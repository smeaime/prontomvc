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
    
    public partial class PresupuestoObrasNodo
    {
        public int IdPresupuestoObrasNodo { get; set; }
        public Nullable<int> IdNodoPadre { get; set; }
        public Nullable<byte> Depth { get; set; }
        public string Lineage { get; set; }
        public Nullable<int> TipoNodo { get; set; }
        public Nullable<int> IdObra { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdUnidad { get; set; }
        public Nullable<decimal> CantidadAvanzada { get; set; }
        public string Item { get; set; }
        public string UnidadAvance { get; set; }
        public Nullable<int> IdPresupuestoObraRubro { get; set; }
        public Nullable<int> IdPresupuestoObraGrupoMateriales { get; set; }
        public Nullable<int> IdCuentaGasto { get; set; }
        public Nullable<int> IdSubrubro { get; set; }
        public string SubItem1 { get; set; }
        public string SubItem2 { get; set; }
        public string SubItem3 { get; set; }
        public Nullable<int> IdNodoAuxiliar { get; set; }
        public string SubItem4 { get; set; }
        public string SubItem5 { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdArticulo { get; set; }
    }
}
