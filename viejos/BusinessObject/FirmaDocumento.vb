Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class FirmaDocumento
        Private _Id As Integer = -1
        Private _BD As String = String.Empty
        Private _IdFormulario As TiposFormulario
        Private _IdComprobante As Integer = 0
        Private _OrdenAutorizacion As Integer = 0
        Private _IdAutorizo As Integer = 0
        Private _Autorizo As String = String.Empty
        Private _FechaAutorizacion As DateTime = DateTime.MinValue
        Private _Firmado As Boolean = False

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property BD() As String
            Get
                Return _BD
            End Get
            Set(ByVal value As String)
                _BD = value
            End Set
        End Property

        Public Property IdFormulario() As TiposFormulario
            Get
                Return _IdFormulario
            End Get
            Set(ByVal value As TiposFormulario)
                _IdFormulario = value
            End Set
        End Property

        Public Property IdComprobante() As Integer
            Get
                Return _IdComprobante
            End Get
            Set(ByVal value As Integer)
                _IdComprobante = value
            End Set
        End Property

        Public Property OrdenAutorizacion() As Integer
            Get
                Return _OrdenAutorizacion
            End Get
            Set(ByVal value As Integer)
                _OrdenAutorizacion = value
            End Set
        End Property

        Public Property IdAutorizo() As Integer
            Get
                Return _IdAutorizo
            End Get
            Set(ByVal value As Integer)
                _IdAutorizo = value
            End Set
        End Property

        Public Property Autorizo() As String
            Get
                Return _Autorizo
            End Get
            Set(ByVal value As String)
                _Autorizo = value
            End Set
        End Property

        Public Property FechaAutorizacion() As DateTime
            Get
                Return _FechaAutorizacion
            End Get
            Set(ByVal value As DateTime)
                _FechaAutorizacion = value
            End Set
        End Property

        Public Property Firmado() As Boolean
            Get
                Return _Firmado
            End Get
            Set(ByVal value As Boolean)
                _Firmado = value
            End Set
        End Property
    End Class

End Namespace