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
    public partial class DetalleFacturasProvincia
    {
        [DataMember]
        public int IdDetalleFacturaProvincias { get; set; }
        [DataMember]
        public Nullable<int> IdFactura { get; set; }
        [DataMember]
        public Nullable<int> IdProvinciaDestino { get; set; }
        [DataMember]
        public Nullable<decimal> Porcentaje { get; set; }
        [DataMember]
        public Nullable<byte> EnviarEmail { get; set; }
    }
    
}
