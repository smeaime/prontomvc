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
    
    public partial class DetalleAutorizacionesFirmante
    {
        public int IdDetalleAutorizacionFirmantes { get; set; }
        public Nullable<int> IdDetalleAutorizacion { get; set; }
        public Nullable<int> IdAutorizacion { get; set; }
        public Nullable<int> IdFirmante { get; set; }
        public Nullable<int> IdRubro { get; set; }
        public Nullable<int> IdSubrubro { get; set; }
        public string ParaTaller { get; set; }
        public Nullable<decimal> ImporteDesde { get; set; }
        public Nullable<decimal> ImporteHasta { get; set; }
        public Nullable<int> IdObra { get; set; }
    }
}
