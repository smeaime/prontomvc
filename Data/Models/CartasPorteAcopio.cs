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
    
    public partial class CartasPorteAcopio
    {
        public CartasPorteAcopio()
        {
            this.CartasDePortes = new HashSet<CartasDePorte>();
        }
    
        public int IdAcopio { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdCliente { get; set; }
    
        public virtual ICollection<CartasDePorte> CartasDePortes { get; set; }
        public virtual Cliente Cliente { get; set; }
    }
}
