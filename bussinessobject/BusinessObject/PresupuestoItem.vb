Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class PresupuestoItem

        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////
        Private _Codigo As String = String.Empty    ' lo agregué a mano
        Private _Articulo As String = String.Empty  ' lo agregué a mano
        Private _Unidad As String = String.Empty    ' lo agregué a mano

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
        Private _IdPresupuesto As Integer = -1
        Private _NumeroItem As Integer = 0
        Private _IdArticulo As Integer = 0
        Private _Cantidad As Double = 0
        Private _IdUnidad As Integer = 0
        Private _Precio As Double = 0
        Private _Adjunto As String = String.Empty
        Private _ArchivoAdjunto As String = String.Empty
        Private _Cantidad1 As Double = 0
        Private _Cantidad2 As Double = 0
        Private _Observaciones As String = String.Empty
        Private _IdDetalleAcopios As Integer = 0
        Private _IdDetalleRequerimiento As Integer = 0
        Private _OrigenDescripcion As Integer = 0
        Private _IdDetalleLMateriales As Integer = 0
        Private _IdCuenta As Integer = 0
        Private _ArchivoAdjunto1 As String = String.Empty
        Private _ArchivoAdjunto2 As String = String.Empty
        Private _ArchivoAdjunto3 As String = String.Empty
        Private _ArchivoAdjunto4 As String = String.Empty
        Private _ArchivoAdjunto5 As String = String.Empty
        Private _ArchivoAdjunto6 As String = String.Empty
        Private _ArchivoAdjunto7 As String = String.Empty
        Private _ArchivoAdjunto8 As String = String.Empty
        Private _ArchivoAdjunto9 As String = String.Empty
        Private _ArchivoAdjunto10 As String = String.Empty
        Private _FechaEntrega As DateTime = DateTime.MinValue
        Private _IdCentroCosto As Integer = 0


        Private _PorcentajeBonificacion As Double = 0
        Private _ImporteBonificacion As Double = 0
        Private _PorcentajeIVA As Double = 0
        Private _ImporteIVA As Double = 0
        Private _ImporteTotalItem As Double = 0
        Private _Eliminado As Boolean = False
        Private _Nuevo As Boolean = False




        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
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








        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
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
        Public Property ArchivoAdjunto() As String
            Get
                Return _ArchivoAdjunto
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto = value
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
        Public Property OrigenDescripcion() As Integer
            Get
                Return _OrigenDescripcion
            End Get
            Set(ByVal value As Integer)
                _OrigenDescripcion = value
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
        Public Property IdCuenta() As Integer
            Get
                Return _IdCuenta
            End Get
            Set(ByVal value As Integer)
                _IdCuenta = value
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
        Public Property ArchivoAdjunto2() As String
            Get
                Return _ArchivoAdjunto2
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto2 = value
            End Set
        End Property
        Public Property ArchivoAdjunto3() As String
            Get
                Return _ArchivoAdjunto3
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto3 = value
            End Set
        End Property
        Public Property ArchivoAdjunto4() As String
            Get
                Return _ArchivoAdjunto4
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto4 = value
            End Set
        End Property
        Public Property ArchivoAdjunto5() As String
            Get
                Return _ArchivoAdjunto5
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto5 = value
            End Set
        End Property
        Public Property ArchivoAdjunto6() As String
            Get
                Return _ArchivoAdjunto6
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto6 = value
            End Set
        End Property
        Public Property ArchivoAdjunto7() As String
            Get
                Return _ArchivoAdjunto7
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto7 = value
            End Set
        End Property
        Public Property ArchivoAdjunto8() As String
            Get
                Return _ArchivoAdjunto8
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto8 = value
            End Set
        End Property
        Public Property ArchivoAdjunto9() As String
            Get
                Return _ArchivoAdjunto9
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto9 = value
            End Set
        End Property
        Public Property ArchivoAdjunto10() As String
            Get
                Return _ArchivoAdjunto10
            End Get
            Set(ByVal value As String)
                _ArchivoAdjunto10 = value
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
        Public Property IdCentroCosto() As Integer
            Get
                Return _IdCentroCosto
            End Get
            Set(ByVal value As Integer)
                _IdCentroCosto = value
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