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
    public partial class PlazoFijoController : ProntoBaseController
    {
        public virtual ViewResult Index()
        {
            if (!PuedeLeer(enumNodos.PlazosFijos)) throw new Exception("No tenés permisos");
            return View();
        }

        public virtual ViewResult Edit(int id)
        {
            PlazosFijo o;

            try
            {
                if (!PuedeLeer(enumNodos.PlazosFijos))
                {
                    o = new PlazosFijo();
                    CargarViewBag(o);
                    ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                    return View(o);
                }
            }
            catch (Exception)
            {
                o = new PlazosFijo();
                CargarViewBag(o);
                ViewBag.AlertaEnLayout = "No tiene permisos de lectura";
                return View(o);
            }

            if (id <= 0)
            {
                o = new PlazosFijo();
                inic(ref o);
                CargarViewBag(o);
                return View(o);
            }
            else
            {
                o = db.PlazosFijos.SingleOrDefault(x => x.IdPlazoFijo == id);
                CargarViewBag(o);
                Session.Add("PlazosFijos", o);
                return View(o);
            }
        }

        void CargarViewBag(PlazosFijo o)
        {
            ViewBag.IdBanco = new SelectList(db.Bancos, "IdBanco", "Nombre", o.IdBanco);
            ViewBag.IdMoneda = new SelectList(db.Monedas, "IdMoneda", "Nombre", o.IdMoneda);
            ViewBag.IdPlazoFijoOrigen = new SelectList((from i in db.PlazosFijos
                                                        from b in db.Bancos.Where(y => y.IdBanco == i.IdBanco).DefaultIfEmpty()
                                                        //where i.IdPlazoFijo == o.IdPlazoFijoOrigen
                                                        select new { IdPlazoFijo = i.IdPlazoFijo, Descripcion = b.Nombre + " Certif. " + i.NumeroCertificado1.ToString() }).Distinct(), "IdPlazoFijo", "Descripcion", o.IdPlazoFijoOrigen).OrderBy(x => x.Text);
            ViewBag.IdCajaOrigen = new SelectList(db.Cajas, "IdCaja", "Descripcion", o.IdCajaOrigen);
            ViewBag.IdCuentaBancariaOrigen = new SelectList((from i in db.CuentasBancarias
                                                             where i.Activa == "SI"
                                                             select new { IdCuentaBancaria = i.IdCuentaBancaria, Nombre = i.Banco.Nombre + " " + i.Cuenta }).Distinct(), "IdCuentaBancaria", "Nombre", o.IdCuentaBancariaOrigen);
            ViewBag.IdCajaDestino = new SelectList(db.Cajas, "IdCaja", "Descripcion", o.IdCajaDestino);
            ViewBag.IdCuentaBancariaDestino = new SelectList((from i in db.CuentasBancarias
                                                             where i.Activa == "SI"
                                                             select new { IdCuentaBancaria = i.IdCuentaBancaria, Nombre = i.Banco.Nombre + " " + i.Cuenta }).Distinct(), "IdCuentaBancaria", "Nombre", o.IdCuentaBancariaDestino);
        }

        void inic(ref PlazosFijo o)
        {
            Parametros parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            Int32 mIdMonedaPeso = parametros.IdMoneda ?? 1;

            o.FechaInicioPlazoFijo = DateTime.Today;
            o.FechaVencimiento = DateTime.Today;
            o.AcreditarInteresesAlFinalizar = "SI";
            o.IdMoneda = mIdMonedaPeso;
            o.CotizacionMonedaAlInicio = 1;
            o.CotizacionMonedaAlFinal = 1;
        }

        private bool Validar(ProntoMVC.Data.Models.PlazosFijo o, ref string sErrorMsg, ref string sWarningMsg)
        {
            if (!PuedeEditar(enumNodos.PlazosFijos)) sErrorMsg += "\n" + "No tiene permisos de edición";

            Int32 mIdPlazoFijo = 0;
            Int32 mNumero = 0;
            Int32 mIdCuentaPlazosFijos = 0;
            Int32 mIdCuentaInteresesPlazosFijos = 0;
            Int32 mIdCuentaRetencionGananciasCobros = 0;
            
            decimal mImporte = 0;
            decimal mImporteIntereses = 0;
            decimal mRetencionGanancia = 0;
            decimal mImporteTotal = 0;
            decimal mTotalRubrosContablesEgresos = 0;
            decimal mTotalRubrosContablesIngresos = 0;

            DateTime mFecha = DateTime.Today;
            DateTime mFechaUltimoCierre = DateTime.Today;

            var parametros = db.Parametros.Where(p => p.IdParametro == 1).FirstOrDefault();
            mFechaUltimoCierre = parametros.FechaUltimoCierre ?? DateTime.Today;
            mIdCuentaPlazosFijos = parametros.IdCuentaPlazosFijos ?? 0;
            mIdCuentaInteresesPlazosFijos = parametros.IdCuentaInteresesPlazosFijos ?? 0;
            mIdCuentaRetencionGananciasCobros = parametros.IdCuentaRetencionGananciasCobros ?? 0;

            if (mIdCuentaPlazosFijos == 0) { sErrorMsg += "\n" + "No esta definida la cuenta contable para plazos fijos en los parametros generales"; }
            if (mIdCuentaInteresesPlazosFijos == 0) { sErrorMsg += "\n" + "No esta definida la cuenta contable para los intereses ganados en los parametros generales"; }
            if (mIdCuentaRetencionGananciasCobros == 0) { sErrorMsg += "\n" + "No esta definida la cuenta contable para las retenciones a las ganancias a los plazos fijos en los parametros generales"; }

            mIdPlazoFijo = o.IdPlazoFijo;
            mNumero = o.NumeroCertificado1 ?? 0;
            mImporte = o.Importe ?? 0;
            mImporteIntereses = o.ImporteIntereses ?? 0;
            mRetencionGanancia = o.RetencionGanancia ?? 0;
            mImporteTotal = mImporte + mImporteIntereses - mRetencionGanancia;

            if (mNumero <= 0) { sErrorMsg += "\n" + "Falta el número de certificado"; }

            if ((o.CotizacionMonedaAlInicio ?? 0) == 0) { sErrorMsg += "\n" + "Falta la conversion a pesos al inicio del plazo fijo"; }
            if (o.Finalizado == "SI" && (o.CotizacionMonedaAlFinal ?? 0) == 0) { sErrorMsg += "\n" + "Falta la conversion a pesos al final del plazo fijo"; }
            
            if ((o.IdMoneda ?? 0) == 0) { sErrorMsg += "\n" + "Falta la moneda"; }

            if ((o.IdCajaOrigen ?? 0) == 0 && (o.IdCuentaBancariaOrigen ?? 0) == 0) { sErrorMsg += "\n" + "Falta indicar el origen de los fondos"; }
            if (o.Finalizado == "SI" && (o.IdCajaDestino ?? 0) == 0 && (o.IdCuentaBancariaDestino ?? 0) == 0) { sErrorMsg += "\n" + "Falta indicar el destino de los fondos"; }

            if (o.FechaInicioPlazoFijo < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha no puede ser anterior a la del ultimo cierre contable"; }
            if (o.FechaVencimiento < mFechaUltimoCierre) { sErrorMsg += "\n" + "La fecha de vencimiento no puede ser anterior a la del ultimo cierre contable"; }

            if (mImporte <= 0) { sErrorMsg += "\n" + "El importe debe ser mayo a cero"; }

            foreach (ProntoMVC.Data.Models.DetallePlazosFijosRubrosContable x in o.DetallePlazosFijosRubrosContables)
            {
                if (x.Tipo == "E") { mTotalRubrosContablesEgresos += x.Importe ?? 0; } else { mTotalRubrosContablesIngresos += x.Importe ?? 0; }
            }
            if (mTotalRubrosContablesEgresos != mImporte) { sErrorMsg += "\n" + "El total de rubros contables egresos asignados debe ser igual al importe nominal del plazo fijo"; }
            if (o.Finalizado == "SI" && mTotalRubrosContablesIngresos != mImporteTotal) { sErrorMsg += "\n" + "El total de rubros contables ingresos asignados debe ser igual al importe total del plazo fijo"; }

            sErrorMsg = sErrorMsg.Replace("\n", "<br/>");
            sWarningMsg = sWarningMsg.Replace("\n", "<br/>");
            if (sErrorMsg != "") return false;
            return true;
        }

        [HttpPost]
        public virtual JsonResult BatchUpdate(ProntoMVC.Data.Models.PlazosFijo PlazoFijo)
        {
            if (!PuedeEditar(enumNodos.PlazosFijos)) throw new Exception("No tenés permisos");

            try
            {
                Int32 mIdPlazoFijo = 0;
                Int32 mIdMoneda = 0;
                Int32 mIdValor = 0;
                Int32 mIdBanco = 0;
                Int32 mIdCuenta = 0;
                Int32 mIdCuentaCajaTitulo = 0;
                Int32 mIdCuentaPlazosFijos = 0;
                Int32 mIdCuentaInteresesPlazosFijos = 0;
                Int32 mIdCuentaRetencionGananciasCobros = 0;
                Int32 mIdTipoComprobantePlazoFijo = 39;
                
                decimal mImporte = 0;
                decimal mImporteIntereses = 0;
                decimal mRetencionGanancia = 0;
                decimal mImporteTotal = 0;
                decimal mImporte2 = 0;
                decimal mImporteIntereses2 = 0;
                decimal mRetencionGanancia2 = 0;
                decimal mCotizacionMonedaAlInicio = 1;
                decimal mCotizacionMonedaAlFinal = 1;

                string errs = "";
                string warnings = "";
                string mAuxS1 = "";
                string mDetalle = "";

                bool mAnulado = false;

                ProntoMVC.Data.Models.Valore v;
                ProntoMVC.Data.Models.Subdiario s;

                if (!Validar(PlazoFijo, ref errs, ref warnings))
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
                mIdCuentaCajaTitulo = parametros.IdCuentaCajaTitulo ?? 0;
                mIdCuentaPlazosFijos = parametros.IdCuentaPlazosFijos ?? 0;
                mIdCuentaInteresesPlazosFijos = parametros.IdCuentaInteresesPlazosFijos ?? 0;
                mIdCuentaRetencionGananciasCobros = parametros.IdCuentaRetencionGananciasCobros ?? 0;

                if (ModelState.IsValid)
                {
                    using (TransactionScope scope = new TransactionScope())
                    {
                        mIdPlazoFijo = PlazoFijo.IdPlazoFijo;
                        if (PlazoFijo.Anulado == "SI") { mAnulado = true; }
                        mCotizacionMonedaAlInicio = PlazoFijo.CotizacionMonedaAlInicio ?? 1;
                        mCotizacionMonedaAlFinal = PlazoFijo.CotizacionMonedaAlFinal ?? 1;
                        mImporte = PlazoFijo.Importe ?? 0;
                        mImporteIntereses = PlazoFijo.ImporteIntereses ?? 0;
                        mRetencionGanancia = PlazoFijo.RetencionGanancia ?? 0;
                        mImporteTotal = mImporte + mImporteIntereses - mRetencionGanancia;
                        mIdMoneda = PlazoFijo.IdMoneda ?? 1;

                        if (mIdPlazoFijo > 0)
                        {
                            var EntidadOriginal = db.PlazosFijos.Where(p => p.IdPlazoFijo == mIdPlazoFijo).SingleOrDefault();

                            var EntidadoEntry = db.Entry(EntidadOriginal);
                            EntidadoEntry.CurrentValues.SetValues(PlazoFijo);

                            ////////////////////////////////////////////// RUBROS CONTABLES //////////////////////////////////////////////
                            foreach (var d in PlazoFijo.DetallePlazosFijosRubrosContables)
                            {
                                var DetallePlazosFijosRubrosContablesOriginal = EntidadOriginal.DetallePlazosFijosRubrosContables.Where(c => c.IdDetallePlazoFijoRubrosContables == d.IdDetallePlazoFijoRubrosContables && d.IdDetallePlazoFijoRubrosContables > 0).SingleOrDefault();
                                if (DetallePlazosFijosRubrosContablesOriginal != null)
                                {
                                    var DetallePlazosFijosRubrosContablesEntry = db.Entry(DetallePlazosFijosRubrosContablesOriginal);
                                    DetallePlazosFijosRubrosContablesEntry.CurrentValues.SetValues(d);
                                }
                                else
                                {
                                    EntidadOriginal.DetallePlazosFijosRubrosContables.Add(d);
                                }
                            }
                            foreach (var DetallePlazosFijosRubrosContablesOriginal in EntidadOriginal.DetallePlazosFijosRubrosContables.Where(c => c.IdDetallePlazoFijoRubrosContables != 0).ToList())
                            {
                                if (!PlazoFijo.DetallePlazosFijosRubrosContables.Any(c => c.IdDetallePlazoFijoRubrosContables == DetallePlazosFijosRubrosContablesOriginal.IdDetallePlazoFijoRubrosContables))
                                {
                                    EntidadOriginal.DetallePlazosFijosRubrosContables.Remove(DetallePlazosFijosRubrosContablesOriginal);
                                    db.Entry(DetallePlazosFijosRubrosContablesOriginal).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }

                            ////////////////////////////////////////////// FIN MODIFICACION //////////////////////////////////////////////
                            db.Entry(EntidadOriginal).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();
                        }
                        else
                        {
                            db.PlazosFijos.Add(PlazoFijo);
                            db.SaveChanges();
                        }

                        if (!mAnulado)
                        {
                            mIdValor = -1;
                            v = db.Valores.Where(c => c.IdPlazoFijoInicio == mIdPlazoFijo).SingleOrDefault();
                            if (v != null) { mIdValor = v.IdValor; } else { v = new Valore(); }
                            v.IdTipoValor = mIdTipoComprobantePlazoFijo;
                            v.Importe = mImporte * -1;
                            v.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                            v.FechaComprobante = PlazoFijo.FechaInicioPlazoFijo;
                            v.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                            v.IdPlazoFijoInicio = PlazoFijo.IdPlazoFijo;
                            v.IdMoneda = mIdMoneda;
                            v.CotizacionMoneda = mCotizacionMonedaAlInicio;
                            if ((PlazoFijo.IdCajaOrigen ?? 0) > 0)
                            {
                                v.IdCaja = PlazoFijo.IdCajaOrigen;
                            }
                            else
                            {
                                v.IdCuentaBancaria = PlazoFijo.IdCuentaBancariaOrigen;
                                v.IdBanco = db.CuentasBancarias.Where(x => x.IdCuentaBancaria == (PlazoFijo.IdCuentaBancariaOrigen ?? 0)).Select(x => (x.IdBanco ?? 0)).FirstOrDefault();
                            }
                            if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }

                            if ((PlazoFijo.Finalizado ?? "") == "SI")
                            {
                                mIdValor = -1;
                                v = db.Valores.Where(c => c.IdPlazoFijoFin == mIdPlazoFijo).SingleOrDefault();
                                if (v != null) { mIdValor = v.IdValor; } else { v = new Valore(); }
                                v.IdTipoValor = mIdTipoComprobantePlazoFijo;
                                v.Importe = mImporteTotal;
                                v.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                v.FechaComprobante = PlazoFijo.FechaVencimiento;
                                v.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                v.IdPlazoFijoFin = PlazoFijo.IdPlazoFijo;
                                v.IdMoneda = mIdMoneda;
                                v.CotizacionMoneda = mCotizacionMonedaAlFinal;
                                if ((PlazoFijo.IdCajaDestino ?? 0) > 0)
                                {
                                    v.IdCaja = PlazoFijo.IdCajaDestino;
                                }
                                else
                                {
                                    v.IdCuentaBancaria = PlazoFijo.IdCuentaBancariaDestino;
                                    v.IdBanco = db.CuentasBancarias.Where(x => x.IdCuentaBancaria == (PlazoFijo.IdCuentaBancariaDestino ?? 0)).Select(x => (x.IdBanco ?? 0)).FirstOrDefault();
                                }
                                if (mIdValor <= 0) { db.Valores.Add(v); } else { db.Entry(v).State = System.Data.Entity.EntityState.Modified; }
                            }
                        }
                        else
                        {
                            var Valores = db.Valores.Where(c => c.IdPlazoFijoInicio == mIdPlazoFijo || c.IdPlazoFijoFin == mIdPlazoFijo).ToList();
                            if (Valores != null)
                            {
                                foreach (Valore v1 in Valores)
                                {
                                    db.Entry(v1).State = System.Data.Entity.EntityState.Deleted;
                                }
                            }
                        }

                        db.SaveChanges();

                        ////////////////////////////////////////////// ASIENTO //////////////////////////////////////////////
                        if (mIdPlazoFijo>0 || mAnulado)
                        {
                            var Subdiarios = db.Subdiarios.Where(c => c.IdTipoComprobante == mIdTipoComprobantePlazoFijo && c.IdComprobante == mIdPlazoFijo).ToList();
                            if (Subdiarios != null) { foreach (ProntoMVC.Data.Models.Subdiario s1 in Subdiarios) { db.Entry(s1).State = System.Data.Entity.EntityState.Deleted; } }
                            db.SaveChanges();
                        }

                        if (!mAnulado)
                        {
                            if ((PlazoFijo.AcreditarInteresesAlFinalizar ?? "") == "SI") { 
                                mImporteIntereses2 = 0;
                                mRetencionGanancia2 = 0;
                                mImporte2 = mImporte;
                            }
                            else
                            {
                                mImporteIntereses2 = mImporteIntereses;
                                mRetencionGanancia2 = mRetencionGanancia;
                                mImporte2 = mImporteTotal; 
                            }

                            Banco Banco = db.Bancos.Where(c => c.IdBanco == PlazoFijo.IdBanco).SingleOrDefault();
                            if (Banco != null) { mDetalle = "Bco. " + Banco.Nombre; }
                            mDetalle = mDetalle + " - Certif. " + PlazoFijo.NumeroCertificado1.ToString() + " - Vto. " + PlazoFijo.FechaVencimiento.ToString();
                            if (mDetalle.Length > 10) { mDetalle = mDetalle.Substring(0, 9); }

                            if ((PlazoFijo.IdCajaOrigen ?? 0) > 0)
                            {
                                Caja Caja = db.Cajas.Where(c => c.IdCaja == PlazoFijo.IdCajaOrigen).SingleOrDefault();
                                if (Caja != null) { mIdCuenta = Caja.IdCuenta ?? mIdCuenta; }
                            }
                            else
                            {
                                CuentasBancaria CuentaBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == PlazoFijo.IdCuentaBancariaOrigen).SingleOrDefault();
                                if (CuentaBancaria != null) { mIdCuenta = CuentaBancaria.Banco.IdCuenta ?? mIdCuenta; }
                            }

                            s = new Subdiario();
                            s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                            s.IdCuenta = mIdCuentaPlazosFijos;
                            s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                            s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                            s.FechaComprobante = PlazoFijo.FechaInicioPlazoFijo;
                            s.IdComprobante = PlazoFijo.IdPlazoFijo;
                            s.Detalle = mDetalle;
                            s.Debe = mImporte2 * mCotizacionMonedaAlInicio;
                            s.IdMoneda = mIdMoneda;
                            s.CotizacionMoneda = mCotizacionMonedaAlInicio;
                            db.Subdiarios.Add(s);

                            if (mImporteIntereses2 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuentaInteresesPlazosFijos;
                                s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                s.FechaComprobante = PlazoFijo.FechaInicioPlazoFijo;
                                s.IdComprobante = PlazoFijo.IdPlazoFijo;
                                s.Detalle = mDetalle;
                                s.Haber = mImporteIntereses2 * mCotizacionMonedaAlInicio;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMonedaAlInicio;
                                db.Subdiarios.Add(s);
                            }

                            if (mRetencionGanancia2 > 0)
                            {
                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuentaRetencionGananciasCobros;
                                s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                s.FechaComprobante = PlazoFijo.FechaInicioPlazoFijo;
                                s.IdComprobante = PlazoFijo.IdPlazoFijo;
                                s.Detalle = mDetalle;
                                s.Debe = mRetencionGanancia2 * mCotizacionMonedaAlInicio;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMonedaAlInicio;
                                db.Subdiarios.Add(s);
                            }

                            s = new Subdiario();
                            s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                            s.IdCuenta = mIdCuenta;
                            s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                            s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                            s.FechaComprobante = PlazoFijo.FechaInicioPlazoFijo;
                            s.IdComprobante = PlazoFijo.IdPlazoFijo;
                            s.Detalle = mDetalle;
                            s.Haber = mImporte2 * mCotizacionMonedaAlInicio;
                            s.IdMoneda = mIdMoneda;
                            s.CotizacionMoneda = mCotizacionMonedaAlInicio;
                            db.Subdiarios.Add(s);

                            if ((PlazoFijo.Finalizado ?? "") == "SI")
                            {
                                if ((PlazoFijo.AcreditarInteresesAlFinalizar ?? "") == "SI")
                                {
                                    mImporteIntereses2 = mImporteIntereses;
                                    mRetencionGanancia2 = mRetencionGanancia;
                                    mImporte2 = mImporte;
                                }
                                else
                                {
                                    mImporteIntereses2 = 0;
                                    mRetencionGanancia2 = 0;
                                    mImporte2 = mImporteTotal;
                                }

                                if ((PlazoFijo.IdCajaDestino ?? 0) > 0)
                                {
                                    Caja Caja = db.Cajas.Where(c => c.IdCaja == PlazoFijo.IdCajaDestino).SingleOrDefault();
                                    if (Caja != null) { mIdCuenta = Caja.IdCuenta ?? mIdCuenta; }
                                }
                                else
                                {
                                    CuentasBancaria CuentaBancaria = db.CuentasBancarias.Where(c => c.IdCuentaBancaria == PlazoFijo.IdCuentaBancariaDestino).SingleOrDefault();
                                    if (CuentaBancaria != null) { mIdCuenta = CuentaBancaria.Banco.IdCuenta ?? mIdCuenta; }
                                }

                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuenta;
                                s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                s.FechaComprobante = PlazoFijo.FechaVencimiento;
                                s.IdComprobante = PlazoFijo.IdPlazoFijo;
                                s.Detalle = mDetalle;
                                s.Debe = mImporteTotal * mCotizacionMonedaAlFinal;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMonedaAlFinal;
                                db.Subdiarios.Add(s);

                                if (mImporteIntereses2 > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                    s.IdCuenta = mIdCuentaInteresesPlazosFijos;
                                    s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                    s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                    s.FechaComprobante = PlazoFijo.FechaVencimiento;
                                    s.IdComprobante = PlazoFijo.IdPlazoFijo;
                                    s.Detalle = mDetalle;
                                    s.Haber = mImporteIntereses2 * mCotizacionMonedaAlFinal;
                                    s.IdMoneda = mIdMoneda;
                                    s.CotizacionMoneda = mCotizacionMonedaAlFinal;
                                    db.Subdiarios.Add(s);
                                }

                                if (mRetencionGanancia2 > 0)
                                {
                                    s = new Subdiario();
                                    s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                    s.IdCuenta = mIdCuentaRetencionGananciasCobros;
                                    s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                    s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                    s.FechaComprobante = PlazoFijo.FechaVencimiento;
                                    s.IdComprobante = PlazoFijo.IdPlazoFijo;
                                    s.Detalle = mDetalle;
                                    s.Debe = mRetencionGanancia2 * mCotizacionMonedaAlFinal;
                                    s.IdMoneda = mIdMoneda;
                                    s.CotizacionMoneda = mCotizacionMonedaAlFinal;
                                    db.Subdiarios.Add(s);
                                }

                                s = new Subdiario();
                                s.IdCuentaSubdiario = mIdCuentaCajaTitulo;
                                s.IdCuenta = mIdCuentaPlazosFijos;
                                s.IdTipoComprobante = mIdTipoComprobantePlazoFijo;
                                s.NumeroComprobante = PlazoFijo.NumeroCertificado1;
                                s.FechaComprobante = PlazoFijo.FechaVencimiento;
                                s.IdComprobante = PlazoFijo.IdPlazoFijo;
                                s.Detalle = mDetalle;
                                s.Haber = mImporte2 * mCotizacionMonedaAlFinal;
                                s.IdMoneda = mIdMoneda;
                                s.CotizacionMoneda = mCotizacionMonedaAlFinal;
                                db.Subdiarios.Add(s);
                            }
                            
                            db.SaveChanges();
                        }

                        scope.Complete();
                        scope.Dispose();
                    }

                    TempData["Alerta"] = "Grabado " + DateTime.Now.ToShortTimeString();

                    return Json(new { Success = 1, IdPlazoFijo = PlazoFijo.IdPlazoFijo, ex = "" });
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

        public virtual ActionResult TT(string sidx, string sord, int? page, int? rows, bool _search, string searchField, string searchOper, string searchString, string Tipo)
        {
            string campo = String.Empty;
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            var data = (from a in db.PlazosFijos
                        from b in db.Bancos.Where(y => y.IdBanco == a.IdBanco).DefaultIfEmpty()
                        from c in db.Monedas.Where(y => y.IdMoneda == a.IdMoneda).DefaultIfEmpty()
                        from d in db.Cajas.Where(y => y.IdCaja == a.IdCajaOrigen).DefaultIfEmpty()
                        from e in db.CuentasBancarias.Where(y => y.IdCuentaBancaria == a.IdCuentaBancariaOrigen).DefaultIfEmpty()
                        from f in db.Cajas.Where(y => y.IdCaja == a.IdCajaDestino).DefaultIfEmpty()
                        from g in db.CuentasBancarias.Where(y => y.IdCuentaBancaria == a.IdCuentaBancariaDestino).DefaultIfEmpty()
                        from h in db.Bancos.Where(y => y.IdBanco == (e.IdBanco ?? 0)).DefaultIfEmpty()
                        from i in db.Bancos.Where(y => y.IdBanco == (g.IdBanco ?? 0)).DefaultIfEmpty()
                        from j in db.PlazosFijos.Where(y => y.IdPlazoFijo == a.IdPlazoFijoOrigen).DefaultIfEmpty()
                        select new
                        {
                            a.IdPlazoFijo,
                            a.IdBanco,
                            a.IdMoneda,
                            a.IdCajaOrigen,
                            a.IdCuentaBancariaOrigen,
                            a.IdCajaDestino,
                            a.IdCuentaBancariaDestino,
                            a.IdPlazoFijoOrigen,
                            Banco = b != null ? b.Nombre : "",
                            a.NumeroCertificado1,
                            a.Anulado,
                            a.Titulares,
                            a.PlazoEnDias,
                            a.TasaNominalAnual,
                            a.TasaEfectivaMensual,
                            a.FechaInicioPlazoFijo,
                            a.FechaVencimiento,
                            OrigenFondosTipo = (a.IdCajaOrigen ?? 0) > 0 ? "Caja" : ((a.IdCuentaBancariaOrigen ?? 0) > 0 ? "Banco" : ""),
                            OrigenFondos = d != null ? d.Descripcion : (e != null ? (h != null ? h.Nombre : "") + " " + e.Cuenta : ""),
                            DestinoFondosTipo = (a.IdCajaDestino ?? 0) > 0 ? "Caja" : ((a.IdCuentaBancariaDestino ?? 0) > 0 ? "Banco" : ""),
                            DestinoFondos = f != null ? f.Descripcion : (g != null ? (i != null ? i.Nombre : "") + " " + g.Cuenta : ""),
                            PlazoFijoOrigen = j != null ? j.NumeroCertificado1.ToString() : "",
                            a.Importe,
                            a.ImporteIntereses,
                            a.RetencionGanancia,
                            ImporteTotal = a.Importe - a.RetencionGanancia + a.ImporteIntereses,
                            Moneda = c != null ? c.Abreviatura : "",
                            a.CotizacionMonedaAlInicio,
                            a.CotizacionMonedaAlFinal,
                            a.Finalizado,
                            a.AcreditarInteresesAlFinalizar,
                            a.DireccionEmisionYPago,
                            a.CodigoDeposito,
                            a.CodigoClase,
                            a.Orden,
                            a.Detalle
                        }).AsQueryable();

            if (Tipo == "AVencer") { data = (from a in data where a.FechaVencimiento > DateTime.Today && (a.Anulado ?? "") != "SI" select a).AsQueryable(); }
            if (Tipo == "Vencidos") { data = (from a in data where a.FechaVencimiento <= DateTime.Today && (a.Anulado ?? "") != "SI" select a).AsQueryable(); }

            int totalRecords = data.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data1 = (from a in data select a).OrderBy(x => x.Banco).ThenBy(x => x.FechaVencimiento)
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
                            id = a.IdPlazoFijo.ToString(),
                            cell = new string[] { 
                                "<a href="+ Url.Action("Edit",new {id = a.IdPlazoFijo} ) + ">Editar</>",
                                a.IdPlazoFijo.ToString(),
                                a.IdBanco.NullSafeToString(),
                                a.IdMoneda.NullSafeToString(),
                                a.IdCajaOrigen.NullSafeToString(),
                                a.IdCuentaBancariaOrigen.NullSafeToString(),
                                a.IdCajaDestino.NullSafeToString(),
                                a.IdCuentaBancariaDestino.NullSafeToString(),
                                a.IdPlazoFijoOrigen.NullSafeToString(),
                                a.Banco.NullSafeToString(),
                                a.NumeroCertificado1.NullSafeToString(),
                                a.Anulado.NullSafeToString(),
                                a.Titulares.NullSafeToString(),
                                a.PlazoEnDias.NullSafeToString(),
                                a.TasaNominalAnual.NullSafeToString(),
                                a.TasaEfectivaMensual.NullSafeToString(),
                                a.FechaInicioPlazoFijo == null ? "" : a.FechaInicioPlazoFijo.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.FechaVencimiento == null ? "" : a.FechaVencimiento.GetValueOrDefault().ToString("dd/MM/yyyy"),
                                a.OrigenFondosTipo.NullSafeToString(),
                                a.OrigenFondos.NullSafeToString(),
                                a.DestinoFondosTipo.NullSafeToString(),
                                a.DestinoFondos.NullSafeToString(),
                                a.PlazoFijoOrigen.NullSafeToString(),
                                a.Importe.NullSafeToString(),
                                a.ImporteIntereses.NullSafeToString(),
                                a.RetencionGanancia.NullSafeToString(),
                                a.ImporteTotal.NullSafeToString(),
                                a.Moneda.NullSafeToString(),
                                a.CotizacionMonedaAlInicio.NullSafeToString(),
                                a.CotizacionMonedaAlFinal.NullSafeToString(),
                                a.Finalizado.NullSafeToString(),
                                a.AcreditarInteresesAlFinalizar.NullSafeToString(),
                                a.DireccionEmisionYPago.NullSafeToString(),
                                a.CodigoDeposito.NullSafeToString(),
                                a.CodigoClase.NullSafeToString(),
                                a.Orden.NullSafeToString(),
                                a.Detalle.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult DetPlazosFijosRubrosContables(string sidx, string sord, int? page, int? rows, int IdPlazoFijo, string Tipo)
        {
            var Det = db.DetallePlazosFijosRubrosContables.Where(p => p.IdPlazoFijo == IdPlazoFijo && ((Tipo == "Egreso" && (p.Tipo ?? "") == "E") || (Tipo == "Ingreso" && (p.Tipo ?? "") == "I"))).AsQueryable();
            int pageSize = rows ?? 20;
            int totalRecords = Det.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);
            int currentPage = page ?? 1;

            var data = (from a in Det
                        from b in db.RubrosContables.Where(o => o.IdRubroContable == a.IdRubroContable).DefaultIfEmpty()
                        select new
                        {
                            a.IdDetallePlazoFijoRubrosContables,
                            a.IdRubroContable,
                            RubroContable = b.Descripcion != null ? b.Descripcion : "",
                            a.Importe
                        }).OrderBy(x => x.IdDetallePlazoFijoRubrosContables)
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
                            id = a.IdDetallePlazoFijoRubrosContables.ToString(),
                            cell = new string[] { 
                            string.Empty, 
                            a.IdDetallePlazoFijoRubrosContables.ToString(), 
                            a.IdRubroContable.NullSafeToString(),
                            a.RubroContable.NullSafeToString(),
                            a.Importe.NullSafeToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public void EditGridData(int? IdPlazoFijo, int? NumeroItem, decimal? Cantidad, string Unidad, string Codigo, string Descripcion, string oper)
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