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
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace ProntoMVC.Controllers
{
    public partial class DepositoBancarioController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.DepositosBancarios)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            DepositosBancario o;

            try
            {
                if (!PuedeLeer(enumNodos.DepositosBancarios))
                {
                    o = new DepositosBancario();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new DepositosBancario();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new DepositosBancario();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.DepositosBancarios.SingleOrDefault(x => x.IdDepositoBancario == id);
                CargarViewBag(o);
                Session.Add("AjusteStock", o);
                return View(o);
            }
        }

        void CargarViewBag(DepositosBancario o)
        {
            //ViewBag.IdRealizo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdRealizo);
            //ViewBag.IdAprobo = new SelectList(db.Empleados, "IdEmpleado", "Nombre", o.IdAprobo);
        }

        void inic(ref DepositosBancario o)
        {
            o.FechaDeposito = DateTime.Today;
        }

//        private bool Validar(ProntoMVC.Data.Models.DepositosBancario o, ref string sErrorMsg, ref string sWarningMsg)
//        {
//            if (!PuedeEditar(enumNodos.DepositosBancarios)) sErrorMsg += "\n" + "No tiene permisos de edición";

//            Int32 mIdDepositoBancario = 0;
//            Int32 mNumero = 0;
//            Int32 mIdTipoComprobante = 106;
//            Int32 mIdArticulo = 0;
//            Int32 mIdArticuloAnterior = 0;

//            decimal mCantidad = 0;
//            decimal mCantidadAnterior = 0;
//            decimal mCantidadNeta = 0;
//            decimal mStockGlobal = 0;

//            string mObservaciones = "";
//            string mProntoIni_InhabilitarUbicaciones = "";
//            string mProntoIni_InhabilitarStockNegativo = "";
//            string mProntoIni_InhabilitarStockNegativoGlobal = "";
//            string mProntoIni_ExigirOrdenCompra = "";
//            string mProntoIni_NoPermitirItemsEnCero = "";
//            string mAnulado = "";
//            string mRegistrarStock = "";
//            string mArticulo = "";

//            DateTime mFechaAjuste = DateTime.Today;

//            mIdDepositoBancario = o.IdDepositoBancario;
//            mFechaAjuste = o.FechaAjuste ?? DateTime.MinValue;
//            mNumero = o.NumeroAjusteStock ?? 0;
//            mObservaciones = o.Observaciones ?? "";

//            if ((o.NumeroAjusteStock ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número"; }
            
//            var DepositosBancarios = db.DepositosBancarios.Where(x => x.NumeroAjusteStock == mNumero && x.IdDepositoBancario != mIdDepositoBancario).Select(x => x.IdDepositoBancario).FirstOrDefault();
//            if (DepositosBancarios > 0) { sErrorMsg += "\n" + "El numero de ajuste de stock ya existe."; }

//            mProntoIni_InhabilitarUbicaciones = BuscarClaveINI("Inhabilitar ubicaciones en movimientos de stock", -1) ?? "";
//            mProntoIni_InhabilitarStockNegativo = BuscarClaveINI("Inhabilitar stock negativo", -1) ?? "";
//            mProntoIni_InhabilitarStockNegativoGlobal = BuscarClaveINI("Inhabilitar stock global negativo", -1) ?? "";
//            mProntoIni_ExigirOrdenCompra = BuscarClaveINI("Exigir orden de compra en DepositosBancarios", -1) ?? "";
//            mProntoIni_NoPermitirItemsEnCero = BuscarClaveINI("No permitir items en cero en DepositosBancarios de venta", -1) ?? "";

//            if (o.DetalleDepositosBancarios.Count <= 0) sErrorMsg += "\n" + "El ajuste de stock no tiene items";
//            foreach (ProntoMVC.Data.Models.DetalleDepositosBancarios x in o.DetalleDepositosBancarios)
//            {
//                mIdArticulo = (x.IdArticulo ?? 0);
//                mRegistrarStock = db.Articulos.Where(y => y.IdArticulo == mIdArticulo).Select(y => y.RegistrarStock).FirstOrDefault() ?? "";
//                mCantidad = (x.CantidadUnidades ?? 0);

//                if (mIdArticulo == 0) { sErrorMsg += "\n" + "Hay items que no tienen articulo"; }
//                if ((x.IdObra ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items sin obra"; }
//                if ((x.IdUbicacion ?? 0) <= 0 && mProntoIni_InhabilitarUbicaciones != "SI") { sErrorMsg += "\n" + "Hay items sin ubicacion"; }

