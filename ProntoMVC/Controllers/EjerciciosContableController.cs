
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
    public partial class EjerciciosContableController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            return View();
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(EjerciciosContable EjerciciosContable)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (EjerciciosContable.IdEjercicioContable > 0)
                    {
                        var EntidadOriginal = db.EjerciciosContables.Where(p => p.IdEjercicioContable == EjerciciosContable.IdEjercicioContable).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(EjerciciosContable);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.EjerciciosContables.Add(EjerciciosContable);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdEjercicioContable = EjerciciosContable.IdEjercicioContable, ex = "" });
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
            EjerciciosContable EjerciciosContable = db.EjerciciosContables.Find(Id);
            db.EjerciciosContables.Remove(EjerciciosContable);
            db.SaveChanges();
            return Json(new { Success = 1, IdEjercicioContable = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows)
        {
            var Det = db.EjerciciosContables.AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        select new
                        {
                            a.IdEjercicioContable,
                            a.FechaInicio,
                            a.FechaFinalizacion
                        }).OrderByDescending(x => x.FechaInicio).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdEjercicioContable.ToString(),
                            cell = new string[] { 
                                string.Empty,
                                a.IdEjercicioContable.ToString(), 
                                a.FechaInicio == null ? "" : a.FechaInicio.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaFinalizacion == null ? "" : a.FechaFinalizacion.GetValueOrDefault().ToString("dd/MM/yyyy")
                         }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


    }
}