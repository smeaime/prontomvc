Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports System.Data
Imports System.Linq
Imports Microsoft.Reporting.WebForms
Imports ProntoFuncionesGenerales


Partial Class CtaCteDeudores
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
            Else
                HFTipoFiltro.Value = ""
            End If
            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
            gvCuentasRebind()
        End If


        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button3)

        Permisos()
    End Sub

    Sub Permisos()
        'Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, session(SESSIONPRONTO_UserId), "CtaCteDs")

        'If Not p("PuedeLeer") Then
        '    'esto tiene que anular el sitemapnode
        '    gvCuentas.Visible = False
        '    lnkNuevo.Visible = False
        'End If

        'If Not p("PuedeModificar") Then
        '    'anular la columna de edicion
        '    'getGridIDcolbyHeader(
        '    gvCuentas.Columns(0).Visible = False
        'End If

        'If Not p("PuedeEliminar") Then
        '    'anular la columna de eliminar
        '    gvCuentas.Columns(7).Visible = False
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

    Protected Sub gvCuentas_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvCuentas.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdCtaCteD As Integer = Convert.ToInt32(gvCuentas.DataKeys(rowIndex).Value)
                'Response.Redirect(String.Format("CtaCteD.aspx?Id={0}", IdCtaCteD.ToString))
        End Select
    End Sub

    Protected Sub gvCuentas_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvCuentas.RowDataBound
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", gvCuentas)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...
        '    gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, "DetOrdenesCompra_TXOCompra", DataBinder.Eval(e.Row.DataItem, "Id"))
        '    gp.DataBind()
        'End If
    End Sub

    Protected Sub gvCuentas_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvCuentas.RowUpdating
        'Dim records(e.NewValues.Count - 1) As DictionaryEntry
        'e.NewValues.CopyTo(records, 0)

        'Dim entry As DictionaryEntry
        'For Each entry In records
        '    e.NewValues(entry.Key) = CType(Server.HtmlEncode(entry.Value.ToString()), DateTime)
        'Next
    End Sub

    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click
        'Response.Redirect(String.Format("CtaCteD.aspx?Id=-1"))
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

    Protected Sub gvCuentas_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvCuentas.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        gvCuentas.PageIndex = e.NewPageIndex
        gvCuentasRebind()

    End Sub






    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        gvCuentasRebind()
    End Sub
    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        gvCuentasRebind()
        'gvCuentas.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub gvCuentasRebind()
        Dim pageIndex = gvCuentas.PageIndex
        ObjectDataSource1.FilterExpression = GenerarWHERE()
        Dim b As Data.DataView = ObjectDataSource1.Select()
        'b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        b.Sort = "Cliente ASC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        ViewState("Sort") = b.Sort
        gvCuentas.DataSourceID = ""
        gvCuentas.DataSource = b
        gvCuentas.DataBind()
        gvCuentas.PageIndex = pageIndex
    End Sub


    Protected Sub gvCuentas_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvCuentas.SelectedIndexChanged
        gvEstadoRebind()
    End Sub






    'Protected Sub RadioButtonPendientes_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonPendientes.CheckedChanged
    '    'ObjGrillaConsulta.SelectParameters.Add("TX", "_Pendientes1")
    'End Sub



    'Sub RebindReportViewer(ByVal rdlFile As String, ByVal dt As DataTable)
    '    'http://forums.asp.net/t/1183208.aspx

    '    With ReportViewer2
    '        .ProcessingMode = ProcessingMode.Local

    '        With .LocalReport
    '            .ReportPath = rdlFile
    '            .EnableHyperlinks = True
    '            .DataSources.Clear()
    '            '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
    '            .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
    '            '.ReportEmbeddedResource = rdlFile


    '            '/////////////////////
    '            'parametros (no uses la @ delante del parametro!!!!)
    '            '/////////////////////
    '            'Try
    '            '    If .GetParameters.Count > 1 Then
    '            '        If .GetParameters.Item(1).Name = "FechaDesde" Then
    '            '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
    '            '            Dim p2 = New ReportParameter("FechaDesde", Today)
    '            '            Dim p3 = New ReportParameter("FechaHasta", Today)
    '            '            .SetParameters(New ReportParameter() {p1, p2, p3})
    '            '        End If
    '            '    End If
    '            'Catch ex As Exception
    '            '    ErrHandler.WriteError(ex.Message)
    '            'End Try
    '            '/////////////////////
    '            '/////////////////////
    '            '/////////////////////
    '            '/////////////////////

    '        End With

    '        .DocumentMapCollapsed = True
    '        .LocalReport.Refresh()
    '        .DataBind()
    '    End With


    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    'ReportViewer2.Reset()
    '    'Dim rep As Microsoft.Reporting.WebForms.LocalReport = ReportViewer2.LocalReport

    '    ''rep.ReportPath = "SampleReport.rdlc"
    '    'Dim myConnection As SqlConnection = New SqlConnection(HFSC.Value)

    '    'Dim ds As Data.DataSet = RequerimientoManager.GetListTXDetallesPendientes(HFSC.Value) 'RequerimientoManager.GetListTX(HFSC.Value, )

    '    'Dim dsSalesOrder As New Microsoft.Reporting.WebForms.ReportDataSource()
    '    'dsSalesOrder.Name = "DataSet1"
    '    'dsSalesOrder.Value = ds.Tables(0)

    '    'rep.DataSources.Add(dsSalesOrder)

    '    'ds.ReadXml(Server.MapPath("SalesDataFile.xml"))
    '    'ds.ReadXml(HttpContext.Current.Request.MapPath("SalesDataFile.xml"))



    '    'ReportViewer2.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSource1", myConnection))
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////

    '    'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

    '    'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    'End Sub

    Function AsignaInformeAlReportViewer() As DataTable
        'Select Case cmbCuenta.Text
        '    Case "Descargas por Titular compactado (Notas de entrega) "
        '        'TraerDataset = NotasDeEntrega()

        '        '//LINQ - Strongly Typed DataSet
        '        '                DataRow(row = ds.Customers.AsEnumerable())
        '        '     .Where(i => i.CustID == 4)
        '        '     .FirstOrDefault();

        '        '//DataTable Example
        '        'DataRow row = customers.Select("CustID = 4")[0];

        '        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)).Tables(0)
        '        RebindReportViewer("ProntoWeb\Informes\Descargas por Titular - Compactado.rdl", ProntoFuncionesGenerales.DataTableWHERE(dt, generarWHERE()))

        '    Case "Notas de entrega continuo"
        '        'TraerDataset = generarNotasDeEntrega()



        '    Case Else
        '        MsgBoxAjax(Me, "El informe no existe. Consulte con el administrador")
        'End Select

    End Function

    Protected Sub gvEstadoPorMayor_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvEstadoPorMayor.PageIndexChanging
        gvEstadoPorMayor.PageIndex = e.NewPageIndex
        gvEstadoRebind()
    End Sub


    Protected Sub gvEstadoPorTrs_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvEstadoPorTrs.PageIndexChanging
        gvEstadoPorTrs.PageIndex = e.NewPageIndex
        gvEstadoRebind()
    End Sub



    Protected Sub gvEstadoPorMayor_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvEstadoPorMayor.RowCommand

        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdComprobante As Integer = Convert.ToInt32(gvEstadoPorMayor.DataKeys(rowIndex).Item("IdComprobante"))
                Dim IdTipoComprobante As Integer = Convert.ToInt32(gvEstadoPorMayor.DataKeys(rowIndex).Item("IdTipoComprobante"))

                Dim sUrl = AbrirSegunTipoComprobante(IdTipoComprobante, IdComprobante)

                Response.Redirect(sUrl)
        End Select

    End Sub


    Protected Sub gvEstadoPorTrs_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvEstadoPorTrs.RowCommand

        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdComprobante As Integer = Convert.ToInt32(gvEstadoPorTrs.DataKeys(rowIndex).Item("IdComprobante"))
                Dim IdTipoComprobante As Integer = Convert.ToInt32(gvEstadoPorTrs.DataKeys(rowIndex).Item("IdTipoComp"))

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


    Function AbrirSegunTipoComprobante(ByVal idtipocomprobante As IdTipoComprobante, ByVal IdComprobante As Long) As String

        Select Case idtipocomprobante

            Case idtipocomprobante.Factura
                Return String.Format("Factura.aspx?Id={0}", IdComprobante)
            Case EntidadManager.IdTipoComprobante.Recibo
                Return String.Format("Recibo.aspx?Id={0}", IdComprobante)
            Case EntidadManager.IdTipoComprobante.Remito
                Return String.Format("Remito.aspx?Id={0}", IdComprobante)
        End Select

    End Function



    'Protected Sub btnPorMayor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPorMayor.Click
    '    gvEstadoRebind()
    'End Sub

    'Protected Sub btnPorTransaccion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPorTransaccion.Click
    '    gvEstadoRebind()
    'End Sub

    Protected Sub RadioButtonListAlcance_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListAlcance.SelectedIndexChanged
        gvEstadoRebind()
    End Sub

    Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
        gvEstadoRebind()
    End Sub

    Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
        gvEstadoRebind()
    End Sub











    Sub gvEstadoRebind()

        'ObjectDataSource4.FilterExpression = GenerarWHERE()
        'Dim b As Data.DataView = ObjectDataSource4.Select()
        ''b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        ''b.Sort = "Cliente DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        ''ViewState("Sort") = b.Sort
        'gvEstadoPorMayor.DataSourceID = ""
        'gvEstadoPorMayor.DataSource = b

        Dim idcliente

        If IsNothing(gvCuentas.SelectedDataKey) Then Exit Sub

        idcliente = Convert.ToInt32(gvCuentas.SelectedDataKey.Value)

        Dim oCli = ClienteManager.GetItem(HFSC.Value, idcliente)
        lblCliente.Text = oCli.RazonSocial
        lblTelefono.Text = oCli.RazonSocial
        lblMail.Text = oCli.Email




        lblSaldo.Text = FF2(CtaCteDeudorManager.Saldo(HFSC.Value, idcliente))

        'ObjectDataSource4.SelectParameters.Clear()
        'ObjectDataSource4.SelectParameters.Add("SC", HFSC.Value)
        'ObjectDataSource4.SelectParameters.Add("TX", "PorMayor")
        'ObjectDataSource4.SelectParameters.Add("Param1", idcliente)
        'ObjectDataSource4.SelectParameters.Add("Param2", -1)
        'ObjectDataSource4.SelectParameters.Add("Param3", iisValidSqlDate(txtFechaDesde.Text))
        'ObjectDataSource4.SelectParameters.Add("Param4", iisValidSqlDate(txtFechaHasta.Text))
        'ObjectDataSource4.SelectParameters.Add("Param5", -1)

        If RadioButtonListTrans_O_Mayor.SelectedValue <> "Por Mayor" Then
            Dim pageIndex = gvEstadoPorTrs.PageIndex

            gvEstadoPorTrs.DataSourceID = ""
            'gvEstadoPorTrs.DataSource = DataTableORDER(GetDataSource(), "IdCtaCte DESC")
            'gvEstadoPorTrs.DataSource = DataTableORDER(GetDataSource(), "Fecha DESC,Numero DESC")
            gvEstadoPorTrs.DataSource = DataTableORDER(GetDataSource(), "IdImputacion,Cabeza,Fecha,Numero")


            gvEstadoPorTrs.Visible = True
            gvEstadoPorMayor.Visible = False

            gvEstadoPorTrs.DataBind()
            gvEstadoPorTrs.PageIndex = pageIndex
            'sp = "CtasCtesD_TXPorTrs"
        Else
            Dim pageIndex = gvEstadoPorMayor.PageIndex

            gvEstadoPorMayor.DataSourceID = ""
            'gvEstadoPorMayor.DataSource = DataTableORDER(GetDataSource(), "IdCtaCte DESC")
            gvEstadoPorMayor.DataSource = DataTableORDER(GetDataSource(), "Fecha DESC,Numero DESC")

            'sp = "CtasCtesD_TXPorMayor"
            gvEstadoPorTrs.Visible = False
            gvEstadoPorMayor.Visible = True

            gvEstadoPorMayor.DataBind()
            gvEstadoPorMayor.PageIndex = pageIndex
        End If



    End Sub


    Function GetDataSource() As DataTable
        Dim idcliente As Long
        If Not IsNothing(gvCuentas.SelectedDataKey) Then
            idcliente = Convert.ToInt32(gvCuentas.SelectedDataKey.Value)
        End If
        'dim dt=EntidadManager.GetStoreProcedure(hfSC.value,"CtasCtesD_TXPorMayor",idcliente,alcance, iisValidSqlDate(txtFechaHasta.Text, "1/1/1900"), iisValidSqlDate(txtFechaDesde.Text, "1/1/2100"), consolidar }

        If IsNothing(idcliente) Or idcliente < 1 Then Exit Function

        Dim sp As String





        Dim mTodo = -1
        If txtFechaDesde.Text <> "" Then mTodo = 0 'no sé cómo funciona esto, pero así está en Pronto





        Dim dt As DataTable

        If RadioButtonListTrans_O_Mayor.SelectedValue <> "Por Mayor" Then

            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            'POR TRANSACCION
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////


            Dim mSoloPendiente As String
            'soloPendiente se usa nada mas para "por transaccion"
            If RadioButtonListAlcance.SelectedValue = "todo" Then
                mSoloPendiente = "N"
            Else
                mSoloPendiente = "S"
            End If




            dt = EntidadManager.TraerFiltrado(HFSC.Value, enumSPs.CtasCtesD_TXPorTrs, idcliente, mTodo, iisValidSqlDate(txtFechaHasta.Text, "1/1/2100"), iisValidSqlDate(txtFechaDesde.Text, "1/1/1900"), -1) ' , "N")

            Dim Sdo As Double = 0
            Dim Trs As Long
            Sdo = 0
            Dim mTransaccionesSaldoCero As New Generic.List(Of String)

            If dt.Rows.Count > 1 Then Trs = iisNull(dt(0).Item("IdImputacion"), -1)

            'If mTodo <> -1 Then CalcularSaldosTransaccion(oRsCtaCte, Trs)

            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////
            Dim dtTotales = dt.Copy
            For Each dr In dt.Rows
                With dr

                    If Trs <> iisNull(.item("IdImputacion"), -1) Then
                        'es un IF para crear agrupaciones... cuando encuentra un IdImputacion distinto, hace
                        'el "AGGREGATE" con el SUM del saldo

                        'If mTodo <> -1 Then CalcularSaldosTransaccion(oRsCtaCte, Trs)

                        Dim drTot As DataRow = dtTotales.NewRow
                        'If Trs <> -1 Then oRsTotales.Fields("IdImputacion").Value = Trs
                        Sdo = Math.Round(Sdo, 2)
                        drTot.Item("SaldoTrs") = FF2(Sdo)

                        If Sdo = 0 Then mTransaccionesSaldoCero.Add(Trs)
                        Trs = iisNull(.item("IdImputacion"), -1)
                        drTot.Item("IdImputacion") = Trs
                        'drTot.Item("Numero") = Trs
                        drTot.Item("IdCtaCte") = .item("IdCtaCte")
                        Sdo = 0

                        dtTotales.Rows.Add(drTot)
                    End If

                    Sdo += iisNull(.item("Saldo Comp_"), 0)
                End With
            Next
            'agrega el ultimo
            'If mTodo <> -1 Then CalcularSaldosTransaccion(oRsCtaCte, Trs)
            Dim drTot2 = dtTotales.NewRow
            'If Trs <> -1 Then oRsTotales.Fields("IdImputacion").Value = Trs
            drTot2.Item("IdImputacion") = 99999999
            drTot2.Item("SaldoTrs") = Sdo
            dtTotales.Rows.Add(drTot2)
            If Sdo = 0 Then mTransaccionesSaldoCero.Add(drTot2.Item("IdImputacion"))
            '//////////////////////////////////////////
            '//////////////////////////////////////////

            'codigo que reemplaza el BorraTransacciones
            If mSoloPendiente = "S" Then
                Dim sWHERE = Join(mTransaccionesSaldoCero.ToArray, ",")
                dtTotales = DataTableWHERE(dtTotales, "IdImputacion NOT IN (" & sWHERE & ")")


                'For Each i In mTransaccionesSaldoCero

                '    Dim listaIndices As New Generic.List(Of Long)
                '    For h = 0 To dt.Rows.Count - 1
                '        If dt(h).Item("IdImputacion") = i Then
                '            listaIndices.Add(h)
                '        End If
                '    Next

                '    For Each j In listaIndices

                '        dt.Rows()

                '    Next

                'Next
            End If

            '//////////////////////////////////////////
            '//////////////////////////////////////////

            dt = dtTotales





            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////



        Else



            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            'POR MAYOR
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            dt = EntidadManager.TraerFiltrado(HFSC.Value, enumSPs.CtasCtesD_TXPorMayor, idcliente, mTodo, iisValidSqlDate(txtFechaHasta.Text, "1/1/2100"), iisValidSqlDate(txtFechaDesde.Text, "1/1/1900"), -1)

            'el saldo que viene del sp tambien se corrige así a mano en el pronto.
            Dim Sdo As Double = 0
            For Each dr In dt.Rows
                With dr
                    Sdo += iisNull(.item("Debe"), 0)
                    Sdo -= iisNull(.item("Haber"), 0)
                    .item("Saldo") = FF2(Sdo)
                End With
            Next
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////




        End If


        Return dt
    End Function





    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click

        Dim output As String


        Dim dt As DataTable = GetDataSource()
        Dim dv As DataView

        If IsNothing(dt) Then Exit Sub

        If RadioButtonListTrans_O_Mayor.SelectedValue <> "Por Mayor" Then
            dv = DataTableORDER(GetDataSource(), "IdImputacion,Cabeza,Fecha,Numero")
            With dv.Table.Columns
                .Remove("IdCtaCte")
                .Remove("IdImputacion")
                .Remove("IdTipoComp")
                .Remove("IdComprobante")
                .Remove("Cabeza")
                .Remove("IdImpu")
                .Remove("IdAux1")
                .Remove("Obra")
                .Remove("Orden de compra")
                .Remove("Mon_origen")
                .Remove("Vendedor")
                .Remove("SaldoTrs")
                .Remove("Vector_E")
                .Remove("Vector_T")
                .Remove("Vector_X")
            End With
        Else
            dv = DataTableORDER(GetDataSource(), "Fecha DESC,Numero DESC")
            With dv.Table.Columns
                .Remove("IdCtaCte")
                .Remove("IdComprobante")
                .Remove("IdTipoComprobante")
                .Remove("Mon_origen")


                .Remove("Vector_E")
                .Remove("Vector_T")
                .Remove("Vector_X")
            End With
        End If



        output = DataTableToExcel(dv, "", "Cuenta corriente deudor")

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



    Protected Sub ObjectDataSource4_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource4.Selecting
        'En caso de que necesite pasarle parametros
        'Dim idcliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value).ToString
        Dim idcliente As Integer = -1
        If Not IsNothing(gvCuentas.SelectedDataKey) Then
            idcliente = Convert.ToInt32(gvCuentas.SelectedDataKey.Value)
        End If
        'idcliente = 84

        Dim oCli = ClienteManager.GetItem(HFSC.Value, idcliente)
        lblCliente.Text = oCli.RazonSocial
        lblTelefono.Text = oCli.RazonSocial
        lblMail.Text = oCli.Email
        lblSaldo.Text = oCli.Saldo



        Dim sp As String
        If RadioButtonListTrans_O_Mayor.SelectedValue = "" Then
            e.InputParameters("TX") = "PorMayor"
            e.InputParameters("Parametros") = New String() {idcliente, -1, iisValidSqlDate(txtFechaHasta.Text, "1/1/1900"), iisValidSqlDate(txtFechaDesde.Text, "1/1/2100"), -1}
        Else
            e.InputParameters("TX") = "PorTrs"
            e.InputParameters("Parametros") = New String() {idcliente, -1, iisValidSqlDate(txtFechaHasta.Text, "1/1/1900"), iisValidSqlDate(txtFechaDesde.Text, "1/1/2100"), -1} ', "N"}
        End If
        
        'exec CtasCtesD_TXPorMayor 84, -1, 'Ene 12 2011 12:00AM', 'Ene  1 2000 12:00AM', -1
        'exec CtasCtesD_TXPorTrs 84, -1, 'Ene 12 2011 12:00AM', 'Ene  1 2000 12:00AM', -1



        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control

        'If Not ViewState("ObjectDataSource2Mostrar") Then 'para que no busque estos datos si no fueron pedidos explicitamente


        'If txtBuscar.Text = "buscar" Then
        'If Not IsPostBack Then
        '    e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        'End If

        ViewState("ObjectDataSource2Mostrar") = False

    End Sub


    Protected Sub RadioButtonListTrans_O_Mayor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListTrans_O_Mayor.SelectedIndexChanged
        gvEstadoRebind()
    End Sub

End Class


