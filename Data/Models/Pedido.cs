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
    
    public partial class Pedido
    {
        public Pedido()
        {
            this.DetallePedidos = new HashSet<DetallePedido>();
        }
    
        public int IdPedido { get; set; }
        public Nullable<int> NumeroPedido { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public Nullable<System.DateTime> FechaPedido { get; set; }
        public string LugarEntrega { get; set; }
        public string FormaPago { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> Bonificacion { get; set; }
        public Nullable<decimal> TotalIva1 { get; set; }
        public Nullable<decimal> TotalIva2 { get; set; }
        public Nullable<decimal> TotalPedido { get; set; }
        public Nullable<decimal> PorcentajeIva1 { get; set; }
        public Nullable<decimal> PorcentajeIva2 { get; set; }
        public Nullable<int> IdComprador { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public Nullable<int> NumeroComparativa { get; set; }
        public string Contacto { get; set; }
        public string PlazoEntrega { get; set; }
        public string Garantia { get; set; }
        public string Documentacion { get; set; }
        public Nullable<int> Aprobo { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<System.DateTime> FechaAprobacion { get; set; }
        public string Importante { get; set; }
        public Nullable<int> TipoCompra { get; set; }
        public string Consorcial { get; set; }
        public string Cumplido { get; set; }
        public string DetalleCondicionCompra { get; set; }
        public Nullable<int> IdAutorizoCumplido { get; set; }
        public Nullable<int> IdDioPorCumplido { get; set; }
        public Nullable<System.DateTime> FechaDadoPorCumplido { get; set; }
        public string ObservacionesCumplido { get; set; }
        public Nullable<int> SubNumero { get; set; }
        public string UsuarioAnulacion { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
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
        public string ImprimeImportante { get; set; }
        public string ImprimePlazoEntrega { get; set; }
        public string ImprimeLugarEntrega { get; set; }
        public string ImprimeFormaPago { get; set; }
        public string ImprimeImputaciones { get; set; }
        public string ImprimeInspecciones { get; set; }
        public string ImprimeGarantia { get; set; }
        public string ImprimeDocumentacion { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public string PedidoExterior { get; set; }
        public string PRESTOPedido { get; set; }
        public Nullable<System.DateTime> PRESTOFechaProceso { get; set; }
        public Nullable<int> IdCondicionCompra { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdPedidoOriginal { get; set; }
        public Nullable<int> IdOrigenTransmision { get; set; }
        public Nullable<System.DateTime> FechaImportacionTransmision { get; set; }
        public string Subcontrato { get; set; }
        public Nullable<int> IdPedidoAbierto { get; set; }
        public string NumeroLicitacion { get; set; }
        public string Transmitir_a_SAT { get; set; }
        public string NumeracionAutomatica { get; set; }
        public string Impresa { get; set; }
        public string EmbarcadoA { get; set; }
        public string FacturarA { get; set; }
        public string ProveedorExt { get; set; }
        public Nullable<decimal> ImpuestosInternos { get; set; }
        public Nullable<System.DateTime> FechaSalida { get; set; }
        public Nullable<decimal> CodigoControl { get; set; }
        public string CircuitoFirmasCompleto { get; set; }
        public Nullable<decimal> OtrosConceptos1 { get; set; }
        public Nullable<decimal> OtrosConceptos2 { get; set; }
        public Nullable<decimal> OtrosConceptos3 { get; set; }
        public Nullable<decimal> OtrosConceptos4 { get; set; }
        public Nullable<decimal> OtrosConceptos5 { get; set; }
        public Nullable<int> IdClausula { get; set; }
        public string IncluirObservacionesRM { get; set; }
        public Nullable<int> NumeroSubcontrato { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public Nullable<int> IdMonedaOriginal { get; set; }
        public Nullable<int> IdLugarEntrega_1 { get; set; }
        public string ConfirmadoPorWeb_1 { get; set; }
        public Nullable<int> IdTipoCompraRM { get; set; }
        public Nullable<System.DateTime> FechaEnvioProveedor { get; set; }
        public Nullable<int> IdUsuarioEnvioProveedor { get; set; }
        public Nullable<int> IdPlazoEntrega { get; set; }
        public string Inspecciones { get; set; }
        public string Subcontratos { get; set; }
        public string ImprimeSubcontratos { get; set; }
        public string NotasSeguimiento { get; set; }
        public Nullable<decimal> CoeficienteCompra { get; set; }
        public string Detalle { get; set; }
        public string BloqueadoFirma { get; set; }
        public Nullable<int> IdUsuarioBloqueo { get; set; }
    
        public virtual ICollection<DetallePedido> DetallePedidos { get; set; }
        public virtual Moneda Moneda { get; set; }
        public virtual Proveedor Proveedor { get; set; }
        public virtual Empleado Empleado { get; set; }
        public virtual Empleado Comprador { get; set; }
        public virtual Empleado Empleado2 { get; set; }
    }
}
