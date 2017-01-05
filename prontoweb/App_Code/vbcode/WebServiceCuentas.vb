Imports System
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Collections.Generic
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
<System.Web.Script.Services.ScriptService()> _
Public Class WebServiceCuentas
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetCompletionList(ByVal prefixText As String, ByVal count As Integer, ByVal contextKey As String) As String()
        'Dim c1 As Char
        'Dim c2 As Char
        'Dim c3 As Char

        If (count = 0) Then
            count = 10
        End If

        Dim rnd As New Random()

        Dim items As New List(Of String)

        Dim cod As String




        Dim sc As String '= "Data Source=NANOPC\SQLEXPRESS;Initial catalog=Equimac;User ID=sa; Password=ok;Connect Timeout=45"
        sc = contextKey ' SplitRapido(contextKey, "|", 0)
        '/////////////////////////////
        '/////////////////////////////
        'funciona esto? conviene?
        'Dim Usuario As New Usuario
        'Usuario = session(SESSIONPRONTO_USUARIO)
        'sc = Usuario.StringConnection
        '/////////////////////////////
        '/////////////////////////////




        'Dim articulolist = EntidadManager.GetStoreProcedure(sc, "Transportistas_TX_Busqueda", prefixText)

        Dim lista As Data.DataTable
        Dim idCuentaGrupo = SplitRapido(contextKey, "|", 1)

        Try
            If iisNull(idCuentaGrupo, 0) > 0 Then
                lista = EntidadManager.ExecDinamico(sc, "SELECT  TOP 100  IdCuenta,Descripcion,Codigo FROM Cuentas WHERE Descripcion + ' ' + Convert(varchar,Codigo) LIKE '" & prefixText & "%' AND IdTipoCuentaGrupo=" & idCuentaGrupo)
            Else
                lista = EntidadManager.ExecDinamico(sc, "SELECT  TOP 100  IdCuenta,Descripcion,Codigo FROM Cuentas WHERE Descripcion + ' ' + Convert(varchar,Codigo) LIKE '" & prefixText & "%'")
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            lista = EntidadManager.ExecDinamico(sc, "SELECT  TOP 100  IdCuenta,Descripcion,Codigo FROM Cuentas WHERE Descripcion + ' ' + Convert(varchar,Codigo) LIKE '" & prefixText & "%'")
        End Try






        For Each cuenta As Data.DataRow In lista.Rows
            'items.Add(articulo.Descripcion)

            cod = cuenta.Item("IdCuenta") ' & "^" & proveedor.Item("Cuit")
            Dim texto = cuenta.Item("Descripcion") & " " & cuenta.Item("Codigo")
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(texto, cod))
        Next

        If lista.Rows.Count = 0 Then
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        End If




        Return items.ToArray()
    End Function

End Class
