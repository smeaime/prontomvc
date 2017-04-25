﻿Imports Pronto.ERP.Bll

Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo
Imports CDPDestinosManager 'como la capa de negocios la tengo acá para debuguear en tiempo de ejecucion, la importo desde acá

Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá

Imports ClaseMigrar.SQLdinamico

Imports ProntoMVC.Data.Models

Imports CartaDePorteManager



'    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

Partial Class CartasDePorteReasignarImagenListado
    Inherits System.Web.UI.Page





    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'http://forums.asp.net/t/1002747.aspx?PageIndex=1

    '    Re: GridView RowDeleting event fires twice ! (My Solution)
    '06-19-2007, 11:27 PM	
    'Contact
    'Favorites
    'Reply

    '2 point Member
    'Mimix
    'Member since 06-20-2007
    'Posts 1
    'I have a solution to this issue that is probably the cleanest I have seen.  I will allow you to make the fewest changes to your code and continue using the RowDeleting and RowDeleted events for the  GridView.
    'Currently when you build a command field for a delete button it will look something like this.

    ' <asp:CommandField ButtonType="Image" DeleteImageUrl="images/delete.gif" ShowDeleteButton="true"  />

    'By Changing the ButtonType to "Link" and modifying the DeleteText you will have the same delete image that works exactly like the Image Button Type but without the double firing event.  Here is the modified code.

    '<asp:CommandField ButtonType="Link" DeleteText="<img src='images/delete.gif' alt='Delete this' border='0' />" ShowDeleteButton="true" />

    'Additionally, I am constantly being asked about how to add a confirm dialog box to the delete button.  You can use the following code on the RowDataBound event to add the confirmation.

    ' If e.Row.RowType = DataControlRowType.DataRow Then
    '    Dim lnk As LinkButton = e.Row.Cells(1).Controls(0)
    '    lnk.OnClientClick = "if(!confirm('Are you sure you want to delete this?')) return false;"
    ' End If

    'I hope this helps!
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        ''Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(Session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, Session(SESSIONPRONTO_glbIdObraAsignadaUsuario))



        If Not IsPostBack Then 'es decir, si es la primera vez que se carga






            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////
            '    'PRIMERA CARGA
            '    'inicializacion de varibles y preparar pantalla
            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////


            Dim tempSelectedIndex As Integer

            If Not (Request.QueryString.Get("Id") Is Nothing) Or True Then
                Dim id = Convert.ToInt32(Request.QueryString.Get("Id"))
            End If


            BindTypeDropDown()
            ReBind()
            grillaIrreconocibles.SelectedIndex = tempSelectedIndex


            '    'TraerCuentaFFasociadaALaObra()

            '    'Debug.Print(Session("glbWebIdProveedor"))
            '    'If Not IsNumeric(Session("glbWebIdProveedor")) Then
            '    '    ResumenVisible(False)
            '    'Else
            '    '    'TraerResumenDeCuentaFF()
            '    '    Debug.Print(Session("glbWebIdProveedor"))
            '    '    BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor"))
            '    'End If

            '    Me.Title = "Comparativas"



            '    'si estás buscando el filtro, andá a PresupuestoManager.GetList
            '    If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
            '        HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            '    Else
            '        HFTipoFiltro.Value = ""
            '    End If

            '    ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
            'End If


            'If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            '    LinkAgregarRenglon.Enabled = False
            'Else
            '    LinkAgregarRenglon.Enabled = True


        End If


        Permisos()
    End Sub



    Private Sub BindTypeDropDown()


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0
        cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
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
        Return

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "Destinos")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            grillaIrreconocibles.Visible = False
            grillaIrreconocibles.BottomPagerRow.Enabled = False
            MsgBoxAjax(Me, "No tenes permisos de lectura")
        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            grillaIrreconocibles.Columns(1).Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            grillaIrreconocibles.Columns(5).Visible = False
        End If


    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    'BIND de combos
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub grillaIrreconocibles_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grillaIrreconocibles.RowDataBound
        'Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        'If (e.Row.RowType = DataControlRowType.DataRow) Then

        '    'Hago el bind de los controles para EDICION

        '    Dim cmbArticulo As DropDownList = e.Row.FindControl("cmbArticulo")

        '    If Not IsNothing(cmbArticulo) Then
        '        cmbArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
        '        cmbArticulo.DataTextField = "Titulo"
        '        cmbArticulo.DataValueField = "IdArticulo"
        '        cmbArticulo.DataBind()
        '        cmbArticulo.Items.Insert(0, New ListItem("", -1)) 'recorda que hay DOS combos (uno para alta y otro para edicion)


        '        'cmbType.DataSource = .FetchCustomerType()
        '        'cmbType.DataBind()
        '        'cmbType.SelectedValue = grillaIrreconocibles.DataKeys(e.Row.RowIndex).Values(1).ToString()






        '    End If




        '    Dim cmbProvincia As DropDownList = e.Row.FindControl("cmbProvincia") 'por qué tengo que preguntar si no es nothing? no se supone que todos los renglones tienen el control en la template?

        '    If Not IsNothing(cmbProvincia) Then
        '        cmbProvincia.DataSource = EntidadManager.GetListCombo(HFSC.Value, "Provincias")
        '        cmbProvincia.DataTextField = "Titulo"
        '        cmbProvincia.DataValueField = "IdProvincia"
        '        cmbProvincia.DataBind()
        '        cmbProvincia.Items.Insert(0, New ListItem("", -1))

        '        BuscaTextoEnCombo(cmbProvincia, CStr(DirectCast(grillaIrreconocibles.DataSource, DataView).Table.Rows(e.Row.RowIndex).Item("Provincia").ToString()))

        '    End If


        '    ac = e.Row.FindControl("AutoCompleteExtender21")
        '    If Not IsNothing(ac) Then ac.ContextKey = HFSC.Value
        '    ac = e.Row.FindControl("AutoCompleteExtender22")
        '    If Not IsNothing(ac) Then ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender23")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender24")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender25")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender26")
        '    'ac.ContextKey = HFSC.Value
        '    ac = e.Row.FindControl("AutoCompleteExtender27")
        '    If Not IsNothing(ac) Then ac.ContextKey = HFSC.Value



        'End If





        'If (e.Row.RowType = DataControlRowType.Footer) Then

        '    'Hago el bind de los controles para ALTA

        '    'Dim cmbNewArticulo As DropDownList = e.Row.FindControl("cmbNewArticulo")
        '    'cmbNewArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
        '    'cmbNewArticulo.DataTextField = "Titulo"
        '    'cmbNewArticulo.DataValueField = "IdArticulo"
        '    'cmbNewArticulo.DataBind()
        '    'cmbNewArticulo.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)
        '    ''cmbNewType.DataSource = .FetchCustomerType()
        '    ''cmbNewType.DataBind()



        '    'Hago el bind de los controles para ALTA

        '    Dim cmbNewProvincia As DropDownList = e.Row.FindControl("cmbNewProvincia")
        '    cmbNewProvincia.DataSource = EntidadManager.GetListCombo(HFSC.Value, "Provincias")
        '    cmbNewProvincia.DataTextField = "Titulo"
        '    cmbNewProvincia.DataValueField = "IdProvincia"
        '    cmbNewProvincia.DataBind()
        '    cmbNewProvincia.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)



        '    ac = e.Row.FindControl("AutoCompleteExtender1")
        '    ac.ContextKey = HFSC.Value
        '    ac = e.Row.FindControl("AutoCompleteExtender2")
        '    ac.ContextKey = HFSC.Value
        '    ac = e.Row.FindControl("AutoCompleteExtender7")
        '    ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender3")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender4")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender5")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender6")
        '    'ac.ContextKey = HFSC.Value
        '    'ac = e.Row.FindControl("AutoCompleteExtender7")
        '    'ac.ContextKey = HFSC.Value

        'End If

    End Sub

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
        ReBind()
        'grillaIrreconocibles.databind()

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
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub

    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub grillaIrreconocibles_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grillaIrreconocibles.PageIndexChanging
        grillaIrreconocibles.PageIndex = e.NewPageIndex
        ReBind()
    End Sub


    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

    Protected Sub grillaIrreconocibles_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grillaIrreconocibles.RowCommand
        If (e.CommandName.Equals("Excel")) Then
            Dim renglon = Convert.ToInt32(e.CommandArgument)
            Dim Entregador As Label = grillaIrreconocibles.Rows(renglon).FindControl("lblEntregador")
            'Dim cmbNewGender As DropDownList = grillaIrreconocibles.FooterRow.FindControl("cmbNewGender")
            'Dim txtNewCity As TextBox = grillaIrreconocibles.FooterRow.FindControl("txtNewCity")
            'Dim txtNewState As TextBox = grillaIrreconocibles.FooterRow.FindControl("txtNewState")
            'Dim cmbNewType As DropDownList = grillaIrreconocibles.FooterRow.FindControl("cmbNewType")
            'Dim txtNewEntregador As TextBox = grillaIrreconocibles.FooterRow.FindControl("txtNewEntregador")

            Dim output As String
            'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, HFSC.Value), Nothing)

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

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

        ElseIf (e.CommandName.Equals("AddNew")) Then
            'Se hace un alta en la grilla 
            '(si se está llamando dos veces, fijate que la funcion no esté vinculada al evento 
            'tanto con el Handles como con el OnRowCommand del markup)

            Dim r As GridViewRow
            r = grillaIrreconocibles.FooterRow
            With r

                If TextoWebControl(.FindControl("txtNewDescripcion")) = "" Then
                    MsgBoxAjax(Me, "Ingrese una descripcion")
                    Return
                End If

                'Metodo con datatable
                Dim dt = TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow
                dr.Item("Descripcion") = TextoWebControl(.FindControl("txtNewDescripcion"))
                dr.Item("Subcontratista1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewSubcontratista1")), HFSC.Value))
                dr.Item("Subcontratista2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewSubcontratista2")), HFSC.Value))
                dr.Item("CodigoONCAA") = TextoWebControl(.FindControl("txtNewCodigoONCAA"))
                dr.Item("CodigoWilliams") = TextoWebControl(.FindControl("txtNewCodigoWilliams"))
                dr.Item("CodigoLosGrobo") = TextoWebControl(.FindControl("txtNewCodigoLosGrobo"))
                dr.Item("CodigoYPF") = TextoWebControl(.FindControl("txtNewCodigoYPF"))
                dr.Item("CodigoPostal") = TextoWebControl(.FindControl("txtNewCodigoPostal"))
                dr.Item("CUIT") = TextoWebControl(.FindControl("txtNewCUIT"))


                dr.Item("IdLocalidad") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtNewLocalidad")), HFSC.Value))
                dr.Item("IdProvincia") = IdNull(CType(.FindControl("cmbNewProvincia"), DropDownList).SelectedValue)



                dt.Rows.Add(dr)

                Insert(HFSC.Value, dt)




                ''metodo con objetito
                'Dim o As New CDPMailFiltro
                'o.Emails = TextoWebControl(.FindControl("txtNewEmails")) 'txtEmails.Text
                'o.Vendedor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewVendedor")), HFSC.Value)
                'o.CuentaOrden1 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden1")), HFSC.Value)
                'o.CuentaOrden2 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden2")), HFSC.Value)
                'o.Corredor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCorredor")), HFSC.Value)
                'o.Entregador = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewEntregador")), HFSC.Value)
                'o.IdArticulo = CType(.FindControl("cmbNewArticulo"), DropDownList).SelectedValue

                'Insert(HFSC.Value, o)

            End With

            ReBind()

        End If

    End Sub


    Protected Sub grillaIrreconocibles_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles grillaIrreconocibles.RowUpdating
        'se aplican los cambios editados
        With grillaIrreconocibles.Rows(e.RowIndex)


            'Metodo con datatable
            Dim Id = grillaIrreconocibles.DataKeys(e.RowIndex).Values(0).ToString()
            Dim dt = TraerMetadata(HFSC.Value, Id)
            Dim dr = dt.Rows(0)

            dr.Item("Descripcion") = TextoWebControl(.FindControl("txtDescripcion"))
            dr.Item("Subcontratista1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtSubcontratista1")), HFSC.Value))
            dr.Item("Subcontratista2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtSubcontratista2")), HFSC.Value))
            dr.Item("CodigoONCAA") = TextoWebControl(.FindControl("txtCodigoONCAA"))
            dr.Item("CodigoWilliams") = TextoWebControl(.FindControl("txtCodigoWilliams"))
            dr.Item("CodigoLosGrobo") = TextoWebControl(.FindControl("txtCodigoLosGrobo"))
            dr.Item("CodigoYPF") = TextoWebControl(.FindControl("txtCodigoYPF"))
            dr.Item("CodigoPostal") = TextoWebControl(.FindControl("txtCodigoPostal"))
            dr.Item("CUIT") = TextoWebControl(.FindControl("txtCUIT"))


            dr.Item("IdLocalidad") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtLocalidad")), HFSC.Value))
            dr.Item("IdProvincia") = IdNull(CType(.FindControl("cmbProvincia"), DropDownList).SelectedValue)

            ' dr.Item("IdProvincia") = TextoWebControl(.FindControl("txtCUIT"))
            ' dr.Item("IdLocalidadEquivalente") = TextoWebControl(.FindControl("txtCUIT"))



            Update(HFSC.Value, dt)







            ''metodo con objetito
            'Dim o As New CDPMailFiltro
            'o.Emails = TextoWebControl(.FindControl("txtEmails")) 'txtEmails.Text
            'o.Vendedor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtVendedor")), HFSC.Value)
            'o.CuentaOrden1 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden1")), HFSC.Value)
            'o.CuentaOrden2 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden2")), HFSC.Value)
            'o.Corredor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCorredor")), HFSC.Value)
            'o.Entregador = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtEntregador")), HFSC.Value)
            'o.IdArticulo = CType(.FindControl("cmbArticulo"), DropDownList).SelectedValue

            'Update(HFSC.Value, grillaIrreconocibles.DataKeys(e.RowIndex).Values(0).ToString(), o.Emails, o.Entregador, o.IdArticulo)
        End With

        grillaIrreconocibles.EditIndex = -1
        ReBind() 'hay que volver a pedir los datos...

    End Sub

    Protected Sub grillaIrreconocibles_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles grillaIrreconocibles.RowEditing
        'se empieza a editar un renglon
        grillaIrreconocibles.EditIndex = e.NewEditIndex
        ReBind() 'hay que volver a pedir los datos...
    End Sub

    Protected Sub grillaIrreconocibles_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles grillaIrreconocibles.RowCancelingEdit
        'se cancelan los datos editados
        grillaIrreconocibles.EditIndex = -1
        ReBind() 'hay que volver a pedir los datos...
    End Sub


    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    Function TextoWebControl(ByVal c As WebControl) As String
        Try
            Select Case c.GetType.Name
                Case "Label"
                    Return CType(c, WebControls.Label).Text
                Case "DropDownList"
                    Return CType(c, WebControls.DropDownList).Text
                Case "TextBox"
                    Return CType(c, WebControls.TextBox).Text
                Case Else
                    Return Nothing
            End Select
        Catch ex As Exception
            'Tiene que explotar, para advertir que se le pasó un control invalido
        End Try

    End Function


    Function renglonControl(ByVal r As GridViewRow, ByVal sHeader As String) As WebControls.Label ' WebControls.TextBox
        If getGridIDcolbyHeader(sHeader, grillaIrreconocibles) = -1 Then Return New WebControls.Label 'si devuelvo Nothing para que no explote 

        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, grillaIrreconocibles)).Controls(1), WebControls.Label)
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal sHeader As String) As String
        If getGridIDcolbyHeader(sHeader, grillaIrreconocibles) = -1 Then Return Nothing

        'Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView2)).Controls(1), WebControls.TextBox).Text()
        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, grillaIrreconocibles)).Controls(1), WebControls.Label).Text()
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal col As Integer) As String
        Return CType(r.Cells(col).Controls(1), WebControls.TextBox).Text()
    End Function
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////



    Protected Sub grillaIrreconocibles_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grillaIrreconocibles.RowDeleting
        CDPDestinosManager.Delete(HFSC.Value, grillaIrreconocibles.DataKeys(e.RowIndex).Values(0).ToString())
        ReBind()
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////


    Private Sub ReBind()

        Dim puntoventa As String = ""
        If cmbPuntoVenta.SelectedValue > 0 Then puntoventa = " PV" & cmbPuntoVenta.SelectedValue.ToString


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'preseleccionar uno ya existente
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        Dim db As ProntoMVC.Data.Models.DemoProntoEntities =
                           New ProntoMVC.Data.Models.DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(HFSC.Value)))



        Dim DIRTEMP = DirApp() & "\Temp\"
        Dim DIRFTP = DirApp() & "\DataBackupear\"



        ErrHandler2.WriteError("grilla1")

        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        Dim aaa As List(Of ProntoMVC.Data.Models.CartasDePorteLogDeOCR) = ProntoFlexicapture.ClassFlexicapture.ExtraerListaDeImagenesIrreconocibles(DirApp, HFSC.Value).Where(Function(x) x.TextoAux1.Contains(puntoventa)).Take(50).ToList
        grillaIrreconocibles.DataSource = aaa
        grillaIrreconocibles.DataBind()



        ErrHandler2.WriteError("grilla2")

        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        Try

            '10 segundos aca

            Dim estado As String = ProntoFlexicapture.ClassFlexicapture.EstadoServicio()
            lblCantidad.Text = "0 cartas en cola.     Estado del servicio: " & estado

            Dim lista = ProntoFlexicapture.ClassFlexicapture.ExtraerListaDeImagenesQueNoHanSidoProcesadas(100, DirApp).ToList

            If lista Is Nothing Then
            Else
                lblCantidad.Text = lista.Count & " cartas en cola.     Estado del servicio: " & estado
                If lista.Count >= 100 Then lblCantidad.Text = " Más de 100 cartas en cola.     Estado del servicio: " & estado
                If estado = "Stopped" Then FileUpload1.Enabled = False Else FileUpload1.Enabled = True
            End If

            grillaEncoladas.DataSource = (From i In lista Where i.Contains(puntoventa) Select New With {.nombre = i.Substring(i.IndexOf("\Temp"))}).ToList
            grillaEncoladas.DataBind()



        Catch ex As Exception
            ErrHandler2.WriteError(ex)

        End Try

        ErrHandler2.WriteError("grilla3")


        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////

        '7     segs aca



