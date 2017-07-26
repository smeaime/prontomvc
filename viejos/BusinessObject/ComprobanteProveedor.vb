Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ComprobanteProveedor

        Private _Id As Integer = -1

        Private _IdProveedor As Integer = 0
        Private _IdTipoComprobante As Integer = 0
        Private _FechaComprobante As DateTime = DateTime.MinValue
        Private _Letra As String = String.Empty
        Private _NumeroComprobante1 As Integer = 0
        Private _NumeroComprobante2 As Integer = 0
        Private _NumeroReferencia As Integer = 0
        Private _FechaRecepcion As DateTime = DateTime.MinValue
        Private _FechaVencimiento As DateTime = DateTime.MinValue
        Private _TotalBruto As Double = 0
        Private _TotalIva1 As Double = 0
        Private _TotalIva2 As Double = 0
        Private _TotalBonificacion As Double = 0
        Private _TotalComprobante As Double = 0
        Private _PorcentajeBonificacion As Double = 0
        Private _Observaciones As String = String.Empty
        Private _DiasVencimiento As Integer = 0
        Private _IdObra As Integer = 0
        Private _IdProveedorEventual As Integer = 0
        Private _IdOrdenPago As Integer = 0
        Private _IdCuenta As Integer = 0
        Private _IdMoneda As Integer = 0
        Private _CotizacionMoneda As Double = 0
        Private _CotizacionDolar As Double = 0
        Private _TotalIVANoDiscriminado As Double = 0
        Private _IdCuentaIvaCompras1 As Integer = 0
        Private _IVAComprasPorcentaje1 As Double = 0
        Private _IVAComprasImporte1 As Double = 0
        Private _IdCuentaIvaCompras2 As Integer = 0
        Private _IVAComprasPorcentaje2 As Double = 0
        Private _IVAComprasImporte2 As Double = 0
        Private _IdCuentaIvaCompras3 As Integer = 0
        Private _IVAComprasPorcentaje3 As Double = 0
        Private _IVAComprasImporte3 As Double = 0
        Private _IdCuentaIvaCompras4 As Integer = 0
        Private _IVAComprasPorcentaje4 As Double = 0
        Private _IVAComprasImporte4 As Double = 0
        Private _IdCuentaIvaCompras5 As Integer = 0
        Private _IVAComprasPorcentaje5 As Double = 0
        Private _IVAComprasImporte5 As Double = 0
        Private _IdCuentaIvaCompras6 As Integer = 0
        Private _IVAComprasPorcentaje6 As Double = 0
        Private _IVAComprasImporte6 As Double = 0
        Private _IdCuentaIvaCompras7 As Integer = 0
        Private _IVAComprasPorcentaje7 As Double = 0
        Private _IVAComprasImporte7 As Double = 0
        Private _IdCuentaIvaCompras8 As Integer = 0
        Private _IVAComprasPorcentaje8 As Double = 0
        Private _IVAComprasImporte8 As Double = 0
        Private _IdCuentaIvaCompras9 As Integer = 0
        Private _IVAComprasPorcentaje9 As Double = 0
        Private _IVAComprasImporte9 As Double = 0
        Private _IdCuentaIvaCompras10 As Integer = 0
        Private _IVAComprasPorcentaje10 As Double = 0
        Private _IVAComprasImporte10 As Double = 0
        Private _SubtotalGravado As Double = 0
        Private _SubtotalExento As Double = 0
        Private _AjusteIVA As Double = 0
        Private _PorcentajeIVAAplicacionAjuste As Double = 0
        Private _BienesOServicios As String = String.Empty
        Private _IdDetalleOrdenPagoRetencionIVAAplicada As Integer = 0
        Private _IdIBCondicion As Integer = 0
        Private _PRESTOFactura As String = String.Empty
        Private _Confirmado As String = String.Empty
        Private _IdProvinciaDestino As Integer = 0
        Private _IdTipoRetencionGanancia As Integer = 0
        Private _NumeroCAI As String = String.Empty
        Private _FechaVencimientoCAI As DateTime = DateTime.MinValue
        Private _IdCodigoAduana As Integer = 0
        Private _IdCodigoDestinacion As Integer = 0
        Private _NumeroDespacho As Integer = 0
        Private _DigitoVerificadorNumeroDespacho As String = String.Empty
        Private _FechaDespachoAPlaza As DateTime = DateTime.MinValue
        Private _IdUsuarioIngreso As Integer = 0
        Private _FechaIngreso As DateTime = DateTime.MinValue
        Private _IdUsuarioModifico As Integer = 0
        Private _FechaModifico As DateTime = DateTime.MinValue
        Private _PRESTOProveedor As String = String.Empty
        Private _IdCodigoIva As Integer = 0
        Private _CotizacionEuro As Double = 0
        Private _IdCondicionCompra As Integer = 0
        Private _Importacion_FOB As Double = 0
        Private _Importacion_PosicionAduana As String = String.Empty
        Private _Importacion_Despacho As String = String.Empty
        Private _Importacion_Guia As String = String.Empty
        Private _Importacion_IdPaisOrigen As Integer = 0
        Private _Importacion_FechaEmbarque As DateTime = DateTime.MinValue
        Private _Importacion_FechaOficializacion As DateTime = DateTime.MinValue
        Private _REP_CTAPRO_INS As String = String.Empty
        Private _REP_CTAPRO_UPD As String = String.Empty
        Private _InformacionAuxiliar As String = String.Empty
        Private _GravadoParaSUSS As Double = 0
        Private _PorcentajeParaSUSS As Double = 0
        Private _FondoReparo As Double = 0
        Private _AutoincrementarNumeroReferencia As String = String.Empty
        Private _ReintegroImporte As Double = 0
        Private _ReintegroDespacho As String = String.Empty
        Private _ReintegroIdMoneda As Integer = 0
        Private _ReintegroIdCuenta As Integer = 0
        Private _PrestoDestino As String = String.Empty
        Private _IdFacturaVenta_RecuperoGastos As Integer = 0
        Private _IdNotaCreditoVenta_RecuperoGastos As Integer = 0
        Private _IdComprobanteImputado As Integer = 0
        Private _IdCuentaOtros As Integer = 0
        Private _PRESTOFechaProceso As DateTime = DateTime.MinValue
        Private _DestinoPago As String = String.Empty
        Private _NumeroRendicionFF As Integer = 0
        Private _Cuit As String = String.Empty
        Private _FechaAsignacionPresupuesto As DateTime = DateTime.MinValue
        Private _Dolarizada As String = String.Empty
        Private _NumeroOrdenPagoFondoReparo As Integer = 0
        Private _IdListaPrecios As Integer = 0
        Private _IdComprobanteProveedorOriginal As Integer = 0
        Private _PorcentajeIVAParaMonotributistas As Double = 0
        Private _IdDiferenciaCambio As Integer = 0
        Public TomarEnCuboDeGastos As String = String.Empty

        Public CircuitoFirmasCompleto As String = String.Empty
        Public IdLiquidacionFlete As Integer = 0
        Public NumeroCAE As String = String.Empty

        Private _ConfirmadoPorWeb As String = String.Empty

        Private _Detalles As ComprobanteProveedorItemList = New ComprobanteProveedorItemList
        Public DetallesProvincias As ComprobanteProveedorPrvItemList = New ComprobanteProveedorPrvItemList


        Private _Proveedor As String = String.Empty
        Private _ProveedorEventual As String = String.Empty
        Private _Cuenta As String = String.Empty



        Public Property ConfirmadoPorWeb() As String
            Get
                Return _ConfirmadoPorWeb
            End Get
            Set(ByVal value As String)
                _ConfirmadoPorWeb = value
            End Set
        End Property


        Public Property Proveedor() As String
            Get
                Return _Proveedor
            End Get
            Set(ByVal value As String)
                _Proveedor = value
            End Set
        End Property
        Public Property ProveedorEventual() As String
            Get
                Return _ProveedorEventual
            End Get
            Set(ByVal value As String)
                _ProveedorEventual = value
            End Set
        End Property

        Public Property Cuenta() As String
            Get
                Return _Cuenta
            End Get
            Set(ByVal value As String)
                _Cuenta = value
            End Set
        End Property



































        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property
        Public Property IdProveedor() As Integer
            Get
                Return _IdProveedor
            End Get
            Set(ByVal value As Integer)
                _IdProveedor = value
            End Set
        End Property

        Public Property IdTipoComprobante() As Integer
            Get
                Return _IdTipoComprobante
            End Get
            Set(ByVal value As Integer)
                _IdTipoComprobante = value
            End Set
        End Property
        Public Property FechaComprobante() As DateTime
            Get
                Return _FechaComprobante
            End Get
            Set(ByVal value As DateTime)
                _FechaComprobante = value
            End Set
        End Property
        Public ReadOnly Property Numero() As String
            Get
                Return _Letra & "-" & String.Format("{0:0000}", _NumeroComprobante1) & "-" & String.Format("{0:00000000}", _NumeroComprobante2)
            End Get
        End Property
        Public Property Letra() As String
            Get
                Return _Letra
            End Get
            Set(ByVal value As String)
                _Letra = value
            End Set
        End Property
        Public Property NumeroComprobante1() As Integer
            Get
                Return _NumeroComprobante1
            End Get
            Set(ByVal value As Integer)
                _NumeroComprobante1 = value
            End Set
        End Property
        Public Property NumeroComprobante2() As Integer
            Get
                Return _NumeroComprobante2
            End Get
            Set(ByVal value As Integer)
                _NumeroComprobante2 = value
            End Set
        End Property
        Public Property NumeroReferencia() As Integer
            Get
                Return _NumeroReferencia
            End Get
            Set(ByVal value As Integer)
                _NumeroReferencia = value
            End Set
        End Property
        Public Property FechaRecepcion() As DateTime
            Get
                Return _FechaRecepcion
            End Get
            Set(ByVal value As DateTime)
                _FechaRecepcion = value
            End Set
        End Property
        Public Property FechaVencimiento() As DateTime
            Get
                Return _FechaVencimiento
            End Get
            Set(ByVal value As DateTime)
                _FechaVencimiento = value
            End Set
        End Property
        Public Property TotalBruto() As Double
            Get
                Return _TotalBruto
            End Get
            Set(ByVal value As Double)
                _TotalBruto = value
            End Set
        End Property
        Public Property TotalIva1() As Double
            Get
                Return _TotalIva1
            End Get
            Set(ByVal value As Double)
                _TotalIva1 = value
            End Set
        End Property
        Public Property TotalIva2() As Double
            Get
                Return _TotalIva2
            End Get
            Set(ByVal value As Double)
                _TotalIva2 = value
            End Set
        End Property
        Public Property TotalBonificacion() As Double
            Get
                Return _TotalBonificacion
            End Get
            Set(ByVal value As Double)
                _TotalBonificacion = value
            End Set
        End Property
        Public Property TotalComprobante() As Double
            Get
                Return _TotalComprobante
            End Get
            Set(ByVal value As Double)
                _TotalComprobante = value
            End Set
        End Property
        Public Property PorcentajeBonificacion() As Double
            Get
                Return _PorcentajeBonificacion
            End Get
            Set(ByVal value As Double)
                _PorcentajeBonificacion = value
            End Set
        End Property
        Public Property Observaciones() As String
            Get
                Return _Observaciones
            End Get
            Set(ByVal value As String)
                _Observaciones = value
            End Set
        End Property
        Public Property DiasVencimiento() As Integer
            Get
                Return _DiasVencimiento
            End Get
            Set(ByVal value As Integer)
                _DiasVencimiento = value
            End Set
        End Property
        Public Property IdObra() As Integer
            Get
                Return _IdObra
            End Get
            Set(ByVal value As Integer)
                _IdObra = value
            End Set
        End Property
        Public Property IdProveedorEventual() As Integer
            Get
                Return _IdProveedorEventual
            End Get
            Set(ByVal value As Integer)
                _IdProveedorEventual = value
            End Set
        End Property

        Public Property IdOrdenPago() As Integer
            Get
                Return _IdOrdenPago
            End Get
            Set(ByVal value As Integer)
                _IdOrdenPago = value
            End Set
        End Property
        Public Property IdCuenta() As Integer
            Get
                Return _IdCuenta
            End Get
            Set(ByVal value As Integer)
                _IdCuenta = value
            End Set
        End Property

        Public Property IdMoneda() As Integer
            Get
                Return _IdMoneda
            End Get
            Set(ByVal value As Integer)
                _IdMoneda = value
            End Set
        End Property
        Public Property CotizacionMoneda() As Double
            Get
                Return _CotizacionMoneda
            End Get
            Set(ByVal value As Double)
                _CotizacionMoneda = value
            End Set
        End Property
        Public Property CotizacionDolar() As Double
            Get
                Return _CotizacionDolar
            End Get
            Set(ByVal value As Double)
                _CotizacionDolar = value
            End Set
        End Property
        Public Property TotalIVANoDiscriminado() As Double
            Get
                Return _TotalIVANoDiscriminado
            End Get
            Set(ByVal value As Double)
                _TotalIVANoDiscriminado = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras1() As Integer
            Get
                Return _IdCuentaIvaCompras1
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras1 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje1() As Double
            Get
                Return _IVAComprasPorcentaje1
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje1 = value
            End Set
        End Property
        Public Property IVAComprasImporte1() As Double
            Get
                Return _IVAComprasImporte1
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte1 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras2() As Integer
            Get
                Return _IdCuentaIvaCompras2
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras2 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje2() As Double
            Get
                Return _IVAComprasPorcentaje2
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje2 = value
            End Set
        End Property
        Public Property IVAComprasImporte2() As Double
            Get
                Return _IVAComprasImporte2
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte2 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras3() As Integer
            Get
                Return _IdCuentaIvaCompras3
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras3 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje3() As Double
            Get
                Return _IVAComprasPorcentaje3
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje3 = value
            End Set
        End Property
        Public Property IVAComprasImporte3() As Double
            Get
                Return _IVAComprasImporte3
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte3 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras4() As Integer
            Get
                Return _IdCuentaIvaCompras4
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras4 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje4() As Double
            Get
                Return _IVAComprasPorcentaje4
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje4 = value
            End Set
        End Property
        Public Property IVAComprasImporte4() As Double
            Get
                Return _IVAComprasImporte4
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte4 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras5() As Integer
            Get
                Return _IdCuentaIvaCompras5
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras5 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje5() As Double
            Get
                Return _IVAComprasPorcentaje5
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje5 = value
            End Set
        End Property
        Public Property IVAComprasImporte5() As Double
            Get
                Return _IVAComprasImporte5
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte5 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras6() As Integer
            Get
                Return _IdCuentaIvaCompras6
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras6 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje6() As Double
            Get
                Return _IVAComprasPorcentaje6
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje6 = value
            End Set
        End Property
        Public Property IVAComprasImporte6() As Double
            Get
                Return _IVAComprasImporte6
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte6 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras7() As Integer
            Get
                Return _IdCuentaIvaCompras7
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras7 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje7() As Double
            Get
                Return _IVAComprasPorcentaje7
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje7 = value
            End Set
        End Property
        Public Property IVAComprasImporte7() As Double
            Get
                Return _IVAComprasImporte7
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte7 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras8() As Integer
            Get
                Return _IdCuentaIvaCompras8
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras8 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje8() As Double
            Get
                Return _IVAComprasPorcentaje8
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje8 = value
            End Set
        End Property
        Public Property IVAComprasImporte8() As Double
            Get
                Return _IVAComprasImporte8
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte8 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras9() As Integer
            Get
                Return _IdCuentaIvaCompras9
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras9 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje9() As Double
            Get
                Return _IVAComprasPorcentaje9
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje9 = value
            End Set
        End Property
        Public Property IVAComprasImporte9() As Double
            Get
                Return _IVAComprasImporte9
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte9 = value
            End Set
        End Property
        Public Property IdCuentaIvaCompras10() As Integer
            Get
                Return _IdCuentaIvaCompras10
            End Get
            Set(ByVal value As Integer)
                _IdCuentaIvaCompras10 = value
            End Set
        End Property
        Public Property IVAComprasPorcentaje10() As Double
            Get
                Return _IVAComprasPorcentaje10
            End Get
            Set(ByVal value As Double)
                _IVAComprasPorcentaje10 = value
            End Set
        End Property
        Public Property IVAComprasImporte10() As Double
            Get
                Return _IVAComprasImporte10
            End Get
            Set(ByVal value As Double)
                _IVAComprasImporte10 = value
            End Set
        End Property
        Public Property SubtotalGravado() As Double
            Get
                Return _SubtotalGravado
            End Get
            Set(ByVal value As Double)
                _SubtotalGravado = value
            End Set
        End Property
        Public Property SubtotalExento() As Double
            Get
                Return _SubtotalExento
            End Get
            Set(ByVal value As Double)
                _SubtotalExento = value
            End Set
        End Property
        Public Property AjusteIVA() As Double
            Get
                Return _AjusteIVA
            End Get
            Set(ByVal value As Double)
                _AjusteIVA = value
            End Set
        End Property
        Public Property PorcentajeIVAAplicacionAjuste() As Double
            Get
                Return _PorcentajeIVAAplicacionAjuste
            End Get
            Set(ByVal value As Double)
                _PorcentajeIVAAplicacionAjuste = value
            End Set
        End Property
        Public Property BienesOServicios() As String
            Get
                Return _BienesOServicios
            End Get
            Set(ByVal value As String)
                _BienesOServicios = value
            End Set
        End Property
        Public Property IdDetalleOrdenPagoRetencionIVAAplicada() As Integer
            Get
                Return _IdDetalleOrdenPagoRetencionIVAAplicada
            End Get
            Set(ByVal value As Integer)
                _IdDetalleOrdenPagoRetencionIVAAplicada = value
            End Set
        End Property
        Public Property IdIBCondicion() As Integer
            Get
                Return _IdIBCondicion
            End Get
            Set(ByVal value As Integer)
                _IdIBCondicion = value
            End Set
        End Property
        Public Property PRESTOFactura() As String
            Get
                Return _PRESTOFactura
            End Get
            Set(ByVal value As String)
                _PRESTOFactura = value
            End Set
        End Property
        Public Property Confirmado() As String
            Get
                Return _Confirmado
            End Get
            Set(ByVal value As String)
                _Confirmado = value
            End Set
        End Property
        Public Property IdProvinciaDestino() As Integer
            Get
                Return _IdProvinciaDestino
            End Get
            Set(ByVal value As Integer)
                _IdProvinciaDestino = value
            End Set
        End Property
        Public Property IdTipoRetencionGanancia() As Integer
            Get
                Return _IdTipoRetencionGanancia
            End Get
            Set(ByVal value As Integer)
                _IdTipoRetencionGanancia = value
            End Set
        End Property
        Public Property NumeroCAI() As String
            Get
                Return _NumeroCAI
            End Get
            Set(ByVal value As String)
                _NumeroCAI = value
            End Set
        End Property
        Public Property FechaVencimientoCAI() As DateTime
            Get
                Return _FechaVencimientoCAI
            End Get
            Set(ByVal value As DateTime)
                _FechaVencimientoCAI = value
            End Set
        End Property
        Public Property IdCodigoAduana() As Integer
            Get
                Return _IdCodigoAduana
            End Get
            Set(ByVal value As Integer)
                _IdCodigoAduana = value
            End Set
        End Property
        Public Property IdCodigoDestinacion() As Integer
            Get
                Return _IdCodigoDestinacion
            End Get
            Set(ByVal value As Integer)
                _IdCodigoDestinacion = value
            End Set
        End Property
        Public Property NumeroDespacho() As Integer
            Get
                Return _NumeroDespacho
            End Get
            Set(ByVal value As Integer)
                _NumeroDespacho = value
            End Set
        End Property
        Public Property DigitoVerificadorNumeroDespacho() As String
            Get
                Return _DigitoVerificadorNumeroDespacho
            End Get
            Set(ByVal value As String)
                _DigitoVerificadorNumeroDespacho = value
            End Set
        End Property
        Public Property FechaDespachoAPlaza() As DateTime
            Get
                Return _FechaDespachoAPlaza
            End Get
            Set(ByVal value As DateTime)
                _FechaDespachoAPlaza = value
            End Set
        End Property
        Public Property IdUsuarioIngreso() As Integer
            Get
                Return _IdUsuarioIngreso
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioIngreso = value
            End Set
        End Property
        Public Property FechaIngreso() As DateTime
            Get
                Return _FechaIngreso
            End Get
            Set(ByVal value As DateTime)
                _FechaIngreso = value
            End Set
        End Property
        Public Property IdUsuarioModifico() As Integer
            Get
                Return _IdUsuarioModifico
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioModifico = value
            End Set
        End Property
        Public Property FechaModifico() As DateTime
            Get
                Return _FechaModifico
            End Get
            Set(ByVal value As DateTime)
                _FechaModifico = value
            End Set
        End Property
        Public Property PRESTOProveedor() As String
            Get
                Return _PRESTOProveedor
            End Get
            Set(ByVal value As String)
                _PRESTOProveedor = value
            End Set
        End Property
        Public Property IdCodigoIva() As Integer
            Get
                Return _IdCodigoIva
            End Get
            Set(ByVal value As Integer)
                _IdCodigoIva = value
            End Set
        End Property
        Public Property CotizacionEuro() As Double
            Get
                Return _CotizacionEuro
            End Get
            Set(ByVal value As Double)
                _CotizacionEuro = value
            End Set
        End Property
        Public Property IdCondicionCompra() As Integer
            Get
                Return _IdCondicionCompra
            End Get
            Set(ByVal value As Integer)
                _IdCondicionCompra = value
            End Set
        End Property
        Public Property Importacion_FOB() As Double
            Get
                Return _Importacion_FOB
            End Get
            Set(ByVal value As Double)
                _Importacion_FOB = value
            End Set
        End Property
        Public Property Importacion_PosicionAduana() As String
            Get
                Return _Importacion_PosicionAduana
            End Get
            Set(ByVal value As String)
                _Importacion_PosicionAduana = value
            End Set
        End Property
        Public Property Importacion_Despacho() As String
            Get
                Return _Importacion_Despacho
            End Get
            Set(ByVal value As String)
                _Importacion_Despacho = value
            End Set
        End Property
        Public Property Importacion_Guia() As String
            Get
                Return _Importacion_Guia
            End Get
            Set(ByVal value As String)
                _Importacion_Guia = value
            End Set
        End Property
        Public Property Importacion_IdPaisOrigen() As Integer
            Get
                Return _Importacion_IdPaisOrigen
            End Get
            Set(ByVal value As Integer)
                _Importacion_IdPaisOrigen = value
            End Set
        End Property
        Public Property Importacion_FechaEmbarque() As DateTime
            Get
                Return _Importacion_FechaEmbarque
            End Get
            Set(ByVal value As DateTime)
                _Importacion_FechaEmbarque = value
            End Set
        End Property
        Public Property Importacion_FechaOficializacion() As DateTime
            Get
                Return _Importacion_FechaOficializacion
            End Get
            Set(ByVal value As DateTime)
                _Importacion_FechaOficializacion = value
            End Set
        End Property
        Public Property REP_CTAPRO_INS() As String
            Get
                Return _REP_CTAPRO_INS
            End Get
            Set(ByVal value As String)
                _REP_CTAPRO_INS = value
            End Set
        End Property
        Public Property REP_CTAPRO_UPD() As String
            Get
                Return _REP_CTAPRO_UPD
            End Get
            Set(ByVal value As String)
                _REP_CTAPRO_UPD = value
            End Set
        End Property
        Public Property InformacionAuxiliar() As String
            Get
                Return _InformacionAuxiliar
            End Get
            Set(ByVal value As String)
                _InformacionAuxiliar = value
            End Set
        End Property
        Public Property GravadoParaSUSS() As Double
            Get
                Return _GravadoParaSUSS
            End Get
            Set(ByVal value As Double)
                _GravadoParaSUSS = value
            End Set
        End Property
        Public Property PorcentajeParaSUSS() As Double
            Get
                Return _PorcentajeParaSUSS
            End Get
            Set(ByVal value As Double)
                _PorcentajeParaSUSS = value
            End Set
        End Property
        Public Property FondoReparo() As Double
            Get
                Return _FondoReparo
            End Get
            Set(ByVal value As Double)
                _FondoReparo = value
            End Set
        End Property
        Public Property AutoincrementarNumeroReferencia() As String
            Get
                Return _AutoincrementarNumeroReferencia
            End Get
            Set(ByVal value As String)
                _AutoincrementarNumeroReferencia = value
            End Set
        End Property
        Public Property ReintegroImporte() As Double
            Get
                Return _ReintegroImporte
            End Get
            Set(ByVal value As Double)
                _ReintegroImporte = value
            End Set
        End Property
        Public Property ReintegroDespacho() As String
            Get
                Return _ReintegroDespacho
            End Get
            Set(ByVal value As String)
                _ReintegroDespacho = value
            End Set
        End Property
        Public Property ReintegroIdMoneda() As Integer
            Get
                Return _ReintegroIdMoneda
            End Get
            Set(ByVal value As Integer)
                _ReintegroIdMoneda = value
            End Set
        End Property
        Public Property ReintegroIdCuenta() As Integer
            Get
                Return _ReintegroIdCuenta
            End Get
            Set(ByVal value As Integer)
                _ReintegroIdCuenta = value
            End Set
        End Property
        Public Property PrestoDestino() As String
            Get
                Return _PrestoDestino
            End Get
            Set(ByVal value As String)
                _PrestoDestino = value
            End Set
        End Property
        Public Property IdFacturaVenta_RecuperoGastos() As Integer
            Get
                Return _IdFacturaVenta_RecuperoGastos
            End Get
            Set(ByVal value As Integer)
                _IdFacturaVenta_RecuperoGastos = value
            End Set
        End Property
        Public Property IdNotaCreditoVenta_RecuperoGastos() As Integer
            Get
                Return _IdNotaCreditoVenta_RecuperoGastos
            End Get
            Set(ByVal value As Integer)
                _IdNotaCreditoVenta_RecuperoGastos = value
            End Set
        End Property
        Public Property IdComprobanteImputado() As Integer
            Get
                Return _IdComprobanteImputado
            End Get
            Set(ByVal value As Integer)
                _IdComprobanteImputado = value
            End Set
        End Property
        Public Property IdCuentaOtros() As Integer
            Get
                Return _IdCuentaOtros
            End Get
            Set(ByVal value As Integer)
                _IdCuentaOtros = value
            End Set
        End Property
        Public Property PRESTOFechaProceso() As DateTime
            Get
                Return _PRESTOFechaProceso
            End Get
            Set(ByVal value As DateTime)
                _PRESTOFechaProceso = value
            End Set
        End Property
        Public Property DestinoPago() As String
            Get
                Return _DestinoPago
            End Get
            Set(ByVal value As String)
                _DestinoPago = value
            End Set
        End Property
        Public Property NumeroRendicionFF() As Integer
            Get
                Return _NumeroRendicionFF
            End Get
            Set(ByVal value As Integer)
                _NumeroRendicionFF = value
            End Set
        End Property
        Public Property Cuit() As String
            Get
                Return _Cuit
            End Get
            Set(ByVal value As String)
                _Cuit = value
            End Set
        End Property
        Public Property FechaAsignacionPresupuesto() As DateTime
            Get
                Return _FechaAsignacionPresupuesto
            End Get
            Set(ByVal value As DateTime)
                _FechaAsignacionPresupuesto = value
            End Set
        End Property
        Public Property Dolarizada() As String
            Get
                Return _Dolarizada
            End Get
            Set(ByVal value As String)
                _Dolarizada = value
            End Set
        End Property
        Public Property NumeroOrdenPagoFondoReparo() As Integer
            Get
                Return _NumeroOrdenPagoFondoReparo
            End Get
            Set(ByVal value As Integer)
                _NumeroOrdenPagoFondoReparo = value
            End Set
        End Property
        Public Property IdListaPrecios() As Integer
            Get
                Return _IdListaPrecios
            End Get
            Set(ByVal value As Integer)
                _IdListaPrecios = value
            End Set
        End Property
        Public Property IdComprobanteProveedorOriginal() As Integer
            Get
                Return _IdComprobanteProveedorOriginal
            End Get
            Set(ByVal value As Integer)
                _IdComprobanteProveedorOriginal = value
            End Set
        End Property
        Public Property PorcentajeIVAParaMonotributistas() As Double
            Get
                Return _PorcentajeIVAParaMonotributistas
            End Get
            Set(ByVal value As Double)
                _PorcentajeIVAParaMonotributistas = value
            End Set
        End Property
        Public Property IdDiferenciaCambio() As Integer
            Get
                Return _IdDiferenciaCambio
            End Get
            Set(ByVal value As Integer)
                _IdDiferenciaCambio = value
            End Set
        End Property




        Public Property Detalles() As ComprobanteProveedorItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As ComprobanteProveedorItemList)
                _Detalles = value
            End Set
        End Property


    End Class

End Namespace