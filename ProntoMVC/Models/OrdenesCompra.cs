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
    [KnownType(typeof(Cliente))]
    [KnownType(typeof(Moneda))]
    [KnownType(typeof(DetalleOrdenesCompra))]
    public partial class OrdenesCompra
    {
        public OrdenesCompra()
        {
            this.DetalleOrdenesCompras = new HashSet<DetalleOrdenesCompra>();
        }
    
        [DataMember]
        public int IdOrdenCompra { get; set; }
        [DataMember]
        public Nullable<int> NumeroOrdenCompra { get; set; }
        [DataMember]
        public Nullable<int> IdCliente { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaOrdenCompra { get; set; }
        [DataMember]
        public Nullable<int> IdCondicionVenta { get; set; }
        [DataMember]
        public string Anulada { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        [DataMember]
        public string Observaciones { get; set; }
        [DataMember]
        public Nullable<decimal> ImporteTotal { get; set; }
        [DataMember]
        public string ArchivoAdjunto1 { get; set; }
        [DataMember]
        public string ArchivoAdjunto2 { get; set; }
        [DataMember]
        public string ArchivoAdjunto3 { get; set; }
        [DataMember]
        public string ArchivoAdjunto4 { get; set; }
        [DataMember]
        public string ArchivoAdjunto5 { get; set; }
        [DataMember]
        public string ArchivoAdjunto6 { get; set; }
        [DataMember]
        public string ArchivoAdjunto7 { get; set; }
        [DataMember]
        public string ArchivoAdjunto8 { get; set; }
        [DataMember]
        public string ArchivoAdjunto9 { get; set; }
        [DataMember]
        public string ArchivoAdjunto10 { get; set; }
        [DataMember]
        public string NumeroOrdenCompraCliente { get; set; }
        [DataMember]
        public Nullable<int> IdObra { get; set; }
        [DataMember]
        public Nullable<int> IdMoneda { get; set; }
        [DataMember]
        public Nullable<int> IdUsuarioAnulacion { get; set; }
        [DataMember]
        public Nullable<int> AgrupacionFacturacion { get; set; }
        [DataMember]
        public Nullable<int> Agrupacion2Facturacion { get; set; }
        [DataMember]
        public string SeleccionadaParaFacturacion { get; set; }
        [DataMember]
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        [DataMember]
        public Nullable<int> IdListaPrecios { get; set; }
        [DataMember]
        public Nullable<int> IdUsuarioIngreso { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        [DataMember]
        public Nullable<int> IdUsuarioModifico { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaModifico { get; set; }
        [DataMember]
        public Nullable<int> Aprobo { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaAprobacion { get; set; }
        [DataMember]
        public string CircuitoFirmasCompleto { get; set; }
        [DataMember]
        public Nullable<int> IdDetalleClienteLugarEntrega { get; set; }
        [DataMember]
        public string Estado { get; set; }
        [DataMember]
        public Nullable<int> IdUsuarioCambioEstado { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaCambioEstado { get; set; }
    
        [DataMember]
        public virtual Cliente Cliente { get; set; }
        [DataMember]
        public virtual Moneda Moneda { get; set; }
        [DataMember]
        public virtual ICollection<DetalleOrdenesCompra> DetalleOrdenesCompras { get; set; }
    }
    
}
