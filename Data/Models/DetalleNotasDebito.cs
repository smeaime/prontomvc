//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
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
    
        public virtual Concepto Concepto { get; set; }
        public virtual NotasDebito NotasDebito { get; set; }
    }
}