//                // FALTA CONTROLAR SI EL ARTICULO ES UN PACK Y DESCONTAR POR COMPONENTES
//                if (mRegistrarStock != "NO") {
//                    var mStockGlobal1 = db.Stocks.Where(y => y.IdArticulo == mIdArticulo).Sum(y => y.CantidadUnidades);
//                    mStockGlobal = mStockGlobal1 ?? 0;
//                    mIdArticuloAnterior = 0;
//                    mCantidadAnterior = 0;
//                    if (x.IdDetalleAjusteStock > 0) {
//                        DetalleDepositosBancarios DetalleAjusteStockAnterior = db.DetalleDepositosBancarios.Where(c => c.IdDetalleAjusteStock == x.IdDetalleAjusteStock).FirstOrDefault();
//                        if (DetalleAjusteStockAnterior != null)
//                        {
//                            mIdArticuloAnterior = DetalleAjusteStockAnterior.IdArticulo ?? 0;
//                            mCantidadAnterior = DetalleAjusteStockAnterior.CantidadUnidades ?? 0;
//                        }
//                    }
//                    mCantidadNeta = mCantidad;
//                    if (mIdArticulo == mIdArticuloAnterior) { mCantidadNeta = mCantidad + mCantidadAnterior; }
//                    if (mCantidadNeta > mStockGlobal && mProntoIni_InhabilitarStockNegativoGlobal == "SI") {
//                        mArticulo = db.Articulos.Where(y => y.IdArticulo == mIdArticulo).Select(y => y.Descripcion).FirstOrDefault() ?? "";
//                        sErrorMsg += "\n" + "El articulo " + mArticulo + ", no tiene stock global suficiente"; 
//                    }
//                }
//            }

//            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
//            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
//            if (sErrorMsg != "") return false;
//            return true;
//        }

//        [HttpPost]
//        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.DepositosBancario AjusteStock)
//        {
//            if (!PuedeEditar(enumNodos.DepositosBancarios)) throw new Exception("No tenés permisos");

//            try
//            {
//                Int32 mIdDepositoBancario = 0;
//                Int32 mNumero = 0;
//                Int32 mIdTipoComprobante = 106;

//                string errs = "";
//                string warnings = "";
//                string mWebService = "";

//                bool mAnulado = false;

//                //Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();

//                string usuario = ViewBag.NombreUsuario;
//                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();

//                if (AjusteStock.IdDepositoBancario > 0)
//                {
//                    AjusteStock.IdUsuarioModifico = IdUsuario;
//                    AjusteStock.FechaModifico = DateTime.Now;
//                }
//                else
//                {
//                    AjusteStock.IdUsuarioIngreso = IdUsuario;
//                    AjusteStock.FechaIngreso = DateTime.Now;
//                }

//                if (!Validar(AjusteStock, ref errs, ref warnings))
//                {
//                    try
//                    {
//                        Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
//                    }
//                    catch (Exception)
//                    {
//                    }

//                    JsonResponse res = new JsonResponse();
//                    res.Status = Status.Error;

//                    string[] words = errs.Split('\n');
//                    res.Errors = words.ToList();
//                    res.Message = "Hay datos invalidos";

//                    return Json(res);
//                }

//                if (ModelState.IsValid)
//                {
//                    using (TransactionScope scope = new TransactionScope())
//                    {
//                        mIdDepositoBancario = AjusteStock.IdDepositoBancario;

//                        if (mIdDepositoBancario > 0)
//                        {
//                            var EntidadOriginal = db.DepositosBancarios.Where(p => p.IdDepositoBancario == mIdDepositoBancario).SingleOrDefault();

//                            var EntidadoEntry = db.Entry(EntidadOriginal);
//                            EntidadoEntry.CurrentValues.SetValues(AjusteStock);

