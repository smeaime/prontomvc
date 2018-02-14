using System;
using System.Collections.Generic;
using System.Transactions;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
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
using Pronto.ERP.Bll;
// using ProntoMVC.Controllers.Logica;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;//using DocumentFormat.OpenXml.Spreadsheet;
using OpenXmlPowerTools;
using System.Diagnostics;
using ClosedXML.Excel;
using System.IO;
using Pronto.ERP.Bll;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class RecepcionController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Recepciones)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            Recepcione o;

            try
            {
                if (!PuedeLeer(enumNodos.Recepciones))
                {
                    o = new Recepcione();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new Recepcione();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new Recepcione();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.Recepciones.Include(x => x.DetalleRecepciones).SingleOrDefault(x => x.IdRecepcion == id);
                CargarViewBag(o);
                Session.Add("Recepcion", o);
                return View(o);
            }
        }

        void CargarViewBag(Recepcione o)
        {
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdTransportista = new SelectList(db.Transportistas, "IdTransportista", "RazonSocial", o.IdTransportista);
            ViewBag.Realizo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.Realizo);
        }

        void inic(ref Recepcione o)
        {
            o.FechaRecepcion = DateTime.Today;
            o.TipoRecepcion = 1;
        }

        private bool Validar(ProntoMVC.Data.Models.Recepcione o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.Recepciones)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdRecepcion = 0;
            Int32 mNumero1 = 0;
            Int32 mNumero2 = 0;
            Int32 mIdProveedor = 0;
            Int32 mIdTipoComprobante = 60;
            Int32 mIdArticulo = 0;
            Int32 mIdRubro = 0;
            Int32 mIdCuentaComprasActivo = 0;
            Int32 mNumeroPedido = 0;
            Int32 mNumeroItemPE = 0;

            decimal mCantidad = 0;
            decimal mCantidadNeta = 0;
            decimal mCantidadPedida = 0;
            decimal mCantidadEntregada = 0;
            decimal mStockGlobal = 0;

            string mObservaciones = "";
            string mProntoIni_InhabilitarUbicaciones = "";
            string mProntoIni_ControlCierreRecepcionesPedidos = "";
            string mAnulada = "";
            string mRegistrarStock = "";
            string mArticulo = "";
            string mRegistroContableComprasAlActivo = "";

            DateTime mFechaRecepcion = DateTime.Today;

            mIdRecepcion = o.IdRecepcion;
            mFechaRecepcion = o.FechaRecepcion ?? DateTime.MinValue;
            mNumero1 = o.NumeroRecepcion1 ?? 0;
            mNumero2 = o.NumeroRecepcion2 ?? 0;
            mIdProveedor = o.IdProveedor ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mAnulada = o.Anulada ?? "";

            if ((o.NumeroRecepcionAlmacen ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número interno de recepcion"; }
            if ((o.NumeroRecepcion1 ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de sucursal"; }
            if ((o.NumeroRecepcion2 ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de recepcion del proveedor"; }
            if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; }
            if (mIdProveedor <= 0 && o.TipoRecepcion == 1) { sErrorMsg += "\n" + "Falta definir el proveedor"; }

            if (mIdProveedor > 0 && mAnulada != "SI")
            {
                if ((db.Proveedores.Where(x => x.IdProveedor == mIdProveedor).Select(x => x.Estados_Proveedores.Activo).FirstOrDefault() ?? "") == "NO") { sErrorMsg += "\n" + "Proveedor inhabilitado"; }

                Recepcione Recepcion = db.Recepciones.Where(c => (c.IdProveedor ?? 0) == mIdProveedor && (c.NumeroRecepcion1 ?? 0) == mNumero1 && (c.NumeroRecepcion2 ?? 0) == mNumero2).FirstOrDefault();
                if (Recepcion != null) { sErrorMsg += "\n" + "Recepcion ya ingresada"; }
            }

            mProntoIni_InhabilitarUbicaciones = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock", -1) ?? "";
            mProntoIni_ControlCierreRecepcionesPedidos = BuscarClaveINI("Control cierre de recepciones y pedidos", -1) ?? "";

            mRegistroContableComprasAlActivo = db.Parametros2.Where(x => x.Campo == "RegistroContableComprasAlActivo").Select(x => x.Valor).FirstOrDefault() ?? "";

            if (o.DetalleRecepciones.Count <= 0) sErrorMsg += "\n" + "La Recepcion no tiene items";
            foreach (ProntoMVC.Data.Models.DetalleRecepcione x in o.DetalleRecepciones)
            {
                mIdArticulo = (x.IdArticulo ?? 0);
                mCantidad = (x.CantidadCC ?? (x.Cantidad ?? 0));

                if (mIdArticulo == 0) { sErrorMsg += "\n" + "Hay items que no tienen articulo"; }
                if ((x.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin obra"; }
                if ((x.IdUbicacion ?? 0) <= 0 && mProntoIni_InhabilitarUbicaciones != "SI") { sErrorMsg += "\n" + "Hay items sin ubicacion"; }
                if (mCantidad <= 0) { sErrorMsg += "\n" + "Hay items que no tienen la cantidad mayor a cero"; }

                mIdRubro = db.Articulos.Where(y => y.IdArticulo == x.IdArticulo).Select(y => y.IdRubro).FirstOrDefault() ;
                mIdCuentaComprasActivo = db.Articulos.Where(y => y.IdArticulo == x.IdArticulo).Select(y => y.IdCuentaComprasActivo).FirstOrDefault() ?? 0;
                if (mIdCuentaComprasActivo == 0 && mIdRubro > 0) { mIdCuentaComprasActivo = db.Rubros.Where(y => y.IdRubro == mIdRubro).Select(y => y.IdCuentaComprasActivo).FirstOrDefault() ?? 0; }
                if (mRegistroContableComprasAlActivo == "SI" && mIdCuentaComprasActivo == 0) { sErrorMsg += "\n" + "Hay items que no tienen cuenta contable al activo"; }

                mNumeroPedido = db.DetallePedidos.Where(p => p.IdDetallePedido == (x.IdDetallePedido ?? 0)).Select(p => p.Pedido.NumeroPedido).FirstOrDefault() ?? 0;
                mNumeroItemPE = db.DetallePedidos.Where(p => p.IdDetallePedido == (x.IdDetallePedido ?? 0)).Select(p => p.NumeroItem).FirstOrDefault() ?? 0;
                mCantidadPedida = db.DetallePedidos.Where(p => p.IdDetallePedido == (x.IdDetallePedido ?? 0)).Select(p => p.Cantidad).FirstOrDefault() ?? 0;

                if (mProntoIni_ControlCierreRecepcionesPedidos == "SI")
                {
                    mCantidadEntregada = db.DetalleRecepciones.Where(p => p.IdDetallePedido == x.IdDetallePedido && (p.Recepcione.Anulada ?? "") != "SI" && p.IdDetalleRecepcion != x.IdDetalleRecepcion).Select(p => p.Cantidad).Sum() ?? 0;
                    if (mCantidadEntregada + mCantidad > mCantidadPedida)
                    { sErrorMsg += "\n" + "En el pedido " + Convert.ToString(mNumeroPedido) + " item " + Convert.ToString(mNumeroItemPE) + " la cantidad entregada superaria a la pedida"; }
                }
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.Recepcione Recepcion)
        {
            if (!PuedeEditar(enumNodos.Recepciones)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdRecepcion = 0;
                Int32 mNumero = 0;
                Int32 mIdCliente = 0;
                Int32 mIdTipoComprobante = 60;
                Int32 mIdControlCalidad = 0;
                Int32 mIdDetallePedido = 0;
                Int32 mIdRequerimiento = 0;
                Int32 mIdTipoCompra = 0;
                Int32 mIdDepositoCentral = 0;
                Int32 mIdDepositoRecepcion = 0;
                Int32 mIdDetalleRequerimiento = 0;

                decimal mCostoReposicion = 0;
                decimal mCostoReposicionDolar = 0;
                decimal mCostoUnitario = 0;

                string errs = "";
                string warnings = "";
                string mAuxS1 = "";
                string mControlar = "";
                string mAsignarPartidasAutomaticamente = "";
                string mProximoNumeroPartida = "";
                string mRegistrarStock = "";
                string mActivarSolicitudMateriales = "";
                string mModalidadTipoCompra = "";
                string mCostoReposicionPorComprobanteProveedor = "";

                DateTime mFechaRecepcion = DateTime.MinValue;
                DateTime mFechaUltimoCostoReposicion = DateTime.MinValue;

                bool mAnulada = false;

                string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

                mAsignarPartidasAutomaticamente = db.Parametros2.Where(x => x.Campo == "AsignarPartidasAutomaticamente").Select(x => x.Valor).FirstOrDefault() ?? "";
                mAuxS1 = db.Parametros2.Where(x => x.Campo == "IdDepositoCentral").Select(x => x.Valor).FirstOrDefault() ?? "0";
                if (mAuxS1.Length > 0) { mIdDepositoCentral = Convert.ToInt32(mAuxS1); }
                mCostoReposicionPorComprobanteProveedor = db.Parametros2.Where(x => x.Campo == "CostoReposicionPorComprobanteProveedor").Select(x => x.Valor).FirstOrDefault() ?? "SI";

                mActivarSolicitudMateriales = db.Parametros.Where(x => x.IdParametro == 1).Select(x => x.ActivarSolicitudMateriales).FirstOrDefault() ?? "";

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (!Validar(Recepcion, ref errs, ref warnings))
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
                        mIdRecepcion = Recepcion.IdRecepcion;
                        if (Recepcion.Anulada == "SI") { mAnulada = true; }
                        mFechaRecepcion = Recepcion.FechaRecepcion ?? DateTime.MinValue;

                        if (mIdRecepcion > 0)
                        {
                            var EntidadOriginal = db.Recepciones.Where(p => p.IdRecepcion == mIdRecepcion).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(Recepcion);

                            //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
                            foreach (var d in Recepcion.DetalleRecepciones)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleRecepciones.Where(c => c.IdDetalleRecepcion == d.IdDetalleRecepcion && d.IdDetalleRecepcion > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == d.IdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "SI";
                                    if (mRegistrarStock == "SI")
                                    {
                                        // Bajar stock 
                                        Stock Stock = db.Stocks.Where(
                                            c => c.IdArticulo == DetalleEntidadOriginal.IdArticulo &&
                                                 (c.Partida ?? "") == (DetalleEntidadOriginal.Partida ?? "") &&
                                                 (c.IdUbicacion ?? 0) == (DetalleEntidadOriginal.IdUbicacion ?? 0) &&
                                                 (c.IdObra ?? 0) == (DetalleEntidadOriginal.IdObra ?? 0) &&
                                                 (c.IdUnidad ?? 0) == (DetalleEntidadOriginal.IdUnidad ?? 0) &&
                                                 (c.NumeroCaja ?? 0) == (DetalleEntidadOriginal.NumeroCaja ?? 0) &&
                                                 (c.IdColor ?? 0) == (DetalleEntidadOriginal.IdColor ?? 0) &&
                                                 (c.Talle ?? "") == (DetalleEntidadOriginal.Talle ?? "")
                                        ).FirstOrDefault();
                                        if (Stock != null)
                                        {
                                            Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) - (DetalleEntidadOriginal.Cantidad ?? 0);
                                            db.Entry(Stock).State = System.Data.Entity.EntityState.Modified;
                                        }
                                        else
                                        {
                                            Stock = new Stock();
                                            Stock.IdArticulo = DetalleEntidadOriginal.IdArticulo;
                                            Stock.Partida = DetalleEntidadOriginal.Partida ?? "";
                                            Stock.IdUbicacion = DetalleEntidadOriginal.IdUbicacion ?? 0;
                                            Stock.IdObra = DetalleEntidadOriginal.IdObra ?? 0;
                                            Stock.IdUnidad = DetalleEntidadOriginal.IdUnidad ?? 0;
                                            Stock.NumeroCaja = DetalleEntidadOriginal.NumeroCaja ?? 0;
                                            Stock.IdColor = DetalleEntidadOriginal.IdColor ?? 0;
                                            Stock.Talle = DetalleEntidadOriginal.Talle ?? "";
                                            Stock.CantidadUnidades = (DetalleEntidadOriginal.Cantidad ?? 0) * -1;
                                            db.Stocks.Add(Stock);
                                        }
                                    }

                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleRecepciones.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleRecepciones.Where(c => c.IdDetalleRecepcion != 0).ToList())
                            {
                                if (!Recepcion.DetalleRecepciones.Any(c => c.IdDetalleRecepcion == DetalleEntidadOriginal.IdDetalleRecepcion))
                                {
                                    EntidadOriginal.DetalleRecepciones.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                            if (parametros != null)
                            {
                                mNumero = parametros.ProximoNumeroInternoRecepcion ?? 1;
                                Recepcion.NumeroRecepcionAlmacen = mNumero;
                                parametros.ProximoNumeroInternoRecepcion = mNumero + 1;
                                db.Entry(parametros).State = System.Data.Entity.EntityState.Modified;
                            }

                            db.Recepciones.Add(Recepcion);
                            db.SaveChanges();
                        }

                        //////////////////////////////////////////////  STOCK  //////////////////////////////////////////////

                        if (!mAnulada)
                        {
                            foreach (var d in Recepcion.DetalleRecepciones)
                            {
                                mIdDetalleRequerimiento = d.IdDetalleRequerimiento ?? 0;

                                if (mAsignarPartidasAutomaticamente == "SI")
                                {
                                    Parametros2 parametros2 = db.Parametros2.Where(p => p.Campo == "ProximoNumeroPartida").FirstOrDefault();
                                    if (parametros2 != null)
                                    {
                                        mProximoNumeroPartida = parametros2.Valor ?? "";
                                        d.Partida = mProximoNumeroPartida;
                                        parametros2.Valor = Convert.ToString(Convert.ToInt32(mProximoNumeroPartida) + 1);
                                        db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
                                    }
                                    else
                                    {
                                        mProximoNumeroPartida = "1";
                                        parametros2 = new Parametros2();
                                        d.Partida = mProximoNumeroPartida;
                                        parametros2.Campo = "ProximoNumeroPartida";
                                        parametros2.Valor = Convert.ToString(Convert.ToInt32(mProximoNumeroPartida) + 1);
                                        db.Parametros2.Add(parametros2);
                                    }
                                }

                                mIdControlCalidad = d.IdControlCalidad ?? 0;
                                mControlar = db.ControlesCalidads.Where(x => x.IdControlCalidad == mIdControlCalidad).Select(x => x.Inspeccion).FirstOrDefault() ?? "";
                                if (mControlar != "SI")
                                {
                                    d.Controlado = "DI";
                                    d.CantidadCC = d.Cantidad;
                                }

                                mIdDetallePedido = d.IdDetallePedido ?? 0;
                                DetallePedido DetallePedido = db.DetallePedidos.Where(x => x.IdDetallePedido == mIdDetallePedido).FirstOrDefault();
                                if (DetallePedido != null)
                                {
                                    mCostoUnitario = ((DetallePedido.Precio ?? 0) * (100 - (DetallePedido.PorcentajeBonificacion ?? 0)) / 100) * (100 - (DetallePedido.Pedido.PorcentajeBonificacion ?? 0)) / 100;
                                    d.CostoUnitario = mCostoUnitario;
                                    d.IdMoneda = DetallePedido.Pedido.IdMoneda;
                                    d.CotizacionMoneda = DetallePedido.Pedido.CotizacionMoneda;
                                    d.CotizacionDolar = DetallePedido.Pedido.CotizacionDolar;
                                }

                                mIdRequerimiento = db.DetalleRequerimientos.Where(y => y.IdDetalleRequerimiento == mIdDetalleRequerimiento).Select(y => y.IdRequerimiento).FirstOrDefault() ?? 0;
                                mIdTipoCompra = db.Requerimientos.Where(y => y.IdRequerimiento == mIdRequerimiento).Select(y => y.IdTipoCompra).FirstOrDefault() ?? 0;
                                mModalidadTipoCompra = db.TiposCompras.Where(y => y.IdTipoCompra == mIdTipoCompra).Select(y => y.Modalidad).FirstOrDefault() ?? "";
                                mIdDepositoRecepcion = db.Ubicaciones.Where(y => y.IdUbicacion == (d.IdUbicacion ?? 0)).Select(y => y.IdDeposito).FirstOrDefault() ?? 0;

                                if ((mActivarSolicitudMateriales == "SI" || mModalidadTipoCompra == "CR") && mIdDetalleRequerimiento > 0)
                                {
                                    ProntoMVC.Data.Models.DetalleRequerimiento DetalleRequerimiento = db.DetalleRequerimientos.Where(x => x.IdDetalleRequerimiento == mIdDetalleRequerimiento).FirstOrDefault();
                                    if (DetalleRequerimiento != null)
                                    {
                                        if ((DetalleRequerimiento.TipoDesignacion ?? "") == "CMP")
                                        {
                                            if (mIdDepositoCentral > 0 && mIdDepositoCentral != mIdDepositoRecepcion)
                                            { DetalleRequerimiento.TipoDesignacion = "CMP"; }
                                            else
                                            { DetalleRequerimiento.TipoDesignacion = "REC"; }
                                            db.Entry(DetalleRequerimiento).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                }

                                mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == d.IdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "SI";
                                if ((d.Controlado ?? "") == "DI" && mRegistrarStock == "SI")
                                {
                                    // Subir stock
                                    Stock Stock = db.Stocks.Where(
                                        c => c.IdArticulo == d.IdArticulo &&
                                             (c.Partida ?? "") == (d.Partida ?? "") &&
                                             (c.IdUbicacion ?? 0) == (d.IdUbicacion ?? 0) &&
                                             (c.IdObra ?? 0) == (d.IdObra ?? 0) &&
                                             (c.IdUnidad ?? 0) == (d.IdUnidad ?? 0) &&
                                             (c.NumeroCaja ?? 0) == (d.NumeroCaja ?? 0) &&
                                             (c.IdColor ?? 0) == (d.IdColor ?? 0) &&
                                             (c.Talle ?? "") == (d.Talle ?? "")
                                    ).FirstOrDefault();
                                    if (Stock != null)
                                    {
                                        Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) + (d.Cantidad ?? 0);
                                        db.Entry(Stock).State = System.Data.Entity.EntityState.Modified;
                                    }
                                    else
                                    {
                                        Stock = new Stock();
                                        Stock.IdArticulo = d.IdArticulo;
                                        Stock.Partida = d.Partida ?? "";
                                        Stock.IdUbicacion = d.IdUbicacion ?? 0;
                                        Stock.IdObra = d.IdObra ?? 0;
                                        Stock.IdUnidad = d.IdUnidad ?? 0;
                                        Stock.NumeroCaja = d.NumeroCaja ?? 0;
                                        Stock.IdColor = d.IdColor ?? 0;
                                        Stock.Talle = d.Talle ?? "";
                                        Stock.CantidadUnidades = (d.Cantidad ?? 0);
                                        db.Stocks.Add(Stock);
                                    }
                                }

                                if (mCostoReposicionPorComprobanteProveedor == "SI")
                                {
                                    mCostoReposicion = decimal.Round((d.CostoUnitario ?? 0) * (d.CotizacionMoneda ?? 1), 2);
                                    if ((d.CotizacionDolar ?? 0) > 0) { mCostoReposicionDolar = decimal.Round((d.CostoUnitario ?? 0) * (d.CotizacionMoneda ?? 1) / (d.CotizacionDolar ?? 1), 2); }
                                    mFechaUltimoCostoReposicion = db.Articulos.Where(y => y.IdArticulo == d.IdArticulo).Select(y => y.FechaUltimoCostoReposicion).FirstOrDefault() ?? DateTime.MinValue;
                                    if (mFechaRecepcion >= mFechaUltimoCostoReposicion && mCostoReposicion != 0 && mCostoReposicionDolar != 0)
                                    {
                                        Articulo Articulo = db.Articulos.Where(y => y.IdArticulo == d.IdArticulo).FirstOrDefault();
                                        if (Articulo != null)
                                        {
                                            Articulo.CostoReposicion = mCostoReposicion;
                                            Articulo.CostoReposicionDolar = mCostoReposicionDolar;
                                            Articulo.FechaUltimoCostoReposicion = mFechaRecepcion;
                                            db.Entry(Articulo).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                }
                            }
                            db.SaveChanges();

                            db.Tree_TX_Actualizar("RecepcionesAgrupadas", Recepcion.IdRecepcion, "Recepcion");
                        }
                        scope.Complete();
                        scope.Dispose();
                    }

                    EntidadManager.Tarea(SC, "Recepciones_ActualizarEstadoPedidos", Recepcion.IdRecepcion);

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdRecepcion = Recepcion.IdRecepcion, ex = "" });
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

        public virtual JsonResult DetRecepcionesSinFormato(int IdRecepcion)
        {
            var Det = db.DetalleRecepciones.Where(p => p.IdRecepcion == IdRecepcion).ToList(); //.AsQueryable();

            Parametros parametros = db.Parametros.Find(1);
            var mIdCuentaDiferenciaCambio = parametros.IdCuentaDiferenciaCambio ?? 0;
            string cuentadesc;

            Det.ToList();

            DataTable dt = EntidadManager.GetStoreProcedure(SCsql(), "Recepciones_TX_DetallesParaComprobantesProveedores", IdRecepcion);

            //var q= from i in Det
            //       from mappings in dt.AsEnumerable()
            //                .Where(mapping => mapping["IdCuentaContable"].NullSafeToString() == IdRecepcion.ToString() ).DefaultIfEmpty() 
            //        select i;

            //foreach (DataRow dr in dt)
            //{

            //}

            try
            {
                cuentadesc = db.Cuentas.Find(mIdCuentaDiferenciaCambio).Descripcion;
            }
            catch (Exception)
            {
                cuentadesc = "";
            }

            var data = (from a in Det
                        from mappings in dt.AsEnumerable()
                             .Where(mapping => mapping["IdDetalleRecepcion"].NullSafeToString() == a.IdDetalleRecepcion.ToString()).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetallePedido,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdDetalleRequerimiento,
                            // a.NumeroItem,
                            //a.DetalleRequerimiento.Requerimientos.Obra.NumeroObra,
                            a.Cantidad,
                            //a.Unidad.Abreviatura,
                            //a.Articulo.Codigo,
                            //a.Articulo.Descripcion,
                            //a.FechaEntrega,
                            a.Observaciones,
                            //a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            //NumeroItemRM = a.DetalleRequerimiento.NumeroItem,
                            //a.Adjunto,
                            //a.ArchivoAdjunto1,
                            //a.ArchivoAdjunto2,
                            //a.ArchivoAdjunto3,
                            //a.Precio

                            //idcuenta = mIdCuentaDiferenciaCambio,
                            //cuentadescripcion = cuentadesc

                            IdCuenta = mappings["IdCuenta"].NullSafeToString(),
                            CodigoCuenta = mappings["CodigoCuenta"].NullSafeToString(),
                            cuentadescripcion = (db.Cuentas.Find(Generales.Val(mappings["IdCuenta"].NullSafeToString())) ?? new Cuenta()).Descripcion


                        }).OrderBy(p => p.IdArticulo).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Recepciones(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString,
                                            string FechaInicial, string FechaFinal, string IdObra, bool bAConfirmar = false, bool bALiberar = false)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            int totalRecords = 0;
            int totalPages = 0;

            if (true)
            {
                LinqToSQL_ProntoDataContext l2sqlPronto = new LinqToSQL_ProntoDataContext(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SCsql()));
                var qq = (from rm in l2sqlPronto.Requerimientos
                          select l2sqlPronto.Requerimientos_Pedidos(rm.IdRequerimiento)
                          ).Take(100).ToList();


            }

            var Req = db.Recepciones
                // .Include(x => x.DetallePedidos.Select(y => y.Unidad))
                // .Include(x => x.DetallePedidos.Select(y => y.Moneda))
                //.Include(x => x.DetallePedidos. .moneda)
                //   .Include("DetallePedidos.Unidad") // funciona tambien
                //    .Include(x => x.Moneda)
                //.Include(x => x.Obra)

                    //.Include(x => x.SolicitoRequerimiento)
                //.Include(x => x.AproboRequerimiento)
                //.Include(x => x.Sectores)
                //  .Include("DetallePedidos.IdDetalleRequerimiento") // funciona tambien
                //   .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                //.Include(x => x.DetalleRequerimientos)

                        //.Include(x => x.DetalleRequerimientos
                //            .Select(y => y.DetallePedidos
                //                )
                //        )
                //.Include(x => x.DetalleRequerimientos
                //            .Select(y => y.DetallePresupuestos
                //                )
                //        )

                 //       .Include(r => r.DetalleRequerimientos.Select(dr => dr.DetallePedidos.Select(dt => dt.Pedido)))

           //  .Include("DetalleRequerimientos.DetallePedidos.Pedido") // funciona tambien
                //   .Include("DetalleRequerimientos.DetallePresupuestos.Presupuesto") // funciona tambien
                // .Include(x => x.Aprobo)
                          .AsQueryable();


            // Requerimiento test = Req.Where(x => x.IdRequerimiento == 4).ToList().FirstOrDefault();


            //if (bAConfirmar)
            //{

            //    Req = (from a in Req where (a.Confirmado ?? "SI") == "NO" select a).AsQueryable();
            //    //            WHERE  IsNull(Confirmado,'SI')='NO' and 
            //    //(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

            //}
            //if (bALiberar)
            //{
            //    Req = (from a in Req where a.Aprobo == null select a).AsQueryable();
            //    //            WHERE  Requerimientos.Aprobo is null and 
            //    //(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)

            //}

            if (IdObra != string.Empty)
            {
                //int IdObra1 = Convert.ToInt32(IdObra);
                //Req = (from a in Req where a.IdObra == IdObra1 select a).AsQueryable();
            }
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                Req = (from a in Req where a.FechaRecepcion >= FechaDesde && a.FechaRecepcion <= FechaHasta select a).AsQueryable();
            }
            if (_search)
            {
                switch (searchField.ToLower())
                {
                    case "numerorequerimiento":
                        campo = String.Format("Obra.NumeroObra.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //if (searchString != "")
                        //{
                        //    campo = String.Format("{0} = {1}", searchField, Generales.Val(searchString));
                        //}
                        //else
                        //{
                        //    campo = "true";
                        //}
                        break;
                    case "fecharequerimiento":
                        //No anda
                        campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                    default:
                        campo = String.Format("Obra.Descripcion.Contains(\"{0}\") OR NumeroRequerimiento = {1} ", searchString, Generales.Val(searchString));

                        //campo = String.Format("{0}.Contains(\"{1}\")", searchField, searchString);
                        break;
                }
            }
            else
            {
                campo = "true";
            }

            try
            {
                var Req1 = from a in Req.Where(campo) select a.IdRequerimiento;

                totalRecords = Req1.Count();
                totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            }
            catch (Exception)
            {

                //                throw;
            }

            //switch (sidx.ToLower())
            //{
            //    case "numerorequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //    case "fecharequerimiento":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.FechaRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.FechaRequerimiento);
            //        break;
            //    case "numeroobra":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Obra.NumeroObra);
            //        else
            //            Req = Req.OrderBy(a => a.Obra.NumeroObra);
            //        break;
            //    case "libero":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados.Nombre);
            //        break;
            //    case "aprobo":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Empleados1.Nombre);
            //        else
            //            Req = Req.OrderBy(a => a.Empleados1.Nombre);
            //        break;
            //    case "sector":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Sectores.Descripcion);
            //        else
            //            Req = Req.OrderBy(a => a.Sectores.Descripcion);
            //        break;
            //    case "detalle":
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.Detalle);
            //        else
            //            Req = Req.OrderBy(a => a.Detalle);
            //        break;
            //    default:
            //        if (sord.Equals("desc"))
            //            Req = Req.OrderByDescending(a => a.NumeroRequerimiento);
            //        else
            //            Req = Req.OrderBy(a => a.NumeroRequerimiento);
            //        break;
            //}

            var data = from a in Req  // .Where(campo)
                           .OrderBy(sidx + " " + sord)
                           //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                            .ToList()
                       select a; //supongo que tengo que hacer la paginacion antes de hacer un select, para que me llene las colecciones anidadas

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRecepcion.ToString(),
                            cell = new string[] { 
                                //"<a href="+ Url.Action("Edit",new {id = a.IdRequerimiento} ) + " target='' >Editar</>" ,
                                "<a href="+ Url.Action("Edit",new {id = a.IdRecepcion} ) + "  >Editar</>" ,
							    "<a href="+ Url.Action("Imprimir",new {id = a.IdRecepcion} )  +">Imprimir</>" ,
                                a.IdRecepcion.ToString(), 
                                a.NumeroRecepcion1.ToString(), 
                                a.NumeroRecepcion2.ToString(), 
                                a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                              //  a.Cumplido,
                              //  a.Recepcionado,
                              //  a.Entregado,
                              //  a.Impresa,
                              //  a.Detalle,
                              //  //a.Obra.Descripcion, 
                              //(a.Obra==null) ?  "" :  a.Obra.NumeroObra,

                                //  string.Join(" ",  a.DetalleRequerimientos.Select(x=> (x.DetallePresupuestos.Select(y=> y.IdPresupuesto))  )),
                                // string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePresupuestos   ==null) ? "" : x.DetallePresupuestos.Select(z=>z.Presupuesto.Numero.ToString()).NullSafeToString() ).Distinct()),

                                // Req ya viene con todos los datos para las colecciones hijas. lo paginé y ahí hice el select (arriba)

                                //string.Join(",",  a.DetalleRequerimientos
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
                                //"",

                                //string.Join(",",  a.DetalleRequerimientos
                                //    .SelectMany(x =>
                                //        (x.DetallePedidos == null) ?
                                //        null :
                                //        x.DetallePedidos.Select(y =>
                                //                    (y.Pedido == null) ?
                                //                    null :
                                //                    "<a href="+ Url.Action("Edit", "Pedido",new {id = y.Pedido.IdPedido} ) + "  >" + y.Pedido.NumeroPedido.NullSafeToString() + "</>"
                                                    
                                //            )
                                //    ).Distinct()
                                //),


                                "", //recepciones
                                "", // salidas

                                //a.Comparativas,
                                //string.Join(" ",  a.DetalleRequerimientos.Select(x=> x.DetallePedidos.Count ))  ,


                                ////string.Join(" ",  a.DetalleRequerimientos.Select(x=>(x.DetallePedidos   ==null) ? "" : x.DetallePedidos.Select(z=>z.Pedido.NumeroPedido.ToString()).NullSafeToString() ).Distinct()),
                                //a.Recepciones,
                                
                                
                                
                                //(a.SolicitoRequerimiento==null) ?  "" :   a.SolicitoRequerimiento.Nombre,
                                //(a.AproboRequerimiento==null) ?  "" :  a.AproboRequerimiento.Nombre,
                                //(a.Sectores==null) ?  "" : a.Sectores.Descripcion,

                                //a.UsuarioAnulacion,
                                //a.FechaAnulacion.NullSafeToString(),
                                //a.MotivoAnulacion,
                                //a.FechasLiberacion,
                             
                                //a.Observaciones,
                                //a.LugarEntrega,
                                //a.IdObra.ToString(),
                                //a.IdSector.ToString(),
                                //a.ConfirmadoPorWeb.NullSafeToString()
                            }
                        }).ToArray()
            };

            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual FileResult ImprimirConPlantillaEXE_PDF(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.pdf";
            string plantilla = DirApp + "Documentos\\" + "Recepcion_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "Recepcion.pdf";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConPlantillaEXE(int id)
        {
            string DirApp = AppDomain.CurrentDomain.BaseDirectory;
            string output = DirApp + "Documentos\\" + "archivo.doc";
            string plantilla = DirApp + "Documentos\\" + "Recepcion_" + this.HttpContext.Session["BasePronto"].ToString() + ".dotm";

            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var s = new ServicioMVC.servi(SC);
            string mensajeError;
            s.ImprimirConPlantillaEXE(id, SC, DirApp, plantilla, output, out mensajeError);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            string nombrearchivo = "Recepcion.doc";
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, nombrearchivo);
        }

        public virtual FileResult ImprimirConInteropPDF(int id)
        {
            object nulo = null;
            string baseP = this.HttpContext.Session["BasePronto"].ToString();
            string SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            string output = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "archivo.pdf";
            string plantilla;
            plantilla = AppDomain.CurrentDomain.BaseDirectory + "Documentos\\" + "Recepcion_" + baseP + ".dotm";

            //tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
            System.IO.FileInfo MyFile1 = new System.IO.FileInfo(output);//busca si ya existe el archivo a generar y en ese caso lo borra
            if (MyFile1.Exists) MyFile1.Delete();

            EntidadManager.ImprimirWordDOT_VersionDLL_PDF(plantilla, ref nulo, SC, nulo, ref nulo, id, nulo, nulo, nulo, output, nulo);

            byte[] contents = System.IO.File.ReadAllBytes(output);
            return File(contents, System.Net.Mime.MediaTypeNames.Application.Octet, "Recepcion.pdf");
        }

        private class Recepcione2
        {
            public int IdRecepcion { get; set; }
            public int? IdProveedor { get; set; }
            public int? IdCondicionCompra { get; set; }
            public int? NumeroRecepcionAlmacen { get; set; }
            public string NumeroRecepcion1 { get; set; }
            public string NumeroRecepcion2 { get; set; }
            public string SubNumero { get; set; }
            public string ProveedorCodigo { get; set; }
            public string ProveedorNombre { get; set; }
            public string ProveedorCuit { get; set; }
            public DateTime? FechaRecepcion { get; set; }
            public string Obras { get; set; }
            public string Anulada { get; set; }
            public string Requerimientos { get; set; }
            public string SolicitantesRequerimientos { get; set; }
            public string Pedidos { get; set; }
            public string ListaAcopio { get; set; }
            public string Observaciones { get; set; }
            public string Confecciono { get; set; }
            public DateTime? FechaIngreso { get; set; }
            public string Modifico { get; set; }
            public DateTime? FechaUltimaModificacion { get; set; }
            public string Anulo { get; set; }
            public DateTime? FechaAnulacion { get; set; }
            public string MotivoAnulacion { get; set; }
            public int? NumeroPesada { get; set; }
            public decimal? Progresiva1 { get; set; }
            public decimal? Progresiva2 { get; set; }
            public DateTime? FechaPesada { get; set; }
            public string ObservacionesPesada { get; set; }
            public string CircuitoFirmasCompleto { get; set; }
            public string Transportista { get; set; }
            public string Chofer { get; set; }
            public string NumeroDocumentoChofer { get; set; }
            public string Patente { get; set; }
            public decimal? PesoBruto { get; set; }
            public decimal? PesoNeto { get; set; }
            public decimal? Tara { get; set; }
            public int? NumeroOrdenCarga { get; set; }
            public int? NumeroRemitoTransporte1 { get; set; }
            public int? NumeroRemitoTransporte2 { get; set; }
            public int? Items { get; set; }
        }

        public virtual ActionResult TT_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal)
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

            var data = (from a in db.Recepciones
                        from b in db.Proveedores.Where(v => v.IdProveedor == a.IdProveedor).DefaultIfEmpty()
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Transportistas.Where(v => v.IdTransportista == a.IdTransportista).DefaultIfEmpty()
                        from e in db.Empleados.Where(y => y.IdEmpleado == a.Realizo).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from g in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from h in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulo).DefaultIfEmpty()
                        select new Recepcione2
                        {
                            IdRecepcion = a.IdRecepcion,
                            IdProveedor = a.IdProveedor,
                            IdCondicionCompra = b.IdCondicionCompra != null ? b.IdCondicionCompra : null,
                            NumeroRecepcionAlmacen = a.NumeroRecepcionAlmacen,
                            NumeroRecepcion1 = SqlFunctions.Replicate("0", 4 - a.NumeroRecepcion1.ToString().Length) + a.NumeroRecepcion1.ToString(),
                            NumeroRecepcion2 = SqlFunctions.Replicate("0", 8 - a.NumeroRecepcion2.ToString().Length) + a.NumeroRecepcion2.ToString(),
                            SubNumero = a.SubNumero,
                            ProveedorCodigo = b.CodigoEmpresa != null ? b.CodigoEmpresa : "",
                            ProveedorNombre = b.RazonSocial != null ? b.RazonSocial : "",
                            ProveedorCuit = b.Cuit != null ? b.Cuit : "",
                            FechaRecepcion = a.FechaRecepcion,
                            Anulada = a.Anulada,
                            Obras = ModelDefinedFunctions.Recepciones_Obras(a.IdRecepcion).ToString(),
                            Requerimientos = ModelDefinedFunctions.Recepciones_Requerimientos(a.IdRecepcion).ToString(),
                            SolicitantesRequerimientos = ModelDefinedFunctions.Recepciones_Solicitantes(a.IdRecepcion).ToString(),
                            Pedidos = ModelDefinedFunctions.Recepciones_Pedidos(a.IdRecepcion).ToString(),
                            ListaAcopio = "",
                            Observaciones = a.Observaciones,
                            Confecciono = f != null ? f.Nombre : "",
                            FechaIngreso = a.FechaIngreso,
                            Modifico = g != null ? g.Nombre : "",
                            FechaUltimaModificacion = a.FechaUltimaModificacion,
                            Anulo = h != null ? h.Nombre : "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion,
                            NumeroPesada = a.NumeroPesada,
                            Progresiva1 = a.Progresiva1,
                            Progresiva2 = a.Progresiva2,
                            FechaPesada = a.FechaPesada,
                            ObservacionesPesada = a.ObservacionesPesada,
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Transportista = d != null ? d.RazonSocial : "",
                            Chofer = a.Chofer,
                            NumeroDocumentoChofer = a.NumeroDocumentoChofer,
                            Patente = a.Patente,
                            PesoBruto = a.PesoBruto,
                            PesoNeto = a.PesoNeto,
                            Tara = a.Tara,
                            NumeroOrdenCarga = a.NumeroOrdenCarga,
                            NumeroRemitoTransporte1 = a.NumeroRemitoTransporte1,
                            NumeroRemitoTransporte2 = a.NumeroRemitoTransporte1,
                            Items = a.DetalleRecepciones.Distinct().Count(),
                        }).Where(a => a.FechaRecepcion >= FechaDesde && a.FechaRecepcion <= FechaHasta).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Recepcione2>
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
                            id = a.IdRecepcion.ToString(),
                            cell = new string[] {
                                "<a href="+ Url.Action("Edit",new {id = a.IdRecepcion} ) + ">Editar</>",
                                "<a href="+ Url.Action("ImprimirConPlantillaEXE_PDF",new {id = a.IdRecepcion} ) + ">Emitir</a> ",
                                a.IdRecepcion.ToString(),
                                a.IdProveedor.ToString(), 
                                a.IdCondicionCompra.ToString(), 
                                a.NumeroRecepcionAlmacen.NullSafeToString(),
                                a.NumeroRecepcion1.NullSafeToString(),
                                a.NumeroRecepcion2.NullSafeToString(),
                                a.SubNumero.NullSafeToString(),
                                a.ProveedorCodigo.NullSafeToString(),
                                a.ProveedorNombre.NullSafeToString(),
                                a.ProveedorCuit.NullSafeToString(),
                                a.FechaRecepcion == null ? "" : a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Anulada.NullSafeToString(),
                                a.Obras.NullSafeToString(),
                                a.Requerimientos.NullSafeToString(),
                                a.SolicitantesRequerimientos.NullSafeToString(),
                                a.Pedidos.NullSafeToString(),
                                a.ListaAcopio.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.Confecciono.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaUltimaModificacion == null ? "" : a.FechaUltimaModificacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.NumeroPesada.NullSafeToString(),
                                a.Progresiva1.NullSafeToString(),
                                a.Progresiva2.NullSafeToString(),
                                a.FechaPesada == null ? "" : a.FechaPesada.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ObservacionesPesada.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.Chofer.NullSafeToString(),
                                a.NumeroDocumentoChofer.NullSafeToString(),
                                a.Patente.NullSafeToString(),
                                a.PesoBruto.NullSafeToString(),
                                a.PesoNeto.NullSafeToString(),
                                a.Tara.NullSafeToString(),
                                a.NumeroOrdenCarga.NullSafeToString(),
                                a.NumeroRemitoTransporte1.NullSafeToString(),
                                a.NumeroRemitoTransporte2.NullSafeToString(),
                                a.Items.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult Recepciones_Pendientes(string sidx, string sord, int page, int rows, bool _search, string filters, int? IdProveedor)
        {
            int IdProveedor1 = IdProveedor ?? 0;

            var Entidad = db.Recepciones.Where(p => (p.ProcesadoPorCPManualmente ?? "") != "SI" && (p.Anulada ?? "") != "SI" && (IdProveedor1 <= 0 || p.IdProveedor == IdProveedor1) &&
                (db.DetalleRecepciones.Where(q => q.IdRecepcion == p.IdRecepcion && (db.DetalleComprobantesProveedores.Where(r => r.IdDetalleRecepcion == q.IdDetalleRecepcion).Count() > 0)).Count() == 0)).AsQueryable();

            int totalRecords = 0;
            int pageSize = rows;

            var data = (from a in Entidad
                        from b in db.Proveedores.Where(v => v.IdProveedor == a.IdProveedor).DefaultIfEmpty()
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Transportistas.Where(v => v.IdTransportista == a.IdTransportista).DefaultIfEmpty()
                        from e in db.Empleados.Where(y => y.IdEmpleado == a.Realizo).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from g in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from h in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioAnulo).DefaultIfEmpty()
                        select new Recepcione2
                        {
                            IdRecepcion = a.IdRecepcion,
                            IdProveedor = a.IdProveedor,
                            IdCondicionCompra = b.IdCondicionCompra != null ? b.IdCondicionCompra : null,
                            NumeroRecepcionAlmacen = a.NumeroRecepcionAlmacen,
                            NumeroRecepcion1 = SqlFunctions.Replicate("0", 4 - a.NumeroRecepcion1.ToString().Length) + a.NumeroRecepcion1.ToString(),
                            NumeroRecepcion2 = SqlFunctions.Replicate("0", 8 - a.NumeroRecepcion2.ToString().Length) + a.NumeroRecepcion2.ToString(),
                            SubNumero = a.SubNumero,
                            ProveedorCodigo = b.CodigoEmpresa != null ? b.CodigoEmpresa : "",
                            ProveedorNombre = b.RazonSocial != null ? b.RazonSocial : "",
                            ProveedorCuit = b.Cuit != null ? b.Cuit : "",
                            FechaRecepcion = a.FechaRecepcion,
                            Anulada = a.Anulada,
                            Obras = ModelDefinedFunctions.Recepciones_Obras(a.IdRecepcion).ToString(),
                            Requerimientos = ModelDefinedFunctions.Recepciones_Requerimientos(a.IdRecepcion).ToString(),
                            SolicitantesRequerimientos = ModelDefinedFunctions.Recepciones_Solicitantes(a.IdRecepcion).ToString(),
                            Pedidos = ModelDefinedFunctions.Recepciones_Pedidos(a.IdRecepcion).ToString(),
                            ListaAcopio = "",
                            Observaciones = a.Observaciones,
                            Confecciono = f != null ? f.Nombre : "",
                            FechaIngreso = a.FechaIngreso,
                            Modifico = g != null ? g.Nombre : "",
                            FechaUltimaModificacion = a.FechaUltimaModificacion,
                            Anulo = h != null ? h.Nombre : "",
                            FechaAnulacion = a.FechaAnulacion,
                            MotivoAnulacion = a.MotivoAnulacion,
                            NumeroPesada = a.NumeroPesada,
                            Progresiva1 = a.Progresiva1,
                            Progresiva2 = a.Progresiva2,
                            FechaPesada = a.FechaPesada,
                            ObservacionesPesada = a.ObservacionesPesada,
                            CircuitoFirmasCompleto = a.CircuitoFirmasCompleto,
                            Transportista = d != null ? d.RazonSocial : "",
                            Chofer = a.Chofer,
                            NumeroDocumentoChofer = a.NumeroDocumentoChofer,
                            Patente = a.Patente,
                            PesoBruto = a.PesoBruto,
                            PesoNeto = a.PesoNeto,
                            Tara = a.Tara,
                            NumeroOrdenCarga = a.NumeroOrdenCarga,
                            NumeroRemitoTransporte1 = a.NumeroRemitoTransporte1,
                            NumeroRemitoTransporte2 = a.NumeroRemitoTransporte1,
                            Items = a.DetalleRecepciones.Distinct().Count(),
                        }).OrderBy(sidx + " " + sord).AsQueryable();

            var pagedQuery = Filters.FiltroGenerico_UsandoIQueryable<Recepcione2>
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
                            id = a.IdRecepcion.ToString(),
                            cell = new string[] {
                                a.IdRecepcion.ToString(),
                                a.IdProveedor.NullSafeToString(), 
                                a.IdCondicionCompra.NullSafeToString(), 
                                a.NumeroRecepcionAlmacen.NullSafeToString(),
                                a.NumeroRecepcion1.NullSafeToString(),
                                a.NumeroRecepcion2.NullSafeToString(),
                                a.SubNumero.NullSafeToString(),
                                a.ProveedorCodigo.NullSafeToString(),
                                a.ProveedorNombre.NullSafeToString(),
                                a.ProveedorCuit.NullSafeToString(),
                                a.FechaRecepcion == null ? "" : a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Anulada.NullSafeToString(),
                                a.Obras.NullSafeToString(),
                                a.Requerimientos.NullSafeToString(),
                                a.SolicitantesRequerimientos.NullSafeToString(),
                                a.Pedidos.NullSafeToString(),
                                a.ListaAcopio.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                                a.Confecciono.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaUltimaModificacion == null ? "" : a.FechaUltimaModificacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Anulo.NullSafeToString(),
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.MotivoAnulacion.NullSafeToString(),
                                a.NumeroPesada.NullSafeToString(),
                                a.Progresiva1.NullSafeToString(),
                                a.Progresiva2.NullSafeToString(),
                                a.FechaPesada == null ? "" : a.FechaPesada.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.ObservacionesPesada.NullSafeToString(),
                                a.CircuitoFirmasCompleto.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.Chofer.NullSafeToString(),
                                a.NumeroDocumentoChofer.NullSafeToString(),
                                a.Patente.NullSafeToString(),
                                a.PesoBruto.NullSafeToString(),
                                a.PesoNeto.NullSafeToString(),
                                a.Tara.NullSafeToString(),
                                a.NumeroOrdenCarga.NullSafeToString(),
                                a.NumeroRemitoTransporte1.NullSafeToString(),
                                a.NumeroRemitoTransporte2.NullSafeToString(),
                                a.Items.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetRecepcion(string sidx, string sord, int? page, int? rows, int? IdRecepcion)
        {
            int IdRecepcion1 = IdRecepcion ?? 0;
            var Det = db.DetalleRecepciones.Where(p => p.IdRecepcion == IdRecepcion1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Unidades.Where(o => o.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        from c in db.Depositos.Where(o => o.IdDeposito == a.Ubicacione.IdDeposito).DefaultIfEmpty()
                        from d in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from e in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        from f in db.ControlesCalidads.Where(o => o.IdControlCalidad == a.IdControlCalidad).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRecepcion,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.IdUbicacion,
                            a.IdObra,
                            a.IdControlCalidad,
                            a.IdDetalleRequerimiento,
                            a.IdDetallePedido,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ItemRM = a.DetalleRequerimiento.NumeroItem,
                            a.DetallePedido.Pedido.NumeroPedido,
                            ItemPE = a.DetallePedido.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Unidad = b != null ? b.Abreviatura : "",
                            Ubicacion = (c != null ? c.Abreviatura : "") + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "") + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "") + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "") + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : ""),
                            Obra = e != null ? e.NumeroObra : "",
                            a.Partida,
                            ControlCalidad = f != null ? f.Descripcion : "",
                            a.Observaciones
                        }).OrderBy(x => x.IdDetalleRecepcion)
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
                            id = a.IdDetalleRecepcion.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleRecepcion.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.IdUbicacion.NullSafeToString(),
                            a.IdObra.NullSafeToString(),
                            a.IdControlCalidad.NullSafeToString(),
                            a.IdDetalleRequerimiento.NullSafeToString(),
                            a.IdDetallePedido.NullSafeToString(),
                            a.NumeroRequerimiento.NullSafeToString(),
                            a.ItemRM.NullSafeToString(),
                            a.NumeroPedido.NullSafeToString(),
                            a.ItemPE.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.Partida.NullSafeToString(),
                            db.DetalleRecepciones.Where(x=>x.IdDetallePedido==a.IdDetallePedido && (x.Recepcione.Anulada ?? "") != "SI").Select(x=>x.Cantidad).Sum().ToString(),
                            a.ControlCalidad.NullSafeToString(),
                            a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetRecepcionesSinFormato(int? IdRecepcion, int? IdDetalleRecepcion)
        {
            int IdRecepcion1 = IdRecepcion ?? 0;
            int IdDetalleRecepcion1 = IdDetalleRecepcion ?? 0;
            var Det = db.DetalleRecepciones.Where(p => (IdRecepcion1 <= 0 || p.IdRecepcion == IdRecepcion1) && (IdDetalleRecepcion1 <= 0 || p.IdDetalleRecepcion == IdDetalleRecepcion1)).AsQueryable();

            var data = (from a in Det
                        from b in db.Unidades.Where(y => y.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        from c in db.Obras.Where(y => y.IdObra == a.IdObra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRecepcion,
                            a.IdRecepcion,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.IdUbicacion,
                            a.IdObra,
                            a.IdDetalleRequerimiento,
                            a.Recepcione.NumeroRecepcionAlmacen,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            a.DetalleRequerimiento.NumeroItem,
                            ArticuloCodigo = a.Articulo.Codigo,
                            ArticuloDescripcion = a.Articulo.Descripcion,
                            a.Cantidad,
                            Unidad = b != null ? b.Abreviatura : "",
                            Obra = c != null ? c.NumeroObra : "",
                            a.Partida,
                            a.Observaciones
                        }).OrderBy(p => p.IdDetalleRecepcion).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetRecepcionesParaComprobanteProveedor(int? IdRecepcion, int? IdDetalleRecepcion)
        {
            int IdRecepcion1 = IdRecepcion ?? 0;
            int IdDetalleRecepcion1 = IdDetalleRecepcion ?? 0;

            string nSC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            DataTable dt = EntidadManager.GetStoreProcedure(nSC, "Recepciones_TX_DetallesParaComprobantesProveedores2", IdRecepcion1, IdDetalleRecepcion1, "RESUMEN");
            IEnumerable<DataRow> rows = dt.AsEnumerable();
            var Det = (from r in rows
                       orderby r[2]
                       select new
                       {
                           IdDetalleRecepcion = r[0],
                           IdDetallePedido = r[1],
                           IdArticulo = r[2],
                           Cantidad = r[3],
                           ArticuloCodigo = r[4],
                           ArticuloDescripcion = r[5],
                           AlicuotaIVA = r[6],
                           IdCuentaContable = r[7],
                           CuentaCodigo = r[8],
                           CuentaDescripcion = r[9],
                           Importe = r[10],
                           IdObra = r[11],
                           Obra = r[12],
                           IdRubroFinanciero = r[13]
                       }).ToList();

            var data = (from a in Det
                        select new
                        {
                            a.IdDetalleRecepcion,
                            a.IdDetallePedido,
                            a.IdArticulo,
                            a.Cantidad,
                            a.ArticuloCodigo,
                            a.ArticuloDescripcion,
                            a.AlicuotaIVA,
                            a.IdCuentaContable,
                            a.CuentaCodigo,
                            a.CuentaDescripcion,
                            a.Importe,
                            a.IdObra,
                            a.Obra,
                            a.IdRubroFinanciero
                        }).OrderBy(p => p.IdDetalleRecepcion).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult RecepcionesPendientesDeSalidaMateriales(string sidx, string sord, int? page, int? rows)
        {
            var Det = db.DetalleRecepciones.Where(p => (p.Recepcione.Anulada ?? "") != "SI" && (db.DetalleSalidasMateriales.Where(x => x.IdDetalleRecepcion == p.IdDetalleRecepcion && (x.SalidasMateriale.Anulada ?? "") != "SI").Select(x => x.Cantidad).Sum() ?? 0) < p.Cantidad).AsQueryable();

            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Unidades.Where(o => o.IdUnidad == a.IdUnidad).DefaultIfEmpty()
                        from c in db.Depositos.Where(o => o.IdDeposito == a.Ubicacione.IdDeposito).DefaultIfEmpty()
                        from d in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from e in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
                        from f in db.ControlesCalidads.Where(o => o.IdControlCalidad == a.IdControlCalidad).DefaultIfEmpty()
                        from g in db.Proveedores.Where(o => o.IdProveedor == a.Recepcione.IdProveedor).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRecepcion,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.IdUbicacion,
                            a.IdObra,
                            a.IdControlCalidad,
                            a.IdDetalleRequerimiento,
                            a.IdDetallePedido,
                            a.Recepcione.IdProveedor,
                            a.Recepcione.NumeroRecepcionAlmacen,
                            a.Recepcione.NumeroRecepcion1,
                            a.Recepcione.NumeroRecepcion2,
                            a.Recepcione.FechaRecepcion,
                            a.DetalleRequerimiento.Requerimientos.NumeroRequerimiento,
                            ItemRM = a.DetalleRequerimiento.NumeroItem,
                            a.DetallePedido.Pedido.NumeroPedido,
                            ItemPE = a.DetallePedido.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Unidad = b != null ? b.Abreviatura : "",
                            Ubicacion = (c != null ? c.Abreviatura : "") + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "") + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "") + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "") + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : ""),
                            Obra = e != null ? e.NumeroObra : "",
                            Proveedor = g != null ? g.RazonSocial : "",
                            a.Partida,
                            ControlCalidad = f != null ? f.Descripcion : "",
                            a.Observaciones
                        }).OrderByDescending(x => x.NumeroRecepcionAlmacen)
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
                            id = a.IdDetalleRecepcion.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleRecepcion.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.IdUbicacion.NullSafeToString(),
                            a.IdObra.NullSafeToString(),
                            a.IdControlCalidad.NullSafeToString(),
                            a.IdDetalleRequerimiento.NullSafeToString(),
                            a.IdDetallePedido.NullSafeToString(),
                            a.IdProveedor.NullSafeToString(),
                            a.NumeroRecepcionAlmacen.NullSafeToString(),
                            a.NumeroRecepcion1.NullSafeToString().PadLeft(4,'0') + '-'+a.NumeroRecepcion2.NullSafeToString().PadLeft(8,'0'),
                            a.FechaRecepcion == null ? "" : a.FechaRecepcion.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.NumeroRequerimiento.NullSafeToString(),
                            a.ItemRM.NullSafeToString(),
                            a.NumeroPedido.NullSafeToString(),
                            a.ItemPE.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.Proveedor.NullSafeToString(),
                            a.Partida.NullSafeToString(),
                            a.ControlCalidad.NullSafeToString(),
                            a.Observaciones.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRecepcion, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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

    }

}