Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenPagoValoresItem
        Private _Id As Integer = -1

        Public IdOrdenPago As Integer = 0
        Public IdTipoValor As Integer = 0
        Public _NumeroValor As Double = 0
        Public _NumeroInterno As Integer = 0
        Public _FechaVencimiento As DateTime = DateTime.MinValue
        Public IdBanco As Integer = 0
        Public _Importe As Double = 0




        Public IdValor As Integer = 0
        Public IdCuentaBancaria As Integer = 0
        Public IdBancoChequera As Integer = 0
        Public IdCaja As Integer = 0
        Public ChequesALaOrdenDe As String = String.Empty
        Public NoALaOrden As String = String.Empty
        Public Anulado As String = String.Empty
        Public IdUsuarioAnulo As Integer = 0
        Public FechaAnulacion As DateTime = DateTime.MinValue
        Public MotivoAnulacion As String = String.Empty
        Public IdTarjetaCredito As Integer = 0




        Public IdCuentaBancariaTransferencia As Integer = 0
        Public IdBancoTransferencia As Integer = 0
        Public NumeroTransferencia As Integer = 0
        Public IdTipoCuentaGrupo As Integer = 0
        Public IdCuenta As Integer = 0

        Public CuitLibrador As String = String.Empty

        Public NumeroTarjetaCredito As String = String.Empty
        Public NumeroAutorizacionTarjetaCredito As Integer = 0
        Public CantidadCuotas As Integer = 0
        Public EnviarEmail As Integer = 0
        Public IdOrigenTransmision As Integer = 0
        Public IdOrdenPagoOriginal As Integer = 0
        Public IdDetalleOrdenPagoValoresOriginal As Integer = 0
        Public FechaImportacionTransmision As DateTime = DateTime.MinValue

        Public _Tipo As String


        Public Property Tipo() As String
            Get
                Return _Tipo
            End Get
            Set(ByVal value As String)
                _Tipo = value
            End Set
        End Property
        Public Property NumeroValor() As Double
            Get
                Return _NumeroValor
            End Get
            Set(ByVal value As Double)
                _NumeroValor = value
            End Set
        End Property
        Public Property NumeroInterno() As Integer
            Get
                Return _NumeroInterno
            End Get
            Set(ByVal value As Integer)
                _NumeroInterno = value
            End Set
        End Property
        Public Property Importe() As Double
            Get
                Return _Importe
            End Get
            Set(ByVal value As Double)
                _Importe = value
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


        Public _Precio As Double = 0   'Ehhhh? No puedo hacer bind desde la grilla a esto porque no tiene property???? http://www.mikepope.com/blog/AddComment.aspx?blogid=1419
        Public _PrecioUnitarioTotal As Double = 0
        Public _PorcentajeBonificacion As Double = 0
        Public _ImporteBonificacion As Double = 0
        Public _PorcentajeIVA As Double = 0
        Public _ImporteIVA As Double = 0
        Public _ImporteTotalItem As Double = 0


        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////

        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
            End Set
        End Property

        Public Property PrecioUnitarioTotal() As Double
            Get
                Return _PrecioUnitarioTotal
            End Get
            Set(ByVal value As Double)
                _PrecioUnitarioTotal = value
            End Set
        End Property


        Public Property ImporteTotalItem() As Double
            Get
                Return _ImporteTotalItem
            End Get
            Set(ByVal value As Double)
                _ImporteTotalItem = value
            End Set
        End Property



        '///////////////////////////////////////















        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property



        Public Property Eliminado() As Boolean
            Get
                Return _Eliminado
            End Get
            Set(ByVal value As Boolean)
                _Eliminado = value
            End Set
        End Property

        Public Property Nuevo() As Boolean
            Get
                Return _Nuevo
            End Get
            Set(ByVal value As Boolean)
                _Nuevo = value
            End Set
        End Property

    End Class
    
End Namespace