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
    [KnownType(typeof(Proveedor))]
    public partial class DetalleProveedor
    {
        [DataMember]
        public int IdDetalleProveedor { get; set; }
        [DataMember]
        public Nullable<int> IdProveedor { get; set; }
        [DataMember]
        public string Contacto { get; set; }
        [DataMember]
        public string Puesto { get; set; }
        [DataMember]
        public string Telefono { get; set; }
        [DataMember]
        public string Email { get; set; }
    
        [DataMember]
        public virtual Proveedor Proveedor { get; set; }
    }
    
}
