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
    
    public partial class Caja
    {
        public int IdCaja { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdMoneda { get; set; }
    
        public virtual Cuenta Cuenta { get; set; }
    }
}
