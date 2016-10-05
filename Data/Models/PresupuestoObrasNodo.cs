//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProntoMVC.Data.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class PresupuestoObrasNodo
    {
        public PresupuestoObrasNodo()
        {
            this.PresupuestoObrasNodosConsumos = new HashSet<PresupuestoObrasNodosConsumo>();
            this.PresupuestoObrasNodosDatos = new HashSet<PresupuestoObrasNodosDato>();
            this.PresupuestoObrasNodosPxQxPresupuestoes = new HashSet<PresupuestoObrasNodosPxQxPresupuesto>();
            this.PresupuestoObrasNodosPxQxPresupuestoPorDias = new HashSet<PresupuestoObrasNodosPxQxPresupuestoPorDia>();
            this.PresupuestoObrasRedeterminaciones = new HashSet<PresupuestoObrasRedeterminacione>();
        }
    
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
        public string BaseDatosOrigen { get; set; }
        public string HabilitarAvanceReal { get; set; }
    
        public virtual ICollection<PresupuestoObrasNodosConsumo> PresupuestoObrasNodosConsumos { get; set; }
        public virtual ICollection<PresupuestoObrasNodosDato> PresupuestoObrasNodosDatos { get; set; }
        public virtual ICollection<PresupuestoObrasNodosPxQxPresupuesto> PresupuestoObrasNodosPxQxPresupuestoes { get; set; }
        public virtual ICollection<PresupuestoObrasNodosPxQxPresupuestoPorDia> PresupuestoObrasNodosPxQxPresupuestoPorDias { get; set; }
        public virtual ICollection<PresupuestoObrasRedeterminacione> PresupuestoObrasRedeterminaciones { get; set; }
    }
}