//                            //////////////////////////////////////////////// ITEMS ////////////////////////////////////////////////
//                            foreach (var d in AjusteStock.DetalleDepositosBancarios)
//                            {
//                                var DetalleEntidadOriginal = EntidadOriginal.DetalleDepositosBancarios.Where(c => c.IdDetalleAjusteStock == d.IdDetalleAjusteStock && d.IdDetalleAjusteStock > 0).SingleOrDefault();
//                                if (DetalleEntidadOriginal != null)
//                                {
//                                    // Restaurar stock 
//                                    Stock Stock = db.Stocks.Where(
//                                        c => c.IdArticulo == DetalleEntidadOriginal.IdArticulo &&
//                                             (c.Partida ?? "") == (DetalleEntidadOriginal.Partida ?? "") &&
//                                             (c.IdUbicacion ?? 0) == (DetalleEntidadOriginal.IdUbicacion ?? 0) &&
//                                             (c.IdObra ?? 0) == (DetalleEntidadOriginal.IdObra ?? 0) &&
//                                             (c.IdUnidad ?? 0) == (DetalleEntidadOriginal.IdUnidad ?? 0) &&
//                                             (c.NumeroCaja ?? 0) == (DetalleEntidadOriginal.NumeroCaja ?? 0) &&
//                                             (c.IdColor ?? 0) == (DetalleEntidadOriginal.IdColor ?? 0) &&
//                                             (c.Talle ?? "") == (DetalleEntidadOriginal.Talle ?? "")
//                                    ).FirstOrDefault();
//                                    if (Stock != null)
//                                    {
//                                        Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) - (DetalleEntidadOriginal.CantidadUnidades ?? 0);
//                                        db.Entry(Stock).State = System.Data.Entity.EntityState.Modified;
//                                    }
//                                    else
//                                    {
//                                        Stock = new Stock();
//                                        Stock.IdArticulo = DetalleEntidadOriginal.IdArticulo;
//                                        Stock.Partida = DetalleEntidadOriginal.Partida ?? "";
//                                        Stock.IdUbicacion = DetalleEntidadOriginal.IdUbicacion ?? 0;
//                                        Stock.IdObra = DetalleEntidadOriginal.IdObra ?? 0;
//                                        Stock.IdUnidad = DetalleEntidadOriginal.IdUnidad ?? 0;
//                                        Stock.NumeroCaja = DetalleEntidadOriginal.NumeroCaja ?? 0;
//                                        Stock.IdColor = DetalleEntidadOriginal.IdColor ?? 0;
//                                        Stock.Talle = DetalleEntidadOriginal.Talle ?? "";
//                                        Stock.CantidadUnidades = (DetalleEntidadOriginal.CantidadUnidades ?? 0) * -1;
//                                        db.Stocks.Add(Stock);
//                                    }

//                                    var DetalleEntidadEntry = db.Entry(DetalleEntidadOriginal);
//                                    DetalleEntidadEntry.CurrentValues.SetValues(d);
//                                }
//                                else
//                                {
//                                    EntidadOriginal.DetalleDepositosBancarios.Add(d);
//                                }
//                            }
//                            foreach (var DetalleEntidadOriginal in EntidadOriginal.DetalleDepositosBancarios.Where(c => c.IdDetalleAjusteStock != 0).ToList())
//                            {
//                                if (!AjusteStock.DetalleDepositosBancarios.Any(c => c.IdDetalleAjusteStock == DetalleEntidadOriginal.IdDetalleAjusteStock))
//                                {
//                                    EntidadOriginal.DetalleDepositosBancarios.Remove(DetalleEntidadOriginal);
//                                    db.Entry(DetalleEntidadOriginal).State = System.Data.Entity.EntityState.Deleted;
//                                }
//                            }

//                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
//                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
//                            db.SaveChanges();
//                        }
//                        else
//                        {
//                            Parametros parametros2 = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
//                            if (parametros2 != null)
//                            {
//                                mNumero = parametros2.ProximoNumeroAjusteStock ?? 1;
//                                AjusteStock.NumeroAjusteStock = mNumero;
//                                parametros2.ProximoNumeroAjusteStock = mNumero + 1;
//                                db.Entry(parametros2).State = System.Data.Entity.EntityState.Modified;
//                            }

//                            db.DepositosBancarios.Add(AjusteStock);
//                            db.SaveChanges();
//                        }

