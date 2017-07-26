Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenPagoRubrosContablesItemList
        Inherits List(Of OrdenPagoRubrosContablesItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal OrdenPagoItemA As OrdenPagoItem, ByVal OrdenPagoItemB As OrdenPagoItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(OrdenPagoItemA, OrdenPagoItemB, compareResult) Then
                Return OrdenPagoItemA.Id.CompareTo(OrdenPagoItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal OrdenPagoItemA As OrdenPagoItem, ByVal OrdenPagoItemB As OrdenPagoItem, ByRef result As Integer) As Boolean
            If OrdenPagoItemA Is Nothing Then
                If OrdenPagoItemB Is Nothing Then
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
                If OrdenPagoItemB Is Nothing Then
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
