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

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
//using Trirand.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class MarcaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Marcas
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Marcas.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Marca o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.Descripcion.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la descripcion";
            }
            else
            {
                mMaxLength = GetMaxLength<Marca>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "La descripcion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.Codigo ?? 0) <= 0) sErrorMsg += "\n" + "Falta el codigo";

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Marca Marca)
        {
            if (!PuedeEditar(enumNodos.Marcas)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Marca, ref errs))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    }
                    catch (Exception)
                    {
                    }

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    if (Marca.IdMarca > 0)
                    {
                        var EntidadOriginal = db.Marcas.Where(p => p.IdMarca == Marca.IdMarca).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Marca);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Marcas.Add(Marca);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdMarca = Marca.IdMarca, ex = "" });
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
            Marca Marca = db.Marcas.Find(Id);
            db.Marcas.Remove(Marca);
            db.SaveChanges();
            return Json(new { Success = 1, IdMarca = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Marcas.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdMarca = a.IdMarca }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdMarca,
                            a.Descripcion,
                            a.Codigo
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
                            id = a.IdMarca.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdMarca.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Codigo.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Marcas_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Marca>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdMarca,
                            a.Descripcion,
                            a.Codigo
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdMarca.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdMarca.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Codigo.ToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetMarcas()
        {
            Dictionary<int, string> Marcas = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Marca u in db.Marcas.OrderBy(x => x.Descripcion).ToList())
                Marcas.Add(u.IdMarca, u.Descripcion);

            return PartialView("Select", Marcas);
        }
    }
}

