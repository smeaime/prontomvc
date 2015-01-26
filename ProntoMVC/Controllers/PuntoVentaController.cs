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
    public partial class PuntoVentaController : ProntoBaseController
    {


        //
        // GET: /PuntoVenta/

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





        // GET: /PuntosVenta/Edit/5

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer()) throw new Exception("No tenés permisos");
            //ojo: si llama a esta funcion al hacer POST, debe ser porque la vista no pusiste el Html.BeginForm()
          Data.Models.PuntosVenta PuntosVenta;

            if (id == -1)
            {

                PuntosVenta = new Data.Models.PuntosVenta();
            }
            else
            {
                PuntosVenta = db.PuntosVentas.Find(id);

            }

            CargarViewBag(PuntosVenta);

            return View(PuntosVenta);
        }



        void CargarViewBag(Data.Models.PuntosVenta o)
        {
            ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes, "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);
            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.Aprobo);
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre", requerimiento.IdSolicito);
        }


        private bool Validar(Data.Models.PuntosVenta o)
        {
            // una opcion es extender el modelo autogenerado, para ensoquetar ahí las validaciones
            // si no, podemos usar una funcion como esta, y devolver los  errores de dos maneras:
            // con ModelState.AddModelError si los devolvemos en una ViewResult,
            // o con un array de strings si es una JsonResult.
            //
            // If you are returning JSON, you cannot use ModelState.
            // http://stackoverflow.com/questions/2808327/how-to-read-modelstate-errors-when-returned-by-json

            if (o.Letra != "A" && o.Letra != "B" && o.Letra != "C" && o.Letra != "E" && o.Letra != "X")
            {
                ModelState.AddModelError("Letra", "La letra debe ser A, B, C, E o X");
                return false;
            }
            return true;

        }




        //
        // POST: /PuntosVenta/Edit/5

        [HttpPost]
        public virtual ActionResult Edit(Data.Models.PuntosVenta PuntosVenta)
        {
            if (!PuedeLeer()) throw new Exception("No tenés permisos");
            try
            {

                Validar(PuntosVenta);

                if (ModelState.IsValid)
                {
                    if (PuntosVenta.IdPuntoVenta <= 0)
                    {
                        db.PuntosVentas.Add(PuntosVenta);
                        db.SaveChanges();
                    }
                    else
                    {
                        // verificar que esté el ID --->>>>>       @Html.HiddenFor(model => model.productID)

                        // ERROR: Store update, insert, or delete statement affected an unexpected number of rows (0). Entities may have been modified or deleted since entities were loaded. Refresh ObjectStateManager entries
                        // I ran into this and it was caused by the entity's ID (key) field not being set. 
                        // Thus when the context went to save the data, it could not find an ID = 0. 
                        // Be sure to place a break point in your update statement and verify that the entity's ID has been set.
                        //+1 Thanks for adding this answer - I had this exact issue, caused by forgetting to include the hidden ID input in the .cshtml edit page. – Paul Bellora Dec 22 '11 at 19:26
                        //+1 I was having same problem and this helped find the solution. Turns out I had [Bind(Exclude = "OrderID")] in my Order model which was causing the value of the entity's ID to be zero on HttpPost. – David HAust Jan 23 '12 at 2:07
                        //That's exactly what I was missing. My object's ID was 0. – Azhar Khorasany Aug 16 '12 at 21:18
                        //@Html.HiddenFor(model => model.productID) -- worked perfect. I was missing the productID on the EDIT PAGE (MVC RAZOR) – David K Egghead Aug 28 '12 at 5:02


                        // http://stackoverflow.com/a/6337741/1054200

                        db.Entry(PuntosVenta).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        //try
                        //{
                        //    db.SaveChanges();
                        //}
                        //catch (OptimisticConcurrencyException)
                        //{
                        //    db.Refresh(RefreshMode.ClientWins, db.Articles);

                        //}

                    }

                    return RedirectToAction("Index");
                }
                else
                {
                    // el IsValid se quejaba en las altas     
                    // http://stackoverflow.com/questions/2397563/asp-net-mvc-modelstate-isvalid-is-false-how-to-bypass
                    // Try:
                    //public ActionResult CreateCustomer([Bind(Exclude = "Id")]GWCustomer customer)
                    //This will exclude Id from binding and validation.

                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

                    ViewBag.Errores = mensajes;


                    CargarViewBag(PuntosVenta);
                    return View(PuntosVenta);
                }




            }
            catch (System.Data.Entity.Validation.DbEntityValidationException ex)
            {
                //http://stackoverflow.com/questions/10219864/ef-code-first-how-do-i-see-entityvalidationerrors-property-from-the-nuget-pac
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

                //throw new System.Data.Entity.Validation.DbEntityValidationException(
                //    "Entity Validation Failed - errors follow:\n" +
                //    sb.ToString(), ex
                //); // Add the original exception as the innerException

                CargarViewBag(PuntosVenta);
                return View(PuntosVenta);
            }

            catch (Exception ex)
            {

                // me saltaba "[...] because it has a DefiningQuery and no element exists in the element to support the current operation."
                // porque faltaba la PK en la tabla DetalleClientesLugaresEntrega
                // http://stackoverflow.com/questions/7583770/unable-to-update-the-entityset-because-it-has-a-definingquery-and-no-updatefu

                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }

            // return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });


        }



        [HttpPost]
        //public JsonResult BatchUpdate(PuntosVenta PuntosVenta)
        //{
        //    try
        //    {

        //        if (ModelState.IsValid || true)
        //        {
        //            // Perform Update
        //            if (PuntosVenta.IdPuntosVenta > 0)
        //            {
        //                var originalPuntosVenta = db.PuntosVentas.Where(p => p.IdPuntosVenta == PuntosVenta.IdPuntosVenta).Include(p => p.DetallePuntosVentas).SingleOrDefault();
        //                var PuntosVentaEntry = db.Entry(originalPuntosVenta);
        //                PuntosVentaEntry.CurrentValues.SetValues(PuntosVenta);

        //                foreach (var dr in PuntosVenta.DetallePuntosVentas)
        //                {
        //                    var originalDetallePuntosVenta = originalPuntosVenta.DetallePuntosVentas.Where(c => c.IdDetallePuntosVenta == dr.IdDetallePuntosVenta).SingleOrDefault();
        //                    // Is original child item with same ID in DB?
        //                    if (originalDetallePuntosVenta != null)
        //                    {
        //                        // Yes -> Update scalar properties of child item
        //                        //db.Entry(originalDetallePuntosVenta).CurrentValues.SetValues(dr);
        //                        var DetallePuntosVentaEntry = db.Entry(originalDetallePuntosVenta);
        //                        DetallePuntosVentaEntry.CurrentValues.SetValues(dr);
        //                    }
        //                    else
        //                    {
        //                        // No -> It's a new child item -> Insert
        //                        originalPuntosVenta.DetallePuntosVentas.Add(dr);
        //                    }
        //                }

        //                // Now you must delete all entities present in parent.ChildItems but missing in modifiedParent.ChildItems
        //                // ToList should make copy of the collection because we can't modify collection iterated by foreach
        //                foreach (var originalDetallePuntosVenta in originalPuntosVenta.DetallePuntosVentas.Where(c => c.IdDetallePuntosVenta != 0).ToList())
        //                {
        //                    // Are there child items in the DB which are NOT in the new child item collection anymore?
        //                    if (!PuntosVenta.DetallePuntosVentas.Any(c => c.IdDetallePuntosVenta == originalDetallePuntosVenta.IdDetallePuntosVenta))
        //                        // Yes -> It's a deleted child item -> Delete
        //                        originalPuntosVenta.DetallePuntosVentas.Remove(originalDetallePuntosVenta);
        //                    //db.DetallePuntosVentas.Remove(originalDetallePuntosVenta);
        //                }
        //                db.Entry(originalPuntosVenta).State = System.Data.Entity.EntityState.Modified;


        //                //foreach (DetallePuntosVenta dr in PuntosVenta.DetallePuntosVentas)
        //                //{
        //                //    if (dr.IdDetallePuntosVenta > 0)
        //                //    {
        //                //        db.Entry(dr).State = System.Data.Entity.EntityState.Modified;
        //                //    }
        //                //    else
        //                //    {
        //                //        db.Entry(dr).State = System.Data.Entity.EntityState.Added;
        //                //        //db.DetallePuntosVentas.Add(dr);
        //                //    }
        //                //}
        //                //db.Entry(PuntosVenta).State = System.Data.Entity.EntityState.Modified;
        //            }
        //            //Perform Save
        //            else
        //            {
        //                db.PuntosVentas.Add(PuntosVenta);




        //                var pv = (from item in db.PuntosVentas
        //                          where item.Letra == PuntosVenta.TipoABC && item.PuntoVenta == PuntosVenta.PuntoVenta
        //                             && item.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.PuntosVenta
        //                          select item).SingleOrDefault();

        //                // var pv = db.PuntosVenta.Where(p => p.IdPuntoVenta == PuntosVenta.IdPuntoVenta).SingleOrDefault();
        //                pv.ProximoNumero += 1;

        //                //   ClaseMigrar.AsignarNumeroATalonario(SC, myRemito.IdPuntoVenta, myRemito.Numero + 1);


        //            }
        //            db.SaveChanges();

        //            if (false) PuntosVentaelectronica();

        //            //http://stackoverflow.com/questions/2864972/how-to-redirect-to-a-controller-action-from-a-jsonresult-method-in-asp-net-mvc
        //            //return RedirectToAction(( "Index",    "PuntosVenta");
        //            //redirectUrl = Url.Action("Index", "Home"), 
        //            //isRedirect = true 

        //            return Json(new { Success = 1, IdPuntosVenta = PuntosVenta.IdPuntosVenta, ex = "" }); //, DetallePuntosVentas = PuntosVenta.DetallePuntosVentas
        //        }


        //    }
        //    catch (Exception ex)
        //    {
        //        // If Sucess== 0 then Unable to perform Save/Update Operation and send Exception to View as JSON
        //        return Json(new { Success = 0, ex = ex.Message.ToString() });
        //    }
        //    return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        //}









        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////
        //este es el indice que se usa para la grilla de Jquery como se ve en el Index de PuntoVentas
        /////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////////////////

        public virtual ActionResult Listado_jqGrid(string sidx, string sord, int? page, int? rows,
                                         bool _search, string searchField, string searchOper, string searchString,
                                         string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.PuntosVentas.Include("TiposComprobante").AsQueryable();
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
                            IdPuntoVenta = a.IdPuntoVenta,
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
                        //join c in db.PuntoVentas on a.IdPuntoVenta equals c.IdPuntoVenta
                        select a).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

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
                                "<a href="+ Url.Action("Edit",new {id = a.IdPuntoVenta} )  +" target='_blank' >Editar</>" 
                                //+         "|" +      "<a href=/Cliente/Details/" + a.IdPuntoVenta + ">Detalles</a> "
                                ,
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdPuntoVenta} )  +">Imprimir</>" ,
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

                                //(a.FechaCliente ?? DateTime.MinValue).ToString(),
                                ////a.FechaCliente.ToString(),
                                //(a.PuntoVentas==null ? string.Empty : a.PuntoVentas.RazonSocial ).ToString(),
                                //(a.IdPuntoVenta ?? 0).ToString(),
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



    }
}