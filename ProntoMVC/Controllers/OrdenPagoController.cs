using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Objects;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Text;
using System.Reflection;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Web.Security;

namespace ProntoMVC.Controllers
{
    public partial class OrdenPagoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Compras")
                ) throw new Exception("No tenés permisos");

            //var OrdenesPago = db.OrdenesPago.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult IndexExterno()
        {
            //var OrdenesPago = db.OrdenesPago.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }
        public virtual ViewResult Details(int id)
        {
            OrdenPago OrdenPago = db.OrdenesPago.Find(id);
            return View(OrdenPago);
        }

        public virtual ActionResult Create()
        {
            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre");
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
            ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Proveedor = "";
            return View();
        }


        void enviarmailAlComprador()
        {

        }


        public virtual ActionResult Edit(int id)
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Compras")
               ) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                OrdenPago OrdenPago = new OrdenPago();
                inic(ref OrdenPago);

                CargarViewBag(OrdenPago);


                return View(OrdenPago);
            }
            else
            {


                OrdenPago OrdenPago = db.OrdenesPago.Find(id);
                // ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", OrdenPago.IdCondicionCompra);

                CargarViewBag(OrdenPago);
                Session.Add("OrdenPago", OrdenPago);
                return View(OrdenPago);
            }
        }


        void inic(ref OrdenPago o)
        {





            Parametros parametros = db.Parametros.Find(1);
            o.NumeroOrdenPago = parametros.ProximaOrdenPago;
            //o.SubNumero = 1;
            //o.FechaComprobanteProveedor = DateTime.Today;
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;

            o.FechaIngreso = DateTime.Today;


            //o.PorcentajeIva1 = 21;                  //  mvarP_IVA1_Tomado
            //o.FechaFactura = DateTime.Now;

            //Parametros parametros = db.Parametros.Find(1);
            //o.OtrasPercepciones1 = 0;
            //o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            //o.OtrasPercepciones2 = 0;
            //o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            //o.OtrasPercepciones3 = 0;
            //o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            //o.IdMoneda = 1;

            //mvarP_IVA1 = .Fields("Iva1").Value
            //mvarP_IVA2 = .Fields("Iva2").Value
            //mvarPorc_IBrutos_Cap = .Fields("Porc_IBrutos_Cap").Value
            //mvarTope_IBrutos_Cap = .Fields("Tope_IBrutos_Cap").Value
            //mvarPorc_IBrutos_BsAs = .Fields("Porc_IBrutos_BsAs").Value
            //mvarTope_IBrutos_BsAs = .Fields("Tope_IBrutos_BsAs").Value
            //mvarPorc_IBrutos_BsAsM = .Fields("Porc_IBrutos_BsAsM").Value
            //mvarTope_IBrutos_BsAsM = .Fields("Tope_IBrutos_BsAsM").Value
            //mvarDecimales = .Fields("Decimales").Value
            //mvarAclaracionAlPie = .Fields("AclaracionAlPieDeFactura").Value
            //mvarIdMonedaPesos = .Fields("IdMoneda").Value
            //mvarIdMonedaDolar = .Fields("IdMonedaDolar").Value
            //mvarPercepcionIIBB = IIf(IsNull(.Fields("PercepcionIIBB").Value), "NO", .Fields("PercepcionIIBB").Value)
            //mvarOtrasPercepciones1 = IIf(IsNull(.Fields("OtrasPercepciones1").Value), "NO", .Fields("OtrasPercepciones1").Value)
            //mvarOtrasPercepciones1Desc = IIf(IsNull(.Fields("OtrasPercepciones1Desc").Value), "", .Fields("OtrasPercepciones1Desc").Value)
            //mvarOtrasPercepciones2 = IIf(IsNull(.Fields("OtrasPercepciones2").Value), "NO", .Fields("OtrasPercepciones2").Value)
            //mvarOtrasPercepciones2Desc = IIf(IsNull(.Fields("OtrasPercepciones2Desc").Value), "", .Fields("OtrasPercepciones2Desc").Value)
            //mvarOtrasPercepciones3 = IIf(IsNull(.Fields("OtrasPercepciones3").Value), "NO", .Fields("OtrasPercepciones3").Value)
            //mvarOtrasPercepciones3Desc = IIf(IsNull(.Fields("OtrasPercepciones3Desc").Value), "", .Fields("OtrasPercepciones3Desc").Value)
            //mvarConfirmarClausulaDolar = IIf(IsNull(.Fields("ConfirmarClausulaDolar").Value), "NO", .Fields("ConfirmarClausulaDolar").Value)
            //mvarNumeracionUnica = False
            //If .Fields("NumeracionUnica").Value = "SI" Then mvarNumeracionUnica = True
            //gblFechaUltimoCierre = IIf(IsNull(.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), .Fields("FechaUltimoCierre").Value)


            // db.Cotizaciones_TX_PorFechaMoneda(fecha,IdMoneda)
            var mvarCotizacion = db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            o.CotizacionMoneda = 1;
            //  o.CotizacionADolarFijo=
            o.CotizacionDolar = (decimal)mvarCotizacion;

            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());
            //o.DetalleFacturas.Add(new DetalleFactura());

        }


        public virtual JsonResult Autorizaciones(int IdPedido)
        {
            var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.OrdenesPago, IdPedido);
            return Json(Autorizaciones, JsonRequestBehavior.AllowGet);
        }


        void CargarViewBag(OrdenPago o)
        {

            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
            ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");

            ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;



            //ViewBag.IdTipoComprobante = new SelectList(db.TiposComprobantes, "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);
            //ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionCompra);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", o.PlazoEntrega);
            //ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdComprador);
            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Aprobo);
            //ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;

            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", (o.Proveedor ?? new Proveedor()).IdCodigoIva);
            ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.OrdenesPago, 0, -1).Count();

            //ViewBag.TotalBonificacionGlobal = o.Bonificacion;


            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            //ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            //ViewBag.PuntoVenta = new SelectList((from i in db.PuntosVentas
            //                                     where i.IdTipoComprobante == (int)Pronto.ERP.Bll.EntidadManager.IdTipoComprobante.Factura
            //                                     select new { PuntoVenta = i.PuntoVenta })
            //    // http://stackoverflow.com/questions/2135666/databinding-system-string-does-not-contain-a-property-with-the-name-dbmake
            //                                     .Distinct(), "PuntoVenta", "PuntoVenta"); //traer solo el Numero de PuntoVenta, no el Id


            //ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            //ViewBag.IdCliente = new SelectList(db.Clientes, "IdCliente", "RazonSocial", o.IdCliente);
            //ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            //ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);

            ////http://stackoverflow.com/questions/942262/add-empty-value-to-a-dropdownlist-in-asp-net-mvc
            //// http://stackoverflow.com/questions/7659612/mvc3-dropdownlist-and-viewbag-how-add-new-items-to-collection
            ////List<SelectListItem>  l = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ////l.ad
            ////l.Add((new SelectListItem { IdIBCondicion = " ", Descripcion = "-1" }));
            //ViewBag.IdIBCondicionPorDefecto = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);



            //ViewBag.IdIBCondicionPorDefecto2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            //ViewBag.IdIBCondicionPorDefecto3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);



            //Parametros parametros = db.Parametros.Find(1);
            //ViewBag.PercepcionIIBB = parametros.PercepcionIIBB;

        }



        public virtual ActionResult EditExterno(int id)
        {




            if (id == -1)
            {
                OrdenPago OrdenPago = new OrdenPago();
                Parametros parametros = db.Parametros.Find(1);
                //OrdenPago.Numero = parametros.ProximoOrdenesPago;
                //OrdenPago.SubNumero = 1;
                OrdenPago.FechaIngreso = DateTime.Today;
                OrdenPago.IdMoneda = 1;
                OrdenPago.CotizacionMoneda = 1;
                ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
                ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", OrdenPago.IdMoneda);
                ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
                ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
                ViewBag.Proveedor = "";
                return View(OrdenPago);
            }
            else
            {
                OrdenPago OrdenPago = db.OrdenesPago.Find(id);


                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)Membership.GetUser().ProviderUserKey));
                if (OrdenPago.IdProveedor != idproveedor
                     && !Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador")
                    ) throw new Exception("Sólo podes acceder a OrdenesPago tuyos");


                //  ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", OrdenPago.IdCondicionCompra);
                //ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", OrdenPago.IdMoneda);
                //ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", OrdenPago.IdPlazoEntrega);
                //ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", OrdenPago.IdComprador);
                //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", OrdenPago.Aprobo);
                try
                {
                    ViewBag.Proveedor = db.Proveedores.Find(OrdenPago.IdProveedor).RazonSocial;
                }
                catch (Exception e)
                {

                    ErrHandler.WriteError(e);
                }

                Session.Add("OrdenPago", OrdenPago);
                return View(OrdenPago);
            }
        }
        [HttpPost]
        public virtual ActionResult Edit(OrdenPago OrdenPago)
        {

            if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
               !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador")
               ) throw new Exception("No tenés permisos");

            if (ModelState.IsValid)
            {
                db.Entry(OrdenPago).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            // ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", OrdenPago.IdCondicionCompra);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", OrdenPago.IdMoneda);
            //ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion", OrdenPago.IdPlazoEntrega);
            //ViewBag.RazonSocial = OrdenPago.Proveedor.RazonSocial;
            //ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre", OrdenPago.IdComprador);
            //ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", OrdenPago.Aprobo);
            ViewBag.Proveedor = db.Proveedores.Find(OrdenPago.IdProveedor).RazonSocial;
            return View(OrdenPago);
        }

        public virtual ActionResult Delete(int id)
        {
            OrdenPago OrdenPago = db.OrdenesPago.Find(id);
            return View(OrdenPago);
        }

        [HttpPost, ActionName("Delete")]
        public virtual ActionResult DeleteConfirmed(int id)
        {
            OrdenPago OrdenPago = db.OrdenesPago.Find(id);
            db.OrdenesPago.Remove(OrdenPago);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual ActionResult OrdenesPago_obsoleta(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.OrdenesPago.AsQueryable();
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Entidad = (from a in Entidad where a.FechaIngreso >= FechaDesde && a.FechaIngreso <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numero":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaingreso":
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

            var Entidad1 = (from a in Entidad select new { IdOrdenesPago = a.IdOrdenPago }).Where(campo);

            int totalRecords = Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {

                            IdOrdenesPago = a.IdOrdenPago,
                            Numero = a.NumeroOrdenPago,
                            //Orden = a.SubNumero,
                            FechaIngreso = a.FechaIngreso,
                            //Proveedor = a.Proveedor.RazonSocial,
                            //Validez = a.Validez,
                            //Bonificacion = a.Bonificacion,
                            //PorcentajeIva1 = a.PorcentajeIva1,
                            //Moneda = a.Moneda.Abreviatura,
                            //Subtotal = (a.ImporteTotal - a.ImporteIva1 + a.ImporteBonificacion),
                            //ImporteBonificacion = a.ImporteBonificacion,
                            //ImporteIva1 = a.ImporteIva1,
                            //ImporteTotal = a.ImporteTotal,
                            //PlazoEntrega = a.PlazosEntrega.Descripcion,
                            //CondicionCompra = a.Condiciones_Compra.Descripcion,
                            //Garantia = a.Garantia,
                            //LugarEntrega = a.LugarEntrega,
                            //Comprador = a.Empleado.Nombre,
                            //Aprobo = a.Empleado2.Nombre,
                            //Referencia = a.Referencia,
                            Detalle = a.Detalle,
                            //Contacto = a.Contacto,
                            Observaciones = a.Observaciones
                        }).Where(campo).OrderBy(sidx + " " + sord).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenesPago.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdOrdenesPago} ) + " target='' >Editar</>" 
								 +"|"+"<a href=../OrdenPago/Edit/" + a.IdOrdenesPago + "?code=1" + ">Detalles</a> ",
                                a.IdOrdenesPago.ToString(), 
                                a.Numero.ToString(), 
                               // a.Orden.ToString(), 
                                a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                //a.Proveedor,
                                //a.Validez,
                                //a.Bonificacion.ToString(),
                                //a.PorcentajeIva1.ToString(),
                                //a.Moneda,
                                //a.Subtotal.ToString(),
                                //a.ImporteBonificacion.ToString(),
                                //a.ImporteIva1.ToString(),
                                //a.ImporteTotal.ToString(),
                                //a.PlazoEntrega,
                                //a.CondicionCompra,
                                //a.Garantia,
                                //a.LugarEntrega,
                                //a.Comprador,
                                //a.Aprobo,
                                //a.Referencia,
                                a.Detalle,
                                //a.Contacto,
                                a.Observaciones
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult OrdenesPago(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;


            int idproveedor;


            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var pendiente = "S"; //hay que usar S para traer solo lo pendiente

            //var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TX_EnCaja", "CA"); // "FI", "EN", "CA"
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TT"); // "FI", "EN", "CA"


            IEnumerable<DataRow> Entidad = dt.AsEnumerable();


            try
            {
                idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)Membership.GetUser().ProviderUserKey));
                if (idproveedor > 0)
                {
                    string razonsocial = db.Proveedores.Find(idproveedor).RazonSocial;
                    Entidad = Entidad.Where(p => (string)p["Proveedor"].NullSafeToString() == razonsocial).AsQueryable();
                }

            }
            catch (Exception)
            {


            }



            int totalRecords = Entidad.Count();  // Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);



            var data = (from a in Entidad
                        select new
                        {
                            IdOrdenesPago = a[0],
                            IdOPComplementariaFF = a[1],
                            Numero = a[2],
                            Exterior = a[3],
                            FechaOrdenesPago = a[4],
                            Tipo = a[5],
                            Estado = a[6],
                            Proveedores = a[7],
                            NombreAnterior = a[8],
                            Monedas = a[9],
                            Efectivo = a[10],
                            Descuentos = a[11],
                            Valores = a[12],
                            Documentos = a[13],
                            Acreedores = a[14],
                            RetencionIVA = a[15],
                            RetencionGanancias = a[16],
                            RetencionIBrutos = a[17],
                            RetencionSUSS = a[18],
                            GastosGenerales = a[19],
                            DiferenciaBalanceo = a[20],
                            NumeroOrdenesPago = a[21],
                            CotizacionDolar = a[22],
                            Empleados = a[23],
                            Observaciones = a[24],
                            Obras = a[25],
                            TextoAuxiliar1 = a[26],
                            TextoAuxiliar2 = a[27],
                            TextoAuxiliar3 = a[28]



                        })
                //.Where(campo)
                        .OrderByDescending(x => x.Numero)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenesPago.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditExterno",new {id = a.IdOrdenesPago} ) + " target='' >Editar</>" 
                                 //+"|"+"<a href=../OrdenPago/EditExterno/" + a.IdOrdenesPago + "?code=1" + ">Detalles</a> "
                                 ,
                                                                
                                   "<a href="+ Url.Action("ImprimirRetenciones",new {id = a.IdOrdenesPago} ) + ">Emitir</a> ",
                                 a.IdOPComplementariaFF.NullSafeToString(),
                            a.Numero.NullSafeToString(),
                            //a.IdOrdenPago.NullSafeToString(),
                            a.Exterior.NullSafeToString(),
                            a.FechaOrdenesPago.NullSafeToString(),
                            a.Tipo.NullSafeToString(),
                            a.Estado.NullSafeToString(),
                            a.Proveedores.NullSafeToString(),  
                             a.NombreAnterior.NullSafeToString(),  
                            a.Monedas.NullSafeToString() ,  
                            a.Efectivo.NullSafeToString(),
                            a.Descuentos.NullSafeToString(),
                            a.Valores.NullSafeToString(),
                            a.Documentos.NullSafeToString(),
                            a.Acreedores.NullSafeToString(),
                            a.RetencionIVA.NullSafeToString(),
                            a.RetencionGanancias.NullSafeToString(),
                            a.RetencionIBrutos.NullSafeToString(),
                            a.RetencionSUSS.NullSafeToString(),
                            a.GastosGenerales.NullSafeToString(),
                            a.DiferenciaBalanceo.NullSafeToString(),
                             a.NumeroOrdenesPago .NullSafeToString(),
                            a.CotizacionDolar.NullSafeToString(),
                             a.Empleados.NullSafeToString() ,
                            a.Observaciones.NullSafeToString(),
                             a.Obras.NullSafeToString() ,
                            a.TextoAuxiliar1.NullSafeToString(),
                            a.TextoAuxiliar2.NullSafeToString(),
                            a.TextoAuxiliar3.NullSafeToString()

                                //a.IdOrdenPago.ToString(), 
                                //a.Numero.ToString(), 
                                //a.Orden.ToString(), 
                                //a.FechaIngreso.ToString(),
                                //a.Proveedor,
                                //a.Validez,
                                //a.Bonificacion.ToString(),
                                //a.PorcentajeIva1.ToString(),
                                //a.Moneda,
                                //a.Subtotal.ToString(),
                                //a.ImporteBonificacion.ToString(),
                                //a.ImporteIva1.ToString(),
                                //a.ImporteTotal.ToString(),
                                //a.PlazoEntrega,
                                //a.CondicionCompra,
                                //a.Garantia,
                                //a.LugarEntrega,
                                //a.Comprador,
                                //a.Aprobo,
                                //a.Referencia,
                                //a.Detalle,
                                //a.Contacto,
            
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult OrdenesPagoEnCajaUsandoDataset(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;


            int idproveedor;


            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var pendiente = "S"; //hay que usar S para traer solo lo pendiente

            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TX_EnCaja", "CA"); // "FI", "EN", "CA"
            // var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC,        "OrdenesPago_TT"); // "FI", "EN", "CA"


            IEnumerable<DataRow> Entidad = dt.AsEnumerable();


            try
            {
                idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)Membership.GetUser().ProviderUserKey));
                if (idproveedor > 0)
                {
                    string razonsocial = db.Proveedores.Find(idproveedor).RazonSocial;
                    Entidad = Entidad.Where(p => (string)p["Proveedor"].NullSafeToString() == razonsocial).AsQueryable();
                }

            }
            catch (Exception)
            {


            }



            int totalRecords = Entidad.Count();  // Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);



            var data = (from a in Entidad
                        select new
                        {
                            IdOrdenesPago = a[0],
                            IdOPComplementariaFF = a[1],
                            Numero = a[2],
                            Exterior = a[3],
                            FechaOrdenesPago = a[4],
                            Tipo = a[5],
                            Estado = a[6],
                            Proveedores = a[7],
                            NombreAnterior = a[8],
                            Monedas = a[9],
                            Efectivo = a[10],
                            Descuentos = a[11],
                            Valores = a[12],
                            Documentos = a[13],
                            Acreedores = a[14],
                            RetencionIVA = a[15],
                            RetencionGanancias = a[16],
                            RetencionIBrutos = a[17],
                            RetencionSUSS = a[18],
                            GastosGenerales = a[19],
                            DiferenciaBalanceo = a[20],
                            NumeroOrdenesPago = a[21],
                            CotizacionDolar = a[22],
                            Empleados = a[23],
                            Observaciones = a[24],
                            Obras = a[25],
                            TextoAuxiliar1 = a[26],
                            TextoAuxiliar2 = a[27],
                            TextoAuxiliar3 = a[28]



                        })
                //.Where(campo)
                //.OrderBy(sidx + " " + sord)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();


            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenesPago.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("EditExterno",new {id = a.IdOrdenesPago} ) + " target='' >Editar</>" 
                                 //+"|"+"<a href=../OrdenPago/EditExterno/" + a.IdOrdenesPago + "?code=1" + ">Detalles</a> "
                                 ,
                                                                
                                   "<a href="+ Url.Action("ImprimirRetenciones",new {id = a.IdOrdenesPago} ) + ">Emitir</a> ",
                                 a.IdOPComplementariaFF.NullSafeToString(),
                            a.Numero.NullSafeToString(),
                            //a.IdOrdenPago.NullSafeToString(),
                            a.Exterior.NullSafeToString(),
                            a.FechaOrdenesPago.NullSafeToString(),
                            a.Tipo.NullSafeToString(),
                            a.Estado.NullSafeToString(),
                            a.Proveedores.NullSafeToString(),  
                             a.NombreAnterior.NullSafeToString(),  
                            a.Monedas.NullSafeToString() ,  
                            a.Efectivo.NullSafeToString(),
                            a.Descuentos.NullSafeToString(),
                            a.Valores.NullSafeToString(),
                            a.Documentos.NullSafeToString(),
                            a.Acreedores.NullSafeToString(),
                            "",
