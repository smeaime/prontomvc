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
    
    public partial class Provincia
    {
        public Provincia()
        {
            this.Clientes = new HashSet<Cliente>();
            this.Clientes1 = new HashSet<Cliente>();
            this.Clientes2 = new HashSet<Cliente>();
            this.IBCondiciones = new HashSet<IBCondicion>();
            this.IBCondiciones1 = new HashSet<IBCondicion>();
            this.Proveedores = new HashSet<Proveedor>();
            this.DetalleClientesLugaresEntregas = new HashSet<DetalleClientesLugaresEntrega>();
            this.Facturas = new HashSet<Factura>();
            this.Localidades = new HashSet<Localidad>();
            this.NotasCreditoes = new HashSet<NotasCredito>();
            this.NotasDebitoes = new HashSet<NotasDebito>();
            this.WilliamsDestinos = new HashSet<WilliamsDestino>();
            this.Partidos = new HashSet<Partido>();
        }
    
        public int IdProvincia { get; set; }
        public string Nombre { get; set; }
        public string Codigo { get; set; }
        public Nullable<int> IdPais { get; set; }
        public Nullable<int> ProximoNumeroCertificadoRetencionIIBB { get; set; }
        public Nullable<int> IdCuentaRetencionIBrutos { get; set; }
        public Nullable<int> TipoRegistro { get; set; }
        public Nullable<int> IdCuentaPercepcionIBrutos { get; set; }
        public Nullable<int> ProximoNumeroCertificadoPercepcionIIBB { get; set; }
        public Nullable<int> TipoRegistroPercepcion { get; set; }
        public Nullable<int> IdCuentaRetencionIBrutosCobranzas { get; set; }
        public Nullable<int> IdCuentaPercepcionIIBBConvenio { get; set; }
        public string ExportarConApertura { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public string InformacionAuxiliar { get; set; }
        public Nullable<int> IdCuentaPercepcionIIBBCompras { get; set; }
        public string PlantillaRetencionIIBB { get; set; }
        public Nullable<int> IdCuentaSIRCREB { get; set; }
        public string EsAgenteRetencionIIBB { get; set; }
        public Nullable<int> IdCuentaPercepcionIIBBComprasJurisdiccionLocal { get; set; }
        public string CodigoESRI_1 { get; set; }
        public Nullable<int> Codigo2 { get; set; }
        public Nullable<int> IdCuentaRetencionIBrutos2 { get; set; }
        public Nullable<int> ProximoNumeroCertificadoRetencionIIBB2 { get; set; }
    
        public virtual ICollection<Cliente> Clientes { get; set; }
        public virtual ICollection<Cliente> Clientes1 { get; set; }
        public virtual ICollection<Cliente> Clientes2 { get; set; }
        public virtual ICollection<IBCondicion> IBCondiciones { get; set; }
        public virtual ICollection<IBCondicion> IBCondiciones1 { get; set; }
        public virtual Pais Pais { get; set; }
        public virtual ICollection<Proveedor> Proveedores { get; set; }
        public virtual ICollection<DetalleClientesLugaresEntrega> DetalleClientesLugaresEntregas { get; set; }
        public virtual ICollection<Factura> Facturas { get; set; }
        public virtual ICollection<Localidad> Localidades { get; set; }
        public virtual ICollection<NotasCredito> NotasCreditoes { get; set; }
        public virtual ICollection<NotasDebito> NotasDebitoes { get; set; }
        public virtual ICollection<WilliamsDestino> WilliamsDestinos { get; set; }
        public virtual ICollection<Partido> Partidos { get; set; }
    }
}
