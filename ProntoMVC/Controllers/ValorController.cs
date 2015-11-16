using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.Entity.SqlServer;
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
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using Newtonsoft.Json;

namespace ProntoMVC.Controllers
{
    public partial class ValorController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.Valores)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult IndexValores()
        {
            if (!PuedeLeer(enumNodos.Valores)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult IndexMovimientosCaja()
        {
            if (!PuedeLeer(enumNodos.Valores)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult IndexMovimientosTarjeta()
        {
            if (!PuedeLeer(enumNodos.Valores)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult IndexChequesPendientes()
        {
            if (!PuedeLeer(enumNodos.Valores)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult IndexChequesNoUtilizados()
        {
            if (!PuedeLeer(enumNodos.Valores)) throw new Exception("No tenés permisos");
            return View();
        }
        
        public virtual ViewResult Edit(int id)
        {
            Valore o;

            try
            {
                if (!PuedeLeer(enumNodos.Valores))
                {
                    o = new Valore();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new Valore();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new Valore();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.Valores.SingleOrDefault(x => x.IdValor == id);
                CargarViewBag(o);
                Session.Add("GastosBancarios", o);
                return View(o);
            }
        }

        void CargarViewBag(Valore o)
        {
            Int32 mIdTipoCuentaGrupoIVA = 0;

            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mIdTipoCuentaGrupoIVA = parametros.IdTipoCuentaGrupoIVA ?? 0;

            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdObra = new SelectList(db.Obras.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdObra", "Descripcion", o.IdObra);
            ViewBag.IdCuentaBancaria = new SelectList((from i in db.CuentasBancarias
                                                       where i.Activa == "SI"
                                                       select new { IdCuentaBancaria = i.IdCuentaBancaria, Nombre = i.Banco.Nombre + " " + i.Cuenta }).Distinct(), "IdCuentaBancaria", "Nombre", o.IdCuentaBancaria);
            ViewBag.IdTipoComprobante = new SelectList((from i in db.TiposComprobantes
                                                        where i.Agrupacion1 == "GASTOSBANCOS"
                                                        select new { IdTipoComprobante = i.IdTipoComprobante, Descripcion = i.DescripcionAb + " " + i.Descripcion }).Distinct(), "IdTipoComprobante", "Descripcion", o.IdTipoComprobante);
            ViewBag.IdCuentaContable = new SelectList(db.Cuentas.Where(x => x.IdCuenta == o.IdCuentaContable), "IdCuenta", "Descripcion", o.IdCuentaContable);
            ViewBag.IdCuentaIVA = new SelectList((from i in db.Cuentas
                                                  where i.IdTipoCuentaGrupo == mIdTipoCuentaGrupoIVA && i.IdTipoCuenta == 2
                                                  select new { IdCuenta = i.IdCuenta, Descripcion = i.Descripcion }).Distinct(), "IdCuenta", "Descripcion", o.IdCuentaIVA);
            ViewBag.IdCuentaGasto = new SelectList(db.CuentasGastos.Where(x => (x.Activa ?? "SI") == "SI").OrderBy(x => x.Descripcion), "IdCuentaGasto", "Descripcion", o.IdCuentaGasto);
            ViewBag.IdTipoCuentaGrupo = new SelectList(db.TiposCuentaGrupos.OrderBy(x => x.Descripcion), "IdTipoCuentaGrupo", "Descripcion");
        }

        void inic(ref Valore o)
        {
            o.FechaComprobante = DateTime.Today;
            o.FechaGasto = DateTime.Today;
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
        }

        private bool Validar(ProntoMVC.Data.Models.Valore o, ref string sErrorMsg, ref string sWarningMsg)
        {
            Int32 mIdValor = 0;
            Int32 mIdMoneda = 1;

            decimal mTotalRubrosContables = 0;
            decimal mTotalProvincias = 0;
            decimal mDebe = 0;
            decimal mHaber = 0;
            decimal mImporte = 0;

            string mControlarRubrosContablesEnOP = "SI";

            DateTime mFechaComprobante = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            mIdValor = o.IdValor;
            mIdMoneda = o.IdMoneda ?? 1;
            mImporte = o.Importe ?? 0;

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;
            mControlarRubrosContablesEnOP=parametros.ControlarRubrosContablesEnOP ?? "SI";

            if (BuscarClaveINI("Numerar automaticamente gastos bancarios", -1) != "SI" && (o.NumeroComprobante ?? 0) <= 0) { sErrorMsg += "\n" + "Falta el número de comprobante"; }
            if (o.FechaComprobante < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha del comprobante no puede ser anterior a la del ultimo cierre contable"; }
            if ((o.CotizacionMoneda ?? 0) <= 0) { sErrorMsg += "\n" + "Falta la cotización de equivalencia a pesos"; }
            if (mIdMoneda <= 0) { sErrorMsg += "\n" + "Falta la moneda"; }
            if ((o.Iva ?? 0) != 0 && (o.IdCuentaIVA ?? 0) == 0) { sErrorMsg += "\n" + "Falta la cuenta contable del iva"; }
            if ((o.Iva ?? 0) != 0 && (o.PorcentajeIVA ?? 0) == 0) { sErrorMsg += "\n" + "Falta el porcentaje del iva"; }

            if (BuscarClaveINI("Deshabilitar control de numeros de gastos bancarios", -1) != "SI")
            {
                var Valores = db.Valores.Where(c => c.IdTipoComprobante == (o.IdTipoComprobante ?? 0) && c.NumeroComprobante == (o.NumeroComprobante ?? 0) && c.IdValor != mIdValor).SingleOrDefault();
                if (Valores != null) { sErrorMsg += "\n" + "Numero de comprobante existente"; }
            }

            if (o.DetalleValoresCuentas.Count <= 0) sErrorMsg += "\n" + "El comprobante no tiene registro contable";
            foreach (ProntoMVC.Data.Models.DetalleValoresCuenta x in o.DetalleValoresCuentas)
            {
                if ((x.IdCuenta ?? 0) <= 0) { sErrorMsg += "\n" + "Hay items de registro contable sin cuenta"; }
                mDebe += x.Debe ?? 0;
                mHaber += x.Haber ?? 0;
            }
            if (mDebe != mHaber) { sErrorMsg += "\n" + "El asiento contable no balancea"; }

            foreach (ProntoMVC.Data.Models.DetalleValoresRubrosContable x in o.DetalleValoresRubrosContables)
            {
                mTotalRubrosContables += x.Importe ?? 0;
            }
            if (mControlarRubrosContablesEnOP == "SI" && mTotalRubrosContables != mImporte) { sErrorMsg += "\n" + "El total de rubros contables asignados debe ser igual al total del comprobante"; }

            foreach (ProntoMVC.Data.Models.DetalleValoresProvincia x in o.DetalleValoresProvincias)
            {
                mTotalProvincias += x.Porcentaje ?? 0;
            }
            if (mTotalProvincias != 100 && mTotalProvincias != 0) { sErrorMsg += "\n" + "El total de % por provincia asignados debe ser 0 o 100"; }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(Valore valor)
        {
            if (!PuedeEditar(enumNodos.OPago)) throw new Exception("No tenés permisos");

            try
            {
                decimal mCotizacionMoneda = 0;
                decimal mDebe = 0;
                decimal mHaber = 0;
                decimal mDiferencia = 0;

                Int32 mIdValor = 0;
                Int32 mNumero = 0;
                Int32 mIdMonedaPesos = 1;
                Int32 mIdAux1 = 0;
                Int32 i = 0;
                Int32 mIdCuentaCajaTitulo = 0;
                Int32 mIdBanco = 0;
                
                string errs = "";
                string warnings = "";

                bool mAsientoManual = false;
                bool mExiste = false;

                DateTime mFechaInicioControl;

                var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

                Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
                mIdMonedaPesos = parametros.IdMoneda ?? 0;
                mIdCuentaCajaTitulo = parametros.IdCuentaCajaTitulo ?? 0;

                string usuario = ViewBag.NombreUsuario;
                int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario || x.UsuarioNT == usuario).Select(x => x.IdEmpleado).FirstOrDefault();
                
                if (!Validar(valor, ref errs, ref warnings))
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
                        mIdValor = valor.IdValor;
                        mNumero = valor.NumeroComprobante ?? 0;
                        mCotizacionMoneda = valor.CotizacionMoneda ?? 1;
                        if ((valor.AsientoManual ?? "") == "SI") { mAsientoManual = true; }

                        ProntoMVC.Data.Models.CuentasBancaria CuentaBancaria = db.CuentasBancarias.Where(p => p.IdCuentaBancaria == (valor.IdCuentaBancaria ?? 0)).FirstOrDefault();
                        if (CuentaBancaria != null) { mIdBanco = CuentaBancaria.IdBanco ?? 0; }

                        valor.Estado = "G";
                        valor.IdBanco = mIdBanco;
                        valor.Conciliado = valor.Conciliado ?? "NO";
                        valor.MovimientoConfirmadoBanco = valor.MovimientoConfirmadoBanco ?? "NO";

                        if (mIdValor > 0)
                        {
                            valor.IdUsuarioModifico = IdUsuario;
                            valor.FechaModifico = DateTime.Now;

                            var valorOriginal = db.Valores.Where(p => p.IdValor == mIdValor).SingleOrDefault();

                            ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                            foreach (var d in valor.DetalleValoresCuentas)
                            {
                                var DetalleValorCuentasOriginal = valorOriginal.DetalleValoresCuentas.Where(c => c.IdDetalleValorCuentas == d.IdDetalleValorCuentas && d.IdDetalleValorCuentas > 0).SingleOrDefault();
                                if (DetalleValorCuentasOriginal != null)
                                {
                                    var DetalleValorCuentasEntry = db.Entry(DetalleValorCuentasOriginal);
                                    DetalleValorCuentasEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    valorOriginal.DetalleValoresCuentas.Add(d);
                                }
                            }
                            foreach (var DetalleValorCuentasOriginal in valorOriginal.DetalleValoresCuentas.Where(c => c.IdDetalleValorCuentas != 0).ToList())
                            {
                                if (!valor.DetalleValoresCuentas.Any(c => c.IdDetalleValorCuentas == DetalleValorCuentasOriginal.IdDetalleValorCuentas))
                                {
                                    valorOriginal.DetalleValoresCuentas.Remove(DetalleValorCuentasOriginal);
                                    db.Entry(DetalleValorCuentasOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// RUBROS CONTABLES //////////////////////////////////////////////
                            foreach (var d in valor.DetalleValoresRubrosContables)
                            {
                                var DetalleValorRubrosContablesOriginal = valorOriginal.DetalleValoresRubrosContables.Where(c => c.IdDetalleValorRubrosContables == d.IdDetalleValorRubrosContables && d.IdDetalleValorRubrosContables > 0).SingleOrDefault();
                                if (DetalleValorRubrosContablesOriginal != null)
                                {
                                    var DetalleValorRubrosContablesEntry = db.Entry(DetalleValorRubrosContablesOriginal);
                                    DetalleValorRubrosContablesEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    valorOriginal.DetalleValoresRubrosContables.Add(d);
                                }
                            }
                            foreach (var DetalleValorRubrosContablesOriginal in valorOriginal.DetalleValoresRubrosContables.Where(c => c.IdDetalleValorRubrosContables != 0).ToList())
                            {
                                if (!valor.DetalleValoresRubrosContables.Any(c => c.IdDetalleValorRubrosContables == DetalleValorRubrosContablesOriginal.IdDetalleValorRubrosContables))
                                {
                                    valorOriginal.DetalleValoresRubrosContables.Remove(DetalleValorRubrosContablesOriginal);
                                    db.Entry(DetalleValorRubrosContablesOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// PROVINCIAS //////////////////////////////////////////////
                            foreach (var d in valor.DetalleValoresProvincias)
                            {
                                var DetalleValorProvinciasOriginal = valorOriginal.DetalleValoresProvincias.Where(c => c.IdDetalleValorProvincias == d.IdDetalleValorProvincias && d.IdDetalleValorProvincias > 0).SingleOrDefault();
                                if (DetalleValorProvinciasOriginal != null)
                                {
                                    var DetalleValorProvinciasEntry = db.Entry(DetalleValorProvinciasOriginal);
                                    DetalleValorProvinciasEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    valorOriginal.DetalleValoresProvincias.Add(d);
                                }
                            }
                            foreach (var DetalleValorProvinciasOriginal in valorOriginal.DetalleValoresProvincias.Where(c => c.IdDetalleValorProvincias != 0).ToList())
                            {
                                if (!valor.DetalleValoresProvincias.Any(c => c.IdDetalleValorProvincias == DetalleValorProvinciasOriginal.IdDetalleValorProvincias))
                                {
                                    valorOriginal.DetalleValoresProvincias.Remove(DetalleValorProvinciasOriginal);
                                    db.Entry(DetalleValorProvinciasOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(valorOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            valor.IdUsuarioIngreso = IdUsuario;
                            valor.FechaIngreso = DateTime.Now;

                            if (BuscarClaveINI("Numerar automaticamente gastos bancarios", -1) == "SI")
                            {
                                ProntoMVC.Data.Models.TiposComprobante TipoComprobante = db.TiposComprobantes.Where(p => p.IdTipoComprobante == (valor.IdTipoComprobante ?? 0)).FirstOrDefault();
                                mNumero = TipoComprobante.NumeradorAuxiliar ?? 1;
                                valor.NumeroComprobante = mNumero;
                                TipoComprobante.NumeradorAuxiliar = mNumero + 1;
                                db.Entry(TipoComprobante).State = System.Data.Entity.EntityState.Modified;
                            }
                            db.Valores.Add(valor);
                            db.SaveChanges();
                        }

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mIdValor > 0)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == valor.IdTipoComprobante && c.IdComprobante == mIdValor).ToList();
                            if (Subdiarios != null) { foreach (Subdiario s in Subdiarios) { db.Entry(s).State = System.Data.Entity.EntityState.Deleted; } }
                        }

                        if (true)
                        {
                            foreach (var d in valor.DetalleValoresCuentas)
                            {
                                mDebe += (d.Debe ?? 0) * mCotizacionMoneda;
                                mHaber += (d.Haber ?? 0) * mCotizacionMoneda;
                            }
                            mDiferencia = decimal.Round(mDebe - mHaber, 2);
                            foreach (var d in valor.DetalleValoresCuentas)
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
                                s.IdTipoComprobante = valor.IdTipoComprobante;
                                s.NumeroComprobante = valor.NumeroComprobante;
                                s.FechaComprobante = valor.FechaComprobante;
                                s.IdComprobante = valor.IdValor;
                                s.Debe = d.Debe == 0 ? null : d.Debe;
                                s.Haber = d.Haber == 0 ? null : d.Haber;
                                s.IdMoneda = mIdMonedaPesos;
                                s.CotizacionMoneda = 1;
                                db.Subdiarios.Add(s);
                            }
                            db.SaveChanges();
                        }

                        db.Tree_TX_Actualizar(Tree_TX_ActualizarParam.GastosBancariosAgrupados.ToString(), valor.IdValor, "valor");

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdValor = valor.IdValor, ex = "" });
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

        public virtual ActionResult MarcarVisto(int IdBancoChequera, decimal NumeroCheque, int IdUsuarioMarco, string MotivoMarcado)
        {
            ProntoMVC.Data.Models.ValoresFaltantesVisto ValoresFaltantesVisto = db.ValoresFaltantesVistos.Where(p => p.IdBancoChequera == IdBancoChequera && p.NumeroCheque == NumeroCheque).FirstOrDefault();
            if (ValoresFaltantesVisto == null) {
                ValoresFaltantesVisto = new ValoresFaltantesVisto();
                ValoresFaltantesVisto.IdBancoChequera = IdBancoChequera;
                ValoresFaltantesVisto.NumeroCheque = NumeroCheque;
                ValoresFaltantesVisto.IdUsuarioMarco = IdUsuarioMarco;
                ValoresFaltantesVisto.MotivoMarcado = MotivoMarcado;
                ValoresFaltantesVisto.FechaMarcado = DateTime.Today;

                db.ValoresFaltantesVistos.Add(ValoresFaltantesVisto);
            }
            else
            {
                db.ValoresFaltantesVistos.Remove(ValoresFaltantesVisto);
            }
            db.SaveChanges();
            return Json(new { Success = 1, IdBancoChequera = IdBancoChequera, ex = "" });
        }

        public virtual JsonResult CalcularAsiento(Valore valor)
        {
            List<DetalleValoresCuenta> asiento = new List<DetalleValoresCuenta>();
            DetalleValoresCuenta rc;

            Int32 mIdBanco = 0;
            Int32 mIdCuenta = 0;
            Int32 mCoeficiente = 1;

            decimal mImporte = 0;
            decimal mIva = 0;
            decimal mAplicacion = 0;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            //mIdCuentaCaja = parametros.IdCuentaCaja ?? 0;
            //mActivarCircuitoChequesDiferidos = parametros.ActivarCircuitoChequesDiferidos ?? "NO";


            ProntoMVC.Data.Models.TiposComprobante TipoComprobante = db.TiposComprobantes.Where(p => p.IdTipoComprobante == (valor.IdTipoComprobante ?? 0)).FirstOrDefault();
            if (TipoComprobante != null) { mCoeficiente = TipoComprobante.Coeficiente ?? 1; }

            ProntoMVC.Data.Models.CuentasBancaria CuentaBancaria = db.CuentasBancarias.Where(p => p.IdCuentaBancaria == (valor.IdCuentaBancaria ?? 0)).FirstOrDefault();
            if (CuentaBancaria != null) { mIdBanco = CuentaBancaria.IdBanco ?? 0; }

            ProntoMVC.Data.Models.Banco Banco = db.Bancos.Where(p => p.IdBanco == mIdBanco).FirstOrDefault();
            if (Banco != null) { mIdCuenta = Banco.IdCuenta ?? 0; }

            mImporte = valor.Importe ?? 0;
            mIva = valor.Iva ?? 0;
            mAplicacion = mImporte - mIva;

            if (mImporte != 0)
            {
                rc = new DetalleValoresCuenta();
                rc.IdCuenta = mIdCuenta;
                if (mCoeficiente == 1) { rc.Haber = mImporte; } else { rc.Debe = mImporte; };
                asiento.Add(rc);
            };

            if (mIva != 0)
            {
                rc = new DetalleValoresCuenta();
                rc.IdCuenta = valor.IdCuentaIVA;
                if (mCoeficiente == 1) { rc.Debe = mIva; } else { rc.Haber = mIva; };
                asiento.Add(rc);
            };

            if (mAplicacion != 0)
            {
                rc = new DetalleValoresCuenta();
                rc.IdCuenta = valor.IdCuentaContable;
                if (mCoeficiente == 1) { rc.Debe = mAplicacion; } else { rc.Haber = mAplicacion; };
                asiento.Add(rc);
            };

            var data = (from a in asiento.ToList()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValorCuentas,
                            a.IdCuenta,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleValorCuentas).ToList();

            return Json(JsonConvert.SerializeObject(data), JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ValoresEnCartera(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var Entidad = db.Valores.Where(p => p.Estado == null && p.IdTipoComprobante != 17 && p.TiposComprobante1.Agrupacion1 == "CHEQUES").AsQueryable();

            var data = (from a in Entidad
                        from b in db.Bancos.Where(o => o.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Clientes.Where(o => o.IdCliente == a.IdCliente).DefaultIfEmpty()
                        select new
                        {
                            a.IdValor,
                            Tipo = a.TiposComprobante1.DescripcionAb,
                            a.NumeroInterno,
                            a.NumeroValor,
                            a.FechaValor,
                            Entidad = b != null ? b.Nombre : "",
                            a.Importe,
                            TipoComprobante = a.TiposComprobante.DescripcionAb,
                            a.NumeroComprobante,
                            a.FechaComprobante,
                            Cliente = c.RazonSocial
                        }).OrderBy(x => x.FechaValor)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var jsonData = new jqGridJson()
            {
                total = totalPages,
                page = currentPage,
                records = totalRecords,
                rows = (from a in data
                        select new jqGridRowJson
                        {
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                                string.Empty,
                                a.IdValor.ToString(),
                                a.Tipo,
                                a.NumeroInterno.ToString(),
                                a.NumeroValor.ToString(),
                                a.FechaValor == null ? "" : a.FechaValor.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Entidad,
                                a.Importe.ToString(),
                                a.TipoComprobante,
                                a.NumeroComprobante.ToString(),
                                a.FechaComprobante == null ? "" : a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Cliente
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual JsonResult TraerUno(int IdValor)
        {
            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Valores_TX_PorIdConDatos", IdValor);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var data = (from a in Entidad
                        select new
                        {
                            IdValor = a["IdValor"],
                            Tipo = a["Tipo"],
                            NumeroInterno = a["NumeroInterno"],
                            NumeroValor = a["NumeroValor"],
                            FechaValor = Convert.ToDateTime(a["FechaValor"].NullSafeToString()),
                            Entidad = a["Banco"],
                            Importe = a["Importe"],
                            TipoComprobante = a["TipoComprobante"],
                            NumeroComprobante = a["NumeroComprobante"],
                            FechaComprobante = a["FechaComprobante"],
                            Cliente = a["Cliente"],
                            Moneda = a["Moneda"],
                            FechaDeposito = Convert.ToDateTime(a["FechaDeposito"].NullSafeToString()),
                            NumeroDeposito = a["NumeroDeposito"],
                            Iva = a["Iva"],
                            Proveedor = a["Proveedor"],
                            Controlado = a["Controlado"],
                            ControladoNoConciliado = a["ControladoNoConciliado"],
                        }).ToList();
            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string FechaInicial, string FechaFinal)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.Valores where a.Estado=="G"
                        from b in db.Bancos.Where(y => y.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.TarjetasCreditoes.Where(y => y.IdTarjetaCredito == a.IdTarjetaCredito).DefaultIfEmpty()
                        from d in db.CuentasBancarias.Where(y => y.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from e in db.Conciliaciones.Where(y => y.IdConciliacion == a.IdConciliacion).DefaultIfEmpty()
                        from f in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioIngreso).DefaultIfEmpty()
                        from g in db.Empleados.Where(y => y.IdEmpleado == a.IdUsuarioModifico).DefaultIfEmpty()
                        from h in db.Obras.Where(y => y.IdObra == a.IdObra).DefaultIfEmpty()
                        from i in db.Cuentas.Where(y => y.IdCuenta == a.IdCuentaContable).DefaultIfEmpty()
                        from j in db.Cuentas.Where(y => y.IdCuenta == a.IdCuentaIVA).DefaultIfEmpty()
                        from k in db.CuentasGastos.Where(y => y.IdCuentaGasto == a.IdCuentaGasto).DefaultIfEmpty()
                        select new
                        {
                            a.IdValor,
                            a.IdBanco,
                            a.IdCuentaBancaria,
                            a.IdTipoComprobante,
                            a.IdObra,
                            a.IdCuentaGasto,
                            a.IdCuentaContable,
                            a.IdCuentaIVA,
                            a.IdMoneda,
                            Banco = b != null ? b.Nombre : (c != null ? c.Nombre : ""),
                            Tipo = a.TiposComprobante.DescripcionAb,
                            Obra = h != null ? h.NumeroObra : "",
                            CuentaGasto = k != null ? k.Descripcion : "",
                            Cuenta = i != null ? i.Descripcion : "",
                            a.NumeroComprobante,
                            a.FechaGasto,
                            a.FechaComprobante,
                            a.Iva,
                            CuentaIVA = j != null ? j.Descripcion : "",
                            a.PorcentajeIVA,
                            a.CertificadoRetencion,
                            Importe = a.Importe * (a.TiposComprobante.Coeficiente ?? 1),
                            Moneda = a.Moneda.Abreviatura,
                            a.CotizacionMoneda,
                            ImportePesos = a.Importe * (a.TiposComprobante.Coeficiente ?? 1) * (a.CotizacionMoneda ?? 1),
                            a.Detalle,
                            a.Conciliado,
                            a.MovimientoConfirmadoBanco,
                            a.FechaConfirmacionBanco,
                            CuentaBancaria = d != null ? d.Cuenta : "",
                            ConciliacionNumero = e != null ? e.Numero : "",
                            ConciliacionFecha = e.FechaIngreso,
                            Confecciono = f != null ? f.Nombre : "",
                            a.FechaIngreso,
                            Modifico = g != null ? g.Nombre : "",
                            a.FechaModifico
                        }).AsQueryable();
            
            
            if (FechaInicial != string.Empty)
            {
                DateTime FechaDesde = DateTime.ParseExact(FechaInicial, "dd/MM/yyyy", null);
                DateTime FechaHasta = DateTime.ParseExact(FechaFinal, "dd/MM/yyyy", null);
                data = (from a in data where a.FechaComprobante >= FechaDesde && a.FechaComprobante <= FechaHasta select a).AsQueryable();
            }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a).OrderByDescending(x => x.FechaComprobante)
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
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdValor} ) + ">Editar</>",
                                a.IdValor.ToString(),
                                a.IdBanco.NullSafeToString(),
                                a.IdCuentaBancaria.NullSafeToString(),
                                a.IdTipoComprobante.ToString(),
                                a.IdObra.ToString(),
                                a.IdCuentaGasto.ToString(),
                                a.IdCuentaContable.ToString(),
                                a.IdCuentaIVA.ToString(),
                                a.IdMoneda.ToString(),
                                a.Banco.NullSafeToString(),
                                a.Tipo.NullSafeToString(),
                                a.Obra.NullSafeToString(),
                                a.CuentaGasto.NullSafeToString(),
                                a.Cuenta.NullSafeToString(),
                                a.NumeroComprobante.NullSafeToString(),
                                a.FechaGasto == null ? "" : a.FechaGasto.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaComprobante == null ? "" : a.FechaComprobante.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Iva.NullSafeToString(),
                                a.CuentaIVA.NullSafeToString(),
                                a.PorcentajeIVA.NullSafeToString(),
                                a.CertificadoRetencion.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.CotizacionMoneda.NullSafeToString(),
                                a.ImportePesos.NullSafeToString(),
                                a.Detalle.NullSafeToString(),
                                a.Conciliado.NullSafeToString(),
                                a.MovimientoConfirmadoBanco.NullSafeToString(),
                                a.FechaConfirmacionBanco == null ? "" : a.FechaConfirmacionBanco.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.CuentaBancaria.NullSafeToString(),
                                a.ConciliacionNumero.NullSafeToString(),
                                a.ConciliacionFecha == null ? "" : a.ConciliacionFecha.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Confecciono.NullSafeToString(),
                                a.FechaIngreso == null ? "" : a.FechaIngreso.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.Modifico.NullSafeToString(),
                                a.FechaModifico == null ? "" : a.FechaModifico.GetValueOrDefault().ToString("dd/MM/yyyy")
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ConciliacionBanco(string sidx, string sord, int? page, int? rows, int IdCuentaBancaria, string FechaInicial, string FechaFinal, string ConfirmacionBanco)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Bancos_TX_MovimientosPorCuenta", IdCuentaBancaria, FechaInicial, FechaFinal, 0, 2, ConfirmacionBanco);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdValor = a[0],
                            Tipo = a[1],
                            NumeroValor = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            Ingresos = (a[5].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[5].NullSafeToString()),
                            Egresos = (a[6].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[6].NullSafeToString()),
                            Saldo = (a[7].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[7].NullSafeToString()),
                            CotizacionMoneda = (a[8].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[8].NullSafeToString()),
                            IngresosPesos = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            EgresosPesos = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            SaldoPesos = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            FechaComprobante = a[12],
                            Conciliado = a[13],
                            MovimientoConfirmadoBanco = a[14],
                            FechaConfirmacionBanco = a[15],
                            Cuenta = a[16],
                            NumeroConciliacion = a[17],
                            FechaIngresoConciliacion = a[18],
                            NumeroInterno = (a[19].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[19].NullSafeToString()),
                            FechaValor = a[20],
                            FechaDeposito = a[21],
                            NumeroDeposito = (a[22].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[22].NullSafeToString()),
                            Iva = (a[23].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[23].NullSafeToString()),
                            Moneda = a[24],
                            Banco = a[25],
                            TipoComprobante = a[26],
                            NumeroComprobante = (a[27].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[27].NullSafeToString()),
                            FechaOrigen = a[28],
                            Cliente = a[29],
                            Proveedor = a[30],
                            CuentaContable = a[31],
                            Detalle = a[32],
                            NumeroAsientoChequesDiferidos = (a[33].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[33].NullSafeToString()),
                            Observaciones = a[34],
                            IdAux = a[35]
                        }).OrderBy(s => s.FechaComprobante)
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
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdValor.ToString(), 
                            a.Tipo.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.Ingresos.NullSafeToString(),
                            a.Egresos.NullSafeToString(),
                            a.Saldo.NullSafeToString(),
                            a.CotizacionMoneda.ToString(),
                            a.IngresosPesos.ToString(),
                            a.EgresosPesos.ToString(),
                            a.SaldoPesos.ToString(),
                            a.FechaComprobante.ToString(),
                            a.Conciliado.ToString(),
                            a.MovimientoConfirmadoBanco.ToString(),
                            a.FechaConfirmacionBanco.ToString(),
                            a.Cuenta.ToString(),
                            a.NumeroConciliacion.ToString(),
                            a.FechaIngresoConciliacion.ToString(),
                            a.NumeroInterno.ToString(),
                            a.FechaValor.ToString(),
                            a.FechaDeposito.ToString(),
                            a.NumeroDeposito.ToString(),
                            a.Iva.ToString(),
                            a.Moneda.ToString(),
                            a.Banco.ToString(),
                            a.TipoComprobante.ToString(),
                            a.NumeroComprobante.ToString(),
                            a.FechaOrigen.ToString(),
                            a.Cliente.ToString(),
                            a.Proveedor.ToString(),
                            a.CuentaContable.ToString(),
                            a.Detalle.ToString(),
                            a.NumeroAsientoChequesDiferidos.ToString(),
                            a.Observaciones.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ConciliacionCaja(string sidx, string sord, int? page, int? rows, int IdCaja, string FechaInicial, string FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Valores_TX_MovimientosPorIdCaja", IdCaja, FechaInicial, FechaFinal, 0, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdValor = a[0],
                            Tipo = a[1],
                            IdCaja = (a[3].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[3].NullSafeToString()),
                            Ingresos = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            Egresos = (a[5].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[5].NullSafeToString()),
                            Saldo = (a[6].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[6].NullSafeToString()),
                            CotizacionMoneda = (a[7].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[7].NullSafeToString()),
                            IngresosPesos = (a[8].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[8].NullSafeToString()),
                            EgresosPesos = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            SaldoPesos = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            FechaComprobante = a[11],
                            Conciliado = a[12],
                            MovimientoConfirmadoBanco = a[13],
                            FechaConfirmacionBanco = a[14],
                            Cuenta = a[15],
                            NumeroConciliacion = a[16],
                            FechaIngresoConciliacion = a[17],
                            FechaDeposito = a[18],
                            NumeroDeposito = (a[19].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[19].NullSafeToString()),
                            Iva = (a[20].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[20].NullSafeToString()),
                            Moneda = a[21],
                            TipoComprobante = a[22],
                            NumeroComprobante = (a[23].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[23].NullSafeToString()),
                            FechaOrigen = a[24],
                            Cliente = a[25],
                            Proveedor = a[26],
                            CuentaContable = a[27],
                            Observaciones = a[28],
                            IdAux = a[29]
                        }).OrderBy(s => s.FechaComprobante)
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
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdValor.ToString(), 
                            a.Tipo.NullSafeToString(),
                            a.IdCaja.NullSafeToString(),
                            a.Ingresos.NullSafeToString(),
                            a.Egresos.NullSafeToString(),
                            a.Saldo.NullSafeToString(),
                            a.CotizacionMoneda.ToString(),
                            a.IngresosPesos.ToString(),
                            a.EgresosPesos.ToString(),
                            a.SaldoPesos.ToString(),
                            a.FechaComprobante.ToString(),
                            a.Conciliado.ToString(),
                            a.MovimientoConfirmadoBanco.ToString(),
                            a.FechaConfirmacionBanco.ToString(),
                            a.Cuenta.ToString(),
                            a.NumeroConciliacion.ToString(),
                            a.FechaIngresoConciliacion.ToString(),
                            a.FechaDeposito.ToString(),
                            a.NumeroDeposito.ToString(),
                            a.Iva.ToString(),
                            a.Moneda.ToString(),
                            a.TipoComprobante.ToString(),
                            a.NumeroComprobante.ToString(),
                            a.FechaOrigen.ToString(),
                            a.Cliente.ToString(),
                            a.Proveedor.ToString(),
                            a.CuentaContable.ToString(),
                            a.Observaciones.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ConciliacionTarjeta(string sidx, string sord, int? page, int? rows, int IdTarjetaCredito, string FechaInicial, string FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Valores_TX_MovimientosPorIdTarjetaCredito", IdTarjetaCredito, FechaInicial, FechaFinal, 0, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdValor = a[0],
                            Tipo = a[1],
                            IdTarjetaCredito = (a[3].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[3].NullSafeToString()),
                            Ingresos = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            Egresos = (a[5].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[5].NullSafeToString()),
                            Saldo = (a[6].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[6].NullSafeToString()),
                            CotizacionMoneda = (a[7].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[7].NullSafeToString()),
                            IngresosPesos = (a[8].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[8].NullSafeToString()),
                            EgresosPesos = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            SaldoPesos = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            FechaComprobante = a[11],
                            Conciliado = a[12],
                            MovimientoConfirmadoBanco = a[13],
                            FechaConfirmacionBanco = a[14],
                            Cuenta = a[15],
                            NumeroConciliacion = a[16],
                            FechaIngresoConciliacion = a[17],
                            FechaDeposito = a[18],
                            NumeroDeposito = (a[19].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[19].NullSafeToString()),
                            Iva = (a[20].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[20].NullSafeToString()),
                            Moneda = a[21],
                            TipoComprobante = a[22],
                            NumeroComprobante = (a[23].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[23].NullSafeToString()),
                            FechaOrigen = a[24],
                            Cliente = a[25],
                            Proveedor = a[26],
                            CuentaContable = a[27],
                            Observaciones = a[28],
                            IdAux = a[29]
                        }).OrderBy(s => s.FechaComprobante)
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
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdValor.ToString(), 
                            a.Tipo.NullSafeToString(),
                            a.IdTarjetaCredito.NullSafeToString(),
                            a.Ingresos.NullSafeToString(),
                            a.Egresos.NullSafeToString(),
                            a.Saldo.NullSafeToString(),
                            a.CotizacionMoneda.ToString(),
                            a.IngresosPesos.ToString(),
                            a.EgresosPesos.ToString(),
                            a.SaldoPesos.ToString(),
                            a.FechaComprobante.ToString(),
                            a.Conciliado.ToString(),
                            a.MovimientoConfirmadoBanco.ToString(),
                            a.FechaConfirmacionBanco.ToString(),
                            a.Cuenta.ToString(),
                            a.NumeroConciliacion.ToString(),
                            a.FechaIngresoConciliacion.ToString(),
                            a.FechaDeposito.ToString(),
                            a.NumeroDeposito.ToString(),
                            a.Iva.ToString(),
                            a.Moneda.ToString(),
                            a.TipoComprobante.ToString(),
                            a.NumeroComprobante.ToString(),
                            a.FechaOrigen.ToString(),
                            a.Cliente.ToString(),
                            a.Proveedor.ToString(),
                            a.CuentaContable.ToString(),
                            a.Observaciones.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ChequesPendientes(string sidx, string sord, int? page, int? rows)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Valores_TX_ChequesPendientes");
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdValor = a[0],
                            Tipo = a[1],
                            Banco = a[3],
                            NumeroChequera = (a[4].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[4].NullSafeToString()),
                            NumeroInterno = (a[5].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[5].NullSafeToString()),
                            NumeroValor = (a[6].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[6].NullSafeToString()),
                            FechaValor = a[7],
                            Importe = (a[8].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[8].NullSafeToString()),
                            Moneda = a[9],
                            CotizacionMoneda = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            FechaComprobante = a[11],
                            Conciliado = a[12],
                            MovimientoConfirmadoBanco = a[13],
                            FechaConfirmacionBanco = a[14],
                            Cuenta = a[15],
                            NumeroConciliacion = a[16],
                            FechaIngresoConciliacion = a[17],
                            TipoComprobante = a[18],
                            NumeroComprobante = (a[19].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[19].NullSafeToString()),
                            Proveedor = a[20],
                            Detalle = a[21]
                        }).OrderBy(s => s.FechaComprobante)
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
                            id = a.IdValor.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdValor.ToString(), 
                            a.Tipo.NullSafeToString(),
                            a.Banco.NullSafeToString(),
                            a.NumeroChequera.NullSafeToString(),
                            a.NumeroInterno.NullSafeToString(),
                            a.NumeroValor.NullSafeToString(),
                            a.FechaValor.ToString(),
                            a.Importe.ToString(),
                            a.Moneda.ToString(),
                            a.CotizacionMoneda.ToString(),
                            a.FechaComprobante.ToString(),
                            a.Conciliado.ToString(),
                            a.MovimientoConfirmadoBanco.ToString(),
                            a.FechaConfirmacionBanco.ToString(),
                            a.Cuenta.ToString(),
                            a.NumeroConciliacion.ToString(),
                            a.FechaIngresoConciliacion.ToString(),
                            a.TipoComprobante.ToString(),
                            a.NumeroComprobante.ToString(),
                            a.Proveedor.ToString(),
                            a.Detalle.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult ChequesNoUtilizados(string sidx, string sord, int? page, int? rows, string visto)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Valores_TX_ChequesNoUsados", visto);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdBancoChequera = a[0],
                            Banco = a[1],
                            NumeroChequera = (a[3].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[3].NullSafeToString()),
                            NumeroCheque = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            Detalle = a[5],
                            EmpleadoMarco = a[6],
                            FechaMarcado = a[7],
                            MotivoMarcado = a[8],
                            IdAux = a[9]
                        }).OrderBy(s => s.Banco).ThenBy(s => s.NumeroChequera).ThenBy(s => s.NumeroCheque)
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
                            id = a.IdAux.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdAux.ToString(), 
                            a.IdBancoChequera.ToString(), 
                            a.Banco.NullSafeToString(),
                            a.NumeroChequera.NullSafeToString(),
                            a.NumeroCheque.NullSafeToString(),
                            a.Detalle.NullSafeToString(),
                            a.EmpleadoMarco.NullSafeToString(),
                            a.FechaMarcado.ToString(),
                            a.MotivoMarcado.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetValoresRubrosContables(string sidx, string sord, int? page, int? rows, int? IdValor)
        {
            int IdValor1 = IdValor ?? 0;
            var Det = db.DetalleValoresRubrosContables.Where(p => p.IdValor == IdValor1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValorRubrosContables,
                            a.IdRubroContable,
                            RubroContable = b.Descripcion != null ? b.Descripcion : "",
                            a.Importe
                        }).OrderBy(x => x.IdDetalleValorRubrosContables)
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
                            id = a.IdDetalleValorRubrosContables.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleValorRubrosContables.ToString(), 
                            a.IdRubroContable.NullSafeToString(),
                            a.RubroContable.NullSafeToString(),
                            a.Importe.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetValoresProvincias(string sidx, string sord, int? page, int? rows, int? IdValor)
        {
            int IdValor1 = IdValor ?? 0;
            var Det = db.DetalleValoresProvincias.Where(p => p.IdValor == IdValor1).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.Provincias.Where(o => o.IdProvincia == a.IdProvincia).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValorProvincias,
                            a.IdProvincia,
                            Provincia = b.Nombre != null ? b.Nombre : "",
                            a.Porcentaje
                        }).OrderBy(x => x.IdDetalleValorProvincias)
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
                            id = a.IdDetalleValorProvincias.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleValorProvincias.ToString(), 
                            a.IdProvincia.NullSafeToString(),
                            a.Provincia.NullSafeToString(),
                            a.Porcentaje.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetValoresCuentas(string sidx, string sord, int? page, int? rows, int? IdValor)
        {
            int IdValor1 = IdValor ?? 0;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString(), oStaticMembershipService));
            //var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "DetOrdenesPagoCuentas_TXvalor", IdOrdenesPago1);
            //IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            var Det = db.DetalleValoresCuentas.Where(p => p.IdValor == IdValor1).AsQueryable();

            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Det.AsEnumerable()
                        from b in db.Cuentas.Where(o => o.IdCuenta == a.IdCuenta).DefaultIfEmpty()
                        from c in db.DetalleCuentas.Where(o => o.IdCuenta == a.IdCuenta && o.FechaCambio > a.Valore.FechaComprobante).OrderByDescending(o => o.FechaCambio).DefaultIfEmpty()
                        from d in db.Cajas.Where(t => t.IdCaja == a.IdCaja).DefaultIfEmpty()
                        //from e in db.TarjetasCreditoes.Where(t => t.IdTarjetaCredito == a.IdTarjetaCredito).DefaultIfEmpty()
                        from f in db.Obras.Where(t => t.IdObra == a.IdObra).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(t => t.IdCuentaBancaria == a.IdCuentaBancaria).DefaultIfEmpty()
                        from h in db.CuentasGastos.Where(t => t.IdCuentaGasto == a.IdCuentaGasto).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetalleValorCuentas,
                            a.IdCuenta,
                            a.IdObra,
                            a.IdCuentaGasto,
                            a.IdCuentaBancaria,
                            a.IdCaja,
                            //a.IdTarjetaCredito,
                            a.IdMoneda,
                            a.CotizacionMonedaDestino,
                            IdTipoCuentaGrupo = 0,
                            Codigo = b != null ? b.Codigo : 0,
                            Cuenta = b != null ? b.Descripcion : "",
                            CuentaBancaria = g != null ? g.Banco.Nombre + " " + g.Cuenta : "",
                            Caja = d != null ? d.Descripcion : "",
                            //TarjetaCredito = e != null ? e.Nombre : "",
                            Obra = f != null ? f.Descripcion : "",
                            CuentaGasto = h != null ? h.Descripcion : "",
                            TipoCuentaGrupo = "",
                            a.Debe,
                            a.Haber
                        }).OrderBy(x => x.IdDetalleValorCuentas)
                        //.Skip((currentPage - 1) * pageSize).Take(pageSize)
                        .ToList();


            //var data = (from a in Entidad
            //            select new
            //            {
            //                IdDetallevalorCuentas = a[0],
            //                IdCuenta = (a[2].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[2].NullSafeToString()),
            //                Codigo = a[3],
            //                Cuenta = a[4],
            //                Debe = a[5],
            //                Haber = a[6]
            //            }).OrderBy(s => s.IdDetallevalorCuentas)
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
                            id = a.IdDetalleValorCuentas.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetalleValorCuentas.ToString(), 
                            a.IdCuenta.NullSafeToString(),
                            a.IdObra.ToString(),
                            a.IdCuentaGasto.ToString(),
                            a.IdCuentaBancaria.ToString(),
                            a.IdCaja.ToString(),
                            //a.IdTarjetaCredito.ToString(),
                            a.IdMoneda.ToString(),
                            a.CotizacionMonedaDestino.ToString(),
                            a.IdTipoCuentaGrupo.ToString(),
                            a.Codigo.NullSafeToString(),
                            a.Cuenta.NullSafeToString(),
                            a.Debe.ToString(),
                            a.Haber.ToString(),
                            a.CuentaBancaria.NullSafeToString(),
                            a.Caja.NullSafeToString(),
                            //a.TarjetaCredito.NullSafeToString(),
                            a.Obra.NullSafeToString(),
                            a.CuentaGasto.NullSafeToString(),
                            a.TipoCuentaGrupo.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult GetTiposValores()
        {
            Dictionary<int, string> Datacombo = new Dictionary<int, string>();
            foreach (Data.Models.TiposComprobante u in db.TiposComprobantes.Where(x => x.EsValor == "SI").OrderBy(x => x.Descripcion).ToList())
                Datacombo.Add(u.IdTipoComprobante, u.DescripcionAb);
            return PartialView("Select", Datacombo);
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

    }
}
