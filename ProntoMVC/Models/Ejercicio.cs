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
    public partial class Ejercicio
    {
        [DataMember]
        public int IdEjercicio { get; set; }
        [DataMember]
        public Nullable<int> Ejercicio1 { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta { get; set; }
        [DataMember]
        public Nullable<decimal> SaldoDebe { get; set; }
        [DataMember]
        public Nullable<decimal> SaldoHaber { get; set; }
    }
    
}
