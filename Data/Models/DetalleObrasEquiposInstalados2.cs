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
    
    public partial class DetalleObrasEquiposInstalados2
    {
        public int IdDetalleObraEquipoInstalado2 { get; set; }
        public Nullable<int> IdDetalleObraEquipoInstalado { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdArticulo { get; set; }
        public Nullable<System.DateTime> FechaInstalacion { get; set; }
        public Nullable<System.DateTime> FechaDesinstalacion { get; set; }
        public string Observaciones { get; set; }
    
        public virtual Obra Obra { get; set; }
    }
}
