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
        }

        public virtual ActionResult DetOrdenesPago(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            //var Det = db.DetalleOrdenesPagoes.Where(p => p.IdOrdenPago == IdOrdenesPago1 || IdOrdenesPago1 == -1).AsQueryable();
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //var data = (from a in Det 
            //            from b in db.CuentasCorrientesAcreedores.Where(c => c.IdCtaCte == a.IdImputacion).DefaultIfEmpty() 
            //            from c in db.ComprobantesProveedor.Where(p => p.IdComprobanteProveedor == b.IdComprobante && b.IdTipoComp != 16 && b.IdTipoComp != 17).DefaultIfEmpty()
            //            from d in db.TiposComprobantes.Where(t => t.IdTipoComprobante == b.IdTipoComp).DefaultIfEmpty()
            //            from e in db.Proveedores.Where(u => u.IdProveedor == c.IdProveedor).DefaultIfEmpty()
            //            from f in db.DetalleOrdenesPagoes.Where(v => v.IdDetalleOrdenPago == c.IdDetalleOrdenPagoRetencionIVAAplicada).DefaultIfEmpty()
            //            from g in db.OrdenesPago.Where(w => w.IdOrdenPago == f.IdOrdenPago).DefaultIfEmpty()
            //            from h in db.OrdenesPago.Where(x => x.IdOrdenPago == c.IdOrdenPagoRetencionIva).DefaultIfEmpty()
            //            from i in db.IBCondiciones.Where(y => y.IdIBCondicion == c.IdIBCondicion).DefaultIfEmpty()
            //            select new
            //            { 
            //                a.IdDetalleOrdenPago,
            //                a.IdImputacion,
            //                Tipo = d != null ? d.DescripcionAb : "PA",
            //                Letra = c.Letra != null ? c.Letra : "",
            //                Numero1 = c.NumeroComprobante1 != null ? c.NumeroComprobante1.ToString() : "",
            //                Numero2 = c.NumeroComprobante2 != null ? c.NumeroComprobante2.ToString() : b.NumeroComprobante.ToString(),
            //                b.Fecha,
            //                b.ImporteTotal,
            //                b.Saldo,
            //                a.Importe,
            //                SinImpuestos = a.IdImputacion<=0 ? a.ImportePagadoSinImpuestos : (b.ImporteTotal != 0 ? a.Importe * c.TotalBruto / b.ImporteTotal : 0),
            //                IvaTotal = c.TotalIva1 * d.Coeficiente,
            //                TotalComprobante = c.TotalComprobante * d.Coeficiente,
            //                BienesYServicios = c.BienesOServicios != null ? c.BienesOServicios : e.BienesOServicios,
            //                ImporteRetencionIVA = a.ImporteRetencionIVA,
            //                NumeroOrdenPagoRetencionIVA = g != null ? g.NumeroOrdenPago : h.NumeroOrdenPago,
            //                c.IdTipoRetencionGanancia,
            //                c.IdIBCondicion,
            //                BaseCalculoIIBB = i.BaseCalculo == null || i.BaseCalculo == "SIN IMPUESTOS" ? "SIN IMPUESTOS" : "CON IMPUESTOS",
            //                b.FechaVencimiento,
            //                c.FechaComprobante,
            //                GravadoIVA = a.IdImputacion <= 0 ? a.ImportePagadoSinImpuestos : (b.ImporteTotal != 0 ? a.Importe * c.TotalBruto / b.ImporteTotal : 0),
            //                c.CotizacionMoneda,
            //                c.PorcentajeIVAParaMonotributistas,
            //                b.IdTipoComp,
            //                b.IdComprobante
            //            }).OrderBy(x => x.IdDetalleOrdenPago).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetOrdenesPago_TXOrdenPago", IdOrdenesPago1);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleOrdenPago = a[0],
                            IdImputacion = (a[2].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[2].NullSafeToString()),
                            Tipo = a[3],
                            Numero = a[4],
                            Fecha = a[5],
                            ImporteTotal = a[6],
                            Saldo = a[7],
                            Importe = a[8],
                            SinImpuestos = a[9],
                            IvaTotal = a[10],
                            TotalComprobante = a[11],
                            BienesYServicios = a[12],
                            ImporteRetencionIVA = a[13],
                            NumeroOrdenPagoRetencionIVA = a[14],
                            IdTipoRetencionGanancia = a[15],
                            IdIBCondicion = a[16],
                            BaseCalculoIIBB = a[17],
                            FechaVencimiento = a[18],
                            FechaComprobante = a[19],
                            GravadoIVA = a[20],
                            CotizacionMoneda = a[21],
                            PorcentajeIVAParaMonotributistas = a[22],
                            IdTipoComp = a[23],
                            IdComprobante = a[24],
                            CertificadoPoliza = a[25],
                            NumeroEndosoPoliza = a[26]
                        }).OrderBy(s => s.IdDetalleOrdenPago).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

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
                                a.IdTipoRetencionGanancia.ToString(), 
                                a.IdIBCondicion.ToString(), 
                                a.BaseCalculoIIBB.ToString(), 
                                a.CotizacionMoneda.ToString(), 
                                a.IdTipoComp.ToString(), 
                                a.IdComprobante.ToString(), 
                                a.Tipo.ToString(), 
                                a.Numero.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.ImporteTotal.ToString(),
                                a.Saldo.ToString(),
                                a.Importe.ToString(),
                                a.SinImpuestos.ToString(), 
                                a.IvaTotal.ToString(), 
                                a.TotalComprobante.ToString(), 
                                a.BienesYServicios.ToString(), 
                                a.ImporteRetencionIVA.ToString(), 
                                a.NumeroOrdenPagoRetencionIVA.ToString(), 
                                a.GravadoIVA.ToString(), 
                                a.PorcentajeIVAParaMonotributistas.ToString(), 
                                a.CertificadoPoliza.ToString(), 
                                a.NumeroEndosoPoliza.ToString(),
                                a.FechaVencimiento == null || a.FechaVencimiento.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy")
                                //(a.Letra != "" ? a.Letra + '-' : "") + (a.Numero1 != "" ? a.Numero1.PadLeft(4,'0') + '-' : "") + (a.Numero2 != "" ? a.Numero2.PadLeft(8,'0') : ""),
                                //(a.IdImputacion==-1) ? "PA" : (db.TiposComprobantes.Where(y=>y.IdTipoComprobante==(db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte==a.IdImputacion).FirstOrDefault()).IdTipoComp).FirstOrDefault()).DescripcionAb,
                                //(a.IdImputacion==-1) ? "" : 
                                //    ((db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte==a.IdImputacion).FirstOrDefault().IdTipoComp!=16 && db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte==a.IdImputacion).FirstOrDefault().IdTipoComp!=17) ? 
                                //        db.ComprobantesProveedor.Where(x=>x.IdComprobanteProveedor == (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte==a.IdImputacion).FirstOrDefault().IdComprobante)).FirstOrDefault().Letra.NullSafeToString() + " " +
                                //        db.ComprobantesProveedor.Where(x=>x.IdComprobanteProveedor == (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte==a.IdImputacion).FirstOrDefault().IdComprobante)).FirstOrDefault().NumeroComprobante1.NullSafeToString() + " " +
                                //        db.ComprobantesProveedor.Where(x=>x.IdComprobanteProveedor == (db.CuentasCorrientesAcreedores.Where(y=>y.IdCtaCte==a.IdImputacion).FirstOrDefault().IdComprobante)).FirstOrDefault().NumeroComprobante2.NullSafeToString()
                                //    :
                                //    (a.IdImputacion==-1) ? "" : db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().NumeroComprobante.ToString()),
                                //(a.IdImputacion==-1) ? "" : db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte==a.IdImputacion).FirstOrDefault().Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                //(a.IdImputacion==-1) ? "" : db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().ImporteTotal.ToString(),
                                //(a.IdImputacion==-1) ? "" : db.CuentasCorrientesAcreedores.Where(x=>x.IdCtaCte== a.IdImputacion).FirstOrDefault().Saldo.ToString(),
                                //a.Importe.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetOrdenesPagoValores(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            var Det = db.DetalleOrdenesPagoValores.Where(p => p.IdOrdenPago == IdOrdenesPago1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Cajas.Where(p => p.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from d in db.TarjetasCreditoes.Where(q => q.IdTarjetaCredito == a.IdTarjetaCredito).DefaultIfEmpty()
                        from e in db.Valores.Where(r => r.IdValor == a.IdValor).DefaultIfEmpty()
                        from f in db.TiposComprobantes.Where(s => s.IdTipoComprobante == a.IdTipoValor).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenPagoValores,
                            a.IdTipoValor,
                            a.IdBanco,
                            a.IdValor,
                            a.IdCuentaBancaria,
                            a.IdBancoChequera,
                            a.IdCaja,
                            a.IdTarjetaCredito,
                            Tipo = f.DescripcionAb != null ? f.DescripcionAb : "",
                            a.NumeroInterno,
                            a.NumeroValor,
                            a.FechaVencimiento,
                            Banco = b != null ? b.Nombre : "",
                            Caja = c != null ? c.Descripcion : "",
                            TarjetaCredito = d != null ? d.Nombre : "",
                            a.Importe,
                            a.Anulado
                        }).OrderBy(x => x.IdDetalleOrdenPagoValores).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

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
                            a.IdTipoValor.NullSafeToString(),
                            a.IdBanco.NullSafeToString(),
                            a.IdValor.NullSafeToString(),
                            a.IdCuentaBancaria.NullSafeToString(),
                            a.IdBancoChequera.NullSafeToString(),
                            a.IdCaja.NullSafeToString(),
                            a.IdTarjetaCredito.NullSafeToString(),
                            a.Tipo + (a.IdValor != null ? " (Terc.)" : "") + (a.Anulado == "SI" ? " AN" : ""),
                            a.NumeroInterno.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            (a.IdBanco != null ? a.Banco : "") + (a.IdCaja != null ? a.Caja : "") + (a.IdTarjetaCredito != null ? a.TarjetaCredito : ""),
                            //a.IdCaja==null ? db.Bancos.Find(a.IdBanco).Nombre.NullSafeToString() :  db.Cajas.Find(a.IdCaja).Descripcion.NullSafeToString(),
                            a.Importe.ToString(),
                            a.Anulado
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetOrdenesPagoCuentas(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetOrdenesPagoCuentas_TXOrdenPago", IdOrdenesPago1);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleOrdenPagoCuentas = a[0],
                            IdCuenta = (a[2].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[2].NullSafeToString()),
                            Codigo = a[3],
                            Cuenta = a[4],
                            Debe = a[5],
                            Haber = a[6]
                        }).OrderBy(s => s.IdDetalleOrdenPagoCuentas).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleOrdenPagoCuentas.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleOrdenPagoCuentas.ToString(), 
                            a.IdCuenta.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Cuenta.NullSafeToString(),
                            a.Debe.ToString(),
                            a.Haber.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetOrdenesPagoImpuestos(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetOrdenesPagoImpuestos_TXOrdenPago", IdOrdenesPago1);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleOrdenPagoImpuestos = a[0],
                            Tipo = a[2],
                            IdTipoImpuesto = (a[3].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[3].NullSafeToString()),
                            Categoria = a[4],
                            ImportePagadoSinImpuestos = a[5],
                            ImpuestoRetenido = a[6],
                            PagosMes = a[7],
                            RetencionesMes = a[8],
                            MinimoIIBB = a[9],
                            AlicuotaIIBB = a[10],
                            AlicuotaConvenioIIBB = a[11],
                            PorcentajeATomarSobreBase = a[12],
                            PorcentajeAdicional = a[13],
                            ImpuestoAdicional = a[14],
                            NumeroCertificadoRetencionGanancias = a[15],
                            NumeroCertificadoRetencionIIBB = a[16],
                            ImporteTotalFacturasMPagadasSujetasARetencion = a[17]
                        }).OrderBy(s => s.IdDetalleOrdenPagoImpuestos).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleOrdenPagoImpuestos.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleOrdenPagoImpuestos.ToString(), 
                            a.IdTipoImpuesto.NullSafeToString(),
                            a.Tipo.NullSafeToString(),
                            a.Categoria.NullSafeToString(),
                            a.ImportePagadoSinImpuestos.ToString(),
                            a.ImpuestoRetenido.ToString(),
                            a.PagosMes.ToString(),
                            a.RetencionesMes.ToString(),
                            a.MinimoIIBB.ToString(),
                            a.AlicuotaIIBB.ToString(),
                            a.AlicuotaConvenioIIBB.ToString(),
                            a.PorcentajeAdicional.ToString(),
                            a.ImpuestoAdicional.ToString(),
                            a.NumeroCertificadoRetencionGanancias.ToString(),
                            a.NumeroCertificadoRetencionIIBB.ToString(),
                            a.ImporteTotalFacturasMPagadasSujetasARetencion.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetOrdenesPagoRubrosContables(string sidx, string sord, int? page, int? rows, int? IdOrdenPago)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            var Det = db.DetalleOrdenesPagoRubrosContables.Where(p => p.IdOrdenPago == IdOrdenesPago1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenPagoRubrosContables,
                            a.IdRubroContable,
                            RubroContable = b.Descripcion != null ? b.Descripcion : "",
                            a.Importe
                        }).OrderBy(x => x.IdDetalleOrdenPagoRubrosContables).Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleOrdenPagoRubrosContables.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleOrdenPagoRubrosContables.ToString(), 
                            a.IdRubroContable.NullSafeToString(),
                            a.RubroContable.NullSafeToString(),
                            a.Importe.ToString()
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
        public void EditGridData(int? IdArticulo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

        protected override void Dispose(bool disposing)
        {
            if (db != null) db.Dispose();
            base.Dispose(disposing);
        }
    }

}
