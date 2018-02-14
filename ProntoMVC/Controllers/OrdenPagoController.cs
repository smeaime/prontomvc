using System;
using System.Collections.Generic;
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
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using System.Web.Security;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Newtonsoft.Json;

namespace ProntoMVC.Controllers
{
    public partial class OrdenPagoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.OPago)) throw new Exception("No tenés permisos");

            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
               !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
                ) throw new Exception("No tenés permisos");

            //var OrdenesPago = db.OrdenesPago.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual ViewResult IndexExterno()
        {
            //var OrdenesPago = db.OrdenesPago.Include(r => r.Condiciones_Compra).OrderBy(r => r.Numero);
            return View();
        }

        public virtual ActionResult EditExterno(int id)
        {
            if (!PuedeLeer(enumNodos.OPago)) throw new Exception("No tenés permisos");

            //if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
            //   !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
            //   ) throw new Exception("No tenés permisos");

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

                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
                if (OrdenPago.IdProveedor != idproveedor
                //     && !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                //!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador")
                    ) throw new Exception("No tenés permisos para esa Orden de Pago");


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

                CargarViewBag(OrdenPago);
                Session.Add("OrdenPago", OrdenPago);
                return View(OrdenPago);
            }
        }

        public virtual ActionResult Edit(int id)
        {
            if (!PuedeLeer(enumNodos.OPago)) throw new Exception("No tenés permisos");

            if (!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
               !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
               !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Compras")
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

                CargarViewBag(OrdenPago);
                Session.Add("OrdenPago", OrdenPago);
                return View(OrdenPago);
            }
        }

        public virtual ActionResult EditCC(int id)
        {
            if (id == -1)
            {
                OrdenPago OrdenPago = new OrdenPago();

                inic(ref OrdenPago);
                OrdenPago.Tipo = "CC";
                CargarViewBag(OrdenPago);
                return View(OrdenPago);
            }
            else
            {
                OrdenPago OrdenPago = db.OrdenesPago.Find(id);

                int idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
                if (OrdenPago.IdProveedor != idproveedor && !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
                    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador")) throw new Exception("Sólo podes acceder a OrdenesPago tuyos");
                try
                {
                    ViewBag.Proveedor = db.Proveedores.Find(OrdenPago.IdProveedor).RazonSocial;
                    CargarViewBag(OrdenPago);
                }
                catch (Exception e)
                {
                    ErrHandler.WriteError(e);
                }

                Session.Add("OrdenPago", OrdenPago);
                return View(OrdenPago);
            }
        }

        public virtual ActionResult EditFF(int id)
        {

            if (!PuedeLeer(enumNodos.OPago)) throw new Exception("No tenés permisos");

            if (id == -1)
            {
                OrdenPago OrdenPago = new OrdenPago();

                inic(ref OrdenPago);
                OrdenPago.Tipo = "FF";
                CargarViewBag(OrdenPago);
                return View(OrdenPago);
            }
            else
            {
                OrdenPago OrdenPago = db.OrdenesPago.Find(id);

                CargarViewBag(OrdenPago);
                return View(OrdenPago);
            }
        }

        public virtual ActionResult EditOT(int id)
        {
            if (!PuedeLeer(enumNodos.OPago)) throw new Exception("No tenés permisos");
            if (id == -1)
            {
                OrdenPago OrdenPago = new OrdenPago();

                inic(ref OrdenPago);
                OrdenPago.Tipo = "OT";
                CargarViewBag(OrdenPago);
                return View(OrdenPago);
            }
            else
            {
                OrdenPago OrdenPago = db.OrdenesPago.Find(id);

                CargarViewBag(OrdenPago);
                return View(OrdenPago);
            }
        }

        void inic(ref OrdenPago o)
        {
            Parametros parametros = db.Parametros.Find(1);

            Int32 mIdMonedaDolar;
            Int32 mIdMonedaEuro;

            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            o.NumeroOrdenPago = parametros.ProximaOrdenPago;
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            o.FechaIngreso = DateTime.Today;
            o.FechaOrdenPago = DateTime.Today;
            o.CotizacionMoneda = 1;

            Cotizacione Cotizaciones = db.Cotizaciones.Where(x => x.IdMoneda == mIdMonedaDolar && x.Fecha == DateTime.Today).FirstOrDefault();
            if (Cotizaciones != null) { o.CotizacionDolar = Cotizaciones.Cotizacion ?? 0; }

            Cotizaciones = db.Cotizaciones.Where(x => x.IdMoneda == mIdMonedaEuro && x.Fecha == DateTime.Today).FirstOrDefault();
            if (Cotizaciones != null) { o.CotizacionEuro = Cotizaciones.Cotizacion ?? 0; }
        }

        class DatosJson
        {
            public string campo1 { get; set; }
            public string campo2 { get; set; }
            public string campo3 { get; set; }
            public string campo4 { get; set; }
            public string campo5 { get; set; }
        }
        
        public virtual JsonResult Autorizaciones(int IdPedido)
        {
            var Autorizaciones = db.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.OrdenesPago, IdPedido);
            return Json(Autorizaciones, JsonRequestBehavior.AllowGet);
        }

        void CargarViewBag(OrdenPago o)
        {
            Int32 mIdTipoCuentaGrupoFF = 0;

            Parametros parametros = db.Parametros.Find(1);
            ViewBag.IdTipoComprobanteCajaEgresos = parametros.IdTipoComprobanteCajaEgresos;
            mIdTipoCuentaGrupoFF = parametros.IdTipoCuentaGrupoFF ?? 0;

            ViewBag.IdCondicionCompra = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPlazoEntrega = new SelectList(db.PlazosEntregas, "IdPlazoEntrega", "Descripcion");
            ViewBag.IdComprador = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdEmpleadoFF = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdEmpleadoFF);
            ViewBag.Proveedor = (db.Proveedores.Find(o.IdProveedor) ?? new Proveedor()).RazonSocial;
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion");
            ViewBag.IdIBCondicion = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion");
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdCuentaGasto = new SelectList(db.CuentasGastos.OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto);
            ViewBag.IdTipoCuentaGrupo = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.CantidadAutorizaciones = db.Autorizaciones_TX_CantidadAutorizaciones((int)Pronto.ERP.Bll.EntidadManager.EnumFormularios.OrdenesPago, 0, -1).Count();

            IEnumerable<SelectListItem> Cuentas;
            if (o.Tipo == "CC") { 
                Cuentas = (from x in db.Cuentas where x.IdCuenta == 0 select x).AsEnumerable().Select(x => new SelectListItem() { Text = x.Descripcion + " " + x.Codigo.ToString(), Value = x.IdCuenta.ToString() }); 
            }
            else
            {
                if (o.Tipo == "FF") {
                    Cuentas = (from x in db.Cuentas where x.IdTipoCuentaGrupo == mIdTipoCuentaGrupoFF select x).AsEnumerable().Select(x => new SelectListItem() { Text = x.Descripcion + " " + x.Codigo.ToString(), Value = x.IdCuenta.ToString() }); 
                }
                else { 
                    Cuentas = (from x in db.Cuentas where x.IdTipoCuenta == 2 select x).AsEnumerable().Select(x => new SelectListItem() { Text = x.Descripcion + " " + x.Codigo.ToString(), Value = x.IdCuenta.ToString() }); 
                }
            }
            ViewBag.IdCuenta = new SelectList(Cuentas, "Value", "Text", o.IdCuenta);
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

        public virtual ActionResult Anular(int id)
        {
            OrdenPago OrdenPago = db.OrdenesPago.Find(id);
            OrdenPago.Anulada = "OK";
            OrdenPago.FechaAnulacion = DateTime.Now;
            OrdenPago.IdUsuarioAnulo = 0;
            OrdenPago.MotivoAnulacion = "";
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public virtual FileResult ImprimirConPlantillaEXE_PDF(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.pdf";
            string plantilla = DirApp + "Documentos\\" + "OrdenPago_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "OrdenPago.pdf";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConPlantillaEXE(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.doc";
            string plantilla = DirApp + "Documentos\\" + "OrdenPago_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "OrdenPago.doc";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            object nulo = null;
            string baseP = this.HttpContext.Session["BasePronto"].ToString();
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf";
            string plantilla;
            plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "OrdenPago_" + baseP + ".dotm";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, "", nulo, nulo, output, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "OrdenPago.pdf");
        }

        public class OrdenesPago2
        {
            public int IdOrdenPago { get; set; }
            public int? IdOPComplementariaFF { get; set; }
            public int? NumeroOrdenPago { get; set; }
            public string Exterior { get; set; }
            public DateTime? FechaOrdenPago { get; set; }
            public string Tipo { get; set; }
            public string Anulada { get; set; }
            public string Estado { get; set; }
            public string Proveedor { get; set; }
            public string Cuenta { get; set; }
            public string Moneda { get; set; }
            public string Obra { get; set; }
            public decimal? Valores { get; set; }
            public decimal? Acreedores { get; set; }
            public decimal? RetencionIVA { get; set; }
            public decimal? RetencionGanancias { get; set; }
            public decimal? RetencionIBrutos { get; set; }
            public decimal? RetencionSUSS { get; set; }
            public decimal? DevolucionFF { get; set; }
            public decimal? DiferenciaBalanceo { get; set; }
            public string OPComplementariaFF { get; set; }
            public string DestinatarioFF { get; set; }
            public int? NumeroRendicionFF { get; set; }
            public string ConfirmacionAcreditacionFF { get; set; }
            public string ConceptoOPOtros { get; set; }
            public string Clasificacion { get; set; }
            public string Detalle { get; set; }
            public string Modalidad { get; set; }
            public string EnviarA { get; set; }
            public string Auxiliar { get; set; }
            public string Ingreso { get; set; }
            public DateTime? FechaIngreso { get; set; }
            public string Modifico { get; set; }
            public DateTime? FechaModifico { get; set; }
            public string Anulo { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string MotivoAnulacion { get; set; }
            public string Observaciones { get; set; }
            public decimal? CotizacionDolar { get; set; }
            public decimal? CotizacionEuro { get; set; }
        }

        public virtual JsonResult OrdenesPago_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            DateTime FechaDesde, FechaHasta;
            try
            {
                if (FechaInicial == "") FechaDesde = DateTime.MinValue;
                else FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaDesde = DateTime.MinValue;
            }

            try
            {
                if (FechaFinal == "") FechaHasta = DateTime.MaxValue;
                else FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
            }
            catch (Exception)
            {
                FechaHasta = DateTime.MaxValue;
            }

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in db.OrdenesPago
                        select new OrdenesPago2
                        {
                            IdOrdenPago = a.IdOrdenPago,
                            IdOPComplementariaFF = a.IdOPComplementariaFF,
                            NumeroOrdenPago = a.NumeroOrdenPago,
                            Exterior = a.Exterior,
                            FechaOrdenPago = a.FechaOrdenPago,
                            Tipo = a.Tipo,
                            Anulada = a.Anulada,
                            Estado = a.Estado,
                            Proveedor = a.Proveedore != null ? a.Proveedore.RazonSocial : "",
                            Cuenta = a.Cuenta != null ? a.Cuenta.Descripcion : "",
                            Moneda = a.Moneda != null ? a.Moneda.Abreviatura : "",
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            Valores = a.Valores,
                            Acreedores = a.Acreedores,
                            RetencionIVA = a.RetencionIVA,
                            RetencionGanancias = a.RetencionGanancias,
                            RetencionIBrutos = a.RetencionIBrutos,
                            RetencionSUSS = a.RetencionSUSS,
                            DevolucionFF = a.GastosGenerales,
                            DiferenciaBalanceo = a.DiferenciaBalanceo,
                            OPComplementariaFF = a.OrdenesPago2 != null ? a.OrdenesPago2.NumeroOrdenPago.ToString() : "",
                            DestinatarioFF = a.Empleado != null ? a.Empleado.Nombre : "",
                            NumeroRendicionFF = a.NumeroRendicionFF,
                            ConfirmacionAcreditacionFF = a.ConfirmacionAcreditacionFF,
                            ConceptoOPOtros = a.Concepto  != null ?  a.Concepto.Descripcion : "",
                            Clasificacion = a.Concepto1 != null ? a.Concepto1.Descripcion : "",
                            Detalle = a.Detalle,
                            Modalidad = a.TextoAuxiliar1,
                            EnviarA = a.TextoAuxiliar2,
                            Auxiliar = a.TextoAuxiliar3,
                            Ingreso = a.Empleado1  != null ? a.Empleado1.Nombre : "",
                            FechaIngreso = a.FechaIngreso,
                            Modifico = a.Empleado2 != null ? a.Empleado2.Nombre : "",
                            FechaModifico = a.FechaModifico,
                            Anulo = a.Empleado3 != null ? a.Empleado3.Nombre : "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion,
                            Observaciones = a.Observaciones,
                            CotizacionDolar = a.CotizacionDolar,
                            CotizacionEuro = a.CotizacionEuro,
                        }).Where(a => a.FechaOrdenPago >= FechaDesde && a.FechaOrdenPago <= FechaHasta).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<OrdenesPago2>
                                     (sidx, sord, page, rows, _search, filters, db, ref totalRecords, data);

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = page,
                records = totalRecords,
                rows = (from a in pagedQuery
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenPago.ToString(),
                            cell = new string[] {
                                a.Tipo=="CC" ? "<a href="+ Url.Action("EditCC",new {id = a.IdOrdenPago} ) + " target='' >Editar</>" : (a.Tipo=="FF" ? "<a href="+ Url.Action("EditFF",new {id = a.IdOrdenPago} ) + " target='' >Editar</>" : "<a href="+ Url.Action("EditOT",new {id = a.IdOrdenPago} ) + " target='' >Editar</>"),
                                "<a href="+ Url.Action("ImprimirConPlantillaEXE_PDF",new {id = a.IdOrdenPago} ) + ">Emitir</a> ",
                                "<a href="+ Url.Action("ImprimirRetenciones",new {id = a.IdOrdenPago} ) + ">Emitir retenciones</a> ",
                                a.IdOrdenPago.NullSafeToString(),
                                a.IdOPComplementariaFF.NullSafeToString(),
                                a.NumeroOrdenPago.NullSafeToString(),
                                a.Exterior.NullSafeToString(),
                                a.FechaOrdenPago.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.Estado.NullSafeToString(),
                                a.Proveedor.NullSafeToString(),  
                                a.Cuenta.NullSafeToString(),  
                                a.Moneda.NullSafeToString() ,  
                                a.Obra.NullSafeToString() ,  
                                a.Valores.NullSafeToString(),
                                a.Acreedores.NullSafeToString(),
                                a.RetencionIVA.NullSafeToString(),
                                a.RetencionGanancias.NullSafeToString(),
                                a.RetencionIBrutos.NullSafeToString(),
                                a.RetencionSUSS.NullSafeToString(),
                                a.DevolucionFF.NullSafeToString(),
                                a.DiferenciaBalanceo.NullSafeToString(),
                                a.OPComplementariaFF.NullSafeToString(),
                                a.DestinatarioFF.NullSafeToString(),
                                a.NumeroRendicionFF.NullSafeToString(),
                                a.ConfirmacionAcreditacionFF.NullSafeToString(),
                                a.ConceptoOPOtros.NullSafeToString(),
                                a.Clasificacion.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.Modalidad.NullSafeToString(),
                                a.EnviarA.NullSafeToString(),
                                a.Auxiliar.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.CotizacionDolar.NullSafeToString(),
                                a.CotizacionEuro.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }
        
        public virtual ActionResult OrdenesPago(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
            string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;
            int idproveedor;

            //var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            //var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TT"); // "FI", "EN", "CA"
            //IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data = (from a in db.OrdenesPago
                        from b in db.Proveedores.Where(o => o.IdProveedor == a.IdProveedor).DefaultIfEmpty()
                        from c in db.Cuentas.Where(p => p.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from d in db.Monedas.Where(q => q.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from e in db.Conceptos.Where(r => r.IdConcepto == a.IdConcepto).DefaultIfEmpty()
                        from f in db.Conceptos.Where(s => s.IdConcepto == a.IdConcepto2).DefaultIfEmpty()
                        from g in db.Obras.Where(u => u.IdObra == a.IdObra).DefaultIfEmpty()
                        from h in db.Empleados.Where(v => v.IdEmpleado == a.IdEmpleadoFF).DefaultIfEmpty()
                        from i in db.Empleados.Where(w => w.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from j in db.Empleados.Where(x => x.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from k in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulo).DefaultIfEmpty()
                        from l in db.OrdenesPago.Where(z => z.IdOrdenPago == a.IdOPComplementariaFF).DefaultIfEmpty()
                        select new
                        {
                            a.IdOrdenPago,
                            a.IdOPComplementariaFF,
                            a.NumeroOrdenPago,
                            a.Exterior,
                            FechaOrdenPago = a.FechaOrdenPago ?? DateTime.MinValue,
                            a.Tipo,
                            a.Anulada,
                            Estado = a.Estado == "CA" ? "En Caja" : (a.Estado == "FI" ? "A la firma" : (a.Estado == "EN" ? "Entregado" : (a.Estado == "CO" ? "Caja obra" : ""))),
                            Proveedor = b != null ? b.RazonSocial : "",
                            Cuenta = c != null ? c.Descripcion : "",
                            Moneda = d != null ? d.Abreviatura : "",
                            Obra = g != null ? g.NumeroObra : "",
                            a.Valores,
                            a.Acreedores,
                            a.RetencionIVA,
                            a.RetencionGanancias,
                            a.RetencionIBrutos,
                            a.RetencionSUSS,
                            DevolucionFF = a.GastosGenerales,
                            DiferenciaBalanceo = a.Tipo == "OT" ? "" : (a.Anulada == "SI" ? "" : a.DiferenciaBalanceo.ToString()),
                            OPComplementariaFF = l != null ? l.NumeroOrdenPago.ToString() : "",
                            DestinatarioFF = h != null ? h.Nombre : "",
                            a.NumeroRendicionFF,
                            a.ConfirmacionAcreditacionFF,
                            ConceptoOPOtros = e != null ? e.Descripcion : "",
                            Clasificacion = f != null ? f.Descripcion : "",
                            a.Detalle,
                            Modalidad = a.TextoAuxiliar1,
                            EnviarA = a.TextoAuxiliar2,
                            Auxiliar = a.TextoAuxiliar3,
                            Ingreso = i != null ? i.Nombre : "",
                            a.FechaIngreso,
                            Modifico = j != null ? j.Nombre : "",
                            a.FechaModifico,
                            Anulo = k != null ? k.Nombre : "",
                            a.FechaAnulacion,
                            a.MotivoAnulacion,
                            a.Observaciones,
                            a.CotizacionDolar,
                            a.CotizacionEuro
                        }).AsQueryable(); 

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaOrdenPago >= FechaDesde && a.FechaOrdenPago <= FechaHasta select a).AsQueryable();
            }
            
            idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
            if (idproveedor > 0)
            {
                string razonsocial = db.Proveedores.Find(idproveedor).RazonSocial;
                data = (from a in data where a.Proveedor.NullSafeToString() == razonsocial select a).AsQueryable();
                //Entidad = Entidad.Where(p => (string)p["Proveedor"].NullSafeToString() == razonsocial).AsQueryable();
            }

            int totalRecords = data.Count();  // Entidad1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaOrdenPago)
                        //.OrderByDescending(x => x.NumeroOrdenPago)
                        .Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdOrdenPago.ToString(),
                            cell = new string[] { 
                                a.Tipo=="CC" ? "<a href="+ Url.Action("EditCC",new {id = a.IdOrdenPago} ) + " target='' >Editar</>" : (a.Tipo=="FF" ? "<a href="+ Url.Action("EditFF",new {id = a.IdOrdenPago} ) + " target='' >Editar</>" : "<a href="+ Url.Action("EditOT",new {id = a.IdOrdenPago} ) + " target='' >Editar</>"),
                                "<a href="+ Url.Action("ImprimirRetenciones",new {id = a.IdOrdenPago} ) + ">Emitir</a> ",
                                a.IdOrdenPago.NullSafeToString(),
                                a.IdOPComplementariaFF.NullSafeToString(),
                                a.NumeroOrdenPago.NullSafeToString(),
                                a.Exterior.NullSafeToString(),
                                a.FechaOrdenPago.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.Estado.NullSafeToString(),
                                a.Proveedor.NullSafeToString(),  
                                a.Cuenta.NullSafeToString(),  
                                a.Moneda.NullSafeToString() ,  
                                a.Obra.NullSafeToString() ,  
                                a.Valores.NullSafeToString(),
                                a.Acreedores.NullSafeToString(),
                                a.RetencionIVA.NullSafeToString(),
                                a.RetencionGanancias.NullSafeToString(),
                                a.RetencionIBrutos.NullSafeToString(),
                                a.RetencionSUSS.NullSafeToString(),
                                a.DevolucionFF.NullSafeToString(),
                                a.DiferenciaBalanceo.NullSafeToString(),
                                a.OPComplementariaFF.NullSafeToString(),
                                a.DestinatarioFF.NullSafeToString(),
                                a.NumeroRendicionFF.NullSafeToString(),
                                a.ConfirmacionAcreditacionFF.NullSafeToString(),
                                a.ConceptoOPOtros.NullSafeToString(),
                                a.Clasificacion.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.Modalidad.NullSafeToString(),
                                a.EnviarA.NullSafeToString(),
                                a.Auxiliar.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion.NullSafeToString(),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.CotizacionDolar.NullSafeToString(),
                                a.CotizacionEuro.NullSafeToString()
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

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var pendiente = "S"; //hay que usar S para traer solo lo pendiente

            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TX_EnCaja", "CA"); // "FI", "EN", "CA"
            // var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC,        "OrdenesPago_TT"); // "FI", "EN", "CA"

            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            try
            {
                idproveedor = buscaridproveedorporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
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
                            NumeroOrdenPago = a[2],
                            PuntoVenta = a[4],
                            FechaOrdenesPago = a[6],
                            Tipo = a[7],
                            Estado = a[8],
                            Proveedores = a[9],
                            Cuenta = a[10],
                            Moneda = a[11],
                            Efectivo = a[12],
                            Descuentos = a[13],
                            Valores = a[14],
                            Documentos = a[15],
                            Acreedores = a[16],
                            RetencionIVA = a[18],
                            //RetencionIVA = (a[18].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[18].NullSafeToString()),
                            RetencionGanancias = a[19],
                            RetencionIBrutos = a[20],
                            RetencionSUSS = a[21],
                            DevolucionFondoFijo = a[22],
                            DiferenciaBalanceo = a[23],
                            OrdenesPagoComplementaria = a[24],
                            CotizacionDolar = a[25],
                            Observaciones = a[27],
                            Obra = a[28]
                        })
                //.Where(campo)
                //.OrderBy(sidx + " " + sord)
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
                            id = a.IdOrdenesPago.ToString(),
                            cell = new string[] { 
                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Orden%20Pago2&Id=" + a.IdOrdenesPago + "'>Editar</a> ",
                                //"<a href="+ Url.Action("EditExterno",new {id = a.IdOrdenesPago} ) + " target='' >Editar</>", 
                                 //+"|"+"<a href=../OrdenPago/EditExterno/" + a.IdOrdenesPago + "?code=1" + ">Detalles</a> "
                                "<a href="+ Url.Action("ImprimirRetenciones",new {id = a.IdOrdenesPago} ) + ">Emitir</a> ",
                                a.IdOPComplementariaFF.NullSafeToString(),
                                a.NumeroOrdenPago.NullSafeToString(),
                                a.IdOrdenesPago.NullSafeToString(),
                                //a.Exterior.NullSafeToString(),
                                a.FechaOrdenesPago.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.Estado.NullSafeToString(),
                                a.Proveedores.NullSafeToString(),  
                                a.Moneda.NullSafeToString() ,  
                                //a.Efectivo.NullSafeToString(),
                                //a.Descuentos.NullSafeToString(),
                                a.Valores.NullSafeToString(),
                                //a.Documentos.NullSafeToString(),
                                a.Acreedores.NullSafeToString(),
                                //(a.Letra != "" ? a.Letra + '-' : "") + (a.Numero1 != "" ? a.Numero1.PadLeft(4,'0') + '-' : "") + (a.Numero2 != "" ? a.Numero2.PadLeft(8,'0') : ""),
                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IVA&Id=" + a.IdOrdenesPago + "'>" + a.RetencionIVA.NullSafeToString() + " </a> ",
                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Ganancias&Id=" + a.IdOrdenesPago + "'>" + a.RetencionGanancias.NullSafeToString() + "</a> ",
                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IIBB&Id=" + a.IdOrdenesPago + "'>" + a.RetencionIBrutos.NullSafeToString() + "</a> ",
                                "<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Suss&Id=" + a.IdOrdenesPago + "'>" + a.RetencionSUSS.NullSafeToString() + "</a> ",
                                //a.GastosGenerales.NullSafeToString(),
                                //a.DiferenciaBalanceo.NullSafeToString(),
                                //a.NumeroOrdenesPago .NullSafeToString(),
                                a.CotizacionDolar.NullSafeToString(),
                                //a.Empleados.NullSafeToString() ,
                                a.Observaciones.NullSafeToString()
                                //a.Obras.NullSafeToString() ,
                                //a.TextoAuxiliar1.NullSafeToString(),
                                //a.TextoAuxiliar2.NullSafeToString(),
                                //// a.TextoAuxiliar3.NullSafeToString(),
                                //"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Suss&Id=" + a.IdOrdenesPago + "'>Cert. SUSS</a> "
                                // +"|"+"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20Ganancias&Id=" + a.IdOrdenesPago + "'>Cert. Ganancias</a> "
                                // +"|"+"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IVA&Id=" + a.IdOrdenesPago + "'>Cert. IVA</a> "
                                // +"|"+"<a href='"+ @Url.Content("~/") + "Reporte.aspx?ReportName=Certificado%20IIBB&Id=" + a.IdOrdenesPago + "'>Cert. IIBB</a> "
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual FileResult ImprimirRetenciones(int id) //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

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
            //            }).OrderBy(x => x.IdDetalleOrdenPago)
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
//.ToList();

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
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
                            ImportePagadoSinImpuestos = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
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
                            GravadoIVA = (a[20].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[20].NullSafeToString()),
                            CotizacionMoneda = a[21],
                            PorcentajeIVAParaMonotributistas = a[22],
                            IdTipoComp = a[23],
                            IdComprobante = a[24],
                            CertificadoPoliza = a[25],
                            NumeroEndosoPoliza = a[26],
                            CategoriaIIBB = a[27],
                            CategoriaGanancias = a[28]
                        }).OrderBy(s => s.IdDetalleOrdenPago)
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
                                Math.Round(a.ImportePagadoSinImpuestos, 2).ToString(), 
                                a.IvaTotal.ToString(), 
                                a.TotalComprobante.ToString(), 
                                a.BienesYServicios.ToString(), 
                                a.ImporteRetencionIVA.ToString(), 
                                a.NumeroOrdenPagoRetencionIVA.ToString(), 
                                Math.Round(a.GravadoIVA, 2).ToString(), 
                                a.PorcentajeIVAParaMonotributistas.ToString(), 
                                a.CertificadoPoliza.ToString(), 
                                a.NumeroEndosoPoliza.ToString(),
                                a.FechaVencimiento == null || a.FechaVencimiento.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.CategoriaIIBB.ToString(), 
                                a.CategoriaGanancias.ToString()
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
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from h in db.BancoChequeras.Where(u => u.IdBancoChequera == a.IdBancoChequera).DefaultIfEmpty()
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
                            a.Anulado,
                            CuentaBancaria = g != null ? g.Cuenta : "",
                            Chequera = h != null ? h.NumeroChequera.ToString() : "",
                            a.ChequesALaOrdenDe,
                            a.NoALaOrden
                        }).OrderBy(x => x.IdDetalleOrdenPagoValores)
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
                            (a.IdBanco != null ? a.Banco + " " + a.CuentaBancaria : "") + (a.IdCaja != null ? a.Caja : "") + (a.IdTarjetaCredito != null ? a.TarjetaCredito : ""),
                            //a.IdCaja==null ? db.Bancos.Find(a.IdBanco).Nombre.NullSafeToString() :  db.Cajas.Find(a.IdCaja).Descripcion.NullSafeToString(),
                            a.Importe.ToString(),
                            a.Chequera,
                            a.Anulado,
                            a.ChequesALaOrdenDe,
                            a.NoALaOrden
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

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            //var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetOrdenesPagoCuentas_TXOrdenPago", IdOrdenesPago1);
            //IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var Det = db.DetalleOrdenesPagoCuentas.Where(p => p.IdOrdenPago == IdOrdenesPago1).AsQueryable();

            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Det.AsEnumerable()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.DetalleCuentas.Where(o => o.IdCuenta == a.IdCuenta && o.FechaCambio > a.OrdenesPago.FechaOrdenPago).OrderByDescending(o => o.FechaCambio).DefaultIfEmpty()
                        from d in db.Cajas.Where(t => t.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from e in db.TarjetasCreditoes.Where(t => t.IdTarjetaCredito == a.IdTarjetaCredito).DefaultIfEmpty()
                        from f in db.Obras.Where(t => t.IdObra == a.IdObra).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from h in db.CuentasGastos.Where(t => t.IdCuentaGasto == a.IdCuentaGasto).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenPagoCuentas,
                            a.IdCuenta,
                            a.IdObra,
                            a.IdCuentaGasto,
                            a.IdCuentaBancaria,
                            a.IdCaja,
                            a.IdTarjetaCredito,
                            a.IdMoneda,
                            a.CotizacionMonedaDestino,
                            IdTipoCuentaGrupo = 0,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            CuentaBancaria = g != null ? g.Banco.Nombre + " " + g.Cuenta : "",
                            Caja = d != null ? d.Descripcion : "",
                            TarjetaCredito = e != null ? e.Nombre : "",
                            Obra = f != null ? f.Descripcion : "",
                            CuentaGasto = h != null ? h.Descripcion : "",
                            TipoCuentaGrupo = "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleOrdenPagoCuentas)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();


            //var data = (from a in Entidad
            //            select new
            //            {
            //                IdDetalleOrdenPagoCuentas = a[0],
            //                IdCuenta = (a[2].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[2].NullSafeToString()),
            //                Codigo = a[3],
            //                Cuenta = a[4],
            //                Debe = a[5],
            //                Haber = a[6]
            //            }).OrderBy(s => s.IdDetalleOrdenPagoCuentas)
            //.Skip((currentPage - 1) * pageSize).Take(pageSize)
            //.ToList();

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
                            a.IdObra.ToString(),
                            a.IdCuentaGasto.ToString(),
                            a.IdCuentaBancaria.ToString(),
                            a.IdCaja.ToString(),
                            a.IdTarjetaCredito.ToString(),
                            a.IdMoneda.ToString(),
                            a.CotizacionMonedaDestino.ToString(),
                            a.IdTipoCuentaGrupo.ToString(),
                            a.Codigo.NullSafeToString(),
                            a.Cuenta.NullSafeToString(),
                            a.Debe.ToString(),
                            a.Haber.ToString(),
                            a.CuentaBancaria.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            a.TarjetaCredito.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.CuentaGasto.NullSafeToString(),
                            a.TipoCuentaGrupo.NullSafeToString()
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

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetOrdenesPagoImpuestos_TXOrdenPago", IdOrdenesPago1);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdDetalleOrdenPagoImpuestos = a[0],
                            TipoImpuesto = a[2],
                            IdTipoRetencionGanancia = (a[2].NullSafeToString() == "Ganancias") ? Convert.ToInt32(a[3].NullSafeToString()) : 0,
                            IdIBCondicion = (a[2].NullSafeToString() == "I.Brutos") ? Convert.ToInt32(a[3].NullSafeToString()) : 0,
                            IdTipoImpuesto = (a[3].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[3].NullSafeToString()),
                            Categoria = a[4],
                            ImportePagado = a[5],
                            ImpuestoRetenido = a[6],
                            PagosMes = a[7],
                            RetencionesMes = a[8],
                            MinimoIIBB = a[9],
                            AlicuotaAplicada = a[10],
                            AlicuotaConvenioAplicada = a[11],
                            PorcentajeATomarSobreBase = a[12],
                            PorcentajeAdicional = a[13],
                            ImpuestoAdicional = a[14],
                            NumeroCertificadoRetencionGanancias = a[15],
                            NumeroCertificadoRetencionIIBB = a[16],
                            ImporteTotalFacturasMPagadasSujetasARetencion = a[17]
                        }).OrderBy(s => s.IdDetalleOrdenPagoImpuestos)
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
                            id = a.IdDetalleOrdenPagoImpuestos.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleOrdenPagoImpuestos.ToString(), 
                            a.IdTipoRetencionGanancia.NullSafeToString(),
                            a.IdIBCondicion.NullSafeToString(),
                            a.IdTipoImpuesto.NullSafeToString(),
                            a.TipoImpuesto.NullSafeToString(),
                            a.Categoria.NullSafeToString(),
                            a.ImportePagado.ToString(),
                            a.ImpuestoRetenido.ToString(),
                            a.PagosMes.ToString(),
                            a.RetencionesMes.ToString(),
                            a.MinimoIIBB.ToString(),
                            a.AlicuotaAplicada.ToString(),
                            a.AlicuotaConvenioAplicada.ToString(),
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
                        }).OrderBy(x => x.IdDetalleOrdenPagoRubrosContables)
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

        public virtual ActionResult DetOrdenesPagoGastosFF(string sidx, string sord, int? page, int? rows, int? IdOrdenPago, int? IdOPComplementariaFF, int? IdMonedaOP)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            int IdOPComplementariaFF1 = IdOPComplementariaFF ?? 0;
            int IdMonedaOP1 = IdMonedaOP ?? 1;
            var Det = db.ComprobantesProveedor.Where(p => (p.IdProveedor ?? 0) == 0 && (p.IdOrdenPago == IdOrdenesPago1 || p.IdOrdenPago == IdOPComplementariaFF1)).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            int mIdMonedaPesos = 1;
            int mIdMonedaDolar = 0;
            int mIdMonedaEuro = 0;

            Parametros parametros = db.Parametros.Find(1);
            mIdMonedaPesos = parametros.IdMoneda ?? 1;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            var data = (from a in Det
                        from b in db.TiposComprobantes.Where(o => o.IdTipoComprobante == a.IdTipoComprobante).DefaultIfEmpty()
                        from c in db.Obras.Where(p => p.IdObra == (a.IdObra ?? 0)).DefaultIfEmpty()
                        from d in db.Cuentas.Where(q => q.IdCuenta == (a.IdCuenta ?? 0)).DefaultIfEmpty()
                        select new
                        {
                            a.IdComprobanteProveedor,
                            TipoComprobante = b != null ? b.DescripcionAb : "",
                            a.NumeroReferencia,
                            a.Letra,
                            a.NumeroComprobante1,
                            a.NumeroComprobante2,
                            Cuenta = d != null ? d.Descripcion : "",
                            a.FechaComprobante,
                            a.FechaVencimiento,
                            Obra = d != null ? c.NumeroObra : "",
                            a.NumeroRendicionFF,
                            Subtotal = a.IdMoneda == IdMonedaOP1 ? a.TotalBruto * b.Coeficiente : (IdMonedaOP1 == mIdMonedaPesos ? a.TotalBruto * b.Coeficiente * a.CotizacionMoneda : (IdMonedaOP1 == mIdMonedaDolar && (a.CotizacionDolar ?? 0) != 0 ? a.TotalBruto * b.Coeficiente * a.CotizacionMoneda / a.CotizacionDolar : 0)),
                            Iva = a.IdMoneda == IdMonedaOP1 ? a.TotalIva1 * b.Coeficiente : (IdMonedaOP1 == mIdMonedaPesos ? a.TotalIva1 * b.Coeficiente * a.CotizacionMoneda : (IdMonedaOP1 == mIdMonedaDolar && (a.CotizacionDolar ?? 0) != 0 ? a.TotalIva1 * b.Coeficiente * a.CotizacionMoneda / a.CotizacionDolar : 0)),
                            Total = a.IdMoneda == IdMonedaOP1 ? a.TotalComprobante * b.Coeficiente : (IdMonedaOP1 == mIdMonedaPesos ? a.TotalComprobante * b.Coeficiente * a.CotizacionMoneda : (IdMonedaOP1 == mIdMonedaDolar && (a.CotizacionDolar ?? 0) != 0 ? a.TotalComprobante * b.Coeficiente * a.CotizacionMoneda / a.CotizacionDolar : 0))
                        }).OrderBy(x => x.IdComprobanteProveedor)
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
                            id = a.IdComprobanteProveedor.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdComprobanteProveedor.ToString(), 
                            a.TipoComprobante.NullSafeToString(),
                            a.NumeroReferencia.ToString(),
                            a.Letra + '-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-' + a.NumeroComprobante2.NullSafeToString().PadLeft(8,'0'),
                            a.FechaComprobante == null ? "" : a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.NumeroRendicionFF.ToString(),
                            a.Subtotal.ToString(),
                            a.Iva.ToString(),
                            a.Total.ToString(),
                            a.Cuenta.NullSafeToString(),
                            a.Obra.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public virtual JsonResult GastosFFPendientes(int? IdOrdenPago, int? IdOPComplementariaFF, int? IdMonedaOP, int? NumeroRendicionFF, int? IdCuentaFF)
        {
            int IdOrdenesPago1 = IdOrdenPago ?? 0;
            int IdOPComplementariaFF1 = IdOPComplementariaFF ?? 0;
            int IdMonedaOP1 = IdMonedaOP ?? 1;
            int NumeroRendicionFF1 = NumeroRendicionFF ?? 0;
            int IdCuentaFF1 = IdCuentaFF ?? 0;
            
            int mIdMonedaPesos = 1;
            int mIdMonedaDolar = 0;
            int mIdMonedaEuro = 0;

            Parametros parametros = db.Parametros.Find(1);
            mIdMonedaPesos = parametros.IdMoneda ?? 1;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            var Det = db.ComprobantesProveedor.Where(p => (p.IdProveedor ?? 0) == 0 && (p.Confirmado ?? "") != "NO" && (p.IdCuenta ?? 0) != 0 && (p.IdOrdenPago == IdOrdenesPago1 || p.IdOrdenPago == IdOPComplementariaFF1 || (p.IdOrdenPago ?? 0) == 0) && (NumeroRendicionFF1 <= 0 || p.NumeroRendicionFF == NumeroRendicionFF1) && (IdCuentaFF1 <= 0 || p.IdCuenta == IdCuentaFF1)).AsQueryable();

            var data = (from a in Det.ToList()
                        from b in db.TiposComprobantes.Where(o => o.IdTipoComprobante == a.IdTipoComprobante).DefaultIfEmpty()
                        from c in db.Obras.Where(p => p.IdObra == (a.IdObra ?? 0)).DefaultIfEmpty()
                        from d in db.Cuentas.Where(q => q.IdCuenta == (a.IdCuenta ?? 0)).DefaultIfEmpty()
                        select new
                        {
                            a.IdComprobanteProveedor,
                            TipoComprobante = b != null ? b.DescripcionAb : "",
                            a.NumeroReferencia,
                            Numero = a.Letra + '-' + a.NumeroComprobante1.NullSafeToString().PadLeft(4,'0') + '-' + a.NumeroComprobante2.NullSafeToString().PadLeft(8,'0'),
                            Cuenta = d != null ? d.Descripcion : "",
                            FechaComprobante = a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            FechaVencimiento = a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            Obra = d != null ? c.NumeroObra : "",
                            a.NumeroRendicionFF,
                            Subtotal = a.IdMoneda == IdMonedaOP1 ? a.TotalBruto * b.Coeficiente : (IdMonedaOP1 == mIdMonedaPesos ? a.TotalBruto * b.Coeficiente * a.CotizacionMoneda : (IdMonedaOP1 == mIdMonedaDolar && (a.CotizacionDolar ?? 0) != 0 ? a.TotalBruto * b.Coeficiente * a.CotizacionMoneda / a.CotizacionDolar : 0)),
                            Iva = a.IdMoneda == IdMonedaOP1 ? a.TotalIva1 * b.Coeficiente : (IdMonedaOP1 == mIdMonedaPesos ? a.TotalIva1 * b.Coeficiente * a.CotizacionMoneda : (IdMonedaOP1 == mIdMonedaDolar && (a.CotizacionDolar ?? 0) != 0 ? a.TotalIva1 * b.Coeficiente * a.CotizacionMoneda / a.CotizacionDolar : 0)),
                            Total = a.IdMoneda == IdMonedaOP1 ? a.TotalComprobante * b.Coeficiente : (IdMonedaOP1 == mIdMonedaPesos ? a.TotalComprobante * b.Coeficiente * a.CotizacionMoneda : (IdMonedaOP1 == mIdMonedaDolar && (a.CotizacionDolar ?? 0) != 0 ? a.TotalComprobante * b.Coeficiente * a.CotizacionMoneda / a.CotizacionDolar : 0))
                        }).OrderBy(x => x.IdComprobanteProveedor).ToList();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetOrdenesPagoesSinFormato(int IdOrdenesPago)
        {
            var Det = db.DetalleOrdenesPagoes.Where(p => p.IdOrdenPago == IdOrdenesPago).AsQueryable();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleOrdenPago,
                        })
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

        [HttpPost]
        public virtual JsonResult CalcularRetenciones(OrdenPago OrdenPago)
        {
            List<DetalleOrdenesPagoImpuesto> impuestos = new List<DetalleOrdenesPagoImpuesto>();
            List<DetalleOrdenesPagoImpuesto> impuestos2 = new List<DetalleOrdenesPagoImpuesto>();
            DetalleOrdenesPagoImpuesto ri;

            Int32 mIdProveedor = 0;
            Int32 mIdOrdenPago = 0;
            Int32 mIdMoneda = 0;
            Int32 mIdMonedaPesos = 0;
            Int32 mIdTipoRetencionGanancia = 0;
            Int32 mIdIBCondicion = 0;
            Int32 mIBCondicionProveedor = 0;
            Int32 mIdProvinciaRealIIBB = 0;
            
            decimal mImporteComprobantesMParaRetencionGanancias = 0;
            decimal mPorcentajeRetencionGananciasComprobantesM = 0;
            decimal mCoeficienteUnificado = 0;
            decimal mAlicuota = 0;
            decimal mAlicuotaDirecta = 0;
            decimal mAlicuotaDirectaCapital = 0;
            decimal mAlicuotaConvenio = 0;
            decimal mPorcentajeATomarSobreBase = 0;
            decimal mPorcentajeAdicional = 0;
            decimal mImporteTopeMinimo = 0;
            decimal mBaseIIBB = 0;
            decimal mImpuestoRetenido = 0;
            decimal mImpuestoAdicional = 0;
            decimal mImporte = 0;
            decimal mAuxD1 = 0;
            decimal mAuxD2 = 0;
            decimal[] ganancias_pagosmes = new decimal[100];
            decimal[] ganancias_retencionesmes = new decimal[100];
            decimal[] iibb_pagosmes = new decimal[100];
            decimal[] iibb_retencionesmes = new decimal[100];

            string mGeneraImpuestos = "SI";
            string mBaseCalculoIIBB = "";
            string mRegimenEspecialConstruccionIIBB = "";
            string mLeyendaPorcentajeAdicional = "";
            string mCodigoProvincia = "";
            string mAcumulaMensualmente = "";
            
            DateTime mFecha = DateTime.Now;
            DateTime mFechaInicioVigenciaIBDirecto = DateTime.Now;
            DateTime mFechaFinVigenciaIBDirecto = DateTime.Now;
            DateTime mFechaInicioVigenciaIBDirectoCapital = DateTime.Now;
            DateTime mFechaFinVigenciaIBDirectoCapital = DateTime.Now;

            bool mAplicarAlicuotaConvenio = false;
            bool mAplicarAlicuotaDirecta = false;
            
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mImporteComprobantesMParaRetencionGanancias = parametros.ImporteComprobantesMParaRetencionGanancias ?? 0;
            mPorcentajeRetencionGananciasComprobantesM = parametros.PorcentajeRetencionGananciasComprobantesM ?? 0;
            mIdMonedaPesos = parametros.IdMoneda ?? 0;

            mFecha = OrdenPago.FechaOrdenPago ?? mFecha;
            mIdOrdenPago = OrdenPago.IdOrdenPago;

            mIdProveedor = OrdenPago.IdProveedor ?? 0;
            var Proveedores = db.Proveedores.Where(p => p.IdProveedor == mIdProveedor).FirstOrDefault();
            if (Proveedores != null)
            {
                mCoeficienteUnificado = Proveedores.CoeficienteIIBBUnificado ?? 0;
                mAlicuotaDirecta = Proveedores.PorcentajeIBDirecto ?? 0;
                mFechaInicioVigenciaIBDirecto = Proveedores.FechaInicioVigenciaIBDirecto ?? DateTime.MinValue;
                mFechaFinVigenciaIBDirecto = Proveedores.FechaFinVigenciaIBDirecto ?? DateTime.MinValue;
                mAlicuotaDirectaCapital = Proveedores.PorcentajeIBDirectoCapital ?? 0;
                mFechaInicioVigenciaIBDirectoCapital = Proveedores.FechaInicioVigenciaIBDirectoCapital ?? DateTime.MinValue;
                mFechaFinVigenciaIBDirectoCapital = Proveedores.FechaFinVigenciaIBDirectoCapital ?? DateTime.MinValue;
                mRegimenEspecialConstruccionIIBB = Proveedores.RegimenEspecialConstruccionIIBB ?? "";
                mIBCondicionProveedor = Proveedores.IBCondicion ?? 0;
            };

            mIdMoneda = OrdenPago.IdMoneda ?? mIdMonedaPesos;
            var Monedas = db.Monedas.Where(p => p.IdMoneda == mIdMoneda).FirstOrDefault();
            if (Monedas != null) { mGeneraImpuestos = Monedas.GeneraImpuestos ?? "NO"; }

            if (mGeneraImpuestos == "SI")
            {
                foreach (var a in OrdenPago.DetalleOrdenesPagoes)
                {
                    mImporte = a.ImportePagadoSinImpuestos ?? 0;
                    mIdTipoRetencionGanancia = a.IdTipoRetencionGanancia ?? 0;
                    mIdIBCondicion = a.IdIBCondicion ?? 0;

                    if (mIdTipoRetencionGanancia > 0)
                    {
                        ri = impuestos.Find(p => p.IdTipoRetencionGanancia == mIdTipoRetencionGanancia);
                        if (ri != null)
                        {
                            ri.ImportePagado += mImporte;
                            //impuestos.Remove(ri);
                        }
                        else
                        {
                            ri = new DetalleOrdenesPagoImpuesto();
                            ri.IdTipoRetencionGanancia = mIdTipoRetencionGanancia;
                            ri.ImportePagado = mImporte;
                            ri.TipoImpuesto = "Ganancias";
                            impuestos.Add(ri);
                        }
                    };
                    if (mIdIBCondicion > 0)
                    {
                        var IBCondiciones = db.IBCondiciones.Where(p => p.IdIBCondicion == mIdIBCondicion).FirstOrDefault();
                        if (IBCondiciones != null) { mBaseCalculoIIBB = IBCondiciones.BaseCalculo ?? "SIN IMPUESTOS"; }
                        if (mBaseCalculoIIBB != "SIN IMPUESTOS") { mImporte = a.Importe ?? 0; }
                        ri = impuestos.Find(p => p.IdIBCondicion == mIdIBCondicion);
                        if (ri != null)
                        {
                            ri.ImportePagado += mImporte;
                            //impuestos.Remove(ri);
                        }
                        else
                        {
                            ri = new DetalleOrdenesPagoImpuesto();
                            ri.IdIBCondicion = mIdIBCondicion;
                            ri.ImportePagado = mImporte;
                            ri.TipoImpuesto = "I.Brutos";
                            impuestos.Add(ri);
                        }
                    };
                };
                foreach (var a in impuestos)
                {
                    mImporte = a.ImportePagado ?? 0;
                    mIdTipoRetencionGanancia = a.IdTipoRetencionGanancia ?? 0;
                    mIdIBCondicion = a.IdIBCondicion ?? 0;

                    if (mIdTipoRetencionGanancia > 0)
                    {
                        mAuxD1 = 0;
                        var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Ganancias_TX_ImpuestoPorIdTipoRetencionGanancia", mIdProveedor, mFecha, mIdTipoRetencionGanancia, mImporte, mIdOrdenPago).AsEnumerable().FirstOrDefault();
                        if (dt != null)
                        {
                            mAuxD1 = (decimal)dt[0];
                            ganancias_pagosmes[mIdTipoRetencionGanancia] = (decimal)dt[1];
                            ganancias_retencionesmes[mIdTipoRetencionGanancia] = (decimal)dt[2];
                        }
                        mAuxD2 = (a.ImporteTotalFacturasMPagadasSujetasARetencion ?? 0);
                        if (mAuxD2 != 0) { mAuxD1 = mAuxD1 + decimal.Round((mAuxD2 * mPorcentajeRetencionGananciasComprobantesM / 100),2); }
                        a.ImpuestoRetenido = mAuxD1;
                    }

                    if (mIdIBCondicion > 0)
                    {
                        mImpuestoRetenido = 0;
                        mAplicarAlicuotaConvenio = false;
                        mAplicarAlicuotaDirecta = false;

                        var IBCondiciones = db.IBCondiciones.Where(p => p.IdIBCondicion == mIdIBCondicion).FirstOrDefault();
                        if (IBCondiciones != null)
                        {
                            mPorcentajeATomarSobreBase = IBCondiciones.PorcentajeATomarSobreBase ?? 0;
                            mPorcentajeAdicional = IBCondiciones.PorcentajeAdicional ?? 0;
                            mLeyendaPorcentajeAdicional = IBCondiciones.LeyendaPorcentajeAdicional ?? "";
                            mIdProvinciaRealIIBB = IBCondiciones.IdProvinciaReal ?? 0;
                            mAlicuota = IBCondiciones.Alicuota ?? 0;
                            mAcumulaMensualmente = IBCondiciones.AcumulaMensualmente ?? "";
                            mImporteTopeMinimo = IBCondiciones.ImporteTopeMinimo ?? 0;
                        }

                        if (mIBCondicionProveedor == 2)
                        {
                            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetProveedoresIB_TX_PorIdProveedorIdIBCondicion", mIdProveedor, mIBCondicionProveedor).AsEnumerable().FirstOrDefault();
                            if (dt != null)
                            {
                                mAlicuotaConvenio = (decimal)dt[3];
                                mAplicarAlicuotaConvenio = true;
                            }
                        }
                        
                        var Provincias = db.Provincias.Where(p => p.IdProvincia == mIdProvinciaRealIIBB).FirstOrDefault();
                        if (Provincias != null) { mCodigoProvincia = Provincias.InformacionAuxiliar ?? ""; }

                        if (mCodigoProvincia=="902" && mFecha >= mFechaInicioVigenciaIBDirecto && mFecha <= mFechaFinVigenciaIBDirecto && mRegimenEspecialConstruccionIIBB != "SI" ) {
                            mAuxD1 = mAlicuotaDirecta;
                            mAplicarAlicuotaDirecta = true;
                        }
                        else {
                            if (mCodigoProvincia == "901" && mFecha >= mFechaInicioVigenciaIBDirectoCapital && mFecha <= mFechaFinVigenciaIBDirectoCapital && mRegimenEspecialConstruccionIIBB != "SI")
                            {
                                mAuxD1 = mAlicuotaDirectaCapital;
                                mAplicarAlicuotaDirecta = true;
                            }
                            else { mAuxD1 = mAlicuota; }
                        }
                        a.AlicuotaAplicada = mAuxD1;
                        a.AlicuotaConvenioAplicada = mAlicuotaConvenio;
                        a.PorcentajeATomarSobreBase = 100;
                        mAuxD1 = 0;
                        mAuxD2 = 0;
                        if (mAcumulaMensualmente == "SI")
                        {
                            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "IBCondiciones_TX_AcumuladosPorIdProveedorIdIBCondicion", mIdProveedor, mFecha, mIdIBCondicion, mIdOrdenPago).AsEnumerable().FirstOrDefault();
                            if (dt != null)
                            {
                                mAuxD1 = (decimal)dt[0];
                                mAuxD2 = (decimal)dt[1];
                            }
                            iibb_pagosmes[mIdIBCondicion] = mAuxD1;
                            iibb_retencionesmes[mIdIBCondicion] = mAuxD2;
                        }
                        if (mImporte > mImporteTopeMinimo)
                        {
                            mBaseIIBB = mImporte + (mAuxD1 * mPorcentajeATomarSobreBase / 100);
                            if (mCoeficienteUnificado > 0 && mCoeficienteUnificado <= 100) { mBaseIIBB = mBaseIIBB * mCoeficienteUnificado / 100; }
                            if (mAplicarAlicuotaConvenio && mAplicarAlicuotaDirecta == false) { mImpuestoRetenido = decimal.Round(mBaseIIBB * mAlicuotaConvenio / 100, 2); }
                            else { mImpuestoRetenido = decimal.Round(mBaseIIBB * mAlicuota / 100, 2); }
                            mImpuestoAdicional = decimal.Round(mImpuestoRetenido * mPorcentajeAdicional / 100, 2);
                            mImpuestoRetenido += mImpuestoAdicional;
                            mImpuestoRetenido -= mAuxD2;
                            if (mImpuestoRetenido < 0) { mImpuestoRetenido = 0; }
                        }
                        a.ImpuestoRetenido = mImpuestoRetenido;
                        if (mCoeficienteUnificado > 0 && mCoeficienteUnificado <= 100) { mAuxD1 = mCoeficienteUnificado; }
                        else { mAuxD1 = mPorcentajeATomarSobreBase; }
                        a.PorcentajeATomarSobreBase = mAuxD1;
                        a.PorcentajeAdicional = mPorcentajeAdicional;
                        a.ImpuestoAdicional = mImpuestoAdicional;
                        a.LeyendaPorcentajeAdicional = mLeyendaPorcentajeAdicional;
                        if (mAplicarAlicuotaConvenio && mAplicarAlicuotaDirecta == false) {
                            a.AlicuotaAplicada = 0;
                            a.AlicuotaConvenioAplicada = mAlicuotaConvenio;
                        }
                        else
                        {
                            a.AlicuotaAplicada = mAlicuota;
                            a.AlicuotaConvenioAplicada = 0;
                        }
                    };
                    impuestos2.Add(a);
                }
            }

            var data = (from a in impuestos2.ToList()
                        from b in db.TiposRetencionGanancias.Where(o => o.IdTipoRetencionGanancia == a.IdTipoRetencionGanancia).DefaultIfEmpty()
                        from c in db.IBCondiciones.Where(p => p.IdIBCondicion == a.IdIBCondicion).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenPagoImpuestos,
                            a.IdTipoRetencionGanancia,
                            a.IdIBCondicion,
                            IdTipoImpuesto = (a.IdTipoRetencionGanancia != null ? a.IdTipoRetencionGanancia : (a.IdIBCondicion != null ? a.IdIBCondicion : 0)),
                            TipoImpuesto = a.TipoImpuesto,
                            Categoria = (b != null ? b.Descripcion : (c != null ? c.Descripcion : "")),
                            ImportePagado = a.ImportePagado,
                            a.ImpuestoRetenido,
                            PagosMes = ganancias_pagosmes[(a.IdTipoRetencionGanancia ?? 0)],
                            RetencionesMes = ganancias_retencionesmes[(a.IdTipoRetencionGanancia ?? 0)],
                            MinimoIIBB = c != null ? c.ImporteTopeMinimo : 0,
                            a.AlicuotaAplicada,
                            a.AlicuotaConvenioAplicada,
                            a.PorcentajeAdicional,
                            a.ImpuestoAdicional,
                            a.NumeroCertificadoRetencionGanancias,
                            a.NumeroCertificadoRetencionIIBB,
                            a.ImporteTotalFacturasMPagadasSujetasARetencion
                        }).OrderBy(x => x.Categoria).ToList();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult CalcularRetencionSUSS(OrdenPago OrdenPago)
        {
            Int32 mIdProveedor = 0;
            Int32 mIdOrdenPago = 0;
            Int32 mIdMoneda = 0;
            Int32 mIdMonedaPesos = 0;
            Int32 mIdImpuestoDirectoSUSS = 0;

            decimal mRetencionSUSS = 0;
            decimal mRetencionSUSSIndividual = 0;
            decimal mPorcentajeRetencionSUSS = 0;
            decimal mPorcentajeRetencionSUSS1 = 0;
            decimal mImporteMinimoBaseRetencionSUSS = 0;
            decimal mTopeAnualSUSS = 0;
            decimal mTotalGravado = 0;
            decimal mImporteAcumulado = 0;
            decimal mRetenidoAño = 0;
            decimal mBaseOperacion = 0;
            decimal mBaseCalculoSUSS = 0;

            string mAgenteRetencionSUSS = "NO";
            string mRetenerSUSSAProveedor = "NO";

            DateTime mFecha = DateTime.Now;

            bool mProcesarSUSS = false;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdMonedaPesos = parametros.IdMoneda ?? 0;
            mAgenteRetencionSUSS = parametros.AgenteRetencionSUSS ?? "NO";
            mPorcentajeRetencionSUSS = parametros.PorcentajeRetencionSUSS ?? 0;

            mFecha = OrdenPago.FechaOrdenPago ?? mFecha;
            mIdOrdenPago = OrdenPago.IdOrdenPago;
            mIdProveedor = OrdenPago.IdProveedor ?? 0;
            mIdMoneda = OrdenPago.IdMoneda ?? mIdMonedaPesos;

            if (mAgenteRetencionSUSS == "SI" && mIdProveedor > 0)
            {
                //If mvarSUSSFechaCaducidadExencion < Date And Me.Visible And IsNumeric(dcfields(0).BoundText) And Option1.Value Then 'And mvarAgenteRetencionIVA = "SI" Then
                //MsgBox "El proveedor tiene la fecha de excencion al SUSS vencida," & vbCrLf & "se requerira la categoria para realizar la retencion", vbExclamation

                var Proveedores = db.Proveedores.Where(p => p.IdProveedor == mIdProveedor).FirstOrDefault();
                if (Proveedores != null)
                {
                    mRetenerSUSSAProveedor = Proveedores.RetenerSUSS ?? "NO";
                    mIdImpuestoDirectoSUSS = Proveedores.IdImpuestoDirectoSUSS ?? 0;
                }

                if (mRetenerSUSSAProveedor == "SI")
                {
                    mPorcentajeRetencionSUSS1 = -1;
                    if (mIdImpuestoDirectoSUSS > 0)
                    {
                        var ImpuestosDirectos = db.ImpuestosDirectos.Where(p => p.IdImpuestoDirecto == mIdImpuestoDirectoSUSS).FirstOrDefault();
                        if (ImpuestosDirectos != null)
                        {
                            mPorcentajeRetencionSUSS1 = ImpuestosDirectos.Tasa ?? 0;
                            mImporteMinimoBaseRetencionSUSS = ImpuestosDirectos.BaseMinima ?? 0;
                            mTopeAnualSUSS = ImpuestosDirectos.TopeAnual ?? 0;
                        }
                    }
                    foreach (var a in OrdenPago.DetalleOrdenesPagoes)
                    { mTotalGravado += a.ImportePagadoSinImpuestos ?? 0; };
                    if (mTopeAnualSUSS > 0)
                    {
                        var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TX_PagosAcumuladoAnual", mIdProveedor, mFecha, mIdOrdenPago, mIdImpuestoDirectoSUSS).AsEnumerable().FirstOrDefault();
                        if (dt != null)
                        {
                            mImporteAcumulado = (decimal)dt[0];
                            mRetenidoAño = (decimal)dt[1];
                        }
                    }
                    if (mTotalGravado >= mImporteMinimoBaseRetencionSUSS)
                    {
                        foreach (var a in OrdenPago.DetalleOrdenesPagoes)
                        {
                            mRetencionSUSSIndividual = 0;
                            mBaseOperacion = a.ImportePagadoSinImpuestos ?? 0;
                            if (mBaseOperacion != 0)
                            {
                                mBaseCalculoSUSS += mBaseOperacion;
                                if (mTopeAnualSUSS > 0 && mImporteAcumulado + mBaseCalculoSUSS >= mTopeAnualSUSS) { mProcesarSUSS = true; }
                                if (mPorcentajeRetencionSUSS1 == -1) { mRetencionSUSSIndividual = decimal.Round(mBaseOperacion * mPorcentajeRetencionSUSS / 100, 2); }
                                else { mRetencionSUSSIndividual = decimal.Round(mBaseOperacion * mPorcentajeRetencionSUSS1 / 100, 2); }
                            }
                            mRetencionSUSS += mRetencionSUSSIndividual;
                        }
                        if (mTopeAnualSUSS > 0)
                        {
                            if (mProcesarSUSS)
                            {
                                if (mPorcentajeRetencionSUSS1 == -1) { mRetencionSUSS += decimal.Round(mImporteAcumulado * mPorcentajeRetencionSUSS / 100, 2); }
                                else { mRetencionSUSS += decimal.Round(mImporteAcumulado * mPorcentajeRetencionSUSS1 / 100, 2); }
                                mRetencionSUSS -= mRetenidoAño;
                                if (mRetencionSUSS < 0) { mRetencionSUSS = 0; }
                            }
                            else
                            {
                                mRetencionSUSS = 0;
                            }
                        }
                    }
                }
            }

            var data = mRetencionSUSS.ToString();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult CalcularRetencionIva(OrdenPago OrdenPago)
        {
            Int32 mIdProveedor = 0;
            Int32 mIdOrdenPago = 0;
            Int32 mNumeroOrdenPago = 0;
            Int32 mIdMoneda = 0;
            Int32 mIdMonedaPesos = 0;
            Int32 mTipoIVA = 0;
            Int32 mIdImputacion = 0;
            Int32 mIdTipoComprobante = 0;
            Int32 mIdComprobante = 0;
            Int32 mNumeroOrdenPagoRetencionIVA = 0;
            Int32 mIdDetalleOrdenPagoRetencionIVAAplicada = 0;
            Int32 mIdOrdenPagoRetencionIva = 0;
            Int32 mIdActividad = 0;
            Int32 mActividadPrincipalGrupo = 0;
            Int32 mIdImpuestoDirecto = 0;
            
            decimal mRetencionIva = 0;
            decimal mRetencionIVAIndividual = 0;
            decimal mRetencionIVAComprobantesM = 0;
            decimal mBienesUltimoAño = 0;
            decimal mServiciosUltimoAño = 0;
            decimal mImporteComprobantesMParaRetencionIVA = 0;
            decimal mPorcentajeRetencionIVA = 0;
            decimal mPorcentajeRetencionIVAComprobantesM = 0;
            decimal mTopeMinimoRetencionIVA = 0;
            decimal mTopeMinimoRetencionIVAServicios = 0;
            decimal mPorcentajeBaseRetencionIVABienes = 0;
            decimal mPorcentajeBaseRetencionIVAServicios = 0;
            decimal mImporteMinimoRetencionIVA = 0;
            decimal mImporteMinimoRetencionIVAServicios = 0;
            decimal mTotalComprobante = 0;
            decimal mTotalIva1 = 0;
            decimal mImportePagadoSinImpuestos = 0;
            decimal mBase = 0;
            decimal mImporteTotalMinimoAplicacionRetencionIVA = 0;
            decimal mExceptuadoRetencionIVA = 0;
            decimal mIvaPorcentajeExencion = 0;
            decimal mTopeMonotributoAnual_Bienes = 0;
            decimal mTopeMonotributoAnual_Servicios = 0;
            decimal mPorcentajeRetencionIVAMonotributistas = 0;
            decimal mAuxD1 = 0;

            DateTime mFecha = DateTime.Now;
            DateTime mIvaFechaInicioExencion = DateTime.MinValue;
            DateTime mIvaFechaCaducidadExencion = DateTime.MinValue;

            string mLetra = "";
            string mImputacionesOrdenPago = "";
            string mAgenteRetencionIVA = "";
            string mBienesOServicios = "B";
            string mCodigoSituacionRetencionIVA = "0";
            string mIvaExencionRetencion = "";
            string mIdsComprobanteProveedorRetenidosIva = "";
            string mTotalesImportesRetenidosIva = "";

            bool mActividadComercializacionGranos = false;

            //If mvarCodigoSituacionRetencionIVA = 3 And mvarTipoIVA = 1 Then
            //   MsgBox "El codigo de situacion del proveedor para retencion IVA es 3," & vbCrLf & "en consecuencia no puede ser registrado este comprobante", vbExclamation
            //   GoTo Salida
            //End If

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var Empresas = db.Empresas.Where(p => p.IdEmpresa == 1).FirstOrDefault();
            if ((Empresas.ActividadComercializacionGranos ?? "") == "SI") { mActividadComercializacionGranos = true; }
            
            var Parametros2 = db.Parametros2.Where(p => p.Campo == "TopeMonotributoAnual_Bienes").FirstOrDefault();
            if (Parametros2 != null) { mTopeMonotributoAnual_Bienes = Convert.ToDecimal(Parametros2.Valor ?? "0"); }
            Parametros2 = db.Parametros2.Where(p => p.Campo == "TopeMonotributoAnual_Servicios").FirstOrDefault();
            if (Parametros2 != null) { mTopeMonotributoAnual_Servicios = Convert.ToDecimal(Parametros2.Valor ?? "0"); }
            Parametros2 = db.Parametros2.Where(p => p.Campo == "PorcentajeRetencionIVAMonotributistas").FirstOrDefault();
            if (Parametros2 != null) { mPorcentajeRetencionIVAMonotributistas = Convert.ToDecimal(Parametros2.Valor ?? "0"); }

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdMonedaPesos = parametros.IdMoneda ?? 0;
            mImporteComprobantesMParaRetencionIVA = parametros.ImporteComprobantesMParaRetencionIVA ?? 0;
            mPorcentajeRetencionIVAComprobantesM = parametros.PorcentajeRetencionIVAComprobantesM ?? 0;
            mTopeMinimoRetencionIVA = parametros.TopeMinimoRetencionIVA ?? 0;
            mTopeMinimoRetencionIVAServicios = parametros.TopeMinimoRetencionIVAServicios ?? 0;
            mAgenteRetencionIVA = parametros.AgenteRetencionIVA ?? "NO";
            mImporteTotalMinimoAplicacionRetencionIVA = parametros.ImporteTotalMinimoAplicacionRetencionIVA ?? 0;
            mPorcentajeBaseRetencionIVABienes = parametros.PorcentajeBaseRetencionIVABienes ?? 0;
            mPorcentajeBaseRetencionIVAServicios = parametros.PorcentajeBaseRetencionIVAServicios ?? 0;
            mImporteMinimoRetencionIVA = parametros.ImporteMinimoRetencionIVA ?? 0;
            mImporteMinimoRetencionIVAServicios = parametros.ImporteMinimoRetencionIVAServicios ?? 0;

            mFecha = OrdenPago.FechaOrdenPago ?? mFecha;
            mIdOrdenPago = OrdenPago.IdOrdenPago;
            mIdProveedor = OrdenPago.IdProveedor ?? 0;
            mNumeroOrdenPago = OrdenPago.NumeroOrdenPago ?? 0;
            mIdMoneda = OrdenPago.IdMoneda ?? mIdMonedaPesos;

            if (mIdOrdenPago <= 0)
            {
                var Proveedores = db.Proveedores.Where(p => p.IdProveedor == mIdProveedor).FirstOrDefault();
                if (Proveedores != null)
                {
                    mTipoIVA = Proveedores.IdCodigoIva ?? 0;
                    mIdActividad = Proveedores.IdActividad ?? 0;
                    mCodigoSituacionRetencionIVA = Proveedores.CodigoSituacionRetencionIVA ?? "0";
                    mIvaExencionRetencion = Proveedores.IvaExencionRetencion ?? "";
                    mIvaFechaInicioExencion = Proveedores.IvaFechaInicioExencion ?? DateTime.MinValue;
                    mIvaFechaCaducidadExencion = Proveedores.IvaFechaCaducidadExencion ?? DateTime.MinValue;
                    mIvaPorcentajeExencion = Proveedores.IvaPorcentajeExencion ?? 0;
                    if (mIvaExencionRetencion == "SI") { mExceptuadoRetencionIVA = 100; }
                    else { if (mIvaFechaInicioExencion <= mFecha) { if (mIvaFechaCaducidadExencion >= mFecha) { mExceptuadoRetencionIVA = mIvaPorcentajeExencion; } } }

                }

                if (mIdActividad > 0)
                {
                    var Actividades_Proveedores = db.Actividades_Proveedores.Where(p => p.IdActividad == mIdActividad).FirstOrDefault();
                    if (Actividades_Proveedores != null) { mActividadPrincipalGrupo = Actividades_Proveedores.Agrupacion1 ?? 0; }
                }

                if (mTipoIVA == 6)
                {
                    var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "ComprobantesProveedores_TX_TotalBSUltimoAño", mIdProveedor, mFecha, mTipoIVA).AsEnumerable().FirstOrDefault();
                    if (dt != null)
                    {
                        mBienesUltimoAño = (decimal)dt[0];
                        mServiciosUltimoAño = (decimal)dt[1];
                    }
                }
                foreach (var a in OrdenPago.DetalleOrdenesPagoes)
                {
                    mRetencionIVAIndividual = 0;
                    mNumeroOrdenPagoRetencionIVA = 0;
                    mLetra = "";
                    mTotalComprobante = 0;
                    mTotalIva1 = 0;
                    mAuxD1 = 0;

                    mIdImputacion = a.IdImputacion ?? 0;
                    mImportePagadoSinImpuestos = a.ImportePagadoSinImpuestos ?? 0;
                    

                    var CuentasCorrientesAcreedores = db.CuentasCorrientesAcreedores.Where(p => p.IdCtaCte == mIdImputacion).FirstOrDefault();
                    if (CuentasCorrientesAcreedores != null)
                    {
                        mIdTipoComprobante = CuentasCorrientesAcreedores.IdTipoComp ?? 0;
                        mIdComprobante = CuentasCorrientesAcreedores.IdComprobante ?? 0;
                    }

                    if (mIdTipoComprobante != 17 && mIdTipoComprobante != 16)
                    {
                        var ComprobantesProveedor = db.ComprobantesProveedor.Where(p => p.IdComprobanteProveedor == mIdComprobante && p.IdTipoComprobante == mIdTipoComprobante).FirstOrDefault();
                        if (ComprobantesProveedor != null)
                        {
                            mIdDetalleOrdenPagoRetencionIVAAplicada = ComprobantesProveedor.IdDetalleOrdenPagoRetencionIVAAplicada ?? 0;
                            mIdOrdenPagoRetencionIva = ComprobantesProveedor.IdOrdenPagoRetencionIva ?? 0;
                            mLetra = ComprobantesProveedor.Letra ?? "";
                            mTotalComprobante = ComprobantesProveedor.TotalComprobante ?? 0;
                            mTotalIva1 = ComprobantesProveedor.TotalIva1 ?? 0;
                            mIdImpuestoDirecto = ComprobantesProveedor.IdImpuestoDirecto ?? 0;
                            mBienesOServicios = ComprobantesProveedor.BienesOServicios ?? (Proveedores.BienesOServicios ?? "B");
                        }

                        if (mIdImpuestoDirecto > 0)
                        {
                            var ImpuestosDirectos = db.ImpuestosDirectos.Where(p => p.IdImpuestoDirecto == mIdImpuestoDirecto).FirstOrDefault();
                            if (ImpuestosDirectos != null) { mAuxD1 = ImpuestosDirectos.Tasa ?? 0; }
                        }
                    }
                    if (mIdDetalleOrdenPagoRetencionIVAAplicada != 0)
                    {
                        var DetalleOrdenesPagoes = db.DetalleOrdenesPagoes.Where(p => p.IdDetalleOrdenPago == mIdDetalleOrdenPagoRetencionIVAAplicada).FirstOrDefault();
                        if (DetalleOrdenesPagoes != null) { mNumeroOrdenPagoRetencionIVA = DetalleOrdenesPagoes.OrdenesPago.NumeroOrdenPago ?? 0; }
                    }
                    if (mIdOrdenPagoRetencionIva != 0 && mNumeroOrdenPagoRetencionIVA == 0)
                    {
                        var OrdenesPago = db.OrdenesPago.Where(p => p.IdOrdenPago == mIdOrdenPagoRetencionIva).FirstOrDefault();
                        if (OrdenesPago != null) { mNumeroOrdenPagoRetencionIVA = OrdenesPago.NumeroOrdenPago ?? 0; }
                    }

                    if (mNumeroOrdenPagoRetencionIVA == 0 || mNumeroOrdenPago==mNumeroOrdenPagoRetencionIVA)
                    {
                        mBase = mTotalIva1;
                        if (mLetra == "M")
                        {
                            if (mTotalComprobante - mTotalIva1 >= mImporteComprobantesMParaRetencionIVA)
                            {
                                mRetencionIVAIndividual = decimal.Round(mBase * mPorcentajeRetencionIVAComprobantesM / 100, 2);
                                mRetencionIVAComprobantesM += mRetencionIVAIndividual;
                            }
                        }
                        else
                        {
                            if (mTipoIVA == 1 && mActividadPrincipalGrupo == 1)
                            { if (mIdImputacion != 0) { mImputacionesOrdenPago = mImputacionesOrdenPago + '(' + mIdImputacion.ToString() + ')'; } }
                            else
                            {
                                if (mRetencionIVAIndividual == 0 && mAgenteRetencionIVA == "SI")
                                {
                                    if (mActividadComercializacionGranos)
                                    {
                                        if (mTipoIVA == 1)
                                        {
                                            mPorcentajeRetencionIVA = mAuxD1;
                                            mRetencionIVAIndividual = decimal.Round(mImportePagadoSinImpuestos * mPorcentajeRetencionIVA / 100, 2);
                                        }
                                    }
                                    if (mRetencionIVAIndividual == 0 && mTotalComprobante > mImporteTotalMinimoAplicacionRetencionIVA)
                                    {
                                        if (mBienesOServicios == "B")
                                        {
                                            if (mBase > mTopeMinimoRetencionIVA)
                                            {
                                                mBase = mBase * mPorcentajeBaseRetencionIVABienes / 100;
                                                if (mCodigoSituacionRetencionIVA == "2") { mRetencionIVAIndividual = mBase; }
                                                if (mExceptuadoRetencionIVA != 0) { 
                                                    mRetencionIVAIndividual = decimal.Round(mBase * (100 - mExceptuadoRetencionIVA) / 100, 2); 
                                                }
                                                else {
                                                    mRetencionIVAIndividual = mBase;
                                                    if (mRetencionIVAIndividual < mImporteMinimoRetencionIVA) { mRetencionIVAIndividual = 0; }
                                                }
                                                if (mTipoIVA != 1) { mRetencionIVAIndividual = 0; }
                                            }
                                        }
                                        else
                                        {
                                            if (mBienesOServicios == "S")
                                            {
                                                if (mBase > mTopeMinimoRetencionIVAServicios)
                                                {
                                                    mBase = mBase * mPorcentajeBaseRetencionIVAServicios / 100;
                                                    if (mCodigoSituacionRetencionIVA == "2") { mRetencionIVAIndividual = mBase; }
                                                    if (mExceptuadoRetencionIVA != 0)
                                                    {
                                                        mRetencionIVAIndividual = decimal.Round(mBase * (100 - mExceptuadoRetencionIVA) / 100, 2);
                                                    }
                                                    else
                                                    {
                                                        mRetencionIVAIndividual = mBase;
                                                        if (mRetencionIVAIndividual < mImporteMinimoRetencionIVAServicios) { mRetencionIVAIndividual = 0; }
                                                    }
                                                    if (mTipoIVA != 1) { mRetencionIVAIndividual = 0; }
                                                }
                                            }
                                            else
                                            {
                                                mBase = 0;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if (mTipoIVA == 6)
                        {
                            if (mBienesUltimoAño > mTopeMonotributoAnual_Bienes || mServiciosUltimoAño > mTopeMonotributoAnual_Servicios)
                            {
                                mBase = mImportePagadoSinImpuestos;
                                mRetencionIVAIndividual = decimal.Round(mBase * mPorcentajeRetencionIVAMonotributistas / 100, 2);
                            }
                        }
                    }
                    mRetencionIva += mRetencionIVAIndividual;
                }
                if (mImputacionesOrdenPago.Length > 0)
                {
                    var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "OrdenesPago_TX_ImpuestosPorGrupo", mIdOrdenPago, mIdProveedor, mImputacionesOrdenPago);
                    IEnumerable<DataRow> Entidad = dt.AsEnumerable();
                    if (Entidad.Count() > 0) { mRetencionIva = 0; }
                    foreach (DataRow dr in Entidad)
                    {
                        mRetencionIVAIndividual = Convert.ToDecimal(dr["ImporteRetencionIva"]);
                        mRetencionIva += mRetencionIVAIndividual;
                        if (dr["ImputacionEnOPActual"].NullSafeToString() != "SI")
                        {
                            mIdsComprobanteProveedorRetenidosIva = mIdsComprobanteProveedorRetenidosIva + Convert.ToString(dr["IdComprobanteProveedor"]) + "|";
                            mTotalesImportesRetenidosIva = mTotalesImportesRetenidosIva + mRetencionIVAIndividual.ToString() + "|";
                        }
                    }
                }
            }
            else
            {
                mRetencionIva = OrdenPago.RetencionIVA ?? 0;
            }

            //var data = "[{\"RetencionIva\": \"" + mRetencionIva.ToString() + "\", \"IdsComprobanteProveedorRetenidosIva\": \"" + mIdsComprobanteProveedorRetenidosIva + "\", \"TotalesImportesRetenidosIva\": \"" + mTotalesImportesRetenidosIva + "\"}]";
            DatosJson data = new DatosJson();
            data.campo1=mRetencionIva.ToString();
            data.campo2=mIdsComprobanteProveedorRetenidosIva;
            data.campo3=mTotalesImportesRetenidosIva;

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public virtual JsonResult CalcularAsiento(OrdenPago OrdenPago)
        {
            List<DetalleOrdenesPagoCuenta> asiento = new List<DetalleOrdenesPagoCuenta>();
            DetalleOrdenesPagoCuenta rc;

            Int32 IdProveedor = 0;
            Int32 mIdCuenta = 0;
            Int32 mIdCuentaRetencionGanancias = 0;
            Int32 mIdCuentaRetencionIBrutos = 0;
            Int32 mIdCuentaRetencionIVA = 0;
            Int32 mIdCuentaRetencionIVAComprobantesM = 0;
            Int32 mIdCuentaRetencionSUSS = 0;
            Int32 mIdImpuestoDirectoSUSS = 0;
            Int32 mIdIBCondicionPorDefecto = 0;
            Int32 mIdAux = 0;
            Int32 mIdCuentaCaja = 0;
            Int32 mIdCuentaValores = 0;
            Int32 mIdCuentaValores1 = 0;
            Int32 mIdIBCondicion = 0;
            
            decimal mDebeHaber = 0;
            decimal mRetencionGanancias = 0;
            decimal mRetencionIVA = 0;
            decimal mRetencionIVAComprobantesM = 0;
            decimal mImporte = 0;
            decimal mRetencionIBrutos = 0;
            decimal mRetencionSUSS = 0;
            decimal mTotalValores = 0;

            string mChequeraPagoDiferido = "";
            string mActivarCircuitoChequesDiferidos = "";

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdCuentaRetencionGanancias = parametros.IdCuentaRetencionGanancias ?? 0;
            mIdCuentaRetencionIBrutos = parametros.IdCuentaRetencionIBrutos ?? 0;
            mIdCuentaRetencionIVA = parametros.IdCuentaRetencionIva ?? 0;
            mIdCuentaRetencionIVAComprobantesM = parametros.IdCuentaRetencionIvaComprobantesM ?? 0;
            mIdCuentaRetencionSUSS = parametros.IdCuentaRetencionSUSS ?? 0;
            mIdCuentaCaja = parametros.IdCuentaCaja ?? 0;
            mActivarCircuitoChequesDiferidos = parametros.ActivarCircuitoChequesDiferidos ?? "NO";

            IdProveedor = OrdenPago.IdProveedor ?? 0;
            var proveedor = db.Proveedores.Where(p => p.IdProveedor == IdProveedor).FirstOrDefault();
            if (proveedor != null)
            {
                mIdImpuestoDirectoSUSS = proveedor.IdImpuestoDirectoSUSS ?? 0;
                if (mIdImpuestoDirectoSUSS > 0)
                {
                    var ImpuestosDirectos = db.ImpuestosDirectos.Where(p => p.IdImpuestoDirecto == mIdImpuestoDirectoSUSS).FirstOrDefault();
                    mIdAux = ImpuestosDirectos.IdCuenta ?? 0;
                    if (mIdAux > 0) { mIdCuentaRetencionSUSS = mIdAux; }
                }
                mIdIBCondicionPorDefecto = proveedor.IdIBCondicionPorDefecto ?? 0;
                if (mIdIBCondicionPorDefecto > 0)
                {
                    var IBCondiciones = db.IBCondiciones.Where(p => p.IdIBCondicion == mIdIBCondicionPorDefecto).FirstOrDefault();
                    mIdAux = IBCondiciones.Provincia.IdCuentaRetencionIBrutos ?? 0;
                    if (mIdAux > 0) { mIdCuentaRetencionIBrutos = mIdAux; }
                }
            };

            mRetencionGanancias = OrdenPago.RetencionGanancias ?? 0;
            if (mRetencionGanancias != 0)
            {
                rc = new DetalleOrdenesPagoCuenta();
                rc.IdCuenta = mIdCuentaRetencionGanancias;
                if (mRetencionGanancias >= 0) { rc.Haber = mRetencionGanancias; } else { rc.Debe = mRetencionGanancias * -1; };
                mDebeHaber -= mRetencionGanancias;
                asiento.Add(rc);
            };

            mRetencionIVA = OrdenPago.RetencionIVA ?? 0;
            mRetencionIVAComprobantesM = OrdenPago.RetencionIVAComprobantesM ?? 0;
            mImporte = mRetencionIVA - mRetencionIVAComprobantesM;
            if (mImporte != 0)
            {
                rc = new DetalleOrdenesPagoCuenta();
                rc.IdCuenta = mIdCuentaRetencionIVA;
                if (mImporte >= 0) { rc.Haber = mImporte; } else { rc.Debe = mImporte * -1; };
                mDebeHaber -= mImporte;
                asiento.Add(rc);
            };

            if (mRetencionIVAComprobantesM != 0)
            {
                rc = new DetalleOrdenesPagoCuenta();
                rc.IdCuenta = mIdCuentaRetencionIVAComprobantesM;
                if (mRetencionIVAComprobantesM >= 0) { rc.Haber = mRetencionIVAComprobantesM; } else { rc.Debe = mRetencionIVAComprobantesM * -1; };
                mDebeHaber -= mRetencionIVAComprobantesM;
                asiento.Add(rc);
            };

            mRetencionIBrutos = OrdenPago.RetencionIBrutos ?? 0;
            if (mRetencionIBrutos != 0)
            {
                foreach (var a in OrdenPago.DetalleOrdenesPagoImpuestos)
                {
                    mIdIBCondicion = a.IdIBCondicion ?? 0;
                    if (mIdIBCondicion > 0)
                    {
                        mImporte = a.ImpuestoRetenido ?? 0;
                        if (mImporte > 0)
                        {
                            mIdCuenta = mIdCuentaRetencionIBrutos;
                            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "IBCondiciones_TX_IdCuentaPorProvincia", mIdIBCondicion).AsEnumerable().FirstOrDefault();
                            if (dt != null) { mIdCuenta = (Int32)dt["IdCuentaRetencionIBrutos"]; }

                            rc = new DetalleOrdenesPagoCuenta();
                            rc.IdCuenta = mIdCuenta;
                            if (mImporte >= 0) { rc.Haber = mImporte; } else { rc.Debe = mImporte * -1; };
                            asiento.Add(rc);
                            mDebeHaber -= mImporte;
                        }
                    }
                }
            };

            mRetencionSUSS = OrdenPago.RetencionSUSS ?? 0;
            if (mRetencionSUSS != 0)
            {
                rc = new DetalleOrdenesPagoCuenta();
                rc.IdCuenta = mIdCuentaRetencionSUSS;
                if (mRetencionSUSS >= 0) { rc.Haber = mRetencionSUSS; } else { rc.Debe = mRetencionSUSS * -1; };
                mDebeHaber -= mRetencionSUSS;
                asiento.Add(rc);
            };

            mTotalValores = 0;
            foreach (var a in OrdenPago.DetalleOrdenesPagoValores)
            {
                if ((a.Anulado ?? "") != "SI")
                {
                    mIdCuentaValores1 = mIdCuentaValores;
                    mTotalValores += a.Importe ?? 0;
                    if (a.IdBanco != null)
                    {
                        mChequeraPagoDiferido = "NO";
                        if (a.IdBancoChequera != null)
                        {
                            var BancoChequeras = db.BancoChequeras.Where(p => p.IdBancoChequera == a.IdBancoChequera).FirstOrDefault();
                            if (BancoChequeras != null) { mChequeraPagoDiferido = BancoChequeras.ChequeraPagoDiferido ?? "NO"; }
                        };
                        var Bancos = db.Bancos.Where(p => p.IdBanco == a.IdBanco).FirstOrDefault();
                        if (Bancos != null)
                        {
                            if (mActivarCircuitoChequesDiferidos == "NO" || mChequeraPagoDiferido == "NO" || Bancos.IdCuentaParaChequesDiferidos == null)
                            { mIdCuentaValores1 = Bancos.IdCuenta ?? 0; }
                            else { mIdCuentaValores1 = Bancos.IdCuentaParaChequesDiferidos ?? 0; };
                        }
                    };
                    if (a.IdTarjetaCredito != null)
                    {
                        var TarjetasCreditoes = db.TarjetasCreditoes.Where(p => p.IdTarjetaCredito == a.IdTarjetaCredito).FirstOrDefault();
                        if (TarjetasCreditoes != null) { if (TarjetasCreditoes.IdCuenta != null) { mIdCuentaValores1 = TarjetasCreditoes.IdCuenta ?? 0; } }
                    };
                    if (a.IdCaja != null)
                    {
                        var Cajas = db.Cajas.Where(p => p.IdCaja == a.IdCaja).FirstOrDefault();
                        if (Cajas != null) { if (Cajas.IdCuenta != null) { mIdCuentaValores1 = Cajas.IdCuenta ?? 0; } }
                    };
                    rc = new DetalleOrdenesPagoCuenta();
                    rc.IdCuenta = mIdCuentaValores1;
                    rc.Haber = a.Importe ?? 0;
                    mDebeHaber -= a.Importe ?? 0;
                    asiento.Add(rc);
                };
            };

            if (IdProveedor > 0)
            { mIdCuenta = proveedor.IdCuenta ?? 0; }
            else
            { mIdCuenta = OrdenPago.IdCuenta ?? 0; };

            rc = new DetalleOrdenesPagoCuenta();
            rc.IdCuenta = mIdCuenta;
            if (mDebeHaber <= 0) { rc.Debe = mDebeHaber * -1; } else { rc.Haber = mDebeHaber; };
            asiento.Add(rc);

            var data = (from a in asiento.ToList()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleOrdenPagoCuentas,
                            a.IdCuenta,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleOrdenPagoCuentas).ToList();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult CalcularImportePagadoSinImpuestos(Int32 IdTipoComprobante, Int32 IdComprobante, decimal Pagado)
        {
            decimal mImportePagadoSinImpuestos = 0;
            decimal mTotalBruto = 0;
            decimal mTotalComprobante = 0;
            decimal mCotizacionMoneda = 1;

            var ComprobantesProveedor = db.ComprobantesProveedor.Where(p => p.IdComprobanteProveedor == IdComprobante && p.IdTipoComprobante == IdTipoComprobante).FirstOrDefault();
            if (ComprobantesProveedor != null)
            {
                mTotalBruto = ComprobantesProveedor.TotalBruto ?? 0;
                mTotalComprobante = ComprobantesProveedor.TotalComprobante ?? 0;
                mCotizacionMoneda = ComprobantesProveedor.CotizacionMoneda ?? 1;
            }
            else
            {
                mImportePagadoSinImpuestos = Pagado;
            }
            if (mTotalComprobante != 0)
            {
                mImportePagadoSinImpuestos = decimal.Round(Pagado * mTotalBruto * mCotizacionMoneda / mTotalComprobante, 2);
            }

            var data = mImportePagadoSinImpuestos.ToString();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        private bool Validar(ProntoMVC.Data.Models.OrdenPago o, ref string sErrorMsg, ref string sWarningMsg)
        {
            Int32 mIdOrdenPago = 0;
            Int32 mNumeroOrdenPago = 0;
            Int32 mNumeroOrdenPagoAux = 0;
            Int32 mIdMoneda = 1;
            Int32 mIdProveedor = 0;
            Int32 mIdEstado = 0;

            decimal mTotalRubrosContables = 0;
            decimal mTotalValores = 0;

            string mTipo = "";
            string mObservaciones = "";
            string mOrdenPagoExterior = "";

            DateTime mFechaOrdenPago = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;

            DataRow oRsAux1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            mIdOrdenPago = o.IdOrdenPago;
            mNumeroOrdenPago = o.NumeroOrdenPago ?? 0;
            mTipo = o.Tipo;
            mIdMoneda = o.IdMoneda ?? 1;
            mIdProveedor = o.IdProveedor ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mOrdenPagoExterior = o.Exterior ?? "NO";

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;

            if ((o.NumeroOrdenPago ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de orden de pago"; }
            if (o.FechaOrdenPago < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha de la orden no puede ser anterior a la del ultimo cierre contable"; }
            if (BuscarClaveINI("Requerir obra en OP", -1) == "SI") { if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; } }
            if ((o.CotizacionMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización de equivalencia a pesos"; }
            if ((o.CotizacionDolar ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización dolar"; }
            if ((o.CotizacionEuro ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización euro"; }
            if (mIdMoneda <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }

            if (mTipo == "CC")
            {
                if (o.DetalleOrdenesPagoes.Count <= 0) sErrorMsg += "\n" + "La orden de pago no tiene imputaciones a cuenta corriente";
                if (mIdProveedor <= 0) { 
                    sErrorMsg += "\n" + "Falta el proveedor"; 
                }
                else
                {
                    Proveedor Proveedor = db.Proveedores.Where(c => c.IdProveedor == mIdProveedor).SingleOrDefault();
                    if (Proveedor != null)
                    {
                        mIdEstado = Proveedor.IdEstado ?? 0;
                        if ((Proveedor.CodigoSituacionRetencionIVA ?? "") == "3" && (Proveedor.IdCodigoIva ?? 0) == 1) { sErrorMsg += "\n" + "El codigo de situacion del proveedor para retencion IVA es 3, no puede registrar la orden de pago"; }
                        if ((Proveedor.SujetoEmbargado ?? "") == "SI") { sWarningMsg += "\n" + "Proveedor embargado, revise su situacion en el maestro y proceda en consecuencia"; }

                        Estados_Proveedore EstadoProveedor = db.Estados_Proveedores.Where(c => c.IdEstado == mIdEstado).SingleOrDefault();
                        if (EstadoProveedor != null)
                        {
                            if ((EstadoProveedor.Activo ?? "") == "NO") { sErrorMsg += "\n" + "El proveedor esta inactivo"; }
                        }
                    }
                }
                if ((o.DiferenciaBalanceo ?? 0) != 0) { sErrorMsg += "\n" + "La orden de pago no balancea"; }
            }
            else
            {
                if (mTipo == "FF")
                {
                    if (mObservaciones.Length == 0) { sErrorMsg += "\n" + "El campo observaciones no puede estar vacio"; }
                    if ((o.IdEmpleadoFF ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el destinatario del fondo"; }
                    if ((o.DiferenciaBalanceo ?? 0) != 0) { sErrorMsg += "\n" + "La orden de pago no balancea"; }
                }
                else
                {
                    if ((o.IdCuenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cuenta contable"; }
                    if (mObservaciones.Length == 0) { sErrorMsg += "\n" + "El campo observaciones no puede estar vacio"; }
                }
            }

            foreach (ProntoMVC.Data.Models.DetalleOrdenesPago x in o.DetalleOrdenesPagoes)
            {
                if (mIdOrdenPago > 0)
                {
                    if (x.IdDetalleOrdenPago > 0 && (x.IdImputacion ?? 0) == -1)
                    {
                        CuentasCorrientesAcreedor CtaCte = db.CuentasCorrientesAcreedores.Where(c => c.IdDetalleOrdenPago == x.IdDetalleOrdenPago).SingleOrDefault();
                        if (CtaCte != null)
                        {
                            if ((CtaCte.ImporteTotal ?? 0) != (CtaCte.Saldo ?? 0)) { sErrorMsg += "\n" + "Hay anticipos que en cuenta corriente tienen aplicado el saldo, no puede modificar esta orden de pago"; }
                        }
                    }
                    oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "OrdenesPago_TX_ValidarNumero", mNumeroOrdenPago, mIdOrdenPago, mTipo, mOrdenPagoExterior);
                    if (oRsAux1 != null)
                    {
                        mFechaOrdenPago = (DateTime)oRsAux1["FechaOrdenPago"];
                        sErrorMsg += "\n" + "El numero de orden de pago ya fue utilizado por una OP del dia " + mFechaOrdenPago.ToString() + ".";
                    }
                }
            }

            foreach (ProntoMVC.Data.Models.DetalleOrdenesPagoValore x in o.DetalleOrdenesPagoValores)
            {
                if ((x.IdCuentaBancaria ?? 0) > 0)
                {
                    CuentasBancaria CuentasBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == x.IdCuentaBancaria).SingleOrDefault();
                    if (CuentasBancaria != null)
                    {
                        if (mIdMoneda != (CuentasBancaria.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay valores con una moneda distinta a la de la orden de pago"; }
                    }
                    else
                    {
                        sErrorMsg += "\n" + "Hay valores que apuntan a cuentas bancarias inexistentes";
                    }
                    if ((x.IdBancoChequera ?? 0) == 0) { 
                        sErrorMsg += "\n" + "Hay valores con cuenta bancaria que no tiene chequera asignada";
                    }
                }
                if ((x.IdBancoChequera ?? 0) > 0)
                {
                    oRsAux1 = EntidadManager.GetStoreProcedureTop1(SC, "DetOrdenesPagoValores_TX_Control", mIdOrdenPago, x.IdBancoChequera, x.NumeroValor);
                    if (oRsAux1 != null)
                    {
                        mNumeroOrdenPagoAux = (Int32)oRsAux1["Numero"];
                        sErrorMsg += "\n" + "El cheque  " + x.NumeroValor.ToString() + " ya existe en la orden de pago " + mNumeroOrdenPagoAux.ToString() + ".";
                    }
                    else
                    {
                        BancoChequera BancoChequera = db.BancoChequeras.Where(c => c.IdBancoChequera == x.IdBancoChequera).SingleOrDefault();
                        if (BancoChequera != null)
                        {
                            if ((x.IdCuentaBancaria ?? 0) != BancoChequera.IdCuentaBancaria) { sErrorMsg += "\n" + "Hay valores que tienen cuentas bancarias con chequeras de otra cuenta"; }
                        }
                        else
                        {
                            sErrorMsg += "\n" + "Hay valores que apuntan a chequeras inexistentes";
                        }
                    }
                    if ((x.IdCuentaBancaria ?? 0) == 0) { sErrorMsg += "\n" + "Hay valores con chequera asignada y sin cuenta bancaria"; }
                }
                if ((x.IdCaja ?? 0) > 0)
                {
                    Caja Caja = db.Cajas.Where(c => c.IdCaja == x.IdCaja).SingleOrDefault();
                    if (Caja != null)
                    {
                        if (mIdMoneda != (Caja.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay una caja con una moneda distinta a la de la orden de pago"; }
                    }
                    if ((x.IdCuentaBancaria ?? 0) > 0 || (x.IdBancoChequera ?? 0) > 0) { sErrorMsg += "\n" + "Hay movimientos de caja que tienen cuenta bancaria o chequera asignada y no deberia"; }
                }
                if ((x.IdValor ?? 0) > 0)
                {
                    Valore Valor = db.Valores.Where(c => c.IdCaja == x.IdCaja).SingleOrDefault();
                    if (Valor != null)
                    {
                        if (mIdMoneda != (Valor.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay un valor de terceros con una moneda distinta a la de la orden de pago"; }
                    }
                    if ((x.IdCuentaBancaria ?? 0) > 0 || (x.IdBancoChequera ?? 0) > 0) { sErrorMsg += "\n" + "Hay endosos de cheques que tienen cuenta bancaria o chequera asignada y no deberia"; }
                }
                mTotalValores += x.Importe ?? 0;
            }

            if (o.DetalleOrdenesPagoCuentas.Count <= 0) sErrorMsg += "\n" + "La orden de pago no tiene registro contable";
            foreach (ProntoMVC.Data.Models.DetalleOrdenesPagoCuenta x in o.DetalleOrdenesPagoCuentas)
            {
                if ((x.IdCuenta ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items de registro contable sin cuenta"; }
            }

            foreach (ProntoMVC.Data.Models.DetalleOrdenesPagoRubrosContable x in o.DetalleOrdenesPagoRubrosContables)
            {
                mTotalRubrosContables += x.Importe ?? 0;
            }
            if (mTotalRubrosContables != mTotalValores) { sErrorMsg += "\n" + "El total de rubros contables asignados debe ser igual al total de valores"; }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(OrdenPago OrdenPago, string IdsGastosFF = "")
        {
            if (!PuedeEditar(enumNodos.OPago)) throw new Exception("No tenés permisos");

            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mCotizacionDolar = 0; 
                decimal mCotizacionEuro = 0;
                decimal mCotizacionMonedaAnterior = 0;
                decimal mImporte = 0;
                decimal mImportePesos = 0;
                decimal mImporteDolares = 0;
                decimal mImporteEuros = 0;
                decimal mSaldoPesos = 0;
                decimal mSaldoDolares = 0;
                decimal mSaldoEuros = 0;
                decimal mNumeroValor = 0;
                decimal mDebe = 0;
                decimal mHaber = 0;
                decimal mDiferencia = 0;

                Int32 mIdOrdenPago = 0;
                Int32 mNumeroOP = 0;
                Int32 mNumeroOP1 = 0;
                Int32 mNumeroOP2 = 0;
                Int32 mNumeroOP3 = 0;
                Int32 mNumeroOP4 = 0;
                Int32 mIdProveedor = 0;
                Int32 mIdImputacion = 0;
                Int32 mIdValor = 0;
                Int32 mIdBanco = 0;
                Int32 mIdCuentaCajaTitulo = 0;
                Int32 mIdMonedaPesos = 1;
                Int32 mIdEjercicioContableControlNumeracion = 1;
                Int32 mIdAux1 = 0;
                Int32 i = 0;
                
                string mIdsComprobanteProveedorRetenidosIva = "";
                string mTotalesImportesRetenidosIva = "";
                string mExterior = "";
                string mTipo = "";
                string mFormaAnulacionCheques = "";
                string mEsCajaBanco = "";
                string[] mAux1;
                string[] mAux2;
                string errs = "";
                string warnings = "";
                string mNumeracionAutomaticaDeOrdenesDePago = "";
                string mNumeracionIndependienteDeOrdenesDePagoFFyCTACTE = "";
                string mNumeracionUnicaDeOrdenesDePago = "";
                
                bool mAnulada = false;
                bool mAsientoManual = false;
                bool mGrabarRegistrosEnCuentaCorriente = true;
                bool mGrabarRegistrosRetenciones = true;
                bool mBorrarEnValores = true;
                bool mExiste = false;

                DateTime mFechaInicioControl;
                
                var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdCuentaCajaTitulo = parametros.IdCuentaCajaTitulo ?? 0;
                mIdMonedaPesos = parametros.IdMoneda ?? 0;
                mNumeroOP1 = parametros.ProximaOrdenPago ?? 1;
                mNumeroOP2 = parametros.ProximaOrdenPagoOtros ?? 1;
                mNumeroOP3 = parametros.ProximaOrdenPagoFF ?? 1;
                mNumeroOP4 = parametros.ProximaOrdenPagoExterior ?? 1;

                if (!Validar(OrdenPago, ref errs, ref warnings))
                {
                    try
                    {
                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    }
                    catch (Exception)
                    {
                    }

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;

                    string[] words = errs.Split('\n');
                    res.Errors = words.ToList();
                    res.Message = "Hay datos invalidos";

                    return Json(res);
                }

                if (ModelState.IsValid)
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        mIdOrdenPago = OrdenPago.IdOrdenPago;
                        mIdProveedor = OrdenPago.IdProveedor ?? 0;
                        mCotizacionMoneda = OrdenPago.CotizacionMoneda ?? 1;
                        mCotizacionDolar = OrdenPago.CotizacionDolar ?? 0;
                        mCotizacionEuro = OrdenPago.CotizacionEuro ?? 0;
                        mFormaAnulacionCheques = OrdenPago.FormaAnulacionCheques ?? "";
                        if ((OrdenPago.AsientoManual ?? "") == "SI") { mAsientoManual = true; }
                        mTipo = OrdenPago.Tipo ?? "";

                        string usuario = ViewBag.NombreUsuario;
                        int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                        if (OrdenPago.IdOrdenPago > 0)
                        {
                            OrdenPago.IdUsuarioModifico = IdUsuario;
                            OrdenPago.FechaModifico = DateTime.Now;
                        }
                        else
                        {
                            OrdenPago.IdUsuarioIngreso = IdUsuario;
                            OrdenPago.FechaIngreso = DateTime.Now;
                        }

                        if (OrdenPago.Anulada == "OK")
                        {
                            mAnulada = true;
                            OrdenPago.Anulada = "SI";
                        }

                        if (mIdProveedor > 0) {
                            var Proveedores = db.Proveedores.Where(p => p.IdProveedor == mIdProveedor).FirstOrDefault();
                            if (Proveedores != null) {
                                if ((Proveedores.RegistrarMovimientosEnCuentaCorriente ?? "SI") == "NO") { mGrabarRegistrosEnCuentaCorriente = false; }
                            }
                        }

                        if (mIdOrdenPago > 0)
                        {
                            var OrdenPagoOriginal = db.OrdenesPago.Where(p => p.IdOrdenPago == mIdOrdenPago).SingleOrDefault();

                            mCotizacionMonedaAnterior = OrdenPagoOriginal.CotizacionMoneda ?? 1;
                            if ((OrdenPago.RecalculoRetencionesUltimaModificacion ?? "SI") == "NO") { mGrabarRegistrosRetenciones = false; }
                            mIdsComprobanteProveedorRetenidosIva = OrdenPagoOriginal.IdsComprobanteProveedorRetenidosIva ?? "";
                            if (mIdsComprobanteProveedorRetenidosIva.Length > 0)
                            {
                                mAux1 = mIdsComprobanteProveedorRetenidosIva.Split('|');
                                foreach (string mIdAux0 in mAux1)
                                {
                                    if (mIdAux0.Length > 0)
                                    {
                                        mIdAux1 = Convert.ToInt32(mIdAux0);
                                        ComprobanteProveedor ComprobantesProveedor = db.ComprobantesProveedor.Where(c => c.IdComprobanteProveedor == mIdAux1).SingleOrDefault();
                                        if (ComprobantesProveedor != null)
                                        {
                                            ComprobantesProveedor.IdOrdenPagoRetencionIva = 0;
                                            ComprobantesProveedor.ImporteRetencionIvaEnOrdenPago = 0;
                                            db.Entry(ComprobantesProveedor).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                }
                            }

                            if (!mAnulada)
                            {
                                mIdsComprobanteProveedorRetenidosIva = OrdenPago.IdsComprobanteProveedorRetenidosIva ?? "";
                                if (mIdsComprobanteProveedorRetenidosIva.Length > 0)
                                {
                                    mAux1 = mIdsComprobanteProveedorRetenidosIva.Split('|');
                                    mAux2 = OrdenPago.TotalesImportesRetenidosIva.Split('|');
                                    foreach (string mIdAux0 in mAux1)
                                    {
                                        if (mIdAux0.Length > 0)
                                        {
                                            mIdAux1 = Convert.ToInt32(mIdAux0);
                                            mImporte = Convert.ToDecimal(mAux2[i].Replace(".", ","));

                                            ComprobanteProveedor ComprobantesProveedor = db.ComprobantesProveedor.Where(c => c.IdComprobanteProveedor == mIdAux1).SingleOrDefault();
                                            if (ComprobantesProveedor != null)
                                            {
                                                ComprobantesProveedor.IdOrdenPagoRetencionIva = mIdOrdenPago;
                                                ComprobantesProveedor.ImporteRetencionIvaEnOrdenPago = mImporte;
                                                db.Entry(ComprobantesProveedor).State = System.Data.Entity.EntityState.Modified;
                                            }
                                        }
                                        i += 1;
                                    }
                                }
                            }
                            else
                            {
                                foreach (var d in OrdenPagoOriginal.DetalleOrdenesPagoValores)
                                {
                                    if (d.IdValor != null)
                                    {
                                        Valore Valores = db.Valores.Where(c => c.IdValor == d.IdValor).SingleOrDefault();
                                        if (Valores != null)
                                        {
                                            Valores.Estado = null;
                                            Valores.IdProveedor = null;
                                            Valores.NumeroOrdenPago = null;
                                            Valores.FechaOrdenPago = null;
                                            db.Entry(Valores).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                    //Pronto.ERP.Bll.EntidadManager.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", d.IdDetalleOrdenPagoValores);
                                    db.Valores_BorrarPorIdDetalleOrdenPagoValores(d.IdDetalleOrdenPagoValores);
                                }
                                foreach (var d in OrdenPagoOriginal.DetalleOrdenesPagoCuentas)
                                {
                                    db.Valores_BorrarPorIdDetalleOrdenPagoCuentas(d.IdDetalleOrdenPagoCuentas);
                                }
                            }
                            
                            var OrdenPagoEntry = db.Entry(OrdenPagoOriginal);
                            OrdenPagoEntry.CurrentValues.SetValues(OrdenPago);

                            // Restiruir los saldos de las imputaciones ya registradas
                            foreach (var d in OrdenPagoOriginal.DetalleOrdenesPagoes.Where(c => c.IdDetalleOrdenPago != 0).ToList())
                            {
                                CuentasCorrientesAcreedor CtaCteAnterior = db.CuentasCorrientesAcreedores.Where(c => c.IdDetalleOrdenPago == d.IdDetalleOrdenPago).FirstOrDefault();
                                if (CtaCteAnterior != null)
                                {
                                    mImportePesos = (CtaCteAnterior.ImporteTotal ?? 0) - (CtaCteAnterior.Saldo ?? 0);
                                    mImporteDolares = (CtaCteAnterior.ImporteTotalDolar ?? 0) - (CtaCteAnterior.SaldoDolar ?? 0);
                                    mImporteEuros = (CtaCteAnterior.ImporteTotalEuro ?? 0) - (CtaCteAnterior.SaldoEuro ?? 0);
                                    mIdImputacion = d.IdImputacion ?? 0;

                                    if (mIdImputacion > 0)
                                    {
                                        CuentasCorrientesAcreedor CtaCteImputadaAnterior = db.CuentasCorrientesAcreedores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                                        if (CtaCteImputadaAnterior != null)
                                        {
                                            CtaCteImputadaAnterior.Saldo += mImportePesos;
                                            CtaCteImputadaAnterior.SaldoDolar += mImporteDolares;
                                            CtaCteImputadaAnterior.SaldoEuro += mImporteEuros;

                                            db.Entry(CtaCteImputadaAnterior).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                    db.Entry(CtaCteAnterior).State = System.Data.Entity.EntityState.Deleted;
                                }

                                var DiferenciasCambios = db.DiferenciasCambios.Where(c => c.IdTipoComprobante == 17 && c.IdRegistroOrigen == d.IdDetalleOrdenPago).ToList();
                                if (DiferenciasCambios != null)
                                {
                                    foreach (DiferenciasCambio dc in DiferenciasCambios)
                                    {
                                        db.Entry(dc).State = System.Data.Entity.EntityState.Deleted;
                                    }
                                }
                            }

                            ////////////////////////////////////////////// IMPUTACIONES //////////////////////////////////////////////
                            foreach (var d in OrdenPago.DetalleOrdenesPagoes)
                            {
                                var DetalleOrdenPagoOriginal = OrdenPagoOriginal.DetalleOrdenesPagoes.Where(c => c.IdDetalleOrdenPago == d.IdDetalleOrdenPago && d.IdDetalleOrdenPago > 0).SingleOrDefault();
                                if (DetalleOrdenPagoOriginal != null)
                                {
                                    var DetalleOrdenPagoEntry = db.Entry(DetalleOrdenPagoOriginal);
                                    DetalleOrdenPagoEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoes.Add(d);
                                }
                            }
                            foreach (var DetalleOrdenPagoOriginal in OrdenPagoOriginal.DetalleOrdenesPagoes.Where(c => c.IdDetalleOrdenPago != 0).ToList())
                            {
                                if (!OrdenPago.DetalleOrdenesPagoes.Any(c => c.IdDetalleOrdenPago == DetalleOrdenPagoOriginal.IdDetalleOrdenPago))
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoes.Remove(DetalleOrdenPagoOriginal);
                                    db.Entry(DetalleOrdenPagoOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                            foreach (var d in OrdenPago.DetalleOrdenesPagoValores)
                            {
                                var DetalleOrdenPagoValoresOriginal = OrdenPagoOriginal.DetalleOrdenesPagoValores.Where(c => c.IdDetalleOrdenPagoValores == d.IdDetalleOrdenPagoValores && d.IdDetalleOrdenPagoValores > 0).SingleOrDefault();
                                if (DetalleOrdenPagoValoresOriginal != null)
                                {
                                    var DetalleOrdenPagoValoresEntry = db.Entry(DetalleOrdenPagoValoresOriginal);
                                    DetalleOrdenPagoValoresEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    //CONTROLAR QUE EL NUMERO DE VALOR DE LA CHEQUERA SEA EL QUE SIGUE. PORQUE EL NUMERO SE ASIGNA EN LA CARGA Y OTRO USUARIO PODRIA HABERLO UTILIZADO.
                                    OrdenPagoOriginal.DetalleOrdenesPagoValores.Add(d);
                                }
                            }
                            foreach (var DetalleOrdenPagoValoresOriginal in OrdenPagoOriginal.DetalleOrdenesPagoValores.Where(c => c.IdDetalleOrdenPagoValores != 0).ToList())
                            {
                                if (!OrdenPago.DetalleOrdenesPagoValores.Any(c => c.IdDetalleOrdenPagoValores == DetalleOrdenPagoValoresOriginal.IdDetalleOrdenPagoValores))
                                {
                                    // Estos son los valores que se eliminaron en la modificacion de la orden de pago.
                                    if (DetalleOrdenPagoValoresOriginal.IdValor != null)
                                    {
                                        Valore Valores = db.Valores.Where(c => c.IdValor == DetalleOrdenPagoValoresOriginal.IdValor).SingleOrDefault();
                                        if (Valores != null)
                                        {
                                            Valores.Estado = null;
                                            Valores.IdProveedor = null;
                                            Valores.NumeroOrdenPago = null;
                                            Valores.FechaOrdenPago = null;
                                            db.Entry(Valores).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                    db.Valores_BorrarPorIdDetalleOrdenPagoValores(DetalleOrdenPagoValoresOriginal.IdDetalleOrdenPagoValores);
                                    
                                    OrdenPagoOriginal.DetalleOrdenesPagoValores.Remove(DetalleOrdenPagoValoresOriginal);
                                    db.Entry(DetalleOrdenPagoValoresOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                            foreach (var d in OrdenPago.DetalleOrdenesPagoCuentas)
                            {
                                var DetalleOrdenPagoCuentasOriginal = OrdenPagoOriginal.DetalleOrdenesPagoCuentas.Where(c => c.IdDetalleOrdenPagoCuentas == d.IdDetalleOrdenPagoCuentas && d.IdDetalleOrdenPagoCuentas > 0).SingleOrDefault();
                                if (DetalleOrdenPagoCuentasOriginal != null)
                                {
                                    var DetalleOrdenPagoCuentasEntry = db.Entry(DetalleOrdenPagoCuentasOriginal);
                                    DetalleOrdenPagoCuentasEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoCuentas.Add(d);
                                }
                            }
                            foreach (var DetalleOrdenPagoCuentasOriginal in OrdenPagoOriginal.DetalleOrdenesPagoCuentas.Where(c => c.IdDetalleOrdenPagoCuentas != 0).ToList())
                            {
                                if (!OrdenPago.DetalleOrdenesPagoCuentas.Any(c => c.IdDetalleOrdenPagoCuentas == DetalleOrdenPagoCuentasOriginal.IdDetalleOrdenPagoCuentas))
                                {
                                    // Estos son los valores que se eliminaron en la modificacion de la orden de pago.
                                    db.Valores_BorrarPorIdDetalleOrdenPagoCuentas(DetalleOrdenPagoCuentasOriginal.IdDetalleOrdenPagoCuentas);

                                    OrdenPagoOriginal.DetalleOrdenesPagoCuentas.Remove(DetalleOrdenPagoCuentasOriginal);
                                    db.Entry(DetalleOrdenPagoCuentasOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// IMPUESTOS //////////////////////////////////////////////
                            foreach (var d in OrdenPago.DetalleOrdenesPagoImpuestos)
                            {
                                var DetalleOrdenPagoImpuestosOriginal = OrdenPagoOriginal.DetalleOrdenesPagoImpuestos.Where(c => c.IdDetalleOrdenPagoImpuestos == d.IdDetalleOrdenPagoImpuestos && d.IdDetalleOrdenPagoImpuestos > 0).SingleOrDefault();
                                if (DetalleOrdenPagoImpuestosOriginal != null)
                                {
                                    var DetalleOrdenPagoImpuestosEntry = db.Entry(DetalleOrdenPagoImpuestosOriginal);
                                    DetalleOrdenPagoImpuestosEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoImpuestos.Add(d);
                                }
                            }
                            foreach (var DetalleOrdenPagoImpuestosOriginal in OrdenPagoOriginal.DetalleOrdenesPagoImpuestos.Where(c => c.IdDetalleOrdenPagoImpuestos != 0).ToList())
                            {
                                if (!OrdenPago.DetalleOrdenesPagoImpuestos.Any(c => c.IdDetalleOrdenPagoImpuestos == DetalleOrdenPagoImpuestosOriginal.IdDetalleOrdenPagoImpuestos))
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoImpuestos.Remove(DetalleOrdenPagoImpuestosOriginal);
                                    db.Entry(DetalleOrdenPagoImpuestosOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// RUBROS CONTABLES //////////////////////////////////////////////
                            foreach (var d in OrdenPago.DetalleOrdenesPagoRubrosContables)
                            {
                                var DetalleOrdenPagoRubrosContablesOriginal = OrdenPagoOriginal.DetalleOrdenesPagoRubrosContables.Where(c => c.IdDetalleOrdenPagoRubrosContables == d.IdDetalleOrdenPagoRubrosContables && d.IdDetalleOrdenPagoRubrosContables > 0).SingleOrDefault();
                                if (DetalleOrdenPagoRubrosContablesOriginal != null)
                                {
                                    var DetalleOrdenPagoRubrosContablesEntry = db.Entry(DetalleOrdenPagoRubrosContablesOriginal);
                                    DetalleOrdenPagoRubrosContablesEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoRubrosContables.Add(d);
                                }
                            }
                            foreach (var DetalleOrdenPagoRubrosContablesOriginal in OrdenPagoOriginal.DetalleOrdenesPagoRubrosContables.Where(c => c.IdDetalleOrdenPagoRubrosContables != 0).ToList())
                            {
                                if (!OrdenPago.DetalleOrdenesPagoRubrosContables.Any(c => c.IdDetalleOrdenPagoRubrosContables == DetalleOrdenPagoRubrosContablesOriginal.IdDetalleOrdenPagoRubrosContables))
                                {
                                    OrdenPagoOriginal.DetalleOrdenesPagoRubrosContables.Remove(DetalleOrdenPagoRubrosContablesOriginal);
                                    db.Entry(DetalleOrdenPagoRubrosContablesOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(OrdenPagoOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            mExterior = OrdenPago.Exterior ?? "";
                            
                            var Parametros2 = db.Parametros2.Where(p => p.Campo == "NumeracionAutomaticaDeOrdenesDePago").FirstOrDefault();
                            if (Parametros2 != null) { mNumeracionAutomaticaDeOrdenesDePago = Parametros2.Valor ?? ""; }

                            Parametros2 = db.Parametros2.Where(p => p.Campo == "NumeracionIndependienteDeOrdenesDePagoFFyCTACTE").FirstOrDefault();
                            if (Parametros2 != null) { mNumeracionIndependienteDeOrdenesDePagoFFyCTACTE = Parametros2.Valor ?? ""; }
                            
                            Parametros2 = db.Parametros2.Where(p => p.Campo == "NumeracionUnicaDeOrdenesDePago").FirstOrDefault();
                            if (Parametros2 != null) { mNumeracionUnicaDeOrdenesDePago = Parametros2.Valor ?? ""; }

                            Parametros2 = db.Parametros2.Where(p => p.Campo == "IdEjercicioContableControlNumeracion").FirstOrDefault();
                            if (Parametros2 != null) { if (Parametros2.Valor.Length > 0) { mIdEjercicioContableControlNumeracion = Convert.ToInt32(Parametros2.Valor); } }
                            mFechaInicioControl = Convert.ToDateTime("01/01/2000");
                            if (mIdEjercicioContableControlNumeracion != 0)
                            {
                                EjerciciosContable EjerciciosContable = db.EjerciciosContables.Where(x => x.IdEjercicioContable == mIdEjercicioContableControlNumeracion).SingleOrDefault();
                                if (EjerciciosContable != null) { mFechaInicioControl = EjerciciosContable.FechaInicio ?? Convert.ToDateTime("01/01/2000"); }
                            }

                            if (mNumeracionUnicaDeOrdenesDePago == "SI")
                            {
                                mNumeroOP = mNumeroOP1;
                            }
                            else
                            {
                                if (mExterior == "SI")
                                {
                                    mNumeroOP = mNumeroOP4;
                                }
                                else
                                {
                                    if (mNumeracionIndependienteDeOrdenesDePagoFFyCTACTE == "SI")
                                    {
                                        if (mTipo == "CC") { mNumeroOP = mNumeroOP1; }
                                        if (mTipo == "FF") { mNumeroOP = mNumeroOP3; }
                                        if (mTipo == "OT") { mNumeroOP = mNumeroOP2; }
                                    }
                                    else
                                    {
                                        if (mTipo == "CC" || mTipo == "FF") { mNumeroOP = mNumeroOP1; }
                                        else { mNumeroOP = mNumeroOP2; }
                                    }
                                }
                            }

                            mExiste = true;
                            for (int n = 1; mExiste; n++)
                            {
                                OrdenPago mAux = db.OrdenesPago.Where(x => x.NumeroOrdenPago == mNumeroOP && x.FechaOrdenPago >= mFechaInicioControl && 
                                                                        (mNumeracionUnicaDeOrdenesDePago=="SI" || 
                                                                         (((mExterior=="SI" && (x.Exterior ?? "")=="SI") || 
                                                                           (mExterior!="SI" &&  (x.Exterior ?? "")!="SI" && 
                                                                            ((mNumeracionIndependienteDeOrdenesDePagoFFyCTACTE=="SI" && x.Tipo==mTipo) || 
                                                                             (mNumeracionIndependienteDeOrdenesDePagoFFyCTACTE!="SI" && 
                                                                              ((mTipo=="CC" && (x.Tipo=="CC" || x.Tipo=="FF")) ||
                                                                               (mTipo=="FF" && (x.Tipo=="CC" || x.Tipo=="FF")) || mTipo==x.Tipo)))))))).FirstOrDefault();
                                if (mAux != null) { mNumeroOP += 1; }
                                else { mExiste = false; }
                            }

                            mExiste = false;
                            if (mNumeracionAutomaticaDeOrdenesDePago == "NO")
                            {
                                OrdenPago mAux = db.OrdenesPago.Where(x => x.NumeroOrdenPago == mNumeroOP && x.FechaOrdenPago >= mFechaInicioControl).FirstOrDefault();
                                if (mAux != null) { mExiste = true; }
                            }

                            if (mNumeracionAutomaticaDeOrdenesDePago == "SI" || mExiste || OrdenPago.NumeroOrdenPago == mNumeroOP)
                            {
                                OrdenPago.NumeroOrdenPago = mNumeroOP;
                                Parametros parametros2 = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                                if (mNumeracionUnicaDeOrdenesDePago == "SI")
                                {
                                    parametros2.ProximaOrdenPago = mNumeroOP + 1;
                                }
                                else
                                {
                                    if (OrdenPago.Exterior == "SI") { parametros2.ProximaOrdenPagoExterior = mNumeroOP + 1; }
                                    else
                                    {
                                        if (mNumeracionIndependienteDeOrdenesDePagoFFyCTACTE == "SI")
                                        {
                                            if (mTipo == "CC") { parametros2.ProximaOrdenPago = mNumeroOP + 1; }
                                            if (mTipo == "FF") { parametros2.ProximaOrdenPagoFF = mNumeroOP + 1; }
                                            if (mTipo == "OT") { parametros2.ProximaOrdenPagoOtros = mNumeroOP + 1; }
                                        }
                                        else
                                        {
                                            if (mTipo == "CC" || mTipo == "FF") { parametros2.ProximaOrdenPago = mNumeroOP + 1; }
                                            else { parametros2.ProximaOrdenPagoOtros = mNumeroOP + 1; }
                                        }
                                    }
                                }
                                db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
                            }
                            db.OrdenesPago.Add(OrdenPago);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// IMPUTACIONES //////////////////////////////////////////////
                        if (!mAnulada && mGrabarRegistrosEnCuentaCorriente)
                        {
                            foreach (var d in OrdenPago.DetalleOrdenesPagoes)
                            {
                                mImporte = d.Importe ?? 0;
                                mImportePesos = mImporte * mCotizacionMoneda;
                                mImporteDolares = 0;
                                if (mCotizacionDolar != 0) { mImporteDolares = decimal.Round(mImporte * mCotizacionMoneda / mCotizacionDolar, 2); }
                                mImporteEuros = 0;
                                if (mCotizacionEuro != 0) { mImporteEuros = decimal.Round(mImporte * mCotizacionMoneda / mCotizacionEuro, 2); }
                                mIdImputacion = d.IdImputacion ?? 0;

                                CuentasCorrientesAcreedor CtaCte = new CuentasCorrientesAcreedor();
                                CtaCte.IdProveedor = OrdenPago.IdProveedor;
                                CtaCte.NumeroComprobante = OrdenPago.NumeroOrdenPago;
                                CtaCte.Fecha = OrdenPago.FechaOrdenPago;
                                CtaCte.FechaVencimiento = OrdenPago.FechaOrdenPago;
                                CtaCte.CotizacionDolar = OrdenPago.CotizacionDolar;
                                CtaCte.CotizacionEuro = OrdenPago.CotizacionEuro;
                                CtaCte.CotizacionMoneda = OrdenPago.CotizacionMoneda;
                                if (d.IdImputacion != -2) { CtaCte.IdTipoComp = 17; } else { CtaCte.IdTipoComp = 16; }
                                CtaCte.IdComprobante = OrdenPago.IdOrdenPago;
                                if (d.IdImputacion > 0) { CtaCte.IdImputacion = d.IdImputacion; }
                                CtaCte.ImporteTotal = mImportePesos;
                                CtaCte.Saldo = mImportePesos;
                                CtaCte.ImporteTotalDolar = mImporteDolares;
                                CtaCte.SaldoDolar = mImporteDolares;
                                CtaCte.ImporteTotalEuro = mImporteEuros;
                                CtaCte.SaldoEuro = mImporteEuros;
                                CtaCte.IdMoneda = OrdenPago.IdMoneda;
                                CtaCte.IdDetalleOrdenPago = d.IdDetalleOrdenPago;
                                CtaCte.IdCtaCte = 0;

                                if (mIdImputacion > 0)
                                {
                                    CuentasCorrientesAcreedor CtaCteImputada = db.CuentasCorrientesAcreedores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                                    if (CtaCteImputada != null)
                                    {
                                        mSaldoPesos = CtaCteImputada.Saldo ?? 0;
                                        mSaldoDolares = CtaCteImputada.SaldoDolar ?? 0;
                                        mSaldoEuros = CtaCteImputada.SaldoEuro ?? 0;
                                    }
                                    else
                                    {
                                        mSaldoPesos = 0;
                                        mSaldoDolares = 0;
                                        mSaldoEuros = 0;
                                    }

                                    if ((OrdenPago.Dolarizada ?? "NO") == "NO")
                                    {
                                        mImporteDolares = 0;
                                        if ((CtaCteImputada.CotizacionDolar ?? 0) != 0) { mImporteDolares = decimal.Round(mImporte * mCotizacionMoneda / (CtaCteImputada.CotizacionDolar ?? 0), 2); }
                                        CtaCte.CotizacionDolar = CtaCteImputada.CotizacionDolar;
                                        CtaCte.ImporteTotalDolar = mImporteDolares;
                                        CtaCte.SaldoDolar = mImporteDolares;

                                        mImporteEuros = 0;
                                        if ((CtaCteImputada.CotizacionEuro ?? 0) != 0) { mImporteEuros = decimal.Round(mImporte * mCotizacionMoneda / (CtaCteImputada.CotizacionEuro ?? 0), 2); }
                                        CtaCte.CotizacionEuro = CtaCteImputada.CotizacionEuro;
                                        CtaCte.ImporteTotalEuro = mImporteEuros;
                                        CtaCte.SaldoEuro = mImporteEuros;
                                    }

                                    if (mImportePesos > mSaldoPesos)
                                    {
                                        mImportePesos = decimal.Round(mImportePesos - mSaldoPesos, 2);
                                        CtaCteImputada.Saldo = 0;
                                        CtaCte.Saldo = mImportePesos;
                                    }
                                    else
                                    {
                                        mSaldoPesos = decimal.Round(mSaldoPesos - mImportePesos, 2);
                                        CtaCteImputada.Saldo = mSaldoPesos;
                                        CtaCte.Saldo = 0;
                                    }
                                    if (mImporteDolares > mSaldoDolares)
                                    {
                                        mImporteDolares = decimal.Round(mImporteDolares - mSaldoDolares, 2);
                                        CtaCteImputada.SaldoDolar = 0;
                                        CtaCte.SaldoDolar = mImporteDolares;
                                    }
                                    else
                                    {
                                        mSaldoDolares = decimal.Round(mSaldoDolares - mImporteDolares, 2);
                                        CtaCteImputada.SaldoDolar = mSaldoDolares;
                                        CtaCte.SaldoDolar = 0;
                                    }
                                    if (mImporteEuros > mSaldoEuros)
                                    {
                                        mImporteEuros = decimal.Round(mImporteEuros - mSaldoEuros, 2);
                                        CtaCteImputada.SaldoEuro = 0;
                                        CtaCte.SaldoEuro = mImporteEuros;
                                    }
                                    else
                                    {
                                        mSaldoEuros = decimal.Round(mSaldoEuros - mImporteEuros, 2);
                                        CtaCteImputada.SaldoEuro = mSaldoEuros;
                                        CtaCte.SaldoEuro = 0;
                                    }
                                    CtaCte.IdImputacion = CtaCteImputada.IdImputacion;

                                    var TiposComprobantes = db.TiposComprobantes.Where(t => t.IdTipoComprobante == CtaCteImputada.IdTipoComp).SingleOrDefault();
                                    if (TiposComprobantes != null)
                                    {
                                        if (TiposComprobantes.Coeficiente == -1) { CtaCte.IdTipoComp = 16; }
                                    }

                                    if (CtaCteImputada.IdTipoComp != 16 && CtaCteImputada.IdTipoComp != 17 && (d.ImporteRetencionIVA ?? 0) != 0)
                                    {
                                        ComprobanteProveedor ComprobantesProveedor = db.ComprobantesProveedor.Where(c => c.IdComprobanteProveedor == CtaCteImputada.IdComprobante).SingleOrDefault();
                                        if (ComprobantesProveedor != null)
                                        {
                                            ComprobantesProveedor.IdDetalleOrdenPagoRetencionIVAAplicada = d.IdDetalleOrdenPago;
                                            db.Entry(ComprobantesProveedor).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                    db.Entry(CtaCteImputada).State = System.Data.Entity.EntityState.Modified;
                                }

                                db.CuentasCorrientesAcreedores.Add(CtaCte);
                                if ((CtaCte.IdImputacion ?? 0) == 0)
                                {
                                    db.SaveChanges();
                                    CtaCte.IdImputacion = CtaCte.IdCtaCte;
                                    db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                }

                                if ((OrdenPago.Dolarizada ?? "NO") == "SI")
                                {
                                    DiferenciasCambio dc = new DiferenciasCambio();
                                    dc.IdDiferenciaCambio = -1;
                                    dc.IdTipoComprobante = 17;
                                    dc.IdRegistroOrigen = d.IdDetalleOrdenPago;
                                    db.DiferenciasCambios.Add(dc);
                                }
                            }
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                        if (!mAnulada)
                        {
                            foreach (var d in OrdenPago.DetalleOrdenesPagoValores)
                            {
                                mBorrarEnValores = true;

                                mIdValor = -1;
                                Valore valor = db.Valores.Where(c => c.IdDetalleOrdenPagoValores == d.IdDetalleOrdenPagoValores).SingleOrDefault();
                                if (valor != null) { mIdValor = valor.IdValor; }

                                if ((d.IdCaja ?? 0) > 0)
                                {
                                    Valore v;
                                    if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                    v.IdTipoValor = d.IdTipoValor;
                                    v.Importe = d.Importe;
                                    v.NumeroComprobante = OrdenPago.NumeroOrdenPago;
                                    v.FechaComprobante = OrdenPago.FechaOrdenPago;
                                    if ((OrdenPago.IdProveedor ?? 0) > 0) { v.IdProveedor = OrdenPago.IdProveedor; }
                                    v.IdTipoComprobante = 17;
                                    v.IdDetalleOrdenPagoValores = d.IdDetalleOrdenPagoValores;
                                    v.IdCaja = d.IdCaja;
                                    v.IdMoneda = OrdenPago.IdMoneda;
                                    v.IdValor = mIdValor;
                                    if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                    mBorrarEnValores = false;
                                }
                                else
                                {
                                    if ((d.IdValor ?? 0) > 0)
                                    {
                                        Valore v = db.Valores.Where(c => c.IdValor == d.IdValor).SingleOrDefault();

                                        v.Estado = "E";
                                        if ((OrdenPago.IdProveedor ?? 0) > 0) { v.IdProveedor = OrdenPago.IdProveedor; }
                                        v.NumeroComprobante = OrdenPago.NumeroOrdenPago;
                                        v.FechaComprobante = OrdenPago.FechaOrdenPago;
                                        db.Entry(v).State = System.Data.Entity.EntityState.Modified;
                                    }
                                    else
                                    {
                                        mNumeroValor = d.NumeroValor ?? 0;
                                        var dopv = db.DetalleOrdenesPagoValores.Where(c => c.IdDetalleOrdenPagoValores == d.IdDetalleOrdenPagoValores).SingleOrDefault();
                                        if (dopv != null) { mNumeroValor = dopv.NumeroValor ?? 0; }

                                        Valore v;
                                        if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                        v.IdTipoValor = d.IdTipoValor;
                                        v.NumeroValor = mNumeroValor;
                                        v.NumeroInterno = d.NumeroInterno;
                                        v.FechaValor = d.FechaVencimiento;
                                        v.IdCuentaBancaria = d.IdCuentaBancaria;
                                        v.IdBanco = d.IdBanco;
                                        v.Importe = d.Importe;
                                        v.NumeroComprobante = OrdenPago.NumeroOrdenPago;
                                        v.FechaComprobante = OrdenPago.FechaOrdenPago;
                                        if ((OrdenPago.IdProveedor ?? 0) > 0) { v.IdProveedor = OrdenPago.IdProveedor; }
                                        v.IdTipoComprobante = 17;
                                        v.IdDetalleOrdenPagoValores = d.IdDetalleOrdenPagoValores;
                                        v.IdMoneda = OrdenPago.IdMoneda;
                                        v.CotizacionMoneda = OrdenPago.CotizacionMoneda;
                                        v.IdUsuarioAnulo = d.IdUsuarioAnulo;
                                        v.FechaAnulacion = d.FechaAnulacion;
                                        v.MotivoAnulacion = d.MotivoAnulacion;
                                        v.IdTarjetaCredito = d.IdTarjetaCredito;
                                        v.Anulado = d.Anulado;
                                        v.IdValor = mIdValor;
                                        if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }

                                        if (mFormaAnulacionCheques != "E") { mBorrarEnValores = false; }

                                        if (mIdValor > 0 && (d.Anulado ?? "") != "SI")
                                        {
                                            var DetalleAsientos = db.DetalleAsientos.Where(c => c.IdValor == mIdValor).ToList();
                                            if (DetalleAsientos != null)
                                            {
                                                foreach (DetalleAsiento da in DetalleAsientos)
                                                {
                                                    da.Debe = null;
                                                    da.Haber = null;
                                                    db.Entry(da).State = System.Data.Entity.EntityState.Modified;
                                                }
                                            }

                                            var DetalleConciliaciones = db.DetalleConciliacionesContables.Where(c => c.IdValor == mIdValor).ToList();
                                            if (DetalleConciliaciones != null)
                                            {
                                                foreach (DetalleConciliacione dc in DetalleConciliaciones)
                                                {
                                                    db.Entry(dc).State = System.Data.Entity.EntityState.Deleted;
                                                }
                                            }
                                        }

                                        if (d.IdDetalleOrdenPagoValores <= 0 && (d.IdBancoChequera ?? 0) > 0)
                                        {
                                            BancoChequera BancoChequera = db.BancoChequeras.Where(c => c.IdBancoChequera == d.IdBancoChequera).SingleOrDefault();
                                            if (BancoChequera != null)
                                            {
                                                if (mNumeroValor >= BancoChequera.ProximoNumeroCheque)
                                                {
                                                    BancoChequera.ProximoNumeroCheque = Convert.ToInt32(mNumeroValor) + 1;
                                                    if (BancoChequera.ProximoNumeroCheque >= BancoChequera.HastaCheque) { BancoChequera.Activa = "NO"; }
                                                    db.Entry(BancoChequera).State = System.Data.Entity.EntityState.Modified;
                                                }
                                            }
                                        }
                                    }
                                }
                                if (mBorrarEnValores) { db.Valores_BorrarPorIdDetalleOrdenPagoValores(d.IdDetalleOrdenPagoValores); }
                            }
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mIdOrdenPago > 0 || mAnulada)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == 17 && c.IdComprobante == mIdOrdenPago).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                        }

                        if (!mAnulada)
                        {
                            foreach (var d in OrdenPago.DetalleOrdenesPagoCuentas)
                            {
                                mDebe += (d.Debe ?? 0) * mCotizacionMoneda;
                                mHaber += (d.Haber ?? 0) * mCotizacionMoneda;
                            }
                            mDiferencia = decimal.Round(mDebe - mHaber, 2);
                            foreach (var d in OrdenPago.DetalleOrdenesPagoCuentas)
                            {
                                mBorrarEnValores = true;

                                if (mDiferencia != 0) {
                                    if ((d.Debe ?? 0) != 0) { 
                                        d.Debe += mDiferencia;
                                        mDiferencia = 0;
                                    }
                                    else if ((d.Haber ?? 0) != 0)
                                    {
                                        d.Haber += mDiferencia;
                                        mDiferencia = 0;
                                    }
                                }
                                Subdiario s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = d.IdCuenta;
                                s.IdTipoComprobante = 17;
                                s.NumeroComprobante = OrdenPago.NumeroOrdenPago;
                                s.FechaComprobante = OrdenPago.FechaOrdenPago;
                                s.IdComprobante = OrdenPago.IdOrdenPago;
                                s.Debe = d.Debe==0 ? null : d.Debe;
                                s.Haber = d.Haber == 0 ? null : d.Haber;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;
                                s.IdDetalleComprobante = d.IdDetalleOrdenPagoCuentas;
                                db.Subdiarios.Add(s);

                                mEsCajaBanco = "";
                                var data = (from a in db.Cuentas
                                            from b in db.TiposCuentaGrupos.Where(o => o.IdTipoCuentaGrupo == a.IdTipoCuentaGrupo).DefaultIfEmpty()
                                            select new { a.IdCuenta, EsCajaBanco = b != null ? b.EsCajaBanco : "" }).Where(x => x.IdCuenta == d.IdCuenta).AsQueryable().FirstOrDefault();
                                if (data != null)
                                {
                                    mEsCajaBanco = data.EsCajaBanco ?? "";
                                }
                                //var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Cuentas_TX_CuentaCajaBanco", d.IdCuenta).AsEnumerable().FirstOrDefault();
                                //if (dt != null)
                                //{
                                //    mEsCajaBanco = (string)dt["EsCajaBanco"] ?? "";
                                //}
                                if (mEsCajaBanco != "BA" && mEsCajaBanco != "CA" && mEsCajaBanco != "TC") { mEsCajaBanco = ""; }

                                if (mEsCajaBanco.Length > 0)
                                {
                                    mIdValor = -1;
                                    Valore valor = db.Valores.Where(c => c.IdDetalleOrdenPagoCuentas == d.IdDetalleOrdenPagoCuentas).SingleOrDefault();
                                    if (valor != null) { mIdValor = valor.IdValor; }

                                    mIdBanco = 0;
                                    if (mEsCajaBanco == "BA" && (d.IdCuentaBancaria ?? 0) > 0)
                                    {
                                        CuentasBancaria CuentasBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == d.IdCuentaBancaria).SingleOrDefault();
                                        if (CuentasBancaria != null) { mIdBanco = CuentasBancaria.IdBanco ?? 0; }
                                    }

                                    Valore v;
                                    if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                    if (mEsCajaBanco == "BA")
                                    {
                                        v.IdTipoValor = 21;
                                        v.IdBanco = mIdBanco;
                                        v.IdCuentaBancaria = d.IdCuentaBancaria;
                                    }
                                    if (mEsCajaBanco == "CA")
                                    {
                                        v.IdTipoValor = 32;
                                        v.IdCaja = d.IdCaja;
                                    }
                                    if (mEsCajaBanco == "TC")
                                    {
                                        v.IdTipoValor = 43;
                                        v.IdTarjetaCredito = d.IdTarjetaCredito;
                                    }
                                    v.NumeroValor = 0;
                                    v.NumeroInterno = 0;
                                    v.FechaValor = OrdenPago.FechaOrdenPago;
                                    v.NumeroComprobante = OrdenPago.NumeroOrdenPago;
                                    v.FechaComprobante = OrdenPago.FechaOrdenPago;
                                    if ((OrdenPago.IdProveedor ?? 0) > 0) { v.IdProveedor = OrdenPago.IdProveedor; }
                                    v.IdTipoComprobante = 17;
                                    v.IdDetalleOrdenPagoCuentas = d.IdDetalleOrdenPagoCuentas;
                                    v.IdMoneda = d.IdMoneda;
                                    if ((d.CotizacionMonedaDestino ?? 0) != 0)
                                    {
                                        if ((d.Debe ?? 0) != 0)
                                        { v.Importe = d.Debe * mCotizacionMoneda / d.CotizacionMonedaDestino * -1; }
                                        else if ((d.Haber ?? 0) != 0)
                                        { v.Importe = d.Haber * mCotizacionMoneda / d.CotizacionMonedaDestino; }
                                        v.CotizacionMoneda = d.CotizacionMonedaDestino;
                                    }
                                    else
                                    {
                                        if ((d.Debe ?? 0) != 0)
                                        { v.Importe = d.Debe * -1; }
                                        else if ((d.Haber ?? 0) != 0)
                                        { v.Importe = d.Haber; }
                                        v.CotizacionMoneda = mCotizacionMoneda;
                                    }
                                    if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                    mBorrarEnValores = false;
                                }
                                if (mBorrarEnValores) { db.Valores_BorrarPorIdDetalleOrdenPagoCuentas(d.IdDetalleOrdenPagoCuentas); }
                            }
                            db.SaveChanges();
                        }

                        ///////////////////////////////////////////// GASTOS FF /////////////////////////////////////////////
                        if (mIdOrdenPago > 0 || mAnulada)
                        {
                            var ComprobantesProveedores = db.ComprobantesProveedor.Where(c => c.IdOrdenPago == mIdOrdenPago).ToList();
                            if (ComprobantesProveedores != null)
                            {
                                foreach (ComprobanteProveedor cp in ComprobantesProveedores)
                                {
                                    cp.IdOrdenPago = null;
                                    db.Entry(cp).State = System.Data.Entity.EntityState.Modified;
                                }
                            }
                        }

                        if (!mAnulada && IdsGastosFF.Length > 0)
                        {
                            char[] delimiterChars = { ',', '.', ':', '\t' };
                            string[] vector = IdsGastosFF.Split(delimiterChars);
                            foreach (string s in vector)
                            {
                                mIdAux1 = Convert.ToInt32(s);
                                ComprobanteProveedor ComprobantesProveedor = db.ComprobantesProveedor.Where(c => c.IdComprobanteProveedor == mIdAux1).SingleOrDefault();
                                if (ComprobantesProveedor != null)
                                {
                                    ComprobantesProveedor.IdOrdenPago = OrdenPago.IdOrdenPago;
                                    db.Entry(ComprobantesProveedor).State = System.Data.Entity.EntityState.Modified;
                                }
                            }
                        }
                        db.SaveChanges();

                        db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.OPagoPorMes.ToString(), OrdenPago.IdOrdenPago, "OrdenPago");



                        scope.Complete();
                        scope.Dispose();
                    }                    



                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdOrdenPago = OrdenPago.IdOrdenPago, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "La orden de pago tiene datos invalidos";

                    return Json(res);
                }
            }

            catch (TransactionAbortedException ex)
            {
                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                Response.TrySkipIisCustomErrors = true;
                return Json("TransactionAbortedException Message: {0}", ex.Message);
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

        public virtual JsonResult GetIdOrdenPagoPorNumero(int NumeroOrdenPago = 0)
        {
            var filtereditems = (from a in db.OrdenesPago
                                 where (a.NumeroOrdenPago == NumeroOrdenPago)
                                 select new
                                 {
                                     id = a.IdOrdenPago,
                                     a.Tipo,
                                     a.Valores
                                 }).ToList();

            return Json(filtereditems, JsonRequestBehavior.AllowGet);
        }

    }
}
