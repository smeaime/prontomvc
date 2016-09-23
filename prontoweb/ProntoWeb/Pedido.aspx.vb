Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Data
Imports ClaseMigrar.SQLdinamico
Imports ClaseMigrar.MigrarPedido
Imports Pronto.ERP.Bll.PedidoManager
Imports Pronto.ERP.Bll.ParametroManager

Imports System.Linq
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
Imports OpenXmlPowerTools
Imports OpenXML_Pronto


Imports CartaDePorteManager


Partial Class PedidoABM
    Inherits System.Web.UI.Page

    Private IdPedido As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdPedido"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdPedido") = Value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdPedido = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdPedido
        End If
        mKey = "Pedido_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)

        'que pasa si el usuario es Nothing? Qué se rompió?
        If usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))


        SC = usuario.StringConnection
        If Not (Request.QueryString.Get("SC") Is Nothing) Then
            SC = Request.QueryString.Get("SC")
            SC = Session("ConexionBaseAlternativa")
        End If

        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion

        HFSC.Value = GetConnectionString(Server, Session) 'para que la grilla de consulta sepa la cadena de conexion

        If Request.QueryString.Count > 0 Then
            If Request.QueryString("cmd") = "showBuscaArticulos" Then
                GetPedidoAjax(Request.QueryString("id"), Request.QueryString("empresaName"))
            End If
        End If





        If Not Page.IsPostBack Then

            If Cotizacion(SC) = 0 Then
                MsgBoxAjaxAndRedirect(Me, "No hay cotizacion, ingresela primero", String.Format("Cotizaciones.aspx"))
                ' msgboxcotizacion()
                Exit Sub
            End If


            'http://forums.asp.net/t/1362149.aspx     para que no se apriete dos veces el boton de ok
            'btnSave.Attributes.Add("onclick", "this.disabled=true;" + ClientScript.GetPostBackEventReference(btnSave, "").ToString())


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
            PanelInfoNum.Attributes("style") = "display:none"
            Panel1.Attributes("style") = "display:none"
            'Panel4.Attributes("style") = "display:none"
            PopUpGrillaConsulta.Attributes("style") = "display:none"
            '///////////////////////////

            TextBox1.Text = IdPedido
            BindTypeDropDown()
            Dim myPedido As Pronto.ERP.BO.Pedido
            If IdPedido > 0 Then
                myPedido = EditarSetup()
            Else
                myPedido = AltaSetup()
            End If
            'MostrarElementos(False)
            TraerFirmas(myPedido)
            ponerFocoEnElPopupDeLiberarArreglar()

            Me.ViewState.Add(mKey, myPedido)

            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")

            BloqueosDeEdicion(myPedido)




        End If


        Me.btnBuscarRMoLA.Attributes.Add("onclick", "javascript:return OpenPopup()")

        txtDetCantidad.Attributes.Add("onKeyUp", "jsRecalcularItem()")
        txtDetPrecioUnitario.Attributes.Add("onKeyUp", "jsRecalcularItem()")
        txtDetBonif.Attributes.Add("onKeyUp", "jsRecalcularItem()")
        txtDetCosto.Attributes.Add("onKeyUp", "jsRecalcularItem()")
        'txtPorcentajeCertificacion.Attributes.Add("onKeyUp", "jsRecalcularItem()")


        txtCodigo.Attributes.Add("onKeyUp", "if (key==13 || key==9) __dopostback();")

        'http://www.aspdotnetcodes.com/ModalPopup_Postback.aspx
        btnLiberar.Attributes.Add("onclick", "fnSetFocus('" + txtPass.ClientID + "');")

        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

    End Sub


    Sub TraerFirmas(ByRef myRM As Pronto.ERP.BO.Pedido)
        'Exit Sub

        If Not IsNull(myRM.Aprobo) Then
            Dim mIdAprobo = myRM.Aprobo
            'dcfields(4).Enabled = False
            'If CantidadFirmasConfirmadas(RequerimientoMateriales, mvarId) = 0 And _
            '      IIf(IsNull(.Fields("Cumplido").Value), "NO", .Fields("Cumplido").Value) <> "SI" Then
            '    ActivarAnulacionLiberacion(True)
            'Else
            '    ActivarAnulacionLiberacion(False)
            '    ActivarAnulacionFirmas(True)
            'End If

            'If mFirmasLiberacion = 1 Then
            '    mvarLiberada = True
            If myRM.IdAprobo > 0 Then chkFirma0.Checked = 1
            'End If
        End If
        'If Not IsNull(myRM.Aprobo2) Then
        '    'mIdAprobo1 = .Fields("Aprobo2").Value
        '    'mvarLiberada = True
        '    chkFirma0.Checked = 1
        'End If


        Dim oRsAut As ADODB.Recordset
        Dim mCantidadFirmas = 0
        oRsAut = ConvertToRecordset(GetStoreProcedure(SC, enumSPs.Autorizaciones_TX_CantidadAutorizaciones, EnumFormularios.NotaPedido, myRM.TotalPedido - myRM.TotalIva1))
        If oRsAut.RecordCount > 0 Then
            oRsAut.MoveFirst()
            Do While Not oRsAut.EOF
                mCantidadFirmas = mCantidadFirmas + 1

                Dim check As WebControls.CheckBox = Master.FindControl("ContentPlaceHolder1").FindControl("chkFirma" & mCantidadFirmas)
                check.Visible = True
                check.ToolTip = oRsAut.Fields(0).Value

                oRsAut.MoveNext()
            Loop
        End If
        oRsAut.Close()
        oRsAut = ConvertToRecordset(GetStoreProcedure(SC, enumSPs.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante, EnumFormularios.NotaPedido, IdEntity))
        If oRsAut.RecordCount > 0 Then
            oRsAut.MoveFirst()
            Do While Not oRsAut.EOF
                For i = 1 To mCantidadFirmas
                    Dim check As WebControls.CheckBox = Master.FindControl("ContentPlaceHolder1").FindControl("chkFirma" & i)
                    If check.ToolTip = oRsAut.Fields("OrdenAutorizacion").Value Then
                        check.Checked = 1
                        Exit For
                    End If
                Next
                oRsAut.MoveNext()
            Loop
        End If
        oRsAut.Close()
        oRsAut = Nothing
    End Sub

    Sub ponerFocoEnElPopupDeLiberarArreglar()

        Return
        If Not Page.IsPostBack Then
            'If (Not AjaxControlToolkit.ToolkitScriptManager..IsStartupScriptRegistered("Startup")) Then
            Dim sb As StringBuilder = New StringBuilder()
            sb.Append("<script type=""text/javascript\"">")
            sb.Append("Sys.Application.add_load(modalSetup);")
            sb.Append("function modalSetup() {")
            sb.Append(String.Format("var modalPopup = $find('{0}');", ModalPopupExtender1.BehaviorID))
            sb.Append("modalPopup.add_shown(SetFocusOnControl); }")
            sb.Append("function SetFocusOnControl() {")
            sb.Append(String.Format("var textBox1 = $get('{0}');", txtPass.ClientID))
            sb.Append("textBox1.focus();}")
            sb.Append("</script>")

            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "Startup", sb.ToString(), True)

            'End If
        End If

    End Sub

    Function AltaSetup() As Pronto.ERP.BO.Pedido
        Dim myPedido = New Pronto.ERP.BO.Pedido
        myPedido.Id = -1


        ''/////////////////////////////////
        ''/////////////////////////////////
        'Encabezado
        ''/////////////////////////////////
        ''/////////////////////////////////

        'txtFechaPedido.Text = System.DateTime.Now.ToShortDateString()
        'txtNumeroPedido.Text = Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoNumeroPedido").ToString
        myPedido.Fecha = System.DateTime.Now.ToShortDateString()
        myPedido.Numero = ProximoNumeroPedido(SC) 'Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoNumeroPedido").ToString
        myPedido.SubNumero = 0

        RecargarEncabezado(myPedido)
        CargaDatosAdicionales()

        BuscaTextoEnCombo(cmbMoneda, "Pesos")
        txtCotizacionDolar.Text = Cotizacion(SC)
        txtConversionPesos.Text = Cotizacion(SC, , cmbMoneda.SelectedValue)


        ''/////////////////////////////////
        ''/////////////////////////////////
        'Detalle
        ''/////////////////////////////////
        ''/////////////////////////////////
        'agrego renglones vacios. Ver si vale la pena

        Dim mItem As PedidoItem = New Pronto.ERP.BO.PedidoItem
        mItem.Id = -1
        mItem.Nuevo = True
        mItem.Cantidad = 0
        mItem.Precio = Nothing


        myPedido.Detalles.Add(mItem)
        GridView1.DataSource = myPedido.Detalles 'este bind lo copié
        GridView1.DataBind()             'este bind lo copié   
        ''/////////////////////////////////
        ''/////////////////////////////////


        ViewState("PaginaTitulo") = "Nuevo Pedido"
        Return myPedido
    End Function

    Function EditarSetup() As Pronto.ERP.BO.Pedido
        Dim myPedido = PedidoManager.GetItem(SC, IdPedido, True)
        If Not (myPedido Is Nothing) Then
            RecargarEncabezado(myPedido)


            'GridView1.Columns(0).Visible = False
            GridView1.DataSource = myPedido.Detalles
            GridView1.DataBind()

            ViewState("PaginaTitulo") = "Edicion Pedido " + myPedido.Numero.ToString
        End If
        Return myPedido
    End Function


    Sub BloqueosDeEdicion(ByVal myPedido As Pronto.ERP.BO.Pedido)
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or



        If ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ExigirTrasabilidad_RMLA_PE) = "SI" Then
            LinkAgregarRenglon.Enabled = False
            LinkAgregarRenglon.ToolTip = "La opcion ExigirTrasabilidad_RMLA_PE impide que se agreguen items manuales"
            'LinkButtonPopupDirectoCliente.Text = "La opcion ExigirTrasabilidad_RMLA_PE impide que se agreguen items manuales"
            LinkButtonPopupDirectoCliente.Enabled = LinkAgregarRenglon.Enabled
            LinkButtonPopupDirectoCliente.Visible = False
            LinkButtonPopupDirectoCliente.Attributes("OnClientClick") = ";"
            LinkButtonPopupDirectoCliente.Attributes("display") = "none"
            LinkButtonPopupDirectoCliente.ToolTip = LinkAgregarRenglon.ToolTip
        Else

        End If





        With myPedido

            If .Id = -1 Then
                '//////////////////////////
                'es NUEVO
                '//////////////////////////

                LinkImprimir.Visible = False
                btnAnular.Visible = False
                MostrarBotonesParaAdjuntar()

            Else
                '//////////////////////////
                'es EDICION
                '//////////////////////////

                LinkImprimir.Visible = True
                btnAnular.Visible = True
                MostrarBotonesParaAdjuntar()


                If .IdAprobo > 0 Or .Cumplido = "SI" Or .Cumplido = "AN" Then '.IdAprobo > 0 Or .Cumplido = "AN" Then  'lo saqué para que en esuco no editen al firmar. TO DO. arreglar
                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////

                    If False Then
                        'habilito el eliminar del renglon
                        For Each r As GridViewRow In GridView1.Rows
                            Dim bt As LinkButton = r.Cells(3).Controls(0) 'r.Cells(getGridIDcolbyHeader("Eliminar", GridView1)).Controls(0)
                            If Not bt Is Nothing Then
                                bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                                bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                            End If
                            bt = r.Cells(4).Controls(0)
                            If Not bt Is Nothing Then
                                bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                                bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                            End If
                        Next

                        'me fijo si está cerrado
                        'DisableControls(Me)
                    End If
                    GridView1.Enabled = True

                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'encabezado
                    txtDescArt.Enabled = False
                    'cmbEmpleado.Enabled = False
                    txtObservaciones.Enabled = False
                    txtLugarEntrega.Enabled = False
                    cmbComprador.Enabled = False
                    cmbCondicionCompra.Enabled = False
                    cmbLibero.Enabled = False
                    txtLugarEntrega.Enabled = False
                    txtNumeroPedido.Enabled = False
                    cmbComparativas.Enabled = False
                    txtFechaPedido.Enabled = False





                    Dim oRsAut = ConvertToRecordset(GetStoreProcedure(SC, enumSPs.AutorizacionesPorComprobante_TX_AutorizacionesPorComprobante, EnumFormularios.NotaPedido, IdEntity))
                    If oRsAut.RecordCount = 0 Then
                        btnLiberar.Text = "Anular liberación"
                    Else
                        'tiene firmas
                        btnLiberar.Text = "Anular firmas"

                    End If
                    '
                    'btnLiberar.Enabled = False
                    cmbLibero.Enabled = True



                    'detalle
                    LinkButton1.Enabled = False 'boton "+Agregar item"
                    txt_AC_Articulo.Enabled = False
                    'txtDetObservaciones.Enabled = False
                    'txtDetTotal.Enabled = False
                    LinkAgregarRenglon.Visible = False
                    'Dim divAdjunto As HtmlGenericControl = ((Master.FindControl("Adjunto")))
                    'divAdjunto.Visible = False

                    'links a popups
                    'LinkAgregarRenglon.Style.Add("visibility", "hidden")

                    LinkButton1.Style.Add("visibility", "hidden")
                    'LinkButtonPopupDirectoCliente.Style.Add("visibility", "hidden")
                    LinkButton2.Style.Add("visibility", "hidden")
                    'LinkButton7.Style.Add("visibility", "hidden")
                    'LinkButton2.Style.Add("visibility", "hidden")

                    MostrarBotonesParaAdjuntar()
                Else
                    LinkButton1.Enabled = True
                    'LinkButtonPopupDirectoCliente.Enabled = True
                End If


                If .Cumplido = "AN" Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    btnAnular.Visible = False
                    lblAnulado.Visible = True
                    lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & .MotivoAnulacion
                    btnSave.Visible = False
                    btnCancel.Text = "Salir"

                    panelAdjunto.Visible = False

                End If


                If .IdAprobo > 0 Then
                    btnSave.Enabled = False
                    btnSave.Visible = False
                    btnCancel.Text = "Salir"
                End If


                If False Then
                    DisableControls(Me)
                    btnCancel.Enabled = True
                    LinkImprimir.Enabled = True

                    Exit Sub
                End If

            End If


        End With
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

    End Sub









    Private Sub BindTypeDropDown()
        'cmbProveedor.DataSource = ProveedorManager.GetListCombo(SC)
        'cmbProveedor.DataTextField = "Titulo"
        'cmbProveedor.DataValueField = "IdProveedor"
        'cmbProveedor.DataBind()

        'cmbEmpleado.DataSource = EmpleadoManager.GetListCombo(SC)
        'cmbEmpleado.DataTextField = "Titulo"
        'cmbEmpleado.DataValueField = "IdEmpleado"
        'cmbEmpleado.DataBind()


        cmbLibero.DataSource = EmpleadoManager.GetListComboSectorCompras(SC) ' solo acepta a gente del sector de compras
        cmbLibero.DataTextField = "Titulo"
        cmbLibero.DataValueField = "IdEmpleado"
        cmbLibero.DataBind()



        'DropDownList2.DataSource = EmpleadoManager.GetListCombo(SC)
        'DropDownList2.DataTextField = "Titulo"
        'DropDownList2.DataValueField = "IdEmpleado"
        'DropDownList2.DataBind()

        cmbUsuarioAnulo.DataSource = EmpleadoManager.GetListCombo(SC)
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()


        IniciaCombo(SC, cmbMoneda, tipos.Monedas)

        LlenoComboDeUnidades(SC, cmbDetUnidades, -1)


        Try
            cmbClausulaDolar.DataSource = GetStoreProcedure(SC, "Clausulas_TL") 'Comparativas_TL
            cmbClausulaDolar.DataTextField = "Titulo"
            cmbClausulaDolar.DataValueField = "IdClausula"
            cmbClausulaDolar.DataBind()
            ' AgregaLeyendaEnCombo(cmbComparativas, "-- Elija una Comparativa --")

        Catch ex As Exception

        End Try

        cmbCalidad.DataSource = GetStoreProcedure(SC, enumSPs.ControlesCalidad_TL)
        cmbCalidad.DataTextField = "Titulo"
        cmbCalidad.DataValueField = "IdControlCalidad"
        cmbCalidad.DataBind()
        'IniciaCombo(SC, cmbCalidad, 
        hfIdCalidadDefault.Value = Val(ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.IdControlCalidadStandar))
        cmbCalidad.SelectedValue = hfIdCalidadDefault.Value 'lo guardo en un hidden porque este formulario usa el popup de alta sin hacer postback


        cmbComprador.DataSource = EmpleadoManager.GetListComboSectorCompras(SC)
        cmbComprador.DataTextField = "Titulo"
        cmbComprador.DataValueField = "IdEmpleado"
        cmbComprador.DataBind()
        BuscaIDEnCombo(cmbComprador, Session(SESSIONPRONTO_glbIdUsuario)) 'confeccionó




        'cmbArticulos.DataSource = Pronto.ERP.Bll.ArticuloManager.GetListCombo(SC)
        'cmbArticulos.DataTextField = "Titulo"
        'cmbArticulos.DataValueField = "IdArticulo"
        'cmbArticulos.DataBind()
        cmbComparativas.DataSource = GetListCombo(SC, "Comparativas") 'Comparativas_TL

        cmbComparativas.DataTextField = "Titulo"
        cmbComparativas.DataValueField = "Numero"
        cmbComparativas.DataBind()
        AgregaLeyendaEnCombo(cmbComparativas, "-- Elija una Comparativa --")


        'cmbArticulos.DataSource = ArticuloManager.GetListCombo(SC)
        'cmbArticulos.DataTextField = "Titulo"
        'cmbArticulos.DataValueField = "IdArticulo"
        'cmbArticulos.DataBind()

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbCondicionCompra.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "CondicionesCompra")
        If cmbCondicionCompra.DataSource.Tables(0).Rows.Count = 0 Then
        End If
        cmbCondicionCompra.DataTextField = "Titulo"
        cmbCondicionCompra.DataValueField = "IdCondicionCompra"
        cmbCondicionCompra.DataBind()
        'If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
        '    BuscaIDEnCombo(cmbCondicionCompra, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))
        '    cmbCondicionCompra.Enabled = False
        'Else
        cmbCondicionCompra.Items.Insert(0, New ListItem("-- Elija una Condición --", -1))
        cmbCondicionCompra.SelectedIndex = 0
        'End If



    End Sub

    Sub CargaDatosAdicionales()
        txtPlazoEntrega.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.PedidosPlazoEntrega)
        txtLugarEntrega.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.PedidosLugarEntrega)
        txtFormaPago.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.PedidosFormaPago)
        txtGarantia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.PedidosGarantia)
        txtDocumentacion.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.PedidosDocumentacion)
        txtImportante.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.PedidosImportante)

        If txtPlazoEntrega.Text <> "" Then chkPlazoEntrega.Checked = True
        If txtLugarEntrega.Text <> "" Then chkLugarEntrega.Checked = True
        If txtFormaPago.Text <> "" Then chkFormaPago.Checked = True
        If txtGarantia.Text <> "" Then chkGarantia.Checked = True
        If txtDocumentacion.Text <> "" Then chkDocumentacion.Checked = True
        If txtImportante.Text <> "" Then chkImportante.Checked = True


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



            Dim filtroano = Request.QueryString.Get("año")
            Dim filtromes = Request.QueryString.Get("mes")
            Dim url = String.Format("Pedidos.aspx?año={0}&mes={1}", filtroano, filtromes)

            If Not (Request.Browser.Browser.ToLower().Contains("ie")) Then
                btnSave.Enabled = False
                'btnSave.Text = "Grabado" 'no, porque quizás canceló


                Dim scriptCerrar As String '= "var windowObject = window.self; windowObject.opener = window.self; windowObject.close();"


                'window.opener.document.getElementById("ctl00_ContentPlaceHolder1_txtPopupRetorno").value = val;
                'window.opener.__doPostBack('ctl00_ContentPlaceHolder1_txtPopupRetorno', '');
                Dim openerrefresh = "try  { if (window.opener!=null) {" & _
                                    "      window.opener.document.getElementById('ctl00_ContentPlaceHolder1_btnRefresca').click(); " & _
                                    "      var windowObject = window.self; windowObject.opener = window.self; windowObject.close(); }" & _
                                    "      else   window.location.href='" & url & "'; " & _
                                    " } catch(ex) {}  "



                Dim script = openerrefresh & scriptCerrar
                'script = " window.opener.document.getElementById('ctl00_ContentPlaceHolder1_btnRefresca').click; " & script


                AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "Close Window", script, True)
            Else

                Response.Redirect(url)
            End If





        End If
    End Sub




    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("Pedidos.aspx?Imprimir=" & IdPedido))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("Pedidos.aspx")) 'roundtrip al cuete?
    End Sub



    Protected mustAlert As Boolean = False


    '//////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!


        ViewState("IdDetallePedido") = -1

        UpdatePanel4.Update()
        ModalPopupExtender3.Show()


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

                Dim b As LinkButton = e.Row.Cells(3).Controls(0)
                b.Text = "Restaurar" 'reemplazo el texto del eliminado
            End If




            Dim itPed As PedidoItem = e.Row.DataItem


            If False Then

                Using db = New DataClasses2DataContext(Encriptar(SC))
                    Dim vistaDet = (From i In db.wVistaDetPedidos Where i.IdDetallePedido = itPed.Id).SingleOrDefault

                    With vistaDet

                        e.Row.Cells(getGridIDcolbyHeader("Subtotal", GridView1)).Text = vistaDet.Subtotal
                        e.Row.Cells(getGridIDcolbyHeader("Subtotal grav.", GridView1)).Text = vistaDet.Subtotal_grav_
                        e.Row.Cells(getGridIDcolbyHeader("Equipo destino", GridView1)).Text = vistaDet.Equipo_destino
                        e.Row.Cells(getGridIDcolbyHeader("it LA", GridView1)).Text = iisNull(.It_LA)
                        'e.Row.Cells(getGridIDcolbyHeader("cod eq de", GridView1)).Text = .Cod_Eq_Destino
                        e.Row.Cells(getGridIDcolbyHeader("RM solicitada por", GridView1)).Text = .RM_solicitada_por
                        e.Row.Cells(getGridIDcolbyHeader("Obra", GridView1)).Text = .Obra
                    End With

                End Using
            Else
                With itPed
                    e.Row.Cells(getGridIDcolbyHeader("Subtotal", GridView1)).Text = .Subtotal
                    e.Row.Cells(getGridIDcolbyHeader("Subtotal grav.", GridView1)).Text = .Subtotal_grav_
                    e.Row.Cells(getGridIDcolbyHeader("Equipo destino", GridView1)).Text = .Equipo_destino
                    e.Row.Cells(getGridIDcolbyHeader("it LA", GridView1)).Text = .It_LA
                    'e.Row.Cells(getGridIDcolbyHeader("cod eq de", GridView1)).Text = .Cod_Eq_Destino
                    e.Row.Cells(getGridIDcolbyHeader("RM solicitada por", GridView1)).Text = .RM_solicitada_por
                    e.Row.Cells(getGridIDcolbyHeader("Obra", GridView1)).Text = .Obra
                End With

            End If




        End If
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myPedido As Pronto.ERP.BO.Pedido
        If e.CommandName.ToLower = "eliminar" Then
            If (Me.ViewState(mKey) IsNot Nothing) Then
                myPedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)

                'si esta eliminado, lo restaura
                myPedido.Detalles(mIdItem).Eliminado = Not myPedido.Detalles(mIdItem).Eliminado

                Me.ViewState.Add(mKey, myPedido)
                GridView1.DataSource = myPedido.Detalles
                GridView1.DataBind()
            End If

        ElseIf e.CommandName.ToLower = "editar" Then
            ViewState("IdDetallePedido") = mIdItem
            hfIdItem.Value = mIdItem
            If (Me.ViewState(mKey) IsNot Nothing) Then
                'MostrarElementos(True)
                myPedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
                myPedido.Detalles(mIdItem).Eliminado = False

                With myPedido.Detalles(mIdItem)
                    '////////////////////////////////////////////////////////////////////////////////
                    'HAY QUE ARREGLAR ESTO: me lo tiene que dar directamente el BO.Pedido
                    'txtDescArt = myPedido.Detalles(mIdItem).descripcion
                    'Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", myPedido.Detalles(mIdItem).IdArticulo)
                    'If ds.Tables(0).Rows.Count > 0 Then
                    '    'txtDescArt.Text = ds.Tables(0).Rows(0).Item("Descripcion").ToString
                    'End If
                    '////////////////////////////////////////////////////////////////////////////////

                    txtDetItem.Text = .NumeroItem.ToString

                    SelectedAutoCompleteIDArticulo.Value = .IdArticulo
                    txt_AC_Articulo.Text = .Articulo
                    BuscaIDEnCombo(cmbDetUnidades, .IdUnidad)
                    If .IdArticulo > 0 Then txtCodigo.Text = ArticuloManager.GetItem(SC, .IdArticulo).Codigo

                    'txtCodigo.Text = .Detalles(mIdItem).CodigoCuenta
                    txtDetPrecioUnitario.Text = DecimalToString(.Precio)
                    txtDetIVA.Text = DecimalToString(.PorcentajeIVA)
                    txtDetCosto.Text = DecimalToString(.Costo)
                    txtDetBonif.Text = DecimalToString(.PorcentajeBonificacion)


                    Dim numeroreq As Integer
                    Dim numeroreqitem As Integer
                    If .IdDetalleRequerimiento > 0 Then
                        Using db As New DataClasses2DataContext(Encriptar(HFSC.Value))
                            Dim q = (From i In db.wVistaDetRequerimientos Where i.IdDetalleRequerimiento = .IdDetalleRequerimiento).SingleOrDefault
                            numeroreq = q.NumeroRequerimiento
                            numeroreqitem = q.Item
                        End Using
                    End If
                    txtDetRmImputada.Text = numeroreq
                    txtDetRmItemImputada.Text = numeroreqitem

                    Try
                        cmbCalidad.SelectedValue = .IdControlCalidad
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try


                    txtDetTotal.Text = .ImporteTotalItem


                    'cmbArticulos.SelectedValue = Convert.ToInt32(myPedido.Detalles(mIdItem).IdArticulo)
                    'TextBox3.Text = myPedido.Detalles(mIdItem).Codigo
                    txtDetCantidad.Text = .Cantidad.ToString
                    txtObservacionesItem.Text = .Observaciones.ToString
                    txtFechaNecesidad.Text = .FechaNecesidad.ToString
                    txtFechaEntrega.Text = .FechaEntrega.ToString
                    If .OrigenDescripcion = 1 Then
                        RadioButtonList1.Items(0).Selected = True
                    ElseIf myPedido.Detalles(mIdItem).OrigenDescripcion = 2 Then
                        RadioButtonList1.Items(1).Selected = True
                    ElseIf .OrigenDescripcion = 3 Then
                        RadioButtonList1.Items(2).Selected = True
                    Else
                        RadioButtonList1.Items(0).Selected = True
                    End If
                    UpdatePanel4.Update()
                    ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                End With
            Else
                txtDetCantidad.Text = 1
                RadioButtonList1.Items(0).Selected = True
            End If

        End If
    End Sub

    'Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
    '    'MostrarElementos(False)
    '    mAltaItem = True
    '    'UpdatePanel4.Update()
    'End Sub

    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click

        Dim mOk As Boolean

        Page.Validate("Detalle")
        mOk = Page.IsValid

        If mOk Then
            'If (Me.ViewState(mKey) IsNot Nothing) Then

            Dim mIdItem As Integer
            mIdItem = hfIdItem.Value

            'If ViewState("IdDetallePedido") Is Nothing Then
            '    'se debe haber llamado al popup desde el cliente... por ahora, lo asigno yo....
            '    mIdItem = -1
            'Else
            '    mIdItem = DirectCast(ViewState("IdDetallePedido"), Integer)
            'End If


            Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then
                Dim mItem As PedidoItem = New Pronto.ERP.BO.PedidoItem

                If myPedido.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myPedido.Detalles.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myPedido.Detalles.Add(mItem)



            End If


            Try
                With myPedido.Detalles(mIdItem)
                    'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
                    ' de cada valor, como se hace en toda web

                    'ORIGINAL EDU:
                    '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
                    '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
                    'MODIFICADO CON AUTOCOMPLETE:
                    '.IdArticulo = Convert.ToInt32(SelectedReceiver.Value)
                    '.Articulo = txtDescArt.Text

                    '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
                    '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
                    .IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
                    .Articulo = txt_AC_Articulo.Text

                    .Precio = StringToDecimal(txtDetPrecioUnitario.Text)
                    .PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
                    .PorcentajeIVA = StringToDecimal(txtDetIVA.Text)
                    .Costo = StringToDecimal(txtDetCosto.Text)

                    .ImporteTotalItem = StringToDecimal(txtDetTotal.Text)
                    .IdUnidad = Val(cmbDetUnidades.SelectedValue)
                    .Unidad = cmbDetUnidades.SelectedItem.Text
                    .Abreviatura = NombreUnidadAbreviatura(SC, .IdUnidad)

                    .Cantidad = Convert.ToDecimal(txtDetCantidad.Text)
                    '.IdUnidad = Convert.ToInt32(UnidadPorIdArticulo(.IdArticulo, SC))



                    '.IdDetalleRequerimiento = txtDetRmImputada.Text
                    'txtDetRmItemImputada.Text=


                    .FechaNecesidad = iisValidSqlDate(txtFechaNecesidad.Text, Now)


                    .IdControlCalidad = cmbCalidad.SelectedValue

                    .FechaEntrega = iisValidSqlDate(txtFechaEntrega.Text, Now)
                    .Observaciones = txtObservacionesItem.Text.ToString


                    Try
                        .Subtotal = .Precio * .Cantidad
                        .Subtotal_grav_ = .Cantidad * .Precio - .ImporteBonificacion
                        .Equipo_destino = RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).Equipo
                        .It_LA = RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).Item
                        .RM_solicitada_por = RequerimientoManager.GetItem(SC, RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).IdRequerimiento).Solicito
                        .Obra = RequerimientoItemManager.GetItem(SC, .IdDetalleRequerimiento).centrocosto

                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try


                    If RadioButtonList1.SelectedItem IsNot Nothing Then
                        .OrigenDescripcion = RadioButtonList1.SelectedItem.Value
                    End If
                    'TO DO
                    .FechaNecesidad = .FechaNecesidad '#1/1/2009#
                    .FechaDadoPorCumplido = .FechaEntrega '#1/1/2009#
                    .FechaAsignacionCosto = .FechaEntrega ' #1/1/2009#
                End With
            Catch ex As Exception
                'lblError.Visible = True
                ErrHandler2.WriteError(ex)
                Exit Sub
            End Try


            'reseteo textbox para evitar extraños textchanged no detectados al repetir el mismo articulo
            txt_AC_Articulo.Text = ""
            txtCodigo.Text = ""


            Me.ViewState.Add(mKey, myPedido)
            GridView1.DataSource = myPedido.Detalles
            GridView1.DataBind()
            ModalPopupExtender3.Hide()
            UpdatePanel4.Update()
            'MostrarElementos(False)
            mAltaItem = True
            RecalcularTotalComprobante()
        Else

            'como el item es inválido, no oculto el popup
            ModalPopupExtender3.Show()

            'MsgBoxAjax(Me, "")
            'necesito un update del updatepanel?
        End If
    End Sub


    Sub RecargarEncabezado(ByVal myPedido As Pronto.ERP.BO.Pedido)
        With myPedido
            txtNumeroPedido.Text = .Numero
            txtSubnumeroPedido.Text = .SubNumero
            txtFechaPedido.Text = .Fecha.ToString("dd/MM/yyyy")
            'calFecha.SelectedDate = myPedido.Fecha


            '////////////////////////////////////////////////////////
            'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
            SelectedReceiver.Value = .IdProveedor
            txtDescArt.Text = .Proveedor

            txtTotBonif.Text = .PorcentajeBonificacion '.Bonificacion
            txtImpuestosInternos.Text = .ImpuestosInternos

            Try
                TraerDatosProveedor(myPedido.IdProveedor) 'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            'BuscaIDEnCombo(cmbProveedor, .IdProveedor)
            BuscaIDEnCombo(cmbComprador, .IdComprador)
            BuscaIDEnCombo(cmbLibero, .IdAprobo)
            BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)

            'If Not (cmbLibero.Items.FindByValue(myPedido.IdAprobo.ToString) Is Nothing) Then
            '    cmbLibero.Items.FindByValue(myPedido.IdAprobo.ToString).Selected = True
            '    cmbLibero.Enabled = False
            '    btnLiberar.Enabled = False
            'End If

            txtLugarEntrega.Text = .LugarEntrega
            txtObservaciones.Text = .Observaciones
            txtAclaracionDeCondicionDeCompra.Text = .DetalleCondicionCompra

            txtLibero.Text = .Aprobo


            BuscaIDEnCombo(cmbMoneda, .IdMoneda)


            txtCotizacionDolar.Text = .CotizacionDolar
            txtConversionPesos.Text = .CotizacionMoneda
            'en el campo CotizacionDolar SIEMPRE va la cotizacion del dolar del dia

            'en el campo CotizacionMoneda, si la NP esta en pesos siempre va 1
            'si la cotizacion esta en otra moneda va la cotizacion del dia de esa moneda (Si la NP es en dolares ese campo seria igual al de CotizacionDolar)


            txtContacto.Text = .Contacto
            txtLicitacion.Text = .NumeroLicitacion
            BuscaIDEnCombo(cmbTipoCompra, .TipoCompra)
            BuscaIDEnCombo(cmbPedidoAbierto, .IdPedidoAbierto)
            Try
                BuscaIDEnCombo(cmbSubcontrato, .Subcontrato)            'txtSubcontrato.Text = .Subcontrato

            Catch ex As Exception

            End Try

            'datos adicionales
            txtImportante.Text = .Importante
            txtPlazoEntrega.Text = .PlazoEntrega
            txtLugarEntrega.Text = .LugarEntrega
            txtFormaPago.Text = .FormaPago
            'txtImputacionContable.Text      '.Imputaciones = 
            '.Inspecciones=
            txtGarantia.Text = .Garantia
            txtDocumentacion.Text = .Documentacion
            '.clau

            ProntoCheckSINO(.ImprimeImportante, chkImportante)
            ProntoCheckSINO(.ImprimePlazoEntrega, chkPlazoEntrega)
            ProntoCheckSINO(.ImprimeLugarEntrega, chkLugarEntrega)
            ProntoCheckSINO(.ImprimeFormaPago, chkFormaPago)
            '.ImprimeImputaciones = txtImputacionContable.Text
            '.ImprimeInspecciones=
            ProntoCheckSINO(.ImprimeGarantia, chkGarantia)
            ProntoCheckSINO(.ImprimeDocumentacion, chkDocumentacion)



            lblDescOtrosConceptos1.Text = TraerValorParametro2(SC, eParam2.Pedidos_DescripcionOtrosConceptos1)
            lblDescOtrosConceptos2.Text = TraerValorParametro2(SC, eParam2.Pedidos_DescripcionOtrosConceptos2)
            lblDescOtrosConceptos3.Text = TraerValorParametro2(SC, eParam2.Pedidos_DescripcionOtrosConceptos3)
            lblDescOtrosConceptos4.Text = TraerValorParametro2(SC, eParam2.Pedidos_DescripcionOtrosConceptos4)
            lblDescOtrosConceptos5.Text = TraerValorParametro2(SC, eParam2.Pedidos_DescripcionOtrosConceptos5)
            txtOtrosConceptos1.Text = .OtrosConceptos1
            txtOtrosConceptos2.Text = .OtrosConceptos2
            txtOtrosConceptos3.Text = .OtrosConceptos3
            txtOtrosConceptos4.Text = .OtrosConceptos4
            txtOtrosConceptos5.Text = .OtrosConceptos5



            UpdatePanelEncabezado.Update() 'por ahora solo incluye el combo del proveedor, porque tuve problemas para incluir todo el resto del encabezado
        End With
    End Sub



    Sub DeObjetoHaciaPagina(ByVal myPedido As Pronto.ERP.BO.Pedido)
        RecargarEncabezado(myPedido)

        GridView1.DataSource = myPedido.Detalles
        GridView1.DataBind()
    End Sub



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            Dim mOk As Boolean
            Page.Validate("Encabezado")
            mOk = Page.IsValid

            If Not IsDate(txtFechaPedido.Text) Then
                'lblFecha.Visible = True
                mOk = False
            End If

            'cómo puedo saber si tiene renglones, si los datos estan en el ViewState?

            'If myPedido.Detalles Is Nothing Then
            '    MsgBoxAjax(me,"no tiene detalle")
            '    mOk = False
            'End If

            'Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
            'If myPedido.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
            '    MsgBoxAjax(me,"Está editando pero el comprobante no tiene detalle. Hay algo mal")
            '    Exit Sub
            'End If




            If mOk Then
                If Not mAltaItem Then
                    Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
                    With myPedido
                        .Numero = Convert.ToInt32(txtNumeroPedido.Text)
                        .SubNumero = Val(txtSubnumeroPedido.Text)
                        .Fecha = Convert.ToDateTime(txtFechaPedido.Text)
                        .IdProveedor = BuscaIdProveedorPreciso(txtDescArt.Text, SC)
                        .IdAprobo = IIf(txtLibero.Text <> "" And txtLibero.Text <> "Password Incorrecta", Convert.ToInt32(cmbLibero.SelectedValue), 0)
                        If .IdAprobo > 0 And .FechaAprobacion = DateTime.MinValue Then .FechaAprobacion = Now

                        .LugarEntrega = Convert.ToString(txtLugarEntrega.Text)
                        .Observaciones = Convert.ToString(txtObservaciones.Text)
                        .DetalleCondicionCompra = txtAclaracionDeCondicionDeCompra.Text

                        'If InStr(.Observaciones, "<ProntoWeb>") = 0 Then .Observaciones &= " <ProntoWeb>"
                        .ModificadoPorWeb = "SI"
                        .IdComprador = Convert.ToInt32(cmbComprador.SelectedValue)
                        .IdCondicionCompra = Convert.ToInt32(cmbCondicionCompra.SelectedValue)


                        .IdMoneda = Val(cmbMoneda.SelectedValue)
                        .CotizacionDolar = txtCotizacionDolar.Text
                        .CotizacionMoneda = txtConversionPesos.Text
                        'en el campo CotizacionDolar SIEMPRE va la cotizacion del dolar del dia

                        'en el campo CotizacionMoneda, si la NP esta en pesos siempre va 1
                        'si la cotizacion esta en otra moneda va la cotizacion del dia de esa moneda (Si la NP es en dolares ese campo seria igual al de CotizacionDolar)


                        .Contacto = txtContacto.Text
                        .NumeroLicitacion = txtLicitacion.Text
                        .TipoCompra = Val(cmbTipoCompra.SelectedValue)
                        .IdPedidoAbierto = Val(cmbPedidoAbierto.SelectedValue)
                        .Subcontrato = Val(cmbSubcontrato.SelectedValue) 'txtSubcontrato.Text

                        'datos adicionales
                        .Importante = txtImportante.Text
                        .PlazoEntrega = txtPlazoEntrega.Text
                        .LugarEntrega = txtLugarEntrega.Text
                        .FormaPago = txtFormaPago.Text
                        '.Imputaciones = txtImputacionContable.Text
                        '.Inspecciones=
                        .Garantia = txtGarantia.Text
                        .Documentacion = txtDocumentacion.Text
                        '.clau

                        .ImprimeImportante = ProntoCheckSINO(chkImportante)
                        .ImprimePlazoEntrega = ProntoCheckSINO(chkPlazoEntrega)
                        .ImprimeLugarEntrega = ProntoCheckSINO(chkLugarEntrega)
                        .ImprimeFormaPago = ProntoCheckSINO(chkFormaPago)
                        '.ImprimeImputaciones = txtImputacionContable.Text
                        '.ImprimeInspecciones=
                        .ImprimeGarantia = ProntoCheckSINO(chkGarantia)
                        .ImprimeDocumentacion = ProntoCheckSINO(chkDocumentacion)
                        '.clau


                        .IdPedidoAbierto = Val(cmbPedidoAbierto.SelectedValue)


                        .OtrosConceptos1 = StringToDecimal(txtOtrosConceptos1.Text)
                        .OtrosConceptos2 = StringToDecimal(txtOtrosConceptos2.Text)
                        .OtrosConceptos3 = StringToDecimal(txtOtrosConceptos3.Text)
                        .OtrosConceptos4 = StringToDecimal(txtOtrosConceptos4.Text)
                        .OtrosConceptos5 = StringToDecimal(txtOtrosConceptos5.Text)



                        .ImpuestosInternos = StringToDecimal(txtImpuestosInternos.Text)


                        'TO DO
                        '.Fecha = #1/1/2009#
                        '.FechaAnulacion = #1/30/2009#
                        '.FechaAprobacion = #1/1/2009#
                        '.FechaDadoPorCumplido = #1/1/2009#
                        '.FechaImportacionTransmision = #1/1/2009#
                        '.FechaSalida = #1/1/2009#

                        '.IdMoneda = 1
                    End With


                    'If myPedido.Id = -1 Then
                    'no, esto asi no va, porque quizas puse un numero explicito.
                    '    lo que deberia hacer es fijarse si ya existe en la base
                    'TomarProximoNumero()
                    If ExisteEsteNumero(SC, myPedido.Numero, myPedido.SubNumero, myPedido.Id) Then
                        Dim nuevonum = ProximoNumeroPedido(SC)
                        MsgBoxAjax(Me, "El número de pedido " & myPedido.Numero & " ya existe, se actualiza a " & nuevonum & ". Intente grabar de nuevo")
                        myPedido.Numero = nuevonum
                        txtNumeroPedido.Text = nuevonum
                        mAltaItem = False
                        'ScriptManager1.RegisterDataItem(Label2, DateTime.Now.ToString())
                        'UpdatePanel22.Update()
                        Return
                    End If

                    Dim ms As String
                    If PedidoManager.IsValid(myPedido, HFSC.Value, ms) Then
                        Try
                            If PedidoManager.Save(SC, myPedido) <= 0 Then
                                MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                                Exit Sub
                            End If
                        Catch ex As Exception
                            MsgBoxAjax(Me, ex.ToString)
                            Exit Sub
                        End Try
                    Else
                        MsgBoxAjax(Me, ms)

                        mAltaItem = False
                        Exit Sub
                    End If




                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Incremento de número en capa de UI. Evitar.Fields("

                    If IdPedido = -1 Then
                        If ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ProximoNumeroPedido, myPedido.Numero + 1) = -1 Then
                            MsgBoxAjax(Me, "Hubo un error al modificar los parámetros")
                        End If
                    End If
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                    If myPedido.Numero <> StringToDecimal(txtNumeroPedido.Text) Then
                        'EndEditing("El Pedido fue grabada con el número " & myPedido.Numero) 'me voy 
                        MsgBoxAjaxAndCerrarVentana(Me, "El Pedido fue grabado con el número " & myPedido.Numero)

                    Else
                        If False Then
                            EndEditing("Desea imprimir el comprobante?")
                        Else
                            EndEditing()
                        End If

                    End If

                Else
                    MsgBoxAjax(Me, "El objeto no es válido")
                    Exit Sub
                End If
            Else
                MsgBoxAjax(Me, "El objeto no es válido")
                mAltaItem = False
                'LblInfo.Visible = False
                'PanelInfo.Visible = True
                'PanelInfoNum.Visible = True
            End If


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, ex.ToString)
            Exit Sub
        Finally
            btnSave.Visible = True
            btnSave.Enabled = True
        End Try


    End Sub




    Protected Sub ActualizaDetalle()
        Dim Id As Long
        'Id = Convert.ToInt32(SelectedReceiver.Value)
        If Id > 0 Then
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", Id)
            If ds.Tables(0).Rows.Count > 0 Then
                'txtCodigo.Text = ds.Tables(0).Rows(0).Item("Codigo").ToString
            End If
        End If

    End Sub


    Protected Sub btnLiberar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
        Dim mOk As Boolean
        Page.Validate("Encabezado")
        mOk = Page.IsValid

        Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
        If Not PedidoManager.IsValid(myPedido, HFSC.Value) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
            mOk = False
            MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
        End If
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

                    If btnLiberar.Text <> "Anular liberación" And btnLiberar.Text <> "Anular firmas" Then
                        txtLibero.Text = ds.Tables(0).Rows(0).Item("Nombre").ToString
                        btnLiberar.Enabled = False
                    ElseIf btnLiberar.Text = "Anular firmas" Then

                        'si es con firmas,  tiene que borrar las firmas,  aumentar el subnumero, grabar el comprobante y tomarselas
                        Try
                            EntidadManager.GetStoreProcedure(SC, "AutorizacionesPorComprobante_EliminarFirmas", EnumFormularios.NotaPedido, IdEntity, -1, cmbLibero.SelectedValue)
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try
                        Try
                            GetStoreProcedure(SC, enumSPs.Pedidos_ActualizarEstadoPorIdPedido, IdEntity)
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try

                        Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
                        myPedido.SubNumero += 1
                        myPedido.IdAprobo = 0
                        PedidoManager.Save(SC, myPedido)
                        EndEditing()
                    Else
                        'deslibera
                        txtLibero.Text = ""
                        btnLiberar.Text = "Liberar"
                        btnLiberar.Enabled = False
                        btnSave.Visible = True
                        btnSave.Enabled = True
                    End If

                Else
                    txtLibero.Text = "PassWord incorrecta"
                End If
            End If
        End If

    End Sub


    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////


    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    ' Refrescos del autocomplete
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub SelectedReceiver_ServerChange(ByVal sender As Object, ByVal e As System.EventArgs) Handles SelectedReceiver.ServerChange
        btnTraerDatos_Click(Nothing, Nothing)
    End Sub

    'Este es el AC del proveedor
    Protected Sub btnTraerDatos_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDescArt.TextChanged
        If Not TraerDatosProveedor(SelectedReceiver.Value) Then
            'cmbCondicionIVA.Enabled = True
            'txtCUIT.Enabled = True
            If SelectedReceiver.Value <> "" Then 'acaban de cambiar un proveedor existente por un alta al vuelo
                SelectedReceiver.Value = ""

                'cmbCondicionIVA.SelectedValue = -1
                'txtCUIT.Text = ""
            End If
        Else
            'cmbCondicionIVA.Enabled = False
            'txtCUIT.Enabled = False
        End If
    End Sub


    'Este es el AC del articulo
    Protected Sub btnTraerDatosArticulo_Click(ByVal sender As Object, ByVal e As System.EventArgs) _
    Handles btnTraerDatos.Click, txt_AC_Articulo.TextChanged '




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







    Function TraerDatosProveedor(ByVal IdProveedor As String) As Boolean 'es string porque el hidden con el ID puede ser ""
        Dim myProveedor As New Pronto.ERP.BO.Proveedor

        '////////////////////////////////
        'Busco el proveedor
        '////////////////////////////////

        If iisNumeric(IdProveedor, 0) <> 0 Then
            'Busco el ID

            myProveedor = ProveedorManager.GetItem(SC, SelectedReceiver.Value)
            If myProveedor Is Nothing Then Return False

            txtDescArt.Text = myProveedor.RazonSocial
        Else
            'Usa el mismo criterio de busqueda del AUTOCOMPLETE

            'Dim l As ProveedorList = ProveedorManager.GetListParaWebService(SC, txtDescArt.Text)
            ''l.Find()
            'If l Is Nothing Then Exit Function
            'For Each myProveedor In l
            '    If myProveedor.RazonSocial = txtDescArt.Text Then Exit For
            'Next

            'BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value)
            IdProveedor = BuscaIdProveedorPreciso(IdProveedor, SC)
            myProveedor = ProveedorManager.GetItem(SC, IdProveedor)
        End If



        '////////////////////////////////
        '////////////////////////////////
        '////////////////////////////////

        'lleno los datos

        If myProveedor IsNot Nothing AndAlso myProveedor.RazonSocial = txtDescArt.Text Then 'si lo encontré
            With myProveedor
                'txtCUIT.Text = .Cuit
                'BuscaIDEnCombo(cmbCondicionIVA, .IdCodigoIva)
                'If cmbCondicionIVA.SelectedValue = -1 Then BuscaIDEnCombo(cmbCondicionIVA, 1) 'por si no encuentra la condicion (me quedaría el combo sin cargar y disabled)

                '///////////////////////////////////////////
                'estos campos solo los debo traer si cambiaron el proveedor explícitamente, y no 
                'en la carga de datos antes de editar -y cómo hago? -bueno, si llamas a la funcion
                'desde el EditarSetup(), que la carga de estos combos venga después
                BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)
                BuscaIDEnCombo(cmbMoneda, .IdMoneda)
                '///////////////////////////////////////////

                'If txtLetra.Text = "" Then
                If .IdCodigoIva = 0 Then
                    'txtLetra.Text = "B"  ' y "C"?
                ElseIf .IdCodigoIva = 1 Then
                    'txtLetra.Text = "A"
                Else
                    'txtLetra.Text = "C"
                End If
                'End If

                txtDatosProveedor.Text = .Direccion & "<br/>" & .Localidad & "<br/>" & .Provincia & "<br/>" & .Telefono1 & "<br/>" & .Email & "<br/>" & .CodigoIva
                txtContacto.Text = .Contacto

            End With



            '////////////////////////////////
            'traigo los datos del ultimo comprobante del proveedor
            'Dim dsTemp As System.Data.DataSet
            'dsTemp = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Presupuestos", "TX_UltimoComprobantePorIdProveedor", SelectedReceiver.Value)
            'If dsTemp.Tables(0).Rows.Count > 0 Then
            '    With dsTemp.Tables(0).Rows(0)
            '        'estos se tocan solo si estan vacios
            '        'If txtCAI.Text = "" Then txtCAI.Text = iisNull(.Item("NumeroCAI"))
            '        'If txtFechaVtoCAI.Text = "" Then txtFechaVtoCAI.Text = iisNull(.Item("FechaVencimientoCAI"))
            '    End With

            'End If

            '////////////////////////////////


            If myProveedor.Cuit <> "" Then Return True
        End If

        '////////////////////////////////

        Return False 'no lo encontré
    End Function













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
            Dim a = ArticuloManager.GetItem(SC, IdArticulo)
            txt_AC_Articulo.Text = a.Descripcion
            'BuscaIDEnCombo(cmbDetUnidades, UnidadPorIdArticulo(IdArticulo, SC))
            SelectedAutoCompleteIDArticulo.Value = IdArticulo

            LlenoComboDeUnidades(SC, cmbDetUnidades, IdArticulo)
            txtCodigo.Text = ArticuloManager.GetItem(SC, IdArticulo).Codigo
            '////////////////////////////////


            'If mvarId = -1 Then
            '    If IsNull(.Fields("Observaciones").Value) Then
            '        .Fields("Observaciones").Value = oArt.CadenaSubitems
            '    Else
            '        .Fields("Observaciones").Value = .Fields("Observaciones").Value & vbCrLf & oArt.CadenaSubitems
            '    End If
            'End If
            'If mTipoCosto = "CostoPPP" Then
            '    .Fields("Costo").Value = oRs.Fields("CostoPPP").Value
            'Else
            '    .Fields("Costo").Value = oRs.Fields("CostoReposicion").Value
            'End If
            'If Not IsNull(oRs.Fields("IdCuantificacion").Value) Then

            'End If
            'If Not IsNull(oRs.Fields("IdCuenta").Value) And mvarId = -1 Then
            '    origen.Registro.Fields("IdCuenta").Value = oRs.Fields("IdCuenta").Value
            'End If

            'If (a.AlicuotaIVA) Then 'And mExterior <> "SI" Then
            txtDetIVA.Text = a.AlicuotaIVA
            'End If
        Else
            'Usa el mismo criterio de busqueda del AUTOCOMPLETE

            'Dim l As ArticuloList = ArticuloManager.GetListParaWebService(SC, txt_AC_Articulo.Text)
            Dim l As DataTable = EntidadManager.ExecDinamico(SC, "SELECT TOP 100 IdArticulo,Descripcion FROM Articulos WHERE Descripcion LIKE '" & txt_AC_Articulo.Text & "%'")

            If l Is Nothing Or l.Rows.Count = 0 Then
                txtCodigo.Text = ""
                txt_AC_Articulo.Text = "" 'lo vacío así se activa el validador
                SelectedAutoCompleteIDArticulo.Value = 0
                Return False
            Else
                Dim myArticulo As Pronto.ERP.BO.Articulo
                myArticulo = ArticuloManager.GetItem(SC, l.Rows(0).Item("IdArticulo"))
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


    'Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ButBuscaArticulos.Click

    '    'Dim idFormulario As Integer
    '    'Dim but As ImageButton 'en lugar de Button 
    '    'but = DirectCast(e.Row.FindControl("ButBuscaArticulos"), ImageButton)
    '    'idFormulario = Convert.ToUInt32(DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("IdFormulario").ToString)
    '    'Dim db As String = DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("BD").ToString
    '    'but.CommandArgument = idFormulario.ToString + "#"
    '    'but.CommandArgument += DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("IdComprobante").ToString + "#"
    '    'but.CommandArgument += db
    '    'Dim idComprobante As String = DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("IdComprobante").ToString

    '    ButBuscaArticulos.OnClientClick = String.Format("javascript:ShowBuscaArticulos('{0}','{1}', elPed); return false;", 0, 0) 'idComprobante, db)

    'End Sub


    Private Sub GetPedidoAjax(ByVal idPedido As Integer, ByVal empresaName As String)
        'Dim myPedido As Pronto.ERP.BO.Pedido
        'Dim sc As String = GetSC(empresaName)
        'If idPedido > 0 Then
        '    myPedido = PedidoManager.GetItem(sc, idPedido, True)
        '    If Not (myPedido Is Nothing) Then
        '        lblNumero.Text = myPedido.Numero
        '        lblFecha.Text = myPedido.Fecha.ToString("dd/MM/yyyy")
        '        LblContacto.Text = myPedido.Contacto
        '        lblObra.Text = myPedido.Obras
        '        LlblLiberado.Text = myPedido.Aprobo
        '        LblCondCompra.Text = myPedido.CondicionCompra
        '        LblCompador.Text = myPedido.Comprador
        '        LblAclaracion.Text = myPedido.DetalleCondicionCompra
        '        LblMoneda.Text = myPedido.Moneda & " (Cotiz.u$s : " & myPedido.CotizacionDolar & ")"
        '        lblMon4.Text = myPedido.Moneda
        '        LblNroComparativa.Text = myPedido.NumeroComparativa
        '        lblObservaciones.Text = myPedido.Observaciones
        '        lblSubtotal.Text = Format(myPedido.TotalPedido - myPedido.ImpuestosInternos - myPedido.TotalIva1, "#,##0.00")
        '        lblIVA.Text = Format(myPedido.TotalIva1, "#,##0.00")
        '        lblImpInt.Text = Format(myPedido.ImpuestosInternos, "#,##0.00")
        '        lblTotal.Text = Format(myPedido.TotalPedido, "#,##0.00")

        '        GVPedidoItems.DataSource = myPedido.Detalles
        '        GVPedidoItems.DataBind()
        '        ProveedoreshowData(myPedido.IdProveedor, sc)
        '    End If
        'End If

        'Dim html As String = GetHtml(GridView1, BuscaArticulos)
        'Response.Write(html)
        'Response.End()
    End Sub

    Function GetHtml(ByVal gv As GridView, ByVal panel As Panel) As String
        Dim sb As StringBuilder = New StringBuilder()
        Dim tw As StringWriter = New StringWriter(sb)
        Dim hw As HtmlTextWriter = New HtmlTextWriter(tw)
        Dim page As Page = New Page()
        Dim form As HtmlForm = New HtmlForm()

        page.EnableEventValidation = False
        page.Controls.Add(form)
        form.Controls.Add(gv)
        'panelGrilla.Controls.Add(form)
        panel.Visible = True

        panel.RenderControl(hw)
        panel.Visible = False
        Return sb.ToString
    End Function

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub




    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        'ObjGrillaConsulta.SelectMethod = "GetListTX"
        'ObjGrillaConsulta.TypeName = "Pronto.ERP.Bll.RequerimientoManager"
        'ObjGrillaConsulta.SelectParameters.Add("TX", "PendientesDeFirma")
        'ObjGrillaConsulta.SelectParameters.Add("Parametros", "")
        'ObjGrillaConsulta.Update()
        'UpdatePanelGrillaConsulta.Update()
        gridPresupuestos.DataBind()
        ModalPopupExtender4.Show()
    End Sub



    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    'Grilla Popup de Consulta de items de RMs pendientes
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub ObjectDataSource3_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource3.Selecting
        'En caso de que necesite pasarle parametros
        e.InputParameters("Parametros") = New String() {"P"}

        'solo dejo que se enlace si llamaron explicitamente al popup
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        If txtBuscar.Text = "" Then 'para que no busque estos datos si no fueron pedidos explicitamente
            e.Cancel = True
        End If
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        RebindGridAuxRMs()


    End Sub










    Function GenerarWHERErms() As String
        Return "Convert([Req_Nro_], 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Function


    Protected Sub lnkActualizarPendientes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkActualizarPendientes.Click
        RequerimientoManager.RecalcularPendientes1(SC)
        RebindGridAuxRMs()
        ModalPopupExtender6.Show()
    End Sub

    Sub RebindGridAuxRMs()
        With gridRMsParaComprar


            Dim pageIndex = .PageIndex
            'ObjectDataSource3.FilterExpression = GenerarWHERErms()

            Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes1(SC)
            dt = DataTableWHERE(dt, GenerarWHERErms())
            Dim b As Data.DataView = DataTableORDER(dt, "IdDetalleRequerimiento DESC") 'ObjectDataSource3.Select()
            'b.Sort = "IdDetalleRequerimiento DESC"
            ViewState("Sort") = b.Sort
            .DataSourceID = ""
            .DataSource = b
            .DataBind()
            .PageIndex = pageIndex


        End With
    End Sub



    Protected Sub gridRMsParaComprar_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gridRMsParaComprar.PageIndexChanging
        gridRMsParaComprar.PageIndex = e.NewPageIndex
        RebindGridAuxRMs()
    End Sub





















    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'restauro el objeto a partir del viewstate
        Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        With gridRMsParaComprar
            For Each fila As GridViewRow In .Rows
                If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                    chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                    If chkFirmar.Checked Then

                        '///////////////////////////////////////////////////////////
                        '///////////////////////////////////////////////////////////
                        'Cargo el renglon (si no me bastan los datos que ya tengo en la grilla)
                        '
                        'La coleccion Grilla.DataKeys(fila.RowIndex).Values.Item(0) tiene las keys de la grilla. 
                        'Para las columnas, usá Grilla.Rows(fila).Cells(col)
                        '///////////////////////////////////////////////////////////
                        '///////////////////////////////////////////////////////////


                        Dim idRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdAux2")
                        Dim oRM As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idRM, True)
                        Dim oDetRM As RequerimientoItem
                        Dim idDetRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleRequerimiento")
                        'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)


                        '///////////////////////////////////////////////////////////
                        'Si copio de varios RMs, de cual copio los datos de encabezado, 
                        'myPedido.IdPlazoEntrega=oRM.
                        'myPedido.Validez=oRM.
                        'oDetRM.Id
                        '///////////////////////////////////////////////////////////


                        '///////////////////////////////////////////////////////////
                        'lo pongo en la solicitud  
                        'migrado de frmPresupuesto.Lista.OLEDragDrop()
                        '///////////////////////////////////////////////////////////

                        'me fijo si ya existe en el detalle
                        If myPedido.Detalles.Find(Function(obj) obj.IdDetalleRequerimiento = idDetRM) Is Nothing Then

                            Dim mItem As PedidoItem = New Pronto.ERP.BO.PedidoItem
                            With mItem
                                .Id = myPedido.Detalles.Count
                                .Nuevo = True
                                '.FechaEntrega = ProntoFuncionesGenerales.iisValidSqlDate(txtDetFechaEntrega.Text)

                                '.IdArticulo = oDetRM.IdArticulo
                                '.Cantidad = StringToDecimal(oDetRM.Cantidad)
                                '.IdDetalleRequerimiento = oDetRM.Id




                                '.Precio = 
                                '.PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
                                '.PorcentajeIVA = StringToDecimal(txtDetIVA.Text)
                                '.ImporteTotalItem = StringToDecimal(txtDetTotal.Text)


                                Dim oRsDet As Data.DataSet
                                oRsDet = RequerimientoManager.GetListTX(SC, "_DatosRequerimiento", idDetRM) 'este sp trae datos del DETALLE de requerimientos (el parametro es un IdDetalleRequerimiento)
                                With oRsDet.Tables(0).Rows(0)
                                    If IsNull(.Item("Aprobo")) Then
                                        MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " no fue liberado")
                                        Continue For
                                    End If
                                    If IIf(IsNull(.Item("CumplidoReq")), "NO", .Item("CumplidoReq")) = "SI" Or _
                                          IIf(IsNull(.Item("CumplidoReq")), "NO", .Item("CumplidoReq")) = "AN" Then
                                        MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " ya esta cumplido")
                                        Continue For
                                    End If
                                    If Not CircuitoFirmasCompleto(SC, EntidadManager.EnumFormularios.RequerimientoMateriales, .Item("IdRequerimiento")) Then
                                        MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " no tiene completo el circuito de firmas")
                                        Continue For
                                    End If
                                    If IIf(IsNull(.Item("Cumplido")), "NO", .Item("Cumplido")) = "SI" Or _
                                          IIf(IsNull(.Item("Cumplido")), "NO", .Item("Cumplido")) = "AN" Then
                                        'MsgBoxAjax(Me, "El requerimiento " & oRs.item("NumeroRequerimiento") & " item " & .Item("NumeroItem") & " ya esta cumplido", vbExclamation)
                                        Continue For
                                    End If

                                    If iisNull(.Item("TipoDesignacion"), "") = "S/D" Then
                                        MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " está sin designar")
                                        Continue For
                                    End If

                                    .Item("TipoDesignacion") = iisNull(.Item("TipoDesignacion"))
                                    If iisNull(.Item("TipoDesignacion")) = "" Or _
                                          .Item("TipoDesignacion") = "CMP" Or _
                                          (.Item("TipoDesignacion") = "STK" And .Item("SalidaPorVales") < iisNull(.Item("Cantidad"), 0)) Or _
                                          (.Item("TipoDesignacion") = "REC" And .Item("IdObra") = ProntoParamOriginal(SC, "IdObraStockDisponible") And _
                                           .Item("SalidaPorVales") < iisNull(.Item("Cantidad"), 0)) Then

                                        mItem.NumeroItem = myPedido.Detalles.Count
                                        If .Item("TipoDesignacion") = "STK" Then
                                            mItem.Cantidad = IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad")) - .Item("SalidaPorVales")
                                        Else
                                            mItem.Cantidad = IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad")) - .Item("Pedido")
                                        End If
                                        mItem.IdUnidad = .Item("IdUnidad")
                                        mItem.IdArticulo = .Item("IdArticulo")
                                        mItem.Articulo = .Item("DescripcionArt")
                                        'mItem.Cantidad1 = iisNull(.Item("Cantidad1"), 0)
                                        'mItem.Cantidad2 = iisNull(.Item("Cantidad2"), 0)
                                        'mItem.Adjunto = iisNull(.Item("Adjunto"), "")
                                        mItem.FechaEntrega = iisNull(.Item("FechaEntrega"), "")
                                        mItem.Precio = 0
                                        mItem.IdDetalleRequerimiento = .Item("IdDetalleRequerimiento")
                                        mItem.Observaciones = .Item("Observaciones")
                                        mItem.IdDetalleLMateriales = iisNull(.Item("IdDetalleLMateriales"), 0)
                                        mItem.IdCuenta = iisNull(.Item("IdCuenta"), 0)
                                        'mItem.IdCentroCosto = iisNull(.Item("IdCentroCosto"), 0)
                                        mItem.OrigenDescripcion = IIf(IsNull(.Item("OrigenDescripcion")), 1, .Item("OrigenDescripcion"))
                                        For i = 0 To 9
                                            'mItem.(ArchivoAdjunto" & i + 1) =  .item("ArchivoAdjunto" & i + 1)
                                        Next
                                        mItem.PorcentajeIVA = .Item("AlicuotaIVA")
                                        mItem.ImporteIVA = mItem.Precio * mItem.Cantidad * mItem.PorcentajeIVA / 100
                                        mItem.ImporteTotalItem = mItem.Precio * mItem.Cantidad + mItem.ImporteIVA



                                    End If
                                End With











                            End With
                            myPedido.Detalles.Add(mItem)
                        Else
                            MsgBoxAjax(Me, "El renglon de requerimiento " & idDetRM & " ya está en el detalle")
                        End If


                    End If
                End If
            Next
        End With


        Me.ViewState.Add(mKey, myPedido)
        GridView1.DataSource = myPedido.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()

    End Sub

    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    'Popup con Grilla de Presupuestos
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub ObjGrillaConsulta_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjGrillaConsulta.Selecting
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        If TextBox3.Text = "" Then 'para que no busque estos datos si no fueron pedidos explicitamente
            e.Cancel = True
        End If
    End Sub

    Protected Sub TextBox3_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox3.TextChanged
        RebindGridAuxCopiaPresupuesto()
    End Sub




    Function GenerarWHERE() As String
        Return "Convert(Numero, 'System.String') LIKE '*" & TextBox3.Text & "*'" _
                                       & " OR " & _
                                       "Convert(Proveedor, 'System.String') LIKE '*" & TextBox3.Text & "*'"
    End Function



    Sub RebindGridAuxCopiaPresupuesto()
        With gridPresupuestos


            Dim pageIndex = .PageIndex

            'Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes(SC) ' EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
            '.DataSource = DataTableORDER(dt, "IdDetalleRequerimiento DESC")
            'dt = DataTableWHERE(dt, GenerarWHERE)
            Dim b As Data.DataView = ObjGrillaConsulta.Select()
            'b.Sort = "IdDetalleRequerimiento DESC"
            ViewState("Sort") = b.Sort
            .DataSourceID = ""
            .DataSource = b
            .DataBind()
            .PageIndex = pageIndex


        End With
    End Sub



    Protected Sub gridPresupuestos_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gridPresupuestos.PageIndexChanging
        gridPresupuestos.PageIndex = e.NewPageIndex
        RebindGridAuxCopiaPresupuesto()
    End Sub






    Protected Sub btnAceptarPopupGrilla_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAceptarPopupGrilla.Click

        'restauro el objeto a partir del viewstate
        Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String

        'Dim fila As GridViewRow = gridPresupuestos.SelectedRow

        '///////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////
        'Cargo el renglon (si no me bastan los datos que ya tengo en la grilla)
        '
        'La coleccion Grilla.DataKeys(fila.RowIndex).Values.Item(0) tiene las keys de la grilla. 
        'Para las columnas, usá Grilla.Rows(fila).Cells(col)
        '///////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////
        For Each fila As GridViewRow In gridPresupuestos.Rows
            If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                If chkFirmar.Checked Then

                    Dim idPresu As Integer = gridPresupuestos.DataKeys(fila.RowIndex).Values.Item("IdPresupuesto")
                    Dim oPresu As Pronto.ERP.BO.Presupuesto = PresupuestoManager.GetItem(SC, idPresu, True)
                    Dim oDetPresu As PresupuestoItem
                    Dim idDetPresu As Integer = gridPresupuestos.DataKeys(fila.RowIndex).Values.Item("IdDetalleRequerimiento")
                    'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)



                    '///////////////////////////////////////////////////////////
                    'lo pongo en la comparativa
                    'migrado de frmComparativa.MSFlexGrid1_OLEDragDrop.OLEDragDrop()
                    '///////////////////////////////////////////////////////////

                    'me fijo si ya existe 

                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    'Acá se fija si el precio de un item de un presupuesto que
                    ' ya estaba presente no haya cambiado???
                    'With oRsDetPre
                    '    If .RecordCount > 0 Then
                    '        Do While Not .EOF
                    '            mError = False
                    '            oRsDetPreCopia.MoveFirst()
                    '            Do While Not oRsDetPreCopia.EOF
                    '                If oRsDetPreCopia.Fields("IdArticulo").Value = .Fields("IdArticulo").Value And _
                    '                   oRsDetPreCopia.Fields("OrigenDescripcion").Value = .Fields("OrigenDescripcion").Value And _
                    '                   (.Fields("OrigenDescripcion").Value = 1 Or _
                    '                    (.Fields("OrigenDescripcion").Value >= 2 And oRsDetPreCopia.Fields("Observaciones").Value = .Fields("Observaciones").Value)) Then
                    '                    If oRsDetPreCopia.Fields("Prec.Unit.").Value <> .Fields("Prec.Unit.").Value Then
                    '                        mError = True
                    '                        Exit Do
                    '                    End If
                    '                End If
                    '                oRsDetPreCopia.MoveNext()
                    '            Loop
                    '            If mError Then
                    '                MsgBox("Los items " & .Fields("Item").Value & " y " & _
                    '                         oRsDetPreCopia.Fields("Item").Value & " del presupuesto son iguales" & vbCrLf & _
                    '                         "y tienen precios diferentes, la solicitud no sera incorporada", vbExclamation)
                    '                GoTo Salida
                    '            End If
                    '            .MoveNext()
                    '        Loop
                    '        .MoveFirst()
                    '    End If
                    '    oRsDetPreCopia.Close()
                    'End With
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////////////////////

                    'Primero me fijo si el presupuesto se importó alguna vez
                    If myPedido.Detalles Is Nothing OrElse myPedido.Detalles.Find(Function(obj) obj.IdDetalleRequerimiento = idPresu) Is Nothing Then

                        For Each oDetPresu In oPresu.Detalles

                            With oDetPresu
                                Dim mEsta As Boolean = False
                                Dim mCantidad = 0

                                '////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////
                                'Se fija si encuentra el mismo IdPresupuesto+ IdArticulo+Precio+OrigenDescripcion+etc... y 
                                'pone la bandera mEsta en TRUE
                                If myPedido.Detalles IsNot Nothing Then
                                    For Each oDetCompa In myPedido.Detalles
                                        If Not .Eliminado Then
                                            If .IdPresupuesto = oDetPresu.IdPresupuesto And _
                                               .IdArticulo = oDetPresu.IdArticulo And _
                                               .Precio = oDetPresu.Precio And _
                                               oDetCompa.OrigenDescripcion = oDetPresu.OrigenDescripcion And _
                                               (IsNull(oDetCompa.OrigenDescripcion Or oDetCompa.OrigenDescripcion = 1 Or _
                                                (oDetCompa.OrigenDescripcion >= 2 And oDetCompa.Observaciones = oDetPresu.Observaciones))) Then

                                                mEsta = True
                                                Dim mIdDet = oDetCompa.Id
                                                mCantidad = oDetCompa.Cantidad
                                                Exit For
                                            End If
                                        End If
                                    Next
                                End If

                                'Si lo encontró en el IF de arriba, lo asigna
                                If Not mEsta Then
                                    Dim oDetCompa2 As New PedidoItem
                                    With oDetCompa2
                                        '.IdPresupuesto = oPresu.Id
                                        '.IdDetallePresupuesto = oDetPresu.Id
                                        '.NumeroPresupuesto = oPresu.Numero
                                        '.SubNumero = oPresu.SubNumero
                                        '.FechaPresupuesto = oPresu.FechaIngreso
                                        '.IdMoneda = oPresu.IdMoneda

                                        .IdArticulo = oDetPresu.IdArticulo
                                        .Articulo = oDetPresu.Articulo
                                        .Cantidad = oDetPresu.Cantidad
                                        .Precio = oDetPresu.Precio
                                        .PorcentajeBonificacion = oDetPresu.PorcentajeBonificacion
                                        .IdUnidad = oDetPresu.IdUnidad
                                        .OrigenDescripcion = oDetPresu.OrigenDescripcion
                                        '.CotizacionMoneda = IIf(IsNull(oPresu.CotizacionMoneda), 1, oPresu.CotizacionMoneda)

                                        'observaciones
                                        Dim rchObs As String
                                        rchObs = IIf(IsNull(oDetPresu.Observaciones), "", oDetPresu.Observaciones)
                                        Dim mObs As String
                                        mObs = Replace(rchObs, ",", " ")
                                        mObs = Replace(mObs, ";", " ")
                                        mObs = Replace(mObs, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
                                        .Observaciones = mObs
                                    End With
                                    If myPedido.Detalles Is Nothing Then myPedido.Detalles = New PedidoItemList
                                    myPedido.Detalles.Add(oDetCompa2)
                                Else
                                    myPedido.Detalles.Item(idDetPresu).Cantidad = mCantidad + oDetPresu.Cantidad
                                End If
                            End With
                        Next
                    Else
                        MsgBoxAjax(Me, "El renglon de requerimiento " & idDetPresu & " ya está en el detalle")
                    End If
                End If
            End If
        Next


        Me.ViewState.Add(mKey, myPedido)
        'DeDetalleAGrilla(myPedido) 'si convierto el detalle a una GUI manualmente
        GridView1.DataSource = myPedido.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()
    End Sub



    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////
    'Traer Comparativas
    '////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////

    Protected Sub cmbComparativas_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbComparativas.TextChanged
        'Tengo que usar TextChanged y no SelectedIndexChange, porque en los multipresupuesto uso el mismo ID (de presupuesto)!!!!
        TraerDesdeComparativa()
    End Sub

    Public Sub TraerDesdeComparativa()
        Dim ms As String 'para guardar los datos y mostrarlos en el MsgBoxAjax

        Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido) 'la primera y ultima linea de estas funciones deben ser la reconstruccion y el grabado en el viewstate del objeto


        Dim oPre As Pronto.ERP.BO.Presupuesto
        Dim oRs As ADODB.Recordset
        Dim oRs1 As ADODB.Recordset
        Dim oRsPre As Pronto.ERP.BO.Presupuesto
        Dim oRsDet As ADODB.Recordset
        Dim oRsComp As ADODB.Recordset
        Dim oL As ListItem
        Dim idDet As Long, IdCCal As Long
        Dim i As Integer
        Dim mExiste As String, mCodigo As String, mArticulo As String, mObs As String
        Dim mImporte As Double, mIVA As Double


        'On Error GoTo Mal


        oRsComp = ConvertToRecordset(ComparativaManager.GetListTX(SC, "_PorNumero", SplitRapido(cmbComparativas.SelectedValue, ";", 0)))

        If oRsComp.RecordCount > 0 Then

            If iisNull(oRsComp.Fields("PresupuestoSeleccionado").Value, -1) = -1 Then

                'Multipresupuesto

                Dim mvarArticulo1 As String, mvarArticulo2 As String
                Dim mvarArticuloConObs As String, mvarArticuloSinObs As String
                Dim mOrigenDescripcion As Integer

                'Dim oF As frmConsulta2
                Dim mIdPresupuestoSeleccionado As Long
                'Set oF = New frmConsulta2
                'With oF
                '           .IdComparativa = oRsComp.Fields(0).Value
                '           .IdPresupuestoSeleccionado = 0
                '           .Id = 3
                '           .Show(vbModal, Me)
                '           mIdPresupuestoSeleccionado = .IdPresupuestoSeleccionado
                '       End With
                'Unload oF
                'Set oF = Nothing
                Dim s As String = TextoEntre(cmbComparativas.SelectedItem.Text, "MULTI:", " ")
                If IsNumeric(s) Then

                    mIdPresupuestoSeleccionado = Convert.ToInt32(s)

                    oRs = ConvertToRecordset(ComparativaManager.GetListTX(SC, "_PorPresupuestoSoloSeleccionados", oRsComp.Fields("IdComparativa").Value, mIdPresupuestoSeleccionado))

                    oRsPre = PresupuestoManager.GetItem(SC, mIdPresupuestoSeleccionado)
                    oRsDet = ConvertToRecordset(PresupuestoManager.GetListTX(SC, "_DetallesPorIdPresupuestoIdComparativa", _
                                               mIdPresupuestoSeleccionado, oRsComp.Fields("IdComparativa").Value))


                    'txtPresupuesto.Text = oRsPre.Fields("Numero").Value & " / " & oRsPre.Fields("SubNumero").Value

                    If IdPedido = -1 And Not IsNull(oRsPre.IdPlazoEntrega) Then
                        oRs1 = ConvertToRecordset(EntidadManager.GetListTX(SC, "PlazosEntrega", "TX_PorId", oRsPre.IdPlazoEntrega))
                        If oRs1.RecordCount > 0 Then
                            'mvarPlazoEntrega = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                        End If
                        oRs1.Close()
                    End If

                    If oRs.RecordCount > 0 Then

                        Do While Not oRs.EOF

                            mvarArticulo1 = ""
                            mvarArticuloConObs = oRs.Fields("Descripcion").Value & " [Id " & oRs.Fields("IdArticulo").Value & "]"
                            mvarArticuloSinObs = oRs.Fields("Descripcion").Value & " [Id " & oRs.Fields("IdArticulo").Value & "]"
                            If Not IsNull(oRs.Fields("Observaciones").Value) Then
                                mvarArticuloConObs = mvarArticuloConObs & " " & oRs.Fields("Observaciones").Value
                            End If
                            If Not IsNull(oRs.Fields("OrigenDescripcion").Value) Then
                                mOrigenDescripcion = oRs.Fields("OrigenDescripcion").Value
                            Else
                                mOrigenDescripcion = 1
                            End If
                            If (mOrigenDescripcion = 1 Or mOrigenDescripcion = 3) Then
                                mvarArticulo1 = mvarArticuloSinObs
                            End If
                            If mOrigenDescripcion = 2 Or mOrigenDescripcion = 3 Then
                                If Len(Trim(mvarArticulo1)) > 0 Then
                                    mvarArticulo1 = mvarArticuloConObs
                                Else
                                    mvarArticulo1 = oRs.Fields("Observaciones").Value
                                End If
                            End If

                            oRsDet.MoveFirst()
                            Do While Not oRsDet.EOF 'me paseo por los items de la comparativa para el presupuesto en cuestion

                                mvarArticulo2 = ""
                                mvarArticuloConObs = oRsDet.Fields("Descripcion").Value & " [Id " & oRsDet.Fields("IdArticulo").Value & "]"
                                mvarArticuloSinObs = oRsDet.Fields("Descripcion").Value & " [Id " & oRsDet.Fields("IdArticulo").Value & "]"
                                mObs = ""
                                If Not IsNull(oRsDet.Fields("Observaciones").Value) Then
                                    mObs = Replace(oRsDet.Fields("Observaciones").Value, ",", " ")
                                    mObs = Replace(mObs, ";", " ")
                                    mObs = Replace(mObs, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
                                    mvarArticuloConObs = mvarArticuloConObs & " " & mObs
                                End If
                                If Not IsNull(oRsDet.Fields("OrigenDescripcion").Value) Then
                                    mOrigenDescripcion = oRsDet.Fields("OrigenDescripcion").Value
                                Else
                                    mOrigenDescripcion = 1
                                End If
                                If (mOrigenDescripcion = 1 Or mOrigenDescripcion = 3) Then
                                    mvarArticulo2 = mvarArticuloSinObs
                                End If
                                If mOrigenDescripcion = 2 Or mOrigenDescripcion = 3 Then
                                    If Len(Trim(mvarArticulo2)) > 0 Then
                                        mvarArticulo2 = mvarArticuloConObs
                                    Else
                                        mvarArticulo2 = mObs
                                    End If
                                End If

                                If Mid(mvarArticulo1, 1, 1000) = Mid(mvarArticulo2, 1, 1000) Then 'es el mismo artículo?

                                    mExiste = ""
                                    If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                                        mExiste = ItemEnOtrosPedidos(SC, myPedido, oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                                    End If
                                    If Len(mExiste) > 0 Then
                                        'A diferencia de VB6, estos mensajes no los puedo mandar si son acumulables
                                        ms += "El item de la RM ya existe en el Pedido n°" & mExiste & " y no sera incluido en este pedido." & vbCrLf
                                    Else
                                        Dim mvarP_IVA1 = 100 'TO DO
                                        mIVA = Math.Round((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) * mvarP_IVA1 / 100, 4)
                                        mImporte = (oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) + mIVA

                                        'agrego un renglon al detalle
                                        Dim oDetCompa2 As New PedidoItem
                                        With oDetCompa2


                                            .Nuevo = True

                                            .NumeroItem = oRsDet.Fields("NumeroItem").Value
                                            .Cantidad = oRsDet.Fields("Cantidad").Value
                                            .IdUnidad = oRsDet.Fields("IdUnidad").Value
                                            .IdArticulo = oRsDet.Fields("IdArticulo").Value
                                            .Precio = oRsDet.Fields("Precio").Value
                                            '.Adjunto = oRsDet.Fields("Adjunto").Value
                                            '.Cantidad1 = oRsDet.Fields("Cantidad1").Value
                                            '.Cantidad2 = oRsDet.Fields("Cantidad2").Value
                                            .Observaciones = oRsDet.Fields("Observaciones").Value
                                            .IdDetalleAcopios = iisNull(oRsDet.Fields("IdDetalleAcopios").Value, -1)
                                            .IdDetalleRequerimiento = iisNull(oRsDet.Fields("IdDetalleRequerimiento").Value, -1)
                                            .OrigenDescripcion = oRsDet.Fields("OrigenDescripcion").Value
                                            .FechaEntrega = iisValidSqlDate(oRsDet.Fields("FechaEntrega").Value)
                                            .IdCuenta = oRsDet.Fields("IdCuenta").Value
                                            '.IdCentroCosto = oRsDet.Fields("IdCentroCosto").Value
                                            .PorcentajeBonificacion = iisNull(oRsDet.Fields("PorcentajeBonificacion").Value, "0")
                                            .ImporteBonificacion = oRsDet.Fields("ImporteBonificacion").Value
                                            'If Check2.Value = 0 Then
                                            '    .PorcentajeIVA = oRsDet.Fields("PorcentajeIVA").Value
                                            '    .ImporteIVA = oRsDet.Fields("ImporteIVA").Value
                                            'End If
                                            .ImporteTotalItem = oRsDet.Fields("ImporteTotalItem").Value
                                            '.IdControlCalidad(= mvarIdControlCalidadStandar")
                                            If IsNull(oRsDet.Fields("ImporteTotalItem").Value) Then
                                                '.ImporteTotalItem(= mImporte")
                                            End If
                                            For i = 0 To 9
                                                '.ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                                            Next
                                            .IdDetalleComparativa = oRsDet.Fields("IdDetalleComparativa").Value
                                            '.Modificado = True
                                            idDet = .Id

                                            Dim art As Pronto.ERP.BO.Articulo
                                            art = ArticuloManager.GetItem(SC, oRsDet.Fields("IdArticulo").Value)
                                            mCodigo = art.Codigo
                                            mArticulo = art.Descripcion

                                            .Articulo = mArticulo 'esta linea no forma parte de la logica original


                                            If Not IsNull(oRsDet.Fields("IdDetalleAcopios").Value) Then
                                                mExiste = ItemEnOtrosPedidos(SC, myPedido, oRsDet.Fields("IdDetalleAcopios").Value, "AC")
                                                If Len(mExiste) Then
                                                    MsgBoxAjax(Me, "Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo")
                                                End If
                                                oRs1 = EntidadManager.GetListTX(SC, "Acopios", "_DatosAcopio", oRsDet.Fields("IdDetalleAcopios").Value)
                                                If oRs1.RecordCount > 0 Then
                                                    If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                                        '.IdControlCalidad = oRs1.Fields("IdControlCalidad").Value
                                                    End If
                                                    If IsNull(.IdCuenta) Then
                                                        .IdCuenta = oRs1.Fields("IdCuenta").Value
                                                    End If
                                                End If
                                                oRs1.Close()
                                            Else
                                                If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                                                    '                                    mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                                                    '                                    If Len(mExiste) Then
                                                    '                                       Me.Refresh
                                                    '                                       MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                                                    '                                    End If
                                                    oRs1 = ConvertToRecordset(RequerimientoManager.GetListTX(SC, "_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value))
                                                    If oRs1.RecordCount > 0 Then
                                                        If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                                            '.IdControlCalidad = oRs1.Fields("IdControlCalidad").Value
                                                        End If
                                                        If IsNull(.IdCuenta) Then
                                                            .IdCuenta = oRs1.Fields("IdCuenta").Value
                                                        End If
                                                    End If
                                                    oRs1.Close()
                                                End If
                                            End If
                                            IdCCal = 0
                                            'If Not IsNull(.IdControlCalidad) Then
                                            '    IdCCal = .IdControlCalidad
                                            'End If
                                        End With

                                        If myPedido.Detalles Is Nothing Then myPedido.Detalles = New PedidoItemList
                                        myPedido.Detalles.Add(oDetCompa2)

                                        'modifico el encabezado

                                        With myPedido
                                            .IdProveedor = oRsPre.IdProveedor
                                            .Observaciones = oRsPre.Observaciones
                                            .PorcentajeBonificacion = oRsPre.Bonificacion
                                            .Garantia = oRsPre.Garantia
                                            .LugarEntrega = oRsPre.LugarEntrega
                                            .IdComprador = oRsPre.IdComprador
                                            .Contacto = oRsPre.Contacto
                                            .Bonificacion = oRsPre.ImporteBonificacion
                                            .TotalIva1 = oRsPre.ImporteIva1
                                            .TotalPedido = oRsPre.ImporteTotal
                                            .PorcentajeIva1 = oRsPre.PorcentajeIva1
                                            '.PorcentajeIva2 = oRsPre.PorcentajeIva2
                                            .IdMoneda = oRsPre.IdMoneda
                                            .DetalleCondicionCompra = oRsPre.DetalleCondicionCompra
                                            .IdCondicionCompra = oRsPre.IdCondicionCompra
                                            For i = 0 To 9
                                                '.Fields("ArchivoAdjunto" & i + 1).Value = oRsPre.Fields("ArchivoAdjunto" & i + 1).Value
                                            Next
                                        End With
                                    End If

                                End If
                                oRsDet.MoveNext()
                            Loop

                            oRs.MoveNext()
                        Loop

                        oRs.Close()
                        'oRsPre.Close()
                        oRsDet.Close()

                    End If

                End If

            Else

                'Seleccion monopresupuesto

                oRs = ConvertToRecordset(ComparativaManager.GetListTX(SC, "_PorPresupuesto", SplitRapido(cmbComparativas.SelectedValue, ";", 0)))

                If oRs.RecordCount > 0 Then


                    oPre = PresupuestoManager.GetItem(SC, oRs.Fields("IdPresupuesto").Value)
                    oRsPre = oPre
                    oRsDet = ConvertToRecordset(PresupuestoManager.GetListTX(SC, "_DetallesPorIdPresupuestoIdComparativa", _
                                   oPre.Id, oRs.Fields("IdComparativa").Value))

                    'txtPresupuesto.Text = oRsPre.Numero & " / " & oRsPre.SubNumero

                    If IdPedido = -1 And Not IsNull(oRsPre.IdPlazoEntrega) Then
                        'oRs1 = Aplicacion.PlazosEntrega.TraerFiltrado("_PorId", oRsPre.Fields("IdPlazoEntrega").Value)
                        'If oRs1.RecordCount > 0 Then
                        '    mvarPlazoEntrega = IIf(IsNull(oRs1.Fields("Descripcion").Value), "", oRs1.Fields("Descripcion").Value)
                        'End If
                        'oRs1.Close()
                    End If

                    'If oRsDet.EOF Then Stop

                    Do While Not oRsDet.EOF
                        mExiste = ""
                        If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                            mExiste = ItemEnOtrosPedidos(SC, myPedido, oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                        End If
                        If Len(mExiste) > 0 Then
                            ms += "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "y no sera incluido en el pedido."
                        Else
                            Dim mvarP_IVA1 = 100
                            mIVA = Math.Round((oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) * mvarP_IVA1 / 100, 4)
                            mImporte = (oRsDet.Fields("Precio").Value * oRsDet.Fields("Cantidad").Value) + mIVA

                            'agrego un renglon al detalle
                            Dim oDetCompa2 As New PedidoItem
                            With oDetCompa2

                                .Nuevo = True

                                .NumeroItem = oRsDet.Fields("NumeroItem").Value
                                .Cantidad = oRsDet.Fields("Cantidad").Value
                                .IdUnidad = oRsDet.Fields("IdUnidad").Value
                                .IdArticulo = oRsDet.Fields("IdArticulo").Value
                                .Precio = oRsDet.Fields("Precio").Value
                                '.Adjunto = oRsDet.Fields("Adjunto").Value
                                '.Cantidad1 = oRsDet.Fields("Cantidad1").Value
                                '.Cantidad2 = oRsDet.Fields("Cantidad2").Value
                                .Observaciones = oRsDet.Fields("Observaciones").Value
                                .IdDetalleAcopios = iisNull(oRsDet.Fields("IdDetalleAcopios").Value, -1)
                                .IdDetalleRequerimiento = iisNull(oRsDet.Fields("IdDetalleRequerimiento").Value, -1)
                                .OrigenDescripcion = oRsDet.Fields("OrigenDescripcion").Value
                                .FechaEntrega = iisValidSqlDate(oRsDet.Fields("FechaEntrega").Value, #1/1/1753#)
                                .IdCuenta = oRsDet.Fields("IdCuenta").Value
                                '.IdCentroCosto = oRsDet.Fields("IdCentroCosto").Value
                                .PorcentajeBonificacion = iisNull(oRsDet.Fields("PorcentajeBonificacion").Value, 0)
                                .ImporteBonificacion = oRsDet.Fields("ImporteBonificacion").Value
                                'If Check2.Value = 0 Then
                                '    .PorcentajeIVA = oRsDet.Fields("PorcentajeIVA").Value
                                '    .ImporteIVA = oRsDet.Fields("ImporteIVA").Value
                                'End If
                                .ImporteTotalItem = oRsDet.Fields("ImporteTotalItem").Value
                                '.IdControlCalidad(= mvarIdControlCalidadStandar")
                                If IsNull(oRsDet.Fields("ImporteTotalItem").Value) Then
                                    '.ImporteTotalItem(= mImporte")
                                End If
                                For i = 0 To 9
                                    '.ArchivoAdjunto" & i + 1).Value = oRsDet.Fields("ArchivoAdjunto" & i + 1).Value
                                Next
                                .IdDetalleComparativa = iisNull(oRsDet.Fields("IdDetalleComparativa").Value, -1)
                                '.Modificado = True
                                idDet = .Id

                                Dim art As Pronto.ERP.BO.Articulo
                                art = ArticuloManager.GetItem(SC, oRsDet.Fields("IdArticulo").Value)
                                mCodigo = art.Codigo
                                mArticulo = art.Descripcion

                                .Articulo = mArticulo 'esta linea no forma parte de la logica original

                                If Not IsNull(oRsDet.Fields("IdDetalleAcopios").Value) Then
                                    mExiste = ItemEnOtrosPedidos(SC, myPedido, oRsDet.Fields("IdDetalleAcopios").Value, "AC")
                                    If Len(mExiste) Then
                                        MsgBoxAjax("Cuidado, el item del Acopio ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation)
                                    End If
                                    'oRs1 = oAp.TablasGenerales.TraerFiltrado("Acopios", "_DatosAcopio", oRsDet.Fields("IdDetalleAcopios").Value)
                                    If oRs1.RecordCount > 0 Then
                                        If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                            '.IdControlCalidad = oRs1.Fields("IdControlCalidad").Value
                                        End If
                                        If IsNull(.IdCuenta) Then
                                            .IdCuenta = oRs1.Fields("IdCuenta").Value
                                        End If
                                    End If
                                    oRs1.Close()
                                Else
                                    If Not IsNull(oRsDet.Fields("IdDetalleRequerimiento").Value) Then
                                        '                           mExiste = origen.ItemEnOtrosPedidos(oRsDet.Fields("IdDetalleRequerimiento").Value, "RM")
                                        '                           If Len(mExiste) Then
                                        '                              Me.Refresh
                                        '                              MsgBox "Cuidado, el item de la RM ya existe en el pedido :" & vbCrLf & mExiste & "El mensaje es solo informativo", vbInformation
                                        '                           End If
                                        oRs1 = ConvertToRecordset(RequerimientoManager.GetListTX(SC, "_DatosRequerimiento", oRsDet.Fields("IdDetalleRequerimiento").Value))
                                        If oRs1.RecordCount > 0 Then
                                            If Not IsNull(oRs1.Fields("IdControlCalidad").Value) Then
                                                '.IdControlCalidad = oRs1.Fields("IdControlCalidad").Value
                                            End If
                                            If IsNull(.IdCuenta) Then
                                                .IdCuenta = oRs1.Fields("IdCuenta").Value
                                            End If
                                        End If
                                        oRs1.Close()
                                    End If
                                End If
                                IdCCal = 0
                                'If Not IsNull(.IdControlCalidad) Then
                                '    IdCCal = .IdControlCalidad
                                'End If
                            End With
                            If myPedido.Detalles Is Nothing Then myPedido.Detalles = New PedidoItemList
                            myPedido.Detalles.Add(oDetCompa2)

                            'modifico el encabezado

                            With myPedido
                                .IdProveedor = oRsPre.IdProveedor
                                .Observaciones = oRsPre.Observaciones
                                .PorcentajeBonificacion = oRsPre.Bonificacion
                                .Garantia = oRsPre.Garantia
                                .LugarEntrega = oRsPre.LugarEntrega
                                .IdComprador = oRsPre.IdComprador
                                .Contacto = oRsPre.Contacto
                                .Bonificacion = oRsPre.ImporteBonificacion
                                .TotalIva1 = oRsPre.ImporteIva1
                                .TotalPedido = oRsPre.ImporteTotal
                                .PorcentajeIva1 = oRsPre.PorcentajeIva1
                                '.PorcentajeIva2 = oRsPre.PorcentajeIva2
                                .IdMoneda = oRsPre.IdMoneda
                                .DetalleCondicionCompra = oRsPre.DetalleCondicionCompra
                                .IdCondicionCompra = oRsPre.IdCondicionCompra
                                For i = 0 To 9
                                    '.Fields("ArchivoAdjunto" & i + 1).Value = oRsPre.Fields("ArchivoAdjunto" & i + 1).Value
                                Next
                            End With
                        End If
                        oRsDet.MoveNext()
                    Loop

                    'oRsPre.Close()
                    oRsDet.Close()

                End If

            End If

        End If

        'oRsComp.Close()


        RecargarEncabezado(myPedido)

        Me.ViewState.Add(mKey, myPedido) 'guardo en el viewstate el objeto
        GridView1.DataSource = myPedido.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True

        If ms <> "" Then
            'MsgBoxAlert(ms)
            MsgBoxAjax(Me, ms)
            lblErrorComparativa.Text = "<br>" & ms.Replace(vbCrLf, "<br>")
            Exit Sub
        Else
            lblErrorComparativa.Text = ""
        End If



Salida:

        oRs = Nothing
        oRs1 = Nothing
        oRsPre = Nothing
        oRsDet = Nothing
        oPre = Nothing
        oRsComp = Nothing
        'oAp = Nothing

        'CalculaPedido()

        Exit Sub

Mal:

        MsgBoxAjax("No se ha podido completar la operacion" & vbCrLf & Err.Description, vbCritical)
        GoTo Salida



    End Sub





    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim output As String


        'Dim Info As String = "|" & mResp & "|" & Index & "|||" & mCopias & "|||" & mvarAgrupar & "|" &   mvarBorrador & "|" & mImprimirAdjuntos & "|" & mRTF & "|" & mPrinter
        Dim Info As String = "|C|1|||1|||1|NO|NO||"

        output = ImprimirWordDOT("Pedido_" & Session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdPedido, Info)
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



    Protected Sub LinkImprimirOpenXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        'BuscarClaveINI("Pedir autorizacion para reimprimir RM") = SI
        Dim pedi = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)


        Dim output As String = IO.Path.GetTempPath & "Pedido " & pedi.Numero & "_" & Now.ToString("ddmmyy_hhmmss") & " .docx"


        'Dim plantilla As String = DirApp() & "\Documentos\" & "Requerimiento1_ESUCO_PUNTONET.docx"
        Dim plantilla As String = DirApp() & "\Documentos\" & "PedidoWeb_AUTOTROL.docx"
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
            MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
            Exit Sub
        End Try
        OpenXML_Pronto.PedidoXML_DOCX(output, pedi, SC)




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
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub





    Protected Sub btnAnular_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnular.Click
        ModalPopupAnular.Show()
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

    Private DIRFTP As String = "C:\"

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
                MostrarBotonesParaAdjuntar()
            Catch ex As Exception
                MsgBoxAjax(Me, ex.ToString)
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If
    End Sub

    Sub MostrarBotonesParaAdjuntar()
        Dim hayAdjunto As Boolean = (lnkAdjunto1.Text <> "")
        lnkAdjunto1.Visible = hayAdjunto
        lnkBorrarAdjunto.Visible = hayAdjunto 'Not mostrar And lnkAdjunto1.Text <> "" 'si no hay arhcivo, no hay borrar

        lnkAdjuntar.Visible = False 'antes era =mostrar . Por ahora este no lo muestro (se supone que era el que adjuntaba sin 2 clicks)
        FileUpLoad2.Visible = Not hayAdjunto
        btnAdjuntoSubir.Visible = Not hayAdjunto
    End Sub
    Protected Sub lnkBorrarAdjunto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBorrarAdjunto.Click
        lnkAdjunto1.Text = ""
        MostrarBotonesParaAdjuntar()
    End Sub


    Protected Sub btnAnularOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnularOk.Click
        If cmbUsuarioAnulo.SelectedValue > 0 Then
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Empleados", "T", cmbUsuarioAnulo.SelectedValue)
            If ds.Tables(0).Rows.Count > 0 Then
                If txtAnularPassword.Text = ds.Tables(0).Rows(0).Item("Password").ToString Then
                    Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
                    With myPedido
                        'esto tiene que estar en el manager, dios!
                        DeObjetoHaciaPagina(myPedido)
                        .MotivoAnulacion = txtAnularMotivo.Text
                        .FechaAnulacion = Today
                        .UsuarioAnulacion = cmbUsuarioAnulo.SelectedValue
                        .Cumplido = "AN"
                        For Each i As PedidoItem In .Detalles
                            With i
                                .Cumplido = "AN"
                                '.EnviarEmail = 1
                            End With
                        Next
                    End With
                    Me.ViewState.Add(mKey, myPedido) 'guardo en el viewstate el objeto
                    PedidoManager.Save(SC, myPedido)
                    Response.Redirect(Request.Url.ToString) 'reinicia la pagina
                    'BloqueosDeEdicion(myRequerimiento)

                    'Y aca tengo que hacer un refresco de todo!...
                Else
                    MsgBoxAjax(Me, "PassWord incorrecta")
                End If
            End If
        End If

    End Sub

    Protected Sub gridRMsParaComprar_PreRender(sender As Object, e As System.EventArgs) Handles gridRMsParaComprar.PreRender
        gridRMsParaComprar.Columns(getGridIDcolbyHeader("ID", gridRMsParaComprar)).Visible = False
    End Sub


    Protected Sub gridPresupuestos_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gridPresupuestos.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", gridPresupuestos)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "IdPresupuesto")
            Try
                gp.DataSource = ObjectDataSource2.Select
                gp.DataBind()
            Catch ex As Exception
                'Debug.Print(ex.ToString)
                ErrHandler2.WriteError(ex)

                Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
            Finally
            End Try
            gp.Width = 200

        End If
    End Sub



    Sub RecalcularTotalComprobante()
        Dim myFactura As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)
        Try
            With myFactura


                'mejor sería usar la funcion DePaginaHaciaObjeto
                .PorcentajeBonificacion = StringToDecimal(txtTotBonif.Text)
                .ImpuestosInternos = StringToDecimal(txtImpuestosInternos.Text)
                .OtrosConceptos1 = StringToDecimal(txtOtrosConceptos1.Text)
                .OtrosConceptos2 = StringToDecimal(txtOtrosConceptos2.Text)
                .OtrosConceptos3 = StringToDecimal(txtOtrosConceptos3.Text)
                .OtrosConceptos4 = StringToDecimal(txtOtrosConceptos4.Text)
                .OtrosConceptos5 = StringToDecimal(txtOtrosConceptos5.Text)


                ' .IdIBCondicion = cmbCategoriaIIBB1.SelectedValue '-para... el RecalcularTotales necesita que le 
                'pases el porcentaje, no el id
                '.PorcentajeIBrutos1 = 
                '.Fecha = txtFechaIngreso.Text 'evidentemente, necesito pasar todo el encabezado al objeto para hacer el recalculo
                '.Cotizacion = Cotizacion(SC)

                '.IdCliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, SC)
                '.PorcentajeIva1 = IIf(lblLetra.Text = "A", 21, 0) 'HORROR!







                '////////////////////////////////////////////
                'If IdFactura = -1 Then

                'End If
                PedidoManager.RecalcularTotales(SC, myFactura)


                '////////////////////////////////////////////
                '////////////////////////////////////////////
                '////////////////////////////////////////////
                '////////////////////////////////////////////

                txtSubtotal.Text = FF2(.SubTotal)
                txtBonificacionPorItem.Text = FF2(.TotalBonifEnItems)
                lblTotBonif.Text = FF2(.TotalBonifSobreElTotal)
                lblTotIVA.Text = FF2(.ImporteIva1)
                lblSubtotalGravado.Text = FF2(.TotalSubGravado)
                'lblTotPercepcionIVA.Text = FF2(.PercepcionIVA)
                'lblTotIngresosBrutos.Text = FF2(.IBrutos)
                txtTotal.Text = FF2(.Total)

                txtOtrosConceptosTotal.Text = StringToDecimal(.TotalOtrosConceptos)


            End With

            UpdatePanelTotales.Update()

        Catch ex As Exception
            '            MsgBoxAjax(Me, ex.ToString)
            ErrHandler2.WriteError(ex)

        End Try
    End Sub


    Protected Sub btnBuscarRMoLA_Click(sender As Object, e As System.EventArgs) Handles btnBuscarRMoLA.Click
        'popupgrilla()
        'Me.btnBuscarRMoLA_Click.Attributes.Add("onclick", "javascript:return OpenPopup()")
    End Sub



    Protected Sub txtPopupRetorno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPopupRetorno.TextChanged
        AgregarItemsACarteraValores()
    End Sub


    Sub AgregarItemsACarteraValores()

        'pinta que _datosRequerimiento tiene un tipo de retorno que el SqlMetal no pudo descular
        'Using db As New DataClassesRequerimientoDataContext(Encriptar(SC))
        '    Dim kk = db.Requerimientos_TX_DatosRequerimiento(11)
        'End Using






        Dim q As String = ViewState("consulta")

        Dim myPedido As Pronto.ERP.BO.Pedido = CType(Me.ViewState(mKey), Pronto.ERP.BO.Pedido)

        Dim a = Split(txtPopupRetorno.Text)
        Array.Sort(a)

        For Each id As Long In a


            If id <= 0 Then Continue For

            'me fijo si ya existe en el detalle
            Dim idtemp = id
            If myPedido.Detalles.Find(Function(obj) obj.Id = idtemp) IsNot Nothing Then
                MsgBoxAjax(Me, "El renglon de imputacion " & id & " ya está en el detalle")
                Continue For
            End If


            Dim mItemRM As RequerimientoItem = New Pronto.ERP.BO.RequerimientoItem
            Dim mItemPedido As PedidoItem = New Pronto.ERP.BO.PedidoItem

            With mItemPedido
                'vendría a ser el código de ListaVal_OLEDragDrop

                .Id = myPedido.Detalles.Count
                .Nuevo = True


                If .NumeroItem = 0 Then
                    '.NumeroItem = PedidoManager.UltimoItemDetalle(myPedido) + 1
                End If

                Dim v = GetStoreProcedureTop1(SC, enumSPs.DetRequerimientos_T, id)
                'acá tendría que usar una llamada tipada a DetRequerimientos_T



                'Dim idRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdAux2")
                'Dim oRM As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idRM, True)
                'Dim oDetRM As RequerimientoItem
                'Dim idDetRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleRequerimiento")
                Dim idDetRM = id




                .Id = myPedido.Detalles.Count
                .Nuevo = True

                Try


                    Dim oRsDet As Data.DataSet
                    oRsDet = RequerimientoManager.GetListTX(SC, "_DatosRequerimiento", idDetRM) 'este sp trae datos del DETALLE de requerimientos (el parametro es un IdDetalleRequerimiento)
                    With oRsDet.Tables(0).Rows(0)
                        If IsNull(.Item("Aprobo")) Then
                            MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " no fue liberado")
                            Continue For
                        End If
                        If IIf(IsNull(.Item("CumplidoReq")), "NO", .Item("CumplidoReq")) = "SI" Or _
                              IIf(IsNull(.Item("CumplidoReq")), "NO", .Item("CumplidoReq")) = "AN" Then
                            MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " ya esta cumplido")
                            Continue For
                        End If
                        If Not CircuitoFirmasCompleto(SC, EntidadManager.EnumFormularios.RequerimientoMateriales, .Item("IdRequerimiento")) Then
                            MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " no tiene completo el circuito de firmas")
                            Continue For
                        End If
                        If IIf(IsNull(.Item("Cumplido")), "NO", .Item("Cumplido")) = "SI" Or _
                              IIf(IsNull(.Item("Cumplido")), "NO", .Item("Cumplido")) = "AN" Then
                            'MsgBoxAjax(Me, "El requerimiento " & oRs.item("NumeroRequerimiento") & " item " & .Item("NumeroItem") & " ya esta cumplido", vbExclamation)
                            Continue For
                        End If

                        If iisNull(.Item("TipoDesignacion"), "") = "S/D" Then
                            MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " está sin designar")
                            Continue For
                        End If

                        .Item("TipoDesignacion") = iisNull(.Item("TipoDesignacion"))
                        If iisNull(.Item("TipoDesignacion")) = "" Or _
                              .Item("TipoDesignacion") = "CMP" Or _
                              (.Item("TipoDesignacion") = "STK" And .Item("SalidaPorVales") < iisNull(.Item("Cantidad"), 0)) Or _
                              (.Item("TipoDesignacion") = "REC" And .Item("IdObra") = ProntoParamOriginal(SC, "IdObraStockDisponible") And _
                               .Item("SalidaPorVales") < iisNull(.Item("Cantidad"), 0)) Then

                            mItemPedido.NumeroItem = myPedido.Detalles.Count
                            If .Item("TipoDesignacion") = "STK" Then
                                mItemPedido.Cantidad = IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad")) - .Item("SalidaPorVales")
                            Else
                                mItemPedido.Cantidad = IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad")) - .Item("Pedido")
                            End If
                            mItemPedido.IdUnidad = .Item("IdUnidad")
                            mItemPedido.Unidad = .Item("Unidad")
                            mItemPedido.IdArticulo = .Item("IdArticulo")
                            mItemPedido.Articulo = .Item("DescripcionArt")
                            'mItemPedido.Cantidad1 = iisNull(.Item("Cantidad1"), 0)
                            'mItemPedido.Cantidad2 = iisNull(.Item("Cantidad2"), 0)
                            'mItemPedido.Adjunto = iisNull(.Item("Adjunto"), "")
                            mItemPedido.FechaEntrega = iisNull(.Item("FechaEntrega"), "")
                            mItemPedido.Precio = 0
                            mItemPedido.IdDetalleRequerimiento = .Item("IdDetalleRequerimiento")
                            mItemPedido.Observaciones = .Item("Observaciones")
                            mItemPedido.IdDetalleLMateriales = iisNull(.Item("IdDetalleLMateriales"), 0)
                            mItemPedido.IdCuenta = iisNull(.Item("IdCuenta"), 0)
                            'mItemPedido.IdCentroCosto = iisNull(.Item("IdCentroCosto"), 0)
                            mItemPedido.OrigenDescripcion = IIf(IsNull(.Item("OrigenDescripcion")), 1, .Item("OrigenDescripcion"))
                            For i = 0 To 9
                                'mItemPedido.(ArchivoAdjunto" & i + 1) =  .item("ArchivoAdjunto" & i + 1)
                            Next
                            mItemPedido.PorcentajeIVA = .Item("AlicuotaIVA")
                            mItemPedido.ImporteIVA = mItemPedido.Precio * mItemPedido.Cantidad * mItemPedido.PorcentajeIVA / 100
                            mItemPedido.ImporteTotalItem = mItemPedido.Precio * mItemPedido.Cantidad + mItemPedido.ImporteIVA



                        End If
                    End With


                    myPedido.Detalles.Add(mItemPedido)

                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


            End With

        Next


        Me.ViewState.Add(mKey, myPedido)
        GridView1.DataSource = myPedido.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()


        mAltaItem = True

    End Sub

    Protected Sub cmbComprador_TextChanged(sender As Object, e As System.EventArgs) Handles cmbComprador.TextChanged
        TraerDatosComprador()

    End Sub

    Sub TraerDatosComprador()
        Dim d = EntidadManager.GetItem(SC, "Empleados", cmbComprador.SelectedValue)
        txtMailComprador.Text = iisNull(d.Item("Email"))
        txtTelefonoComprador.Text = iisNull(d.Item("Interno"))
    End Sub

    Protected Sub cmbCondicionCompra_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cmbCondicionCompra.SelectedIndexChanged
        If txtAclaracionDeCondicionDeCompra.Text = "" Then
            txtAclaracionDeCondicionDeCompra.Text = cmbCondicionCompra.SelectedItem.Text
        End If
    End Sub
End Class


Public Class OpenXML_Pronto_Pedido

    Public Shared Sub PedidoXML_DOCX(ByVal document As String, ByVal oFac As Pronto.ERP.BO.Pedido, ByVal SC As String)

        'Dim oFac As Pronto.ERP.BO.Requerimiento = CType(Me.ViewState(mKey), Pronto.ERP.BO.Requerimiento)


        Dim wordDoc As WordprocessingDocument = WordprocessingDocument.Open(document, True)



        Dim settings As New SimplifyMarkupSettings
        With settings
            .RemoveComments = True
            .RemoveContentControls = True
            .RemoveEndAndFootNotes = True
            .RemoveFieldCodes = False
            .RemoveLastRenderedPageBreak = True
            .RemovePermissions = True
            .RemoveProof = True
            .RemoveRsidInfo = True
            .RemoveSmartTags = True
            .RemoveSoftHyphens = True
            .ReplaceTabsWithSpaces = True
        End With
        MarkupSimplifier.SimplifyMarkup(wordDoc, settings)





        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        Dim cab As wVistaPedido
        Dim cab2 As Pedidos_TResult
        Dim det As Generic.List(Of DetPedidos_TX_DetallesParametrizadosResult)
        Dim empresa As Empresa_TX_DatosResult
        Dim comprador As Empleados_TX_PorIdResult
        Dim proveedor As Pronto.ERP.BO.Proveedor '= ProveedorManager.GetItem(SC, oFac.Id)
        Using db As New DataClasses2DataContext(Encriptar(SC))
            cab = (From i In db.wVistaPedidos Where i.IdPedido = oFac.Id).SingleOrDefault
            cab2 = (From i In db.Pedidos_T(oFac.Id)).SingleOrDefault
            det = (From i In db.DetPedidos_TX_DetallesParametrizados(oFac.Id, -1)).ToList
            ' de varios de los stores no el orm no detecta el tipo devuelto
            '                If mItemsAgrupados Then
            'det = (From i In db.Pedidos_TX_DetallesPorIdPedido(oFac.Id)).ToList
            'det = (From i In db.Pedidos_TX_DetallesPorIdPedidoAgrupados(oFac.Id)).ToList
            empresa = (From i In db.Empresa_TX_Datos).SingleOrDefault
            comprador = (From i In db.Empleados_TX_PorId(oFac.IdComprador)).SingleOrDefault ' = EmpleadoManager.GetItem(SC, oFac.IdComprador)
            proveedor = ProveedorManager.GetItem(SC, oFac.IdProveedor)  'oAp.Proveedores.Item(oRs.Fields("IdProveedor").Value).Registro
        End Using


        ' oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")




        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////
        '/////////////////////////////
        'ENCABEZADO
        'Hace el reemplazo
        '/////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        For Each head As HeaderPart In wordDoc.MainDocumentPart.HeaderParts
            'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
            head.GetStream()

            Dim docText = Nothing
            Dim sr4 = New StreamReader(head.GetStream())

            Using (sr4)
                docText = sr4.ReadToEnd
            End Using

            regexReplace2(docText, "#Numero#", oFac.Numero & " / " & oFac.SubNumero)
            regexReplace2(docText, "#fecha#", oFac.Fecha)

            Dim sw4 = New StreamWriter(head.GetStream(FileMode.Create))
            Using (sw4)
                sw4.Write(docText)
            End Using
        Next



        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'cuerpo
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////






        Using (wordDoc)
            Dim docText As String = Nothing
            Dim sr As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)



            Using (sr)
                docText = sr.ReadToEnd
            End Using



            With oFac
                'regexReplace2(docText, "#Cliente#", oFac.Sector)
                'regexReplace2(docText, "#CodigoCliente#", oFac.Cliente.CodigoCliente)
                'regexReplace2(docText, "#Direccion#", oFac.Cliente.Direccion) 'oFac.Domicilio)
                'regexReplace2(docText, "#Localidad#", oFac.Cliente.Localidad) 'oFac.Domicilio)

                'regexReplace2(docText, "#CUIT#", oFac.Cliente.Cuit)


                'regexReplace2(docText, "#CondicionIVA#", oFac.CondicionIVADescripcion)
                'regexReplace2(docText, "#CondicionVenta#", oFac.CondicionVentaDescripcion)
                'regexReplace2(docText, "#CAE#", oFac.CAE)

                regexReplace2(docText, "#PieObservaciones#", oFac.Observaciones)

                With cab

                    regexReplace2(docText, "#Empresa#", "")
                    regexReplace2(docText, "#DetalleEmpresa#", "")
                    regexReplace2(docText, "#DireccionCentral#", empresa.Direccion & empresa.Localidad & " (" & empresa.CodigoPostal & ") " & empresa.Provincia)
                    regexReplace2(docText, "#DireccionPlanta#", empresa.DatosAdicionales1 & "  " & empresa.DatosAdicionales2) 'empresa.DireccionPlanta)
                    regexReplace2(docText, "#TelefonosEmpresa#", empresa.Telefono1 & "  " & empresa.Telefono2)



                    regexReplace2(docText, "#Proveedor#", proveedor.Nombre1)
                    regexReplace2(docText, "#Direccion#", proveedor.Direccion)
                    regexReplace2(docText, "#Localidad#", proveedor.Localidad)
                    regexReplace2(docText, "#Contacto#", proveedor.Contacto)
                    regexReplace2(docText, "#EmailProveedor#", proveedor.Email)
                    regexReplace2(docText, "#Telefono#", proveedor.Telefono1)
                    regexReplace2(docText, "#CuitProveedor#", proveedor.Cuit)
                    regexReplace2(docText, "#CondicionIva#", NombreCondicionIVA(SC, proveedor.IdCodigoIva))
                    regexReplace2(docText, "#Fax#", proveedor.Fax)


                    regexReplace2(docText, "#Comprador#", comprador.Nombre) ' trajo el nombre de usuarioWindows en lugar del nombre
                    regexReplace2(docText, "#EmailComprador#", comprador.Email)
                    regexReplace2(docText, "#TelefonoComprador#", comprador.Interno)



                    regexReplace2(docText, "#AclaracionCondicion#", .DetalleCondicionCompra)
                    regexReplace2(docText, "#NumeroComparativa#", iisNull(.NumeroComparativa))




                    regexReplace2(docText, "#subtotal#", FF2(oFac.SubTotal))
                    regexReplace2(docText, "#boniftot#", FF2(oFac.Bonificacion))

                    Dim TotalSubGravado = oFac.SubTotal - oFac.Bonificacion - oFac.TotalBonifEnItems
                    regexReplace2(docText, "#subtotalgrav#", FF2(TotalSubGravado))
                    regexReplace2(docText, "#ivatotal#", FF2(oFac.TotalIva1))
                    regexReplace2(docText, "#total#", FF2(oFac.TotalPedido))


                    regexReplace2(docText, "#moneda#", oFac.Moneda)



                    regexReplace2(docText, "#Importante#", oFac.Importante)
                    regexReplace2(docText, "#PlazoEntrega#", oFac.PlazoEntrega)
                    regexReplace2(docText, "#FormaPago#", oFac.FormaPago)
                    regexReplace2(docText, "#LugarEntrega#", oFac.LugarEntrega)
                    regexReplace2(docText, "#Garantia#", oFac.Garantia)
                    regexReplace2(docText, "#Documentacion#", oFac.Documentacion)


                    'regexReplace2(docText, "#Observaciones#", oFac.Observaciones)


                End With
            End With

            'regexReplace2(docText, "#Solicito#", oFac.Solicito)
            'regexReplace2(docText, "#Sector#", oFac.Sector)
            'regexReplace2(docText, "#Tipo#", oFac.Tipo)
            'regexReplace2(docText, "#TipoDes#", oFac.TipoDes)
            'regexReplace2(docText, "#TipoDes1#", oFac.TipoDes1)

            Dim sw As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
            Using (sw)
                sw.Write(docText)
            End Using


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'detalles en CUERPO  (repetir renglones)
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'http://msdn.microsoft.com/en-us/library/cc850835(office.14).aspx
            '///////////////////////////////////////////////////////////////////////////////////
            '   http://stackoverflow.com/a/3783607/1054200
            '@Matt S: I've put in a few extra links that should also help you get started. There are a number of ways 
            'to do repeaters with Content Controls - one is what you mentioned. The other way is to use Building Blocks. 
            'Another way is to kind of do the opposite of what you mentioned - put a table with just a header row and then 
            'create rows populated with CCs in the cells (creo que esto es lo que hago yo). Do take a look 
            'at the Word Content Control Kit as well - that will save your life in working with CCs until you 
            'become much more familiar. – Otaku Sep 25 '10 at 15:46
            '/////////////////////////////////////////////////////////////////////////////////////
            '  'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
            '//////////////////////////////////////////////////
            'en VBA, Edu busca el sector así:     Selection.GoTo(What:=wdGoToBookmark, Name:="Detalles")
            'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
            '//////////////////////////////////////////////////////////

            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'busco el primer renglon de la tabla de detalle
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            Dim tempParent

            'busco el bookmark Detalles
            Dim bookmarkDetalles = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.BookmarkStart)() _
                                    Where bookmark.Name = "Detalles" Or bookmark.Name = "Detalle" _
                                    Select bookmark).FirstOrDefault

            '... o tambien el tag Descripcion
            Dim placeholderCANT = (From bookmark In wordDoc.MainDocumentPart.Document.Body.Descendants(Of Wordprocessing.Text)() _
                                      Where bookmark.Text = "#Descripcion#" _
                                      Select bookmark).FirstOrDefault


            If Not placeholderCANT Is Nothing Then
                tempParent = placeholderCANT.Parent
            Else
                tempParent = bookmarkDetalles.Parent
            End If





            'qué tabla contiene al bookmark "Detalles"? (es el que usa Edu en VBA)
            Dim table As Wordprocessing.Table

            ' Find the second row in the table.
            Dim row1 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(0)
            Dim row2 As Wordprocessing.TableRow '= table.Elements(Of Wordprocessing.TableRow)().ElementAt(1)


            'http://stackoverflow.com/questions/1612511/insert-openxmlelement-after-word-bookmark-in-open-xml-sdk
            ' loop till we get the containing element in case bookmark is inside a table etc.
            ' keep checking the element's parent and update it till we reach the Body
            'Dim tempParent = bookmarkDetalles.Parent
            Dim isInTable As Boolean = False

            While Not TypeOf (tempParent.Parent) Is Wordprocessing.Body ',) <> mainPart.Document.Body
                tempParent = tempParent.Parent
                If (TypeOf (tempParent) Is Wordprocessing.TableRow And Not isInTable) Then
                    isInTable = True
                    Exit While
                End If
            End While

            If isInTable Then
                'table = tempParent
                'no basta con saber la tabla. necesito saber la posicion del bookmark en la tabla
                'table.ChildElements(
                'bookmarkDetalles.
                row1 = tempParent
                table = row1.Parent
            Else
                Err.Raise(5454, "asdasdasa")
            End If





            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            'hago los reemplazos
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////////////


            ''Make a copy of the 2nd row (assumed that the 1st row is header) http://patrickyong.net/tags/openxml/
            'Dim rows = table.Elements(Of Wordprocessing.TableRow)()
            For Each i In det  ' oFac.Detalles
                Dim dupRow = row1.CloneNode(True)
                'Dim dupRow2 = row2.CloneNode(True)

                'CeldaReemplazos(dupRow, -1, i)


                For CeldaColumna = 0 To row1.Elements(Of Wordprocessing.TableCell)().Count - 1
                    Try

                        '///////////////////////////
                        'renglon 1
                        '///////////////////////////


                        Dim texto As String = dupRow.InnerXml
                        With i

                            Dim tempi = oFac.Detalles.Find(Function(o) o.Id = .IdDetallePedido)

                            regexReplace2(texto, "#item#", iisNull(.Item))



                            'regexReplace2(texto, "#Cant#", iisNull(.Cant_))    'problema, me devuelve nothing: http://forums.asp.net/t/1611701.aspx/1
                            regexReplace2(texto, "#cant#", iisNull(tempi.Cantidad))


                            regexReplace2(texto, "#Unidad#", iisNull(tempi.Unidad))
                            regexReplace2(texto, "#Codigo#", iisNull(tempi.Codigo))
                            '                regexReplace2(texto, "#Precio#", iisNull(itemFactura.Precio))
                            '              regexReplace2(texto, "#Importe#", iisNull(itemFactura.ImporteTotalItem))
                            regexReplace2(texto, "#Descripcion#", iisNull(.Articulo))
                            'regexReplace2(texto, "#FechaEntrega#", iisNull(.F_entrega))



                            regexReplace2(texto, "#FechaNecesidad#", iisNull(.F_necesidad))
                            'regexReplace2(texto, "#ListaMat#", iisNull(.ListaMateriales))
                            'regexReplace2(texto, "#itLM#", iisNull(.ItemListaMaterial))
                            'regexReplace2(texto, "#Equipo#", iisNull(.Equipo))
                            'regexReplace2(texto, "#CentrocostoCuenta#", iisNull(.centrocosto))
                            'regexReplace2(texto, "#BienUso#", IIf(iisNull(.bien_o_uso, False) = True, "SI", "NO"))
                            'regexReplace2(texto, "#controlcalidad#", iisNull(.ControlDeCalidad))
                            'regexReplace2(texto, "#adj#", iisNull(.Adjunto))
                            'regexReplace2(texto, "#Proveedor#", iisNull(.proveedor))
                            'regexReplace2(texto, "#nroFactPedido#", iisNull(.NumeroFacturaCompra1))
                            regexReplace2(texto, "#FechaFact#", "") 'iisNull(.FechaFacturaCompra))




                            '    regexReplace2(texto, "#item#", iisNull(.item))
                            regexReplace2(texto, "#obra#", iisNull(.Obra))
                            regexReplace2(texto, "#rm#", iisNull(.Nro_RM))
                            regexReplace2(texto, "#codigo#", iisNull(NombreArticuloCodigo(SC, .IdArticulo)))
                            'regexReplace2(texto, "#Descripcion#", iisNull(.Descripcion))
                            regexReplace2(texto, "#en#", iisNull(tempi.Unidad)) 'iisNull(.Equipo))
                            regexReplace2(texto, "#medida#", iisNull(.Med_1))
                            regexReplace2(texto, "#FechaEntrega#", iisNull(tempi.FechaEntrega))
                            regexReplace2(texto, "#ctrl#", iisNull(.Control_de_Calidad))
                            regexReplace2(texto, "#adj#", iisNull(.Adjunto))
                            regexReplace2(texto, "#preciounitario#", iisNull(.Precio))
                            regexReplace2(texto, "#mon#", "$")
                            regexReplace2(texto, "#bon#", iisNull(.Bonif_))
                            regexReplace2(texto, "#iva#", .__IVA)
                            regexReplace2(texto, "#totalitem#", FF2(iisNull(.Importe)))



                        End With

                        dupRow.InnerXml = texto





                        '///////////////////////////
                        'renglon 2
                        '///////////////////////////

                        '    CeldaReemplazos(dupRow2, CeldaColumna, i)
                        '    table.AppendChild(dupRow2)



                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try

                Next

                table.AppendChild(dupRow)


            Next

            table.RemoveChild(row1)
            'row2.Parent.RemoveChild(row2)




            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'tablita totales en el cuerpo
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



            'Dim sr2 As StreamReader = New StreamReader(wordDoc.MainDocumentPart.GetStream)
            'Dim docText2 As String = Nothing

            'Using (sr2)
            '    docText2 = sr2.ReadToEnd
            'End Using


            'With oFac
            '    'tableTotales=

            '    regexReplace2(docText2, "#Subtotal#", oFac.TotalIva1)
            '    regexReplace2(docText2, "#boniftot#", oFac.Bonificacion)
            '    regexReplace2(docText2, "#subtotalgrav#", oFac.TotalIva1)
            '    regexReplace2(docText2, "#ivatotal#", oFac.TotalIva1)
            '    regexReplace2(docText2, "#total#", 333) 'oFac.TotalIva1)

            'End With

            'Dim sw2 As StreamWriter = New StreamWriter(wordDoc.MainDocumentPart.GetStream(FileMode.Create))
            'Using (sw2)
            '    sw2.Write(docText2)
            'End Using







            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            'PIE
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            For Each pie As FooterPart In wordDoc.MainDocumentPart.FooterParts
                'Dim pie = wordDoc.MainDocumentPart.FooterParts.First
                pie.GetStream()

                docText = Nothing
                sr = New StreamReader(pie.GetStream())

                Using (sr)
                    docText = sr.ReadToEnd
                End Using

                regexReplace2(docText, "#Observaciones#", oFac.Observaciones)
                regexReplace2(docText, "#LugarEntrega#", oFac.LugarEntrega)
                regexReplace2(docText, "#Liberado#", IIf(Val(oFac.IdAprobo) > 0, GetInitialsFromString(oFac.Aprobo) & " " & oFac.FechaAprobacion, ""))  'iniciales + fecha + hora
                regexReplace2(docText, "#JefeSector#", "")
                regexReplace2(docText, "#DireccionPie#", "")
                regexReplace2(docText, "#Calidad#", "")
                regexReplace2(docText, "#Planeamiento#", "")
                regexReplace2(docText, "#GerenciaSector#", "")

                regexReplace2(docText, "#Total#", FF2(0))
                regexReplace2(docText, "#Total2#", FF2(0))

                'regexReplace2(docText, "#Subtotal#", FF2(oFac.SubTotal))
                'regexReplace2(docText, "#IVA#", FF2(oFac.ImporteIva1))
                'regexReplace2(docText, "#IIBB#", oFac.IBrutos)
                'regexReplace2(docText, "#Total#", FF2(oFac.Total))


                sw = New StreamWriter(pie.GetStream(FileMode.Create))
                Using (sw)
                    sw.Write(docText)
                End Using
            Next


            'buscar bookmark http://openxmldeveloper.org/discussions/formats/f/13/p/2539/8302.aspx
            'Dim mainPart As MainDocumentPart = wordDoc.MainDocumentPart()
            'Dim bookmarkStart = mainPart.Document.Body.Descendants().Where(bms >= bms.Name = "testBookmark").SingleOrDefault()
            'Dim bookmarkEnd = mainPart.Document.Body.Descendants().Where(bme >= bme.Id.Value = bookmarkStart.Id.Value).SingleOrDefault()
            'BookmarkStart.Remove()
            'BookmarkEnd.Remove()



        End Using
    End Sub

    Public Shared Sub regexReplace2(ByRef cadena As String, ByVal buscar As String, ByVal reemplazo As String)
        'buscar = "\[" & buscar & "\]" 'agrego los corchetes
        buscar = buscar

        Dim regexText = New Regex(buscar)
        cadena = regexText.Replace(cadena, If(reemplazo, ""))

    End Sub




