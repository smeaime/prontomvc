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
    
    public partial class DetalleDepositosBancario
    {
        public int IdDetalleDepositoBancario { get; set; }
        public Nullable<int> IdDepositoBancario { get; set; }
        public Nullable<int> IdValor { get; set; }
    
        public virtual DepositosBancario DepositosBancario { get; set; }
        public virtual Valore Valore { get; set; }
    }
}
