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
    
    public partial class Ubicacion
    {
        public Ubicacion()
        {
            this.DetalleRemitos = new HashSet<DetalleRemito>();
            this.Articulos = new HashSet<Articulo>();
            this.DetalleRecepciones = new HashSet<DetalleRecepcione>();
            this.DetalleSalidasMateriales = new HashSet<DetalleSalidasMateriale>();
        }
    
        public int IdUbicacion { get; set; }
        public string Descripcion { get; set; }
        public string Estanteria { get; set; }
        public string Modulo { get; set; }
        public string Gabeta { get; set; }
        public Nullable<int> IdDeposito { get; set; }
    
        public virtual Deposito Deposito { get; set; }
        public virtual ICollection<DetalleRemito> DetalleRemitos { get; set; }
        public virtual ICollection<Articulo> Articulos { get; set; }
        public virtual ICollection<DetalleRecepcione> DetalleRecepciones { get; set; }
        public virtual ICollection<DetalleSalidasMateriale> DetalleSalidasMateriales { get; set; }
    }
}