End Class








'Sub Emision(ByVal StringConexion As String, ByVal mIdPedido As Long, ByVal Info As String)

'    Dim oAp As ComPronto.Aplicacion
'    Dim oRs As ADOR.Recordset
'    Dim oRsDet As ADOR.Recordset
'    Dim oRsPrv As ADOR.Recordset
'    Dim oRsArt As ADOR.Recordset
'    Dim oRsAux As ADOR.Recordset
'    Dim oRsAux1 As ADOR.Recordset

'    Dim mInfo
'    Dim mPaginas As Integer, i As Integer, j As Integer, Index As Integer
'    Dim mCantidadFirmas As Integer, mCopias As Integer
'    Dim mvarUnidad As String, mvarMedidas As String, mvarLocalidad As String
'    Dim mvarDescripcion As String, mvarAutorizo As String, mPlantilla As String
'    Dim mvarFecha As String, mAdjuntos As String, mNumero As String, mPiePedido As String
'    Dim mResp As String, mvarTag As String, mCarpeta As String, mImprime As String
'    Dim mvarObra As String, mvarMoneda As String, mFormulario As String
'    Dim mConSinAviso As String, mCC As String, mvarCantidad As String, espacios As String
'    Dim mvarUnidadPeso As String, mCodigo As String, mvarDireccion As String
'    Dim mvarOrigen1 As String, mvarOrigen2 As String, mvarDescripcionIva As String
'    Dim mvarNumLet As String, mvarDocumento As String, mvarBorrador As String
'    Dim mvarEmpresa As String, mvarDescBonif As String
'    Dim mPrecio As Double, mTotalItem As Double, mvarSubTotal As Double
'    Dim mvarSubtotalGravado As Double, mvarIVA1 As Double, mvarIVA2 As Double
'    Dim mvarTotalPedido As Double, mvarBonificacionPorItem As Double
'    Dim mvarBonificacion As Double, mvarTotalPeso As Double, mvarTotalImputaciones As Double
'    Dim mvarTotalOrdenPago As Double, mvarTotalDebe As Double, mvarTotalValores As Double
'    Dim mvarCCostos As Long, mIdOPComplementaria As Long
'    Dim mVectorAutorizaciones(10) As Integer
'    Dim HayVariosCCostos As Boolean, mImprimio As Boolean, mItemsAgrupados As Boolean

