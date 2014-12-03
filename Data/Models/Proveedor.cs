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
    
    public partial class Proveedor
    {
        public Proveedor()
        {
            this.DetalleProveedores = new HashSet<DetalleProveedor>();
            this.DetalleProveedoresIBs = new HashSet<DetalleProveedoresIB>();
            this.DetalleProveedoresRubros = new HashSet<DetalleProveedoresRubro>();
            this.Pedidos = new HashSet<Pedido>();
            this.Presupuestos = new HashSet<Presupuesto>();
            this.CuentasCorrientesAcreedores = new HashSet<CuentasCorrientesAcreedor>();
            this.Remitos = new HashSet<Remito>();
            this.ComprobantesProveedores = new HashSet<ComprobanteProveedor>();
            this.OrdenesPagoes = new HashSet<OrdenPago>();
            this.ComprobantesProveedores_1 = new HashSet<ComprobanteProveedor>();
        }
    
        public int IdProveedor { get; set; }
        public string RazonSocial { get; set; }
        public string Direccion { get; set; }
        public Nullable<int> IdLocalidad { get; set; }
        public string CodigoPostal { get; set; }
        public Nullable<int> IdProvincia { get; set; }
        public Nullable<int> IdPais { get; set; }
        public string Telefono1 { get; set; }
        public string Telefono2 { get; set; }
        public string Fax { get; set; }
        public string Email { get; set; }
        public string Cuit { get; set; }
        public Nullable<int> IdCodigoIva { get; set; }
        public Nullable<System.DateTime> FechaAlta { get; set; }
        public Nullable<System.DateTime> FechaUltimaCompra { get; set; }
        public Nullable<decimal> Excencion { get; set; }
        public Nullable<int> IdCondicionCompra { get; set; }
        public string Contacto { get; set; }
        public Nullable<int> IdActividad { get; set; }
        public string Nif { get; set; }
        public Nullable<int> IdEstado { get; set; }
        public Nullable<System.DateTime> EstadoFecha { get; set; }
        public string EstadoUsuario { get; set; }
        public string AltaUsuario { get; set; }
        public string CodigoEmpresa { get; set; }
        public string Nombre1 { get; set; }
        public string Nombre2 { get; set; }
        public string NombreFantasia { get; set; }
        public Nullable<int> IGCondicion { get; set; }
        public string IGCertificadoAutoretencion { get; set; }
        public string IGCertificadoNORetencion { get; set; }
        public Nullable<System.DateTime> IGFechaCaducidadExencion { get; set; }
        public Nullable<decimal> IGPorcentajeNORetencion { get; set; }
        public string IvaAgenteRetencion { get; set; }
        public string IvaExencionRetencion { get; set; }
        public Nullable<System.DateTime> IvaFechaCaducidadExencion { get; set; }
        public Nullable<decimal> IvaPorcentajeExencion { get; set; }
        public string IBNumeroInscripcion { get; set; }
        public Nullable<int> IBCondicion { get; set; }
        public Nullable<System.DateTime> IBFechaCaducidadExencion { get; set; }
        public Nullable<decimal> IBPorcentajeExencion { get; set; }
        public Nullable<System.DateTime> SSFechaCaducidadExencion { get; set; }
        public Nullable<decimal> SSPorcentajeExcencion { get; set; }
        public string PaginaWeb { get; set; }
        public string Habitual { get; set; }
        public string Observaciones { get; set; }
        public Nullable<decimal> Saldo { get; set; }
        public Nullable<decimal> SaldoDocumentos { get; set; }
        public Nullable<int> CodigoProveedor { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public string NumeroIngresosBrutos { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> LimiteCredito { get; set; }
        public Nullable<int> TipoProveedor { get; set; }
        public string Eventual { get; set; }
        public Nullable<int> IdTipoRetencionGanancia { get; set; }
        public string Confirmado { get; set; }
        public string CodigoPresto { get; set; }
        public string BienesOServicios { get; set; }
        public Nullable<int> IdIBCondicionPorDefecto { get; set; }
        public string RetenerSUSS { get; set; }
        public string ChequesALaOrdenDe { get; set; }
        public Nullable<System.DateTime> FechaLimiteExentoGanancias { get; set; }
        public Nullable<System.DateTime> FechaLimiteExentoIIBB { get; set; }
        public Nullable<int> IdImpuestoDirectoSUSS { get; set; }
        public string Importaciones_NumeroInscripcion { get; set; }
        public string Importaciones_DenominacionInscripcion { get; set; }
        public Nullable<byte> EnviarEmail { get; set; }
        public string REP_PROVEEDO_INS { get; set; }
        public string REP_PROVEEDO_UPD { get; set; }
        public string InformacionAuxiliar { get; set; }
        public Nullable<decimal> CoeficienteIIBBUnificado { get; set; }
        public Nullable<System.DateTime> FechaUltimaPresentacionDocumentacion { get; set; }
        public string ObservacionesPresentacionDocumentacion { get; set; }
        public Nullable<System.DateTime> FechaLimiteCondicionIVA { get; set; }
        public string CodigoSituacionRetencionIVA { get; set; }
        public Nullable<System.DateTime> SUSSFechaCaducidadExencion { get; set; }
        public Nullable<int> Calificacion { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModifico { get; set; }
        public string Exterior { get; set; }
        public string SujetoEmbargado { get; set; }
        public Nullable<decimal> SaldoEmbargo { get; set; }
        public string DetalleEmbargo { get; set; }
        public Nullable<decimal> PorcentajeIBDirecto { get; set; }
        public Nullable<System.DateTime> FechaInicioVigenciaIBDirecto { get; set; }
        public Nullable<System.DateTime> FechaFinVigenciaIBDirecto { get; set; }
        public Nullable<int> GrupoIIBB { get; set; }
        public Nullable<System.DateTime> IvaFechaInicioExencion { get; set; }
        public Nullable<int> IdTransportista { get; set; }
        public string CodigoRetencionIVA { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public string RegimenEspecialConstruccionIIBB { get; set; }
        public Nullable<decimal> PorcentajeIBDirectoCapital { get; set; }
        public Nullable<System.DateTime> FechaInicioVigenciaIBDirectoCapital { get; set; }
        public Nullable<System.DateTime> FechaFinVigenciaIBDirectoCapital { get; set; }
        public Nullable<int> GrupoIIBBCapital { get; set; }
        public Nullable<int> IdCuentaProvision { get; set; }
        public string TextoAuxiliar1 { get; set; }
        public string TextoAuxiliar2 { get; set; }
        public string TextoAuxiliar3 { get; set; }
        public string InscriptoRegistroFiscalOperadoresGranos_1 { get; set; }
        public string ArchivoAdjunto1 { get; set; }
        public string ArchivoAdjunto2 { get; set; }
        public string ArchivoAdjunto3 { get; set; }
        public string ArchivoAdjunto4 { get; set; }
        public string CancelacionInmediataDeDeuda { get; set; }
        public string DebitoAutomaticoPorDefecto { get; set; }
        public string RegistrarMovimientosEnCuentaCorriente { get; set; }
        public string FechaVencimientoParaEgresosProyectados { get; set; }
        public Nullable<System.DateTime> SUSSFechaInicioVigencia { get; set; }
        public string OperacionesMercadoInternoEntidadVinculada { get; set; }
        public Nullable<int> IdCuentaAplicacion { get; set; }
        public string CodigoCategoriaIIBBAlternativo { get; set; }
        public Nullable<System.DateTime> FechaInicialControlComprobantes { get; set; }
    
        public virtual ICollection<DetalleProveedor> DetalleProveedores { get; set; }
        public virtual ICollection<DetalleProveedoresIB> DetalleProveedoresIBs { get; set; }
        public virtual ICollection<DetalleProveedoresRubro> DetalleProveedoresRubros { get; set; }
        public virtual Localidad Localidad { get; set; }
        public virtual Pais Pais { get; set; }
        public virtual ICollection<Pedido> Pedidos { get; set; }
        public virtual ICollection<Presupuesto> Presupuestos { get; set; }
        public virtual Provincia Provincia { get; set; }
        public virtual ICollection<CuentasCorrientesAcreedor> CuentasCorrientesAcreedores { get; set; }
        public virtual ICollection<Remito> Remitos { get; set; }
        public virtual ICollection<ComprobanteProveedor> ComprobantesProveedores { get; set; }
        public virtual ICollection<OrdenPago> OrdenesPagoes { get; set; }
        public virtual ICollection<ComprobanteProveedor> ComprobantesProveedores_1 { get; set; }
        public virtual DescripcionIva DescripcionIva { get; set; }
    }
}