//                        //////////////////////////////////////////////  STOCK  //////////////////////////////////////////////
//                        if (!mAnulado)
//                        {
//                            // Registrar stock
//                            foreach (var d in AjusteStock.DetalleDepositosBancarios)
//                            {
//                                Stock Stock = db.Stocks.Where(
//                                    c => c.IdArticulo == d.IdArticulo &&
//                                         (c.Partida ?? "") == (d.Partida ?? "") &&
//                                         (c.IdUbicacion ?? 0) == (d.IdUbicacion ?? 0) &&
//                                         (c.IdObra ?? 0) == (d.IdObra ?? 0) &&
//                                         (c.IdUnidad ?? 0) == (d.IdUnidad ?? 0) &&
//                                         (c.NumeroCaja ?? 0) == (d.NumeroCaja ?? 0) &&
//                                         (c.IdColor ?? 0) == (d.IdColor ?? 0) &&
//                                         (c.Talle ?? "") == (d.Talle ?? "")
//                                ).FirstOrDefault();
//                                if (Stock != null)
//                                {
//                                    Stock.CantidadUnidades = (Stock.CantidadUnidades ?? 0) + (d.CantidadUnidades ?? 0);
//                                    db.Entry(Stock).State = System.Data.Entity.EntityState.Modified;
//                                }
//                                else
//                                {
//                                    Stock = new Stock();
//                                    Stock.IdArticulo = d.IdArticulo;
//                                    Stock.Partida = d.Partida ?? "";
//                                    Stock.IdUbicacion = d.IdUbicacion ?? 0;
//                                    Stock.IdObra = d.IdObra ?? 0;
//                                    Stock.IdUnidad = d.IdUnidad ?? 0;
//                                    Stock.NumeroCaja = d.NumeroCaja ?? 0;
//                                    Stock.IdColor = d.IdColor ?? 0;
//                                    Stock.Talle = d.Talle ?? "";
//                                    Stock.CantidadUnidades = (d.CantidadUnidades ?? 0);
//                                    db.Stocks.Add(Stock);
//                                }
//                            }
//                            db.SaveChanges();
//                        }

//                        scope.Complete();
//                        scope.Dispose();
//                    }

//                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

//                    return Json(new { Success = 1, IdDepositoBancario = AjusteStock.IdDepositoBancario, ex = "" });
//                }
//                else
//                {
//                    Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
//                    Response.TrySkipIisCustomErrors = true;

//                    JsonResponse res = new JsonResponse();
//                    res.Status = Status.Error;
//                    res.Errors = GetModelStateErrorsAsString(this.ModelState);
//                    res.Message = "El comprobante tiene datos invalidos";

//                    return Json(res);
//                }
//            }

//            catch (TransactionAbortedException ex)
//            {
//                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
//                Response.TrySkipIisCustomErrors = true;
//                return Json("TransactionAbortedException Message: {0}", ex.Message);
//            }
//            catch (Exception ex)
//            {
//                Response.StatusCode = (int)System.Net.HttpStatusCode.BadRequest;
//                Response.TrySkipIisCustomErrors = true;

//                List<string> errors = new List<string>();
//                errors.Add(ex.Message);
//                return Json(errors);
//            }
//        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.DepositosBancarios
                        from b in db.Bancos.Where(y => y.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Empleados.Where(y => y.IdEmpleado == a.IdAutorizaAnulacion).DefaultIfEmpty()
                        select new
                        {
                            a.IdDepositoBancario,
                            a.IdBanco,
                            a.IdAutorizaAnulacion,
                            a.FechaDeposito,
                            Banco = b != null ? b.Nombre : "",
                            a.NumeroDeposito,
                            Valores = 0, //(db.DetalleDepositosBancarios.Where(x => x.IdDepositoBancario == a.IdDepositoBancario && (a.Anulado ?? "NO") != "SI").Sum(y => (y.Valore.Importe ?? 0))),
                            a.Efectivo,
                            a.Anulado,
                            Anulo = c != null ? c.Nombre : "",
                            a.FechaAnulacion,
                            CantidadItems = db.DetalleDepositosBancarios.Where(x => x.IdDepositoBancario == a.IdDepositoBancario && (a.Anulado ?? "NO") != "SI").Select(x => x.IdDetalleDepositoBancario).Distinct().Count().ToString()
                        }).AsQueryable();

            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaDeposito >= FechaDesde && a.FechaDeposito <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a).OrderByDescending(x => x.FechaDeposito)
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
                            id = a.IdDepositoBancario.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdDepositoBancario} ) + ">Editar</>",
                                "<a href="+ Url.Action("Imprimir",new {id = a.IdDepositoBancario} ) + ">Emitir</a> ",
                                a.IdDepositoBancario.ToString(),
                                a.IdBanco.NullSafeToString(),
                                a.IdAutorizaAnulacion.NullSafeToString(),
                                a.FechaDeposito == null ? "" : a.FechaDeposito.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Banco.NullSafeToString(),
                                a.NumeroDeposito.NullSafeToString(),
                                db.DetalleDepositosBancarios.Where(x=>x.IdDepositoBancario==a.IdDepositoBancario).Select(x=>(x.Valore.Importe ?? 0)).Sum().NullSafeToString(),
                                //db.DetalleDepositosBancarios.Where(x=>x.IdDepositoBancario==a.IdDepositoBancario && (a.Anulado ?? "NO") != "SI").Select(x=>(x.Valore.Importe ?? 0)).Sum().NullSafeToString(),
                                a.Efectivo.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.Anulo,
                                a.FechaAnulacion == null ? "" : a.FechaAnulacion.GetValueOrDefault().ToString("dd/MM/yyyy")
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

