Imports System
Imports System.ComponentModel
Imports System.Diagnostics

<Serializable()> Public Class Usuario
	Private _UserId As String = String.Empty
    Private _Nombre As String = String.Empty
    Private _IdEmpresa As Integer = 0
    Private _Empresa As String = String.Empty
    Private _StringConnection As String = String.Empty
    Private _ListEmpresas() As Integer

    Public Property UserId() As String
        Get
            Return _UserId
        End Get
        Set(ByVal value As String)
            _UserId = value
        End Set
    End Property

    Public Property Nombre() As String
        Get
            Return _Nombre
        End Get
        Set(ByVal value As String)
            _Nombre = value
        End Set
    End Property

    Public Property IdEmpresa() As Integer
        Get
            Return _IdEmpresa
        End Get
        Set(ByVal value As Integer)
            _IdEmpresa = value
        End Set
    End Property

    Public Property Empresa() As String
        Get
            Return _Empresa
        End Get
        Set(ByVal value As String)
            _Empresa = value
        End Set
    End Property

    Public Property StringConnection() As String
        Get
            Return _StringConnection
        End Get
        Set(ByVal value As String)
            _StringConnection = value
        End Set
    End Property

    Default Property ListEmpresas(ByVal index As Integer) As Integer
        Get
            Return _ListEmpresas(index)
        End Get
        Set(ByVal Value As Integer)
            _ListEmpresas(index) = Value
        End Set
    End Property

    'Sub New(ByVal size As Integer)
    '    ReDim _ListEmpresas(size)
    'End Sub
End Class
