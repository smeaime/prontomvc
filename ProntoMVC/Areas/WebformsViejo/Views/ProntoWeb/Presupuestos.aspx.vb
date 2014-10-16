Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports Pronto.ERP.Bll.EntidadManager


Partial Class Presupuestos
    Inherits System.Web.UI.Page

    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))

        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////

            TraerCuentaFFasociadaALaObra()



            Debug.Print(Session("glbWebIdProveedor"))
            If Not IsNumeric(Session("glbWebIdProveedor")) Then
                'es un usuario administrador

                ResumenVisible(False)
                HFIdProveedor.Value = -1

            Else
                'es un proveedor

                'TraerResumenDeCuentaFF()
                Debug.Print(Session("glbWebIdProveedor"))
                'BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor"))
                HFIdProveedor.Value = Session("glbWebIdProveedor") 'metodo original: acá usa el filtro manual por GetList


            End If




            Me.Title = "Solicitudes de Cotización"



            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            ElseIf Not (Request.QueryString.Get("Imprimir") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                Imprimir(Request.QueryString.Get("Imprimir")) 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If

            ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 


        End If


        '///////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////
        'Bloqueos
        '///////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////
        If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Then
            LinkAgregarRenglon.Visible = False
        Else
            LinkAgregarRenglon.Visible = True
        End If
    End Sub



    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdPresupuesto As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Presupuesto.aspx?Id={0}", IdPresupuesto.ToString))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
            Try
                gp.DataSource = ObjectDataSource2.Select
                gp.DataBind()
            Catch ex As Exception
                'Debug.Print(ex.Message)
                ErrHandler.WriteError(ex)

                Throw New ApplicationException("Error en la grabacion " + ex.Message, ex)
            Finally
            End Try
            gp.Width = 200

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


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GridView1.PageIndex = e.NewPageIndex
        Rebind()
    End Sub

    Sub Rebind()
        Dim pageIndex = GridView1.PageIndex
        ObjectDataSource1.FilterExpression = GenerarWHERE()
        Dim b As Data.DataView = ObjectDataSource1.Select()
        'Debug.Print(DebugGetDataTableColumnNames(b.d))
        'b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'b.Sort = "[Fecha Factura] DESC,Numero DESC" 
        b.Sort = "Id DESC"
        ViewState("Sort") = b.Sort
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'Combos
    '////////////////////////////////////////////////////////////////////////////////////

    Private Sub BindTypeDropDown()
        'cmbCuenta.DataSource = Pronto.ERP.Bll.CuentaManager.GetListCombo(SC)
        'cmbCuenta.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")

        'sieltipo tiene una obra asignada, qué hago acá?
        TraerCuentaFFasociadaALaObra()




    End Sub




    '///////////////////////////////////
    '///////////////////////////////////
    'refrescos
    '///////////////////////////////////


    Protected Sub cmbCuenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCuenta.SelectedIndexChanged
        TraerResumenDeCuentaFF()
    End Sub


    Sub TraerCuentaFFasociadaALaObra()

        cmbCuenta.DataSource = Pronto.ERP.Bll.ProveedorManager.GetListCombo(HFSC.Value)
        cmbCuenta.DataTextField = "Titulo"
        cmbCuenta.DataValueField = "IdProveedor"
        'cmbCuenta.DataBind()  'BEEEESSSTTIIAAA!!!! un combo con los proveedores?????? Eso es una pagina gordita!

        If IsNumeric(Session("glbWebIdProveedor")) Then
            BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor")) 'uso datos de la tabla "empleados"
            'cmbCuenta.Enabled = False
            'ElseIf Pronto.ERP.Bll.ObraManager.GetItem(HFSC.Value, HFIdObra.Value).IdCuentaContableFF Then 'uso datos de la tabla "obras"
            '    BuscaIDEnCombo(cmbCuenta, Pronto.ERP.Bll.ObraManager.GetItem(HFSC.Value, HFIdObra.Value).IdCuentaContableFF)
            '    'cmbCuenta.Enabled = False
        Else
            cmbCuenta.Items.Insert(0, New ListItem("-- Elija una Cuenta --", -1))
            cmbCuenta.SelectedIndex = 0
        End If
    End Sub



    Sub TraerResumenDeCuentaFF()
        Dim dsTemp As System.Data.DataSet
        dsTemp = Pronto.ERP.Bll.EntidadManager.GetListTX(GetConnectionString(Server, Session), "FondosFijos", "TX_ResumenPorIdCuenta", cmbCuenta.SelectedValue)
        If dsTemp.Tables(0).Rows.Count > 0 Then
            ResumenVisible(True)
            With dsTemp.Tables(0).Rows(0)
                txtPendientesReintegrar.Text = iisNull(.Item("PagosPendientesReintegrar"))
                txtReposicionSolicitada.Text = iisNull(.Item("Reposicion solicitada"))
                txtSaldo.Text = iisNull(.Item("Saldo"))
                txtTotalAsignados.Text = iisNull(.Item("Fondos asignados"))

                'Campos de FondosFijos_TX_Resumen:
                'IdCuenta,
                '[Cuenta FF],
                '[Rendicion],
                '[Fondos asignados],
                '[Reposicion solicitada],
                '[Rendiciones reintegradas],
                ' IsNull(FondosAsignados,0)-IsNull(ReposicionSolicitada,0)+IsNull(RendicionesReintegradas,0) as [Saldo],
                ' PagosPendientesReintegrar as [PagosPendientesReintegrar],

            End With
        Else
            ResumenVisible(False)
        End If
    End Sub


    '///////////////////////////////////
    '///////////////////////////////////
    'botones y links
    '///////////////////////////////////


    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        Response.Redirect(String.Format("Presupuesto.aspx?Id=-1"))
    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        GridViewExportUtil.Export("Grilla.xls", GridView1)
    End Sub

    '///////////////////////////////////
    '///////////////////////////////////
    'toggles
    '///////////////////////////////////

    Sub ResumenVisible(ByVal estado As Boolean)
        txtPendientesReintegrar.Visible = estado
        txtReposicionSolicitada.Visible = estado
        txtSaldo.Visible = estado
        txtTotalAsignados.Visible = estado
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

        s += " AND " & _
                                             "(Convert([Numero Presupuesto], 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert([Razon social], 'System.String') LIKE '*" & txtBuscar.Text & "*'  )"


        'si es un usuario proveedor, filtro sus comprobantes
        If IsNumeric(Session("glbWebIdProveedor")) Then
            s += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        End If


        Select Case HFTipoFiltro.Value.ToString  '
            Case "", "AConfirmarEnObra"
                s += " AND (Aprobo IS NULL OR Aprobo=0)"
                's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

            Case "AConfirmarEnCentral"
                s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)  AND  (Aprobo IS NULL OR Aprobo=0) ) "

            Case "Confirmados"
                s += " AND (Aprobo NOT IS NULL AND Aprobo>0)"
                's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
        End Select


        Return s
    End Function

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        Rebind()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub Imprimir(ByVal IdPresupuesto As Long)
        Dim output As String
        'output = ImprimirWordDOT("Presupuesto_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdPresupuesto)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa
        output = ImprimirWordDOT("Presupuesto_PRONTO.dot", Me, HFSC.Value, Session, Response, IdPresupuesto, "" & mvaragrupar & "|")
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
End Class
