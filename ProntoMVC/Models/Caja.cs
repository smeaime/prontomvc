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
    [KnownType(typeof(Cuenta))]
    public partial class Caja
    {
        [DataMember]
        public int IdCaja { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public Nullable<int> IdCuenta { get; set; }
        [DataMember]
        public Nullable<int> IdMoneda { get; set; }
    
        [DataMember]
        public virtual Cuenta Cuenta { get; set; }
    }
    
}