'    mInfo = VBA.Split(Info, "|")

'    Index = CInt(mInfo(2))
'    mCarpeta = mInfo(3)
'    mImprime = mInfo(4)
'    mCopias = CInt(mInfo(5))
'    mFormulario = mInfo(6)
'    mConSinAviso = mInfo(7)
'    mResp = mInfo(1)
'    If mResp = "C" Then
'    Else
'    End If
'    For j = 0 To 10
'        mVectorAutorizaciones(j) = -1
'    Next
'    If mInfo(8) = "1" Then
'        mItemsAgrupados = True
'    Else
'        mItemsAgrupados = False
'    End If
'    mvarBorrador = mInfo(9)

'    oAp = CreateObject("ComPronto.Aplicacion")
'    oAp.StringConexion = StringConexion

'    oRs = oAp.Pedidos.TraerFiltrado("_PorId", mIdPedido)
'    If mItemsAgrupados Then
'        oRsDet = oAp.Pedidos.TraerFiltrado("_DetallesPorIdPedidoAgrupados", mIdPedido)
'    Else
'        oRsDet = oAp.Pedidos.TraerFiltrado("_DetallesPorIdPedido", mIdPedido)
'    End If
'    oRsPrv = oAp.Proveedores.Item(oRs.Fields("IdProveedor").Value).Registro

