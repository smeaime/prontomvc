Imports System
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Web.UI.WebControls

Imports Pronto.ERP.BO

Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
'Imports Pronto.ERP.Bll.BDLmasterPermisosManager

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo

Imports System.Linq


Imports CartaDePorteManager

Partial Class Clientes
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()
        If Not IsPostBack Then
            'primera carga. Muestro la primera pagina, sin filtrar
            BindPrimeraPagina()
        Else
            'si haces el bind antes de q se procese un click, no desbaratás los ID?

            If Request.Params("__EVENTTARGET").ToString() <> "ctl00$ContentPlaceHolder1$GridView1" Then 'si hacen clic en editar, no hace falta hacer un bind
                ReBindGrid1()
            End If
        End If


            Permisos()
    End Sub



    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdArticulo As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Cliente.aspx?Id={0}", IdArticulo.ToString))
        End Select
    End Sub

    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click

        Response.Redirect(String.Format("Cliente.aspx?Id=-1"))

    End Sub



    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "Clientes")

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




    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (Session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function


    'Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
    '    'http://forums.asp.net/t/1284166.aspx
    '    'esto solo se puede usar si el ODS usa un dataset
    '    ObjectDataSource1.FilterExpression = "Convert([Razon Social], 'System.String') LIKE '*" & txtBuscar.Text & "*'"


    '    'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    'End Sub


    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        ReBindGrid1()
        ''ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        ReBindGrid1()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        'GridView1.databind()

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

        s += " AND isnull([Razon Social],'')<>''"
        s += " AND ( " & _
                                   "Convert(" & cmbBuscarEsteCampo.SelectedValue & ", 'System.String') LIKE '*" & txtBuscar.Text & "*' )" '_

        If DropDownList1.SelectedValue = "Provisorios" Then
            s += " AND " & _
                                   "CUIT is NULL"
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
        GridView1.PageIndex = e.NewPageIndex
        ReBindGrid1()
    End Sub


    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        Try
            Pronto.ERP.Bll.ClienteManager.Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString())
            ReBindGrid1()
        Catch ex As Exception
            MsgBoxAjax(Me, "El cliente se está usando, y no se puede borrar")
        End Try

        'If Not Pronto.ERP.Bll.ClienteManager.Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString()) Then
        '    MsgBoxAjax(Me, "El cliente se está usando, y no se puede borrar")
        '    'MsgBoxAlert("sdfsdf")
        'Else
        '    'ObjectDataSource1.FilterExpression = GenerarWHERE()
        '    'ObjectDataSource1.Select()
        '    'GridView1.DataBind()
        '    ReBindGrid1()
        'End If


        'ReBindGrid1()
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        ReBindGrid1()
    End Sub


    Sub ReBindGrid1()


        


        Dim dt As Data.DataTable
        Try

            'dt = ClienteManager.GetListDataset(HFSC.Value).Tables(0)
            dt = ClienteManager.GetListDatasetWHERE(HFSC.Value, cmbBuscarEsteCampo.SelectedValue, txtBuscar.Text, "", 0, 10).Tables(0)

            GenerarWHERE()


            If True Then
                Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
                Dim a = db.linqClientes.Where(Function(x) x.RazonSocial.Contains(txtBuscar.Text))
                Dim c = From x In a _
                       Select Id = x.IdCliente, x.RazonSocial, x.Telefono, x.Email, x.Cuit, x.Direccion, Localidad = x.Localidade, Provincia = x.IdProvincia


                GridView1.DataSource = c
                GridView1.DataBind()
                Return
            End If


        Catch ex As Exception
            MandarMailDeError("Usar dinamic linq en lugar de los stores")
            Throw
            '                    Error en la ejecucion del SP: wClientes_TT - Exception of type 'System.OutOfMemoryException' was thrown.
            'Stack Trace:	 at Pronto.ERP.Dal.GeneralDB.TraerDatos(String SC, String Nombre, Object[] ParametrosQueLeQuieroMandarAsql) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 228
            'at Pronto.ERP.Bll.EntidadManager.TraerDatos(String SC, String Nombre, Object[] Parametros) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 227
            'at Pronto.ERP.Bll.ClienteManager.GetListDataset(String SC) in C:\Backup\BDL\BussinessLogic\ClienteManager.vb:line 241
            '            at(Clientes.ReBindGrid1())




            '        Error en la ejecucion del SP: wClientes_TT - Exception of type 'System.OutOfMemoryException' was thrown.
            'Stack Trace:	 at Pronto.ERP.Dal.GeneralDB.TraerDatos(String SC, String Nombre, Object[] ParametrosQueLeQuieroMandarAsql) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 228
            'at Pronto.ERP.Bll.EntidadManager.TraerDatos(String SC, String Nombre, Object[] Parametros) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 227
            'at Pronto.ERP.Bll.ClienteManager.GetListDataset(String SC) in C:\Backup\BDL\BussinessLogic\ClienteManager.vb:line 241
            '        at(Clientes.ReBindGrid1())
            'at Clientes.txtBuscar_TextChanged(Object sender, EventArgs e)
            'at System.Web.UI.WebControls.TextBox.OnTextChanged(EventArgs e)
            '        at(System.Web.UI.WebControls.TextBox.RaisePostDataChangedEvent())
            '        at(System.Web.UI.WebControls.TextBox.System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent())
            '        at(System.Web.UI.Page.RaiseChangedEvents())
            'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)



        End Try







        Dim dv As Data.DataView = New Data.DataView(dt, GenerarWHERE(), "", Data.DataViewRowState.OriginalRows)

        'GridView1.DataSource = dtCustomer
        GridView1.DataSource = dv
        '    GridView1.DataSource = '  EntidadManager.ExecDinamico(SC," "Localidades_TT")
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GridView1.DataBind()
    End Sub

    Sub ReBindGrid2()





        Dim dt As Data.DataTable
        Try

            'dt = ClienteManager.GetListDataset(HFSC.Value).Tables(0)
            'dt = ClienteManager.GetListDatasetWHERE(HFSC.Value, cmbBuscarEsteCampo.SelectedValue, txtBuscar.Text, "", 0, 10).Tables(0)

            'GenerarWHERE()


            If True Then
                Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
                Dim a = db.linqClientes.Where(Function(x) x.RazonSocial.Contains(txtBuscar.Text))
                Dim c = From x In a _
                       Select Id = x.IdCliente, x.RazonSocial, x.Telefono, x.Email, x.Cuit, x.Direccion, Localidad = x.Localidade, Provincia = x.IdProvincia _
                       Take 30



                GridView1.DataSource = c
                GridView1.DataBind()
                Return
            End If


        Catch ex As Exception
            MandarMailDeError("Usar dinamic linq en lugar de los stores")
            Throw
            '                    Error en la ejecucion del SP: wClientes_TT - Exception of type 'System.OutOfMemoryException' was thrown.
            'Stack Trace:	 at Pronto.ERP.Dal.GeneralDB.TraerDatos(String SC, String Nombre, Object[] ParametrosQueLeQuieroMandarAsql) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 228
            'at Pronto.ERP.Bll.EntidadManager.TraerDatos(String SC, String Nombre, Object[] Parametros) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 227
            'at Pronto.ERP.Bll.ClienteManager.GetListDataset(String SC) in C:\Backup\BDL\BussinessLogic\ClienteManager.vb:line 241
            '            at(Clientes.ReBindGrid1())




            '        Error en la ejecucion del SP: wClientes_TT - Exception of type 'System.OutOfMemoryException' was thrown.
            'Stack Trace:	 at Pronto.ERP.Dal.GeneralDB.TraerDatos(String SC, String Nombre, Object[] ParametrosQueLeQuieroMandarAsql) in C:\Backup\BDL\DataAccess\GeneralDB.vb:line 228
            'at Pronto.ERP.Bll.EntidadManager.TraerDatos(String SC, String Nombre, Object[] Parametros) in C:\Backup\BDL\BussinessLogic\EntidadManager.vb:line 227
            'at Pronto.ERP.Bll.ClienteManager.GetListDataset(String SC) in C:\Backup\BDL\BussinessLogic\ClienteManager.vb:line 241
            '        at(Clientes.ReBindGrid1())
            'at Clientes.txtBuscar_TextChanged(Object sender, EventArgs e)
            'at System.Web.UI.WebControls.TextBox.OnTextChanged(EventArgs e)
            '        at(System.Web.UI.WebControls.TextBox.RaisePostDataChangedEvent())
            '        at(System.Web.UI.WebControls.TextBox.System.Web.UI.IPostBackDataHandler.RaisePostDataChangedEvent())
            '        at(System.Web.UI.Page.RaiseChangedEvents())
            'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)



        End Try







        Dim dv As Data.DataView = New Data.DataView(dt, GenerarWHERE(), "", Data.DataViewRowState.OriginalRows)

        'GridView1.DataSource = dtCustomer
        GridView1.DataSource = dv
        '    GridView1.DataSource = '  EntidadManager.ExecDinamico(SC," "Localidades_TT")
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GridView1.DataBind()
    End Sub
    Sub BindPrimeraPagina()

        ReBindGrid2()


        If False Then

            GridView1.DataSourceID = ""
            'me traigo suficientes como para llenar el paginado y no tener que forzar el pagerow
            GridView1.DataSource = GetStoreProcedure(HFSC.Value, enumSPs.wClientes_TTprimerapagina)
            GridView1.DataBind()
            'ForzarPagerow()
        End If
    End Sub


End Class
