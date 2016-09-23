Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeDebitoList
        Inherits List(Of NotaDeDebito)

        Public Sub New()
        End Sub

        Private _orderField As String

        Public Property OrderField() As String
            Get
                Return _orderField
            End Get
            Set(ByVal value As String)
                _orderField = value
            End Set
        End Property

        Public Shared Function CompareFecha(ByVal NotaDeDebitoA As NotaDeDebito, ByVal NotaDeDebitoB As NotaDeDebito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeDebitoA, NotaDeDebitoB, compareResult) Then
                Return Date.Compare(NotaDeDebitoA.Fecha, NotaDeDebitoB.Fecha)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareObra(ByVal NotaDeDebitoA As NotaDeDebito, ByVal NotaDeDebitoB As NotaDeDebito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeDebitoA, NotaDeDebitoB, compareResult) Then
                Return String.Compare(NotaDeDebitoA.Obra, NotaDeDebitoB.Obra)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareId(ByVal NotaDeDebitoA As NotaDeDebito, ByVal NotaDeDebitoB As NotaDeDebito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeDebitoA, NotaDeDebitoB, compareResult) Then
                Return NotaDeDebitoA.Id.CompareTo(NotaDeDebitoB.Id)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareSector(ByVal NotaDeDebitoA As NotaDeDebito, ByVal NotaDeDebitoB As NotaDeDebito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeDebitoA, NotaDeDebitoB, compareResult) Then
                Return String.Compare(NotaDeDebitoA.Sector, NotaDeDebitoB.Sector)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal NotaDeDebitoA As NotaDeDebito, ByVal NotaDeDebitoB As NotaDeDebito, ByRef result As Integer) As Boolean
            If NotaDeDebitoA Is Nothing Then
                If NotaDeDebitoB Is Nothing Then
                    ' If x is Nothing and y is Nothing, they're
                    ' equal. 
                    result = 0
                Else
                    ' If x is Nothing and y is not Nothing, y
                    ' is greater. 
                    result = -1
                End If
            Else
                ' If x is not Nothing...
                '
                If NotaDeDebitoB Is Nothing Then
                    ' ...and y is Nothing, x is greater.
                    result = 1
                Else
                    Return False
                End If
            End If
            Return True

        End Function

    End Class

End Namespace