using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;

using ProntoMVC.Models;
using ProntoMVC.Data.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class DepositoController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Depositos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Depositos.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Deposito o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            Boolean result;


            if (o.Descripcion.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el nombre";
            }
            else
            {
                mMaxLength = GetMaxLength<Deposito>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Abreviatura.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la abreviatura";
            }
            else
            {
                mMaxLength = GetMaxLength<Deposito>(x => x.Abreviatura) ?? 0;
                if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "La abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.Deposito Deposito)
        {
            if (!PuedeEditar(enumNodos.Depositos)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Deposito, ref errs))
                {
                    try
                    { Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest; }
                    catch (Exception)
                    { }
                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    if (Deposito.IdDeposito > 0)
                    {
                        var EntidadOriginal = db.Depositos.Where(p => p.IdDeposito == Deposito.IdDeposito).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Deposito);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Depositos.Add(Deposito);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdDeposito = Deposito.IdDeposito, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El registro tiene datos invalidos";

                    return Json(res);
                }
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                List<string> errors = new List<string>();
                errors.Add(ex.Message);
                return Json(errors);
            }
        }

        [HttpPost]
        public virtual JsonResult Delete(int Id)
        {
            try
            {
                ProntoMVC.Data.Models.Deposito Deposito = db.Depositos.Find(Id);
                db.Depositos.Remove(Deposito);
                db.SaveChanges();
                return Json(new { Success = 1, IdDeposito = Id, ex = "" });
            }
            catch (Exception ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;

                List<string> errors = new List<string>();
                errors.Add(ex.Message);
                return Json(errors);
            }
        }

        public class Depositos2
        {
            public int IdDeposito { get; set; }
            public int? IdObra { get; set; }
            public string Descripcion { get; set; }
            public string Abreviatura { get; set; }
            public string Obra { get; set; }
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Depositos.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdDeposito = a.IdDeposito }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDeposito,
                            a.IdObra,
                            a.Descripcion,
                            a.Abreviatura,
                            Obra = b != null ? b.Descripcion : ""
                        }).Where(campo).OrderBy(sidx + " " + sord)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDeposito.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdDeposito.ToString(),
                                a.IdObra.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Obra.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Depositos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.Depositos
                        from b in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        select new Depositos2
                        {
                            IdDeposito = a.IdDeposito,
                            IdObra = a.IdObra,
                            Descripcion = a.Descripcion,
                            Abreviatura = a.Abreviatura,
                            Obra = b != null ? b.Descripcion : ""
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            //IQueryable<Rubros2> data2 = data.AsQueryable();
            //List<Rubros2> data3 = data2.ToList();

            var pagedQuery = Filters.FiltroGenerico_UsandoStoreOLista<Depositos2>
                                (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data.ToList());

            //var pagedQuery = Filters.FiltroGenerico<Data.Models.Rubro>
            //                    ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdDeposito.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdDeposito.ToString(),
                                a.IdObra.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Obra.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetDepositos()
        {
            Dictionary<int, string> deposito = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Deposito u in db.Depositos.OrderBy(x => x.Descripcion).ToList())
                deposito.Add(u.IdDeposito, u.Descripcion);

            return PartialView("Select", deposito);
        }

    }
}
