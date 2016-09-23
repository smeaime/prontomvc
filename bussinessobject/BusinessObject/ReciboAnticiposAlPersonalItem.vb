Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ReciboAnticiposAlPersonalItem


        Private _Id As Integer = -1

        Private _IdOrdenPago As Integer = -1
        Public IdEmpleado As Integer = -1
        Public IdAsiento As Integer = -1
        Public IdRecibo As Integer = -1

        Public Importe As Double = 0
        Public CantidadCuotas As Integer = -1
        Public Detalle As String = String.Empty







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