Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class ReciboAnticiposAlPersonalItemList
        Inherits List(Of ReciboAnticiposAlPersonalItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal ReciboItemA As ReciboItem, ByVal ReciboItemB As ReciboItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(ReciboItemA, ReciboItemB, compareResult) Then
                Return ReciboItemA.Id.CompareTo(ReciboItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal ReciboItemA As ReciboItem, ByVal ReciboItemB As ReciboItem, ByRef result As Integer) As Boolean
            If ReciboItemA Is Nothing Then
                If ReciboItemB Is Nothing Then
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
                If ReciboItemB Is Nothing Then
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
