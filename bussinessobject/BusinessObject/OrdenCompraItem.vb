Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenCompraItem



        Private _Id As Integer = -1
        Private _IdOrdenCompra As Integer = -1
        Private _IdArticulo As Integer = 0
        Private _Codigo As String = String.Empty
        Private _Articulo As String = String.Empty
        Private _Cantidad As Double = 0
        Private _IdUnidad As Integer = 0
        Private _Unidad As String = String.Empty
        Private _NumeroItem As Integer = 0
        Private _FechaEntrega As DateTime = DateTime.MinValue
        Private _Cumplido As String = String.Empty
        Private _Observaciones As String = String.Empty
        Private _Cantidad1 As Double = 0
        Private _Cantidad2 As Double = 0
        Private _IdDetalleLMateriales As Integer = 0
        Private _NumeroFacturaCompra1 As Integer = 0
        Private _NumeroFacturaCompra2 As Integer = 0
        Private _FechaFacturaCompra As DateTime = DateTime.MinValue
        Private _ImporteFacturaCompra As Double = 0
        Private _IdProveedor As Integer = 0
        Private _ProveedorCompra As String = String.Empty
        Private _IdComprador As Integer = 0
        Private _Comprador As String = String.Empty
        Private _DescripcionManual As String = String.Empty
        Private _IdRequerimientoOriginal As Integer = 0
        Private _IdDetalleRequerimientoOriginal As Integer = 0
        Private _IdOrigenTransmision As Integer = 0
        Private _IdAutorizoCumplido As Integer = 0
        Private _IdDioPorCumplido As Integer = 0
        Private _FechaDadoPorCumplido As DateTime = DateTime.MinValue
        Private _ObservacionesCumplido As String = String.Empty
        Private _Costo As Double = 0
        Private _OrigenDescripcion As Integer = 0
        Private _TipoDesignacion As String = String.Empty
        Private _IdLiberoParaCompras As Integer = 0
        Private _FechaLiberacionParaCompras As DateTime = DateTime.MinValue
        Private _Recepcionado As String = String.Empty
        Private _Pagina As Integer = 0
        Private _Item As Integer = 0
        Private _Figura As Integer = 0
        Private _CodigoDistribucion As String = String.Empty
        Private _IdEquipoDestino As Integer = 0
        Private _Entregado As String = String.Empty
        Private _FechaAsignacionComprador As DateTime = DateTime.MinValue
        Private _MoP As String = String.Empty
        Private _IdDetalleObraDestino As Integer = 0
        Private _Adjunto As String = String.Empty
        Private _ArchivoAdjunto1 As String = String.Empty


        Public IdUnidad As Integer = 0
        Public IdArticulo As Integer = 0
        Public TipoCancelacion As Integer = 0
        Public Cumplido As String = String.Empty
        Public FacturacionAutomatica As String = String.Empty
        Public FechaComienzoFacturacion As String = String.Empty
        Public CantidadMesesAFacturar As Integer = 0
        Public FacturacionCompletaMensual
        Public IdDetalleObraDestino As Integer = 0
        Public FechaNecesidad As DateTime = DateTime.MinValue
        Public FechaEntrega As DateTime = DateTime.MinValue
        Public IdColor As Integer = 0
        Public IdDioPorCumplido As Integer = 0
        Public FechaDadoPorCumplido As DateTime = DateTime.MinValue
        Public ObservacionesCumplido As String = String.Empty



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


        Public Property OrigenDescripcion() As Integer
            Get
                Return _OrigenDescripcion
            End Get
            Set(ByVal value As Integer)
                _OrigenDescripcion = value
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


        Public Property Cantidad() As Double
            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
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

        Public Property IdOrdenCompra() As Integer
            Get
                Return _IdOrdenCompra
            End Get
            Set(ByVal value As Integer)
                _IdOrdenCompra = value
            End Set
        End Property










        Public Property Cantidad1() As Double
            Get
                Return _Cantidad1
            End Get
            Set(ByVal value As Double)
                _Cantidad1 = value
            End Set
        End Property

        Public Property Cantidad2() As Double
            Get
                Return _Cantidad2
            End Get
            Set(ByVal value As Double)
                _Cantidad2 = value
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

        Public Property NumeroFacturaCompra1() As Integer
            Get
                Return _NumeroFacturaCompra1
            End Get
            Set(ByVal value As Integer)
                _NumeroFacturaCompra1 = value
            End Set
        End Property

        Public Property NumeroFacturaCompra2() As Integer
            Get
                Return _NumeroFacturaCompra2
            End Get
            Set(ByVal value As Integer)
                _NumeroFacturaCompra2 = value
            End Set
        End Property

        Public Property FechaFacturaCompra() As DateTime
            Get
                Return _FechaFacturaCompra
            End Get
            Set(ByVal value As DateTime)
                _FechaFacturaCompra = value
            End Set
        End Property

        Public Property ImporteFacturaCompra() As Double
            Get
                Return _ImporteFacturaCompra
            End Get
            Set(ByVal value As Double)
                _ImporteFacturaCompra = value
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

        Public Property ProveedorCompra() As String
            Get
                Return _ProveedorCompra
            End Get
            Set(ByVal value As String)
                _ProveedorCompra = value
            End Set
        End Property

        Public Property IdComprador() As Integer
            Get
                Return _IdComprador
            End Get
            Set(ByVal value As Integer)
                _IdComprador = value
            End Set
        End Property

        Public Property Comprador() As String
            Get
                Return _Comprador
            End Get
            Set(ByVal value As String)
                _Comprador = value
            End Set
        End Property

        Public Property DescripcionManual() As String
            Get
                Return _DescripcionManual
            End Get
            Set(ByVal value As String)
                _DescripcionManual = value
            End Set
        End Property

        Public Property IdRequerimientoOriginal() As Integer
            Get
                Return _IdRequerimientoOriginal
            End Get
            Set(ByVal value As Integer)
                _IdRequerimientoOriginal = value
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

        Public Property IdOrigenTransmision() As Integer
            Get
                Return _IdOrigenTransmision
            End Get
            Set(ByVal value As Integer)
                _IdOrigenTransmision = value
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





        Public Property Costo() As Double
            Get
                Return _Costo
            End Get
            Set(ByVal value As Double)
                _Costo = value
            End Set
        End Property



        Public Property TipoDesignacion() As String
            Get
                Return _TipoDesignacion
            End Get
            Set(ByVal value As String)
                _TipoDesignacion = value
            End Set
        End Property

        Public Property IdLiberoParaCompras() As Integer
            Get
                Return _IdLiberoParaCompras
            End Get
            Set(ByVal value As Integer)
                _IdLiberoParaCompras = value
            End Set
        End Property

        Public Property FechaLiberacionParaCompras() As DateTime
            Get
                Return _FechaLiberacionParaCompras
            End Get
            Set(ByVal value As DateTime)
                _FechaLiberacionParaCompras = value
            End Set
        End Property

        Public Property Recepcionado() As String
            Get
                Return _Recepcionado
            End Get
            Set(ByVal value As String)
                _Recepcionado = value
            End Set
        End Property

        Public Property Pagina() As Integer
            Get
                Return _Pagina
            End Get
            Set(ByVal value As Integer)
                _Pagina = value
            End Set
        End Property

        Public Property Item() As Integer
            Get
                Return _Item
            End Get
            Set(ByVal value As Integer)
                _Item = value
            End Set
        End Property

        Public Property Figura() As Integer
            Get
                Return _Figura
            End Get
            Set(ByVal value As Integer)
                _Figura = value
            End Set
        End Property

        Public Property CodigoDistribucion() As String
            Get
                Return _CodigoDistribucion
            End Get
            Set(ByVal value As String)
                _CodigoDistribucion = value
            End Set
        End Property

        Public Property IdEquipoDestino() As Integer
            Get
                Return _IdEquipoDestino
            End Get
            Set(ByVal value As Integer)
                _IdEquipoDestino = value
            End Set
        End Property

        Public Property Entregado() As String
            Get
                Return _Entregado
            End Get
            Set(ByVal value As String)
                _Entregado = value
            End Set
        End Property

        Public Property FechaAsignacionComprador() As DateTime
            Get
                Return _FechaAsignacionComprador
            End Get
            Set(ByVal value As DateTime)
                _FechaAsignacionComprador = value
            End Set
        End Property

        Public Property MoP() As String
            Get
                Return _MoP
            End Get
            Set(ByVal value As String)
                _MoP = value
            End Set
        End Property


        Public Property Adjunto() As String
            Get
                Return _Adjunto
            End Get
            Set(ByVal value As String)
                _Adjunto = value
            End Set
        End Property

        Public Property ArchivoAdjunto1() As String
            Get
                Return _ArchivoAdjunto1
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto1 = value
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