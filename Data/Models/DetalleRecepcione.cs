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
    
    public partial class DetalleRecepcione
    {
        public int IdDetalleRecepcion { get; set; }
        public Nullable<int> IdRecepcion { get; set; }
        public Nullable<decimal> Cantidad { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<int> IdControlCalidad { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> Cantidad1 { get; set; }
        public Nullable<decimal> Cantidad2 { get; set; }
        public Nullable<int> IdDetallePedido { get; set; }
        public string Controlado { get; set; }
        public Nullable<decimal> CantidadAdicional { get; set; }
        public string Partida { get; set; }
        public Nullable<decimal> CantidadCC { get; set; }
        public Nullable<decimal> Cantidad1CC { get; set; }
        public Nullable<decimal> Cantidad2CC { get; set; }
        public Nullable<decimal> CantidadAdicionalCC { get; set; }
        public string ObservacionesCC { get; set; }
        public Nullable<decimal> CantidadRechazadaCC { get; set; }
        public Nullable<int> IdMotivoRechazo { get; set; }
        public Nullable<int> IdRealizo { get; set; }
        public Nullable<int> IdDetalleRequerimiento { get; set; }
        public string Trasabilidad { get; set; }
        public Nullable<int> IdDetalleAcopios { get; set; }
        public Nullable<int> IdUbicacion { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<decimal> CostoUnitario { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdDetalleRecepcionOriginal { get; set; }
        public Nullable<int> IdRecepcionOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<int> IdDetalleObraDestino { get; set; }
        public Nullable<decimal> CantidadEnOrigen { get; set; }
        public Nullable<int> IdDetalleSalidaMateriales { get; set; }
        public Nullable<int> IdPresupuestoObrasNodo { get; set; }
        public Nullable<decimal> CostoOriginal { get; set; }
        public Nullable<int> IdUsuarioModificoCosto { get; set; }
        public Nullable<System.DateTime> FechaModificacionCosto { get; set; }
        public string ObservacionModificacionCosto { get; set; }
        public Nullable<int> IdMonedaOriginal { get; set; }
        public Nullable<int> NumeroCaja { get; set; }
        public Nullable<int> IdColor { get; set; }
        public Nullable<int> IdDetalleLiquidacionFlete { get; set; }
        public Nullable<int> IdUsuarioDioPorCumplidoLiquidacionFletes { get; set; }
        public Nullable<System.DateTime> FechaDioPorCumplidoLiquidacionFletes { get; set; }
        public string ObservacionDioPorCumplidoLiquidacionFletes { get; set; }
        public string Talle { get; set; }
        public Nullable<int> IdProduccionTerminado { get; set; }
    
        public virtual Recepcione Recepcione { get; set; }
    }
}
