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
    
    public partial class Caja
    {
        public int IdCaja { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdMoneda { get; set; }
    
        public virtual Cuenta Cuenta { get; set; }
    }
}
