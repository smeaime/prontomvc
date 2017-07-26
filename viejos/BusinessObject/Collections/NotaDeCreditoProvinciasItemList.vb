Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeCreditoProvinciasItemList
        Inherits List(Of NotaDeCreditoProvinciasItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal NotaDeCreditoItemA As NotaDeCreditoItem, ByVal NotaDeCreditoItemB As NotaDeCreditoItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeCreditoItemA, NotaDeCreditoItemB, compareResult) Then
                Return NotaDeCreditoItemA.Id.CompareTo(NotaDeCreditoItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal NotaDeCreditoItemA As NotaDeCreditoItem, ByVal NotaDeCreditoItemB As NotaDeCreditoItem, ByRef result As Integer) As Boolean
            If NotaDeCreditoItemA Is Nothing Then
                If NotaDeCreditoItemB Is Nothing Then
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
                If NotaDeCreditoItemB Is Nothing Then
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
