Imports System.Data.SqlClient
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.IO
Imports System.Diagnostics 'para usar Debug.Print
Imports Microsoft.Reporting.WebForms
Imports System.Data

Imports System.Linq

Imports OfficeOpenXml 'EPPLUS, no confundir con el OOXML
'Imports Pronto.ERP.Bll.CartaDePorteManager
Imports CartaDePorteManager
Imports Pronto.ERP.Bll.EntidadManager

Partial Class CartasDePortes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Membership.GetUser() Is Nothing Then
            ErrHandler2.WriteError("sin loguearse")
        Else
            ErrHandler2.WriteError(Membership.GetUser().UserName)
        End If



        'HFSC.Value = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        HFSC.Value = GetConnectionString(Server, Session)



        'HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            BindTypeDropDown() 'combos


            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If

            refrescaPeriodo()

            If HFTipoFiltro.Value = "Todas" Then
                ReBindPrimeraPaginaConUltimasCreadas()
                'ReBind()
            Else

                DropDownList1.Text = HFTipoFiltro.Value
                'ObjectDataSource1.FilterExpression = generarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
                ReBindPrimeraPaginaConUltimasCreadas()
                'ReBind()
            End If



        End If

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkExcelDescarga)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkZipDescarga)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkButton2)

        AutoCompleteExtender3.ContextKey = HFSC.Value

        Permisos()
    End Sub

    Private Sub BindTypeDropDown()
        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)
        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)
        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.Items.Insert(0, New ListItem("Todas las sucursales", -1))
        cmbPuntoVenta.SelectedIndex = 0

        Try
            If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                BuscaTextoEnCombo(cmbPuntoVenta, pventa)
                If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Cartas_de_Porte)

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

            'muestro el borrar posiciones
            lnkBorrarPosiciones.Visible = False
        Else
            lnkBorrarPosiciones.Visible = True
        End If



        Try
            Dim rol = Roles.GetRolesForUser(Session(SESSIONPRONTO_UserName))
            If rol(0) = "Cliente" Or rol(0) = "WilliamsClientes" Then
                Response.Redirect(String.Format("CartaDePorteInformesAccesoClientes.aspx"))
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



    End Sub





    Function generarWHERE() As String
        Dim idVendedor = BuscaIdClientePreciso(txtBuscar.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtBuscar.Text, HFSC.Value)

        Dim strWHERE As String = "1=1  "

        If idVendedor <> -1 Or idCorredor <> -1 Then
            strWHERE += "  " & _
             "           AND (Vendedor = " & idVendedor & _
            "           OR CuentaOrden1 = " & idVendedor & _
            "           OR CuentaOrden2 = " & idVendedor & _
            "             OR Corredor=" & idCorredor & _
            "             OR Entregador=" & idVendedor & ")"
        End If

        If cmbPuntoVenta.SelectedValue > 0 Then
            strWHERE += "AND (PuntoVenta=" & cmbPuntoVenta.SelectedValue & ")"   ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
        End If


        Select Case DropDownList1.Text  '
            Case "Todas"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas)
            Case "Incompletas"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Incompletas)
            Case "Posición"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Posicion)
            Case "Descargas"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas)
            Case "Facturadas"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Facturadas)
            Case "NoFacturadas"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.NoFacturadas)
            Case "Rechazadas"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Rechazadas)
            Case "EnNotaCredito"
                strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito, , HFSC.Value)
        End Select

        'strWHERE += " ORDER BY " & facturarselaA & " ASC,NumeroCartaDePorte ASC "

        Return strWHERE
    End Function


    Function GetCartas(Optional ByRef titulo As String = "") As DataTable



        Dim estado As CartaDePorteManager.enumCDPestado
        Select Case DropDownList1.Text  '
            Case "Todas"
                estado = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
            Case "Incompletas"
                estado = CartaDePorteManager.enumCDPestado.Incompletas
            Case "Posición"
                estado = CartaDePorteManager.enumCDPestado.Posicion
            Case "Descargas"
                estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
            Case "Facturadas"
                estado = CartaDePorteManager.enumCDPestado.Facturadas
            Case "NoFacturadas"
                estado = CartaDePorteManager.enumCDPestado.NoFacturadas
            Case "Rechazadas"
                estado = CartaDePorteManager.enumCDPestado.Rechazadas
            Case "EnNotaCredito"
                estado = CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito
        End Select




        Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                    "", "", "", 1, 0, _
                                   estado, txtBuscar.Text, _
                                   -1, -1, -1, -1, -1, -1, -1, -1, _
                                   "1", "Ambas", _
                                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                   cmbPuntoVenta.SelectedValue, titulo)




        '/////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////
        'TODO: sacar despues de la actualizacion de CartasPorteManager

        If txtBuscar.Text <> "" Then
            Dim idVendedorQueContiene = BuscaIdClientePreciso(txtBuscar.Text, HFSC.Value)
            Dim idCorredorQueContiene = BuscaIdVendedorPreciso(txtBuscar.Text, HFSC.Value)

            If idVendedorQueContiene <> -1 Or idCorredorQueContiene <> -1 Then
                Dim WHERE = "  " & _
                 "            (Vendedor = " & idVendedorQueContiene & _
                "           OR CuentaOrden1 = " & idVendedorQueContiene & _
                "           OR CuentaOrden2 = " & idVendedorQueContiene & _
                "             OR Corredor=" & idCorredorQueContiene & _
                "             OR Entregador=" & idVendedorQueContiene & ")"


                dt = DataTableWHERE(dt, WHERE)
            End If


        End If
        '////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////




        Return dt
    End Function


    Function GenerarWHEREparaObjectDataSource() As String
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
                                   "Convert(" & cmbBuscarEsteCampo.SelectedValue & ", 'System.String') LIKE '*" & txtBuscar.Text & "*' )"

        If cmbPuntoVenta.Text <> "-1" Then

            s += "         AND ( " & _
                                        " Convert(PuntoVenta, 'System.String')='" & cmbPuntoVenta.Text & "'" & _
                                " )"
            ' "   OR " & _
            '       "  PuntoVenta=0" & _
            '"       )"
        End If

        '& " OR " & _
        '" DestinoDesc LIKE '*" & txtBuscar.Text & "*'    )" ' _

        '& " OR " & _
        '"Convert(CuentaOrden1, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '& " OR " & _
        '"Convert(CuentaOrden1, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '& " OR " & _
        '"Convert(Vendedor, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '& " OR " & _
        '"Convert(Corredor, 'System.String') LIKE '*" & txtBuscar.Text & "*'"



        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


        Select Case DropDownList1.Text  '
            Case "Todas"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas)
            Case "Incompletas"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Incompletas)
            Case "Posición"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Posicion)
            Case "Descargas"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas)
            Case "Facturadas"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Facturadas)
            Case "NoFacturadas"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.NoFacturadas)
            Case "Rechazadas"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.Rechazadas)
            Case "EnNotaCredito"
                s += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito, , HFSC.Value)
        End Select






        Return s
    End Function




    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdCartaDePorte As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("CartaDePorte.aspx?Id={0}", IdCartaDePorte.ToString))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

        '    ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
        '    gp.DataSource = ObjectDataSource2.Select
        '    gp.DataBind()
        'End If
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


    End Sub


    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        GridView1.DataSourceID = ""
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'GridView1.DataSource = ordenar(ObjectDataSource1.Select())
        ReBind()

        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataBind()





    End Sub


    Function ordenar(ByVal o As Data.DataView) As Data.DataView
        If ViewState("Sort") <> "" Then
            'o.Sort = GridView1.SortExpression + " " + ConvertSortDirectionToSql(GridView1.SortDirection)
            o.Sort = ViewState("Sort")
        End If
        Return o
    End Function


    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        GridView1.DataSourceID = ""
        ObjectDataSource1.FilterExpression = generarWHERE()
        GridView1.DataSource = ObjectDataSource1.Select()
        GridView1.DataBind()
    End Sub


    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()

        ReBind()
        'GridView1.DataSourceID = ""
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'GridView1.DataSource = ObjectDataSource1.Select()
        'GridView1.DataBind()
        ''GridView1.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    Protected Sub GridView1_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles GridView1.Sorting

        'Si usás un ObjectDatasource, el que se encarga de ordenar es su SelectMethod, y 
        'este evento no hace nada.  -El ejemplo que ví, ordena en el SelectMethod devolviendo un 
        'Dataview... Y el Dataview no puede usar filterExpression!



        'El asunto es que solo me deja ordenar un Dataview, no un Datatable. Pero solo puedo devolver para
        'filtrar con filterExpression un Datatable... -Es que por eso terminaste en
        ' lo de "HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource"  !!!!


        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx  'es ingenioso, transforma en datatable el datasource de la gridview mostrada
        'http://stackoverflow.com/questions/1278995/objectdatasource-and-gridview-sorting-paging-filtering
        'http://stackoverflow.com/questions/1002196/how-to-sort-on-a-gridview-using-objectdatasource-with-templatefields
        'http://stackoverflow.com/questions/1003037/how-to-sort-using-gridview-and-objectdatasource

        'Dim dataTable As datatable = GridView.DataSource

        'If dataTable <> null Then
        '    DataView(dataView = New DataView(dataTable))
        '    dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'ObjectDataSource1.FilterExpression = GenerarWHERE()

        'ObjectDataSource1.SortParameterName = "sortExpression" 'con ese nombre le va a llegar el filtro a GetListDataset
        'ObjectDataSource1.Select()
        'ObjectDataSource1.InputParameters("sortExpression") = 

        'e.SortExpression(+" " + ConvertSortDirectionToSql(e.SortDirection))
        'GridView1.DataSource = dataView
        'GridView1.DataBind()
        'End If




        'Dim dataTable As Data.DataTable = GridView1.DataSource
        'If Not IsNothing(dataTable) Then

        '    Dim dataView As Data.DataView = New Data.DataView(dataTable)
        '    dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)

        '    GridView1.DataSource = dataView
        '    GridView1.DataBind()
        'End If

        'e.SortExpression = "VendedorDesc"





        '/////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////







        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'Dim a As Data.DataView = ObjectDataSource1.Select()

        'Debug.Print("-----")
        'Debug.Print(a.ToTable.Rows(0).Item(1))

        'a.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'Debug.Print(a.ToTable.Rows(0).Item(1))

        'Dim pageIndex = GridView1.PageIndex

        'GridView1.DataSourceID = ""
        'GridView1.DataSource = ""
        ''GridView1.Columns.Clear()
        'GridView1.DataSource = a
        'GridView1.DataBind()

        'GridView1.PageIndex = pageIndex





        Dim pageIndex = GridView1.PageIndex

        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
        dt = DataTableWHERE(dt, generarWHERE)
        With dt
            .Columns("IdCartaDePorte").ColumnName = "Id"
        End With

        'ObjectDataSource1.FilterExpression = generarWHERE()
        'Dim b As Data.DataView = ObjectDataSource1.Select()
        Dim b As Data.DataView = dt.AsDataView


        b.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(Val(ViewState("Sort")))
        'GridView1.SortExpression = b.Sort
        ViewState("Sort") = IIf(ConvertSortDirectionToSql(Val(ViewState("Sort"))) = "ASC", SortDirection.Descending, SortDirection.Ascending)
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex


        e.Cancel = True


        'El asunto es que solo me deja ordenar un Dataview, no un Datatable. Pero solo puedo devolver para
        'filtrar con filterExpression un Datatable... -Es que por eso terminaste en
        ' lo de "HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource"  !!!!
    End Sub

    Function ConvertSortDirectionToSql(ByVal SortDirection As SortDirection) As String
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx


        Dim newSortDirection As String = String.Empty

        Select Case SortDirection
            Case SortDirection.Ascending
                newSortDirection = "ASC"
            Case SortDirection.Descending
                newSortDirection = "DESC"
        End Select

        Return newSortDirection
    End Function




    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    'botones de prueba para el sort de la gridview
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click



        ''///////////////////////////////////////////////////
        ''ordenando con datatable
        'Dim c As Data.DataTable = ObjectDataSource1.Select()
        'c.Sort = "CorredorDesc"
        ''GridView1.Sort("CorredorDesc", SortDirection.Ascending)
        'GridView1.DataSource = b
        'GridView1.DataBind()



        '///////////////////////////////////////////////////
        'ordenando con Dataview
        'ObjectDataSource1.Select()
        Dim pageIndex = GridView1.PageIndex
        ObjectDataSource1.FilterExpression = generarWHERE()
        Dim b As Data.DataView = ObjectDataSource1.Select()
        b.Sort = "CorredorDesc"
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex

        'El asunto es que solo me deja ordenar un Dataview, no un Datatable. Pero solo puedo devolver para
        'filtrar con filterExpression un Datatable... -Es que por eso terminaste en
        ' lo de "HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource"  !!!!




        '////////////////////////////////////
        'usar gridview2 para debug del sort


        'Dim a As Data.DataView = ObjectDataSource1.Select()
        'a.Sort = "CorredorDesc"
        'GridView2.DataSource = a
        'GridView2.DataBind()
    End Sub


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'ObjectDataSource1.Select()
        'GridView1.Sort("VendedorDesc", SortDirection.Ascending)
        'GridView1.DataBind()

        '////////////////////////////////////
        '////////////////////////////////////

        Dim pageIndex = GridView1.PageIndex
        ObjectDataSource1.FilterExpression = generarWHERE()
        Dim b As Data.DataView = ObjectDataSource1.Select()
        b.Sort = "VendedorDesc"
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex


        ''Dim dataTable As Data.DataTable = GridView1.DataSource
        ''If Not IsNothing(dataTable) Then

        ''    Dim dataView As Data.DataView = New Data.DataView(dataTable)
        ''    dataView.Sort = "VendedorDesc"




        '////////////////////////////////////
        'usar gridview2 para debug del sort
        Dim a As Data.DataView = ObjectDataSource1.Select()

        Debug.Print("-----")
        Debug.Print(a.ToTable.Rows(0).Item(1))

        a.Sort = "VendedorDesc"
        Debug.Print(a.ToTable.Rows(0).Item(1))

        ''GridView1.DataSourceID = ""
        GridView2.DataSource = a
        'GridView2.DataSource = ObjectDataSource1.Select()



        GridView2.DataBind()
        'GridView2.Sort("VendedorDesc", SortDirection.Ascending)
        'End If




    End Sub

    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////




    Protected Sub GridView1_Sorted(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.Sorted
        'Dim a As Data.DataView = ObjectDataSource1.Select()

        'Debug.Print("-----")
        'Debug.Print(a.ToTable.Rows(0).Item(1))

        'a.Sort = "VendedorDesc"
        'Debug.Print(a.ToTable.Rows(0).Item(1))

        'GridView1.DataSourceID = ""
        'GridView1.DataSource = ""
        'GridView1.Columns.Clear()
        'GridView1.DataSource = a
        'GridView1.DataBind()
    End Sub

    Protected Sub GridView2_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles GridView2.Sorting

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        ReBind()
    End Sub

    Protected Sub lnkBorrarPosiciones_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBorrarPosiciones.Click
        LinkButton1.Visible = True
    End Sub



    '//////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub ReBindPrimeraPaginaConUltimasCreadas()



        'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1,  now, now)

        GridView1.DataSourceID = ""
        'me traigo suficientes como para llenar el paginado y no tener que forzar el pagerow
        'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, DateAdd(DateInterval.Day, -1, Today), Now)

        'usar(getdatatablepaginado)


        If False Then ' True Then

            Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, "", "", "", -1, -1, _
                            CartaDePorteManager.enumCDPestado.Todas, "", -1, -1, _
                            -1, -1, -1, -1, -1, -1, -1, _
                            "1", _
                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                            cmbPuntoVenta.SelectedValue, , , , , , , , , , )


            'skip 0 take 10
            'kkk()

            'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "SELECT TOP 10 *,IdCartaDePorte as Id FROM e ORDER BY IdCartaDePorte DESC")
            With dt
                .Columns("IdCartaDePorte").ColumnName = "Id"

                '    .Columns("VendedorDesc").ColumnName = "TitularDesc"
                '    .Columns("EntregadorDesc").ColumnName = "DestinatarioDesc"
                '    .Columns("CuentaOrden1Desc").ColumnName = "IntermediarioDesc"
                '    .Columns("CuentaOrden2Desc").ColumnName = "RComercialDesc"
                '    '.Columns("VendedorDesc").ColumnName = "TitularDesc"
            End With
            dt = DataTableWHERE(dt, generarWHERE)

            Dim b As Data.DataView = DataTableORDER(dt, "FechaModificacion DESC")
            ViewState("Sort") = b.Sort


            GridView1.DataSource = b




        ElseIf True Then



            Dim s As String = _