'    oRsAux = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")
'    mvarEmpresa = " " & IIf(IsNull(oRsAux.Fields("Nombre").Value), "", oRsAux.Fields("Nombre").Value)
'    oRsAux.Close()

'    Selection.HomeKey(Unit:=wdStory)
'    Selection.MoveDown(Unit:=wdLine, Count:=7)
'    Selection.MoveLeft(Unit:=wdCell, Count:=1)

'    With oRsDet
'        Do Until .EOF
'            If mItemsAgrupados Then
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & Format(.AbsolutePosition, "##0"))
'                Selection.MoveRight(Unit:=wdCell, Count:=2)
'            Else
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & Format(.Fields("NumeroItem").Value, "##0"))
'                Selection.MoveRight(Unit:=wdCell)
'                If Not IsNull(.Fields("IdObra").Value) Then
'                    Selection.TypeText(Text:="" & oAp.Obras.Item(.Fields("IdObra").Value).Registro.Fields("NumeroObra").Value)
'                End If
'                Selection.MoveRight(Unit:=wdCell)
'                If Not IsNull(.Fields("NumeroAcopio").Value) Then
'                    Selection.TypeText(Text:="" & .Fields("NumeroAcopio").Value & " - " & .Fields("NumeroItemLA").Value)
'                ElseIf Not IsNull(.Fields("NumeroRequerimiento").Value) Then
'                    Selection.TypeText(Text:="" & .Fields("NumeroRequerimiento").Value & " - " & .Fields("NumeroItemRM").Value)
'                End If
'            End If
'            oRsArt = oAp.Articulos.Item(.Fields("IdArticulo").Value).Registro
'            mCodigo = IIf(IsNull(oRsArt.Fields("Codigo").Value), "", oRsArt.Fields("Codigo").Value)
'            mvarDescripcion = ""
'            If Not IsNull(.Fields("OrigenDescripcion").Value) Then
'                If .Fields("OrigenDescripcion").Value = 1 Or .Fields("OrigenDescripcion").Value = 3 Then
'                    mvarDescripcion = IIf(IsNull(oRsArt.Fields("Descripcion").Value), "", oRsArt.Fields("Descripcion").Value)
'                End If
'                If .Fields("OrigenDescripcion").Value = 2 Or .Fields("OrigenDescripcion").Value = 3 Then
'                    If Not IsNull(.Fields("Observaciones").Value) Then
'                        UserForm1.RichTextBox1.TextRTF = .Fields("Observaciones").Value
'                        mvarDescripcion = mvarDescripcion & " " & UserForm1.RichTextBox1.Text
'                    End If
'                End If
'            Else
'                mvarDescripcion = IIf(IsNull(oRsArt.Fields("Descripcion").Value), "", oRsArt.Fields("Descripcion").Value)
'            End If
'            mvarUnidad = ""
'            oRsAux = oAp.Unidades.Item(.Fields("IdUnidad").Value).Registro
'            If oRsAux.RecordCount > 0 Then
'                mvarUnidad = IIf(IsNull(oRsAux.Fields("Abreviatura").Value), oRsAux.Fields("Descripcion").Value, oRsAux.Fields("Abreviatura").Value)
'            End If
'            oRsAux.Close()
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & mCodigo)
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & mvarDescripcion)
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & Format(.Fields("Cantidad").Value, "Fixed"))
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & mvarUnidad)
'            mvarMedidas = ""
'            mvarUnidad = ""
'            If Not IsNull(oRsArt.Fields("IdCuantificacion").Value) Then
'                If Not IsNull(oRsArt.Fields("Unidad11").Value) Then
'                    mvarUnidad = oAp.Unidades.Item(oRsArt.Fields("Unidad11").Value).Registro.Fields("Abreviatura").Value
'                End If
'                Select Case oRsArt.Fields("IdCuantificacion").Value
'                    Case 3
'                        mvarMedidas = "" & .Fields("Cantidad1").Value & " x " & .Fields("Cantidad2").Value & " " & mvarUnidad
'                    Case 2
'                        mvarMedidas = "" & .Fields("Cantidad1").Value & " " & mvarUnidad
'                End Select
'            End If
'            oRsArt.Close()
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & mvarMedidas)
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & Format(.Fields("FechaEntrega").Value, "Short Date"))
'            Selection.MoveRight(Unit:=wdCell)
'            If Not IsNull(.Fields("IdControlCalidad").Value) Then
'                Selection.TypeText(Text:="" & _
'                   oAp.ControlesCalidad.Item(.Fields("IdControlCalidad").Value).Registro.Fields("Abreviatura").Value)
'            End If
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & .Fields("Adjunto").Value)
'            Selection.MoveRight(Unit:=wdCell)
'            If mResp = "C" Then
'                mPrecio = .Fields("Precio").Value
'                Selection.TypeText(Text:="" & Format(mPrecio, "#,##0.0000"))
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & .Fields("Moneda").Value)
'                Selection.MoveRight(Unit:=wdCell)
'                If Not IsNull(.Fields("PorcentajeBonificacion").Value) Then
'                    Selection.TypeText(Text:="" & Format(.Fields("PorcentajeBonificacion").Value, "#0.00"))
'                End If
'                Selection.MoveRight(Unit:=wdCell)
'                If Not IsNull(.Fields("PorcentajeIVA").Value) And _
'                      Not IIf(IsNull(oRs.Fields("PedidoExterior").Value), "NO", oRs.Fields("PedidoExterior").Value) = "SI" Then
'                    Selection.TypeText(Text:="" & Format(.Fields("PorcentajeIVA").Value, "#0.00"))
'                End If
'                mTotalItem = mPrecio * .Fields("Cantidad").Value
'                If Not IsNull(.Fields("ImporteBonificacion").Value) Then
'                    mTotalItem = mTotalItem - .Fields("ImporteBonificacion").Value
'                End If
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & Format(mTotalItem, "#,##0.00"))
'            Else
'                Selection.MoveLeft(Unit:=wdCell)
'            End If
'            If Not IsNull(.Fields("Observaciones").Value) And Not IsNull(.Fields("OrigenDescripcion").Value) Then
'                If .Fields("OrigenDescripcion").Value = 1 Then
'                    If Len(Trim(.Fields("Observaciones").Value)) > 2 Then
'                        UserForm1.RichTextBox1.TextRTF = .Fields("Observaciones").Value
'                        Selection.MoveRight(Unit:=wdCell, Count:=1)
'                        .MoveNext()
'                        If Not .EOF Then
'                            If mResp = "C" Then
'                                Selection.MoveRight(Unit:=wdCell, Count:=16)
'                            Else
'                                Selection.MoveRight(Unit:=wdCell, Count:=12)
'                            End If
'                            Selection.MoveUp(Unit:=wdLine, Count:=1)
'                        End If
'                        .MovePrevious()
'                        If mResp = "C" Then
'                            Selection.MoveRight(Unit:=wdCharacter, Count:=16, Extend:=wdExtend)
'                        Else
'                            Selection.MoveRight(Unit:=wdCharacter, Count:=12, Extend:=wdExtend)
'                        End If
'                        Selection.Cells.Merge()
'                        Selection.ParagraphFormat.Alignment = wdAlignParagraphLeft
'                        Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                    End If
'                End If
'            End If
'            .MoveNext()
'        Loop
'    End With

