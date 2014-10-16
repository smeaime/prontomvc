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
    public partial class CuentasGasto
    {
        public CuentasGasto()
        {
            this.Cuentas = new HashSet<Cuenta>();
        }
    
        [DataMember]
        public int IdCuentaGasto { get; set; }
        [DataMember]
        public Nullable<int> CodigoSubcuenta { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public Nullable<int> IdRubroContable { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaMadre { get; set; }
        [DataMember]
        public string Activa { get; set; }
        [DataMember]
        public string Codigo { get; set; }
        [DataMember]
        public string CodigoDestino { get; set; }
        [DataMember]
        public string Titulo { get; set; }
        [DataMember]
        public Nullable<int> Nivel { get; set; }
    
        [DataMember]
        public virtual ICollection<Cuenta> Cuentas { get; set; }
    }
    
}
