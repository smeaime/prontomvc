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
    [KnownType(typeof(Concepto))]
    public partial class DetalleNotasCredito
    {
        [DataMember]
        public int IdDetalleNotaCredito { get; set; }
        [DataMember]
        public Nullable<int> IdNotaCredito { get; set; }
        [DataMember]
        public Nullable<int> IdConcepto { get; set; }
        [DataMember]
        public Nullable<decimal> Importe { get; set; }
        [DataMember]
        public string Gravado { get; set; }
        [DataMember]
        public Nullable<int> IdDiferenciaCambio { get; set; }
        [DataMember]
        public Nullable<decimal> IvaNoDiscriminado { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaBancaria { get; set; }
        [DataMember]
        public Nullable<int> IdCaja { get; set; }
    
        [DataMember]
        public virtual Concepto Concepto { get; set; }
    }
    
}
