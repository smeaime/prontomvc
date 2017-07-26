Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class NotaDeCreditoList
        Inherits List(Of NotaDeCredito)

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

        Public Shared Function CompareFecha(ByVal NotaDeCreditoA As NotaDeCredito, ByVal NotaDeCreditoB As NotaDeCredito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeCreditoA, NotaDeCreditoB, compareResult) Then
                Return Date.Compare(NotaDeCreditoA.Fecha, NotaDeCreditoB.Fecha)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareObra(ByVal NotaDeCreditoA As NotaDeCredito, ByVal NotaDeCreditoB As NotaDeCredito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeCreditoA, NotaDeCreditoB, compareResult) Then
                Return String.Compare(NotaDeCreditoA.Obra, NotaDeCreditoB.Obra)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareId(ByVal NotaDeCreditoA As NotaDeCredito, ByVal NotaDeCreditoB As NotaDeCredito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeCreditoA, NotaDeCreditoB, compareResult) Then
                Return NotaDeCreditoA.Id.CompareTo(NotaDeCreditoB.Id)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareSector(ByVal NotaDeCreditoA As NotaDeCredito, ByVal NotaDeCreditoB As NotaDeCredito) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(NotaDeCreditoA, NotaDeCreditoB, compareResult) Then
                Return String.Compare(NotaDeCreditoA.Sector, NotaDeCreditoB.Sector)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal NotaDeCreditoA As NotaDeCredito, ByVal NotaDeCreditoB As NotaDeCredito, ByRef result As Integer) As Boolean
            If NotaDeCreditoA Is Nothing Then
                If NotaDeCreditoB Is Nothing Then
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
                If NotaDeCreditoB Is Nothing Then
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