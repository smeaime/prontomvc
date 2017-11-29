Imports System
Imports System.Data.SqlClient
Imports System.Reflection


Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.ParametroManager
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO

Imports System.Linq
Imports DocumentFormat.OpenXml
Imports DocumentFormat.OpenXml.Packaging
'Imports DocumentFormat.OpenXml.Wordprocessing


Imports CartaDePorteManager


Imports OpenXML_Pronto

Imports OpenXmlPowerTools


Imports ClaseMigrar.SQLdinamico

Partial Class FacturaABM
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Private DIRFTP As String = "C:\"

    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing


    Public Property IdFactura() As Integer
        Get
            Return DirectCast(iisNull(ViewState("IdFactura"), -1), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdFactura") = Value
        End Set
    End Property

    Public Property ClientIDSetfocus() As String 'para recuperar el foco perdido tras la actualizacion del updatepanel
        Get
            Return DirectCast(ViewState("ClientIDSetfocus"), String)
        End Get
        Set(ByVal Value As String)
            ViewState("ClientIDSetfocus") = Value
        End Set
    End Property


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'LOAD
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////








    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        HFSC.Value = GetConnectionString(Server, Session)

        If Not (Request.QueryString.Get("Id") Is Nothing) Then 'si trajo el parametro ID, lo guardo aparte
            Me.IdFactura = Convert.ToInt32(Request.QueryString.Get("Id"))
        End If
        If Not (Request.QueryString.Get("SincroAmaggi") Is Nothing) Then 'si trajo el parametro ID, lo guardo aparte
            FacturaManager.SincroFacturacionAmaggi(HFSC.Value, IdFactura)
        End If


        mKey = "Factura_" & Me.IdFactura.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)


        'Cómo puede ser que a veces llegue hasta acá (Page Load de un ABM) y el session(SESSIONPRONTO_USUARIO) está en nothing? Un cookie?
        If usuario Is Nothing Then ' Or SC Is Nothing Then
            'debug.print(session(SESSIONPRONTO_UserName))

            'pero si lo hacés así, no vas a poder redirigirlo, porque te quedas sin RequestUrl...
            ' ma sí, le pongo el dato en el session
            'session(SESSIONPRONTO_MiRequestUrl) = Request.Url..AbsoluteUri
            Session(SESSIONPRONTO_MiRequestUrl) = Request.RawUrl.ToLower
            Debug.Print(Session(SESSIONPRONTO_MiRequestUrl))

            Response.Redirect("~/Login.aspx")
        End If

        SC = usuario.StringConnection
        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion


        If Not Page.IsPostBack Then
            '//////////////////////////////////////////////////////////////////
            'Este pedazo se ejecuta si es la PRIMERA VEZ QUE SE CARGA (es decir, no es un postback)
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////


            Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Facturas)

            If Not p("PuedeLeer") Then
                'esto tiene que anular el sitemapnode
                MsgBoxAjaxAndRedirect(Me, "El usuario no tiene permisos de facturación", "CartasDePortes.aspx")
                Exit Sub
                'lnkNuevo.Visible = False
            End If


            If Cotizacion(SC) = 0 Then
                MsgBoxAjaxAndRedirect(Me, "No hay cotizacion, ingresela primero", String.Format("Cotizaciones.aspx"))
                Exit Sub
            End If


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
            'Panel4.Attributes("style") = "display:none"
            Panel5.Attributes("style") = "display:none"
            PopupGrillaSolicitudes.Attributes("style") = "display:none"
            '///////////////////////////



            'Carga del objeto
            TextBox1.Text = IdFactura
            BindTypeDropDown()


            Dim myFactura As Pronto.ERP.BO.Factura
            If IdFactura > 0 Then
                myFactura = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myFactura = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    myFactura = AltaSetup()
                End If
            End If



            Me.ViewState.Add(mKey, myFactura) 'si adentro del myFactura hay un COMPRONTO, va a explotar porque no es serializable



            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")

            txtDetCantidad.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            txtDetPrecioUnitario.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            txtDetBonif.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            txtDetCosto.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            txtPorcentajeCertificacion.Attributes.Add("onKeyUp", "jsRecalcularItem()")


            'comprobar q existe porq si no explota
            BloqueosDeEdicion(myFactura)



        End If



        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnDescargaAdjuntosDeFacturacionWilliams)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnDescargaAdjuntosDeFacturacionWilliamsA4)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkEditarXML)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkButton3)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkButton4)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkImprimirXMLFactElectronica)

        LinkButton3.Enabled = True
        LinkButton4.Enabled = True
        btnDescargaAdjuntosDeFacturacionWilliams.Enabled = True


        '////////////////////////////////

        'RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        'txtRendicion.Enabled = False

        'refresco
        'btnTraerDatos_Click(Nothing, Nothing)

        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

        If ClientIDSetfocus <> "" Then
            System.Web.UI.ScriptManager.GetCurrent(Me).SetFocus(ViewState("ClientIDSetfocus"))
            ClientIDSetfocus = ""
        End If

    End Sub


    Sub BloqueosDeEdicion(ByVal myFactura As Pronto.ERP.BO.Factura)


        If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
            Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
            If iisNull(pventa, 0) <> 0 Then
                'NumeroPuntoVentaSegunSucursalWilliams                  () 
                'dt = DataTableWHERE(dt, "[Pto_Vta_] = " & pventa & " OR [Pto_Vta_] = " & pventa * 10)
            End If
        End If

        'Single es de  otro punto de venta






        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Facturas)

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            MsgBoxAjaxAndRedirect(Me, "El usuario no tiene permisos de facturación", "CartasDePortes.aspx")

            'lnkNuevo.Visible = False
        End If



        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Then
            'si es un proveedor, deshabilito la edicion


            'habilito el eliminar del renglon
            'For Each r As GridViewRow In GridView1.Rows
            '    Dim bt As LinkButton
            '    'bt = r.FindControl("Elim.")
            '    bt = r.Controls(5).Controls(0) 'el boton eliminar esta dentro de un control datafield
            '    If Not bt Is Nothing Then
            '        bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
            '        bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
            '    End If
            'Next

            'me fijo si está cerrado
            'DisableControls(Me)
            GridView1.Enabled = True
            btnOk.Enabled = True
            btnCancel.Enabled = True

            'encabezado
            'txtNumeroFactura1.Enabled = False
            txtNumeroFactura2.Enabled = False
            txtFechaIngreso.Enabled = False
            'txtFechaAprobado.Enabled = False
            'txtValidezOferta.Enabled = False
            'txtDetalleCondicionCompra.Enabled = False
            cmbMoneda.Enabled = False
            'cmbPlazo.Enabled = False
            cmbCondicionVenta.Enabled = False
            'cmbPlazo.Enabled = False
            txtObservaciones.Enabled = False
            'txtDescProveedor.Enabled = False
            'txtFechaCierreCompulsa.Enabled = False
            'txtDetalle.Enabled = False
            txtCodigo.Enabled = False
            'txtTotBonif.Enabled = False



            'detalle
            LinkAgregarRenglon.Enabled = False
            txt_AC_Articulo.Enabled = False
            txtDetObservaciones.Enabled = False
            txtDetTotal.Enabled = False
            '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
            'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
            txtDetCantidad.Enabled = False
            txtDetFechaEntrega.Enabled = False



            'links a popups

            LinkAgregarRenglon.Style.Add("visibility", "hidden")
            LinkButton1.Style.Add("visibility", "hidden")
            LinkButton2.Style.Add("visibility", "hidden")
            'LinkButton2.Attributes("Visibility") = "Hidden"
            'LinkButton2.Style.Add("display", "none")

            'ModalPopupExtender1.Hide()
            'ModalPopupExtender2.Hide()

        Else
            LinkAgregarRenglon.Enabled = True
        End If


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or
        With myFactura

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

             
                btnAnular.Visible = True


                MostrarBotonesParaAdjuntar()


                'If Val(.Aprobo) > 0 Then
                If True Then
                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////

                    DisableControls(Me)
                    LinkImprimirXMLFactElectronica.Visible = True
                    LinkImprimirXMLFactElectronica.Enabled = True
                    'LinkImprimir.Enabled = True
                    LinkImprimirXML.Enabled = True
                    LinkEditarXML.Enabled = True

                    btnAdjuntosBLD.Enabled = True

                    chkLiberarCDPs.Enabled = True

                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    ''habilito el eliminar del renglon
                    For Each r As GridViewRow In GridView1.Rows
                        For Each c As Control In r.Controls
                            If (TypeOf c Is LinkButton) Then
                                CType(c, LinkButton).Enabled = True
                            End If
                            For Each c2 As Control In c.Controls
                                If (TypeOf c2 Is LinkButton) Then
                                    CType(c2, LinkButton).Enabled = True
                                End If

                            Next
                        Next
                    Next
                    btnCancelItem.Enabled = True
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////




                    'me fijo si está cerrado

                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True
                    btnAnular.Enabled = True
                    btnAnularOk.Enabled = True
                    btnAnularCancel.Enabled = True
                    cmbUsuarioAnulo.Enabled = True
                    txtAnularMotivo.Enabled = True
                    txtAnularPassword.Enabled = True

                    'si es un proveedor, deshabilito la edicion


                    'habilito el eliminar del renglon
                    For Each r As GridViewRow In GridView1.Rows
                        Dim bt As LinkButton
                        'bt = r.FindControl("Elim.")
                        bt = r.Controls(6).Controls(0) 'el boton eliminar esta dentro de un control datafield
                        If Not bt Is Nothing Then
                            'bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                            'bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                        End If
                    Next

                    'me fijo si está cerrado
                    'DisableControls(Me)
                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'encabezado
                    'txtNumeroFactura1.Enabled = False
                    txtNumeroFactura2.Enabled = False
                    txtFechaIngreso.Enabled = False
                    'txtFechaAprobado.Enabled = False
                    'txtValidezOferta.Enabled = False
                    'txtDetalleCondicionCompra.Enabled = False
                    cmbMoneda.Enabled = False
                    'cmbPlazo.Enabled = False
                    cmbCondicionVenta.Enabled = False
                    'cmbPlazo.Enabled = False
                    txtObservaciones.Enabled = False
                    'txtDescProveedor.Enabled = False
                    'txtFechaCierreCompulsa.Enabled = False
                    'txtDetalle.Enabled = False
                    txtTotBonif.Enabled = False



                    'detalle
                    LinkAgregarRenglon.Enabled = False
                    txt_AC_Articulo.Enabled = False
                    txtDetObservaciones.Enabled = False
                    txtDetTotal.Enabled = False
                    '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
                    'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
                    txtDetCantidad.Enabled = False
                    txtTotBonif.Enabled = False
                    txtDetFechaEntrega.Enabled = False



                    'links a popups

                    LinkAgregarRenglon.Style.Add("visibility", "hidden")
                    LinkButton1.Style.Add("visibility", "hidden")
                    LinkButton2.Style.Add("visibility", "hidden")
                    'LinkButton2.Attributes("Visibility") = "Hidden"
                    'LinkButton2.Style.Add("display", "none")

                    'ModalPopupExtender1.Hide()
                    'ModalPopupExtender2.Hide()


                    'links a popups
                    'LinkAgregarRenglon.Style.Add("visibility", "hidden")
                    LinkButton1.Style.Add("visibility", "hidden")
                    'LinkButton2.Style.Add("visibility", "hidden")

                    MostrarBotonesParaAdjuntar()
                Else
                    LinkButton1.Enabled = True
                    'LinkButtonPopupDirectoCliente.Enabled = True
                End If

                If True Then 'solo vista
                    btnSave.Visible = False
                    btnAnular.Visible = True
                    btnAnular.Enabled = True
                    btnCancel.Text = "Salir"
                End If

                If .Anulada = "SI" Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    btnAnular.Visible = False
                    lblAnulado.Visible = True
                    lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion '& " por " & .MotivoAnulacion
                    btnSave.Visible = False
                    btnCancel.Text = "Salir"
                End If

                btnDescargaAdjuntosDeFacturacionWilliams.Enabled = True
                btnDescargaAdjuntosDeFacturacionWilliamsA4.Enabled = True
                btnEnvioMailAdjuntosWilliams.Enabled = True
                Button6.Enabled = True
                txtDireccionMailAdjuntoWilliams.Enabled = True

                Try
                    MostrarCartasPorteImputadas()
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MandarMailDeError(ex.ToString())
                End Try

                If myFactura.Anulada = "SI" Or lblLinksAcartasImputadas.Text = "" Then VerLog()

            End If
        End With
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

        butVerLog.Enabled = True

    End Sub


    '////////////////////////////////////////////////////////////////////////////
    '   ALTA SETUP   'preparo la pagina para dar un alta
    '////////////////////////////////////////////////////////////////////////////

    Function AltaSetup() As Pronto.ERP.BO.Factura


        Dim myFactura As Pronto.ERP.BO.Factura = New Pronto.ERP.BO.Factura
        With myFactura
            .Id = -1


            RefrescarNumeroTalonario()
            txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?


            BuscaTextoEnCombo(cmbMoneda, "PESOS")
            'txtNumeroFactura1.Text = 1

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As FacturaItem = New Pronto.ERP.BO.FacturaItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Cantidad = 0
            mItem.Precio = Nothing


            .Detalles.Add(mItem)
            GridView1.DataSource = .Detalles 'este bind lo copié
            GridView1.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////



            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If


            'txtReferencia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoFacturaReferencia").ToString
            'txtFechaFactura.Text = System.DateTime.Now.ToShortDateString()


            ViewState("PaginaTitulo") = "Nueva Factura"
        End With

        Return myFactura
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As Pronto.ERP.BO.Factura
        'los textbox que no se refresquen ponelos en un UpdatePanel

        Dim myFactura As Pronto.ERP.BO.Factura

        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?
            myFactura = FacturaManager.GetItem(SC, IdFactura, True) 'va a editar ese ID
            'myFactura = FacturaManager.GetItemComPronto(SC, IdFactura, True) 'va a editar ese ID
        Else
            'está haciendo un alta, pero uso los datos de un ID existente
            'myFactura = FacturaManager.GetCopyOfItem(SC, CopiaDeOtroId)
            IdFactura = -1
            'tomar el ultimo de la serie y sumarle uno


            'myFactura.SubNumero = FacturaManager.ProximoSubNumero(SC, myFactura.Numero)

            'limpiar los precios del Factura original
            For Each i In myFactura.Detalles
                i.Precio = 0
            Next

            'mKey = "Factura_" & Me.IdEntity.ToString 'esto es un balurdo. aclarar bien
        End If


        If Not (myFactura Is Nothing) Then
            With myFactura

                TraerDatosCliente(myFactura.IdCliente)
                RecargarEncabezado(myFactura)


                '/////////////////////////
                '/////////////////////////
                'Grilla
                '/////////////////////////
                '/////////////////////////
                'GridView1.Columns(0).Visible = False
                GridView1.DataSource = .Detalles 'pero cómo se mantiene esto, si estoy usando un objeto local de la funcion?
                GridView1.DataBind()






                'Me.Title = "Edición Fondo Fijo " + myFactura.Letra + myFactura.NumeroComprobante1.ToString + myFactura.NumeroComprobante2.ToString
                ViewState("PaginaTitulo") = "Edición Factura " & myFactura.TipoABC & "-" & myFactura.PuntoVenta.ToString.PadLeft(4, "0") & "-" & myFactura.Numero.ToString.PadLeft(8, "0")
                '/////////////////////////
                '/////////////////////////




                '/////////////////////////
                '/////////////////////////
                'If iisNull(.Aprobo, "NO") = "SI" Then
                'If iisNull(.Aprobo) = "" Then

                'If .Aprobo <> 0 Then
                '    'me fijo si está cerrado
                '    DisableControls(Me)
                '    btnCancel.Enabled = True
                'End If


                '/////////////////////////
                '/////////////////////////

            End With


            If CopiaDeOtroId <> -1 Then 'esto se tiene que controlar de otra manera, pero por ahora safemos así
                'acá se mete si es una copia de otro
                Me.ViewState.Add(mKey, myFactura)

                'vacío el proveedor (porque es una copia)
                'SelectedReceiver.Value = 0
                'txtDescProveedor.Text = ""
            End If

        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdFactura & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myFactura
    End Function

    Sub RecargarEncabezado(ByVal myFactura As Pronto.ERP.BO.Factura)
        With myFactura

            txtFechaIngreso.Text = .Fecha
            txtLetra.Text = .TipoABC
            lblLetra.Text = txtLetra.Text
            txtAutocompleteCliente.Text = EntidadManager.NombreCliente(SC, .IdCliente)

            txtFechaVencimiento.Text = .FechaVencimiento

            BuscaIDEnCombo(cmbPuntoVenta, .IdPuntoVenta)
            cmbPuntoVenta.Text = .PuntoVenta 'TODO: problemas con el talonario vs el punto de venta. Vienen otros IDs
            BuscaTextoEnCombo(cmbPuntoVenta, .PuntoVenta.ToString.PadLeft(4, "0"))
            '.IdPuntoVenta = FacturaManager.IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, cmbPuntoVenta.Text, txtLetra.Text)


            txtNumeroFactura2.Text = .Numero

            txtNumeroCertificadoIIBB.Text = .NumeroCertificadoPercepcionIIBB





            Try
                Dim db = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(Encriptar(SC)))
                Dim fac = db.Facturas.Where(Function(x) x.IdFactura = IdFactura).FirstOrDefault
                If If(fac.IdClienteObservaciones, 0) > 0 Then lblLog.Text &= "Cliente Obs=" & fac.IdClienteObservaciones
                db = Nothing
            Catch ex As Exception
                ErrHandler2.WriteError(Encriptar(SC))
                ErrHandler2.WriteError("Idfactura=" & IdFactura)
                ErrHandler2.WriteError(ex)
                ErrHandler2.WriteError(ex.ToString)
            End Try






            BuscaIDEnCombo(cmbCategoriaIIBB1, .IdIBCondicion)

            BuscaIDEnCombo(cmbMoneda, .IdMoneda)
            BuscaIDEnCombo(cmbCondicionVenta, .IdCondicionVenta)

            'txtTotal.Text = .total
            Try

                txtDireccionMailAdjuntoWilliams.Text = ClienteManager.GetItem(SC, .IdCliente).Email
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            txtVendedor.Text = EntidadManager.NombreVendedor(HFSC.Value, .IdVendedor)
            txtObservaciones.Text = .Observaciones
            chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)


            'pero debiera usar el formato universal...
            txtTotBonif.Text = String.Format("{0:F2}", DecimalToString(.Bonificacion))
            txtSubtotal.Text = String.Format("{0:F2}", DecimalToString(.ImporteIva1)) 'o uso {0:c} o {0:F2} ?
            txtTotal.Text = String.Format("{0:F2}", DecimalToString(.Total))

            'UpdatePanelEncabezado.Update() 'por ahora solo incluye el combo del proveedor, porque tuve problemas para incluir todo el resto del encabezado
        End With
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'Combos
    '////////////////////////////////////////////////////////////////////////////////////

    Private Sub BindTypeDropDown()
        'cmbProveedor.DataSource = Pronto.ERP.Bll.ProveedorManager.GetListCombo(SC)
        'cmbProveedor.DataTextField = "Titulo"
        'cmbProveedor.DataValueField = "IdProveedor"
        'cmbProveedor.DataBind()

        'cmbEmpleado.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        'cmbEmpleado.DataTextField = "Titulo"
        'cmbEmpleado.DataValueField = "IdEmpleado"
        'cmbEmpleado.DataBind()

        'cmbSectores.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Sectores")
        'cmbSectores.DataTextField = "Titulo"
        'cmbSectores.DataValueField = "IdSector"
        'cmbSectores.DataBind()

        cmbLibero.DataSource = EmpleadoManager.GetListCombo(SC)
        cmbLibero.DataTextField = "Titulo"
        cmbLibero.DataValueField = "IdEmpleado"
        cmbLibero.DataBind()


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////


        Dim db As LinqBDLmasterDataContext = New LinqBDLmasterDataContext(Encriptar(ConexBDLmaster))

        '       
        Dim a = From p In db.DetalleUserPermisos _
                Join e In db.aspnet_Users On p.UserId Equals e.UserId _
                Where p.Modulo = "Facturas" And p.PuedeModificar _
                Select IdEmpleado = e.UserId, Titulo = e.UserName



        cmbUsuarioAnulo.DataSource = EmpleadoManager.GetListCombo(SC)
        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8085
        'Para anular facturas: en el combo de usuarios solo mostrar los que tengan permisos de facturación y pedir el pass de la web
        'Dim ue = EmpleadoManager.GetListUsuariosQuePuedenAnularFacturas(ConexBDLmaster)
        cmbUsuarioAnulo.DataSource = a
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()



        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////





        cmbCategoriaIIBB1.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "IBCondiciones")
        cmbCategoriaIIBB1.DataTextField = "Titulo"
        cmbCategoriaIIBB1.DataValueField = "IdIBCondicion"
        cmbCategoriaIIBB1.DataBind()

        cmbListaPrecios.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "ListasPrecios_TL")
        cmbListaPrecios.DataTextField = "Titulo"
        cmbListaPrecios.DataValueField = "IdListaPrecios"
        cmbListaPrecios.DataBind()
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbCondicionIVA.DataSource = EntidadManager.GetListCombo(SC, "DescripcionIVA")
        cmbCondicionIVA.DataTextField = "Titulo"
        cmbCondicionIVA.DataValueField = "IdCodigoIVA"
        cmbCondicionIVA.DataBind()
        cmbCondicionIVA.Items.Insert(0, New ListItem("-- Elija una Condición --", -1))
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'METODO 1
        'cmbPuntoVenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", 41, "X")
        'cmbPuntoVenta.DataSource = EntidadManager.GetListTX(SC, "PuntosVenta", "TX_PuntosVentaTodos") 'Comparativas solo acepta a gente del sector de compras


        RefrescarTalonariosDisponibles()


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbCondicionVenta.DataSource = EntidadManager.GetListCombo(SC, "CondicionesCompra")
        If cmbCondicionVenta.DataSource.Tables(0).Rows.Count = 0 Then
        End If
        cmbCondicionVenta.DataTextField = "Titulo"
        cmbCondicionVenta.DataValueField = "IdCondicionCompra"
        cmbCondicionVenta.DataBind()
        'If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
        '    BuscaIDEnCombo(cmbCondicionCompra, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))
        '    cmbCondicionCompra.Enabled = False
        'Else
        cmbCondicionVenta.Items.Insert(0, New ListItem("", -1))
        cmbCondicionVenta.SelectedIndex = 0
        'End If


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbMoneda.DataSource = EntidadManager.GetListCombo(SC, "Monedas")
        cmbMoneda.DataTextField = "Titulo"
        cmbMoneda.DataValueField = "IdMoneda"
        cmbMoneda.DataBind()
        BuscaTextoEnCombo(cmbMoneda, "PESOS")
        'AgregaLeyendaEnCombo(cmbMoneda, "-- Elija una Moneda --")


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'cmbTipoComprobante.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "TiposComprobante", "TX_ParaComboProveedores")
        'If cmbTipoComprobante.DataSource.Tables(0).Rows.Count = 0 Then
        'End If
        'cmbTipoComprobante.DataTextField = "Titulo"
        'cmbTipoComprobante.DataValueField = "IdTipoComprobante"
        'cmbTipoComprobante.DataBind()


        ''elegir automaticamente "Factura de Compra"
        'BuscaTextoEnCombo(cmbTipoComprobante, "FC  Factura compra")
        ''If Not (cmbTipoComprobante.Items.FindByValue("FC Factura de Compra") Is Nothing) Then
        '' cmbTipoComprobante.SelectedIndex = -1
        '' cmbTipoComprobante.Items.FindByValue("FC Factura de Compra").Selected = True
        '' End If

        ''If IsNumeric(Session("glbIdCuentaFFUsuario")) Then
        ''If False Then
        ''    'cmbTipoComprobante.SelectedValue = 
        ''    'cmbTipoComprobante.Enabled = False
        ''Else
        ''    cmbTipoComprobante.Items.Insert(0, New ListItem("-- Elija un Tipo --", -1))
        ''    cmbTipoComprobante.SelectedIndex = 0
        ''End If


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'cmbDestino.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Obras", "TX_DestinosParaComboPorIdObra", cmbObra.SelectedValue)
        'cmbDestino.DataTextField = "Titulo"
        'cmbDestino.DataValueField = "IdDetalleObraDestino"
        'cmbDestino.DataBind()


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbDetUnidades.DataSource = EntidadManager.GetListCombo(SC, "Unidades")
        cmbDetUnidades.DataTextField = "Titulo"
        cmbDetUnidades.DataValueField = "IdUnidad"
        cmbDetUnidades.DataBind()
        cmbDetUnidades.Enabled = False


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbArticulosDevolucion.DataSource = GetStoreProcedure(SC, enumSPs.Articulos_TX_PorIdRubroParaCombo, mvarIdRubroDevolucionAnticipos)
        cmbArticulosDevolucion.DataTextField = "Titulo"
        cmbArticulosDevolucion.DataValueField = "IdArticulo"
        cmbArticulosDevolucion.DataBind()

    End Sub

    Function mvarIdRubroDevolucionAnticipos() As Integer
        mvarIdRubroDevolucionAnticipos = 0
        mvarIdRubroDevolucionAnticipos = iisNull(ParametroManager.TraerValorParametro2(SC, "IdRubroDevolucionAnticipos"), 0)
        Return mvarIdRubroDevolucionAnticipos
    End Function


    Function TraerDatosCliente(ByVal IdCliente As Long)
        Try
            Dim oCli = ClienteManager.GetItem(SC, IdCliente)
            With oCli
                BuscaIDEnCombo(cmbCondicionIVA, EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("IdCodigoIva"))
                txtCUIT.Text = EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("CUIT")
                BuscaIDEnCombo(cmbCondicionVenta, .IdCondicionVenta)

                MostrarDatos(0)

                RefrescarTalonariosDisponibles()

            End With
        Catch ex As Exception
            Return -1
        End Try



    End Function




    Function TraerLogDeFactura(ByVal idfact As Long) As Data.DataTable


        Dim s = "select * from log    where  idcomprobante=" & idfact & " AND " & _
                                    " (     (Tipo='MODIF' " & " and detalle like 'Imputacion de IdCartaPorte%idfacturaimputada=" & idfact & " %' )   " & _
                                    "    or   (Tipo='FA')   " & _
                                    "    or  (detalle like 'Factura%')      " & _
                                    "  )                                                 " & _
                                    "  order by FechaRegistro"

        If False Then
            'para mostrar tambien las desimputadas manuales
            'va muy lento. hay que loguear la idfactura en otra columna del log
            Dim os = "select * from log    where  idcomprobante=" & idfact & " AND " & _
                                        " (     (Tipo='MODIF' " & " and detalle like 'Imputacion de IdCartaPorte%idfacturaimputada " & idfact & "' )   " & _
                                        "    or   (Tipo='FA')   " & _
                                        "    or  (detalle like 'Factura%')      " & _
                                        "  )                                                 " & _
                                        "    or  (detalle like 'Se desimputa la carta id%de la factura id" & idfact & "' ) " & _
                                        "  order by FechaRegistro"
        End If




        'mostrar si, al no encontrar cartas, hay alguna nota de credito imputada
        Dim c = "select idfactura,idnotacredito " & _
