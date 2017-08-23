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
    public partial class ReciboController : ProntoBaseController
    {

        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Recibos)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ActionResult EditCC(int id)
        {
            if (!PuedeLeer(enumNodos.Recibos)) throw new Exception("No tenés permisos");
            if (id == -1)
            {
                Recibo Recibo = new Recibo();

                Recibo.Tipo = "CC";
                inic(ref Recibo);
                CargarViewBag(Recibo);
                return View(Recibo);
            }
            else
            {
                Recibo Recibo = db.Recibos.Find(id);
                CargarViewBag(Recibo);
                return View(Recibo);
            }
        }

        public virtual ActionResult EditOT(int id)
        {
            if (!PuedeLeer(enumNodos.Recibos)) throw new Exception("No tenés permisos");
            if (id == -1)
            {
                Recibo Recibo = new Recibo();

                Recibo.Tipo = "OT";
                inic(ref Recibo);
                CargarViewBag(Recibo);
                return View(Recibo);
            }
            else
            {
                Recibo Recibo = db.Recibos.Find(id);
                CargarViewBag(Recibo);
                return View(Recibo);
            }
        }

        void inic(ref Recibo o)
        {
            Parametros parametros = db.Parametros.Find(1);

            Int32 mIdMonedaDolar;
            Int32 mIdMonedaEuro;

            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            o.FechaIngreso = DateTime.Today;
            o.FechaRecibo = DateTime.Today;
            o.CotizacionMoneda = 1;
            if (o.Tipo == "OT")
            {
                o.TipoOperacionOtros = 0;
            }

            Cotizacione Cotizaciones = db.Cotizaciones.Where(x => x.IdMoneda == mIdMonedaDolar && x.Fecha == DateTime.Today).FirstOrDefault();
            if (Cotizaciones != null) { o.Cotizacion = Cotizaciones.Cotizacion ?? 0; }
        }

        void CargarViewBag(Recibo o)
        {
            ViewBag.IdVendedor = new SelectList(db.Vendedores, "IdVendedor", "Nombre");
            ViewBag.IdCobrador = new SelectList(db.Vendedores, "IdVendedor", "Nombre");
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion",o.IdTipoRetencionGanancia);
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdObra1 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra1);
            ViewBag.IdObra2 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra2);
            ViewBag.IdObra3 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra3);
            ViewBag.IdObra4 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra4);
            ViewBag.IdObra5 = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra5);
            if (o.Tipo=="OT"){
                ViewBag.IdCuenta = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuenta), "IdCuenta", "Descripcion", o.IdCuenta);
            }
            ViewBag.IdCuenta1 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuenta1), "IdCuenta", "Descripcion", o.IdCuenta1);
            ViewBag.IdCuenta2 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuenta2), "IdCuenta", "Descripcion", o.IdCuenta2);
            ViewBag.IdCuenta3 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuenta3), "IdCuenta", "Descripcion", o.IdCuenta3);
            ViewBag.IdCuenta4 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuenta4), "IdCuenta", "Descripcion", o.IdCuenta4);
            ViewBag.IdCuenta5 = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuenta5), "IdCuenta", "Descripcion", o.IdCuenta5);
            ViewBag.IdCuentaGasto = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto);
            ViewBag.IdCuentaGasto1 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto1);
            ViewBag.IdCuentaGasto2 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto2);
            ViewBag.IdCuentaGasto3 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto3);
            ViewBag.IdCuentaGasto4 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto4);
            ViewBag.IdCuentaGasto5 = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto5);
            ViewBag.IdTipoCuentaGrupo = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo1 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo2 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo3 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo4 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdTipoCuentaGrupo5 = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 2), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
            
        }

        private bool Validar(ProntoMVC.Data.Models.Recibo o, ref string sErrorMsg, ref string sWarningMsg)
        {
            Int32 mIdRecibo = 0;
            Int32 mNumeroRecibo = 0;
            Int32 mIdMoneda = 1;
            Int32 mIdCliente = 0;
            Int32 mIdEstado = 0;
            Int32 mPuntoVenta = 0;
            Int32 mIdImputacion = 0;
            
            decimal mTotalRubrosContables = 0;
            decimal mTotalValores = 0;
            decimal mDiferenciaBalanceo = 0;
            decimal mDebe = 0;
            decimal mHaber = 0;

            string mTipo = "";
            string mObservaciones = "";
            string mControlarRubrosContablesEnOP = "SI";
            string mNumeroReciboPagoAutomatico = "NO";

            DateTime mFechaRecibo = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;

            if (!PuedeEditar(enumNodos.Recibos)) sErrorMsg += "\n" + "No tiene permisos de edición";

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;
            mControlarRubrosContablesEnOP = parametros.ControlarRubrosContablesEnOP ?? "SI";
            mNumeroReciboPagoAutomatico = parametros.NumeroReciboPagoAutomatico ?? "NO";

            mIdRecibo = o.IdRecibo;
            mNumeroRecibo = o.NumeroRecibo ?? 0;
            mFechaRecibo = o.FechaRecibo ?? DateTime.MinValue;
            mTipo = o.Tipo;
            mIdMoneda = o.IdMoneda ?? 1;
            mIdCliente = o.IdCliente ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mDiferenciaBalanceo = o.GastosGenerales ?? 0;
            mPuntoVenta = o.PuntoVenta ?? 0;

            if (mNumeroRecibo == 0) sErrorMsg += "\n" + "Falta el número de Recibo";
            if (mFechaRecibo < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha no puede ser anterior a la del ultimo cierre contable"; }
            if ((o.CotizacionMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización de equivalencia a pesos"; }
            if ((o.Cotizacion ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización dolar"; }
            if (mIdMoneda <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }
            if ((o.IdPuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el punto de venta"; }
            if (mPuntoVenta <= 0) { sErrorMsg += "\n" + "Falta el punto de venta"; }
            if ((o.NumeroCertificadoRetencionGanancias ?? 0) != 0 && (o.IdTipoRetencionGanancia ?? 0) == 0) { sErrorMsg += "\n" + "Si ingresa un numero de certificado de retencion ganancias debe indicar una categoria"; }

            if (mNumeroReciboPagoAutomatico == "SI")
            {
                var Recibos = db.Recibos.Where(c => c.PuntoVenta == mPuntoVenta && c.NumeroRecibo == mNumeroRecibo && c.IdRecibo != mIdRecibo).SingleOrDefault();
                if (Recibos != null) { sErrorMsg += "\n" + "Numero de recibo existente"; }
            }
            
            if (mTipo == "CC")
            {
                if (o.DetalleRecibosImputaciones.Count <= 0) sErrorMsg += "\n" + "No hay imputaciones ingresadas";
                if (mDiferenciaBalanceo != 0) { sErrorMsg += "\n" + "Hay diferencia de balanceo en el comprobante (" + mDiferenciaBalanceo + ")"; }

                if (mIdCliente <= 0)
                {
                    sErrorMsg += "\n" + "Falta el cliente";
                }
                else
                {
                    Cliente Cliente = db.Clientes.Where(c => c.IdCliente == mIdCliente).SingleOrDefault();
                    if (Cliente != null)
                    {
                        mIdEstado = Cliente.IdEstado ?? 0;

                        Estados_Proveedore EstadoProveedor = db.Estados_Proveedores.Where(c => c.IdEstado == mIdEstado).SingleOrDefault();
                        if (EstadoProveedor != null)
                        {
                            if ((EstadoProveedor.Activo ?? "") == "NO") { sErrorMsg += "\n" + "El cliente esta inactivo"; }
                        }
                    }
                }

                foreach (ProntoMVC.Data.Models.DetalleRecibo x in o.DetalleRecibosImputaciones)
                {
                    mIdImputacion = x.IdImputacion ?? 0;

                    if (mIdRecibo > 0)
                    {
                        if (x.IdDetalleRecibo > 0 && mIdImputacion == -1)
                        {
                            CuentasCorrientesDeudor CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdDetalleRecibo == x.IdDetalleRecibo).SingleOrDefault();
                            if (CtaCte != null)
                            {
                                if ((CtaCte.ImporteTotal ?? 0) != (CtaCte.Saldo ?? 0)) { sErrorMsg += "\n" + "Hay anticipos que en cuenta corriente tienen aplicado el saldo, no puede modificar este recibo"; }
                            }
                        }
                    }
                    if (mIdImputacion > 0)
                    {
                        CuentasCorrientesDeudor CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                        if (CtaCte != null)
                        {
                            if ((CtaCte.IdCliente ?? 0) != mIdCliente) { sErrorMsg += "\n" + "Hay imputaciones en cuenta corriente que corresponden a otro cliente"; }
                            ProntoMVC.Data.Models.TiposComprobante tc = db.TiposComprobantes.Where(c => c.IdTipoComprobante == CtaCte.IdTipoComp).SingleOrDefault();
                            if (tc != null)
                            {
                                if ((tc.Coeficiente ?? 0) == -1 && (x.Importe ?? 0) > 0) { sErrorMsg += "\n" + "Hay imputaciones en cuenta corriente aplicadas a creditos que deben ser negativas"; }
                            }
                        }
                    }
                }
            }
            else
            {
                if ((o.IdCuenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cuenta contable"; }
                if (mObservaciones.Length == 0) { sErrorMsg += "\n" + "El campo observaciones no puede estar vacio"; }
            }

            foreach (ProntoMVC.Data.Models.DetalleRecibosValore x in o.DetalleRecibosValores)
            {
                if ((x.IdCuentaBancariaTransferencia ?? 0) > 0)
                {
                    CuentasBancaria CuentasBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == x.IdCuentaBancariaTransferencia).SingleOrDefault();
                    if (CuentasBancaria != null)
                    {
                        if (mIdMoneda != (CuentasBancaria.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay transferencias con una moneda distinta a la del recibo"; }
                        // if ((x.IdBancoTransferencia ?? 0) != (CuentasBancaria.IdBanco ?? 0)) { sErrorMsg += "\n" + "Hay transferencias que no tienen indicado el banco destino"; }
                    }
                    else
                    {
                        sErrorMsg += "\n" + "Hay transferencias que apuntan a cuentas bancarias inexistentes";
                    }
                }
                if ((x.IdBanco ?? 0) > 0)
                {
                    if ((x.NumeroInterno ?? 0) == 0) { sErrorMsg += "\n" + "Hay valores sin numero interno"; }
                    if ((x.NumeroValor ?? 0) == 0) { sErrorMsg += "\n" + "Hay valores sin numero de valor"; }
                }
                if ((x.IdCaja ?? 0) > 0)
                {
                    Caja Caja = db.Cajas.Where(c => c.IdCaja == x.IdCaja).SingleOrDefault();
                    if (Caja != null)
                    {
                        if (mIdMoneda != (Caja.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay una caja con una moneda distinta a la del recibo"; }
                    }
                }
                if ((x.IdTarjetaCredito ?? 0) > 0)
                {
                    TarjetasCredito TarjetaCredito = db.TarjetasCreditoes.Where(c => c.IdTarjetaCredito == x.IdTarjetaCredito).SingleOrDefault();
                    if (TarjetaCredito != null)
                    {
                        if (mIdMoneda != (TarjetaCredito.IdMoneda ?? 0)) { sErrorMsg += "\n" + "Hay tarjetas de credito con una moneda distinta a la del recibo"; }
                    }
                    if ((x.NumeroTarjetaCredito ?? "").Length == 0) { sErrorMsg += "\n" + "Hay tarjetas de credito sin numero"; }
                }
                mTotalValores += x.Importe ?? 0;
                if ((x.IdCuentaBancariaTransferencia ?? 0) <= 0 && (x.IdBanco ?? 0) <= 0 && (x.IdCaja ?? 0) <= 0 && (x.IdTarjetaCredito ?? 0) <= 0) { sErrorMsg += "\n" + "Hay valores sin entidad emisora"; }
            }

            if (o.DetalleRecibosCuentas.Count <= 0) sErrorMsg += "\n" + "No hay registro contable";
            foreach (ProntoMVC.Data.Models.DetalleRecibosCuenta x in o.DetalleRecibosCuentas)
            {
                if ((x.IdCuenta ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items de registro contable sin cuenta"; }
                mDebe += x.Debe ?? 0;
                mHaber += x.Haber ?? 0;
            }
            if (mDebe != mHaber) { sErrorMsg += "\n" + "El registro contable no balancea"; }

            if (mControlarRubrosContablesEnOP == "SI")
            {
                foreach (ProntoMVC.Data.Models.DetalleRecibosRubrosContable x in o.DetalleRecibosRubrosContables)
                {
                    if ((x.IdRubroContable ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items de sin rubro contable"; }
                    mTotalRubrosContables += x.Importe ?? 0;
                }
                if (mTotalRubrosContables != mTotalValores) { sErrorMsg += "\n" + "El total de rubros contables asignados debe ser igual al total de valores"; }
            }

            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Recibo Recibo)
        {
            if (!PuedeEditar(enumNodos.Recibos)) throw new Exception("No tenés permisos");

            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mCotizacionDolar = 0;
                decimal mCotizacionEuro = 0;
                decimal mCotizacionMonedaAnterior = 0;
                decimal mImporte = 0;
                decimal mImportePesos = 0;
                decimal mImporteDolares = 0;
                decimal mSaldoPesos = 0;
                decimal mSaldoDolares = 0;
                decimal mNumeroValor = 0;
                decimal mDebe = 0;
                decimal mHaber = 0;
                decimal mDiferencia = 0;

                Int32 mIdRecibo = 0;
                Int32 mIdTipoComprobante = 2;
                Int32 mNumeroRecibo = 0;
                Int32 mNumero = 0;
                Int32 mIdCliente = 0;
                Int32 mIdImputacion = 0;
                Int32 mIdBanco = 0;
                Int32 mIdMonedaPesos = 1;
                Int32 mIdMonedaDolar = 2;
                Int32 mIdTipoComprobanteDocumento = 0;
                Int32 mIdCuentaCajaTitulo = 0;
                Int32 mIdValor = 0;
                Int32 mIdAux1 = 0;
                Int32 i = 0;

                string mTipo = "";
                string[] mAux1;
                string[] mAux2;
                string errs = "";
                string warnings = "";
                string mProntoIni = "";
                string mPermitirModificarNumeroRecibo = "";
                string mPermitirRepetirNumeroRecibo = "";
                string mNumeroReciboPagoAutomatico = "";

                bool mAnulado = false;
                bool mAsientoManual = false;
                bool mExiste = false;
                bool mBorrarEnValores = false;
                bool mProcesa = false;
                bool mLlevarAPesosEnValores = false;

                DateTime mFechaInicioControl;

                var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdMonedaPesos = parametros.IdMoneda ?? 1;
                mIdMonedaDolar = parametros.IdMonedaDolar ?? 2;
                mNumeroReciboPagoAutomatico = parametros.NumeroReciboPagoAutomatico ?? "";
                mIdCuentaCajaTitulo = parametros.IdCuentaCajaTitulo ?? 0;

                var Parametros2 = db.Parametros2.Where(p => p.Campo == "IdTipoComprobanteDocumento").FirstOrDefault();
                if (Parametros2 != null) { if (Parametros2.Valor.Length > 0) { mIdTipoComprobanteDocumento = Convert.ToInt32(Parametros2.Valor ?? "0"); } }

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (Recibo.IdRecibo > 0)
                {
                    Recibo.IdUsuarioModifico = IdUsuario;
                    Recibo.FechaModifico = DateTime.Now;
                }
                else
                {
                    Recibo.IdUsuarioIngreso = IdUsuario;
                    Recibo.FechaIngreso = DateTime.Now;
                }

                if (!Validar(Recibo, ref errs, ref warnings))
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
                        mIdRecibo = Recibo.IdRecibo;
                        mIdCliente = Recibo.IdCliente ?? 0;
                        mCotizacionMoneda = Recibo.CotizacionMoneda ?? 1;
                        mCotizacionDolar = Recibo.Cotizacion ?? 0;
                        if ((Recibo.AsientoManual ?? "") == "SI") { mAsientoManual = true; }
                        mTipo = Recibo.Tipo ?? "";

                        if (Recibo.Anulado == "SI") { mAnulado = true; }

                        if (mIdRecibo > 0)
                        {
                            var EntidadOriginal = db.Recibos.Where(p => p.IdRecibo == mIdRecibo).SingleOrDefault();

                            mCotizacionMonedaAnterior = EntidadOriginal.CotizacionMoneda ?? 1;

                            // ver que hacer cuando se anula el recibo

                            var EntidadEntry = db.Entry(EntidadOriginal);
                            EntidadEntry.CurrentValues.SetValues(Recibo);

                            // Restiruir los saldos de las imputaciones ya registradas
                            foreach (var d in EntidadOriginal.DetalleRecibosImputaciones.Where(c => c.IdDetalleRecibo != 0).ToList())
                            {
                                CuentasCorrientesDeudor CtaCteAnterior = db.CuentasCorrientesDeudores.Where(c => c.IdDetalleRecibo == d.IdDetalleRecibo).FirstOrDefault();
                                if (CtaCteAnterior != null)
                                {
                                    mImportePesos = (CtaCteAnterior.ImporteTotal ?? 0) - (CtaCteAnterior.Saldo ?? 0);
                                    mImporteDolares = (CtaCteAnterior.ImporteTotalDolar ?? 0) - (CtaCteAnterior.SaldoDolar ?? 0);
                                    mIdImputacion = d.IdImputacion ?? 0;

                                    if (mIdImputacion > 0)
                                    {
                                        CuentasCorrientesDeudor CtaCteImputadaAnterior = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                                        if (CtaCteImputadaAnterior != null)
                                        {
                                            CtaCteImputadaAnterior.Saldo += mImportePesos;
                                            CtaCteImputadaAnterior.SaldoDolar += mImporteDolares;

                                            db.Entry(CtaCteImputadaAnterior).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                    db.Entry(CtaCteAnterior).State = System.Data.Entity.EntityState.Deleted;
                                }

                                var DiferenciasCambios = db.DiferenciasCambios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdRegistroOrigen == d.IdDetalleRecibo).ToList();
                                if (DiferenciasCambios != null)
                                {
                                    foreach (DiferenciasCambio dc in DiferenciasCambios)
                                    {
                                        db.Entry(dc).State = System.Data.Entity.EntityState.Deleted;
                                    }
                                }
                            }

                            ////////////////////////////////////////////// IMPUTACIONES //////////////////////////////////////////////
                            foreach (var d in Recibo.DetalleRecibosImputaciones)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleRecibosImputaciones.Where(c => c.IdDetalleRecibo == d.IdDetalleRecibo && d.IdDetalleRecibo > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleRecibosImputaciones.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleRecibosImputaciones.Where(c => c.IdDetalleRecibo != 0).ToList())
                            {
                                if (!Recibo.DetalleRecibosImputaciones.Any(c => c.IdDetalleRecibo == DetalleEntidadOriginal.IdDetalleRecibo))
                                {
                                    EntidadOriginal.DetalleRecibosImputaciones.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                            foreach (var d in Recibo.DetalleRecibosValores)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleRecibosValores.Where(c => c.IdDetalleReciboValores == d.IdDetalleReciboValores && d.IdDetalleReciboValores > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {

                                    if ((d.NumeroInterno ?? 0) > 0)
                                    {
                                        mIdAux1 = parametros.ProximoNumeroInterno ?? 1;
                                        d.NumeroInterno = mIdAux1;
                                        parametros.ProximoNumeroInterno = mIdAux1 + 1;
                                        db.Entry(parametros).State = System.Data.Entity.EntityState.Modified;
                                    }
                                    EntidadOriginal.DetalleRecibosValores.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleRecibosValores.Where(c => c.IdDetalleReciboValores != 0).ToList())
                            {
                                if (!Recibo.DetalleRecibosValores.Any(c => c.IdDetalleReciboValores == DetalleEntidadOriginal.IdDetalleReciboValores))
                                {
                                    EntidadOriginal.DetalleRecibosValores.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                            foreach (var d in Recibo.DetalleRecibosCuentas)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleRecibosCuentas.Where(c => c.IdDetalleReciboCuentas == d.IdDetalleReciboCuentas && d.IdDetalleReciboCuentas > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleRecibosCuentas.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleRecibosCuentas.Where(c => c.IdDetalleReciboCuentas != 0).ToList())
                            {
                                if (!Recibo.DetalleRecibosCuentas.Any(c => c.IdDetalleReciboCuentas == DetalleEntidadOriginal.IdDetalleReciboCuentas))
                                {
                                    EntidadOriginal.DetalleRecibosCuentas.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// RUBROS CONTABLES //////////////////////////////////////////////
                            foreach (var d in Recibo.DetalleRecibosRubrosContables)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleRecibosRubrosContables.Where(c => c.IdDetalleReciboRubrosContables == d.IdDetalleReciboRubrosContables && d.IdDetalleReciboRubrosContables > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleRecibosRubrosContables.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleRecibosRubrosContables.Where(c => c.IdDetalleReciboRubrosContables != 0).ToList())
                            {
                                if (!Recibo.DetalleRecibosRubrosContables.Any(c => c.IdDetalleReciboRubrosContables == DetalleEntidadOriginal.IdDetalleReciboRubrosContables))
                                {
                                    EntidadOriginal.DetalleRecibosRubrosContables.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            mPermitirModificarNumeroRecibo = BuscarClaveINI("Permitir modificar el numero de recibo", -1) ?? "";
                            mPermitirRepetirNumeroRecibo = BuscarClaveINI("Permitir repetir numeros de recibo", -1) ?? "";

                            if (mNumeroReciboPagoAutomatico == "SI")
                            {
                                ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == Recibo.IdPuntoVenta).SingleOrDefault();
                                if (PuntoVenta != null)
                                {
                                    mNumero = PuntoVenta.ProximoNumero ?? 1;
                                    if (mPermitirRepetirNumeroRecibo != "SI")
                                    {
                                        mExiste = true;
                                        while (mExiste)
                                        {
                                            var Recibos = db.Recibos.Where(c => c.IdPuntoVenta == Recibo.IdPuntoVenta && c.NumeroRecibo == mNumero).SingleOrDefault();
                                            if (Recibos != null) { mNumero++; }
                                            else { mExiste = false; }
                                        }
                                        if (mNumero > 0 && (mPermitirModificarNumeroRecibo != "SI" || mNumeroRecibo <= mNumero))
                                        {
                                            Recibo.NumeroRecibo = mNumero;
                                            PuntoVenta.ProximoNumero = mNumero + 1;
                                            db.Entry(PuntoVenta).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                }
                            }

                            db.Recibos.Add(Recibo);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// IMPUTACIONES //////////////////////////////////////////////
                        if (!mAnulado)
                        {
                            foreach (var d in Recibo.DetalleRecibosImputaciones)
                            {
                                mImporte = Math.Abs(d.Importe ?? 0);
                                mImportePesos = mImporte * mCotizacionMoneda;
                                mImporteDolares = 0;
                                if (mCotizacionDolar != 0) { mImporteDolares = decimal.Round(mImporte * mCotizacionMoneda / mCotizacionDolar, 2); }
                                mIdImputacion = d.IdImputacion ?? 0;

                                CuentasCorrientesDeudor CtaCte = new CuentasCorrientesDeudor();
                                CtaCte.IdCliente = Recibo.IdCliente;
                                CtaCte.NumeroComprobante = Recibo.NumeroRecibo;
                                CtaCte.Fecha = Recibo.FechaRecibo;
                                CtaCte.FechaVencimiento = Recibo.FechaRecibo;
                                CtaCte.Cotizacion = Recibo.Cotizacion;
                                CtaCte.CotizacionMoneda = Recibo.CotizacionMoneda;
                                CtaCte.IdTipoComp = mIdTipoComprobante; // if (d.IdImputacion != -2) { CtaCte.IdTipoComp = mIdTipoComprobante; } else { CtaCte.IdTipoComp = 16; }
                                CtaCte.IdComprobante = Recibo.IdRecibo;
                                if (d.IdImputacion > 0) { CtaCte.IdImputacion = d.IdImputacion; }
                                CtaCte.ImporteTotal = mImportePesos;
                                CtaCte.Saldo = mImportePesos;
                                CtaCte.ImporteTotalDolar = mImporteDolares;
                                CtaCte.SaldoDolar = mImporteDolares;
                                CtaCte.IdMoneda = Recibo.IdMoneda;
                                CtaCte.IdDetalleRecibo = d.IdDetalleRecibo;
                                CtaCte.IdCtaCte = 0;

                                if (mIdImputacion > 0)
                                {
                                    CuentasCorrientesDeudor CtaCteImputada = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdImputacion).SingleOrDefault();
                                    if (CtaCteImputada != null)
                                    {
                                        mSaldoPesos = CtaCteImputada.Saldo ?? 0;
                                        mSaldoDolares = CtaCteImputada.SaldoDolar ?? 0;
                                    }
                                    else
                                    {
                                        mSaldoPesos = 0;
                                        mSaldoDolares = 0;
                                    }

                                    if ((Recibo.Dolarizada ?? "NO") == "NO")
                                    {
                                        mImporteDolares = 0;
                                        if ((CtaCteImputada.Cotizacion ?? 0) != 0) { mImporteDolares = decimal.Round(mImporte * mCotizacionMoneda / (CtaCteImputada.Cotizacion ?? 0), 2); }
                                        CtaCte.Cotizacion = CtaCteImputada.Cotizacion;
                                        CtaCte.ImporteTotalDolar = mImporteDolares;
                                        CtaCte.SaldoDolar = mImporteDolares;
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
                                    CtaCte.IdImputacion = CtaCteImputada.IdImputacion;

                                    var TiposComprobantes = db.TiposComprobantes.Where(t => t.IdTipoComprobante == CtaCteImputada.IdTipoComp).SingleOrDefault();
                                    if (TiposComprobantes != null)
                                    {
                                        if (TiposComprobantes.Coeficiente == -1) { CtaCte.IdTipoComp = 16; }
                                    }

                                    db.Entry(CtaCteImputada).State = System.Data.Entity.EntityState.Modified;
                                }

                                db.CuentasCorrientesDeudores.Add(CtaCte);
                                if ((CtaCte.IdImputacion ?? 0) == 0)
                                {
                                    db.SaveChanges();
                                    CtaCte.IdImputacion = CtaCte.IdCtaCte;
                                    db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                }

                                if ((Recibo.Dolarizada ?? "NO") == "SI")
                                {
                                    DiferenciasCambio dc = new DiferenciasCambio();
                                    dc.IdDiferenciaCambio = -1;
                                    dc.IdTipoComprobante = mIdTipoComprobante;
                                    dc.IdRegistroOrigen = d.IdDetalleRecibo;
                                    db.DiferenciasCambios.Add(dc);
                                }
                            }
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                        if (!mAnulado)
                        {
                            foreach (var d in Recibo.DetalleRecibosValores)
                            {
                                if (mIdRecibo > 0)
                                {
                                    if ((d.IdTipoValor ?? 0) == mIdTipoComprobanteDocumento)
                                    {
                                        CuentasCorrientesDeudor CtaCteImputada = db.CuentasCorrientesDeudores.Where(c => c.IdComprobante == d.IdDetalleReciboValores && c.IdTipoComp == d.IdTipoValor).SingleOrDefault();
                                        if (CtaCteImputada != null) { db.Entry(CtaCteImputada).State = System.Data.Entity.EntityState.Deleted; }
                                    }
                                }
                                
                                mBorrarEnValores = true;

                                mIdValor = -1;
                                Valore valor = db.Valores.Where(c => c.IdDetalleReciboValores == d.IdDetalleReciboValores).SingleOrDefault();
                                if (valor != null) { mIdValor = valor.IdValor; }
                                Valore v;
                                if (mIdValor <= 0) { v = new Valore(); } else { v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault(); }

                                if ((d.IdCaja ?? 0) > 0)
                                {
                                    v.IdTipoValor = d.IdTipoValor;
                                    v.Importe = d.Importe;
                                    v.NumeroComprobante = Recibo.NumeroRecibo;
                                    v.FechaComprobante = Recibo.FechaRecibo;
                                    if ((Recibo.IdCliente ?? 0) > 0) { v.IdCliente = Recibo.IdCliente; }
                                    v.IdTipoComprobante = mIdTipoComprobante;
                                    v.IdDetalleReciboValores = d.IdDetalleReciboValores;
                                    v.IdCaja = d.IdCaja;
                                    v.IdMoneda = Recibo.IdMoneda;
                                    v.CotizacionMoneda = Recibo.CotizacionMoneda;
                                    v.IdValor = mIdValor;
                                    if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                    mBorrarEnValores = false;
                                }
                                else
                                {
                                    if ((d.IdTarjetaCredito ?? 0) > 0)
                                    {
                                        v.IdTipoValor = d.IdTipoValor;
                                        v.Importe = d.Importe;
                                        v.NumeroComprobante = Recibo.NumeroRecibo;
                                        v.FechaComprobante = Recibo.FechaRecibo;
                                        if ((Recibo.IdCliente ?? 0) > 0) { v.IdCliente = Recibo.IdCliente; }
                                        v.IdTipoComprobante = mIdTipoComprobante;
                                        v.IdDetalleReciboValores = d.IdDetalleReciboValores;
                                        v.IdTarjetaCredito = d.IdTarjetaCredito;
                                        v.IdMoneda = Recibo.IdMoneda;
                                        v.CotizacionMoneda = Recibo.CotizacionMoneda;
                                        v.NumeroTarjetaCredito = d.NumeroTarjetaCredito;
                                        v.NumeroAutorizacionTarjetaCredito = d.NumeroAutorizacionTarjetaCredito;
                                        v.CantidadCuotas = d.CantidadCuotas;
                                        v.FechaExpiracionTarjetaCredito = d.FechaExpiracionTarjetaCredito;
                                        v.NumeroValor = d.NumeroValor;
                                        v.IdValor = mIdValor;
                                        if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                        mBorrarEnValores = false;
                                    }
                                    else
                                    {
                                        mProcesa = true;
                                        mLlevarAPesosEnValores = false;
                                        var TipoComprobante = db.TiposComprobantes.Where(p => p.IdTipoComprobante == d.IdTipoValor).FirstOrDefault();
                                        if (TipoComprobante != null)
                                        {
                                            if ((TipoComprobante.VaAConciliacionBancaria ?? "") == "NO") { mProcesa = false; }
                                            if ((TipoComprobante.LlevarAPesosEnValores ?? "") == "SI") { mLlevarAPesosEnValores = true; }
                                        }

                                        if (mProcesa)
                                        {
                                            v.IdTipoValor = d.IdTipoValor;
                                            v.NumeroComprobante = Recibo.NumeroRecibo;
                                            v.FechaComprobante = Recibo.FechaRecibo;
                                            if ((Recibo.IdCliente ?? 0) > 0) { v.IdCliente = Recibo.IdCliente; }
                                            v.IdTipoComprobante = mIdTipoComprobante;
                                            v.IdDetalleReciboValores = d.IdDetalleReciboValores;
                                            v.IdValor = mIdValor;
                                            if (d.IdCuentaBancariaTransferencia != null)
                                            {
                                                v.Estado = "D";
                                                v.IdCuentaBancariaDeposito = d.IdCuentaBancariaTransferencia;
                                                v.IdBancoDeposito = d.IdBancoTransferencia;
                                                v.FechaDeposito = Recibo.FechaRecibo;
                                                v.NumeroDeposito = d.NumeroTransferencia;
                                            }
                                            else
                                            {
                                                v.NumeroValor = d.NumeroValor;
                                                v.NumeroInterno = d.NumeroInterno;
                                                v.FechaValor = d.FechaVencimiento;
                                                v.IdBanco = d.IdBanco;
                                                v.CuitLibrador = d.CuitLibrador;
                                            }
                                            if (mLlevarAPesosEnValores)
                                            {
                                                v.Importe = d.Importe * Recibo.CotizacionMoneda;
                                                v.IdMoneda = mIdMonedaPesos;
                                                v.CotizacionMoneda = 1;
                                            }
                                            else
                                            {
                                                v.Importe = d.Importe;
                                                v.IdMoneda = Recibo.IdMoneda;
                                                v.CotizacionMoneda = Recibo.CotizacionMoneda;
                                            }
                                            if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                                            mBorrarEnValores = false;
                                        }
                                    }
                                }
                                if (mBorrarEnValores)
                                {
                                    Valore Valor = db.Valores.Where(c => c.IdDetalleReciboValores == d.IdDetalleReciboValores).FirstOrDefault();
                                    if (Valor != null) { db.Entry(Valor).State = System.Data.Entity.EntityState.Deleted; }
                                }

                            
               //If DetallesValores.Fields("IdTipoValor").Value = mvarIdTipoComprobanteDocumento Then
               //   Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesD", "_Struc")
               //   Set DatosCtaCteNv = CopiarRs(DatosCtaCte)
               //   DatosCtaCte.Close
               //   Set DatosCtaCte = Nothing
               //   With DatosCtaCteNv
               //      Set DatosCtaCte = oDet.TraerFiltrado("CtasCtesD", "_BuscarComprobante", Array(mIdDetalleReciboValores, DetallesValores.Fields("IdTipoValor").Value))
               //      If DatosCtaCte.RecordCount > 0 Then
               //         .Fields(0).Value = DatosCtaCte.Fields(0).Value
               //         mvarIdImputacion = IIf(IsNull(DatosCtaCte.Fields("IdImputacion").Value), 0, DatosCtaCte.Fields("IdImputacion").Value)
               //         Sdo = IIf(IsNull(DatosCtaCte.Fields("ImporteTotal").Value), 0, DatosCtaCte.Fields("ImporteTotal").Value) - _
               //               IIf(IsNull(DatosCtaCte.Fields("Saldo").Value), 0, DatosCtaCte.Fields("Saldo").Value)
               //         SdoDol = IIf(IsNull(DatosCtaCte.Fields("ImporteTotalDolar").Value), 0, DatosCtaCte.Fields("ImporteTotalDolar").Value) - _
               //                  IIf(IsNull(DatosCtaCte.Fields("SaldoDolar").Value), 0, DatosCtaCte.Fields("SaldoDolar").Value)
               //      Else
               //         .Fields(0).Value = -1
               //         mvarIdImputacion = 0
               //         Sdo = 0
               //         SdoDol = 0
               //      End If
               //      DatosCtaCte.Close
               //      Set DatosCtaCte = Nothing

               //      Tot = Round(Abs(DetallesValores.Fields("Importe").Value) * mvarCotizacionMoneda, 2)
               //      TotDol = Round(Abs(DetallesValores.Fields("Importe").Value) * mvarCotizacionMoneda / mvarCotizacion, 2)
               //      .Fields("IdCliente").Value = Recibo.Fields("IdCliente").Value
               //      .Fields("NumeroComprobante").Value = DetallesValores.Fields("NumeroInterno").Value
               //      .Fields("Fecha").Value = Recibo.Fields("FechaRecibo").Value
               //      .Fields("FechaVencimiento").Value = DetallesValores.Fields("FechaVencimiento").Value
               //      .Fields("IdTipoComp").Value = DetallesValores.Fields("IdTipoValor").Value
               //      .Fields("IdComprobante").Value = mIdDetalleReciboValores
               //      .Fields("ImporteTotal").Value = Tot
               //      .Fields("Saldo").Value = Round(Tot - Sdo, 2)
               //      .Fields("Cotizacion").Value = mvarCotizacion
               //      .Fields("ImporteTotalDolar").Value = TotDol
               //      .Fields("SaldoDolar").Value = Round(TotDol - SdoDol, 2)
               //      .Fields("IdMoneda").Value = Recibo.Fields("IdMoneda").Value
               //      .Fields("CotizacionMoneda").Value = Recibo.Fields("CotizacionMoneda").Value
               //      If mvarIdImputacion <> 0 Then .Fields("IdImputacion").Value = mvarIdImputacion
               //   End With
               //   Resp = oDet.Guardar("CtasCtesD", DatosCtaCteNv)
               //   If mvarIdImputacion = 0 Then
               //      DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
               //      DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
               //      Resp = oDet.Guardar("CtasCtesD", DatosCtaCteNv)
               //   End If
               //   DatosCtaCteNv.Close
               //   Set DatosCtaCteNv = Nothing
               //End If
                            
                            }
                        }
                        else
                        {
                            foreach (var d in Recibo.DetalleRecibosValores)
                            {
                                Valore Valor = db.Valores.Where(c => c.IdDetalleReciboValores == d.IdDetalleReciboValores).FirstOrDefault();
                                if (Valor != null) { db.Entry(Valor).State = System.Data.Entity.EntityState.Deleted; }
                            }
                        }

                        db.SaveChanges();

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mIdRecibo > 0 || mAnulado)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == 2 && c.IdComprobante == mIdRecibo).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                        }

                        if (!mAnulado)
                        {
                            foreach (var d in Recibo.DetalleRecibosCuentas)
                            {
                                mDebe += (d.Debe ?? 0) * mCotizacionMoneda;
                                mHaber += (d.Haber ?? 0) * mCotizacionMoneda;
                            }
                            mDiferencia = decimal.Round(mDebe - mHaber, 2);
                            foreach (var d in Recibo.DetalleRecibosCuentas)
                            {
                                if (mDiferencia != 0)
                                {
                                    if ((d.Debe ?? 0) != 0)
                                    {
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
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Recibo.NumeroRecibo;
                                s.FechaComprobante = Recibo.FechaRecibo;
                                s.IdComprobante = Recibo.IdRecibo;
                                s.Debe = d.Debe == 0 ? null : d.Debe;
                                s.Haber = d.Haber == 0 ? null : d.Haber;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;
                                s.IdDetalleComprobante = d.IdDetalleReciboCuentas;
                                db.Subdiarios.Add(s);

                            
                            
                            
                            
                            
                            
               //If Not IsNull(DetallesCuentas.Fields("Haber").Value) And DetallesCuentas.Fields("Haber").Value <> 0 Then
               //   Set oRsAux = oDet.TraerFiltrado("Cuentas", "_CuentaCajaBanco", .Fields("IdCuenta").Value)
               //   If oRsAux.RecordCount > 0 Then
               //      mvarEsCajaBanco = ""
               //      If Not IsNull(oRsAux.Fields("EsCajaBanco").Value) And (oRsAux.Fields("EsCajaBanco").Value = "BA" Or oRsAux.Fields("EsCajaBanco").Value = "CA") Then
               //         mvarEsCajaBanco = oRsAux.Fields("EsCajaBanco").Value
               //         oRsAux.Close
               //      End If
               //      If Len(mvarEsCajaBanco) > 0 Then
               //         mIdValor = -1
               //         Set oRsAux = oDet.TraerFiltrado("Valores", "_PorIdDetalleReciboCuentas", mvarIdDetalleReciboCuentas)
               //         If oRsAux.RecordCount > 0 Then
               //            mIdValor = oRsAux.Fields(0).Value
               //         End If
               //         oRsAux.Close
                        
               //         mvarIdBanco = 0
               //         If mvarEsCajaBanco = "BA" And Not IsNull(.Fields("IdCuentaBancaria").Value) Then
               //            Set oRsAux = oDet.TraerFiltrado("CuentasBancarias", "_PorId", .Fields("IdCuentaBancaria").Value)
               //            If oRsAux.RecordCount > 0 Then
               //               mvarIdBanco = oRsAux.Fields("IdBanco").Value
               //            End If
               //         End If
                        
               //         Set oRsValores = oDet.TraerFiltrado("Valores", "_Struc")
               //         Set oRsValoresNv = CopiarRs(oRsValores)
               //         oRsValores.Close
               //         Set oRsValores = Nothing
               //         With oRsValoresNv
               //            If mvarEsCajaBanco = "BA" Then
               //               .Fields("IdTipoValor").Value = 21
               //               .Fields("IdBanco").Value = mvarIdBanco
               //               .Fields("IdCuentaBancaria").Value = DetallesCuentas.Fields("IdCuentaBancaria").Value
               //            Else
               //               .Fields("IdTipoValor").Value = 33
               //               .Fields("IdCaja").Value = DetallesCuentas.Fields("IdCaja").Value
               //            End If
               //            .Fields("NumeroValor").Value = 0
               //            .Fields("NumeroInterno").Value = 0
               //            .Fields("FechaValor").Value = Recibo.Fields("FechaRecibo").Value
               //            If Not IsNull(DetallesCuentas.Fields("CotizacionMonedaDestino").Value) And DetallesCuentas.Fields("CotizacionMonedaDestino").Value <> 0 Then
               //               If Not IsNull(DetallesCuentas.Fields("Debe").Value) And DetallesCuentas.Fields("Debe").Value <> 0 Then
               //                  .Fields("Importe").Value = (DetallesCuentas.Fields("Debe").Value * _
               //                                              Recibo.Fields("CotizacionMoneda").Value) / _
               //                                              DetallesCuentas.Fields("CotizacionMonedaDestino").Value
               //               End If
               //               If Not IsNull(DetallesCuentas.Fields("Haber").Value) And DetallesCuentas.Fields("Haber").Value <> 0 Then
               //                  .Fields("Importe").Value = (DetallesCuentas.Fields("Haber").Value * _
               //                                              Recibo.Fields("CotizacionMoneda").Value) / _
               //                                              DetallesCuentas.Fields("CotizacionMonedaDestino").Value * -1
               //               End If
               //               .Fields("CotizacionMoneda").Value = DetallesCuentas.Fields("CotizacionMonedaDestino").Value
               //            Else
               //               If Not IsNull(DetallesCuentas.Fields("Debe").Value) And DetallesCuentas.Fields("Debe").Value <> 0 Then
               //                  .Fields("Importe").Value = DetallesCuentas.Fields("Debe").Value
               //               End If
               //               If Not IsNull(DetallesCuentas.Fields("Haber").Value) And DetallesCuentas.Fields("Haber").Value <> 0 Then
               //                  .Fields("Importe").Value = DetallesCuentas.Fields("Haber").Value * -1
               //               End If
               //               .Fields("CotizacionMoneda").Value = Recibo.Fields("CotizacionMoneda").Value
               //            End If
               //            .Fields("NumeroComprobante").Value = Recibo.Fields("NumeroRecibo").Value
               //            .Fields("FechaComprobante").Value = Recibo.Fields("FechaRecibo").Value
               //            If Not IsNull(Recibo.Fields("IdCliente").Value) Then
               //               .Fields("IdCliente").Value = Recibo.Fields("IdCliente").Value
               //            End If
               //            .Fields("IdTipoComprobante").Value = 2
               //            .Fields("IdDetalleReciboCuentas").Value = mvarIdDetalleReciboCuentas
               //            .Fields("IdMoneda").Value = DetallesCuentas.Fields("IdMoneda").Value
               //            .Fields(0).Value = mIdValor
               //         End With
               //         Resp = oDet.Guardar("Valores", oRsValoresNv)
               //         oRsValoresNv.Close
               //         Set oRsValoresNv = Nothing
               //      End If
               //   Else
               //      oRsAux.Close
               //   End If
               //   Set oRsAux = Nothing
               //End If
                            
                            
                            
                            
                            
                            }
                        }

                        db.SaveChanges();
                        db.Tree_TX_Actualizar("RecibosAgrupados", Recibo.IdRecibo, "Recibo");
                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdRecibo = Recibo.IdRecibo, ex = "" });
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

        public class JsonResponse
        {
            public Status Status { get; set; }
            public string Message { get; set; }
            public List<string> Errors { get; set; }
        }

        public virtual FileResult Imprimir(int id) //(int id)
        {
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "ReciboNET_Hawk.docx";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            Pronto.ERP.BO.Recibo fac = ReciboManager.GetItem(SC, id, true);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Recibo.docx");
        }


        public virtual ActionResult Recibos(string sidx, string sord, int? page, int? rows, bool? _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Recibos
                        from b in db.Cuentas.Where(p => p.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.Monedas.Where(q => q.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from d in db.Obras.Where(u => u.IdObra == a.IdObra).DefaultIfEmpty()
                        from e in db.Empleados.Where(w => w.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from f in db.Empleados.Where(x => x.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from g in db.Vendedores.Where(y => y.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        from h in db.Vendedores.Where(y => y.IdVendedor == a.IdCobrador).DefaultIfEmpty()
                        select new
                        {
                            a.IdRecibo,
                            a.PuntoVenta,
                            a.NumeroRecibo,
                            a.FechaRecibo,
                            a.Tipo,
                            a.Anulado,
                            CodigoCliente = a.Cliente.CodigoCliente,
                            NombreCliente = a.Cliente.RazonSocial,
                            Cuenta = b != null ? b.Descripcion : "",
                            Moneda = c != null ? c.Abreviatura : "",
                            a.Deudores,
                            a.Valores,
                            a.RetencionIVA,
                            a.RetencionGanancias,
                            a.RetencionIBrutos,
                            OtrosConceptos = (a.Otros1 ?? 0) + (a.Otros2 ?? 0) + (a.Otros3 ?? 0) + (a.Otros4 ?? 0) + (a.Otros5 ?? 0) + (a.Otros6 ?? 0) + (a.Otros7 ?? 0) + (a.Otros8 ?? 0) + (a.Otros9 ?? 0) + (a.Otros10 ?? 0),
                            Obra = d != null ? d.NumeroObra : "",
                            Vendedor = g != null ? g.Nombre : "",
                            Cobrador = h != null ? h.Nombre : "",
                            Ingreso = e != null ? e.Nombre : "",
                            a.FechaIngreso,
                            Modifico = f != null ? f.Nombre : "",
                            a.FechaModifico,
                            a.Observaciones,
                            a.Cotizacion
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaRecibo >= FechaDesde && a.FechaRecibo <= FechaHasta select a).AsQueryable();
            }

            if (_search ?? false)
            {
                switch (searchField.ToLower())
                {
                    case "numeroRecibo":
                        campo = String.Format("{0} = {1}", searchField, searchString);
                        break;
                    case "fechaRecibo":
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

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaRecibo)
                        
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            //switch (sidx.ToLower())
            //{
            //    case "numeroRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //    case "fechaRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaRecibo);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //}

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdRecibo.ToString(),
                            cell = new string[] { 
                                a.Tipo=="CC" ? "<a href="+ Url.Action("EditCC",new {id = a.IdRecibo} ) + " target='' >Editar</>" : "<a href="+ Url.Action("EditOT",new {id = a.IdRecibo} ) + " target='' >Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRecibo} ) + ">Emitir</a> ",
                                a.IdRecibo.ToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroRecibo.NullSafeToString(),
                                a.FechaRecibo == null ? "" : a.FechaRecibo.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Tipo.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.CodigoCliente.NullSafeToString(),
                                a.NombreCliente.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Deudores.NullSafeToString(),
                                a.Valores.NullSafeToString(),
                                a.RetencionIVA.NullSafeToString(),
                                a.RetencionGanancias.NullSafeToString(),
                                a.RetencionIBrutos.NullSafeToString(),
                                a.OtrosConceptos.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.Cobrador.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                a.Cotizacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult Recibos_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters)
        {


            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Recibo>
                                ("Localidade,Provincia,Vendedore,Empleado,Cuentas,Transportista", sidx, sord, page, rows, _search, filters, db, ref totalRecords);

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            string campo = String.Empty;
            int pageSize = rows;
            int currentPage = page;

            var data = (from a in pagedQuery
                        //from b in db.Cuentas.Where(p => p.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        //from c in db.Monedas.Where(q => q.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        //from d in db.Obras.Where(u => u.IdObra == a.IdObra).DefaultIfEmpty()
                        //from e in db.Empleados.Where(w => w.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        //from f in db.Empleados.Where(x => x.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        //from g in db.Vendedores.Where(y => y.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        //from h in db.Vendedores.Where(y => y.IdVendedor == a.IdCobrador).DefaultIfEmpty()
                        select new
                        {
                            a.IdRecibo,
                            a.PuntoVenta,
                            a.NumeroRecibo,
                            a.FechaRecibo,
                            a.Tipo,
                            a.Anulado,
                            CodigoCliente = a.Cliente.CodigoCliente,
                            NombreCliente = a.Cliente.RazonSocial,
                            Cuenta = a.Cuenta != null ? a.Cuenta.Descripcion : "",
                            Moneda = a.Moneda != null ? a.Moneda.Abreviatura : "",
                            a.Deudores,
                            a.Valores,
                            a.RetencionIVA,
                            a.RetencionGanancias,
                            a.RetencionIBrutos,
                            OtrosConceptos = (a.Otros1 ?? 0) + (a.Otros2 ?? 0) + (a.Otros3 ?? 0) + (a.Otros4 ?? 0) + (a.Otros5 ?? 0) + (a.Otros6 ?? 0) + (a.Otros7 ?? 0) + (a.Otros8 ?? 0) + (a.Otros9 ?? 0) + (a.Otros10 ?? 0),
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            Vendedor =a.Vendedore  != null ? a.Vendedore.Nombre : "",
                            Cobrador = a.Vendedore1 != null ? a.Vendedore1.Nombre : "",
                            Ingreso = a.Empleado != null ? a.Empleado.Nombre : "",
                            a.FechaIngreso,
                            Modifico = a.Empleado1 != null ? a.Empleado1.Nombre : "",
                            a.FechaModifico,
                            a.Observaciones,
                            a.Cotizacion
                        }).AsQueryable(); 

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaRecibo)
                        
//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            //switch (sidx.ToLower())
            //{
            //    case "numeroRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //    case "fechaRecibo":
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.FechaRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.FechaRecibo);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Fac = Fac.OrderByDescending(a => a.NumeroRecibo);
            //        else
            //            Fac = Fac.OrderBy(a => a.NumeroRecibo);
            //        break;
            //}

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdRecibo.ToString(),
                            cell = new string[] { 
                                a.Tipo=="CC" ? "<a href="+ Url.Action("EditCC",new {id = a.IdRecibo} ) + " target='' >Editar</>" : "<a href="+ Url.Action("EditOT",new {id = a.IdRecibo} ) + " target='' >Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRecibo} ) + ">Emitir</a> ",
                                a.IdRecibo.ToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroRecibo.NullSafeToString(),
                                a.FechaRecibo == null ? "" : a.FechaRecibo.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Tipo.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.CodigoCliente.NullSafeToString(),
                                a.NombreCliente.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Deudores.NullSafeToString(),
                                a.Valores.NullSafeToString(),
                                a.RetencionIVA.NullSafeToString(),
                                a.RetencionGanancias.NullSafeToString(),
                                a.RetencionIBrutos.NullSafeToString(),
                                a.OtrosConceptos.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.Cobrador.NullSafeToString(),
                                a.Ingreso.NullSafeToString(),
                                a.FechaIngreso.NullSafeToString(),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico.NullSafeToString(),
                                a.Cotizacion.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosImputaciones(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var Det = db.DetalleRecibos.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;
            int mIdMonedaPesos = 1;
            int mIdMonedaDolar = 0;
            int mIdTipoComprobanteFacturaVenta = 0;
            int mIdTipoComprobanteDevoluciones = 0;
            int mIdTipoComprobanteNotaDebito = 0;
            int mIdTipoComprobanteNotaCredito = 0;
            int mIdTipoComprobanteRecibo = 0;

            Parametros parametros = db.Parametros.Find(1);
            mIdMonedaPesos = parametros.IdMoneda ?? 1;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdTipoComprobanteFacturaVenta = parametros.IdTipoComprobanteFacturaVenta ?? 0;
            mIdTipoComprobanteDevoluciones = parametros.IdTipoComprobanteDevoluciones ?? 0;
            mIdTipoComprobanteNotaDebito = parametros.IdTipoComprobanteNotaDebito ?? 0;
            mIdTipoComprobanteNotaCredito = parametros.IdTipoComprobanteNotaCredito ?? 0;
            mIdTipoComprobanteRecibo = parametros.IdTipoComprobanteRecibo ?? 0;

            var data = (from a in Det
                        from b in db.CuentasCorrientesDeudores.Where(o => o.IdCtaCte == a.IdImputacion).DefaultIfEmpty()
                        from c in db.Facturas.Where(p => p.IdFactura == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteFacturaVenta).DefaultIfEmpty()
                        from d in db.Devoluciones.Where(p => p.IdDevolucion == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteDevoluciones).DefaultIfEmpty()
                        from e in db.NotasDebitoes.Where(p => p.IdNotaDebito == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteNotaDebito).DefaultIfEmpty()
                        from f in db.NotasCreditoes.Where(p => p.IdNotaCredito == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteNotaCredito).DefaultIfEmpty()
                        from g in db.Recibos.Where(p => p.IdRecibo == (b.IdComprobante ?? 0) && (b.IdTipoComp ?? 0) == mIdTipoComprobanteRecibo).DefaultIfEmpty()
                        from h in db.TiposComprobantes.Where(o => o.IdTipoComprobante == b.IdTipoComp).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRecibo,
                            a.IdImputacion,
                            b.CotizacionMoneda,
                            b.IdTipoComp,
                            b.IdComprobante,
                            Tipo = h != null ? h.DescripcionAb : "",
                            Letra = c != null ? c.TipoABC : (d != null ? d.TipoABC : (e != null ? e.TipoABC : (f != null ? f.TipoABC : ""))),
                            PuntoVenta = c != null ? c.PuntoVenta : (d != null ? d.PuntoVenta : (e != null ? e.PuntoVenta : (f != null ? f.PuntoVenta : (g != null ? g.PuntoVenta : 0)))),
                            Numero = c != null ? c.NumeroFactura : (d != null ? d.NumeroDevolucion : (e != null ? e.NumeroNotaDebito : (f != null ? f.NumeroNotaCredito : (g != null ? g.NumeroRecibo : b.NumeroComprobante)))),
                            b.Fecha,
                            ImporteOriginal = a.Recibo.IdMoneda == mIdMonedaDolar ? b.ImporteTotalDolar * h.Coeficiente : b.ImporteTotal * h.Coeficiente,
                            Saldo = a.Recibo.IdMoneda == mIdMonedaDolar ? b.Saldo * h.Coeficiente : b.Saldo * h.Coeficiente,
                            a.Importe
                        }).OrderBy(x => x.IdDetalleRecibo)
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
                            id = a.IdDetalleRecibo.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleRecibo.ToString(), 
                            a.IdImputacion.ToString(), 
                            a.CotizacionMoneda.ToString(), 
                            a.IdTipoComp.ToString(), 
                            a.IdComprobante.ToString(), 
                            a.Tipo.NullSafeToString(),
                            a.Letra + '-' + a.PuntoVenta.NullSafeToString().PadLeft(4,'0') + '-' + a.Numero.NullSafeToString().PadLeft(8,'0'),
                            a.Fecha == null ? "" : a.Fecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.ImporteOriginal.ToString(),
                            a.Saldo.ToString(),
                            a.Importe.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosValores(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var Det = db.DetalleRecibosValores.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from d in db.Cajas.Where(p => p.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from e in db.TarjetasCreditoes.Where(q => q.IdTarjetaCredito == a.IdTarjetaCredito).DefaultIfEmpty()
                        from f in db.TiposComprobantes.Where(s => s.IdTipoComprobante == a.IdTipoValor).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancariaTransferencia).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboValores,
                            a.IdTipoValor,
                            a.IdBanco,
                            a.IdCuentaBancariaTransferencia,
                            a.IdCaja,
                            a.IdTarjetaCredito,
                            Tipo = f.DescripcionAb != null ? f.DescripcionAb : "",
                            a.FechaVencimiento,
                            a.Importe,
                            a.NumeroInterno,
                            a.NumeroValor,
                            a.NumeroTransferencia,
                            a.NumeroTarjetaCredito,
                            Banco = b != null ? b.Nombre : "",
                            Caja = d != null ? d.Descripcion : "",
                            TarjetaCredito = e != null ? e.Nombre : "",
                            CuentaBancariaTransferencia = g != null ? g.Cuenta : "",
                            a.CuitLibrador,
                            a.FechaExpiracionTarjetaCredito,
                            a.CantidadCuotas,
                            a.NumeroAutorizacionTarjetaCredito
                        }).OrderBy(x => x.IdDetalleReciboValores)
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
                            id = a.IdDetalleReciboValores.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleReciboValores.ToString(), 
                            a.IdTipoValor.NullSafeToString(),
                            a.IdBanco.NullSafeToString(),
                            a.IdCuentaBancariaTransferencia.NullSafeToString(),
                            a.IdCaja.NullSafeToString(),
                            a.IdTarjetaCredito.NullSafeToString(),
                            a.Tipo.NullSafeToString(),
                            a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.NumeroInterno.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.Importe.ToString(),
                            a.Banco.NullSafeToString(),
                            a.CuitLibrador.NullSafeToString(),
                            a.CuentaBancariaTransferencia.NullSafeToString(),
                            a.NumeroTransferencia.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            a.TarjetaCredito.NullSafeToString(),
                            a.NumeroTarjetaCredito.NullSafeToString(),
                            a.FechaExpiracionTarjetaCredito.NullSafeToString(),
                            a.CantidadCuotas.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosCuentas(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Det = db.DetalleRecibosCuentas.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();

            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Det.AsEnumerable()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.DetalleCuentas.Where(o => o.IdCuenta == a.IdCuenta && o.FechaCambio > a.Recibo.FechaRecibo).OrderByDescending(o => o.FechaCambio).DefaultIfEmpty()
                        from d in db.Cajas.Where(t => t.IdCaja == a.IdCaja).DefaultIfEmpty()
                        from f in db.Obras.Where(t => t.IdObra == a.IdObra).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from h in db.CuentasGastos.Where(t => t.IdCuentaGasto == a.IdCuentaGasto).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboCuentas,
                            a.IdCuenta,
                            a.IdObra,
                            a.IdCuentaGasto,
                            a.IdCuentaBancaria,
                            a.IdCaja,
                            a.IdMoneda,
                            a.CotizacionMonedaDestino,
                            IdTipoCuentaGrupo = 0,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            CuentaBancaria = g != null ? g.Banco.Nombre + " " + g.Cuenta : "",
                            Caja = d != null ? d.Descripcion : "",
                            Obra = f != null ? f.Descripcion : "",
                            CuentaGasto = h != null ? h.Descripcion : "",
                            TipoCuentaGrupo = "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleReciboCuentas)
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
                            id = a.IdDetalleReciboCuentas.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleReciboCuentas.ToString(), 
                            a.IdCuenta.NullSafeToString(),
                            a.IdObra.ToString(),
                            a.IdCuentaGasto.ToString(),
                            a.IdCuentaBancaria.ToString(),
                            a.IdCaja.ToString(),
                            a.IdMoneda.ToString(),
                            a.CotizacionMonedaDestino.ToString(),
                            a.IdTipoCuentaGrupo.ToString(),
                            a.Codigo.NullSafeToString(),
                            a.Cuenta.NullSafeToString(),
                            a.Debe.ToString(),
                            a.Haber.ToString(),
                            a.CuentaBancaria.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.CuentaGasto.NullSafeToString(),
                            a.TipoCuentaGrupo.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecibosRubrosContables(string sidx, string sord, int? page, int? rows, int? IdRecibo)
        {
            int IdRecibo1 = IdRecibo ?? 0;
            var Det = db.DetalleRecibosRubrosContables.Where(p => p.IdRecibo == IdRecibo1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboRubrosContables,
                            a.IdRubroContable,
                            RubroContable = b.Descripcion != null ? b.Descripcion : "",
                            a.Importe
                        }).OrderBy(x => x.IdDetalleReciboRubrosContables)
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
                            id = a.IdDetalleReciboRubrosContables.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleReciboRubrosContables.ToString(), 
                            a.IdRubroContable.NullSafeToString(),
                            a.RubroContable.NullSafeToString(),
                            a.Importe.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult CalcularAsiento(Recibo Recibo)
        {
            List<DetalleRecibosCuenta> asiento = new List<DetalleRecibosCuenta>();
            DetalleRecibosCuenta rc;

            Int32 IdCliente = 0;
            Int32 mIdCuenta = 0;
            Int32 mIdCuentaPricipal = 0;
            Int32 mIdCuentaPricipalMonedaExtranjera = 0;
            Int32 mIdCuentaCaja = 0;
            Int32 mIdCuentaValores = 0;
            Int32 mIdCuentaValores1 = 0;
            Int32 mIdCuentaRetencionIVA = 0;
            Int32 mIdCuentaRetencionGanancias = 0;
            Int32 mIdCuentaRetencionIBrutos = 0;
            Int32 mIdCuentaDescuentos = 0;
            Int32 mIdCuentaOtros = 0;
            Int32 mIdMonedaPesos = 0;
            Int32 mIdAux = 0;

            decimal mDebeHaber = 0;
            decimal mRetencionGanancias = 0;
            decimal mRetencionIVA = 0;
            decimal mImporte = 0;
            decimal mRetencionIBrutos = 0;
            decimal mTotalValores = 0;
            decimal mOtros = 0;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var Parametros2 = db.Parametros2.Where(p => p.Campo == "IdCuentaRetencionIvaCobros").FirstOrDefault();
            if (Parametros2 != null) { mIdCuentaRetencionIVA = Convert.ToInt32(Parametros2.Valor); }

            var Parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdCuentaCaja = Parametros.IdCuentaCaja ?? 0;
            mIdCuentaValores = Parametros.IdCuentaValores ?? 0;
            if (mIdCuentaRetencionIVA == 0) { mIdCuentaRetencionIVA = Parametros.IdCuentaRetencionIva ?? 0; }
            mIdCuentaRetencionGanancias = Parametros.IdCuentaRetencionGananciasCobros ?? 0;
            mIdCuentaRetencionIBrutos = Parametros.IdCuentaRetencionIBrutos ?? 0;
            mIdCuentaDescuentos = Parametros.IdCuentaDescuentos ?? 0;
            mIdMonedaPesos = Parametros.IdMoneda ?? 1;

            mIdCuentaPricipal = Recibo.IdCuenta ?? 0;
            mIdCuentaPricipalMonedaExtranjera = mIdCuentaPricipal;

            IdCliente = Recibo.IdCliente ?? 0;
            if (IdCliente > 0)
            {
                var Cliente = db.Clientes.Where(p => p.IdCliente == IdCliente).FirstOrDefault();
                if (Cliente != null)
                {
                    mIdCuentaPricipal = Cliente.IdCuenta ?? 0;
                    mIdCuentaPricipalMonedaExtranjera = Cliente.IdCuentaMonedaExt ?? 0;
                };
            }

            mRetencionIVA = Recibo.RetencionIVA ?? 0;
            if (mRetencionIVA != 0)
            {
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaRetencionIVA;
                if (mRetencionIVA >= 0) { rc.Debe = mRetencionIVA; } else { rc.Haber = mRetencionIVA * -1; };
                mDebeHaber += mRetencionIVA;
                asiento.Add(rc);
            };

            mRetencionGanancias = Recibo.RetencionGanancias ?? 0;
            if (mRetencionGanancias != 0)
            {
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaRetencionGanancias;
                if (mRetencionGanancias >= 0) { rc.Debe = mRetencionGanancias; } else { rc.Haber = mRetencionGanancias * -1; };
                mDebeHaber += mRetencionGanancias;
                asiento.Add(rc);
            };

            mRetencionIBrutos = Recibo.RetencionIBrutos ?? 0;
            if (mRetencionIBrutos != 0)
            {
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaRetencionGanancias;
                if (mRetencionIBrutos >= 0) { rc.Debe = mRetencionIBrutos; } else { rc.Haber = mRetencionIBrutos * -1; };
                mDebeHaber += mRetencionIBrutos;
                asiento.Add(rc);
            };

            for (int i = 1; i<=10; i++)
            {
                if (i == 1) { mOtros = Recibo.Otros1 ?? 0; mIdCuentaOtros = Recibo.IdCuenta1 ?? 0; }
                if (i == 2) { mOtros = Recibo.Otros2 ?? 0; mIdCuentaOtros = Recibo.IdCuenta2 ?? 0; }
                if (i == 3) { mOtros = Recibo.Otros3 ?? 0; mIdCuentaOtros = Recibo.IdCuenta3 ?? 0; }
                if (i == 4) { mOtros = Recibo.Otros4 ?? 0; mIdCuentaOtros = Recibo.IdCuenta4 ?? 0; }
                if (i == 5) { mOtros = Recibo.Otros5 ?? 0; mIdCuentaOtros = Recibo.IdCuenta5 ?? 0; }
                if (i == 6) { mOtros = Recibo.Otros6 ?? 0; mIdCuentaOtros = Recibo.IdCuenta6 ?? 0; }
                if (i == 7) { mOtros = Recibo.Otros7 ?? 0; mIdCuentaOtros = Recibo.IdCuenta7 ?? 0; }
                if (i == 8) { mOtros = Recibo.Otros8 ?? 0; mIdCuentaOtros = Recibo.IdCuenta8 ?? 0; }
                if (i == 9) { mOtros = Recibo.Otros9 ?? 0; mIdCuentaOtros = Recibo.IdCuenta9 ?? 0; }
                if (i == 10) { mOtros = Recibo.Otros10 ?? 0; mIdCuentaOtros = Recibo.IdCuenta10 ?? 0; }

                if (mOtros != 0)
                {
                    rc = new DetalleRecibosCuenta();
                    rc.IdCuenta = mIdCuentaOtros;
                    if (mOtros >= 0) { rc.Debe = mOtros; } else { rc.Haber = mOtros * -1; };
                    mDebeHaber += mOtros;
                    asiento.Add(rc);
                }
            }
            
            mTotalValores = 0;
            foreach (var a in Recibo.DetalleRecibosValores)
            {
                mIdCuentaValores1 = a.IdCuenta ?? mIdCuentaValores;
                mTotalValores += a.Importe ?? 0;

                if (a.IdCaja != null)
                {
                    var Cajas = db.Cajas.Where(p => p.IdCaja == a.IdCaja).FirstOrDefault();
                    if (Cajas != null) { if (Cajas.IdCuenta != null) { mIdCuentaValores1 = Cajas.IdCuenta ?? 0; } }
                };

                if (a.IdTarjetaCredito != null)
                {
                    var TarjetasCreditoes = db.TarjetasCreditoes.Where(p => p.IdTarjetaCredito == a.IdTarjetaCredito).FirstOrDefault();
                    if (TarjetasCreditoes != null) { if (TarjetasCreditoes.IdCuenta != null) { mIdCuentaValores1 = TarjetasCreditoes.IdCuenta ?? 0; } }
                };
                
                rc = new DetalleRecibosCuenta();
                rc.IdCuenta = mIdCuentaValores1;
                rc.Debe = a.Importe ?? 0;
                mDebeHaber += a.Importe ?? 0;
                asiento.Add(rc);
            };

            rc = new DetalleRecibosCuenta();
            rc.IdCuenta = mIdCuentaPricipal;
            if (mDebeHaber >= 0) { rc.Haber = mDebeHaber; } else { rc.Haber = mDebeHaber * -1; };
            asiento.Add(rc);

            var data = (from a in asiento.ToList()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleReciboCuentas,
                            a.IdCuenta,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleReciboCuentas).ToList();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRecibo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

    }
}