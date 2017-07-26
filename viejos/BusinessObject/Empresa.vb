Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Empresa
        Private _Id As Integer = -1
		Private _Descripcion As String = String.Empty
        Private _ConnectionString As String = String.Empty

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

        Public Property ConnectionString() As String
            Get
                Return _ConnectionString
            End Get
            Set(ByVal value As String)
                _ConnectionString = value
            End Set
        End Property

    End Class
End Namespace
