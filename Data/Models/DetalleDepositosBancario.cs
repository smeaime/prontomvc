//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
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
