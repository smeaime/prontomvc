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
    
    public partial class Conjunto
    {
        public int IdConjunto { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> IdRealizo { get; set; }
        public Nullable<System.DateTime> FechaRegistro { get; set; }
        public string CodigoConjunto { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> Version { get; set; }
    }
}
