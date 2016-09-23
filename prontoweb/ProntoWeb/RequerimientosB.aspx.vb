Imports System.IO
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data


Imports CartaDePorteManager

Imports System.Linq.Expressions
Imports System.Collections.Generic
Imports System.Linq.Dynamic


Imports System.Linq
Imports System.Diagnostics

Partial Class Requerimientos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            ViewState("pagina") = 1
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
            ElseIf Not (Request.QueryString.Get("año") Is Nothing) Then
                HFTipoFiltro.Value = "periodo"
            Else
                HFTipoFiltro.Value = ""
            End If


            '///////////////////////////////////////////////


            LlenarComboMes()

            If HFTipoFiltro.Value = "" Or HFTipoFiltro.Value = "Todas" Then
                'ReBindPrimeraPaginaConUltimasCreadas()
                Rebind()
            Else
                Rebind()
            End If
            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 

            If BuscarClaveINI("Ocultar columna comparativas en principal de RM", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then
                GridView1.Columns(getGridIDcolbyHeader("Comparativas", GridView1)).Visible = False
            End If
            If BuscarClaveINI("Ocultar columna pedidos en principal de RM", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then
                GridView1.Columns(getGridIDcolbyHeader("Pedidos", GridView1)).Visible = False
            End If
            If BuscarClaveINI("Ocultar columna presupuestos en principal de RM", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then
                GridView1.Columns(getGridIDcolbyHeader("Presupuestos", GridView1)).Visible = False
            End If
            If BuscarClaveINI("Ocultar columna recepciones en principal de RM", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then
                GridView1.Columns(getGridIDcolbyHeader("Recepciones", GridView1)).Visible = False
            End If
            If BuscarClaveINI("Ocultar columna salidas en principal de RM", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then
                GridView1.Columns(getGridIDcolbyHeader("Salidas", GridView1)).Visible = False
            End If


            If BuscarClaveINI("Pedir autorizacion para reimprimir RM", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then

            End If
        End If

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnExcel)


        'GridView1.Columns("").Visible = False
        '      <asp:BoundField DataField="Presupuestos" HeaderText="Cump" />
        '    <asp:BoundField DataField="Comparativas" HeaderText="Cump" />
        '    <asp:BoundField DataField="Pedidos" HeaderText="Cump" />
        '    <asp:BoundField DataField="Recepciones" HeaderText="Cump" />
        '    <asp:BoundField DataField="Salidas" HeaderText="Cump" />

        Permisos()


    End Sub
    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Requerimientos)

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            GridView1.Visible = False
            lnkNuevo.Visible = False
        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            GridView1.Columns(0).Visible = True
            'GridView1.Columns(0).enabled = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            GridView1.Columns(7).Visible = False

            'muestro el borrar posiciones
            'lnkBorrarPosiciones.Visible = False
        Else
            'lnkBorrarPosiciones.Visible = True
        End If

    End Sub
    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        SetPaging()
    End Sub





    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'GridView1.DataSourceID = ""
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'GridView1.DataSource = ordenar(ObjectDataSource1.Select())


        GridView1.PageIndex = e.NewPageIndex
        'GridView1.DataBind()

        Rebind()



    End Sub




    Function ordenar(ByVal o As Data.DataView) As Data.DataView
        If ViewState("Sort") <> "" Then
            'o.Sort = GridView1.SortExpression + " " + ConvertSortDirectionToSql(GridView1.SortDirection)
            o.Sort = ViewState("Sort")
        End If
        Return o
    End Function



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
                                   "Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"



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
                Dim IdRequerimiento As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Dim filtroano = Request.QueryString.Get("año")
                Dim filtromes = Request.QueryString.Get("mes")
                Response.Redirect(String.Format("RequerimientoB.aspx?Id={0}&año={1}&mes={2}", IdRequerimiento.ToString, filtroano, filtromes))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
            'gp.DataSource = ObjectDataSource2.Select

            'http://stackoverflow.com/questions/331231/c-gridview-row-click
            If False Then
                e.Row.Attributes("onClick") = "location.href='RequerimientoB.aspx?Id=" + DataBinder.Eval(e.Row.DataItem, "Id").ToString + "'"
                e.Row.Attributes("onmouseover") = "this.style.cursor='pointer';"
            End If

            gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.DetRequerimientos_TXReq, DataBinder.Eval(e.Row.DataItem, "Id"))
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

    'Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click
    '    ' Response.Redirect(String.Format("RequerimientoB.aspx?Id=-1"))
    'End Sub


    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (Session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function




    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        'hacer lo de la paginacion
        'GridView1.BottomPagerRow.Visible = True 'forzando el coso para cambiar de pagina
    End Sub


    Private Sub SetPaging()
        'http://www.dotnetcurry.com/ShowArticle.aspx?ID=339

        Exit Sub

        Dim row As GridViewRow = GridView1.BottomPagerRow
        Dim alphaStart As Integer = 65

        For i As Integer = 1 To 10 ' GridView1.PageCount - 1
            Dim btn As New LinkButton()
            btn.CommandName = "Page"
            btn.CommandArgument = i.ToString()

            If i = GridView1.PageIndex + 1 Then
                btn.BackColor = Drawing.Color.BlanchedAlmond
            End If

            btn.Text = Convert.ToChar(alphaStart).ToString()
            btn.ToolTip = "Page " & i.ToString()
            alphaStart += 1
            Dim place As PlaceHolder = TryCast(row.FindControl("PlaceHolder1"), PlaceHolder)
            place.Controls.Add(btn)

            Dim lbl As New Label()
            lbl.Text = " "
            place.Controls.Add(lbl)
        Next i
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


        cmbMesFiltro.DataSource = s
        cmbMesFiltro.DataBind()
        cmbMesFiltro.SelectedIndex = 1




        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////


        Dim nodoporperiodos As TreeNode = New TreeNode("por Períodos")
        nodoporperiodos.SelectAction = TreeNodeSelectAction.None


        Using db As New DataClassesRequerimientoDataContext(Encriptar(HFSC.Value))
            Dim q = (From rm In db.linqRequerimientos Select rm.FechaRequerimiento.Value.Year, rm.FechaRequerimiento.Value.Month).Distinct.OrderBy(Function(i) i.Year)
            Dim anios = q.Select(Function(i) i.Year).Distinct.OrderByDescending(Function(i) i)
            For Each anio In anios


                Dim anionodo = New TreeNode(anio, anio & " ", "", "ProntoWeb/RequerimientosB.aspx?año=" & anio, "")

                Dim aniotemp = anio
                Dim meses = From rm In q Where rm.Year = aniotemp Order By rm.Month Descending Select rm.Month

                For Each Mes In meses
                    anionodo.ChildNodes.Add(New TreeNode(MonthName(Mes), anio & " " & Mes, "", "ProntoWeb/RequerimientosB.aspx?año=" & anio & "&mes=" & Mes, ""))
                Next

                nodoporperiodos.ChildNodes.Add(anionodo)
            Next
        End Using

        'nodoporperiodos.ChildNodes(5).Select()




        Dim arbolOriginal As TreeView = CType(Master.FindControl("ArbolSitemap"), TreeView)
        Dim arbolCopia As TreeView = CType(Master.FindControl("arbolCopia"), TreeView)

        arbolOriginal.DataBind()
        ImpresoraMatrizDePuntosEPSONTexto.CopyTreeview(arbolOriginal, arbolCopia)

        Dim n2 = arbolCopia.FindNode("REQUERIMIENTOS/Por períodos")
        Dim p = n2.Parent
        p.ChildNodes.Remove(n2)



        Dim nodito = arbolCopia.FindNode("REQUERIMIENTOS")
        nodito.ChildNodes.Add(nodoporperiodos)


        'Dim arbolprincipal As TreeView = CType(Master.FindControl("ArbolSitemap"), TreeView) 'http://harriyott.com/2007/03/adding-dynamic-nodes-to-aspnet-site.aspx
        'arbolprincipal.Nodes.Add(nodoporperiodos)
        'arbolprincipal.DataBind()


        ' Dim sm As SiteMapDataSource = Master.FindControl("SiteMapDataSource")
        'Dim siteMapView As SiteMapDataSourceView = CType(sm.GetView(String.Empty), SiteMapDataSourceView)
        'Dim nodes As SiteMapNodeCollection = CType(siteMapView.Select(DataSourceSelectArguments.Empty), SiteMapNodeCollection)
        'Dim tempaaa = New SiteMapNode(SiteMap.Provider, _
        '             HttpRuntime.AppDomainAppVirtualPath & "/" & "ccc", _
        '             HttpRuntime.AppDomainAppVirtualPath & "/" & "ccc", _
        '             "lalalala", _
        '             "lalalala")
        'sm.SiteMapProvider = "main"
        'nodes.Add(tempaaa)
        'Dim x(100) As SiteMapNode
        'nodes.CopyTo(x, 0)
        'Dim c = From i In nodes Select i
        'Dim cn As SiteMapNode = SiteMap.CurrentNode.Clone(True)
        'x.Add(tempaaa)
        'tempaaa.ParentNode = nodes(3)
        'arbolprincipal.DataSourceID = ""
        'arbolprincipal.DataSource = nodes
        'arbolprincipal.DataBind()

        If False Then
            Dim temp = New TreeNode("por Obras")
            temp.SelectAction = TreeNodeSelectAction.None
            arbolCopia.Nodes.Add(temp)
            'rmArbol.Nodes.Add(New TreeNode("a Liberar"))
            'rmArbol.Nodes.Add(New TreeNode("a Confirmar"))
            'rmArbol.Nodes.Add(New TreeNode("Todas"))
        End If

        'arbolprincipal.CollapseAll()
        arbolCopia.CollapseAll()

        Dim filtroano = Request.QueryString.Get("año")
        Dim filtromes = Request.QueryString.Get("mes")




        If filtromes = "" And filtromes IsNot Nothing Then filtromes = iisNull(Session("filtromes"), "")

        If If(filtroano, "") = "" Then filtroano = iisNull(Session("filtroano"), Now.Year)



        Session("filtroano") = filtroano
        Session("filtromes") = filtromes


        Try


            Dim nodoelegido As TreeNode
            If filtromes = "" Then
                nodoelegido = arbolCopia.FindNode("REQUERIMIENTOS/por Períodos/" & filtroano & " ")
            Else
                nodoelegido = arbolCopia.FindNode("REQUERIMIENTOS/por Períodos/" & filtroano & " /" & filtroano & " " & filtromes)
            End If

            nodoelegido.Select()
            'nodoelegido.Expand()
            nodoelegido.Parent.Expand()
            nodoelegido.Parent.Parent.Expand()
            nodoelegido.Parent.Parent.Parent.Expand()

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try









    End Sub


    'Sub ReBindPrimeraPaginaConUltimasCreadas()

    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '1- con LINQ
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    Dim db As New DataClassesRequerimientoDataContext(Encriptar(HFSC.Value))


    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '2- con EntityFramework
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    'http://chanmingman.wordpress.com/2011/03/04/change-the-connection-string-dynamically-for-edmx-entity-during-run-time/
    '    'http://www.developmentalmadness.com/archive/2009/02/10/entity-framework-connection-strings.aspx
    '    Dim prefijo = "metadata=res://*/Model1.csdl|res://*/Model1.ssdl|res://*/Model1.msl;provider=System.Data.SqlClient;provider connection string="
    '    Dim reconstr = prefijo & """" & Encriptar(HFSC.Value) & """"
    '    Dim dbConEntityFramw As New wDemoWilliamsModel.wDemoWilliamsEntities(reconstr)
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////
    '    '////////////////////////////////////////////


    '    Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
    '    Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)

    '    If cmbMesFiltro.Text = "Todas" Then
    '        txtFechaDesde.Text = #1/1/1900#
    '        txtFechahasta.Text = #1/1/2100#
    '    Else
    '        txtFechaDesde.Text = GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
    '        txtFechahasta.Text = GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
    '    End If

    '    'Requerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)

    '    Dim fechaDelDecimoMasReciente = (From i In db.linqRequerimientos Order By i.IdRequerimiento Descending _
    '                                     Select i.FechaRequerimiento Skip 10 Take 1).FirstOrDefault

    '    'tengo que definir lo que me devuelve este store porque pinta que usa temp tables y vuelve loco al mapeo de LINQ!!!!!!! -masí, safo llamandola por afuera
    '    'Dim b = From i In db.Requerimientos_TXFecha(fechaDelDecimoMasReciente, TextoAFecha(txtFechahasta.Text), -1) Select i.
    '    Dim dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, iisValidSqlDate(fechaDelDecimoMasReciente, Today), TextoAFecha(txtFechahasta.Text), -1)
    '    With dt
    '        .Columns("IdRequerimiento").ColumnName = "Id"
    '        .Columns("Numero Req_").ColumnName = "Numero"
    '    End With

    '    '///////////////////////////////////////////////////
    '    'filtro
    '    ' dt = DataTableWHERE(dt, GenerarWHERE)


    '    '///////////////////////////////////////////////////
    '    '///////////////////////////////////////////////////
    '    'ordeno
    '    Dim b As Data.DataView = DataTableORDER(dt, "Id DESC")
    '    ViewState("Sort") = b.Sort


    '    GridView1.DataSourceID = ""
    '    GridView1.DataSource = b
    '    GridView1.DataBind()
    '    'GridView1.PageIndex = pageIndex
    'End Sub


    Sub Rebind()
        Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
        'Dim cmbMesFiltro As DropDownList = CType(Master.FindControl("cmbMesFiltro"), DropDownList)


        Dim dt As DataTable





        If Request.QueryString.Get("año") IsNot Nothing Then
            Dim filtroano = Request.QueryString.Get("año")
            Dim filtromes = Request.QueryString.Get("mes")

            Dim fechadesde As Date
            Dim fechahasta As Date

            If If(filtroano, "") = "" Then filtroano = Now.Year

            If If(filtromes, "") = "" Then
                fechadesde = New Date(filtroano, 1, 1)
                fechahasta = New Date(filtroano, 12, 31)
            Else
                fechadesde = New Date(filtroano, filtromes, 1)
                fechahasta = GetLastDayInMonth(fechadesde)
            End If

            txtFechaDesde.Text = fechadesde ' GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
            txtFechahasta.Text = fechahasta ' GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
        ElseIf cmbMesFiltro.Text = "Todas" Or Request.QueryString.Get("tipo") = "Todas" Then
            txtFechaDesde.Text = #1/1/1900#
            txtFechahasta.Text = #1/1/2100#
        Else
            txtFechaDesde.Text = GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
            txtFechahasta.Text = GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
        End If





        Dim pageIndex = GridView1.PageIndex


        'chupo
        If HFTipoFiltro.Value = "Aconfirmar" Then
            dt = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_AConfirmar, -1)
            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("Nro_ Req_ a Conf_").ColumnName = "Numero"

                .Columns.Add("Recibido")
                .Columns.Add("Entregado")
                .Columns.Add("Presupuestos")
                .Columns.Add("Comparativas")
                .Columns.Add("Pedidos")
                .Columns.Add("Recepciones")
                .Columns.Add("Salidas")


                '.Columns.Add("Obra")
                '.Columns.Add("Sector")
                '.Columns.Add("Origen")
                .Columns.Add("Equipo destino")
                .Columns.Add("Anulo")
                .Columns.Add("Fecha_anulacion")
                .Columns.Add("Motivo_anulacion")

                .Columns.Add("Tipo_compra")
                .Columns.Add("_2da_Firma")
                .Columns.Add("Fecha_2da_Firma")
                .Columns.Add("Comprador")
                .Columns.Add("Importada_por")
                .Columns.Add("Fec_llego_SAT")
                .Columns.Add("Fechas_de_liberacion para compras por item")
                .Columns.Add("Detalle_imputacion")
                .Columns.Add("Observaciones")
                .Columns.Add("Elim_Firmas")


                'GridView1.AutoGenerateColumns = True
            End With

        ElseIf HFTipoFiltro.Value = "Aliberar" Then
            dt = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_ALiberar, -1)
            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("Nro_ Req_ a Conf_").ColumnName = "Numero"

                .Columns.Add("Recibido")
                .Columns.Add("Entregado")
                .Columns.Add("Presupuestos")
                .Columns.Add("Comparativas")
                .Columns.Add("Pedidos")
                .Columns.Add("Recepciones")
                .Columns.Add("Salidas")


                '.Columns.Add("Obra")
                '.Columns.Add("Sector")
                '.Columns.Add("Origen")
                .Columns.Add("Liberada_por")
                .Columns.Add("Solicitada_por")
                .Columns.Add("Equipo_destino")
                .Columns.Add("Anulo")
                .Columns.Add("Fecha_anulacion")
                .Columns.Add("Motivo_anulacion")

                .Columns.Add("Tipo_compra")
                .Columns.Add("_2da_Firma")
                .Columns.Add("Fecha_2da_Firma")
                .Columns.Add("Comprador")
                .Columns.Add("Importada_por")
                .Columns.Add("Fec_llego_SAT")
                .Columns.Add("Fechas_de_liberacion_para_compras_por_item")
                .Columns.Add("Detalle_imputacion")
                .Columns.Add("Observaciones")
                .Columns.Add("Elim_Firmas")


                'GridView1.AutoGenerateColumns = True
            End With
        ElseIf True Then
            'filtrar por fecha

            ' dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)
            Dim bFiltraPeriodos As Boolean = (Request.QueryString.Get("año") IsNot Nothing)
            Dim q = RequerimientoManagerExtension.GetList(HFSC.Value, _
                                                 (ViewState("pagina") - 1) * 10, _
                                                 10, txtBuscar.Text, _
                                                 cmbBuscarEsteCampo.SelectedValue, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text))




            'dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, #7/1/2009#, #7/31/2009#, -1)
            'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)
            'dt = q.ToDataTable
            dt = LogicaFacturacion.ToDataTableNull(q.ToList)


            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("Numero_Req_").ColumnName = "Numero"

                .Columns.Add("Presupuestos")
                .Columns.Add("Comparativas")
                .Columns.Add("Recepciones")
                .Columns.Add("Salidas")
                .Columns.Add("Pedidos")
                .Columns.Add("Fechas_de_liberacion_para_compras_por_item")
                .Columns.Add("Observaciones")
                .Columns.Add("Elim_firmas")

            End With




            ViewState("totalpaginas") = RequerimientoManager.GetList_Count(HFSC.Value, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechaDesde.Text))


            Try
                Dim s As String = (ViewState("pagina") - 1) * GridView1.PageSize + 1 & "-" & (ViewState("pagina") - 1) * GridView1.PageSize + GridView1.Rows.Count & " de " & ViewState("totalpaginas") '& " " & dt.Rows.Count & " fila(s)"
                lblGrilla1Info.Text = s

            Catch ex As Exception

            End Try


            GridView1.AllowPaging = False
            GridView1.DataSourceID = ""

            GridView1.DataSource = dt
            GridView1.DataBind()

            Return



            'dt = linqrms

        ElseIf False Then
            'filtrar por fecha

            ' dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)


            Using db As New DataClassesRequerimientoDataContext(Encriptar(HFSC.Value))

                Dim q = From rm In db.wRequerimientos_TTpaginado((ViewState("pagina") - 1) * 10 + 1, 10, cmbBuscarEsteCampo.SelectedValue, txtBuscar.Text, "", _
                                                                TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text))


                ' Dim q = From rm In db.wVistaRequerimientos Take 10 Skip (ViewState("pagina") - 1) * 10

                '        Where rm.fecha > TextoAFecha(txtFechaDesde.Text) And rm.Fecha < TextoAFecha(txtFechahasta.Text) _
                '        Take 10 Skip ViewState("pagina") * 10
                'dt = q.ToDataTable



                GridView1.AllowPaging = False
                GridView1.DataSourceID = ""
                GridView1.DataSource = q
                GridView1.DataBind()


                ViewState("totalpaginas") = (From i In db.wRequerimientos_TTpaginadoTotalCount(cmbBuscarEsteCampo.SelectedValue, txtBuscar.Text, _
                                                                TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text)) Select i.Column1).FirstOrDefault

                '                ViewState("totalpaginas") = db.wVistaRequerimientos.Count


                lblGrilla1Info.Text = (ViewState("pagina") - 1) * GridView1.PageSize + 1 & "-" & (ViewState("pagina") - 1) * GridView1.PageSize + GridView1.Rows.Count & " de " & ViewState("totalpaginas") '& " " & dt.Rows.Count & " fila(s)"


                Exit Sub
            End Using



            'dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, #7/1/2009#, #7/31/2009#, -1)
            'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)
            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("Numero Req_").ColumnName = "Numero"
            End With

            'dt = linqrms
        Else
            'filtrar por pagina
            Dim lTopRow = pageIndex * GridView1.PageSize + 1
            dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TTpaginado, lTopRow, GridView1.PageSize)
            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("Numero Req_").ColumnName = "Numero"
            End With
        End If



        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'filtro
        dt = DataTableWHERE(dt, GenerarWHERE)


        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'ordeno
        Dim b As Data.DataView = DataTableORDER(dt, "Id DESC")
        ViewState("Sort") = b.Sort


        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex




    End Sub

    Function linqrms()

        '        Dim a As New model
        '        Dim s As New DataClasses2DataContext(Encriptar(HFSC.Value))

        'SELECT 
        ' Requerimientos.IdRequerimiento,
        ' Requerimientos.NumeroRequerimiento as [Numero Req.],
        ' Requerimientos.IdRequerimiento as [IdReq],
        ' Requerimientos.FechaRequerimiento as [Fecha],

        '            ''  as [Vs],
        '--'' IsNull('/'+Convert(varchar,Requerimientos.NumeradorEliminacionesFirmas),'') as [Vs],

        ' Requerimientos.Cumplido as [Cump.],
        ' Requerimientos.Recepcionado as [Recibido],
        ' Requerimientos.Entregado as [Entregado],
        ' Requerimientos.Impresa as [Impresa],
        ' Requerimientos.Detalle as [Detalle],
        ' Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
        ' dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],
        ' dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],
        ' dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],
        ' dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],
        ' dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas], 
        ' (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],
        ' E1.Nombre as [Liberada por],
        ' E2.Nombre as [Solicitada por],
        ' Sectores.Descripcion as [Sector],
        ' ArchivosATransmitirDestinos.Descripcion as [Origen],
        ' Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],
        ' Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Articulos.Descripcion as [Equipo destino],
        ' Requerimientos.UsuarioAnulacion as [Anulo],
        ' Requerimientos.FechaAnulacion as [Fecha anulacion],
        ' Requerimientos.MotivoAnulacion as [Motivo anulacion],
        ' TiposCompra.Descripcion as [Tipo compra],
        ' (Select Top 1 Empleados.Nombre From Empleados 
        '  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut 
        '				Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],
        ' (Select Top 1 Aut.FechaAutorizacion 
        '  From AutorizacionesPorComprobante Aut 
        '  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],
        ' (Select Top 1 Empleados.Nombre From Empleados 
        '  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador From DetalleRequerimientos Det 
        '				Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],
        ' E3.Nombre as [Importada por],
        ' Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],
        ' dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [Fechas de liberacion para compras por item],
        ' Requerimientos.DetalleImputacion as [Detalle imputacion],
        ' Requerimientos.Observaciones as [Observaciones],
        ' Requerimientos.NumeradorEliminacionesFirmas as [Elim.Firmas],
        ' @Vector_T as Vector_T,
        ' @Vector_X as Vector_X
        'FROM Requerimientos
        'LEFT OUTER JOIN Obras ON Requerimientos.IdObra=Obras.IdObra
        'LEFT OUTER JOIN CentrosCosto ON Requerimientos.IdCentroCosto=CentrosCosto.IdCentroCosto
        'LEFT OUTER JOIN Sectores ON Requerimientos.IdSector=Sectores.IdSector
        'LEFT OUTER JOIN Monedas ON Requerimientos.IdMoneda=Monedas.IdMoneda
        'LEFT OUTER JOIN ArchivosATransmitirDestinos ON Requerimientos.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
        'LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino=Articulos.IdArticulo
        'LEFT OUTER JOIN TiposCompra ON Requerimientos.IdTipoCompra = TiposCompra.IdTipoCompra
        'LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado = Requerimientos.Aprobo
        'LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado = Requerimientos.IdSolicito
        'LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado = Requerimientos.IdImporto
        'WHERE (Requerimientos.FechaRequerimiento Between @Desde And @Hasta) 
        '	--and isNull(Requerimientos.Confirmado,'SI')<>'NO' 
        '	--and IsNull(Requerimientos.ConfirmadoPorWeb,'SI')<>'NO' 
        '	and	(@IdObraAsignadaUsuario=-1 or Requerimientos.IdObra=@IdObraAsignadaUsuario)
        'ORDER BY Requerimientos.FechaRequerimiento Desc, Requerimientos.NumeroRequerimiento Desc

    End Function


    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        Rebind()

        'ObjectDataSource1.FilterExpression = GenerarWHERE() 

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub Imprimir(ByVal IdRequerimiento As Long)
        Dim output As String
        output = ImprimirWordDOT("Requerimiento_" & Session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, HFSC.Value, Session, Response, IdRequerimiento)
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
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub


    Protected Sub cmbMesFiltro_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbMesFiltro.SelectedIndexChanged
        Rebind()
    End Sub

    Protected Sub btnPaginaAvanza_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaAvanza.Click

        If ViewState("pagina") < ViewState("totalpaginas") Then
            ViewState("pagina") += 1

            Rebind()
        End If

    End Sub

    Protected Sub btnPaginaRetrocede_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaRetrocede.Click
        If ViewState("pagina") > 1 Then
            ViewState("pagina") -= 1

            Rebind()
        End If
    End Sub



    'Sub a()

    '    Using db As New DataClassesRequerimientoDataContext(Encriptar(HFSC.Value))

    '        '            Dim s = From rm In db.linqRequerimientos _
    '        '                    From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
    '        '                    From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
    '        '                    From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
    '        '                    From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
    '        '                    From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
    '        '                    From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
    '        '                    From clifac In db.linqClientes.Where(Function(i) i.IdCliente = fac.IdCliente).DefaultIfEmpty _
    '        '                    From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
    '        '                    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
    '        '                    From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
    '        '                    From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
    '        '                    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
    '        '                    From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
    '        '                    From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
    '        '                    Where fac.FechaFactura >= fechadesde And fac.FechaFactura < fechahasta _
    '        '                        And (cdp.IdFacturaImputada > 0) _
    '        '                        And (cdp.NetoProc > 0 And cdp.FechaDescarga.HasValue) _
    '        '                        And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
    '        '                        And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
    '        '                        And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
    '        '                        And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
    '        '                        And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
    '        '                        And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
    '        '                        And (idDestino = -1 Or cdp.Destino = idDestino) _
    '        '                        And (PV() = -1 Or cdp.PuntoVenta = PV()) _
    '        '                    Select
    '        'Requerimientos.IdRequerimiento,  
    '        ' Requerimientos.NumeroRequerimiento as [Numero Req.],  
    '        ' Requerimientos.IdRequerimiento as [IdReq],  
    '        ' Requerimientos.FechaRequerimiento as [Fecha],  
    '        ' IsNull('/'+Convert(varchar,Requerimientos.NumeradorEliminacionesFirmas),'') as [Vs],  
    '        ' Requerimientos.Cumplido as [Cump.],  
    '        ' Requerimientos.Recepcionado as [Recibido],  
    '        ' Requerimientos.Entregado as [Entregado],  
    '        ' Requerimientos.Impresa as [Impresa],  
    '        ' Requerimientos.Detalle as [Detalle],  
    '        ' Obras.NumeroObra+' '+Obras.Descripcion as [Obra],  
    '        ' dbo.Requerimientos_Presupuestos(Requerimientos.IdRequerimiento)as [Presupuestos],  
    '        ' dbo.Requerimientos_Comparativas(Requerimientos.IdRequerimiento)as [Comparativas],  
    '        ' dbo.Requerimientos_Pedidos(Requerimientos.IdRequerimiento)as [Pedidos],  
    '        ' dbo.Requerimientos_Recepciones(Requerimientos.IdRequerimiento)as [Recepciones],  
    '        ' dbo.Requerimientos_SalidasMateriales(Requerimientos.IdRequerimiento)as [Salidas],   
    '        ' (Select Count(*) From DetalleRequerimientos Where DetalleRequerimientos.IdRequerimiento=Requerimientos.IdRequerimiento) as [Cant.Items],  
    '        ' E1.Nombre as [Liberada por],  
    '        ' E2.Nombre as [Solicitada por],  
    '        ' Sectores.Descripcion as [Sector],  
    '        ' ArchivosATransmitirDestinos.Descripcion as [Origen],  
    '        ' Requerimientos.FechaImportacionTransmision as [Fecha imp.transm,],  
    '        ' #Auxiliar1.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+#Auxiliar1.Descripcion as [Equipo destino],  
    '        ' Requerimientos.UsuarioAnulacion as [Anulo],  
    '        ' Requerimientos.FechaAnulacion as [Fecha anulacion],  
    '        ' Requerimientos.MotivoAnulacion as [Motivo anulacion],  
    '        ' TiposCompra.Descripcion as [Tipo compra],  
    '        ' (Select Top 1 Empleados.Nombre From Empleados   
    '        '  Where Empleados.IdEmpleado=(Select Top 1 Aut.IdAutorizo From AutorizacionesPorComprobante Aut   
    '        '    Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento)) as [2da.Firma],  
    '        ' (Select Top 1 Aut.FechaAutorizacion   
    '        '  From AutorizacionesPorComprobante Aut   
    '        '  Where Aut.IdFormulario=3 and Aut.OrdenAutorizacion=1 and Aut.IdComprobante=Requerimientos.IdRequerimiento) as [Fecha 2da.Firma],  
    '        ' (Select Top 1 Empleados.Nombre From Empleados   
    '        '  Where Empleados.IdEmpleado=(Select Top 1 Det.IdComprador From DetalleRequerimientos Det   
    '        '    Where Det.IdRequerimiento=Requerimientos.IdRequerimiento and Det.IdComprador  is not null)) as [Comprador],  
    '        ' E3.Nombre as [Importada por],  
    '        ' Requerimientos.FechaLlegadaImportacion as [Fec.llego SAT],  
    '        ' dbo.Requerimientos_FechasLiberacion(Requerimientos.IdRequerimiento) as [Fechas de liberacion para compras por item],  
    '        ' Requerimientos.DetalleImputacion as [Detalle imputacion],  
    '        ' Requerimientos.Observaciones as [Observaciones],  
    '        ' Requerimientos.NumeradorEliminacionesFirmas as [Elim.Firmas],  

    '        '            fac.IdFactura, _
    '        '                                        fac.IdCliente, _
    '        '                                        Factura = fac.TipoABC.ToString & "-" & fac.PuntoVenta.ToString & "-" & fac.NumeroFactura.ToString, _
    '        '                                        CDP = cdp.NumeroCartaDePorte, _
    '        '                                        FechaFactura = fac.FechaFactura, _
    '        '                                        Obs = cdp.Observaciones, _
    '        '                                        KgNetos = cdp.NetoFinal, _
    '        '                                        Cliente = clifac.RazonSocial, _
    '        '                                        VendedorDesc = clitit.RazonSocial, _
    '        '                                        CuentaOrden1Desc = cliint.RazonSocial, _
    '        '                                        CuentaOrden2Desc = clircom.RazonSocial, _
    '        '                                        CorredorDesc = corr.Nombre, _
    '        '                                        EntregadorDesc = clidest.RazonSocial, _
    '        '                                        ProcedenciaDesc = Loc.Nombre, _
    '        '                                        DestinoDesc = dest.Descripcion, _
    '        '                                        Producto = art.Descripcion, _
    '        '                                        CalidadDesc = cal.Descripcion, _
    '        '                                        TarifaFacturada = cdp.TarifaFacturada

    '    End Using



    '    'GridView1.DataSourceID = ""
    '    'GridView1.DataSource = q
    '    'GridView1.DataBind()

    'End Sub



    Protected Sub btnExcel_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        ' Dim q = RequerimientoManager.GetListDatasetPaginado(HFSC.Value, 0, 5000)


        Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
        Dim desde As Date? = iisValidSqlDate(TextoAFecha(txtFechaDesde.Text), #1/1/1900#)
        Dim hasta As Date? = iisValidSqlDate(TextoAFecha(txtFechahasta.Text), #1/1/2100#)






        Dim pdatatable As DataTable

        Using db As New DataClasses2DataContext(Encriptar(HFSC.Value))


            If False Then
                Dim q = (From rm In db.wRequerimientos_TTpaginado(1, 100000, cmbBuscarEsteCampo.SelectedValue, txtBuscar.Text, "", _
                                                                 #1/1/2000#, Today)).ToList

                'Dim q = (From rm In db.wRequerimientos_TTpaginado(1, 100000, cmbBuscarEsteCampo.SelectedValue, txtBuscar.Text, "", _
                '                                                    TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text))).ToList

                pdatatable = LogicaFacturacion.ToDataTableNull(q)


            Else

                Dim q2 = RequerimientoManagerExtension.GetList(HFSC.Value, 0, 10000, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, desde, hasta)


                Dim bFiltraPeriodos As Boolean = (Request.QueryString.Get("año") IsNot Nothing)




                Dim q = (From cab In q2 Join det In db.wVistaDetRequerimientos On cab.IdRequerimiento Equals det.IdRequerimiento _
                            Select cab.Numero_Req_, _
                                Fecha = CDate(cab.Fecha).ToShortDateString, _
                                  det.Articulo, det.Cant_, det.Unidad_en, _
                                cab.Recibido, _
                                cab.Entregado, _
                                cab.Impresa, _
                                cab.Cant_Items, _
                                cab.Liberada_por, _
                                cab.Solicitada_por, _
                                cab.Obra, _
                                cab.Sector, _
                                cab.Origen, _
                                cab.Equipo_destino, _
                                cab.Fecha_anulacion, _
                                cab.Motivo_anulacion, _
                                cab.Tipo_compra, _
                                cab._2da_Firma, _
                                cab.Fecha_2da_Firma, _
                                cab.Comprador, _
                                cab.Importada_por, _
                                cab.Fec_llego_SAT, _
                                cab.Detalle_imputacion _
                                            ).ToList()






                'Dim q = (From rm In db.wVistaRequerimientos).ToList
                pdatatable = LogicaFacturacion.ToDataTableNull(q)
            End If


            Try
                pdatatable.Columns.Remove("IdReq")
                pdatatable.Columns.Remove("IdRequerimiento")
                'pdatatable.Columns.Remove("Numero_Req_")
                pdatatable.Columns.Remove("id")



            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            For Each c As DataColumn In pdatatable.Columns
                c.ColumnName() = c.ColumnName().Replace("_", " ")
            Next

            ' Dim dt = q.ToArray '.ToDataTable
            'Dim pdatatable = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TTpaginado, 1, 1000, "", "", "", #1/1/2000#, Today)
            Debug.Print(pdatatable.Rows.Count)

            Dim output As String
            output = System.IO.Path.GetTempPath & "Requerimientos_" & Session(SESSIONPRONTO_NombreEmpresa) & Now.ToString("ddMMMyyyy_HHmmss") & ".xlsx"
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
                MsgBoxAjax(Me, ex.ToString)
                Return
            End Try
        End Using

    End Sub

    Protected Sub btnRefresca_Click(sender As Object, e As System.EventArgs) Handles btnRefresca.Click

        Rebind()
    End Sub
End Class
