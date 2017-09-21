using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
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
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Pronto.ERP.Bll;

// using ProntoMVC.Controllers.Logica;

using mercadopago;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class FacturaController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Facturas)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ActionResult Edit(int id)
        {
            Factura o;

            MercadoPago();

            try
            {
                if (!PuedeLeer(enumNodos.Facturas))
                {
                    o = new Factura();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new Factura();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                Int32 mIdMonedaDolar = 2;
                var cotiz = funcMoneda_Cotizacion(DateTime.Today, mIdMonedaDolar);
                if ((cotiz ?? 0) <= 0)
                {
                    /// "Falta la cotización del dólar"
                     TempData["Alerta"] = "Falta la cotización del dólar";
                    //return RedirectToAction("Index", "Factura");



                    //JsonResponse res = new JsonResponse();
                    //res.Status = Status.Error;

                    //string[] words = errs.Split('\n');
                    //res.Errors = words.ToList();
                    //res.Message = "Hay datos invalidos";

                    //return Json(res);

                }


                o = new Factura();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.Facturas.Include(x => x.DetalleFacturas).Include(x => x.Cliente).SingleOrDefault(x => x.IdFactura == id);
                CargarViewBag(o);
                Session.Add("Factura", o);
                return View(o);
            }
        }

        void CargarViewBag(Factura o)
        {
            ViewBag.Aprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdSolicito = new SelectList(db.Empleados, "IdEmpleado", "Nombre");
            ViewBag.IdSector = new SelectList(db.Sectores, "IdSector", "Descripcion");
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 1), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdTipoRetencionGanancia = new SelectList(db.TiposRetencionGanancias, "IdTipoRetencionGanancia", "Descripcion", o.IdCodigoIva);
            //ViewBag.IdCodigoIVA = new SelectList(db.DescripcionIvas, "IdCodigoIVA", "Descripcion", o.IdCodigoIva);
            ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            ViewBag.IdIBCondicion = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion);
            ViewBag.IdIBCondicion2 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion2);
            ViewBag.IdIBCondicion3 = new SelectList(db.IBCondiciones, "IdIBCondicion", "Descripcion", o.IdIBCondicion3);
        }

        void inic(ref Factura o)
        {
            o.PorcentajeIva1 = 21;
            o.FechaFactura = DateTime.Today;

            Parametros parametros = db.Parametros.Find(1);
            o.OtrasPercepciones1 = 0;
            o.OtrasPercepciones1Desc = ((parametros.OtrasPercepciones1 ?? "NO") == "SI") ? parametros.OtrasPercepciones1Desc : "";
            o.OtrasPercepciones2 = 0;
            o.OtrasPercepciones2Desc = ((parametros.OtrasPercepciones2 ?? "NO") == "SI") ? parametros.OtrasPercepciones2Desc : "";
            o.OtrasPercepciones3 = 0;
            o.OtrasPercepciones3Desc = ((parametros.OtrasPercepciones3 ?? "NO") == "SI") ? parametros.OtrasPercepciones3Desc : "";

            o.IdMoneda = 1;

            var mvarCotizacion = funcMoneda_Cotizacion(DateTime.Today, 2); // db.Cotizaciones.OrderByDescending(x => x.IdCotizacion).FirstOrDefault().Cotizacion; //  mo  Cotizacion(Date, glbIdMonedaDolar);
            o.CotizacionMoneda = 1;
            o.CotizacionDolar = (decimal)(mvarCotizacion ?? 0);
            o.BienesOServicios = "B";
        }

        private bool Validar(ProntoMVC.Data.Models.Factura o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.Facturas)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdFactura = 0;
            Int32 mNumero = 0;
            Int32 mIdMoneda = 1;
            Int32 mIdCliente = 1;
            Int32 mIdPuntoVenta = 0;
            Int32 mPuntoVenta = 0;
            Int32 mIdTipoComprobante = 3;

            decimal mImporteDetalle = 0;
            decimal mSubtotal = 0;

            string mObservaciones = "";
            string mTipoABC = "";
            string mCAI = "";
            string mWS = "";
            string mWSModoTest = "";
            string mCAEManual = "";
            string mProntoIni = "";
            string mCtaCte = "";
            string mAnulada = "";

            DateTime mFechaFactura = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;
            DateTime mFechaCAI = DateTime.MinValue;

            mIdFactura = o.IdFactura;
            mFechaFactura = o.FechaFactura ?? DateTime.MinValue;
            mNumero = o.NumeroFactura ?? 0;
            mIdMoneda = o.IdMoneda ?? 1;
            mIdCliente = o.IdCliente ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mIdPuntoVenta = o.IdPuntoVenta ?? 0;
            mPuntoVenta = o.PuntoVenta ?? 0;
            mTipoABC = o.TipoABC ?? "";
            mAnulada = o.Anulada ?? "";

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;

            if ((o.NumeroFactura ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            if ((o.TipoABC ?? "") == "") { sErrorMsg += "\n" + "Falta la letra del comprobante"; }
            if (o.FechaFactura < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha no puede ser anterior a la del ultimo cierre contable"; }
            if ((o.CotizacionMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización de equivalencia a pesos"; }
            if ((o.CotizacionDolar ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización dolar"; }
            if (mIdMoneda <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }
            if ((o.IdPuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el punto de venta"; }
            if ((o.PuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el numero de sucursal"; }
            if ((o.IdCondicionVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la condicion de venta"; }
            if ((o.BienesOServicios ?? "") == "") { sErrorMsg += "\n" + "Falta la marca de bien o servicio"; }
            if ((o.BienesOServicios ?? "") == "S" && (o.FechaInicioServicio == null || o.FechaFinServicio == null)) { sErrorMsg += "\n" + "Debe indicar las fechas de inicio y fin de servicio"; }
            if ((o.BienesOServicios ?? "") == "S" && (o.FechaFinServicio ?? DateTime.MinValue) < (o.FechaInicioServicio ?? DateTime.MinValue)) { sErrorMsg += "\n" + "La fecha de fin de servicio no puede ser menor a la de inicio"; }

            if (BuscarClaveINI("Exigir obra en facturacion", -1) == "SI") { if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; } }

            if (mIdPuntoVenta > 0)
            {
                var PuntoVenta = db.PuntosVentas.Where(p => p.IdPuntoVenta == mIdPuntoVenta).FirstOrDefault();
                if (PuntoVenta != null)
                {
                    if (mTipoABC == "A" || mTipoABC == "M")
                    {
                        mCAI = PuntoVenta.NumeroCAI_F_A ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_F_A ?? DateTime.MinValue;
                    }
                    if (mTipoABC == "B")
                    {
                        mCAI = PuntoVenta.NumeroCAI_F_B ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_F_B ?? DateTime.MinValue;
                    }
                    if (mTipoABC == "E")
                    {
                        mCAI = PuntoVenta.NumeroCAI_F_E ?? "";
                        mFechaCAI = PuntoVenta.FechaCAI_F_E ?? DateTime.MinValue;
                    }
                    mWS = PuntoVenta.WebService ?? "";
                    mWSModoTest = PuntoVenta.WebServiceModoTest ?? "";
                    mCAEManual = PuntoVenta.CAEManual ?? "";
                }
                if (mCAEManual != "SI" && (mTipoABC == "A" || mTipoABC == "M") && mWS.Length == 0 && mCAI.Length == 0) { sErrorMsg += "\n" + "No existe numero de CAI"; }
                if (mCAEManual != "SI" && mWS.Length == 0 && mCAI.Length > 0 && mFechaFactura > mFechaCAI) { sErrorMsg += "\n" + "El CAI vencio el " + mFechaCAI.ToString() + "."; }
                if (mCAEManual == "SI" && (o.CAE ?? "").Length != 14) { sErrorMsg += "\n" + "Numero de CAE incorrecto (debe tener 14 digitos)"; }
                if (mCAEManual == "SI" && o.FechaVencimientoORechazoCAE == null) { sErrorMsg += "\n" + "Debe ingresar la fecha de vencimiento CAE"; }
                if (mCAI.Length > 0)
                {
                    o.NumeroCAI = Convert.ToDecimal(mCAI);
                    o.FechaVencimientoCAI = mFechaCAI;
                }
            }

            var Facturas = db.Facturas.Where(p => p.IdPuntoVenta == mIdPuntoVenta && p.TipoABC == mTipoABC && p.NumeroFactura == mNumero && p.IdFactura != mIdFactura).OrderByDescending(p => p.FechaFactura).FirstOrDefault();
            if (Facturas != null) { sErrorMsg += "\n" + "La factura ya existe."; }

            mProntoIni = BuscarClaveINI("Validar fecha de facturas nuevas", -1);
            if ((mProntoIni ?? "") == "SI" && mIdFactura <= 0 && mIdPuntoVenta > 0)
            {
                Facturas = db.Facturas.Where(p => p.IdPuntoVenta == mIdPuntoVenta).OrderByDescending(p => p.FechaFactura).FirstOrDefault();
                if (Facturas != null)
                { if (Facturas.FechaFactura > mFechaFactura) { sErrorMsg += "\n" + "La fecha de la ultima factura es " + Facturas.FechaFactura.ToString() + " para este punto de venta."; } }
            }

            var Cliente = db.Clientes.Where(p => p.IdCliente == mIdCliente).FirstOrDefault();
            if (Cliente != null)
            {
                if (Cliente.Estados_Proveedores != null) { if ((Cliente.Estados_Proveedores.Activo ?? "") == "NO") { sErrorMsg += "\n" + "Cliente inhabilitado"; } }
            }

            if (o.DetalleFacturas.Count <= 0) sErrorMsg += "\n" + "La factura no tiene items";

            var reqsToDelete = o.DetalleFacturas.Where(x => (x.IdArticulo ?? 0) <= 0).Where(x => (x.Cantidad ?? 0) == 0).ToList();
            foreach (var deleteReq in reqsToDelete)
            {
                o.DetalleFacturas.Remove(deleteReq);
            }

            foreach (ProntoMVC.Data.Models.DetalleFactura x in o.DetalleFacturas)
            {
                if ((x.IdArticulo ?? 0) == 0 && (x.Cantidad ?? 0) != 0)
                {
                    sErrorMsg += "\n" + "Hay items que no tienen articulo";
                }
                mImporteDetalle = (x.Cantidad ?? 0) * (x.PrecioUnitario ?? 0);
                mImporteDetalle = mImporteDetalle * (1 - (x.Bonificacion ?? 0) / 100);
                mSubtotal += mImporteDetalle;

                //x.Articulo.AuxiliarNumerico1 = 0;
            }
            if (mSubtotal <= 0) sErrorMsg += "\n" + "El subtotal de la factura debe ser mayor a cero";

            if (mAnulada == "SI")
            {
                CuentasCorrientesDeudor CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdTipoComp == mIdTipoComprobante && c.IdComprobante == mIdFactura).SingleOrDefault();
                if (CtaCte != null)
                {
                    if ((CtaCte.ImporteTotal ?? 0) != (CtaCte.Saldo ?? 0)) { sErrorMsg += "\n" + "La factura ha sido cancelada parcial o totalmente y no puede anularse"; }
                }
            }

            //If mvarId < 0 And IsNumeric(dcfields(10).BoundText) And Not BuscarClaveINI("Validar fecha de facturas nuevas") = "NO" Then
            //   Set oRs = Aplicacion.Facturas.TraerFiltrado("_UltimaPorIdPuntoVenta", dcfields(10).BoundText)
            //   If oRs.RecordCount > 0 Then
            //      If oRs.Fields("FechaFactura").Value > DTFields(0).Value Then
            //         MsgBox "La fecha de la ultima factura es " & oRs.Fields("FechaFactura").Value & ", modifiquela", vbExclamation
            //         oRs.Close
            //         Set oRs = Nothing
            //         Exit Sub
            //      End If
            //   End If
            //   oRs.Close
            //   Set oRs = Nothing
            //End If


            // VERIFICAR QUE EXISTAN TODAS LAS CUENTAS CONTABLES DEL ASIENTO DE SUBDIARIO

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.Factura Factura)
        {
            if (!PuedeEditar(enumNodos.Facturas)) throw new Exception("No tenés permisos");

            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mCotizacionDolar = 0;
                decimal mImporteTotal = 0;
                decimal mIvaNoDiscriminado = 0;
                decimal mIvaNoDiscriminadoItem = 0;
                decimal mImporteDetalle = 0;
                decimal mImporteGravado = 0;
                decimal mImporteNoGravado = 0;
                decimal mImporte = 0;
                decimal mAlicuotaIVA = 0;

                Int32 mIdFactura = 0;
                Int32 mNumero = 0;
                Int32 mNumeroElectronico = 0;
                Int32 mIdCliente = 0;
                Int32 mIdCuenta = 0;
                Int32 mIdCuentaOtrasPercepciones1 = 0;
                Int32 mIdCuentaOtrasPercepciones2 = 0;
                Int32 mIdCuentaOtrasPercepciones3 = 0;
                Int32 mIdCuentaPercepcionesIVA = 0;
                Int32 mIdCuentaIvaInscripto = 0;
                Int32 mIdProvincia = 0;
                Int32 mIdCuentaVentasTitulo = 0;
                Int32 mIdMonedaPesos = 1;
                Int32 mIdCtaCte = 0;
                Int32 mIdTipoComprobante = 1;
                Int32 mIdRubro = 0;

                string errs = "";
                string warnings = "";
                string mWebService = "";

                bool mAnulada = false;
                bool mAplicarEnCtaCte = true;
                bool mBorrarEnValores = false;

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdCuentaVentasTitulo = parametros.IdCuentaVentasTitulo ?? 0;
                mIdMonedaPesos = parametros.IdMoneda ?? 0;
                mIdCuentaIvaInscripto = parametros.IdCuentaIvaInscripto ?? 0;
                mIdCuentaOtrasPercepciones1 = parametros.IdCuentaOtrasPercepciones1 ?? 0;
                mIdCuentaOtrasPercepciones2 = parametros.IdCuentaOtrasPercepciones2 ?? 0;
                mIdCuentaOtrasPercepciones3 = parametros.IdCuentaOtrasPercepciones3 ?? 0;
                mIdCuentaPercepcionesIVA = parametros.IdCuentaPercepcionesIVA ?? 0;

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (Factura.IdFactura <= 0)
                {
                    Factura.IdUsuarioIngreso = IdUsuario;
                    Factura.FechaIngreso = DateTime.Now;
                    Factura.ImporteIva2 = Factura.ImporteIva2 ?? 0;
                    Factura.ImporteBonificacion = Factura.ImporteBonificacion ?? 0;
                }

                if (!Validar(Factura, ref errs, ref warnings))
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
                        mIdFactura = Factura.IdFactura;
                        mIdCliente = Factura.IdCliente ?? 0;
                        mCotizacionMoneda = Factura.CotizacionMoneda ?? 1;
                        mCotizacionDolar = Factura.CotizacionDolar ?? 0;
                        if (Factura.Anulada == "SI") { mAnulada = true; }
                        mImporteTotal = (Factura.ImporteTotal ?? 0) * mCotizacionMoneda;
                        mIvaNoDiscriminado = (Factura.IVANoDiscriminado ?? 0) * mCotizacionMoneda;

                        if (mIdFactura > 0)
                        {
                            var EntidadOriginal = db.Facturas.Where(p => p.IdFactura == mIdFactura).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(Factura);

                            ////////////////////////////////////////////// ANULACION //////////////////////////////////////////////
                            if (mAnulada)
                            {
                                CuentasCorrientesDeudor CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdTipoComp == mIdTipoComprobante && c.IdComprobante == mIdFactura).SingleOrDefault();
                                if (CtaCte != null)
                                {
                                    if ((CtaCte.ImporteTotal ?? 0) == (CtaCte.Saldo ?? 0))
                                    {
                                        CtaCte.ImporteTotal = 0;
                                        CtaCte.Saldo = 0;
                                        CtaCte.ImporteTotalDolar = 0;
                                        CtaCte.SaldoDolar = 0;
                                        db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                    }
                                }
                            }

                            ////////////////////////////////////////////// ARTICULOS //////////////////////////////////////////////
                            //foreach (var d in Factura.DetalleFacturas)
                            //{
                            //    var DetalleEntidadOriginal = EntidadOriginal.DetalleFacturas.Where(c => c.IdDetalleFactura == d.IdDetalleFactura && d.IdDetalleFactura > 0).SingleOrDefault();
                            //    if (DetalleEntidadOriginal != null)
                            //    {
                            //        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                            //        DetalleEntidadEntry.CurrentValues.SetValues(d);
                            //    }
                            //    else
                            //    {
                            //        EntidadOriginal.DetalleFacturas.Add(d);
                            //    }
                            //}
                            //foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleFacturas.Where(c => c.IdDetalleFactura != 0).ToList())
                            //{
                            //    if (!Factura.DetalleFacturas.Any(c => c.IdDetalleFactura == DetalleEntidadOriginal.IdDetalleFactura))
                            //    {
                            //        EntidadOriginal.DetalleFacturas.Remove(DetalleEntidadOriginal);
                            //        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            //    }
                            //}

                            //////////////////////////////////////////// ORDENES COMPRA ////////////////////////////////////////////
                            //foreach (var d in Factura.DetalleFacturasOrdenesCompras)
                            //{
                            //    var DetalleEntidadOriginal = EntidadOriginal.DetalleFacturasOrdenesCompras.Where(c => c.IdDetalleFacturaOrdenesCompra == d.IdDetalleFacturaOrdenesCompra && d.IdDetalleFacturaOrdenesCompra > 0).SingleOrDefault();
                            //    if (DetalleEntidadOriginal != null)
                            //    {
                            //        var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                            //        DetalleEntidadEntry.CurrentValues.SetValues(d);
                            //    }
                            //    else
                            //    {
                            //        EntidadOriginal.DetalleFacturasOrdenesCompras.Add(d);
                            //    }
                            //}
                            //foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleFacturasOrdenesCompras.Where(c => c.IdDetalleFacturaOrdenesCompra != 0).ToList())
                            //{
                            //    if (!Factura.DetalleFacturasOrdenesCompras.Any(c => c.IdDetalleFacturaOrdenesCompra == DetalleEntidadOriginal.IdDetalleFacturaOrdenesCompra))
                            //    {
                            //        EntidadOriginal.DetalleFacturasOrdenesCompras.Remove(DetalleEntidadOriginal);
                            //        db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                            //    }
                            //}

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == Factura.IdPuntoVenta).SingleOrDefault();
                            if (PuntoVenta != null)
                            {
                                mNumero = PuntoVenta.ProximoNumero ?? 1;
                                Factura.NumeroFactura = mNumero;

                                mWebService = PuntoVenta.WebService ?? "";
                                if (mWebService.Length > 0)
                                {
                                    LogComprobantesElectronico log = new LogComprobantesElectronico();
                                    string sErrores = "";
                                    if (!Logica_FacturaElectronica(ref Factura, ref log, ref sErrores))
                                    {
                                        throw new Exception(sErrores);
                                    }

                                    db.LogComprobantesElectronicos.Add(log);
                                }
                                PuntoVenta.ProximoNumero = Factura.NumeroFactura + 1;
                                db.Entry(PuntoVenta).State = System.Data.Entity.EntityState.Modified;
                            }

                            db.Facturas.Add(Factura);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// IMPUTACION //////////////////////////////////////////////
                        if (mIdFactura <= 0 && !mAnulada && mAplicarEnCtaCte)
                        {
                            CuentasCorrientesDeudor CtaCte = new CuentasCorrientesDeudor();
                            CtaCte.IdCliente = Factura.IdCliente;
                            CtaCte.NumeroComprobante = Factura.NumeroFactura;
                            CtaCte.Fecha = Factura.FechaFactura;
                            CtaCte.FechaVencimiento = Factura.FechaFactura;
                            CtaCte.Cotizacion = Factura.CotizacionDolar;
                            CtaCte.CotizacionMoneda = Factura.CotizacionMoneda;
                            CtaCte.IdComprobante = Factura.IdFactura;
                            CtaCte.IdTipoComp = mIdTipoComprobante;
                            CtaCte.ImporteTotal = mImporteTotal;
                            CtaCte.Saldo = mImporteTotal;
                            if (mCotizacionDolar > 0)
                            {
                                CtaCte.ImporteTotalDolar = mImporteTotal * mCotizacionMoneda / mCotizacionDolar;
                                CtaCte.SaldoDolar = mImporteTotal * mCotizacionMoneda / mCotizacionDolar;
                            }
                            CtaCte.IdMoneda = Factura.IdMoneda;
                            CtaCte.IdCtaCte = 0;

                            db.CuentasCorrientesDeudores.Add(CtaCte);
                            db.SaveChanges();
                            mIdCtaCte = CtaCte.IdCtaCte;

                            CtaCte = db.CuentasCorrientesDeudores.Where(c => c.IdCtaCte == mIdCtaCte).SingleOrDefault();
                            if (CtaCte != null)
                            {
                                CtaCte.IdImputacion = mIdCtaCte;
                                db.Entry(CtaCte).State = System.Data.Entity.EntityState.Modified;
                                db.SaveChanges();
                            }
                        }

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mAnulada)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdComprobante == mIdFactura).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                            db.SaveChanges();
                        }

                        if (mIdFactura <= 0 && !mAnulada)
                        {
                            Subdiario s;

                            Cliente Cliente = db.Clientes.Where(c => c.IdCliente == mIdCliente).SingleOrDefault();
                            mIdCuenta = 0;
                            if (Cliente != null) { mIdCuenta = Cliente.IdCuenta ?? 0; }

                            if (mIdCuenta > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuenta;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Debe = mImporteTotal;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = Factura.ImporteIva1 ?? 0;
                            if (mImporte != 0 && mIdCuentaIvaInscripto > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaIvaInscripto;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = Factura.IVANoDiscriminado ?? 0;
                            if (mImporte != 0 && mIdCuentaIvaInscripto > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaIvaInscripto;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = Factura.RetencionIBrutos1 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == Factura.IdIBCondicion).FirstOrDefault();
                                if (IBCondicion != null)
                                {
                                    mIdCuenta = IBCondicion.IdCuentaPercepcionIIBB ?? 0;
                                    mIdProvincia = IBCondicion.IdProvincia ?? 0;
                                    if (mIdProvincia != 0)
                                    {
                                        var Provincia = db.Provincias.Where(c => c.IdProvincia == mIdProvincia).FirstOrDefault();
                                        if (Provincia != null)
                                        {
                                            if ((Provincia.IdCuentaPercepcionIBrutos ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIBrutos ?? 0; }
                                            if ((Factura.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = Factura.NumeroFactura;
                                    s.FechaComprobante = Factura.FechaFactura;
                                    s.IdComprobante = Factura.IdFactura;
                                    s.Haber = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = Factura.RetencionIBrutos2 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == Factura.IdIBCondicion2).FirstOrDefault();
                                if (IBCondicion != null)
                                {
                                    mIdCuenta = IBCondicion.IdCuentaPercepcionIIBB ?? 0;
                                    mIdProvincia = IBCondicion.IdProvincia ?? 0;
                                    if (mIdProvincia != 0)
                                    {
                                        var Provincia = db.Provincias.Where(c => c.IdProvincia == mIdProvincia).FirstOrDefault();
                                        if (Provincia != null)
                                        {
                                            if ((Provincia.IdCuentaPercepcionIBrutos ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIBrutos ?? 0; }
                                            if ((Factura.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = Factura.NumeroFactura;
                                    s.FechaComprobante = Factura.FechaFactura;
                                    s.IdComprobante = Factura.IdFactura;
                                    s.Haber = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = Factura.RetencionIBrutos3 ?? 0;
                            if (mImporte != 0)
                            {
                                mIdCuenta = 0;
                                var IBCondicion = db.IBCondiciones.Where(c => c.IdIBCondicion == Factura.IdIBCondicion3).FirstOrDefault();
                                if (IBCondicion != null)
                                {
                                    mIdCuenta = IBCondicion.IdCuentaPercepcionIIBB ?? 0;
                                    mIdProvincia = IBCondicion.IdProvincia ?? 0;
                                    if (mIdProvincia != 0)
                                    {
                                        var Provincia = db.Provincias.Where(c => c.IdProvincia == mIdProvincia).FirstOrDefault();
                                        if (Provincia != null)
                                        {
                                            if ((Provincia.IdCuentaPercepcionIBrutos ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIBrutos ?? 0; }
                                            if ((Factura.ConvenioMultilateral ?? "") == "SI" && (Provincia.IdCuentaPercepcionIIBBConvenio ?? 0) > 0) { mIdCuenta = Provincia.IdCuentaPercepcionIIBBConvenio ?? 0; }
                                        }
                                    }
                                }

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = Factura.NumeroFactura;
                                    s.FechaComprobante = Factura.FechaFactura;
                                    s.IdComprobante = Factura.IdFactura;
                                    s.Haber = mImporte;
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }

                            mImporte = Factura.OtrasPercepciones1 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones1 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones1;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = Factura.OtrasPercepciones2 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones2 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones2;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = Factura.OtrasPercepciones3 ?? 0;
                            if (mImporte != 0 && mIdCuentaOtrasPercepciones3 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaOtrasPercepciones3;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            mImporte = Factura.PercepcionIVA ?? 0;
                            if (mImporte != 0 && mIdCuentaPercepcionesIVA > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                s.IdCuenta = mIdCuentaPercepcionesIVA;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = Factura.NumeroFactura;
                                s.FechaComprobante = Factura.FechaFactura;
                                s.IdComprobante = Factura.IdFactura;
                                s.Haber = mImporte;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;

                                db.Subdiarios.Add(s);
                            }

                            foreach (var d in Factura.DetalleFacturas)
                            {
                                mImporteDetalle = (d.Cantidad ?? 0) * (d.PrecioUnitario ?? 0);
                                mImporteDetalle = mImporteDetalle * (1 - (d.Bonificacion ?? 0) / 100);

                                mAlicuotaIVA = db.Articulos.Find(d.IdArticulo).AlicuotaIVA ?? 0;

                                if (mAlicuotaIVA == 0)
                                { mImporteNoGravado += mImporteDetalle; }
                                else { mImporteGravado -= mImporteDetalle; }
                            }
                            foreach (var d in Factura.DetalleFacturas)
                            {
                                mImporteDetalle = (d.Cantidad ?? 0) * (d.PrecioUnitario ?? 0);
                                mImporteDetalle = mImporteDetalle * (1 - (d.Bonificacion ?? 0) / 100);

                                mAlicuotaIVA = db.Articulos.Find(d.IdArticulo).AlicuotaIVA ?? 0;
                                if (mIvaNoDiscriminado > 0 && mAlicuotaIVA == 0) { mImporteDetalle = mImporteDetalle * (mImporteGravado - mIvaNoDiscriminado) / mImporteGravado; }

                                mIdRubro = db.Articulos.Find(d.IdArticulo).IdRubro;
                                mIdCuenta = db.Rubros.Find(mIdRubro).IdCuenta ?? 0;

                                if (mIdCuenta > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaVentasTitulo;
                                    s.IdCuenta = mIdCuenta;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = Factura.NumeroFactura;
                                    s.FechaComprobante = Factura.FechaFactura;
                                    s.IdComprobante = Factura.IdFactura;
                                    if (mImporteDetalle >= 0) { s.Haber = mImporteDetalle; }
                                    else { s.Debe = mImporteDetalle * -1; }
                                    s.IdMoneda = mIdMonedaPesos;
                                    s.CotizacionMoneda = 1;

                                    db.Subdiarios.Add(s);
                                }
                            }
                            db.SaveChanges();
                        }

                        //////////////////////////////////////////////////////////
                        db.Tree_TX_Actualizar("FacturasAgrupadas", Factura.IdFactura, "Factura");
                        // db.SaveChanges(); // no tiene sentido con un store

                        //////////////////////////////////////////////////////////
                        scope.Complete();
                        scope.Dispose();
                        //////////////////////////////////////////////////////////
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdFactura = Factura.IdFactura, ex = "" });
                }
                else
                {
                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
                    Response.TrySkipIisCustomErrors = true;

                    JsonResponse res = new JsonResponse();
                    res.Status = Status.Error;
                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
                    res.Message = "El comprobante tiene datos invalidos";

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

        public virtual FileResult Imprimir(int id) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.docx"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "FacturaNET_Hawk.docx";
            /*
            string plantilla = Pronto.ERP.Bll.OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC);
            */

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            System.IO.File.Copy(plantilla, output); // 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 
            Pronto.ERP.BO.Factura fac = FacturaManager.GetItem(SC, id, true);
            OpenXML_Pronto.FacturaXML_DOCX(output, fac, SC);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "factura.docx");
        }

        public virtual FileResult ImprimirConInterop(int id) //(int id)
        {
            // string sBasePronto = (string)rc.HttpContext.Session["BasePronto"];
            // db = new DemoProntoEntities(Funciones.Generales.sCadenaConex(sBasePronto));
            int idcliente = buscaridclienteporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
            if (idcliente != 0 &&
                  db.Facturas.Find(id).IdCliente != idcliente
                 && !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") &&
                !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Comercial")
                ) throw new Exception("Sólo podes acceder a facturas a tu nombre");

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            //  string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["DemoProntoConexionDirecta"].ConnectionString);
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.doc"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla;

            if (db.Facturas.Find(id).TipoABC == "A")
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Factura_A_Hawk_Nueva_FA.dot";
            }
            else
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Factura_B_Hawk_Nueva.dot";
            }

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            Pronto.ERP.BO.Factura fac = FacturaManager.GetItem(SC, id, true);

            object nulo = null;
            var mvarClausula = false;
            var mPrinter = "";
            var mCopias = 1;

            string mArgs = "NO|NO|2|3|4|1/1/1800|1/1/2100";

            EntidadManager.ImprimirWordDOT_VersionDLL(plantilla, ref nulo, SC, nulo, ref nulo, id, mvarClausula, mPrinter, mCopias, output, mArgs);

            //byte[] contents = ;
            //return File(contents, "application/octet-stream");

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "factura.doc");
        }

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            int idcliente = buscaridclienteporcuit(DatosExtendidosDelUsuario_GrupoUsuarios((Guid)oStaticMembershipService.GetUser().ProviderUserKey));
            //if (db.Facturas.Find(id).IdCliente != idcliente
            //     && !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "SuperAdmin") &&
            //!oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Administrador") && 
            //    !oStaticMembershipService.UsuarioTieneElRol(oStaticMembershipService.GetUser().UserName, "Comercial")
            //    ) throw new Exception("Sólo podes acceder a facturas a tu nombre");


            string baseP = this.HttpContext.Session["BasePronto"].ToString();
            // baseP = "Vialagro";
            // baseP = "BDLConsultores";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf"; //System.IO.Path.GetDirectoryName(); // + '\Documentos\' + 'archivo.docx';
            string plantilla;
            if (db.Facturas.Find(id).TipoABC == "A")
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Factura_A_" + baseP + "";
            }
            else
            {
                plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Factura_B_" + baseP + "";
            }

            if (db.Facturas.Find(id).CAE.NullSafeToString() != "")
            {
                plantilla += "_FA.dot";
            }
            else
            {
                plantilla += ".dot";
            }

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            Pronto.ERP.BO.Factura fac = FacturaManager.GetItem(SC, id, true);

            object nulo = null;
            var mvarClausula = false;
            var mPrinter = "";
            var mCopias = 1;

            string mArgs = "NO|NO|2|3|4|1/1/1800|1/1/2100";

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, mvarClausula, mPrinter, mCopias, output, mArgs);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "factura.pdf");
        }

        public virtual FileResult TT_DynamicGridData_ExcelExportacion(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            //asdad

            // la idea seria llamar a la funcion filtrador pero sin paginar, o diciendolo de
            // otro modo, pasandole como maxrows un numero grandisimo
            // http://stackoverflow.com/questions/8227898/export-jqgrid-filtered-data-as-excel-or-csv
            // I would recommend you to implement export of data on the server and just post the current searching filter to the back-end. Full information about the searching parameter defines postData parameter of jqGrid. Another boolean parameter of jqGrid search define whether the searching filter should be applied of not. You should better ignore _search property of postData parameter and use search parameter of jqGrid.

            // http://stackoverflow.com/questions/9339792/jqgrid-ef-mvc-how-to-export-in-excel-which-method-you-suggest?noredirect=1&lq=1

            //string sidx = "NumeroPedido";
            //string sord = "desc";
            //int page = 1;
            //rows = 99999999;
            //bool _search = false;
            //string filters = "";
            //DemoProntoEntities db = new DemoProntoEntities(sc);
            //llamo directo a FiltroGenerico o a Pedidos_DynamicGridData??? -y, filtroGenerico no va a incluir las columnas recalculadas!!!!
            // Cuanto tarda ExportToExcelEntityCollection en crear el excel de un FiltroGenerico de toda la tabla de Pedidos?

            IQueryable<Data.Models.Factura> q = (from a in db.Facturas select a).AsQueryable();

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            List<Data.Models.Factura> pagedQuery =
                    Filters.FiltroGenerico_UsandoIQueryable<Data.Models.Factura>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, q);

            JsonResult result;

            result = (JsonResult)TT_DynamicGridData(sidx, sord, page, rows, _search, filters, "", "");

            string output = "c:\\adasdasd.xls";

            List<string[]> lista = new List<string[]>();

            jqGridJson listado = (jqGridJson)result.Data;

            for (int n = 0; n < listado.rows.Count(); n++)
            {
                string[] renglon = listado.rows[n].cell;
                lista.Add(renglon);
            }

            var excelData = new jqGridWeb.DataForExcel(
                    // column Header
                    new[] { "Col1", "Col2", "Col3" },
                    new[]{jqGridWeb.DataForExcel.DataType.String, jqGridWeb.DataForExcel.DataType.Integer,
                          jqGridWeb.DataForExcel.DataType.String},
                    //      new List<string[]> {
                    //    new[] {"a", "1", "c1"},
                    //    new[] {"a", "2", "c2"}
                    //},
                    lista,
                    "Test Grid");

            Stream stream = new FileStream(output, FileMode.Create);
            excelData.CreateXlsxAndFillData(stream);
            stream.Close();

            //PreFormatear();
            //abrir con eeplus y poner autowidth?

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "output.xls");
        }

        public virtual ActionResult TT_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
        {
            //            if (FechaInicial != string.Empty)
            //          {

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

            IQueryable<Data.Models.Factura> q = (from a in db.Facturas where a.FechaFactura >= FechaDesde && a.FechaFactura <= FechaHasta select a).AsQueryable();

            int totalRecords = 0;

            List<Data.Models.Factura> pagedQuery =
            Filters.FiltroGenerico_UsandoIQueryable<Data.Models.Factura>(sidx, sord, page, rows, _search, filters, db, ref totalRecords, q);

            string campo = String.Empty;
            int pageSize = rows;
            int currentPage = page;

            var data = (from a in pagedQuery
                            //from b in db.DescripcionIvas.Where(v => v.IdCodigoIva == a.IdCodigoIva).DefaultIfEmpty()
                            //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                            //from d in db.Vendedores.Where(v => v.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                            //from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                            //from f in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                            //from g in db.Provincias.Where(v => v.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                            //from h in db.Depositos.Where(v => v.IdDeposito == a.IdDeposito).DefaultIfEmpty()
                            //from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                            //from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdFactura,
                            a.TipoABC,
                            a.PuntoVenta,
                            a.NumeroFactura,
                            a.FechaFactura,
                            Sucursal = a.Deposito != null ? a.Deposito.Descripcion : "",
                            a.Anulada,
                            ClienteSubCod = a.Cliente != null ? (   a.Cliente.Codigo !=null ?         ( a.Cliente.Codigo.Length > 2 ? a.Cliente.Codigo.Substring(0, 2) : ""    )  :"" ) : "", 
                            //ClienteSubCod = a.Cliente != null ? a.Cliente.Codigo.PadLeft(2,' ').Substring(0, 2) : "",
                            ClienteCodigo = a.Cliente != null ? a.Cliente.CodigoCliente : 0,
                            ClienteNombre = a.Cliente != null ? a.Cliente.RazonSocial : "",
                            DescripcionIva = a.DescripcionIva != null ? a.DescripcionIva.Descripcion : "",
                            ClienteCuit = a.Cliente.Cuit,
                            CondicionVenta = a.Condiciones_Compra != null ? a.Condiciones_Compra.Descripcion : "",
                            a.FechaVencimiento,
                            ListaDePrecio = a.ListasPrecio != null ? "Lista " + a.ListasPrecio.NumeroLista.ToString() + " " + a.ListasPrecio.Descripcion : "",
                            //#Auxiliar1.OCompras as [Ordenes de compra],
                            //#Auxiliar3.Remitos as [Remitos],
                            OCompras = "",
                            Remitos = "",
                            TotalGravado = (a.ImporteTotal ?? 0) - (a.ImporteIva1 ?? 0) - (a.AjusteIva ?? 0) - (a.PercepcionIVA ?? 0) - (a.RetencionIBrutos1 ?? 0) - (a.RetencionIBrutos2 ?? 0) - (a.RetencionIBrutos3 ?? 0) - (a.OtrasPercepciones1 ?? 0) - (a.OtrasPercepciones2 ?? 0) - (a.OtrasPercepciones3 ?? 0) + (a.ImporteBonificacion ?? 0),
                            Bonificacion = a.ImporteBonificacion,
                            TotalIva = a.ImporteIva1,
                            AjusteIva = a.AjusteIva,
                            TotalIIBB = (a.RetencionIBrutos1 ?? 0) + (a.RetencionIBrutos2 ?? 0) + (a.RetencionIBrutos3 ?? 0),
                            TotalPercepcionIVA = a.PercepcionIVA,
                            TotalOtrasPercepciones = (a.OtrasPercepciones1 ?? 0) + (a.OtrasPercepciones2 ?? 0) + (a.OtrasPercepciones3 ?? 0),
                            a.ImporteTotal,
                            Moneda = a.Moneda == null ? "" : a.Moneda.Abreviatura,
                            Obra = a.Obra != null ? a.Obra.NumeroObra : "",
                            Vendedor = a.Vendedore != null ? a.Vendedore.Nombre : "",
                            ProvinciaDestino = a.Provincia != null ? a.Provincia.Nombre : "",
                            //(Select Count(*) From DetalleFacturas df Where df.IdFactura=Facturas.IdFactura and Patindex('%'+Convert(varchar,df.IdArticulo)+'%', @IdAbonos)<>0) as [Cant.Abonos],
                            //'Grupo '+Convert(varchar,
                            //(Select Top 1 oc.Agrupacion2Facturacion From DetalleFacturasOrdenesCompra dfoc 
                            //   Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
                            //   Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
                            //   Where dfoc.IdFactura=Facturas.IdFactura)) as [Grupo facturacion automatica],
                            CantidadItems = 0,
                            CantidadAbonos = 0,
                            GrupoFacturacionAutomatica = "",
                            FechaContabilizacion = (a.ContabilizarAFechaVencimiento ?? "NO") == "NO" ? a.FechaFactura : a.FechaVencimiento,
                            a.FechaAnulacion,
                            UsuarioAnulo = a.Empleado1 != null ? a.Empleado1.Nombre : "",
                            a.FechaIngreso,
                            UsuarioIngreso = a.Empleado != null ? a.Empleado.Nombre : "",
                            a.CAE,
                            a.RechazoCAE,
                            a.FechaVencimientoORechazoCAE,
                            a.Observaciones
                        }).AsQueryable();

            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
//   .OrderByDescending(x => x.FechaFactura).ThenByDescending(y => y.NumeroFactura)

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdFactura.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdFactura} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConInteropPDF",new {id = a.IdFactura} ) + ">Emitir</a> ",
                                a.IdFactura.ToString(),
                                a.TipoABC.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroFactura.NullSafeToString(),
                                a.FechaFactura == null ? "" : a.FechaFactura.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Sucursal.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.ClienteSubCod.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ListaDePrecio.NullSafeToString(),
                                a.OCompras.NullSafeToString(),
                                a.Remitos.NullSafeToString(),

                                //string.Join(",", a.DetalleRequerimientos
                                //    .SelectMany(x =>
                                //        (x.DetallePresupuestos == null) ?
                                //        null :
                                //        x.DetallePresupuestos.Select(y =>
                                //                    (y.Presupuesto == null) ?
                                //                    null :
                                //                    y.Presupuesto.Numero.NullSafeToString()
                                //            )
                                //    ).Distinct()
                                //),
                                
                                a.TotalGravado.NullSafeToString(),
                                a.Bonificacion.NullSafeToString(),
                                a.TotalIva.NullSafeToString(),
                                a.AjusteIva.NullSafeToString(),
                                a.TotalIIBB.NullSafeToString(),
                                a.TotalPercepcionIVA.NullSafeToString(),
                                a.TotalOtrasPercepciones.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.ProvinciaDestino.NullSafeToString(),
                                db.DetalleFacturas.Where(x=>x.IdFactura==a.IdFactura).Select(x=>x.IdDetalleFactura).Distinct().Count().ToString(),
                                a.CantidadAbonos.NullSafeToString(),
                                a.GrupoFacturacionAutomatica.NullSafeToString(),
                                a.FechaContabilizacion == null ? "" : a.FechaContabilizacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioAnulo.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioIngreso.NullSafeToString(),
                                a.CAE.NullSafeToString(),
                                a.RechazoCAE.NullSafeToString(),
                                a.FechaVencimientoORechazoCAE.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }


        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Facturas
                        from b in db.DescripcionIvas.Where(v => v.IdCodigoIva == a.IdCodigoIva).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Vendedores.Where(v => v.IdVendedor == a.IdVendedor).DefaultIfEmpty()
                        from e in db.Empleados.Where(v => v.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        from g in db.Provincias.Where(v => v.IdProvincia == a.IdProvinciaDestino).DefaultIfEmpty()
                        from h in db.Depositos.Where(v => v.IdDeposito == a.IdDeposito).DefaultIfEmpty()
                        from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdFactura,
                            a.TipoABC,
                            a.PuntoVenta,
                            a.NumeroFactura,
                            a.FechaFactura,
                            Sucursal = h != null ? h.Descripcion : "",
                            a.Anulada,
                            ClienteSubCod = a.Cliente.Codigo.Substring(1, 2),
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            DescripcionIva = b != null ? b.Descripcion : "",
                            ClienteCuit = a.Cliente.Cuit,
                            CondicionVenta = i != null ? i.Descripcion : "",
                            a.FechaVencimiento,
                            ListaDePrecio = j != null ? "Lista " + j.NumeroLista.ToString() + " " + j.Descripcion : "",
                            //#Auxiliar1.OCompras as [Ordenes de compra],
                            //#Auxiliar3.Remitos as [Remitos],
                            OCompras = "",
                            Remitos = "",
                            TotalGravado = (a.ImporteTotal ?? 0) - (a.ImporteIva1 ?? 0) - (a.AjusteIva ?? 0) - (a.PercepcionIVA ?? 0) - (a.RetencionIBrutos1 ?? 0) - (a.RetencionIBrutos2 ?? 0) - (a.RetencionIBrutos3 ?? 0) - (a.OtrasPercepciones1 ?? 0) - (a.OtrasPercepciones2 ?? 0) - (a.OtrasPercepciones3 ?? 0) + (a.ImporteBonificacion ?? 0),
                            Bonificacion = a.ImporteBonificacion,
                            TotalIva = a.ImporteIva1,
                            AjusteIva = a.AjusteIva,
                            TotalIIBB = (a.RetencionIBrutos1 ?? 0) + (a.RetencionIBrutos2 ?? 0) + (a.RetencionIBrutos3 ?? 0),
                            TotalPercepcionIVA = a.PercepcionIVA,
                            TotalOtrasPercepciones = (a.OtrasPercepciones1 ?? 0) + (a.OtrasPercepciones2 ?? 0) + (a.OtrasPercepciones3 ?? 0),
                            a.ImporteTotal,
                            Moneda = a.Moneda.Abreviatura,
                            Obra = c != null ? c.NumeroObra : "",
                            Vendedor = d != null ? d.Nombre : "",
                            ProvinciaDestino = g != null ? g.Nombre : "",
                            //(Select Count(*) From DetalleFacturas df Where df.IdFactura=Facturas.IdFactura and Patindex('%'+Convert(varchar,df.IdArticulo)+'%', @IdAbonos)<>0) as [Cant.Abonos],
                            //'Grupo '+Convert(varchar,
                            //(Select Top 1 oc.Agrupacion2Facturacion From DetalleFacturasOrdenesCompra dfoc 
                            //   Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
                            //   Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
                            //   Where dfoc.IdFactura=Facturas.IdFactura)) as [Grupo facturacion automatica],
                            CantidadItems = 0,
                            CantidadAbonos = 0,
                            GrupoFacturacionAutomatica = "",
                            FechaContabilizacion = (a.ContabilizarAFechaVencimiento ?? "NO") == "NO" ? a.FechaFactura : a.FechaVencimiento,
                            a.FechaAnulacion,
                            UsuarioAnulo = f != null ? f.Nombre : "",
                            a.FechaIngreso,
                            UsuarioIngreso = e != null ? e.Nombre : "",
                            a.CAE,
                            a.RechazoCAE,
                            a.FechaVencimientoORechazoCAE,
                            a.Observaciones
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaFactura >= FechaDesde && a.FechaFactura <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .OrderByDescending(x => x.FechaFactura).ThenByDescending(y => y.NumeroFactura)

//.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data1
                        select new jqGridRowJson
                        {
                            id = a.IdFactura.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdFactura} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConInteropPDF",new {id = a.IdFactura} ) + ">Emitir</a> ",
                                a.IdFactura.ToString(),
                                a.TipoABC.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroFactura.NullSafeToString(),
                                a.FechaFactura == null ? "" : a.FechaFactura.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Sucursal.NullSafeToString(),
                                a.Anulada.NullSafeToString(),
                                a.ClienteSubCod.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ListaDePrecio.NullSafeToString(),
                                a.OCompras.NullSafeToString(),
                                a.Remitos.NullSafeToString(),

                                //string.Join(",", a.DetalleRequerimientos
                                //    .SelectMany(x =>
                                //        (x.DetallePresupuestos == null) ?
                                //        null :
                                //        x.DetallePresupuestos.Select(y =>
                                //                    (y.Presupuesto == null) ?
                                //                    null :
                                //                    y.Presupuesto.Numero.NullSafeToString()
                                //            )
                                //    ).Distinct()
                                //),
                                
                                a.TotalGravado.NullSafeToString(),
                                a.Bonificacion.NullSafeToString(),
                                a.TotalIva.NullSafeToString(),
                                a.AjusteIva.NullSafeToString(),
                                a.TotalIIBB.NullSafeToString(),
                                a.TotalPercepcionIVA.NullSafeToString(),
                                a.TotalOtrasPercepciones.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.Vendedor.NullSafeToString(),
                                a.ProvinciaDestino.NullSafeToString(),
                                db.DetalleFacturas.Where(x=>x.IdFactura==a.IdFactura).Select(x=>x.IdDetalleFactura).Distinct().Count().ToString(),
                                a.CantidadAbonos.NullSafeToString(),
                                a.GrupoFacturacionAutomatica.NullSafeToString(),
                                a.FechaContabilizacion == null ? "" : a.FechaContabilizacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioAnulo.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.UsuarioIngreso.NullSafeToString(),
                                a.CAE.NullSafeToString(),
                                a.RechazoCAE.NullSafeToString(),
                                a.FechaVencimientoORechazoCAE.NullSafeToString(),
                                a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetFactura(string sidx, string sord, int? page, int? rows, int? IdFactura)
        {
            int IdFactura1 = IdFactura ?? 0;
            var Det = db.DetalleFacturas.Where(p => p.IdFactura == IdFactura1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from c in db.DetalleFacturasOrdenesCompras.Where(o => o.IdDetalleFactura == a.IdDetalleFactura).DefaultIfEmpty()
                        from d in db.DetalleOrdenesCompras.Where(o => o.IdDetalleOrdenCompra == c.IdDetalleOrdenCompra).DefaultIfEmpty()
                        from e in db.DetalleFacturasRemitos.Where(o => o.IdDetalleFactura == a.IdDetalleFactura).DefaultIfEmpty()
                        from f in db.DetalleRemitos.Where(o => o.IdDetalleRemito == e.IdDetalleRemito).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleFactura,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.OrigenDescripcion,
                            TipoCancelacion = (d != null ? d.TipoCancelacion : 1),
                            IdDetalleOrdenCompra = (c != null ? c.IdDetalleOrdenCompra : 0),
                            IdDetalleRemito = 0,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Unidad = a.Unidade.Abreviatura,
                            a.PorcentajeCertificacion,
                            Costo = Math.Round((double)a.Costo, 2),
                            PrecioUnitario = Math.Round((double)a.PrecioUnitario, 2),
                            a.Bonificacion,
                            Importe = Math.Round((double)(a.Cantidad ?? 0) * (double)(a.PrecioUnitario ?? 0) * (double)(1 - (a.Bonificacion ?? 0) / 100), 2),
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            a.Observaciones,
                            OrdenCompraNumero = d.OrdenesCompra.NumeroOrdenCompra,
                            OrdenCompraItem = d.NumeroItem,
                            RemitoNumero = f.Remito.NumeroRemito,
                            RemitoItem = f.NumeroItem,
                            a.PorcentajeIva,
                            a.ImporteIva
                        }).OrderBy(x => x.IdDetalleFactura)
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
                            id = a.IdDetalleFactura.ToString(),
                            cell = new string[] {
                            string.Empty,
                            a.IdDetalleFactura.ToString(),
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.OrigenDescripcion.NullSafeToString(),
                            a.TipoCancelacion.NullSafeToString(),
                            a.IdDetalleOrdenCompra.NullSafeToString(),
                            a.IdDetalleRemito.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.PorcentajeCertificacion.NullSafeToString(),
                            a.Costo.NullSafeToString(),
                            a.PrecioUnitario.NullSafeToString(),
                            a.Bonificacion.NullSafeToString(),
                            a.PorcentajeIva.ToString(),
                            a.ImporteIva.ToString(),
                            a.Importe.NullSafeToString(),
                            a.TiposDeDescripcion.NullSafeToString(),
                            a.Observaciones.NullSafeToString(),
                            a.OrdenCompraNumero == null ? "" : a.OrdenCompraNumero.ToString().PadLeft(8,'0') + "/" + a.OrdenCompraItem.ToString().PadLeft(2,'0'),
                            a.RemitoNumero == null ? "" : a.RemitoNumero.ToString().PadLeft(8,'0') + "/" + a.RemitoItem.ToString().PadLeft(2,'0')
                            }
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

        [HttpPost]
        public virtual ActionResult Uploadfile(System.ComponentModel.Container containers, HttpPostedFileBase file)
        {

            if (file.ContentLength > 0)
            {
                var fileName = System.IO.Path.GetFileName(file.FileName);
                var path = ""; //  = System.IO.Path.Combine(Server.MapPath("~/App_Data/Uploads"), containers.ContainerNo);
                file.SaveAs(path);
            }

            return RedirectToAction("Index");
        }

        public virtual ActionResult RemitosPendienteFacturacion(string sidx, string sord, int? page, int? rows,
                              bool _search, string searchField, string searchOper, string searchString,
                              string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.DetalleRemitos
                        .Include(x => x.Remito).Include(x => x.Remito.Cliente).Include(x => x.Articulo).Include(x => x.Unidade)
                        .AsQueryable();  // si queres usar include, no usar "select new" mezclando con join

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
                        select new { a }
                        ).Where(campo).AsQueryable();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                            //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord)
.Skip((currentPage - 1) * pageSize).Take(pageSize)
.ToList();

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdDetalleRemito.NullSafeToString(),
                            cell = new string[] {

                                "<a href="+ Url.Action("Edit",new {id = a.IdDetalleRemito} )  +" target='_blank' >Editar</>"
                                ,
                                a.IdDetalleRemito.NullSafeToString(),
                                a.IdArticulo.NullSafeToString(),
                                (a.Articulo ?? new Articulo()).Codigo.NullSafeToString(),
                                (a.Articulo ?? new Articulo()).Descripcion.NullSafeToString(),
                                a.Precio.NullSafeToString(),
                                a.Cantidad.NullSafeToString(),
                                a.IdUnidad.NullSafeToString(),
                                (a.Unidade ?? new Unidad()).Descripcion.NullSafeToString(),
                                a.Remito.IdCliente.NullSafeToString(),
                                (a.Remito.Cliente==null) ? "" : a.Remito.Cliente.RazonSocial.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult OrdenesCompraPendientesFacturar(string sidx, string sord, int? page, int? rows,
                                 bool _search, string searchField, string searchOper, string searchString,
                                 string FechaInicial, string FechaFinal, string IdObra)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Fac = db.DetalleOrdenesCompras
                        .Include(x => x.OrdenesCompra).Include(x => x.OrdenesCompra.Cliente)
                        .Include(x => x.Articulo).Include(x => x.Unidade)
                        .AsQueryable();  // si queres usar include, no usar "select new" mezclando con join

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
                            a
                        }).Where(campo).AsQueryable(); // .ToList();

            int totalRecords = Req1.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Fac
                            //join c in db.IngresoBrutos on a.IdIBCondicion equals c.IdIBCondicion
                        select a).Where(campo).OrderBy(sidx + " " + sord)
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
                            id = a.IdDetalleOrdenCompra.ToString(),
                            cell = new string[] {

                                "<a href="+ Url.Action("Edit",new {id = a.IdDetalleOrdenCompra} )  +" target='_blank' >Editar</>"
                                ,
                                   a.IdDetalleOrdenCompra.NullSafeToString(),
                                a.IdArticulo.NullSafeToString(),
                                 (a.Articulo ?? new Articulo()).Codigo.NullSafeToString(),
                               (a.Articulo ?? new Articulo()).Descripcion.NullSafeToString(),
                                a.Precio.NullSafeToString(),
                                a.Cantidad.NullSafeToString(),
                                                                a.IdUnidad.NullSafeToString(),
                                 (a.Unidade ?? new Unidad()).Descripcion.NullSafeToString(),

                                a.OrdenesCompra.Cliente.RazonSocial.NullSafeToString(),

                               a.OrdenesCompra.IdCliente.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public bool Logica_FacturaElectronica(ref ProntoMVC.Data.Models.Factura o, ref ProntoMVC.Data.Models.LogComprobantesElectronico log, ref string sErrores)
        {
            WSAFIPFE.Factura FE;

            string glbCuit;
            string mCodigoMoneda1 = "";
            string mTipoABC = "";
            string mWebService = "";
            string mCuitEmpresa = "";
            string mArchivoAFIP = "";
            string mFecha = "";
            string glbPathPlantillas = "";
            string mCAE = "";
            string mOtrasPercepciones1Desc = "";
            string mOtrasPercepciones2Desc = "";
            string mOtrasPercepciones3Desc = "";
            string mFechaVencimientoORechazoCAE = "";
            string mFechaString = "";
            string mArchivoXMLEnviado = "";
            string mArchivoXMLRecibido = "";
            string mArchivoXMLEnviado2 = "";
            string mArchivoXMLRecibido2 = "";
            string glbArchivoCertificadoPassWord = "";
            string mCuitCliente = "";

            Int32 mIdPuntoVenta = 0;
            Int32 mPuntoVenta = 0;
            Int32 mIdMoneda = 0;
            Int32 mIdMonedaPesos = 1;
            Int32 mIdMonedaDolar = 2;
            Int32 mIdMonedaEuro = 0;
            Int32 mCodigoMoneda = 0;
            Int32 mDetalleTributoItemCantidad = 0;
            Int32 mIndiceItem = 0;
            Int32 mTipoIvaAFIP = 0;
            Int32 mIdCodigoIva = 1;
            Int32 mNumeroComprobanteElectronico = 0;

            decimal mImporteTotal = 0;
            decimal mSubTotal = 0;
            decimal mSubTotalExento = 0;
            decimal mImporteIva = 0;
            decimal mImporteIva1 = 0;
            decimal mIVANoDiscriminado = 0;
            decimal mPercepcionIVA = 0;
            decimal mRetencionIBrutos1 = 0;
            decimal mRetencionIBrutos2 = 0;
            decimal mRetencionIBrutos3 = 0;
            decimal mPorcentajeIBrutos1 = 0;
            decimal mPorcentajeIBrutos2 = 0;
            decimal mPorcentajeIBrutos3 = 0;
            decimal mOtrasPercepciones1 = 0;
            decimal mOtrasPercepciones2 = 0;
            decimal mOtrasPercepciones3 = 0;
            decimal mImporteBonificacion = 0;
            decimal mAuxD1 = 0;

            bool mResul = false;
            bool glbDebugFacturaElectronica = false;
            bool mAplicarIVANoDiscriminado = false;

            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdMonedaPesos = parametros.IdMoneda ?? 0;
            mIdMonedaDolar = parametros.IdMonedaDolar ?? 0;
            mIdMonedaEuro = parametros.IdMonedaEuro ?? 0;

            glbArchivoCertificadoPassWord = BuscarClaveINI("ArchivoCertificadoPassWord", -1);

            var Parametros2 = db.Parametros2.Where(p => p.Campo == "DebugFacturaElectronica").FirstOrDefault();
            if (Parametros2 != null) { if ((Parametros2.Valor ?? "") == "SI") { glbDebugFacturaElectronica = true; } }

            var Empresa = db.Empresas.Where(p => p.IdEmpresa == 1).FirstOrDefault();
            mCuitEmpresa = (Empresa.Cuit ?? "").Replace("-", "");
            mArchivoAFIP = (Empresa.ArchivoAFIP ?? "");

            mIdPuntoVenta = o.IdPuntoVenta ?? 0;
            mPuntoVenta = o.PuntoVenta ?? 0;
            mIdMoneda = o.IdMoneda ?? 1;
            mTipoABC = o.TipoABC;
            mFecha = String.Format("{0:yyyyMMdd}", o.FechaFactura);
            mIdCodigoIva = o.IdCodigoIva ?? 1;
            mImporteBonificacion = o.ImporteBonificacion ?? 0;

            foreach (ProntoMVC.Data.Models.DetalleFactura x in o.DetalleFacturas)
            {
                mImporteIva = mImporteIva + (x.ImporteIva ?? 0);
                if (mImporteIva == 0)
                {
                    mAuxD1 = ((x.Cantidad ?? 0) * (x.PrecioUnitario ?? 0) * (1 - (x.Bonificacion ?? 0) / 100));
                    mSubTotalExento += Math.Round((mAuxD1), 2);
                }
            }

            mSubTotal = (o.ImporteTotal ?? 0) - (o.ImporteIva1 ?? 0) - (o.AjusteIva ?? 0) - (o.PercepcionIVA ?? 0) - (o.RetencionIBrutos1 ?? 0) - (o.RetencionIBrutos2 ?? 0) - (o.RetencionIBrutos3 ?? 0) - (o.OtrasPercepciones1 ?? 0) - (o.OtrasPercepciones2 ?? 0) - (o.OtrasPercepciones3 ?? 0) + (o.ImporteBonificacion ?? 0);
            mImporteIva1 = o.ImporteIva1 ?? 0;
            mIVANoDiscriminado = o.IVANoDiscriminado ?? 0;

            mRetencionIBrutos1 = o.RetencionIBrutos1 ?? 0;
            mRetencionIBrutos2 = o.RetencionIBrutos2 ?? 0;
            mRetencionIBrutos3 = o.RetencionIBrutos3 ?? 0;
            mPorcentajeIBrutos1 = o.PorcentajeIBrutos1 ?? 0;
            mPorcentajeIBrutos2 = o.PorcentajeIBrutos2 ?? 0;
            mPorcentajeIBrutos3 = o.PorcentajeIBrutos3 ?? 0;

            mOtrasPercepciones1 = o.OtrasPercepciones1 ?? 0;
            mOtrasPercepciones2 = o.OtrasPercepciones2 ?? 0;
            mOtrasPercepciones3 = o.OtrasPercepciones3 ?? 0;
            mOtrasPercepciones1Desc = o.OtrasPercepciones1Desc ?? "";
            mOtrasPercepciones2Desc = o.OtrasPercepciones2Desc ?? "";
            mOtrasPercepciones3Desc = o.OtrasPercepciones3Desc ?? "";

            mPercepcionIVA = o.PercepcionIVA ?? 0;

            mCuitCliente = db.Clientes.Find(o.IdCliente).Cuit.Replace("-", "");

            mTipoIvaAFIP = 0;
            if ((double)(o.PorcentajeIva1 ?? 0) == 21) { mTipoIvaAFIP = 5; }
            if ((double)(o.PorcentajeIva1 ?? 0) == 10.5) { mTipoIvaAFIP = 4; }
            if ((double)(o.PorcentajeIva1 ?? 0) == 27) { mTipoIvaAFIP = 6; }

            mImporteTotal = o.ImporteTotal ?? 0;
            if (o.IdMoneda == mIdMonedaPesos) { mCodigoMoneda1 = "PES"; }
            if (o.IdMoneda == mIdMonedaDolar) { mCodigoMoneda1 = "DOL"; }

            //var Moneda = db.Monedas.Where(c => c.IdMoneda == mIdMoneda).SingleOrDefault();
            //if (Moneda != null) { mCodigoMoneda = Convert.ToInt32(Moneda.CodigoAFIP ?? "0"); }
            if (mCodigoMoneda == 0) { if (o.IdMoneda == mIdMonedaPesos) { mCodigoMoneda = 1; } }
            if (mCodigoMoneda == 0) { if (o.IdMoneda == mIdMonedaDolar) { mCodigoMoneda = 2; } }
            if (mCodigoMoneda == 0) { if (o.IdMoneda == mIdMonedaEuro) { mCodigoMoneda = 60; } }

            var PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == mIdPuntoVenta).SingleOrDefault();
            if (PuntoVenta != null) { mWebService = PuntoVenta.WebService ?? ""; }

            glbPathPlantillas = AppDomain.CurrentDomain.BaseDirectory + "Documentos";

            if (mWebService == "WSFE1" && (mTipoABC == "A" || mTipoABC == "B"))
            {
                FE = new WSAFIPFE.Factura();

                if (!System.IO.File.Exists(glbPathPlantillas + "\\FE_" + mCuitEmpresa + ".lic"))
                {
                    mResul = FE.ActivarLicenciaSiNoExiste(mCuitEmpresa, glbPathPlantillas + "\\FE_" + mCuitEmpresa + ".lic", "pronto.wsfex@gmail.com", "bdlconsultores");
                    if (glbDebugFacturaElectronica)
                    {
                        Console.Write("ActivarLicenciaSiNoExiste : " + glbPathPlantillas + "\\FE_" + mCuitEmpresa + ".lic - Ultimo mensaje : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg);
                    }
                    if (!mResul)
                    {
                        ErrHandler.WriteError("ActivarLicenciaSiNoExiste : " + glbPathPlantillas + "\\FE_" + mCuitEmpresa + ".lic - Ultimo mensaje : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg);
                    }
                }

                mResul = FE.iniciar(WSAFIPFE.Factura.modoFiscal.Fiscal, mCuitEmpresa, glbPathPlantillas + "\\" + mArchivoAFIP + ".pfx", glbPathPlantillas + "\\FE_" + mCuitEmpresa + ".lic");
                if (!mResul)
                {
                    ErrHandler.WriteError("iniciar : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg);
                }

                if (glbArchivoCertificadoPassWord.Length > 0)
                {
                    FE.ArchivoCertificadoPassword = glbArchivoCertificadoPassWord;
                }

                if (mResul) mResul = FE.f1ObtenerTicketAcceso();
                if (!mResul)
                {
                    ErrHandler.WriteError("f1ObtenerTicketAcceso : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg);
                }

                if (glbDebugFacturaElectronica)
                {
                    Console.Write("f1ObtenerTicketAcceso : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg);
                }

                if (mResul)
                {
                    try
                    {
                        FE.F1CabeceraCantReg = 1;
                        FE.indice = 0;
                        FE.F1CabeceraPtoVta = (int)o.PuntoVenta;
                        if (mTipoABC == "A")
                        {
                            FE.F1CabeceraCbteTipo = 1;
                        }
                        else
                        {
                            FE.F1CabeceraCbteTipo = 6;
                        }

                        FE.f1Indice = 0;
                        FE.F1DetalleConcepto = 3;
                        if (mCuitCliente.Length > 0)
                        {
                            FE.F1DetalleDocTipo = 80;
                            FE.F1DetalleDocNro = mCuitCliente;
                        }
                        else
                        {
                            FE.F1DetalleDocTipo = 99;
                            FE.F1DetalleDocNro = "0";
                        }
                        FE.F1DetalleCbteDesde = o.NumeroFactura ?? 0;
                        FE.F1DetalleCbteHasta = o.NumeroFactura ?? 0;
                        FE.F1DetalleCbteFch = mFecha;
                        FE.F1DetalleImpTotal = Math.Round((double)mImporteTotal, 2);
                        FE.F1DetalleImpTotalConc = 0;
                        FE.F1DetalleImpNeto = Math.Round((double)mSubTotal - (double)mSubTotalExento - (double)mIVANoDiscriminado - (double)mImporteBonificacion, 2);
                        FE.F1DetalleImpOpEx = (double)mSubTotalExento;
                        FE.F1DetalleImpTrib = Math.Round((double)mRetencionIBrutos1 + (double)mRetencionIBrutos2 + (double)mRetencionIBrutos3 + (double)mOtrasPercepciones1 + (double)mOtrasPercepciones2 + (double)mOtrasPercepciones3 + (double)mPercepcionIVA, 2);
                        FE.F1DetalleImpIva = (double)mImporteIva1 + (double)mIVANoDiscriminado;
                        FE.F1DetalleFchServDesde = mFecha;
                        FE.F1DetalleFchServHasta = mFecha;
                        FE.F1DetalleFchVtoPago = mFecha;
                        FE.F1DetalleMonIdS = mCodigoMoneda1;
                        FE.F1DetalleMonCotiz = (double)(o.CotizacionMoneda ?? 0);
                        FE.F1DetalleCbtesAsocItemCantidad = 0;
                        FE.F1DetalleOpcionalItemCantidad = 0;
                        if ((o.FechaInicioServicio ?? DateTime.MinValue) > DateTime.MinValue) { FE.F1DetalleFchServDesde = String.Format("{0:yyyyMMdd}", o.FechaInicioServicio); }
                        if ((o.FechaFinServicio ?? DateTime.MinValue) > DateTime.MinValue) { FE.F1DetalleFchServHasta = String.Format("{0:yyyyMMdd}", o.FechaFinServicio); }


                        mDetalleTributoItemCantidad = 0;
                        if (mRetencionIBrutos1 != 0) { mDetalleTributoItemCantidad++; }
                        if (mRetencionIBrutos2 != 0) { mDetalleTributoItemCantidad++; }
                        if (mRetencionIBrutos3 != 0) { mDetalleTributoItemCantidad++; }
                        if (mOtrasPercepciones1 != 0) { mDetalleTributoItemCantidad++; }
                        if (mOtrasPercepciones2 != 0) { mDetalleTributoItemCantidad++; }
                        if (mOtrasPercepciones3 != 0) { mDetalleTributoItemCantidad++; }
                        if (mPercepcionIVA != 0) { mDetalleTributoItemCantidad++; }

                        if (mDetalleTributoItemCantidad > 0)
                        {
                            mIndiceItem = 0;
                            FE.F1DetalleTributoItemCantidad = mDetalleTributoItemCantidad;
                            if (mRetencionIBrutos1 != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 2;
                                FE.F1DetalleTributoDesc = "Ingresos Brutos";
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = Math.Round((double)mPorcentajeIBrutos1, 2);
                                FE.F1DetalleTributoImporte = Math.Round((double)mRetencionIBrutos1, 2);
                            }
                            if (mRetencionIBrutos2 != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 2;
                                FE.F1DetalleTributoDesc = "Ingresos Brutos";
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = Math.Round((double)mPorcentajeIBrutos2, 2);
                                FE.F1DetalleTributoImporte = Math.Round((double)mRetencionIBrutos2, 2);
                            }
                            if (mRetencionIBrutos3 != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 2;
                                FE.F1DetalleTributoDesc = "Ingresos Brutos";
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = Math.Round((double)mPorcentajeIBrutos3, 2);
                                FE.F1DetalleTributoImporte = Math.Round((double)mRetencionIBrutos3, 2);
                            }
                            if (mOtrasPercepciones1 != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 2;
                                FE.F1DetalleTributoDesc = mOtrasPercepciones1Desc;
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = 0;
                                FE.F1DetalleTributoImporte = Math.Round((double)mOtrasPercepciones1, 2);
                            }
                            if (mOtrasPercepciones2 != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 2;
                                FE.F1DetalleTributoDesc = mOtrasPercepciones1Desc;
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = 0;
                                FE.F1DetalleTributoImporte = Math.Round((double)mOtrasPercepciones2, 2);
                            }
                            if (mOtrasPercepciones3 != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 2;
                                FE.F1DetalleTributoDesc = mOtrasPercepciones1Desc;
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = 0;
                                FE.F1DetalleTributoImporte = Math.Round((double)mOtrasPercepciones3, 2);
                            }
                            if (mPercepcionIVA != 0)
                            {
                                mIndiceItem++;
                                FE.f1IndiceItem = mIndiceItem - 1;
                                FE.F1DetalleTributoId = 1;
                                FE.F1DetalleTributoDesc = "Percepcion IVA";
                                FE.F1DetalleTributoBaseImp = Math.Round((double)mSubTotal, 2);
                                FE.F1DetalleTributoAlic = 0;
                                FE.F1DetalleTributoImporte = Math.Round((double)mPercepcionIVA, 2);
                            }
                        }

                        if (mImporteIva1 + mIVANoDiscriminado != 0)
                        {
                            FE.F1DetalleIvaItemCantidad = 1;
                            FE.f1IndiceItem = 0;
                            FE.F1DetalleIvaId = mTipoIvaAFIP;
                            FE.F1DetalleIvaBaseImp = Math.Round((double)mSubTotal - (double)mSubTotalExento - (double)mIVANoDiscriminado - (double)mImporteBonificacion, 2);
                            FE.F1DetalleIvaImporte = Math.Round((double)mImporteIva1 + (double)mIVANoDiscriminado, 2);
                        }

                        FE.F1DetalleCbtesAsocItemCantidad = 0;
                        FE.F1DetalleOpcionalItemCantidad = 0;
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }

                    mArchivoXMLEnviado = glbPathPlantillas + "\\FACTURA_" + o.NumeroFactura.ToString() + "_Enviado.xml";
                    mArchivoXMLRecibido = glbPathPlantillas + "\\FACTURA_" + o.NumeroFactura.ToString() + "_Recibido.xml";

                    FE.ArchivoXMLEnviado = mArchivoXMLEnviado;
                    FE.ArchivoXMLRecibido = mArchivoXMLRecibido;

                    mResul = FE.F1CAESolicitar();
                    if (glbDebugFacturaElectronica) { Console.Write("F1CAESolicitar : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg + " - CAE : " + FE.F1RespuestaDetalleCae); }

                    if (mResul && FE.F1RespuestaDetalleCae.Length > 0)
                    {
                        mCAE = FE.F1RespuestaDetalleCae;
                        mFechaVencimientoORechazoCAE = FE.F1RespuestaDetalleCAEFchVto ?? "";

                        if (System.IO.File.Exists(mArchivoXMLEnviado)) { mArchivoXMLEnviado2 = System.IO.File.ReadAllText(mArchivoXMLEnviado); }
                        if (System.IO.File.Exists(mArchivoXMLRecibido)) { mArchivoXMLRecibido2 = System.IO.File.ReadAllText(mArchivoXMLRecibido); }

                        // Read the file as one string.
                        //System.IO.StreamReader myFile = new System.IO.StreamReader("c:\\test.txt");
                        //string myString = myFile.ReadToEnd();
                        //myFile.Close();

                        if (mCAE.Trim().Length == 0)
                        {
                            var s = "Error al obtener CAE : " + FE.UltimoMensajeError + " - Ultimo numero " + FE.F1CompUltimoAutorizado(FE.F1CabeceraPtoVta, FE.F1CabeceraCbteTipo);
                            throw new Exception(s);
                        }
                        mNumeroComprobanteElectronico = Convert.ToInt32(FE.F1RespuestaDetalleCbteDesdeS);
                        if (mNumeroComprobanteElectronico == 0)
                        {
                            var s = "El Web service devuelve 0 como numero de factura : " + FE.UltimoMensajeError + " - Ultimo numero " + FE.F1CompUltimoAutorizado(FE.F1CabeceraPtoVta, FE.F1CabeceraCbteTipo);
                            throw new Exception(s);
                        }

                        log.Letra = mTipoABC;
                        log.Tipo = "FA";
                        log.PuntoVenta = mPuntoVenta;
                        log.NumeroComprobante = mNumeroComprobanteElectronico;
                        log.Identificador = 0;
                        log.Enviado = mArchivoXMLEnviado2;
                        log.Recibido = mArchivoXMLRecibido2;

                        o.CAE = mCAE;
                        o.IdIdentificacionCAE = 0;
                        if (mFechaVencimientoORechazoCAE.Length > 0)
                        {
                            mFechaString = mFechaVencimientoORechazoCAE.Substring(6, 2) + "/" + mFechaVencimientoORechazoCAE.Substring(4, 2) + "/" + mFechaVencimientoORechazoCAE.Substring(0, 4);
                            o.FechaVencimientoORechazoCAE = Convert.ToDateTime(mFechaString);
                        }
                        o.NumeroFactura = mNumeroComprobanteElectronico;
                    }
                    else
                    {
                        var s = "Error al obtener CAE : " + FE.UltimoMensajeError + " - Ultimo numero " + FE.F1CompUltimoAutorizado(FE.F1CabeceraPtoVta, FE.F1CabeceraCbteTipo);
                        throw new Exception(s);
                    }
                }
                else
                {
                    ErrHandler.WriteError("algo anduvo mal : " + FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg);
                }

                sErrores = FE.UltimoMensajeError + " - " + FE.F1RespuestaDetalleObservacionMsg;
                FE = null;
            }

            return mResul;
        }

        public void Probar(ProntoMVC.Data.Models.Factura o)
        {
            string mTipoABC = "";
            string glbPathPlantillas = "";
            string mFechaVencimientoORechazoCAE = "";
            string mFechaVencimientoORechazoCAE2 = "";
            string mArchivoXMLEnviado = "";
            string mArchivoXMLRecibido = "";
            string mArchivoXMLEnviado2 = "";
            string mArchivoXMLRecibido2 = "";

            Int32 mPuntoVenta = 0;
            Int32 mNumeroComprobanteElectronico = 0;

            DateTime mFecha;

            glbPathPlantillas = AppDomain.CurrentDomain.BaseDirectory + "Documentos";

            mNumeroComprobanteElectronico = 2020;
            mArchivoXMLEnviado = glbPathPlantillas + "\\FACTURA_" + mNumeroComprobanteElectronico.ToString() + "_Enviado.xml";
            mArchivoXMLRecibido = glbPathPlantillas + "\\FACTURA_" + mNumeroComprobanteElectronico.ToString() + "_Recibido.xml";

            if (System.IO.File.Exists(mArchivoXMLEnviado)) { mArchivoXMLEnviado2 = System.IO.File.ReadAllText(mArchivoXMLEnviado); }
            if (System.IO.File.Exists(mArchivoXMLRecibido)) { mArchivoXMLRecibido2 = System.IO.File.ReadAllText(mArchivoXMLRecibido); }

            mFechaVencimientoORechazoCAE = "20150203";
            mFechaVencimientoORechazoCAE2 = mFechaVencimientoORechazoCAE.Substring(6, 2) + "/" + mFechaVencimientoORechazoCAE.Substring(4, 2) + "/" + mFechaVencimientoORechazoCAE.Substring(0, 4);
            mFecha = Convert.ToDateTime(mFechaVencimientoORechazoCAE2);

            LogComprobantesElectronico log = new LogComprobantesElectronico();
            log.Letra = "A";
            log.Tipo = "FA";
            log.PuntoVenta = 11;
            log.NumeroComprobante = mNumeroComprobanteElectronico;
            log.Identificador = 0;
            log.Enviado = mArchivoXMLEnviado2;
            log.Recibido = mArchivoXMLRecibido2;
            db.LogComprobantesElectronicos.Add(log);
            db.SaveChanges();

        }

        void MercadoPago()
        {
            return;

            // http://developers.mercadopago.com/documentacion/recibir-pagos#
            MP mp = new MP("7300779784794197", "yKhGAzhyjGOck9Lox4UEK9fSs3fVpUMR");

            mp.sandboxMode(true);

            String accessToken = mp.getAccessToken();

            Response.Write(accessToken);

            // Object preference = mp.createPreference("");
            System.Collections.Hashtable preference = mp.createPreference("{'items':{'title':'sdk-dotnet','quantity':1,'currency_id':'ARS','unit_price':10.5}}");

            // https://github.com/mercadopago/sdk-java/issues/5
            string sss = (String)preference["response"]; //["sandbox_init_point"];
            //string sss2 = (String)preference333["response"]["items"][0]["title"];

            // http://developers.mercadopago.com/sandbox#!/sandbox-ip-dotnet

            // https://github.com/mercadopago/sdk-dotnet
        }
    }

}