Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Comparativa


        '///////////////////////////////////////
        'Ver qué conviene anexar al codigo generado
        '///////////////////////////////////////

        Private _Proveedor As String = String.Empty    ' lo agregué a mano


        Public Property Proveedor() As String
            Get
                Return _Proveedor
            End Get
            Set(ByVal value As String)
                _Proveedor = value
            End Set
        End Property

        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        'Agregado para web
        '///////////////////////////////////////
        '///////////////////////////////////////
        Private _FechaCierreCompulsa As DateTime = DateTime.MinValue
        Private _ConfirmadoPorWeb As String = String.Empty
        Private _FechaRespuestaWeb As DateTime = DateTime.MinValue
        Private _NombreUsuarioWeb As String = String.Empty


        Public Property ConfirmadoPorWeb() As String
            Get
                Return _ConfirmadoPorWeb
            End Get
            Set(ByVal value As String)
                _ConfirmadoPorWeb = value
            End Set
        End Property

        Public Property NombreUsuarioWeb() As String
            Get
                Return _NombreUsuarioWeb
            End Get
            Set(ByVal value As String)
                _NombreUsuarioWeb = value
            End Set
        End Property

        Public Property FechaRespuestaWeb() As DateTime
            Get
                Return _FechaRespuestaWeb
            End Get
            Set(ByVal value As DateTime)
                _FechaRespuestaWeb = value
            End Set
        End Property

        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////
        '///////////////////////////////////////







        Private _Id As Integer = -1
        Private _Numero As Integer = 0
        Private _Fecha As DateTime = DateTime.MinValue
        Private _Observaciones As String = String.Empty
        Private _IdConfecciono As Integer = 0
        Private _IdAprobo As Integer = 0
        Private _PresupuestoSeleccionado As Integer = 0
        Private _SubNumeroSeleccionado As Integer = 0
        Private _MontoPrevisto As Double = 0
        Private _MontoParaCompra As Double = 0
        Private _NumeroRequerimiento As Integer = 0
        Private _FechaAprobacion As DateTime = DateTime.MinValue
        Private _Obras As String = String.Empty
        Private _CircuitoFirmasCompleto As String = String.Empty
        Private _Detalles As ComparativaItemList = New ComparativaItemList


        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        ' Codigo exclusivo del objeto de COMPARATIVA:
        ' Esta matriz no se graba, se usa para manejar la grilla de la comparativa(ya que en un mismo renglon
        ' de la grilla van distintos renglones de la tabla detalle)
        'BESTIA!!!! Esto costaba 1 mega en el viewstate!!!!!
        'Private mMatriz(1000, 100) As Long 'BESTIA!!!! Esto costaba 1 mega en el viewstate!!!!!
        'BESTIA!!!! Esto costaba 1 mega en el viewstate!!!!!
        'Public ReadOnly Property MatrizId() As Object
        'BESTIA!!!! Esto costaba 1 mega en el viewstate!!!!!
        '    Get
        '        MatrizId = mMatriz
        '    End Get
        'BESTIA!!!! Esto costaba 1 mega en el viewstate!!!!!
        'End Property
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////




        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property
        Public Property Numero() As Integer
            Get
                Return _Numero
            End Get
            Set(ByVal value As Integer)
                _Numero = value
            End Set
        End Property
        Public Property Fecha() As DateTime
            Get
                Return _Fecha
            End Get
            Set(ByVal value As DateTime)
                _Fecha = value
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
        Public Property IdConfecciono() As Integer
            Get
                Return _IdConfecciono
            End Get
            Set(ByVal value As Integer)
                _IdConfecciono = value
            End Set
        End Property
        Public Property IdAprobo() As Integer
            Get
                Return _IdAprobo
            End Get
            Set(ByVal value As Integer)
                _IdAprobo = value
            End Set
        End Property
        Public Property PresupuestoSeleccionado() As Integer
            Get
                Return _PresupuestoSeleccionado
            End Get
            Set(ByVal value As Integer)
                _PresupuestoSeleccionado = value
            End Set
        End Property
        Public Property SubNumeroSeleccionado() As Integer
            Get
                Return _SubNumeroSeleccionado
            End Get
            Set(ByVal value As Integer)
                _SubNumeroSeleccionado = value
            End Set
        End Property
        Public Property MontoPrevisto() As Double
            Get
                Return _MontoPrevisto
            End Get
            Set(ByVal value As Double)
                _MontoPrevisto = value
            End Set
        End Property
        Public Property MontoParaCompra() As Double
            Get
                Return _MontoParaCompra
            End Get
            Set(ByVal value As Double)
                _MontoParaCompra = value
            End Set
        End Property
        Public Property NumeroRequerimiento() As Integer
            Get
                Return _NumeroRequerimiento
            End Get
            Set(ByVal value As Integer)
                _NumeroRequerimiento = value
            End Set
        End Property
        Public Property FechaAprobacion() As DateTime
            Get
                Return _FechaAprobacion
            End Get
            Set(ByVal value As DateTime)
                _FechaAprobacion = value
            End Set
        End Property
        Public Property Obras() As String
            Get
                Return _Obras
            End Get
            Set(ByVal value As String)
                _Obras = value
            End Set
        End Property
        Public Property CircuitoFirmasCompleto() As String
            Get
                Return _CircuitoFirmasCompleto
            End Get
            Set(ByVal value As String)
                _CircuitoFirmasCompleto = value
            End Set
        End Property

        Public Property Detalles() As ComparativaItemList
            Get
                Return _Detalles
            End Get
            Set(ByVal value As ComparativaItemList)
                _Detalles = value
            End Set
        End Property

    End Class

End Namespace