'    If mResp = "C" Then
'        mvarSubTotal = 0
'        mvarSubtotalGravado = 0
'        mvarIVA1 = 0
'        mvarIVA2 = 0
'        mvarTotalPedido = 0
'        mvarBonificacionPorItem = 0
'        mvarBonificacion = 0
'        oRsAux = oAp.Pedidos.TraerFiltrado("_DetallesPorId", mIdPedido)
'        If oRsAux.RecordCount > 0 Then
'            oRsAux.MoveFirst()
'            Do While Not oRsAux.EOF
'                If Not IsNull(oRsAux.Fields("ImporteTotalItem").Value) Then
'                    mvarSubTotal = mvarSubTotal + oRsAux.Fields("ImporteTotalItem").Value
'                Else
'                    mvarSubTotal = mvarSubTotal + (oRsAux.Fields("Precio").Value * oRsAux.Fields("Cantidad").Value)
'                End If
'                If Not IsNull(oRsAux.Fields("ImporteBonificacion").Value) Then
'                    mvarBonificacionPorItem = mvarBonificacionPorItem + oRsAux.Fields("ImporteBonificacion").Value
'                End If
'                If Not IsNull(oRsAux.Fields("ImporteIVA").Value) Then
'                    mvarIVA1 = mvarIVA1 + oRsAux.Fields("ImporteIVA").Value
'                End If
'                oRsAux.MoveNext()
'            Loop
'        End If
'        oRsAux.Close()
'        oRsAux = Nothing
'        If Not IsNull(oRs.Fields("Bonificacion").Value) Then
'            ' mvarBonificacion = Round((mvarSubTotal - mvarBonificacionPorItem) * oRs.Fields("PorcentajeBonificacion").Value / 100, 2)
'            mvarBonificacion = oRs.Fields("Bonificacion").Value
'        End If
'        mvarSubTotal = mvarSubTotal + mvarBonificacionPorItem + mvarBonificacion - mvarIVA1
'        mvarSubtotalGravado = mvarSubTotal - mvarBonificacion - mvarBonificacionPorItem
'        If IIf(IsNull(oRs.Fields("PedidoExterior").Value), "NO", oRs.Fields("PedidoExterior").Value) = "SI" Then
'            mvarIVA1 = 0
'        End If
'        mvarTotalPedido = mvarSubtotalGravado + mvarIVA1 + mvarIVA2

