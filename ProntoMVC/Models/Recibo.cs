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
    [KnownType(typeof(DetalleRecibo))]
    [KnownType(typeof(DetalleRecibosCuenta))]
    [KnownType(typeof(DetalleRecibosRubrosContable))]
    [KnownType(typeof(DetalleRecibosValore))]
    [KnownType(typeof(Cliente))]
    public partial class Recibo
    {
        public Recibo()
        {
            this.DetalleRecibos = new HashSet<DetalleRecibo>();
            this.DetalleRecibosCuentas = new HashSet<DetalleRecibosCuenta>();
            this.DetalleRecibosRubrosContables = new HashSet<DetalleRecibosRubrosContable>();
            this.DetalleRecibosValores = new HashSet<DetalleRecibosValore>();
        }
    
        [DataMember]
        public int IdRecibo { get; set; }
        [DataMember]
        public Nullable<int> NumeroRecibo { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaRecibo { get; set; }
        [DataMember]
        public Nullable<int> IdCliente { get; set; }
        [DataMember]
        public Nullable<decimal> Efectivo { get; set; }
        [DataMember]
        public Nullable<decimal> Descuentos { get; set; }
        [DataMember]
        public Nullable<decimal> Valores { get; set; }
        [DataMember]
        public Nullable<decimal> Documentos { get; set; }
        [DataMember]
        public Nullable<decimal> Otros1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta1 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros2 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta2 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros3 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta3 { get; set; }
        [DataMember]
        public Nullable<decimal> Deudores { get; set; }
        [DataMember]
        public Nullable<decimal> RetencionIVA { get; set; }
        [DataMember]
        public Nullable<decimal> RetencionGanancias { get; set; }
        [DataMember]
        public Nullable<decimal> RetencionIBrutos { get; set; }
        [DataMember]
        public Nullable<decimal> GastosGenerales { get; set; }
        [DataMember]
        public Nullable<decimal> Cotizacion { get; set; }
        [DataMember]
        public string Observaciones { get; set; }
        [DataMember]
        public Nullable<int> IdMoneda { get; set; }
        [DataMember]
        public string Dolarizada { get; set; }
        [DataMember]
        public Nullable<int> IdObra1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto1 { get; set; }
        [DataMember]
        public Nullable<int> IdObra2 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto2 { get; set; }
        [DataMember]
        public Nullable<int> IdObra3 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto3 { get; set; }
        [DataMember]
        public Nullable<int> IdObra4 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto4 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta4 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros4 { get; set; }
        [DataMember]
        public Nullable<int> IdObra5 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto5 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta5 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros5 { get; set; }
        [DataMember]
        public string Tipo { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta { get; set; }
        [DataMember]
        public string AsientoManual { get; set; }
        [DataMember]
        public Nullable<int> IdObra { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto { get; set; }
        [DataMember]
        public Nullable<int> NumeroCertificadoRetencionGanancias { get; set; }
        [DataMember]
        public Nullable<int> NumeroCertificadoRetencionIVA { get; set; }
        [DataMember]
        public Nullable<int> NumeroCertificadoSUSS { get; set; }
        [DataMember]
        public Nullable<int> IdTipoRetencionGanancia { get; set; }
        [DataMember]
        public Nullable<decimal> CotizacionMoneda { get; set; }
        [DataMember]
        public Nullable<int> NumeroCertificadoRetencionIngresosBrutos { get; set; }
        [DataMember]
        public string Anulado { get; set; }
        [DataMember]
        public Nullable<int> PuntoVenta { get; set; }
        [DataMember]
        public Nullable<int> IdPuntoVenta { get; set; }
        [DataMember]
        public Nullable<int> IdUsuarioIngreso { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        [DataMember]
        public Nullable<int> IdUsuarioModifico { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaModifico { get; set; }
        [DataMember]
        public Nullable<int> IdCobrador { get; set; }
        [DataMember]
        public Nullable<int> IdVendedor { get; set; }
        [DataMember]
        public Nullable<int> Lote { get; set; }
        [DataMember]
        public Nullable<int> Sublote { get; set; }
        [DataMember]
        public Nullable<int> IdCodigoIvaOpcional { get; set; }
        [DataMember]
        public Nullable<int> TipoOperacionOtros { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaLote { get; set; }
        [DataMember]
        public string CuitOpcional { get; set; }
        [DataMember]
        public Nullable<int> IdComprobanteProveedorReintegro { get; set; }
        [DataMember]
        public Nullable<int> IdObra6 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto6 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta6 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros6 { get; set; }
        [DataMember]
        public Nullable<int> IdObra7 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto7 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta7 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros7 { get; set; }
        [DataMember]
        public Nullable<int> IdObra8 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto8 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta8 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros8 { get; set; }
        [DataMember]
        public Nullable<int> IdObra9 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto9 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta9 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros9 { get; set; }
        [DataMember]
        public Nullable<int> IdObra10 { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaGasto10 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta10 { get; set; }
        [DataMember]
        public Nullable<decimal> Otros10 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante1 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante2 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante3 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante4 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante5 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante6 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante7 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante8 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante9 { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante10 { get; set; }
        [DataMember]
        public Nullable<byte> EnviarEmail { get; set; }
        [DataMember]
        public Nullable<int> IdOrigenTransmision { get; set; }
        [DataMember]
        public Nullable<int> IdReciboOriginal { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        [DataMember]
        public string CuitClienteTransmision { get; set; }
        [DataMember]
        public Nullable<int> IdProvinciaDestino { get; set; }
        [DataMember]
        public string ServicioCobro { get; set; }
        [DataMember]
        public string LoteServicioCobro { get; set; }
        [DataMember]
        public Nullable<int> IdFacturaDirecta { get; set; }
    
        [DataMember]
        public virtual ICollection<DetalleRecibo> DetalleRecibos { get; set; }
        [DataMember]
        public virtual ICollection<DetalleRecibosCuenta> DetalleRecibosCuentas { get; set; }
        [DataMember]
        public virtual ICollection<DetalleRecibosRubrosContable> DetalleRecibosRubrosContables { get; set; }
        [DataMember]
        public virtual ICollection<DetalleRecibosValore> DetalleRecibosValores { get; set; }
        [DataMember]
        public virtual Cliente Cliente { get; set; }
    }
    
}
