using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.SqlServer;


using System.Data.Entity.Core.Objects; //using System.Data.Objects;

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
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class RemitoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Remitos)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            Remito o;

            try
            {
                if (!PuedeLeer(enumNodos.Remitos))
                {
                    o = new Remito();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new Remito();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new Remito();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.Remitos.Include(x => x.DetalleRemitos).Include(x => x.Cliente).SingleOrDefault(x => x.IdRemito == id);
                CargarViewBag(o);
                Session.Add("Remito", o);
                return View(o);
            }
        }

        void CargarViewBag(Remito o)
        {
            ViewBag.IdPuntoVenta = new SelectList(db.PuntosVentas.Where(x => x.IdTipoComprobante == 41), "IdPuntoVenta", "PuntoVenta", o.IdPuntoVenta);
            ViewBag.IdObra = new SelectList(db.Obras, "IdObra", "NumeroObra", o.IdObra);
            ViewBag.IdListaPrecios = new SelectList(db.ListasPrecios, "IdListaPrecios", "Descripcion", o.IdListaPrecios);
            ViewBag.IdCondicionVenta = new SelectList(db.Condiciones_Compras, "IdCondicionCompra", "Descripcion", o.IdCondicionVenta);
            ViewBag.IdTransportista = new SelectList(db.Transportistas, "IdTransportista", "RazonSocial", o.IdTransportista);
        }

        void inic(ref Remito o)
        {
            o.FechaRemito = DateTime.Today;
            o.Destino = 1;
        }

        private bool Validar(ProntoMVC.Data.Models.Remito o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.Remitos)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdRemito = 0;
            Int32 mNumero = 0;
            Int32 mIdCliente = 0;
            Int32 mIdProveedor = 0;
            Int32 mIdPuntoVenta = 0;
            Int32 mPuntoVenta = 0;
            Int32 mIdTipoComprobante = 41;
            Int32 mIdArticulo = 0;
            Int32 mIdArticuloAnterior = 0;

            decimal mCantidad = 0;
            decimal mCantidadAnterior = 0;
            decimal mCantidadNeta = 0;
            decimal mStockGlobal = 0;

            string mObservaciones = "";
            string mProntoIni_InhabilitarUbicaciones = "";
            string mProntoIni_InhabilitarStockNegativo = "";
            string mProntoIni_InhabilitarStockNegativoGlobal = "";
            string mProntoIni_ExigirOrdenCompra = "";
            string mProntoIni_NoPermitirItemsEnCero = "";
            string mProntoIni_AvisarOrdenCompraPendiente = "";
            string mProntoIni_ControlLimiteCredito = "";
            string mAnulado = "";
            string mRegistrarStock = "";
            string mArticulo = "";

            DateTime mFechaRemito = DateTime.Today;

            mIdRemito = o.IdRemito;
            mFechaRemito = o.FechaRemito ?? DateTime.MinValue;
            mNumero = o.NumeroRemito ?? 0;
            mIdCliente = o.IdCliente ?? 0;
            mIdProveedor = o.IdProveedor ?? 0;
            mObservaciones = o.Observaciones ?? "";
            mIdPuntoVenta = o.IdPuntoVenta ?? 0;
            mPuntoVenta = o.PuntoVenta ?? 0;
            mAnulado = o.Anulado ?? "";

            if ((o.NumeroRemito ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            if ((o.IdPuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el punto de venta"; }
            if ((o.PuntoVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el numero de sucursal"; }
            if ((o.IdCondicionVenta ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la condicion de venta"; }
            if ((o.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la obra"; }
            if (mIdCliente <= 0 && mIdProveedor <= 0) { sErrorMsg += "\n" + "Falta definir el destino (cliente o proveedor)"; }
            if ((o.Destino ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el destino"; }
            if ((o.TotalBultos ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cantidad de bultos"; }
            if ((o.ValorDeclarado ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el valor declarado"; }

            var Remitos = db.Remitos.Where(x => x.IdPuntoVenta == mIdPuntoVenta && x.NumeroRemito == mNumero && x.IdRemito != mIdRemito).Select(x => x.IdRemito).FirstOrDefault();
            if (Remitos > 0) { sErrorMsg += "\n" + "El remito ya existe."; }

            if (mIdCliente > 0) { if ((db.Clientes.Where(x => x.IdCliente == mIdCliente).Select(x => x.Estados_Proveedores.Activo).FirstOrDefault() ?? "") == "NO") { sErrorMsg += "\n" + "Cliente inhabilitado"; } }
            if (mIdProveedor > 0) { if ((db.Proveedores.Where(x => x.IdProveedor == mIdProveedor).Select(x => x.Estados_Proveedores.Activo).FirstOrDefault() ?? "") != "SI") { sErrorMsg += "\n" + "Proveedor inhabilitado"; } }

            //If Not IsNumeric(dcfields(5).BoundText) And dcfields(5).Visible And mvarTransportistaConEquipos Then
            //   MsgBox "Debe ingresar el equipo de transporte", vbExclamation
            //   Exit Sub
            //End If

            //If BuscarClaveINI("Controlar la imputacion de varios ordenes de compra en un mismo remito de venta") = "SI" Then
            //   mvarAux1 = origen.DetRemitos.OrdenesCompraImputadas
            //   If InStr(1, mvarAux1, ",") <> 0 Then
            //      MsgBox "El remito imputa a mas de una nota de venta : " & mvarAux1, vbInformation
            //   End If
            //End If

            //If txtPesoNeto.Visible Then
            //   If Val(txtPesoNeto.Text) <> origen.DetRemitos.TotalCantidad Then
            //      mvarSeguro = MsgBox("La suma de cantidades de los items del remito no coincide con el peso neto informado, Desea continuar?", vbYesNo, "Sin orden de compra")
            //      If mvarSeguro = vbNo Then Exit Sub
            //   End If
            //End If

            mProntoIni_InhabilitarUbicaciones = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock", -1) ?? "";
            mProntoIni_InhabilitarStockNegativo = BuscarClaveINI("Inhabilitar stock negativo", -1) ?? "";
            mProntoIni_InhabilitarStockNegativoGlobal = BuscarClaveINI("Inhabilitar stock global negativo", -1) ?? "";
            mProntoIni_ExigirOrdenCompra = BuscarClaveINI("Exigir orden de compra en remitos", -1) ?? "";
            mProntoIni_NoPermitirItemsEnCero = BuscarClaveINI("No permitir items en cero en remitos de venta", -1) ?? "";
            mProntoIni_AvisarOrdenCompraPendiente = BuscarClaveINI("Avisar si hay orden de compra pendientes en remitos", -1) ?? "";
            mProntoIni_ControlLimiteCredito = BuscarClaveINI("Control de limite de credito en remitos", -1) ?? "";

            if (o.DetalleRemitos.Count <= 0) sErrorMsg += "\n" + "La Remito no tiene items";
            foreach (ProntoMVC.Data.Models.DetalleRemito x in o.DetalleRemitos)
            {
                mIdArticulo = (x.IdArticulo ?? 0);
                mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == mIdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "";
                mCantidad = (x.Cantidad ?? 0);

                if (mIdArticulo == 0) { sErrorMsg += "\n" + "Hay items que no tienen articulo"; }
                if ((x.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin obra"; }
                if ((x.IdUbicacion ?? 0) <= 0 && mProntoIni_InhabilitarUbicaciones != "SI") { sErrorMsg += "\n" + "Hay items sin ubicacion"; }
                if ((x.TipoCancelacion ?? 0) == 0) { sErrorMsg += "\n" + "Hay items que no tienen definido el tipo de cancelacion"; }
                if (mCantidad <= 0 && mProntoIni_NoPermitirItemsEnCero == "SI") { sErrorMsg += "\n" + "Hay items que no tienen la cantidad mayor a cero"; }

                if ((x.IdDetalleOrdenCompra ?? 0) <= 0)
                {
                    if (mProntoIni_ExigirOrdenCompra == "SI") { sErrorMsg += "\n" + "Hay items sin imputar a orden de compra"; }
                    if (mProntoIni_AvisarOrdenCompraPendiente == "SI") { sWarningMsg += "\n" + "Hay items sin imputar a orden de compra"; }
                }

                // FALTA CONTROLAR SI EL ARTICULO ES UN PACK Y DESCONTAR POR COMPONENTES
                if (mRegistrarStock != "NO")
                {
                    var mStockGlobal1 = db.Stocks.Where(y => y.IdArticulo == mIdArticulo).Sum(y => y.CantidadUnidades);
                    mStockGlobal = mStockGlobal1 ?? 0;
                    mIdArticuloAnterior = 0;
                    mCantidadAnterior = 0;
                    if (x.IdDetalleRemito > 0)
                    {
                        DetalleRemito DetalleRemitoAnterior = db.DetalleRemitos.Where(c => c.IdDetalleRemito == x.IdDetalleRemito).FirstOrDefault();
                        if (DetalleRemitoAnterior != null)
                        {
                            mIdArticuloAnterior = DetalleRemitoAnterior.IdArticulo ?? 0;
                            mCantidadAnterior = DetalleRemitoAnterior.Cantidad ?? 0;
                        }
                    }
                    mCantidadNeta = mCantidad;
                    if (mIdArticulo == mIdArticuloAnterior) { mCantidadNeta = mCantidad - mCantidadAnterior; }
                    if (mCantidadNeta > mStockGlobal && mProntoIni_InhabilitarStockNegativoGlobal == "SI")
                    {
                        mArticulo = db.Articulos.Where(y => y.IdArticulo == mIdArticulo).Select(y => y.Descripcion).FirstOrDefault() ?? "";
                        sErrorMsg += "\n" + "El articulo " + mArticulo + ", no tiene stock global suficiente";
                    }
                }
            }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.Remito Remito)
        {
            if (!PuedeEditar(enumNodos.Remitos)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdRemito = 0;
                Int32 mNumero = 0;
                Int32 mIdCliente = 0;
                Int32 mIdTipoComprobante = 41;

                string errs = "";
                string warnings = "";
                string mWebService = "";

                bool mAnulado = false;

                //Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

                if (!Validar(Remito, ref errs, ref warnings))
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
                        mIdRemito = Remito.IdRemito;
                        mIdCliente = Remito.IdCliente ?? 0;
                        if (Remito.Anulado == "SI") { mAnulado = true; }

                        if (mIdRemito > 0)
                        {
                            var EntidadOriginal = db.Remitos.Where(p => p.IdRemito == mIdRemito).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(Remito);

                            //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
                            foreach (var d in Remito.DetalleRemitos)
                            {
                                var DetalleEntidadOriginal = EntidadOriginal.DetalleRemitos.Where(c => c.IdDetalleRemito == d.IdDetalleRemito && d.IdDetalleRemito > 0).SingleOrDefault();
                                if (DetalleEntidadOriginal != null)
                                {
                                    // Subir stock 
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
                                        Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) + (DetalleEntidadOriginal.Cantidad ?? 0);
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
                                        Stock.CantidadUnidades = DetalleEntidadOriginal.Cantidad ?? 0;
                                        db.Stocks.Add(Stock);
                                    }

                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetalleRemitos.Add(d);
                                }
                            }
                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleRemitos.Where(c => c.IdDetalleRemito != 0).ToList())
                            {
                                if (!Remito.DetalleRemitos.Any(c => c.IdDetalleRemito == DetalleEntidadOriginal.IdDetalleRemito))
                                {
                                    EntidadOriginal.DetalleRemitos.Remove(DetalleEntidadOriginal);
                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            ProntoMVC.Data.Models.PuntosVenta PuntoVenta = db.PuntosVentas.Where(c => c.IdPuntoVenta == Remito.IdPuntoVenta).SingleOrDefault();
                            if (PuntoVenta != null)
                            {
                                mNumero = PuntoVenta.ProximoNumero ?? 1;
                                Remito.NumeroRemito = mNumero;
                                PuntoVenta.ProximoNumero = mNumero + 1;
                                db.Entry(PuntoVenta).State = System.Data.Entity.EntityState.Modified;
                            }

                            db.Remitos.Add(Remito);
                            db.SaveChanges();
                        }

                        //////////////////////////////////////////////  STOCK  //////////////////////////////////////////////
                        if (!mAnulado)
                        {
                            // Bajar stock
                            foreach (var d in Remito.DetalleRemitos)
                            {
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
                                    Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) - (d.Cantidad ?? 0);
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
                                    Stock.CantidadUnidades = (d.Cantidad ?? 0) * -1;
                                    db.Stocks.Add(Stock);
                                }
                            }
                            db.SaveChanges();
                        }
                        db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.RemitosAgrupados.ToString(), Remito.IdRemito, "Remito");

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdRemito = Remito.IdRemito, ex = "" });
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


        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal, string PendienteFactura = "")
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Remitos.Include(x => x.DetalleRemitos)
                        from b in db.DescripcionIvas.Where(v => v.IdCodigoIva == a.Cliente.IdCodigoIva).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.Transportistas.Where(v => v.IdTransportista == a.IdTransportista).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdRemito,
                            a.DetalleRemitos,
                            a.IdCliente,
                            a.IdProveedor,
                            a.IdObra,
                            a.IdTransportista,
                            a.IdCondicionVenta,
                            a.IdListaPrecios,
                            a.Destino,
                            a.PuntoVenta,
                            a.NumeroRemito,
                            a.FechaRemito,
                            a.Anulado,
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            ClienteCuit = a.Cliente.Cuit,
                            DescripcionIva = b != null ? b.Descripcion : "",
                            ProveedorCodigo = a.Proveedore.CodigoEmpresa,
                            ProveedorNombre = a.Proveedore.RazonSocial,
                            ProveedorCuit = a.Proveedore.Cuit,
                            Obras = "",
                            OCompras = "",
                            Facturas = "",
                            Materiales = "",
                            TipoRemito = (a.Destino ?? 1) == 1 ? "A facturar" : ((a.Destino ?? 1) == 2 ? "A proveedor p/fabricar" : ((a.Destino ?? 1) == 3 ? "Con cargo devolucion" : ((a.Destino ?? 1) == 4 ? "Muestra" : ((a.Destino ?? 1) == 5 ? "A prestamo" : ((a.Destino ?? 1) == 6 ? "Traslado" : ""))))),
                            CondicionVenta = i != null ? i.Descripcion : "",
                            Transportista = d != null ? d.RazonSocial : "",
                            ListaDePrecio = j != null ? "Lista " + j.NumeroLista.ToString() + " " + j.Descripcion : "",
                            Obra = c != null ? c.NumeroObra : "",
                            a.TotalBultos,
                            a.ValorDeclarado,
                            CantidadItems = 0,
                            a.Chofer,
                            a.HoraSalida,
                            a.Observaciones,
                            PendienteFacturar = PendienteFactura == "SI"
                                                ? (db.DetalleRemitos.Where(x => x.IdRemito == a.IdRemito && (a.Anulado ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : y.PorcentajeCertificacion) -
                                                        (db.DetalleFacturasRemitos.Where(x => x.IdDetalleRemito == y.IdDetalleRemito && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0))) ?? 0
                                                : 1
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaRemito >= FechaDesde && a.FechaRemito <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .Where(x => (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))
                        .OrderByDescending(x => x.NumeroRemito)

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
                            id = a.IdRemito.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdRemito} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRemito} ) + ">Emitir</a> ",
                                a.IdRemito.ToString(),
                                a.IdCliente.NullSafeToString(),
                                a.IdProveedor.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdTransportista.NullSafeToString(),
                                a.IdCondicionVenta.NullSafeToString(),
                                a.IdListaPrecios.NullSafeToString(),
                                a.Destino.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroRemito.NullSafeToString(),
                                a.FechaRemito.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.ProveedorCodigo.NullSafeToString(),
                                a.ProveedorNombre.NullSafeToString(),
                                a.ProveedorCuit.NullSafeToString(),
                                string.Join(",", 
                                       a.DetalleRemitos
                                       .Select(x => 
                                           (x.Obra == null) ?
                                           "" :
                                           ((   x.Obra.NumeroObra == null) ? 
                                               "" :
                                               x.Obra.NumeroObra.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",", 
                                       a.DetalleRemitos
                                       .Select(x => 
                                           (x.DetalleOrdenesCompra == null) ?
                                           "" :
                                           ((   x.DetalleOrdenesCompra.OrdenesCompra == null) ? 
                                               "" :
                                               x.DetalleOrdenesCompra.OrdenesCompra.NumeroOrdenCompra.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",",  a.DetalleRemitos
                                    .SelectMany(x =>
                                        (x.DetalleFacturas == null) ?
                                        null :
                                        x.DetalleFacturas.Select(y =>
                                                    (y.Factura == null) ?
                                                    "" :
                                                    y.Factura.NumeroFactura.NullSafeToString()
                                            )
                                    ).Distinct()
                                ),
                                ""
                                //string.Join(",", 
                                //       a.DetalleRemitos
                                //       .Select(x => 
                                //          ( (x.Articulo == null) ?
                                //                    "" :   x.Articulo.Codigo.NullSafeToString() 
                                //           )
                                //       ).Distinct()
                                //)
                                ,
                                a.TipoRemito.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.ListaDePrecio.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.TotalBultos.NullSafeToString(),
                                a.ValorDeclarado.NullSafeToString(),
                                db.DetalleRemitos.Where(x=>x.IdRemito==a.IdRemito).Select(x=>x.IdDetalleRemito).Distinct().Count().ToString(),
                                a.Chofer.NullSafeToString(),
                                a.HoraSalida.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ActionResult TT_DynamicGridData_ConQueryEntera(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, string PendienteFactura = "")
        {



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;


            IQueryable<Data.Models.Remito> aaaa = db.Remitos.Take(19);


            ObjectQuery<Data.Models.Remito> set = aaaa as ObjectQuery<Data.Models.Remito>;


            var pagedQuery = Filters.FiltroGenerico_PasandoQueryEntera<Data.Models.Remito>
                                (db.Remitos.Take(19) as ObjectQuery<Data.Models.Remito>
                                , sidx, sord, page, rows, _search, filters, ref totalRecords);

            // .Where(x => (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))





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
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        //from d in db.Transportistas.Where(v => v.IdTransportista == a.IdTransportista).DefaultIfEmpty()
                        //from f in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        //from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        //from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdRemito,
                            a.DetalleRemitos,
                            a.IdCliente,
                            a.IdProveedor,
                            a.IdObra,
                            a.IdTransportista,
                            a.IdCondicionVenta,
                            a.IdListaPrecios,
                            a.Destino,
                            a.PuntoVenta,
                            a.NumeroRemito,
                            a.FechaRemito,
                            a.Anulado,
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            ClienteCuit = a.Cliente.Cuit,
                            DescripcionIva = a.Cliente.DescripcionIva.Descripcion,
                            ProveedorCodigo = a.Proveedore.CodigoEmpresa,
                            ProveedorNombre = a.Proveedore.RazonSocial,
                            ProveedorCuit = a.Proveedore.Cuit,
                            Obras = "",
                            OCompras = "",
                            Facturas = "",
                            Materiales = "",
                            TipoRemito = (a.Destino ?? 1) == 1 ? "A facturar" : ((a.Destino ?? 1) == 2 ? "A proveedor p/fabricar" :
                                          ((a.Destino ?? 1) == 3 ? "Con cargo devolucion" : ((a.Destino ?? 1) == 4 ?
                                        "Muestra" : ((a.Destino ?? 1) == 5 ? "A prestamo" : ((a.Destino ?? 1) == 6 ? "Traslado" : ""))))),
                            CondicionVenta = a.Condiciones_Compra.Descripcion,
                            Transportista = a.Transportista.RazonSocial,
                            ListaDePrecio = a.ListasPrecio != null ? "Lista " + a.ListasPrecio.NumeroLista.ToString() + " " + a.ListasPrecio.Descripcion : "",
                            Obra = a.Obra.NumeroObra,
                            a.TotalBultos,
                            a.ValorDeclarado,
                            CantidadItems = 0,
                            a.Chofer,
                            a.HoraSalida,
                            a.Observaciones,
                            PendienteFacturar = PendienteFactura == "SI"
                                                ? (db.DetalleRemitos.Where(x => x.IdRemito == a.IdRemito && (a.Anulado ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : y.PorcentajeCertificacion) -
                                                        (db.DetalleFacturasRemitos.Where(x => x.IdDetalleRemito == y.IdDetalleRemito &&
                                                           (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI")
                                                     .Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0))) ?? 0
                                                : 1
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaRemito >= FechaDesde && a.FechaRemito <= FechaHasta select a).AsQueryable();
            }


            //int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);



            var jsonData = new jqGridJson()
            {
                total = (int)Math.Ceiling((float)totalRecords / (float)pageSize),
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdRemito.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdRemito} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRemito} ) + ">Emitir</a> ",
                                a.IdRemito.ToString(),
                                a.IdCliente.NullSafeToString(),
                                a.IdProveedor.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdTransportista.NullSafeToString(),
                                a.IdCondicionVenta.NullSafeToString(),
                                a.IdListaPrecios.NullSafeToString(),
                                a.Destino.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroRemito.NullSafeToString(),
                                a.FechaRemito.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.ProveedorCodigo.NullSafeToString(),
                                a.ProveedorNombre.NullSafeToString(),
                                a.ProveedorCuit.NullSafeToString(),
                                string.Join(",", 
                                       a.DetalleRemitos
                                       .Select(x => 
                                           (x.Obra == null) ?
                                           "" :
                                           ((   x.Obra.NumeroObra == null) ? 
                                               "" :
                                               x.Obra.NumeroObra.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",", 
                                       a.DetalleRemitos
                                       .Select(x => 
                                           (x.DetalleOrdenesCompra == null) ?
                                           "" :
                                           ((   x.DetalleOrdenesCompra.OrdenesCompra == null) ? 
                                               "" :
                                               x.DetalleOrdenesCompra.OrdenesCompra.NumeroOrdenCompra.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",",  a.DetalleRemitos
                                    .SelectMany(x =>
                                        (x.DetalleFacturas == null) ?
                                        null :
                                        x.DetalleFacturas.Select(y =>
                                                    (y.Factura == null) ?
                                                    "" :
                                                    y.Factura.NumeroFactura.NullSafeToString()
                                            )
                                    ).Distinct()
                                ),
                                ""
                                //string.Join(",", 
                                //       a.DetalleRemitos
                                //       .Select(x => 
                                //          ( (x.Articulo == null) ?
                                //                    "" :   x.Articulo.Codigo.NullSafeToString() 
                                //           )
                                //       ).Distinct()
                                //)
                                ,
                                a.TipoRemito.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.ListaDePrecio.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.TotalBultos.NullSafeToString(),
                                a.ValorDeclarado.NullSafeToString(),
                                db.DetalleRemitos.Where(x=>x.IdRemito==a.IdRemito).Select(x=>x.IdDetalleRemito).Distinct().Count().ToString(),
                                a.Chofer.NullSafeToString(),
                                a.HoraSalida.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }




        public virtual ActionResult TT_DynamicGridData(string sidx, string sord, int page, int rows, bool _search, string filters, string FechaInicial, string FechaFinal, string PendienteFactura = "")
        {



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            int totalRecords = 0;

            var pagedQuery = Filters.FiltroGenerico<Data.Models.Remito>
                                ("Obra,Condiciones_Compra,Empleado,ListasPrecio,Transportista,DetalleRemito,DetalleOrdenesCompra,OrdenesCompra"
                                , sidx, sord, page, rows, _search, filters, db, ref totalRecords);



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
                        //from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        //from d in db.Transportistas.Where(v => v.IdTransportista == a.IdTransportista).DefaultIfEmpty()
                        //from f in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        //from i in db.Condiciones_Compras.Where(v => v.IdCondicionCompra == a.IdCondicionVenta).DefaultIfEmpty()
                        //from j in db.ListasPrecios.Where(v => v.IdListaPrecios == a.IdListaPrecios).DefaultIfEmpty()
                        select new
                        {
                            a.IdRemito,
                            a.DetalleRemitos,
                            a.IdCliente,
                            a.IdProveedor,
                            a.IdObra,
                            a.IdTransportista,
                            a.IdCondicionVenta,
                            a.IdListaPrecios,
                            a.Destino,
                            a.PuntoVenta,
                            a.NumeroRemito,
                            a.FechaRemito,
                            a.Anulado,
                            ClienteCodigo = a.Cliente.CodigoCliente,
                            ClienteNombre = a.Cliente.RazonSocial,
                            ClienteCuit = a.Cliente.Cuit,
                            DescripcionIva = a.Cliente.DescripcionIva.Descripcion,
                            ProveedorCodigo = a.Proveedore.CodigoEmpresa,
                            ProveedorNombre = a.Proveedore.RazonSocial,
                            ProveedorCuit = a.Proveedore.Cuit,
                            Obras = "",
                            OCompras = "",
                            Facturas = "",
                            Materiales = "",
                            TipoRemito = (a.Destino ?? 1) == 1 ? "A facturar" : ((a.Destino ?? 1) == 2 ? "A proveedor p/fabricar" :
                                          ((a.Destino ?? 1) == 3 ? "Con cargo devolucion" : ((a.Destino ?? 1) == 4 ?
                                        "Muestra" : ((a.Destino ?? 1) == 5 ? "A prestamo" : ((a.Destino ?? 1) == 6 ? "Traslado" : ""))))),
                            CondicionVenta = a.Condiciones_Compra.Descripcion,
                            Transportista = a.Transportista.RazonSocial,
                            ListaDePrecio = a.ListasPrecio != null ? "Lista " + a.ListasPrecio.NumeroLista.ToString() + " " + a.ListasPrecio.Descripcion : "",
                            Obra = a.Obra.NumeroObra,
                            a.TotalBultos,
                            a.ValorDeclarado,
                            CantidadItems = 0,
                            a.Chofer,
                            a.HoraSalida,
                            a.Observaciones,
                            PendienteFacturar = PendienteFactura == "SI"
                                                ? (db.DetalleRemitos.Where(x => x.IdRemito == a.IdRemito && (a.Anulado ?? "NO") != "SI")
                                                    .Sum(y => ((y.TipoCancelacion ?? 1) == 1 ? y.Cantidad : y.PorcentajeCertificacion) -
                                                        (db.DetalleFacturasRemitos.Where(x => x.IdDetalleRemito == y.IdDetalleRemito &&
                                                           (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI")
                                                     .Sum(z => ((y.TipoCancelacion ?? 1) == 1 ? z.DetalleFactura.Cantidad : z.DetalleFactura.PorcentajeCertificacion)) ?? 0))) ?? 0
                                                : 1
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaRemito >= FechaDesde && a.FechaRemito <= FechaHasta select a).AsQueryable();
            }


            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a)
                        .Where(x => (PendienteFactura != "SI" || (PendienteFactura == "SI" && x.PendienteFacturar > 0)))
                        .OrderByDescending(x => x.NumeroRemito)

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
                            id = a.IdRemito.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdRemito} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdRemito} ) + ">Emitir</a> ",
                                a.IdRemito.ToString(),
                                a.IdCliente.NullSafeToString(),
                                a.IdProveedor.NullSafeToString(),
                                a.IdObra.NullSafeToString(),
                                a.IdTransportista.NullSafeToString(),
                                a.IdCondicionVenta.NullSafeToString(),
                                a.IdListaPrecios.NullSafeToString(),
                                a.Destino.NullSafeToString(),
                                a.PuntoVenta.NullSafeToString(),
                                a.NumeroRemito.NullSafeToString(),
                                a.FechaRemito.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.ClienteCodigo.NullSafeToString(),
                                a.ClienteNombre.NullSafeToString(),
                                a.ClienteCuit.NullSafeToString(),
                                a.DescripcionIva.NullSafeToString(),
                                a.ProveedorCodigo.NullSafeToString(),
                                a.ProveedorNombre.NullSafeToString(),
                                a.ProveedorCuit.NullSafeToString(),
                                string.Join(",", 
                                       a.DetalleRemitos
                                       .Select(x => 
                                           (x.Obra == null) ?
                                           "" :
                                           ((   x.Obra.NumeroObra == null) ? 
                                               "" :
                                               x.Obra.NumeroObra.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",", 
                                       a.DetalleRemitos
                                       .Select(x => 
                                           (x.DetalleOrdenesCompra == null) ?
                                           "" :
                                           ((   x.DetalleOrdenesCompra.OrdenesCompra == null) ? 
                                               "" :
                                               x.DetalleOrdenesCompra.OrdenesCompra.NumeroOrdenCompra.NullSafeToString()
                                           )
                                       ).Distinct()
                                ),
                                string.Join(",",  a.DetalleRemitos
                                    .SelectMany(x =>
                                        (x.DetalleFacturas == null) ?
                                        null :
                                        x.DetalleFacturas.Select(y =>
                                                    (y.Factura == null) ?
                                                    "" :
                                                    y.Factura.NumeroFactura.NullSafeToString()
                                            )
                                    ).Distinct()
                                ),
                                ""
                                //string.Join(",", 
                                //       a.DetalleRemitos
                                //       .Select(x => 
                                //          ( (x.Articulo == null) ?
                                //                    "" :   x.Articulo.Codigo.NullSafeToString() 
                                //           )
                                //       ).Distinct()
                                //)
                                ,
                                a.TipoRemito.NullSafeToString(),
                                a.CondicionVenta.NullSafeToString(),
                                a.Transportista.NullSafeToString(),
                                a.ListaDePrecio.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.TotalBultos.NullSafeToString(),
                                a.ValorDeclarado.NullSafeToString(),
                                db.DetalleRemitos.Where(x=>x.IdRemito==a.IdRemito).Select(x=>x.IdDetalleRemito).Distinct().Count().ToString(),
                                a.Chofer.NullSafeToString(),
                                a.HoraSalida.NullSafeToString(),
                                a.Observaciones.NullSafeToString(),
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }





        public virtual ActionResult DetRemito(string sidx, string sord, int? page, int? rows, int? IdRemito)
        {
            int IdRemito1 = IdRemito ?? 0;
            var Det = db.DetalleRemitos.Where(p => p.IdRemito == IdRemito1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from c in db.Depositos.Where(o => o.IdDeposito == a.Ubicacione.IdDeposito).DefaultIfEmpty()
                        from d in db.DetalleOrdenesCompras.Where(o => o.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRemito,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.IdUbicacion,
                            a.IdObra,
                            a.OrigenDescripcion,
                            a.TipoCancelacion,
                            a.IdDetalleOrdenCompra,
                            a.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            Unidad = a.Unidade.Abreviatura,
                            a.PorcentajeCertificacion,
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            TiposCancelacion = (a.TipoCancelacion ?? 1) == 1 ? "Por cantidad" : ((a.TipoCancelacion ?? 1) == 2 ? "Por certificacion" : ""),
                            Ubicacion = (c != null ? c.Abreviatura : "") + (a.Ubicacione.Descripcion != null ? " " + a.Ubicacione.Descripcion : "") + (a.Ubicacione.Estanteria != null ? " Est.:" + a.Ubicacione.Estanteria : "") + (a.Ubicacione.Modulo != null ? " Mod.:" + a.Ubicacione.Modulo : "") + (a.Ubicacione.Gabeta != null ? " Gab.:" + a.Ubicacione.Gabeta : ""),
                            Obra = a.Obra.NumeroObra,
                            a.Partida,
                            a.NumeroCaja,
                            a.Observaciones,
                            OrdenCompraNumero = d.OrdenesCompra.NumeroOrdenCompra,
                            OrdenCompraItem = d.NumeroItem,
                        }).OrderBy(x => x.NumeroItem)
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
                            id = a.IdDetalleRemito.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleRemito.ToString(), 
                            a.IdArticulo.NullSafeToString(),
                            a.IdUnidad.NullSafeToString(),
                            a.IdColor.NullSafeToString(),
                            a.IdUbicacion.NullSafeToString(),
                            a.IdObra.NullSafeToString(),
                            a.OrigenDescripcion.NullSafeToString(),
                            a.TipoCancelacion.NullSafeToString(),
                            a.IdDetalleOrdenCompra.NullSafeToString(),
                            a.NumeroItem.NullSafeToString(),
                            a.Codigo.NullSafeToString(),
                            a.Articulo.NullSafeToString(),
                            a.Cantidad.NullSafeToString(),
                            a.Unidad.NullSafeToString(),
                            a.PorcentajeCertificacion.NullSafeToString(),
                            a.TiposDeDescripcion.NullSafeToString(),
                            a.TiposCancelacion.NullSafeToString(),
                            a.Ubicacion.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.Partida.NullSafeToString(),
                            a.NumeroCaja.NullSafeToString(),
                            a.Observaciones.NullSafeToString(),
                            a.OrdenCompraNumero == null ? "" : a.OrdenCompraNumero.ToString().PadLeft(8,'0') + "/" + a.OrdenCompraItem.ToString().PadLeft(2,'0')
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult DetRemitosSinFormato(int IdRemito)
        {
            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            decimal mPorcentajeIva = parametros.Iva1 ?? 0;

            var Det = db.DetalleRemitos.Where(p => p.IdRemito == IdRemito).AsQueryable();

            var data = (from a in Det
                        from b in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
                        from c in db.Obras.Where(v => v.IdObra == a.IdObra).DefaultIfEmpty()
                        from d in db.DetalleOrdenesCompras.Where(v => v.IdDetalleOrdenCompra == a.IdDetalleOrdenCompra).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleRemito,
                            a.IdArticulo,
                            a.IdUnidad,
                            a.IdColor,
                            a.OrigenDescripcion,
                            a.IdDetalleOrdenCompra,
                            a.TipoCancelacion,
                            a.Remito.IdObra,
                            a.NumeroItem,
                            Codigo = a.Articulo.Codigo,
                            Articulo = a.Articulo.Descripcion + (b != null ? " " + b.Descripcion : ""),
                            a.Cantidad,
                            PendienteFacturar = (a.TipoCancelacion ?? 1) == 1
                                                ? a.Cantidad - (db.DetalleFacturasRemitos.Where(x => x.IdDetalleRemito == a.IdDetalleRemito && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => z.DetalleFactura.Cantidad) ?? 0)
                                                : (a.PorcentajeCertificacion ?? 100) - (db.DetalleFacturasRemitos.Where(x => x.IdDetalleRemito == a.IdDetalleRemito && (x.DetalleFactura.Factura.Anulada ?? "NO") != "SI").Sum(z => z.DetalleFactura.PorcentajeCertificacion) ?? 0),
                            Unidad = a.Unidade.Abreviatura,
                            Precio = a.Precio != null ? Math.Round((double)a.Precio, 2) : (d.Precio != null ? Math.Round((double)d.Precio, 2) : 0),
                            PorcentajeBonificacion = d.PorcentajeBonificacion != null ? d.PorcentajeBonificacion : 0,
                            Importe = Math.Round((double)a.Cantidad * (a.Precio != null ? Math.Round((double)a.Precio, 2) : (d.Precio != null ? Math.Round((double)d.Precio, 2) : 0)) * (double)(1 - (d.PorcentajeBonificacion != null ? d.PorcentajeBonificacion : 0) / 100), 2),
                            TiposDeDescripcion = (a.OrigenDescripcion ?? 1) == 1 ? "Solo material" : ((a.OrigenDescripcion ?? 1) == 2 ? "Solo observaciones" : ((a.OrigenDescripcion ?? 1) == 3 ? "Material + observaciones" : "")),
                            TiposCancelacion = (a.TipoCancelacion ?? 1) == 1 ? "Por cantidad" : ((a.TipoCancelacion ?? 1) == 2 ? "Por certificacion" : ""),
                            a.Observaciones,
                            Obra = c != null ? c.NumeroObra : "",
                            OrdenCompraNumero = (d.OrdenesCompra.NumeroOrdenCompra != null ? d.OrdenesCompra.NumeroOrdenCompra.ToString() + "/" : "") + (d.NumeroItem != null ? d.NumeroItem.ToString() : ""),
                            RemitoNumero = (a.Remito.NumeroRemito != null ? a.Remito.NumeroRemito.ToString() + "/" : "") + (a.NumeroItem != null ? a.NumeroItem.ToString() : ""),
                            PorcentajeIva = mPorcentajeIva,
                            IdCodigoIva = a.Remito.Cliente.IdCodigoIva
                        }).OrderBy(p => p.NumeroItem).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdRemito, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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