Imports System
Imports System.Collections.Generic

Namespace Pronto.ERP.BO

    <Serializable()> Public Class RequerimientoList
        Inherits List(Of Requerimiento)

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

        Public Shared Function CompareFecha(ByVal requerimientoA As Requerimiento, ByVal requerimientoB As Requerimiento) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(requerimientoA, requerimientoB, compareResult) Then
                Return Date.Compare(requerimientoA.Fecha, requerimientoB.Fecha)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareObra(ByVal requerimientoA As Requerimiento, ByVal requerimientoB As Requerimiento) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(requerimientoA, requerimientoB, compareResult) Then
                Return String.Compare(requerimientoA.Obra, requerimientoB.Obra)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareId(ByVal requerimientoA As Requerimiento, ByVal requerimientoB As Requerimiento) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(requerimientoA, requerimientoB, compareResult) Then
                Return requerimientoA.Id.CompareTo(requerimientoB.Id)
            Else
                Return compareResult
            End If
        End Function

        Public Shared Function CompareSector(ByVal requerimientoA As Requerimiento, ByVal requerimientoB As Requerimiento) As Integer
            Dim compareResult As Integer = 0
            If Not CompareBase(requerimientoA, requerimientoB, compareResult) Then
                Return String.Compare(requerimientoA.Sector, requerimientoB.Sector)
            Else
                Return compareResult
            End If
        End Function

        Private Shared Function CompareBase(ByVal requerimientoA As Requerimiento, ByVal requerimientoB As Requerimiento, ByRef result As Integer) As Boolean
            If requerimientoA Is Nothing Then
                If requerimientoB Is Nothing Then
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
                If requerimientoB Is Nothing Then
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