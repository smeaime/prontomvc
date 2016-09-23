Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Subrubro
        Private _Id As Integer = -1
        Private _Descripcion As String = String.Empty
        Private _Abreviatura As String = String.Empty

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

    End Class

End Namespace