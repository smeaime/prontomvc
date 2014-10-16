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
    
    public partial class ListasPrecio
    {
        public ListasPrecio()
        {
            this.Clientes = new HashSet<Cliente>();
            this.ListasPreciosDetalles = new HashSet<ListasPreciosDetalle>();
        }
    
        public int IdListaPrecios { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> NumeroLista { get; set; }
        public Nullable<System.DateTime> FechaVigencia { get; set; }
        public string Activa { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public string DescripcionPrecio1 { get; set; }
        public string DescripcionPrecio2 { get; set; }
        public string DescripcionPrecio3 { get; set; }
        public Nullable<int> IdObra { get; set; }
    
        public virtual ICollection<Cliente> Clientes { get; set; }
        public virtual ICollection<ListasPreciosDetalle> ListasPreciosDetalles { get; set; }
        public virtual Moneda Moneda { get; set; }
    }
}
