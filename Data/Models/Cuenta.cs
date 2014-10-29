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
    
    public partial class Cuenta
    {
        public Cuenta()
        {
            this.Articulos = new HashSet<Articulo>();
            this.Articulos1 = new HashSet<Articulo>();
            this.Articulos2 = new HashSet<Articulo>();
            this.Clientes = new HashSet<Cliente>();
            this.Conceptos = new HashSet<Concepto>();
            this.Clientes1 = new HashSet<Cliente>();
            this.IBCondiciones = new HashSet<IBCondicion>();
            this.IBCondiciones1 = new HashSet<IBCondicion>();
            this.IBCondiciones2 = new HashSet<IBCondicion>();
            this.Rubros = new HashSet<Rubro>();
            this.Bancos = new HashSet<Banco>();
            this.Bancos1 = new HashSet<Banco>();
            this.DetalleCuentas = new HashSet<DetalleCuenta>();
            this.DetalleComprobantesProveedores = new HashSet<DetalleComprobantesProveedore>();
            this.Cajas = new HashSet<Caja>();
            this.ComprobantesProveedores = new HashSet<ComprobanteProveedor>();
        }
    
        public int IdCuenta { get; set; }
        public Nullable<int> Codigo { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdTipoCuenta { get; set; }
        public Nullable<int> NivelTotal { get; set; }
        public Nullable<int> IdRubroContable { get; set; }
        public string Jerarquia { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdCuentaGasto { get; set; }
        public string DebeHaber { get; set; }
        public Nullable<int> IdTipoCuentaGrupo { get; set; }
        public string VaAlCiti { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes01 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes02 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes03 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes04 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes05 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes06 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes07 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes08 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes09 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes10 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes11 { get; set; }
        public Nullable<decimal> PresupuestoTeoricoMes12 { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public Nullable<int> CodigoAgrupacionAuxiliar { get; set; }
        public Nullable<int> IdObraAgrupacionAuxiliar { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public string AjustaPorInflacion { get; set; }
        public string CodigoSecundario { get; set; }
        public Nullable<int> IdCuentaConsolidacion { get; set; }
        public Nullable<int> IdCuentaConsolidacion2 { get; set; }
        public Nullable<int> IdCuentaConsolidacion3 { get; set; }
        public Nullable<int> NumeroAuxiliar { get; set; }
        public Nullable<int> IdRubroFinanciero { get; set; }
        public Nullable<int> IdPresupuestoObraRubro { get; set; }
        public Nullable<int> OrdenamientoAuxiliar { get; set; }
        public string TextoAuxiliar1 { get; set; }
        public string TextoAuxiliar2 { get; set; }
        public string TextoAuxiliar3 { get; set; }
        public string ImputarAPresupuestoDeObra { get; set; }
    
        public virtual ICollection<Articulo> Articulos { get; set; }
        public virtual ICollection<Articulo> Articulos1 { get; set; }
        public virtual ICollection<Articulo> Articulos2 { get; set; }
        public virtual ICollection<Cliente> Clientes { get; set; }
        public virtual ICollection<Concepto> Conceptos { get; set; }
        public virtual Obra Obra { get; set; }
        public virtual ICollection<Cliente> Clientes1 { get; set; }
        public virtual ICollection<IBCondicion> IBCondiciones { get; set; }
        public virtual ICollection<IBCondicion> IBCondiciones1 { get; set; }
        public virtual ICollection<IBCondicion> IBCondiciones2 { get; set; }
        public virtual ICollection<Rubro> Rubros { get; set; }
        public virtual ICollection<Banco> Bancos { get; set; }
        public virtual ICollection<Banco> Bancos1 { get; set; }
        public virtual ICollection<DetalleCuenta> DetalleCuentas { get; set; }
        public virtual ICollection<DetalleComprobantesProveedore> DetalleComprobantesProveedores { get; set; }
        public virtual ICollection<Caja> Cajas { get; set; }
        public virtual ICollection<ComprobanteProveedor> ComprobantesProveedores { get; set; }
        public virtual TiposCuentaGrupos TiposCuentaGrupos { get; set; }
        public virtual CuentasGasto CuentasGasto { get; set; }
    }
}
