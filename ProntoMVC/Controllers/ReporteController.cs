using System;
using System.Collections.Generic;
using System.Configuration;
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
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;

using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
//using Trirand.Web.Mvc;

using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using Pronto.ERP.Bll;

namespace ProntoMVC.Controllers
{
    public partial class ReporteController : ProntoBaseController
    {
        public virtual ActionResult RegimenDeInformacionDeComprasYVentas()
        {
            return View();
        }

        public virtual ActionResult RegimenDeInformacionDeComprasYVentas_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "InformesContables_TX_ComprasYVentas", FechaInicial, FechaFinal);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            TipoRegistro = a[1],
                            Fecha = a[2],
                            Registro2 = a[3],
                            TipoComprobante2 = a[4],
                            PuntoVenta = a[5],
                            NumeroComprobante1 = a[6],
                            NumeroComprobante2 = a[7],
                            TipoDocumentoIdentificacion = a[8],
                            NumeroDocumentoIdentificacion = a[9],
                            RazonSocial = a[10],
                            ImporteTotal = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            ImporteNoGravado = (a[12].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[12].NullSafeToString()),
                            PercepcionANoCategorizados = (a[13].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[13].NullSafeToString()),
                            ImporteExento = (a[14].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[14].NullSafeToString()),
                            ImportePagoACuentaImpuestosMunicipales = (a[15].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[15].NullSafeToString()),
                            ImportePercepcionesIIBB = (a[16].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[16].NullSafeToString()),
                            ImportePercepcionesImpuestosMunicipales = (a[17].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[17].NullSafeToString()),
                            ImporteImpuestosInternos = (a[18].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[18].NullSafeToString()),
                            Moneda = a[19],
                            CotizacionMoneda = (a[20].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[20].NullSafeToString()),
                            CantidadAlicuotasIVA = (a[21].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[21].NullSafeToString()),
                            CodigoOperacion = a[22],
                            OtrosTributos = (a[23].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[23].NullSafeToString()),

                            ImporteGravado = (a[24].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[24].NullSafeToString()),
                            CodigoAlicuotaIVA = a[25],
                            ImporteIVADiscriminado = (a[26].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[26].NullSafeToString()),

                            NumeroDespacho = a[27],
                            ImportePercepcionesOPagosImpuestoAlValorAgregado = (a[28].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[28].NullSafeToString()),
                            ImportePercepcionesOPagosImpuestosNacionales = (a[29].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[29].NullSafeToString()),
                            CreditoFiscalComputable = (a[30].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[30].NullSafeToString()),
                            CuitEmisorCorredor = a[31],
                            DenominacionEmisorCorredor = a[32],

