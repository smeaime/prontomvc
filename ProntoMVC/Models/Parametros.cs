//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Runtime.Serialization;


namespace ProntoMVC.Models
{
    [DataContract(IsReference = true)]
    public partial class Parametros
    {
        [DataMember]
        public int IdParametro { get; set; }
        [DataMember]
        public Nullable<int> ProximoPresupuesto { get; set; }
        [DataMember]
        public Nullable<decimal> Iva1 { get; set; }
        [DataMember]
        public Nullable<decimal> Iva2 { get; set; }
        [DataMember]
        public Nullable<int> ProximaListaAcopio { get; set; }
        [DataMember]
        public Nullable<int> ProximaListaMateriales { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroRequerimiento { get; set; }
        [DataMember]
        public Nullable<int> IdUnidadPorUnidad { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroAjusteStock { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroReservaStock { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroPedido { get; set; }
        [DataMember]
        public Nullable<int> ControlCalidadDefault { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroValeSalida { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMateriales { get; set; }
        [DataMember]
        public Nullable<int> ProximaComparativa { get; set; }
        [DataMember]
        public string PathAdjuntos { get; set; }
        [DataMember]
        public Nullable<int> IdUnidadPorKilo { get; set; }
        [DataMember]
        public string PedidosGarantia { get; set; }
        [DataMember]
        public string PedidosDocumentacion { get; set; }
        [DataMember]
        public string PedidosPlazoEntrega { get; set; }
        [DataMember]
        public string PedidosLugarEntrega { get; set; }
        [DataMember]
        public string PedidosFormaPago { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMaterialesAObra { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMaterialesParaFacturar { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMateriales2 { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMaterialesAObra2 { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMaterialesParaFacturar2 { get; set; }
        [DataMember]
        public string PedidosInspecciones { get; set; }
        [DataMember]
        public string PedidosImportante { get; set; }
        [DataMember]
        public string PathEnvioEmails { get; set; }
        [DataMember]
        public string PathRecepcionEmails { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMaterialesAProveedor { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSalidaMaterialesAProveedor2 { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroDevolucionDeFabrica { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroDevolucionDeFabrica2 { get; set; }
        [DataMember]
        public string ArchivoAyuda { get; set; }
        [DataMember]
        public string PathArchivoExcelDatanet { get; set; }
        [DataMember]
        public string PathArchivoExcelProveedores { get; set; }
        [DataMember]
        public Nullable<decimal> Porc_IBrutos_Cap { get; set; }
        [DataMember]
        public Nullable<decimal> Tope_IBrutos_Cap { get; set; }
        [DataMember]
        public Nullable<decimal> Porc_IBrutos_BsAs { get; set; }
        [DataMember]
        public Nullable<decimal> Tope_IBrutos_BsAs { get; set; }
        [DataMember]
        public Nullable<decimal> Porc_IBrutos_BsAsM { get; set; }
        [DataMember]
        public Nullable<decimal> Tope_IBrutos_BsAsM { get; set; }
        [DataMember]
        public Nullable<short> Decimales { get; set; }
        [DataMember]
        public string AclaracionAlPieDeFactura { get; set; }
        [DataMember]
        public Nullable<decimal> CotizacionDolar { get; set; }
        [DataMember]
        public Nullable<int> ProximoAsiento { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroInterno { get; set; }
        [DataMember]
        public string NumeracionUnica { get; set; }
        [DataMember]
        public Nullable<int> EjercicioActual { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaVentas { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaBonificaciones { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaInscripto { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaNoInscripto { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaSinDiscriminar { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionIBrutosBsAs { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionIBrutosCap { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaReventas { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaND { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaNC { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaCaja { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaValores { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionIva { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionGanancias { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionIBrutos { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaDescuentos { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaDescuentosyRetenciones { get; set; }
        [DataMember]
        public Nullable<int> IdUnidad { get; set; }
        [DataMember]
        public Nullable<int> IdMoneda { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaCompras { get; set; }
        [DataMember]
        public Nullable<int> ProximoComprobanteProveedorReferencia { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroInternoChequeEmitido { get; set; }
        [DataMember]
        public Nullable<int> ProximaNumeroOrdenPago { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras { get; set; }
        [DataMember]
        public string CAI { get; set; }
        [DataMember]
        public string FechaCAI { get; set; }
        [DataMember]
        public string ClausulaDolar { get; set; }
        [DataMember]
        public Nullable<int> IdMonedaDolar { get; set; }
        [DataMember]
        public string NumeroCAI_R_A { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_R_A { get; set; }
        [DataMember]
        public string NumeroCAI_F_A { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_F_A { get; set; }
        [DataMember]
        public string NumeroCAI_D_A { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_D_A { get; set; }
        [DataMember]
        public string NumeroCAI_C_A { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_C_A { get; set; }
        [DataMember]
        public string NumeroCAI_R_B { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_R_B { get; set; }
        [DataMember]
        public string NumeroCAI_F_B { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_F_B { get; set; }
        [DataMember]
        public string NumeroCAI_D_B { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_D_B { get; set; }
        [DataMember]
        public string NumeroCAI_C_B { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_C_B { get; set; }
        [DataMember]
        public string NumeroCAI_R_E { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_R_E { get; set; }
        [DataMember]
        public string NumeroCAI_F_E { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_F_E { get; set; }
        [DataMember]
        public string NumeroCAI_D_E { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_D_E { get; set; }
        [DataMember]
        public string NumeroCAI_C_E { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCAI_C_E { get; set; }
        [DataMember]
        public string NumeracionCorrelativa { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroRefProveedores { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroCuentaContable { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAcreedoresVarios { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaDeudoresVarios { get; set; }
        [DataMember]
        public Nullable<int> ProximaOrdenPago { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras1 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras2 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje2 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras3 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje3 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras4 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje4 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras5 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje5 { get; set; }
        [DataMember]
        public Nullable<int> ProximaOrdenPagoExterior { get; set; }
        [DataMember]
        public Nullable<decimal> MinimoNoImponible { get; set; }
        [DataMember]
        public Nullable<decimal> DeduccionEspecial { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroCertificadoRetencionGanancias { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaVentasTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaNDTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaNCTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaCajaTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaValoresTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaDescuentosyRetencionesTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaComprasTitulo { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras6 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje6 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras7 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje7 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras8 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje8 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras9 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje9 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaCompras10 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAComprasPorcentaje10 { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroOrdenCompra { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroRemito { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionGananciasCobros { get; set; }
        [DataMember]
        public Nullable<int> IdTipoCuentaGrupoIVA { get; set; }
        [DataMember]
        public Nullable<int> IGCondicionExcepcion { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaVentas1 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAVentasPorcentaje1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaVentas2 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAVentasPorcentaje2 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaVentas3 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAVentasPorcentaje3 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaIvaVentas4 { get; set; }
        [DataMember]
        public Nullable<decimal> IVAVentasPorcentaje4 { get; set; }
        [DataMember]
        public Nullable<int> ProximaOrdenPagoOtros { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteEfectivo { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteDeposito { get; set; }
        [DataMember]
        public Nullable<int> ProximaNotaDebitoInterna { get; set; }
        [DataMember]
        public Nullable<int> ProximaNotaCreditoInterna { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteCajaIngresos { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteCajaEgresos { get; set; }
        [DataMember]
        public string DirectorioDTS { get; set; }
        [DataMember]
        public string PathObra { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaUltimoCierre { get; set; }
        [DataMember]
        public Nullable<int> IdConceptoDiferenciaCambio { get; set; }
        [DataMember]
        public Nullable<int> IdTipoCuentaGrupoFF { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroOtroIngresoAlmacen { get; set; }
        [DataMember]
        public string AgenteRetencionIVA { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteTotalMinimoAplicacionRetencionIVA { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeBaseRetencionIVABienes { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeBaseRetencionIVAServicios { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteMinimoRetencionIVA { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroCertificadoRetencionIVA { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroCertificadoRetencionIIBB { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteFacturaCompra { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteFacturaVenta { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteDevoluciones { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteNotaDebito { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteNotaCredito { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteRecibo { get; set; }
        [DataMember]
        public Nullable<int> IdControlCalidadStandar { get; set; }
        [DataMember]
        public Nullable<int> IdTipoCuentaGrupoAnticiposAlPersonal { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteNDInternaAcreedores { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteNCInternaAcreedores { get; set; }
        [DataMember]
        public string PercepcionIIBB { get; set; }
        [DataMember]
        public string OtrasPercepciones1 { get; set; }
        [DataMember]
        public string OtrasPercepciones1Desc { get; set; }
        [DataMember]
        public string OtrasPercepciones2 { get; set; }
        [DataMember]
        public string OtrasPercepciones2Desc { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaDiferenciaCambio { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroReciboPago { get; set; }
        [DataMember]
        public string NumeroReciboPagoAutomatico { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaPercepcionIIBB { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaOtrasPercepciones1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaOtrasPercepciones2 { get; set; }
        [DataMember]
        public string ConfirmarClausulaDolar { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroPedidoExterior { get; set; }
        [DataMember]
        public string ExigirTrasabilidad_RMLA_PE { get; set; }
        [DataMember]
        public string AgenteRetencionSUSS { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeRetencionSUSS { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroCertificadoRetencionSUSS { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionSUSS { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaPercepcionIVACompras { get; set; }
        [DataMember]
        public Nullable<int> IdPuntoVentaNumeracionUnica { get; set; }
        [DataMember]
        public string AgenteRetencionIIBB { get; set; }
        [DataMember]
        public string PathArchivosExportados { get; set; }
        [DataMember]
        public Nullable<int> IdObraStockDisponible { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteOrdenPago { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroInternoRecepcion { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionSUSS_Recibida { get; set; }
        [DataMember]
        public string Plantilla_Factura_A { get; set; }
        [DataMember]
        public string Plantilla_Factura_B { get; set; }
        [DataMember]
        public string Plantilla_Factura_E { get; set; }
        [DataMember]
        public string Plantilla_Devoluciones_A { get; set; }
        [DataMember]
        public string Plantilla_Devoluciones_B { get; set; }
        [DataMember]
        public string Plantilla_Devoluciones_E { get; set; }
        [DataMember]
        public string Plantilla_NotasDebito_A { get; set; }
        [DataMember]
        public string Plantilla_NotasDebito_B { get; set; }
        [DataMember]
        public string Plantilla_NotasDebito_E { get; set; }
        [DataMember]
        public string Plantilla_NotasCredito_A { get; set; }
        [DataMember]
        public string Plantilla_NotasCredito_B { get; set; }
        [DataMember]
        public string Plantilla_NotasCredito_E { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaArranqueCajaYBancos { get; set; }
        [DataMember]
        public Nullable<int> IdRubroVentasEnCuotas { get; set; }
        [DataMember]
        public Nullable<int> IdConceptoVentasEnCuotas { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaPlazosFijos { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaInteresesPlazosFijos { get; set; }
        [DataMember]
        public Nullable<int> NumeroGeneracionVentaEnCuotas { get; set; }
        [DataMember]
        public Nullable<int> IdBancoGestionCobroCuotas { get; set; }
        [DataMember]
        public string PathArchivoCobranzaCuotas { get; set; }
        [DataMember]
        public string TipoAmortizacionContable { get; set; }
        [DataMember]
        public string FrecuenciaAmortizacionContable { get; set; }
        [DataMember]
        public string TipoAmortizacionImpositiva { get; set; }
        [DataMember]
        public string FrecuenciaAmortizacionImpositiva { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaResultadosEjercicio { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaResultadosAcumulados { get; set; }
        [DataMember]
        public Nullable<int> CuentasResultadoDesde { get; set; }
        [DataMember]
        public Nullable<int> CuentasResultadoHasta { get; set; }
        [DataMember]
        public Nullable<int> CuentasPatrimonialesDesde { get; set; }
        [DataMember]
        public Nullable<int> CuentasPatrimonialesHasta { get; set; }
        [DataMember]
        public Nullable<int> IdArticuloVariosParaPRESTO { get; set; }
        [DataMember]
        public string ControlarRubrosContablesEnOP { get; set; }
        [DataMember]
        public Nullable<int> IdObraActiva { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAdicionalIVACompras1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAdicionalIVACompras2 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAdicionalIVACompras3 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAdicionalIVACompras4 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAdicionalIVACompras5 { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaUltimoCierreEjercicio { get; set; }
        [DataMember]
        public string EmiteAsientoEnOP { get; set; }
        [DataMember]
        public Nullable<int> IdMonedaEuro { get; set; }
        [DataMember]
        public Nullable<int> LineasDiarioDetallado { get; set; }
        [DataMember]
        public Nullable<int> LineasDiarioResumido { get; set; }
        [DataMember]
        public string PathEnvioEmailsMANTENIMIENTO { get; set; }
        [DataMember]
        public string PathRecepcionEmailsMANTENIMIENTO { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteComprobantesMParaRetencionIVA { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeRetencionIVAComprobantesM { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteComprobantesMParaRetencionGanancias { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeRetencionGananciasComprobantesM { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteFacturaCompraExportacion { get; set; }
        [DataMember]
        public string IvaCompras_DesglosarNOGRAVADOS { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaImpuestosInternos { get; set; }
        [DataMember]
        public string Subdiarios_ResumirRegistros { get; set; }
        [DataMember]
        public Nullable<int> IdCajaEnPesosDefault { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroGastoBancario { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroSolicitudCompra { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaReintegros { get; set; }
        [DataMember]
        public Nullable<int> IdArticuloPRONTO_MANTENIMIENTO { get; set; }
        [DataMember]
        public Nullable<int> ProximoCodigoArticulo { get; set; }
        [DataMember]
        public byte[] FechaTimeStamp { get; set; }
        [DataMember]
        public string PathPlantillas { get; set; }
        [DataMember]
        public string OtrasPercepciones3 { get; set; }
        [DataMember]
        public string OtrasPercepciones3Desc { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaOtrasPercepciones3 { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaArranqueMovimientosStock { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaRetencionIvaComprobantesM { get; set; }
        [DataMember]
        public Nullable<int> IdJefeCompras { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteMinimoRetencionIVAServicios { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaPercepcionesIVA { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaREI_Ganancia { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaREI_Perdida { get; set; }
        [DataMember]
        public string ActivarCircuitoChequesDiferidos { get; set; }
        [DataMember]
        public string BasePRONTOSyJAsociada { get; set; }
        [DataMember]
        public Nullable<int> IdConceptoAnticiposSyJ { get; set; }
        [DataMember]
        public Nullable<int> IdConceptoRecuperoGastos { get; set; }
        [DataMember]
        public string BasePRONTOConsolidacion { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeConsolidacion { get; set; }
        [DataMember]
        public string BasePRONTOConsolidacion2 { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeConsolidacion2 { get; set; }
        [DataMember]
        public string BasePRONTOConsolidacion3 { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeConsolidacion3 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaAjusteConsolidacion { get; set; }
        [DataMember]
        public string PathImportacionDatos { get; set; }
        [DataMember]
        public string ActivarSolicitudMateriales { get; set; }
        [DataMember]
        public Nullable<decimal> TopeMinimoRetencionIVA { get; set; }
        [DataMember]
        public Nullable<decimal> TopeMinimoRetencionIVAServicios { get; set; }
        [DataMember]
        public Nullable<int> IdMonedaPrincipal { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComprobanteTarjetaCredito { get; set; }
        [DataMember]
        public Nullable<int> ProximoNumeroOrdenTrabajo { get; set; }
        [DataMember]
        public string BasePRONTOMantenimiento { get; set; }
        [DataMember]
        public Nullable<int> ProximaOrdenPagoFF { get; set; }
    }
    
}
