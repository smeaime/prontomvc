Imports Pronto.ERP.Bll

Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo
Imports Pronto.ERP.Bll.BDLmasterPermisosManager 'como la capa de negocios la tengo acá para debuguear en tiempo de ejecucion, la importo desde acá

Imports System.Data.SqlClient 'esto tambien hay que sacarlo de acá
Imports System.Linq

Imports System.DateTime


Imports CartaDePorteManager


Partial Class Admin_EditarUsuario
    Inherits System.Web.UI.Page
    Private SC As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HFSC.Value = GetConnectionString(Server, Session)

        HiddenField1.Value = ConexBDLmaster()
        SC = ConexBDLmaster()







        If False And Not Page.PreviousPage Is Nothing Then
            'If Not (PreviousPage.UserName Is Nothing) Then
            '    LblNombre.Text = PreviousPage.UserName
            'End If
        ElseIf Not (Request.QueryString.Get("UserName") Is Nothing) Then
            LblNombre.Text = Request.QueryString.Get("UserName")
        Else
            Dim Usuario As New Usuario
            Usuario = Session(SESSIONPRONTO_USUARIO)
            LblNombre.Text = Usuario.Nombre

            'por qué el User.Identity.Name (el que usa el LoginView) puede ser distinto del que tengo guardado en la Session????
            'será porque está usando mi login de Windows??? (windows authentication)
            '-puede ser.....
        End If


        Dim membershipUser As MembershipUser
        membershipUser = Membership.GetUser(LblNombre.Text)

        If membershipUser Is Nothing Then
            MsgBoxAjax(Me, "Este usuario no existe. Hay una inconsistencia en la base BDLMaster. Contacte al Administrador")
            Return
        End If

        ButAceptar.CommandArgument = LblNombre.Text



        If Not IsPostBack Then

            GetAllUsers()
            Dim Usuario = New Usuario
            Usuario = Session(SESSIONPRONTO_USUARIO)
            'BuscaTextoEnCombo(DDLUser, Usuario.Nombre)
            BuscaTextoEnCombo(DDLUser, LblNombre.Text)
            Try
                TxTEmail.Text = If(membershipUser.Email, "")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Dim a As String
            Try
                a = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(membershipUser.ProviderUserKey.ToString, ConexBDLmaster, HFSC.Value)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            If IsNothing(a) Then
                txtRazonSocial.Text = "" 'Usuario.Nombre supongo que le asignaba el nombre si el nombre era parecido al de un cliente, pero mejor lo dejo vacio
            Else
                txtRazonSocial.Text = a
            End If


            txtListadoCuits.Text = UserDatosExtendidosManager.TraerClientesRelacionadoslDelUsuario(membershipUser.UserName, ConexBDLmaster)



            RebindRoles()
            ReBindGrillaModulos()

            'ParametroManager.TraerValorParametro2(SC, ParametroManager.eParam2.WebConfiguracionEmpresa)
            If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(HFSC.Value) = "Williams" Then
                RenglonCliente.Visible = True
            Else
                RenglonCliente.Visible = False
            End If

        End If

        AutoCompleteExtender21.ContextKey = HFSC.Value



        'TODO: agregar(rol())
    End Sub


    Sub SuperadminBackdoor()

        'labelSuperadmin.visible = True
        'btnHabilitarRol.visible = True
        'columnaPermisosSuperAdmin = True
    End Sub


    Sub RebindRoles()
        Dim r() As String

        If Session("SuperAdmin") = "Habilitado" Then
            'If EstaEsteRol("SuperAdministrador") Then
            'labelSuperadmin.visible = True
            'btnHabilitarRol.visible = True
            gvModulos.Columns(4).Visible = True
        Else
            'columnaPermisosSuperAdmin = False
            gvModulos.Columns(4).Visible = False
        End If

        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        'Harcodeando. Codigo asqueroso. arreglar
        If ConfigurationManager.AppSettings("ConfiguracionEmpresa") = "Esuco" Then
            'filtrar para esuco soloamente los roles de admin y usuario
            '-y no puede haber directamente unos checks con los roles????
            ReDim r(1)
            r(0) = "Administrador"
            r(1) = "Usuario"
        Else
            r = Roles.GetAllRoles()
            For i = 0 To r.Length - 1
                If r(i) = "Administrador" And Not EstaEsteRol("Administrador") Then
                    r(i) = "WilliamsAdmin" 'para el caso de williams
                End If
            Next
        End If
        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        DDLRoles.DataSource = r
        DDLRoles.DataBind()
        SelectRol(LblNombre.Text)



        '//////////////////////////////////////////////////
        '//////////////////////////////////////////////////
        DropDownList3.DataSource = r
        DropDownList3.DataBind()

        Dim rols() As String = Roles.GetRolesForUser(LblNombre.Text)
        ListBox1.DataSource = rols
        ListBox1.DataBind()

    End Sub


    Protected Sub SelectRol(ByVal userName As String)
        Dim rol() As String
        rol = Roles.GetRolesForUser(userName)
        If (rol.Length <> 1) Then
            DDLRoles.Items(0).Selected = True
        Else
            Try
                Dim listItems As ListItem
                listItems = DDLRoles.Items.FindByValue(rol(0))
                listItems.Selected = True
            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
            End Try
        End If
    End Sub





    Protected Sub ButAceptar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButAceptar.Command

        Dim membershipUser As MembershipUser
        membershipUser = Membership.GetUser(e.CommandArgument.ToString)
        membershipUser.Email = TxTEmail.Text
        Dim rol() As String
        rol = Roles.GetRolesForUser(e.CommandArgument.ToString)
        'Try

        '    If (rol.Length > 0) Then
        '        Roles.RemoveUserFromRole(e.CommandArgument.ToString, rol(0))
        '        'If (rol(0) <> DDLRoles.SelectedValue) Then
        '        Roles.AddUserToRole(e.CommandArgument.ToString, DDLRoles.SelectedValue)
        '        'End If
        '    Else
        '        Roles.AddUserToRole(e.CommandArgument.ToString, DDLRoles.SelectedValue)
        '    End If
        'Catch ex As Exception
        '    ErrHandler2.WriteError(ex)
        'End Try



        
        UserDatosExtendidosManager.Update(membershipUser.ProviderUserKey.ToString, BuscaIdClientePreciso(txtRazonSocial.Text, HFSC.Value), "", ConexBDLmaster)
        UserDatosExtendidosManager.UpdateClientesRelacionadoslDelUsuario(membershipUser.UserName, ConexBDLmaster, txtListadoCuits.Text)




        If EsUnAdministradorLimitado(membershipUser) Then
            NoDejarQueLeAsigneOtroRolDeMayoresPermisos()
        End If




        grabarGrillaPermisos()


        Membership.UpdateUser(membershipUser)
        Response.Redirect("~/Admin/ListadoUsuarios.aspx")
        'ooo
    End Sub


    Function EsUnAdministradorLimitado(ByVal usuario As MembershipUser) As Boolean

        'EstaEsteRol("Administrador")



        Dim rol() As String
        rol = Roles.GetRolesForUser(usuario.UserName)
        'Dim a = rol.Find("AdminLimitado")

        'TODO: admin limitado

        Return True
    End Function

    Sub NoDejarQueLeAsigneOtroRolDeMayoresPermisos()
        'cc()
    End Sub

    Protected Sub ButCancelar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButCancelar.Command
        Response.Redirect("~/Admin/ListadoUsuarios.aspx")
    End Sub








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






    Protected Sub gvModulos_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvModulos.RowCommand
        If (e.CommandName.Equals("Excel")) Then
            Dim renglon = Convert.ToInt32(e.CommandArgument)
            Dim Entregador As Label = gvModulos.Rows(renglon).FindControl("lblEntregador")
            'Dim cmbNewGender As DropDownList = gvModulos.FooterRow.FindControl("cmbNewGender")
            'Dim txtNewCity As TextBox = gvModulos.FooterRow.FindControl("txtNewCity")
            'Dim txtNewState As TextBox = gvModulos.FooterRow.FindControl("txtNewState")
            'Dim cmbNewType As DropDownList = gvModulos.FooterRow.FindControl("cmbNewType")
            'Dim txtNewEntregador As TextBox = gvModulos.FooterRow.FindControl("txtNewEntregador")

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
            r = gvModulos.FooterRow
            With r



                'Metodo con datatable
                Dim dt = TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow



                dr.Item("CodigoVendedor") = IIf(TextoWebControl(.FindControl("txtNewCodigo")) = "", DBNull.Value, TextoWebControl(.FindControl("txtNewCodigo")))
                dr.Item("Nombre") = TextoWebControl(.FindControl("txtNewRazonSocial"))
                dr.Item("Direccion") = TextoWebControl(.FindControl("txtNewDireccion"))
                dr.Item("CUIT") = TextoWebControl(.FindControl("txtNewCUIT"))
                dr.Item("IdLocalidad") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtNewLocalidad")), HFSC.Value))

                Dim s = Validar(HFSC.Value, dr)
                If s <> "" Then
                    MsgBoxAjax(Me, s)
                    Return
                End If


                dt.Rows.Add(dr)

                Insert(HFSC.Value, dt)
            End With

            ReBindGrillaModulos()

        End If

    End Sub


    Protected Sub gvModulos_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvModulos.RowUpdating
        'se aplican los cambios editados
        With gvModulos.Rows(e.RowIndex)

            If TextoWebControl(.FindControl("txtRazonSocial")) = "" Then
                MsgBoxAjax(Me, "Ingrese una razón social")
                Return
            End If

            If TextoWebControl(.FindControl("txtLocalidad")) = "" Then
                MsgBoxAjax(Me, "Ingrese una localidad")
                Return
            End If

            'Metodo con datatable
            Dim Id = gvModulos.DataKeys(e.RowIndex).Values(0).ToString()
            Dim dt = TraerMetadata(HFSC.Value, Id)
            Dim dr = dt.Rows(0)




            dr.Item("CodigoVendedor") = TextoWebControl(.FindControl("txtCodigo"))
            dr.Item("Nombre") = TextoWebControl(.FindControl("txtRazonSocial"))
            dr.Item("Direccion") = TextoWebControl(.FindControl("txtDireccion"))
            dr.Item("CUIT") = TextoWebControl(.FindControl("txtCUIT"))
            dr.Item("IdLocalidad") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtLocalidad")), HFSC.Value))

            Dim s = Validar(HFSC.Value, dr)
            If s <> "" Then
                MsgBoxAjax(Me, s)
                Return
            End If
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

            'Update(HFSC.Value, gvModulos.DataKeys(e.RowIndex).Values(0).ToString(), o.Emails, o.Entregador, o.IdArticulo)
        End With

        gvModulos.EditIndex = -1
        ReBindGrillaModulos() 'hay que volver a pedir los datos...

    End Sub

    Protected Sub gvModulos_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvModulos.RowEditing
        'se empieza a editar un renglon
        gvModulos.EditIndex = e.NewEditIndex
        ReBindGrillaModulos() 'hay que volver a pedir los datos...
    End Sub

    Protected Sub gvModulos_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvModulos.RowCancelingEdit
        'se cancelan los datos editados
        gvModulos.EditIndex = -1
        ReBindGrillaModulos() 'hay que volver a pedir los datos...
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
        If getGridIDcolbyHeader(sHeader, gvModulos) = -1 Then Return New WebControls.Label 'si devuelvo Nothing para que no explote 

        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvModulos)).Controls(1), WebControls.Label)
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal sHeader As String) As String
        If getGridIDcolbyHeader(sHeader, gvModulos) = -1 Then Return Nothing

        'Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView2)).Controls(1), WebControls.TextBox).Text()
        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, gvModulos)).Controls(1), WebControls.Label).Text()
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal col As Integer) As String
        Return CType(r.Cells(col).Controls(1), WebControls.TextBox).Text()
    End Function
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////



    Protected Sub gvModulos_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvModulos.RowDeleting
        BDLmasterPermisosManager.Delete(HFSC.Value, gvModulos.DataKeys(e.RowIndex).Values(0).ToString())
        ReBindGrillaModulos()
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

        's += " AND ( " & _
        '                           "Convert(" & cmbBuscarEsteCampo.SelectedValue & ", 'System.String') LIKE '*" & txtBuscar.Text & "*' )" '_
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
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub gvModulos_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvModulos.PageIndexChanging
        gvModulos.PageIndex = e.NewPageIndex
        ReBindGrillaModulos()
    End Sub

    Private Sub ReBindGrillaModulos()
        Dim membershipUser As MembershipUser = Membership.GetUser(LblNombre.Text)
        Dim dtPermisos = Fetch(ProntoFuncionesUIWeb.ConexBDLmaster(), membershipUser.ProviderUserKey.ToString)

        'FiltroHarcodeado()

        'como hacer superadministrador?


        Dim r = Roles.GetAllRoles()

        'If r.Contains("Requerimiento") Then filtro &= "'Requerimientos' or Modulo LIKE '%Firmas%' or Modulo LIKE '%Comparativas%'")
        'If r.Contains("Compras") Then filtro &= "'Requerimientos' or Modulo LIKE '%Firmas%' or Modulo LIKE '%Comparativas%'")
        'If r.Contains("Comercial") Then filtro &= "'Requerimientos' or Modulo LIKE '%Firmas%' or Modulo LIKE '%Comparativas%'")
        'If r.Contains("Williams") Then filtro &= "'Requerimientos' or Modulo LIKE '%Firmas%' or Modulo LIKE '%Comparativas%'")
        'dtPermisos = DataTableWHERE(dtPermisos, "Modulo in (" & filtro & ")")

        If True Then
            If ConfigurationManager.AppSettings("ConfiguracionEmpresa") = "Esuco" Then
                'la lista de modulos se refresca en el Fetch
                dtPermisos = DataTableWHERE(dtPermisos, "Modulo='Requerimientos' or Modulo LIKE '%Firmas%' or Modulo LIKE '%Comparativas%'")
            ElseIf ConfigurationManager.AppSettings("ConfiguracionEmpresa") = "Autotrol" Then
                'la lista de modulos se refresca en el Fetch
                dtPermisos = DataTableWHERE(dtPermisos, "Modulo in ('Requerimientos','Artículos','Unidades','Obras','Pedidos') ")
            ElseIf ConfigurationManager.AppSettings("ConfiguracionEmpresa") <> "Williams" Then
                'la lista de modulos se refresca en el Fetch
                dtPermisos = DataTableWHERE(dtPermisos, "Modulo in ('Requerimientos','Artículos','Unidades','Obras','Pedidos') ")
                'dtPermisos = DataTableWHERE(dtPermisos, "NOT (Modulo='Requerimientos' or Modulo LIKE '%CDP%' or Modulo LIKE '%Humedad%'  or Modulo LIKE '%Porte%' )")
            End If
        End If




        'Dim dv As DataView = New DataView(dtCustomer, GenerarWHERE(), "", DataViewRowState.OriginalRows)
        Try
            If False Then
                If Not EsSuperadminActivo() Then
                    dtPermisos = DataTableWHERE(dtPermisos, "Instalado=1 or Instalado is null")
                End If
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        If dtPermisos.Rows.Count > 0 Then
            gvModulos.DataSource = dtPermisos
            'gvModulos.DataSource = dv

            gvModulos.DataBind()
        Else
            'la grilla está vacia. Creo un renglon nuevo para el alta y un cartel de aviso
            dtPermisos.Rows.Add(dtPermisos.NewRow())
            gvModulos.DataSource = dtPermisos
            Try
                gvModulos.DataBind()

                Dim TotalColumns = gvModulos.Rows(0).Cells.Count
                gvModulos.Rows(0).Cells.Clear()
                gvModulos.Rows(0).Cells.Add(New TableCell())
                gvModulos.Rows(0).Cells(0).ColumnSpan = TotalColumns
                gvModulos.Rows(0).Cells(0).Text = "No Record Found"
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

        End If
    End Sub


    Function EsSuperadminActivo() As Boolean
        If Session("Superadmin") = "Habilitado" Then Return True

        Return False
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


    Sub grabarGrillaPermisos()
        Dim membershipUser As MembershipUser = Membership.GetUser(LblNombre.Text)
        Dim dt = Fetch(ProntoFuncionesUIWeb.ConexBDLmaster(), membershipUser.ProviderUserKey.ToString)


        'gvModulos.DataSource

        For Each i As GridViewRow In gvModulos.Rows
            For Each dr In dt.Rows
                If dr("Modulo") = TextoWebControl(i.Cells(0).Controls(1)) Then

                    If EsSuperadminActivo() Then

                        ' dr("PuedeLeer") = False
                        ' dr("PuedeModificar") = False
                        ' dr("PuedeEliminar") = False
                    End If

                    Try
                        dr("Instalado") = DirectCast(i.Cells(4).Controls(1), CheckBox).Checked
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try

                    dr("PuedeLeer") = DirectCast(i.Cells(1).Controls(1), CheckBox).Checked
                    dr("PuedeModificar") = DirectCast(i.Cells(2).Controls(1), CheckBox).Checked
                    dr("PuedeEliminar") = DirectCast(i.Cells(3).Controls(1), CheckBox).Checked


                    Exit For
                End If
            Next
        Next


        Update(ProntoFuncionesUIWeb.ConexBDLmaster(), dt)

    End Sub



















    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Private Sub GetAllUsers()
        DDLUser.Items.Clear()
        Dim membershipUserCollection As MembershipUserCollection
        membershipUserCollection = Membership.GetAllUsers()
        Dim li As ListItem
        For Each user As MembershipUser In membershipUserCollection
            li = New ListItem
            li.Text = user.UserName
            li.Value = user.ProviderUserKey.ToString
            If Not Page.PreviousPage Is Nothing Then
                'If Not (PreviousPage.UserName Is Nothing) Then
                '    If (li.Text = PreviousPage.UserName) Then
                '        li.Selected = True
                '    End If
                'End If
            End If
            DDLUser.Items.Add(li)
        Next
    End Sub

    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub DDLUser_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLUser.SelectedIndexChanged
        Dim empresaList As EmpresaList
        empresaList = New EmpresaList
        SC = ConexBDLmaster()
        'empresaList = EmpresaManager.GetEmpresasPorUsuario(SC, DDLUser.SelectedValue.ToString)
        RefreshBinding()
    End Sub


    Protected Sub ButAsisgnar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButAsisgnar.Command
        If Not DDLEmpresas.SelectedItem Is Nothing Then
            EmpresaManager.AddUserInCompanies(SC, DDLUser.SelectedValue, DDLEmpresas.SelectedItem.Value)
            RefreshBinding()
        End If
    End Sub


    Protected Sub ButDeleteUserInCompany_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButDeleteUserInCompany.Command
        If Not LBEmpresas.SelectedItem Is Nothing Then
            EmpresaManager.DeleteUserInCompanies(SC, DDLUser.SelectedValue, LBEmpresas.SelectedItem.Value)
        End If
        RefreshBinding()
    End Sub


    Private Sub RefreshBinding()
        LBEmpresas.Items.Clear()
        LBEmpresas.DataBind()
        DDLEmpresas.Items.Clear()
        DDLEmpresas.DataBind()
    End Sub


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



















    Protected Sub ChangePassword1_ChangePasswordError(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChangePassword1.ChangePasswordError

    End Sub

    Protected Sub ChangePassword1_ChangingPassword(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles ChangePassword1.ChangingPassword
        '        In my application, the "Manager" membership user, is the one that creates all 
        'the other users. They don't have the ability to register themselves. Only 
        'through the Manager. So if so a user's password, must be altered later, the 
        'Manager opens the users list page, selects the user and a ChangePassword 
        'control is displayed, having the DisplayUserName property set to true (the 
        'user name textbox is displayed). So, the Manager types the name of the user 
        'to change his password, and supplies all the other password data and clicks 
        'on the "Change Password" button. So far so good. 

        'But, as the help file also mentions : 
        '"After the password for the given user name is changed, the user is logged 
        'on to the account associated with the changed password, even if the user was 
        'not logged on to that account previously.",

        'this has the sideffect of, having the Manager log out of the application and 
        'logged in again as the user whose password was changed, also trying to stay 
        'on the same page (which is a page to be displayed only for Manager user!!!), 
        'so I get an authorization error. It couldn't be worse!

        'Is there any way to avoid this, and leave the Manager as is, to continue his 
        'work?

        '        TIA
        '        Iordanis

        '        Using the following simple code, I' ve managed to do what I want, without 
        'reinventing the wheel and still use the control!! I just used the 
        'ChangingPassword event, in which I manually do what I want to do, and then 
        'cancel it and return to the SuccessUrl set. But anyway if this approach has 
        'any hidden disadvantage, I'd like to here what anyone has to say. Code 
        'follows:



    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Protected Sub btnAsignarRol_Click(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles btnAsignarRol.Command
        'Dim rol() As String
        'rol = Roles.GetRolesForUser(LblNombre.Text)
        'If (rol.Length <> 1) Then
        '    DDLRoles.Items(0).Selected = True
        'Else
        '    Try
        '        Dim listItems As ListItem
        '        listItems = DDLRoles.Items.FindByValue(rol(0))
        '        listItems.Selected = True
        '    Catch ex As Exception
        '        ErrHandler2.WriteError(ex.ToString)
        '    End Try
        'End If
        Try
            Roles.AddUserToRole(LblNombre.Text, DropDownList3.SelectedValue)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
        RebindRoles()

    End Sub


    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        If ListBox1.SelectedItem Is Nothing Then
            'If ListBox1.Items.Count > 0 Then
            '    ListBox1.SelectedIndex = 0
            'Else
            MsgBoxAjax(Me, "Elija un rol")
            Exit Sub
            'End If
        End If

        Roles.RemoveUserFromRole(LblNombre.Text, ListBox1.SelectedItem.Text)
        RebindRoles()



        '    Dim membershipUser As MembershipUser
        '    membershipUser = Membership.GetUser(LblNombre.Text)
        '    membershipUser.Email = TxTEmail.Text
        '    Dim rol() As String
        '    rol = Roles.GetRolesForUser(LblNombre.Text)
        '    If (rol.Length > 0) Then
        '        Roles.RemoveUserFromRole(e.CommandArgument.ToString, rol(0))
        '        'If (rol(0) <> DDLRoles.SelectedValue) Then
        '        Roles.AddUserToRole(e.CommandArgument.ToString, DDLRoles.SelectedValue)
        '        'End If
        '    Else
        '        Roles.AddUserToRole(e.CommandArgument.ToString, DDLRoles.SelectedValue)
        '    End If
    End Sub

End Class





