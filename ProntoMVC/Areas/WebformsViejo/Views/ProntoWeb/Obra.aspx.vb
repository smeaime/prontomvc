Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.ParametroManager
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO 'por fileinfo

Imports Word = Microsoft.Office.Interop.Word


Imports System.Linq
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports DocumentFormat.OpenXml.Wordprocessing


Imports openxmlviejadeObras

Partial Class Obra
    Inherits System.Web.UI.Page

    Private IdObra As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing
    Private _gvCompara As Object



    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdObra"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdObra") = Value
        End Set
    End Property

    Private Property gvCompara As Object
        Get
            Return _gvCompara
        End Get
        Set(ByVal value As Object)
            _gvCompara = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdObra = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdObra
        Else
            Me.IdEntity = -1
        End If
        mKey = "Obra_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)

        '/////////////////////////////////////////////
        'Cómo puede ser que a veces llegue hasta acá (Page Load de un ABM) y el session(SESSIONPRONTO_USUARIO) está en nothing? Un cookie?
        If usuario Is Nothing Then 'Or SC Is Nothing Then
            'debug.print(session(SESSIONPRONTO_UserName))

            'pero si lo hacés así, no vas a poder redirigirlo, porque te quedas sin RequestUrl...
            ' ma sí, le pongo el dato en el session
            'session(SESSIONPRONTO_MiRequestUrl) = Request.Url..AbsoluteUri
            Session(SESSIONPRONTO_MiRequestUrl) = Request.RawUrl.ToLower
            Debug.Print(Session(SESSIONPRONTO_MiRequestUrl))

            Session.RemoveAll()
            Response.Redirect("~/Login.aspx")
        End If
        '/////////////////////////////////////////////

        SC = usuario.StringConnection
        If Not (Request.QueryString.Get("SC") Is Nothing) Then
            SC = Request.QueryString.Get("SC")
            SC = Session("ConexionBaseAlternativa")
        End If

        'AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion

        If SC = "" Then Response.Redirect("~/Login.aspx")






        If Not Page.IsPostBack Then
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'Primera llamada a la página
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            '////////////////////////////////////////////
            'DEBUG: oculto o muestro la version de servidor (codebehind) o de cliente (jscript)
            Dim versionViejaDePopupPorServer As Boolean = False
            If versionViejaDePopupPorServer Then
                LinkButtonPopupDirectoCliente.Style.Add("display", "none")
            Else
                LinkButton1.Style.Add("display", "none")
            End If
            '////////////////////////////////////////////



            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            'para que el click sobre la scrollbar del autocomplete no dispare el postback del textbox que extiende
            'http://aadreja.blogspot.com/2009/07/clicking-autocompleteextender-scrollbar.html
            Page.Form.Attributes.Add("onsubmit", "return checkFocusOnExtender();")
            '///////////////////////////////////////////////

            '///////////////////////////////////////////////
            '///////////////////////////
            'pongo popups invisible en tiempo de ejecucion, así los puedo ver en tiempo de diseño 
            'busco todas las configuraciones de "PopupControlID="
            PanelDetalle.Attributes("style") = "display:none"
            PanelInfoNum.Attributes("style") = "display:none"
            Panel1.Attributes("style") = "display:none"
            Panel4.Attributes("style") = "display:none"
            '///////////////////////////

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "") 'este es del popup del password

            'http://forums.asp.net/t/1362149.aspx     para que no se apriete dos veces el boton de ok
            'btnSave.Attributes.Add("onclick", "this.disabled=true;" + ClientScript.GetPostBackEventReference(btnSave, "").ToString())



            BindTypeDropDown() 'combos
            Dim myObra As Pronto.ERP.BO.Obra
            If IdObra > 0 Then
                myObra = EditarSetup()
            Else
                myObra = AltaSetup()

            End If

            Me.ViewState.Add(mKey, myObra)

            BloqueosDeEdicion(myObra)
            DatosDelPopupQueNoSonConstantes()

            '////////////////////////////////////////////
            '////////////////////////////////////////////
            '////////////////////////////////////////////
        End If


        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

        Permisos()

    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Cartas_de_Porte)

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            GridView1.Visible = False
            ' lnkNuevo.Visible = False
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
            'lnkBorrarPosiciones.Visible = False
        Else
            'l() 'nkBorrarPosiciones.Visible = True
        End If

    End Sub
    Function AltaSetup() As Pronto.ERP.BO.Obra
        Dim myObra As Pronto.ERP.BO.Obra = New Pronto.ERP.BO.Obra
        myObra.Id = -1

        With myObra
            txtFechaObra.Text = System.DateTime.Now.ToShortDateString()
            '  txtNumeroObra.Text = Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoNumeroObra").ToString

            BuscaIDEnCombo(cmbEmpleado, session(SESSIONPRONTO_glbIdUsuario)) 'confeccionó

            Try
                'BuscaIDEnCombo(cmbSectores, EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)).IdSector) 'sector del confeccionó
            Catch ex As Exception
                ErrHandler.WriteError(ex)
            End Try


            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            AgregarRenglonVacio(myObra)
            'AgregarRenglonVacio(myObra)
            'AgregarRenglonVacio(myObra)
            'AgregarRenglonVacio(myObra)


            RebindDetalle(myObra)

            GuardarProximoItem(myObra)

            ''/////////////////////////////////
            ''/////////////////////////////////
            '
            '  TraerFirmas(myObra)

        End With
        ViewState("PaginaTitulo") = "Nueva Obra"
        Return myObra

    End Function

    Sub GuardarProximoItem(ByRef myRM As Pronto.ERP.BO.Obra)
        '  hfProxItem.Value = ObraManager.UltimoItemDetalle(myRM) + 1
        txtItem.Text = hfProxItem.Value
    End Sub

    Sub AgregarRenglonVacio(ByRef myRM As Pronto.ERP.BO.Obra)
        With myRM
            '/////////////////////////////////
            '/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As RequerimientoItem = New Pronto.ERP.BO.RequerimientoItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Cantidad = 0
            Dim mvarAux As String = EntidadManager.BuscarClaveINI("Dias default para fecha necesidad en RM", SC, Session(SESSIONPRONTO_glbIdUsuario))
            If Len(mvarAux) > 0 Then
                mItem.FechaEntrega = DateAdd("d", Val(mvarAux), Today)
            Else
                mItem.FechaEntrega = Today
            End If

            mItem.NumeroItem = Nothing 'ObraManager.UltimoItemDetalle(myRM) + 1
            'mItem.NumeroItem = ObraManager.UltimoItemDetalle(SC, myRM.Id) + 1
            mItem.Nuevo = True
            mItem.Eliminado = True


            .linqHelper.DetallePolizas.Add(New DetalleObrasPoliza)
            RebindDetalle(myRM)
            ''/////////////////////////////////
        End With
    End Sub



    Sub RebindDetalle(ByRef myRM As Pronto.ERP.BO.Obra)

        If IsNothing(myRM) Then myRM = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)

        GridView1.DataSource = myRM.linqHelper.DetallePolizas
        GridView1.DataBind()

        GridView2.DataSource = myRM.linqHelper.DetalleRecepciones
        GridView2.DataBind()


        Dim TotalDebe, TotalHaber As Decimal

        'For Each det As ObraItem In myRM.Detalles
        '    With det

        '        If .Eliminado Then Continue For

        '        'TotalDebe += .Debe

        '        'TotalHaber += .Haber

        '    End With
        'Next

        'GridView1.FooterRow.Cells(getGridIDcolbyHeader("Debe", GridView1)).Text = FF2(TotalDebe)
        'GridView1.FooterRow.Cells(getGridIDcolbyHeader("Haber", GridView1)).Text = FF2(TotalHaber)



        UpdatePanelGrilla.Update()
    End Sub


    


    Function EditarSetup() As Pronto.ERP.BO.Obra
        Dim myObra As Pronto.ERP.BO.Obra
        myObra = ObraManager.GetItem(SC, IdObra) ', True)
        If Not (myObra Is Nothing) Then
            With myObra
                'txtNumeroObra.Text = .Numero
                'txtFechaObra.Text = .Fecha.ToString("dd/MM/yyyy")
                ''calFecha.SelectedDate = myObra.Fecha

                'BuscaIDEnCombo(cmbObra, .IdObra)
                'BuscaIDEnCombo(cmbEmpleado, .IdSolicito)
                'BuscaIDEnCombo(cmbSectores, .IdSector)
                'If Not (cmbLibero.Items.FindByValue(.IdAprobo.ToString) Is Nothing) Then
                '    cmbLibero.Items.FindByValue(.IdAprobo.ToString).Selected = True
                '    cmbLibero.Enabled = False
                '    btnLiberar.Visible = False
                'End If
                'txtLugarEntrega.Text = .LugarEntrega
                'txtDetalle.Text = .Detalle
                'txtObservaciones.Text = .Observaciones
                'txtLibero.Text = myObra.Aprobo
                'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

                'lnkAdjunto1.Text = .Detalles(0).ArchivoAdjunto1 'ATENTI!: lo grabo en el adjunto de TODOS los items, porque la RM no tiene adjuntos en el encabezado
                'If lnkAdjunto1.Text <> "" Then
                '    MostrarBotonesParaAdjuntar(False)
                'Else
                '    MostrarBotonesParaAdjuntar(True)
                'End If

                'GuardarProximoItem(myObra)


                'TraerFirmas(myObra)


                'GridView1.DataSource = .Detalles
                'GridView1.DataBind()
                'ViewState("PaginaTitulo") = "Edicion RM " + .Numero.ToString
            End With
        End If
        Return myObra

    End Function




    Sub BloqueosDeEdicion(ByVal myObra As Pronto.ERP.BO.Obra)



        'BuscarClaveINI("Permitir modificar detalle RM") = SI






        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or
        With myObra

            If .Id = -1 Then
                '//////////////////////////
                'es NUEVO
                '//////////////////////////

                LinkImprimir.Visible = False
                btnAnular.Visible = False
                MostrarBotonesParaAdjuntar(True)

            Else
                '//////////////////////////
                'es EDICION
                '//////////////////////////

                LinkImprimir.Visible = True
                btnAnular.Visible = True

                'If .IdAprobo > 0 Or .Cumplido = "AN" Then
                '    '//////////////////////////
                '    'si esta APROBADO o ANULADO, deshabilito la edicion
                '    '//////////////////////////


                '    'habilito el eliminar del renglon
                '    For Each r As GridViewRow In GridView1.Rows
                '        Dim bt As LinkButton = r.Cells(4).Controls(0)
                '        If Not bt Is Nothing Then
                '            bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                '            bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                '        End If
                '        bt = r.Cells(5).Controls(0)
                '        If Not bt Is Nothing Then
                '            bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                '            bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                '        End If
                '    Next

                '    'me fijo si está cerrado
                '    'DisableControls(Me)
                '    GridView1.Enabled = True
                '    btnOk.Enabled = True
                '    btnCancel.Enabled = True

                '    'encabezado
                '    txtNumeroObra.Enabled = False
                '    txtFechaObra.Enabled = False
                '    cmbObra.Enabled = False
                '    cmbSectores.Enabled = False
                '    cmbEmpleado.Enabled = False
                '    txtObservaciones.Enabled = False
                '    txtDetalle.Enabled = False
                '    txtLugarEntrega.Enabled = False

                '    'detalle
                '    LinkButton1.Enabled = False 'boton "+Agregar item"
                '    LinkButtonPopupDirectoCliente.Enabled = False 'boton "+Agregar item"
                '    txt_AC_Articulo.Enabled = False
                '    'txtDetObservaciones.Enabled = False
                '    'txtDetTotal.Enabled = False


                '    'links a popups
                '    'LinkAgregarRenglon.Style.Add("visibility", "hidden")
                '    LinkButton1.Style.Add("visibility", "hidden")
                '    LinkButtonPopupDirectoCliente.Style.Add("visibility", "hidden")
                '    'LinkButton2.Style.Add("visibility", "hidden")

                '    MostrarBotonesParaAdjuntar(False)
                'Else
                '    LinkButton1.Enabled = True
                '    LinkButtonPopupDirectoCliente.Enabled = True
                'End If


                'If .Cumplido = "SI" Then
                '    btnAnular.Visible = False
                '    btnSave.Visible = False
                '    btnCancel.Text = "Salir"
                'End If


                'If .Cumplido = "AN" Then
                '    '////////////////////////////////////////////
                '    'y está ANULADO
                '    '////////////////////////////////////////////
                '    btnAnular.Visible = False
                '    lblAnulado.Visible = True
                '    lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & .MotivoAnulacion
                '    btnSave.Visible = False
                '    btnCancel.Text = "Salir"
                'End If
            End If

        End With
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

    End Sub






    Private Sub BindTypeDropDown()
        cmbObra.DataSource = Pronto.ERP.Bll.ObraManager.GetListCombo(SC)
        cmbObra.DataTextField = "Titulo"
        cmbObra.DataValueField = "IdObra"
        cmbObra.DataBind()
        cmbObra.Items.Insert(0, New WebControls.ListItem("-- Elija una Obra --", -1))

        cmbEmpleado.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        cmbEmpleado.DataTextField = "Titulo"
        cmbEmpleado.DataValueField = "IdEmpleado"
        cmbEmpleado.DataBind()

        'cmbSectores.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Sectores")
        'cmbSectores.DataTextField = "Titulo"
        'cmbSectores.DataValueField = "IdSector"
        'cmbSectores.DataBind()
        'cmbSectores.Items.Insert(0, New WebControls.ListItem("-- Elija un Sector --", -1))

        cmbLibero.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        cmbLibero.DataTextField = "Titulo"
        cmbLibero.DataValueField = "IdEmpleado"
        cmbLibero.DataBind()

        cmbUsuarioAnulo.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()


        cmbDetUnidades.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
        cmbDetUnidades.DataTextField = "Titulo"
        cmbDetUnidades.DataValueField = "IdUnidad"
        cmbDetUnidades.DataBind()
        cmbDetUnidades.Enabled = False

    End Sub




    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click
        If Not mAltaItem Then
            EndEditing()
        Else
            mAltaItem = False
        End If
    End Sub


    Private Sub EndEditing(Optional ByVal MensajeFinal As String = "")
        'http://www.sitepoint.com/forums//showthread.php?t=483413

        'poner en el redirect del EndEditing esto:
        'Response.Write("<script>alert('message') ; window.location.href='nextpage.aspx'</script>")
        ' o tambien se puede usar un confirm button 

        If MensajeFinal <> "" Then
            'Response.Write("<script>alert('message') ; window.location.href='Comparativas.aspx'</script>")

            'PreRedirectMsgbox.OnOkScript = "window.location = ""Comparativas.aspx"""
            'ButVolver.PostBackUrl = "Comparativas.aspx"
            LblPreRedirectMsgbox.Text = MensajeFinal
            PreRedirectMsgbox.Show()
            'el confirmbutton tambien me sirve si el usuario aprieta sin querer en el menu!!!!!! -no, no sirve para eso
        Else
            'PreRedirectConfirmButtonExtender.Enabled = False 'http://stackoverflow.com/questions/2096262/conditional-confirmbuttonextender
            Response.Redirect(String.Format("Obras.aspx"))
        End If
    End Sub





    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("Obras.aspx?Imprimir=" & IdObra))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("Obras.aspx")) 'roundtrip al cuete?
    End Sub

    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    Sub DatosDelPopupQueNoSonConstantes()
        '/////////////////////////////////////////////////////
        'traigo el Obra, todo para ver el proximo item......
        Dim myObra As Pronto.ERP.BO.Obra
        If (Me.ViewState(mKey) IsNot Nothing) Then
            myObra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
            ' txtItem.Text = ObraManager.UltimoItemDetalle(myObra) + 1
        Else
            txtItem.Text = 1
        End If
        'hfProxItem.Value = txtItem.Text
        '/////////////////////////////////////////////////////



        Dim mvarAux As String = EntidadManager.BuscarClaveINI("Dias default para fecha necesidad en RM", SC, session(SESSIONPRONTO_glbIdUsuario))
        If Len(mvarAux) > 0 Then
            txtFechaNecesidad.Text = DateAdd("d", Val(mvarAux), txtFechaObra.Text)
        Else
            txtFechaNecesidad.Text = Today.ToString
        End If
        hfFechaNecesidad.Value = txtFechaNecesidad.Text

    End Sub

    Sub AltaItemSetup()
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!
        ViewState("IdDetalleObra") = -1

        'RequiredFieldValidator1.Enabled = True 'desactivo validators del popup

        'RequiredFieldValidator1.IsValid = True 'porque me está apareciendo antes de aceptar. este problema no lo tengo en el abm de pedidos


        'Limpio el popup

        txt_AC_Articulo.Text = ""
        SelectedAutoCompleteIDArticulo.Value = 0
        txtCodigo.Text = ""
        txtCantidad.Text = 0
        txtObservacionesItem.Text = ""
        RadioButtonList1.SelectedIndex = 0

        RequiredFieldtxtObservacionesItem.EnableClientScript = False
        RequiredFieldtxtObservacionesItem.Enabled = False


        DatosDelPopupQueNoSonConstantes()




        '/////////////////////////////////////////////////
        'If Len(Trim(txtItem.Text)) = 0 Or mvarId = -1 Then 'si no hay renglones o si la RM es nueva
        '    origen.Registro.Fields("NumeroItem").Value = oObra.DetObras.UltimoItemDetalle
        'Else
        '    .numeroitem = findmax(listadetalle().numeroitem) + 1
        'End If


        ''como pongo los nombres de los proveedores?
        'If myComparativa.Detalles IsNot Nothing Then
        '    Dim p As Pronto.ERP.BO.ComparativaItem

        '    For i As Integer = 1 To 8
        '        Dim tempi = i
        '        p = myObra.Detalles.Find(Function(obj) obj.SubNumero = tempi)
        '        Try
        '            'Lo saco por problema de performance
        '            If p IsNot Nothing Then .Columns("Precio" & i).ColumnName = p.ProveedorDelPresupuesto 'PresupuestoManager.GetItem(SC, p.IdPresupuesto).Proveedor

        '        Catch x As Exception
        '            'puede darse que se repita un titulo, y esssplota
        '        End Try
        '    Next

        'End If
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////


        'txtDetCantidad.Text = 0






        UpdatePanelDetalle.Update()
        ModalPopupExtender3.Show()
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click

        AltaItemSetup()

    End Sub

    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        'Para poner el tabindex. Por ahora lo pongo despues del boton anular, porque no se
        'como hacer para colarme entre tabindex existentes
        Dim I As Integer = 14 'el tabindex desde donde empiezo
        For Each ThisRow As GridViewRow In GridView1.Rows
            'Dim bt As Button = CType(ThisRow.FindControl("Eliminar"), Button)
            Dim bt As LinkButton = CType(ThisRow.Cells(4).Controls(0), LinkButton)
            bt.TabIndex = I
            I = I + 1
            bt = CType(ThisRow.Cells(5).Controls(0), LinkButton)
            bt.TabIndex = I
            I = I + 1
        Next
        'ln.TabIndex = I + 1
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'tachar la linea eliminada
        'http://stackoverflow.com/questions/535769/asp-net-gridview-how-to-strikeout-the-entire-text-in-a-row

        'Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        'If eliminado Then e.Row.Style.Value = "text-decoration:line-through;"
        If e.Row.RowType = DataControlRowType.DataRow Then 'no es el encabezado
            If e.Row.DataItem.eliminado Then
                'Las tres columnas de texto (art cant uni)

                'el text decoration es demasiado nuevo, no anda en firefox, es medio buggy
                'e.Row.Cells(0).Style.Value = "text-decoration:line-through;"
                'e.Row.Cells(1).Style.Value = "text-decoration:line-through;"
                'e.Row.Cells(2).Style.Value = "text-decoration:line-through;"

                e.Row.Cells(0).Text = "<strike>" + e.Row.Cells(0).Text + "</strike>"
                e.Row.Cells(1).Text = "<strike>" + e.Row.Cells(1).Text + "</strike>"
                e.Row.Cells(2).Text = "<strike>" + e.Row.Cells(2).Text + "</strike>"


                'e.Row.FindControl("Eliminar").text = "Restaurar" 'reemplazo el texto del eliminado

                Dim b As LinkButton = e.Row.Cells(4).Controls(0)
                b.Text = "Restaurar" 'reemplazo el texto del eliminado

            End If
        End If
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myObra As Pronto.ERP.BO.Obra
        'If e.CommandName.ToLower = "eliminar" Then ' o restaurar
        '    If (Me.ViewState(mKey) IsNot Nothing) Then
        '        myObra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)

        '        'si esta eliminado, lo restaura
        '        myObra.Detalles(mIdItem).Eliminado = Not myObra.Detalles(mIdItem).Eliminado
        '        GuardarProximoItem(myObra)

        '        Me.ViewState.Add(mKey, myObra)
        '        GridView1.DataSource = myObra.Detalles
        '        GridView1.DataBind()
        '    End If

        'ElseIf e.CommandName.ToLower = "editar" Then
        '    ViewState("IdDetalleObra") = mIdItem
        '    hfIdItem.Value = mIdItem
        '    If (Me.ViewState(mKey) IsNot Nothing) Then
        '        'MostrarElementos(True)
        '        myObra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
        '        myObra.Detalles(mIdItem).Eliminado = False

        '        With myObra.Detalles(mIdItem)

        '            SelectedAutoCompleteIDArticulo.Value = .IdArticulo
        '            txt_AC_Articulo.Text = .Articulo

        '            'cmbDetUnidades.SelectedValue = UnidadPorIdArticulo(.IdArticulo, SC) 'evitá esto. estás llamando a la base -Pero tarda tanto? No será la reconstruccion del viewstate lo que me lo pone más lento que agregar un item directo?

        '            txtCantidad.Text = .Cantidad.ToString
        '            txtObservacionesItem.Text = .Observaciones.ToString
        '            txtFechaNecesidad.Text = .FechaEntrega.ToString
        '            txtItem.Text = .NumeroItem.ToString
        '            If .IdArticulo > 0 Then txtCodigo.Text = ArticuloManager.GetItem(SC, .IdArticulo).Codigo

        '            If .IdUnidad = 0 Then .IdUnidad = UnidadPorIdArticulo(.IdArticulo, SC)
        '            BuscaIDEnCombo(cmbDetUnidades, .IdUnidad)

        '            If .OrigenDescripcion = 1 Then
        '                RadioButtonList1.Items(0).Selected = True
        '            ElseIf .OrigenDescripcion = 2 Then
        '                RadioButtonList1.Items(1).Selected = True
        '            ElseIf .OrigenDescripcion = 3 Then
        '                RadioButtonList1.Items(2).Selected = True
        '            Else
        '                RadioButtonList1.Items(0).Selected = True
        '            End If
        '        End With


        '        UpdatePanelDetalle.Update()
        '        ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?

        '    Else
        '        'eh? esto en qué caso lo hace?

        '        txtCantidad.Text = 1
        '        RadioButtonList1.Items(0).Selected = True
        '    End If

        'End If
    End Sub


    Protected Sub txtCodigo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCodigo.TextChanged
        If Len(txtCodigo.Text) <> 0 Then
            Dim oRs As ADODB.Recordset
            oRs = ConvertToRecordset(ArticuloManager.GetListTX(SC, "_PorCodigo", txtCodigo.Text))
            If oRs.RecordCount > 0 Then
                TraerDatosArticulo(oRs.Fields(0).Value)
                '    If Not IsNull(oRs.Fields("IdUnidad").Value) Then
                '        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
                '    Else
                '        '.Fields("IdUnidad").Value = mvarIdUnidadCU
                '    End If
                '    If Not IsNull(oRs.Fields("CostoReposicion").Value) Then
                '        .Fields("Costo").Value = oRs.Fields("CostoReposicion").Value
                '    End If
                'End With
            Else
                'MsgBox("Codigo de material incorrecto", vbExclamation)
                'Cancel = True
                txtCodigo.Text = ""
                txt_AC_Articulo.Text = ""
            End If
        End If
    End Sub

    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////

    'Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
    '    mAltaItem = True
    'End Sub

    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click
        Dim mOk As Boolean

        Page.Validate("Detalle")
        mOk = Page.IsValid

        'che, pero esta validacion no la haces ya en el change del radiobutton???
        'If RadioButtonList1.SelectedItem.Value = 2 And txtObservacionesItem.Text = "" Then
        'si es solo observaciones, tiene que escribir algo
        'mOk = False
        'End If


        'If (Me.ViewState(mKey) IsNot Nothing) Then 'y esto?????
        If mOk Then
            'Me fijo si es valido
            Dim mIdItem As Integer
            mIdItem = hfIdItem.Value

            'If ViewState("IdDetalleObra") Is Nothing Then
            '    'se debe haber llamado al popup desde el cliente... por ahora, lo asigno yo....
            '    mIdItem = -1
            'Else
            '    mIdItem = DirectCast(ViewState("IdDetalleObra"), Integer)
            'End If

            Dim myObra As Pronto.ERP.BO.Obra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
            'If mIdItem = -1 Then
            '    Dim mItem As ObraItem = New Pronto.ERP.BO.ObraItem
            '    mItem.Id = myObra.Detalles.Count
            '    mItem.Nuevo = True
            '    mIdItem = mItem.Id
            '    myObra.Detalles.Add(mItem)
            'End If



            ''como hago para evitar que se oculte el popup? -o incluis el boton en un updatepanel, o usas o un customvalidator
            ''http://forums.asp.net/t/1065336.aspx

            'With myObra.Detalles(mIdItem)
            '    '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
            '    '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
            '    .IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
            '    .Articulo = txt_AC_Articulo.Text
            '    .Cantidad = StringToDecimal(txtCantidad.Text)
            '    .FechaEntrega = iisValidSqlDate(txtFechaNecesidad.Text, Now)
            '    .Observaciones = txtObservacionesItem.Text.ToString

            '    If .Observaciones <> "" AndAlso BuscarClaveINI("OrigenDescripcion en 3 cuando hay observaciones", SC, session(SESSIONPRONTO_glbIdUsuario)) = "SI" Then
            '        .OrigenDescripcion = 3
            '    Else
            '        .OrigenDescripcion = RadioButtonList1.SelectedItem.Value
            '    End If


            '    '.IdUnidad = Convert.ToInt32(UnidadPorIdArticulo(.IdArticulo, SC))
            '    .IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)
            '    .Unidad = cmbDetUnidades.SelectedItem.Text


            '    .Adjunto = "NO"

            '    '.TipoDesignacion = "CMP" 'esto hay que cambiarlo, no?
            '    If .TipoDesignacion = "" Then .TipoDesignacion = "S/D" 'esto hay que cambiarlo, no?

            '    If .Cumplido = "" Then .Cumplido = "NO"
            '    '.Cumplido = IIf(.Cumplido = "SI", "SI", "NO") ' y qué pasa si es "AN"?


            '    If .NumeroItem = 0 Then
            '        .NumeroItem = ObraManager.UltimoItemDetalle(myObra) + 1
            '    End If

            '    'If Len(Trim(txtItem.Text)) = 0 Or mvarId = -1 Then 'si no hay renglones o si la RM es nueva
            '    '    origen.Registro.Fields("NumeroItem").Value = oObra.DetObras.UltimoItemDetalle
            '    'Else
            '    '    .numeroitem = findmax(listadetalle().numeroitem) + 1
            '    'End If


            '    '.idaproboalmacen (o .directoacompras en el encabezado) si queres que aparezcan (despues del asignador) en "RMs a comprar". Esto se asigna en el frmObras

            'End With

            'GuardarProximoItem(myObra)

            ''RecalcularTotalComprobante()
            ''DatosDelPopupQueNoSonConstantes()

            'Me.ViewState.Add(mKey, myObra) 'guardo en el viewstate el objeto
            'GridView1.DataSource = myObra.Detalles 'refresco la grilla
            'GridView1.DataBind()

            UpdatePanelDetalle.Update()

            mAltaItem = True 'para qué sirve esto?
        Else

            'como el item es inválido, no oculto el popup
            ModalPopupExtender3.Show()

            'MsgBoxAjax(Me, "")
            'necesito un update del updatepanel?
        End If

    End Sub


    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////

    Sub DePaginaHaciaObjeto(ByRef myObra As Pronto.ERP.BO.Obra)
        With myObra
            ''myObra.Numero = Convert.ToInt32(txtNumeroObra.Text)
            '.Fecha = Convert.ToDateTime(txtFechaObra.Text)
            '.IdObra = Convert.ToInt32(cmbObra.SelectedValue)
            '.IdSolicito = Convert.ToInt32(cmbEmpleado.SelectedValue)
            '.IdAprobo = IIf(txtLibero.Text <> "" And txtLibero.Text <> "Password Incorrecta", Convert.ToInt32(cmbLibero.SelectedValue), Nothing)
            '.IdSector = Convert.ToInt32(cmbSectores.SelectedValue)
            '.LugarEntrega = Convert.ToString(txtLugarEntrega.Text)
            '.Detalle = Convert.ToString(txtDetalle.Text)
            '.Observaciones = Convert.ToString(txtObservaciones.Text)

            'For Each i In .Detalles 'ATENTI!: lo grabo en el adjunto de TODOS los items, porque la RM no tiene adjuntos en el encabezado
            '    i.Adjunto = IIf(lnkAdjunto1.Text = "", "NO", "SI")
            '    i.ArchivoAdjunto1 = lnkAdjunto1.Text  'ATENTI!: lo grabo en el adjunto de TODOS los items, porque la RM no tiene adjuntos en el encabezado
            'Next

            'If .Cumplido = "" Then .Cumplido = "NO"
            '.Confirmado = "SI"
            ''.ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
            '.ConfirmadoPorWeb = "SI" 'IIf(.IdAprobo <> 0, "SI", "NO") 'lo doy por confirmado si lo liberan
            '.DirectoACompras = "SI"
        End With
    End Sub


    Sub DeObjetoHaciaPagina()

    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try

            Dim mOk As Boolean

            Page.Validate("Encabezado")
            mOk = Page.IsValid
            If Not IsDate(txtFechaObra.Text) Then
                'lblFecha.Visible = True
                mOk = False
            End If
            If mOk Then
                If Not mAltaItem Then
                    Dim myObra As Pronto.ERP.BO.Obra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
                    With myObra

                        DePaginaHaciaObjeto(myObra)

                        If .Id = -1 Then
                            Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                            '.Numero = StringToDecimal(drParam.Item("ProximoNumeroObra").ToString)
                        End If

                        If True Then '  ObraManager.IsValid(myObra) Then

                            'VER
                            Try
                                If ObraManager.Save(SC, myObra) = -1 Then
                                    MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                                    Exit Sub
                                End If
                            Catch ex As Exception
                                MsgBoxAjax(Me, ex.Message)
                            End Try


                            IdObra = myObra.Id


                            'If myObra.Numero <> StringToDecimal(txtNumeroObra.Text) Then
                            '    EndEditing("El Obra fue grabada con el número " & myObra.Numero) 'me voy 
                            'Else
                            '    EndEditing()
                            '    'EndEditing("Desea imprimir el comprobante?")
                            'End If


                        Else
                            MsgBoxAjax(Me, "La lista de items está vacía")
                            mAltaItem = False
                            Exit Sub
                        End If
                    End With
                End If
            Else
                MsgBoxAjax(Me, "La lista de items está vacía")
                mAltaItem = False
            End If
        Catch ex As Exception
        Finally
            btnSave.Visible = True
            btnSave.Enabled = True
        End Try
    End Sub



    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    ' Refrescos del autocomplete
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////



    Protected Sub SelectedAutoCompleteIDArticulo_ServerChange(ByVal sender As Object, ByVal e As System.EventArgs) Handles SelectedAutoCompleteIDArticulo.ServerChange
        btnTraerDatos_Click(Nothing, Nothing)
        'si lo llaman por acá lo seleccionó de la lista, pero si lo escribió hay que buscarlo!
    End Sub

    Protected Sub txt_AC_Articulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) _
    Handles txt_AC_Articulo.TextChanged
        TraerDatosArticulo(SelectedAutoCompleteIDArticulo.Value)
    End Sub


    Protected Sub btnTraerDatos_Click(ByVal sender As Object, ByVal e As System.EventArgs) _
    Handles btnTraerDatos.Click, txt_AC_Articulo.TextChanged ' , txt_AC_Articulo.TextChanged, txtDescArt.TextChanged


        If Not TraerDatosArticulo(SelectedAutoCompleteIDArticulo.Value) Then
            'If SelectedReceiver.Value <> "" Then 'acaban de cambiar un proveedor existente por un alta al vuelo
            'End If
        Else
            'cmbCondicionIVA.Enabled = False
            'txtCUIT.Enabled = False
        End If


        'SelectedAutoCompleteIDArticulo.Value = AutoCompleteExtender2.compl


        'puedo usar el FirstRowSelected
        'para forzar la seleccion del autocomplete por jscript
        'http://www.experts-exchange.com/Programming/Languages/Scripting/JScript/Q_23217217.html



        '        var AutoCompleteExtender = $find('<%=MyAutoCompleteExtender.ClientID%>');
        'var completionList = AutoCompleteExtender.getCompletionList();

        'var firstItem;
        'var newLineIndex = completionList.innerText.indexOf("\r\n");

        'if (newLineIndex != -1)
        '{
        '     firstItem = completionList.innerText.substring(0, newLineIndex);
        '}
        '        Else
        '{
        '    firstItem = completionList.innerText;
        '}

        'var autoCompleteTextBox = $get('<%= MyAutoCompletingTextBox.ClientID %>');
        'autoCompleteTextBox.value = firstItem;
    End Sub





    Function TraerDatosArticulo(ByVal IdArticulo As String) As Boolean 'es string porque el hidden con el ID puede ser ""
        Dim myProveedor As New Pronto.ERP.BO.Proveedor

        '////////////////////////////////
        'Busco el proveedor
        '////////////////////////////////

        If iisNumeric(IdArticulo, 0) <> 0 Then
            'Busco el ID

            'myProveedor = ProveedorManager.GetItem(SC, SelectedAutoCompleteIDArticulo.Value)
            'If myProveedor Is Nothing Then Return False

            '///////////////////////////////
            txt_AC_Articulo.Text = ArticuloManager.GetItem(SC, IdArticulo).Descripcion
            'BuscaIDEnCombo(cmbDetUnidades, UnidadPorIdArticulo(IdArticulo, SC))
            SelectedAutoCompleteIDArticulo.Value = IdArticulo

            LlenoComboDeUnidades(SC, cmbDetUnidades, IdArticulo)
            txtCodigo.Text = ArticuloManager.GetItem(SC, IdArticulo).Codigo
            '////////////////////////////////



        Else
            'Usa el mismo criterio de busqueda del AUTOCOMPLETE

            Dim l As ArticuloList '= ArticuloManager.GetListParaWebService(SC, txt_AC_Articulo.Text)
            If l Is Nothing Then
                txtCodigo.Text = ""
                txt_AC_Articulo.Text = "" 'lo vacío así se activa el validador
                SelectedAutoCompleteIDArticulo.Value = 0
                Return False
            Else
                Dim myArticulo As Pronto.ERP.BO.Articulo
                myArticulo = l(0)
                txt_AC_Articulo.Text = myArticulo.Descripcion
                SelectedAutoCompleteIDArticulo.Value = myArticulo.Id
                txtCodigo.Text = myArticulo.Codigo
                Return True
            End If


            'For Each myProveedor In l
            '    If myProveedor.RazonSocial = txt_AC_Articulo.Text Then
            '        txt_AC_Articulo.Text=
            '        SelectedAutoCompleteIDArticulo.Value = myProveedor.Id
            '        Return True
            '    End If
            'Next




        End If



        '////////////////////////////////
        '////////////////////////////////
        '////////////////////////////////

        'lleno los datos

        'If myProveedor.RazonSocial = txtDescArt.Text Then 'si lo encontré
        With myProveedor
        End With
        'End If


        Return False 'no lo encontré
    End Function


    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        'BuscarClaveINI("Pedir autorizacion para reimprimir RM") = SI

        Dim output As String
        'output = ImprimirWordDOT("Obra_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdObra)
        output = ImprimirWordDOT(DirApp() & "\Documentos\" & "Obra_PRONTO.dot", Me, SC, Session, Response, IdObra)
        'output = ImprimirWordDOT("Presupuesto_PRONTO.dot", Me, SC, Session, Response, IdObra)
        'output = ImprimirWordDOT(DirApp() & "\Documentos\" & "Obra_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdObra)

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

    Protected Sub LinkImprimirOpenXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonOpenXML.Click
        'BuscarClaveINI("Pedir autorizacion para reimprimir RM") = SI


        Dim output As String = DirApp() & "\Documentos\" & "archivo.docx"


        'Dim plantilla As String = DirApp() & "\Documentos\" & "Obra1_ESUCO_PUNTONET.docx"
        Dim plantilla As String = DirApp() & "\Documentos\" & "ObraWeb_AUTOTROL.docx"
        'Dim plantilla = OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC)
        'Dim plantilla = OpenXML_Pronto.CargarPlantillaDesdeArchivo(OpenXML_Pronto.enumPlantilla.FacturaA, SC)



        'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
        Dim MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
        If MyFile1.Exists Then
            MyFile1.Delete()
        End If






        Try
            System.IO.File.Copy(plantilla, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

        Catch ex As Exception
            MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.Message)
            Exit Sub
        End Try
        ' OpenXML_Pronto.ObraXML_DOCX(output, CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra), SC)




        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
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






    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    'Refrescos de controles y refrescos de validaciones
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub ValidarGrilla(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CustomValidator1.ServerValidate
        Try
            Dim myObra As Pronto.ERP.BO.Obra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
            'args.IsValid = ObraManager.IsValid(myObra)
        Catch ex As Exception
            args.IsValid = False
        End Try
    End Sub


    Protected Sub cmbEmpleado_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbEmpleado.SelectedIndexChanged
        'If cmbSectores.SelectedValue = -1 Then
        'BuscaIDEnCombo(cmbSectores, EmpleadoManager.GetItem(SC, cmbEmpleado.SelectedValue).IdSector) 'sector del confeccionó
        'End If
    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList1.SelectedIndexChanged
        If RadioButtonList1.SelectedItem.Value = 2 Then
            RequiredFieldtxtObservacionesItem.EnableClientScript = True
            RequiredFieldtxtObservacionesItem.Enabled = True
        Else
            RequiredFieldtxtObservacionesItem.EnableClientScript = False
            RequiredFieldtxtObservacionesItem.Enabled = False
        End If

    End Sub

    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////

    Private DIRFTP As String = "C:\"


    'linkbutton de descarga del encabezado 
    Protected Sub lnkAdjunto1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAdjunto1.Click
        Dim FilePath As String = lnkAdjunto1.Text  'si lo grabó el pronto, va a venir con el directorio original...
        Dim FileName As String = System.IO.Path.GetFileName(FilePath)

        'System.IO.Path.GetFileName(FilePath)
        'System.IO.Path.GetDirectoryName()

        'EL BOTON DE DESCARGA DEBE ESTAR AFUERA DE LOS UPDATEPANEL!!!!!!!
        If FilePath <> "" Then
            Dim MyFile As New FileInfo(FilePath)
            If MyFile.Exists Then
                'Set the appropriate ContentType.
                Try
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & FileName)
                    'Write the file directly to the HTTP output stream.
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                    Response.TransmitFile(FilePath)
                    Response.End()
                Catch ex As Exception
                    MsgBoxAjax(Me, ex.Message)
                End Try
            End If
        Else
            MsgBoxAjax(Me, "No se encuentra el archivo")
            Exit Sub
        End If

    End Sub

    'subida de adjunto del encabezado
    Protected Sub btnAdjuntoSubir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdjuntoSubir.Click

        'http://forums.asp.net/t/1048832.aspx  'COMO SUBIr de a varios!!!

        'if (FileUpLoad1.HasFile) {

        'http://mattberseth.com/blog/2008/07/aspnet_file_upload_with_realti_1.html

        'http://geekswithblogs.net/ranganh/archive/2008/04/01/file-upload-in-updatepanel-asp.net-ajax.aspx
        If FileUpLoad2.FileName <> "" Then
            Try
                FileUpLoad2.SaveAs(DIRFTP + FileUpLoad2.FileName)
                lnkAdjunto1.Text = DIRFTP + FileUpLoad2.FileName

                'oculto y muestro los controles hasta que se me ocurra una manera más piola
                MostrarBotonesParaAdjuntar(False)
            Catch ex As Exception
                MsgBoxAjax(Me, ex.Message)
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If
    End Sub

    Sub MostrarBotonesParaAdjuntar(ByVal mostrar As Boolean)
        lnkAdjunto1.Visible = Not mostrar
        lnkBorrarAdjunto.Visible = Not mostrar And lnkAdjunto1.Text <> "" 'si no hay arhcivo, no hay borrar

        lnkAdjuntar.Visible = False 'antes era =mostrar . Por ahora este no lo muestro (se supone que era el que adjuntaba sin 2 clicks)
        FileUpLoad2.Visible = mostrar
        btnAdjuntoSubir.Visible = mostrar
    End Sub

    Protected Sub lnkBorrarAdjunto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBorrarAdjunto.Click
        lnkAdjunto1.Text = ""
        MostrarBotonesParaAdjuntar(True)
    End Sub




    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////

    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    'Popup de password (Liberó y Anuló)
    '///////////////////////////////////////////////////////////////////////


    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
        Dim mOk As Boolean
        Page.Validate("Encabezado")
        mOk = Page.IsValid

        Dim myObra As Pronto.ERP.BO.Obra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
        'If Not ObraManager.IsValid(myObra) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
        '    mOk = False
        '    MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
        'End If
        If mOk Then
            ModalPopupExtender1.Show()
        Else
            'MsgBoxAjax(Me, "El objeto no es válido")
        End If
    End Sub


    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click

        If cmbLibero.SelectedValue > 0 Then
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Empleados", "T", cmbLibero.SelectedValue)
            If ds.Tables(0).Rows.Count > 0 Then
                If txtPass.Text = ds.Tables(0).Rows(0).Item("Password").ToString Then
                    txtLibero.Text = ds.Tables(0).Rows(0).Item("Nombre").ToString
                    btnLiberar.Enabled = False
                Else
                    txtLibero.Text = "PassWord incorrecta"
                End If
            End If
        End If

    End Sub




    Protected Sub btnAnular_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnular.Click
        ModalPopupAnular.Show()

    End Sub

    Protected Sub btnAnularOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnularOk.Click

        Dim bPassOK = False
        Dim usuario = cmbUsuarioAnulo.Items(cmbUsuarioAnulo.SelectedIndex).Text
        'password de WEB
        bPassOK = Membership.ValidateUser(usuario, txtAnularPassword.Text)

        If Not bPassOK Then

            'password de pronto
            If txtAnularPassword.Text = ProntoPasswordSegunIdEmpleado(SC, cmbUsuarioAnulo.SelectedValue) Then bPassOK = True
        End If





        If bPassOK Then
            Dim myObra As Pronto.ERP.BO.Obra = CType(Me.ViewState(mKey), Pronto.ERP.BO.Obra)
            With myObra
                'esto tiene que estar en el manager, dios!
                DePaginaHaciaObjeto(myObra)
            End With


            Me.ViewState.Add(mKey, myObra) 'guardo en el viewstate el objeto
            '      ObraManager.Anular(SC, IdObra, cmbUsuarioAnulo.SelectedValue, txtAnularMotivo.Text)
            Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            'BloqueosDeEdicion(myObra)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If

    End Sub








    Private Function ImpresionDeObraSinUsarEMISION(ByVal myComparativa As Pronto.ERP.BO.Comparativa) As String 'Aunque la comparativa tiene plantilla, no llena los datos sola (de hecho, necesita de la gui de pronto)

        'debug:
        Debug.Print(Session("glbPathPlantillas"))
        'Session("glbPathPlantillas")="\\192.168.66.2\DocumentosPronto\Plantillas"


        Dim xlt As String = Session("glbPathPlantillas") & "\Comparativa_" & session(SESSIONPRONTO_NombreEmpresa) & ".xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        Dim output As String = Session("glbPathPlantillas") & "\archivo.xls" 'no funciona bien si uso el raíz





    End Function




End Class





