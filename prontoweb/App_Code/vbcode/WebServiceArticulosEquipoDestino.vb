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
Public Class WebServiceArticulosEquipoDestino
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
        sc = contextKey

        If sc Is Nothing Then
            ErrHandler2.WriteAndRaiseError("Al autocomplete le falta asignarle la cadena de conexión")
        End If



        'podria llamar directamente un storeproc....
        Dim sTabla = "Articulos"
        Dim sColumnaDescripcion = "Descripcion"
        Dim sColumnaCodigo = "NumeroInventario"

        'TODO:
        'Articulos_TX_ParaMantenimiento_ParaCombo es el store

        Dim s = "SELECT TOP 500 IdArticulo,  " & _
                "           isnull(" & sColumnaCodigo & ",'') COLLATE Modern_Spanish_ci_as + ' ' + " & _
                "           isnull(" & sColumnaDescripcion & ",'') + '' COLLATE Modern_Spanish_ci_as as Descripcion   " & _
                " FROM Articulos " & _
                " WHERE " & _
                "			" & sColumnaDescripcion & " like '%[^A-z^0-9]' + '" & prefixText & "' + '%' " & _
                "        OR " & sColumnaDescripcion & " like  '" & prefixText & "' + '%'  " & _
                "        OR " & sColumnaCodigo & " like  '" & prefixText & "' + '%'  "

        Dim articulolist = EntidadManager.ExecDinamico(sc, s)



        For Each articulo As Data.DataRow In articulolist.Rows
            'items.Add(articulo.Descripcion)

            cod = articulo.Item("IdArticulo") & "^" & articulo.Item("Descripcion")
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(articulo.Item("Descripcion"), cod))
        Next

        'http://vincexu.blogspot.com/2008/12/custom-autocomplete-3-check-if.html
        If articulolist.Rows.Count = 0 Then
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No se encontraron resultados", -1))
        End If


        'Dim articulolist As ArticuloList = ArticuloManager.GetListParaWebService(sc, prefixText) 'codigo, Description, Convert.ToInt32(idRubro))
        'For Each articulo As Pronto.ERP.BO.Articulo In articulolist
        '    'items.Add(articulo.Descripcion)

        '    cod = articulo.Id & "^" & articulo.Codigo

        '    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(articulo.Descripcion, cod))
        'Next

        ' '//////////////////////////////////////////////////////////////////////////////////////////////
        ' '//////////////////////////////////////////////////////////////////////////////////////////////
        ' 'codigo para traer el ID
        ' ' http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/
        ' 'http://forums.asp.net/t/1162005.aspx
        ' 'http://forums.asp.net/p/1131690/1796218.aspx
        ' 'http://www.codeplex.com/AjaxControlToolkit/WorkItem/View.aspx?WorkItemId=9043

        ' http://blogs.msdn.com/phaniraj/archive/2007/06/19/how-to-use-a-key-value-pair-in-your-autocompleteextender.aspx
        ' '//////////////////////////////////////////////////////////////////////////////////////////////
        ' '//////////////////////////////////////////////////////////////////////////////////////////////

        ' Dim Co As String


        'c string[] GetCompletionListWithContextAndValues(string prefixText, int count, string contextKey)
        '         {
        '             Generic.List<string>(GetCompletionListWithContext(prefixText, count, contextKey));
        '             for (int i = 0; i < items.Count; i++)
        '             {
        '                 items[i] = AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(items[i], i.ToString());
        '             }
        '             return items.ToArray();
        '         }

        '     For Each articulo As Pronto.ERP.BO.Articulo In articulolist
        '         items.Add(articulo.Descripcion)


        '         Co = articulo.Codigo & "," & articulo.Descripcion
        '         If sQuickName.StartsWith(prefixText, StringComparison.OrdinalIgnoreCase) Or sCompany.StartsWith(prefixText, StringComparison.OrdinalIgnoreCase) Or sLocationName.StartsWith(prefixText, StringComparison.OrdinalIgnoreCase) Then
        '             '—add the member name to the list if the text starts with the variables—
        '             listOfMembersStartsWith.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(Co, dr("ReceiverPK")))
        '         Else
        '             '—add the member name to the list if the text contains the keyword but not as an prefix—
        '             listOfMembersNotStartsWith.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(Co, dr("ReceiverPK")))
        '         End If

        '     Next




        '     '//////////////////////////////////////////////////////////////////////////////////////////////
        '     '//////////////////////////////////////////////////////////////////////////////////////////////
        '     '//////////////////////////////////////////////////////////////////////////////////////////////
        '     '//////////////////////////////////////////////////////////////////////////////////////////////




        Return items.ToArray()
    End Function

End Class
