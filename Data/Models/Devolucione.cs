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
    
    public partial class Devolucione
    {
        public Devolucione()
        {
            this.DetalleDevoluciones = new HashSet<DetalleDevolucione>();
        }
    
        public int IdDevolucion { get; set; }
        public Nullable<int> NumeroDevolucion { get; set; }
        public string TipoABC { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public Nullable<int> IdFactura { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<System.DateTime> FechaDevolucion { get; set; }
        public Nullable<int> IdVendedor { get; set; }
        public string TipoPedidoConsignacion { get; set; }
        public string Anulada { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public Nullable<decimal> ImporteTotal { get; set; }
        public Nullable<decimal> ImporteIva1 { get; set; }
        public Nullable<decimal> ImporteIva2 { get; set; }
        public Nullable<decimal> ImporteBonificacion { get; set; }
        public Nullable<decimal> RetencionIBrutos1 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos1 { get; set; }
        public Nullable<decimal> RetencionIBrutos2 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos2 { get; set; }
        public string ConvenioMultilateral { get; set; }
        public Nullable<decimal> RetencionIBrutos3 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos3 { get; set; }
        public Nullable<short> IdTipoVentaC { get; set; }
        public Nullable<decimal> ImporteIvaIncluido { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public Nullable<decimal> PorcentajeIva1 { get; set; }
        public Nullable<decimal> PorcentajeIva2 { get; set; }
        public Nullable<decimal> IVANoDiscriminado { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public string Observaciones { get; set; }
        public Nullable<System.DateTime> FechaRegistracion { get; set; }
        public Nullable<int> IdProvinciaDestino { get; set; }
        public Nullable<decimal> OtrasPercepciones1 { get; set; }
        public string OtrasPercepciones1Desc { get; set; }
        public Nullable<decimal> OtrasPercepciones2 { get; set; }
        public string OtrasPercepciones2Desc { get; set; }
        public Nullable<int> IdIBCondicion { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public Nullable<decimal> NumeroCAI { get; set; }
        public Nullable<System.DateTime> FechaVencimientoCAI { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdCodigoIva { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdIBCondicion2 { get; set; }
        public Nullable<int> IdIBCondicion3 { get; set; }
        public Nullable<decimal> PercepcionIVA { get; set; }
        public Nullable<decimal> PorcentajePercepcionIVA { get; set; }
        public Nullable<int> IdDeposito { get; set; }
        public Nullable<int> IdUsuarioAnulacion { get; set; }
        public string CAE { get; set; }
        public string RechazoCAE { get; set; }
        public Nullable<System.DateTime> FechaVencimientoORechazoCAE { get; set; }
        public Nullable<int> IdIdentificacionCAE { get; set; }
        public string Cliente { get; set; }
        public string OrigenRegistro { get; set; }
        public string CuitClienteExterno { get; set; }
        public Nullable<decimal> OtrasPercepciones3 { get; set; }
        public string OtrasPercepciones3Desc { get; set; }
        public Nullable<decimal> AjusteIva { get; set; }
        public Nullable<int> IdIBCondicion31 { get; set; }
        public Nullable<decimal> RetencionIBrutos31 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos31 { get; set; }
        public Nullable<int> IdIBCondicion32 { get; set; }
        public Nullable<decimal> RetencionIBrutos32 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos32 { get; set; }
        public Nullable<int> IdIBCondicion33 { get; set; }
        public Nullable<decimal> RetencionIBrutos33 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos33 { get; set; }
        public Nullable<int> IdIBCondicion34 { get; set; }
        public Nullable<decimal> RetencionIBrutos34 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos34 { get; set; }
        public Nullable<int> IdIBCondicion35 { get; set; }
        public Nullable<decimal> RetencionIBrutos35 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos35 { get; set; }
        public Nullable<int> IdIBCondicion36 { get; set; }
        public Nullable<decimal> RetencionIBrutos36 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos36 { get; set; }
        public Nullable<int> IdIBCondicion37 { get; set; }
        public Nullable<decimal> RetencionIBrutos37 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos37 { get; set; }
        public Nullable<int> IdIBCondicion38 { get; set; }
        public Nullable<decimal> RetencionIBrutos38 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos38 { get; set; }
        public Nullable<int> IdIBCondicion39 { get; set; }
        public Nullable<decimal> RetencionIBrutos39 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos39 { get; set; }
    
        public virtual ICollection<DetalleDevolucione> DetalleDevoluciones { get; set; }
    }
}
