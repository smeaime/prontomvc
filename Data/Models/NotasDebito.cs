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
    
    public partial class NotasDebito
    {
        public int IdNotaDebito { get; set; }
        public Nullable<int> NumeroNotaDebito { get; set; }
        public string TipoABC { get; set; }
        public Nullable<short> PuntoVenta { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<System.DateTime> FechaNotaDebito { get; set; }
        public Nullable<int> IdVendedor { get; set; }
        public Nullable<decimal> ImporteTotal { get; set; }
        public Nullable<decimal> ImporteIva1 { get; set; }
        public Nullable<decimal> ImporteIva2 { get; set; }
        public Nullable<decimal> RetencionIBrutos1 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos1 { get; set; }
        public Nullable<decimal> RetencionIBrutos2 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos2 { get; set; }
        public Nullable<int> IdCodigoIva { get; set; }
        public Nullable<decimal> PorcentajeIva1 { get; set; }
        public Nullable<decimal> PorcentajeIva2 { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> ImporteIvaIncluido { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public string CtaCte { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<decimal> IVANoDiscriminado { get; set; }
        public string ConvenioMultilateral { get; set; }
        public Nullable<decimal> OtrasPercepciones1 { get; set; }
        public string OtrasPercepciones1Desc { get; set; }
        public Nullable<decimal> OtrasPercepciones2 { get; set; }
        public string OtrasPercepciones2Desc { get; set; }
        public Nullable<int> IdProvinciaDestino { get; set; }
        public Nullable<int> IdIBCondicion { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public string Anulada { get; set; }
        public Nullable<int> IdUsuarioAnulacion { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public Nullable<decimal> NumeroCAI { get; set; }
        public Nullable<System.DateTime> FechaVencimientoCAI { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> NumeroCertificadoPercepcionIIBB { get; set; }
        public Nullable<int> IdVentaEnCuotas { get; set; }
        public Nullable<int> NumeroCuota { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public string AplicarEnCtaCte { get; set; }
        public Nullable<int> IdIBCondicion2 { get; set; }
        public Nullable<decimal> OtrasPercepciones3 { get; set; }
        public string OtrasPercepciones3Desc { get; set; }
        public string NoIncluirEnCubos { get; set; }
        public Nullable<decimal> PercepcionIVA { get; set; }
        public Nullable<decimal> PorcentajePercepcionIVA { get; set; }
        public Nullable<int> IdNotaCreditoVenta_RecuperoGastos { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdIBCondicion3 { get; set; }
        public Nullable<decimal> RetencionIBrutos3 { get; set; }
        public Nullable<decimal> PorcentajeIBrutos3 { get; set; }
        public string CAE { get; set; }
        public string RechazoCAE { get; set; }
        public Nullable<System.DateTime> FechaVencimientoORechazoCAE { get; set; }
        public Nullable<int> IdIdentificacionCAE { get; set; }
    
        public virtual Cliente Cliente { get; set; }
    }
}
