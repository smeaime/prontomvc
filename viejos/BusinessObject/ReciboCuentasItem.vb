Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ReciboCuentasItem
        Private _Id As Integer = -1
        Private _IdRecibo As Integer = -1

        Public IdCuenta As Integer = 0
        Public _CodigoCuenta As String = String.Empty
        Public _Debe As Double = 0
        Public _Haber As Double = 0
        Public IdObra As Integer = 0
        Public IdCuentaGasto As Integer = 0
        Public IdCuentaBancaria As Integer = 0
        Public IdCaja As Integer = 0
        Public IdMoneda As Integer = 0
        Public CotizacionMonedaDestino As Double = 0
        Public EnviarEmail As Integer = 0
        Public IdOrigenTransmision As Integer = 0
        Public IdReciboOriginal As Integer = 0
        Public IdDetalleReciboCuentasOriginal As Integer = 0
        Public FechaImportacionTransmision As DateTime = DateTime.MinValue

        Public _DescripcionCuenta As String = String.Empty

        Public Property CodigoCuenta() As String
            Get
                Return _CodigoCuenta
            End Get
            Set(ByVal value As String)
                _CodigoCuenta = value
            End Set
        End Property
        Public Property DescripcionCuenta() As String
            Get
                Return _DescripcionCuenta
            End Get
            Set(ByVal value As String)
                _DescripcionCuenta = value
            End Set
        End Property
        Public Property Debe() As Double
            Get
                Return _Debe
            End Get
            Set(ByVal value As Double)
                _Debe = value
            End Set
        End Property
        Public Property Haber() As Double
            Get
                Return _Haber
            End Get
            Set(ByVal value As Double)
                _Haber = value
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

        Public Property IdRecibo() As Integer
            Get
                Return _IdRecibo
            End Get
            Set(ByVal value As Integer)
                _IdRecibo = value
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