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
    
    public partial class Rubro
    {
        public Rubro()
        {
            this.Articulos = new HashSet<Articulo>();
            this.DetalleProveedoresRubros = new HashSet<DetalleProveedoresRubro>();
            this.DefinicionArticulos = new HashSet<DefinicionArticulo>();
        }
    
        public int IdRubro { get; set; }
        public string Descripcion { get; set; }
        public string Abreviatura { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdCuentaCompras { get; set; }
        public Nullable<int> IdCuentaComprasActivo { get; set; }
        public Nullable<int> IdCuentaCompras1 { get; set; }
        public Nullable<int> IdCuentaCompras2 { get; set; }
        public Nullable<int> IdCuentaCompras3 { get; set; }
        public Nullable<int> IdCuentaCompras4 { get; set; }
        public Nullable<int> IdCuentaCompras5 { get; set; }
        public Nullable<int> IdCuentaCompras6 { get; set; }
        public Nullable<int> IdCuentaCompras7 { get; set; }
        public Nullable<int> IdCuentaCompras8 { get; set; }
        public Nullable<int> IdCuentaCompras9 { get; set; }
        public Nullable<int> IdCuentaCompras10 { get; set; }
        public Nullable<int> Codigo { get; set; }
        public Nullable<int> IdTipoOperacion { get; set; }
    
        public virtual ICollection<Articulo> Articulos { get; set; }
        public virtual Cuenta Cuenta { get; set; }
        public virtual ICollection<DetalleProveedoresRubro> DetalleProveedoresRubros { get; set; }
        public virtual ICollection<DefinicionArticulo> DefinicionArticulos { get; set; }
    }
}
