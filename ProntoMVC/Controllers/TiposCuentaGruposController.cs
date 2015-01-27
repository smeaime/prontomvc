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
    public partial class TiposCuentaGruposController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.TiposCuentaGrupos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.TiposCuentaGrupos.Count() / pageSize);

            return View(Tabla);
        }

        public virtual JsonResult BatchUpdate(TiposCuentaGrupos TiposCuentaGrupos)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (TiposCuentaGrupos.IdTipoCuentaGrupo > 0)
                    {
                        var EntidadOriginal = db.TiposCuentaGrupos.Where(p => p.IdTipoCuentaGrupo == TiposCuentaGrupos.IdTipoCuentaGrupo).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(TiposCuentaGrupos);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.TiposCuentaGrupos.Add(TiposCuentaGrupos);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdTipoCuentaGrupo = TiposCuentaGrupos.IdTipoCuentaGrupo, ex = "" });
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
            TiposCuentaGrupos TiposCuentaGrupos = db.TiposCuentaGrupos.Find(Id);
            db.TiposCuentaGrupos.Remove(TiposCuentaGrupos);
            db.SaveChanges();
            return Json(new { Success = 1, IdTipoCuentaGrupo = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.TiposCuentaGrupos.AsQueryable();
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
                            select new { IdTipoCuentaGrupo = a.IdTipoCuentaGrupo }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipoCuentaGrupo,
                            a.Descripcion,
                            a.EsCajaBanco,
                            IdTipoGrupo = (a.EsCajaBanco ?? "") == "CA" ? 1 : ((a.EsCajaBanco ?? "") == "BA" ? 2 : ((a.EsCajaBanco ?? "") == "TC" ? 3 : 4)),
                            TipoGrupo = (a.EsCajaBanco ?? "") == "CA" ? "Cajas" : ((a.EsCajaBanco ?? "") == "BA" ? "Bancos" : ((a.EsCajaBanco ?? "") == "TC" ? "Tarjetas" : "Otros"))
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTipoCuentaGrupo.ToString(),
                            cell = new string[] { "",
                                a.IdTipoCuentaGrupo.ToString(),
                                a.EsCajaBanco.NullSafeToString(),
                                a.IdTipoGrupo.ToString(),
                                a.Descripcion.NullSafeToString(),
                                a.TipoGrupo.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposCuentaGrupos()
        {
            Dictionary<int, string> tipos = new Dictionary<int, string>();
            foreach (TiposCuentaGrupos u in db.TiposCuentaGrupos.OrderBy(x => x.Descripcion).ToList())
                tipos.Add(u.IdTipoCuentaGrupo, u.Descripcion);

            return PartialView("Select", tipos);
        }

        public virtual ActionResult GetTiposGrupos()
        {
            Dictionary<int, string> tiposgrupos = new Dictionary<int, string>();
            tiposgrupos.Add(1, "Cajas");
            tiposgrupos.Add(2, "Bancos");
            tiposgrupos.Add(3, "Tarjetas");
            tiposgrupos.Add(4, "Otros");

            return PartialView("Select", tiposgrupos);
        }
    }
}
