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
    
    public partial class DetallePedido
    {
        public DetallePedido()
        {
            this.DetalleRecepciones = new HashSet<DetalleRecepcione>();
        }
    
        public int IdDetallePedido { get; set; }
        public Nullable<int> IdPedido { get; set; }
        public Nullable<int> NumeroItem { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<System.DateTime> FechaEntrega { get; set; }
        public Nullable<int> IdControlCalidad { get; set; }
        public Nullable<decimal> Precio { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> Cantidad1 { get; set; }
        public Nullable<decimal> Cantidad2 { get; set; }
        public Nullable<int> IdDetalleAcopios { get; set; }
        public Nullable<int> IdDetalleRequerimiento { get; set; }
        public string Cumplido { get; set; }
        public Nullable<decimal> CantidadAdicional { get; set; }
        public Nullable<decimal> CantidadRecibida { get; set; }
        public Nullable<decimal> CantidadAdicionalRecibida { get; set; }
        public string Adjunto { get; set; }
        public string ArchivoAdjunto { get; set; }
        public Nullable<System.DateTime> FechaNecesidad { get; set; }
        public Nullable<int> IdDetalleLMateriales { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> OrigenDescripcion { get; set; }
        public string ArchivoAdjunto1 { get; set; }
        public string ArchivoAdjunto2 { get; set; }
        public string ArchivoAdjunto3 { get; set; }
        public string ArchivoAdjunto4 { get; set; }
        public string ArchivoAdjunto5 { get; set; }
        public string ArchivoAdjunto6 { get; set; }
        public string ArchivoAdjunto7 { get; set; }
        public string ArchivoAdjunto8 { get; set; }
        public string ArchivoAdjunto9 { get; set; }
        public string ArchivoAdjunto10 { get; set; }
        public Nullable<int> IdAutorizoCumplido { get; set; }
        public Nullable<int> IdDioPorCumplido { get; set; }
        public Nullable<System.DateTime> FechaDadoPorCumplido { get; set; }
        public string ObservacionesCumplido { get; set; }
        public Nullable<int> IdCentroCosto { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public Nullable<decimal> Importebonificacion { get; set; }
        public Nullable<decimal> PorcentajeIVA { get; set; }
        public Nullable<decimal> ImporteIva { get; set; }
        public Nullable<decimal> ImporteTotalItem { get; set; }
        public Nullable<decimal> Costo { get; set; }
        public string PRESTOPedido { get; set; }
        public Nullable<System.DateTime> PRESTOFechaProceso { get; set; }
        public Nullable<int> IdAsignacionCosto { get; set; }
        public Nullable<decimal> CostoAsignado { get; set; }
        public Nullable<int> IdUsuarioAsignoCosto { get; set; }
        public Nullable<System.DateTime> FechaAsignacionCosto { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdDetallePedidoOriginal { get; set; }
        public Nullable<int> IdPedidoOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public string PlazoEntrega { get; set; }
        public Nullable<decimal> CostoAsignadoDolar { get; set; }
        public Nullable<int> IdDetalleComparativa { get; set; }
        public Nullable<int> IdDetalleRequerimientoOriginal { get; set; }
        public Nullable<decimal> ImpuestosInternos { get; set; }
        public Nullable<decimal> CostoOriginal { get; set; }
        public Nullable<int> IdUsuarioModificoCosto { get; set; }
        public Nullable<System.DateTime> FechaModificacionCosto { get; set; }
        public string ObservacionModificacionCosto { get; set; }
    
        public virtual Articulo Articulo { get; set; }
        public virtual Pedido Pedido { get; set; }
        public virtual Unidad Unidad { get; set; }
        public virtual DetalleRequerimiento DetalleRequerimiento { get; set; }
        public virtual ControlCalidad ControlesCalidad { get; set; }
        public virtual DetalleComparativa DetalleComparativa { get; set; }
        public virtual ICollection<DetalleRecepcione> DetalleRecepciones { get; set; }
    }
}
