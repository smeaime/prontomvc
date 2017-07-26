Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ComparativaItem

        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////
        Private _Codigo As String = String.Empty    ' lo agregué a mano
        Private _Articulo As String = String.Empty  ' lo agregué a mano
        Private _Unidad As String = String.Empty    ' lo agregué a mano


        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False

        Public ProveedorDelPresupuesto As String = String.Empty  'desnormalizado


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

        Public Property Codigo() As String
            Get
                Return _Codigo
            End Get
            Set(ByVal value As String)
                _Codigo = value
            End Set
        End Property

        Public Property Articulo() As String
            Get
                Return _Articulo
            End Get
            Set(ByVal value As String)
                _Articulo = value
            End Set
        End Property

        Public Property Unidad() As String
            Get
                Return _Unidad
            End Get
            Set(ByVal value As String)
                _Unidad = value
            End Set
        End Property
        '///////////////////////////////////////


        Private _Id As Integer = -1
        Private _IdComparativa As Integer = 0
        Private _IdPresupuesto As Integer = 0
        Private _NumeroPresupuesto As Integer = 0
        Private _FechaPresupuesto As DateTime = DateTime.MinValue
        Private _IdArticulo As Integer = 0
        Private _Cantidad As Double = 0
        Private _Precio As Double = 0
        Private _Estado As String = String.Empty
        Private _SubNumero As Integer = 0
        Private _Observaciones As String = String.Empty
        Private _IdUnidad As Integer = 0
        Private _IdMoneda As Integer = 0
        Private _OrigenDescripcion As Integer = 0
        Private _PorcentajeBonificacion As Double = 0
        Private _CotizacionMoneda As Double = 0
        Private _IdDetallePresupuesto As Integer = 0
        Private _Detalles As ComparativaItemList = New ComparativaItemList


        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property
        Public Property IdComparativa() As Integer
            Get
                Return _IdComparativa
            End Get
            Set(ByVal value As Integer)
                _IdComparativa = value
            End Set
        End Property
        Public Property IdPresupuesto() As Integer
            Get
                Return _IdPresupuesto
            End Get
            Set(ByVal value As Integer)
                _IdPresupuesto = value
            End Set
        End Property
        Public Property NumeroPresupuesto() As Integer
            Get
                Return _NumeroPresupuesto
            End Get
            Set(ByVal value As Integer)
                _NumeroPresupuesto = value
            End Set
        End Property
        Public Property FechaPresupuesto() As DateTime
            Get
                Return _FechaPresupuesto
            End Get
            Set(ByVal value As DateTime)
                _FechaPresupuesto = value
            End Set
        End Property
        Public Property IdArticulo() As Integer
            Get
                Return _IdArticulo
            End Get
            Set(ByVal value As Integer)
                _IdArticulo = value
            End Set
        End Property
        Public Property Cantidad() As Double
            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
            End Set
        End Property
        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
            End Set
        End Property
        Public Property Estado() As String
            Get
                Return _Estado
            End Get
            Set(ByVal value As String)
                _Estado = value
            End Set
        End Property
        Public Property SubNumero() As Integer
            Get
                Return _SubNumero
            End Get
            Set(ByVal value As Integer)
                _SubNumero = value
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
        Public Property IdUnidad() As Integer
            Get
                Return _IdUnidad
            End Get
            Set(ByVal value As Integer)
                _IdUnidad = value
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
        Public Property OrigenDescripcion() As Integer
            Get
                Return _OrigenDescripcion
            End Get
            Set(ByVal value As Integer)
                _OrigenDescripcion = value
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
        Public Property CotizacionMoneda() As Double
            Get
                Return _CotizacionMoneda
            End Get
            Set(ByVal value As Double)
                _CotizacionMoneda = value
            End Set
        End Property
        Public Property IdDetallePresupuesto() As Integer
            Get
                Return _IdDetallePresupuesto
            End Get
            Set(ByVal value As Integer)
                _IdDetallePresupuesto = value
            End Set
        End Property






    End Class

End Namespace