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
    public partial class ColorController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Colores
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Colores.Count() / pageSize);

            return View(Tabla);
        }

        public bool Validar(ProntoMVC.Data.Models.Colore o, ref string sErrorMsg)
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
                mMaxLength = GetMaxLength<Colore>(x => x.Descripcion) ?? 0;
                if (o.Descripcion.Length > mMaxLength) { sErrorMsg += "\n" + "La descripcion no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Abreviatura.NullSafeToString() == "")
            {
                sErrorMsg += "\n" + "Falta la abreviatura";
            }
            else
            {
                mMaxLength = GetMaxLength<Colore>(x => x.Abreviatura) ?? 0;
                if (o.Abreviatura.Length > mMaxLength) { sErrorMsg += "\n" + "La abreviatura no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (o.Codigo2.NullSafeToString() == "")
            {
                o.Codigo2 = "";
            }
            else
            {
                mMaxLength = GetMaxLength<Colore>(x => x.Codigo2) ?? 0;
                if (o.Codigo2.Length > mMaxLength) { sErrorMsg += "\n" + "El codigo no puede tener mas de " + mMaxLength + " digitos"; }
            }

            if (sErrorMsg != "") return false;
            else return true;
        }

        public virtual JsonResult BatchUpdate(Colore Color)
        {
            if (!PuedeEditar(enumNodos.Colores)) throw new Exception("No tenés permisos");

            try
            {
                string errs = "";
                if (!Validar(Color, ref errs))
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
                    if (Color.IdColor > 0)
                    {
                        var EntidadOriginal = db.Colores.Where(p => p.IdColor == Color.IdColor).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Color);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Colores.Add(Color);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdColor = Color.IdColor, ex = "" });
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
            Colore Color = db.Colores.Find(Id);
            db.Colores.Remove(Color);
            db.SaveChanges();
            return Json(new { Success = 1, IdColor = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Colores.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdColor = a.IdColor }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdColor,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Codigo2
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
                            id = a.IdColor.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdColor.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Codigo2.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Colores_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Colore>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdColor = a.IdColor }).ToList();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdColor,
                            a.Descripcion,
                            a.Abreviatura,
                            a.Codigo2
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdColor.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdColor.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Abreviatura.NullSafeToString(),
                                a.Codigo2.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetColores()
        {
            Dictionary<int, string> Colores = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.Colore u in db.Colores.OrderBy(x => x.Descripcion).ToList())
                Colores.Add(u.IdColor, u.Descripcion);

            return PartialView("Select", Colores);
        }
    }
}