"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IVA&Id=" + a.IdOrdenesPago + "'>" + a.RetencionIVA.NullSafeToString() + " </a> ",
"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Ganancias&Id=" + a.IdOrdenesPago + "'>" + a.RetencionGanancias.NullSafeToString() + "</a> ",
"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IIBB&Id=" + a.IdOrdenesPago + "'>" + a.RetencionIBrutos.NullSafeToString() + "</a> ",
"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Suss&Id=" + a.IdOrdenesPago + "'>" + a.RetencionSUSS.NullSafeToString() + "</a> ",
                           
           
                            a.GastosGenerales.NullSafeToString(),
                            a.DiferenciaBalanceo.NullSafeToString(),
                             a.NumeroOrdenesPago .NullSafeToString(),
                            a.CotizacionDolar.NullSafeToString(),
                             a.Empleados.NullSafeToString() ,
                            a.Observaciones.NullSafeToString(),
                             a.Obras.NullSafeToString() ,
                            a.TextoAuxiliar1.NullSafeToString(),
                            a.TextoAuxiliar2.NullSafeToString(),
                            // a.TextoAuxiliar3.NullSafeToString(),


                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Suss&Id=" + a.IdOrdenesPago + "'>Cert. SUSS</a> "
                                 +"|"+"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Ganancias&Id=" + a.IdOrdenesPago + "'>Cert. Ganancias</a> "
                                 +"|"+"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IVA&Id=" + a.IdOrdenesPago + "'>Cert. IVA</a> "
                                 +"|"+"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IIBB&Id=" + a.IdOrdenesPago + "'>Cert. IIBB</a> "

                                //a.IdOrdenPago.ToString(), 
                                //a.Numero.ToString(), 
                                //a.Orden.ToString(), 
                                //a.FechaIngreso.ToString(),
                                //a.Proveedor,
                                //a.Validez,
                                //a.Bonificacion.ToString(),
                                //a.PorcentajeIva1.ToString(),
                                //a.Moneda,
                                //a.Subtotal.ToString(),
                                //a.ImporteBonificacion.ToString(),
                                //a.ImporteIva1.ToString(),
                                //a.ImporteTotal.ToString(),
                                //a.PlazoEntrega,
                                //a.CondicionCompra,
                                //a.Garantia,
                                //a.LugarEntrega,
                                //a.Comprador,
                                //a.Aprobo,
                                //a.Referencia,
                                //a.Detalle,
                                //a.Contacto,
            
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual FileResult ImprimirRetenciones(int id) //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));

            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "CertificadoRetencionGanancias.docx";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 



            // Pronto.ERP.BO.Comparativa comp = ComparativaManager.GetItem(SC, id, true);

            EmisionCert();

            //ComparativaManager.ImpresionDeComparativaPorDLLconXML
            //OpenXML_Pronto.FacturaXML_DOCX(output, fac, SC);

            //var c = ComparativaXML_XLSX_MVC_ConTags(output, comp, SC, id);
            //c = null;
            //ComparativaManager.TraerPieDLL

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "CertificadoRetencionGanancias.docx");
        }





        public void EmisionCert()
        {
            //   Dim oW As Word.Application
            //   Dim oRs As ADOR.Recordset
            //   Dim mNumeroCertificado As Long, mIdProveedor As Long
            //   Dim mCopias As Integer
            //   Dim mFecha As Date
            //   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String
            //   Dim mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String, mPlantilla As String
            //   Dim mRetenido As Double, mCotMon As Double, mMontoOrigen As Double

            //   On Error GoTo Mal

            //   mPlantilla = glbPathPlantillas & "\CertificadoRetencionGanancias_" & glbEmpresaSegunString & ".dot"
            //   If Len(Dir(mPlantilla)) = 0 Then
            //      mPlantilla = glbPathPlantillas & "\CertificadoRetencionGanancias.dot"
            //      If Len(Dir(mPlantilla)) = 0 Then
            //         MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
            //         Exit Sub
            //      End If
            //   End If

            //   mCopias = 1
            //   mAux1 = BuscarClaveINI("Copias retenciones en op")
            //   If IsNumeric(mAux1) Then mCopias = Val(mAux1)

            //   Set oRs = Aplicacion.OrdenPago.TraerFiltrado("_PorId", mIdOrdenesPago)
            //   With oRs
            //      mComprobante = Format(.Fields("NumeroOrdenesPago").Value, "00000000")
            //      mIdProveedor = .Fields("IdProveedor").Value
            //      mCotMon = .Fields("CotizacionMoneda").Value
            //      mFecha = .Fields("FechaOrdenesPago").Value
            //      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
            //      .Close
            //   End With

            //   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
            //   If oRs.RecordCount > 0 Then
            //      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
            //      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
            //      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
            //      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
            //                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
            //      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
            //   End If
            //   oRs.Close
            //   Set oRs = Nothing

            //   Set oW = CreateObject("Word.Application")

            //   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenesPago)
            //   If oRs.Fields.Count > 0 Then
            //      If oRs.RecordCount > 0 Then
            //         oRs.MoveFirst
            //         Do While Not oRs.EOF
            //            If oRs.Fields("Tipo").Value = "Ganancias" And Not IsNull(oRs.Fields("Certif.Gan.").Value) Then
            //               mNumeroCertificado = oRs.Fields("Certif.Gan.").Value
            //               mMontoOrigen = oRs.Fields("Pago s/imp.").Value * mCotMon
            //               mRetenido = oRs.Fields("Retencion").Value * mCotMon

            //               With oW
            //                  .Visible = True
            //                  With .Documents.Add(mPlantilla)
            //                     oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
            //                     oW.ActiveDocument.FormFields("Fecha").Result = mFecha
            //                     oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
            //                     oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
            //                     oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
            //                     oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
            //                     oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
            //                     oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
            //                     oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
            //                     oW.ActiveDocument.FormFields("Regimen").Result = oRs.Fields("Categoria").Value
            //                     oW.ActiveDocument.FormFields("MontoOrigen").Result = Format(mMontoOrigen, "$ #,##0.00")
            //                     oW.ActiveDocument.FormFields("Retencion").Result = Format(mRetenido, "$ #,##0.00")
            //                     oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
            //                     mAux1 = BuscarClaveINI("Aclaracion para certificado de retencion de ganancias")
            //                     If Len(mAux1) > 0 Then
            //                        oW.ActiveDocument.FormFields("Aclaracion").Result = mAux1
            //                     End If
            //                  End With
            //               End With

            //               If mDestino = "Printer" Then
            //                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
            //                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
            //                  oW.Documents(1).PrintOut False, , , , , , , mCopias
            //                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
            //                  oW.Documents(1).Close False
            //               End If

            //            End If
            //            oRs.MoveNext
            //         Loop
            //      End If
            //   End If
            //   oRs.Close

        }







        //y por qué no llamar directamente al sp de detalle???????



        public virtual ActionResult DetOrdenesPago(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            var DetEntidad = db.DetalleOrdenesPagoes.Where(p => p.IdOrdenPago == IdOrdenesPago1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;




            var data = (from a in DetEntidad
                        select a
                // {
                // a.IdDetalleOrdenPago,
                //a.IdArticulo,
                //a.IdUnidad,
                //a.NumeroItem,
                //a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                //a.Cantidad,
                //a.Unidad.Abreviatura,
                //a.Articulo.Codigo,
                //a.Articulo.Descripcion,
                //a.Precio,
                //a.PorcentajeBonificacion,
                //a.ImporteBonificacion,
                //a.PorcentajeIva,
                //a.ImporteIva,
                //a.ImporteTotalItem,
                //a.FechaEntrega,
                //a.Observaciones,
                //a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                //NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                //a.Adjunto,
                //a.ArchivoAdjunto1,
                //a.ArchivoAdjunto2,
                //a.ArchivoAdjunto3
                //                }
        )
                .OrderBy(p => p.IdDetalleOrdenPago)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleOrdenPago.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetalleOrdenPago.ToString(), 
                                a.IdImputacion.ToString(), 
                                "0",//a.IdUnidad.ToString(),
                                "0",//a.NumeroItem.ToString(), 
                                "0",//a.NumeroObra,
                                "0",//a.Cantidad.ToString(),
                                "0",//a.Abreviatura,
                                (a.IdImputacion==-1) ? "PA" : 
                                    (db.TiposComprobantes.Where(y=>y.IdTipoComprobante==  
                                            (db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault()  ).IdTipoComp 
                                         ).FirstOrDefault() )  .DescripcionAb ,
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                      (a.IdImputacion==-1) ? "" : db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////

                                 //y por qué no llamar directamente al sp de detalle??????? 
                                 // como esta parte tiene más logica, la jqgrid podría llamar directo al store DetOrdenesPago_TXOrdenPago
                                
                                 (a.IdImputacion==-1) ? "" : 
                                
                                (
                                 
                                (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte== a.IdImputacion).FirstOrDefault().IdTipoComp != 16 ) ? 

                                 // comprobante proveedor

                                         db.ComprobantesProveedor.Where(x=>x.IdComprobanteProveedor == 
                                        (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte== a.IdImputacion).FirstOrDefault().IdComprobante)  )
                                    .FirstOrDefault().Letra.NullSafeToString() + " " +

                                db.ComprobantesProveedor.Where(x=>x.IdComprobanteProveedor == 
                                        (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte== a.IdImputacion).FirstOrDefault().IdComprobante)  )
                                    .FirstOrDefault().NumeroComprobante1.NullSafeToString() + " " +
    
                                        db.ComprobantesProveedor.Where(x=>x.IdComprobanteProveedor == 
                                        (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte== a.IdImputacion).FirstOrDefault().IdComprobante)  )
                                    .FirstOrDefault().NumeroComprobante2.NullSafeToString()
                                
                                    //
                                    :



                                 // orden de pago
                                 (a.IdImputacion==-1) ? "" : 
                                    (db.TiposComprobantes.Where(y=>y.IdTipoComprobante==  
                                            (db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault()  ).IdTipoComp 
                                         ).FirstOrDefault() )  .Descripcion + " " +
                                db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().NumeroComprobante.ToString() //a.Descripcion,

                                

                                ////cuenta corriente 
                                // (a.IdImputacion==-1) ? "" : 
                                //    (db.TiposComprobantes.Where(y=>y.IdTipoComprobante==  
                                //            (db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault()  ).IdTipoComp 
                                //         ).FirstOrDefault() )  .Descripcion + " " +
                                //db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().NumeroComprobante.ToString(), //a.Descripcion,

                                ) ,
 //                               idtipocomp!=16 && idtipocomp!=17 

 //                                Case When IsNull(cp.IdComprobanteProveedor,0)>0   
 //Then cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+  
 //  Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)  
 //When IsNull(OrdenesPago.IdOrdenPago,0)>0   
 //Then Substring('00000000',1,8-Len(Convert(varchar,OrdenesPago.NumeroOrdenPago)))+Convert(varchar,OrdenesPago.NumeroOrdenPago)  
 //Else Substring('00000000',1,8-Len(Convert(varchar,cc.NumeroComprobante)))+Convert(varchar,cc.NumeroComprobante)  
 //End as [Numero],  

 // LEFT OUTER JOIN CuentasCorrientesAcreedores cc ON cc.IdCtaCte=DetOP.IdImputacion  
//LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=cc.IdTipoComp  
//LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=cc.IdComprobante and cc.IdTipoComp<>17 and cc.IdTipoComp<>16  
//LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=cc.IdComprobante and (cc.IdTipoComp=17 or cc.IdTipoComp=16)  
 
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                ////////////////////////////////////////////////////////////////////////////////////////////////
                                  (a.IdImputacion==-1) ? "" :      db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),  
                                  " --",
                                a.Importe.ToString(), //a.Precio.ToString(), 
                                "saldo",
                                 "" , //importe iva
                                "s/impuesto",
                                "iva",
                                "totcompro",
                                "b/s",
                                "retiva",
                                "retiva en op",
                                "gravadoiva",
                                "ivamono"
                                //a.PorcentajeBonificacion.ToString(), 
                                //a.ImporteBonificacion.ToString(), 
                                //a.PorcentajeIva.ToString(), 
                                //a.ImporteIva.ToString(), 
                                //a.ImporteTotalItem.ToString(), 
                                //a.FechaEntrega.ToString(),
                                //a.Observaciones,
                                //a.NumeroRequerimiento.ToString(),
                                //a.NumeroItemRM.ToString(),
                                //a.ArchivoAdjunto1
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult DetOrdenesPagoValores(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            var DetEntidad = db.DetalleOrdenesPagoValores.Where(p => p.IdOrdenPago == IdOrdenesPago1).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = DetEntidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in DetEntidad
                        select a
                        )
                        .OrderBy(p => p.IdDetalleOrdenPagoValores)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleOrdenPagoValores.ToString(),
                            cell = new string[] { 
                                string.Empty, 
                                a.IdDetalleOrdenPagoValores.ToString(), 
                                
                                
                                a.IdValor.NullSafeToString(),
                                a.IdTipoValor.NullSafeToString(),
                                
                                db.TiposComprobantes.Find(a.IdTipoValor  ).DescripcionAb.NullSafeToString(),  //a.Codigo,,  //a.NumeroItem.ToString(), 
                               a.NumeroInterno.NullSafeToString(),  //a.NumeroObra,
                                a.NumeroValor.NullSafeToString(), //a.Cantidad.ToString(),
                                   
                             a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),  //a.Abreviatura,
                                     a.IdCaja==null ? db.Bancos.Find(a.IdBanco).Nombre.NullSafeToString() :  db.Cajas.Find(a.IdCaja).Descripcion.NullSafeToString(),
                                         "-- ",
                                a.Importe.ToString(), //a.Precio.ToString(),  db.TiposComprobantes.Find(a.IdTipoValor  ).Descripcion.NullSafeToString(),  //a.Codigo,
                               " ",
                               db.TiposComprobantes.Find(a.IdTipoValor  ).Descripcion.NullSafeToString() + " " +  db.Valores.Find(a.IdDetalleOrdenPagoValores).NumeroValor.NullSafeToString(),   //a.Descripcio
                                
                       
                                //a.PorcentajeBonificacion.ToString(), 
                                //a.ImporteBonificacion.ToString(), 
                                //a.PorcentajeIva.ToString(), 
                                //a.ImporteIva.ToString(), 
                                //a.ImporteTotalItem.ToString(), 
                                //a.FechaEntrega.ToString(),
                                //a.Observaciones,
                                //a.NumeroRequerimiento.ToString(),
                                //a.NumeroItemRM.ToString(),
                                //a.ArchivoAdjunto1

                             
                               
                              

                                
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetOrdenesPagoesSinFormato(int IdOrdenesPago)
        {
            var Det = db.DetalleOrdenesPagoes.Where(p => p.IdOrdenPago == IdOrdenesPago).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleOrdenPago,
                            //a.IdArticulo,
                            //a.IdUnidad,
                            //a.IdDetalleRequerimiento,
                            //a.NumeroItem,
                            //a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            //a.Cantidad,
                            //a.Unidad.Abreviatura,
                            //a.Articulo.Codigo,
                            //a.Articulo.Descripcion,
                            //a.FechaEntrega,
                            //a.Observaciones,
                            //a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            //NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            //a.Adjunto,
                            //a.ArchivoAdjunto1,
                            //a.ArchivoAdjunto2,
                            //a.ArchivoAdjunto3
                        })
                //.OrderBy(p => p.NumeroItem)
                        .ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRequerimiento, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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



        //public string BuscarOrden(int Numero)
        //{
        //    var OrdenesPago = db.OrdenesPago.Where(x => x.Numero == Numero).AsQueryable();
        //    var data = (from x in OrdenesPago select new { x.SubNumero }).OrderByDescending(p => p.SubNumero).FirstOrDefault();
        //    if (data != null)
        //        return data.SubNumero.ToString();
        //    else
        //        return "1";

        //}

        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }
    }


















}














