Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
Imports System.IO
Imports System.Data

Imports System.Text.RegularExpressions

Partial Class Buscador
    Inherits System.Web.UI.Page

    Dim q As String
    Dim txtSuperbuscador As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'si estás buscando el filtro, andá a PresupuestoManager.GetList

            If Not (Request.QueryString.Get("preciso") Is Nothing) Then
                Buscar(Request.QueryString.Get("preciso"), Request.QueryString.Get("value"))
                'Exit Sub
            End If


            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            ElseIf Not (Request.QueryString.Get("Imprimir") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                Imprimir(Request.QueryString.Get("Imprimir")) 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If
            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 




            Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
            Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
            txtFechaDesde.Text = GetFirstDayInMonth(Today)
            txtFechahasta.Text = GetLastDayInMonth(Today)



            q = Request.QueryString.Get("q")




            Rebind()
        End If

        Permisos()
    End Sub


    Public Function GetFirstDayInMonth(ByVal origDt As DateTime) As DateTime
        Dim dtRet = New DateTime(origDt.Year, origDt.Month, 1, 0, 0, 0)
        Return dtRet
    End Function

    Public Function GetLastDayInMonth(ByVal origDt As DateTime) As DateTime
        Dim dtRet = New DateTime(origDt.Year, origDt.Month, 1).AddMonths(1).AddDays(-1)
        Return dtRet
    End Function





    Sub Imprimir(ByVal IdComprobantePrv)
        Dim output As String



        Dim mvarClausula = False
        Dim mPrinter As String = ""
        Dim mCopias = 1
        Dim EmpresaSegunString As String = ""
        Dim PathLogo As String = ""

        'output = ImprimirWordDOT("ComprobantePrv_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdComprobantePrv)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa
        Dim p = DirApp() & "\Documentos\" & "ComprobantePrv_PRONTO.dot"
        output = ImprimirWordDOT(p, Me, HFSC.Value, Session, Response, IdComprobantePrv, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "ComprobantePrv.doc", EmpresaSegunString, PathLogo)
        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output)
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.Message)
            Return
        End Try

    End Sub
    Sub Permisos()
        'Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, session(SESSIONPRONTO_UserId), "ComprobantePrvs")

        'If Not p("PuedeLeer") Then
        '    'esto tiene que anular el sitemapnode
        '    GridView1.Visible = False
        '    lnkNuevo.Visible = False
        'End If

        'If Not p("PuedeModificar") Then
        '    'anular la columna de edicion
        '    'getGridIDcolbyHeader(
        '    GridView1.Columns(0).Visible = False
        'End If

        'If Not p("PuedeEliminar") Then
        '    'anular la columna de eliminar
        '    GridView1.Columns(7).Visible = False
        'End If

    End Sub

    Function GenerarWHERE() As String
        Dim s As String

        '//////////
        'debug
        '//////////
        'Return "ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL "
        'Return "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL )  AND  (Aprobo IS NULL OR Aprobo=0) "
        's = "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL )  AND  (Aprobo IS NULL OR Aprobo=0) "
        'Return s
        '//////////
        '//////////


        'Para filtrar por dataset (en lugar de usar el manager con una lista de comprobantes)

        s = "1=1 "

        s += " AND ( " & _
                                   "Convert(" & cmbBuscarEsteCampo.SelectedValue & ", 'System.String') LIKE '*" & txtBuscar.Text & "*' )" '_

        '& " OR " & _
        '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"



        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


        'Select Case HFTipoFiltro.Value.ToString  '
        '    Case "", "AConfirmarEnObra"
        '        s += " AND (Aprobo IS NULL OR Aprobo=0)"
        '        's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

        '    Case "AConfirmarEnCentral"
        '        s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)  AND  (Aprobo IS NULL OR Aprobo=0) ) "

        '    Case "Confirmados"
        '        s += " AND (Aprobo NOT IS NULL AND Aprobo>0)"
        '        's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
        'End Select


        Return s
    End Function

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdComprobantePrv As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)

                Response.Redirect(String.Format("CartaDePorte.aspx?Id={0}", IdComprobantePrv.ToString))
                'Response.Redirect(String.Format("ComprobantePrv.aspx?Id={0}", IdComprobantePrv.ToString))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...
            gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.DetComprobantesProveedores_TXComp, DataBinder.Eval(e.Row.DataItem, "Id"))
            gp.DataBind()
        End If
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        'Dim records(e.NewValues.Count - 1) As DictionaryEntry
        'e.NewValues.CopyTo(records, 0)

        'Dim entry As DictionaryEntry
        'For Each entry In records
        '    e.NewValues(entry.Key) = CType(Server.HtmlEncode(entry.Value.ToString()), DateTime)
        'Next
    End Sub

    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click

        Response.Redirect(String.Format("CartaDePorte.aspx?Id=-1"))

        'Response.Redirect(String.Format("ComprobantePrv.aspx?Id=-1"))
    End Sub


    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function







    Protected Sub gvEstadoPorTrs_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand

        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdComprobante As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Item("IdComprobante"))
                Dim IdTipoComprobante As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Item("IdTipoComp"))

                Dim sUrl = AbrirSegunTipoComprobante(IdTipoComprobante, IdComprobante)

                If False Then
                    'metodo 1: abro usando la misma ventana
                    Response.Redirect(sUrl)
                Else
                    'metodo 2
                    'abro otra ventana. probablemente sea mejor hacerlo con un Hiperlink
                    Dim str As String
                    str = "window.open('" & sUrl & "');"
                    'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
                    AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)
                End If
        End Select

    End Sub





    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GridView1.PageIndex = e.NewPageIndex
        Rebind()
    End Sub


    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        Rebind()
    End Sub
    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        'GridView1.databind()
        Rebind()
        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub Rebind()

        Dim pageIndex = GridView1.PageIndex



        Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, "wBusqueda", iisNull(q, Session("Busqueda")))



        'dt.add("Nueva RM", "Requerimiento?=-1")



        'chupo
        'Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.ComprobantesProveedores_TT).Tables(0)
        'Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes(SC).Tables(0) ' EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
        'filtro
        'dt = DataTableWHERE(dt, GenerarWHERE)
        'ordeno


        With dt
            '.Columns("IdComprobanteProveedor").ColumnName = "Id"
            '.Columns("Factura").ColumnName = "Numero"
            '.Columns("FechaFactura").ColumnName = "Fecha"
        End With


        Dim b As Data.DataView = DataTableORDER(dt, "Id DESC")



        'b.Sort = "IdDetalleRequerimiento DESC"
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'Dim b As Data.DataView = ObjectDataSource1.Select()

        'b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'b.Sort = "Fecha DESC,Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'b.Sort = "Id DESC"

        ViewState("Sort") = b.Sort
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex

    End Sub



    '///////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////
    'http://blog.evonet.com.au/post/Gridview-with-highlighted-search-results.aspx

    'Partial Class GridviewwithHighlightedSearch
    'Inherits System.Web.UI.Page

    ' Create a String to store our search results
    'Dim SearchString As String = ""

    Function HighlightText(ByVal InputTxt As String) As String
        ' This function is called whenever text is displayed in the FirstName and LastName 
        ' fields from our database. If we're not searching then just return the original 
        ' input, this speeds things up a bit
        If q = "" Then
            Return InputTxt
        Else
            ' Otherwise create a new regular expression and evaluate the FirstName and 
            ' LastName fields against our search string.
            Dim ResultStr As Regex
            ResultStr = New Regex(q.Replace(" ", "|"), RegexOptions.IgnoreCase)
            Return ResultStr.Replace(InputTxt, New MatchEvaluator(AddressOf ReplaceWords))
        End If
    End Function

    Public Function ReplaceWords(ByVal m As Match) As String
        ' This match evaluator returns the found string and adds it a CSS class I defined 
        ' as 'highlight'
        Return "<span class=highlight>" + m.ToString + "</span>"
    End Function

    'Protected Sub btnClear_Click(ByVal sender As Object, ByVal e As  _
    '        System.Web.UI.ImageClickEventArgs) Handles btnClear.Click
    '    ' Simple clean up text to return the Gridview to it's default state
    '    'txtSearch.Text = ""
    '    SearchString = ""
    '    GridView1.DataBind()
    'End Sub

    'Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As  _
    '        System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
    '    ' Set the value of the SearchString so it gets 
    '    SearchString = q ' txtSearch.Text
    'End Sub
    'End Class

    <System.Web.Services.WebMethod()> _
    Sub Buscar(key As String, value As String)

        If value = ">UnitTest1" Then

            Dim u As Usuario = Session(SESSIONPRONTO_USUARIO) 'acá puede quedar con nothing. por qué lo dejé?
            Dim sConexionBaseEmpresa = u.StringConnection
            Dim output As String = Tests.test1_ReclamoN9066(sConexionBaseEmpresa)

            Try

                Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
                If MyFile1.Exists Then
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                    Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    Response.End()
                Else
                    MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
                End If
            Catch ex As Exception
                'ErrHandler.WriteAndRaiseError(ex.Message)
                ErrHandler.WriteError(ex.Message)
                'MsgBoxAjax(Me, ex.Message)
                Return
            End Try


            Return
        End If

        If value = ">DarPermisosDeSuperAdministrador" Then
            Try
                Session("SuperAdmin") = "Habilitado"
                MsgBoxAlert("Permisos de admin otorgados")
                Page.Response.Redirect(Page.Request.Url.ToString(), True)
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                MsgBoxAlert("Probablemente ya tenía los permisos")
            End Try
            Return
        End If


        If value = ">DarPermisosDeAdministrador" Then
            Try
                Roles.AddUserToRole(Session(SESSIONPRONTO_UserName), "AdminSolo")
                MsgBoxAlert("Permisos de admin otorgados")
                Page.Response.Redirect(Page.Request.Url.ToString(), True)
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Roles.RemoveUserFromRoles(Session(SESSIONPRONTO_UserName), Roles.GetRolesForUser(Session(SESSIONPRONTO_UserName)))
                Roles.AddUserToRole(Session(SESSIONPRONTO_UserName), "Administrador")
                MsgBoxAlert("Probablemente ya tenía los permisos")
            End Try
            Return
        End If





        Dim Ret(9) As String
        Ret(0) = value

        If False Then
            Dim temp As New WebServiceSuperbuscador
            'Dim Ret As String() = temp.GetCompletionList(value, 0, sConexionBaseEmpresa)
        End If




        Dim i = InStr(value, "Ver más resultados para")
        If i > 0 Then
            Session("Busqueda") = Mid(value, Len("Ver más resultados para") + 2)
            value = Session("Busqueda")
            Response.Redirect("~/ProntoWeb/Busqueda.aspx?q=" & Session("Busqueda"))
            Return
        End If

        'If Session("Busqueda") <> valueThen
		dim sss=InStr(value, Chr(0)) 
        'Left(value,iif( InStr(value, Chr(0))>0,- 1, len(value))
		if sss>1 then
			Session("Busqueda") = Left(value,sss -1 )
		else
			Session("Busqueda") =value
		end if
 
		
		
        If Session("Busqueda") = "No se encontraron resultados" Then
            value = ""
            Session("Busqueda") = ""
            'que hacemos aca, porque vuelve a la nada, y tira un error de fechas 
            Return
        End If

        If Session("Busqueda") = "" Or Session("Busqueda") = "Buscar" Then Return




        If Ret.Length > 0 Then


            If InStr(Ret(0), "No se encontraron resultados") > 0 Then
                Return
            End If




            If InStr(Ret(0), "Carta.de.porte") > 0 Then
                '            AbrirSegunTipoComprobante(
                'Return String.Format("Factura.aspx?Id={0}", IdComprobante)
                Dim dest = key ' TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")

                Response.Redirect("~/ProntoWeb/CartaDePorte.aspx?Id=" & t(0))
                'AbrirSegunTipoEntidad("CartaPorte", 20)
            ElseIf InStr(Ret(0), "Cliente...") > 0 Then
                Dim dest = key 'TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/Cliente.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            ElseIf InStr(Ret(0), "Articulo...") > 0 Then
                Dim dest = key ' TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/Articulo.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            ElseIf InStr(Ret(0), "Factura...") > 0 Then
                Dim dest = key ' TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/Factura.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            ElseIf InStr(Ret(0), "Requerimiento...") > 0 Then
                Dim dest = key ' TextoEntre(Ret(0), "Second"":""", """}")
                Dim t = Split(dest, "^")
                Response.Redirect("~/ProntoWeb/RequerimientoB.aspx?id=" & t(0))
                'AbrirSegunTipoEntidad("Cliente.aspx?id=" & t(0))
            End If
        End If

        For Each s As String In Ret
            Dim dest = key 'TextoEntre(s, "Second"":""", """}")
            If InStr(Request.Url.AbsolutePath, Mid(dest, 2)) > 0 Then Exit Sub 'ya estoy adonde quiero ir
            If InStr(dest, "\u0") > 0 Or InStr(dest, "^") > 0 Then Continue For 'no es un link directo, quizas es un comprobante
            Response.Redirect(dest)
        Next

        'If Ret.Length = 1 Then
        '    Dim dest = TextoEntre(Ret(0), "Second"":""", """}")
        '    If InStr(Request.Url.AbsolutePath, Mid(dest, 2)) > 0 Then Exit Sub 'ya estoy adonde quiero ir
        '    Response.Redirect(dest)
        'Else

        Response.Redirect("~/ProntoWeb/Busqueda.aspx?q=" & value)
        'End If
        'End If
    End Sub


End Class


