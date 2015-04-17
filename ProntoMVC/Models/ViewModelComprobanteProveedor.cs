﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using System.Web.Mvc;
using System.Web.Security;

using ProntoMVC.Data.Models;


namespace ProntoMVC.ViewModels
{


    public class ViewModelComprobanteProveedor : ProntoMVC.Data.Models.ComprobanteProveedor
    {



        public int IdComprobanteProveedor { get; set; }
        public Nullable<int> IdProveedor { get; set; }
        public Nullable<int> IdTipoComprobante { get; set; }
        public Nullable<System.DateTime> FechaComprobante { get; set; }

        public string MetaTipo { get; set; }

        [Required]
        [Display(Name = "Letra del Comprobante")]
        public string Letra { get; set; }
        
        public Nullable<int> NumeroComprobante1 { get; set; }
        public Nullable<int> NumeroComprobante2 { get; set; }
        public Nullable<int> NumeroReferencia { get; set; }
        public Nullable<System.DateTime> FechaRecepcion { get; set; }
        public Nullable<System.DateTime> FechaVencimiento { get; set; }
        public Nullable<decimal> TotalBruto { get; set; }
        public Nullable<decimal> TotalIva1 { get; set; }
        public Nullable<decimal> TotalIva2 { get; set; }
        public Nullable<decimal> TotalBonificacion { get; set; }
        public Nullable<decimal> TotalComprobante { get; set; }
        public Nullable<decimal> PorcentajeBonificacion { get; set; }
        public string Observaciones { get; set; }
        public Nullable<int> DiasVencimiento { get; set; }
        public Nullable<int> IdObra { get; set; }
        public Nullable<int> IdProveedorEventual { get; set; }
        public Nullable<int> IdOrdenPago { get; set; }
        public Nullable<int> IdCuenta { get; set; }
        public Nullable<int> IdMoneda { get; set; }
        public Nullable<decimal> CotizacionMoneda { get; set; }
        public Nullable<decimal> CotizacionDolar { get; set; }
        public Nullable<decimal> TotalIvaNoDiscriminado { get; set; }
        public Nullable<decimal> IVAComprasImporte1 { get; set; }
        public Nullable<int> IdCuentaIvaCompras1 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje1 { get; set; }
        public Nullable<decimal> IVAComprasImporte2 { get; set; }
        public Nullable<int> IdCuentaIvaCompras2 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje2 { get; set; }
        public Nullable<decimal> IVAComprasImporte3 { get; set; }
        public Nullable<int> IdCuentaIvaCompras3 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje3 { get; set; }
        public Nullable<decimal> IVAComprasImporte4 { get; set; }
        public Nullable<int> IdCuentaIvaCompras4 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje4 { get; set; }
        public Nullable<decimal> IVAComprasImporte5 { get; set; }
        public Nullable<int> IdCuentaIvaCompras5 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje5 { get; set; }
        public Nullable<decimal> IVAComprasImporte6 { get; set; }
        public Nullable<int> IdCuentaIvaCompras6 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje6 { get; set; }
        public Nullable<decimal> IVAComprasImporte7 { get; set; }
        public Nullable<int> IdCuentaIvaCompras7 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje7 { get; set; }
        public Nullable<decimal> IVAComprasImporte8 { get; set; }
        public Nullable<int> IdCuentaIvaCompras8 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje8 { get; set; }
        public Nullable<decimal> IVAComprasImporte9 { get; set; }
        public Nullable<int> IdCuentaIvaCompras9 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje9 { get; set; }
        public Nullable<decimal> IVAComprasImporte10 { get; set; }
        public Nullable<int> IdCuentaIvaCompras10 { get; set; }
        public Nullable<decimal> IvaComprasPorcentaje10 { get; set; }
        public Nullable<decimal> SubTotalGravado { get; set; }
        public Nullable<decimal> SubTotalExento { get; set; }
        public Nullable<decimal> AjusteIVA { get; set; }
        public Nullable<decimal> PorcentajeIVAAplicacionAjuste { get; set; }
        public string BienesOServicios { get; set; }
        public Nullable<int> IdDetalleOrdenPagoRetencionIVAAplicada { get; set; }
        public Nullable<int> IdIBCondicion { get; set; }
        public string PRESTOFactura { get; set; }
        public string Confirmado { get; set; }
        public Nullable<int> IdProvinciaDestino { get; set; }
        public Nullable<int> IdTipoRetencionGanancia { get; set; }
        public string NumeroCAI { get; set; }
        public Nullable<System.DateTime> FechaVencimientoCAI { get; set; }
        public Nullable<int> IdCodigoAduana { get; set; }
        public Nullable<int> IdCodigoDestinacion { get; set; }
        public Nullable<int> NumeroDespacho { get; set; }
        public string DigitoVerificadorNumeroDespacho { get; set; }
        public Nullable<System.DateTime> FechaDespachoAPlaza { get; set; }
        public Nullable<int> IdUsuarioIngreso { get; set; }
        public Nullable<System.DateTime> FechaIngreso { get; set; }
        public Nullable<int> IdUsuarioModifico { get; set; }
        public Nullable<System.DateTime> FechaModifico { get; set; }
        public string PRESTOProveedor { get; set; }
        public Nullable<int> IdCodigoIva { get; set; }
        public Nullable<decimal> CotizacionEuro { get; set; }
        public Nullable<int> IdCondicionCompra { get; set; }
        public Nullable<decimal> Importacion_FOB { get; set; }
        public string Importacion_PosicionAduana { get; set; }
        public string Importacion_Despacho { get; set; }
        public string Importacion_Guia { get; set; }
        public Nullable<int> Importacion_IdPaisOrigen { get; set; }
        public Nullable<System.DateTime> Importacion_FechaEmbarque { get; set; }
        public Nullable<System.DateTime> Importacion_FechaOficializacion { get; set; }
        public string REP_CTAPRO_INS { get; set; }
        public string REP_CTAPRO_UPD { get; set; }
        public string InformacionAuxiliar { get; set; }
        public Nullable<decimal> GravadoParaSUSS { get; set; }
        public Nullable<decimal> PorcentajeParaSUSS { get; set; }
        public Nullable<decimal> FondoReparo { get; set; }
        public string AutoincrementarNumeroReferencia { get; set; }
        public Nullable<decimal> ReintegroImporte { get; set; }
        public string ReintegroDespacho { get; set; }
        public Nullable<int> ReintegroIdMoneda { get; set; }
        public Nullable<int> ReintegroIdCuenta { get; set; }
        public string PrestoDestino { get; set; }
        public Nullable<int> IdFacturaVenta_RecuperoGastos { get; set; }
        public Nullable<int> IdNotaCreditoVenta_RecuperoGastos { get; set; }
        public Nullable<int> IdComprobanteImputado { get; set; }
        public Nullable<int> IdCuentaOtros { get; set; }
        public Nullable<System.DateTime> PRESTOFechaProceso { get; set; }
        public string DestinoPago { get; set; }
        public Nullable<int> NumeroRendicionFF { get; set; }
        public string Cuit { get; set; }
        public Nullable<System.DateTime> FechaAsignacionPresupuesto { get; set; }
        public string Dolarizada { get; set; }
        public Nullable<int> NumeroOrdenPagoFondoReparo { get; set; }
        public Nullable<int> IdListaPrecios { get; set; }
        public Nullable<int> IdComprobanteProveedorOriginal { get; set; }
        public Nullable<decimal> PorcentajeIVAParaMonotributistas { get; set; }
        public Nullable<int> IdDiferenciaCambio { get; set; }
        public string TomarEnCuboDeGastos { get; set; }
        public string ConfirmadoPorWeb { get; set; }
        public string CircuitoFirmasCompleto { get; set; }
        public Nullable<int> IdLiquidacionFlete { get; set; }
        public string NumeroCAE { get; set; }
        public Nullable<int> IdImpuestoDirecto { get; set; }
        public Nullable<int> IdPoliza { get; set; }
        public Nullable<int> NumeroCuotaPoliza { get; set; }
        public Nullable<int> IdOrdenPagoRetencionIva { get; set; }
        public Nullable<decimal> ImporteRetencionIvaEnOrdenPago { get; set; }
        public string DebitoAutomatico { get; set; }
        public Nullable<System.DateTime> FechaPrestacionServicio { get; set; }

        public virtual ICollection<DetalleComprobantesProveedore> DetalleComprobantesProveedores { get; set; }
        public virtual Proveedor Proveedor { get; set; }
        public virtual Proveedor Proveedore { get; set; }
        public virtual Cuenta Cuenta { get; set; }
        public virtual Cuenta Cuenta1 { get; set; }
        public virtual Obra Obra { get; set; }
        public virtual DescripcionIva DescripcionIva { get; set; }
    }



    
}
