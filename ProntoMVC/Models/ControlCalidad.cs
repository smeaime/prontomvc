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
    [KnownType(typeof(DetalleRequerimiento))]
    [KnownType(typeof(DetallePedido))]
    public partial class ControlCalidad
    {
        public ControlCalidad()
        {
            this.DetalleRequerimientos = new HashSet<DetalleRequerimiento>();
            this.DetallePedidos = new HashSet<DetallePedido>();
        }
    
        [DataMember]
        public int IdControlCalidad { get; set; }
        [DataMember]
        public string Descripcion { get; set; }
        [DataMember]
        public string Inspeccion { get; set; }
        [DataMember]
        public string Abreviatura { get; set; }
        [DataMember]
        public string Detalle { get; set; }
    
        [DataMember]
        public virtual ICollection<DetalleRequerimiento> DetalleRequerimientos { get; set; }
        [DataMember]
        public virtual ICollection<DetallePedido> DetallePedidos { get; set; }
    }
    
}