"            exec sp_executesql N'SELECT '''' as Producto, '''' as UsuarioIngreso, [t10].[IdCartaDePorte] AS [id], [t10].[NumeroCartaDePorte], [t10].[NumeroSubfijo], [t10].[SubnumeroVagon], [t10].[FechaArribo], [t10].[FechaModificacion], [t10].[FechaDescarga], [t10].[Observaciones] AS [Obs], [t10].[NetoFinal], [t10].[value] AS [TitularDesc], [t10].[value2] AS [IntermediarioDesc], [t10].[value3] AS [RComercialDesc], [t10].[value4] AS [CorredorDesc], [t10].[value5] AS [DestinatarioDesc], [t10].[value6] AS [ProcedenciaDesc], [t10].[value7] AS [DestinoDesc] " & _
"  FROM ( " & _
    "  SELECT ROW_NUMBER() OVER (ORDER BY [t9].[FechaModificacion] DESC) AS [ROW_NUMBER], [t9].[IdCartaDePorte], [t9].[NumeroCartaDePorte], [t9].[NumeroSubfijo], [t9].[SubnumeroVagon], [t9].[FechaArribo], [t9].[FechaModificacion], [t9].[FechaDescarga], [t9].[Observaciones], [t9].[NetoFinal], [t9].[value], [t9].[value2], [t9].[value3], [t9].[value4], [t9].[value5], [t9].[value6], [t9].[value7] " & _
    "  FROM ( " & _
        "  SELECT [t0].[IdCartaDePorte], [t0].[NumeroCartaDePorte], [t0].[NumeroSubfijo], [t0].[SubnumeroVagon], [t0].[FechaArribo], [t0].[FechaModificacion], [t0].[FechaDescarga], [t0].[Observaciones], [t0].[NetoFinal], [t2].[RazonSocial] AS [value], [t4].[RazonSocial] AS [value2], [t5].[RazonSocial] AS [value3], [t6].[Nombre] AS [value4], [t3].[RazonSocial] AS [value5], [t8].[Nombre] AS [value6], [t7].[Descripcion] AS [value7] " & _
        "  FROM [dbo].[CartasDePorte] AS [t0] " & _
       "   LEFT OUTER JOIN [dbo].[Articulos] AS [t1] ON ([t1].[IdArticulo]) = [t0].[IdArticulo] " & _
        "  LEFT OUTER JOIN [dbo].[Clientes] AS [t2] ON ([t2].[IdCliente]) = [t0].[Vendedor] " & _
        "  LEFT OUTER JOIN [dbo].[Clientes] AS [t3] ON ([t3].[IdCliente]) = [t0].[Entregador] " & _
        "  LEFT OUTER JOIN [dbo].[Clientes] AS [t4] ON ([t4].[IdCliente]) = [t0].[CuentaOrden1] " & _
        "  LEFT OUTER JOIN [dbo].[Clientes] AS [t5] ON ([t5].[IdCliente]) = [t0].[CuentaOrden2] " & _
        "  LEFT OUTER JOIN [dbo].[Vendedores] AS [t6] ON ([t6].[IdVendedor]) = [t0].[Corredor] " & _
        "  LEFT OUTER JOIN [dbo].[WilliamsDestinos] AS [t7] ON ([t7].[IdWilliamsDestino]) = [t0].[Destino] " & _
        "  LEFT OUTER JOIN [dbo].[Localidades] AS [t8] ON [t8].[IdLocalidad] = (CONVERT(Int,[t0].[Procedencia])) " & _
        " where FechaModificacion > ''" & FechaANSI(DateAdd(DateInterval.Day, -7, Today)) & "'' " & _
        "  ) AS [t9] " & _
    "  ) AS [t10] " & _
