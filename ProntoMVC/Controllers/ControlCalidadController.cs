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
    public partial class ControlCalidadController : ProntoBaseController
    {
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.ControlesCalidads
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.ControlesCalidads.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.ControlCalidad o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.Descripcion.NullSafeToString() == "") { sErrorMsg += "\n" + "Falta la descripcion"; }
            else
            {
                mMaxLength = GetMaxLength<ControlCalidad>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "La escripcion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Abreviatura.NullSafeToString() == "") { sErrorMsg += "\n" + "Falta la abreviatura"; }
            else
            {
                mMaxLength = GetMaxLength<ControlCalidad>(x => x.Abreviatura) ?? 0;
                if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "La abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(ControlCalidad ControlCalidad)
        {
            if (!PuedeEditar(enumNodos.ControlCalidad)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(ControlCalidad, ref errs))
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
                    if (ControlCalidad.IdControlCalidad > 0)
                    {
                        var EntidadOriginal = db.ControlesCalidads.Where(p => p.IdControlCalidad == ControlCalidad.IdControlCalidad).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(ControlCalidad);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.ControlesCalidads.Add(ControlCalidad);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdControlCalidad = ControlCalidad.IdControlCalidad, ex = "" });
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
            ControlCalidad ControlCalidad = db.ControlesCalidads.Find(Id);
            db.ControlesCalidads.Remove(ControlCalidad);
            db.SaveChanges();
            return Json(new { Success = 1, IdControlCalidad = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.ControlesCalidads.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdControlCalidad = a.IdControlCalidad }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdControlCalidad,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Inspeccion,
                            a.Detalle
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
                            id = a.IdControlCalidad.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdControlCalidad.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Inspeccion.NullSafeToString(),
                                a.Detalle.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult ControlesCalidad_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.ControlCalidad>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdControlCalidad,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Inspeccion,
                            a.Detalle
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdControlCalidad.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdControlCalidad.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Inspeccion.NullSafeToString(),
                                a.Detalle.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetControlCalidad()
        {
            Dictionary<int, string> combo = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.ControlCalidad u in db.ControlesCalidads.OrderBy(x => x.Descripcion).ToList())
                combo.Add(u.IdControlCalidad, u.Descripcion);
            return PartialView("Select", combo);
        }

        public virtual ActionResult ControlCalidades()
        {
            Dictionary<int, string> combo = new Dictionary<int, string>();
            foreach (ControlCalidad u in db.ControlesCalidads.OrderBy(x => x.Descripcion).ToList())
                combo.Add(u.IdControlCalidad, u.Descripcion);
            return PartialView("Select", combo);
        }

        public virtual JsonResult GetControlCalidadesAutocomplete(string term)
        {
            int id = Generales.Val(term); 
            var q= Json((from item in db.ControlesCalidads

                         where item.Descripcion.Contains(term) || item.IdControlCalidad == id
                         select new
                         {
                             value = item.IdControlCalidad,
                             title = item.Descripcion
                         }).ToList(),
                         JsonRequestBehavior.AllowGet);
            return q;
        }

        public virtual ActionResult ControlCalidadParaComboDeJqgridades(string sidx, string sord, int? page, int? rows, int? Id)
        {
            int IdArticulo1 = Id ?? 0;
            var DetEntidad = (from x in db.ControlesCalidads.OrderBy(x => x.Descripcion) select x).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select new
                        {
                            a.IdControlCalidad,
                            a.Descripcion,
                            a.Abreviatura
                        }).OrderBy(p => p.IdControlCalidad)
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
                            id = a.IdControlCalidad.ToString(),
                            cell = new string[] { 
                                string.Empty, // guarda con este espacio vacio
                                a.IdControlCalidad.ToString(),
                                a.Descripcion.NullSafeToString(),
                                // (a.Unidade ?? new Unidad()).Abreviatura.NullSafeToString(),
                                a.Abreviatura.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetControlCalidadAutocomplete(string term)
        {
            var ci = new System.Globalization.CultureInfo("en-US");

            var filtereditems = (from item in db.Cuentas
                                 where ((item.Descripcion.StartsWith(term)) && item.IdTipoCuenta == 2)
                                 orderby item.Descripcion
                                 select new
                                 {
                                     id = item.IdCuenta,
                                     codigo = item.Codigo,
                                     value = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0)),
                                     title = item.Descripcion + " " + SqlFunctions.StringConvert((double)(item.Codigo ?? 0))
                                 }).Take(20).ToList();

            if (filtereditems.Count == 0) return Json(new { value = "No se encontraron resultados" }, JsonRequestBehavior.AllowGet);

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

    }
}