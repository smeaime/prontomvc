Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class PedidoItem
        Private _Id As Integer = -1
        Private _IdPedido As Integer = -1
        Private _NumeroItem As Integer = 0
        Private _IdArticulo As Integer = 0
        Private _Codigo As String = String.Empty
        Private _Articulo As String = String.Empty
        Private _Cantidad As Double = 0
        Private _IdUnidad As Integer = 0
        Private _Unidad As String = String.Empty
        Private _FechaEntrega As DateTime = DateTime.MinValue
        Private _FechaNecesidad As DateTime = DateTime.MinValue
        Private _Precio As Double = 0
        Private _Observaciones As String = String.Empty
        Private _IdDetalleAcopios As Integer = 0
        Private _IdDetalleRequerimiento As Integer = 0
        Private _IdDetalleLMateriales As Integer = 0
        Private _Cumplido As String = String.Empty
        Private _IdCuenta As Integer = 0
        Private _OrigenDescripcion As Integer = 0
        Private _IdAutorizoCumplido As Integer = 0
        Private _IdDioPorCumplido As Integer = 0
        Private _FechaDadoPorCumplido As DateTime = DateTime.MinValue
        Private _ObservacionesCumplido As String = String.Empty
        Private _PorcentajeBonificacion As Double = 0
        Private _ImporteBonificacion As Double = 0
        Private _PorcentajeIVA As Double = 0
        Private _ImporteIVA As Double = 0
        Private _ImporteTotalItem As Double = 0
        Private _Costo As Double = 0
        Private _IdAsignacionCosto As Integer = 0
        Private _CostoAsignado As Double = 0
        Private _IdUsuarioAsignoCosto As Integer = 0
        Private _FechaAsignacionCosto As DateTime = DateTime.MinValue
        Private _IdDetallePedidoOriginal As Integer = 0
        Private _IdPedidoOriginal As Integer = 0
        Private _IdOrigenTransmision As Integer = 0
        Private _PlazoEntrega As String = String.Empty
        Private _CostoAsignadoDolar As Double = 0
        Private _IdDetalleComparativa As Integer = 0
        Private _IdDetalleRequerimientoOriginal As Integer = 0
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

        Public Property IdPedido() As Integer
            Get
                Return _IdPedido
            End Get
            Set(ByVal value As Integer)
                _IdPedido = value
            End Set
        End Property

        Public Property NumeroItem() As Integer
            Get
                Return _NumeroItem
            End Get
            Set(ByVal value As Integer)
                _NumeroItem = value
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

        Public Property Cantidad() As Double
            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
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

        Public Property Unidad() As String
            Get
                Return _Unidad
            End Get
            Set(ByVal value As String)
                _Unidad = value
            End Set
        End Property

        Public Property FechaEntrega() As DateTime
            Get
                Return _FechaEntrega
            End Get
            Set(ByVal value As DateTime)
                _FechaEntrega = value
            End Set
        End Property

        Public Property FechaNecesidad() As DateTime
            Get
                Return _FechaNecesidad
            End Get
            Set(ByVal value As DateTime)
                _FechaNecesidad = value
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

        Public Property Observaciones() As String
            Get
                Return _Observaciones
            End Get
            Set(ByVal value As String)
                _Observaciones = value
            End Set
        End Property

        Public Property IdDetalleAcopios() As Integer
            Get
                Return _IdDetalleAcopios
            End Get
            Set(ByVal value As Integer)
                _IdDetalleAcopios = value
            End Set
        End Property

        Public Property IdDetalleRequerimiento() As Integer
            Get
                Return _IdDetalleRequerimiento
            End Get
            Set(ByVal value As Integer)
                _IdDetalleRequerimiento = value
            End Set
        End Property

        Public Property IdDetalleLMateriales() As Integer
            Get
                Return _IdDetalleLMateriales
            End Get
            Set(ByVal value As Integer)
                _IdDetalleLMateriales = value
            End Set
        End Property

        Public Property Cumplido() As String
            Get
                Return _Cumplido
            End Get
            Set(ByVal value As String)
                _Cumplido = value
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

        Public Property OrigenDescripcion() As Integer
            Get
                Return _OrigenDescripcion
            End Get
            Set(ByVal value As Integer)
                _OrigenDescripcion = value
            End Set
        End Property

        Public Property IdAutorizoCumplido() As Integer
            Get
                Return _IdAutorizoCumplido
            End Get
            Set(ByVal value As Integer)
                _IdAutorizoCumplido = value
            End Set
        End Property

        Public Property IdDioPorCumplido() As Integer
            Get
                Return _IdDioPorCumplido
            End Get
            Set(ByVal value As Integer)
                _IdDioPorCumplido = value
            End Set
        End Property

        Public Property FechaDadoPorCumplido() As DateTime
            Get
                Return _FechaDadoPorCumplido
            End Get
            Set(ByVal value As DateTime)
                _FechaDadoPorCumplido = value
            End Set
        End Property

        Public Property ObservacionesCumplido() As String
            Get
                Return _ObservacionesCumplido
            End Get
            Set(ByVal value As String)
                _ObservacionesCumplido = value
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

        Public Property ImporteBonificacion() As Double
            Get
                Return _ImporteBonificacion
            End Get
            Set(ByVal value As Double)
                _ImporteBonificacion = value
            End Set
        End Property

        Public Property PorcentajeIVA() As Double
            Get
                Return _PorcentajeIVA
            End Get
            Set(ByVal value As Double)
                _PorcentajeIVA = value
            End Set
        End Property

        Public Property ImporteIVA() As Double
            Get
                Return _ImporteIVA
            End Get
            Set(ByVal value As Double)
                _ImporteIVA = value
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

        Public Property Costo() As Double
            Get
                Return _Costo
            End Get
            Set(ByVal value As Double)
                _Costo = value
            End Set
        End Property

        Public Property IdAsignacionCosto() As Integer
            Get
                Return _IdAsignacionCosto
            End Get
            Set(ByVal value As Integer)
                _IdAsignacionCosto = value
            End Set
        End Property

        Public Property CostoAsignado() As Double
            Get
                Return _CostoAsignado
            End Get
            Set(ByVal value As Double)
                _CostoAsignado = value
            End Set
        End Property

        Public Property IdUsuarioAsignoCosto() As Integer
            Get
                Return _IdUsuarioAsignoCosto
            End Get
            Set(ByVal value As Integer)
                _IdUsuarioAsignoCosto = value
            End Set
        End Property

        Public Property FechaAsignacionCosto() As DateTime
            Get
                Return _FechaAsignacionCosto
            End Get
            Set(ByVal value As DateTime)
                _FechaAsignacionCosto = value
            End Set
        End Property

        Public Property IdDetallePedidoOriginal() As Integer
            Get
                Return _IdDetallePedidoOriginal
            End Get
            Set(ByVal value As Integer)
                _IdDetallePedidoOriginal = value
            End Set
        End Property

        Public Property IdPedidoOriginal() As Integer
            Get
                Return _IdPedidoOriginal
            End Get
            Set(ByVal value As Integer)
                _IdPedidoOriginal = value
            End Set
        End Property

        Public Property IdOrigenTransmision() As Integer
            Get
                Return _IdOrigenTransmision
            End Get
            Set(ByVal value As Integer)
                _IdOrigenTransmision = value
            End Set
        End Property

        Public Property PlazoEntrega() As String
            Get
                Return _PlazoEntrega
            End Get
            Set(ByVal value As String)
                _PlazoEntrega = value
            End Set
        End Property

        Public Property CostoAsignadoDolar() As Double
            Get
                Return _CostoAsignadoDolar
            End Get
            Set(ByVal value As Double)
                _CostoAsignadoDolar = value
            End Set
        End Property

        Public Property IdDetalleComparativa() As Integer
            Get
                Return _IdDetalleComparativa
            End Get
            Set(ByVal value As Integer)
                _IdDetalleComparativa = value
            End Set
        End Property

        Public Property IdDetalleRequerimientoOriginal() As Integer
            Get
                Return _IdDetalleRequerimientoOriginal
            End Get
            Set(ByVal value As Integer)
                _IdDetalleRequerimientoOriginal = value
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