//        public virtual ActionResult DetAjusteStock(string sidx, string sord, int? page, int? rows, int? IdDepositoBancario)
//        {
//            int IdDepositoBancario1 = IdDepositoBancario ?? 0;
//            var Det = db.DetalleDepositosBancarios.Where(p => p.IdDepositoBancario == IdDepositoBancario1).AsQueryable();
//            int pageSize = rows ?? 20;
//            int totalRecords = Det.Count();
//            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
//            int currentPage = page ?? 1;

//            var data = (from a in Det
//                        from b in db.Articulos.Where(o => o.IdArticulo == a.IdArticulo).DefaultIfEmpty()
//                        from c in db.Colores.Where(o => o.IdColor == a.IdColor).DefaultIfEmpty()
//                        from d in db.Ubicaciones.Where(o => o.IdUbicacion == a.IdUbicacion).DefaultIfEmpty()
//                        from e in db.Depositos.Where(o => o.IdDeposito == d.IdDeposito).DefaultIfEmpty()
//                        from f in db.Unidades.Where(o => o.IdUnidad == a.IdUnidad).DefaultIfEmpty()
//                        from g in db.Obras.Where(o => o.IdObra == a.IdObra).DefaultIfEmpty()
//                        select new
//                        {
//                            a.IdDetalleAjusteStock,
//                            a.IdArticulo,
//                            a.IdUnidad,
//                            a.IdColor,
//                            a.IdUbicacion,
//                            a.IdObra,
//                            Codigo = b.Codigo != null ? b.Codigo : "",
//                            Articulo = (b.Descripcion != null ? b.Descripcion : "") + (c != null ? " " + c.Descripcion : ""),
//                            a.CantidadUnidades,
//                            Unidad = f.Abreviatura != null ? f.Abreviatura : "",
//                            a.Partida,
//                            a.NumeroCaja,
//                            Obra = g.NumeroObra != null ? g.NumeroObra : "",
//                            Ubicacion = (e != null ? e.Abreviatura : "") + (d.Descripcion != null ? " " + d.Descripcion : "") + (d.Estanteria != null ? " Est.:" + d.Estanteria : "") + (d.Modulo != null ? " Mod.:" + d.Modulo : "") + (d.Gabeta != null ? " Gab.:" + d.Gabeta : ""),
//                            a.Observaciones,
//                        }).OrderBy(x => x.IdDetalleAjusteStock)
//                //.Skip((currentPage - 1) * pageSize).Take(pageSize)
//.ToList();

//            var jsonData = new jqGridJson()
//            {
//                total = totalPages,
//                page = currentPage,
//                records = totalRecords,
//                rows = (from a in data
//                        select new jqGridRowJson
//                        {
//                            id = a.IdDetalleAjusteStock.ToString(),
//                            cell = new string[] { 
//                            string.Empty, 
//                            a.IdDetalleAjusteStock.ToString(), 
//                            a.IdArticulo.NullSafeToString(),
//                            a.IdUnidad.NullSafeToString(),
//                            a.IdColor.NullSafeToString(),
//                            a.IdUbicacion.NullSafeToString(),
//                            a.IdObra.NullSafeToString(),
//                            a.Codigo.NullSafeToString(),
//                            a.Articulo.NullSafeToString(),
//                            a.CantidadUnidades.NullSafeToString(),
//                            a.Unidad.NullSafeToString(),
//                            a.Partida.NullSafeToString(),
//                            a.NumeroCaja.NullSafeToString(),
//                            a.Obra.NullSafeToString(),
//                            a.Ubicacion.NullSafeToString(),
//                            a.Observaciones.NullSafeToString()
//                            }
//                        }).ToArray()
//            };
//            return Json(jsonData, JsonRequestBehavior.AllowGet);
//        }

        [HttpPost]
        public void EditGridData(int? IdDepositoBancario, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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