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
    
    public partial class WilliamsDestino
    {
        public WilliamsDestino()
        {
            this.FertilizantesCupos = new HashSet<FertilizantesCupos>();
            this.FertilizantesCupos1 = new HashSet<FertilizantesCupos>();
            this.CartasDePorteControlDescargas = new HashSet<CartasDePorteControlDescarga>();
        }
    
        public int IdWilliamsDestino { get; set; }
        public string Descripcion { get; set; }
        public string Codigo { get; set; }
        public Nullable<int> Subcontratista1 { get; set; }
        public Nullable<int> Subcontratista2 { get; set; }
        public string CodigoSAJPYA { get; set; }
        public string CodigoONCAA { get; set; }
        public string SincronismoNoble1 { get; set; }
        public string SincronismoNoble2 { get; set; }
        public string AuxiliarString1 { get; set; }
        public string AuxiliarString2 { get; set; }
        public string AuxiliarString3 { get; set; }
        public string CodigoWilliams { get; set; }
        public string CodigoPostal { get; set; }
        public string CUIT { get; set; }
        public string CodigoLosGrobo { get; set; }
        public string CodigoYPF { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<int> IdLocalidad { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public Nullable<int> IdLocalidad2 { get; set; }
        public Nullable<int> IdLocalidad3 { get; set; }
        public Nullable<int> IdLocalidad4 { get; set; }
    
        public virtual Cliente Cliente { get; set; }
        public virtual Cliente Cliente1 { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos1 { get; set; }
        public virtual Localidad Localidade { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual Localidad Localidade1 { get; set; }
        public virtual Localidad Localidade11 { get; set; }
        public virtual Localidad Localidade2 { get; set; }
        public virtual ICollection<CartasDePorteControlDescarga> CartasDePorteControlDescargas { get; set; }
    }
}
