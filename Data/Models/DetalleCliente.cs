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
    
    public partial class DetalleCliente
    {
        public int IdDetalleCliente { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public string Contacto { get; set; }
        public string Puesto { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Acciones { get; set; }
    
        public virtual Cliente Cliente { get; set; }
    }
}
