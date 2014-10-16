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
using System.Data.Objects;
using System.Reflection;
using System.Configuration;
using Pronto.ERP.Bll;



using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class TipoRetencionGananciaController : ProntoBaseController
    {

        //
        // GET: /TipoGanancia/

        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var TipoGanancias = db.TiposRetencionGanancias
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.TiposRetencionGanancias.Count() / pageSize);

            return View(TipoGanancias);
        }



        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de TipoGanancias
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.TiposRetencionGanancias.AsQueryable();
            //if (IdObra != string.Empty)
            //{
            //    int IdObra1 = Convert.ToInt32(IdObra);
            //    Fac = (from a in Fac where a.IdObra == IdObra1 select a).AsQueryable();
            //}
            //if (FechaInicial != string.Empty)
            //{
            //    DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            //    DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            //    Fac = (from a in Fac where a.FechaCliente >= FechaDesde && a.FechaCliente <= FechaHasta select a).AsQueryable();
            //}
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
                            IdTipoRetencionGanancia = a.IdTipoRetencionGanancia,
                            //FechaCliente = ,
                            //NumeroObra=a.Obra.NumeroObra,
                            //Libero=a.Empleados.Nombre,
                            //Aprobo = a.Empleados1.Nombre,
                            //Sector=a.Sectores.Descripcion,
                            //Detalle=a.Detalle
                        }).Where(campo).ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            //switch (sidx.ToLower())
            //{
            //    case "numeroCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //    case "fechaCliente":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaCliente);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Fac = Fac.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Fac = Fac.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Fac = Fac.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.Detalle);
            //        else
            //            Fac = Fac.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroCliente);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroCliente);
            //        break;
            //}

            var data = (from a in Fac
                        //join c in db.TipoGanancias on a.IdTipoRetencionGanancia equals c.IdTipoRetencionGanancia
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

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
                                "<a href="+ Url.Action("Edit",new {id = a.IdTipoRetencionGanancia} )  +" target='_blank' >Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdTipoRetencionGanancia} )  +">Imprimir</>" ,
                                
                                a.IdTipoRetencionGanancia.ToString(),
                                a.Descripcion.ToString(),
                               ( a.CodigoImpuestoAFIP ?? 0).ToString(),
                               ( a.CodigoRegimenAFIP ?? 0).ToString(),
                             (   a.InformacionAuxiliar ?? string.Empty).ToString(),
                                    ( a.BienesOServicios ?? string.Empty).ToString()

                                //(a.Letra ?? string.Empty).ToString(),
                                //(a.TipoGanancia ?? 0).ToString(),
                                //a.ProximoNumero.ToString(),
                                //a.IdTipoComprobante.ToString()
                                ////(a.FechaCliente ?? DateTime.MinValue).ToString(),
                                ////a.FechaCliente.ToString(),
                                //(a.TipoGanancias==null ? string.Empty : a.TipoGanancias.RazonSocial ).ToString(),
                                //(a.IdTipoRetencionGanancia ?? 0).ToString(),
                                //(a.ImporteTotal ?? 0).ToString(),
                                //a.ImporteTotal.ToString()
                                //a.NumeroObra, 
                                //a.Libero,
                                //a.Aprobo,
                                //a.Sector,
                                //a.Detalle
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        // GET: /TiposRetencionGanancias/Edit/5

        public virtual ActionResult Edit(int id)
        {

            if (id == -1)
            {
                TiposRetencionGanancia TiposRetencionGanancias = new TiposRetencionGanancia();
                //Parametros parametros = db.Parametros.Find(1);
                //requerimiento.NumeroRequerimiento = parametros.ProximoNumeroRequerimiento;
                //requerimiento.FechaRequerimiento = DateTime.Today;
                //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra");
                //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
                //ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones(3, 0).Count();
                ////ViewBag.Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(3, id);
                return View(TiposRetencionGanancias);
            }
            else
            {

                TiposRetencionGanancia TiposRetencionGanancias = db.TiposRetencionGanancias.Find(id);
                return View(TiposRetencionGanancias);

                //Requerimiento requerimiento = db.Requerimientos.Find(id);
                //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", requerimiento.IdObra);
                //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.Aprobo);
                //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.IdSolicito);
                //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion", requerimiento.IdSector);
                //ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones(3,0).Count();
                ////ViewBag.Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante(3, id);
                //Session.Add("Requerimiento", requerimiento);
                //return View(requerimiento);
            }
        }






        //
        // POST: /TiposRetencionGanancias/Edit/5

        [HttpPost]
        public virtual ActionResult Edit(TiposRetencionGanancia TiposRetencionGanancias)
        {
            if (ModelState.IsValid)
            {
                if (TiposRetencionGanancias.IdTipoRetencionGanancia <= 0)
                {
                    db.TiposRetencionGanancias.Add(TiposRetencionGanancias);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    db.Entry(TiposRetencionGanancias).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            return View(TiposRetencionGanancias);
        }


        public virtual ActionResult DeleteConfirmed(int id)
        {
            TiposRetencionGanancia TiposRetencionGanancias = db.TiposRetencionGanancias.Find(id);
            db.TiposRetencionGanancias.Remove(TiposRetencionGanancias);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}