Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class FacturaProvinciasItemList
        Inherits List(Of FacturaProvinciasItem)

        Public Sub New()
        End Sub



        Public Shared Function CompareId(ByVal FacturaItemA As FacturaProvinciasItem, ByVal FacturaItemB As FacturaProvinciasItem) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(FacturaItemA, FacturaItemB, compareResult) Then
                Return FacturaItemA.Id.CompareTo(FacturaItemB.Id)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal FacturaItemA As FacturaProvinciasItem, ByVal FacturaItemB As FacturaProvinciasItem, ByRef result As Integer) As Boolean
            If FacturaItemA Is Nothing Then
                If FacturaItemB Is Nothing Then
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
                If FacturaItemB Is Nothing Then
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
