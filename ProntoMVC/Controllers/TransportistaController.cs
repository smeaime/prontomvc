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
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;
using Trirand.Web.Mvc;

namespace ProntoMVC.Controllers
{
    public partial class TransportistaController : ProntoBaseController
    {
        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Transportistas = db.Transportistas
                .OrderBy(s => s.Nombre)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.Sectores.Count() / pageSize);

            return View(Transportistas);
        }

        // GET: 
        public virtual ActionResult Create()
        {
            return View();
        }

        // POST: 
        [HttpPost]
        public virtual ActionResult Create(Transportista Transportista)
        {
            if (ModelState.IsValid)
            {
                db.Transportistas.Add(Transportista);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(Transportista);
        }

        // GET: 
        public virtual ActionResult Edit(int id)
        {
            Transportista Transportista;

            if (id == -1)
            {
                Transportista = new Transportista();
            }
            else
            {
                Transportista = db.Transportistas.Find(id);
            }
            return View(Transportista);
        }

        // POST: 
        [HttpPost]
        public virtual ActionResult Edit(Transportista Transportista)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    if (Transportista.IdTransportista <= 0)
                    {
                        db.Transportistas.Add(Transportista);
                        db.SaveChanges();
                    }
                    else
                    {
                        db.Entry(Transportista).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                    }
                    return RedirectToAction("Index");
                }
                else
                {
                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));
                    ViewBag.Errores = mensajes;
                    return View(Transportista);
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
                //CargarViewBag(Transportista);
                return View(Transportista);
            }

            catch (Exception ex)
            {
                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
        }

        // GET: 
        public virtual ActionResult Delete(int id)
        {
            Transportista Transportista = db.Transportistas.Find(id);
            return View(Transportista);
        }

        // POST: 
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Transportista Transportista = db.Transportistas.Find(id);
            db.Transportistas.Remove(Transportista);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Tabla = db.Transportistas.AsQueryable();
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "nombre":
                        campo = String.Format("{0} = {1}", searchField, searchString);
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

            var Tabla2 = (from a in Tabla
                          select new
                          {
                              Id = a.IdTransportista,
                          }).Where(campo).ToList();

            int totalRecords = Tabla2.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Tabla
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdTransportista.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdTransportista}) +">Editar</>  -  <a href="+ Url.Action("Delete",new {id = a.IdTransportista}) +">Eliminar</>",
                                a.IdTransportista.ToString(),
                                a.Nombre,
                                a.Abreviatura,
                                a.CodigoAFIP,
                                a.GeneraImpuestos
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult Transportista_Cotizacion(DateTime? fecha, int IdTransportista)
        {
            if (db == null) return null;
            if (fecha == null) fecha = DateTime.Now;

            decimal cotizacion;

            if (false)
            {
                cotizacion = db.Cotizaciones_TX_PorFechaTransportista(fecha, IdTransportista);
            }
            else
            {
                DateTime desde = fecha.Value.Date;
                DateTime hasta = desde.AddDays(1);

                var mvarCotizacion = db.Cotizaciones.Where(x => x.Fecha >= desde && x.Fecha <= hasta && x.IdTransportista == IdTransportista).FirstOrDefault();
                if (mvarCotizacion == null) cotizacion = -1; else cotizacion = mvarCotizacion.Cotizacion ?? -1;
            }
            return Json(cotizacion, JsonRequestBehavior.AllowGet);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}
