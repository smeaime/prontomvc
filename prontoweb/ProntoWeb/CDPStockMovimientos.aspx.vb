Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Diagnostics
Imports System.IO
Imports System.Data

Imports System.Web.Services
Imports Microsoft.Reporting.WebForms

Imports CartaDePorteManager

Partial Class CDPStockMovimientos
    Inherits System.Web.UI.Page







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
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            ElseIf Not (Request.QueryString.Get("Imprimir") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                Imprimir(Request.QueryString.Get("Imprimir")) 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If
            Rebind()
            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
        End If

        Permisos()

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button1)


    End Sub





    Sub Imprimir(ByVal IdCDPStockMovimiento)
        Dim output As String
        'output = ImprimirWordDOT("CDPStockMovimiento_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdCDPStockMovimiento)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa





        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1


        'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
        'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
        'llamada a Emision desde el Excel del servidor y ver donde explota.
        '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
        '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!
        '-Por ahora usá la de FontanaNicastro, que no tiene controlcito para codigo de barras
        'Dim p = "CDPStockMovimiento_A_FontanaNicastro.dot" '"CDPStockMovimiento.dot"   "CDPStockMovimiento_PRONTO.dot"
        Dim p = DirApp() & "\Documentos\" & "CDPStockMovimiento_Williams.dot"


        Try
            output = ImprimirWordDOT(p, Me, HFSC.Value, Session, Response, IdCDPStockMovimiento, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "CDPStockMovimiento.doc")
        Catch ex As System.Runtime.InteropServices.COMException
            'If ex.ToString = "No se puede abrir el almacenamiento de macros." Then
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala (NO DESDE SU EQUIPO, sino en el servidor o por terminal), pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala, pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        End Try







        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnAceptaDevolucion)
                Response.TransmitFile(output)
                Response.End()
            Else
                'MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'No se puede abrir el almacenamiento de macros
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'Return
        End Try

    End Sub

    Sub Permisos()
        Exit Sub
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "CDPStockMovimientos")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            GridView1.Visible = False
            lnkNuevo.Visible = False
        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            GridView1.Columns(0).Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            GridView1.Columns(7).Visible = False
        End If

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
            Case "ver"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdCDPStockMovimiento As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)

                Dim sUrl As String = String.Format("CDPStockMovimiento.aspx?Id={0}", IdCDPStockMovimiento.ToString)
                'Response.Redirect(sUrl)

                Dim str As String
                str = "window.open('" & sUrl & "', 'List', 'scrollbars=no,resizable=no,width=1200,height=800,left=0,top=0,toolbar=No,status=No,fullscreen=No');"
                AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)



        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...
            'gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, "DetCDPStockMovimientos_TXFac", DataBinder.Eval(e.Row.DataItem, "Id"))
            'gp.DataBind()

            'http://stackoverflow.com/questions/331231/c-gridview-row-click
            e.Row.Attributes("onClick") = "location.href='CDPStockMovimiento.aspx?Id=" + DataBinder.Eval(e.Row.DataItem, "IdCDPMovimiento").ToString + "'"
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
        Response.Redirect(String.Format("CDPStockMovimiento.aspx?Id=-1"))
    End Sub


    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (Session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function

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
        Rebind()
        'GridView1.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
        Rebind()
    End Sub
    Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
        Rebind()
    End Sub


    Sub Rebind()




        'todo: la grilla no está trayendo los nombres de los clientes, el puerto, el articulo....

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////





        Dim dt As DataTable
        'Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        'Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)

        'Dim ds = CDPStockMovimientoManager.GetList(HFSC.Value)
        'dt = ds.VistaCartasPorteMovimientos

        dt = GetStoreProcedure(HFSC.Value, enumSPs.wCartasDePorteMovimientos_TT)



        Dim desde As Date
        If txtFechaDesde.Text = "" Then
            desde = #1/1/1900#
        Else
            desde = TextoAFecha(txtFechaDesde.Text)
        End If

        Dim hasta As Date '= IIf(txtFechahasta.Text = "", Today, TextoAFecha(txtFechahasta.Text))
        If txtFechaHasta.Text = "" Then
            hasta = Today
        Else
            hasta = TextoAFecha(txtFechaHasta.Text)
        End If

        'Dim cmbMesFiltro As DropDownList = CType(Master.FindControl("cmbMesFiltro"), DropDownList)

        'If cmbMesFiltro.Text = "Todas" Then
        'If False Then
        '    txtFechaDesde.Text = #1/1/1900#
        '    txtFechahasta.Text = #1/1/2100#
        'Else
        '    txtFechaDesde.Text = GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
        '    txtFechahasta.Text = GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
        'End If


        Dim pageIndex = GridView1.PageIndex




        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'filtro
        dt = DataTableWHERE(dt, GenerarWHERE)


        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'ordeno
        Dim b As Data.DataView = DataTableORDER(dt, "IdCDPMovimiento DESC")
        ViewState("Sort") = b.Sort


        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex


    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim filtro = ""
        Dim ReporteLocal = New Microsoft.Reporting.WebForms.ReportViewer()
        Dim output = "c:\asdad.xls"

        Dim s = New ServicioCartaPorte.servi()
        Dim sqlquery4 = s.CDPMovimientos_DynamicGridData_ExcelExportacion_UsandoInternalQuery(HFSC.Value, "IdCDPMovimiento", "desc", 1, 999999, True, filtro)



        CartaDePorteManager.RebindReportViewer_ServidorExcel(ReporteLocal, "Carta Porte - Situacion.rdl", sqlquery4, HFSC.Value, False, output)



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
            'ErrHandler2.WriteAndRaiseError(ex.tostring)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.tostring)
            Return
        End Try


    End Sub






    <WebMethod()> _
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)> _
    Public Shared Function ExportarGrillaNormal(filters As String, fechadesde As String, fechahasta As String, destino As String) As String

        Dim SC As String
        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim idDestino = BuscaIdWilliamsDestinoPreciso(destino, SC)

        Dim output As String = "\DataBackupear\Listado " + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls"
        Dim fisico As String = ConfigurationManager.AppSettings("DirApp") + output
        Dim url As String = ConfigurationManager.AppSettings("UrlDominio").ToString + output




        Dim ReporteLocal As ReportViewer = New Microsoft.Reporting.WebForms.ReportViewer()


        Dim s = New ServicioCartaPorte.servi()

        Dim sqlquery4 = s.CDPMovimientos_DynamicGridData_ExcelExportacion_UsandoInternalQuery(SC, "IdCartaDePorte", "desc", 1, 999999, True, filters)



        CartaDePorteManager.RebindReportViewer_ServidorExcel(ReporteLocal, "Carta Porte - Buques.rdl", sqlquery4, SC, False, fisico)



        'Dim yourParams As ReportParameter() = New ReportParameter(9) {}

        'yourParams(0) = New ReportParameter("webservice", "")
        'yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
        'yourParams(2) = New ReportParameter("idArticulo", -1)
        'yourParams(3) = New ReportParameter("idDestino", -1)
        'yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
        'yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
        'yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
        'yourParams(7) = New ReportParameter("Consulta", sqlquery4)
        'yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(SC))
        'yourParams(9) = New ReportParameter("titulo", "_")



        'RebindReportViewer_ServidorExcel(ReporteLocal, "Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, fisico, False)


        Return url
    End Function


End Class
