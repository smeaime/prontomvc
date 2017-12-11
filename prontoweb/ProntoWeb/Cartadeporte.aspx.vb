Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Web.Services
Imports System.Diagnostics
Imports System.Linq

Imports ProntoMVC.Data.Models

Imports CartaDePorteManager

Partial Class CartadeporteABM

#Const Ancho = "1000px"

    Inherits System.Web.UI.Page

    Private IdCartaDePorte As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing
    Private _linkImagen2 As Object

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdCartaDePorte"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdCartaDePorte") = Value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        'Me.EnableViewState = False 'todo: debug
        'todo: está bien que deje habilitado el viewstate para el objetito CartaPorte, pero
        'sacarlo para los controles

        If Not (Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsComercial") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsAdmin") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsFacturacion")) Then
            Response.Redirect("CartadeporteExternoMovil.aspx?Id=" & If(Request.QueryString("Id"), "").ToString())
        End If

        If Request.Browser("IsMobileDevice") = "true" Then
            'Response.Redirect("CartaDePorteMovil.aspx?Id=" & If(Request.QueryString("Id"), "").ToString())
        End If



        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            Try
                IdCartaDePorte = Convert.ToInt32(Request.QueryString.Get("Id"))
                Me.IdEntity = IdCartaDePorte
            Catch ex As Exception
                MsgBoxAjaxAndRedirect(Me, "La carta buscada (ID=" & IdCartaDePorte & ") no existe ", String.Format("CartasDePortes.aspx"))
                'myCartaDePorte = AltaSetup() 'para q no se disparen los validadores
                RangeValidatorFechaArribo.MinimumValue = Today.AddDays(-3).ToShortDateString 'si no pongo esto, el range hace explotar la pagina
                'RangeValidatorFechaDescarga.MinimumValue() = Today.AddDays(-3).ToShortDateString
                'RangeValidatorFechaDescarga.Enabled = False
                Return
            End Try

        ElseIf Request.QueryString.Get("CopiaDe") IsNot Nothing Then
        Else
            Me.IdEntity = IdCartaDePorte 'que ha de ser  -1. acá llegaría si no le pasan Id
            Debug.Assert(IdCartaDePorte = -1)
        End If

        mKey = "CartaDePorte_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)

        'hhh

        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'que pasa si el usuario es Nothing? Qué se rompió?
        '-en desarrollo, al modificar el codebehind, quedas logueado pero perdes la sesion.... en todo caso, lo importante es no perder a qué base estas conectado
        'lo mismo puede pasar, supongo, en produccion, al pisar un codebehind (sin reciclar). El usuario queda logueado y pierde la sesion
        If usuario Is Nothing Then
            If Debugger.IsAttached And False Then
                Session(SESSIONPRONTO_UserId) = Membership.GetUser.ProviderUserKey.ToString
                Session(SESSIONPRONTO_UserName) = Membership.GetUser.UserName
                'Session("Empresas") = arrayEmpresas

                Dim idempresa = BDLMasterEmpresasManagerMigrar.IdEmpresaDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)
                'BDLMasterEmpresasManagerMigrar.AddEmpresaToSession("Williams", Session, ConexBDLmaster, Me)
            Else

                Session(SESSIONPRONTO_MiRequestUrl) = Request.RawUrl.ToLower
                'Debug.Print(Session(SESSIONPRONTO_MiRequestUrl))

                Return

                'acá podría usar lo mismo, siempre y cuando esten usando una sola empresa. Y de no ser así, redirigirlos, pero no al login, sino al seleccionarempresa
                Response.Redirect(String.Format("../Login.aspx"))
            End If

        End If
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////



        SC = usuario.StringConnection
        If SC = "" Then
            Response.Redirect("~/SeleccionarEmpresa.aspx")
        End If


        HFSC.Value = SC


        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender3.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender4.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender5.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender6.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender7.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        'AutoCompleteExtender8.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender9.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender10.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender11.ContextKey = SC
        AutoCompleteExtender12.ContextKey = SC
        AutoCompleteExtender19.ContextKey = SC
        AutoCompleteExtender14.ContextKey = SC
        AutoCompleteExtender15.ContextKey = SC
        AutoCompleteExtender16.ContextKey = SC
        AutoCompleteExtender17.ContextKey = SC
        AutoCompleteExtender18.ContextKey = SC
        AutoCompleteExtender30.ContextKey = SC
        AutoCompleteExtender40.ContextKey = SC
        'HFSC.Value = GetConnectionString(Server, Session) 'para que la grilla de consulta sepa la cadena de conexion



        Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte







        If Not Page.IsPostBack Then
            '////////////////////
            'PRIMERA VEZ QUE CARGA
            '////////////////////

            'http://forums.asp.net/t/1362149.aspx     para que no se apriete dos veces el boton de ok
            'btnSave.Attributes.Add("onclick", "this.disabled=true;" + ClientScript.GetPostBackEventReference(btnSave, "").ToString())

            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            'para que el click sobre la scrollbar del autocomplete no dispare el postback del textbox que extiende
            'http://aadreja.blogspot.com/2009/07/clicking-autocompleteextender-scrollbar.html
            'Page.Form.Attributes.Add("onsubmit", "return checkFocusOnExtender();")
            '///////////////////////////////////////////////


            'Page.Form.Attributes.Add("onKeyUp", "return jsRecalcular();")


            '///////////////////////////////////////////////
            '///////////////////////////
            'pongo popups invisible en tiempo de ejecucion, así los puedo ver en tiempo de diseño 
            'busco todas las configuraciones de "PopupControlID="
            PanelInfoNum.Attributes("style") = "display:none"
            Panel1.Attributes("style") = "display:none"
            'Panel4.Attributes("style") = "display:none"
            'PopUpGrillaConsulta.Attributes("style") = "display:none"
            '///////////////////////////


            Session("NombreAdjunto") = ""
            Session("NombreAdjunto2") = ""


            BindTypeDropDown() 'combos
            If IdCartaDePorte > 0 Then
                myCartaDePorte = EditarSetup()

            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myCartaDePorte = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    If True Then
                        myCartaDePorte = AltaSetup()
                    Else
                        'pruebas de debug 
                        'pruebas de debug
                        myCartaDePorte = New CartaDePorte  'pruebas de debug
                        ' RangeValidatorFechaDescarga.MinimumValue() = Today.AddDays(-3).ToShortDateString
                        'pruebas de debug
                        'pruebas de debug
                    End If
                End If
            End If


            If IdCartaDePorte > 0 And myCartaDePorte Is Nothing Then
                MsgBoxAjaxAndRedirect(Me, "La carta buscada (ID=" & IdCartaDePorte & ") no existe ", String.Format("CartasDePortes.aspx"))
                myCartaDePorte = AltaSetup() 'para q no se disparen los validadores
                RangeValidatorFechaArribo.MinimumValue = Today.AddDays(-3).ToShortDateString 'si no pongo esto, el range hace explotar la pagina
                '  RangeValidatorFechaDescarga.MinimumValue() = Today.AddDays(-3).ToShortDateString
                '  RangeValidatorFechaDescarga.Enabled = False
                Return
            End If





            Me.ViewState.Add(mKey, myCartaDePorte)

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")

            BloqueosDeEdicion(myCartaDePorte)


            If myCartaDePorte.NetoFinalIncluyendoMermas > 0 Then 'dependiendo del estado, abre una u otra solapa
                TabContainer2.ActiveTabIndex = 1
            Else
                TabContainer2.ActiveTabIndex = 0
            End If


            '////////////////////////////
            RangeValidatorFechaArribo.MinimumValue = Today.AddDays(-3).ToShortDateString
            RangeValidatorFechaArribo.MaximumValue = Today.AddDays(3).ToShortDateString

            RefrescarRangeValidatorFechaDescarga()

            '   If RangeValidatorFechaDescarga.MinimumValue() = "" Then RangeValidatorFechaDescarga.MinimumValue() = DateTime.MinValue.ToShortDateString 'Today.AddDays(.ToShortDateString







            ''////////////////////////////////////////////////
            ''////////////////////////////////////////////////
            ''debug
            ''Traerme el maestro de clientes creo que son 140k
            'Dim items As New System.Collections.Generic.List(Of String)
            'Dim dt = ExecDinamico(SC, "SELECT razonsocial FROM clientes")
            'For Each dr As Data.DataRow In dt.Rows
            '    items.Add(dr.Item(0))
            'Next
            'ViewState("CacheClientes") = items.ToArray()
            ''////////////////////////////////////////////////
            ''////////////////////////////////////////////////
            ''////////////////////////////////////////////////

            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarSyngenta();", True)
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarSyngentaIntermediario();", True)

            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarAcopiosFacturarA();  jsVerificarSyngenta(); jsVerificarSyngentaCorredor(); jsVerificarSyngentaDestinatario(); jsVerificarSyngentaRemitente(); jsVerificarSyngentaIntermediario(); ", True)
            'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarSyngentaIntermediario();", True)
            'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarSyngentaCorredor();", True)
            'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarSyngentaDestinatario();", True)
            'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", "jsVerificarSyngentaRemitente();", True)





        End If
        'MostrarElementos(False)



        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate



        'PESTAÑA POSICION
        txtBrutoPosicion.Attributes.Add("OnKeyUp", "return jsRecalcular();")
        txtTaraPosicion.Attributes.Add("OnKeyUp", "return jsRecalcular();")


        'PESTAÑA DESCARGA
        'txtNetoDescarga.Attributes.Add("OnTextChanged", "document.getElementById('ctl00_ContentPlaceHolder1_TabContainer2_TabPanel2_txtCantidad4').value=200;")
        txtBrutoDescarga.Attributes.Add("OnKeyUp", "return jsRecalcular();") 'neto
        txtTaraDescarga.Attributes.Add("OnKeyUp", "return jsRecalcular();") 'tara
        'txtTaraDescarga.Attributes.Add("OnTextChanged", "return jsRecalcular();")

        txtHumedadTotal.Attributes.Add("OnKeyUp", "return jsRecalcular();") 'neto
        txtFumigada.Attributes.Add("OnKeyUp", "return jsRecalcular();") 'neto
        txtSecada.Attributes.Add("OnKeyUp", "return jsRecalcular();") 'neto
        txtMerma.Attributes.Add("OnKeyUp", "return jsRecalcular();") 'neto



        If Debugger.IsAttached And False Then
            DebugViewState.SeeViewState(Request.Form("__VIEWSTATE"), "c:\temp\viewstate.txt")
        End If


        'The(value) '' of the MinimumValue property of 'RangeValidatorFechaDescarga' cannot be converted to type 'Date'.

        '        Replace()
        '        MinimumValue = "0.1"
        'with 
        'MinimumValue='<%# (0.1).ToString(System.Globalization.CultureInfo.CurrentCulture) %>' 

        'Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "tabshortcut", "document.attachEvent ('onkeypress',ShortcutKeys);", True)
    End Sub



    'comentario en develop



    Sub VerLog(bTraerImputaciones As Boolean)




        Try

            If IdEntity <= 0 Then Return


            'MsgBoxAjax(Me, s)

            lblLog.Text = CartaDePorteManager.TraerLogDeCartaPorteHtml(SC, IdEntity, bTraerImputaciones)
            upLog.Update()
            '        "Log_InsertarRegistro", IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
            '                                              CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario, _

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub


    Sub RefrescarRangeValidatorFechaDescarga()
        'If Not IsDate(txtFechaArribo.Text) Then
        '    If RangeValidatorFechaDescarga.MinimumValue() = "" Then RangeValidatorFechaDescarga.MinimumValue() = DateTime.MinValue.ToShortDateString 'Today.AddDays(.ToShortDateString
        '    Return
        'End If
        'Try
        '    '* Advertir si la fecha de Descarga es anterior a la de Arribo o bien si es 2 o mas días posterior
        '    RangeValidatorFechaDescarga.MinimumValue = Convert.ToDateTime(txtFechaArribo.Text).ToShortDateString
        '    RangeValidatorFechaDescarga.MaximumValue = Convert.ToDateTime(txtFechaArribo.Text).AddDays(2).ToShortDateString
        'Catch ex As Exception
        '    ErrHandler2.WriteError(ex)
        'End Try
        'If RangeValidatorFechaDescarga.MinimumValue() = "" Then RangeValidatorFechaDescarga.MinimumValue() = DateTime.MinValue.ToShortDateString 'Today.AddDays(.ToShortDateString
    End Sub


    Function AltaSetup() As Pronto.ERP.BO.CartaDePorte
        Dim myCartaDePorte = New Pronto.ERP.BO.CartaDePorte
        myCartaDePorte.Id = -1
        myCartaDePorte.SubnumeroDeFacturacion = -1

        ''/////////////////////////////////
        ''/////////////////////////////////
        'Encabezado
        ''/////////////////////////////////
        ''/////////////////////////////////

        'txtFechaCartaDePorte.Text = System.DateTime.Now.ToShortDateString()
        'txtNumeroCartaDePorte.Text = Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoNumeroCartaDePorte").ToString
        'myCartaDePorte.Fecha = System.DateTime.Now.ToShortDateString()
        'myCartaDePorte.Numero = Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoNumeroCartaDePorte").ToString

        cmbCosecha.SelectedIndex = 0
        'cmbCosecha.Text = "" '(Year(Today) - 1) & "/" & Right(Year(Today), 2)

        RecargarEncabezado(myCartaDePorte)
        'txtFechaCarga.Text = Today
        txtFechaArribo.Text = Today

        txtClienteEntregador.Text = "WILLIAMS ENTREGAS SA 30-70738607-6"
        ''/////////////////////////////////
        ''/////////////////////////////////
        'Detalle
        ''/////////////////////////////////
        ''/////////////////////////////////
        'agrego renglones vacios. Ver si vale la pena

        'Dim mItem As CartaDePorteItem = New Pronto.ERP.BO.CartaDePorteItem
        'mItem.Id = -1
        'mItem.Nuevo = True
        'mItem.Cantidad = 0
        'mItem.Precio = Nothing


        'myCartaDePorte.Detalles.Add(mItem)
        'GridView1.DataSource = myCartaDePorte.Detalles 'este bind lo copié
        'GridView1.DataBind()             'este bind lo copié   
        ''/////////////////////////////////
        ''/////////////////////////////////


        ViewState("PaginaTitulo") = "Nueva Carta"
        Return myCartaDePorte
    End Function






    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As Pronto.ERP.BO.CartaDePorte

        Dim myCartaDePorte As CartaDePorte


        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?
            myCartaDePorte = CartaDePorteManager.GetItem(SC, IdCartaDePorte, True)
            'CartaDePorteManager.DuplicarCartaporteConOtroSubnumeroDeFacturacion(SC, myCartaDePorte)

            btnDuplicar.NavigateUrl = "CartaDePorte.aspx?Id=-1&CopiaDe=" & IdCartaDePorte

        Else
            'está haciendo un alta, pero uso los datos de un ID existente
            IdCartaDePorte = -1
            myCartaDePorte = CartaDePorteManager.GetItem(SC, CopiaDeOtroId, True)
            myCartaDePorte.Id = -1
            myCartaDePorte.SubnumeroDeFacturacion = CartaDePorteManager.ProximoSubNumeroParaNumeroCartaPorte(SC, myCartaDePorte)
            myCartaDePorte.IdClienteAFacturarle = -1
            MostrarLinksAFamiliaDeDuplicados(myCartaDePorte)

            'hago que directamente ya se grabe
            CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))
            IdCartaDePorte = myCartaDePorte.Id
            btnDuplicar.Visible = False

            Me.ViewState.Add(mKey, myCartaDePorte)
            'tomar el ultimo de la serie y sumarle uno



        End If

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9811
        Dim aaa = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_VerHistorial)
        If Not aaa("PuedeLeer") Then
            'butVerLog.Visible = False
        Else
            VerLog(False)

        End If


        If Not (myCartaDePorte Is Nothing) Then
            RecargarEncabezado(myCartaDePorte)

            'GridView1.Columns(0).Visible = False
            'GridView1.DataSource = myCartaDePorte.Detalles
            'GridView1.DataBind()

            ViewState("PaginaTitulo") = "Carta " + myCartaDePorte.NumeroCartaDePorte.ToString
        End If

        Try
            MostrarLinksAFamiliaDeDuplicados(myCartaDePorte)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try





        Return myCartaDePorte
    End Function


    Sub BloqueosDeEdicion(ByVal myCartaDePorte As Pronto.ERP.BO.CartaDePorte)
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Cartas_de_Porte)

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            Response.Redirect(String.Format("Principal.aspx"))
        End If



        p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_FacturarleAClienteExplicito)
        If p("PuedeLeer") Then
            lblFacturarleAesteCliente.Visible = True
            txtFacturarleAesteCliente.Visible = True
        End If







        With myCartaDePorte

            '//////////////////////////
            '/////// verifico q un desde un punto de venta no se metan en una carta de otro punto de venta
            '//////////////////////////

            Dim pventa As Integer
            Try
                pventa = EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
            Catch ex As Exception
                pventa = 0
                ErrHandler2.WriteError(ex)
            End Try

            ErrHandler2.WriteError("PV " & .PuntoVenta & " " & pventa)

            If .Id <> -1 And pventa <> 0 And .PuntoVenta <> pventa Then
                MsgBoxAjaxAndRedirect(Me, "La carta de porte no pertenece a tu punto de venta", String.Format("Principal.aspx"))
                'Response.Redirect(String.Format("Principal.aspx"))
                Exit Sub
            End If

            '//////////////////////////
            '//////////////////////////
            '//////////////////////////


            If .Id = -1 Then
                '//////////////////////////
                'es NUEVO
                '//////////////////////////

                LinkImprimir.Visible = False
                btnAnular.Visible = False
                MostrarBotonesParaAdjuntar()
                'lnkRepetirUltimaCDP.Visible = True

                butVerLog.Visible = False

                TabPanel5.Enabled = False
            Else
                '//////////////////////////
                'es EDICION
                '//////////////////////////

                LinkImprimir.Visible = True
                btnAnular.Visible = True
                MostrarBotonesParaAdjuntar()
                'lnkRepetirUltimaCDP.Visible = True

                'txtNumeroCDP.Enabled = False

                If .SubnumeroDeFacturacion > 0 Then
                    txtNumeroCDP.Enabled = False
                    txtSubfijo.Enabled = False
                    txtSubNumeroVagon.Enabled = False
                End If



                'If .IdAprobo > 0 Or .Cumplido = "AN" Then
                If .IdFacturaImputada <> 0 Or .Anulada = "SI" Then
                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////


                    'btnAnular.Visible = False
                    lnkRepetirUltimaCDP.Visible = False
                    DisableControls(TabContainer2)

                    'me fijo si está cerrado
                    'DisableControls(Me)
                    'GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True
                    btnDuplicar.Visible = False

                    'encabezado
                    txtTitular.Enabled = False
                    'cmbEmpleado.Enabled = False
                    txtObservaciones.Enabled = False
                    'cmbLibero.Enabled = False
                    'txtNumeroCartaDePorte.Enabled = False
                    'cmbComparativas.Enabled = False
                    'txtFechaCartaDePorte.Enabled = False

                    'detalle
                    'LinkButton1.Enabled = False 'boton "+Agregar item"
                    txt_AC_Articulo.Enabled = False
                    'txtDetObservaciones.Enabled = False
                    'txtDetTotal.Enabled = False
                    'LinkAgregarRenglon.Visible = False
                    'Dim divAdjunto As HtmlGenericControl = ((Master.FindControl("Adjunto")))
                    'divAdjunto.Visible = False

                    'links a popups
                    'LinkAgregarRenglon.Style.Add("visibility", "hidden")

                    'LinkButton1.Style.Add("visibility", "hidden")
                    'LinkButtonPopupDirectoCliente.Style.Add("visibility", "hidden")
                    'lnkRepetirUltimaCDP.Style.Add("visibility", "hidden")
                    'LinkButton7.Style.Add("visibility", "hidden")
                    'lnkRepetirUltimaCDP.Style.Add("visibility", "hidden")


                Else
                    'LinkButton1.Enabled = True
                    'LinkButtonPopupDirectoCliente.Enabled = True
                    btnDesfacturar.Visible = False
                End If

                If .Anulada = "SI" Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    'btnAnular.Visible = False
                    lblAnulado.Visible = True
                    lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & .MotivoAnulacion
                    lblAnulado.Text = "RECHAZADA el " & .FechaAnulacion & " por " & .MotivoAnulacion
                    lblAnulado.Font.Size = 8

                    btnAnular.Text = "Desrechazar"
                End If




                chkTieneRecibidorOficial.Enabled = True
                cmbEstadoRecibidor.Enabled = True
                cmbMotivoRechazoRecibidor.Enabled = True
                txtClienteAcondicionador.Enabled = True





                If .IdFacturaImputada <> 0 Or .Anulada = "SI" Then


                    ' btnSave.Visible = False
                    ' btnCancel.Text = "Salir"

                    ' Recibo, Contrato y Observaciones queden editables.
                    txtNRecibo.Enabled = True
                    txtContrato.Enabled = True
                    txtObservaciones.Enabled = True



                    '/////////////////////////////////////////////////////
                    'consulta #11099	_Liberar kg en CP facturada
                    txtBrutoPosicion.Enabled = True
                    txtTaraPosicion.Enabled = True
                    txtNetoPosicion.Enabled = True
                    txtBrutoDescarga.Enabled = True
                    txtTaraDescarga.Enabled = True
                    txtNetoDescarga.Enabled = True
                    txtNetoFinalTotalMenosMermas.Enabled = True
                    '///////////////////////////////////////////////////




                    panelAdjunto.Visible = False

                    'btnDesfacturar.Visible = True
                    If .IdFacturaImputada > 0 Then btnAnular.Visible = False

                    btnDuplicar.Visible = False
                End If



            End If

        End With



        TextBox5.Enabled = True
        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9513
        'Sacarle a todos los usuarios excepto los de facturacion y a Hugo el link desde 
        'la carta de porte a la factura, el historial y el boton desfacturar.

        Dim c = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_Facturacion)
        If Not c("PuedeModificar") Then
            btnDesfacturar.Visible = False
            ' butVerLog.Visible = False
            'linkFactura.Visible = False
        End If


        linkImagen.Enabled = True

        butVerLog.Enabled = True
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9811
        Dim aaa = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_VerHistorial)
        If Not aaa("PuedeLeer") Then
            butVerLog.Visible = False
        End If

        Dim bbb = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_VerFacturaImputada)
        If Not bbb("PuedeLeer") Then
            linkFactura.Visible = False
        End If


        '////////////////////////////////////////////
        '////////////////////////////////////////////


        Try


            Using db = New DemoProntoEntities(Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))

                Dim rec As Reclamo
                Dim carta = db.CartasDePortes.Find(myCartaDePorte.Id)

                rec = db.Reclamos.Find(carta.IdReclamo)

                If rec IsNot Nothing Then
                    If rec.Estado = 2 Then
                        'Button6.Enabled = False
                        TextBox5.Enabled = False
                        AsyncFileUpload3.Enabled = False
                        'btnCerrarReclamo.Enabled = False

                        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUp2",
                                "$('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5_btnCerrarReclamo').hide();  $('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5_btnAbrirReclamo').show(); " _
                                , True)

                    Else

                        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUp2",
                                "$('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5_btnCerrarReclamo').show();  $('#ctl00_ContentPlaceHolder1_TabContainer2_TabPanel5_btnAbrirReclamo').hide(); " _
                                , True)

                    End If

                End If

            End Using

        Catch ex As Exception

            ErrHandler2.WriteError(ex)
        End Try


    End Sub


    Sub MostrarLinksAFamiliaDeDuplicados(ByVal oCP As CartaDePorte)
        Dim lista As IQueryable(Of CartasDePorte) = CartaDePorteManager.FamiliaDeDuplicadosDeCartasPorte(SC, oCP)

        'If lista.Count > 1 Or oCP.SubnumeroDeFacturacion > 0 Then
        If oCP.SubnumeroDeFacturacion >= 0 Or lista.Where(Function(x) x.Anulada <> "SI").Count > 1 Then

            'muestro el numero del duplicado actual, y los links al resto
            lblFamiliaDuplicados.Text = "" & CartaDePorteManager.ListaDeLinks(lista, oCP.SubnumeroDeFacturacion)


            If lblFamiliaDuplicados.Text = "" Then
                lblFacturarleAesteCliente.Visible = False
                txtFacturarleAesteCliente.Visible = False

                If oCP.Id > -1 Then
                    Dim s = "La carta numero " & oCP.NumeroCartaDePorte.ToString & " id=" & oCP.Id.ToString & " tiene el subnumerodefacturacion mal subn=" & oCP.SubnumeroDeFacturacion.ToString
                    ErrHandler2.WriteError(s)
                    If False Then
                        MandarMailDeError(s)
                    End If

                End If
            Else

                lblFacturarleAesteCliente.Visible = True
                txtFacturarleAesteCliente.Visible = True

            End If


            ' DeshabilitarLosControles()


            If oCP.SubnumeroDeFacturacion > 0 Then
                'no es el original

                'DeshabilitarLosControles()

                DisableControls(TabContainer2)

                'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9311
                'Solicitan dejar habilitado el tilde de Costo administrativo en las Cartas de Porte duplicadas, ya que a veces se les cobra a uno solo de los clientes.
                chkConCostoAdministrativo.Enabled = True





                '- En las duplicaciones deben estar habilitados los campos:
                '. * Tilde de exportacion
                '. * Calidad en pestaña de Descarga
                '. * Observaciones
                chkExporta.Enabled = True
                TextBoxCalidad.Enabled = True
                txtObservaciones.Enabled = True


                txtTitular.Enabled = True
                txtIntermediario.Enabled = True
                txtRcomercial.Enabled = True
                txtCorredor.Enabled = True
                txtDestinatario.Enabled = True
                txtTransportista.Enabled = True
                txtChofer.Enabled = True
                txtClienteAuxiliar.Enabled = True
                TextBoxCorredorII.Enabled = True


                optAcopiosFacturarA.Enabled = True
                chkFacturarManual.Enabled = True

                optDivisionSyngenta.Enabled = True
                optDivisionSyngentaIntermediario.Enabled = True
                optDivisionSyngentaRemitente.Enabled = True
                optDivisionSyngentaCorredor.Enabled = True
                optDivisionSyngentaDestinatario.Enabled = True
                optDivisionSyngentaCliobs.Enabled = True


                txtClienteEntregador.Enabled = True


                lblFacturarleAesteCliente.Enabled = True
                txtFacturarleAesteCliente.Enabled = True
                lnkRepetirUltimaCDP.Enabled = False


                chkNoFacturarASubcontratistas.Checked = False
                chkNoFacturarASubcontratistas.Enabled = False
            End If
        Else
            lblFacturarleAesteCliente.Visible = False
            txtFacturarleAesteCliente.Visible = False
        End If

    End Sub






    Private Sub BindTypeDropDown()
        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)
        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)
        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)

        'cmbProveedor.DataSource = ProveedorManager.GetListCombo(SC)
        'cmbProveedor.DataTextField = "Titulo"
        'cmbProveedor.DataValueField = "IdProveedor"
        'cmbProveedor.DataBind()

        'cmbEmpleado.DataSource = EmpleadoManager.GetListCombo(SC)
        'cmbEmpleado.DataTextField = "Titulo"
        'cmbEmpleado.DataValueField = "IdEmpleado"
        'cmbEmpleado.DataBind()

        'cmbLibero.DataSource = EmpleadoManager.GetListCombo(SC)
        'cmbLibero.DataTextField = "Titulo"
        'cmbLibero.DataValueField = "IdEmpleado"
        'cmbLibero.DataBind()


        If True Then
            optDivisionSyngenta.DataTextField = "desc"
            optDivisionSyngenta.DataValueField = "idacopio"
            optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optDivisionSyngenta.DataBind()

            optDivisionSyngentaIntermediario.DataTextField = "desc"
            optDivisionSyngentaIntermediario.DataValueField = "idacopio"
            optDivisionSyngentaIntermediario.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optDivisionSyngentaIntermediario.DataBind()

            optDivisionSyngentaRemitente.DataTextField = "desc"
            optDivisionSyngentaRemitente.DataValueField = "idacopio"
            optDivisionSyngentaRemitente.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optDivisionSyngentaRemitente.DataBind()

            optDivisionSyngentaCorredor.DataTextField = "desc"
            optDivisionSyngentaCorredor.DataValueField = "idacopio"
            optDivisionSyngentaCorredor.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optDivisionSyngentaCorredor.DataBind()

            optDivisionSyngentaDestinatario.DataTextField = "desc"
            optDivisionSyngentaDestinatario.DataValueField = "idacopio"
            optDivisionSyngentaDestinatario.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optDivisionSyngentaDestinatario.DataBind()

            optAcopiosFacturarA.DataTextField = "desc"
            optAcopiosFacturarA.DataValueField = "idacopio"
            optAcopiosFacturarA.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optAcopiosFacturarA.DataBind()


            optDivisionSyngentaCliobs.DataTextField = "desc"
            optDivisionSyngentaCliobs.DataValueField = "idacopio"
            optDivisionSyngentaCliobs.DataSource = CartaDePorteManager.excepcionesAcopios(SC).Select(Function(z) New With {z.idacopio, z.desc})
            optDivisionSyngentaCliobs.DataBind()
        End If






        DropDownList2.DataSource = EmpleadoManager.GetListCombo(SC)
        DropDownList2.DataTextField = "Titulo"
        DropDownList2.DataValueField = "IdEmpleado"
        DropDownList2.DataBind()

        cmbUsuarioAnulo.DataSource = EmpleadoManager.GetListCombo(SC)
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(SC)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(SC, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0


        Dim pventa As Integer
        Try
            pventa = EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
        Catch ex As Exception
            pventa = 0
            ErrHandler2.WriteError(ex)
        End Try

        BuscaTextoEnCombo(cmbPuntoVenta, pventa)
        If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir





        Dim s = New ServicioCartaPorte.servi()

        Dim usuarios = s.UsuariosExternosQuePuedenChatearEnEstaCarta(IdCartaDePorte, SC, ConexBDLmaster)

        usuarioschat.DataSource = usuarios



        ''///////////////////////////////////////////////
        ''///////////////////////////////////////////////

        'cmbCalidad.DataSource = EntidadManager.ExecDinamico(SC, "SELECT * FROM Calidades")
        'cmbCalidad.DataTextField = "Descripcion"
        'cmbCalidad.DataValueField = "IdCalidad"
        'cmbCalidad.DataBind()
        'cmbCalidad.Items.Insert(0, New ListItem("-- Elija una Calidad --", -1))
        'cmbCalidad.SelectedIndex = 0


        'IniciaCombo(SC, cmbCalidad, tipos.IBCondiciones)


        ''///////////////////////////////////////////////
        ''///////////////////////////////////////////////

        'cmbHumedad.DataSource = EntidadManager.ExecDinamico(SC, "SELECT * FROM CDPHumedades")
        ''If cmbhumedad.DataSource.Tables(0).Rows.Count = 0 Then
        ''End If
        'cmbHumedad.DataTextField = "Humedad"
        'cmbHumedad.DataValueField = "IdCDPHumedad"
        'cmbHumedad.DataBind()

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click

        Response.Redirect(String.Format("CartasDePortes.aspx"))
        Exit Sub


        Dim script As String = "var windowObject = window.self; windowObject.opener = window.self; windowObject.close(); window.location.href='CartasDePortes.aspx'"
        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "Close Window", script, True)
        Exit Sub

        If IdEntity = -1 Then
            'si cancela en una nueva, redirigir a grilla. hacer este codigo de manera mas elegante, con endEditing()
            Response.Redirect(String.Format("CartasDePortes.aspx"))

            Exit Sub
        End If

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
        Dim buscador As TextBox = Me.Master.FindControl("txtBuscador")

        If MensajeFinal <> "" Then
            'Response.Write("<script>alert('message') ; window.location.href='Comparativas.aspx'</script>")

            'PreRedirectMsgbox.OnOkScript = "window.location = ""Comparativas.aspx"""
            'ButMsgboxSI.PostBackUrl = "Comparativas.aspx"
            LblPreRedirectMsgbox.Text = MensajeFinal
            PreRedirectMsgbox.Show()
            'el confirmbutton tambien me sirve si el usuario aprieta sin querer en el menu!!!!!! -no, no sirve para eso
        Else
            'PreRedirectConfirmButtonExtender.Enabled = False 'http://stackoverflow.com/questions/2096262/conditional-confirmbuttonextender
            'Response.Redirect(String.Format("CartasDePortes.aspx"))


            'cierra la ventana http://forums.asp.net/t/1343473.aspx
            'http://stackoverflow.com/questions/528671/javascript-window-open-only-if-the-window-does-not-already-exist
            If False Then
                Dim script As String = "var windowObject = window.self; windowObject.opener = window.self; windowObject.close(); window.location.href='CartasDePortes.aspx'"
                AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "Close Window", script, True)
            End If
            'BERZONI- Otro ejemplo:  cuando modificas una cporte (le cargas los datos completos ) , le das aceptar y no queda la misma cporte vuelve a todas las ccpp,  y si queres buscar esa que modificaste en el buscador general no la trae.
            'LblPreRedirectMsgbox.Text = "Grabada " & Now.ToString("h:mm")
            Label1.Text = "Grabada a las " & Now.ToString("h:mm:ss")
            'no usar mas el script de cierre


            'si es la unica ventana abierta, no se cierra, ni redirige. Entonces da la sensacion de que no hizo nada.

            'Page.ClientScript.RegisterStartupScript(Me.GetType(), "Close Window", Script, True)

        End If
    End Sub

    Protected Sub ButMsgboxSI_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButMsgboxSI.Click
        'Response.Redirect(String.Format("CartasDePortes.aspx")) 'roundtrip al cuete?
        CrearClientes()
        btnSave_Click(sender, e)
    End Sub


    Protected Sub ButMsgboxNO_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButMsgboxNO.Click

    End Sub



    Protected mustAlert As Boolean = False


    '//////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////

    'Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
    '    '(si el boton no reacciona, probá sacando el CausesValidation)

    '    'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
    '    'viestate el -1!!!!!


    '    ViewState("IdDetalleCartaDePorte") = -1

    '    'UpdatePanel4.Update()
    '    'ModalPopupExtender3.Show()


    'End Sub







    'Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
    '    'MostrarElementos(False)
    '    mAltaItem = True
    '    'UpdatePanel4.Update()
    'End Sub

    'Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    '    Dim mOk As Boolean

    '    Page.Validate("Detalle")
    '    mOk = Page.IsValid

    '    If mOk Then
    '        'If (Me.ViewState(mKey) IsNot Nothing) Then

    '        Dim mIdItem As Integer
    '        'mIdItem = hfIdItem.Value

    '        'If ViewState("IdDetalleCartaDePorte") Is Nothing Then
    '        '    'se debe haber llamado al popup desde el cliente... por ahora, lo asigno yo....
    '        '    mIdItem = -1
    '        'Else
    '        '    mIdItem = DirectCast(ViewState("IdDetalleCartaDePorte"), Integer)
    '        'End If


    '        Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)

    '        'acá tengo que traer el valor id del hidden


    '        If mIdItem = -1 Then
    '            Dim mItem As CartaDePorteItem = New Pronto.ERP.BO.CartaDePorteItem

    '            If myCartaDePorte.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
    '                MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
    '                Exit Sub
    '            End If

    '            mItem.Id = myCartaDePorte.Detalles.Count
    '            mItem.Nuevo = True
    '            mIdItem = mItem.Id
    '            myCartaDePorte.Detalles.Add(mItem)
    '        End If


    '        Try
    '            With myCartaDePorte.Detalles(mIdItem)
    '                'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
    '                ' de cada valor, como se hace en toda web

    '                'ORIGINAL EDU:
    '                '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
    '                '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
    '                'MODIFICADO CON AUTOCOMPLETE:
    '                '.IdArticulo = Convert.ToInt32(SelectedReceiver.Value)
    '                '.Articulo = txtTitular.Text

    '                '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
    '                '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
    '                .IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
    '                .Articulo = txt_AC_Articulo.Text

    '                .Cantidad = Convert.ToDecimal(txtCantidad.Text)
    '                '.IdUnidad = Convert.ToInt32(UnidadPorIdArticulo(.IdArticulo, SC))
    '                .IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)

    '                .FechaEntrega = iisValidSqlDate(txtFechaNecesidad.Text, Now)
    '                .Observaciones = txtObservacionesItem.Text.ToString
    '                If RadioButtonList1.SelectedItem IsNot Nothing Then
    '                    .OrigenDescripcion = RadioButtonList1.SelectedItem.Value
    '                End If
    '                'TO DO
    '                .FechaNecesidad = .FechaEntrega '#1/1/2009#
    '                .FechaDadoPorCumplido = .FechaEntrega '#1/1/2009#
    '                .FechaAsignacionCosto = .FechaEntrega ' #1/1/2009#
    '            End With
    '        Catch
    '            'lblError.Visible = True
    '            Exit Sub
    '        End Try


    '        Me.ViewState.Add(mKey, myCartaDePorte)
    '        'GridView1.DataSource = myCartaDePorte.Detalles
    '        'GridView1.DataBind()
    '        'ModalPopupExtender3.Hide()
    '        'UpdatePanel4.Update()
    '        'MostrarElementos(False)
    '        mAltaItem = True
    '    Else

    '        'como el item es inválido, no oculto el popup
    '        'ModalPopupExtender3.Show()

    '        'MsgBoxAjax(Me, "")
    '        'necesito un update del updatepanel?
    '    End If
    'End Sub

    Sub VaciarEncabezado()
        'no usás esta funcion para vaciar despues de un alta, lo haces por javascript con resetForm()
        'no usás esta funcion para vaciar despues de un alta, lo haces por javascript con resetForm()
        'no usás esta funcion para vaciar despues de un alta, lo haces por javascript con resetForm()
        'no usás esta funcion para vaciar despues de un alta, lo haces por javascript con resetForm()
        'no usás esta funcion para vaciar despues de un alta, lo haces por javascript con resetForm()
        'no usás esta funcion para vaciar despues de un alta, lo haces por javascript con resetForm()

        txtNumeroCDP.Text = ""
        txtSubfijo.Text = ""
        txtSubNumeroVagon.Text = ""
        txtChofer.Text = ""
        txtTransportista.Text = ""
        'cmbCosecha.SelectedItem.Value = ""

    End Sub


    '<WebMethod()> _
    Protected Sub btnDuplicarEscondido_Click() Handles btnDuplicarEscondido.Click
        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8098

        'https://docs.google.com/document/d/1sMSr1zzL9gvndpN7lsfGBxONyCLHdywMLpzdQ_kQmxE/edit?hl=es

        Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)



        If myCartaDePorte.Id > 0 Then

            If myCartaDePorte.SubnumeroDeFacturacion < 0 Then myCartaDePorte.SubnumeroDeFacturacion = 0

            '////////////////////////////////////////////////////////////////////////////////////////////////////////
            'CONCURRENCIA AL DUPLICAR:
            'el save del original se va a quejar del timestamp, porque al duplicar, el original se modificó (recordá
            '  que la duplicación se hizo en otra llamada de página mediante el parámetro CopiaDe. Quiero decir, que cuando se llega acá,
            ' probablemente ya se duplicó la carta) 
            '-Eso esta mal, porque debería duplicar no solo basandose en el Id, sino tambien 
            ' en el contenido modificado, y eso no se actualiza hasta que se ejecuta el Save que está acá abajo.
            '-en definitiva, se generó la copia antes de grabar acá...
            '-pero no entiendo... qué modificó (del timestamp del Original) la llamada usando el parametro CopiaDe??  -Y, porque el Save del 
            '  duplicado llamará a CopiarCarta() para pasarle sus nuevos datos a su familia
            '- ok, solucionado. Pero ahora queda el CopiarCarta que llama el original en este Save.
            '////////////////////////////////////////////////////////////////////////////////////////////////////////
            CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName), False)



            Me.ViewState.Add(mKey, myCartaDePorte) 'guardo en el viewstate el objeto

            MostrarLinksAFamiliaDeDuplicados(myCartaDePorte) 'no le está dando tiempo al duplicado para crearse...


            RecargarEncabezado(myCartaDePorte)

            lblFacturarleAesteCliente.Visible = True
            txtFacturarleAesteCliente.Visible = True

            '    AbrirOtroId(myCartaDePorte.Id)


        Else
            MsgBoxAjax(Me, "Grabe la carta antes de duplicarla")
        End If


        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////

        '        El subnumero no será editable

        'Será posible replicar más de una vez la misma Carta de Porte.

        'Al duplicar una Carta de Porte se deberá indicar en cada una de las copias (también en la primera) a quién se le facturará. Esto debe ser una exigencia para grabar la copia.

        'Para los correos, se enviará solamente la información de una de las copias (para no enviar más de una vez los mismos datos)

        'En cada una de las copias, mostrar cuantas y cuales copias tiene. Si es posible hacer acceso directo a cada una.

        'Al anular una factura que tenga imputada una de las copias de una Carta de Porte, se liberará solamente está copia. 

        'Una vez que esto está en orden, cada copia de la Carta de Porte entra en el automático de facturación a nombre del cliente indicado.

        'Para la liquidación de los Subcontratistas, solamente tener en cuenta la primer Carta de Porte (eliminar el checkbox “No facturar a subcontratistas”)

        'El combo “Facturar a” solo aparecerá en las Cartas de Porte duplicadas (incluyendo la primera). No debe aparecer en el resto de las Cartas de Porte

    End Sub

    Sub AbrirOtroId(ByVal id)

        Dim sUrl = "CartaDePorte.aspx?Id=-1&CopiaDe=" & id




        If False Then
            'metodo 1: abro usando la misma ventana
            Response.Redirect(sUrl)
        Else
            'metodo 2
            'abro otra ventana. probablemente sea mejor hacerlo con un Hiperlink
            ' http://stackoverflow.com/questions/4907843/open-url-in-new-tab-using-javascript
            Dim str As String
            str = "window.open('" & sUrl & "');"
            'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)
        End If
    End Sub






    Sub CargarObjeto(ByRef myCartaDePorte As CartaDePorte)
        With myCartaDePorte



            .NumeroCartaDePorte = Convert.ToInt64(txtNumeroCDP.Text)
            .SubnumeroVagon = StringToDecimal(txtSubNumeroVagon.Text)
            .CEE = StringToDecimal(txtCEE.Text)
            .CTG = StringToDecimal(txtCTG.Text)

            .PuntoVenta = Convert.ToInt32(cmbPuntoVenta.Text)

            .FechaDeCarga = iisValidSqlDate(txtFechaCarga.Text)
            .FechaArribo = iisValidSqlDate(txtFechaArribo.Text)
            .FechaVencimiento = iisValidSqlDate(txtFechaVencimiento.Text)




            '.Calidad = cmbCondicionCompra0.Text
            .Contrato = txtContrato.Text
            .BrutoPto = StringToDecimal(txtBrutoPosicion.Text)
            .TaraPto = StringToDecimal(txtTaraPosicion.Text)
            .NetoPto = StringToDecimal(txtNetoPosicion.Text)



            .IdArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, SC)
            .IdTransportista = BuscaIdTransportistaPrecisoConCUIT(txtTransportista.Text, SC)
            .IdChofer = BuscaIdChoferPrecisoConCUIT(txtChofer.Text, SC)
            .Procedencia = BuscaIdLocalidadPreciso(txtOrigen.Text, SC)
            .Destino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, SC)



            .Secada = cmbTipoMermaGranosExtranos.SelectedValue * &H1 +
                    cmbTipoMermaQuebrados.SelectedValue * &H2 +
                    cmbTipoMermaDaniados.SelectedValue * &H4 +
                    cmbTipoMermaChamico.SelectedValue * &H8 +
                    cmbTipoMermaRevolcado.SelectedValue * &H10 +
                    cmbTipoMermaObjetables.SelectedValue * &H20 +
                    cmbTipoMermaAmohosados.SelectedValue * &H40 +
                    cmbTipoMermaPuntaSombreada.SelectedValue * &H80 +
                    cmbTipoMermaHectolitrico.SelectedValue * &H100 +
                    cmbTipoMermaCarbon.SelectedValue * &H200 +
                    cmbTipoMermaPanzaBlanca.SelectedValue * &H400 +
                    cmbTipoMermaPicados.SelectedValue * &H800 +
                    cmbTipoMermaVerdes.SelectedValue * &H1000 +
                    cmbTipoMermaQuemados.SelectedValue * &H2000 +
                    cmbTipoMermaTierra.SelectedValue * &H4000 +
                    cmbTipoMermaZarandeo.SelectedValue * &H8000 +
                    cmbTipoMermaHumedad.SelectedValue * &H10000 +
                    cmbTipoMermaFumigacion.SelectedValue * &H20000 +
                    cmbTipoMermaDescuentoFinal.SelectedValue * &H40000 +
                    cmbTipoMermaGrado.SelectedValue * &H80000








            .CalidadGastoDeSecada = StringToDecimal(txtCalidadGastoDeSecada.Text)
            .CalidadGastoDeSecadaMerma = StringToDecimal(txtCalidadGastoDeSecadaMerma.Text)
            .CalidadGastoDeSecadaRebaja = StringToDecimal(txtCalidadGastoDeSecadaRebaja.Text)
            .TipoMermaGastoDeSecada = cmbTipoMermaGastoDeSecada.SelectedValue


            .CalidadMermaVolatil = StringToDecimal(txtCalidadMermaVolatil.Text)
            .CalidadMermaVolatilMerma = StringToDecimal(txtCalidadMermaVolatilMerma.Text)
            .CalidadMermaVolatilRebaja = StringToDecimal(txtCalidadMermaVolatilRebaja.Text)
            .TipoMermaVolatil = cmbTipoMermaVolatil.SelectedValue


            .CalidadFondoNidera = StringToDecimal(txtCalidadFondoNidera.Text)
            .CalidadFondoNideraMerma = StringToDecimal(txtCalidadFondoNideraMerma.Text)
            .CalidadFondoNideraRebaja = StringToDecimal(txtCalidadFondoNideraRebaja.Text)
            .TipoMermaFondoNidera = cmbTipoMermaFondoNidera.SelectedValue


            .CalidadMermaConvenida = StringToDecimal(txtCalidadMermaConvenida.Text)
            .CalidadMermaConvenidaMerma = StringToDecimal(txtCalidadMermaConvenidaMerma.Text)
            .CalidadMermaConvenidaRebaja = StringToDecimal(txtCalidadMermaConvenidaRebaja.Text)
            .TipoMermaConvenida = cmbTipoMermaConvenida.SelectedValue


            .CalidadTalCualVicentin = StringToDecimal(txtCalidadTalCualVicentin.Text)
            .CalidadTalCualVicentinMerma = StringToDecimal(txtCalidadTalCualVicentinMerma.Text)
            .CalidadTalCualVicentinRebaja = StringToDecimal(txtCalidadTalCualVicentinRebaja.Text)
            .TipoMermaTalCualVicentin = cmbTipoMermaTalCualVicentin.SelectedValue




            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            .EnumSyngentaDivision = ""

            .EnumSyngentaDivision = optDivisionSyngenta.SelectedItem.Text 'optDivisionSyngenta.SelectedValue
            .Acopio1 = CartaDePorteManager.BuscarIdAcopio(optDivisionSyngenta.SelectedItem.Text, SC)
            .Acopio2 = CartaDePorteManager.BuscarIdAcopio(optDivisionSyngentaIntermediario.SelectedItem.Text, SC)
            .Acopio3 = CartaDePorteManager.BuscarIdAcopio(optDivisionSyngentaRemitente.SelectedItem.Text, SC)
            .Acopio4 = CartaDePorteManager.BuscarIdAcopio(optDivisionSyngentaCorredor.SelectedItem.Text, SC)
            .Acopio5 = CartaDePorteManager.BuscarIdAcopio(optDivisionSyngentaDestinatario.SelectedItem.Text, SC)
            .Acopio6 = CartaDePorteManager.BuscarIdAcopio(optDivisionSyngentaCliobs.SelectedItem.Text, SC)
            .AcopioFacturarleA = CartaDePorteManager.BuscarIdAcopio(optAcopiosFacturarA.SelectedItem.Text, SC)

            If False Then

                If optDivisionSyngenta.SelectedValue <> "" And InStr(txtTitular.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngenta.SelectedValue
                If optDivisionSyngentaIntermediario.SelectedValue <> "" And InStr(txtIntermediario.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaIntermediario.SelectedValue
                If optDivisionSyngentaRemitente.SelectedValue <> "" And InStr(txtRcomercial.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaRemitente.SelectedValue
                If optDivisionSyngentaCorredor.SelectedValue <> "" And InStr(txtCorredor.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaCorredor.SelectedValue
                If optDivisionSyngentaDestinatario.SelectedValue <> "" And InStr(txtDestinatario.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaDestinatario.SelectedValue

                If .EnumSyngentaDivision = "" Then
                    'qué pasa si ponen ACA y tambien SYNGENTA? https://mail.google.com/mail/u/0/#inbox/142ebe7353ac974e

                    'hay un problema: si ponen optDivisionSyngentaIntermediario, pero el optDivisionSyngentaRemitente lo dejan vacio, el EnumSyngentaDivision queda vacio.
                    If optDivisionSyngenta.SelectedValue <> "" And InStr(txtTitular.Text, "A.C.A") Then .EnumSyngentaDivision = optDivisionSyngenta.SelectedValue
                    If optDivisionSyngentaIntermediario.SelectedValue <> "" And InStr(txtIntermediario.Text, "A.C.A") Then .EnumSyngentaDivision = optDivisionSyngentaIntermediario.SelectedValue
                    If optDivisionSyngentaRemitente.SelectedValue <> "" And InStr(txtRcomercial.Text, "A.C.A") Then .EnumSyngentaDivision = optDivisionSyngentaRemitente.SelectedValue

                End If

            End If


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////////




            .IdClienteAuxiliar = BuscaIdClientePrecisoConCUIT(txtClienteAuxiliar.Text, SC)
            If .IdClienteAuxiliar = -1 Then .IdClienteAuxiliar = Nothing

            .IdClienteEntregador = BuscaIdClientePrecisoConCUIT(txtClienteEntregador.Text, SC)
            If .IdClienteEntregador = -1 Then .IdClienteEntregador = Nothing

            .IdClientePagadorFlete = BuscaIdClientePrecisoConCUIT(txtClientePagadorFlete.Text, SC)
            If .IdClientePagadorFlete = -1 Then .IdClientePagadorFlete = Nothing




            .TieneRecibidorOficial = chkTieneRecibidorOficial.Checked
            .EstadoRecibidor = cmbEstadoRecibidor.SelectedIndex
            .MotivoRechazo = cmbMotivoRechazoRecibidor.SelectedIndex
            .ClienteAcondicionador = BuscaIdClientePrecisoConCUIT(txtClienteAcondicionador.Text, SC)
            If .ClienteAcondicionador = -1 Then .ClienteAcondicionador = Nothing


            .EntregaSAP = txtEntregaSAP.Text







            .Subcontr1 = BuscaIdClientePrecisoConCUIT(txtSubcontr1.Text, SC)
            .Subcontr2 = BuscaIdClientePrecisoConCUIT(txtSubcontr2.Text, SC)
            .Contrato1 = cmbTipoContrato1.SelectedValue 'corregir
            .Contrato2 = cmbTipoContrato2.SelectedValue 'corregir


            .IdClienteAFacturarle = BuscaIdClientePrecisoConCUIT(txtFacturarleAesteCliente.Text, SC)





            .NumeroSubfijo = StringToDecimal(txtSubfijo.Text)

            .Patente = txtPatenteCamion.Text
            .Acoplado = txtPatenteAcoplado.Text
            .KmARecorrer = StringToDecimal(txtKmRecorrer.Text)
            .TarifaTransportista = StringToDecimal(txtTarifa.Text)
            .FechaDescarga = iisValidSqlDate(txtFechaDescarga.Text)

            Try
                If txtHoraDescarga.Text = "" Then txtHoraDescarga.Text = "00:00"
                .Hora = iisValidSqlDate(Convert.ToDateTime(txtHoraDescarga.Text))
            Catch ex As Exception
                ErrHandler2.WriteError("No se pudo asignar la hora. " & ex.ToString)
            End Try


            .NRecibo = txtNRecibo.Text
            .CalidadDe = BuscaIdCalidadPreciso(TextBoxCalidad.Text, SC)
            .NetoFinalIncluyendoMermas = StringToDecimal(txtNetoDescarga.Text)
            .TaraFinal = StringToDecimal(txtTaraDescarga.Text)
            .BrutoFinal = StringToDecimal(txtBrutoDescarga.Text)


            .Humedad = StringToDecimal(txtPorcentajeHumedad.Text)
            .HumedadDesnormalizada = StringToDecimal(txtHumedadTotal.Text)
            .Fumigada = StringToDecimal(txtFumigada.Text)
            '.Secada = StringToDecimal(txtSecada.Text)
            .Merma = StringToDecimal(txtMerma.Text)


            .NetoFinalSinMermas = StringToDecimal(txtNetoFinalTotalMenosMermas.Text)


            .Cosecha = cmbCosecha.SelectedValue

            .Exporta = chkExporta.Checked
            .ExcluirDeSubcontratistas = chkNoFacturarASubcontratistas.Checked
            .AgregaItemDeGastosAdministrativos = chkConCostoAdministrativo.Checked

            .LiquidaViaje = chkLiquidaViaje.Checked
            .CobraAcarreo = chkCobraAcarreo.Checked


            .Observaciones = txtObservaciones.Text

            .Factor = StringToDecimal(txtFactor.Text)


            '// si no encuentra el texto, chiflar
            .IdEstablecimiento = BuscaIdEstablecimientoWilliams(txtEstablecimiento.Text, SC)
            If .IdEstablecimiento = -1 And txtEstablecimiento.Text <> "" Then

                MsgBoxAjax(Me, "No se encuentra el establecimiento " & txtEstablecimiento.Text)
                Exit Sub
            End If

            .IdTipoMovimiento = cmbMovimientoLosGrobo.SelectedValue


            .ObviarAdvertencias = HiddenObviarAdvertencias.Value <> ""



            '////////////////////////////////////////////////////////////////////////
            'Asigno los precios de los subcontratistas elegidos (que son como proveedores
            'de servicios)
            CartaDePorteManager.ReasignoTarifaSubcontratistas(SC, myCartaDePorte)








            'calidad noble
            .NobleExtranos = StringToDecimal(TextBox26.Text)
            .NobleNegros = StringToDecimal(TextBox27.Text)
            .NobleQuebrados = StringToDecimal(txtCalidadQuebradosResultado.Text)
            .NobleDaniados = StringToDecimal(TextBox29.Text)
            .NobleChamico = StringToDecimal(txtCalidadChamicoResultado.Text)
            .NobleChamico2 = StringToDecimal(txtCalidadChamicoRebaja.Text)
            .NobleRevolcado = StringToDecimal(txtCalidadRevolcadoResultado.Text)
            .NobleObjetables = StringToDecimal(txtCalidadObjetablesResultado.Text)
            .NobleAmohosados = StringToDecimal(txtCalidadAmohosadosResultado.Text)



            .CalidadGranosExtranosRebaja = StringToDecimal(txtCalidadGranosExtranosRebaja.Text)
            .CalidadQuebradosRebaja = StringToDecimal(txtCalidadQuebradosRebaja.Text)
            .CalidadGranosDanadosRebaja = StringToDecimal(txtCalidadGranosDanadosRebaja.Text)
            .CalidadChamicoRebaja = StringToDecimal(txtCalidadCarbonRebaja.Text)
            .CalidadRevolcadosRebaja = StringToDecimal(txtCalidadRevolcadoRebaja.Text)
            .CalidadObjetablesRebaja = StringToDecimal(txtCalidadObjetablesRebaja.Text)
            .CalidadAmohosadosRebaja = StringToDecimal(txtCalidadAmohosadosRebaja.Text)
            .CalidadPuntaSombreadaRebaja = StringToDecimal(txtCalidadPuntaSombreadaRebaja.Text)
            .CalidadHectolitricoRebaja = StringToDecimal(txtCalidadHectolitricoRebaja.Text)
            .CalidadCarbonRebaja = StringToDecimal(txtCalidadCarbonRebaja.Text)
            .CalidadPanzaBlancaRebaja = StringToDecimal(txtCalidadPanzaBlancaRebaja.Text)
            .CalidadPicadosRebaja = StringToDecimal(txtCalidadPicadosRebaja.Text)
            .CalidadVerdesRebaja = StringToDecimal(txtCalidadVerdesRebaja.Text)
            .CalidadQuemadosRebaja = StringToDecimal(txtCalidadQuemadosRebaja.Text)
            .CalidadTierraRebaja = StringToDecimal(txtCalidadTierraRebaja.Text)
            .CalidadZarandeoRebaja = StringToDecimal(txtCalidadZarandeoRebaja.Text)
            .CalidadDescuentoFinalRebaja = StringToDecimal(txtCalidadDescuentoFinalRebaja.Text)
            .CalidadHumedadRebaja = StringToDecimal(txtCalidadHumedadRebaja.Text)
            .CalidadGastosFumigacionRebaja = StringToDecimal(txtCalidadGastosFumigacionRebaja.Text)


            .CalidadGranosExtranosMerma = StringToDecimal(txtCalidadGranosExtranosMerma.Text)
            .CalidadQuebradosMerma = StringToDecimal(txtCalidadQuebradosMerma.Text)
            .CalidadDanadosMerma = StringToDecimal(txtCalidadGranosDanadosMerma.Text)
            .CalidadChamicoMerma = StringToDecimal(txtCalidadChamicoMerma.Text)
            .CalidadRevolcadosMerma = StringToDecimal(txtCalidadRevolcadoMerma.Text)
            .CalidadObjetablesMerma = StringToDecimal(txtCalidadObjetablesMerma.Text)
            .CalidadAmohosadosMerma = StringToDecimal(txtCalidadAmohosadosMerma.Text)
            .CalidadPuntaSombreadaMerma = StringToDecimal(txtCalidadPuntaSombreadaMerma.Text)
            .CalidadHectolitricoMerma = StringToDecimal(txtCalidadHectolitricoMerma.Text)
            .CalidadCarbonMerma = StringToDecimal(txtCalidadCarbonMerma.Text)
            .CalidadPanzaBlancaMerma = StringToDecimal(txtCalidadPanzaBlancaMerma.Text)
            .CalidadPicadosMerma = StringToDecimal(txtCalidadPicadosMerma.Text)
            .CalidadVerdesMerma = StringToDecimal(txtCalidadVerdesMerma.Text)
            .CalidadQuemadosMerma = StringToDecimal(txtCalidadQuemadosMerma.Text)
            .CalidadTierraMerma = StringToDecimal(txtCalidadTierraMerma.Text)
            .CalidadZarandeoMerma = StringToDecimal(txtCalidadZarandeoMerma.Text)
            .CalidadDescuentoFinalMerma = StringToDecimal(txtCalidadDescuentoFinalMerma.Text)
            .CalidadHumedadMerma = StringToDecimal(txtCalidadHumedadMerma.Text)
            .CalidadGastosFumigacionMerma = StringToDecimal(txtCalidadGastosFumigacionMerma.Text)


            .CalidadHumedadResultado = StringToDecimal(txtCalidadHumedadResultado.Text)
            .CalidadGastosFumigacionResultado = StringToDecimal(txtCalidadGastosFumigacionResultado.Text)



            .CalidadPuntaSombreada = StringToDecimal(txtPuntaSombreada.Text)
            .CalidadDescuentoFinal = StringToDecimal(txtCalidadDescuentoFinal.Text)


            .NobleHectolitrico = StringToDecimal(TextBox35.Text)
            .NobleCarbon = StringToDecimal(TextBox36.Text)
            .NoblePanzaBlanca = StringToDecimal(TextBox37.Text)
            .NoblePicados = StringToDecimal(TextBox38.Text)
            .NobleMGrasa = StringToDecimal(TextBox39.Text)
            .NobleAcidezGrasa = StringToDecimal(TextBox40.Text)
            .NobleVerdes = StringToDecimal(TextBox41.Text)
            .NobleGrado = cmbNobleGrado.Text
            .NobleConforme = CheckBox1.Checked
            .NobleACamara = CheckBox2.Checked


            .CalidadTierra = StringToDecimal(TextBox2.Text)
            .CalidadGranosQuemados = StringToDecimal(TextBox1.Text)
            .CalidadMermaZarandeo = StringToDecimal(TextBox4.Text)
            .CalidadMermaChamico = StringToDecimal(TextBox3.Text)









            'ajusto el combo
            DropDownList3.SelectedIndex = cmbBonifRebajGeneral.SelectedIndex
            DropDownList1.SelectedIndex = cmbBonifRebajGeneral.SelectedIndex
            DropDownList5.SelectedIndex = cmbBonifRebajGeneral.SelectedIndex
            DropDownList4.SelectedIndex = cmbBonifRebajGeneral.SelectedIndex
            .CalidadTierraBonifRebaja = DropDownList3.SelectedIndex
            .CalidadGranosQuemadosBonifRebaja = DropDownList1.SelectedIndex
            .CalidadMermaZarandeoBonifRebaja = DropDownList5.SelectedIndex
            .CalidadMermaChamicoBonifRebaja = DropDownList4.SelectedIndex




            .SojaSustentableCodCondicion = SojaSustentableCodCondicion.Text
            .SojaSustentableCondicion = SojaSustentableCondicion.Text
            .SojaSustentableNroEstablecimientoDeProduccion = SojaSustentableNroEstablecimientoDeProduccion.Text


            .FueraDeEstandar = CheckBox3.Checked

            .FacturarAManual = chkFacturarManual.Checked

            '.PathImagen = linkImagen.NavigateUrl 'nombrenuevo

            If Session("NombreAdjunto") <> "" Then .PathImagen = Session("NombreAdjunto")
            If Session("NombreAdjunto2") <> "" Then .PathImagen2 = Session("NombreAdjunto2")

            If Session("NombreAdjunto") = ".." Then .PathImagen = ""
            If Session("NombreAdjunto2") = ".." Then .PathImagen2 = ""

        End With



    End Sub



    Sub RecargarEncabezado(ByVal myCartaDePorte As Pronto.ERP.BO.CartaDePorte, Optional ByVal CopiarSoloLosGenerales As Boolean = False)

        Try


            If Not CopiarSoloLosGenerales Then VaciarEncabezado() 'si usaron "repetir la ultima cdp", no quieren perder los datos -Tiempo despues, este truco no lo entiendo

            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpSyngenta", " jsVerificarSyngenta(); jsVerificarSyngentaCorredor(); jsVerificarSyngentaDestinatario(); jsVerificarSyngentaRemitente(); jsVerificarSyngentaIntermediario();", True)


            With myCartaDePorte




                'txtFechaCartaDePorte.Text = .Fecha.ToString("dd/MM/yyyy")
                'calFecha.SelectedDate = myCartaDePorte.Fecha


                '////////////////////////////////////////////////////////
                'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
                'SelectedReceiver.Value = .Vendedor
                'txtTitular.Text = .Vendedor
                'TraerDatosProveedor(myCartaDePorte.Vendedor) 'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx





                Try
                    If .Titular > 0 Then txtTitular.Text = EntidadManager.GetItem(SC, "Clientes", .Titular).Item("RazonSocial")


                    If .CuentaOrden1 > 0 Then txtIntermediario.Text = EntidadManager.GetItem(SC, "Clientes", .CuentaOrden1).Item("RazonSocial")
                    If .CuentaOrden2 > 0 Then txtRcomercial.Text = EntidadManager.GetItem(SC, "Clientes", .CuentaOrden2).Item("RazonSocial")


                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar tit c1 c2")

                    ErrHandler2.WriteError(ex)
                End Try


                Try
                    If .Corredor > 0 Then txtCorredor.Text = EntidadManager.GetItem(SC, "Vendedores", .Corredor).Item("Nombre")

                    If .Corredor2 > 0 Then TextBoxCorredorII.Text = EntidadManager.GetItem(SC, "Vendedores", .Corredor2).Item("Nombre")
                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar el corredor. " & ex.ToString)
                End Try




                Try
                    If .Entregador > 0 Then txtDestinatario.Text = EntidadManager.GetItem(SC, "Clientes", .Entregador).Item("RazonSocial")

                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar el Entregador")
                    ErrHandler2.WriteError(ex)
                End Try


                txtClienteAuxiliar.Text = NombreCliente(SC, .IdClienteAuxiliar)
                txtClienteEntregador.Text = NombreCliente(SC, .IdClienteEntregador)
                txtClientePagadorFlete.Text = NombreCliente(SC, .IdClientePagadorFlete)



                chkTieneRecibidorOficial.Checked = .TieneRecibidorOficial
                cmbEstadoRecibidor.SelectedIndex = .EstadoRecibidor
                cmbMotivoRechazoRecibidor.SelectedIndex = .MotivoRechazo
                txtClienteAcondicionador.Text = NombreCliente(SC, .ClienteAcondicionador)

                txtEntregaSAP.Text = .EntregaSAP


                Try
                    If .IdArticulo > 0 Then txt_AC_Articulo.Text = ArticuloManager.GetItem(SC, .IdArticulo).Descripcion
                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar el articulo")
                    ErrHandler2.WriteError(ex)
                End Try

                Try
                    If Val(.Procedencia) > 0 Then txtOrigen.Text = EntidadManager.ExecDinamico(SC, "select * from Localidades where IdLocalidad=" & .Procedencia).Rows(0).Item("Nombre")
                Catch ex As Exception

                    ErrHandler2.WriteError("Al cargar procedencia")

                    ErrHandler2.WriteError(ex)

                End Try

                Try
                    If .Destino > 0 Then txtDestino.Text = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & .Destino).Rows(0).Item("Descripcion")
                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar destino")

                    ErrHandler2.WriteError(ex)

                End Try


                Try
                    If .Subcontr1 > 0 Then txtSubcontr1.Text = EntidadManager.GetItem(SC, "Clientes", .Subcontr1).Item("RazonSocial")
                    If .Subcontr2 > 0 Then txtSubcontr2.Text = EntidadManager.GetItem(SC, "Clientes", .Subcontr2).Item("RazonSocial")

                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar subcontratista")

                    ErrHandler2.WriteError(ex)

                End Try




                txtFechaCarga.Text = .FechaDeCarga
                txtFechaArribo.Text = .FechaArribo
                txtCEE.Text = .CEE
                txtContrato.Text = .Contrato
                txtFechaVencimiento.Text = IIf(iisValidSqlDate(.FechaVencimiento, #1/1/1753#) = #1/1/1753#, "", .FechaVencimiento)


                txtFacturarleAesteCliente.Text = NombreCliente(SC, .IdClienteAFacturarle)
                'txtSubnumeroDeFacturacion.text = .SubnumeroDeFacturacion

                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                '        CUANDO LE DAMOS REPETIR DATOS, QUE SOLAMENTE REPITA : 
                '- CEE /FECHA CARGA / VENCIMI. / TITULAR / INTERMED. / REM. CCIAL 
                '/ CORREDOR / DESTINATARIO / GRANO / CONTRATO / ORIGEN / DESTINO.


                '        De la Posición,NO COPIAR:
                '-Nro de Carta de porte
                '-Los Kg
                '-El transportista y el chofer. 

                'De la Descarga sólo repite la fecha de descarga.


                If CopiarSoloLosGenerales Then Exit Sub


                txtSubfijo.Text = IIf(.NumeroSubfijo = 0, "", .NumeroSubfijo)
                txtSubNumeroVagon.Text = IIf(.SubnumeroVagon = 0, "", .SubnumeroVagon)

                Try
                    If .IdTransportista > 0 Then txtTransportista.Text = EntidadManager.GetItem(SC, "Transportistas", .IdTransportista).Item("RazonSocial")
                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar transportista")
                    ErrHandler2.WriteError(ex)

                End Try

                Try
                    If .IdChofer > 0 Then txtChofer.Text = EntidadManager.GetItem(SC, "Choferes", .IdChofer).Item("Nombre")
                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar choferes")
                    ErrHandler2.WriteError(ex)

                End Try


                txtPatenteCamion.Text = .Patente
                '.Cupo
                '.NetoProc
                '.Calidad
                txtBrutoPosicion.Text = IIf(.BrutoPto = 0, "", .BrutoPto)
                txtTaraPosicion.Text = IIf(.TaraPto = 0, "", .TaraPto)
                txtNetoPosicion.Text = IIf(.NetoPto = 0, "", .NetoPto)

                txtPatenteAcoplado.Text = .Acoplado

                'BuscaTextoEnCombo(cmbHumedad, FF2(myCartaDePorte.Humedad))
                txtPorcentajeHumedad.Text = DecimalToString(myCartaDePorte.Humedad)
                txtHumedadTotal.Text = DecimalToString(Math.Round(.HumedadDesnormalizada))
                txtMerma.Text = Math.Round(.Merma)
                '.NetoFinal

                '.IdTransportista
                '.ChoferCUIT

                txtFactor.Text = .Factor


                txtCTG.Text = .CTG


                ' cmbCondicionCompra0.Text = .Calidad

                cmbTipoContrato1.SelectedValue = .Contrato1
                cmbTipoContrato2.SelectedValue = .Contrato2


                txtKmRecorrer.Text = .KmARecorrer
                txtTarifa.Text = .TarifaTransportista


                txtEstablecimiento.Text = NombreEstablecimientoWilliams(SC, .IdEstablecimiento)
                Try
                    cmbMovimientoLosGrobo.SelectedValue = .IdTipoMovimiento
                Catch ex As Exception
                    ErrHandler2.WriteError("Al cargar movimiento")

                    ErrHandler2.WriteError(ex)
                End Try



                optDivisionSyngenta.SelectedValue = .Acopio1
                optDivisionSyngentaIntermediario.SelectedValue = .Acopio2
                optDivisionSyngentaRemitente.SelectedValue = .Acopio3
                optDivisionSyngentaCorredor.SelectedValue = .Acopio4
                optDivisionSyngentaDestinatario.SelectedValue = .Acopio5
                Try
                    optDivisionSyngentaCliobs.SelectedValue = .Acopio6
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try




                optAcopiosFacturarA.SelectedValue = .AcopioFacturarleA
                If False Then
                    optDivisionSyngenta.SelectedValue = .EnumSyngentaDivision
                    optDivisionSyngentaIntermediario.SelectedValue = CartaDePorteManager.BuscarTextoAcopio(.Acopio2, SC)
                    optDivisionSyngentaRemitente.SelectedValue = CartaDePorteManager.BuscarTextoAcopio(.Acopio3, SC)
                    optDivisionSyngentaCorredor.SelectedValue = CartaDePorteManager.BuscarTextoAcopio(.Acopio4, SC)
                    optDivisionSyngentaDestinatario.SelectedValue = CartaDePorteManager.BuscarTextoAcopio(.Acopio5, SC)
                    optAcopiosFacturarA.SelectedValue = CartaDePorteManager.BuscarTextoAcopio(.AcopioFacturarleA, SC)
                End If





                linkPDF.NavigateUrl = ConfigurationManager.AppSettings("UrlDominio") & "ProntoWeb\CartasDePorteImagenEncriptada.aspx?Id=" & EntidadManager.encryptQueryString(.Id).ToString()

                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////



                If .NumeroCartaDePorte > 0 Then txtNumeroCDP.Text = .NumeroCartaDePorte

                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////

                txtFechaDescarga.Text = IIf(iisValidSqlDate(.FechaDescarga, #1/1/1753#) = #1/1/1753#, "", .FechaDescarga)
                txtHoraDescarga.Text = Left(.Hora.TimeOfDay.ToString, 5) 'esta linea es la que me hace explotar el tab
                txtNRecibo.Text = .NRecibo

                'BuscaIDEnCombo(cmbCalidad, .CalidadDe)
                If .CalidadDe > 0 Then TextBoxCalidad.Text = NombreCalidad(SC, .CalidadDe)


                txtNetoDescarga.Text = IIf(.NetoFinalIncluyendoMermas = 0, "", .NetoFinalIncluyendoMermas)
                txtTaraDescarga.Text = IIf(.TaraFinal = 0, "", .TaraFinal)
                txtBrutoDescarga.Text = IIf(.BrutoFinal = 0, "", .BrutoFinal)

                txtNetoFinalTotalMenosMermas.Text = .NetoFinalSinMermas

                txtFumigada.Text = .Fumigada
                'txtSecada.Text = .Secada

                If Not .Cosecha Is Nothing AndAlso .Cosecha <> "" Then BuscaTextoEnCombo(cmbCosecha, .Cosecha)

                chkExporta.Checked = .Exporta
                chkNoFacturarASubcontratistas.Checked = .ExcluirDeSubcontratistas
                chkConCostoAdministrativo.Checked = .AgregaItemDeGastosAdministrativos
                chkLiquidaViaje.Checked = .LiquidaViaje
                chkCobraAcarreo.Checked = .CobraAcarreo

                txtObservaciones.Text = .Observaciones

                Try
                    .IdUsuarioIngreso = Session(SESSIONPRONTO_glbIdUsuario)
                Catch ex As Exception
                    ErrHandler2.WriteError("usuario ing")

                    ErrHandler2.WriteError(ex)
                End Try


                ' linkClienteImagen.NavigateUrl = "CartasDePorteImagenEncriptada.aspx?Id=" & .clave

                If .IdFacturaImputada > 0 Then
                    Dim f As Pronto.ERP.BO.Factura
                    f = FacturaManager.GetItem(SC, .IdFacturaImputada)
                    'FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
                    linkFactura.Text = "Factura " & f.TipoABC & "-" & f.PuntoVenta.ToString.PadLeft(4, "0") & "-" & f.Numero.ToString.PadLeft(8, "0")
                    linkFactura.NavigateUrl = "Factura.aspx?Id=" & .IdFacturaImputada
                    linkFactura.Visible = True
                    btnDesfacturar.Visible = True
                Else
                    linkFactura.Visible = False
                    btnDesfacturar.Visible = False
                End If


                reloadimagen()





                BuscaTextoEnCombo(cmbPuntoVenta, .PuntoVenta)

                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////



                txtCalidadGastoDeSecada.Text = .CalidadGastoDeSecada
                txtCalidadGastoDeSecadaRebaja.Text = .CalidadGastoDeSecadaRebaja
                txtCalidadGastoDeSecadaMerma.Text = .CalidadGastoDeSecadaMerma
                cmbTipoMermaGastoDeSecada.SelectedValue = .TipoMermaGastoDeSecada

                txtCalidadMermaVolatil.Text = .CalidadMermaVolatil
                txtCalidadMermaVolatilRebaja.Text = .CalidadMermaVolatilRebaja
                txtCalidadMermaVolatilMerma.Text = .CalidadMermaVolatilMerma
                cmbTipoMermaVolatil.SelectedValue = .TipoMermaVolatil

                txtCalidadFondoNidera.Text = .CalidadFondoNidera
                txtCalidadFondoNideraRebaja.Text = .CalidadFondoNideraRebaja
                txtCalidadFondoNideraMerma.Text = .CalidadFondoNideraMerma
                cmbTipoMermaFondoNidera.SelectedValue = .TipoMermaFondoNidera

                txtCalidadMermaConvenida.Text = .CalidadMermaConvenida
                txtCalidadMermaConvenidaRebaja.Text = .CalidadMermaConvenidaRebaja
                txtCalidadMermaConvenidaMerma.Text = .CalidadMermaConvenidaMerma
                cmbTipoMermaConvenida.SelectedValue = .TipoMermaConvenida

                txtCalidadTalCualVicentin.Text = .CalidadTalCualVicentin
                txtCalidadTalCualVicentinRebaja.Text = .CalidadTalCualVicentinRebaja
                txtCalidadTalCualVicentinMerma.Text = .CalidadTalCualVicentinMerma
                cmbTipoMermaTalCualVicentin.SelectedValue = .TipoMermaTalCualVicentin

                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                ''///////////////////////////////////////////////////////////////////////////



                cmbTipoMermaGranosExtranos.SelectedValue = IIf((.Secada And &H1) > 0, 1, 0)
                cmbTipoMermaQuebrados.SelectedValue = IIf((.Secada And &H2) > 0, 1, 0)
                cmbTipoMermaDaniados.SelectedValue = IIf((.Secada And &H4) > 0, 1, 0)
                cmbTipoMermaChamico.SelectedValue = IIf((.Secada And &H8) > 0, 1, 0)
                cmbTipoMermaRevolcado.SelectedValue = IIf((.Secada And &H10) > 0, 1, 0)
                cmbTipoMermaObjetables.SelectedValue = IIf((.Secada And &H20) > 0, 1, 0)
                cmbTipoMermaAmohosados.SelectedValue = IIf((.Secada And &H40) > 0, 1, 0)
                cmbTipoMermaPuntaSombreada.SelectedValue = IIf((.Secada And &H80) > 0, 1, 0)
                cmbTipoMermaHectolitrico.SelectedValue = IIf((.Secada And &H100) > 0, 1, 0)
                cmbTipoMermaCarbon.SelectedValue = IIf((.Secada And &H200) > 0, 1, 0)
                cmbTipoMermaPanzaBlanca.SelectedValue = IIf((.Secada And &H400) > 0, 1, 0)
                cmbTipoMermaPicados.SelectedValue = IIf((.Secada And &H800) > 0, 1, 0)
                cmbTipoMermaVerdes.SelectedValue = IIf((.Secada And &H1000) > 0, 1, 0)
                cmbTipoMermaQuemados.SelectedValue = IIf((.Secada And &H2000) > 0, 1, 0)
                cmbTipoMermaTierra.SelectedValue = IIf((.Secada And &H4000) > 0, 1, 0)
                cmbTipoMermaZarandeo.SelectedValue = IIf((.Secada And &H8000) > 0, 1, 0)
                cmbTipoMermaHumedad.SelectedValue = IIf((.Secada And &H10000) > 0, 1, 0)
                cmbTipoMermaFumigacion.SelectedValue = IIf((.Secada And &H20000) > 0, 1, 0)
                cmbTipoMermaDescuentoFinal.SelectedValue = IIf((.Secada And &H40000) > 0, 1, 0)
                cmbTipoMermaGrado.SelectedValue = IIf((.Secada And &H80000) > 0, 1, 0)


                'calidad noble
                TextBox26.Text = .NobleExtranos
                txtCalidadGranosExtranosRebaja.Text = .CalidadGranosExtranosRebaja
                txtCalidadGranosExtranosMerma.Text = .CalidadGranosExtranosMerma


                TextBox27.Text = .NobleNegros


                txtCalidadQuebradosResultado.Text = .NobleQuebrados
                txtCalidadQuebradosRebaja.Text = .CalidadQuebradosRebaja
                txtCalidadQuebradosMerma.Text = .CalidadQuebradosMerma


                TextBox29.Text = .NobleDaniados
                txtCalidadGranosDanadosRebaja.Text = .CalidadGranosDanadosRebaja
                txtCalidadGranosDanadosMerma.Text = .CalidadDanadosMerma


                txtCalidadChamicoResultado.Text = .NobleChamico
                txtCalidadChamicoRebaja.Text = .NobleChamico2
                txtCalidadChamicoMerma.Text = .CalidadChamicoMerma


                txtCalidadRevolcadoResultado.Text = .NobleRevolcado
                txtCalidadRevolcadoRebaja.Text = .CalidadRevolcadosRebaja
                txtCalidadRevolcadoMerma.Text = .CalidadRevolcadosMerma

                txtCalidadObjetablesResultado.Text = .NobleObjetables
                txtCalidadObjetablesRebaja.Text = .CalidadObjetablesRebaja
                txtCalidadObjetablesMerma.Text = .CalidadObjetablesMerma


                txtCalidadAmohosadosResultado.Text = .NobleAmohosados
                txtCalidadAmohosadosRebaja.Text = .CalidadAmohosadosRebaja
                txtCalidadAmohosadosMerma.Text = .CalidadAmohosadosMerma



                txtPuntaSombreada.Text = .CalidadPuntaSombreada
                txtCalidadPuntaSombreadaRebaja.Text = .CalidadPuntaSombreadaRebaja
                txtCalidadPuntaSombreadaMerma.Text = .CalidadPuntaSombreadaMerma



                TextBox35.Text = .NobleHectolitrico
                txtCalidadHectolitricoRebaja.Text = .CalidadHectolitricoRebaja
                txtCalidadHectolitricoMerma.Text = .CalidadHectolitricoMerma



                TextBox36.Text = .NobleCarbon
                txtCalidadCarbonRebaja.Text = .CalidadCarbonRebaja
                txtCalidadCarbonMerma.Text = .CalidadCarbonMerma


                TextBox37.Text = .NoblePanzaBlanca
                txtCalidadPanzaBlancaRebaja.Text = .CalidadPanzaBlancaRebaja
                txtCalidadPanzaBlancaMerma.Text = .CalidadPanzaBlancaMerma


                TextBox38.Text = .NoblePicados
                txtCalidadPicadosRebaja.Text = .CalidadPicadosRebaja
                txtCalidadPicadosMerma.Text = .CalidadPicadosMerma


                TextBox39.Text = .NobleMGrasa

                TextBox40.Text = .NobleAcidezGrasa

                TextBox41.Text = .NobleVerdes
                txtCalidadVerdesRebaja.Text = .CalidadVerdesRebaja
                txtCalidadVerdesMerma.Text = .CalidadVerdesMerma





                cmbNobleGrado.Text = .NobleGrado
                CheckBox1.Checked = .NobleConforme
                CheckBox2.Checked = .NobleACamara




                TextBox1.Text = .CalidadGranosQuemados
                txtCalidadQuemadosRebaja.Text = .CalidadQuemadosRebaja
                txtCalidadQuemadosMerma.Text = .CalidadQuemadosMerma


                TextBox2.Text = .CalidadTierra
                txtCalidadTierraRebaja.Text = .CalidadTierraRebaja
                txtCalidadTierraMerma.Text = .CalidadTierraMerma



                TextBox4.Text = .CalidadMermaZarandeo
                txtCalidadZarandeoRebaja.Text = .CalidadZarandeoRebaja
                txtCalidadZarandeoMerma.Text = .CalidadZarandeoMerma




                txtCalidadDescuentoFinal.Text = .CalidadDescuentoFinal
                txtCalidadDescuentoFinalRebaja.Text = .CalidadDescuentoFinalRebaja
                txtCalidadDescuentoFinalMerma.Text = .CalidadDescuentoFinalMerma



                txtCalidadHumedadResultado.Text = .CalidadHumedadResultado
                txtCalidadHumedadRebaja.Text = .CalidadHumedadRebaja
                txtCalidadHumedadMerma.Text = .CalidadHumedadMerma



                txtCalidadGastosFumigacionResultado.Text = .CalidadGastosFumigacionResultado
                txtCalidadGastosFumigacionRebaja.Text = .CalidadGastosFumigacionRebaja
                txtCalidadGastosFumigacionMerma.Text = .CalidadGastosFumigacionMerma




                TextBox3.Text = .CalidadMermaChamico



                DropDownList3.SelectedIndex = .CalidadTierraBonifRebaja
                DropDownList1.SelectedIndex = .CalidadGranosQuemadosBonifRebaja
                DropDownList5.SelectedIndex = .CalidadMermaZarandeoBonifRebaja
                DropDownList4.SelectedIndex = .CalidadMermaChamicoBonifRebaja
                cmbBonifRebajGeneral.SelectedIndex = .CalidadTierraBonifRebaja








                CheckBox3.Checked = .FueraDeEstandar

                chkFacturarManual.Checked = .FacturarAManual


                SojaSustentableCodCondicion.Text = .SojaSustentableCodCondicion
                SojaSustentableCondicion.Text = .SojaSustentableCondicion
                SojaSustentableNroEstablecimientoDeProduccion.Text = .SojaSustentableNroEstablecimientoDeProduccion






                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////
                '//////////////////////////////////////////////////////////////////


                txtObservaciones.Text = .Observaciones

                Try
                    'cmbSituacion.Text = ExcelImportadorManager.Situaciones(If(.Situacion, 0))
                    cmbSituacion.SelectedIndex = If(.Situacion, 0)

                    txtObsSituacion.Text = .ObservacionesSituacion
                    txtFechaAutorizacion.Text = IIf(.FechaAutorizacion = DateTime.MinValue, "", .FechaAutorizacion)
                    txtFechaActualizacion.Text = IIf(.FechaActualizacionAutomatica = DateTime.MinValue, "", .FechaActualizacionAutomatica)
                    txtLogSituacion.Text = .SituacionLog
                Catch ex As Exception

                End Try



                'BuscaIDEnCombo(cmbProveedor, .IdProveedor)
                'BuscaIDEnCombo(cmbComprador, .IdComprador)
                'BuscaIDEnCombo(cmbLibero, .IdAprobo)
                'BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)

                'If Not (cmbLibero.Items.FindByValue(myCartaDePorte.IdAprobo.ToString) Is Nothing) Then
                '    cmbLibero.Items.FindByValue(myCartaDePorte.IdAprobo.ToString).Selected = True
                '    cmbLibero.Enabled = False
                '    btnLiberar.Enabled = False
                'End If

                'txtLugarEntrega.Text = .LugarEntrega
                'txtLibero.Text = .Aprobo

                'UpdatePanelEncabezado.Update() 'por ahora solo incluye el combo del proveedor, porque tuve problemas para incluir todo el resto del encabezado
            End With

        Catch ex As Exception
            'MandarMailDeError(ex)
            ErrHandler2.WriteError(ex)
        End Try


    End Sub



    Sub DeObjetoHaciaPagina(ByVal myCartaDePorte As Pronto.ERP.BO.CartaDePorte)
        RecargarEncabezado(myCartaDePorte)

        'GridView1.DataSource = myCartaDePorte.Detalles
        'GridView1.DataBind()
    End Sub

    Function ValidaClientes(ByRef myCartaDePorte As Pronto.ERP.BO.CartaDePorte) As Boolean
        With myCartaDePorte
            .Titular = BuscaIdClientePrecisoConCUIT(txtTitular.Text, SC)
            .CuentaOrden1 = BuscaIdClientePrecisoConCUIT(txtIntermediario.Text, SC)
            .CuentaOrden2 = BuscaIdClientePrecisoConCUIT(txtRcomercial.Text, SC)
            .Corredor = BuscaIdVendedorPrecisoConCUIT(txtCorredor.Text, SC)
            .Corredor2 = BuscaIdVendedorPrecisoConCUIT(TextBoxCorredorII.Text, SC)
            .Entregador = BuscaIdClientePrecisoConCUIT(txtDestinatario.Text, SC)

            If .Titular = -1 Or (.Corredor2 = -1 And TextBoxCorredorII.Text <> "") Or (.CuentaOrden1 = -1 And txtIntermediario.Text <> "") Or (.CuentaOrden2 = -1 And txtRcomercial.Text <> "") Or .Entregador = -1 Or .Corredor = -1 Then
                Return False
            Else
                Return True
            End If
        End With
    End Function

    Sub CrearClientes()
        If BuscaIdClientePreciso(txtTitular.Text, SC) = -1 Then
            Dim c As New Pronto.ERP.BO.ClienteNuevo
            c.RazonSocial = txtTitular.Text
            c.IdLocalidad = 103
            c.IdPais = 12
            c.IdProvincia = 2
            ClienteManager.Save(SC, c)

        End If


        If BuscaIdClientePreciso(txtRcomercial.Text, SC) = -1 Then
            Dim c As New Pronto.ERP.BO.ClienteNuevo
            c.RazonSocial = txtRcomercial.Text
            c.IdLocalidad = 103
            c.IdPais = 12
            c.IdProvincia = 2
            ClienteManager.Save(SC, c)
        End If


        If BuscaIdClientePreciso(txtIntermediario.Text, SC) = -1 Then
            Dim c As New Pronto.ERP.BO.ClienteNuevo
            c.RazonSocial = txtIntermediario.Text
            c.IdLocalidad = 103
            c.IdPais = 12
            c.IdProvincia = 2
            ClienteManager.Save(SC, c)
        End If


        If BuscaIdClientePreciso(txtDestinatario.Text, SC) = -1 Then
            Dim c As New Pronto.ERP.BO.ClienteNuevo
            c.RazonSocial = txtDestinatario.Text
            c.IdLocalidad = 103
            c.IdPais = 12
            c.IdProvincia = 2
            ClienteManager.Save(SC, c)
        End If


        If BuscaIdVendedorPreciso(txtCorredor.Text, SC) = -1 Then
            Dim aplicacion = ClaseMigrar.CrearAppCompronto(SC)


            Dim oVend = aplicacion.Vendedores.Item(-1)
            With oVend
                With .Registro
                    '.Fields("CodigoVendedor").Value = 
                    .Fields("Nombre").Value = txtCorredor.Text
                    '.Fields("Direccion").value =
                    '.Fields("CUIT").value = null
                    .Fields("IdLocalidad").Value = 103
                    .Fields("IdProvincia").Value = 2
                End With
                .Guardar()
            End With
            oVend = Nothing
        End If

        If BuscaIdVendedorPreciso(TextBoxCorredorII.Text, SC) = -1 Then
            Dim aplicacion = ClaseMigrar.CrearAppCompronto(SC)
            Dim oVend = aplicacion.Vendedores.Item(-1)
            With oVend
                With .Registro
                    '.Fields("CodigoVendedor").Value = 
                    .Fields("Nombre").Value = TextBoxCorredorII.Text
                    '.Fields("Direccion").value =
                    '.Fields("CUIT").value = null
                    .Fields("IdLocalidad").Value = 103
                    .Fields("IdProvincia").Value = 2
                End With
                .Guardar()
            End With
            oVend = Nothing
        End If

    End Sub

    Function ValidarCamposDeLosQueNoSeHaceAltaAlVuelo() As String
        Dim ms As String = ""
        If BuscaIdArticuloPreciso(txt_AC_Articulo.Text, SC) = -1 Then
            Return "El artículo no existe"
        End If
        If txtTransportista.Text <> "" And BuscaIdTransportistaPrecisoConCUIT(txtTransportista.Text, SC) = -1 Then
            'txtTransportista.Text = ""
            Return "El transportista no existe"
        End If
        If txtChofer.Text <> "" And BuscaIdChoferPrecisoConCUIT(txtChofer.Text, SC) = -1 Then
            'txtChofer.Text = ""
            Return "El chofer no existe"
        End If
        If BuscaIdLocalidadPreciso(txtOrigen.Text, SC) = -1 Then
            txtOrigen.Text = ""
            Return "La procedencia no existe"
        End If
        If BuscaIdWilliamsDestinoPreciso(txtDestino.Text, SC) = -1 Then
            txtDestino.Text = ""
            Return "El destino no existe"
        End If
        Return ""
    End Function



    Protected Sub btnObviarAdvertencias_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnObviarAdvertencias.Click

        ModalPopupObviarAdvertencias.Hide()

        HiddenObviarAdvertencias.Value = True




        btnSave_Click(sender, e)

    End Sub






    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'si no está llamando al clic, quizas es por la validacion de la fecha de arribo
        'si no está llamando al clic, quizas es por la validacion de la fecha de arribo
        'si no está llamando al clic, quizas es por la validacion de la fecha de arribo
        'si no está llamando al clic, quizas es por la validacion de la fecha de arribo
        'si no está llamando al clic, quizas es por la validacion de la fecha de arribo


        Try
            Dim mOk As Boolean



            Dim s As String = ValidarCamposDeLosQueNoSeHaceAltaAlVuelo()
            If s <> "" Then
                MsgBoxAjax(Me, s)
                Exit Sub
            End If


            Page.Validate("Encabezado")
            mOk = Page.IsValid

            'If Not IsDate(txtFechaCartaDePorte.Text) Then
            '    'lblFecha.Visible = True
            '    mOk = False
            'End If

            'cómo puedo saber si tiene renglones, si los datos estan en el ViewState?

            'If myCartaDePorte.Detalles Is Nothing Then
            '    MsgBoxAjax(me,"no tiene detalle")
            '    mOk = False
            'End If

            'Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)
            'If myCartaDePorte.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
            '    MsgBoxAjax(me,"Está editando pero el comprobante no tiene detalle. Hay algo mal")
            '    Exit Sub
            'End If







            If mOk Then
                If Not mAltaItem Then
                    Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)



                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////
                    'Creando clientes al vuelo
                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////

                    If Not ValidaClientes(myCartaDePorte) Then
                        MsgBoxAjax(Me, "No se permiten altas al vuelo de clientes. ")
                        Exit Sub
                        'Hay clientes que no estan creados
                        If RespuestaMsgBox.Value = "" Then
                            'Le pregunto al usuario si los quiere crear
                            PreRedirectMsgbox.Show()
                            Return
                            'ElseIf RespuestaMsgBox.Value = "SI" Then
                            '    'Como se le preguntó, y dijo que sí, los creo
                            '    CrearClientes()
                            'ElseIf RespuestaMsgBox.Value = "NO" Then
                            '    MsgBoxAjax(Me, "El objeto no es válido")
                            '    Exit Sub
                            '    Return
                        End If
                    End If

                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////
                    If False Then
                        If txtFacturarleAesteCliente.Visible Then
                            If BuscaIdClientePrecisoConCUIT(txtFacturarleAesteCliente.Text, SC) = -1 Then
                                MsgBoxAjax(Me, "Debe indicarse el cliente a quien se le facturará la carta ")
                                Return
                            End If
                        End If
                    End If
                    '///////////////////////////////////////////////
                    '///////////////////////////////////////////////


                    CargarObjeto(myCartaDePorte)





                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    'Mensajes por repeticion de unicidad
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    Dim cdp As Pronto.ERP.BO.CartaDePorte
                    Try
                        cdp = CartaDePorteManager.GetItemPorNumero(SC, txtNumeroCDP.Text, StringToDecimal(txtSubNumeroVagon.Text), -1)

                        If cdp.Id <> -1 And myCartaDePorte.SubnumeroDeFacturacion < 1 Then 'ya existe ese numero
                            If IdEntity = -1 Then 'estoy haciendo un alta
                                MsgBoxAjax(Me, "El numero/vagon ya existe, " & cdp.NumeroCartaDePorte & "/" & cdp.SubnumeroVagon)
                                Return
                            Else
                                If IdEntity <> cdp.Id Then 'esta editando esa ahora? si no...
                                    MsgBoxAjax(Me, "El numero/vagon ya existe, " & cdp.NumeroCartaDePorte & "/" & cdp.SubnumeroVagon)
                                    Return
                                End If
                            End If
                        End If
                    Catch ex As Exception
                        'a veces llega acá porque ya existe una pero con distinto subnumero de facturacion
                        ErrHandler2.WriteError(ex)
                    End Try





                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////

                    Dim ms, advertencias As String
                    If CartaDePorteManager.IsValid(SC, myCartaDePorte, ms, advertencias) Then

                        Dim b As Boolean = False
                        Try
                            b = IIf(HiddenObviarAdvertencias.Value.ToString() = "", False, HiddenObviarAdvertencias.Value)
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try



                        If advertencias <> "" And Not b Then
                            Label2225.Text = advertencias
                            ModalPopupObviarAdvertencias.Show()

                            Exit Sub
                        End If

                        Try
                            Select Case CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))
                                Case -1
                                    MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                                    Exit Sub
                                Case -2
                                    MsgBoxAjax(Me, "El numero de CDP ya existe")
                                    Exit Sub
                            End Select
                            Session("NombreAdjunto") = ""
                            Session("NombreAdjunto2") = ""

                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                            MsgBoxAjax(Me, ex.ToString)
                            Exit Sub
                        End Try


                    Else
                        mAltaItem = False
                        MsgBoxAjax(Me, ms)
                        Exit Sub
                    End If



                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Incremento de número en capa de UI. Evitar.Fields("

                    'If IdCartaDePorte = -1 And ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNumeroCartaDePorte", myCartaDePorte.NumeroCartaDePorte + 1) = -1 Then MsgBoxAjax(Me, "Hubo un error al modificar los parámetros")
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    Session("UltimaIdCDPeditada") = myCartaDePorte.Id





                    If IdCartaDePorte = -1 And IsNothing(Request.QueryString.Get("CopiaDe")) Then

                        'todo: que al dar una nueva alta sin salir del abm, no haga falta reenviar toda la pagina
                        If True Then
                            Label1.Text = "<a href= 'CartaDePorte.aspx?Id=" & myCartaDePorte.Id & "' target='_blank'> Carta anterior " & myCartaDePorte.NumeroCartaDePorte & " grabada a las " & Now.ToString("h:mm:ss") & "</a>"

                            VaciarEncabezado()
                            'no se refresca porque no hay updatepanel q contenga esos controles

                            myCartaDePorte = AltaSetup() 'se notará la diferencia?
                            Me.ViewState.Add(mKey, myCartaDePorte)
                            'de todas maneras tengo que devolver el viewstate!!!! 
                            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUp", " resetForm($('form[name=aspnetForm]'));", True)
                        Else
                            Response.Redirect(String.Format("CartaDePorte.aspx?Id=-1"), False)
                        End If

                    ElseIf IdCartaDePorte = -1 And Not IsNothing(Request.QueryString.Get("CopiaDe")) Then
                        'los duplicados, al alta, los recargo

                        Response.Redirect(String.Format("CartaDePorte.aspx?Id=" & myCartaDePorte.Id), False)
                        Exit Sub
                    ElseIf False And advertencias <> "" Then
                        'caso especial de CCI y BLD
                        'MsgBoxAjaxAndRedirect(Me, advertencias, String.Format("CartaDePorte.aspx?Id=" & myCartaDePorte.Id))
                        'MsgBoxAlert("adasdsad")

                        Response.Redirect(String.Format("CartaDePorte.aspx?Id=" & myCartaDePorte.Id), False)
                        Exit Sub

                    ElseIf myCartaDePorte.SubnumeroDeFacturacion >= 0 Then
                        'los duplicados, al alta, los recargo

                        Response.Redirect(String.Format("CartaDePorte.aspx?Id=" & myCartaDePorte.Id), False)
                        Exit Sub

                    Else

                        'tengo que actualizar el viewstate porque tengo que actualizar el timestamp
                        Me.ViewState.Add(mKey, myCartaDePorte)

                        EndEditing()
                    End If



                    'If myCartaDePorte.NumeroCartaDePorte <> StringToDecimal(txtNumeroCDP.Text) Then
                    '    'EndEditing("El CartaDePorte fue grabada con el número " & myCartaDePorte.NumeroCartaDePorte) 'me voy 
                    '    Response.Redirect(String.Format("CartaDePorte.aspx?Id=-1"))
                    'Else
                    '    'EndEditing()
                    '    Response.Redirect(String.Format("CartaDePorte.aspx?Id=-1"))
                    'End If

                Else
                    MsgBoxAjax(Me, "El objeto no es válido. (AltaItem falso)")
                    Exit Sub
                End If
            Else



                Dim msg As String = ""
                ' Loop through all validation controls to see which 
                ' generated the error(s).
                Dim oValidator As IValidator
                For Each oValidator In Validators
                    If oValidator.IsValid = False Then
                        msg = msg & oValidator.ErrorMessage & vbNewLine
                    End If
                Next
                'Label1.Text = msg

                MsgBoxAjax(Me, msg & vbNewLine & " (mOk falso)")
                mAltaItem = False


                'LblInfo.Visible = False
                'PanelInfo.Visible = True
                'PanelInfoNum.Visible = True
            End If


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "El objeto no es válido " & ex.ToString)
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


    'Protected Sub btnLiberar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
    '    Dim mOk As Boolean
    '    Page.Validate("Encabezado")
    '    mOk = Page.IsValid

    '    Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)
    '    If Not CartaDePorteManager.IsValid(myCartaDePorte) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
    '        mOk = False
    '        MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
    '    End If
    '    If mOk Then
    '        ModalPopupExtender1.Show()
    '    Else
    '        'MsgBoxAjax(Me, "El objeto no es válido")
    '    End If

    'End Sub

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click

        'If DropDownList2.SelectedValue > 0 Then
        '    Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Empleados", "T", DropDownList2.SelectedValue)
        '    If ds.Tables(0).Rows.Count > 0 Then
        '        If txtPass.Text = ds.Tables(0).Rows(0).Item("Password").ToString Then
        '            txtLibero.Text = ds.Tables(0).Rows(0).Item("Nombre").ToString
        '            btnLiberar.Enabled = False
        '        Else
        '            txtLibero.Text = "PassWord incorrecta"
        '        End If
        '    End If
        'End If

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
    'Protected Sub SelectedReceiver_ServerChange(ByVal sender As Object, ByVal e As System.EventArgs) Handles SelectedReceiver.ServerChange
    '    btnTraerDatos_Click(Nothing, Nothing)
    'End Sub

    'Este es el AC del proveedor
    'Protected Sub btnTraerDatos_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtTitular.TextChanged
    '    If Not TraerDatosProveedor(SelectedReceiver.Value) Then
    '        'cmbCondicionIVA.Enabled = True
    '        'txtCUIT.Enabled = True
    '        If SelectedReceiver.Value <> "" Then 'acaban de cambiar un proveedor existente por un alta al vuelo
    '            SelectedReceiver.Value = ""

    '            'cmbCondicionIVA.SelectedValue = -1
    '            'txtCUIT.Text = ""
    '        End If
    '    Else
    '        'cmbCondicionIVA.Enabled = False
    '        'txtCUIT.Enabled = False
    '    End If
    'End Sub


    'Este es el AC del articulo


    Function TraerDatosProveedor(ByVal IdProveedor As String) As Boolean 'es string porque el hidden con el ID puede ser ""
        'Dim myProveedor As New Pronto.ERP.BO.Proveedor

        ''////////////////////////////////
        ''Busco el proveedor
        ''////////////////////////////////

        'If iisNumeric(IdProveedor, 0) <> 0 Then
        '    'Busco el ID

        '    myProveedor = ProveedorManager.GetItem(SC, SelectedReceiver.Value)
        '    If myProveedor Is Nothing Then Return False

        '    txtTitular.Text = myProveedor.RazonSocial
        'Else
        '    'Usa el mismo criterio de busqueda del AUTOCOMPLETE

        '    Dim l As ProveedorList = ProveedorManager.GetListParaWebService(SC, txtTitular.Text)
        '    'l.Find()
        '    If l Is Nothing Then Exit Function
        '    For Each myProveedor In l
        '        If myProveedor.RazonSocial = txtTitular.Text Then Exit For
        '    Next
        'End If



        ''////////////////////////////////
        ''////////////////////////////////
        ''////////////////////////////////

        ''lleno los datos

        'If myProveedor.RazonSocial = txtTitular.Text Then 'si lo encontré
        '    With myProveedor
        '        'txtCUIT.Text = .Cuit
        '        'BuscaIDEnCombo(cmbCondicionIVA, .IdCodigoIva)
        '        'If cmbCondicionIVA.SelectedValue = -1 Then BuscaIDEnCombo(cmbCondicionIVA, 1) 'por si no encuentra la condicion (me quedaría el combo sin cargar y disabled)

        '        '///////////////////////////////////////////
        '        'estos campos solo los debo traer si cambiaron el proveedor explícitamente, y no 
        '        'en la carga de datos antes de editar -y cómo hago? -bueno, si llamas a la funcion
        '        'desde el EditarSetup(), que la carga de estos combos venga después

        '        'BuscaIDEnCombo(cmbMoneda, .IdMoneda)
        '        'BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)
        '        '///////////////////////////////////////////

        '        'If txtLetra.Text = "" Then
        '        If .IdCodigoIva = 0 Then
        '            'txtLetra.Text = "B"  ' y "C"?
        '        ElseIf .IdCodigoIva = 1 Then
        '            'txtLetra.Text = "A"
        '        Else
        '            'txtLetra.Text = "C"
        '        End If
        '        'End If


        '    End With



        '    '////////////////////////////////
        '    'traigo los datos del ultimo comprobante del proveedor
        '    'Dim dsTemp As System.Data.DataSet
        '    'dsTemp = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Presupuestos", "TX_UltimoComprobantePorIdProveedor", SelectedReceiver.Value)
        '    'If dsTemp.Tables(0).Rows.Count > 0 Then
        '    '    With dsTemp.Tables(0).Rows(0)
        '    '        'estos se tocan solo si estan vacios
        '    '        'If txtCAI.Text = "" Then txtCAI.Text = iisNull(.Item("NumeroCAI"))
        '    '        'If txtFechaVtoCAI.Text = "" Then txtFechaVtoCAI.Text = iisNull(.Item("FechaVencimientoCAI"))
        '    '    End With

        '    'End If

        '    '////////////////////////////////


        '    If myProveedor.Cuit <> "" Then Return True
        'End If

        ''////////////////////////////////

        'Return False 'no lo encontré
    End Function


    Function TraerDatosArticulo(ByVal IdArticulo As String) As Boolean 'es string porque el hidden con el ID puede ser ""
        'Dim myProveedor As New Pronto.ERP.BO.Proveedor

        ''////////////////////////////////
        ''Busco el proveedor
        ''////////////////////////////////

        'If iisNumeric(IdArticulo, 0) <> 0 Then
        '    'Busco el ID

        '    'myProveedor = ProveedorManager.GetItem(SC, SelectedAutoCompleteIDArticulo.Value)
        '    'If myProveedor Is Nothing Then Return False

        '    '///////////////////////////////
        '    txt_AC_Articulo.Text = ArticuloManager.GetItem(SC, IdArticulo).Descripcion
        '    'BuscaIDEnCombo(cmbDetUnidades, UnidadPorIdArticulo(IdArticulo, SC))
        '    'LlenoComboDeUnidades(SC, cmbDetUnidades, IdArticulo)
        '    txtCodigo.Text = ArticuloManager.GetItem(SC, IdArticulo).Codigo
        '    '////////////////////////////////



        'Else
        '    'Usa el mismo criterio de busqueda del AUTOCOMPLETE

        '    Dim l As ArticuloList = ArticuloManager.GetListParaWebService(SC, txt_AC_Articulo.Text)
        '    If l Is Nothing Then
        '        txtCodigo.Text = ""
        '        txt_AC_Articulo.Text = "" 'lo vacío así se activa el validador
        '        SelectedAutoCompleteIDArticulo.Value = 0
        '        Return False
        '    Else
        '        Dim myArticulo As Pronto.ERP.BO.Articulo
        '        myArticulo = l(0)
        '        txt_AC_Articulo.Text = myArticulo.Descripcion
        '        SelectedAutoCompleteIDArticulo.Value = myArticulo.Id
        '        txtCodigo.Text = myArticulo.Codigo
        '        Return True
        '    End If


        '    'For Each myProveedor In l
        '    '    If myProveedor.RazonSocial = txt_AC_Articulo.Text Then
        '    '        txt_AC_Articulo.Text=
        '    '        SelectedAutoCompleteIDArticulo.Value = myProveedor.Id
        '    '        Return True
        '    '    End If
        '    'Next




        'End If



        ''////////////////////////////////
        ''////////////////////////////////
        ''////////////////////////////////

        ''lleno los datos

        ''If myProveedor.RazonSocial = txtTitular.Text Then 'si lo encontré
        'With myProveedor
        'End With
        ''End If


        'Return False 'no lo encontré
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



    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub







    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        Dim output As String


        'Dim Info As String = "|" & mResp & "|" & Index & "|||" & mCopias & "|||" & mvarAgrupar & "|" &   mvarBorrador & "|" & mImprimirAdjuntos & "|" & mRTF & "|" & mPrinter
        Dim Info As String = "|C|1|||1|||1|NO|NO||"

        output = ImprimirWordDOT("CartaDePorte_" & Session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdCartaDePorte, Info)
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


    Protected Sub btnAnular_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnular.Click
        'asasd()

        cmbUsuarioAnulo.DataSource = EmpleadoManager.GetListCombo(SC)
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()

        ModalPopupAnular.Show()

    End Sub

    Protected Sub txtCodigo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'Handles txtCodigo.TextChanged
        'If Len(txtCodigo.Text) <> 0 Then
        '    Dim oRs As adodb.Recordset
        '    oRs = ConvertToRecordset(ArticuloManager.GetListTX(SC, "_PorCodigo", txtCodigo.Text))
        '    If oRs.RecordCount > 0 Then
        '        TraerDatosArticulo(oRs.Fields(0).Value)
        '        '    If Not IsNull(oRs.Fields("IdUnidad").Value) Then
        '        '        .Fields("IdUnidad").Value = oRs.Fields("IdUnidad").Value
        '        '    Else
        '        '        '.Fields("IdUnidad").Value = mvarIdUnidadCU
        '        '    End If
        '        '    If Not IsNull(oRs.Fields("CostoReposicion").Value) Then
        '        '        .Fields("Costo").Value = oRs.Fields("CostoReposicion").Value
        '        '    End If
        '        'End With
        '    Else
        '        'MsgBox("Codigo de material incorrecto", vbExclamation)
        '        'Cancel = True
        '        txtCodigo.Text = ""
        '        txt_AC_Articulo.Text = ""
        '    End If
        'End If
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

        'If cmbUsuarioAnulo.SelectedValue Then
        '    If txtAnularPassword.Text = "" Then

        '    End If
        'End If





        Dim bPassOK = False

        Dim usuario = cmbUsuarioAnulo.Items(cmbUsuarioAnulo.SelectedIndex).Text
        'password de WEB
        bPassOK = Membership.ValidateUser(usuario, txtAnularPassword.Text)

        If Not bPassOK Then
            'password de pronto
            If txtAnularPassword.Text = ProntoPasswordSegunIdEmpleado(SC, cmbUsuarioAnulo.SelectedValue) Then bPassOK = True
        End If

        Dim r As Long

        If bPassOK Then



            Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)
            Debug.Print(myCartaDePorte.PuntoVenta)


            DeObjetoHaciaPagina(myCartaDePorte)


            'esto tiene que estar en el manager, dios!
            With myCartaDePorte
                .MotivoAnulacion = txtAnularMotivo.Text
                .FechaAnulacion = Now
                '.UsuarioAnulacion = cmbUsuarioAnulo.SelectedValue
                '.Cumplido = "AN"

                Try


                    If .Anulada = "SI" Then
                        'des-anula


                        'problemas al desanular cuando existe un numero igual!!!


                        r = CartaDePorteManager.DesAnular(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

                        '.Anulada = "NO"
                    Else
                        'loguear aca que id se le esta pasando
                        ErrHandler2.WriteError(myCartaDePorte.Id & "  llamo a anular " & Session(SESSIONPRONTO_UserName))
                        r = CartaDePorteManager.Anular(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

                        'tira un error. evidentemente piensa que es otra la que estoy anulando con el mismo numero


                        '        despues del primer intento fallado por U_NumeroCartaRestringido, logra anularla en el segundo

                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:38
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:1541003  llamo a anular rcuello
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:39
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:System.Data.SqlClient.SqlException
                        'Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '.Net SqlClient Data Provider
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:39
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:System.ApplicationException
                        'Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '        BusinessLogic()
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:39
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:1541003 539305619 0 System.ApplicationException: Error en la grabacion System.ApplicationException: Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated. ---> System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '   --- End of inner exception stack trace ---
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados) ---> System.ApplicationException: Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated. ---> System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '   --- End of inner exception stack trace ---
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '   --- End of inner exception stack trace ---
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '   at CartaDePorteManager.Anular(String sc, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
                        '   at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:39
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:Error al anular la carta. Le parece que es un duplicado y no deja anularla. O quizás tiró error de concurrencia. System.ApplicationException: Error en la grabacion System.ApplicationException: Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated. ---> System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '   --- End of inner exception stack trace ---
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados) ---> System.ApplicationException: Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated. ---> System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '   --- End of inner exception stack trace ---
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '   --- End of inner exception stack trace ---
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '   at CartaDePorteManager.Anular(String sc, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
                        '   at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:39
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:System.ApplicationException
                        'WriteAndRaiseError: Error al anular la carta. Le parece que es un duplicado y no deja anularla. O quizás tiró error de concurrencia. System.ApplicationException: Error en la grabacion System.ApplicationException: Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated. ---> System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '   --- End of inner exception stack trace ---
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados) ---> System.ApplicationException: Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated. ---> System.Data.SqlClient.SqlException: Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                        'The statement has been terminated.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                        '        at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                        '   --- End of inner exception stack trace ---
                        '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '   --- End of inner exception stack trace ---
                        '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario, Boolean bCopiarDuplicados)
                        '   at CartaDePorteManager.Anular(String sc, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
                        '   at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                        '   at ErrHandler2.WriteAndRaiseError(String errorMessage) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 143
                        '   at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                        '   at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
                        '   at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
                        '   at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
                        '   at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
                        '   at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
                        '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
                        '        BusinessObject()
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:46
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:Generando informe para Planilla de movimientos
                        '        __________________________()

                        '        Log(Entry)
                        '06/10/2014 07:58:57
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1541003. Error Message:1541003  llamo a anular rcuello
                        '        __________________________()






                        '.Anulada = "SI"
                    End If

                Catch ex As Exception
                    ErrHandler2.WriteError(myCartaDePorte.Id & " " & myCartaDePorte.NumeroCartaDePorte & " " & myCartaDePorte.SubnumeroVagon & " " & ex.ToString)
                    ErrHandler2.WriteAndRaiseError("Error al anular la carta. Casi seguro pasa porque aprietan varias veces el Ok. Le parece que es un duplicado y no deja anularla. O quizás tiró error de concurrencia. " & ex.ToString)

                    'Hay algun tipo de problema con el numero de la carta sin el 5 adelante? Pinta que en el caso de abajo, hubo 
                    'algo entre la 36050882 (id 1385268) y la 536050882 (id 1385027)


                    '                     URL:	/ProntoWeb/CartaDePorte.aspx?Id=1385268
                    'User:               scabrera()
                    '                    Exception(Type) : System.ApplicationException()
                    'Message:	WriteAndRaiseError: Error al anular la carta. Le parece que es un duplicado y no deja anularla
                    'Stack Trace:	 at ErrHandler2.WriteAndRaiseError(String errorMessage) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 143
                    'at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                    'at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
                    'at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
                    'at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
                    'at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
                    'at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
                    'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)







                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:16
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:1385268 
                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:17
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:System.Data.SqlClient.SqlException
                    'Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                    'The statement has been terminated.
                    '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                    '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                    '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                    '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                    '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                    '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                    '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                    '   at System.Data.SqlClient.SqlCommand.InternalExecuteNonQuery(DbAsyncResult result, String methodName, Boolean sendToPipe)
                    '                    at(System.Data.SqlClient.SqlCommand.ExecuteNonQuery())
                    '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 295
                    '.Net SqlClient Data Provider
                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:17
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:System.ApplicationException
                    'Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'.
                    'The statement has been terminated.
                    '   at Pronto.ERP.Dal.CartaDePorteDB.Save(String SC, CartaDePorte myCartaDePorte) in C:\Backup\BDL\BussinessLogic\CartaDePorteDB.vb:line 346
                    '   at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
                    '                    BusinessLogic()
                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:17
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:1385268 536050882 0
                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:17
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:Error al anular la carta. Le parece que es un duplicado y no deja anularla
                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:17
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:System.ApplicationException
                    'WriteAndRaiseError: Error al anular la carta. Le parece que es un duplicado y no deja anularla
                    '   at ErrHandler2.WriteAndRaiseError(String errorMessage) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 143
                    '   at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                    '   at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
                    '   at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
                    '   at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
                    '   at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
                    '   at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
                    '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
                    '                    BusinessObject()
                    '                    __________________________()

                    '                    Log(Entry)
                    '01/27/2014 22:44:35
                    'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorte.aspx?Id=1385268. Error Message:1385268 
                    '                    __________________________()



                End Try

                'For Each i As CartaDePorteItem In .Detalles
                '    With i
                '        .Cumplido = "AN"
                '        '.EnviarEmail = 1
                '    End With
                'Next


                '                tira un error de duplicacion al anular
                '                _
                'URL:	/ProntoWeb/CartaDePorte.aspx?Id=1090650
                'User:           scabrera()
                '                Exception(Type) : System.ApplicationException()
                'Message:	Error en la grabacion Error en la grabacion Violation of UNIQUE KEY constraint 'U_NumeroCartaRestringido'. Cannot insert duplicate key in object 'CartasDePorte'. The statement has been terminated.
                'Stack Trace:	 at CartaDePorteManager.Save(String SC, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
                'at CartaDePorteManager.Anular(String sc, CartaDePorte myCartaDePorte, Int32 IdUsuario, String NombreUsuario)
                'at CartadeporteABM.btnAnularOk_Click(Object sender, EventArgs e)
                'at System.Web.UI.WebControls.Button.OnClick(EventArgs e)
                'at System.Web.UI.WebControls.Button.RaisePostBackEvent(String eventArgument)
                'at System.Web.UI.WebControls.Button.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
                'at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
                'at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
                'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)


            End With
            Me.ViewState.Add(mKey, myCartaDePorte) 'guardo en el viewstate el objeto
            'Dim r = CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))



            If r = -1 Then
                MsgBoxAjax(Me, "No se pudo anular la carta")
            Else
                Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            End If
            'BloqueosDeEdicion(myRequerimiento)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If

    End Sub



    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////



    'Protected Sub txtNumeroPedido5_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOrigen.TextChanged
    '    'si no eligió uno de la lista del autocomplete, lo tengo que refrescar
    '    'If noFueElegidoDeLalistaQueDesplegoElAutocomplete Then
    '    '    Return
    '    'End If

    '    Dim l = EntidadManager.GetStoreProcedure(SC, "Localidades_TX_Busqueda", txtOrigen.Text)

    '    If l.Tables(0).Rows.Count < 1 Then
    '        txtOrigen.Text = ""
    '    Else
    '        If txtOrigen.Text <> l.Tables(0).Rows(0).Item("Nombre") Then
    '            txtOrigen.Text = l.Tables(0).Rows(0).Item("Nombre")
    '        End If
    '    End If

    'End Sub

    'Protected Sub txtNumeroPedido6_TextChanged()
    'Dim l = EntidadManager.GetStoreProcedure(SC, "Localidades_TX_Busqueda", txtDestino.Text)

    'If l.Tables(0).Rows.Count < 1 Then
    '    txtDestino.Text = ""
    'Else
    '    txtDestino.Text = l.Tables(0).Rows(0).Item("Nombre")
    'End If
    'End Sub


    Protected Sub TextBox7_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestinatario.TextChanged

    End Sub

    Protected Sub txtNumeroPedido6_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestino.TextChanged
        'si se cambia el Destino, se actualizan los subcontratistas
        Dim iddest = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, SC)

        If iddest <> -1 Then
            Dim idcli1 = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & iddest).Rows(0).Item("Subcontratista1")
            If IsNumeric(idcli1) Then
                txtSubcontr1.Text = EntidadManager.GetItem(SC, "Clientes", idcli1).Item("RazonSocial")
            End If

            Dim idcli2 = EntidadManager.ExecDinamico(SC, "select * from WilliamsDestinos where IdWilliamsDestino=" & iddest).Rows(0).Item("Subcontratista2")
            If IsNumeric(idcli2) Then
                txtSubcontr2.Text = EntidadManager.GetItem(SC, "Clientes", idcli2).Item("RazonSocial")
            End If


            SetFocus(txtSubcontr1)
        End If
    End Sub

    Protected Sub txtNumeroPedido2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPatenteCamion.TextChanged

    End Sub

    Protected Sub lnkRepetirUltimaCDP_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkRepetirUltimaCDP.Click

        If Session("UltimaIdCDPeditada") Is Nothing Then
            'Si no tengo el dato de la sesion del usuario, lo saco de la base.
            Try
                Session("UltimaIdCDPeditada") = CartaDePorteManager.UltimaCDP(SC)
            Catch ex As Exception
                'ErrHandler2.WriteError("No tengo datos de la ultima que hayas editado")
                ErrHandler2.WriteError(ex)
            End Try
        Else
            'Tengo el dato en la sesión
        End If


        If False Then

            Dim c = CartaDePorteManager.GetItem(SC, Session("UltimaIdCDPeditada"))
            If c.SubnumeroVagon Then
                MsgBoxAjax(Me, "No tiene numero de vagon")
                Return
            End If

        Else
            If Val(txtSubNumeroVagon.Text) = 0 Then
                MsgBoxAjax(Me, "Ingrese antes un número de vagón")
                Return
            End If

        End If



        Try
            If IsNumeric(Session("UltimaIdCDPeditada")) Then
                RecargarEncabezado(CartaDePorteManager.GetItem(SC, Session("UltimaIdCDPeditada")), True)
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        '        CUANDO LE DAMOS REPETIR DATOS, QUE SOLAMENTE REPITA : 
        '- CEE /FECHA CARGA / VENCIMI. / TITULAR / INTERMED. / REM. CCIAL / CORREDOR / DESTINATARIO / GRANO / CONTRATO / ORIGEN / DESTINO.


        '        De la Posición,NO COPIAR:
        '-Nro de Carta de porte
        '-Los Kg
        '-El transportista y el chofer. 

        'De la Descarga sólo repite la fecha de descarga.




    End Sub

    'Protected Sub cmbHumedad_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbHumedad.SelectedIndexChanged
    '    Dim porcentajemerma = EntidadManager.ExecDinamico(SC, "select * from CDPHumedades where IdCDPHumedad=" & cmbHumedad.SelectedValue).Rows(0).Item("Merma")
    '    txtHumedadTotal.Text = DecimalToString(porcentajemerma / 100 * StringToDecimal(txtNetoDescarga.Text))

    '    'neto - humedad - fumigada - secada- otras merma=neto final
    '    'txtNetoDescarga = txtNetoDescarga
    'End Sub

    Protected Sub txtPorcentajeHumedad_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPorcentajeHumedad.TextChanged
        Dim idarticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, SC)
        If idarticulo = -1 Then
            If StringToDecimal(txtPorcentajeHumedad.Text) <> 0 Then
                MsgBoxAjax(Me, "Falta elegir el producto para calcular la humedad")
            End If
            Return
        End If
        Dim porcentajemerma = CartaDePorteManager.BuscaMermaSegunHumedadArticulo(SC, idarticulo, StringToDecimal(txtPorcentajeHumedad.Text))

        Dim humedadtot = porcentajemerma / 100 * StringToDecimal(txtNetoDescarga.Text)

        txtHumedadTotal.Text = DecimalToString(Math.Round(humedadtot))

        SetFocus(txtPorcentajeHumedad)
        'SetFocus(txtFumigada)

        txtNetoFinalTotalMenosMermas.Text = StringToDecimal(txtNetoDescarga.Text) - StringToDecimal(txtHumedadTotal.Text) - StringToDecimal(txtMerma.Text)
        'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpScript1", "return jsRecalcular(); ", True)
    End Sub


    <WebMethod()>
    <Script.Services.ScriptMethod()>
    Public Shared Function AcopiosPorCliente(NombreCliente As String, SC As String) As String()
        'Return excepciones(SC)
    End Function


    '<WebMethod()> _
    '<Script.Services.ScriptMethod()> _
    'Public Shared Function GetCompletionListDesdePagina(ByVal prefixText As String, ByVal count As Integer, ByVal contextKey As String) As String()
    '    'haciendo el llenado del autocomplete con un page method en lugar de un web service

    '    Dim lista As String() = {"asdfasd", "asaasefsdf"} 'ViewState("CacheClientes")
    '    Return lista
    '    'Dim items As New System.Collections.Generic.List(Of String)
    '    'Dim dt = ExecDinamico(SC, "SELECT razonsocial FROM clientes")
    '    'For Each dr As Data.DataRow In dt.Rows
    '    '    items.Add(dr.Item(0))
    '    'Next
    'End Function


    Protected Sub txtSubcontr1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSubcontr1.TextChanged
    End Sub

    Protected Sub txtNumeroCDP_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroCDP.TextChanged


        RefrescarValidadorDuplicidad()
        'SetFocus(txtSubfijo)
        'SetFocus(txtSubNumeroVagon)
    End Sub

    Protected Sub txtSubNumeroVagon_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSubNumeroVagon.TextChanged
        RefrescarValidadorDuplicidad()
        'SetFocus(cmbPuntoVenta)
    End Sub

    Protected Sub txtSubfijo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtSubfijo.TextChanged
        RefrescarValidadorDuplicidad()
    End Sub


    Sub RefrescarValidadorDuplicidad()
        'Dim img As Image = Page.FindControl("imageUnicidadError")
        'img.Visible = validarUnicidad()
        Try

            Dim actualCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)
            lblErrorUnicidad.Visible = CartaDePorteManager.validarUnicidad(SC, txtNumeroCDP.Text, txtSubNumeroVagon.Text, IdEntity, actualCartaDePorte)
            PanelIconoErrorCartaDuplicada.Visible = lblErrorUnicidad.Visible
            ' PanelIconoOK.visible = Not PanelIconoErrorCartaDuplicada.Visible
        Catch ex As Exception
            'MsgBoxAjax(Me, "Ya existe una carta con ese número y vagón")
            lblErrorUnicidad.Visible = True
            PanelIconoErrorCartaDuplicada.Visible = True
        End Try

    End Sub



    Protected Sub btnDesfacturar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDesfacturar.Click
        'sagasdf()
        Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)

        DesfacturarCarta(SC, myCartaDePorte, Session(SESSIONPRONTO_UserName))


        'myCartaDePorte.IdFacturaImputada = 0 
        'si llamo a Save así, tengo que cumplir la validacion, y no debería. En realidad, esto debiera ser un método aparte
        'CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))

        MsgBoxAjaxAndRedirect(Me, "Desfacturada con éxito", Request.Url.ToString)

        'EndEditing()
    End Sub


    Protected Sub txtFechaArribo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaArribo.TextChanged
        RefrescarRangeValidatorFechaDescarga()
    End Sub

    Protected Sub txtFechaDescarga_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDescarga.TextChanged

        Dim desc, arri As Date


        desc = iisValidSqlDate(txtFechaDescarga.Text)
        arri = iisValidSqlDate(txtFechaArribo.Text)

        Try
            If desc < arri Then
                MsgBoxAjax(Me, "La descarga es anterior al arribo")
                SetFocus(txtFechaDescarga)
                Return
            End If

            If DateDiff(DateInterval.Day, arri, desc) > 1 Then
                MsgBoxAjax(Me, "La descarga tiene 2 o más días de diferencia con el arribo")
                SetFocus(txtFechaDescarga)
                Return
            End If

            SetFocus(txtHoraDescarga)

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub

    Protected Sub butVerLog_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles butVerLog.Click
        VerLog(True)
    End Sub



    Protected Sub AsyncFileUpload3_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload3.UploadedComplete


        Dim DIRFTP = DirApp() & "\DataBackupear\"
        Dim nombre = NameOnlyFromFullPath(AsyncFileUpload3.PostedFile.FileName)
        Randomize()
        Dim nombrenuevo = Int(Rnd(100000) * 100000).ToString.Replace(".", "") + Now.ToString("ddMMMyyyy_HHmmss") + "_" + nombre


        'nombrenuevo = CreaDirectorioParaImagenCartaPorte(nombrenuevo, DirApp)

        Dim numeroCarta = Val(nombre)
        Dim vagon = 0

        If (AsyncFileUpload3.HasFile) Then
            Try


                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))

                '    Session("NombreArchivoSubido") = DIRFTP + nombrenuevo

                Dim MyFile1 As New FileInfo(DIRFTP + nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                AsyncFileUpload3.SaveAs(DIRFTP + nombrenuevo)

            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If



        Dim s = New ServicioCartaPorte.servi()
        s.GrabarComentario_DLL(IdCartaDePorte, "\DataBackupear\" + nombrenuevo, Membership.GetUser.UserName, SC, "")

        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "dfsdf", " $('#Lista').trigger('reloadGrid'); scrollToLastRow($('#Lista'));", True)


    End Sub





    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)
        Dim nombre As String
        Dim sError As String = ""
        Try

            nombre = CartaDePorteManager.AdjuntarImagen(SC, AsyncFileUpload1, IdCartaDePorte, sError, DirApp(), NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName))
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        linkImagen.NavigateUrl = nombre ' "..\DataBackupear\" & AsyncFileUpload1.PathImagen
        imgFotoCarta.Src = linkImagen.NavigateUrl
        Session("NombreAdjunto") = nombre        'es un problemita...
        reloadimagen()


    End Sub

    Protected Sub AsyncFileUpload2_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload2.UploadedComplete
        'System.Threading.Thread.Sleep(5000)
        Dim nombre As String
        Dim sError As String = ""
        Try
            nombre = CartaDePorteManager.AdjuntarImagen2(SC, AsyncFileUpload2, IdCartaDePorte, sError, DirApp(), NameOnlyFromFullPath(AsyncFileUpload2.PostedFile.FileName))
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        linkImagen_2.NavigateUrl = nombre ' "..\DataBackupear\" & AsyncFileUpload1.PathImagen
        imgFotoCarta2.Src = linkImagen.NavigateUrl
        Session("NombreAdjunto2") = nombre
        'reloadimagen()


    End Sub



    Sub reloadimagen()
        Try

            Using db As New LinqCartasPorteDataContext(Encriptar(SC))
                Dim oCarta = (From i In db.CartasDePortes Where i.IdCartaDePorte = IdCartaDePorte).SingleOrDefault
                If oCarta Is Nothing Then Exit Try
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                If False And linkImagen.NavigateUrl <> "" Then
                    'linkimagenlabel.HRef = "..\DataBackupear\" & linkImagen.NavigateUrl

                    'http://stackoverflow.com/questions/6826478/asp-net-asyncfileupload-show-list-of-uploaded-files/6826681#6826681

                    'UpdatePanel7.UpdateMode = UpdatePanelUpdateMode.Conditional
                    'imgFotoCarta.Src = "..\DataBackupear\" & linkImagen.NavigateUrl
                    'UpdatePanel7.Update()
                ElseIf oCarta.PathImagen <> "" Then
                    linkimagenlabel.HRef = "..\DataBackupear\" & oCarta.PathImagen
                    linkImagen.Text = "ampliar"
                    linkImagen.NavigateUrl = "..\DataBackupear\" & oCarta.PathImagen
                    linkImagen.Visible = False 'True
                    quitarimagen1.Visible = True
                    imgFotoCarta.Src = linkImagen.NavigateUrl ' oCarta.PathImagen
                    'http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx
                    'btnDesfacturar.Visible = True
                Else
                    linkImagen.Visible = False
                    quitarimagen1.Visible = False
                    ' btnadjuntarimagen.Visible = False
                End If
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////
                '//////////////////////////////////////////////////

                If oCarta.PathImagen2 <> "" Then
                    linkimagenlabel2.HRef = "..\DataBackupear\" & oCarta.PathImagen2
                    linkImagen_2.Text = "ampliar"
                    linkImagen_2.NavigateUrl = "..\DataBackupear\" & oCarta.PathImagen2
                    linkImagen_2.Visible = False 'True
                    quitarimagen2.Visible = True
                    imgFotoCarta2.Src = linkImagen_2.NavigateUrl ' oCarta.PathImagen
                    'http://www.aspsnippets.com/Articles/Displaying-images-that-are-stored-outside-the-Website-Root-Folder.aspx
                    'btnDesfacturar.Visible = True
                Else
                    quitarimagen2.Visible = False
                    linkImagen_2.Visible = False
                    ' btnadjuntarimagen.Visible = False
                End If

            End Using

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub

    Protected Sub quitarimagen1_Click(sender As Object, e As System.EventArgs) Handles quitarimagen1.Click
        quitarimagen1.Visible = False
        imgFotoCarta.Visible = False
        linkImagen.Visible = False
        Session("NombreAdjunto") = ".."
        If IdCartaDePorte > 0 Then CartaDePorteManager.QuitarImagen1(SC, IdCartaDePorte)
    End Sub

    Protected Sub quitarimagen2_Click(sender As Object, e As System.EventArgs) Handles quitarimagen2.Click
        quitarimagen2.Visible = False
        imgFotoCarta2.Visible = False
        linkImagen_2.Visible = False
        Session("NombreAdjunto2") = ".."
        If IdCartaDePorte > 0 Then CartaDePorteManager.QuitarImagen2(SC, IdCartaDePorte)
    End Sub




    Protected Sub btnAutorizarSituacion_Click(sender As Object, e As EventArgs) Handles btnAutorizarSituacion.Click

        Dim bPassOK = True


        If bPassOK Then



            Dim myCartaDePorte As Pronto.ERP.BO.CartaDePorte = CType(Me.ViewState(mKey), Pronto.ERP.BO.CartaDePorte)
            Debug.Print(myCartaDePorte.PuntoVenta)


            DeObjetoHaciaPagina(myCartaDePorte)


            'esto tiene que estar en el manager, dios!
            With myCartaDePorte
                .Situacion = 0
                .FechaAutorizacion = Now

                Try
                    Dim ms = ""
                    Dim r = CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName), True, ms)

                Catch ex As Exception
                    ErrHandler2.WriteError(myCartaDePorte.Id & " " & myCartaDePorte.NumeroCartaDePorte & " " & myCartaDePorte.SubnumeroVagon & " " & ex.ToString)
                    ErrHandler2.WriteAndRaiseError("Error al anular la carta. Casi seguro pasa porque aprietan varias veces el Ok. Le parece que es un duplicado y no deja anularla. O quizás tiró error de concurrencia. " & ex.ToString)

                End Try


            End With
            Me.ViewState.Add(mKey, myCartaDePorte) 'guardo en el viewstate el objeto
            'Dim r = CartaDePorteManager.Save(SC, myCartaDePorte, Session(SESSIONPRONTO_glbIdUsuario), Session(SESSIONPRONTO_UserName))



        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If

    End Sub
