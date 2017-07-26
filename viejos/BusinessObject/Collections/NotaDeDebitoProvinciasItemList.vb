Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeDebitoProvinciasItemList
        Inherits List(Of NotaDeDebitoProvinciasItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal NotaDeDebitoItemA As NotaDeDebitoItem, ByVal NotaDeDebitoItemB As NotaDeDebitoItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeDebitoItemA, NotaDeDebitoItemB, compareResult) Then
                Return NotaDeDebitoItemA.Id.CompareTo(NotaDeDebitoItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal NotaDeDebitoItemA As NotaDeDebitoItem, ByVal NotaDeDebitoItemB As NotaDeDebitoItem, ByRef result As Integer) As Boolean
            If NotaDeDebitoItemA Is Nothing Then
                If NotaDeDebitoItemB Is Nothing Then
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
                If NotaDeDebitoItemB Is Nothing Then
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
