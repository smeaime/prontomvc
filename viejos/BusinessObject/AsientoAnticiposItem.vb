Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class AsientoAnticiposItem
        Private _Id As Integer = -1



        Private _IdOrdenPago As Integer = -1
        Private _IdEmpleado As Integer = -1
        Private _IdAsiento As Integer = -1
        Private _IdRecibo As Integer = -1

        Private _Importe As Double = 0

        '
        'This is the IdEmpleado property.
        '
        Public Property IdEmpleado() As Integer
            Get
                Return _IdEmpleado
            End Get
            Set(ByVal Value As Integer)
                _IdEmpleado = Value
            End Set
        End Property

        '
        'This is the IdAsiento property.
        '
        Public Property IdAsiento() As Integer
            Get
                Return _IdAsiento
            End Get
            Set(ByVal Value As Integer)
                _IdAsiento = Value
            End Set
        End Property

        '
        'This is the IdRecibo property.
        '
        Public Property IdRecibo() As Integer
            Get
                Return _IdRecibo
            End Get
            Set(ByVal Value As Integer)
                _IdRecibo = Value
            End Set
        End Property

        '
        'This is the Importe property.
        '
        Public Property Importe() As Double
            Get
                Return _Importe
            End Get
            Set(ByVal Value As Double)
                _Importe = Value
            End Set
        End Property
        Private _CantidadCuotas As Integer = -1

        '
        'This is the CantidadCuotas property.
        '
        Public Property CantidadCuotas() As Integer
            Get
                Return _CantidadCuotas
            End Get
            Set(ByVal Value As Integer)
                _CantidadCuotas = Value
            End Set
        End Property

        Private _Detalle As String = String.Empty

        '
        'This is the Detalle property.
        '
        Public Property Detalle() As String
            Get
                Return _Detalle
            End Get
            Set(ByVal Value As String)
                _Detalle = Value
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

        Public Property IdOrdenPago() As Integer
            Get
                Return _IdOrdenPago
            End Get
            Set(ByVal value As Integer)
                _IdOrdenPago = value
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