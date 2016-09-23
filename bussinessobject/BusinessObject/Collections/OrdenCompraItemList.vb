Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class OrdenCompraItemList
        Inherits List(Of OrdenCompraItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal OrdenCompraA As OrdenCompra, ByVal OrdenCompraB As OrdenCompra) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(OrdenCompraA, OrdenCompraB, compareResult) Then
                Return OrdenCompraA.Id.CompareTo(OrdenCompraB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal OrdenCompraA As OrdenCompra, ByVal OrdenCompraB As OrdenCompra, ByRef result As Integer) As Boolean
            If OrdenCompraA Is Nothing Then
                If OrdenCompraB Is Nothing Then
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
                If OrdenCompraB Is Nothing Then
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
