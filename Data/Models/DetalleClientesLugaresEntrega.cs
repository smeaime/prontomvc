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
    
    public partial class DetalleClientesLugaresEntrega
    {
        public int IdDetalleClienteLugarEntrega { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public string DireccionEntrega { get; set; }
        public Nullable<int> IdLocalidadEntrega { get; set; }
        public Nullable<int> IdProvinciaEntrega { get; set; }
    
        public virtual Localidad Localidad { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual Cliente Cliente { get; set; }
    }
}
