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
    
    public partial class DetalleAsiento
    {
        public int IdDetalleAsiento { get; set; }
        public Nullable<int> IdAsiento { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdTipoComprobante { get; set; }
        public Nullable<int> NumeroComprobante { get; set; }
        public Nullable<System.DateTime> FechaComprobante { get; set; }
        public string Libro { get; set; }
        public string Signo { get; set; }
        public string TipoImporte { get; set; }
        public string Cuit { get; set; }
        public string Detalle { get; set; }
        public Nullable<decimal> Debe { get; set; }
        public Nullable<decimal> Haber { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdCuentaGasto { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<int> IdCuentaBancaria { get; set; }
        public Nullable<int> IdCaja { get; set; }
        public Nullable<int> IdMonedaDestino { get; set; }
        public Nullable<decimal> CotizacionMonedaDestino { get; set; }
        public Nullable<decimal> ImporteEnMonedaDestino { get; set; }
        public Nullable<decimal> PorcentajeIVA { get; set; }
        public string RegistrarEnAnalitico { get; set; }
        public Nullable<int> Item { get; set; }
        public Nullable<int> IdValor { get; set; }
        public Nullable<int> IdProvinciaDestino { get; set; }
        public Nullable<int> IdDetalleComprobanteProveedor { get; set; }
        public Nullable<int> IdEntidadOrigen { get; set; }
    
        public virtual Asiento Asiento { get; set; }
        public virtual Cuenta Cuenta { get; set; }
        public virtual Moneda Moneda { get; set; }
        public virtual Moneda Moneda1 { get; set; }
        public virtual Obra Obra { get; set; }
    }
}
