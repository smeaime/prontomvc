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
    
    public partial class DetalleConciliacione
    {
        public int IdDetalleConciliacion { get; set; }
        public Nullable<int> IdConciliacion { get; set; }
        public Nullable<int> IdValor { get; set; }
        public string Conciliado { get; set; }
        public string Controlado { get; set; }
        public string ControladoNoConciliado { get; set; }
    
        public virtual Conciliacione Conciliacione { get; set; }
    }
}
