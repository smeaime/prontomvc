//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProntoMVC.Data.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class Factura
    {
        public Factura()
        {
            this.DetalleFacturas = new HashSet<DetalleFactura>();
            this.DetalleFacturasOrdenesCompras = new HashSet<DetalleFacturasOrdenesCompra>();
            this.DetalleFacturasProvincias = new HashSet<DetalleFacturasProvincia>();
            this.DetalleFacturasRemitos = new HashSet<DetalleFacturasRemito>();
        }
    
        public int IdFactura { get; set; }
        public Nullable<int> NumeroFactura { get; set; }
        public string TipoABC { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<System.DateTime> FechaFactura { get; set; }
        public Nullable<short> IdCondicionVenta { get; set; }
        public Nullable<int> IdVendedor { get; set; }
        public Nullable<byte> IdTransportista1 { get; set; }
        public Nullable<byte> IdTransportista2 { get; set; }
        public Nullable<byte> ItemDireccion { get; set; }
        public string OrdenCompra { get; set; }
        public string TipoPedidoConsignacion { get; set; }
        public string Anulada { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> IdRemito { get; set; }
        public Nullable<int> NumeroRemito { get; set; }
        public Nullable<int> IdPedido { get; set; }
        public Nullable<int> NumeroPedido { get; set; }
        public Nullable<decimal> ImporteTotal { get; set; }
        public Nullable<decimal> ImporteIva1 { get; set; }
        public Nullable<decimal> ImporteIva2 { get; set; }
        public Nullable<decimal> ImporteBonificacion { get; set; }
        public Nullable<decimal> RetencionIBrutos1 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos1 { get; set; }
        public Nullable<decimal> RetencionIBrutos2 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos2 { get; set; }
        public string ConvenioMultilateral { get; set; }
        public Nullable<decimal> RetencionIBrutos3 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos3 { get; set; }
        public Nullable<short> IdTipoVentaC { get; set; }
        public Nullable<decimal> ImporteIvaIncluido { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public string EsMuestra { get; set; }
        public Nullable<decimal> CotizacionADolarFijo { get; set; }
        public Nullable<decimal> ImporteParteEnDolares { get; set; }
        public Nullable<decimal> ImporteParteEnPesos { get; set; }
        public Nullable<decimal> PorcentajeIva1 { get; set; }
        public Nullable<decimal> PorcentajeIva2 { get; set; }
        public Nullable<System.DateTime> FechaVencimiento { get; set; }
        public Nullable<decimal> IVANoDiscriminado { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public Nullable<decimal> OtrasPercepciones1 { get; set; }
        public string OtrasPercepciones1Desc { get; set; }
        public Nullable<decimal> OtrasPercepciones2 { get; set; }
        public string OtrasPercepciones2Desc { get; set; }
        public Nullable<int> IdProvinciaDestino { get; set; }
        public Nullable<int> IdIBCondicion { get; set; }
        public Nullable<int> IdAutorizaAnulacion { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public Nullable<decimal> NumeroCAI { get; set; }
        public Nullable<System.DateTime> FechaVencimientoCAI { get; set; }
        public Nullable<int> NumeroCertificadoPercepcionIIBB { get; set; }
        public Nullable<int> NumeroTicketInicial { get; set; }
        public Nullable<int> NumeroTicketFinal { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdIBCondicion2 { get; set; }
        public Nullable<int> IdIBCondicion3 { get; set; }
        public Nullable<int> IdCodigoIva { get; set; }
        public Nullable<decimal> Exportacion_FOB { get; set; }
        public string Exportacion_PosicionAduana { get; set; }
        public string Exportacion_Despacho { get; set; }
        public string Exportacion_Guia { get; set; }
        public Nullable<int> Exportacion_IdPaisDestino { get; set; }
        public Nullable<System.DateTime> Exportacion_FechaEmbarque { get; set; }
        public Nullable<System.DateTime> Exportacion_FechaOficializacion { get; set; }
        public Nullable<decimal> OtrasPercepciones3 { get; set; }
        public string OtrasPercepciones3Desc { get; set; }
        public string NoIncluirEnCubos { get; set; }
        public Nullable<decimal> PercepcionIVA { get; set; }
        public Nullable<decimal> PorcentajePercepcionIVA { get; set; }
        public string ActivarRecuperoGastos { get; set; }
        public Nullable<int> IdAutorizoRecuperoGastos { get; set; }
        public string ContabilizarAFechaVencimiento { get; set; }
        public string FacturaContado { get; set; }
        public Nullable<int> IdReciboContado { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<int> IdFacturaOriginal { get; set; }
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        public string CuitClienteTransmision { get; set; }
        public Nullable<int> IdReciboContadoOriginal { get; set; }
        public string DevolucionAnticipo { get; set; }
        public Nullable<decimal> PorcentajeDevolucionAnticipo { get; set; }
        public string CAE { get; set; }
        public string RechazoCAE { get; set; }
        public Nullable<System.DateTime> FechaVencimientoORechazoCAE { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdIdentificacionCAE { get; set; }
        public Nullable<decimal> AjusteIva { get; set; }
        public Nullable<int> TipoExportacion { get; set; }
        public string PermisoEmbarque { get; set; }
        public Nullable<int> NumeroFacturaInicial { get; set; }
        public Nullable<int> NumeroFacturaFinal { get; set; }
        public Nullable<int> CodigoIdAuxiliar { get; set; }
        public Nullable<int> NumeroCertificadoObra { get; set; }
        public Nullable<decimal> ImporteCertificacionObra { get; set; }
        public Nullable<decimal> FondoReparoCertificacionObra { get; set; }
        public Nullable<decimal> PorcentajeRetencionesEstimadasCertificacionObra { get; set; }
        public string NumeroExpedienteCertificacionObra { get; set; }
        public Nullable<int> NumeroProyecto { get; set; }
        public Nullable<int> IdCertificacionObras { get; set; }
        public Nullable<int> IdCertificacionObraDatos { get; set; }
        public Nullable<System.DateTime> FechaRecepcionCliente { get; set; }
        public string CuentaVentaLetra { get; set; }
        public Nullable<int> CuentaVentaPuntoVenta { get; set; }
        public Nullable<int> CuentaVentaNumero { get; set; }
        public Nullable<int> IdDeposito { get; set; }
        public string Cliente_1 { get; set; }
        public string OrigenRegistro { get; set; }
        public Nullable<int> TotalBultos { get; set; }
        public Nullable<int> IdDetalleClienteLugarEntrega { get; set; }
        public string CuitClienteExterno { get; set; }
        public Nullable<decimal> ComisionDiferenciada { get; set; }
        public Nullable<int> IdTipoNegocioVentas { get; set; }
        public Nullable<int> NumeroOrdenCompraExterna { get; set; }
        public Nullable<int> IdTipoOperacion { get; set; }
        public string FueEnviadoCorreoConFacturaElectronica { get; set; }
    
        public virtual Cliente Cliente { get; set; }
        public virtual Moneda Moneda { get; set; }
        public virtual ICollection<DetalleFactura> DetalleFacturas { get; set; }
        public virtual Vendedor Vendedore { get; set; }
        public virtual Obra Obra { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual PuntosVenta PuntosVenta { get; set; }
        public virtual ICollection<DetalleFacturasOrdenesCompra> DetalleFacturasOrdenesCompras { get; set; }
        public virtual ICollection<DetalleFacturasProvincia> DetalleFacturasProvincias { get; set; }
        public virtual ICollection<DetalleFacturasRemito> DetalleFacturasRemitos { get; set; }
    }
}
