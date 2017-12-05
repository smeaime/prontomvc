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
    
    public partial class OrdenPago
    {
        public OrdenPago()
        {
            this.DetalleOrdenesPagoes = new HashSet<DetalleOrdenesPago>();
            this.DetalleOrdenesPagoCuentas = new HashSet<DetalleOrdenesPagoCuenta>();
            this.DetalleOrdenesPagoImpuestos = new HashSet<DetalleOrdenesPagoImpuesto>();
            this.DetalleOrdenesPagoRubrosContables = new HashSet<DetalleOrdenesPagoRubrosContable>();
            this.DetalleOrdenesPagoValores = new HashSet<DetalleOrdenesPagoValore>();
            this.OrdenesPago1 = new HashSet<OrdenPago>();
        }
    
        public int IdOrdenPago { get; set; }
        public Nullable<int> NumeroOrdenPago { get; set; }
        public Nullable<System.DateTime> FechaOrdenPago { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public Nullable<decimal> Efectivo { get; set; }
        public Nullable<decimal> Descuentos { get; set; }
        public Nullable<decimal> Valores { get; set; }
        public Nullable<decimal> Documentos { get; set; }
        public Nullable<decimal> Otros1 { get; set; }
        public Nullable<int> IdCuenta1 { get; set; }
        public Nullable<decimal> Otros2 { get; set; }
        public Nullable<int> IdCuenta2 { get; set; }
        public Nullable<decimal> Otros3 { get; set; }
        public Nullable<int> IdCuenta3 { get; set; }
        public Nullable<decimal> Acreedores { get; set; }
        public Nullable<decimal> RetencionIVA { get; set; }
        public Nullable<decimal> RetencionGanancias { get; set; }
        public Nullable<decimal> RetencionIBrutos { get; set; }
        public Nullable<decimal> GastosGenerales { get; set; }
        public string Estado { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public string Tipo { get; set; }
        public string Anulada { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public string Dolarizada { get; set; }
        public string Exterior { get; set; }
        public Nullable<int> NumeroCertificadoRetencionGanancias { get; set; }
        public Nullable<decimal> BaseGanancias { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public string AsientoManual { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdCuentaGasto { get; set; }
        public Nullable<decimal> DiferenciaBalanceo { get; set; }
        public Nullable<int> IdOPComplementariaFF { get; set; }
        public Nullable<int> IdEmpleadoFF { get; set; }
        public Nullable<int> NumeroCertificadoRetencionIVA { get; set; }
        public Nullable<int> NumeroCertificadoRetencionIIBB { get; set; }
        public Nullable<decimal> RetencionSUSS { get; set; }
        public Nullable<int> NumeroCertificadoRetencionSUSS { get; set; }
        public Nullable<int> TipoOperacionOtros { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModifico { get; set; }
        public string Confirmado { get; set; }
        public Nullable<int> IdObraOrigen { get; set; }
        public Nullable<decimal> CotizacionEuro { get; set; }
        public string TipoGrabacion { get; set; }
        public Nullable<int> IdProvinciaDestino { get; set; }
        public string CalculaSUSS { get; set; }
        public Nullable<decimal> RetencionIVAComprobantesM { get; set; }
        public Nullable<int> IdUsuarioAnulo { get; set; }
        public Nullable<System.DateTime> FechaAnulacion { get; set; }
        public string MotivoAnulacion { get; set; }
        public Nullable<int> NumeroRendicionFF { get; set; }
        public string ConfirmacionAcreditacionFF { get; set; }
        public string OPInicialFF { get; set; }
        public Nullable<int> IdConcepto { get; set; }
        public Nullable<int> IdConcepto2 { get; set; }
        public string FormaAnulacionCheques { get; set; }
        public string Detalle { get; set; }
        public string RecalculoRetencionesUltimaModificacion { get; set; }
        public Nullable<int> IdImpuestoDirecto { get; set; }
        public Nullable<int> NumeroReciboProveedor { get; set; }
        public Nullable<System.DateTime> FechaReciboProveedor { get; set; }
        public string TextoAuxiliar1 { get; set; }
        public string TextoAuxiliar2 { get; set; }
        public string TextoAuxiliar3 { get; set; }
        public string IdsComprobanteProveedorRetenidosIva { get; set; }
        public string TotalesImportesRetenidosIva { get; set; }
        public string ReversionContablePorAnulacion { get; set; }
        public string ArchivoAdjunto1 { get; set; }
        public string ArchivoAdjunto2 { get; set; }
        public Nullable<System.DateTime> FechaReversionContablePorAnulacion { get; set; }
        public Nullable<int> IdTipoRetencionGanancia { get; set; }
        public string CuitOpcional { get; set; }
        public Nullable<int> IdPuntoVenta { get; set; }
        public Nullable<int> PuntoVenta { get; set; }
        public string DocumentacionCompleta { get; set; }
        public byte[] FechaTimeStamp { get; set; }
        public Nullable<decimal> RetencionOTROS { get; set; }
    
        public virtual Proveedor Proveedore { get; set; }
        public virtual ICollection<DetalleOrdenesPago> DetalleOrdenesPagoes { get; set; }
        public virtual ICollection<DetalleOrdenesPagoCuenta> DetalleOrdenesPagoCuentas { get; set; }
        public virtual ICollection<DetalleOrdenesPagoImpuesto> DetalleOrdenesPagoImpuestos { get; set; }
        public virtual ICollection<DetalleOrdenesPagoRubrosContable> DetalleOrdenesPagoRubrosContables { get; set; }
        public virtual ICollection<DetalleOrdenesPagoValore> DetalleOrdenesPagoValores { get; set; }
        public virtual Cuenta Cuenta { get; set; }
        public virtual Concepto Concepto { get; set; }
        public virtual Concepto Concepto1 { get; set; }
        public virtual Empleado Empleado { get; set; }
        public virtual Empleado Empleado1 { get; set; }
        public virtual Empleado Empleado2 { get; set; }
        public virtual Empleado Empleado3 { get; set; }
        public virtual Moneda Moneda { get; set; }
        public virtual Obra Obra { get; set; }
        public virtual ICollection<OrdenPago> OrdenesPago1 { get; set; }
        public virtual OrdenPago OrdenesPago2 { get; set; }
    }
}