//Public Sub EmisionCertificadoRetencionGanancias(ByVal mIdOrdenesPago As String, _
//                                                ByVal mDestino As String, _
//                                                ByVal mPrinter As String)

//   Dim oW As Word.Application
//   Dim oRs As ADOR.Recordset
//   Dim mNumeroCertificado As Long, mIdProveedor As Long
//   Dim mCopias As Integer
//   Dim mFecha As Date
//   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String
//   Dim mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String, mPlantilla As String
//   Dim mRetenido As Double, mCotMon As Double, mMontoOrigen As Double

//   On Error GoTo Mal

//   mPlantilla = glbPathPlantillas & "\CertificadoRetencionGanancias_" & glbEmpresaSegunString & ".dot"
//   If Len(Dir(mPlantilla)) = 0 Then
//      mPlantilla = glbPathPlantillas & "\CertificadoRetencionGanancias.dot"
//      If Len(Dir(mPlantilla)) = 0 Then
//         MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
//         Exit Sub
//      End If
//   End If

//   mCopias = 1
//   mAux1 = BuscarClaveINI("Copias retenciones en op")
//   If IsNumeric(mAux1) Then mCopias = Val(mAux1)

//   Set oRs = Aplicacion.OrdenPago.TraerFiltrado("_PorId", mIdOrdenesPago)
//   With oRs
//      mComprobante = Format(.Fields("NumeroOrdenesPago").Value, "00000000")
//      mIdProveedor = .Fields("IdProveedor").Value
//      mCotMon = .Fields("CotizacionMoneda").Value
//      mFecha = .Fields("FechaOrdenesPago").Value
//      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
//      .Close
//   End With