'        Selection.GoTo(What:=wdGoToBookmark, Name:="Totales")
'        Selection.MoveRight(Unit:=wdCell, Count:=2)
'        Selection.TypeText(Text:="" & Format(mvarSubTotal, "#,##0.00"))
'        Selection.MoveDown(Unit:=wdLine)
'        If mvarBonificacionPorItem <> 0 Then
'            Selection.MoveLeft(Unit:=wdCell)
'            Selection.TypeText(Text:="Bonificacion por item")
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & Format(mvarBonificacionPorItem, "#,##0.00"))
'        End If
'        Selection.MoveDown(Unit:=wdLine)
'        If mvarBonificacion <> 0 Then
'            Selection.MoveLeft(Unit:=wdCell)
'            mvarDescBonif = "Bonificacion "
'            If Not IsNull(oRs.Fields("PorcentajeBonificacion").Value) Then
'                mvarDescBonif = mvarDescBonif & " " & Format(oRs.Fields("PorcentajeBonificacion").Value, "Fixed") & "%"
'            End If
'            Selection.TypeText(Text:=mvarDescBonif)
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & Format(mvarBonificacion, "#,##0.00"))
'        End If
'        Selection.MoveDown(Unit:=wdLine)
'        If mvarSubtotalGravado <> 0 Then
'            Selection.MoveLeft(Unit:=wdCell)
'            Selection.TypeText(Text:="Subtotal gravado")
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & Format(mvarSubtotalGravado, "#,##0.00"))
'        End If
'        Selection.MoveDown(Unit:=wdLine)
'        If mvarIVA1 <> 0 Then
'            Selection.MoveLeft(Unit:=wdCell)
'            Selection.TypeText(Text:="IVA ") ' & Format(mvarP_IVA1, "#,##0.00") & " %"
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & Format(mvarIVA1, "#,##0.00"))
'        End If
'        Selection.MoveDown(Unit:=wdLine)
'        If mvarTotalPedido <> 0 Then
'            Selection.TypeText(Text:="" & Format(mvarTotalPedido, "#,##0.00"))
'        End If
'        Selection.MoveLeft(Unit:=wdCell, Count:=1)
'        If Not IsNull(oRs.Fields("IdMoneda").Value) Then
'            Selection.TypeText(Text:="" & oAp.Monedas.Item(oRs.Fields("IdMoneda").Value).Registro.Fields("Nombre").Value)
'        End If
'    End If

