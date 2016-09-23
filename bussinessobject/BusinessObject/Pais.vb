Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Pais
        Private _Id As Integer = -1
        Private _Descripcion As String = String.Empty
        Private _Codigo As String = String.Empty

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

    End Class

End Namespace