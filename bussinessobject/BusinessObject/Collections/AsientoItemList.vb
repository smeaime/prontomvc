Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class AsientoItemList
        Inherits List(Of AsientoItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal AsientoItemA As AsientoItem, ByVal AsientoItemB As AsientoItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(AsientoItemA, AsientoItemB, compareResult) Then
                Return AsientoItemA.Id.CompareTo(AsientoItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal AsientoItemA As AsientoItem, ByVal AsientoItemB As AsientoItem, ByRef result As Integer) As Boolean
            If AsientoItemA Is Nothing Then
                If AsientoItemB Is Nothing Then
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
                If AsientoItemB Is Nothing Then
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
