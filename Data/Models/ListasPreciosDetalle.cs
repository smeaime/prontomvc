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
    
    public partial class ListasPreciosDetalle
    {
        public int IdListaPreciosDetalle { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<decimal> Precio { get; set; }
        public Nullable<int> IdDestinoDeCartaDePorte_1 { get; set; }
        public Nullable<decimal> PrecioDescargaLocal_1 { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<decimal> Precio2 { get; set; }
        public Nullable<System.DateTime> FechaVigenciaHasta { get; set; }
        public Nullable<decimal> Precio4 { get; set; }
        public Nullable<decimal> Precio5 { get; set; }
        public Nullable<decimal> Precio6 { get; set; }
        public Nullable<decimal> Precio7 { get; set; }
        public Nullable<decimal> Precio8 { get; set; }
        public Nullable<decimal> Precio9 { get; set; }
        public Nullable<decimal> PrecioEmbarque2 { get; set; }
        public Nullable<decimal> MaximaCantidadParaPrecioEmbarque { get; set; }
        public Nullable<decimal> PrecioDescargaExportacion_ { get; set; }
        public Nullable<decimal> PrecioCaladaLocal_ { get; set; }
        public Nullable<decimal> PrecioCaladaExportacion__ { get; set; }
        public Nullable<decimal> PrecioRepetidoPeroConPrecision__ { get; set; }
    
        public virtual ListasPrecio ListasPrecio { get; set; }
        public virtual Articulo Articulo { get; set; }
    }
}
