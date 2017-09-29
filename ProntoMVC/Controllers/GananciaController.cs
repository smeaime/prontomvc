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
    public partial class GananciaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.Ganancias
                .OrderBy(s => s.IdGanancia)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();
            
            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Ganancias.Count() / pageSize);

            return View(Tabla);
        }

        public virtual JsonResult BatchUpdate(Ganancia Ganancia)
        {
            if (!PuedeEditar(enumNodos.Ganancias)) throw new Exception("No tenés permisos");

            try
            {
                if (ModelState.IsValid)
                {
                    if (Ganancia.IdGanancia > 0)
                    {
                        var EntidadOriginal = db.Ganancias.Where(p => p.IdGanancia == Ganancia.IdGanancia).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Ganancia);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Ganancias.Add(Ganancia);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdGanancia = Ganancia.IdGanancia, ex = "" });
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
            Ganancia Ganancia = db.Ganancias.Find(Id);
            db.Ganancias.Remove(Ganancia);
            db.SaveChanges();
            return Json(new { Success = 1, IdGanancia = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Ganancias.Include("TiposRetencionGanancia").AsQueryable();
            //if (_search)
            //{
            //    switch (searchField.ToLower())
            //    {
            //        case "a":
            //            campo = String.Format("{0} = {1}", searchField, searchString);
            //            break;
            //        default:
            //            campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
            //            break;
            //    }
            //}
            //else
            //{
            //    campo = "true";
            //}

            var Entidad1 = (from a in Entidad
                            select new { IdGanancia = a.IdGanancia }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdGanancia,
                            a.IdTipoRetencionGanancia,
                            CategoriaGanancias = a.TiposRetencionGanancia.Descripcion,
                            a.Desde,
                            a.Hasta,
                            a.SumaFija,
                            a.PorcentajeAdicional,
                            a.MinimoNoImponible,
                            a.MinimoARetener
                        }).Where(campo).OrderBy(sidx + " " + sord)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdGanancia.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdGanancia.ToString(),
                                a.IdTipoRetencionGanancia.ToString(),
                                a.CategoriaGanancias,
                                a.Desde.ToString(),
                                a.Hasta.ToString(),
                                a.SumaFija.ToString(),
                                a.PorcentajeAdicional.ToString(),
                                a.MinimoNoImponible.ToString(),
                                a.MinimoARetener.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
    }
}