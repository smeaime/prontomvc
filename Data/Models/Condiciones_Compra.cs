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
    
    public partial class Condiciones_Compra
    {
        public Condiciones_Compra()
        {
            this.Presupuestos = new HashSet<Presupuesto>();
            this.Clientes = new HashSet<Cliente>();
        }
    
        public int IdCondicionCompra { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> CantidadDias { get; set; }
        public string CodigoCondicion { get; set; }
        public Nullable<int> CantidadDias1 { get; set; }
        public Nullable<int> CantidadDias2 { get; set; }
        public Nullable<int> CantidadDias3 { get; set; }
        public Nullable<int> CantidadDias4 { get; set; }
        public Nullable<int> CantidadDias5 { get; set; }
        public Nullable<int> CantidadDias6 { get; set; }
        public Nullable<decimal> Porcentaje1 { get; set; }
        public Nullable<decimal> Porcentaje2 { get; set; }
        public Nullable<decimal> Porcentaje3 { get; set; }
        public Nullable<decimal> Porcentaje4 { get; set; }
        public Nullable<decimal> Porcentaje5 { get; set; }
        public Nullable<decimal> Porcentaje6 { get; set; }
        public Nullable<int> CantidadDias7 { get; set; }
        public Nullable<int> CantidadDias8 { get; set; }
        public Nullable<int> CantidadDias9 { get; set; }
        public Nullable<int> CantidadDias10 { get; set; }
        public Nullable<int> CantidadDias11 { get; set; }
        public Nullable<int> CantidadDias12 { get; set; }
        public Nullable<decimal> Porcentaje7 { get; set; }
        public Nullable<decimal> Porcentaje8 { get; set; }
        public Nullable<decimal> Porcentaje9 { get; set; }
        public Nullable<decimal> Porcentaje10 { get; set; }
        public Nullable<decimal> Porcentaje11 { get; set; }
        public Nullable<decimal> Porcentaje12 { get; set; }
        public string Observaciones { get; set; }
        public string Codigo { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public string ContraEntregaDeValores { get; set; }
    
        public virtual ICollection<Presupuesto> Presupuestos { get; set; }
        public virtual ICollection<Cliente> Clientes { get; set; }
    }
}
