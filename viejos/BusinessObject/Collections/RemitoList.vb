Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class RemitoList
        Inherits List(Of Remito)

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

        Public Shared Function CompareFecha(ByVal RemitoA As Remito, ByVal RemitoB As Remito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(RemitoA, RemitoB, compareResult) Then
                Return Date.Compare(RemitoA.Fecha, RemitoB.Fecha)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareObra(ByVal RemitoA As Remito, ByVal RemitoB As Remito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(RemitoA, RemitoB, compareResult) Then
                Return String.Compare(RemitoA.Obra, RemitoB.Obra)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareId(ByVal RemitoA As Remito, ByVal RemitoB As Remito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(RemitoA, RemitoB, compareResult) Then
                Return RemitoA.Id.CompareTo(RemitoB.Id)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareSector(ByVal RemitoA As Remito, ByVal RemitoB As Remito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(RemitoA, RemitoB, compareResult) Then
                Return String.Compare(RemitoA.Sector, RemitoB.Sector)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal RemitoA As Remito, ByVal RemitoB As Remito, ByRef result As Integer) As Boolean
            If RemitoA Is Nothing Then
                If RemitoB Is Nothing Then
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
                If RemitoB Is Nothing Then
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