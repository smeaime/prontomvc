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
    
    public partial class DetalleNotasDebito
    {
        public int IdDetalleNotaDebito { get; set; }
        public Nullable<int> IdNotaDebito { get; set; }
        public Nullable<int> IdConcepto { get; set; }
        public Nullable<decimal> Importe { get; set; }
        public string Gravado { get; set; }
        public Nullable<int> IdDiferenciaCambio { get; set; }
        public Nullable<decimal> IvaNoDiscriminado { get; set; }
        public Nullable<int> IdCuentaBancaria { get; set; }
        public Nullable<int> IdCaja { get; set; }
        public Nullable<decimal> PorcentajeIva { get; set; }
        public Nullable<decimal> ImporteIva { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> OrigenDescripcion { get; set; }
    
        public virtual Concepto Concepto { get; set; }
        public virtual NotasDebito NotasDebito { get; set; }
    }
}
