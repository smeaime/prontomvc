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
    
    public partial class Obra
    {
        public Obra()
        {
            this.Requerimientos = new HashSet<Requerimiento>();
            this.Cuentas = new HashSet<Cuenta>();
            this.DetalleRemitos = new HashSet<DetalleRemito>();
            this.Facturas = new HashSet<Factura>();
            this.ComprobantesProveedores = new HashSet<ComprobanteProveedor>();
            this.DetalleObrasEquiposInstalados = new HashSet<DetalleObrasEquiposInstalado>();
            this.DetalleObrasEquiposInstalados2 = new HashSet<DetalleObrasEquiposInstalados2>();
            this.DetalleObrasPolizas = new HashSet<DetalleObrasPoliza>();
            this.OrdenesCompras = new HashSet<OrdenesCompra>();
            this.Remitos = new HashSet<Remito>();
            this.Recibos = new HashSet<Recibo>();
            this.NotasCreditoes = new HashSet<NotasCredito>();
            this.NotasDebitoes = new HashSet<NotasDebito>();
            this.OrdenesPagoes = new HashSet<OrdenPago>();
            this.RubrosContables = new HashSet<RubrosContable>();
            this.DetalleAsientos = new HashSet<DetalleAsiento>();
        }
    
        public int IdObra { get; set; }
        public string NumeroObra { get; set; }
        public Nullable<int> IdCliente { get; set; }
        public Nullable<System.DateTime> FechaInicio { get; set; }
        public Nullable<System.DateTime> FechaFinalizacion { get; set; }
        public string Observaciones { get; set; }
        public Nullable<System.DateTime> FechaEntrega { get; set; }
        public string Descripcion { get; set; }
        public Nullable<int> IdJefe { get; set; }
        public Nullable<int> TipoObra { get; set; }
        public Nullable<int> HorasEstimadas { get; set; }
        public string Consorcial { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public string Activa { get; set; }
        public string ParaInformes { get; set; }
        public Nullable<int> IdUnidadOperativa { get; set; }
        public string Jerarquia { get; set; }
        public string ArchivoAdjunto1 { get; set; }
        public string ArchivoAdjunto2 { get; set; }
        public string ArchivoAdjunto3 { get; set; }
        public string ArchivoAdjunto4 { get; set; }
        public string ArchivoAdjunto5 { get; set; }
        public string ArchivoAdjunto6 { get; set; }
        public string ArchivoAdjunto7 { get; set; }
        public string ArchivoAdjunto8 { get; set; }
        public string ArchivoAdjunto9 { get; set; }
        public string ArchivoAdjunto10 { get; set; }
        public string GeneraReservaStock { get; set; }
        public Nullable<int> IdGrupoObra { get; set; }
        public Nullable<int> IdArticuloAsociado { get; set; }
        public string Observaciones2 { get; set; }
        public string Observaciones3 { get; set; }
        public Nullable<int> IdSubjefe { get; set; }
        public string Direccion { get; set; }
        public Nullable<int> IdLocalidad { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<int> IdPais { get; set; }
        public string CodigoPostal { get; set; }
        public string Telefono { get; set; }
        public string LugarPago { get; set; }
        public string Responsable { get; set; }
        public string Horario { get; set; }
        public string Turnos { get; set; }
        public Nullable<int> Operarios { get; set; }
        public Nullable<int> Zona { get; set; }
        public Nullable<int> Jurisdiccion { get; set; }
        public Nullable<int> IdCuentaContableFF { get; set; }
        public Nullable<decimal> ValorObra { get; set; }
        public Nullable<int> IdMonedaValorObra { get; set; }
        public Nullable<int> IdJefeRegional { get; set; }
        public string EsPlantaDeProduccionInterna { get; set; }
        public string ActivarPresupuestoObra { get; set; }
        public Nullable<int> ProximoNumeroAutorizacionCompra { get; set; }
        public string AuxiliarDeMateriales { get; set; }
        public Nullable<int> DiasLiquidacionCertificados { get; set; }
        public Nullable<int> IdObraRelacionada { get; set; }
        public Nullable<int> OrdenamientoSecundario { get; set; }
        public string RegimenMinero { get; set; }
        public Nullable<decimal> AnticipoFinancieroPorcentual { get; set; }
        public Nullable<decimal> FondoReparoPorcentual { get; set; }
        public Nullable<int> PlazoCobroDias { get; set; }
        public Nullable<int> CantidadEstimadaCertificados { get; set; }
    
        public virtual ICollection<Requerimiento> Requerimientos { get; set; }
        public virtual ICollection<Cuenta> Cuentas { get; set; }
        public virtual ICollection<DetalleRemito> DetalleRemitos { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
        public virtual ICollection<ComprobanteProveedor> ComprobantesProveedores { get; set; }
        public virtual ICollection<DetalleObrasEquiposInstalado> DetalleObrasEquiposInstalados { get; set; }
        public virtual ICollection<DetalleObrasEquiposInstalados2> DetalleObrasEquiposInstalados2 { get; set; }
        public virtual ICollection<DetalleObrasPoliza> DetalleObrasPolizas { get; set; }
        public virtual ICollection<OrdenesCompra> OrdenesCompras { get; set; }
        public virtual ICollection<Remito> Remitos { get; set; }
        public virtual ICollection<Recibo> Recibos { get; set; }
        public virtual ICollection<NotasCredito> NotasCreditoes { get; set; }
        public virtual ICollection<NotasDebito> NotasDebitoes { get; set; }
        public virtual ICollection<OrdenPago> OrdenesPagoes { get; set; }
        public virtual ICollection<RubrosContable> RubrosContables { get; set; }
        public virtual ICollection<DetalleAsiento> DetalleAsientos { get; set; }
    }
}
