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
    
    public partial class DetalleNotasCreditoImputacione
    {
        public int IdDetalleNotaCreditoImputaciones { get; set; }
        public Nullable<int> IdNotaCredito { get; set; }
        public Nullable<int> IdImputacion { get; set; }
        public Nullable<decimal> Importe { get; set; }
    
        public virtual NotasCredito NotasCredito { get; set; }
    }
}
