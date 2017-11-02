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
    
    public partial class Moneda
    {
        public Moneda()
        {
            this.Clientes = new HashSet<Cliente>();
            this.ListasPrecios = new HashSet<ListasPrecio>();
            this.Pedidos = new HashSet<Pedido>();
            this.Presupuestos = new HashSet<Presupuesto>();
            this.Facturas = new HashSet<Factura>();
            this.Cotizaciones = new HashSet<Cotizacione>();
            this.OrdenesCompras = new HashSet<OrdenesCompra>();
            this.ComprobantesProveedores = new HashSet<ComprobanteProveedor>();
            this.DetalleComparativas = new HashSet<DetalleComparativa>();
            this.NotasCreditoes = new HashSet<NotasCredito>();
            this.NotasDebitoes = new HashSet<NotasDebito>();
            this.Valores = new HashSet<Valore>();
            this.Valores1 = new HashSet<Valore>();
            this.Recibos = new HashSet<Recibo>();
            this.OrdenesPagoes = new HashSet<OrdenPago>();
            this.DetalleAsientos = new HashSet<DetalleAsiento>();
            this.DetalleAsientos1 = new HashSet<DetalleAsiento>();
        }
    
        public int IdMoneda { get; set; }
        public string Nombre { get; set; }
        public string Abreviatura { get; set; }
        public Nullable<decimal> EquivalenciaUS { get; set; }
        public string CodigoAFIP { get; set; }
        public string GeneraImpuestos { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
    
        public virtual ICollection<Cliente> Clientes { get; set; }
        public virtual ICollection<ListasPrecio> ListasPrecios { get; set; }
        public virtual ICollection<Pedido> Pedidos { get; set; }
        public virtual ICollection<Presupuesto> Presupuestos { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
        public virtual ICollection<Cotizacione> Cotizaciones { get; set; }
        public virtual ICollection<OrdenesCompra> OrdenesCompras { get; set; }
        public virtual ICollection<ComprobanteProveedor> ComprobantesProveedores { get; set; }
        public virtual ICollection<DetalleComparativa> DetalleComparativas { get; set; }
        public virtual ICollection<NotasCredito> NotasCreditoes { get; set; }
        public virtual ICollection<NotasDebito> NotasDebitoes { get; set; }
        public virtual ICollection<Valore> Valores { get; set; }
        public virtual ICollection<Valore> Valores1 { get; set; }
        public virtual ICollection<Recibo> Recibos { get; set; }
        public virtual ICollection<OrdenPago> OrdenesPagoes { get; set; }
        public virtual ICollection<DetalleAsiento> DetalleAsientos { get; set; }
        public virtual ICollection<DetalleAsiento> DetalleAsientos1 { get; set; }
    }
}
