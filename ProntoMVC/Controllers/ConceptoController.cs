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
    public partial class ConceptoController : ProntoBaseController
    {

        //
        // GET: /Concepto/

        [HttpGet]
        public virtual ActionResult Index(int page = 1)
        {
            var Conceptos = db.Conceptos
                .OrderBy(s => s.Descripcion)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToList();

            ViewBag.CurrentPage = page;
            ViewBag.pageSize = pageSize;
            ViewBag.TotalPages = Math.Ceiling((double)db.PuntosVentas.Count() / pageSize);

            return View(Conceptos);
        }



        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de Conceptos
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.Conceptos.Include("Cuenta").AsQueryable();
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
                            IdConcepto = a.IdConcepto,
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
                        //join c in db.Conceptos on a.IdConcepto equals c.IdConcepto
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdConcepto.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdConcepto} )  +" target='_blank' >Editar</>" 
                              ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdConcepto} )  +">Imprimir</>" ,
                                a.IdConcepto.ToString(),
                                a.CodigoConcepto.ToString(),
                                a.Descripcion.ToString(),
                                (a.Cuenta==null ? string.Empty : a.Cuenta.Codigo.ToString() ),
                                (a.Cuenta==null ? string.Empty : a.Cuenta.Descripcion.ToString() ),
                                
                                a.ValorRechazado,
                                a.GravadoDefault,
                                a.CodigoAFIP                                

                                //(a.Letra ?? string.Empty).ToString(),
                                //(a.Concepto ?? 0).ToString(),
                                //a.ProximoNumero.ToString(),
                                //a.IdTipoComprobante.ToString()
                                ////(a.FechaCliente ?? DateTime.MinValue).ToString(),
                                ////a.FechaCliente.ToString(),
                                //(a.Conceptos==null ? string.Empty : a.Conceptos.RazonSocial ).ToString(),
                                //(a.IdConcepto ?? 0).ToString(),
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



            Concepto Concepto;
            if (id == -1)
            {


                Concepto = new Concepto();
            }
            else
            {
                Concepto = db.Conceptos.Include(x=>x.Cuenta)
                                  .SingleOrDefault(x => x.IdConcepto == id);

            }

            // ViewBag.IdCuenta = new SelectList(db.Cuentas, "IdCuenta", "Descripcion").Take(1000);
            //ViewBag.CuentaDescripcion = (from i in db.Cuentas
            //                             where i.IdCuenta == Concepto.IdCuenta
            //                             select i.Descripcion).FirstOrDefault();



            return View(Concepto);

        }

        //
        // POST: /PuntosVenta/Edit/5

        [HttpPost]
        public virtual ActionResult Edit(Concepto Concepto)
        {
            if (ModelState.IsValid)
            {
                if (Concepto.IdConcepto <= 0)
                {
                    db.Conceptos.Add(Concepto);
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
                else
                {
                    db.Entry(Concepto).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Index");
                }
            }
            return View(Concepto);
        }




        // GET: /Sector/Delete/5

        public virtual ActionResult Delete(int id)
        {


            Concepto Concepto = db.Conceptos.Find(id);
            return View(Concepto);
        }

        //
        // POST: /Sector/Delete/5

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Concepto Concepto = db.Conceptos.Find(id);
            db.Conceptos.Remove(Concepto);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult DeleteConfirmedDirecto(int id)
        {
            Concepto Concepto = db.Conceptos.Find(id);
            db.Conceptos.Remove(Concepto);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

    }
}