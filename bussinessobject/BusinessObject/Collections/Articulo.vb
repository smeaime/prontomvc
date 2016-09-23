Imports System
Imports System.ComponentModel
Imports System.Diagnostics
Namespace Pronto.ERP.BO

    <Serializable()> Public Class Articulo
        Private _Id As Integer = -1
        Private _Descripcion As String = String.Empty
        Private _Codigo As String = String.Empty
        Private _NumeroInventario As String = String.Empty
        Private _IdRubro As Integer = 0
        Private _Rubro As String = String.Empty
        Private _IdSubrubro As Integer = 0
        Private _Subrubro As String = String.Empty
        Private _IdUnidad As Integer = 0
        Private _Unidad As String = String.Empty
        Private _AlicuotaIVA As Single = 0
        Private _CostoPPP As Double = 0
        Private _CostoPPPDolar As Double = 0
        Private _CostoReposicion As Double = 0
        Private _CostoReposicionDolar As Double = 0
        Private _Observaciones As String = String.Empty
        Private _DescripcionComplete As String = String.Empty

        Public AuxiliarString5 As String = String.Empty
        Public AuxiliarString6 As String = String.Empty
        Public AuxiliarString7 As String = String.Empty

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property Descripcion() As String
            Get
                Return _Descripcion
            End Get
            Set(ByVal value As String)
                _Descripcion = value
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

        Public Property NumeroInventario() As String
            Get
                Return _NumeroInventario
            End Get
            Set(ByVal value As String)
                _NumeroInventario = value
            End Set
        End Property

        Public Property IdRubro() As Integer
            Get
                Return _IdRubro
            End Get
            Set(ByVal value As Integer)
                _IdRubro = value
            End Set
        End Property

        Public Property Rubro() As String
            Get
                Return _Rubro
            End Get
            Set(ByVal value As String)
                _Rubro = value
            End Set
        End Property

        Public Property IdSubrubro() As Integer
            Get
                Return _IdSubrubro
            End Get
            Set(ByVal value As Integer)
                _IdSubrubro = value
            End Set
        End Property

        Public Property Subrubro() As String
            Get
                Return _Subrubro
            End Get
            Set(ByVal value As String)
                _Subrubro = value
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

        Public Property AlicuotaIVA() As Single
            Get
                Return _AlicuotaIVA
            End Get
            Set(ByVal value As Single)
                _AlicuotaIVA = value
            End Set
        End Property

        Public Property CostoPPP() As Double
            Get
                Return _CostoPPP
            End Get
            Set(ByVal value As Double)
                _CostoPPP = value
            End Set
        End Property

        Public Property CostoPPPDolar() As Double
            Get
                Return _CostoPPPDolar
            End Get
            Set(ByVal value As Double)
                _CostoPPPDolar = value
            End Set
        End Property

        Public Property CostoReposicion() As Double
            Get
                Return _CostoReposicion
            End Get
            Set(ByVal value As Double)
                _CostoReposicion = value
            End Set
        End Property

        Public Property CostoReposicionDolar() As Double
            Get
                Return _CostoReposicionDolar
            End Get
            Set(ByVal value As Double)
                _CostoReposicionDolar = value
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
        Public Property DescripcionComplete() As String
            Get
                Return _DescripcionComplete
            End Get
            Set(ByVal value As String)
                _DescripcionComplete = value
            End Set
        End Property

    End Class

End Namespace