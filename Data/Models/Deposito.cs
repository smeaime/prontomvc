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
    
    public partial class Deposito
    {
        public Deposito()
        {
            this.Ubicaciones = new HashSet<Ubicacion>();
        }
    
        public int IdDeposito { get; set; }
        public string Descripcion { get; set; }
        public string Abreviatura { get; set; }
        public Nullable<int> IdObra { get; set; }
    
        public virtual ICollection<Ubicacion> Ubicaciones { get; set; }
    }
}