"from [DetalleNotasCreditoImputaciones] " & _
"inner join  CuentasCorrientesDeudores on CuentasCorrientesDeudores.IdCtaCte=[DetalleNotasCreditoImputaciones].idImputacion and IdTipoComp=1 " & _
"inner join  Facturas on CuentasCorrientesDeudores.IdComprobante=Facturas.idfactura and IdTipoComp=1 " & _
"order by idfactura"







        Debug.Print(s)
        ErrHandler2.WriteError(s)
        'Return EntidadManager.ExecDinamico(SC, s, 150)
        Return EntidadManager.ExecDinamico(SC, s)

        'EntidadManager.ExecDinamico(SC, "UPDATE CartasDePorte SET IdFacturaImputada=" & idfactura & "  WHERE IdCartaDePorte=" & oCDP.Id)
        'EntidadManager.LogPronto(SC, idfactura, "Imputacion de IdCartaPorte" & oCDP.Id & "CDP:" & oCDP.NumeroCartaDePorte & " " & oCDP.SubnumeroVagon & "  IdFacturaImputada " & idfactura, nombreUsuario)

    End Function


    Sub VerLog()

        Dim dt As Data.DataTable

        Try
            dt = TraerLogDeFactura(IdFactura)
        Catch ex As Exception
            MandarMailDeError(ex)
            ErrHandler2.WriteError(ex)
            Return
        End Try

        If dt Is Nothing Then
            ErrHandler2.WriteError("Log vacío")
            Exit Sub
        End If


        Debug.Print(dt.Rows.Count)
        Dim s As String = "" '= dt.ToString()
        'Join(", ", dt.Rows(0).ItemArray)

        Dim listaCartas As New Generic.List(Of String)

        For Each r In dt.Rows
            'Dim texto As String = r.Item(0) & " " & r.Item(1) & " " & r.Item(2) & " " & r.Item(3) & " " & r.Item(4) & " " & r.Item(5) & " " & r.Item(6) & " " & r.Item(7) & "\n\n <br/>"
            Dim texto As String = r.Item(5) & " " & r.Item(6)
            Dim idcarta = TextoEntre(texto, "CartaPorte", "CDP")
            listaCartas.Add(Val(idcarta))
            s &= "<a href=""CartaDePorte.aspx?Id=" & idcarta & """ target=""_blank"">" & texto & "</a> <br/>"

        Next

        Try
            Dim db As LinqCartasPorteDataContext = New LinqCartasPorteDataContext(Encriptar(SC))
            Dim o As String = (From i In db.Logs Where i.IdComprobante = IdFactura And i.Detalle.StartsWith("Factura De Cartas") Select i.Detalle).FirstOrDefault

            'Dim t As String = (From i In db.Logs Where i.IdComprobante = IdFactura And i.Detalle.StartsWith("FactWilliamsObs") Select i.Detalle).FirstOrDefault

            s += "<br/> [1 titular / 2 destinatario / 3 corredor / 4 a tercero / 5 automatico] <br/>"

            lblLog.Text = s & "<br/><br/>" & Join(listaCartas.ToArray, ",") & vbCrLf & o & vbCrLf & "<br/><br/> Si no hay cartas imputadas y la factura no está anulada, verificar si hay alguna nota de credito imputada<br/>" & vbCrLf & "<br/>" & "<br/>"
        Catch ex As Exception
            ErrHandler2.WriteError("Verlog Facturas")
            ErrHandler2.WriteError(ex)
        End Try



        'ver los corredores que se asociaron a la factura
        'select * from log where Detalle like '% para cliente 437%'




        'MsgBoxAjax(Me, s)

        '        "Log_InsertarRegistro", IIf(myCartaDePorte.Id <= 0, "ALTA", "MODIF"), _
        '                                              CartaDePorteId, 0, Now, 0, "Tabla : CartaPorte", "", NombreUsuario, _

    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    Sub RefrescarTalonariosDisponibles()

        'en la segunada llamada lblLetra.Text está en B!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        lblLetra.Text = "A"

        Dim dt = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", _
                                                            EntidadManager.IdTipoComprobante.Factura, lblLetra.Text.ToUpper, "SI").Tables(0)
        cmbPuntoVenta.DataSource = dt
        cmbPuntoVenta.DataTextField = "Titulo"
        cmbPuntoVenta.DataValueField = "IdPuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0

        If cmbPuntoVenta.Items.Count = 0 Then
            MsgBoxAjax(Me, "No hay talonario para facturas")
        Else
            RefrescarNumeroTalonario()
        End If
    End Sub

    Sub RefrescarNumeroTalonario()
        'RESOLVER ESTO (el refresco del talonario por manager)
        'FacturaManager.RefrescarNumeroTalonario()
        'Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

        txtLetra.Text = EntidadManager.LetraSegunTipoIVA(cmbCondicionIVA.SelectedValue)
        lblLetra.Text = txtLetra.Text
        'cmbPuntoVenta.SelectedIndex = 0
        txtNumeroFactura2.Text = FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.SelectedItem.Text) 'ParametroOriginal(SC, "ProximoFactura")

    End Sub




    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try

            Dim mOk As Boolean
            Page.Validate("Encabezado")
            mOk = Page.IsValid


            If mOk Then
                Dim mIdCodigoIva As Integer
                Dim mIdProveedor As Long

                Dim mIdCuentaIvaCompras(10) As Long
                Dim mIVAComprasPorcentaje(10) As Single



                'If Not mAltaItem Then 'y esto?

                Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

                With myFactura

                    'traigo parámetros generales
                    Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    '.IdMoneda = drParam.Item("ProximoFacturaReferencia").ToString 'mIdMonedaPesos
                    .IdMoneda = 1 ' cmbMoneda.SelectedValue

                    '.IdPuntoVenta = FacturaManager.IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, cmbPuntoVenta.Text, txtLetra.Text)
                    .PuntoVenta = cmbPuntoVenta.SelectedItem.Text
                    .Numero = StringToDecimal(txtNumeroFactura2.Text)
                    .TipoABC = txtLetra.Text

                    .IdCliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, SC)
                    .IdCondicionVenta = cmbCondicionVenta.SelectedValue

                    .FechaIngreso = txtFechaIngreso.Text
                    .FechaFactura = txtFechaIngreso.Text
                    .Fecha = txtFechaIngreso.Text

                    '.Validez = txtValidezOferta.Text
                    '.DetalleCondicionCompra = txtDetalleCondicionCompra.Text

                    '.CotizacionMoneda = 1
                    ''.CotizacionDolar = Cotizacion(Now, drParam.Item("IdMonedaDolar")) 'mvarCotizacionDolar
                    ''.IdOrdenPago = Nothing
                    ''.IdUsuarioIngreso = session(SESSIONPRONTO_glbIdUsuario)
                    '.FechaIngreso = txtFechaIngreso.Text
                    '.FechaAprobacion = txtFechaAprobado.Text
                    '.FechaCierreCompulsa = txtFechaCierreCompulsa.Text

                    '.Aprobo = IIf(txtLibero.Text <> "" And txtLibero.Text <> "Password Incorrecta", Convert.ToInt32(cmbLibero.SelectedValue), 0)

                    '.Detalle = txtDetalle.Text
                    '.DetalleCondicionCompra = txtDetalleCondicionCompra.Text
                    .Cotizacion = 1 ' Cotizacion()
                    .Observaciones = txtObservaciones.Text
                    .IdObra = 1
                    '.ArchivoAdjunto1 = lnkAdjunto1.Text

                    .IdIBCondicion = cmbCategoriaIIBB1.SelectedValue

                    .NumeroCertificadoPercepcionIIBB = Val(txtNumeroCertificadoIIBB.Text)


                    .ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
                    If .IdComprador = 0 Then .IdComprador = Session(SESSIONPRONTO_glbIdUsuario) 'Si lo edita un proveedor, no debe pisar el IdComprador

                    'myFactura.Observaciones = Convert.ToString(txtObservaciones.Text) '???
                    .Observaciones = txtObservaciones.Text

                    '.NumeroCAI = txtCAI.Text

                    'If iisValidSqlDate(txtFechaVtoCAI.Text) Is Nothing Then
                    '    .FechaVencimientoCAI = Nothing
                    'Else
                    '    .FechaVencimientoCAI = Convert.ToDateTime(txtFechaVtoCAI.Text)
                    'End If

                    'myFactura.IdAprobo = Convert.ToInt32(cmbLibero.SelectedValue)
                    'myFactura.LugarEntrega = Convert.ToString(txtLugarEntrega.Text)
                    'myFactura.IdComprador = Convert.ToInt32(cmbComprador.SelectedValue)

                    '.IdComprobanteImputado = Nothing




                    'If txtLibero.Text <> "" Then
                    '.ConfirmadoPorWeb = "SI"
                    'Else
                    '.ConfirmadoPorWeb = "NO"
                    'End If

                End With




                Dim ms As String
                If FacturaManager.IsValid(SC, myFactura, ms) Then
                    Try
                        If FacturaManager.Save(SC, myFactura) = -1 Then
                            MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.ToString)
                    End Try




                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                    IdFactura = myFactura.Id



                    If myFactura.Numero <> StringToDecimal(txtNumeroFactura2.Text) Then
                        EndEditing("La factura fue grabada con el número " & myFactura.Numero) 'me voy 
                    Else
                        EndEditing("Desea imprimir el comprobante?")
                    End If

                Else
                    MsgBoxAjax(Me, ms)
                    Exit Sub
                End If




            Else
                MsgBoxAjax(Me, "El objeto no es válido")
                mAltaItem = False
                'LblInfo.Visible = False
                PanelInfo.Visible = True
                PanelInfoNum.Visible = True
                'LblInfo.Visible = True
            End If

            'End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
        Finally
            btnSave.Visible = True
            btnSave.Enabled = True
        End Try
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click
        If Not mAltaItem Then
            EndEditing()
        Else
            mAltaItem = False
        End If
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////

    Private Sub EndEditing(Optional ByVal MensajeFinal As String = "")
        'http://www.sitepoint.com/forums//showthread.php?t=483413

        'poner en el redirect del EndEditing esto:
        'Response.Write("<script>alert('message') ; window.location.href='nextpage.aspx'</script>")
        ' o tambien se puede usar un confirm button 
        Try
            If MensajeFinal <> "" Then
                'Response.Write("<script>alert('message') ; window.location.href='Comparativas.aspx'</script>")

                'PreRedirectMsgbox.OnOkScript = "window.location = ""Comparativas.aspx"""
                'ButVolver.PostBackUrl = "Comparativas.aspx"
                LblPreRedirectMsgbox.Text = MensajeFinal
                PreRedirectMsgbox.Show()
                'el confirmbutton tambien me sirve si el usuario aprieta sin querer en el menu!!!!!! -no, no sirve para eso
            Else
                'PreRedirectConfirmButtonExtender.Enabled = False 'http://stackoverflow.com/questions/2096262/conditional-confirmbuttonextender
                Response.Redirect(String.Format("Facturas.aspx"))
            End If

        Catch ex As Exception
            ErrHandler2.WriteAndRaiseError(ex)
        End Try
    End Sub



    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("Facturas.aspx?Imprimir=" & IdFactura))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("Facturas.aspx")) 'roundtrip al cuete?
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////









    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '   ALTA Y EDICION DE RENGLONES
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Protected mustAlert As Boolean = False 'y esto?

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////
    'Botón de alta
    '////////////////////////////////////////////////////////////////////////////////////

    ''' <summary>
    ''' Boton de alta
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        AltaItemSetup()
    End Sub


    Sub AltaItemSetup()
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleFactura") = -1
        'cmbCuentaGasto.SelectedIndex = 1
        txtCodigo.Text = ""
        txt_AC_Articulo.Text = ""
        SelectedAutoCompleteIDArticulo.Value = 0
        txtDetCantidad.Text = ""
        txtDetCosto.Text = ""
        txtDetBonif.Text = ""
        txtDetPrecioUnitario.Text = ""
        txtDetTotal.Text = ""
        txtPorcentajeCertificacion.Text = ""
        txtDetObservaciones.Text = ""
        txtDetFechaEntrega.Text = ""
        RadioButtonListDescripcion.SelectedValue = 1
        RadioButtonListFormaCancelacion.SelectedValue = 1

        '    gp.DataSource = ObjectDataSource3.Select
        '    gp.DataBind()

        'odsOCsPendientes.Select()
        gvAuxOCsPendientes.DataBind()
        gvAuxOCsPendientes.SelectedIndex = -1
        'gvAuxRemitosPendientes.DataSource = odsRemitosPendientes.Select()
        gvAuxRemitosPendientes.DataBind()

        UpdatePanelDetalle.Update()
        ModalPopupExtender3.Show()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'ModalPopupExtender3.Show()
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

                Dim b As LinkButton = e.Row.Cells(6).Controls(0)
                b.Text = "Restaurar" 'reemplazo el texto del eliminado

            End If
        End If
    End Sub




    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myFactura As Pronto.ERP.BO.Factura

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myFactura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

                    'si esta eliminado, lo restaura
                    myFactura.Detalles(mIdItem).Eliminado = Not myFactura.Detalles(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myFactura)
                    GridView1.DataSource = myFactura.Detalles
                    GridView1.DataBind()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleFactura") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myFactura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)
                    With myFactura.Detalles(mIdItem)
                        'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                        .Eliminado = False


                        txtDetObservaciones.Text = .Observaciones

                        '////////////////////////////////////////////////////////////////////////////////
                        'HAY QUE ARREGLAR ESTO: me lo tiene que dar directamente el BO.Factura
                        'txtDescProveedor = myFactura.Detalles(mIdItem).descripcion
                        Try
                            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", .IdArticulo)
                            If ds.Tables(0).Rows.Count > 0 Then
                                'txtDescProveedor.Text = ds.Tables(0).Rows(0).Item("Descripcion").ToString
                            End If

                        Catch ex As Exception

                            ErrHandler2.WriteError(ex)
                        End Try
                        '////////////////////////////////////////////////////////////////////////////////

                        If .IdArticulo > 0 Then txtCodigo.Text = ArticuloManager.GetItem(SC, .IdArticulo).Codigo

                        SelectedAutoCompleteIDArticulo.Value = .IdArticulo
                        txt_AC_Articulo.Text = .Articulo

                        '////////////////////////////////////////////////////////////////////////////////
                        'elige en combos
                        '////////////////////////////////////////////////////////////////////////////////
                        BuscaIDEnCombo(cmbDetUnidades, .IdUnidad)
                        'BuscaIDEnCombo(cmbCuentaGasto, .Detalles(mIdItem).IdCuentaGasto.ToString)
                        'BuscaIDEnCombo(cmbDestino, .Detalles(mIdItem).IdDetalleObraDestino)
                        '////////////////////////////////////////////////////////////////////////////////


                        txtDetFechaEntrega.Text = .FechaEntrega
                        'txtCodigo.Text = .Detalles(mIdItem).CodigoCuenta
                        txtDetCantidad.Text = DecimalToString(.Cantidad)
                        txtDetPrecioUnitario.Text = DecimalToString(.Precio)
                        txtDetIVA.Text = DecimalToString(.PorcentajeIVA)
                        txtDetCosto.Text = DecimalToString(.Costo)
                        txtDetBonif.Text = DecimalToString(.PorcentajeBonificacion)

                        txtPorcentajeCertificacion.Text = DecimalToString(.PorcentajeCertificacion)

                        Try
                            RadioButtonListFormaCancelacion.SelectedValue = .TipoCancelacion
                        Catch ex As Exception
                            RadioButtonListFormaCancelacion.Items(0).Selected = True
                        End Try


                        txtDetTotal.Text = .ImporteTotalItem
                        'txtDetTotal.Text = .Cantidad * .Precio * .ImporteIVA

                        'cmbIVA.Text = DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1)
                        'BuscaTextoEnCombo(cmbIVA, DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1))

                        If .ArchivoAdjunto1 <> "" Then
                            Dim MyFile1 As New FileInfo(.ArchivoAdjunto1)
                            If MyFile1.Exists Then
                                lnkDetAdjunto1.Text = .ArchivoAdjunto1 + " (" + MyFile1.Length.ToString + " bytes)"
                                lnkDetAdjunto1.ToolTip = .ArchivoAdjunto1
                                lnkDetAdjunto1.Enabled = True
                            Else
                                lnkDetAdjunto1.Text = "No se encuentra el archivo " + .ArchivoAdjunto1
                                lnkDetAdjunto1.Enabled = False
                            End If
                        Else
                            lnkDetAdjunto1.Text = "Vacío"
                            lnkDetAdjunto1.ToolTip = ""
                            lnkDetAdjunto1.Enabled = False
                        End If

                        Dim oRs As ADODB.Recordset
                        Dim mAlicuotaIVA_Material As Double, mvarPrecio As Double, mPorcB As Double

                        'mIdDetalleOrdenCompra = Item.ListSubItems(1)
                        'oRs = Aplicacion.OrdenesCompra.TraerFiltrado("_DetallePorIdDetalle", mIdDetalleOrdenCompra)

                        'mAlicuotaIVA_Material = IIf(IsNull(oRs.Fields("AlicuotaIVA").Value), 0, oRs.Fields("AlicuotaIVA").Value)

                        'If mAlicuotaIVA_Material <> Me.AlicuotaIVA And Me.AlicuotaIVA <> -1 Then
                        '    MsgBox("El material tiene una alicuota de iva de " & mAlicuotaIVA_Material & " % y" & vbCrLf & _
                        '       "la alicuota activa es de " & Me.AlicuotaIVA & " %.", vbExclamation)
                        '    oRs.Close()
                        '    oRs = Nothing
                        '    origen.Registro.Fields("IdArticulo").Value = Null
                        '    Item.Checked = False
                        '    OC_Elegida = False
                        '    Exit Sub
                        'End If


                        'Me.AlicuotaIVA = mAlicuotaIVA_Material
                        'DataCombo1(0).BoundText = oRs.Fields("IdUnidad").Value
                        'DataCombo1(1).BoundText = oRs.Fields("IdArticulo").Value
                        'Me.PorcentajeBonificacionOC = IIf(IsNull(oRs.Fields("PorcentajeBonificacionOC").Value), 0, oRs.Fields("PorcentajeBonificacionOC").Value)




                        Try
                            'CargoGrillasAuxiliares(mIdItem)
                            CargoGrillasAuxiliares(.Id)
                        Catch ex As Exception

                        End Try






                    End With

                    UpdatePanelDetalle.Update()
                    ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                Else
                    'y esto? por si es el renglon vacio?

                    txtDetCantidad.Text = 1
                    'RadioButtonList1.Items(0).Selected = True
                End If

            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.ToString)
            Exit Sub
        End Try
    End Sub

    Sub CargoGrillasAuxiliares(ByVal IdDetalleFactura As Long)

        'hay que llenar las dos grilla con las colecciones de detalle de imputacion 
        'pero puedo usar los 2 sp:
        '-pero hasta que no esté grabado, no los podrás usar... no se pueden llenar las grillas
        'manualmente? Cómo puedo zafar bien?



        '1 si el item es nuevo: SP pendientes
        '2 si esta editando uno que todavia no se grabó: SP pendientes, y marco los checks segun la coleccion
        '3 si está viendo uno grabado (no puede ser editado, porque es una factura): SP del detalle, que tiene el mismo formato que el de pendientes
        '4 y qué pasaría si se pudiese editar aun grabado?: tendría que mostrar los pendientes, y los usados. Pero nunca los usados por otro...

        Try
            gvAuxOCsPendientes.DataSourceID = ""
            gvAuxOCsPendientes.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "DetFacturasOrdenesCompra_TXOrdenesCompra", IdDetalleFactura)
            gvAuxOCsPendientes.DataBind()

            gvAuxRemitosPendientes.DataSourceID = ""
            gvAuxRemitosPendientes.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "DetFacturasOrdenesCompra_TXOrdenesCompra", IdDetalleFactura)
            gvAuxRemitosPendientes.DataBind()


            'odsOCsPendientes.SelectParameters.Item("TX").DefaultValue = "DetFacturasOrdenesCompra_TXOrdenesCompra"
            'odsOCsPendientes.SelectParameters.Item("Parametros").DefaultValue = IdDetalleFactura

            'odsRemitosPendientes.SelectParameters.Item("TX").DefaultValue = "DetFacturasOrdenesCompra_TXOrdenesCompra"
            'odsRemitosPendientes.SelectParameters.Item("Parametros").DefaultValue = IdDetalleFactura

        Catch ex As Exception

        End Try

    End Sub


    Sub MostrarCartasPorteImputadas()
        Dim lista = FacturaManager.CartasPorteImputadas(SC, IdFactura)

        For Each s In lista
            lblLinksAcartasImputadas.Text &= "<a href=""CartaDePorte.aspx?Id=" & s.IdCartaDePorte & """ target=""_blank"">" & s.NumeroCartaDePorte & " " & s.SubnumeroVagon & "/" & s.SubnumeroDeFacturacion & IIf(s.AgregaItemDeGastosAdministrativos = "SI", "*", "") & "</a>; "
        Next

    End Sub



    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleFactura"), Integer)
            Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As FacturaItem = New Pronto.ERP.BO.FacturaItem

                If myFactura.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myFactura.Detalles.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myFactura.Detalles.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myFactura.Detalles(mIdItem)
                    'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
                    ' de cada valor, como se hace en toda web

                    'ORIGINAL EDU:
                    '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
                    '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
                    'MODIFICADO CON AUTOCOMPLETE:

                    .IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
                    .Articulo = txt_AC_Articulo.Text
                    .FechaEntrega = ProntoFuncionesGenerales.iisValidSqlDate(txtDetFechaEntrega.Text)

                    .Cantidad = StringToDecimal(txtDetCantidad.Text)
                    .Precio = StringToDecimal(txtDetPrecioUnitario.Text)
                    .PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
                    .PorcentajeIVA = StringToDecimal(txtDetIVA.Text)
                    .Costo = StringToDecimal(txtDetCosto.Text)
                    .PorcentajeCertificacion = StringToDecimal(txtPorcentajeCertificacion.Text)

                    .ImporteTotalItem = StringToDecimal(txtDetTotal.Text)
                    .IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)
                    .Unidad = cmbDetUnidades.SelectedItem.Text
                    '.ArchivoAdjunto1 = FileUpLoad2.FileName

                    'total

                    '.ArchivoAdjunto1
                    '.ArchivoAdjunto2


                    .OrigenDescripcion = 1 'como por ahora no tengo el option button, le pongo siempre 1
                    .TipoCancelacion = RadioButtonListFormaCancelacion.SelectedItem.Value + 1



                    ImputoItemAOrdenCompra(mIdItem)
                    ImputoItemARemito(mIdItem)



                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As Data.DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With


                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.ToString)
                Exit Sub
            End Try

            RecalcularTotalComprobante()

            Me.ViewState.Add(mKey, myFactura)
            GridView1.DataSource = myFactura.Detalles
            GridView1.DataBind()

            UpdatePanelGrilla.Update()

        End If

        'MostrarElementos(False)
        mAltaItem = True
    End Sub




    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
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
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnAceptaDevolucion)
                    Response.TransmitFile(FilePath)
                    Response.End()
                Catch ex As Exception
                    MsgBoxAjax(Me, ex.ToString)
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
                MostrarBotonesParaAdjuntar()
            Catch ex As Exception
                MsgBoxAjax(Me, ex.ToString)
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If
    End Sub

    Protected Sub lnkBorrarAdjunto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBorrarAdjunto.Click
        lnkAdjunto1.Text = ""
        MostrarBotonesParaAdjuntar()
    End Sub

    Sub MostrarBotonesParaAdjuntar()
        Dim hayAdjunto As Boolean = (lnkAdjunto1.Text <> "")
        lnkAdjunto1.Visible = hayAdjunto
        lnkBorrarAdjunto.Visible = hayAdjunto 'Not mostrar And lnkAdjunto1.Text <> "" 'si no hay arhcivo, no hay borrar

        lnkAdjuntar.Visible = False 'antes era =mostrar . Por ahora este no lo muestro (se supone que era el que adjuntaba sin 2 clicks)
        FileUpLoad2.Visible = Not hayAdjunto
        btnAdjuntoSubir.Visible = Not hayAdjunto
    End Sub

    'linkbutton de descarga de adjunto del detalle
    Protected Sub lnkDetAdjunto1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkDetAdjunto1.Click

        'http://forums.asp.net/t/1320694.aspx no funciona así nomás dentro de un UpdatePanel
        'http://www.velocityreviews.com/forums/t68390-download-file.html


        'http://forums.asp.net/t/1023022.aspx problema con modalpopup: como 
        '              el FileUpload necesita hacer postback, me vuela el modalpopup
        ' http://forums.asp.net/p/1244834/2285105.aspx#2285105


        Dim FilePath As String = lnkDetAdjunto1.ToolTip  '"C:\downloads\setup.exe"
        Dim FileName As String = System.IO.Path.GetFileName(FilePath)

        'System.IO.Path.GetFileName(FilePath)
        'System.IO.Path.GetDirectoryName()

        'EL BOTON DE DESCARGA DEBE ESTAR AFUERA DE LOS UPDATEPANEL!!!!!!!
        If FilePath <> "" Then
            Dim MyFile As New FileInfo(FilePath)
            If MyFile.Exists Then
                'Set the appropriate ContentType.
                Try


                    'Dim s As String
                    's = "window.open('" & FilePath & "','Descarga','toolbar=0,menubar=0,resizable=yes')"
                    'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "winOpen", s, True)

                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & FileName)
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnAceptaDevolucion)
                    Response.TransmitFile(FilePath)
                    'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON.Fields(".Fields(".Fields(".Fields("

                    ''Write the file directly to the HTTP output stream.
                    'Response.WriteFile(FilePath)
                    Response.End()



                Catch ex As Exception
                    MsgBoxAjax(Me, ex.ToString)
                End Try
            End If
        End If






    End Sub




    Protected Sub lnkDetAdjunto2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkDetAdjunto2.Click

        'http://forums.asp.net/t/1320694.aspx no funciona así nomás dentro de un UpdatePanel
        'http://www.velocityreviews.com/forums/t68390-download-file.html


        'http://forums.asp.net/t/1023022.aspx problema con modalpopup: como 
        '              el FileUpload necesita hacer postback, me vuela el modalpopup
        ' http://forums.asp.net/p/1244834/2285105.aspx#2285105


        Dim FilePath As String = lnkDetAdjunto2.ToolTip  '"C:\downloads\setup.exe"
        Dim FileName As String = System.IO.Path.GetFileName(FilePath)

        'System.IO.Path.GetFileName(FilePath)
        'System.IO.Path.GetDirectoryName()

        'EL BOTON DE DESCARGA DEBE ESTAR AFUERA DE LOS UPDATEPANEL!!!!!!!
        If FilePath <> "" Then
            Dim MyFile As New FileInfo(FilePath)
            If MyFile.Exists Then
                'Set the appropriate ContentType.
                Try


                    'Dim s As String
                    's = "window.open('" & FilePath & "','Descarga','toolbar=0,menubar=0,resizable=yes')"
                    'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Page, Page.GetType(), "winOpen", s, True)

                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & FileName)
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnAceptaDevolucion)
                    Response.TransmitFile(FilePath)
                    'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON.Fields(".Fields(".Fields(".Fields("


                    ''Write the file directly to the HTTP output stream.
                    'Response.WriteFile(FilePath)
                    Response.End()



                Catch ex As Exception
                    MsgBoxAjax(Me, ex.ToString)
                End Try
            End If
        End If
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////


    ''' <summary>
    ''' 
    ''' </summary>
    ''' <remarks></remarks>
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



    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////




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



    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////



    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    ' Refrescos por cambio de combos
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////


    Sub TraerCuentaFFAsociadaAObra() 'relacion uno-->varios
    End Sub




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

    Protected Sub txt_AC_Articulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) _
  Handles txt_AC_Articulo.TextChanged
        TraerDatosArticulo(SelectedAutoCompleteIDArticulo.Value)
        ClientIDSetfocus = sender.ClientID
    End Sub

    Protected Sub btnTraerDatosArti_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles txt_AC_Articulo.TextChanged
        TraerDatosArticulo(SelectedAutoCompleteIDArticulo.Value)

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

            txtDetPrecioUnitario.Text = ListaPreciosManager.GetPrecioPorLista(SC, IdArticulo, Val(cmbListaPrecios.SelectedValue))

            '////////////////////////////////



        Else
            'Usa el mismo criterio de busqueda del AUTOCOMPLETE

            'Dim l As ArticuloList = ArticuloManager.GetListParaWebService(SC, txt_AC_Articulo.Text)
            'If l Is Nothing Then
            '    txtCodigo.Text = ""
            '    txt_AC_Articulo.Text = "" 'lo vacío así se activa el validador
            '    SelectedAutoCompleteIDArticulo.Value = 0
            '    Return False
            'Else
            '    Dim myArticulo As Pronto.ERP.BO.Articulo
            '    myArticulo = l(0)
            '    txt_AC_Articulo.Text = myArticulo.Descripcion
            '    SelectedAutoCompleteIDArticulo.Value = myArticulo.Id
            '    txtCodigo.Text = myArticulo.Codigo
            '    txtDetPrecioUnitario.Text = ListaPreciosManager.GetPrecioPorLista(SC, IdArticulo, cmbListaPrecios.SelectedValue)
            '    Return True
            'End If


        End If



        '////////////////////////////////
        '////////////////////////////////
        '////////////////////////////////



        Return False 'no lo encontré
    End Function

    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Popup
    Protected Sub txtCodigo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCodigo.TextChanged
        ClientIDSetfocus = sender.ClientID
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


    Protected Sub btnRecalcularTotal_Click(ByVal sender As Object, ByVal e As System.EventArgs) _
    'Handles btnRecalcularTotal.Click, txtDetCantidad.TextChanged, txtDetBonif.TextChanged, txtDetPrecioUnitario.TextChanged
        RecalcularTotalDetalle()
    End Sub

    Sub RecalcularTotalDetalle()


        'Dim mImporte = StringToDecimal(txtDetCantidad.Text) * StringToDecimal(txtDetPrecioUnitario.Text)
        'Dim mBonificacion = Math.Round(mImporte * Val(txtDetBonif.Text) / 100, 4)
        'Dim mIVA = Math.Round((mImporte - mBonificacion) * Val(txtDetIVA.Text) / 100, 4)
        'txtDetTotal.Text = FF2(mImporte - mBonificacion + mIVA)

    End Sub

    Protected Sub txtDetCantidad_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetCantidad.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = sender.ClientID
    End Sub

    Protected Sub txtDetPrecioUnitario_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetPrecioUnitario.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = sender.ClientID
    End Sub

    Protected Sub txtDetIVA_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetIVA.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = sender.ClientID
    End Sub

    Protected Sub txtDetBonif_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetBonif.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = sender.ClientID
    End Sub

    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Pagina Principal de ABM

    Sub RecalcularTotalComprobante()
        Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)
        Try
            With myFactura


                'mejor sería usar la funcion DePaginaHaciaObjeto
                .Bonificacion = StringToDecimal(txtTotBonif.Text)
                .IdIBCondicion = cmbCategoriaIIBB1.SelectedValue '-para... el RecalcularTotales necesita que le 
                'pases el porcentaje, no el id
                '.PorcentajeIBrutos1 = 
                .Fecha = txtFechaIngreso.Text 'evidentemente, necesito pasar todo el encabezado al objeto para hacer el recalculo
                .Cotizacion = Cotizacion(SC)

                .IdCliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, SC)
                .PorcentajeIva1 = IIf(lblLetra.Text = "A", 21, 0) 'HORROR!







                '////////////////////////////////////////////
                'If IdFactura = -1 Then

                'End If
                FacturaManager.RecalcularTotales(SC, myFactura)



                '////////////////////////////////////////////
                '////////////////////////////////////////////
                '////////////////////////////////////////////
                '////////////////////////////////////////////

                txtSubtotal.Text = FF2(.SubTotal)
                'txtBonificacionPorItem.Text = FF2(.TotalBonifEnItems)
                lblTotBonif.Text = FF2(.TotalBonifSobreElTotal)
                lblTotIVA.Text = FF2(.ImporteIva1)
                lblTotPercepcionIVA.Text = FF2(.PercepcionIVA)
                lblTotIngresosBrutos.Text = FF2(.RetencionIBrutos1 + .RetencionIBrutos2 + .RetencionIBrutos3) 'FF2(.IBrutos) 
                txtTotal.Text = FF2(.Total)


            End With

            UpdatePanelTotales.Update()

        Catch ex As Exception
            '            MsgBoxAjax(Me, ex.ToString)
            ErrHandler2.WriteError(ex)

        End Try
    End Sub







    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    'Grilla Popup de Consulta de items de RMs pendientes
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub odsRemitosPendientes_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsRemitosPendientes.Selecting
        'En caso de que necesite pasarle parametros
        Dim idcliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value).ToString
        e.InputParameters("Parametros") = New String() {idcliente.ToString}

        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control

        'If Not ViewState("odsOCsPendientesMostrar") Then 'para que no busque estos datos si no fueron pedidos explicitamente
        'If txtBuscar.Text = "buscar" Then
        '    e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        'End If

        ViewState("odsOCsPendientesMostrar") = False

    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'odsRemitosPendientes.FilterExpression = "Convert([Req.Nro.], 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
        '                                     & " OR " & _
        '                                     "Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Sub


    Protected Sub RadioButtonPendientes_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonPendientes.CheckedChanged
        odsRemitosPendientes.SelectParameters.Add("TX", "_Pendientes1")
        'Requerimientos_TX_Pendientes1 'P' 
    End Sub

    Protected Sub RadioButtonAlaFirma_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonAlaFirma.CheckedChanged
        'Requerimientos_TX_PendientesDeFirma
    End Sub

    Protected Sub LinkButton1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click

        'odsRemitosPendientes.SelectMethod = "GetListTX"
        'odsRemitosPendientes.TypeName = "Pronto.ERP.Bll.RequerimientoManager"
        'odsRemitosPendientes.SelectParameters.Add("TX", "PendientesDeFirma")
        'odsRemitosPendientes.SelectParameters.Add("Parametros", "")
        ''odsRemitosPendientes.Update()
        'UpdatePanelGrillaConsulta.Update()
        ViewState("odsOCsPendientesMostrar") = True
        gvAuxRemitosPendientes.DataBind()
        ModalPopupExtender1.Show()




    End Sub





    '////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////

    Protected Sub odsOCsPendientes_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsOCsPendientes.Selecting
        Dim idcliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value).ToString
        e.InputParameters("Parametros") = New String() {idcliente.ToString}

        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        Static Dim odsOCsPendientesMostrar As Boolean = False

        'If TextBox3.Text = "buscar" Then
        If Not IsPostBack Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        odsOCsPendientesMostrar = False
    End Sub



    Protected Sub gvAuxOCsPendientes_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvAuxOCsPendientes.RowCommand
        Dim IdSeleccionado As Integer = Convert.ToInt32(e.CommandArgument)

        Try
            If e.CommandName.ToLower = "select" Then
                'ModalPopupExtender2.Hide() 'no hace falta hacer .hide(), al hacer postback el popup desaparece

                'cargo el seleccionado en pantalla 
                '-pero no te va a servir así, vas a tener que copiar todo el objeto salvo el id, porque 
                'aunque EditarSetup cargue en pantalla lo que vos querés, todavía va a andar dando vueltas
                'en el viewstate el mismo objeto que cargaste, en lugar de uno nuevo
                '-Y no puedo hacer que para crear una copia, cargue el manager igual, y que le ponga -1 al Id?, o que
                'por lo menos el objeto tenga esa posibilidad?
                '-Pero sí puedo cambiar el ID!!!
                'ah, bueno... no debería.....

                'EditarSetup(IdSeleccionado)
            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.ToString)
            Exit Sub
        End Try
    End Sub

    Protected Sub gvAuxOCsPendientes_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvAuxOCsPendientes.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Return
            'Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", gvAuxOCsPendientes)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            ''gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            'ObjectDataSource3.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "IdFactura")
            'Try
            '    gp.DataSource = ObjectDataSource3.Select
            '    gp.DataBind()
            'Catch ex As Exception
            '    'Debug.Print(ex.ToString)
            '    Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
            'Finally
            'End Try
            'gp.Width = 200

        End If
    End Sub

    Sub ImputoItemARemito(ByVal IdDetalleFactura)
        'restauro el objeto a partir del viewstate
        Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        With gvAuxRemitosPendientes
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


                        'Dim idOC As Integer = .DataKeys(fila.RowIndex).Values.Item("IdOrdenCompra")
                        'Dim oOC As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idOC, True)
                        Dim oDetREM As OrdenCompraItem
                        Dim idDetOC As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleRemito")
                        'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)


                        '///////////////////////////////////////////////////////////
                        'Si copio de varios RMs, de cual copio los datos de encabezado, 
                        'myPresupuesto.IdPlazoEntrega=oRM.
                        'myPresupuesto.Validez=oRM.
                        'oDetRM.Id
                        '///////////////////////////////////////////////////////////


                        '///////////////////////////////////////////////////////////
                        'lo pongo en la solicitud  
                        'migrado de frmPresupuesto.Lista.OLEDragDrop()
                        '///////////////////////////////////////////////////////////

                        'me fijo si ya existe en el detalle
                        If myFactura.DetallesRemitos.Find(Function(obj As FacturaRemitosItem) obj.IdDetalleRemito = idDetOC) Is Nothing Then

                            Dim mItem As FacturaRemitosItem = New Pronto.ERP.BO.FacturaRemitosItem

                            With mItem
                                .Id = myFactura.DetallesRemitos.Count
                                .Nuevo = True
                                .IdDetalleFactura = IdDetalleFactura
                                .IdDetalleRemito = idDetOC



                            End With

                            myFactura.DetallesRemitos.Add(mItem)



                        Else
                            MsgBoxAjax(Me, "El renglon de requerimiento " & idDetOC & " ya está en el detalle")
                        End If


                    End If
                End If
            Next
        End With


        Me.ViewState.Add(mKey, myFactura)
        GridView1.DataSource = myFactura.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()

        ModalPopupExtender2.Hide()

    End Sub


    Protected Sub gvAuxOCsPendientes_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvAuxOCsPendientes.SelectedIndexChanged


        'Dim IdSeleccionado As Integer

        ''Dim fila As GridViewRow = gvAuxRemitosPendientes.SelectedRow
        'If IsNothing(gvAuxOCsPendientes.SelectedDataKey) Then
        '    'no seleccionó nada
        '    ModalPopupExtender2.Hide()
        '    Return
        'End If

        'Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)
        'IdSeleccionado = Convert.ToInt32(gvAuxOCsPendientes.SelectedDataKey.Value)


        With gvAuxOCsPendientes.SelectedDataKey.Values


            txtCodigo.Text = ArticuloManager.GetItem(SC, .Item("IdArticulo")).Codigo
            SelectedAutoCompleteIDArticulo.Value = .Item("IdArticulo")
            txt_AC_Articulo.Text = .Item("Articulo")
            'BuscaIDEnCombo(cmbDetUnidades, .IdUnidad)
            'txtDetFechaEntrega.Text = .FechaEntrega
            'txtCodigo.Text = .Detalles(mIdItem).CodigoCuenta
            txtDetCantidad.Text = .Item("Cant_")
            txtDetPrecioUnitario.Text = .Item("Precio")
            txtDetCosto.Text = .Item("Precio")

            If InStr(.Item("Pendfacturar"), "%") Then
                'es item de certificacion
                RadioButtonListFormaCancelacion.SelectedValue = 2
                txtPorcentajeCertificacion.Text = Val(.Item("Pendfacturar").ToString.Replace("%", ""))
                txtDetPrecioUnitario.Text = .Item("Precio") * Val(txtPorcentajeCertificacion.Text) / 100
            Else
                'es por cantidad
                RadioButtonListFormaCancelacion.SelectedValue = 1
                txtPorcentajeCertificacion.Text = "0"
            End If



            'txtDetIVA.Text = DecimalToString(._PorcentajeIVA)
            'txtDetBonif.Text = DecimalToString(._PorcentajeBonificacion)
            'txtPorcentajeCertificacion.Text = DecimalToString(.PorcentajeCertificacion)

            'Try
            '    RadioButtonListFormaCancelacion.SelectedValue = .TipoCancelacion
            'Catch ex As Exception
            '    RadioButtonListFormaCancelacion.Items(0).Selected = True
            'End Try
        End With
    End Sub

    Sub ImputoItemAOrdenCompra(ByVal IdDetalleFactura)
        Dim IdSeleccionado As Integer

        'Dim fila As GridViewRow = gvAuxRemitosPendientes.SelectedRow
        If IsNothing(gvAuxOCsPendientes.SelectedDataKey) Then
            'no seleccionó nada
            ModalPopupExtender2.Hide()
            Return
        End If


        Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

        IdSeleccionado = Convert.ToInt32(gvAuxOCsPendientes.SelectedDataKey.Value)

        With myFactura

            'agrego una imputacion a la OC elegida
            Dim oDetOC As New FacturaOrdenesCompraItem
            If Not .Id = -1 Then .DetallesOrdenesCompra.Clear()

            With oDetOC
                .IdDetalleFactura = IdDetalleFactura
                .IdDetalleOrdenCompra = gvAuxOCsPendientes.SelectedDataKey.Values.Item("IdDetalleOrdenCompra")

                .PorcentajeCertificacion = StringToDecimal(txtPorcentajeCertificacion.Text)
                .ImporteTotalItem = StringToDecimal(txtDetTotal.Text)

                .Nuevo = True
            End With
            .DetallesOrdenesCompra.Add(oDetOC)
        End With

    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        'copio la solicitud elegida
        'ImputoItemAOrdenCompra()
    End Sub


    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        'boton de cierre de grilla popup de copia de solicitudes
        ModalPopupExtender2.Hide()
    End Sub


    '2 metodos para seleccionar el renglon de la grilla de popup sin hacer postback

    'http://www.codeproject.com/KB/grid/GridViewRowColor.aspx?msg=2732537
    'Protected Sub gvAuxOCsPendientes_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) _
    'Handles gvAuxOCsPendientes.RowDataBound
    'If (e.Row.RowType = DataControlRowType.DataRow) Then
    ' e.Row.Attributes.Add("onclick", "javascript:ChangeRowColor('" & e.Row.ClientID & "')")
    ' End If
    'End Sub


    ''http://www.dotnetcurry.com/ShowArticle.aspx?ID=123&AspxAutoDetectCookieSupport=1
    'Protected Sub gvAuxOCsPendientes_RowCreated(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles gvAuxOCsPendientes.RowCreated
    '    e.Row.Attributes.Add("onMouseOver", "this.style.background='#eeff00'")
    '    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'")
    'End Sub


    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////



    Protected Sub TextBox3_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox3.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset

        'odsOCsPendientes.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & TextBox3.Text & "*'" _
        '                                     & " OR " & _
        '                                     "Convert(Proveedor, 'System.String') LIKE '*" & TextBox3.Text & "*'"

        odsOCsPendientes.Select()
        gvAuxOCsPendientes.DataBind()
        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    Protected Sub txtNumeroFactura2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroFactura2.TextChanged
        'txtNumeroFactura1.Text = FacturaManager.ProximoSubNumero(SC, txtNumeroFactura2.Text)
    End Sub

    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        Dim output As String
        'output = ImprimirWordDOT("Factura_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdFactura)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa


        Try
            Kill(System.IO.Path.GetTempPath & "*.txt")
            Kill(System.IO.Path.GetTempPath & "*.doc")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try




        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1


        'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
        'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
        'llamada a Emision desde el Excel del servidor y ver donde explota.
        '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
        '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!
        '-Por ahora usá la de FontanaNicastro, que no tiene controlcito para codigo de barras
        'Dim p = "Factura_A_FontanaNicastro.dot" '"Factura.dot"   "Factura_PRONTO.dot"
        Dim p = DirApp() & "\Documentos\" & "Factura_Williams.dot"


        Try
            ' output = ImprimirWordDOT(p, Me, HFSC.Value, Session, Response, IdFactura, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Factura.doc")
            output = ImprimirWordDOTyGenerarTambienTXT(p, Me, HFSC.Value, Session, Response, IdFactura, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Fact_" & IdFactura & ".doc")
            'output = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir.doc"
            If output = "" Then
                CartaDePorteManager.MandarMailDeError("Error al generar la impresión. Se ha enviado un mail al administrador del sistema")
                ErrHandler2.WriteError("Error al generar la impresión. Se ha enviado un mail al administrador del sistema")
                MsgBoxAjax(Me, "Error al generar la impresión. Se ha enviado un mail al administrador del sistema")
                Exit Sub
            End If

            output = output & ".prontotxt"





            Dim incluirtarifa = IIf(ClienteManager.GetItem(SC, BuscaIdClientePreciso(txtAutocompleteCliente.Text, SC)).IncluyeTarifaEnFactura = "SI", True, False)
            ImpresoraMatrizDePuntosEPSONTexto.WilliamsFacturaWordToTxtMasMergeOpcional(System.IO.Path.GetTempPath, output, , SC, IdFactura) ' incluirtarifa

        Catch ex As System.Runtime.InteropServices.COMException
            'If ex.ToString = "No se puede abrir el almacenamiento de macros." Then
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")

            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala (NO DESDE SU EQUIPO, sino en el servidor o por terminal), pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala, pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        End Try







        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnAceptaDevolucion)
                Response.TransmitFile(output)
                Response.End()
            Else
                'MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'No se puede abrir el almacenamiento de macros
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'Return
        End Try

    End Sub





    Protected Sub btnAnular_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnular.Click
        ModalPopupAnular.Show()
    End Sub



    Protected Sub btnAnularOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAnularOk.Click




        Dim bPassOK = False
        Dim usuario = cmbUsuarioAnulo.Items(cmbUsuarioAnulo.SelectedIndex).Text
        'password de WEB
        bPassOK = Membership.ValidateUser(usuario, txtAnularPassword.Text)


        Dim IdUsuario = BuscaIdEmpleadoPreciso(usuario, SC)

        If Not bPassOK Then

            'password de pronto
            If txtAnularPassword.Text = ProntoPasswordSegunIdEmpleado(SC, IdUsuario) Then bPassOK = True
        End If




        If bPassOK Then

            Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

            If Not chkLiberarCDPs.Checked Then
                myFactura.Observaciones = " -- NO LIBERAR CDPS -- " & myFactura.Observaciones
                EntidadManager.ExecDinamico(SC, "UPDATE FACTURAS SET Observaciones='" & myFactura.Observaciones & "' WHERE IdFactura=" & myFactura.Id)
            End If

            Try
                FacturaManager.AnularFactura(SC, myFactura, IdUsuario)
            Catch ex As Exception
                MandarMailDeError("Se intentó anular la factura y el ComPronto tiró error IdFactura=" & myFactura.Id)
            End Try



            'Me.ViewState.Add(mKey, myFactura) 'guardo en el viewstate el objeto
            'FacturaManager.Save(SC, myFactura)


            Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            'BloqueosDeEdicion(myRequerimiento)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If
    End Sub


    Protected Sub txtAutocompleteCliente_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAutocompleteCliente.TextChanged
        TraerDatosCliente(BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value))
    End Sub

    Private Sub MostrarDatos(ByVal Index As Integer)

        'Dim mvarLocalidad As Integer, mvarZona As Integer, mvarVendedor As Integer
        'Dim mvarTransportista As Integer, mvarProvincia As Integer, mvarTipoVentaC As Integer
        'Dim mvarCondicionVenta As Integer, mvarIdIBCondicion As Integer
        'Dim mvarIdIBCondicion2 As Integer, mvarIdIBCondicion3 As Integer
        'Dim mSeguro As Integer
        'Dim Cambio As Boolean
        'Dim oRs As adodb.Recordset

        '' Cargo los datos del Cliente

        'If mvarIdCliente <> dcfields(0).BoundText Then
        '    Cambio = True
        '    mvarIdCliente = dcfields(0).BoundText
        'Else
        '    Cambio = False
        'End If

        'oRs = Aplicacion.Clientes.TraerFiltrado("_PorId", dcfields(0).BoundText)
        'With oRs
        '    txtCodigoCliente.Text = IIf(IsNull(.Fields("Codigo").Value), "", .Fields("Codigo").Value)
        '    txtDireccion.Text = IIf(IsNull(.Fields("Direccion").Value), "", .Fields("Direccion").Value)
        '    txtCodigoPostal.Text = IIf(IsNull(.Fields("CodigoPostal").Value), "", .Fields("CodigoPostal").Value)
        '    txtCuit.Text = IIf(IsNull(.Fields("Cuit").Value), "", .Fields("Cuit").Value)
        '    txtTelefono.Text = IIf(IsNull(.Fields("Telefono").Value), "", .Fields("Telefono").Value)
        '    txtFax.Text = IIf(IsNull(.Fields("Fax").Value), "", .Fields("Fax").Value)
        '    txtEmail.Text = IIf(IsNull(.Fields("Email").Value), "", .Fields("Email").Value)
        '    '      txtConsignatario.Text = IIf(IsNull(.Fields("Consignatario").Value), "", .Fields("Consignatario").Value)
        '    mvarLocalidad = IIf(IsNull(.Fields("IdLocalidad").Value), 0, .Fields("IdLocalidad").Value)
        '    '      mvarZona = IIf(IsNull(oRs.Fields("IdZona").Value), 0, oRs.Fields("IdZona").Value)
        '    mvarZona = 0
        '    mvarProvincia = IIf(IsNull(.Fields("IdProvincia").Value), 0, .Fields("IdProvincia").Value)
        '    '      mvarIBrutosC = .Fields("CodigoRetencionIBC").Value
        '    '      mvarIBrutosB = .Fields("CodigoRetencionIBB").Value
        '    '      mvarMultilateral = .Fields("EnConvenioMultilateral").Value
        '    mvarTipoIVA = IIf(IsNull(.Fields("IdCodigoIva").Value), 0, .Fields("IdCodigoIva").Value)
        '    mvarCondicionVenta = IIf(IsNull(.Fields("IdCondicionVenta").Value), 0, .Fields("IdCondicionVenta").Value)
        '    mvarIBCondicion = IIf(IsNull(.Fields("IBCondicion").Value), 1, .Fields("IBCondicion").Value)
        '    mvarIdIBCondicion = IIf(IsNull(.Fields("IdIBCondicionPorDefecto").Value), 0, .Fields("IdIBCondicionPorDefecto").Value)
        '    mvarIdIBCondicion2 = IIf(IsNull(.Fields("IdIBCondicionPorDefecto2").Value), 0, .Fields("IdIBCondicionPorDefecto2").Value)
        '    mvarIdIBCondicion3 = IIf(IsNull(.Fields("IdIBCondicionPorDefecto3").Value), 0, .Fields("IdIBCondicionPorDefecto3").Value)
        '    mvarEsAgenteRetencionIVA = IIf(IsNull(.Fields("EsAgenteRetencionIVA").Value), "NO", .Fields("EsAgenteRetencionIVA").Value)
        '    mvarPorcentajePercepcionIVA = IIf(IsNull(.Fields("PorcentajePercepcionIVA").Value), 0, .Fields("PorcentajePercepcionIVA").Value)
        '    mvarBaseMinimaParaPercepcionIVA = IIf(IsNull(.Fields("BaseMinimaParaPercepcionIVA").Value), 0, .Fields("BaseMinimaParaPercepcionIVA").Value)
        '    mAlicuotaDirecta = IIf(IsNull(.Fields("PorcentajeIBDirecto").Value), 0, .Fields("PorcentajeIBDirecto").Value)
        '    mFechaInicioVigenciaIBDirecto = IIf(IsNull(.Fields("FechaInicioVigenciaIBDirecto").Value), 0, .Fields("FechaInicioVigenciaIBDirecto").Value)
        '    mFechaFinVigenciaIBDirecto = IIf(IsNull(.Fields("FechaFinVigenciaIBDirecto").Value), 0, .Fields("FechaFinVigenciaIBDirecto").Value)
        '    If Not IsNull(.Fields("IdListaPrecios").Value) And mvarId <= 0 And Not mvarFijarDatos Then 'And Len(dcfields(7).Text) = 0 Then
        '        dcfields(7).BoundText = .Fields("IdListaPrecios").Value
        '    End If
        'End With

        'If Cambio Then
        '    mvarVendedor = IIf(IsNull(oRs.Fields("Vendedor1").Value), 0, oRs.Fields("Vendedor1").Value)
        '    '      mvarTransportista = oRs.Fields("CodigoTransportista1").Value
        '    '      mvarCondicionVenta = oRs.Fields("IdCondicionVenta").Value
        'Else
        '    mvarVendedor = IIf(IsNull(origen.Registro.Fields("IdVendedor").Value), 0, origen.Registro.Fields("IdVendedor").Value)
        '    mvarTransportista = IIf(IsNull(origen.Registro.Fields("Idtransportista1").Value), 0, origen.Registro.Fields("Idtransportista1").Value)
        'End If

        'oRs.Close()

        'With origen.Registro
        '    .Fields("IdVendedor").Value = mvarVendedor
        '    If mvarId < 0 Then
        '        If Not IsNull(.Fields("IdCondicionVenta").Value) Then
        '            If .Fields("IdCondicionVenta").Value <> mvarCondicionVenta Then
        '                mSeguro = MsgBox("La condicion de venta del cliente es diferente a la actual," & vbCrLf & _
        '                                  "desea poner la del cliente?", vbYesNo, "Cambio de condicion de venta")
        '                If mSeguro = vbYes Then .Fields("IdCondicionVenta").Value = mvarCondicionVenta
        '            End If
        '        Else
        '            .Fields("IdCondicionVenta").Value = mvarCondicionVenta
        '        End If
        '        '         .Fields(dcfields(5).DataField).Value = mvarProvincia
        '        If mvarIBCondicion = 1 Or mvarIBCondicion = 4 Or (mvarId < 0 And mvarPercepcionIIBB <> "SI") Then
        '            dcfields(4).Enabled = False
        '            dcfields(5).Enabled = False
        '            dcfields(6).Enabled = False
        '            .Fields("IdIBCondicion").Value = Null
        '            .Fields("IdIBCondicion2").Value = Null
        '            .Fields("IdIBCondicion3").Value = Null
        '            With Check1(0)
        '                .Value = 0
        '                .Enabled = False
        '            End With
        '            With Check1(1)
        '                .Value = 0
        '                .Enabled = False
        '            End With
        '            With Check1(2)
        '                .Value = 0
        '                .Enabled = False
        '            End With
        '        Else
        '            Check1(0).Enabled = True
        '            If IsNull(.Fields("IdIBCondicion").Value) Then
        '                .Fields("IdIBCondicion").Value = mvarIdIBCondicion
        '                If mvarIdIBCondicion <> 0 Then Check1(0).Value = 1
        '            End If
        '            If Check1(0).Value = 1 Then dcfields(4).Enabled = True Else dcfields(4).Enabled = False
        '            Check1(1).Enabled = True
        '            If IsNull(.Fields("IdIBCondicion2").Value) And mvarIdIBCondicion2 <> 0 Then
        '                .Fields("IdIBCondicion2").Value = mvarIdIBCondicion2
        '                If mvarIdIBCondicion2 <> 0 Then Check1(1).Value = 1
        '            End If
        '            If Check1(1).Value = 1 Then dcfields(5).Enabled = True Else dcfields(5).Enabled = False
        '            Check1(2).Enabled = True
        '            If IsNull(.Fields("IdIBCondicion3").Value) And mvarIdIBCondicion3 <> 0 Then
        '                .Fields("IdIBCondicion3").Value = mvarIdIBCondicion3
        '                If mvarIdIBCondicion3 <> 0 Then Check1(2).Value = 1
        '            End If
        '            If Check1(2).Value = 1 Then dcfields(6).Enabled = True Else dcfields(6).Enabled = False
        '        End If
        '    End If
        'End With

        'oRs = Aplicacion.Localidades.TraerFiltrado("_PorId", mvarLocalidad)
        'If oRs.RecordCount > 0 Then txtLocalidad.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
        'oRs.Close()

        'oRs = Aplicacion.Provincias.TraerFiltrado("_PorId", mvarProvincia)
        'If oRs.RecordCount > 0 Then txtProvincia.Text = IIf(IsNull(oRs.Fields("Nombre").Value), "", oRs.Fields("Nombre").Value)
        'oRs.Close()

        'oRs = Aplicacion.TablasGenerales.TraerFiltrado("DescripcionIva", "_PorId", mvarTipoIVA)
        'If oRs.RecordCount > 0 Then txtCondicionIva.Text = IIf(IsNull(oRs.Fields("Descripcion").Value), "", oRs.Fields("Descripcion").Value)
        'oRs.Close()

        'If EstadoEntidad("Clientes", mvarIdCliente) = "INACTIVO" Then
        '    MsgBox("Cliente inhabilitado, no podra registrar este comprobante", vbExclamation)
        'End If

        ''   If Not IsNull(origen.Registro.Fields("IdPedido").Value) Then
        ''      Set oRs = oAp.Pedidos.Item(origen.Registro.Fields("IdPedido").Value).Registro
        ''      txtNumeroPedido.Text = "Nro. " & oRs.Fields("NumeroPedido").Value & " del " & oRs.Fields("FechaPedido").Value
        ''      oRs.Close
        ''   End If

        'oRs = Nothing

        'If mvarId > 0 Then txtNumeroFactura.Text = origen.Registro.Fields("NumeroFactura").Value

        'CalculaFactura()

    End Sub



    '///////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////
    'Devolucion de anticipos
    '///////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub LinkButton10_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton10.Click
        If mvarIdRubroDevolucionAnticipos() = 0 Then
            MsgBoxAjax(Me, "No está definido el rubro de anticipos (Parametros->Datos Generales 1->Ventas: Anticipos y devolucion de anticipos)")
            '            update(parametros2)
            '            valor = 59
            '           where campo='IdRubroDevolucionAnticipos'

        Else
            ModalPopupExtender5.Show()
        End If


    End Sub

    Protected Sub btnAceptaDevolucion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAceptaDevolucion.Click
        AgregarDevolucionAnticipo()
    End Sub


    Public Sub AgregarDevolucionAnticipo() 'funcion original de ProntoVB6

        Dim mEsta As Boolean, mOk As Boolean
        Dim s As String
        Dim mIdArticulo As Long, mIdDetalleOrdenCompra As Long, mIdDetFac As Long
        Dim mImporte As Double, mPorcentajeCertificacion As Single
        Dim oDetOC As FacturaOrdenesCompraItem

        Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)

        mEsta = False
        If mEsta Then Exit Sub


        mIdDetalleOrdenCompra = 0

        Dim DetallesOrdenesCompraTemp As New FacturaOrdenesCompraItemList

        If myFactura.DetallesOrdenesCompra.Count = 0 Then
            MsgBoxAjax(Me, "No hay imputaciones contra ordenes de compra")
            Return
        End If
        For Each i As FacturaOrdenesCompraItem In myFactura.DetallesOrdenesCompra
            With i
                If Not .Eliminado Then
                    mIdDetalleOrdenCompra = .IdDetalleOrdenCompra

                    mImporte = 0
                    mPorcentajeCertificacion = 0
                    Dim oRs = FacturaManager.GetListTX(SC, "_DevolucionAnticipo", mIdDetalleOrdenCompra)
                    If oRs.Tables(0).Rows.Count > 0 Then
                        mImporte = iisNull(oRs.Tables(0).Rows(0).Item("Importe"), 0)
                        mPorcentajeCertificacion = iisNull(oRs.Tables(0).Rows(0).Item("PorcentajeCertificacion"), 0)
                    End If


                    'creo el item de devolucion a la factura
                    Dim mItem As FacturaItem = New Pronto.ERP.BO.FacturaItem
                    With mItem
                        .Id = myFactura.Detalles.Count
                        .Nuevo = True

                        .IdArticulo = cmbArticulosDevolucion.SelectedValue
                        Dim oArt = ArticuloManager.GetItem(SC, .IdArticulo)
                        .Articulo = oArt.Descripcion
                        .IdUnidad = oArt.IdUnidad
                        .Unidad = EntidadManager.NombreUnidad(SC, oArt.IdUnidad)
                        .Cantidad = -1
                        .PorcentajeCertificacion = mPorcentajeCertificacion * Val(txtPorcentajeDevolucionAnticipo.Text) / 100 * -1
                        .Precio = mImporte * Val(txtPorcentajeDevolucionAnticipo.Text) / 100
                        .ImporteTotalItem = .Precio * .Cantidad
                        mIdDetFac = .Id
                    End With
                    myFactura.Detalles.Add(mItem)


                    'Creo la imputacion en la coleccion detalle de OC.
                    'Las agrego a una coleccion temporal, porque tengo que agregarlas a la misma coleccion
                    'donde estoy haciendo el for each
                    oDetOC = New FacturaOrdenesCompraItem
                    With oDetOC
                        .Nuevo = True
                        .IdDetalleFactura = mIdDetFac
                        .Id = mIdDetalleOrdenCompra
                    End With
                    DetallesOrdenesCompraTemp.Add(oDetOC)


                End If
            End With

        Next

        For Each i In DetallesOrdenesCompraTemp
            myFactura.DetallesOrdenesCompra.Add(i)
        Next

        RecalcularTotalComprobante()


        Me.ViewState.Add(mKey, myFactura)
        GridView1.DataSource = myFactura.Detalles
        GridView1.DataBind()

        UpdatePanelGrilla.Update()

    End Sub


    Protected Sub txtPorcentajeCertificacion_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPorcentajeCertificacion.TextChanged
        'ClientIDSetfocus = sender.ClientID

        Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleFactura"), Integer)
        Dim myFactura As Pronto.ERP.BO.Factura = CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura)
        Dim precio As Double

        If mIdItem = -1 Then
            If Not IsNothing(gvAuxOCsPendientes.SelectedDataKey) Then
                precio = gvAuxOCsPendientes.SelectedDataKey.Values.Item("Precio")
            End If
        Else
            precio = myFactura.Detalles(mIdItem).Precio 'vuelvo a poner el original, así puedo recalcular el nuevo porcertanje ingresado a partir del original, y no de alguno que hayan modificado
        End If

        If IsNumeric(txtPorcentajeCertificacion.Text) Then
            txtDetPrecioUnitario.Text = precio * Val(txtPorcentajeCertificacion.Text) / 100
        End If
        txtDetCosto.Text = precio
    End Sub

    Protected Sub cmbCategoriaIIBB1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCategoriaIIBB1.SelectedIndexChanged
        RecalcularTotalComprobante()
    End Sub


    Protected Sub cmbFiltrarRemitosPendientes_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbFiltrarRemitosPendientes.SelectedIndexChanged
        If cmbFiltrarRemitosPendientes.Text = "Los de la orden" Then
            If Not gvAuxOCsPendientes.SelectedDataKey Is Nothing AndAlso IsNumeric(gvAuxOCsPendientes.SelectedDataKey.Values.Item("IdDetalleOrdenCompra")) Then
                'uso el sp de los remitos pendientes de la orden especifica. Lo hago a lo macho

                Dim idDetOC = gvAuxOCsPendientes.SelectedDataKey.Values.Item("IdDetalleOrdenCompra")
                Dim idOC = EntidadManager.ExecDinamico(HFSC.Value, "SELECT IdOrdenCompra FROM DetalleOrdenesCompra WHERE idDetalleOrdenCompra=" & idDetOC).Rows(0).Item(0)

                Try
                    With gvAuxRemitosPendientes
                        .DataSourceID = ""

                        Dim dt As Data.DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, "Remitos_TX_DetallesPendientesDeFacturarPorIdDetalleOrdenCompra", idDetOC)
                        With dt
                            Dim dc As New Data.DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
                            With dc
                                .ColumnName = "ColumnaTilde"
                                .DataType = System.Type.GetType("System.Int32")
                                .DefaultValue = 0
                            End With
                            .Columns.Add(dc)
                            '.Columns("IdFactura").ColumnName = "Id"
                        End With


                        .DataSource = dt
                        .DataBind()
                    End With

                Catch ex As Exception

                End Try

            Else

                With gvAuxRemitosPendientes
                    .DataSourceID = Nothing
                    .DataSource = Nothing
                    .DataBind()
                End With


            End If

        Else
            'uso el sp de todos los remitos pendientes, usando el ODS
            gvAuxRemitosPendientes.DataSource = Nothing
            gvAuxRemitosPendientes.DataSourceID = "odsRemitosPendientes"
            odsRemitosPendientes.Select()
            gvAuxRemitosPendientes.DataBind()
        End If
    End Sub

    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
        Try
            RefrescarNumeroTalonario()
        Catch ex As Exception

        End Try
    End Sub








    Protected Sub btnDescargaAdjuntosDeFacturacionWilliams_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDescargaAdjuntosDeFacturacionWilliams.Click

        Dim output As String

        output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON(SC, IdFactura, "", ReporteLocal)


        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub



    Protected Sub btnDescargaAdjuntosDeFacturacionWilliamsA4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDescargaAdjuntosDeFacturacionWilliamsA4.Click

        Dim output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON_A4(SC, IdFactura, "", ReporteLocal)

        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub

    Protected Sub btnDescargaAdjuntosDeFacturacionWilliamsFormatoAcondicionadoras_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDescargaAdjuntosDeFacturacionWilliamsFormatoAcondicionadoras.Click

        Dim output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsAcondicionadorasEPSON(SC, IdFactura, ReporteLocal, "")

        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub

    Protected Sub btnInformeAdjuntoDeFacturacionWilliamsExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button6.Click

        Dim output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel(SC, IdFactura, "", ReporteLocal)

        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub


    Protected Sub btnEnvioMailAdjuntosWilliams_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnvioMailAdjuntosWilliams.Click

        'Cómo se mandan por correo?
        Dim output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel(SC, IdFactura, "", ReporteLocal)


        Try
            Dim destinatario As String
            Dim cuerpo As String

            destinatario = txtDireccionMailAdjuntoWilliams.Text


            '#8637	     Correos de adjuntos, enviar con copia al usuario
            CartaDePorteManager.EnviarEmailDeAdjuntosDeWilliams(HFSC.Value, IdFactura, output, destinatario, iisNull(UsuarioSesion.Mail(HFSC.Value, Session)))



            'EnviarEmail(destinatario, "Adjunto de facturación", "", _
            '        ConfigurationManager.AppSettings("SmtpUser"), _
            '        ConfigurationManager.AppSettings("SmtpServer"), _
            '        ConfigurationManager.AppSettings("SmtpUser"), _
            '        ConfigurationManager.AppSettings("SmtpPass"), _
            '         output, _
            '        ConfigurationManager.AppSettings("SmtpPort"), , iisNull(UsuarioSesion.Mail(HFSC.Value, Session)), , "Williams Entregas")


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


    End Sub








    Protected Sub LinkImprimirXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimirXML.Click
        'BuscarClaveINI("Pedir autorizacion para reimprimir RM") = SI
        Dim output As String = DirApp() & "\Documentos\" & "archivo.docx"
        'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
        Dim MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
        If MyFile1.Exists Then
            MyFile1.Delete()
        End If



        If False Then
            Dim williams = True

            Dim plantilla As String

            If williams Then
                plantilla = DirApp() & "\Documentos\" & "FacturaNET_Williams.docx"

            Else
                plantilla = OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, HFSC.Value)
            End If



            Try
                System.IO.File.Copy(plantilla, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

            Catch ex As Exception
                MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
                Exit Sub
            End Try

            If (williams) Then
                Try
                    output = CartaDePorteManager.ImprimirFacturaElectronica(Me.IdFactura, False, SC, DirApp)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MsgBoxAjax(Me, ex.Message)
                    Return
                End Try
                'CartaDePorteManager.FacturaXML_DOCX_Williams(output, CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura), HFSC.Value)
            Else
                OpenXML_Pronto.FacturaXML_DOCX(output, CType(Me.ViewState(mKey), Pronto.ERP.BO.Factura), HFSC.Value)
            End If

        Else
            Try
                output = CartaDePorteManager.ImprimirFacturaElectronica(Me.IdFactura, False, SC, DirApp)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                MsgBoxAjax(Me, ex.Message)
                Return
            End Try

            'Dim listaf = New Generic.List(Of Integer)
            'listaf.Add(Me.IdFactura)
            'output = LoteFacturasNET(listaf, "A")
        End If




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

    Protected Sub LinkEditarXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkEditarXML.Click


        'Dim output As String = DirApp() & "\Documentos\" & "FacturaNET_Hawk_Temp.docx"

        'Dim archiv = OpenXML_Pronto.CargarPlantillaDeSQL("Factura A", SC)
        Dim archiv = OpenXML_Pronto.CargarPlantillaDeSQL(OpenXML_Pronto.enumPlantilla.FacturaA, SC)
        Dim output As String = archiv 'DirApp() & "\Documentos\" & archiv


        Dim MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra

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


    Function LoteFacturasNET(ByVal Facturas As Generic.IList(Of Integer), Optional ByVal letra As String = "A", Optional bZíp As Boolean = False) As String

        'Genera las facturas y luego las une

        'EmitirFacturas(1)
        'MergeWorkbooks()


        'MergeWordDocs()

        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1

        Dim output As String
        'output = ImprimirWordDOT("Presupuesto_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdPresupuesto)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa


        Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )

        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Genera las plantillas 
        'Dim p = DirApp() & "\Documentos\" & "FacturaNET_Williams.docx"





        Try
            Kill(System.IO.Path.GetTempPath & "FacturaNET_Numero*.docx")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



        Try

            For Each i In Facturas 'GetListaDeFacturasTildadas()
                ' Dim ofac = ClaseMigrar.GetItemComProntoFactura(HFSC.Value, i, False)
                Dim ofac = FacturaManager.GetItem(HFSC.Value, i, True)


                ssss

                Dim p = DirApp() & "\Documentos\" & PlantillaWilliamsPorPuntoVenta(ofac.PuntoVenta)



                output = System.IO.Path.GetTempPath() & "\" & "FacturaNET_Numero" & ofac.Numero & ".docx"
                'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
                Dim MyFile2 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
                If MyFile2.Exists Then
                    MyFile2.Delete()
                End If

                Try
                    System.IO.File.Copy(p, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

                Catch ex As Exception
                    MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
                    Exit Function
                End Try


                If ofac.TipoFactura = letra Or True Then
                    'output = CartaDePorteManager.FacturaXML_DOCX_Williams(p,  Me, HFSC.Value, Session, Response, i, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Fact_" & i & ".doc")


                    CartaDePorteManager.FacturaXML_DOCX_Williams(output, ofac, HFSC.Value)



                    For n = 2 To CANTIDAD_COPIAS
                        System.IO.File.Copy(output, System.IO.Path.GetTempPath() & "\" & "FacturaNET_Numero" & ofac.Numero & "_" & n & ".docx")
                    Next




                    'Dim outputtxt = output & ".txt"

                    Debug.Print(i)
                End If
            Next



            If IsNothing(output) Then
                MsgBoxAjax(Me, "No se generaron facturas " & letra)
                Exit Function
            End If


        Catch ex As System.Runtime.InteropServices.COMException
            'If ex.ToString = "No se puede abrir el almacenamiento de macros." Then
            'ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            'MsgBoxAjax(Me, "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala (NO DESDE SU EQUIPO, sino en el servidor o por terminal), pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "No se generaron facturas " & ex.ToString)
            Exit Function
        Catch ex As Exception
            'ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            'MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala, pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")

            ErrHandler2.WriteError(ex)
            MsgBoxAlert("No se generaron facturas " & ex.ToString)
            Exit Function
        End Try


        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Hace el rejunte

        'output = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir.doc"
        'Dim outputtxt = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir " & Now.ToString("ddMMMyyyy_HHmmss") & ".doc.prontotxt"

        'output = outputtxt

        'ProntoFuncionesUIWebc()



        Dim wordFiles As String() = Directory.GetFiles(System.IO.Path.GetTempPath(), "FacturaNET_Numero*.docx")

        'stringMerge = RESETEAR & CANCELCONDENSED

        Dim ssss As New Generic.List(Of Byte())


        If False Then
            ' formato html
            Dim wordDoc = DocumentFormat.OpenXml.Packaging.WordprocessingDocument.Open(wordFiles(0), True)
            Dim html = OpenXmlPowerTools.HtmlConverter.ConvertToHtml(wordDoc, New OpenXmlPowerTools.HtmlConverterSettings())
            wordDoc.Dispose()
            output += ".html"
            File.WriteAllText(output, html.ToString())

        ElseIf False Then

            For i = 0 To wordFiles.Length - 1
                ssss.Add(File.ReadAllBytes(wordFiles(i)))
            Next

            'no está solucionado el tema del salto de pagina.  y el uso de AppendPageBreak???
            'Dim a As New OfficeMergeControl.CombineDocs()

            'If True Then
            '    Dim archivofinal = a.OpenAndCombine(ssss)
            '    File.WriteAllBytes(output, archivofinal)
            'Else
            '    Dim archivofinal = a.CreateDocument(ssss) ' no anda bien. los ensarta por el medio
            '    File.WriteAllBytes(output, archivofinal)
            'End If

        ElseIf Not bZíp Then
            output += ".temppronto.docx"
            'If MyFile2.Exists Then
            '    MyFile2.Delete()
            'End If
            KeithRull.Utilities.OfficeInterop.MsWord.Merge_abriendoEnModoNoTemplateYanexando(wordFiles, output, True, "") 'p) '"") 'wordFiles(0))





            'output = wordFiles(0)
            System.IO.File.Copy(output, output + ".temppronto2.docx")
            output += ".temppronto2.docx"
        Else
            'usar novacode.docx

            output = output & ".zip"
            Dim MyFile1 = New FileInfo(output)
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If
            Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(output) 'usando la .NET Zip Library
            For Each s In wordFiles
                zip.AddFile(s, "")
            Next

            zip.Save()



        End If



        Return output



    End Function


    Protected Sub AsyncFileUpload1_UploadedComplete(ByVal sender As Object, ByVal e As AjaxControlToolkit.AsyncFileUploadEventArgs) Handles AsyncFileUpload1.UploadedComplete
        'System.Threading.Thread.Sleep(5000)

        If (AsyncFileUpload1.HasFile) Then
            Try

                Dim nombre = NameOnlyFromFullPath(AsyncFileUpload1.PostedFile.FileName)
                'Dim nombresolo As String = Mid(nombre, nombre.LastIndexOf("\"))
                Randomize()
                Dim nombrenuevo = DIRFTP + Int(Rnd(100000) * 100000).ToString.Replace(".", "") + "_" + nombre
                Session("NombreArchivoSubido") = nombrenuevo

                Dim MyFile1 As New FileInfo(nombrenuevo)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try

                AsyncFileUpload1.SaveAs(nombrenuevo)


                OpenXML_Pronto.GuardarEnSQL(HFSC.Value, "Factura A", nombre, "", nombrenuevo)


                'btnEmpezarImportacion.Visible = True
                'txtFechaArribo.Visible = True
                'panelEquivalencias.Visible = False
                'txtLogErrores.Visible = False
                'txtLogErrores.Text = ""

                'If Not bEligioForzarFormato Then FormatoDelArchivo(nombrenuevo) 'como no lo eligió manualmente, lo puedo cambiar automaticamente si decidió volver a subir otro archivo
                'RefrescarTextosDefault()

            Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
                Throw
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If

    End Sub



    Protected Sub butVerLog_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles butVerLog.Click
        VerLog()
    End Sub

    Protected Sub LinkButton3_Click(sender As Object, e As System.EventArgs) Handles LinkButton3.Click


        Dim texto = FacturaManager.SincroFacturacionAmaggi(HFSC.Value, IdFactura)

        Dim output As String = Path.GetTempPath & "AmaggiFacturacion.csv" 'DirApp() & "\Documentos\" & archiv

        System.IO.File.WriteAllText(output, texto)



        Dim MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra

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





    Protected Sub LinkButton4_Click(sender As Object, e As EventArgs) Handles LinkButton4.Click
        'CDPMailFiltrosManager.EnviarMailFiltroPorId(aaaaa)



        Dim output = CDPMailFiltrosManager.AdjuntosFacturacionCartasImputadas_Excel(IdFactura, SC, ReporteLocal)


        Dim MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra

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


    Protected Sub btnAdjuntosBLD_Click(sender As Object, e As EventArgs) Handles btnAdjuntosBLD.Click


        Dim output As String

        output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel_ParaBLD(SC, IdFactura, "", ReporteLocal)


        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub




    Protected Sub LinkImprimirXMLFactElectronica_Click(sender As Object, e As System.EventArgs) Handles LinkImprimirXMLFactElectronica.Click

        Dim output As String = DirApp() & "\Documentos\" & "archivo.docx"
        'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
        Dim MyFile1 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
        If MyFile1.Exists Then
            MyFile1.Delete()
        End If



        Dim listaf = New Generic.List(Of Integer)
        listaf.Add(Me.IdFactura)
        Try
            output = CartaDePorteManager.ImprimirFacturaElectronica(Me.IdFactura, True, SC, DirApp)
            'LoteFacturasNET(listaf, "A")

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, ex.Message)
            Return
        End Try



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


End Class

