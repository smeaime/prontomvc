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
    public partial class TipoRetencionGananciaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Tabla = db.TiposRetencionGanancias
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.TiposRetencionGanancias.Count() / pageSize);

            return View(Tabla);
        }

        public virtual JsonResult BatchUpdate(TiposRetencionGanancia TipoRetencionGanancia)
        {
            if (!PuedeEditar(enumNodos.Ganancias)) throw new Exception("No tenés permisos");

            try
            {
                if (ModelState.IsValid)
                {
                    if (TipoRetencionGanancia.IdTipoRetencionGanancia > 0)
                    {
                        var EntidadOriginal = db.TiposRetencionGanancias.Where(p => p.IdTipoRetencionGanancia == TipoRetencionGanancia.IdTipoRetencionGanancia).SingleOrDefault();
                        var EntidadEntry = db.Entry(EntidadOriginal);
                        EntidadEntry.CurrentValues.SetValues(TipoRetencionGanancia);

                        db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                    }
                    else
                    {
                        db.TiposRetencionGanancias.Add(TipoRetencionGanancia);
                    }

                    db.SaveChanges();

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdTipoRetencionGanancia = TipoRetencionGanancia.IdTipoRetencionGanancia, ex = "" });
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
            TiposRetencionGanancia TipoRetencionGanancia = db.TiposRetencionGanancias.Find(Id);
            db.TiposRetencionGanancias.Remove(TipoRetencionGanancia);
            db.SaveChanges();
            return Json(new { Success = 1, IdTipoRetencionGanancia = Id, ex = "" });
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = "true";
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.TiposRetencionGanancias.AsQueryable();
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
                            select new { IdTipoRetencionGanancia = a.IdTipoRetencionGanancia }).Where(campo).ToList();

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdTipoRetencionGanancia,
                            a.Descripcion,
                            a.CodigoImpuestoAFIP,
                            a.CodigoRegimenAFIP,
                            a.InformacionAuxiliar,
                            IdBienesOServicios = (a.BienesOServicios ?? "") == "B" ? 1 : ((a.BienesOServicios ?? "") == "S" ? 2 : 0),
                            BienesOServicios = (a.BienesOServicios ?? "") == "B" ? "Bienes" : ((a.BienesOServicios ?? "") == "S" ? "Servicios" : "")
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
                            id = a.IdTipoRetencionGanancia.ToString(),
                            cell = new string[] { 
                                "",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdGanancia} )  +">Imprimir</>",
                                a.IdTipoRetencionGanancia.ToString(),
                                a.IdBienesOServicios.ToString(),
                                a.Descripcion,
                                a.CodigoImpuestoAFIP.ToString(),
                                a.CodigoRegimenAFIP.ToString(),
                                a.InformacionAuxiliar,
                                a.BienesOServicios
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetCategoriasGanancia()
        {
            Dictionary<int, string> categorias = new Dictionary<int, string>();
            foreach (TiposRetencionGanancia u in db.TiposRetencionGanancias.OrderBy(x => x.Descripcion).ToList())
                categorias.Add(u.IdTipoRetencionGanancia, u.Descripcion);

            return PartialView("Select", categorias);
        }

        public virtual ActionResult GetBienesOServicios()
        {
            Dictionary<int, string> categorias = new Dictionary<int, string>();
            categorias.Add(1, "Bienes");
            categorias.Add(2, "Servicios");

            return PartialView("Select", categorias);
        }
    }
}
