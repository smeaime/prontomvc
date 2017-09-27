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
    public partial class PuntoVentaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var PuntoVentas = db.PuntosVentas
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.PuntosVentas.Count() / pageSize);

            return View(PuntoVentas);
        }

        public virtual ActionResult Edit(int id)
        {
            Data.Models.PuntosVenta PuntosVenta;

            if (id == -1)
            {
                PuntosVenta = new Data.Models.PuntosVenta();
                PuntosVenta.WebService = "";
            }
            else
            {
                PuntosVenta = db.PuntosVentas.Find(id);
                if ((PuntosVenta.CAEManual ?? "") == "SI")
                {
                    PuntosVenta.WebService = " ";
                }
                else 
                {
                    if ((PuntosVenta.WebService ?? "") == "") { PuntosVenta.WebService = ""; }
                }
            }

            CargarViewBag(PuntosVenta);

            return View(PuntosVenta);
        }

        void CargarViewBag(Data.Models.PuntosVenta o)
        {
            ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes, "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);
        }


        private bool Validar(Data.Models.PuntosVenta o)
        {
            if (o.Letra != "A" && o.Letra != "B" && o.Letra != "C" && o.Letra != "E" && o.Letra != "X")
            {
                ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                return false;
            }
            return true;
        }

        [HttpPost]
        public virtual ActionResult Edit(Data.Models.PuntosVenta PuntosVenta)
        {
            try
            {
                Validar(PuntosVenta);

                if (ModelState.IsValid)
                {
                    if ((PuntosVenta.WebService ?? "") == " ") { 
                        PuntosVenta.CAEManual = "SI";
                        PuntosVenta.WebService = null;
                    }
                    else  if ((PuntosVenta.WebService ?? "") == "") {
                        PuntosVenta.CAEManual = null;
                        PuntosVenta.WebService = null;
                    }

                    if (PuntosVenta.IdPuntoVenta <= 0)
                    {
                        db.PuntosVentas.Add(PuntosVenta);
                        db.SaveChanges();
                    }
                    else
                    {
                        db.Entry(PuntosVenta).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                    }

                    return RedirectToAction("Index");
                }
                else
                {
                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

                    ViewBag.Errores = mensajes;

                    CargarViewBag(PuntosVenta);
                    return View(PuntosVenta);
                }
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                StringBuilder sb = new StringBuilder();

                foreach (var failure in ex.EntityValidationErrors)
                {
                    sb.AppendFormat("{0} failed validation\n", failure.Entry.Entity.GetType());
                    foreach (var error in failure.ValidationErrors)
                    {
                        sb.AppendFormat("- {0} : {1}", error.PropertyName, error.ErrorMessage);
                        sb.AppendLine();

                        ModelState.AddModelError(error.PropertyName, error.ErrorMessage); //http://msdn.microsoft.com/en-us/library/dd410404(v=vs.90).aspx
                    }
                }

                CargarViewBag(PuntosVenta);

                return View(PuntosVenta);
            }
            catch (Exception ex)
            {
                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
        }

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.PuntosVentas.Include("TiposComprobante").AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numeroCliente":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaCliente":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            var Req1 = (from a in Fac
                        select new
                        {
                            IdPuntoVenta = a.IdPuntoVenta,
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                        select a).Where(campo).OrderBy(sidx + " " + sord)
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
                            id = a.IdPuntoVenta.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdPuntoVenta})+">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdPuntoVenta} )  +">Imprimir</>",
                                a.IdPuntoVenta.ToString(),
                                (a.Letra ?? string.Empty).ToString(),
                                (a.PuntoVenta ?? 0).ToString(),
                                (a.TiposComprobante==null ? string.Empty : a.TiposComprobante.Descripcion ).ToString(),
                                (a.ProximoNumero ?? 0).ToString(),
                                (a.Descripcion ?? string.Empty).ToString(),
                                (a.WebService ?? string.Empty).ToString(),
                                (a.WebServiceModoTest ?? string.Empty).ToString(),
                                (a.CAEManual ?? string.Empty).ToString(),
                                (a.Activo ?? string.Empty).ToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult PuntosVenta_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {
            int totalRecords = 0;
            int pageSize = rows;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.PuntosVenta>
                                ("", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            // esto filtro se debería aplicar antes que el filtrogenerico (queda mal paginado si no)
            var Entidad = pagedQuery.AsQueryable();

            var Entidad1 = (from a in Entidad
                            select new { IdPuntoVenta = a.IdPuntoVenta }).ToList();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            a.IdPuntoVenta,
                            a.Letra,
                            a.PuntoVenta,
                            TipoComprobante = a.TiposComprobante.Descripcion,
                            a.ProximoNumero,
                            a.Descripcion,
                            a.WebService,
                            a.WebServiceModoTest,
                            a.CAEManual,
                            a.Activo
                        }).OrderBy(sidx + " " + sord).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdPuntoVenta.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdPuntoVenta})+">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdPuntoVenta} )  +">Imprimir</>",
                                a.IdPuntoVenta.ToString(),
                                a.Letra.NullSafeToString(),
                                a.PuntoVenta.ToString(),
                                a.TipoComprobante.NullSafeToString(),
                                a.ProximoNumero.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.WebService.NullSafeToString(),
                                a.WebServiceModoTest.NullSafeToString(),
                                a.CAEManual.NullSafeToString(),
                                a.Activo.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetPuntosVenta(int IdTipoComprobante = 0, string Letra = "")
        {
            Dictionary<int, string> Tabla = new Dictionary<int, string>();
            foreach (ProntoMVC.Data.Models.PuntosVenta u in db.PuntosVentas.Where(x => (IdTipoComprobante <= 0 || x.IdTipoComprobante == IdTipoComprobante) && (Letra == "" || x.Letra == Letra)).OrderBy(x => x.PuntoVenta).ToList())
                Tabla.Add(u.IdPuntoVenta, Convert.ToString(u.PuntoVenta).PadLeft(4,'0'));

            return PartialView("Select", Tabla);
        }

        public virtual JsonResult GetPuntosVenta2(int IdTipoComprobante = 0, string Letra = "")
        {
            var filtereditems = (from a in db.PuntosVentas
                                 where ((IdTipoComprobante <= 0 || a.IdTipoComprobante == IdTipoComprobante) && (Letra == "" || a.Letra == Letra))
                                 select new
                                 {
                                     IdPuntoVenta = a.IdPuntoVenta,
                                     PuntoVenta = a.PuntoVenta,
                                     ProximoNumero = a.ProximoNumero
                                 }).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult GetPuntosVentaPorId(int IdPuntoVenta = 0)
        {
            var filtereditems = (from a in db.PuntosVentas
                                 where (a.IdPuntoVenta == IdPuntoVenta)
                                 select new
                                 {
                                     IdPuntoVenta = a.IdPuntoVenta,
                                     PuntoVenta = a.PuntoVenta,
                                     ProximoNumero = a.ProximoNumero,
                                     CAEManual = a.CAEManual
                                 }).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

    }
}