si esta dormido, aca tarda banda


        Dim a As List(Of ProntoMVC.Data.Models.CartasDePorteLogDeOCR) = ProntoFlexicapture.ClassFlexicapture.ExtraerListaDeImagenesProcesadas(DirApp, HFSC.Value).ToList
        'And i.FechaModificacion > (DateAdd(DateInterval.Hour, -23, DateTime.Now)) 
        'From e In db.Empleados.Where(Function(x) i.IdUsuarioModifico = x.IdEmpleado).DefaultIfEmpty _
        Dim hh = (From i As ProntoMVC.Data.Models.CartasDePorteLogDeOCR In a
                    Where i.NumeroCarta < 900000000 And i.Observaciones = "" And i.TextoAux1.Contains(puntoventa) _
                  Select New With {
                            .IdCartaDePorte = i.IdCartaDePorte,
                            .NumeroCartaDePorte = i.NumeroCarta,
                            .FechaModificacion = i.Fecha,
                             .UsuarioModifico = i.TextoAux1
                    }).ToList
        grillaProcesadas.DataSource = hh
        grillaProcesadas.DataBind()
        'grillaProcesadas.Visible = False



        ErrHandler2.WriteError("grilla4")


        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////



        If True Then
            Pegatinas.Text = ""
            Dim lista = ProntoFlexicapture.ClassFlexicapture.BuscarExcelsGenerados(DirApp).ToList
            For Each i In lista

                'Dim q = i.IndexOf("\Temp\")
                Dim q = "\Temp\" + i

                'Dim archivo = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + i.Substring(q)
                Dim archivo = ConfigurationManager.AppSettings("UrlDominio") + q + "\ExportToXLS.xls"


                If archivo.ToLower.Contains("pegatinas\") Then Continue For
                If Not archivo.Contains(puntoventa) Then Continue For


                'HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority)                            + HttpRuntime.AppDomainAppVirtualPath

                Pegatinas.Text &= "<a href=""" & archivo & """>" & i & "</a>  <br/>"

            Next
        End If

        ErrHandler2.WriteError("grilla5")


    End Sub





    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////










    'Function generarNotasDeEntrega(ByVal FechaDesde As Date, ByVal FechaHasta As Date, ByVal PosicionODescarga As String, ByVal IdVendedor As Integer, ByVal CuentaOrden1 As Integer, ByVal CuentaOrden2 As Integer, ByVal Corredor As Integer, ByVal IdEntregador As Integer, ByVal IdArticulo As Integer) As String
    Function generarNotasDeEntrega(ByVal dr As DataRow) As String
        'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "Select * from CartasDePorte CDP where Entregador=" & IdEntregador)


        Dim strSQL = String.Format("SELECT  " & _
"      NumeroCartaDePorte   as  [C.Porte]  , " & _
"       FechaDescarga   as  Arribo , " & _
"        convert(char, Hora, 108)   as  Hora, " & _
"         Articulos.Descripcion as  Producto, " & _
"       Contrato  as  Contrato , " & _
"       NetoPto   as  [Kg.Proc.] , " & _
"       TaraPto   as  [Kg.Tara Proc.] , " & _
"       BrutoPto   as  [Kg.Bruto Proc.], " & _
"       BrutoFinal   as  [Kg.Bruto Desc.] , " & _
"       TaraFinal   as  [Kg.Tara Desc.] , " & _
"       NetoFinal   as  [Kg.Neto Desc.] , " & _
"       ''   as  [Kg.Dif.] , " & _
"         Humedad as  [H.%]	 , " & _
"         Merma as [Mer.Kg.] , " & _
"         Merma as Otras , " & _
"        NetoProc  as  [Kg.Netos] , " & _
"       CLIVEN.Razonsocial as   Titular  , " & _
"       CLICO1.Razonsocial as   Intermediario  , " & _
"       CLICO2.Razonsocial as   [R. Comercial]  , " & _
"       CLICOR.Nombre as    [Corredor ], " & _
"       CLIENT.Razonsocial  as  [Destinatario], " & _
"        Patente as  [Pat. Chasis] , " & _
"         Acoplado as [Pat. Acoplado] , " & _
"        TransportistaCUIT as [CUIT Transp.] , " & _
"         TRANS.RazonSocial as Trasportista , " & _
"         LOCDES.Descripcion   as  Destino , " & _
"        LOCORI.Nombre as    [Procedcia.] , " & _
"         NetoProc as   [Desc.], " & _
"         CDP.Observaciones  as  [Cal.-Observaciones], " & _
"         ChoferCuit as   [CUIT chofer], " & _
"         CHOF.Nombre as   Chofer, " & _
"         '' as  [Nro ONCA] , " & _
"         '' as   [Pta ONCA], " & _
"         '' as   Provincia, " & _
"         '' as   [Nro CAC]	, " & _
"          FechaVencimiento as  [Vencim.CP], " & _
"          '' as  [Emision CP], " & _
"          ''  as Sucursal, " & _
"          KmARecorrer as  Km, " & _
"          Tarifa as Tarifa, " & _
"           CTG as CTG " & _
                  " FROM CartasDePorte CDP " & _
                   " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
                   " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
                   " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
                   " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
                   " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
                   " LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista " & _
                   " LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer " & _
                   " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
                   " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " & _
                "")




        With dr

            Dim strWHERE = "    WHERE 1=1 " & _
    iisIdValido(.Item("Vendedor"), "           AND CDP.Vendedor = " & .Item("Vendedor"), "") & _
    iisIdValido(.Item("CuentaOrden1"), "         AND CDP.CuentaOrden1=" & .Item("CuentaOrden1"), "") & _
    iisIdValido(.Item("CuentaOrden2"), "         AND CDP.CuentaOrden2=" & .Item("CuentaOrden2"), "") & _
    iisIdValido(.Item("Corredor"), "             AND CDP.Corredor=" & .Item("Corredor"), "") & _
    iisIdValido(.Item("IdArticulo"), "           AND CDP.IdArticulo=" & .Item("IdArticulo"), "") & _
    iisIdValido(.Item("Entregador"), "         AND CDP.Entregador=" & .Item("Entregador"), "") & _
    IIf(iisNull(.Item("EsPosicion"), False), "  AND FechaDescarga IS NULL ", " AND NOT FechaDescarga IS NULL ") & _
            "                               AND FechaDeCarga Between '" & iisValidSqlDate(.Item("FechaDesde"), #1/1/1753#) & "' AND '" & iisValidSqlDate(.Item("FechaHasta"), #1/1/2100#) & "'"


            '        'Version con variables en lugar de datarow
            '        Dim strWHERE = "    WHERE 1=1 " & _
            'IIf(IdVendedor > 0, "           AND CDP.Vendedor = " & IdVendedor, "") & _
            'IIf(CuentaOrden1 > 0, "         AND CDP.CuentaOrden1=" & CuentaOrden1, "") & _
            'IIf(CuentaOrden2 > 0, "         AND CDP.CuentaOrden1=" & CuentaOrden2, "") & _
            'IIf(Corredor > 0, "             AND CDP.Corredor=" & Corredor, "") & _
            'IIf(IdArticulo > 0, "           AND CDP.IdArticulo=" & IdArticulo, "") & _
            'IIf(IdEntregador > 0, "         AND CDP.Entregador=" & IdEntregador, "") & _
            'IIf(PosicionODescarga <> "", "  AND NOT FechaDescarga IS NULL ", "") & _
            '"                               AND FechaDeCarga Between '" & FechaDesde & "' AND '" & FechaHasta & "'"


            strSQL += strWHERE
            Debug.Print(strWHERE)
        End With

        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQL)



        Return DataTableToExcel(dt, String.Format("DESCARGAS entre el {0} y el {1} {2}", _
                    formateaFecha(iisValidSqlDate(dr.Item("FechaDesde"), " primero ")), _
                     formateaFecha(iisValidSqlDate(dr.Item("FechaHasta"), " ultimo ")), _
                    IIf(IsNumeric(dr.Item("Entregador")), " para " & NombreCliente(HFSC.Value, dr.Item("Entregador")), "") _
                    ))
    End Function


    Function formateaFecha(ByVal s As Object) As String
        Try
            Return s.ToString("ddMMMyyyy")
        Catch ex As Exception
            Return s
        End Try
    End Function

    Function iisIdValido(ByVal IdAValidar As Object, Optional ByVal verdadero As Object = True, Optional ByVal falso As Object = False)
        Try
            If IdAValidar > 0 Then
                Return verdadero
            Else
                Return falso
            End If
        Catch ex As Exception
            Return falso
        End Try
    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Public Function DataTableToExcel(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String

        Dim vFileName As String = Path.GetTempFileName()
        'Dim vFileName As String = "c:\archivo.txt"
        FileOpen(1, vFileName, OpenMode.Output)
        Dim sb As String = ""
        Dim dc As DataColumn
        For Each dc In pDataTable.Columns
            sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
        Next
        PrintLine(1, sb)
        Dim i As Integer = 0
        Dim dr As DataRow
        For Each dr In pDataTable.Rows
            i = 0 : sb = ""
            For Each dc In pDataTable.Columns
                If Not IsDBNull(dr(i)) Then
                    Try
                        If IsNumeric(dr(i)) Then
                            sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        Else
                            sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        End If
                    Catch x As Exception
                        sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    End Try
                Else
                    sb &= Microsoft.VisualBasic.ControlChars.Tab
                End If
                i += 1
            Next
            PrintLine(1, sb)
        Next


        FileClose(1)



        Return TextToExcel(vFileName, titulo)
    End Function

    Public Function TextToExcel(ByVal pFileName As String, Optional ByVal titulo As String = "") As String

        Dim vFormato As ExcelOffice.XlRangeAutoFormat
        Dim Exc As ExcelOffice.Application = CreateObject("Excel.Application")
        Exc.Visible = False
        Exc.DisplayAlerts = False

        'importa el archivo de texto
        Exc.Workbooks.OpenText(pFileName, , , , ExcelOffice.XlTextQualifier.xlTextQualifierNone, , True)

        Dim Wb As ExcelOffice.Workbook = Exc.ActiveWorkbook
        Dim Ws As ExcelOffice.Worksheet = CType(Wb.ActiveSheet, ExcelOffice.Worksheet)


        'Se le indica el formato al que queremos exportarlo
        Dim valor As Integer = 10

        If valor > -1 Then
            Select Case (valor)
                Case 10 : vFormato = ExcelOffice.XlRangeAutoFormat.xlRangeAutoFormatClassic1
            End Select
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(Ws.UsedRange.Rows.Count, Ws.UsedRange.Columns.Count)).AutoFormat(vFormato) 'le hace autoformato

            'insertar totales
            Dim filas = Ws.UsedRange.Rows.Count
            Ws.Cells(filas + 1, "E") = "TOTAL:"
            Ws.Cells(filas + 1, "F") = Exc.WorksheetFunction.Sum(Ws.Range("F2:F" & filas))
            Ws.Cells(filas + 1, "G") = Exc.WorksheetFunction.Sum(Ws.Range("G2:G" & filas))
            Ws.Cells(filas + 1, "H") = Exc.WorksheetFunction.Sum(Ws.Range("H2:H" & filas))
            Ws.Cells(filas + 1, "I") = Exc.WorksheetFunction.Sum(Ws.Range("I2:I" & filas))
            Ws.Cells(filas + 1, "J") = Exc.WorksheetFunction.Sum(Ws.Range("J2:J" & filas))
            Ws.Cells(filas + 1, "K") = Exc.WorksheetFunction.Sum(Ws.Range("K2:K" & filas))
            Ws.Cells(filas + 1, "N") = Exc.WorksheetFunction.Sum(Ws.Range("N2:N" & filas))
            Ws.Cells(filas + 1, "O") = Exc.WorksheetFunction.Sum(Ws.Range("O2:O" & filas))
            Ws.Cells(filas + 1, "P") = Exc.WorksheetFunction.Sum(Ws.Range("P2:P" & filas))


            '/////////////////////////////////
            'muevo la planilla formateada para tener un espacio arriba
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(filas + 2, Ws.UsedRange.Columns.Count)).Cut(Ws.Cells(10, 1))

            '/////////////////////////////////
            'poner tambien el filtro que se usó para hacer el informe
            Ws.Cells(7, 1) = titulo

            '/////////////////////////////////
            'insertar la imagen 
            'System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/Williams.bmp")  
            'Ws.Pictures.Insert("~/Imagenes/Williams.bmp")
            Dim imag = Ws.Pictures.Insert(Server.MapPath("~/Imagenes/Williams.bmp"))
            imag.Left = 1
            imag.top = 1

            '/////////////////////////////////
            'insertar link
            Dim rg As ExcelOffice.Range = Ws.Cells(3, 10)
            'rg.hip()
            'rg.Hyperlinks(1).Address = "www.williamsentregas.com.ar"
            'rg.Hyperlinks(1).TextToDisplay=
            Ws.Hyperlinks.Add(rg, "http:\\www.williamsentregas.com.ar", , , "Visite: www.williamsentregas.com.ar y vea toda su información en linea!")
            'Ws.Cells(3, "K") = "=HYPERLINK(" & Chr(34) & "www.williamsentregas.com.ar " & Chr(34) & ", ""Visite: www.williamsentregas.com.ar y vea toda su información en linea!"" )"








            '/////////////////////////////////
            '/////////////////////////////////

            'Usando un GUID
            'pFileName = System.IO.Path.GetTempPath() + Guid.NewGuid().ToString() + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Usando la hora
            pFileName = System.IO.Path.GetTempPath() + "Notas de Entrega " + Now.ToString("ddMMMyyyy_HHmmss") + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            '/////////////////////////////////

            'pFileName = Path.GetTempFileName  'tambien puede ser .GetRandomFileName
            'pFileName = Path.GetTempFileName.Replace("tmp", "xls")
            'problemas con el acceso del proceso al archivo? http://www.eggheadcafe.com/software/aspnet/34067727/file-cannot-be-accessed-b.aspx
            'pFileName = "C:\Archivo.xls"
            'File.Delete(pFileName) 'si no borro, va a aparecer el cartelote de sobreescribir. entonces necesito el .DisplayAlerts = False

            Exc.ActiveWorkbook.SaveAs(pFileName, ExcelOffice.XlTextQualifier.xlTextQualifierNone - 1, )
        End If


        'Exc.Quit()
        'Wb = Nothing
        'Exc = Nothing

        If Not Wb Is Nothing Then Wb.Close(False)
        NAR(Wb)
        'Wbs.Close()
        'NAR(Wbs)
        'quit and dispose app
        Exc.Quit()
        NAR(Exc)

        Ws = Nothing


        GC.Collect()
        'If valor > -1 Then
        '    Dim p As System.Diagnostics.Process = New System.Diagnostics.Process
        '    p.EnableRaisingEvents = False
        '    'System.Diagnostics.Process.Start(pFileName) 'para qué hace esto?
        'End If
        Return pFileName
    End Function






    Protected Sub Button1_Click(sender As Object, e As EventArgs)

        'http://stackoverflow.com/questions/2241545/how-to-correctly-use-the-asp-net-fileupload-control

        If Not Me.FileUpload1.HasFile Then Return

        '(cmbFormatoMultipagina.Text = "CP-TK")

        Dim DIRTEMP As String = System.IO.Path.GetTempPath()
        Dim destarchivo = DIRTEMP + Me.FileUpload1.FileName

        Me.FileUpload1.SaveAs(destarchivo)

        Dim pv As Integer = IIf(cmbPuntoVenta.SelectedValue > 0, cmbPuntoVenta.SelectedValue, 1)
        If InStr(destarchivo, ".zip") Then
            'zip

            'AdjuntarImagenEnZip2(HFSC.Value, destarchivo, DirApp)
            'Dim archivos As Generic.List(Of String) = Extraer(destarchivo, nuevosubdir)
            ProntoFlexicapture.ClassFlexicapture.PreprocesarArchivoSubido(destarchivo, Session(SESSIONPRONTO_UserName), DirApp, _
                                                                         True, False, True, pv)


        ElseIf InStr(destarchivo, ".rar") Then
            'rar

            MsgBoxAjax(Me, "No se aceptan archivos RAR. Convertilo en un ZIP")
        Else
            'archivo simple
            ProntoFlexicapture.ClassFlexicapture.PreprocesarArchivoSubido(destarchivo, Session(SESSIONPRONTO_UserName), DirApp, True, False, True, pv)

        End If


        'poner carterlote de que se subió bien
        MsgBoxAjaxAndRedirect(Me, "Archivo subido con éxito", "CartasDePorteReasignarImagenListado.aspx")
        'Response.Redirect("CartasDePorteReasignarImagenListado.aspx")

    End Sub


    Protected Sub Button6_Click(sender As Object, e As EventArgs)

        'http://stackoverflow.com/questions/2241545/how-to-correctly-use-the-asp-net-fileupload-control

        If Not Me.FileUpload1.HasFile Then Return


        Dim DIRTEMP As String = System.IO.Path.GetTempPath()
        Dim destarchivo = DIRTEMP + Me.FileUpload1.FileName

        Me.FileUpload1.SaveAs(destarchivo)

        Dim pv As Integer = IIf(cmbPuntoVenta.SelectedValue > 0, cmbPuntoVenta.SelectedValue, 1)
        If InStr(destarchivo, ".zip") Then
            'zip

            'AdjuntarImagenEnZip2(HFSC.Value, destarchivo, DirApp)
            'Dim archivos As Generic.List(Of String) = Extraer(destarchivo, nuevosubdir)
            ProntoFlexicapture.ClassFlexicapture.PreprocesarArchivoSubido(destarchivo, Session(SESSIONPRONTO_UserName), DirApp, _
                                                                          False, False, True, pv)


        ElseIf InStr(destarchivo, ".rar") Then
            'rar

            MsgBoxAjax(Me, "No se aceptan archivos RAR. Convertilo en un ZIP")
        Else
            'archivo simple
            ProntoFlexicapture.ClassFlexicapture.PreprocesarArchivoSubido(destarchivo, Session(SESSIONPRONTO_UserName), DirApp, False, False, True, pv)

        End If


        'poner carterlote de que se subió bien
        MsgBoxAjaxAndRedirect(Me, "Archivo subido con éxito", "CartasDePorteReasignarImagenListado.aspx")
        'Response.Redirect("CartasDePorteReasignarImagenListado.aspx")

    End Sub

    Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click
        ReBind()
    End Sub

    Protected Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click

        Dim output As String = DirApp() + "\Temp\FCEExport\ExportToXLS.xls"
        'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, HFSC.Value), Nothing)

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

    Protected Sub Button5_Click(sender As Object, e As EventArgs) Handles Button5.Click
        ' http://stackoverflow.com/questions/818512/how-to-start-stop-a-windows-service-from-an-asp-net-app-security-issues?rq='



    End Sub

    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click

    End Sub
End Class











'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




