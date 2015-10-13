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
    
    public partial class Valore
    {
        public Valore()
        {
            this.DetalleDepositosBancarios = new HashSet<DetalleDepositosBancario>();
            this.DetalleValoresCuentas = new HashSet<DetalleValoresCuenta>();
            this.DetalleValoresProvincias = new HashSet<DetalleValoresProvincia>();
            this.DetalleValoresRubrosContables = new HashSet<DetalleValoresRubrosContable>();
        }
    
        public int IdValor { get; set; }
        public Nullable<int> IdTipoValor { get; set; }
        public Nullable<decimal> NumeroValor { get; set; }
        public Nullable<System.DateTime> FechaValor { get; set; }
        public Nullable<int> NumeroInterno { get; set; }
        public Nullable<int> IdTipoComprobante { get; set; }
        public Nullable<int> NumeroComprobante { get; set; }
        public Nullable<System.DateTime> FechaComprobante { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<int> IdDetalleReciboValores { get; set; }
        public Nullable<int> IdBanco { get; set; }
        public Nullable<decimal> Importe { get; set; }
        public string Estado { get; set; }
        public Nullable<int> IdBancoDeposito { get; set; }
        public Nullable<int> NumeroDeposito { get; set; }
        public Nullable<System.DateTime> FechaDeposito { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public Nullable<int> NumeroOrdenPago { get; set; }
        public Nullable<System.DateTime> FechaOrdenPago { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> NumeroSalida { get; set; }
        public Nullable<System.DateTime> FechaSalida { get; set; }
        public Nullable<int> IdCuentaOrigen { get; set; }
        public Nullable<System.DateTime> FechaEntrada { get; set; }
        public string FechaEntradaActivada { get; set; }
        public string Conciliado { get; set; }
        public Nullable<int> IdCuentaBancaria { get; set; }
        public Nullable<int> IdCuentaBancariaDeposito { get; set; }
        public Nullable<decimal> Iva { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdCuentaGasto { get; set; }
        public Nullable<int> IdCuentaContable { get; set; }
        public Nullable<int> IdCuentaIVA { get; set; }
        public Nullable<decimal> PorcentajeIVA { get; set; }
        public Nullable<int> IdDetalleOrdenPagoCuentas { get; set; }
        public Nullable<int> IdCaja { get; set; }
        public Nullable<int> IdDetalleOrdenPagoValores { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<int> IdDetalleComprobanteProveedor { get; set; }
        public Nullable<int> IdDetalleAsiento { get; set; }
        public string CuitLibrador { get; set; }
        public Nullable<int> IdConciliacion { get; set; }
        public string Emitido { get; set; }
        public Nullable<System.DateTime> FechaEmision { get; set; }
        public Nullable<int> IdEmitio { get; set; }
        public Nullable<int> IdDetalleReciboCuentas { get; set; }
        public string MovimientoConfirmadoBanco { get; set; }
        public Nullable<System.DateTime> FechaConfirmacionBanco { get; set; }
        public Nullable<int> IdUsuarioConfirmacionBanco { get; set; }
        public Nullable<int> IdPlazoFijoInicio { get; set; }
        public Nullable<int> IdPlazoFijoFin { get; set; }
        public Nullable<System.DateTime> FechaGasto { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModifico { get; set; }
        public string Detalle { get; set; }
        public Nullable<int> IdDetalleNotaDebito { get; set; }
        public Nullable<int> IdDetalleNotaCredito { get; set; }
        public string RegistroContableChequeDiferido { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<int> IdValorOriginal { get; set; }
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        public Nullable<int> IdDetalleReciboValoresOriginal { get; set; }
        public string CuitClienteTransmision { get; set; }
        public string CertificadoRetencion { get; set; }
        public string AsientoManual { get; set; }
        public string Anulado { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public string Rechazado { get; set; }
        public Nullable<int> IdTarjetaCredito { get; set; }
        public string NumeroTarjetaCredito { get; set; }
        public Nullable<int> NumeroAutorizacionTarjetaCredito { get; set; }
        public Nullable<int> CantidadCuotas { get; set; }
        public string FechaExpiracionTarjetaCredito { get; set; }
        public Nullable<int> IdFactura { get; set; }
        public Nullable<int> IdDetallePresentacionTarjeta { get; set; }
        public Nullable<int> IdOrigen { get; set; }
        public string OrigenRegistro { get; set; }
        public Nullable<int> IdReciboAsignado { get; set; }
    
        public virtual Moneda Moneda { get; set; }
        public virtual TiposComprobante TiposComprobante { get; set; }
        public virtual TiposComprobante TiposComprobante1 { get; set; }
        public virtual Moneda Moneda1 { get; set; }
        public virtual ICollection<DetalleDepositosBancario> DetalleDepositosBancarios { get; set; }
        public virtual ICollection<DetalleValoresCuenta> DetalleValoresCuentas { get; set; }
        public virtual ICollection<DetalleValoresProvincia> DetalleValoresProvincias { get; set; }
        public virtual ICollection<DetalleValoresRubrosContable> DetalleValoresRubrosContables { get; set; }
    }
}
