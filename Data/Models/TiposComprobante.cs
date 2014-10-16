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
    
    public partial class TiposComprobante
    {
        public TiposComprobante()
        {
            this.PuntosVentas = new HashSet<PuntosVenta>();
            this.DetalleOrdenesPagoValores = new HashSet<DetalleOrdenesPagoValore>();
        }
    
        public int IdTipoComprobante { get; set; }
        public string Descripcion { get; set; }
        public Nullable<short> Coeficiente { get; set; }
        public string DescripcionAb { get; set; }
        public string EsValor { get; set; }
        public string CodigoDgi { get; set; }
        public string Agrupacion1 { get; set; }
        public string CalculaDiferenciaCambio { get; set; }
        public string VaAlLibro { get; set; }
        public string PideBancoCuenta { get; set; }
        public string PideCuenta { get; set; }
        public Nullable<int> IdCuentaDefault { get; set; }
        public string VaAConciliacionBancaria { get; set; }
        public string LlevarAPesosEnValores { get; set; }
        public Nullable<int> CoeficienteParaFondoFijo { get; set; }
        public Nullable<int> CoeficienteParaConciliaciones { get; set; }
        public string VaAlCiti { get; set; }
        public string VaAlRegistroComprasAFIP { get; set; }
        public string CodigoAFIP_Letra_A { get; set; }
        public string CodigoAFIP_Letra_B { get; set; }
        public string CodigoAFIP_Letra_C { get; set; }
        public string CodigoAFIP_Letra_E { get; set; }
        public string InformacionAuxiliar { get; set; }
        public string ExigirCAI { get; set; }
        public Nullable<int> NumeradorAuxiliar { get; set; }
        public string CodigoAFIP2_Letra_A { get; set; }
        public string CodigoAFIP2_Letra_B { get; set; }
        public string CodigoAFIP2_Letra_C { get; set; }
        public string CodigoAFIP2_Letra_E { get; set; }
        public string CodigoAFIP3_Letra_A { get; set; }
        public string CodigoAFIP3_Letra_B { get; set; }
        public string CodigoAFIP3_Letra_C { get; set; }
        public string CodigoAFIP3_Letra_E { get; set; }
    
        public virtual ICollection<PuntosVenta> PuntosVentas { get; set; }
        public virtual ICollection<DetalleOrdenesPagoValore> DetalleOrdenesPagoValores { get; set; }
    }
}