                            Registro = a[33]
                        }).ToList();

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
                                a.TipoRegistro.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.Registro2.ToString(), 
                                a.TipoComprobante2.ToString(), 
                                a.PuntoVenta.ToString(), 
                                a.NumeroComprobante1.ToString(), 
                                a.NumeroComprobante2.ToString(), 
                                a.TipoDocumentoIdentificacion.ToString(), 
                                a.NumeroDocumentoIdentificacion.ToString(), 
                                a.RazonSocial.ToString(), 
                                a.ImporteTotal.ToString(),
                                a.ImporteNoGravado.ToString(),
                                a.PercepcionANoCategorizados.ToString(),
                                a.ImporteExento.ToString(), 
                                a.ImportePagoACuentaImpuestosMunicipales.ToString(), 
                                a.ImportePercepcionesIIBB.ToString(), 
                                a.ImportePercepcionesImpuestosMunicipales.ToString(), 
                                a.ImporteImpuestosInternos.ToString(), 
                                a.Moneda.ToString(), 
                                a.CotizacionMoneda.ToString(), 
                                a.CantidadAlicuotasIVA.ToString(),
                                a.CodigoOperacion.ToString(), 
                                a.OtrosTributos.ToString(), 
                                a.ImporteGravado.ToString(), 
                                a.CodigoAlicuotaIVA.ToString(), 
                                a.ImporteIVADiscriminado.ToString(), 
                                a.NumeroDespacho.ToString(), 
                                a.ImportePercepcionesOPagosImpuestoAlValorAgregado.ToString(), 
                                a.ImportePercepcionesOPagosImpuestosNacionales.ToString(), 
                                a.CreditoFiscalComputable.ToString(), 
                                a.CuitEmisorCorredor.ToString(), 
                                a.DenominacionEmisorCorredor.ToString(), 
                                a.Registro.ToString()
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

        public virtual ActionResult SICORE_RetencionesGanancias_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SICORE_RetencionesGanancias_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_SICORE", FechaInicial, FechaFinal);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            CodigoMovimiento = a[1],
                            Fecha = a[2],
                            NumeroMovimiento = a[3],
                            ImporteTotal = (a[4].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[4].NullSafeToString()),
                            Proveedor = a[5],
                            CodigoImpuesto = (a[6].NullSafeToString() == "") ? 0 : Convert.ToInt32(a[6].NullSafeToString()),
                            CodigoRegimen = a[7],
                            CodigoOperacion = a[8],
                            BaseCalculo = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            FechaEmisionRetencion = a[10],
                            CodigoCondicion = a[11],
                            ImporteRetencion = (a[12].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[12].NullSafeToString()),
                            PorcentajeExclusion = a[13],
                            FechaEmisionBoletin = a[14],
                            TipoDocumentoRetenido = a[15],
                            NumeroDocumentoRetenido = a[16],
                            NumeroCertificadoOriginal = a[17],
                            DenominacionOrdenante = a[18],
                            CuitDelPaisDelRetenido = a[19],
                            CuitDelOrdenante = a[20],
                            Registro = a[21]
                        }).ToList();

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
                                a.CodigoMovimiento.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.NumeroMovimiento.ToString(), 
                                a.ImporteTotal.ToString(), 
                                a.Proveedor.ToString(), 
                                a.CodigoImpuesto.ToString(), 
                                a.CodigoRegimen.ToString(), 
                                a.CodigoOperacion.ToString(), 
                                a.BaseCalculo.ToString(), 
                                a.FechaEmisionRetencion == null || a.FechaEmisionRetencion.ToString() == "" ? "" : Convert.ToDateTime(a.FechaEmisionRetencion.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.CodigoCondicion.ToString(),
                                a.ImporteRetencion.ToString(),
                                a.PorcentajeExclusion.ToString(),
                                a.FechaEmisionBoletin == null || a.FechaEmisionBoletin.ToString() == "" ? "" : Convert.ToDateTime(a.FechaEmisionBoletin.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.TipoDocumentoRetenido.ToString(), 
                                a.NumeroDocumentoRetenido.ToString(), 
                                a.NumeroCertificadoOriginal.ToString(), 
                                a.DenominacionOrdenante.ToString(), 
                                a.CuitDelPaisDelRetenido.ToString(), 
                                a.CuitDelOrdenante.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SICORE_RetencionesIva_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SICORE_RetencionesIva_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_RetencionesIVA", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            CodigoProveedor = a[1],
                            Proveedor = a[2],
                            Cuit = a[3],
                            OrdenPago = a[4],
                            Fecha = a[5],
                            NumeroCertificado = a[6],
                            Comprobante = a[7],
                            ImporteRetencionIVA = (a[8].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[8].NullSafeToString()),
                            Registro = a[9]
                        }).ToList();

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
                                a.CodigoProveedor.ToString(), 
                                a.Proveedor.ToString(), 
                                a.Cuit.ToString(), 
                                a.OrdenPago.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.NumeroCertificado.ToString(), 
                                a.Comprobante.ToString(), 
                                a.ImporteRetencionIVA.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SICORE_PercepcionesIva_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SICORE_PercepcionesIva_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_PercepcionesIVA", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            CodigoProveedor = a[1],
                            Proveedor = a[2],
                            Cuit = a[3],
                            Comprobante = a[4],
                            Fecha = a[5],
                            FechaComprobante = a[6],
                            ImportePercepcionIVA = (a[7].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[7].NullSafeToString()),
                            Registro = a[8]
                        }).ToList();

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
                                a.CodigoProveedor.ToString(), 
                                a.Proveedor.ToString(), 
                                a.Cuit.ToString(), 
                                a.Comprobante.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.FechaComprobante.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.ImportePercepcionIVA.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SUSS_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SUSS_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_SUSS", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            Proveedor = a[1],
                            Cuit = a[2],
                            Fecha = a[3],
                            NumeroMovimiento = a[4],
                            NumeroCertificado = a[5],
                            ImporteRetencion = (a[6].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[6].NullSafeToString()),
                            Registro = a[7]
                        }).ToList();

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
                                a.Proveedor.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.NumeroMovimiento.ToString(), 
                                a.NumeroCertificado.ToString(), 
                                a.ImporteRetencion.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIRE_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SIRE_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_SIRE", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            Formulario = a[1],
                            Version = a[2],
                            Trazabilidad = a[3],
                            CuitAgente = a[4],
                            Impuesto = a[5],
                            Regimen = a[6],
                            Proveedor = a[7],
                            CuitRetenido = a[8],
                            OrdenPago = a[9],
                            FechaRetencion = a[10],
                            TipoComprobante = a[11],
                            FechaComprobante = a[12],
                            NumeroComprobante = a[13],
                            NumeroCertificado = a[14],
                            ImporteComprobante = (a[15].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[15].NullSafeToString()),
                            ImporteRetencion = (a[16].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[16].NullSafeToString()),
                            CertificadoOriginal = a[17],
                            CertificadoOriginalFechaRetencion = a[18],
                            CertificadoOriginalImporte = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString()),
                            OtrosDatos = a[20],
                            Registro = a[21]
                        }).ToList();

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
                                a.Formulario.ToString(), 
                                a.Version.ToString(), 
                                a.Trazabilidad.ToString(), 
                                a.CuitAgente.ToString(), 
                                a.Impuesto.ToString(), 
                                a.Regimen.ToString(), 
                                a.Proveedor.ToString(), 
                                a.CuitRetenido.ToString(), 
                                a.OrdenPago.ToString(), 
                                a.FechaRetencion == null || a.FechaRetencion.ToString() == "" ? "" : Convert.ToDateTime(a.FechaRetencion.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.TipoComprobante.ToString(), 
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.FechaComprobante.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.NumeroComprobante.ToString(), 
                                a.NumeroCertificado.ToString(), 
                                a.ImporteComprobante.ToString(), 
                                a.ImporteRetencion.ToString(), 
                                a.CertificadoOriginal.ToString(), 
                                a.CertificadoOriginalFechaRetencion.ToString(), 
                                a.CertificadoOriginalImporte.ToString(), 
                                a.OtrosDatos.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIFERE_RetencionesIIBBPagos_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SIFERE_RetencionesIIBBPagos_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal, int CodigoActividad)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_RetencionesIIBB", FechaInicial, FechaFinal, 1, CodigoActividad, "SI");
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdDetalleOrdenPagoImpuestos = a[1],
                            Origen = a[2],
                            Proveedor = a[3],
                            DireccionProveedor = a[4],
                            LocalidadProveedor = a[5],
                            ProvinciaProveedor = a[6],
                            CuitProveedor = a[7],
                            Fecha = a[8],
                            Numero = a[9],
                            CodigoCondicion = a[10],
                            ImporteTotal = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            BaseCalculo = (a[12].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[12].NullSafeToString()),
                            Alicuota = (a[13].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[13].NullSafeToString()),
                            ImporteRetencion = (a[14].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[14].NullSafeToString()),
                            NumeroCertificado = a[15],
                            NumeroComprobanteImputado = a[16],
                            IdProvinciaImpuesto = a[17],
                            ProvinciaImpuesto = a[18],
                            TipoRegistro = a[19],
                            IdIBCondicion = a[20],
                            IBCondicion = a[21],
                            CuitEmpresa = a[22],
                            IBNumeroInscripcion = a[23],
                            CodigoIBCondicion = a[24],
                            LetraComprobanteImputado = a[25],
                            JurisdiccionProveedor = a[26],
                            NumeroOrden = a[27],
                            Registro = a[28],
                            Registro1 = a[29],
                            IdCodigoIva = a[30],
                            ImporteIVA = (a[31].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[31].NullSafeToString()),
                            SucursalComprobanteImputado = a[32],
                            CodigoComprobante = a[33],
                            FechaComprobante = a[34],
                            ImporteComprobante = (a[35].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[35].NullSafeToString()),
                            CodigoNorma = a[36],
                            CodigoActividad = a[37],
                            CodigoArticuloInciso = a[38],
                            OtrosConceptos = (a[39].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[39].NullSafeToString()),
                            CodigoCategoriaIIBBAlternativo = a[40]
                        }).ToList();

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
                                a.IdDetalleOrdenPagoImpuestos.ToString(), 
                                a.Origen.ToString(), 
                                a.Proveedor.ToString(), 
                                a.DireccionProveedor.ToString(), 
                                a.LocalidadProveedor.ToString(), 
                                a.ProvinciaProveedor.ToString(), 
                                a.CuitProveedor.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.Numero.ToString(), 
                                a.CodigoCondicion.ToString(), 
                                a.ImporteTotal.ToString(), 
                                a.BaseCalculo.ToString(), 
                                a.Alicuota.ToString(), 
                                a.ImporteRetencion.ToString(), 
                                a.NumeroCertificado.ToString(), 
                                a.NumeroComprobanteImputado.ToString(), 
                                a.IdProvinciaImpuesto.ToString(), 
                                a.ProvinciaImpuesto.ToString(), 
                                a.TipoRegistro.ToString(), 
                                a.IdIBCondicion.ToString(), 
                                a.IBCondicion.ToString(), 
                                a.CuitEmpresa.ToString(), 
                                a.IBNumeroInscripcion.ToString(), 
                                a.CodigoIBCondicion.ToString(), 
                                a.LetraComprobanteImputado.ToString(), 
                                a.JurisdiccionProveedor.ToString(), 
                                a.NumeroOrden.ToString(), 
                                a.Registro.ToString(), 
                                a.Registro1.ToString(), 
                                a.IdCodigoIva.ToString(), 
                                a.ImporteIVA.ToString(), 
                                a.SucursalComprobanteImputado.ToString(), 
                                a.CodigoComprobante.ToString(), 
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.FechaComprobante.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.ImporteComprobante.ToString(), 
                                a.CodigoNorma.ToString(), 
                                a.CodigoActividad.ToString(), 
                                a.CodigoArticuloInciso.ToString(), 
                                a.OtrosConceptos.ToString(), 
                                a.CodigoCategoriaIIBBAlternativo.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIFERE_SIRCREB_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SIFERE_SIRCREB_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal, string TipoArchivo)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_PercepcionesIIBB_SIRCREB", FechaInicial, FechaFinal, TipoArchivo, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdProvincia = a[1],
                            Provincia = a[2],
                            Jurisdiccion = a[3],
                            Cuit = a[4],
                            CBU = a[5],
                            TipoCuenta = a[6],
                            Mes = a[7],
                            Año = a[8],
                            TipoMoneda = a[9],
                            ImporteIIBB = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            Registro = a[11]
                        }).ToList();

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
                                a.IdProvincia.ToString(), 
                                a.Provincia.ToString(), 
                                a.Jurisdiccion.ToString(), 
                                a.Cuit.ToString(), 
                                a.CBU.ToString(), 
                                a.TipoCuenta.ToString(), 
                                a.Mes.ToString(), 
                                a.Año.ToString(), 
                                a.TipoMoneda.ToString(), 
                                a.ImporteIIBB.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIFERE_PercepcionesIIBB_Convenio_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SIFERE_PercepcionesIIBB_Convenio_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal, string TipoArchivo)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_PercepcionesIIBBConvenio", FechaInicial, FechaFinal, TipoArchivo, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdComprobanteProveedor = a[1],
                            IdProvincia = a[2],
                            Tipo = a[3],
                            Jurisdiccion = a[4],
                            Provincia = a[5],
                            Proveedor = a[6],
                            Cuit = a[7],
                            Fecha = a[8],
                            FechaComprobante = a[9],
                            NumeroComprobante1 = a[10],
                            NumeroComprobante2 = a[11],
                            TipoComprobante = a[12],
                            Letra = a[13],
                            ImporteIIBB = (a[14].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[14].NullSafeToString()),
                            Importacion_Despacho = a[15],
                            CBU = a[16],
                            IdMoneda = a[17],
                            Registro = a[18],
                            ImporteBase = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString())
                        }).ToList();

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
                                a.IdComprobanteProveedor.ToString(), 
                                a.IdProvincia.ToString(), 
                                a.Tipo.ToString(), 
                                a.Jurisdiccion.ToString(), 
                                a.Provincia.ToString(), 
                                a.Proveedor.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.FechaComprobante.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.NumeroComprobante1.ToString(), 
                                a.NumeroComprobante2.ToString(), 
                                a.TipoComprobante.ToString(), 
                                a.Letra.ToString(), 
                                a.ImporteIIBB.ToString(), 
                                a.Importacion_Despacho.ToString(), 
                                a.CBU.ToString(), 
                                a.IdMoneda.ToString(), 
                                a.Registro.ToString(), 
                                a.ImporteBase.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIFERE_PercepcionesIIBB_JurisdiccionLocal_Proveedores()
        {
            return View();
        }

        public virtual ActionResult SIFERE_PercepcionesIIBB_JurisdiccionLocal_Proveedores_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal, string TipoArchivo)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Proveedores_TX_PercepcionesIIBB", FechaInicial, FechaFinal, TipoArchivo, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdComprobanteProveedor = a[1],
                            IdProvincia = a[2],
                            Tipo = a[3],
                            Jurisdiccion = a[4],
                            Provincia = a[5],
                            Proveedor = a[6],
                            Cuit = a[7],
                            Fecha = a[8],
                            FechaComprobante = a[9],
                            NumeroComprobante1 = a[10],
                            NumeroComprobante2 = a[11],
                            TipoComprobante = a[12],
                            Letra = a[13],
                            ImporteIIBB = (a[14].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[14].NullSafeToString()),
                            Importacion_Despacho = a[15],
                            CBU = a[16],
                            Registro = a[17],
                            IdMoneda = a[18],
                            ImporteBase = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString()),
                            IdObra = a[20],
                            Obra = a[21]
                        }).ToList();

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
                                a.IdComprobanteProveedor.ToString(), 
                                a.IdProvincia.ToString(), 
                                a.Tipo.ToString(), 
                                a.Jurisdiccion.ToString(), 
                                a.Provincia.ToString(), 
                                a.Proveedor.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.FechaComprobante == null || a.FechaComprobante.ToString() == "" ? "" : Convert.ToDateTime(a.FechaComprobante.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.NumeroComprobante1.ToString(), 
                                a.NumeroComprobante2.ToString(), 
                                a.TipoComprobante.ToString(), 
                                a.Letra.ToString(), 
                                a.ImporteIIBB.ToString(), 
                                a.Importacion_Despacho.ToString(), 
                                a.CBU.ToString(), 
                                a.Registro.ToString(), 
                                a.IdMoneda.ToString(), 
                                a.ImporteBase.ToString(), 
                                a.IdObra.ToString(), 
                                a.Obra.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SICORE_RetencionesGanancias_Clientes()
        {
            return View();
        }

        public virtual ActionResult SICORE_RetencionesGanancias_Clientes_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Clientes_TX_RetencionesGanancias", FechaInicial, FechaFinal, "", 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdComprobante = a[1],
                            IdEntidad = a[2],
                            K_Registro = a[3],
                            CodigoEntidad = a[4],
                            Entidad = a[5],
                            Cuit = a[6],
                            Fecha = a[7],
                            TipoRetencion = a[8],
                            CodigoRegimenAFIP = a[9],
                            Comprobante = a[10],
                            NumeroCertificado = a[11],
                            RetencionGanancias = (a[12].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[12].NullSafeToString()),
                            RetencionGananciasParaRegistro = (a[13].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[13].NullSafeToString()),
                            Registro = a[14],
                            Registro1 = a[15]
                        }).ToList();

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
                                a.IdComprobante.ToString(), 
                                a.IdEntidad.ToString(), 
                                a.K_Registro.ToString(), 
                                a.CodigoEntidad.ToString(), 
                                a.Entidad.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.TipoRetencion.ToString(), 
                                a.CodigoRegimenAFIP.ToString(), 
                                a.Comprobante.ToString(),
                                a.NumeroCertificado.ToString(),
                                a.RetencionGanancias.ToString(),
                                a.RetencionGananciasParaRegistro.ToString(), 
                                a.Registro.ToString(), 
                                a.Registro1.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SICORE_RetencionesIVA_Clientes()
        {
            return View();
        }

        public virtual ActionResult SICORE_RetencionesIVA_Clientes_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Clientes_TX_RetencionesIVA", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdRecibo = a[1],
                            IdCliente = a[2],
                            K_Registro = a[3],
                            CodigoCliente = a[4],
                            Cliente = a[5],
                            Cuit = a[6],
                            Fecha = a[7],
                            Comprobante = a[8],
                            NumeroCertificado = a[9],
                            RetencionIVA = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            Registro = a[11]
                        }).ToList();

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
                                a.IdRecibo.ToString(), 
                                a.IdCliente.ToString(), 
                                a.K_Registro.ToString(), 
                                a.CodigoCliente.ToString(), 
                                a.Cliente.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.Comprobante.ToString(),
                                a.NumeroCertificado.ToString(),
                                a.RetencionIVA.ToString(),
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SICORE_PercepcionesIVA_Clientes()
        {
            return View();
        }

        public virtual ActionResult SICORE_PercepcionesIVA_Clientes_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Clientes_TX_PercepcionesIVA", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            Cliente = a[1],
                            CuitCliente = a[2],
                            Fecha = a[3],
                            CodigoComprobante = a[4],
                            TipoComprobante = a[5],
                            LetraComprobante = a[6],
                            PuntoVenta = a[7],
                            Numero = a[8],
                            CodigoCondicion = a[9],
                            BaseImponible = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            ImporteTotal = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            ImportePercepcion = (a[12].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[12].NullSafeToString()),
                            Alicuota = (a[13].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[13].NullSafeToString()),
                            CuitEmpresa = a[14],
                            Registro = a[15]
                        }).ToList();

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
                                a.Cliente.ToString(), 
                                a.CuitCliente.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.CodigoComprobante.ToString(), 
                                a.TipoComprobante.ToString(), 
                                a.LetraComprobante.ToString(), 
                                a.PuntoVenta.ToString(), 
                                a.Numero.ToString(),
                                a.CodigoCondicion.ToString(),
                                a.BaseImponible.ToString(),
                                a.ImporteTotal.ToString(),
                                a.ImportePercepcion.ToString(),
                                a.Alicuota.ToString(),
                                a.CuitEmpresa.ToString(),
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIFERE_PercepcionesIIBB_Clientes()
        {
            return View();
        }

        public virtual ActionResult SIFERE_PercepcionesIIBB_Clientes_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal, int CodigoActividad)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Clientes_TX_PercepcionesIIBB", FechaInicial, FechaFinal, CodigoActividad, "SI");
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            Cliente = a[1],
                            CuitCliente = a[2],
                            Fecha = a[3],
                            TipoComprobante = a[4],
                            LetraComprobante = a[5],
                            PuntoVenta = a[6],
                            Numero = a[7],
                            BaseImponible = (a[8].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[8].NullSafeToString()),
                            ImportePercepcion = (a[9].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[9].NullSafeToString()),
                            NumeroCertificadoPercepcionIIBB = a[10],
                            Alicuota = a[11],
                            TipoRegistro = a[12],
                            IdProvinciaImpuesto = a[13],
                            ProvinciaImpuesto = a[14],
                            CuitEmpresa = a[15],
                            IBNumeroInscripcion = a[16],
                            Registro = a[17],
                            Registro1 = a[18],
                            ImporteIVA = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString()),
                            ImporteTotal = (a[20].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[20].NullSafeToString()),
                            IBCondicion = a[21],
                            IdCodigoIva = a[22],
                            CodigoIBCondicion = a[23],
                            CodigoComprobante = a[24],
                            CodigoActividad = a[25],
                            NumeroOrden = a[26],
                            CodigoNorma = a[27],
                            Jurisdiccion = a[28],
                            OtrosConceptos = a[29]
                        }).ToList();

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
                                a.Cliente.ToString(), 
                                a.CuitCliente.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.TipoComprobante.ToString(), 
                                a.LetraComprobante.ToString(), 
                                a.PuntoVenta.ToString(), 
                                a.Numero.ToString(), 
                                a.BaseImponible.ToString(), 
                                a.ImportePercepcion.ToString(), 
                                a.NumeroCertificadoPercepcionIIBB.ToString(), 
                                a.Alicuota.ToString(), 
                                a.TipoRegistro.ToString(), 
                                a.IdProvinciaImpuesto.ToString(), 
                                a.ProvinciaImpuesto.ToString(), 
                                a.CuitEmpresa.ToString(), 
                                a.IBNumeroInscripcion.ToString(), 
                                a.Registro.ToString(), 
                                a.Registro1.ToString(), 
                                a.ImporteIVA.ToString(), 
                                a.ImporteTotal.ToString(), 
                                a.IBCondicion.ToString(), 
                                a.IdCodigoIva.ToString(), 
                                a.CodigoIBCondicion.ToString(), 
                                a.CodigoComprobante.ToString(), 
                                a.CodigoActividad.ToString(), 
                                a.NumeroOrden.ToString(), 
                                a.CodigoNorma.ToString(), 
                                a.Jurisdiccion.ToString(), 
                                a.OtrosConceptos.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SIFERE_RetencionesIIBB_Clientes()
        {
            return View();
        }

        public virtual ActionResult SIFERE_RetencionesIIBB_Clientes_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal, string TipoArchivo)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Clientes_TX_RetencionesIIBB_Cobranzas", FechaInicial, FechaFinal, TipoArchivo, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdRecibo = a[1],
                            IdCliente = a[2],
                            IdProvincia = a[3],
                            Jurisdiccion = a[4],
                            Provincia = a[5],
                            CodigoCliente = a[6],
                            Cliente = a[7],
                            Cuit = a[8],
                            Fecha = a[9],
                            PuntoVenta = a[10],
                            Comprobante = a[11],
                            TipoComprobanteOrigen = a[12],
                            LetraComprobanteOrigen = a[13],
                            NumeroComprobanteOrigen = a[14],
                            RetencionIIBB = (a[15].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[15].NullSafeToString()),
                            Valores = (a[16].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[16].NullSafeToString()),
                            Registro = a[17]
                        }).ToList();

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
                                a.IdRecibo.ToString(), 
                                a.IdCliente.ToString(), 
                                a.IdProvincia.ToString(), 
                                a.Jurisdiccion.ToString(), 
                                a.Provincia.ToString(), 
                                a.CodigoCliente.ToString(), 
                                a.Cliente.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.PuntoVenta.ToString(), 
                                a.Comprobante.ToString(), 
                                a.TipoComprobanteOrigen.ToString(), 
                                a.LetraComprobanteOrigen.ToString(), 
                                a.NumeroComprobanteOrigen.ToString(), 
                                a.RetencionIIBB.ToString(), 
                                a.Valores.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

        public virtual ActionResult SUSS_Clientes()
        {
            return View();
        }

        public virtual ActionResult SUSS_Clientes_Informe(string sidx, string sord, int? page, int? rows, DateTime FechaInicial, DateTime FechaFinal)
        {
            int pageSize = rows ?? 20;
            int currentPage = page ?? 1;

            //DateTime FechaInicial = DateTime.Today.AddMonths(-9);
            //DateTime FechaFinal = DateTime.Today.AddDays(0); 

            var SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(Generales.sCadenaConexSQL(this.HttpContext.Session["BasePronto"].ToString()));
            var dt = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Clientes_TX_RetencionesSUSS", FechaInicial, FechaFinal, 2);
            IEnumerable<DataRow> Entidad = dt.AsEnumerable();

            int totalRecords = Entidad.Count();
            int totalPages = (int)Math.Ceiling((float)totalRecords / (float)pageSize);

            var data = (from a in Entidad
                        select new
                        {
                            IdAux = a[0],
                            IdRecibo = a[1],
                            IdCliente = a[2],
                            K_Registro = a[3],
                            CodigoCliente = a[4],
                            Cliente = a[5],
                            Cuit = a[6],
                            Fecha = a[7],
                            Comprobante = a[8],
                            NumeroCertificado = a[9],
                            RetencionSUSS1 = (a[10].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[10].NullSafeToString()),
                            RetencionSUSS2 = (a[11].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[11].NullSafeToString()),
                            RetencionSUSS3 = (a[12].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[12].NullSafeToString()),
                            RetencionSUSS4 = (a[13].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[13].NullSafeToString()),
                            RetencionSUSS5 = (a[14].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[14].NullSafeToString()),
                            RetencionSUSS6 = (a[15].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[15].NullSafeToString()),
                            RetencionSUSS7 = (a[16].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[16].NullSafeToString()),
                            RetencionSUSS8 = (a[17].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[17].NullSafeToString()),
                            RetencionSUSS9 = (a[18].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[18].NullSafeToString()),
                            RetencionSUSS10 = (a[19].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[19].NullSafeToString()),
                            RetencionSUSS = (a[20].NullSafeToString() == "") ? 0 : Convert.ToDecimal(a[20].NullSafeToString()),
                            Registro = a[21]
                        }).ToList();

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
                                a.IdRecibo.ToString(), 
                                a.IdCliente.ToString(), 
                                a.K_Registro.ToString(), 
                                a.CodigoCliente.ToString(), 
                                a.Cliente.ToString(), 
                                a.Cuit.ToString(), 
                                a.Fecha == null || a.Fecha.ToString() == "" ? "" : Convert.ToDateTime(a.Fecha.NullSafeToString()).ToString("dd/MM/yyyy"),
                                a.Comprobante.ToString(), 
                                a.NumeroCertificado.ToString(), 
                                a.RetencionSUSS.ToString(), 
                                a.Registro.ToString()
                            }
                        }).ToArray()
            };
            return Json(jsonData, JsonRequestBehavior.AllowGet);
        }

    }
}

