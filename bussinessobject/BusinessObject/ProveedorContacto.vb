Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ProveedorContacto
        Private _Id As Integer = -1
        Private _IdProveedor As Integer = -1
        Private _Contacto As String = String.Empty
        Private _Puesto As String = String.Empty
        Private _Telefono As String = String.Empty
        Private _Email As String = String.Empty
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

        Public Property IdProveedor() As Integer
            Get
                Return _IdProveedor
            End Get
            Set(ByVal value As Integer)
                _IdProveedor = value
            End Set
        End Property

        Public Property Contacto() As String
            Get
                Return _Contacto
            End Get
            Set(ByVal value As String)
                _Contacto = value
            End Set
        End Property

        Public Property Puesto() As String
            Get
                Return _Puesto
            End Get
            Set(ByVal value As String)
                _Puesto = value
            End Set
        End Property

        Public Property Telefono() As String
            Get
                Return _Telefono
            End Get
            Set(ByVal value As String)
                _Telefono = value
            End Set
        End Property

        Public Property Email() As String
            Get
                Return _Email
            End Get
            Set(ByVal value As String)
                _Email = value
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