//   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
//   If oRs.RecordCount > 0 Then
//      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
//      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
//      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
//      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
//                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
//      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
//   End If
//   oRs.Close
//   Set oRs = Nothing

//   Set oW = CreateObject("Word.Application")

//   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenesPago)
//   If oRs.Fields.Count > 0 Then
//      If oRs.RecordCount > 0 Then
//         oRs.MoveFirst
//         Do While Not oRs.EOF
//            If oRs.Fields("Tipo").Value = "Ganancias" And Not IsNull(oRs.Fields("Certif.Gan.").Value) Then
//               mNumeroCertificado = oRs.Fields("Certif.Gan.").Value
//               mMontoOrigen = oRs.Fields("Pago s/imp.").Value * mCotMon
//               mRetenido = oRs.Fields("Retencion").Value * mCotMon

//               With oW
//                  .Visible = True
//                  With .Documents.Add(mPlantilla)
//                     oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
//                     oW.ActiveDocument.FormFields("Fecha").Result = mFecha
//                     oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
//                     oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
//                     oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
//                     oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
//                     oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
//                     oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
//                     oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
//                     oW.ActiveDocument.FormFields("Regimen").Result = oRs.Fields("Categoria").Value
//                     oW.ActiveDocument.FormFields("MontoOrigen").Result = Format(mMontoOrigen, "$ #,##0.00")
//                     oW.ActiveDocument.FormFields("Retencion").Result = Format(mRetenido, "$ #,##0.00")
//                     oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
//                     mAux1 = BuscarClaveINI("Aclaracion para certificado de retencion de ganancias")
//                     If Len(mAux1) > 0 Then
//                        oW.ActiveDocument.FormFields("Aclaracion").Result = mAux1
//                     End If
//                  End With
//               End With

