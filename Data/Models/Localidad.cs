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
    
    public partial class Localidad
    {
        public Localidad()
        {
            this.Clientes = new HashSet<Cliente>();
            this.Clientes1 = new HashSet<Cliente>();
            this.Proveedores = new HashSet<Proveedor>();
            this.DetalleClientesLugaresEntregas = new HashSet<DetalleClientesLugaresEntrega>();
            this.Transportistas = new HashSet<Transportista>();
            this.FertilizantesCupos = new HashSet<FertilizantesCupos>();
            this.FertilizantesCupos1 = new HashSet<FertilizantesCupos>();
            this.WilliamsDestinos = new HashSet<WilliamsDestino>();
        }
    
        public int IdLocalidad { get; set; }
        public string Nombre { get; set; }
        public string CodigoPostal { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public string CodigoWilliams_1 { get; set; }
        public string CodigoLosGrobo_1 { get; set; }
        public string CodigoESRI { get; set; }
        public Nullable<int> IdPartido { get; set; }
        public Nullable<int> Codigo { get; set; }
        public string Partido { get; set; }
        public string CodigoONCAA { get; set; }
        public Nullable<int> CodigoAfip { get; set; }
    
        public virtual ICollection<Cliente> Clientes { get; set; }
        public virtual ICollection<Cliente> Clientes1 { get; set; }
        public virtual ICollection<Proveedor> Proveedores { get; set; }
        public virtual ICollection<DetalleClientesLugaresEntrega> DetalleClientesLugaresEntregas { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual ICollection<Transportista> Transportistas { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos { get; set; }
        public virtual ICollection<FertilizantesCupos> FertilizantesCupos1 { get; set; }
        public virtual ICollection<WilliamsDestino> WilliamsDestinos { get; set; }
    }
}
