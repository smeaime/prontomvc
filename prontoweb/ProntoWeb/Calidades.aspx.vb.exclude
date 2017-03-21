Imports Pronto.ERP.Bll

Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo
Imports CalidadesManager 'como la capa de negocios la tengo acá para debuguear en tiempo de ejecucion, la importo desde acá

Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá


Imports CartaDePorteManager


'    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

Partial Class Calidades
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
        HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))



        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            ReBind()

            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////
            '    'PRIMERA CARGA
            '    'inicializacion de varibles y preparar pantalla
            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////

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


    End Sub


    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        ReBind()
    End Sub
    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        ''ObjectDataSource1.filterparameters.clear()
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

    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    'BIND de combos
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        If (e.Row.RowType = DataControlRowType.DataRow) Then

            'Hago el bind de los controles para EDICION

            Dim cmbArticulo As DropDownList = e.Row.FindControl("cmbArticulo")

            If Not IsNothing(cmbArticulo) Then
                cmbArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
                cmbArticulo.DataTextField = "Titulo"
                cmbArticulo.DataValueField = "IdArticulo"
                cmbArticulo.DataBind()
                cmbArticulo.Items.Insert(0, New ListItem("", -1)) 'recorda que hay DOS combos (uno para alta y otro para edicion)


                'cmbType.DataSource = .FetchCustomerType()
                'cmbType.DataBind()
                'cmbType.SelectedValue = GridView1.DataKeys(e.Row.RowIndex).Values(1).ToString()






                ac = e.Row.FindControl("AutoCompleteExtender21")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender22")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender23")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender24")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender25")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender26")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender27")
                ac.ContextKey = HFSC.Value

            End If



        End If


        If (e.Row.RowType = DataControlRowType.Footer) Then

            'Hago el bind de los controles para ALTA

            'Dim cmbNewArticulo As DropDownList = e.Row.FindControl("cmbNewArticulo")
            'cmbNewArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
            'cmbNewArticulo.DataTextField = "Titulo"
            'cmbNewArticulo.DataValueField = "IdArticulo"
            'cmbNewArticulo.DataBind()
            'cmbNewArticulo.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)



            'ac = e.Row.FindControl("AutoCompleteExtender1")
            'ac.ContextKey = HFSC.Value
            'ac = e.Row.FindControl("AutoCompleteExtender2")
            'ac.ContextKey = HFSC.Value
            'ac = e.Row.FindControl("AutoCompleteExtender3")
            'ac.ContextKey = HFSC.Value
            'ac = e.Row.FindControl("AutoCompleteExtender4")
            'ac.ContextKey = HFSC.Value
            'ac = e.Row.FindControl("AutoCompleteExtender5")
            'ac.ContextKey = HFSC.Value
            'ac = e.Row.FindControl("AutoCompleteExtender6")
            'ac.ContextKey = HFSC.Value
            'ac = e.Row.FindControl("AutoCompleteExtender7")
            'ac.ContextKey = HFSC.Value

        End If

    End Sub


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


    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If (e.CommandName.Equals("Excel")) Then
            Dim renglon = Convert.ToInt32(e.CommandArgument)
            Dim Entregador As Label = GridView1.Rows(renglon).FindControl("lblEntregador")
            'Dim cmbNewGender As DropDownList = GridView1.FooterRow.FindControl("cmbNewGender")
            'Dim txtNewCity As TextBox = GridView1.FooterRow.FindControl("txtNewCity")
            'Dim txtNewState As TextBox = GridView1.FooterRow.FindControl("txtNewState")
            'Dim cmbNewType As DropDownList = GridView1.FooterRow.FindControl("cmbNewType")
            'Dim txtNewEntregador As TextBox = GridView1.FooterRow.FindControl("txtNewEntregador")

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
            r = GridView1.FooterRow
            With r

                If TextoWebControl(.FindControl("txtNewCalidad")) = "" Then
                    MsgBoxAjax(Me, "Ingrese una descripcion")
                    Return
                End If

                'Metodo con datatable
                Dim dt = TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow
                dr.Item("Descripcion") = TextoWebControl(.FindControl("txtNewCalidad"))
                'dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewVendedor")), HFSC.Value))
                'dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden1")), HFSC.Value))
                'dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden2")), HFSC.Value))
                'dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(TextoWebControl(.FindControl("txtNewCorredor")), HFSC.Value))
                'dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewEntregador")), HFSC.Value))
                'dr.Item("Destino") = IdNull(BuscaIdWilliamsDestino(TextoWebControl(.FindControl("txtNewDestino")), HFSC.Value))
                'dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtNewProcedencia")), HFSC.Value))

                'dr.Item("FechaDesde") = iisValidSqlDate(TextoWebControl(.FindControl("txtNewFechaDesde")), DBNull.Value)
                'dr.Item("FechaHasta") = iisValidSqlDate(TextoWebControl(.FindControl("txtNewFechaHasta")), DBNull.Value)


                'dr.Item("Modo") = TextoWebControl(.FindControl("cmbNewModo"))
                'dr.Item("Orden") = Val(TextoWebControl(.FindControl("txtNewOrden")))
                'dr.Item("Contrato") = Val(TextoWebControl(.FindControl("txtNewContrato")))

                'dr.Item("EsPosicion") = (TextoWebControl(.FindControl("cmbNewPosicion")) = "Posicion")
                'dr.Item("IdArticulo") = IdNull(CType(.FindControl("cmbNewArticulo"), DropDownList).SelectedValue)
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


    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        'se aplican los cambios editados
        With GridView1.Rows(e.RowIndex)


            'Metodo con datatable
            Dim Id = GridView1.DataKeys(e.RowIndex).Values(0).ToString()
            Dim dt = TraerMetadata(HFSC.Value, Id)
            Dim dr = dt.Rows(0)

            dr.Item("Descripcion") = TextoWebControl(.FindControl("txtCalidad"))
            'dr.Item("Orden") = Val(TextoWebControl(.FindControl("txtOrden")))
            'dr.Item("Contrato") = Val(TextoWebControl(.FindControl("txtContrato")))

            'dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtVendedor")), HFSC.Value))
            'dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden1")), HFSC.Value))
            'dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden2")), HFSC.Value))
            'dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(TextoWebControl(.FindControl("txtCorredor")), HFSC.Value))
            'dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtEntregador")), HFSC.Value))
            'dr.Item("Destino") = IdNull(BuscaIdWilliamsDestino(TextoWebControl(.FindControl("txtDestino")), HFSC.Value))
            'dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtProcedencia")), HFSC.Value))

            'dr.Item("FechaDesde") = iisValidSqlDate(TextoWebControl(.FindControl("txtFechaDesde")), DBNull.Value)
            'dr.Item("FechaHasta") = iisValidSqlDate(TextoWebControl(.FindControl("txtFechaHasta")), DBNull.Value)

            'dr.Item("Modo") = TextoWebControl(.FindControl("cmbModo")) 'CType(.FindControl("cmbModo"), DropDownList).SelectedValue
            'dr.Item("EsPosicion") = (TextoWebControl(.FindControl("cmbPosicion")) = "Posicion")
            'dr.Item("IdArticulo") = IdNull(CType(.FindControl("cmbArticulo"), DropDownList).SelectedValue)

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

            'Update(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString(), o.Emails, o.Entregador, o.IdArticulo)
        End With

        GridView1.EditIndex = -1
        ReBind() 'hay que volver a pedir los datos...

    End Sub

    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        'se empieza a editar un renglon
        GridView1.EditIndex = e.NewEditIndex
        ReBind() 'hay que volver a pedir los datos...
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        'se cancelan los datos editados
        GridView1.EditIndex = -1
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
        If getGridIDcolbyHeader(sHeader, GridView1) = -1 Then Return New WebControls.Label 'si devuelvo Nothing para que no explote 

        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView1)).Controls(1), WebControls.Label)
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal sHeader As String) As String
        If getGridIDcolbyHeader(sHeader, GridView1) = -1 Then Return Nothing

        'Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView2)).Controls(1), WebControls.TextBox).Text()
        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView1)).Controls(1), WebControls.Label).Text()
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal col As Integer) As String
        Return CType(r.Cells(col).Controls(1), WebControls.TextBox).Text()
    End Function
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////



    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        CalidadesManager.Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString())
        ReBind()
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////


    Private Sub ReBind()
        Dim dtCustomer = Fetch(HFSC.Value)
        Dim dv As DataView = New DataView(dtCustomer, GenerarWHERE(), "", DataViewRowState.OriginalRows)

        If dtCustomer.Rows.Count > 0 Then
            'GridView1.DataSource = dtCustomer
            GridView1.DataSource = dv
            GridView1.DataBind()
        Else
            'la grilla está vacia. Creo un renglon nuevo para el alta y un cartel de aviso
            dtCustomer.Rows.Add(dtCustomer.NewRow())
            GridView1.DataSource = dtCustomer
            GridView1.DataBind()

            Dim TotalColumns = GridView1.Rows(0).Cells.Count
            GridView1.Rows(0).Cells.Clear()
            GridView1.Rows(0).Cells.Add(New TableCell())
            GridView1.Rows(0).Cells(0).ColumnSpan = TotalColumns
            GridView1.Rows(0).Cells(0).Text = "No Record Found"
        End If
    End Sub





    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////




    





   


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


    

    






    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        ReBind()
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
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
'/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






