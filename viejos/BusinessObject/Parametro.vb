Imports System
Imports System.ComponentModel
Imports System.Diagnostics

Namespace Pronto.ERP.BO

    <Serializable()> Public Class Parametro
        Private _Id As Integer = -1

        Private _RazonSocial As String = String.Empty
        Private _Direccion As String = String.Empty
        Private _IdLocalidad As Integer = 0

    End Class

End Namespace