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
    
    public partial class DetalleArticulosActivosFijo
    {
        public int IdDetalleArticuloActivosFijos { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<System.DateTime> Fecha { get; set; }
        public string TipoConcepto { get; set; }
        public string Detalle { get; set; }
        public Nullable<int> ModificacionVidaUtilImpositiva { get; set; }
        public Nullable<int> ModificacionVidaUtilContable { get; set; }
        public Nullable<decimal> Importe { get; set; }
        public Nullable<int> IdRevaluo { get; set; }
        public Nullable<decimal> ImporteRevaluo { get; set; }
        public Nullable<int> VidaUtilRevaluo { get; set; }
    }
}
