//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Runtime.Serialization;


namespace ProntoMVC.Models
{
    [DataContract(IsReference = true)]
    [KnownType(typeof(Proveedor))]
    public partial class CuentasCorrientesAcreedor
    {
        [DataMember]
        public int IdCtaCte { get; set; }
        [DataMember]
        public Nullable<int> IdProveedor { get; set; }
        [DataMember]
        public Nullable<System.DateTime> Fecha { get; set; }
        [DataMember]
        public Nullable<int> IdTipoComp { get; set; }
        [DataMember]
        public Nullable<int> IdComprobante { get; set; }
        [DataMember]
        public Nullable<int> NumeroComprobante { get; set; }
        [DataMember]
        public Nullable<int> IdImputacion { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteTotal { get; set; }
        [DataMember]
        public Nullable<decimal> Saldo { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaVencimiento { get; set; }
        [DataMember]
        public Nullable<int> IdDetalleOrdenPago { get; set; }
        [DataMember]
        public Nullable<decimal> CotizacionDolar { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteTotalDolar { get; set; }
        [DataMember]
        public Nullable<decimal> SaldoDolar { get; set; }
        [DataMember]
        public Nullable<int> IdMoneda { get; set; }
        [DataMember]
        public Nullable<decimal> CotizacionMoneda { get; set; }
        [DataMember]
        public Nullable<decimal> CotizacionEuro { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteTotalEuro { get; set; }
        [DataMember]
        public Nullable<decimal> SaldoEuro { get; set; }
        [DataMember]
        public Nullable<decimal> SaldoTrs { get; set; }
        [DataMember]
        public string Marca { get; set; }
    
        [DataMember]
        public virtual Proveedor Proveedore { get; set; }
    }
    
}
