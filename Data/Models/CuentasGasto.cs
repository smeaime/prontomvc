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
    
    public partial class CuentasGasto
    {
        public CuentasGasto()
        {
            this.Cuentas = new HashSet<Cuenta>();
        }
    
        public int IdCuentaGasto { get; set; }
        public Nullable<int> CodigoSubcuenta { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdRubroContable { get; set; }
        public Nullable<int> IdCuentaMadre { get; set; }
        public string Activa { get; set; }
        public string Codigo { get; set; }
        public string CodigoDestino { get; set; }
        public string Titulo { get; set; }
        public Nullable<int> Nivel { get; set; }
    
        public virtual ICollection<Cuenta> Cuentas { get; set; }
    }
}