End Class







'En la duplicacion de cartas de porte realizar estos cambios:

'- En las duplicaciones deben estar habilitados los campos:
'. * Tilde de exportacion
'. * Calidad en pestaña de Descarga
'. * Observaciones

'- Replicar todas las modificaciones realizadas en el original inclusive la imagen y exceptuando los campos liberados según el punto anterior.

'- Si una carta de porte original tiene el tilde de exportacion y alguna de las copias no (o viceversa) la carta de porte debe salir una vez en 
'las planillas que tengan el tilde de exportacion y una vez en las planillas de descargas.

'- Postergar la carga del campo \\\"Facturar A\\\". Debido a que muchas veces no se está usando la 
' duplicacion por que el personal que debiera duplicar no conoce a quién se le debe facturar cada copia desarrollar estos cambios:
'. * Al presionar duplicar, crear la duplicacion y abrir pestaña con copia (hoy está abriendo una ventana nueva)
'. * Dejar grabar la copia sin ingresar el cliente al que se le va a facturar. En 
' el caso que el usuario lo haga, mostrar una advertencia.
'. * Crear un nuevo informe que detalle las cartas de porte duplicadas a las cuales les falta ingresar 
' el cliente a facturarle. Incluir en el informe un link a cada una de las copias.
'. * Enviar una vez por día un correo con el informe del punto anterior que incluya todas las cartas de porte duplicadas que están pendientes de
' cargarles el cliente a facturar para lo que va del mes.
'. * Las cartas de porte que esten duplicadas solo pueden facturarse una vez que tenga detallado a
'  quién se le debe facturar. En el paso 1 de facturación mostrar en rojo un mensaje que indique, 
' para los filtros utilizados la cantidad de cartas de porte


