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
    [KnownType(typeof(Cliente))]
    [KnownType(typeof(Proveedor))]
    [KnownType(typeof(DetalleClientesLugaresEntrega))]
    public partial class Localidad
    {
        public Localidad()
        {
            this.Clientes = new HashSet<Cliente>();
            this.Clientes1 = new HashSet<Cliente>();
            this.Proveedores = new HashSet<Proveedor>();
            this.DetalleClientesLugaresEntregas = new HashSet<DetalleClientesLugaresEntrega>();
        }
    
        [DataMember]
        public int IdLocalidad { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string CodigoPostal { get; set; }
        [DataMember]
        public Nullable<int> IdProvincia { get; set; }
        [DataMember]
        public Nullable<byte> EnviarEmail { get; set; }
        [DataMember]
        public string CodigoWilliams_1 { get; set; }
        [DataMember]
        public string CodigoLosGrobo_1 { get; set; }
        [DataMember]
        public string CodigoESRI { get; set; }
        [DataMember]
        public string CodigoONCAA__ { get; set; }
    
        [DataMember]
        public virtual ICollection<Cliente> Clientes { get; set; }
        [DataMember]
        public virtual ICollection<Cliente> Clientes1 { get; set; }
        [DataMember]
        public virtual ICollection<Proveedor> Proveedores { get; set; }
        [DataMember]
        public virtual ICollection<DetalleClientesLugaresEntrega> DetalleClientesLugaresEntregas { get; set; }
    }
    
}
