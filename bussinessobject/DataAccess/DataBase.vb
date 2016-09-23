Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient

Public Class DataBase
    Private _conneccionString As Integer = 0
    Public Property ConneccionString() As Integer
        Get
            Return _conneccionString
        End Get
        Set(ByVal value As Integer)
            _conneccionString = value
        End Set
    End Property
End Class
