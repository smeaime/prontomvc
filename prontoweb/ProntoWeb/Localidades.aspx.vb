Imports Pronto.ERP.Bll

Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports Excel = Microsoft.Office.Interop.Excel
Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo
Imports LocalidadesManager 'como la capa de negocios la tengo acá para debuguear en tiempo de ejecucion, la importo desde acá

Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá



Imports CartaDePorteManager

'    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

Partial Class Localidades
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
            

            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////
            '    'PRIMERA CARGA
            '    'inicializacion de varibles y preparar pantalla
            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////


            Dim tempSelectedIndex As Integer

            If Not (Request.QueryString.Get("Id") Is Nothing) Then
                Dim id = Convert.ToInt32(Request.QueryString.Get("Id"))



                '////////////////////////////////////////////
                '////////////////////////////////////////////
                '////////////////////////////////////////////
                'preseleccionar uno ya existente
                '////////////////////////////////////////////
                '////////////////////////////////////////////
                '////////////////////////////////////////////
                With GridView1


                    Dim dt = Fetch(HFSC.Value)
                    'dim pagina = dt.Rows.Find(id).  / .PageSize



                    'http://forums.asp.net/p/1255509/2332893.aspx
                    'Vince, after you insert a new record you populate the grid again, right?  
                    'When you call _manager.GetById(MyId) you will return a collection of objects. The grid will display 
                    'this collection in the order it is returned by your method. The code I gave you basically find's out which is the position of the inserted record in your collection then it will calculate in which page the record is located to then select it.

                    'le doy una primary key para poder usar el find
                    Dim keys(1) As DataColumn
                    keys(0) = dt.Columns(0)
                    dt.PrimaryKey = keys


                    Dim drc As DataRowCollection = dt.Rows

                    Dim dr As DataRow = drc.Find(id)

                    Dim index = drc.IndexOf(dr)

                    Dim Page As Integer = Int(index / .PageSize)

                    If .PageIndex <> Page Then .PageIndex = Page

                    'aparentemente, a diferencia del pageIndex, este lo tengo que asignar
                    'despues que hago el bind
                    tempSelectedIndex = index - (Page * .PageSize)

                End With
            End If

            ReBind()
            GridView1.SelectedIndex = tempSelectedIndex



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
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        ReBind()
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

        s += " AND ( " & _
                                   "Convert( Isnull(" & cmbBuscarEsteCampo.SelectedValue & ",''), 'System.String') LIKE '%" & txtBuscar.Text.Replace("'", "''") & "%' )" '_
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


    Sub ImportaCodigosONCAA()
        'Dim dtImportar = ExecDinamico(HFSC.Value, "SELECT * from Hoja1$")
        'Dim dtLocalidades = ExecDinamico(HFSC.Value, "SELECT * from Localidades")

        'For Each dr In dt.Rows


        '    LevenshteinDistance()

        'Next




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

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        If (e.Row.RowType = DataControlRowType.DataRow) Then

            'Hago el bind de los controles para EDICION

            Dim cmbProvincia As DropDownList = e.Row.FindControl("cmbProvincia") 'por qué tengo que preguntar si no es nothing? no se supone que todos los renglones tienen el control en la template?

            If Not IsNothing(cmbProvincia) Then
                cmbProvincia.DataSource = EntidadManager.GetListCombo(HFSC.Value, "Provincias")
                cmbProvincia.DataTextField = "Titulo"
                cmbProvincia.DataValueField = "IdProvincia"
                cmbProvincia.DataBind()
                cmbProvincia.Items.Insert(0, New ListItem("", -1))

                BuscaTextoEnCombo(cmbProvincia, CStr(DirectCast(GridView1.DataSource, DataView).Table.Rows(e.Row.RowIndex).Item("Provincia").ToString))
                'cmbType.DataSource = .FetchCustomerType()
                'cmbType.DataBind()
                '


                'ac = e.Row.FindControl("AutoCompleteExtender21")
                'ac.ContextKey = HFSC.Value
                'ac = e.Row.FindControl("AutoCompleteExtender22")
                'ac.ContextKey = HFSC.Value
                'ac = e.Row.FindControl("AutoCompleteExtender23")
                'ac.ContextKey = HFSC.Value
                'ac = e.Row.FindControl("AutoCompleteExtender24")
                'ac.ContextKey = HFSC.Value
                'ac = e.Row.FindControl("AutoCompleteExtender25")
                'ac.ContextKey = HFSC.Value
                'ac = e.Row.FindControl("AutoCompleteExtender26")
                'ac.ContextKey = HFSC.Value
                'ac = e.Row.FindControl("AutoCompleteExtender27")
                'ac.ContextKey = HFSC.Value

            End If


            Dim cmbPartido As DropDownList = e.Row.FindControl("cmbPartido") 'por qué tengo que preguntar si no es nothing? no se supone que todos los renglones tienen el control en la template?

            If Not IsNothing(cmbPartido) Then
                cmbPartido.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "select idpartido,nombre as Titulo from partidos")
                cmbPartido.DataTextField = "Titulo"
                cmbPartido.DataValueField = "idpartido"
                cmbPartido.DataBind()
                cmbPartido.Items.Insert(0, New ListItem("", -1))

                BuscaTextoEnCombo(cmbPartido, CStr(DirectCast(GridView1.DataSource, DataView).Table.Rows(e.Row.RowIndex).Item("Partido").ToString()))
            End If

        End If


        If (e.Row.RowType = DataControlRowType.Footer) Then

            'Hago el bind de los controles para ALTA

            Dim cmbNewProvincia As DropDownList = e.Row.FindControl("cmbNewProvincia")
            cmbNewProvincia.DataSource = EntidadManager.GetListCombo(HFSC.Value, "Provincias")
            cmbNewProvincia.DataTextField = "Titulo"
            cmbNewProvincia.DataValueField = "IdProvincia"
            cmbNewProvincia.DataBind()
            cmbNewProvincia.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)
            'cmbNewType.DataSource = .FetchCustomerType()
            'cmbNewType.DataBind()



            Dim cmbNewPartido As DropDownList = e.Row.FindControl("cmbNewPartido")
            cmbNewPartido.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "select idpartido,nombre as Titulo from partidos")
            cmbNewPartido.DataTextField = "Titulo"
            cmbNewPartido.DataValueField = "idpartido"
            cmbNewPartido.DataBind()
            cmbNewPartido.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)
            'cmbNewType.DataSource = .FetchCustomerType()
            'cmbNewType.DataBind()


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

                If TextoWebControl(.FindControl("txtNewLocalidad")) = "" Then
                    MsgBoxAjax(Me, "Ingrese un nombre")
                    Return
                End If

                'Metodo con datatable
                Dim dt = TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow

                Debug.Print(dr.Table.Columns(0).ColumnName)
                Debug.Print(dr.Table.Columns(0).ColumnName)

                dr.Item("Nombre") = TextoWebControl(.FindControl("txtNewLocalidad"))
                dr.Item("CodigoPostal") = TextoWebControl(.FindControl("txtNewCodigoPostal"))
                dr.Item("IdProvincia") = IdNull(CType(.FindControl("cmbNewProvincia"), DropDownList).SelectedValue)
                dr.Item("CodigoONCAA") = Val(TextoWebControl(.FindControl("txtNewCodigoONCAA")))
                dr.Item("CodigoWilliams") = TextoWebControl(.FindControl("txtNewCodigoWilliams"))
                dr.Item("CodigoLosGrobo") = TextoWebControl(.FindControl("txtNewCodigoLosGrobo"))

                dr.Item("CodigoAFIP") = Val(TextoWebControl(.FindControl("txtNewCodigoAFIP")))
                dr.Item("CodigoCGG") = Val(TextoWebControl(.FindControl("txtNewCodigoCGG")))



                'dr.Item("Partido") = TextoWebControl(.FindControl("txtNewPartido"))
                dr.Item("IdPartido") = IdNull(CType(.FindControl("cmbNewPartido"), DropDownList).SelectedValue)

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
            Dim dr = dt.rows(0)

            dr.Item("Nombre") = TextoWebControl(.FindControl("txtLocalidad"))
            dr.Item("CodigoPostal") = TextoWebControl(.FindControl("txtCodigoPostal"))
            dr.Item("IdProvincia") = IdNull(CType(.FindControl("cmbProvincia"), DropDownList).SelectedValue)
            dr.Item("CodigoONCAA") = Val(TextoWebControl(.FindControl("txtCodigoONCAA")))
            dr.Item("CodigoWilliams") = TextoWebControl(.FindControl("txtCodigoWilliams"))
            dr.Item("CodigoLosGrobo") = TextoWebControl(.FindControl("txtCodigoLosGrobo"))
            dr.Item("CodigoAFIP") = Val(TextoWebControl(.FindControl("txtCodigoAFIP")))
            dr.Item("CodigoCGG") = Val(TextoWebControl(.FindControl("txtCodigoCGG")))

            'dr.Item("Partido") = TextoWebControl(.FindControl("txtPartido"))
            dr.Item("IdPartido") = IdNull(CType(.FindControl("cmbPartido"), DropDownList).SelectedValue)


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


    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        ReBind()
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
        Try
            LocalidadesManager.Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString())
            ReBind()
        Catch sqlEx As SqlException When sqlEx.Number = 547  'handle foreign key violation(547)
            'http://forums.asp.net/t/555900.aspx
            'Do something about the exception
            MsgBoxAjax(Me, "La localidad está siendo usada") ' "La localidad está siendo usada")
            'Catch sqlEx as SqlException When sqlEx.Number = [Another SQL error number]
            'Do something about the exception
        Catch sqlEx As SqlException  'all other SQL exceptions
            'Do something about the exception
            MsgBoxAjax(Me, sqlex.ToString) ' "La localidad está siendo usada")
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString) ' "La localidad está siendo usada")
        End Try

        'If IsNothing()) Then
        '    'MsgBoxAlert("La localidad está siendo usada")
        '    MsgBoxAjax(Me, "La localidad está siendo usada")
        'Else
        '    ReBind()
        'End If
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////


    Private Sub ReBind()
        Dim dtCustomer = Fetch(HFSC.Value)
        Dim dv As DataView = New DataView(dtCustomer, GenerarWHERE(), "", DataViewRowState.OriginalRows)

        Try

            If dtCustomer.Rows.Count > 0 Then
                'GridView1.DataSource = dtCustomer
                GridView1.DataSource = dv

                GridView1.DataBind()
            Else
                ErrHandler2.WriteError("Vacia ")
                'MsgBoxAjax(Me, "Vacia")

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

        Catch ex As Exception
            ErrHandler2.WriteError("error en rebind " & ex.ToString & GenerarWHERE())
        End Try

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

        Dim vFormato As Excel.XlRangeAutoFormat
        Dim Exc As Excel.Application = CreateObject("Excel.Application")
        Exc.Visible = False
        Exc.DisplayAlerts = False

        'importa el archivo de texto
        Exc.Workbooks.OpenText(pFileName, , , , Excel.XlTextQualifier.xlTextQualifierNone, , True)

        Dim Wb As Excel.Workbook = Exc.ActiveWorkbook
        Dim Ws As Excel.Worksheet = CType(Wb.ActiveSheet, Excel.Worksheet)


        'Se le indica el formato al que queremos exportarlo
        Dim valor As Integer = 10

        If valor > -1 Then
            Select Case (valor)
                Case 10 : vFormato = Excel.XlRangeAutoFormat.xlRangeAutoFormatClassic1
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
            Dim rg As Excel.Range = Ws.Cells(3, 10)
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

            Exc.ActiveWorkbook.SaveAs(pFileName, Excel.XlTextQualifier.xlTextQualifierNone - 1, )
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






