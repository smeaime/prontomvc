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
    
    public partial class ControlCalidad
    {
        public ControlCalidad()
        {
            this.DetalleRequerimientos = new HashSet<DetalleRequerimiento>();
            this.DetallePedidos = new HashSet<DetallePedido>();
        }
    
        public int IdControlCalidad { get; set; }
        public string Descripcion { get; set; }
        public string Inspeccion { get; set; }
        public string Abreviatura { get; set; }
        public string Detalle { get; set; }
    
        public virtual ICollection<DetalleRequerimiento> DetalleRequerimientos { get; set; }
        public virtual ICollection<DetallePedido> DetallePedidos { get; set; }
    }
}
