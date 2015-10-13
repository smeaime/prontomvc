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
                Session.Add("DepositosBancarios", o);
                return View(o);
            }
        }

        void CargarViewBag(DepositosBancario o)
        {
            ViewBag.IdMonedaEfectivo = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMonedaEfectivo);
            ViewBag.IdCaja = new SelectList(db.Cajas, "IdCaja", "Descripcion", o.IdCaja);
            ViewBag.IdCuentaBancaria = new SelectList((from i in db.CuentasBancarias
                                                       where i.Activa == "SI"
                                                       select new { IdCuentaBancaria = i.IdCuentaBancaria, Nombre = i.Banco.Nombre + " " + i.Cuenta }).Distinct(), "IdCuentaBancaria", "Nombre",o.IdCuentaBancaria);
        }

        void inic(ref DepositosBancario o)
        {
            o.FechaDeposito = DateTime.Today;
        }

        private bool Validar(ProntoMVC.Data.Models.DepositosBancario o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.DepositosBancarios)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdDepositoBancario = 0;
            Int32 mNumero = 0;

            decimal mEfectivo = 0;

            DateTime mFecha = DateTime.Today;

            mIdDepositoBancario = o.IdDepositoBancario;
            mNumero = o.NumeroDeposito ?? 0;
            mEfectivo = o.Efectivo ?? 0;

            if (mNumero <= 0) { sErrorMsg += "\n" + "Falta el número"; }

            if (mNumero.ToString().Length >7) { sErrorMsg += "\n" + "El numero de deposito no puede tener mas de 7 digitos"; }

            if ((o.IdCuentaBancaria ?? 0) == 0) { sErrorMsg += "\n" + "Falta el banco"; }

            if (o.FechaDeposito == null) { sErrorMsg += "\n" + "Falta la fecha del deposito"; }

            if (o.DetalleDepositosBancarios.Count <= 0 && mEfectivo == 0) sErrorMsg += "\n" + "El deposito no puede estar vacio";

            var DepositosBancarios = db.DepositosBancarios.Where(x => x.NumeroDeposito == mNumero && x.IdDepositoBancario != mIdDepositoBancario).Select(x => x.IdDepositoBancario).FirstOrDefault();
            if (DepositosBancarios > 0) { sErrorMsg += "\n" + "El numero de deposito ya existe."; }

            if (mEfectivo < 0 ) { sErrorMsg += "\n" + "El importe en efectivo debe ser mayor o igual a cero"; }
            if (mEfectivo > 0 && (o.IdCaja ?? 0) == 0) { sErrorMsg += "\n" + "No ingreso la caja origen del efectivo a depositar"; }
            if (mEfectivo > 0 && (o.IdMonedaEfectivo ?? 0) == 0) { sErrorMsg += "\n" + "No ingreso la moneda del efectivo a depositar"; }
            if (mEfectivo > 0 && (o.CotizacionMoneda ?? 0) == 0) { sErrorMsg += "\n" + "No ingreso la equivalencia a pesos del efectivo a depositar"; }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.DepositosBancario DepositoBancario)
        {
            if (!PuedeEditar(enumNodos.DepositosBancarios)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdDepositoBancario = 0;
                Int32 mNumero = 0;
                Int32 mIdTipoComprobante = 14;
                Int32 mIdBanco = 0;
                Int32 mIdCaja = 0;
                Int32 mIdTipoComprobanteEfectivo = 0;
                Int32 mIdMoneda = 1;
                Int32 mIdValor = 0;
                Int32 mIdCuentaValores = 0;
                Int32 mIdCuentaValores1 = 0;
                Int32 mIdCuentaCajaTitulo = 0;
                Int32 mIdCuentaCaja = 0;
                
                decimal mEfectivo = 0;
                decimal mCotizacionMoneda = 1;
                decimal mCotizacionMoneda2 = 1;
                decimal mImporteValor = 0;
                decimal mTotalValores = 0;

                string errs = "";
                string warnings = "";
                string mWebService = "";
                string mDetalleValor = "";
                
                bool mAnulado = false;

                Valore v;

                if (!Validar(DepositoBancario, ref errs, ref warnings))
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

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdTipoComprobanteEfectivo = parametros.IdTipoComprobanteEfectivo ?? 0;
                mIdCuentaValores = parametros.IdCuentaValores ?? 0;
                mIdCuentaCajaTitulo = parametros.IdCuentaCajaTitulo ?? 0;
                mIdCuentaCaja = parametros.IdCuentaCaja ?? 0;

                mIdBanco = db.CuentasBancarias.Where(x => x.IdCuentaBancaria == (DepositoBancario.IdCuentaBancaria ?? 0)).Select(x => (x.IdBanco ?? 0)).FirstOrDefault();
                DepositoBancario.IdBanco = mIdBanco;

                Banco Banco = db.Bancos.Where(c => c.IdBanco == mIdBanco).SingleOrDefault();
                if (Banco != null) { mIdCuentaValores1 = Banco.IdCuenta ?? mIdCuentaValores; }

                mIdCaja = DepositoBancario.IdCaja ?? 0;
                if (mIdCaja > 0)
                {
                    Caja Caja = db.Cajas.Where(c => c.IdCaja == mIdCaja).SingleOrDefault();
                    if (Caja != null) { mIdCuentaCaja = Caja.IdCuenta ?? mIdCuentaCaja; }
                }

                if (ModelState.IsValid)
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        mIdDepositoBancario = DepositoBancario.IdDepositoBancario;
                        if (DepositoBancario.Anulado == "SI") { mAnulado = true; }
                        mCotizacionMoneda = DepositoBancario.CotizacionMoneda ?? 1;
                        mEfectivo = DepositoBancario.Efectivo ?? 0;
                        mIdMoneda = DepositoBancario.IdMonedaEfectivo ?? 1;

                        if (mIdDepositoBancario > 0)
                        {
                            var EntidadOriginal = db.DepositosBancarios.Where(p => p.IdDepositoBancario == mIdDepositoBancario).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(DepositoBancario);

                            ////////////////////////////////////////////// ANULACION //////////////////////////////////////////////
                            if (mAnulado)
                            {
                                //Libera los valores depositados y los pone en cartera
                                foreach (var d in EntidadOriginal.DetalleDepositosBancarios.Where(c => c.IdDetalleDepositoBancario != 0).ToList())
                                {
                                    var Valores = db.Valores.Where(c => c.IdValor == d.IdValor).ToList();
                                    if (Valores != null)
                                    {
                                        foreach (Valore v1 in Valores)
                                        {
                                            v1.Estado = null;
                                            v1.IdCuentaBancariaDeposito = null;
                                            v1.IdBancoDeposito = null;
                                            v1.FechaDeposito = null;
                                            v1.NumeroDeposito = null;
                                            db.Entry(v1).State = System.Data.Entity.EntityState.Modified;
                                        }
                                    }
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            db.DepositosBancarios.Add(DepositoBancario);
                            db.SaveChanges();
                        }

                        if (mEfectivo > 0 && mIdTipoComprobanteEfectivo > 0)
                        {
                            if (!mAnulado)
                            {
                                CuentasBancaria CuentaBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == DepositoBancario.IdCuentaBancaria).SingleOrDefault();
                                if (CuentaBancaria != null)
                                {
                                    if (CuentaBancaria.IdMoneda != mIdMoneda)
                                    {
                                        mEfectivo = mEfectivo * mCotizacionMoneda;
                                        mIdMoneda = CuentaBancaria.IdMoneda ?? 1;
                                        mCotizacionMoneda = 1;
                                    }
                                }
                                v = new Valore();
                                v.IdTipoValor = mIdTipoComprobanteEfectivo;
                                v.IdCuentaBancariaDeposito = DepositoBancario.IdCuentaBancaria;
                                v.IdBancoDeposito = DepositoBancario.IdBanco;
                                v.FechaDeposito = DepositoBancario.FechaDeposito;
                                v.NumeroDeposito = DepositoBancario.NumeroDeposito;
                                v.Importe = mEfectivo;
                                v.NumeroComprobante = DepositoBancario.NumeroDeposito;
                                v.IdTipoComprobante = mIdTipoComprobante;
                                v.FechaComprobante = DepositoBancario.FechaDeposito;
                                v.IdCaja = DepositoBancario.IdCaja;
                                v.IdMoneda = mIdMoneda;
                                v.NumeroValor = 0;
                                v.NumeroInterno = 0;
                                v.CotizacionMoneda = mCotizacionMoneda;
                                v.Estado = "D";
                                v.IdValor = -1;
                                db.Valores.Add(v); 
                            }
                            else
                            {
                                var Valores = db.Valores.Where(c => c.IdTipoValor == mIdTipoComprobanteEfectivo && c.NumeroDeposito == DepositoBancario.NumeroDeposito && c.IdCuentaBancariaDeposito == DepositoBancario.IdCuentaBancaria && c.FechaDeposito == DepositoBancario.FechaDeposito).ToList();
                                if (Valores != null)
                                {
                                    foreach (Valore v1 in Valores)
                                    {
                                        db.Entry(v1).State = System.Data.Entity.EntityState.Deleted;
                                    }
                                }
                            }
                        }

                        ////////////////////////////////////////////// VALORES //////////////////////////////////////////////
                        if (mIdDepositoBancario <= 0 && !mAnulado)
                        {
                            foreach (var d in DepositoBancario.DetalleDepositosBancarios)
                            {
                                mIdValor = d.IdValor ?? -1;
                                v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault();
                                if (v != null)
                                {
                                    v.Estado = "D";
                                    v.IdCuentaBancariaDeposito = DepositoBancario.IdCuentaBancaria;
                                    v.IdBancoDeposito = mIdBanco;
                                    v.FechaDeposito = DepositoBancario.FechaDeposito;
                                    v.NumeroDeposito = DepositoBancario.NumeroDeposito;
                                    db.Entry(v).State = System.Data.Entity.EntityState.Modified; 
                                }
                            }
                        }
                        db.SaveChanges();

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mAnulado)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobante && c.IdComprobante == mIdDepositoBancario).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                            db.SaveChanges();
                        }

                        if (mIdDepositoBancario <= 0 && !mAnulado)
                        {
                            Data.Models.Subdiario s;

                            if (mEfectivo > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuentaValores1;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = DepositoBancario.NumeroDeposito;
                                s.FechaComprobante = DepositoBancario.FechaDeposito;
                                s.IdComprobante = DepositoBancario.IdDepositoBancario;
                                s.Detalle = "Efectivo";
                                s.Debe = mEfectivo;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMoneda;
                                db.Subdiarios.Add(s);

                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuentaCaja;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = DepositoBancario.NumeroDeposito;
                                s.FechaComprobante = DepositoBancario.FechaDeposito;
                                s.IdComprobante = DepositoBancario.IdDepositoBancario;
                                s.Detalle = "Efectivo";
                                s.Haber = mEfectivo;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMoneda;
                                db.Subdiarios.Add(s);
                            }

                            foreach (var d in DepositoBancario.DetalleDepositosBancarios)
                            {
                                mIdValor = d.IdValor ?? -1;
                                v = db.Valores.Where(c => c.IdValor == mIdValor).SingleOrDefault();
                                if (v != null)
                                {
                                    mDetalleValor = "Ch." + v.NumeroValor.ToString() + " [" + v.NumeroInterno.ToString() + "] Vto. :" + v.FechaValor.ToString();
                                    mCotizacionMoneda2 = v.CotizacionMoneda ?? 1;
                                    mImporteValor = v.Importe ?? 0;
                                    mTotalValores = mTotalValores + mImporteValor;

                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                    s.IdCuenta = mIdCuentaValores;
                                    s.IdTipoComprobante = mIdTipoComprobante;
                                    s.NumeroComprobante = DepositoBancario.NumeroDeposito;
                                    s.FechaComprobante = DepositoBancario.FechaDeposito;
                                    s.IdComprobante = DepositoBancario.IdDepositoBancario;
                                    s.Haber = mImporteValor;
                                    s.IdMoneda = mIdMoneda;
                                    s.CotizacionMoneda = mCotizacionMoneda2;
                                    db.Subdiarios.Add(s);
                                }
                            }

                            if (mTotalValores > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuentaValores1;
                                s.IdTipoComprobante = mIdTipoComprobante;
                                s.NumeroComprobante = DepositoBancario.NumeroDeposito;
                                s.FechaComprobante = DepositoBancario.FechaDeposito;
                                s.IdComprobante = DepositoBancario.IdDepositoBancario;
                                s.Debe = mTotalValores;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMoneda;
                                db.Subdiarios.Add(s);
                            }
                            
                            db.SaveChanges();
                        }

                        db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.DepositosBancariosAgrupados.ToString(), DepositoBancario.IdDepositoBancario, "DepositoBancario");

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdDepositoBancario = DepositoBancario.IdDepositoBancario, ex = "" });
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
                                db.DetalleDepositosBancarios.Where(x=>x.IdDepositoBancario==a.IdDepositoBancario).Select(x=>(x.Valore.Importe ?? 0)).DefaultIfEmpty().Sum().NullSafeToString(),
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

        public virtual ActionResult DetDepositoBancario(string sidx, string sord, int? page, int? rows, int? IdDepositoBancario)
        {
            int IdDepositoBancario1 = IdDepositoBancario ?? 0;
            var Det = db.DetalleDepositosBancarios.Where(p => p.IdDepositoBancario == IdDepositoBancario1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Clientes.Where(o => o.IdCliente == a.Valore.IdCliente).DefaultIfEmpty()
                        from c in db.Bancos.Where(o => o.IdBanco == a.Valore.IdBanco).DefaultIfEmpty()
                        from d in db.Monedas.Where(o => o.IdMoneda == a.Valore.IdMoneda).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleDepositoBancario,
                            a.IdValor,
                            a.Valore.NumeroInterno,
                            a.Valore.NumeroValor,
                            a.Valore.FechaValor,
                            Cliente = b.RazonSocial != null ? b.RazonSocial : "",
                            Banco = c.Nombre != null ? c.Nombre : "",
                            a.Valore.Importe,
                            Moneda = d.Abreviatura != null ? d.Abreviatura : ""
                        }).OrderBy(x => x.IdDetalleDepositoBancario)
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
                            id = a.IdDetalleDepositoBancario.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleDepositoBancario.ToString(), 
                            a.IdValor.NullSafeToString(),
                            a.NumeroInterno.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.FechaValor == null ? "" : a.FechaValor.GetValueOrDefault().ToString("dd/MM/yyyy"),
                            a.Cliente.NullSafeToString(),
                            a.Banco.NullSafeToString(),
                            a.Importe.NullSafeToString(),
                            a.Moneda.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

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