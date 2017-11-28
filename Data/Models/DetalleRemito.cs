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
    
    public partial class DetalleRemito
    {
        public DetalleRemito()
        {
            this.DetalleFacturas = new HashSet<DetalleFactura>();
        }
    
        public int IdDetalleRemito { get; set; }
        public Nullable<int> IdRemito { get; set; }
        public Nullable<int> NumeroItem { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<decimal> Precio { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> PorcentajeCertificacion { get; set; }
        public Nullable<int> OrigenDescripcion { get; set; }
        public Nullable<int> IdDetalleOrdenCompra { get; set; }
        public Nullable<int> TipoCancelacion { get; set; }
        public Nullable<int> IdUbicacion { get; set; }
        public Nullable<int> IdObra { get; set; }
        public string Partida { get; set; }
        public string DescargaPorKit { get; set; }
        public Nullable<int> NumeroCaja { get; set; }
        public string Talle { get; set; }
        public Nullable<int> IdColor { get; set; }
    
        public virtual Articulo Articulo { get; set; }
        public virtual Obra Obra { get; set; }
        public virtual Unidad Unidade { get; set; }
        public virtual Remito Remito { get; set; }
        public virtual Ubicacion Ubicacione { get; set; }
        public virtual DetalleOrdenesCompra DetalleOrdenesCompra { get; set; }
        public virtual ICollection<DetalleFactura> DetalleFacturas { get; set; }
    }
}