//               If mDestino = "Printer" Then
//                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
//                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
//                  oW.Documents(1).PrintOut False, , , , , , , mCopias
//                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
//                  oW.Documents(1).Close False
//               End If

//            End If
//            oRs.MoveNext
//         Loop
//      End If
//   End If
//   oRs.Close

//   oW.Selection.HomeKey wdStory

//Mal:

//   If mDestino = "Printer" Then oW.Quit
//   Set oW = Nothing
//   Set oRs = Nothing

//End Sub

//Public Sub EmisionCertificadoRetencionIIBB(ByVal mIdOrdenesPago As String, _
//                                                ByVal mDestino As String, _
//                                                ByVal mPrinter As String)

//   Dim oW As Word.Application
//   Dim cALetra As New clsNum2Let
//   Dim oRs As ADOR.Recordset
//   Dim oRsAux As ADOR.Recordset
//   Dim mNumeroCertificado As Long, mIdProveedor As Long
//   Dim mCopias As Integer
//   Dim mFecha As Date
//   Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String, mProvincia As String
//   Dim mPrinterAnt As String, mIBNumeroInscripcion As String, mAux1 As String, mPlantilla As String, mPlantilla1 As String
//   Dim mCodPos As String, mImporteLetras As String, mAnulada As String
//   Dim mRetenido As Double, mRetencionAdicional As Double, mCotMon As Double

