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


// using JQGridMVCExamples.Models;
//using Trirand.Web.Mvc; //  http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring



using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class ListaPrecioController : ProntoBaseController
    {

        //
        // GET: /Factura/

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.ListasPrecios)) throw new Exception("No tenés permisos");

            if (db == null)
            {
                FormsAuthentication.SignOut();
                return View("ElegirBase", "Home");
            }

            var Facturas = db.ListasPrecios;


            return View(Facturas.ToList());
        }

        //
        // GET: /Factura/Details/5

        public virtual ViewResult Details(int id)
        {
            Factura Factura = db.Facturas.Find(id);
            return View(Factura);
        }

        //
        // GET: /Factura/Create

        public virtual ActionResult Create()
        {
            Factura Factura = new Factura();

            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra");
            ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial");
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(i => i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura).Distinct(), "IdPuntoVenta", "PuntoVenta");
            ViewBag.IdCodigoIva = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion");

            // string connectionString = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string connectionString = Generales.sCadenaConex(this.Session["BasePronto"].ToString());

            Factura.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(connectionString, 1, 6);
            Factura.FechaFactura = DateTime.Now;

            return View(Factura);
        }





        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.ListasPrecio o)
        {
            if (!PuedeEditar(enumNodos.ListasPrecios)) throw new Exception("No tenés permisos");

            try
            {

                if (ModelState.IsValid || true)
                {
                    // Perform Update
                    if (o.IdListaPrecios > 0)
                    {

                        var original = db.ListasPrecios.Where(p => p.IdListaPrecios == o.IdListaPrecios)
                                                        .Include(p => p.ListasPreciosDetalles)
                                                        .SingleOrDefault();

                        var FacturaEntry = db.Entry(original);
                        FacturaEntry.CurrentValues.SetValues(o);

                        foreach (var dr in o.ListasPreciosDetalles)
                        {
                            var originalDetalleFactura = original.ListasPreciosDetalles.Where(c => c.IdListaPreciosDetalle == dr.IdListaPreciosDetalle).SingleOrDefault();
                            // Is original child item with same ID in DB?
                            if (originalDetalleFactura != null)
                            {
                                // Yes -> Update scalar properties of child item
                                //db.Entry(originalDetalleFactura).CurrentValues.SetValues(dr);
                                var DetalleFacturaEntry = db.Entry(originalDetalleFactura);
                                DetalleFacturaEntry.CurrentValues.SetValues(dr);
                            }
                            else
                            {
                                // No -> It's a new child item -> Insert
                                original.ListasPreciosDetalles.Add(dr);
                            }
                        }

                        // Now you must delete all entities present in parent.ChildItems but missing in modifiedParent.ChildItems
                        // ToList should make copy of the collection because we can't modify collection iterated by foreach
                        foreach (var originalDetalleFactura in original.ListasPreciosDetalles.Where(c => c.IdListaPreciosDetalle != 0).ToList())
                        {
                            // Are there child items in the DB which are NOT in the new child item collection anymore?
                            if (!o.ListasPreciosDetalles.Any(c => c.IdListaPreciosDetalle == originalDetalleFactura.IdListaPreciosDetalle))
                                // Yes -> It's a deleted child item -> Delete
                                original.ListasPreciosDetalles.Remove(originalDetalleFactura);
                            //db.DetalleFacturas.Remove(originalDetalleFactura);
                        }
                        db.Entry(original).State = System.Data.Entity.EntityState.Modified;


                        //foreach (DetalleFactura dr in o.DetalleFacturas)
                        //{
                        //    if (dr.IdDetalleFactura > 0)
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Modified;
                        //    }
                        //    else
                        //    {
                        //        db.Entry(dr).State = System.Data.Entity.EntityState.Added;
                        //        //db.DetalleFacturas.Add(dr);
                        //    }
                        //}
                        //db.Entry(Factura).State = System.Data.Entity.EntityState.Modified;
                    }
                    //Perform Save
                    else
                    {
                        db.ListasPrecios.Add(o);



                    }
                    db.SaveChanges();

                    // if (false) facturaelectronica();

                    //http://stackoverflow.com/questions/2864972/how-to-redirect-to-a-controller-action-from-a-jsonresult-method-in-asp-net-mvc
                    //return RedirectToAction(( "Index",    "Factura");
                    //redirectUrl = Url.Action("Index", "Home"), 
                    //isRedirect = true 

                    return Json(new { Success = 1, IdFactura = o.IdListaPrecios, ex = "" }); //, DetalleFacturas = o.DetalleFacturas
                }
                else
                {

                    var allErrors = ModelState.Values.SelectMany(v => v.Errors);
                    var mensajes = string.Join("; ", from i in allErrors select (i.ErrorMessage + (i.Exception == null ? "" : i.Exception.Message)));

                    ViewBag.Errores = mensajes;

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
                    }
                }

                throw new System.Data.Entity.Validation.DbEntityValidationException(
                    "Entity Validation Failed - errors follow:\n" +
                    sb.ToString(), ex
                ); // Add the original exception as the innerException


            }
            catch (Exception ex)
            {

                // If Sucess== 0 then Unable to perform Save/Update Operation and send Exception to View as JSON
                return Json(new { Success = 0, ex = ex.Message.ToString() });
            }
            return Json(new { Success = 0, ex = new Exception("Error al registrar").Message.ToString(), ModelState = ModelState });
        }




        // GET: /PuntosVenta/Edit/5

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.ListasPrecios)) throw new Exception("No tenés permisos");
            ProntoMVC.Data.Models.ListasPrecio o;
            if (id == -1)
            {
                o = new ProntoMVC.Data.Models.ListasPrecio();

            }
            else
            {
                o = db.ListasPrecios
                    .Include(x => x.ListasPreciosDetalles)
                    .Include("ListasPreciosDetalles.Articulo")
                    .SingleOrDefault(x => x.IdListaPrecios == id);
            }

            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            // ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", Ganancias.IdTipoRetencionGanancia);
            return View(o);
        }

        //
        // POST: /PuntosVenta/Edit/5

        [HttpPost]
        public virtual ActionResult Edit(ProntoMVC.Data.Models.ListasPrecio o)
        {
            if (!PuedeLeer(enumNodos.ListasPrecios)) throw new Exception("No tenés permisos");
            if (ModelState.IsValid)
            {
                if (o.IdListaPrecios <= 0)
                {
                    db.ListasPrecios.Add(o);
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
            return View(o);

        }


        // GET: /Factura/Delete/5
        public virtual ActionResult Delete(int id)
        {
            Factura Factura = db.Facturas.Find(id);
            return View(Factura);
        }

        // POST: /Factura/Delete/5
        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            Factura Factura = db.Facturas.Find(id);
            db.Facturas.Remove(Factura);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult DeleteConfirmedDirecto(int id)
        {
            ProntoMVC.Data.Models.ListasPrecio o = db.ListasPrecios.Find(id);
            db.ListasPrecios.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
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

            var Fac = db.ListasPrecios.Include(x=>x.Moneda).AsQueryable();
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
                            IdIBCondicion = a.IdListaPrecios
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
                        select a)
                        .Where(campo)
                        .OrderBy(sidx + " " + sord)
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
                            id = a.IdListaPrecios.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdListaPrecios} )  +" target='_blank' >Editar</>" 
                                // +
                                //"|" +
                                //"<a href=/Cliente/Details/" + a.IdIBCondicion + ">Detalles</a> ",
                                //"<a href="+ Url.Action("Imprimir",new {id = a.IdIBCondicion} )  +">Imprimir</>" 
                                ,
                              
                                a.IdListaPrecios.ToString(),
                                  a.Descripcion.NullSafeToString(),
                                a.NumeroLista.ToString(),
                                a.FechaVigencia.ToString(),
                                a.Activa,
                                (a.Moneda==null ? string.Empty : a.Moneda.Nombre ).ToString()
                                

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



        public virtual ActionResult DetListaPrecios(string sidx, string sord, int? page, int? rows, int? IdListaPrecio)
        {
            int IdFactura1 = IdListaPrecio ?? 0;
            var DetReq = db.ListasPreciosDetalles.Where(p => p.IdListaPrecios == IdFactura1).AsQueryable();
            bool Eliminado = false;

            int pageSize = rows ?? 20;
            int totalRecords = DetReq.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetReq
                        select new
                        {
                            a.IdListaPreciosDetalle,
                            a.IdArticulo,
                            a.Articulo.Codigo,
                            a.Articulo.Descripcion,
                            a.Precio
                            
                        })
                                                      .OrderBy(p => p.IdListaPreciosDetalle)
                                                      
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
                            id = a.IdListaPreciosDetalle.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdListaPreciosDetalle.NullSafeToString(), 
                                a.IdArticulo.NullSafeToString(), 
                                a.Codigo.NullSafeToString(),
                                a.Descripcion.NullSafeToString(),
                                a.Precio.NullSafeToString()} //a.PostedOn.Value.ToShortDateString()
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdFactura, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
        {
            switch (oper)
            {
                case "add": //Validate Input ; Add Method
                    break;
                case "edit":  //Validate Input ; Edit Method
                    break;
                case "del": //Validate Input ; Delete Method
                    break;
                default: break;
            }

        }

        //[HttpPost]
        //public ActionResult Facturas2(string sidx, string sord, int? page, int? rows, bool _search, string filters) //, string searchField, string searchOper, string searchString)
        //{
        //    var serializer = new JavaScriptSerializer();
        //    Filters f = (!_search || string.IsNullOrEmpty(filters)) ? null : serializer.Deserialize<Filters>(filters);
        //    ObjectQuery<Factura> filteredQuery = (f == null ? db.Facturas : f.FilterObjectSet(db.Facturas));
        //    filteredQuery.MergeOption = MergeOption.NoTracking; // we don't want to update the data
        //    var totalRecords = filteredQuery.Count();

        //    var pagedQuery = filteredQuery.Skip("it." + sidx + " " + sord, "@skip",
        //                                        new ObjectParameter("skip", (page - 1) * rows))
        //                                 .Top("@limit", new ObjectParameter("limit", rows));
        //    // to be able to use ToString() below which is NOT exist in the LINQ to Entity
        //    var queryDetails = (from item in pagedQuery
        //                        select new { item.IdFactura, item.FechaFactura, item.Detalle }).ToList();

        //    return Json(new
        //    {
        //        total = (totalRecords + rows - 1) / rows,
        //        page,
        //        records = totalRecords,
        //        rows = (from item in queryDetails
        //                select new[] {
        //                                item.IdFactura.ToString(),
        //                                item.FechaFactura.ToString(),
        //                                item.Detalle
        //                            }).ToList()
        //    });
        //}




        public virtual ActionResult EditDetalle(int id, int idparent = -1)
        {
            if (!PuedeLeer(enumNodos.ListasPrecios)) throw new Exception("No tenés permisos");
            ProntoMVC.Data.Models.ListasPreciosDetalle o;
            if (id == -1)
            {
                o = new ProntoMVC.Data.Models.ListasPreciosDetalle();
                o.IdListaPrecios = idparent;
            }
            else
            {
                o = db.ListasPreciosDetalles.Find(id);
            }

            // ViewBag.IdMonedas = new SelectList(db.Monedas, "IdMoneda", "Descripcion", o.idm);

            return View(o);
        }

        //
        // POST: /PuntosVenta/Edit/5

        [HttpPost]
        public virtual ActionResult EditDetalle(ProntoMVC.Data.Models.ListasPreciosDetalle o)
        {
            o.Articulo = db.Articulos.Find(o.IdArticulo);

            if (ModelState.IsValid)
            {

                if (o.IdListaPreciosDetalle <= 0)
                {
                    db.ListasPreciosDetalles.Add(o);
                    db.SaveChanges();
                    return RedirectToAction("Edit", "ListaPrecio", new { id = o.IdListaPrecios });
                }
                else
                {
                    db.Entry(o).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                    return RedirectToAction("Edit", "ListaPrecio", new { id = o.IdListaPrecios });

                }
            }
            return View(o);


        }



        public virtual ActionResult DeleteDetalleConfirmedDirecto(int id)
        {
            ProntoMVC.Data.Models.ListasPreciosDetalle o = db.ListasPreciosDetalles.Find(id);
            db.ListasPreciosDetalles.Remove(o);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////////////////////


        //
        // GET: /GridDemo/

        //public ActionResult GridDemo()
        //{
        //    // Get the model (setup) of the grid defined in the /Models folder.
        //    var gridModel = new ClassLibrary2.ListasPrecio();
        //    var ordersGrid = gridModel.OrdersGrid;

        //    // customize the default Orders grid model with custom settings
        //    // NOTE: you need to call this method in the action that fetches the data as well,
        //    // so that the models match
        //    SetUpGrid(ordersGrid);

        //    // Pass the custmomized grid model to the View
        //    return View(gridModel);
        //}

        // This method is called when the grid requests data
        //public JsonResult SearchGridDataRequested()
        //{
        //    // Get both the grid Model and the data Model
        //    // The data model in our case is an autogenerated linq2sql database based on Northwind.
        //    var gridModel = new ClassLibrary2.ListasPrecio();
        //    // var northWindModel = new NorthwindDataContext();

        //    // customize the default Orders grid model with our custom settings
        //    SetUpGrid(gridModel.OrdersGrid);

        //    // return the result of the DataBind method, passing the datasource as a parameter
        //    // jqGrid for ASP.NET MVC automatically takes care of paging, sorting, filtering/searching, etc
        //    return gridModel.OrdersGrid.DataBind(db.ListasPrecios);
        //}

        //public ActionResult EditRows(ListasPrecio editedOrder)
        //{
        //    // Get the grid and database (northwind) models
        //    var gridModel = new ClassLibrary2.ListasPrecio();
        //    // var northWindModel = new NorthwindDataContext();

        //    // If we are in "Edit" mode
        //    if (gridModel.OrdersGrid.AjaxCallBackMode == AjaxCallBackMode.EditRow)
        //    {
        //        // Get the data from and find the Order corresponding to the edited row
        //        ListasPrecio order = (from o in db.ListasPrecios
        //                                     where o.IdListaPrecios == editedOrder.IdListaPrecios
        //                                     select o).First<ListasPrecio>();

        //        // update the Order information
        //        order.FechaVigencia = editedOrder.FechaVigencia;
        //        // order.IdListaPrecios = editedOrder.IdListaPrecios;
        //        order.Activa = editedOrder.Activa;
        //        order.Descripcion = editedOrder.Descripcion;

        //        db.SaveChanges();
        //    }
        //    if (gridModel.OrdersGrid.AjaxCallBackMode == AjaxCallBackMode.AddRow)
        //    {
        //        // since we are adding a new Order, create a new istance
        //        ListasPrecio order = new ListasPrecio();
        //        // set the new Order information
        //        order.IdListaPrecios = (from o in db.ListasPrecios
        //                                select o)
        //                        .Max<ListasPrecio>(o => o.IdListaPrecios) + 1;

        //        order.FechaVigencia = editedOrder.FechaVigencia;
        //        //  order.IdListaPrecios = editedOrder.IdListaPrecios;
        //        order.Activa = editedOrder.Activa;
        //        order.Descripcion = editedOrder.Descripcion;

        //        db.ListasPrecios.Add(order);
        //        db.SaveChanges();
        //    }
        //    if (gridModel.OrdersGrid.AjaxCallBackMode == AjaxCallBackMode.DeleteRow)
        //    {
        //        ListasPrecio order = (from o in db.ListasPrecios
        //                                     where o.IdListaPrecios == editedOrder.IdListaPrecios
        //                                     select o)
        //                       .First<ListasPrecio>();

        //        // delete the record                
        //        db.ListasPrecios.Remove(order);
        //        db.SaveChanges();
        //    }

        //    return RedirectToAction("GridDemo", "Grid");
        //}

        //private void SetUpGrid(JQGrid ordersGrid)
        //{
        //    // Customize/change some of the default settings for this model
        //    // ID is a mandatory field. Must by unique if you have several grids on one page.
        //    ordersGrid.ID = "OrdersGrid";
        //    // Setting the DataUrl to an action (method) in the controller is required.
        //    // This action will return the data needed by the grid
        //    ordersGrid.DataUrl = Url.Action("SearchGridDataRequested");
        //    ordersGrid.EditUrl = Url.Action("EditRows");
        //    // show the search toolbar
        //    ordersGrid.ToolBarSettings.ShowSearchToolBar = true;
        //    ordersGrid.Columns.Find(c => c.DataField == "IdListaPrecios").Searchable = false;
        //    // ordersGrid.Columns.Find(c => c.DataField == "FechaVigencia").Searchable = false;

        //    SetUpCustomerIDSearchDropDown(ordersGrid);
        //    SetUpFreightSearchDropDown(ordersGrid);
        //    SetShipNameSearchDropDown(ordersGrid);

        //    ordersGrid.ToolBarSettings.ShowEditButton = true;
        //    ordersGrid.ToolBarSettings.ShowAddButton = true;
        //    ordersGrid.ToolBarSettings.ShowDeleteButton = true;
        //    ordersGrid.EditDialogSettings.CloseAfterEditing = true;
        //    ordersGrid.AddDialogSettings.CloseAfterAdding = true;

        //    // setup the dropdown values for the CustomerID editing dropdown
        //    SetUpCustomerIDEditDropDown(ordersGrid);
        //}

        //private void SetUpCustomerIDSearchDropDown(JQGrid ordersGrid)
        //{
        //    // setup the grid search criteria for the columns
        //    JQGridColumn customersColumn = ordersGrid.Columns.Find(c => c.DataField == "IdListaPrecios");
        //    customersColumn.Searchable = true;

        //    // DataType must be set in order to use searching
        //    customersColumn.DataType = typeof(string);
        //    customersColumn.SearchToolBarOperation = SearchOperation.IsEqualTo;
        //    customersColumn.SearchType = SearchType.DropDown;

        //    // Populate the search dropdown only on initial request, in order to optimize performance
        //    if (ordersGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
        //    {
        //        // var northWindModel = new NorthwindDataContext();
        //        // http://stackoverflow.com/questions/10110266/why-linq-to-entities-does-not-recognize-the-method-system-string-tostring

        //        var searchList = (from customers in db.ListasPrecios
        //                          select customers.IdListaPrecios)
        //                          .AsEnumerable()
        //                          .Select(x => new SelectListItem { Text = x.ToString(), Value = x.ToString() });





        //        customersColumn.SearchList = searchList.ToList<SelectListItem>();
        //        customersColumn.SearchList.Insert(0, new SelectListItem { Text = "All", Value = "" });
        //    }
        //}

        //private void SetUpFreightSearchDropDown(JQGrid ordersGrid)
        //{
        //    // setup the grid search criteria for the columns
        //    JQGridColumn freightColumn = ordersGrid.Columns.Find(c => c.DataField == "Descripcion");
        //    freightColumn.Searchable = true;

        //    // DataType must be set in order to use searching
        //    freightColumn.DataType = typeof(decimal);
        //    freightColumn.SearchToolBarOperation = SearchOperation.IsGreaterOrEqualTo;
        //    freightColumn.SearchType = SearchType.DropDown;

        //    // Populate the search dropdown only on initial request, in order to optimize performance
        //    if (ordersGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
        //    {
        //        List<SelectListItem> searchList = new List<SelectListItem>();
        //        searchList.Add(new SelectListItem { Text = "> 10", Value = "10" });
        //        searchList.Add(new SelectListItem { Text = "> 30", Value = "30" });
        //        searchList.Add(new SelectListItem { Text = "> 50", Value = "50" });
        //        searchList.Add(new SelectListItem { Text = "> 100", Value = "100" });

        //        freightColumn.SearchList = searchList.ToList<SelectListItem>();
        //        freightColumn.SearchList.Insert(0, new SelectListItem { Text = "All", Value = "" });
        //    }
        //}

        //private void SetShipNameSearchDropDown(JQGrid ordersGrid)
        //{
        //    JQGridColumn freightColumn = ordersGrid.Columns.Find(c => c.DataField == "Descripcion");
        //    freightColumn.Searchable = true;
        //    freightColumn.DataType = typeof(string);
        //    freightColumn.SearchToolBarOperation = SearchOperation.Contains;
        //    freightColumn.SearchType = SearchType.TextBox;
        //}

        //private void SetUpCustomerIDEditDropDown(JQGrid ordersGrid)
        //{
        //    // setup the grid search criteria for the columns
        //    JQGridColumn customersColumn = ordersGrid.Columns.Find(c => c.DataField == "Descripcion");
        //    customersColumn.Editable = true;
        //    customersColumn.EditType = EditType.DropDown;

        //    // Populate the search dropdown only on initial request, in order to optimize performance
        //    if (ordersGrid.AjaxCallBackMode == AjaxCallBackMode.RequestData)
        //    {

        //        // var northWindModel = new NorthwindDataContext();

        //        var editList = (from customers in db.ListasPrecios
        //                        select customers.IdListaPrecios)
        //                       .AsEnumerable()
        //                       .Select(x => new SelectListItem { Text = x.ToString(), Value = x.ToString() });


        //        customersColumn.EditList = editList.ToList<SelectListItem>();
        //    }
        //}


    }
}