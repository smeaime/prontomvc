Imports System
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll.EntidadManager
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Imports CartaDePorteManager

Partial Class Articulos
    Inherits System.Web.UI.Page

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdArticulo As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Articulo.aspx?Id={0}", IdArticulo.ToString))
        End Select
    End Sub

    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click

        Response.Redirect(String.Format("Articulo.aspx?Id=-1"))

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            ReBind()
        End If

        Permisos()
    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Artículos)

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
            GridView1.Columns(5).Visible = False
        End If

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


    'Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
    '    'http://forums.asp.net/t/1284166.aspx
    '    'esto solo se puede usar si el ODS usa un dataset
    '    ObjectDataSource1.FilterExpression = "Convert(Descripcion, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
    '                                         & " OR " & _
    '                                         "Convert(Codigo, 'System.String') LIKE '*" & txtBuscar.Text & "*'"

    '    'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    'End Sub


    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()

        ReBind()
    End Sub
    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        'GridView1.databind()

        ReBind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
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

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'objectdatasource1.select()
        GridView1.PageIndex = e.NewPageIndex
        ReBind()

    End Sub


    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        'MsgBoxAjax(Me, "sdfsdf")
        'Exit Sub
        Try
            If Not Pronto.ERP.Bll.ArticuloManager.Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString()) Then
                MsgBoxAjax(Me, "El artículo se está usando, y no se puede borrar")
                'MsgBoxAlert("sdfsdf")
            Else
                'ObjectDataSource1.FilterExpression = GenerarWHERE()
                'ObjectDataSource1.Select()
                'GridView1.DataBind()
                ReBind()
            End If

        Catch ex As Exception

        End Try



        'Try
        '    Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString())
        '    ReBind()
        'Catch sqlEx As SqlException When sqlEx.Number = 547  'handle foreign key violation(547)
        '    'http://forums.asp.net/t/555900.aspx
        '    'Do something about the exception
        '    MsgBoxAjax(Me, "La localidad está siendo usada") ' "La localidad está siendo usada")
        '    'Catch sqlEx as SqlException When sqlEx.Number = [Another SQL error number]
        '    'Do something about the exception
        'Catch sqlEx As SqlException  'all other SQL exceptions
        '    'Do something about the exception
        '    MsgBoxAjax(Me, sqlex.ToString) ' "La localidad está siendo usada")
        'Catch ex As Exception
        '    MsgBoxAjax(Me, ex.ToString) ' "La localidad está siendo usada")
        'End Try
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub

    Private Sub ReBind()
        Dim dt As Data.DataTable = ArticuloManager.GetListDataset(HFSC.Value).Tables(0)
        Dim dv As Data.DataView = New Data.DataView(dt, GenerarWHERE(), "", Data.DataViewRowState.OriginalRows)

        'GridView1.DataSource = dtCustomer
        GridView1.DataSource = dv
        '    GridView1.DataSource = '  EntidadManager.ExecDinamico(SC," "Localidades_TT")
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GridView1.DataBind()
    End Sub
End Class
