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
    public partial class DetalleAutorizacionesFirmante
    {
        [DataMember]
        public int IdDetalleAutorizacionFirmantes { get; set; }
        [DataMember]
        public Nullable<int> IdDetalleAutorizacion { get; set; }
        [DataMember]
        public Nullable<int> IdAutorizacion { get; set; }
        [DataMember]
        public Nullable<int> IdFirmante { get; set; }
        [DataMember]
        public Nullable<int> IdRubro { get; set; }
        [DataMember]
        public Nullable<int> IdSubrubro { get; set; }
        [DataMember]
        public string ParaTaller { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteDesde { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteHasta { get; set; }
    }
    
}
