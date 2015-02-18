using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
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
    public partial class CuentaGastoController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.CuentasGastos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.CuentasGastos.Count() / pageSize);

            return View(Tabla);
        }

        public virtual JsonResult BatchUpdate(CuentasGasto CuentaGasto)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (CuentaGasto.IdCuentaGasto > 0)
                    {
                        var EntidadOriginal = db.TiposCuentaGrupos.Where(p => p.IdTipoCuentaGrupo == CuentaGasto.IdCuentaGasto).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(CuentaGasto);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.CuentasGastos.Add(CuentaGasto);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdCuentaGasto = CuentaGasto.IdCuentaGasto, ex = "" });
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
            CuentasGasto CuentaGasto = db.CuentasGastos.Find(Id);
            db.CuentasGastos.Remove(CuentaGasto);
            db.SaveChanges();
            return Json(new { Success = 1, IdCuentaGasto = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.CuentasGastos.AsQueryable();
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
                            select new { IdCuentaGasto = a.IdCuentaGasto }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdCuentaGasto,
                            a.Descripcion
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdCuentaGasto.ToString(),
                            cell = new string[] { "",
                                a.IdCuentaGasto.ToString(),
                                a.Descripcion.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCuentasGasto()
        {
            Dictionary<int, string> registros = new Dictionary<int, string>();
            foreach (CuentasGasto u in db.CuentasGastos.OrderBy(x => x.Descripcion).ToList())
                registros.Add(u.IdCuentaGasto, u.Descripcion);

            return PartialView("Select", registros);
        }

    }
}
