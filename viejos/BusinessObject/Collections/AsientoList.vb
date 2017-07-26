Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class AsientoList
        Inherits List(Of Asiento)

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

        Public Shared Function CompareFecha(ByVal FacturaA As Factura, ByVal FacturaB As Factura) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(FacturaA, FacturaB, compareResult) Then
                Return Date.Compare(FacturaA.Fecha, FacturaB.Fecha)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareObra(ByVal FacturaA As Factura, ByVal FacturaB As Factura) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(FacturaA, FacturaB, compareResult) Then
                Return String.Compare(FacturaA.Obra, FacturaB.Obra)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareId(ByVal FacturaA As Factura, ByVal FacturaB As Factura) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(FacturaA, FacturaB, compareResult) Then
                Return FacturaA.Id.CompareTo(FacturaB.Id)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareSector(ByVal FacturaA As Factura, ByVal FacturaB As Factura) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(FacturaA, FacturaB, compareResult) Then
                Return String.Compare(FacturaA.Sector, FacturaB.Sector)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal FacturaA As Factura, ByVal FacturaB As Factura, ByRef result As Integer) As Boolean
            If FacturaA Is Nothing Then
                If FacturaB Is Nothing Then
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
                If FacturaB Is Nothing Then
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