'    'Circuito de firmas
'    If ActiveWindow.View.SplitSpecial <> wdPaneNone Then
'        ActiveWindow.Panes(2).Close()
'    End If
'    ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
'    Selection.MoveRight(Unit:=wdCell)
'    Selection.TypeText(Text:="" & mvarEmpresa)
'    Selection.MoveRight(Unit:=wdCell, Count:=2)
'    mNumero = oRs.Fields("NumeroPedido").Value
'    If Not IsNull(oRs.Fields("Subnumero").Value) Then
'        mNumero = mNumero & " / " & oRs.Fields("Subnumero").Value
'    End If
'    If mvarBorrador = "SI" Then mNumero = mNumero & " [Borrador]"
'    Selection.TypeText(Text:="" & mNumero)
'    Selection.MoveRight(Unit:=wdCell, Count:=1)
'    mvarFecha = "FECHA :"
'    If Not IsNull(oRs.Fields("Consorcial").Value) Then
'        If oRs.Fields("Consorcial").Value = "SI" Then
'            mvarFecha = mvarFecha & vbCrLf & "(Consorcial)"
'        End If
'    End If
'    Selection.TypeText(Text:="" & mvarFecha)
'    Selection.MoveRight(Unit:=wdCell, Count:=1)
'    Selection.TypeText(Text:="" & oRs.Fields("FechaPedido").Value)

