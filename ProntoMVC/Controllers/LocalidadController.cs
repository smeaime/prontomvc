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
    public partial class LocalidadController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Localidades
                .OrderBy(s => s.Nombre)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Localidades.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Localidad o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.Nombre.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta el nombre";
            }
            else
            {
                mMaxLength = GetMaxLength<Localidad>(x => x.Nombre) ?? 0;
                if (o.Nombre.Length > mMaxLength) { sErrorMsg += "\n" + "El nombre de la localidad no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if ((o.IdProvincia ?? 0) == 0) { sErrorMsg += "\n" + "Falta la provincia"; }

            if ((o.Codigo ?? 0) == 0) { sErrorMsg += "\n" + "Falta el codigo"; }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Localidad Localidad)
        {
            if (!PuedeEditar(enumNodos.Localidades)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Localidad, ref errs))
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
                    if (Localidad.IdLocalidad > 0)
                    {
                        var EntidadOriginal = db.Localidades.Where(p => p.IdLocalidad == Localidad.IdLocalidad).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Localidad);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Localidades.Add(Localidad);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdLocalidad = Localidad.IdLocalidad, ex = "" });
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
            Localidad Localidad = db.Localidades.Find(Id);
            db.Localidades.Remove(Localidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdLocalidad = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Localidades.AsQueryable();
            var Entidad1 = (from a in Entidad
                            select new { IdLocalidad = a.IdLocalidad }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        select new
                        {
                            a.IdLocalidad,
                            a.IdProvincia,
                            a.Nombre,
                            a.Codigo,
                            a.CodigoPostal,
                            Provincia = b != null ? b.Nombre : "",
                            a.CodigoESRI,
                            a.Partido
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
                            id = a.IdLocalidad.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdLocalidad.ToString(),
                                a.IdProvincia.ToString(),
                                a.Nombre.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.CodigoESRI.NullSafeToString(),
                                a.Partido.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Localidades_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Localidad>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            var Entidad = pagedQuery.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdLocalidad = a.IdLocalidad }).ToList();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        from b in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        select new
                        {
                            a.IdLocalidad,
                            a.IdProvincia,
                            a.Nombre,
                            a.Codigo,
                            a.CodigoPostal,
                            Provincia = a.Provincia.Nombre,   //b != null ? b.Nombre : "",
                            a.CodigoESRI,
                            a.Partido
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdLocalidad.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdLocalidad.ToString(),
                                a.IdProvincia.ToString(),
                                a.Nombre.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.CodigoPostal.NullSafeToString(),
                                a.Provincia.NullSafeToString(),
                                a.CodigoESRI.NullSafeToString(),
                                a.Partido.NullSafeToString(),
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetLocalidadesAutocomplete(string term)
        {
            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Localidades
                                 from b in db.Provincias.Where(o => o.IdProvincia == item.IdProvincia).DefaultIfEmpty()
                                 where ((item.Nombre.StartsWith(term)))
                                 orderby item.Nombre
                                 select new
                                 {
                                     id = item.IdLocalidad,
                                     value = item.Nombre,
                                     title = item.Nombre + " " + item.CodigoPostal,
                                     idprovincia = item.IdProvincia,
                                     IdPais = b != null ? b.IdPais : 0
                                 }).Take(20).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetLocalidadPorId(int IdLocalidad)
        {
            var filtereditems = (from a in db.Localidades
                                 where (a.IdLocalidad == IdLocalidad)
                                 select new
                                 {
                                     id = a.IdLocalidad,
                                     Localidad = a.Nombre.Trim(),
                                     value = a.Nombre.Trim()
                                 }).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetLocalidades()
        {
            Dictionary<int, string> localidades = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Localidad u in db.Localidades.OrderBy(x => x.Nombre).ToList())
                localidades.Add(u.IdLocalidad, u.Nombre);

            return PartialView("Select", localidades);
        }
    }
}

