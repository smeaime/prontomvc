//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

using System;
using System.Collections.Generic;
using System.Runtime.Serialization;


namespace ProntoMVC.Models
{
    [DataContract(IsReference = true)]
    [KnownType(typeof(Sector))]
    [KnownType(typeof(Requerimiento))]
    [KnownType(typeof(Cliente))]
    [KnownType(typeof(Pedido))]
    [KnownType(typeof(Factura))]
    [KnownType(typeof(Presupuesto))]
    [KnownType(typeof(EmpleadosAcceso))]
    public partial class Empleado
    {
        public Empleado()
        {
            this.Requerimientos = new HashSet<Requerimiento>();
            this.Requerimientos1 = new HashSet<Requerimiento>();
            this.Clientes = new HashSet<Cliente>();
            this.Clientes1 = new HashSet<Cliente>();
            this.Pedidos = new HashSet<Pedido>();
            this.Facturas = new HashSet<Factura>();
            this.Presupuestos = new HashSet<Presupuesto>();
            this.Presupuestos1 = new HashSet<Presupuesto>();
            this.EmpleadosAccesos = new HashSet<EmpleadosAcceso>();
            this.Pedidos_1 = new HashSet<Pedido>();
        }
    
        [DataMember]
        public int IdEmpleado { get; set; }
        [DataMember]
        public Nullable<int> Legajo { get; set; }
        [DataMember]
        public string Nombre { get; set; }
        [DataMember]
        public string UsuarioNT { get; set; }
        [DataMember]
        public Nullable<int> IdSector { get; set; }
        [DataMember]
        public Nullable<int> IdCargo { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Interno { get; set; }
        [DataMember]
        public string Administrador { get; set; }
        [DataMember]
        public string Iniciales { get; set; }
        [DataMember]
        public string Password { get; set; }
        [DataMember]
        public string SisMan { get; set; }
        [DataMember]
        public Nullable<decimal> HorasJornada { get; set; }
        [DataMember]
        public Nullable<int> IdSector1 { get; set; }
        [DataMember]
        public Nullable<int> IdCargo1 { get; set; }
        [DataMember]
        public Nullable<int> IdSector2 { get; set; }
        [DataMember]
        public Nullable<int> IdCargo2 { get; set; }
        [DataMember]
        public Nullable<int> IdSector3 { get; set; }
        [DataMember]
        public Nullable<int> IdCargo3 { get; set; }
        [DataMember]
        public Nullable<int> IdSector4 { get; set; }
        [DataMember]
        public Nullable<int> IdCargo4 { get; set; }
        [DataMember]
        public string Dominio { get; set; }
        [DataMember]
        public string SisMat { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaNacimiento { get; set; }
        [DataMember]
        public Nullable<int> TipoUsuario { get; set; }
        [DataMember]
        public Nullable<int> GrupoDeCarga { get; set; }
        [DataMember]
        public string CuentaBancaria { get; set; }
        [DataMember]
        public string InformacionAuxiliar { get; set; }
        [DataMember]
        public Nullable<int> IdCuentaFondoFijo { get; set; }
        [DataMember]
        public Nullable<int> IdObraAsignada { get; set; }
        [DataMember]
        public string Activo { get; set; }
        [DataMember]
        public string Idioma { get; set; }
        [DataMember]
        public Nullable<int> PuntoVentaAsociado_1 { get; set; }
        [DataMember]
        public Nullable<int> IdLugarEntregaAsignado_1 { get; set; }
        [DataMember]
        public string EsConductor { get; set; }
        [DataMember]
        public Nullable<System.DateTime> FechaVencimientoRegistro { get; set; }
    
        [DataMember]
        public virtual Sector Sector { get; set; }
        [DataMember]
        public virtual ICollection<Requerimiento> Requerimientos { get; set; }
        [DataMember]
        public virtual ICollection<Requerimiento> Requerimientos1 { get; set; }
        [DataMember]
        public virtual ICollection<Cliente> Clientes { get; set; }
        [DataMember]
        public virtual ICollection<Cliente> Clientes1 { get; set; }
        [DataMember]
        public virtual ICollection<Pedido> Pedidos { get; set; }
        [DataMember]
        public virtual ICollection<Factura> Facturas { get; set; }
        [DataMember]
        public virtual ICollection<Presupuesto> Presupuestos { get; set; }
        [DataMember]
        public virtual ICollection<Presupuesto> Presupuestos1 { get; set; }
        [DataMember]
        public virtual ICollection<EmpleadosAcceso> EmpleadosAccesos { get; set; }
        [DataMember]
        public virtual ICollection<Pedido> Pedidos_1 { get; set; }
    }
    
}