<Serializable()> Public Class Localidad
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

Public Class LocalidadesManager

    Const Tabla = "Localidades"
    Const IdTabla = "IdLocalidad"

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

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla, myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        adapterForTable1.Update(dt)

    End Function








    Public Shared Function Fetch(ByVal SC As String) As DataTable

        Return EntidadManager.ExecDinamico(SC, "wLocalidades_TT")


        'Return ExecDinamico(SC, String.Format("SELECT CDP.*, " & _
        '                    " CLIVEN.Razonsocial as VendedorDesc, " & _
        '                    " CLICO1.Razonsocial as CuentaOrden1Desc, " & _
        '                    " CLICO2.Razonsocial as CuentaOrden2Desc, " & _
        '                    " CLICOR.Nombre as CorredorDesc, " & _
        '                    " CLIENT.Razonsocial as EntregadorDesc, " & _
        '                    " Articulos.Descripcion as Producto, " & _
        '                    " LOCORI.Nombre as ProcedenciaDesc, " & _
        '                    " LOCDES.Descripcion as DestinoDesc " & _
        '                    " FROM " & Tabla & " CDP " & _
        '                    " LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente " & _
        '                    " LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente " & _
        '                    " LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente " & _
        '                    " LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor " & _
        '                    " LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente " & _
        '                    " LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo " & _
        '                    " LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad " & _
        '                    " LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino " _
        '                                ))

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

        Dim adapterForTable1 = New SqlDataAdapter("select * from " & Tabla, myConnection)
        Dim builderForTable1 = New SqlCommandBuilder(adapterForTable1)
        'si te tira error acá, ojito con estar usando el dataset q usaste para el 
        'insert. Mejor, luego del insert, llamá al Traer para actualizar los datos, y recien ahí llamar al update
        adapterForTable1.Update(dt)

    End Function



    Public Shared Function Delete(ByVal SC As String, ByVal Id As Long) As System.Data.DataTable
        '// Write your own Delete statement blocks. 
        Return ExecDinamico(SC, String.Format("DELETE  " & Tabla & "  WHERE {1}={0}", Id, IdTabla))
    End Function




End Class