//   On Error GoTo Mal

//   mCopias = 1
//   mAux1 = BuscarClaveINI("Copias retenciones en op")
//   If IsNumeric(mAux1) Then mCopias = Val(mAux1)

//   Set oRs = Aplicacion.OrdenPago.TraerFiltrado("_PorId", mIdOrdenesPago)
//   With oRs
//      mComprobante = Format(.Fields("NumeroOrdenesPago").Value, "00000000")
//      mIdProveedor = .Fields("IdProveedor").Value
//      mCotMon = .Fields("CotizacionMoneda").Value
//      mFecha = .Fields("FechaOrdenesPago").Value
//      If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
//      .Close
//   End With

//   Set oRs = Aplicacion.Proveedores.TraerFiltrado("_ConDatos", mIdProveedor)
//   If oRs.RecordCount > 0 Then
//      mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
//      mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
//      If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
//      mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
//                           Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
//      mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
//      mIBNumeroInscripcion = IIf(IsNull(oRs.Fields("IBNumeroInscripcion").Value), "", oRs.Fields("IBNumeroInscripcion").Value)
//      mCodPos = IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value)
//'      If Not IsNull(oRs.Fields("PlantillaRetencionIIBB").Value) Then
//'         If Len(RTrim(oRs.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
//'            mPlantilla = oRs.Fields("PlantillaRetencionIIBB").Value
//'         End If
//'      End If
//   End If
//   oRs.Close
//   Set oRs = Nothing

//   Set oW = CreateObject("Word.Application")

//   Set oRs = Aplicacion.TablasGenerales.TraerFiltrado("DetOrdenesPagoImpuestos", "OrdenPago", mIdOrdenesPago)
//   If oRs.Fields.Count > 0 Then
//      If oRs.RecordCount > 0 Then
//         oRs.MoveFirst
//         Do While Not oRs.EOF
//            If oRs.Fields("Tipo").Value = "I.Brutos" And _
//                  Not IsNull(oRs.Fields("Certif.IIBB").Value) Then

//               mNumeroCertificado = oRs.Fields("Certif.IIBB").Value
//               mRetenido = oRs.Fields("Retencion").Value * mCotMon
//               mRetencionAdicional = IIf(IsNull(oRs.Fields("Impuesto adic.").Value), 0, oRs.Fields("Impuesto adic.").Value) * mCotMon

