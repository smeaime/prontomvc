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
    
    public partial class TiposCuentaGrupos
    {
        public TiposCuentaGrupos()
        {
            this.Cuentas = new HashSet<Cuenta>();
        }
    
        public int IdTipoCuentaGrupo { get; set; }
        public string Descripcion { get; set; }
        public string EsCajaBanco { get; set; }
        public string AjustarDiferenciasEnSubdiarios { get; set; }
    
        public virtual ICollection<Cuenta> Cuentas { get; set; }
    }
}
