Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Localidad
        Private _Id As Integer = -1
        Private _Nombre As String = String.Empty
        Private _CodigoPostal As String = String.Empty
        Private _IdProvincia As Integer = 0
        Private _Provincia As String = String.Empty
        Private _IdPais As Integer = 0
        Private _Pais As String = String.Empty

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
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

        Public Property CodigoPostal() As String
            Get
                Return _CodigoPostal
            End Get
            Set(ByVal value As String)
                _CodigoPostal = value
            End Set
        End Property

        Public Property IdProvincia() As Integer
            Get
                Return _IdProvincia
            End Get
            Set(ByVal value As Integer)
                _IdProvincia = value
            End Set
        End Property

        Public Property Provincia() As String
            Get
                Return _Provincia
            End Get
            Set(ByVal value As String)
                _Provincia = value
            End Set
        End Property

        Public Property IdPais() As Integer
            Get
                Return _IdPais
            End Get
            Set(ByVal value As Integer)
                _IdPais = value
            End Set
        End Property

        Public Property Pais() As String
            Get
                Return _Pais
            End Get
            Set(ByVal value As String)
                _Pais = value
            End Set
        End Property

    End Class

End Namespace