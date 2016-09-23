Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Rubro
        Private _Id As Integer = -1
        Private _Descripcion As String = String.Empty
        Private _Abreviatura As String = String.Empty
        Private _IdCuentaVentas As Integer = 0
        Private _CuentaVentas As String = String.Empty
        Private _IdCuentaCompras As Integer = 0
        Private _CuentaCompras As String = String.Empty

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

        Public Property Abreviatura() As String
            Get
                Return _Abreviatura
            End Get
            Set(ByVal value As String)
                _Abreviatura = value
            End Set
        End Property

        Public Property IdCuentaVentas() As Integer
            Get
                Return _IdCuentaVentas
            End Get
            Set(ByVal value As Integer)
                _IdCuentaVentas = value
            End Set
        End Property

        Public Property CuentaVentas() As String
            Get
                Return _CuentaVentas
            End Get
            Set(ByVal value As String)
                _CuentaVentas = value
            End Set
        End Property

        Public Property IdCuentaCompras() As Integer
            Get
                Return _IdCuentaCompras
            End Get
            Set(ByVal value As Integer)
                _IdCuentaCompras = value
            End Set
        End Property

        Public Property CuentaCompras() As String
            Get
                Return _CuentaCompras
            End Get
            Set(ByVal value As String)
                _CuentaCompras = value
            End Set
        End Property

    End Class

End Namespace