'    ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
'    Selection.HomeKey(Unit:=wdStory)
'    Selection.MoveDown(Unit:=wdLine, Count:=2)

'    If Not IsNull(oRs.Fields("Aprobo").Value) Then
'        oRsAux = oAp.Empleados.Item(oRs.Fields("Aprobo").Value).Registro
'        If Not IsNull(oRsAux.Fields("Iniciales").Value) Then
'            mvarAutorizo = "" & oRsAux.Fields("Iniciales").Value
'            If Not IsNull(oRs.Fields("FechaAprobacion").Value) Then
'                mvarAutorizo = mvarAutorizo & "  " & oRs.Fields("FechaAprobacion").Value
'            End If
'            Selection.TypeText(Text:="" & mvarAutorizo)
'        End If
'        oRsAux.Close()
'    End If

'    mCantidadFirmas = 0
'    oRsAux = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(4, mvarTotalPedido))
'    If Not oRsAux Is Nothing Then
'        If oRsAux.RecordCount > 0 Then
'            oRsAux.MoveFirst()
'            Do While Not oRsAux.EOF
'                mCantidadFirmas = mCantidadFirmas + 1
'                mVectorAutorizaciones(mCantidadFirmas) = oRsAux.Fields(0).Value
'                oRsAux.MoveNext()
'            Loop
'        End If
'        oRsAux.Close()
'    End If

'    oRsAux = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(4, mIdPedido))
'    If oRsAux.RecordCount > 0 Then
'        For j = 1 To mCantidadFirmas
'            mvarAutorizo = ""
'            oRsAux.MoveFirst()
'            Do While Not oRsAux.EOF
'                If mVectorAutorizaciones(j) = oRsAux.Fields("OrdenAutorizacion").Value Then
'                    oRsAux1 = oAp.Empleados.Item(oRsAux.Fields("IdAutorizo").Value).Registro
'                    If Not IsNull(oRsAux1.Fields("Iniciales").Value) Then
'                        mvarAutorizo = mvarAutorizo & "" & oRsAux1.Fields("Iniciales").Value
'                    End If
'                    If Not IsNull(oRsAux.Fields("FechaAutorizacion").Value) Then
'                        mvarAutorizo = mvarAutorizo & " " & oRsAux.Fields("FechaAutorizacion").Value
'                    End If
'                    oRsAux1.Close()
'                    If mvarAutorizo = "" Then mvarAutorizo = "???"
'                    Selection.MoveRight(Unit:=wdCell)
'                    Selection.TypeText(Text:="" & mvarAutorizo)
'                    Exit Do
'                End If
'                oRsAux.MoveNext()
'            Loop
'            If mvarAutorizo = "" Then
'                Selection.MoveRight(Unit:=wdCell)
'            End If
'        Next
'    End If
'    oRsAux.Close()

'    ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument
'    ActiveDocument.FormFields("Proveedor").Result = oRsPrv.Fields("RazonSocial").Value
'    ActiveDocument.FormFields("Direccion").Result = IIf(IsNull(oRsPrv.Fields("Direccion").Value), "", oRsPrv.Fields("Direccion").Value)
'    mvarLocalidad = ""
'    If Not IsNull(oRsPrv.Fields("CodigoPostal").Value) Then
'        mvarLocalidad = "(" & oRsPrv.Fields("CodigoPostal").Value & ") "
'    End If
'    If Not IsNull(oRsPrv.Fields("IdLocalidad").Value) Then
'        mvarLocalidad = mvarLocalidad & oAp.Localidades.Item(oRsPrv.Fields("IdLocalidad").Value).Registro.Fields("Nombre").Value
'    End If
'    ActiveDocument.FormFields("Localidad").Result = mvarLocalidad
'    ActiveDocument.FormFields("Contacto").Result = "At. " & IIf(IsNull(oRs.Fields("Contacto").Value), "", oRs.Fields("Contacto").Value)
'    ActiveDocument.FormFields("Telefono").Result = IIf(IsNull(oRsPrv.Fields("Telefono1").Value), "", "Tel.: " & oRsPrv.Fields("Telefono1").Value)
'    ActiveDocument.FormFields("Fax").Result = IIf(IsNull(oRsPrv.Fields("Fax").Value), "", "Fax : " & oRsPrv.Fields("Fax").Value)
'    ActiveDocument.FormFields("CuitProveedor").Result = "" & oRsPrv.Fields("Cuit").Value
'    If Not IsNull(oRsPrv.Fields("IdCodigoIva").Value) Then
'        ActiveDocument.FormFields("CondicionIva").Result = oAp.TablasGenerales.TraerFiltrado("DescripcionIva", "_TT", oRsPrv.Fields("IdCodigoIva").Value).Fields("Descripcion").Value
'    End If
'    If Not IsNull(oRsPrv.Fields("Email").Value) Then
'        ActiveDocument.FormFields("EmailProveedor").Result = oRsPrv.Fields("Email").Value
'    End If
'    If Not IsNull(oRs.Fields("NumeroComparativa").Value) Then
'        ActiveDocument.FormFields("NumeroComparativa").Result = oRs.Fields("NumeroComparativa").Value
'    End If
'    If Not IsNull(oRs.Fields("DetalleCondicionCompra").Value) Then
'        ActiveDocument.FormFields("AclaracionCondicion").Result = oRs.Fields("DetalleCondicionCompra").Value
'    End If

'    oRsAux = oAp.TablasGenerales.TraerFiltrado("Empresa", "_Datos")
'    ActiveDocument.FormFields("DetalleEmpresa").Result = IIf(IsNull(oRsAux.Fields("DetalleNombre").Value), "", oRsAux.Fields("DetalleNombre").Value)
'    ActiveDocument.FormFields("DireccionCentral").Result = IIf(IsNull(oRsAux.Fields("Direccion").Value), "", oRsAux.Fields("Direccion").Value) & " " & _
'                      IIf(IsNull(oRsAux.Fields("Localidad").Value), "", oRsAux.Fields("Localidad").Value) & " " & _
'                      "(" & IIf(IsNull(oRsAux.Fields("CodigoPostal").Value), "", oRsAux.Fields("CodigoPostal").Value) & ") " & _
'                      IIf(IsNull(oRsAux.Fields("Provincia").Value), "", oRsAux.Fields("Provincia").Value)
'    ActiveDocument.FormFields("DireccionPlanta").Result = IIf(IsNull(oRsAux.Fields("DatosAdicionales1").Value), "", oRsAux.Fields("DatosAdicionales1").Value) & "  " & _
'                      "CUIT : " & IIf(IsNull(oRsAux.Fields("Cuit").Value), "", oRsAux.Fields("Cuit").Value)
'    ActiveDocument.FormFields("TelefonosEmpresa").Result = IIf(IsNull(oRsAux.Fields("Telefono1").Value), "", oRsAux.Fields("Telefono1").Value) & " " & _
'                      "Fax : " & IIf(IsNull(oRsAux.Fields("Telefono2").Value), "", oRsAux.Fields("Telefono2").Value)
'    oRsAux.Close()

'    If Not IsNull(oRs.Fields("IdComprador").Value) Then
'        oRsAux = oAp.Empleados.Item(oRs.Fields("IdComprador").Value).Registro
'        If oRsAux.RecordCount > 0 Then
'            If Not IsNull(oRsAux.Fields("Nombre").Value) Then
'                ActiveDocument.FormFields("Comprador").Result = oRsAux.Fields("Nombre").Value
'            End If
'            If Not IsNull(oRsAux.Fields("Email").Value) Then
'                ActiveDocument.FormFields("EmailComprador").Result = oRsAux.Fields("Email").Value
'            End If
'            If Not IsNull(oRsAux.Fields("Interno").Value) Then
'                ActiveDocument.FormFields("TelefonoComprador").Result = oRsAux.Fields("Interno").Value
'            End If
'        End If
'        oRsAux.Close()
'        oRsAux = Nothing
'    End If

'    oRsDet.Close()

'    Selection.GoTo(What:=wdGoToBookmark, Name:="Notas")

'    If mvarBorrador <> "SI" Then

'        If Not IsNull(oRs.Fields("Importante").Value) Then
'            If IsNull(oRs.Fields("ImprimeImportante").Value) Or oRs.Fields("ImprimeImportante").Value = "SI" Then
'                UserForm1.RichTextBox1.TextRTF = oRs.Fields("Importante").Value
'                Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'                With Selection.Borders(wdBorderTop)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderLeft)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderBottom)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderRight)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                Selection.HomeKey(Unit:=wdLine)
'                Selection.TypeText(Text:="00 - Importante :")
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                Selection.MoveRight(Unit:=wdCell, Count:=3)
'            End If
'        End If

'        If Not IsNull(oRs.Fields("PlazoEntrega").Value) Then
'            If IsNull(oRs.Fields("ImprimePlazoEntrega").Value) Or oRs.Fields("ImprimePlazoEntrega").Value = "SI" Then
'                UserForm1.RichTextBox1.TextRTF = oRs.Fields("PlazoEntrega").Value
'                Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'                With Selection.Borders(wdBorderTop)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderLeft)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderBottom)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderRight)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                Selection.HomeKey(Unit:=wdLine)
'                Selection.TypeText(Text:="01 - Plazo de entrega :")
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                Selection.MoveRight(Unit:=wdCell, Count:=3)
'            End If
'        End If

'        If Not IsNull(oRs.Fields("LugarEntrega").Value) Then
'            If IsNull(oRs.Fields("ImprimeLugarEntrega").Value) Or oRs.Fields("ImprimeLugarEntrega").Value = "SI" Then
'                UserForm1.RichTextBox1.TextRTF = oRs.Fields("LugarEntrega").Value
'                Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'                With Selection.Borders(wdBorderTop)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderLeft)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderBottom)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderRight)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                Selection.HomeKey(Unit:=wdLine)
'                Selection.TypeText(Text:="02 - Lugar de entrega :")
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                Selection.MoveRight(Unit:=wdCell, Count:=3)
'            End If
'        End If

'        If Not IsNull(oRs.Fields("FormaPago").Value) Then
'            If IsNull(oRs.Fields("ImprimeFormaPago").Value) Or oRs.Fields("ImprimeFormaPago").Value = "SI" Then
'                UserForm1.RichTextBox1.TextRTF = oRs.Fields("FormaPago").Value
'                Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'                With Selection.Borders(wdBorderTop)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderLeft)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderBottom)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderRight)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                Selection.HomeKey(Unit:=wdLine)
'                Selection.TypeText(Text:="03 - Forma de pago :")
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                Selection.MoveRight(Unit:=wdCell, Count:=3)
'            End If
'        End If

'        If IsNull(oRs.Fields("ImprimeImputaciones").Value) Or oRs.Fields("ImprimeImputaciones").Value = "SI" Then
'            '         UserForm1.RichTextBox1.TextRTF = "" & GeneraImputacionesBis(mIdPedido)
'            Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'            With Selection.Borders(wdBorderTop)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            With Selection.Borders(wdBorderLeft)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            With Selection.Borders(wdBorderBottom)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            With Selection.Borders(wdBorderRight)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            Selection.HomeKey(Unit:=wdLine)
'            Selection.TypeText(Text:="04 - Imputación contable :")
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'            Selection.MoveRight(Unit:=wdCell, Count:=3)
'        End If

'        If IsNull(oRs.Fields("ImprimeInspecciones").Value) Or oRs.Fields("ImprimeInspecciones").Value = "SI" Then
'            '         UserForm1.RichTextBox1.TextRTF = "" & GeneraInspeccionesBis(mIdPedido)
'            Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'            With Selection.Borders(wdBorderTop)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            With Selection.Borders(wdBorderLeft)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            With Selection.Borders(wdBorderBottom)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            With Selection.Borders(wdBorderRight)
'                .LineStyle = Options.DefaultBorderLineStyle
'                .LineWidth = Options.DefaultBorderLineWidth
'            End With
'            Selection.HomeKey(Unit:=wdLine)
'            Selection.TypeText(Text:="05 - Inspecciones :")
'            Selection.MoveRight(Unit:=wdCell)
'            Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'            Selection.MoveRight(Unit:=wdCell, Count:=3)
'        End If

'        If Not IsNull(oRs.Fields("Garantia").Value) Then
'            If IsNull(oRs.Fields("ImprimeGarantia").Value) Or oRs.Fields("ImprimeGarantia").Value = "SI" Then
'                UserForm1.RichTextBox1.TextRTF = oRs.Fields("Garantia").Value
'                Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'                With Selection.Borders(wdBorderTop)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderLeft)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderBottom)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderRight)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                Selection.HomeKey(Unit:=wdLine)
'                Selection.TypeText(Text:="06 - Garantia :")
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                Selection.MoveRight(Unit:=wdCell, Count:=3)
'            End If
'        End If

'        If Not IsNull(oRs.Fields("Documentacion").Value) Then
'            If IsNull(oRs.Fields("ImprimeDocumentacion").Value) Or oRs.Fields("ImprimeDocumentacion").Value = "SI" Then
'                UserForm1.RichTextBox1.TextRTF = oRs.Fields("Documentacion").Value
'                Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'                With Selection.Borders(wdBorderTop)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderLeft)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderBottom)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                With Selection.Borders(wdBorderRight)
'                    .LineStyle = Options.DefaultBorderLineStyle
'                    .LineWidth = Options.DefaultBorderLineWidth
'                End With
'                Selection.HomeKey(Unit:=wdLine)
'                Selection.TypeText(Text:="07 - Documentación :")
'                Selection.MoveRight(Unit:=wdCell)
'                Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'                Selection.MoveRight(Unit:=wdCell, Count:=3)
'            End If
'        End If

'        UserForm1.RichTextBox1.TextRTF = IIf(IsNull(oRs.Fields("Observaciones").Value), "", oRs.Fields("Observaciones").Value)
'        Selection.MoveRight(Unit:=wdWord, Count:=2, Extend:=wdExtend)
'        With Selection.Borders(wdBorderTop)
'            .LineStyle = Options.DefaultBorderLineStyle
'            .LineWidth = Options.DefaultBorderLineWidth
'        End With
'        With Selection.Borders(wdBorderLeft)
'            .LineStyle = Options.DefaultBorderLineStyle
'            .LineWidth = Options.DefaultBorderLineWidth
'        End With
'        With Selection.Borders(wdBorderBottom)
'            .LineStyle = Options.DefaultBorderLineStyle
'            .LineWidth = Options.DefaultBorderLineWidth
'        End With
'        With Selection.Borders(wdBorderRight)
'            .LineStyle = Options.DefaultBorderLineStyle
'            .LineWidth = Options.DefaultBorderLineWidth
'        End With
'        Selection.HomeKey(Unit:=wdLine)
'        Selection.TypeText(Text:="Observaciones :")
'        Selection.MoveRight(Unit:=wdCell)
'        Selection.TypeText(Text:="" & UserForm1.RichTextBox1.Text)
'        oRsPrv.Close()

'        ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument

'        'Circuito de firmas
'        If ActiveWindow.View.SplitSpecial <> wdPaneNone Then
'            ActiveWindow.Panes(2).Close()
'        End If
'        ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageHeader
'        Selection.MoveRight(Unit:=wdCell)
'        Selection.TypeText(Text:="" & mvarEmpresa)
'        Selection.MoveRight(Unit:=wdCell, Count:=2)
'        mNumero = oRs.Fields("NumeroPedido").Value
'        If Not IsNull(oRs.Fields("Subnumero").Value) Then
'            mNumero = mNumero & " / " & oRs.Fields("Subnumero").Value
'        End If
'        Selection.TypeText(Text:="" & mNumero)
'        Selection.MoveRight(Unit:=wdCell, Count:=2)
'        Selection.TypeText(Text:="" & oRs.Fields("FechaPedido").Value)

'        ActiveWindow.ActivePane.View.SeekView = wdSeekCurrentPageFooter
'        Selection.HomeKey(Unit:=wdStory)
'        Selection.MoveDown(Unit:=wdLine, Count:=2)

'        If Not IsNull(oRs.Fields("Aprobo").Value) Then
'            oRsEmp = oAp.Empleados.Item(oRs.Fields("Aprobo").Value).Registro
'            If Not IsNull(oRsEmp.Fields("Iniciales").Value) Then
'                mvarAutorizo = "" & oRsEmp.Fields("Iniciales").Value
'                If Not IsNull(oRs.Fields("FechaAprobacion").Value) Then
'                    mvarAutorizo = mvarAutorizo & "  " & oRs.Fields("FechaAprobacion").Value
'                End If
'                Selection.TypeText(Text:="" & mvarAutorizo)
'            End If
'            oRsEmp.Close()
'        End If

'        mCantidadFirmas = 0
'        oRsAux = oAp.Autorizaciones.TraerFiltrado("_CantidadAutorizaciones", Array(4, mvarTotalPedido))
'        If Not oRsAux Is Nothing Then
'            If oRsAux.RecordCount > 0 Then
'                oRsAux.MoveFirst()
'                Do While Not oRsAux.EOF
'                    mCantidadFirmas = mCantidadFirmas + 1
'                    mVectorAutorizaciones(mCantidadFirmas) = oRsAux.Fields(0).Value
'                    oRsAux.MoveNext()
'                Loop
'            End If
'            oRsAux.Close()
'        End If

'        oRsAux = oAp.AutorizacionesPorComprobante.TraerFiltrado("_AutorizacionesPorComprobante", Array(4, mIdPedido))
'        If oRsAux.RecordCount > 0 Then
'            For j = 1 To mCantidadFirmas
'                mvarAutorizo = ""
'                oRsAux.MoveFirst()
'                Do While Not oRsAux.EOF
'                    If mVectorAutorizaciones(j) = oRsAux.Fields("OrdenAutorizacion").Value Then
'                        oRsAux1 = oAp.Empleados.Item(oRsAux.Fields("IdAutorizo").Value).Registro
'                        If Not IsNull(oRsAux1.Fields("Iniciales").Value) Then
'                            mvarAutorizo = mvarAutorizo & "" & oRsAux1.Fields("Iniciales").Value
'                        End If
'                        If Not IsNull(oRsAux.Fields("FechaAutorizacion").Value) Then
'                            mvarAutorizo = mvarAutorizo & " " & oRsAux.Fields("FechaAutorizacion").Value
'                        End If
'                        oRsAux1.Close()
'                        If mvarAutorizo = "" Then mvarAutorizo = "???"
'                        Selection.MoveRight(Unit:=wdCell)
'                        Selection.TypeText(Text:="" & mvarAutorizo)
'                        Exit Do
'                    End If
'                    oRsAux.MoveNext()
'                Loop
'                If mvarAutorizo = "" Then
'                    Selection.MoveRight(Unit:=wdCell)
'                End If
'            Next
'        End If
'        oRsAux.Close()

'        ActiveWindow.ActivePane.View.SeekView = wdSeekMainDocument

'    Else

'        Selection.Tables(1).Select()
'        Selection.Tables(1).Delete()
'        Selection.TypeBackspace()

'    End If

'    oRs = Nothing
'    oRsDet = Nothing
'    oRsPrv = Nothing
'    oRsArt = Nothing
'    oRsAux = Nothing
'    oRsAux1 = Nothing

'    oAp = Nothing

'End Sub

