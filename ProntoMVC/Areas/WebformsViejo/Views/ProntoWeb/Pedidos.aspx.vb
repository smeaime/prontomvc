Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data

Imports System.Linq.Expressions
Imports System.Collections.Generic
Imports System.Linq.Dynamic
Imports System.Linq


Partial Class Pedidos
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
                ResumenVisible(False)
            Else
                'TraerResumenDeCuentaFF()
                Debug.Print(Session("glbWebIdProveedor"))
                BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor"))
            End If


            LlenarComboMes()

          

            Me.Title = "Pedidos"

            'GridView1.PageIndex = 0

            'si estás buscando el filtro, andá a PedidoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PedidoManager.GetList
            ElseIf Not (Request.QueryString.Get("Imprimir") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                Imprimir(Request.QueryString.Get("Imprimir")) 'este filtro se le pasa a PresupuestoManager.GetList

            Else
                HFTipoFiltro.Value = ""
            End If

            If HFTipoFiltro.Value = "Todas" Then
                txtFechaDesde.Text = #1/1/1900#
                txtFechaHasta.Text = #1/1/2100#
            End If


            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
            'GridView1.DataBind()



        End If

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnExcel)


        If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            LinkAgregarRenglon.Enabled = False
        Else
            LinkAgregarRenglon.Enabled = True
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

        s += " AND " & _
                                             "( Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Proveedor, 'System.String') LIKE '*" & txtBuscar.Text & "*') "

        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


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

    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdPedido As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Pedido.aspx?Id={0}", IdPedido.ToString))
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
            'gp.Width = 200

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
        Return
        GridView1.PageIndex = e.NewPageIndex
        Rebind()
    End Sub


    Sub Rebind()
        Return
        Dim pageIndex = GridView1.PageIndex
        ObjectDataSource1.FilterExpression = GenerarWHERE()

        Dim dt As Data.DataTable
        dt = ObjectDataSource1.Select()
        Dim b As Data.DataView = New Data.DataView(dt)
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
        'cmbCuenta.DataBind() 'BEEEESSSTTIIAAA!!!! un combo con los proveedores?????? Eso es una pagina gordita!

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
        'Response.Redirect(String.Format("Pedido.aspx?Id=-1"))
        '  AbrirEnNuevaVentanaTab(Me, "Pedido.aspx?Id=-1")
    End Sub


    Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
        'GridViewExportUtil.Export("Grilla.xls", GridView1)
        ' Dim q = pedidoManager.GetListDatasetPaginado(HFSC.Value, 0, 5000)


        Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
        Dim desde As Date? = iisValidSqlDate(TextoAFecha(txtFechaDesde.Text), #1/1/1900#)
        Dim hasta As Date? = iisValidSqlDate(TextoAFecha(txtFechahasta.Text), #1/1/2100#)






        Dim pdatatable As DataTable

        Using db As New DataClasses2DataContext(Encriptar(HFSC.Value))



            Dim q2 = PedidoManager.GetListDataset(HFSC.Value, 0, 10000, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, desde, hasta)





            Dim bFiltraPeriodos As Boolean = (Request.QueryString.Get("año") IsNot Nothing)




            Dim q = (From cab In q2.AsEnumerable Join det In db.wVistaDetPedidos On cab("Id") Equals det.IdPedido _
                        Select cab, det.Articulo _
                        ).ToList()


            'Dim q = (From rm In db.wVistapedidos).ToList
            pdatatable = ToDataTableNull(q)


            Try
                pdatatable.Columns.Remove("IdReq")
                pdatatable.Columns.Remove("Idpedido")
                'pdatatable.Columns.Remove("Numero_Req_")
                pdatatable.Columns.Remove("id")



            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try


            For Each c As DataColumn In pdatatable.Columns
                c.ColumnName() = c.ColumnName().Replace("_", " ")
            Next

            ' Dim dt = q.ToArray '.ToDataTable
            'Dim pdatatable = GetStoreProcedure(HFSC.Value, enumSPs.wpedidos_TTpaginado, 1, 1000, "", "", "", #1/1/2000#, Today)
            Debug.Print(pdatatable.Rows.Count)

            Dim output As String
            output = System.IO.Path.GetTempPath & "pedidos_" & Session(SESSIONPRONTO_NombreEmpresa) & Now.ToString("ddMMMyyyy_HHmmss") & ".xlsx"
            Try


                'DataTableToExcelConEPPLUS(dt, MyFile1)


                Using pck As OfficeOpenXml.ExcelPackage = New OfficeOpenXml.ExcelPackage(New FileInfo(output))

                    '//Create the worksheet
                    Dim ws As OfficeOpenXml.ExcelWorksheet = pck.Workbook.Worksheets.Add("Hoja 1")
                    '//Load the datatable into the sheet, starting from cell A1. Print the column names on row 1
                    ws.Cells("A1").LoadFromDataTable(pdatatable, True)
                    'ws.Cells("A1").LoadFromCollection(q, True)
                    'ws.Cells("A1").LoadFromArrays(q)


                    '                  // add aggregate formulas (get these from an existing table in Excel)
                    'table.Columns[1].TotalsRowFormula = "SUBTOTAL(103,[Column1])"; // count
                    'table.Columns[2].TotalsRowFormula = "SUBTOTAL(109,[Column2])"; // sum
                    'table.Columns[3].TotalsRowFormula = "SUBTOTAL(101,[Column3])"; // average
                    Dim r As OfficeOpenXml.ExcelRange
                    r = ws.Cells(1, 1, pdatatable.Rows.Count + 1, pdatatable.Columns.Count)
                    r.AutoFitColumns()

                    pck.Save()
                End Using

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
        End Using

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



    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'Rebind()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()


        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub Imprimir(ByVal IdPedido As Long)
        Dim output As String


        'Dim Info As String = "|" & mResp & "|" & Index & "|||" & mCopias & "|||" & mvarAgrupar & "|" &   mvarBorrador & "|" & mImprimirAdjuntos & "|" & mRTF & "|" & mPrinter
        Dim Info As String = "|C|1|||1|||1|NO|NO||"

        output = ImprimirWordDOT("Pedido_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, HFSC.Value, Session, Response, IdPedido, Info)
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

    Protected Sub ObjectDataSource1_Selected(sender As Object, e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        'Debug.Print(e.AffectedRows)
        '        If Not e.ExecutingSectCount Then
        Try
            Debug.Print(DirectCast(e.ReturnValue, Data.DataTable).Rows.Count())
        Catch ex As Exception

        End Try
        'End If
    End Sub



    Protected Sub ObjectDataSource1_Selecting(sender As Object, e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource1.Selecting
        If Not e.ExecutingSelectCount Then
            'e.Arguments.MaximumRows = Me.GridView1.PageSize
            'e.InputParameters.Add("e", e)
        End If
    End Sub

    Protected Sub btnPaginaAvanza_Click(sender As Object, e As System.EventArgs) Handles btnPaginaAvanza.Click
        Session("PaginaPedido") += 1
        GridView1.PageIndex = Session("PaginaPedido")
        GridView1.DataBind()
    End Sub

    Protected Sub btnPaginaRetrocede_Click(sender As Object, e As System.EventArgs) Handles btnPaginaRetrocede.Click
        Session("PaginaPedido") -= 1
        Try
            GridView1.PageIndex = Session("PaginaPedido")
        Catch ex As Exception
            Session("PaginaPedido") = 0
        End Try
        GridView1.DataBind()
    End Sub

    Protected Sub btnRefresca_Click(sender As Object, e As System.EventArgs) Handles btnRefresca.Click
        GridView1.DataBind()
    End Sub











    Sub LlenarComboMes()



        Dim desde As Date = #1/1/2001#
        Dim hasta As Date = GetFirstDayInMonth(Now) ' #1/1/2001#
        Dim MAXITEMS = 100
        Dim s(MAXITEMS) As String

        s(0) = "Todas"

        For mes = 1 To MAXITEMS
            Dim mesresta As Date = DateAdd(DateInterval.Month, 1 - mes, hasta)
            If mesresta < desde Then Exit For
            s(mes) = mesresta.ToString("MMM yy")
        Next


        'cmbMesFiltro.DataSource = s
        'cmbMesFiltro.DataBind()
        'cmbMesFiltro.SelectedIndex = 1

        

        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////


        Dim nodoporperiodos As TreeNode = New TreeNode("por Períodos")
        nodoporperiodos.SelectAction = TreeNodeSelectAction.None


        Using db As New DataClasses2DataContext(Encriptar(HFSC.Value))
            Dim q = (From rm In db.linqPedidos Select rm.FechaPedido.Value.Year, rm.FechaPedido.Value.Month).Distinct.OrderBy(Function(i) i.Year)
            Dim anios = q.Select(Function(i) i.Year).Distinct.OrderByDescending(Function(i) i)
            For Each anio In anios


                Dim anionodo = New TreeNode(anio, anio & " ", "", "ProntoWeb/pedidos.aspx?año=" & anio, "")

                Dim aniotemp = anio
                Dim meses = From rm In q Where rm.Year = aniotemp Order By rm.Month Descending Select rm.Month

                For Each Mes In meses
                    anionodo.ChildNodes.Add(New TreeNode(MonthName(Mes), anio & " " & Mes, "", "ProntoWeb/pedidos.aspx?año=" & anio & "&mes=" & Mes, ""))
                Next

                nodoporperiodos.ChildNodes.Add(anionodo)
            Next
        End Using

        'nodoporperiodos.ChildNodes(5).Select()




        Dim arbolOriginal As TreeView = CType(Master.FindControl("ArbolSitemap"), TreeView)
        Dim arbolCopia As TreeView = CType(Master.FindControl("arbolCopia"), TreeView)

        arbolOriginal.Visible = True

        arbolOriginal.DataBind()
        CopyTreeview(arbolOriginal, arbolCopia)

        Dim n2 = arbolCopia.FindNode("COMPRAS/Por períodos") '/Por períodos")
        Dim p = n2.Parent
        p.ChildNodes.Remove(n2)



        Dim nodito = arbolCopia.FindNode("COMPRAS") '/Pedidos")
        nodito.ChildNodes.Add(nodoporperiodos)


 

        arbolCopia.CollapseAll()

        Dim filtroano = Request.QueryString.Get("año")
        Dim filtromes = Request.QueryString.Get("mes")




        If filtromes = "" And filtromes IsNot Nothing Then filtromes = iisNull(Session("filtromes"), "")

        If If(filtroano, "") = "" Then filtroano = iisNull(Session("filtroano"), Now.Year)



        Session("filtroano") = filtroano
        Session("filtromes") = filtromes



        Dim fechadesde As Date
        Dim fechahasta As Date
        If If(filtromes, "") = "" Then
            fechadesde = New Date(filtroano, 1, 1)
            fechahasta = New Date(filtroano, 12, 31)
        Else
            fechadesde = New Date(filtroano, filtromes, 1)
            fechahasta = GetLastDayInMonth(fechadesde)
        End If
        txtFechaDesde.Text = fechadesde
        txtFechaHasta.Text = fechahasta

        If HFTipoFiltro.Value = "Todas" Then
            txtFechaDesde.Text = #1/1/1900#
            txtFechaHasta.Text = #1/1/2100#
        End If



        Try


            Dim nodoelegido As TreeNode
            If filtromes = "" Then
                nodoelegido = arbolCopia.FindNode("COMPRAS/por Períodos/" & filtroano & " ")
            Else
                nodoelegido = arbolCopia.FindNode("COMPRAS/por Períodos/" & filtroano & " /" & filtroano & " " & filtromes)
            End If

            nodoelegido.Select()
            'nodoelegido.Expand()
            nodoelegido.Parent.Expand()
            nodoelegido.Parent.Parent.Expand()
            nodoelegido.Parent.Parent.Parent.Expand()

        Catch ex As Exception
            ErrHandler.WriteError(ex)
        End Try




        'Dim UpdatePanelAcordion As UpdatePanel = CType(Master.FindControl("UpdatePanelAcordion"), UpdatePanel)
        'UpdatePanelAcordion.Update()



    End Sub
End Class
