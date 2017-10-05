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
    public partial class TipoController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult IndexGenericos(int page = 1)
        {
            var Tabla = db.Tipos
                .Where(s => s.Grupo==0)
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Tipos.Where(s => s.Grupo == 0).Count() / pageSize);

            return View(Tabla);
        }

        public virtual ActionResult IndexArticulos(int page = 1)
        {
            var Tabla = db.Tipos
                .Where(s => s.Grupo == 1)
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Tipos.Where(s => s.Grupo == 1).Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Tipos o, ref string sErrorMsg)
        {
            Int32 mPruebaInt = 0;
            Int32 mMaxLength = 0;
            string mProntoIni = "";
            string mExigirCUIT = "";
            Boolean result;

            if (o.Descripcion.NullSafeToString() == "") { sErrorMsg += "\n" + "Falta la descripcion"; }
            else
            {
                mMaxLength = GetMaxLength<Tipos>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "La descripcion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Abreviatura.NullSafeToString() == "") { 
                //sErrorMsg += "\n" + "Falta la abreviatura"; 
            }
            else
            {
                mMaxLength = GetMaxLength<Tipos>(x => x.Abreviatura) ?? 0;
                if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "La abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Tipos Tipo)
        {
            if (!PuedeEditar(enumNodos.Tipos)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Tipo, ref errs))
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
                    if (Tipo.IdTipo > 0)
                    {
                        var EntidadOriginal = db.Tipos.Where(p => p.IdTipo == Tipo.IdTipo).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Tipo);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Tipos.Add(Tipo);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdTipo = Tipo.IdTipo, ex = "" });
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
            Tipos Tipo = db.Tipos.Find(Id);
            db.Tipos.Remove(Tipo);
            db.SaveChanges();
            return Json(new { Success = 1, IdTipo = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, int Grupo = 0)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Tipos.Where(s => s.Grupo == Grupo).AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdTipo = a.IdTipo }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipo,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Codigo,
                            a.Grupo
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
                            id = a.IdTipo.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdTipo.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.Grupo.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TiposGenericos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, int Grupo = 0)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Tipos>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.Where(s => s.Grupo == Grupo).AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipo,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Codigo,
                            a.Grupo
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTipo.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdTipo.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.Grupo.NullSafeToString(),
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TiposGenericosArticulos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, int Grupo = 1)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Tipos>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.Where(s => s.Grupo == Grupo).AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipo,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Codigo,
                            a.Grupo
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTipo.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdTipo.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Codigo.ToString(),
                                a.Grupo.NullSafeToString(),
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTipos()
        {
            Dictionary<int, string> tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Tipos u in db.Tipos.OrderBy(x => x.Descripcion).ToList())
                tabla.Add(u.IdTipo, u.Descripcion);

            return PartialView("Select", tabla);
        }
    }
}

