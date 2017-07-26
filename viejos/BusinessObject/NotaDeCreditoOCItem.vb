Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeCreditoOCItem
        Private _Id As Integer = -1
        Private _IdNotaCredito As Integer = 0
        Private _IdDetalleOrdenCompra As Integer = 0
        Private _Cantidad As Double = 0
        Private _PorcentajeCertificacion As Double = 0

        Private _NumeroOrdenCompra As String = String.Empty
        Private _NumeroOrdenCompraCliente As String = String.Empty
        Private _Obra As String = String.Empty
        Private _ItemOC As Integer = 0
        Private _Articulo As String = String.Empty
        Private _Unidad As String = String.Empty
        Private _Precio As Double = 0
        Private _Importe As Double = 0
        Private _Pendiente As Double = 0

        '/////////////////////////////////////////
        '/////////////////////////////////////////
        Private _aAcreditar As Double = 0 'esta propiedad no está en la tabla. En el Pronto, su valor 
        ' solo se guarda en la grilla de Imputaciones a OC, y luego le pierdo el rastro

        Public Property aAcreditar() As Double
            Get
                Return _aAcreditar
            End Get
            Set(ByVal value As Double)
                _aAcreditar = value
            End Set
        End Property
        '/////////////////////////////////////////
        '/////////////////////////////////////////


        Public Property Cantidad() As Double
            Get
                Return _Cantidad
            End Get
            Set(ByVal value As Double)
                _Cantidad = value
            End Set
        End Property

        Public Property PorcentajeCertificacion() As Double
            Get
                Return _PorcentajeCertificacion
            End Get
            Set(ByVal value As Double)
                _PorcentajeCertificacion = value
            End Set
        End Property

        Public Property IdNotaCredito() As Integer
            Get
                Return _IdNotaCredito
            End Get
            Set(ByVal value As Integer)
                _IdNotaCredito = value
            End Set
        End Property

        Public Property IdDetalleOrdenCompra() As Integer
            Get
                Return _IdDetalleOrdenCompra
            End Get
            Set(ByVal value As Integer)
                _IdDetalleOrdenCompra = value
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



        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        'Datos adicionales desnormalizados traidos de la OC imputada
        '//////////////////////////////////////////////////////

        Public Property NumeroOrdenCompra() As String
            Get
                Return _NumeroOrdenCompra
            End Get
            Set(ByVal value As String)
                _NumeroOrdenCompra = value
            End Set
        End Property


        Public Property NumeroOrdenCompraCliente() As String
            Get
                Return _NumeroOrdenCompraCliente
            End Get
            Set(ByVal value As String)
                _NumeroOrdenCompraCliente = value
            End Set
        End Property


        Public Property Obra() As String
            Get
                Return _Obra
            End Get
            Set(ByVal value As String)
                _Obra = value
            End Set
        End Property

        Public Property ItemOC() As Long
            Get
                Return _ItemOC
            End Get
            Set(ByVal value As Long)
                _ItemOC = value
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


        Public Property Precio() As Double
            Get
                Return _Precio
            End Get
            Set(ByVal value As Double)
                _Precio = value
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


        Public Property Pendiente() As Double
            Get
                Return _Pendiente
            End Get
            Set(ByVal value As Double)
                _Pendiente = value
            End Set
        End Property
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////





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