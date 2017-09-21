using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models; using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;

// using ProntoMVC.Controllers.Logica;

using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class CotizacionMonedaController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Cotizaciones)) throw new Exception("No tenés permisos");

            return View();
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Cotizacione Cotizacion)
        {
            if (!PuedeEditar(enumNodos.Cotizaciones)) throw new Exception("No tenés permisos");

            try
            {
                if (ModelState.IsValid)
                {
                    if (Cotizacion.IdCotizacion > 0)
                    {
                        var EntidadOriginal = db.Cotizaciones.Where(p => p.IdCotizacion == Cotizacion.IdCotizacion).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(Cotizacion);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.Cotizaciones.Add(Cotizacion);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdCotizacion = Cotizacion.IdCotizacion, ex = "" });
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
            Cotizacione Cotizacion = db.Cotizaciones.Find(Id);
            db.Cotizaciones.Remove(Cotizacion);
            db.SaveChanges();
            return Json(new { Success = 1, IdCotizacion = Id, ex = "" });
        }

        public virtual ActionResult Cotizaciones(string sidx, string sord, int? page, int? rows)
        {
            var Det = db.Cotizaciones.AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Monedas.Where(o => o.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        select new
                        {
                            a.IdCotizacion,
                            a.IdMoneda,
                            a.Fecha,
                            Moneda = b != null ? b.Nombre : null,
                            a.CotizacionLibre
                        }).OrderByDescending(x => x.Fecha)
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
                            id = a.IdCotizacion.ToString(),
                            cell = new string[] { 
                                string.Empty,
                                a.IdCotizacion.ToString(), 
                                a.Fecha == null ? "" : a.Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Moneda,
                                a.IdMoneda.ToString(),
                                a.CotizacionLibre.ToString()
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

    }
}