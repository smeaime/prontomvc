Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo
Imports Pronto.ERP.Bll.ListasPreciosManager 'como la capa de negocios la tengo acá para debuguear en tiempo de ejecucion, la importo desde acá

Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá


'    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

Imports CartaDePorteManager
Partial Class ListasPrecios
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

            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////

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
                With gvMaestro


                    Dim dt As DataTable = ListaPreciosManager.Fetch(HFSC.Value, txtBuscar.Text) ', 100)
                    dt = DataTableWHERE(dt, GenerarWHERE)


                    'dim pagina = dt.Rows.Find(id).  / .PageSize

                    'Dim dt = New DataView(dtaaa)


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
            gvMaestro.SelectedIndex = tempSelectedIndex
            rebindDetalle()
        End If

        lblAlerta.Text = ""


        Permisos()
    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "Listas de Precios")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            gvMaestro.Visible = False
            gvMaestro.BottomPagerRow.Enabled = False

        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            gvMaestro.Columns(0).Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            gvMaestro.Columns(4).Visible = False
        End If

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




    Protected Sub txtBuscarDetalleDestino_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscarDetalleDestino.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        rebindDetalle()
        'GridView1.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub
    Protected Sub txtBuscarDetalleArticulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscarDetalleArticulo.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        rebindDetalle()
        'GridView1.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
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

    Protected Sub gvDetalle_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvDetalle.RowDataBound
        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        If (e.Row.RowType = DataControlRowType.DataRow) Then
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            'Hago el bind de los controles para EDICION
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////

            Dim cmbArticulo As DropDownList = e.Row.FindControl("cmbArticulo")

            If Not IsNothing(cmbArticulo) Then
                cmbArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
                cmbArticulo.DataTextField = "Titulo"
                cmbArticulo.DataValueField = "IdArticulo"
                cmbArticulo.DataBind()
                cmbArticulo.Items.Insert(0, New ListItem("", -1)) 'recorda que hay DOS combos (uno para alta y otro para edicion)


                'a veces esta como dataview y otras como datatable...
                Dim prov As String
                If TypeOf (gvDetalle.DataSource) Is Data.DataTable Then
                    prov = iisNull(DirectCast(gvDetalle.DataSource, DataTable).Rows(e.Row.RowIndex).Item("Producto"))
                Else
                    prov = DirectCast(gvDetalle.DataSource, DataView).Table.Rows(e.Row.RowIndex).Item("Producto")
                End If
                BuscaTextoEnCombo(cmbArticulo, prov)



                If False Then

                    Dim cmbLista As DropDownList = e.Row.FindControl("cmbLista")
                    cmbLista.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "ListasPrecios_TL")
                    cmbLista.DataTextField = "Titulo"
                    cmbLista.DataValueField = "IdListaPrecios"
                    cmbLista.DataBind()
                    cmbLista.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)

                End If

                'Dim txtDestino As TextBox = e.Row.FindControl("txtDestino")
                'txt = IdNull(NombreDestino(TextoWebControl(.FindControl("txtDestino")), HFSC.Value))
                'Dim cmbDestino As DropDownList = e.Row.FindControl("cmbDestinoDeCartaDePorte")
                'cmbDestino.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
                'cmbDestino.DataTextField = "Titulo"
                'cmbDestino.DataValueField = "IdArticulo"
                'cmbDestino.DataBind()
                'cmbDestino.Items.Insert(0, New ListItem("", -1)) 'recorda que hay DOS combos (uno para alta y otro para edicion)


                'cmbType.DataSource = .FetchCustomerType()
                'cmbType.DataBind()
                'cmbType.SelectedValue = gvDetalle.DataKeys(e.Row.RowIndex).Values(1).ToString()




                ac = e.Row.FindControl("AutoCompleteExtender28")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender29")
                ac.ContextKey = HFSC.Value

            End If





        End If


        If (e.Row.RowType = DataControlRowType.Footer) Then

            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            'Hago el bind de los controles para ALTA
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////

            If False Then


                Dim cmbNewLista As DropDownList = e.Row.FindControl("cmbNewLista")
                cmbNewLista.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "ListasPrecios_TL")
                cmbNewLista.DataTextField = "Titulo"
                cmbNewLista.DataValueField = "IdListaPrecios"
                cmbNewLista.DataBind()
                cmbNewLista.Items.Insert(0, New ListItem("--Elija una lista--", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)
            End If


            Dim cmbNewArticulo As DropDownList = e.Row.FindControl("cmbNewArticulo")
            cmbNewArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
            cmbNewArticulo.DataTextField = "Titulo"
            cmbNewArticulo.DataValueField = "IdArticulo"
            cmbNewArticulo.DataBind()
            cmbNewArticulo.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)
            'cmbNewType.DataSource = .FetchCustomerType()
            'cmbNewType.DataBind()


            'Dim cmbDestino As DropDownList = e.Row.FindControl("cmbNewDestinoDeCartaDePorte")
            'cmbDestino.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
            'cmbDestino.DataTextField = "Titulo"
            'cmbDestino.DataValueField = "IdArticulo"
            'cmbDestino.DataBind()
            'cmbDestino.Items.Insert(0, New ListItem("", -1)) 'recorda que hay DOS combos (uno para alta y otro para edicion)

            ac = e.Row.FindControl("AutoCompleteExtender8")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender9")
            ac.ContextKey = HFSC.Value
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


    Protected Sub gvMaestro_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvMaestro.PageIndexChanging
        gvMaestro.PageIndex = e.NewPageIndex
        ReBind()
    End Sub

    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////


    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx




    Protected Sub gvMaestro_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvMaestro.RowCommand
        If (e.CommandName.Equals("AddNew")) Then
            'Se hace un alta en la grilla 
            '(si se está llamando dos veces, fijate que la funcion no esté vinculada al evento 
            'tanto con el Handles como con el OnRowCommand del markup)

            Dim r As GridViewRow
            r = gvMaestro.FooterRow
            With r

                'Metodo con datatable
                Dim dt = ListaPreciosManager.TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow

                Debug.Print(DebugGetDataTableColumnNames(dt))

                dr.Item("Descripcion") = TextoWebControl(.FindControl("txtNewDescripcion"))
                Try
                    dr.Item("FechaVigencia") = Convert.ToDateTime(TextoWebControl(.FindControl("txtNewFechaVigencia")))
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try

                'dr.Item("NumeroLista")=
                dr.Item("IdMoneda") = 1
                dr.Item("NumeroLista") = EntidadManager.ExecDinamico(HFSC.Value, "select top 1 NumeroLista from ListasPrecios order by NumeroLista DESC").Rows(0).Item(0) + 1


                dt.Rows.Add(dr)
                ListaPreciosManager.Insert(HFSC.Value, dt)
            End With

            ReBind()

        End If
    End Sub

    Protected Sub gvMaestro_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvMaestro.RowUpdating
        With gvMaestro.Rows(e.RowIndex)

            'Metodo con datatable
            Dim Id = gvMaestro.DataKeys(e.RowIndex).Values(0).ToString()
            Dim dt = ListaPreciosManager.TraerMetadata(HFSC.Value, Id)
            Dim dr = dt.Rows(0)

            dr.Item("Descripcion") = TextoWebControl(.FindControl("txtDescripcion"))
            Try
                dr.Item("FechaVigencia") = Convert.ToDateTime(TextoWebControl(.FindControl("txtFechaVigencia")))
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            'dr.Item("IdListaPrecios") = gvMaestro.SelectedDataKey.Value ' IdNull(CType(.FindControl("cmbLista"), DropDownList).SelectedValue)
            dr.Item("IdMoneda") = 1 'TextoWebControl(.FindControl("txtPrecio"))

            ListaPreciosManager.Update(HFSC.Value, dt)

        End With

        gvMaestro.EditIndex = -1
        ReBind()
    End Sub



    Protected Sub gvDetalle_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvDetalle.RowCommand
        If (e.CommandName.Equals("Excel")) Then
            Dim renglon = Convert.ToInt32(e.CommandArgument)
            Dim Entregador As Label = gvDetalle.Rows(renglon).FindControl("lblEntregador")
            'Dim cmbNewGender As DropDownList = gvDetalle.FooterRow.FindControl("cmbNewGender")
            'Dim txtNewCity As TextBox = gvDetalle.FooterRow.FindControl("txtNewCity")
            'Dim txtNewState As TextBox = gvDetalle.FooterRow.FindControl("txtNewState")
            'Dim cmbNewType As DropDownList = gvDetalle.FooterRow.FindControl("cmbNewType")
            'Dim txtNewEntregador As TextBox = gvDetalle.FooterRow.FindControl("txtNewEntregador")

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
            r = gvDetalle.FooterRow
            With r

                'Metodo con datatable
                Dim dt = ListasPreciosItemManager.TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow

                Debug.Print(DebugGetDataTableColumnNames(dt))

                dr.Item("IdArticulo") = IdNull(CType(.FindControl("cmbNewArticulo"), DropDownList).SelectedValue)
                dr.Item("IdListaPrecios") = gvMaestro.SelectedDataKey.Value  'IdNull(CType(.FindControl("cmbNewLista"), DropDownList).SelectedValue)
                dr.Item("Precio") = Val(TextoWebControl(.FindControl("txtNewPrecio")))
                dr.Item("PrecioRepetidoPeroConPrecision") = Val(TextoWebControl(.FindControl("txtNewPrecio")))



                dr.Item("IdCliente") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCliente")), HFSC.Value))

                dr.Item("IdDestinoDeCartaDePorte") = IdNull(BuscaIdWilliamsDestinoPreciso(TextoWebControl(.FindControl("txtNewDestino")), HFSC.Value))

                dr.Item("PrecioEmbarque") = Val(TextoWebControl(.FindControl("txtNewPrecioEmbarque")))
                dr.Item("PrecioEmbarque2") = Val(TextoWebControl(.FindControl("txtNewPrecioEmbarque2")))
                dr.Item("MaximaCantidadParaPrecioEmbarque") = Val(TextoWebControl(.FindControl("txtNewMaximaCantidadParaPrecioEmbarque")))


                dr.Item("PrecioExportacion") = Val(TextoWebControl(.FindControl("txtNewPrecioExportacion")))


                dr.Item("PrecioBuquesCalada") = Val(TextoWebControl(.FindControl("txtNewPrecioCaladaBuques")))


                dr.Item("PrecioCaladaLocal") = Val(TextoWebControl(.FindControl("txtNewPrecioCaladaLocal")))
                dr.Item("PrecioCaladaExportacion") = Val(TextoWebControl(.FindControl("txtNewPrecioCaladaExportacion")))
                dr.Item("PrecioDescargaLocal") = Val(TextoWebControl(.FindControl("txtNewPrecioDescargaLocal")))
                dr.Item("PrecioDescargaExportacion") = Val(TextoWebControl(.FindControl("txtNewPrecioDescargaExportacion")))


                dr.Item("PrecioVagonesCalada") = Val(TextoWebControl(.FindControl("txtNewPrecioVagonesCalada")))
                dr.Item("PrecioVagonesBalanza") = Val(TextoWebControl(.FindControl("txtNewPrecioVagonesBalanza")))


                dr.Item("PrecioVagonesCaladaExportacion") = Val(TextoWebControl(.FindControl("txtNewPrecioVagonesCaladaExportacion")))
                dr.Item("PrecioVagonesBalanzaExportacion") = Val(TextoWebControl(.FindControl("txtNewPrecioVagonesBalanzaExportacion")))


                dr.Item("PrecioComboCaladaMasBalanza") = Val(TextoWebControl(.FindControl("txtNewPrecioComboCaladaMasBalanza")))

                'dr.Item("PrecioCaladaLocal") = Val(TextoWebControl(.Cells(6).Controls(0)))
                'dr.Item("PrecioCaladaExportacion") = Val(TextoWebControl(.Cells(7).Controls(0)))
                'dr.Item("PrecioDescargaLocal") = Val(TextoWebControl(.Cells(8).Controls(0)))
                'dr.Item("PrecioDescargaExportacion") = Val(TextoWebControl(.Cells(9).Controls(0)))

                dt.Rows.Add(dr)

                Try
                    ListasPreciosItemManager.Insert(HFSC.Value, dt)
                Catch sqlEx As SqlException When sqlEx.Number = 2627
                    ErrHandler2.WriteError(sqlEx)
                    lblAlerta.Text = "Ya existe ese item"
                    'Do something about the exception
                Catch sqlEx As SqlException
                    ErrHandler2.WriteError(sqlex.ToString)
                    lblAlerta.Text = sqlex.ToString
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    'MsgBoxAlert(ex.ToString)
                    lblAlerta.Text = ex.ToString
                    'MsgBoxAjax(Me, ex.ToString)
                    'Return
                End Try

            End With

            rebindDetalle()

        End If

    End Sub


    Protected Sub gvDetalle_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvDetalle.RowUpdating
        'se aplican los cambios editados
        With gvDetalle.Rows(e.RowIndex)


            'Metodo con datatable
            Dim Id = gvDetalle.DataKeys(e.RowIndex).Values(0).ToString()
            Dim dt = ListasPreciosItemManager.TraerMetadata(HFSC.Value, Id)
            Dim dr = dt.Rows(0)

            dr.Item("IdArticulo") = IdNull(CType(.FindControl("cmbArticulo"), DropDownList).SelectedValue)
            dr.Item("IdListaPrecios") = gvMaestro.SelectedDataKey.Value ' IdNull(CType(.FindControl("cmbLista"), DropDownList).SelectedValue)
            dr.Item("Precio") = Val(TextoWebControl(.FindControl("txtPrecio")))
            dr.Item("PrecioRepetidoPeroConPrecision") = Val(TextoWebControl(.FindControl("txtPrecio")))

            dr.Item("IdCliente") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCliente")), HFSC.Value))
            dr.Item("IdDestinoDeCartaDePorte") = IdNull(BuscaIdWilliamsDestinoPreciso(TextoWebControl(.FindControl("txtDestino")), HFSC.Value))



            dr.Item("PrecioEmbarque") = Val(TextoWebControl(.FindControl("txtPrecioEmbarque")))
            dr.Item("PrecioEmbarque2") = Val(TextoWebControl(.FindControl("txtPrecioEmbarque2")))
            dr.Item("MaximaCantidadParaPrecioEmbarque") = Val(TextoWebControl(.FindControl("txtMaximaCantidadParaPrecioEmbarque")))


            dr.Item("PrecioExportacion") = Val(TextoWebControl(.FindControl("txtPrecioExportacion")))

            Try
                If iisNull(dr.Item("PrecioCaladaLocal"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioCaladaLocal"))) _
                    Or iisNull(dr.Item("PrecioCaladaExportacion"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioCaladaExportacion"))) _
                    Or iisNull(dr.Item("PrecioDescargaLocal"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioDescargaLocal"))) _
                    Or iisNull(dr.Item("PrecioDescargaExportacion"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioDescargaExportacion"))) _
                    Or iisNull(dr.Item("PrecioVagonesCalada"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioVagonesCalada"))) _
                    Or iisNull(dr.Item("PrecioVagonesBalanza"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioVagonesBalanza"))) _
                    Or iisNull(dr.Item("PrecioVagonesCalada"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioVagonesCaladaExportacion"))) _
                    Or iisNull(dr.Item("PrecioVagonesBalanza"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioVagonesBalanzaExportacion"))) _
                    Or iisNull(dr.Item("PrecioBuquesCalada"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioCaladaBuques"))) _
                    Or iisNull(dr.Item("PrecioComboCaladaMasBalanza"), 0) <> Val(TextoWebControl(.FindControl("txtPrecioComboCaladaMasBalanza"))) _
                    Then

                    dr.Item("PrecioBuquesCalada") = Val(TextoWebControl(.FindControl("txtPrecioCaladaBuques")))

                    dr.Item("PrecioCaladaLocal") = Val(TextoWebControl(.FindControl("txtPrecioCaladaLocal")))
                    dr.Item("PrecioCaladaExportacion") = Val(TextoWebControl(.FindControl("txtPrecioCaladaExportacion")))
                    dr.Item("PrecioDescargaLocal") = Val(TextoWebControl(.FindControl("txtPrecioDescargaLocal")))
                    dr.Item("PrecioDescargaExportacion") = Val(TextoWebControl(.FindControl("txtPrecioDescargaExportacion")))

                    dr.Item("PrecioVagonesCalada") = Val(TextoWebControl(.FindControl("txtPrecioVagonesCalada")))
                    dr.Item("PrecioVagonesBalanza") = Val(TextoWebControl(.FindControl("txtPrecioVagonesBalanza")))

                    dr.Item("PrecioVagonesCaladaExportacion") = Val(TextoWebControl(.FindControl("txtPrecioVagonesCaladaExportacion")))
                    dr.Item("PrecioVagonesBalanzaExportacion") = Val(TextoWebControl(.FindControl("txtPrecioVagonesBalanzaExportacion")))

                    dr.Item("PrecioComboCaladaMasBalanza") = Val(TextoWebControl(.FindControl("txtPrecioComboCaladaMasBalanza")))

                    ListasPreciosItemManager.Update(HFSC.Value, dt)
                    CartaDePorteManager.ReasignoTarifaSubcontratistasDeTodasLasCDPsDescargadasSinFacturarYLasGrabo(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName), gvMaestro.SelectedDataKey.Value)
                Else
                    ListasPreciosItemManager.Update(HFSC.Value, dt)

                End If


            Catch sqlEx As SqlException When sqlEx.Number = 2627
                ErrHandler2.WriteError(sqlEx)
                lblAlerta.Text = "Ya existe ese item"
                'Do something about the exception
            Catch sqlEx As SqlException
                ErrHandler2.WriteError(sqlEx.ToString)
                lblAlerta.Text = sqlEx.ToString
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                'MsgBoxAlert(ex.ToString)
                lblAlerta.Text = ex.ToString
                'MsgBoxAjax(Me, ex.ToString)
                'Return
            End Try


            'Metodo cuando hice la intentona con el <BoundField> en lugar del <TemplateField> 
            '(lo cambie porque no se como poner controles en el footer
            'dr.Item("PrecioCaladaLocal") = Val(TextoWebControl(.Cells(6).Controls(0)))
            'dr.Item("PrecioCaladaExportacion") = Val(TextoWebControl(.Cells(7).Controls(0)))
            'dr.Item("PrecioDescargaLocal") = Val(TextoWebControl(.Cells(8).Controls(0)))
            'dr.Item("PrecioDescargaExportacion") = Val(TextoWebControl(.Cells(9).Controls(0)))


            'If you don't use an objectdatasouce/sqldatasouce e.NewValues collection will be empty.
            'If you don't use an objectdatasouce/sqldatasouce e.NewValues collection will be empty.
            'If you don't use an objectdatasouce/sqldatasouce e.NewValues collection will be empty.
            'dr.Item("IdDestinoDeCartaDePorte") = IdNull(CType(.FindControl("cmbDestinoDeCartaDePorte"), DropDownList).SelectedValue)
            'dr.Item("PrecioCaladaLocal") = Val(TextoWebControl(.FindControl("txtPrecioCaladaLocal")))
            'dr.Item("PrecioCaladaExportacion") = Val(TextoWebControl(.FindControl("txtPrecioCaladaExportacion")))
            'dr.Item("PrecioDescargaLocal") = Val(TextoWebControl(.FindControl("txtPrecioDescargaLocal")))
            'dr.Item("PrecioDescargaExportacion") = Val(TextoWebControl(.FindControl("txtPrecioDescargaExportacion")))
        End With

        gvDetalle.EditIndex = -1
        rebindDetalle() 'hay que volver a pedir los datos...

    End Sub

    Protected Sub gvDetalle_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvDetalle.RowEditing
        'se empieza a editar un renglon
        gvDetalle.EditIndex = e.NewEditIndex
        rebindDetalle() 'hay que volver a pedir los datos...
    End Sub

    Protected Sub gvDetalle_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvDetalle.RowCancelingEdit
        'se cancelan los datos editados
        gvDetalle.EditIndex = -1
        rebindDetalle() 'hay que volver a pedir los datos...
    End Sub


    Protected Sub gvMaestro_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvMaestro.RowCancelingEdit
        'se cancelan los datos editados
        gvMaestro.EditIndex = -1
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
        If getGridIDcolbyHeader(sHeader, gvDetalle) = -1 Then Return New WebControls.Label 'si devuelvo Nothing para que no explote 

        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvDetalle)).Controls(1), WebControls.Label)
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal sHeader As String) As String
        If getGridIDcolbyHeader(sHeader, gvDetalle) = -1 Then Return Nothing

        'Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvMaestro)).Controls(1), WebControls.TextBox).Text()
        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvDetalle)).Controls(1), WebControls.Label).Text()
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal col As Integer) As String
        Return CType(r.Cells(col).Controls(1), WebControls.TextBox).Text()
    End Function
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////



    Protected Sub gvDetalle_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvDetalle.RowDeleting
        ListasPreciosItemManager.Delete(HFSC.Value, gvDetalle.DataKeys(e.RowIndex).Values(0).ToString())
        rebindDetalle()
    End Sub
    Protected Sub gvMaestro_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvMaestro.RowDeleting
        ListaPreciosManager.Delete(HFSC.Value, gvMaestro.DataKeys(e.RowIndex).Values(0).ToString())
        ReBind()
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////

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
                                   "Convert(Descripcion, 'System.String') LIKE '*" & txtBuscar.Text & "*' )" '_

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
    Function GenerarWHEREdetalle() As String
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
                                   "Convert(DestinoDesc, 'System.String') LIKE '*" & txtBuscarDetalleDestino.Text & "*' )" _
        & " AND " & _
        "Convert(Producto, 'System.String') LIKE '*" & txtBuscarDetalleArticulo.Text & "*'"



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

    Private Sub ReBind()

        Dim dt As DataTable = ListaPreciosManager.Fetch(HFSC.Value, txtBuscar.Text)
        dt = DataTableWHERE(dt, GenerarWHERE)

        gvMaestro.DataSource = dt ' New DataView(dt)



        If IsNothing(gvMaestro.SelectedDataKey) Then
            Me.gvMaestro.SelectedIndex = 0
        End If

        gvMaestro.DataBind()

        rebindDetalle()
    End Sub

    Sub rebindDetalle()
        Try

            If gvMaestro.SelectedDataKey Is Nothing Then
                gvMaestro.SelectedIndex = 0
            End If

            Dim dtCustomer = ListasPreciosItemManager.Fetch(HFSC.Value, gvMaestro.SelectedDataKey.Value)
            dtCustomer = DataTableWHERE(dtCustomer, GenerarWHEREdetalle)

            DataTableORDER(dtCustomer, "DestinoDesc")

            'For Each r In dtCustomer.Rows
            '    r("PrecioRepetidoPeroConPrecision") = iisNull(r("PrecioRepetidoPeroConPrecision"), 0)

            'Next


            If dtCustomer.Rows.Count > 0 Then

                gvDetalle.DataSource = dtCustomer
                gvDetalle.DataBind()


            Else
                'la grilla está vacia. Creo un renglon nuevo para el alta y un cartel de aviso
                dtCustomer.Rows.Add(dtCustomer.NewRow())
                gvDetalle.DataSource = dtCustomer
                gvDetalle.DataBind()

                Dim TotalColumns = gvDetalle.Rows(0).Cells.Count
                gvDetalle.Rows(0).Cells.Clear()
                gvDetalle.Rows(0).Cells.Add(New TableCell())
                gvDetalle.Rows(0).Cells(0).ColumnSpan = TotalColumns
                gvDetalle.Rows(0).Cells(0).Text = "No Record Found"
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
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












    Protected Sub gvMaestro_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvMaestro.SelectedIndexChanged

        Dim dtCustomer = ListasPreciosItemManager.Fetch(HFSC.Value, gvMaestro.SelectedDataKey.Value)

        'For Each r In dtCustomer.Rows
        '    r("PrecioRepetidoPeroConPrecision  ") = iisNull(r("PrecioRepetidoPeroConPrecision"), 0)

        'Next


        If dtCustomer.Rows.Count > 0 Then
            gvDetalle.DataSource = dtCustomer
            gvDetalle.DataBind()
        Else

            'la grilla está vacia. Creo un renglon nuevo para el alta y un cartel de aviso
            dtCustomer.Rows.Add(dtCustomer.NewRow())
            gvDetalle.DataSource = dtCustomer
            gvDetalle.DataBind()

            Dim TotalColumns = gvDetalle.Rows(0).Cells.Count
            gvDetalle.Rows(0).Cells.Clear()
            gvDetalle.Rows(0).Cells.Add(New TableCell())
            gvDetalle.Rows(0).Cells(0).ColumnSpan = TotalColumns
            gvDetalle.Rows(0).Cells(0).Text = "Lista vacía"
        End If

    End Sub

    Protected Sub gvMaestro_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvMaestro.RowEditing

        gvMaestro.EditIndex = e.NewEditIndex
        ReBind() 'hay que volver a pedir los datos...
    End Sub













    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        If (AsyncFileUpload1.HasFile) Then
            Try

                Dim nombre = NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)
                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))
                Randomize()

                Dim temppath = System.IO.Path.GetTempPath()
                Dim nombrenuevo = temppath + Int(Rnd(100000) * 100000).ToString.Replace(".", "") + "_" + nombre
                Session("NombreArchivoSubido") = nombrenuevo

                Dim MyFile1 As New FileInfo(nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try




                AsyncFileUpload1.SaveAs(nombrenuevo)


                Dim ds = GetExcelToDatatable(nombrenuevo, , , 2000)

                ImportarListaDePrecios(ds)
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

    End Sub

    Sub ImportarListaDePrecios(ByVal ds As DataSet)
        'ds.Tables(0).Rows(0).Item(0)

        For c = 0 To ds.Tables(0).Columns.Count - 1
            Try
                ds.Tables(0).Columns(c).ColumnName = ds.Tables(0).Rows(0).Item(c)
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
            End Try
        Next

        For Each i As DataRow In ds.Tables(0).Rows

            Dim idClienteAfacturarle As Long = BuscaIdClientePreciso(i("Cliente"), HFSC.Value)
            Dim idart As Long = BuscaIdArticuloPreciso(i("Articulo"), HFSC.Value)
            Dim tarif As Double = Val(i("Tarifa"))
            Dim bPORdestino As Boolean
            Dim iddestino As Long
            Try
                bPORdestino = (i("Por Destino?") = "SI")
                If bPORdestino Then
                    iddestino = BuscaIdWilliamsDestinoPreciso(i("Destino"), HFSC.Value)
                End If
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
            End Try


            If tarif > 0 Then
                If iddestino > 0 Then
                    ListaPreciosManager.SavePrecioPorCliente_OBSOLETA_NOUSARMASELDESTINO(HFSC.Value, idClienteAfacturarle, idart, iddestino, tarif)
                Else
                    ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, idart, tarif)
                End If

            End If
        Next

        MsgBoxAjax(Me, "Importación terminada")
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






