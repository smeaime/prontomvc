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
    
    public partial class DetalleOrdenesPagoImpuesto
    {
        public int IdDetalleOrdenPagoImpuestos { get; set; }
        public Nullable<int> IdOrdenPago { get; set; }
        public string TipoImpuesto { get; set; }
        public Nullable<int> IdTipoRetencionGanancia { get; set; }
        public Nullable<decimal> ImportePagado { get; set; }
        public Nullable<decimal> ImpuestoRetenido { get; set; }
        public Nullable<int> IdIBCondicion { get; set; }
        public Nullable<int> NumeroCertificadoRetencionGanancias { get; set; }
        public Nullable<int> NumeroCertificadoRetencionIIBB { get; set; }
        public Nullable<decimal> AlicuotaAplicada { get; set; }
        public Nullable<decimal> AlicuotaConvenioAplicada { get; set; }
        public Nullable<decimal> PorcentajeATomarSobreBase { get; set; }
        public Nullable<decimal> PorcentajeAdicional { get; set; }
        public Nullable<decimal> ImpuestoAdicional { get; set; }
        public string LeyendaPorcentajeAdicional { get; set; }
        public Nullable<decimal> ImporteTotalFacturasMPagadasSujetasARetencion { get; set; }
        public Nullable<int> IdDetalleImpuesto { get; set; }
    
        public virtual OrdenPago OrdenesPago { get; set; }
    }
}
