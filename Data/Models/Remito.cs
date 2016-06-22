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
    
    public partial class Remito
    {
        public Remito()
        {
            this.DetalleRemitos = new HashSet<DetalleRemito>();
        }
    
        public int IdRemito { get; set; }
        public Nullable<int> NumeroRemito { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<System.DateTime> FechaRemito { get; set; }
        public Nullable<int> IdCondicionVenta { get; set; }
        public string Anulado { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string Observaciones { get; set; }
        public string ArchivoAdjunto1 { get; set; }
        public string ArchivoAdjunto2 { get; set; }
        public string ArchivoAdjunto3 { get; set; }
        public string ArchivoAdjunto4 { get; set; }
        public string ArchivoAdjunto5 { get; set; }
        public string ArchivoAdjunto6 { get; set; }
        public string ArchivoAdjunto7 { get; set; }
        public string ArchivoAdjunto8 { get; set; }
        public string ArchivoAdjunto9 { get; set; }
        public string ArchivoAdjunto10 { get; set; }
        public Nullable<int> Destino { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public Nullable<int> IdTransportista { get; set; }
        public Nullable<int> TotalBultos { get; set; }
        public Nullable<decimal> ValorDeclarado { get; set; }
        public Nullable<System.DateTime> FechaRegistracion { get; set; }
        public Nullable<int> IdAutorizaAnulacion { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public string Patente { get; set; }
        public string Chofer { get; set; }
        public string NumeroDocumento { get; set; }
        public string OrdenCarga { get; set; }
        public string OrdenCompra { get; set; }
        public string COT { get; set; }
        public Nullable<int> IdEquipo { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdDetalleClienteLugarEntrega { get; set; }
        public string HoraSalida { get; set; }
        public Nullable<decimal> PesoBruto { get; set; }
        public Nullable<decimal> Tara { get; set; }
    
        public virtual Cliente Cliente { get; set; }
        public virtual Proveedor Proveedore { get; set; }
        public virtual PuntosVenta PuntosVenta { get; set; }
        public virtual ICollection<DetalleRemito> DetalleRemitos { get; set; }
        public virtual Condiciones_Compra Condiciones_Compra { get; set; }
        public virtual Empleado Empleado { get; set; }
        public virtual ListasPrecio ListasPrecio { get; set; }
        public virtual Obra Obra { get; set; }
        public virtual Transportista Transportista { get; set; }
    }
}
