Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Empleado
        Private _Id As Integer = -1
        Private _Legajo As Integer = 0
        Private _Nombre As String = String.Empty
        Private _Email As String = String.Empty
        Private _IdSector As Long = 0

        Public PuntoVentaAsociado As Integer

        <DataObjectFieldAttribute(True, True, False)> _
        Public Property Id() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property

        Public Property Legajo() As Integer
            Get
                Return _Legajo
            End Get
            Set(ByVal value As Integer)
                _Legajo = value
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

        Public Property Email() As String
            Get
                Return _Email
            End Get
            Set(ByVal value As String)
                _Email = value
            End Set
        End Property


        Public Property IdSector() As Long
            Get
                Return _IdSector
            End Get
            Set(ByVal value As Long)
                _IdSector = value
            End Set
        End Property

    End Class

End Namespace