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
    }
}
