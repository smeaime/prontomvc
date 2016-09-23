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
Public Class WebServiceClientesCUIT
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
        'sc = SplitRapido(contextKey, "|", 0)
        sc = contextKey
        '/////////////////////////////
        '/////////////////////////////
        'funciona esto? conviene?
        'Dim Usuario As New Usuario
        'Usuario = session(SESSIONPRONTO_USUARIO)
        'sc = Usuario.StringConnection
        '/////////////////////////////
        '/////////////////////////////




        Dim lista = EntidadManager.GetStoreProcedure(sc, enumSPs.wClientes_TX_BusquedaConCUIT, prefixText)



        For Each Cliente As Data.DataRow In lista.Rows
            'items.Add(articulo.Descripcion)

            cod = Cliente.Item("IdCliente") & "^" & Cliente.Item("Cuit")
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(iisNull(Cliente.Item("RazonSocial")), cod))
        Next

        If lista.Rows.Count = 0 Then
            'no me conviene poner lo de "No se encontraron resultados" si uso FirstSelectedRow y permito altas al vuelo
            'items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        End If




        Return items.ToArray()
    End Function



    <WebMethod()> _
    Public Function GetCompletionListEntregadores(ByVal prefixText As String, ByVal count As Integer, ByVal contextKey As String) As String()
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
        'sc = SplitRapido(contextKey, "|", 0)
        sc = contextKey

        '/////////////////////////////
        '/////////////////////////////
        'funciona esto? conviene?
        'Dim Usuario As New Usuario
        'Usuario = session(SESSIONPRONTO_USUARIO)
        'sc = Usuario.StringConnection
        '/////////////////////////////
        '/////////////////////////////




        Dim lista = EntidadManager.GetStoreProcedure(sc, "wClientesEntregadores_TX_BusquedaConCUIT", prefixText)



        For Each Cliente As Data.DataRow In lista.Rows
            'items.Add(articulo.Descripcion)

            cod = Cliente.Item("IdCliente") & "^" & Cliente.Item("Cuit")
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(iisNull(Cliente.Item("RazonSocial")), cod))
        Next

        If lista.Rows.Count = 0 Then
            'no me conviene poner lo de "No se encontraron resultados" si uso FirstSelectedRow y permito altas al vuelo
            'items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        End If




        Return items.ToArray()
    End Function


End Class