"  WHERE [t10].[ROW_NUMBER] BETWEEN @p0 + 1 AND @p0 + @p1 " & _
"  ORDER BY [t10].[ROW_NUMBER]',N'@p0 int,@p1 int',@p0=0,@p1=8"
            'al agregar lo de ultimasemana, el cambio es brutal en el uso del índice
            'al agregar lo de ultimasemana, el cambio es brutal en el uso del índice
            'al agregar lo de ultimasemana, el cambio es brutal en el uso del índice
            'al agregar lo de ultimasemana, el cambio es brutal en el uso del índice
            'al agregar lo de ultimasemana, el cambio es brutal en el uso del índice
            'al agregar lo de ultimasemana, el cambio es brutal en el uso del índice







            Dim s2 = "SELECT TOP 10  " & _
"                                                 IdCartaDePorte as Id  " & _
"  , '' as Producto " & _
"             , '' as Obs " & _
"                     , '' as   TitularDesc " & _
"            , '' as IntermediarioDesc " & _
"             , '' as RComercialDesc " & _
"             , '' as CorredorDesc " & _
"             , '' as DestinatarioDesc  " & _
" , '' as ProcedenciaDesc  " & _
"             , '' as DestinoDesc  " & _
"            , '' as UsuarioIngreso  " & _
"            ,NumeroCartaDePorte, NumeroSubfijo, SubnumeroVagon,  " & _
"            FechaArribo, FechaModificacion, FechaDescarga,  " & _
"            NetoFinal ,  " & _
"            Anulada " & _
" FROM CartasDePorte ORDER BY IdCartaDePorte DESC"


            Try
                'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, s)
                Dim dt As DataTable = CartaDePorteManager.ListaditoPrincipal(HFSC.Value)


          

                GridView1.DataSource = dt 'b
            Catch ex As Exception
                ErrHandler2.WriteAndRaiseError("Los errores de deadlock pasan siempre acá?")
            End Try

        Else

            Dim q = CartasLINQlocalSimplificadoPrimeraPagina(HFSC.Value, "", "", "", GridView1.PageIndex * GridView1.PageSize, GridView1.PageSize, _
                                CartaDePorteManager.enumCDPestado.Todas, "", -1, -1, _
                                -1, -1, -1, -1, -1, -1, -1, _
                                "1", _
                               #1/1/1753#, _
                                #1/1/2100#, _
                                cmbPuntoVenta.SelectedValue)

            GridView1.DataSource = q
        End If

        GridView1.DataBind()
        'ForzarPagerow()
    End Sub




    Sub ReBind()
        GridView1.DataSourceID = ""

        Dim pageIndex = GridView1.PageIndex

        'METODO 1
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'GridView1.DataSource = ObjectDataSource1.Select()




        'METODO 2
        'ObjectDataSource1.FilterExpression = ""
        'GridView1.DataSource = CartaDePorteManager.GetListDatasetWHERE(HFSC.Value, , 1, 120)
        'GridView1.DataSource = CartaDePorteManager.GetList(HFSC.Value, , 1, 120)
        'sss()


        Dim dt = GetCartas()

        'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))





        '///////////////////////////////////////////////////
        'filtro
        'dt = DataTableWHERE(dt, generarWHERE)



        With dt
            .Columns("IdCartaDePorte").ColumnName = "Id"
        End With

        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'ordeno
        Dim b As Data.DataView = DataTableORDER(dt, "FechaModificacion DESC")
        ViewState("Sort") = b.Sort


        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex

    End Sub

















    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
        ReBind()
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click


        Dim s() As String = Split(ListaDeCDPTildados(), ",") 'y este está trayendo otro renglon!



        For Each id As Long In s

            If id = 0 Then Continue For

            'flagHayChecksTildados = True

            Dim cdp As CartaDePorte = CartaDePorteManager.GetItem(HFSC.Value, id)
            If GetEstado(HFSC.Value, cdp) = enumCDPestado.Posicion Then
                cdp.Anulada = "SI"
                EntidadManager.LogPronto(HFSC.Value, id, "CartaPorte Anulacion de posiciones ", Session(SESSIONPRONTO_UserName))
                CartaDePorteManager.Anular(HFSC.Value, cdp, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))
            End If
        Next


        ReBind()
    End Sub

    Protected Sub LinkExcelDescarga_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkExcelDescarga.Click
        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

        '///////////////////////////////////////////////////
        'filtro
        dt = DataTableWHERE(dt, generarWHERE)



        'Dim sFileName = DataTableToExcel(CartaDePorteManager.GetListDataset(HFSC.Value, ""))
        'Dim dt = CartaDePorteManager.GetListDataset(HFSC.Value, "")



        'http://fourleafit.wikispaces.com/EPPlus

        Dim xlPackage = New ExcelPackage()
        Dim xlWorkSheet = xlPackage.Workbook.Worksheets.Add("Test Sheet")
        'xlPackage.Save()

        'http://fourleafit.wikispaces.com/EPPlus

        xlWorkSheet.Cells("A1").LoadFromDataTable(dt, True)
        xlPackage.SaveAs(Response.OutputStream)
        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        Response.AddHeader("content-disposition", "attachment;  filename=ProductPricing.xlsx")

        Return





        Dim output = xlPackage.File.Name

        'ExcelPackage.DataSetHelper.CreateWorkbook("MyExcelFile.xls", ds)
        If output = "" Then Return

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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub


    Protected Sub LinkZipDescarga_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkZipDescarga.Click
        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

        '///////////////////////////////////////////////////
        'filtro
        dt = DataTableWHERE(dt, generarWHERE)


        'RebindReportViewer("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)
        'Return


        Dim sFileName = RebindReportViewerExcel("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)

        Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(sFileName & ".zip") 'usando la .NET Zip Library
        zip.AddFile(sFileName)
        zip.Save()

        Dim output = zip.Name

        If output = "" Then Return

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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try



    End Sub

    Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
        ReBind()
    End Sub

    Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
        ReBind()
    End Sub

    Protected Sub cmbPeriodo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodo.SelectedIndexChanged
        refrescaPeriodo()
        ReBind()
    End Sub

    Sub refrescaPeriodo()
        txtFechaDesde.Visible = False
        txtFechaHasta.Visible = False
        Select Case cmbPeriodo.Text

            Case "Cualquier fecha"
                txtFechaDesde.Text = ""
                txtFechaHasta.Text = ""

            Case "Hoy"
                txtFechaDesde.Text = Today
                txtFechaHasta.Text = ""

            Case "Ayer"
                txtFechaDesde.Text = DateAdd(DateInterval.Day, -1, Today)
                txtFechaHasta.Text = DateAdd(DateInterval.Day, -1, Today)

            Case "Este mes"
                txtFechaDesde.Text = GetFirstDayInMonth(Today)
                txtFechaHasta.Text = GetLastDayInMonth(Today)
            Case "Mes anterior"
                txtFechaDesde.Text = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
                txtFechaHasta.Text = GetLastDayInMonth(DateAdd(DateInterval.Month, -1, Today))
            Case "Personalizar"
                txtFechaDesde.Visible = True
                txtFechaHasta.Visible = True
        End Select


    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click

        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

        '///////////////////////////////////////////////////
        'filtro
        dt = DataTableWHERE(dt, generarWHERE)


        'RebindReportViewer("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)
        'Return



        Dim sFileName = RebindReportViewerExcel("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)







        'Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(sFileName & ".zip") 'usando la .NET Zip Library
        'zip.AddFile(sFileName)
        'zip.Save()

        Dim output = sFileName ' zip.Name

        If output = "" Then Return

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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub

    Function RebindReportViewerExcel(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing, Optional ByRef ArchivoExcelDestino As String = "") As String




        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = Path.GetTempPath & "Listado general " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)



        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = rdlFile
                .EnableHyperlinks = True
                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                .EnableExternalImages = True

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String
            Dim bytes As Byte()

            Try
                bytes = ReportViewer2.LocalReport.Render( _
                      "Excel", Nothing, mimeType, encoding, _
                        extension, _
                       streamids, warnings)

            Catch e As System.Exception
                Dim inner As Exception = e.InnerException
                While Not (inner Is Nothing)
                    MsgBox(inner.Message)
                    ErrHandler2.WriteError(inner.Message)
                    inner = inner.InnerException
                End While
            End Try


            Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()


            Return ArchivoExcelDestino
        End With


    End Function


    Sub RebindReportViewer(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing)
        'http://forums.asp.net/t/1183208.aspx

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = True

            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True



                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                'Try
                '    If .GetParameters.Count > 1 Then
                '        If .GetParameters.Item(1).Name = "FechaDesde" Then
                '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                '            Dim p2 = New ReportParameter("FechaDesde", Today)
                '            Dim p3 = New ReportParameter("FechaHasta", Today)
                '            .SetParameters(New ReportParameter() {p1, p2, p3})
                '        End If
                '    End If
                'Catch ex As Exception
                '    ErrHandler2.WriteError(ex.ToString)
                'End Try
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With

            .DocumentMapCollapsed = True
            .LocalReport.Refresh()
            .DataBind()
        End With


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'ReportViewer2.Reset()
        'Dim rep As Microsoft.Reporting.WebForms.LocalReport = ReportViewer2.LocalReport

        ''rep.ReportPath = "SampleReport.rdlc"
        'Dim myConnection As SqlConnection = New SqlConnection(HFSC.Value)

        'Dim ds As Data.DataSet = RequerimientoManager.GetListTXDetallesPendientes(HFSC.Value) 'RequerimientoManager.GetListTX(HFSC.Value, )

        'Dim dsSalesOrder As New Microsoft.Reporting.WebForms.ReportDataSource()
        'dsSalesOrder.Name = "DataSet1"
        'dsSalesOrder.Value = ds.Tables(0)

        'rep.DataSources.Add(dsSalesOrder)

        'ds.ReadXml(Server.MapPath("SalesDataFile.xml"))
        'ds.ReadXml(HttpContext.Current.Request.MapPath("SalesDataFile.xml"))



        'ReportViewer2.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSource1", myConnection))
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Sub


    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton3.Click

        'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

        '///////////////////////////////////////////////////
        'filtro
        Dim titulo As String = ""
        Dim dt = DataTableWHERE(GetCartas(titulo), generarWHERE)



        'RebindReportViewer("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)
        'Return


        ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                    "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", _
                            dt, Nothing, , , titulo)

        'ReportViewer2.Visible = True
        'RebindReportViewer("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)

    End Sub


    '////////////////////////////////////////////
    '////////////////////////////////////////////
    '////////////////////////////////////////////



    Sub ResetChecks()
        Dim lista As New Generic.List(Of String)
        For Each Item In Session.Contents
            If Left(Item, 4) = "page" Then lista.Add(Item)
        Next
        For Each i In lista
            Session.Remove(i)
        Next
    End Sub

    Sub GuardaChecks()
        'persistencia de los checks http://forums.asp.net/t/1147075.aspx
        'Response.Write(GridView1.PageIndex.ToString()) 'esto para qué es? si lo descomento, no cambia la pagina
        Dim d = GridView1.PageCount
        Dim values(GridView1.PageSize) As Boolean
        Dim chb As CheckBox
        Dim count = 0
        For i = 0 To GridView1.Rows.Count - 1
            chb = GridView1.Rows(i).FindControl("CheckBox1")
            If Not IsNothing(chb) Then values(i) = chb.Checked
        Next
        Session("page" & GridView1.PageIndex) = values

    End Sub

    Sub MarcarTodosLosChecks(ByVal check As Boolean)
        Dim d = GridView1.PageCount
        Dim values(GridView1.PageSize) As Boolean
        'Dim values(GridView1.Rows.Count) As Boolean
        Dim ids(GridView1.Rows.Count) As Long


        For p = 0 To GridView1.PageCount
            For i = 0 To GridView1.PageSize
                values(i) = check
            Next
            Session("page" & p) = values
        Next
    End Sub

    Protected Sub HeaderCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'this is for header checkbox changed event


        'For p = 0 To GridView1.PageCount - 1

        '    'reviso cada pagina de checks
        '    Dim values() As Boolean = Session("page" & p)

        '    For Each row As GridViewRow In GridView1.Rows
        '        For i = 0 To row.Cells.Count - 1
        '            Dim cell As TableCell = row.Cells(i)
        '            Dim c As CheckBox = row.Cells(0).Controls(1)
        '            c.Checked = sender.Checked
        '        Next
        '    Next
        'Next

        For Each row As GridViewRow In GridView1.Rows
            For i = 0 To row.Cells.Count - 1
                Dim cell As TableCell = row.Cells(i)
                Dim c As CheckBox = row.Cells(0).Controls(1)
                c.Checked = sender.Checked
            Next
        Next



        MarcarTodosLosChecks(sender.Checked)


        'GuardaChecks() 'acá tendría que grabar tambien el estado 
    End Sub




    Function ListaDeCDPTildados() As String
        GuardaChecks()

        'hay que filtrar el datatable por el mismo criterio de la grilla
        Dim puntoventa = Val(cmbPuntoVenta.SelectedValue)
        If puntoventa = -1 Then puntoventa = 0


        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
        dt = DataTableWHERE(dt, generarWHERE)
        Dim dv As DataView = DataTableORDER(dt, "FechaModificacion DESC")
        '        Dim dv As DataView = New DataView(dt, Text, cmbBuscarEsteCampo.SelectedValue, cmbPuntoVenta.SelectedValue), "", DataViewRowState.OriginalRows)




        Dim chb As CheckBox
        Dim s As String = "0"
        For p = 0 To GridView1.PageCount - 1

            'reviso cada pagina de checks
            Dim values() As Boolean = Session("page" & p)


            If Not IsNothing(values) Then

                For i = 0 To GridView1.PageSize - 1  'si en el paso 2 reseteo el datasource de la grilla del paso 1, no sé más qué buscar...
                    'chb = GridView1.Rows(i).FindControl("CheckBox1")
                    'chb.Checked = values(i)
                    Dim indice = i + p * GridView1.PageSize
                    If indice < dv.Count Then
                        Try

                            If values(i) Then

                                s = s & "," & dv(indice).Item("IdCartaDePorte")
                                'Debug.Print(dt.Rows(indice).Item(2))
                                'Debug.Print(dv(indice).Item("IdWilliamsMailFiltro"))
                            End If
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try

                    End If
                Next
            End If

        Next
        Return s
    End Function

    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub btnRefresca_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresca.Click
        ReBind()

        '        WriteAndRaiseError: Error en GetDataTableFiltradoYPaginado. Probable timeout. ver si el error es de system memory o de report processing, recomendar reinicio del IIS por las sesiones con basura. Incluir sp_who2. Filtro: Descargas, del 17/04/2014 al 19/04/2014 (Exporta: Ambas, Punto de venta: BuenosAires, Criterio: TODOS)Error: Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.
        '            t ErrHandler2.WriteAndRaiseError(String errorMessage) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 143
        'at CartaDePorteManager.GetDataTableFiltradoYPaginado(String SC, String ColumnaParaFiltrar, String TextoParaFiltrar, String sortExpression, Int64 startRowIndex, Int64 maximumRows, enumCDPestado estado, String QueContenga, Int32 idVendedor, Int32 idCorredor, Int32 idDestinatario, Int32 idIntermediario, Int32 idRemComercial, Int32 idArticulo, Int32 idProcedencia, Int32 idDestino, FiltroANDOR AplicarANDuORalFiltro, String ModoExportacion, DateTime fechadesde, DateTime fechahasta, Int32 puntoventa, String& sTituloFiltroUsado, String optDivisionSyngenta, Boolean bTraerDuplicados, String Contrato, String QueContenga2, Int32 idClienteAuxiliar, Int32 AgrupadorDeTandaPeriodos, Int32 Vagon, String Patente, Boolean bInsertarEnTablaTemporal)
        'at CartasDePortes.GetCartas(String& titulo)
        '        at(CartasDePortes.ReBind())
        'at CartasDePortes.btnPaginaAvanza_Click(Object sender, EventArgs e)
    End Sub

    Protected Sub btnPaginaAvanza_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaAvanza.Click
        Try
            GridView1.PageIndex += 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        ReBind()
    End Sub

    Protected Sub btnPaginaRetrocede_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaRetrocede.Click
        Try
            If GridView1.PageIndex < 1 Then Return
            GridView1.PageIndex -= 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        ReBind()
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        'http://msdn.microsoft.com/en-us/library/ms247256(v=vs.80).aspx

        'Dim tema As String = "Azul"
        'Select Case tema
        '    Case "Azul"
        '        Page.Theme = "Azul"
        '    Case "BlancoNegro"
        '        Page.Theme = "BlancoNegro"
        'End Select

    End Sub
End Class