<Serializable()> Public Class Calidad
    Public Descripcion As String
    Public Emails As String

    Public FechaDesde As Date
    Public FechaHasta As Date

    Public EsPosicion As String

    Public Enviar As String
    Public EsMailOesFax As String

    Public Orden As Integer
    Public Modo As String

    Public AplicarANDuORalFiltro As String
    Public Vendedor As Integer
    Public CuentaOrden1 As Integer
    Public CuentaOrden2 As Integer
    Public Corredor As Integer
    Public Entregador As Integer

    Public IdArticulo As Integer
    Public Contrato As Integer

    Public Destino As Integer
    Public Procedencia As Integer
End Class

Public Class CalidadesManager

    Const Tabla = "Calidades"
    Const IdTabla = "IdCalidad"

    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx


    Public Shared Function TraerMetadata(ByVal SC As String, Optional ByVal id As Integer = -1) As DataTable
        If id = -1 Then
            Return ExecDinamico(SC, "select * from " & Tabla & " where 1=0")
        Else
            Return ExecDinamico(SC, "select * from " & Tabla & " where " & IdTabla & "=" & id)
        End If
    End Function

    Public Shared Function Insert(ByVal SC As String, ByVal dt As DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        adapterForTable1.Update(dt)

    End Function








    Public Shared Function Fetch(ByVal SC As String) As DataTable

        Return ExecDinamico(SC, String.Format("SELECT IdCalidad, Descripcion " & _
                            " FROM " & Tabla & " CDP " & _
                                        ""))

    End Function


    Public Shared Function Update(ByVal SC As String, ByVal dt As DataTable) As Integer
        '// Write your own Insert statement blocks 


        'ver cómo trabaja el commandBuilder   http://msdn.microsoft.com/en-us/library/4czb85fz(vs.71).aspx
        ' acá uno más complejo para maestro+detalle http://www.codeproject.com/KB/database/relationaladonet.aspx
        'y esto? http://www.vbforums.com/showthread.php?t=352219


        ''convertir datarow en datatable
        'Dim ds As New DataSet
        'ds.Tables.Add(dr.Table.Clone())
        'ds.Tables(0).ImportRow(dr)

        Dim myConnection = New SqlConnection(encriptar(SC))
        myConnection.Open()

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla & "", myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        'si te tira error acá, ojito con estar usando el dataset q usaste para el 
        'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
        adapterForTable1.Update(dt)

    End Function



    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long)
        '// Write your own Delete statement blocks. 
        ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function


End Class