//               mPlantilla = "CertificadoRetencionIIBB.dot"
//               Set oRsAux = Aplicacion.IBCondiciones.TraerFiltrado("_IdCuentaPorProvincia", oRs.Fields("IdTipoImpuesto").Value)
//               If oRsAux.RecordCount > 0 Then
//                  If Not IsNull(oRsAux.Fields("PlantillaRetencionIIBB").Value) Then
//                     If Len(RTrim(oRsAux.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
//                        mPlantilla = oRsAux.Fields("PlantillaRetencionIIBB").Value
//                     End If
//                  End If
//               End If
//               oRsAux.Close
//               mPlantilla1 = mId(mPlantilla, 1, Len(mPlantilla) - 4)
//               mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & "_" & glbEmpresaSegunString & ".dot"
//               If Len(Dir(mPlantilla)) = 0 Then
//                  mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & ".dot"
//                  If Len(Dir(mPlantilla)) = 0 Then
//                     MsgBox "Plantilla " & mPlantilla & " inexistente", vbExclamation
//                     Exit Sub
//                  End If
//               End If

//               With oW
//                  .Visible = True
//                  With .Documents.Add(mPlantilla)

//                     If InStr(1, mPlantilla, "Salta") = 0 Then
//                        oW.ActiveDocument.FormFields("NumeroCertificado").Result = Format(mNumeroCertificado, "00000000")
//                        oW.ActiveDocument.FormFields("Fecha").Result = mFecha
//                        oW.ActiveDocument.FormFields("NombreAgente").Result = glbEmpresa
//                        oW.ActiveDocument.FormFields("CuitAgente").Result = glbCuit
//                        oW.ActiveDocument.FormFields("DomicilioAgente").Result = glbDireccion & " " & glbLocalidad & " " & glbProvincia
//                        oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
//                        oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
//                        oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
//                        oW.ActiveDocument.FormFields("NumeroInscripcion").Result = mIBNumeroInscripcion
//                        oW.ActiveDocument.FormFields("Anulada").Result = mAnulada

//                        oW.Selection.Goto What:=wdGoToBookmark, Name:="DetalleComprobantes"
//                        oW.Selection.MoveDown Unit:=wdLine
//                        oW.Selection.MoveLeft Unit:=wdCell
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & oRs.Fields("Categoria").Value
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Pagos mes").Value, "#,##0.00")
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & Format(oRs.Fields("Ret. mes").Value, "#,##0.00")
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & oRs.Fields("% a tomar s/base").Value
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & oRs.Fields("Alicuota.IIBB").Value
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & Format(mRetenido - mRetencionAdicional, "#,##0.00")
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & oRs.Fields("% adic.").Value
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & Format(mRetencionAdicional, "#,##0.00")
//                        oW.Selection.MoveRight Unit:=wdCell
//                        oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")

//                        oW.Selection.Goto What:=wdGoToBookmark, Name:="TotalRetencion"
//                        oW.Selection.MoveRight Unit:=wdCell, Count:=2
//                        oW.Selection.TypeText Text:="" & Format(mRetenido, "#,##0.00")

//                     ElseIf InStr(1, mPlantilla, "Salta") > 0 Then
//                        cALetra.Numero = mRetenido
//                        mImporteLetras = cALetra.ALetra
//                        oW.ActiveDocument.FormFields("NombreSujeto1").Result = mNombreSujeto
//                        oW.ActiveDocument.FormFields("CuitSujeto1").Result = mCuitSujeto
//                        oW.ActiveDocument.FormFields("DomicilioSujeto1").Result = mDomicilioSujeto
//                        oW.ActiveDocument.FormFields("CodigoPostal1").Result = mCodPos
//                        oW.ActiveDocument.FormFields("Monto1").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
//                        oW.ActiveDocument.FormFields("Alicuota1").Result = oRs.Fields("Alicuota.IIBB").Value
//                        oW.ActiveDocument.FormFields("Retencion1").Result = mRetenido
//                        oW.ActiveDocument.FormFields("ImporteEnLetras1").Result = mImporteLetras
//                        oW.ActiveDocument.FormFields("Fecha1").Result = mFecha

//                        oW.ActiveDocument.FormFields("NombreSujeto2").Result = mNombreSujeto
//                        oW.ActiveDocument.FormFields("CuitSujeto2").Result = mCuitSujeto
//                        oW.ActiveDocument.FormFields("DomicilioSujeto2").Result = mDomicilioSujeto
//                        oW.ActiveDocument.FormFields("CodigoPostal2").Result = mCodPos
//                        oW.ActiveDocument.FormFields("Monto2").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
//                        oW.ActiveDocument.FormFields("Alicuota2").Result = oRs.Fields("Alicuota.IIBB").Value
//                        oW.ActiveDocument.FormFields("Retencion2").Result = mRetenido
//                        oW.ActiveDocument.FormFields("ImporteEnLetras2").Result = mImporteLetras
//                        oW.ActiveDocument.FormFields("Fecha2").Result = mFecha

//                        oW.ActiveDocument.FormFields("NombreSujeto3").Result = mNombreSujeto
//                        oW.ActiveDocument.FormFields("CuitSujeto3").Result = mCuitSujeto
//                        oW.ActiveDocument.FormFields("DomicilioSujeto3").Result = mDomicilioSujeto
//                        oW.ActiveDocument.FormFields("CodigoPostal3").Result = mCodPos
//                        oW.ActiveDocument.FormFields("Monto3").Result = Format(oRs.Fields("Pago s/imp.").Value * mCotMon, "#,##0.00")
//                        oW.ActiveDocument.FormFields("Alicuota3").Result = oRs.Fields("Alicuota.IIBB").Value
//                        oW.ActiveDocument.FormFields("Retencion3").Result = mRetenido
//                        oW.ActiveDocument.FormFields("ImporteEnLetras3").Result = mImporteLetras
//                        oW.ActiveDocument.FormFields("Fecha3").Result = mFecha

//                     End If

//                  End With
//               End With

//               If mDestino = "Printer" Then
//                  mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
//                  If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
//                  oW.Documents(1).PrintOut False, , , , , , , mCopias
//                  If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
//                  oW.Documents(1).Close False
//               End If

//            End If
//            oRs.MoveNext
//         Loop
//      End If
//   End If
//   oRs.Close

//   oW.Selection.HomeKey wdStory

//Mal:

//   If mDestino = "Printer" Then oW.Quit
//   Set oW = Nothing
//   Set oRs = Nothing
//   Set oRsAux = Nothing
//   Set cALetra = Nothing

//End Sub
