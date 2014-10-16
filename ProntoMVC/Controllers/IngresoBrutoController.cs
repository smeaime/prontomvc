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
    public partial class IngresoBrutoController : ProntoBaseController
    {

        //
        // GET: /IngresoBruto/

        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            return View();

            var IngresoBrutos = db.IBCondiciones
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .Select(i => i.Descripcion)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.PuntosVentas.Count() / pageSize);

            return View(IngresoBrutos);
        }



        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de IngresoBrutos
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.IBCondiciones.Include(x=>x.Provincia).AsQueryable();
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
                            IdIBCondicion = a.IdIBCondicion,
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
                        //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdIBCondicion.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdIBCondicion} )  +" target='_blank' >Editar</>" 
                                // +
                                //"|" +
                                //"<a href=/Cliente/Details/" + a.IdIBCondicion + ">Detalles</a> ",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdIBCondicion} )  +">Imprimir</>" 
                                ,
                                a.IdIBCondicion.ToString(),

                                a.Descripcion,
                                (a.ProvinciaReal==null ? string.Empty : a.ProvinciaReal.Nombre ).ToString(),
                                a.ImporteTopeMinimo.ToString(),
                                a.ImporteTopeMinimoPercepcion.ToString()
                        , a.AlicuotaPercepcion.ToString()
                        , a.AlicuotaPercepcionConvenio.ToString()
                        , a.FechaVigencia.ToString()
                        , a.AcumulaMensualmente
                        , a.BaseCalculo
                        , a.PorcentajeATomarSobreBase.ToString()
                        , a.PorcentajeAdicional.ToString()
                        , a.LeyendaPorcentajeAdicional
                        

                                //(a.Letra ?? string.Empty).ToString(),
                                //(a.IngresoBruto ?? 0).ToString(),
                                //a.ProximoNumero.ToString(),
                                //a.IdTipoComprobante.ToString()
                                ////(a.FechaCliente ?? DateTime.MinValue).ToString(),
                                ////a.FechaCliente.ToString(),
                                //(a.IngresoBrutos==null ? string.Empty : a.IngresoBrutos.RazonSocial ).ToString(),
                                //(a.IdIBCondicion ?? 0).ToString(),
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


        // GET: /PuntosVenta/Edit/5

        public virtual ActionResult Edit(int id)
        {
            ProntoMVC.Data.Models.IBCondicion o;
            if (id == -1)
            {
                o = new IBCondicion();

            }
            else
            {
                o = db.IBCondiciones.Include(x => x.CuentaIIBBcompras)
                                    .Include(x => x.CuentaIIBBconvenio)
                                    .Include(x => x.CuentaIIBBnormal)
                                      .SingleOrDefault(x => x.IdIBCondicion == id);
            }

            ViewBag.IdProvincia = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
            ViewBag.IdProvinciaReal = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvinciaReal);
            return View(o);
        }

        //
        // POST: /PuntosVenta/Edit/5

        [HttpPost]
        public virtual ActionResult Edit(IBCondicion o)
        {

            if (ModelState.IsValid)
            {
                if (o.IdIBCondicion <= 0)
                {
                    db.IBCondiciones.Add(o);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    db.Entry(o).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            else
            {
                //hubo un error
                // http://stackoverflow.com/questions/1352948/how-to-get-all-errors-from-asp-net-mvc-modelstate
                //foreach (ModelState modelState in ViewData.ModelState.Values)
                //{
                //    foreach (ModelError error in modelState.Errors)
                //    {
                //        DoSomethingWith(error);
                //    }
                //}

                var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + i.Exception.Message));

                ViewBag.Errores = mensajes;

                ViewBag.IdProvincias = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvincia);
                ViewBag.IdProvinciaReal = new SelectList(db.Provincias, "IdProvincia", "Nombre", o.IdProvinciaReal);
                return View(o);
            }
        }

    }
}