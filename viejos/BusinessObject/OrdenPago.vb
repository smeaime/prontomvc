Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenPago
        Private _Id As Integer = -1

        Public NumeroOrdenPago As Long
        Public FechaOrdenPago As Date
        Public IdProveedor As Long
        Public Efectivo As Double
        Public Descuentos As Double
        Public Valores As Double
        Public Documentos As Double
        Public Otros1 As Double
        Public IdCuenta1 As Long
        Public Otros2 As Double
        Public IdCuenta2 As Long
        Public Otros3 As Double
        Public IdCuenta3 As Long
        Public Acreedores As Double
        Public RetencionIVA As Double
        Public RetencionGanancias As Double
        Public RetencionIBrutos As Double
        Public GastosGenerales As Double

        Public Estado As tipoEstado
        Enum tipoEstado
            CA
            EN
            FI
        End Enum


        Public Tipo As tipoOP
        Enum tipoOP
            CC
            FF
            OT
        End Enum

        Public IdCuenta As Long
        Public Anulada As String
        Public CotizacionDolar As Double
        Public Dolarizada As String
        Public Exterior As String
        Public NumeroCertificadoRetencionGanancias As Long
        Public BaseGanancias As Double
        Public IdMoneda As Long
        Public CotizacionMoneda As Double
        Public AsientoManual As String
        Public Observaciones As String
        Public IdObra As Long
        Public IdCuentaGasto As Long
        Public DiferenciaBalanceo As Double
        Public IdOPComplementariaFF As Long
        Public IdEmpleadoFF As Long
        Public NumeroCertificadoRetencionIVA As Long
        Public NumeroCertificadoRetencionIIBB As Long
        Public RetencionSUSS As Double
        Public NumeroCertificadoRetencionSUSS As Long
        Public TipoOperacionOtros As Long
        Public IdUsuarioIngreso As Long
        Public FechaIngreso As Date
        Public IdUsuarioModifico As Long
        Public FechaModifico As Date
        Public Confirmado As String
        Public IdObraOrigen As Long
        Public CotizacionEuro As Double
        Public TipoGrabacion As String
        Public IdProvinciaDestino As Long
        Public CalculaSUSS As String
        Public RetencionIVAComprobantesM As Double
        Public IdUsuarioAnulo As Long
        Public FechaAnulacion As Date
        Public MotivoAnulacion As String
        Public NumeroRendicionFF As Long
        Public ConfirmacionAcreditacionFF As String
        Public OPInicialFF As String
        Public IdConcepto As Long
        Public IdConcepto2 As Long
        Public FormaAnulacionCheques As String
        Public Detalle As String
        Public RecalculoRetencionesUltimaModificacion As String
        Public IdImpuestoDirecto As Long
        Public NumeroReciboProveedor As Long
        Public FechaReciboProveedor As Date

        Public TotalOPcomplementaria As Double
        Public TotalGastos As Double

        
        Enum tipoOrdenPago
            CC 'de clientes
            OT 'de otros (para usar una cuenta cualquiera)
        End Enum




        Private _Detalles As OrdenPagoItemList = New OrdenPagoItemList
        Public DetallesAnticiposAlPersonal As OrdenPagoAnticiposAlPersonalItemList = New OrdenPagoAnticiposAlPersonalItemList
        Public DetallesValores As OrdenPagoValoresItemList = New OrdenPagoValoresItemList
        Public DetallesCuentas As OrdenPagoCuentasItemList = New OrdenPagoCuentasItemList
        Public DetallesRubrosContables As OrdenPagoRubrosContablesItemList = New OrdenPagoRubrosContablesItemList
        Public DetallesImpuestos As OrdenPagoImpuestosItemList = New OrdenPagoImpuestosItemList






        Private _DirectoACompras As String = String.Empty



        Public __COMPRONTO_OrdenPago 'As ComPronto.OrdenPago




        'Agregado para web
        Private _FechaCierreCompulsa As Date = Date.MinValue
        Private _ConfirmadoPorWeb As String = String.Empty
        Private _FechaRespuestaWeb As Date = Date.MinValue
        Private _NombreUsuarioWeb As String = String.Empty


        Public TotalImputaciones = 0
        Public TotalDebe = 0
        Public TotalHaber = 0
        Public TotalValores = 0
        Public TotalRubrosContables = 0
        Public TotalOtrosConceptos = 0
        Public TotalAnticipos = 0
        Public TotalDiferencia = 0

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        'Public Property Numero() As Integer
        '    Get
        '        Return __COMPRONTO_OrdenPago.Registro.Fields("NumeroOrdenPago").Value
        '    End Get
        '    Set(ByVal value As Integer)
        '        __COMPRONTO_OrdenPago.Registro.Fields("NumeroOrdenPago").Value = value
        '    End Set
        'End Property



        Public Property ConfirmadoPorWeb() As String
            Get
                Return _ConfirmadoPorWeb
            End Get
            Set(ByVal value As String)
                _ConfirmadoPorWeb = value
            End Set
        End Property

        Public Property DirectoACompras() As String
            Get
                Return _DirectoACompras
            End Get
            Set(ByVal value As String)
                _DirectoACompras = value
            End Set
        End Property



        Public Property DetallesImputaciones() As OrdenPagoItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As OrdenPagoItemList)
                _Detalles = value
            End Set
        End Property


        Public Function BuscarRenglonPorIdDetalle(ByVal id As Integer) As OrdenPagoItem
            If _Detalles.Count = 0 Then
                Throw New ApplicationException("No hay detalle. Verificar que el objeto fue cargado con el parametro TraerDetalle en True")
            Else
                Return _Detalles.Find(Function(obj) obj.Id = id)
            End If
        End Function

    End Class

End Namespace