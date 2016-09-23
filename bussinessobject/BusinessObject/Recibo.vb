Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Recibo
        Private _Id As Integer = -1

        Public NumeroRecibo As Integer = 0
        Public FechaRecibo As DateTime = DateTime.MinValue
        Public IdCliente As Integer = 0
        Public Efectivo As Double = 0
        Public Descuentos As Double = 0
        Public Valores As Double = 0
        Public Documentos As Double = 0
        Public Otros1 As Double = 0
        Public IdCuenta1 As Integer = 0
        Public Otros2 As Double = 0
        Public IdCuenta2 As Integer = 0
        Public Otros3 As Double = 0
        Public IdCuenta3 As Integer = 0
        Public Deudores As Double = 0
        Public RetencionIVA As Double = 0
        Public RetencionGanancias As Double = 0
        Public RetencionIBrutos As Double = 0
        Public GastosGenerales As Double = 0
        Public Cotizacion As Double = 0
        Public Observaciones As String = String.Empty
        Public IdMoneda As Integer = 0
        Public Dolarizada As String = String.Empty
        Public IdObra1 As Integer = 0
        Public IdCuentaGasto1 As Integer = 0
        Public IdObra2 As Integer = 0
        Public IdCuentaGasto2 As Integer = 0
        Public IdObra3 As Integer = 0
        Public IdCuentaGasto3 As Integer = 0
        Public IdObra4 As Integer = 0
        Public IdCuentaGasto4 As Integer = 0
        Public IdCuenta4 As Integer = 0
        Public Otros4 As Double = 0
        Public IdObra5 As Integer = 0
        Public IdCuentaGasto5 As Integer = 0
        Public IdCuenta5 As Integer = 0
        Public Otros5 As Double = 0

        Public Tipo As tipoRecibo
        Enum tipoRecibo
            CC 'de clientes
            OT 'de otros (para usar una cuenta cualquiera)
        End Enum


        Public IdCuenta As Integer = 0
        Public AsientoManual As String = String.Empty
        Public IdObra As Integer = 0
        Public IdCuentaGasto As Integer = 0
        Public NumeroCertificadoRetencionGanancias As Integer = 0
        Public NumeroCertificadoRetencionIVA As Integer = 0
        Public NumeroCertificadoSUSS As Integer = 0
        Public IdTipoRetencionGanancia As Integer = 0
        Public CotizacionMoneda As Double = 0
        Public NumeroCertificadoRetencionIngresosBrutos As Integer = 0

        Public Anulado As EnumPRONTO_SiNo


        Public PuntoVenta As Integer = 0
        Public IdPuntoVenta As Integer = 0
        Public IdUsuarioIngreso As Integer = 0
        Public FechaIngreso As DateTime = DateTime.MinValue
        Public IdUsuarioModifico As Integer = 0
        Public FechaModifico As DateTime = DateTime.MinValue
        Public IdCobrador As Integer = 0
        Public IdVendedor As Integer = 0
        Public Lote As Integer = 0
        Public Sublote As Integer = 0
        Public IdCodigoIvaOpcional As Integer = 0
        Public TipoOperacionOtros As Integer = 0
        Public FechaLote As DateTime = DateTime.MinValue
        Public CuitOpcional As String = String.Empty
        Public IdComprobanteProveedorReintegro As Integer = 0
        Public IdObra6 As Integer = 0
        Public IdCuentaGasto6 As Integer = 0
        Public IdCuenta6 As Integer = 0
        Public Otros6 As Double = 0
        Public IdObra7 As Integer = 0
        Public IdCuentaGasto7 As Integer = 0
        Public IdCuenta7 As Integer = 0
        Public Otros7 As Double = 0
        Public IdObra8 As Integer = 0
        Public IdCuentaGasto8 As Integer = 0
        Public IdCuenta8 As Integer = 0
        Public Otros8 As Double = 0
        Public IdObra9 As Integer = 0
        Public IdCuentaGasto9 As Integer = 0
        Public IdCuenta9 As Integer = 0
        Public Otros9 As Double = 0
        Public IdObra10 As Integer = 0
        Public IdCuentaGasto10 As Integer = 0
        Public IdCuenta10 As Integer = 0
        Public Otros10 As Double = 0
        Public NumeroComprobante1 As Integer = 0
        Public NumeroComprobante2 As Integer = 0
        Public NumeroComprobante3 As Integer = 0
        Public NumeroComprobante4 As Integer = 0
        Public NumeroComprobante5 As Integer = 0
        Public NumeroComprobante6 As Integer = 0
        Public NumeroComprobante7 As Integer = 0
        Public NumeroComprobante8 As Integer = 0
        Public NumeroComprobante9 As Integer = 0
        Public NumeroComprobante10 As Integer = 0
        Public EnviarEmail As Integer = 0
        Public IdOrigenTransmision As Integer = 0
        Public IdReciboOriginal As Integer = 0
        Public FechaImportacionTransmision As DateTime = DateTime.MinValue
        Public CuitClienteTransmision As String = String.Empty
        Public IdProvinciaDestino As Integer = 0
        Public ServicioCobro As String = String.Empty
        Public LoteServicioCobro As String = String.Empty



        Private _Detalles As ReciboItemList = New ReciboItemList
        Public DetallesAnticiposAlPersonal As ReciboAnticiposAlPersonalItemList = New ReciboAnticiposAlPersonalItemList
        Public DetallesValores As ReciboValoresItemList = New ReciboValoresItemList
        Public DetallesCuentas As ReciboCuentasItemList = New ReciboCuentasItemList
        Public DetallesRubrosContables As ReciboRubrosContablesItemList = New ReciboRubrosContablesItemList






        Private _DirectoACompras As String = String.Empty



        Public __COMPRONTO_Recibo 'As ComPronto.Recibo




        'Agregado para web
        Private _FechaCierreCompulsa As DateTime = DateTime.MinValue
        Private _ConfirmadoPorWeb As String = String.Empty
        Private _FechaRespuestaWeb As DateTime = DateTime.MinValue
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
        '        Return __COMPRONTO_Recibo.Registro.Fields("NumeroRecibo").Value
        '    End Get
        '    Set(ByVal value As Integer)
        '        __COMPRONTO_Recibo.Registro.Fields("NumeroRecibo").Value = value
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



        Public Property DetallesImputaciones() As ReciboItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As ReciboItemList)
                _Detalles = value
            End Set
        End Property


        Public Function BuscarRenglonPorIdDetalle(ByVal id As Integer) As ReciboItem
            If _Detalles.Count = 0 Then
                Throw New ApplicationException("No hay detalle. Verificar que el objeto fue cargado con el parametro TraerDetalle en True")
            Else
                Return _Detalles.Find(Function(obj) obj.Id = id)
            End If
        End Function

    End Class

End Namespace