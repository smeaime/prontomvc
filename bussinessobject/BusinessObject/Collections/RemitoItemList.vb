Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class RemitoItemList
        Inherits List(Of RemitoItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal RemitoItemA As RemitoItem, ByVal RemitoItemB As RemitoItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(RemitoItemA, RemitoItemB, compareResult) Then
                Return RemitoItemA.Id.CompareTo(RemitoItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal RemitoItemA As RemitoItem, ByVal RemitoItemB As RemitoItem, ByRef result As Integer) As Boolean
            If RemitoItemA Is Nothing Then
                If RemitoItemB Is Nothing Then
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
                If RemitoItemB Is Nothing Then
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
