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
    
    public partial class DetalleOrdenesCompra
    {
        public DetalleOrdenesCompra()
        {
            this.DetalleRemitos = new HashSet<DetalleRemito>();
        }
    
        public int IdDetalleOrdenCompra { get; set; }
        public Nullable<int> IdOrdenCompra { get; set; }
        public Nullable<int> NumeroItem { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<decimal> Precio { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> OrigenDescripcion { get; set; }
        public Nullable<int> TipoCancelacion { get; set; }
        public string Cumplido { get; set; }
        public string FacturacionAutomatica { get; set; }
        public Nullable<System.DateTime> FechaComienzoFacturacion { get; set; }
        public Nullable<int> CantidadMesesAFacturar { get; set; }
        public string FacturacionCompletaMensual { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public Nullable<int> IdDetalleObraDestino { get; set; }
        public Nullable<System.DateTime> FechaNecesidad { get; set; }
        public Nullable<System.DateTime> FechaEntrega { get; set; }
        public Nullable<int> IdColor { get; set; }
        public Nullable<int> IdDioPorCumplido { get; set; }
        public Nullable<System.DateTime> FechaDadoPorCumplido { get; set; }
        public string ObservacionesCumplido { get; set; }
        public string Estado { get; set; }
        public Nullable<int> IdUsuarioCambioEstado { get; set; }
        public Nullable<System.DateTime> FechaCambioEstado { get; set; }
    
        public virtual Articulo Articulo { get; set; }
        public virtual OrdenesCompra OrdenesCompra { get; set; }
        public virtual Unidad Unidade { get; set; }
        public virtual ICollection<DetalleRemito> DetalleRemitos { get; set; }
    }
}
