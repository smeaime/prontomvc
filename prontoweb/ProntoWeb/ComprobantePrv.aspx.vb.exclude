Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.ParametroManager
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Linq

Imports CartaDePorteManager



Partial Class ComprobanteProveedorABM
    Inherits System.Web.UI.Page

    Implements IProntoABM




    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Private DIRFTP As String = "C:\"

    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing


    Public Property IdComprobanteProveedor() As Integer
        Get
            Return DirectCast(iisNull(ViewState("IdComprobanteProveedor"), -1), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdComprobanteProveedor") = Value
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
            Me.IdComprobanteProveedor = Convert.ToInt32(Request.QueryString.Get("Id"))
        End If
        mKey = "ComprobanteProveedor_" & Me.IdComprobanteProveedor.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        SC = usuario.StringConnection

        'Cómo puede ser que a veces llegue hasta acá (Page Load de un ABM) y el session(SESSIONPRONTO_USUARIO) está en nothing? Un cookie?
        If usuario Is Nothing Or SC Is Nothing Then
            'debug.print(session(SESSIONPRONTO_UserName))

            'pero si lo hacés así, no vas a poder redirigirlo, porque te quedas sin RequestUrl...
            ' ma sí, le pongo el dato en el session
            'session(SESSIONPRONTO_MiRequestUrl) = Request.Url..AbsoluteUri
            Session(SESSIONPRONTO_MiRequestUrl) = Request.RawUrl.ToLower
            Debug.Print(Session(SESSIONPRONTO_MiRequestUrl))

            'Response.Redirect("~/Login.aspx")
        End If



        If Not Page.IsPostBack Then
            '//////////////////////////////////////////////////////////////////
            'Este pedazo se ejecuta si es la PRIMERA VEZ QUE SE CARGA (es decir, no es un postback)
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '//////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////

            If Cotizacion(SC) = 0 Then
                MsgBoxAjaxAndRedirect(Me, "No hay cotizacion, ingresela primero", String.Format("Cotizaciones.aspx"))
                Exit Sub
            End If




            AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
            AutoCompleteExtender20.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
            AutoCompleteExtender3.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion

            RefrescaDetalleIva()



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
            TextBox1.Text = IdComprobanteProveedor
            BindTypeDropDown()


            Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor
            If IdComprobanteProveedor > 0 Then
                myComprobanteProveedor = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myComprobanteProveedor = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    myComprobanteProveedor = AltaSetup()
                End If
            End If



            Me.ViewState.Add(mKey, myComprobanteProveedor) 'si adentro del myComprobanteProveedor hay un COMPRONTO, va a explotar porque no es serializable



            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")

            'txtDetCantidad.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            'txtDetPrecioUnitario.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            'txtDetBonif.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            'txtDetCosto.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            'txtPorcentajeCertificacion.Attributes.Add("onKeyUp", "jsRecalcularItem()")



            BloqueosDeEdicion(myComprobanteProveedor)



        End If





        '////////////////////////////////

        'RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        'txtRendicion.Enabled = False

        'refresco
        'btnTraerDatos_Click(Nothing, Nothing)

        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

        If ClientIDSetfocus <> "" Then
            'System.Web.UI.ScriptManager.GetCurrent(Me).SetFocus(ClientIDSetfocus)

            SetFocusAjax(Me, ClientIDSetfocus.Replace("$", "_"))


            'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "FocusScript", _
            '                                    "document.getElementById('" + ClientIDSetfocus.Replace("$", "_") + "').focus()", _
            '                                    True)

            ClientIDSetfocus = ""
        End If

    End Sub



    Sub BloqueosDeEdicion(ByVal myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor) Implements IProntoABM.BloqueosDeEdicion


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
            'txtNumeroComprobanteProveedor1.Enabled = False
            txtNumeroComprobanteProveedor2.Enabled = False
            txtFechaComprobante.Enabled = False
            'txtFechaAprobado.Enabled = False
            'txtValidezOferta.Enabled = False
            'txtDetalleCondicionCompra.Enabled = False
            cmbMoneda.Enabled = False
            'cmbPlazo.Enabled = False
            cmbCondicionCompra.Enabled = False
            'cmbPlazo.Enabled = False
            txtObservaciones.Enabled = False
            'txtDescProveedor.Enabled = False
            'txtFechaCierreCompulsa.Enabled = False
            'txtDetalle.Enabled = False
            'txtCodigo.Enabled = False
            'txtTotBonif.Enabled = False



            'detalle
            LinkAgregarRenglon.Enabled = False
            'txt_AC_Articulo.Enabled = False
            'txtDetObservaciones.Enabled = False
            'txtDetTotal.Enabled = False
            '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
            'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
            'txtDetCantidad.Enabled = False
            'txtDetFechaEntrega.Enabled = False



            'links a popups

            LinkAgregarRenglon.Style.Add("visibility", "hidden")
            'LinkButton1.Style.Add("visibility", "hidden")
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
        With myComprobanteProveedor

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

                LinkImprimir.Visible = False 'el comprobante de terceros no se imprime
                btnAnular.Visible = False
                MostrarBotonesParaAdjuntar()


                'If Val(.Aprobo) > 0 Then
                If False Then
                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////

                    DisableControls(Me)
                    LinkImprimir.Enabled = True


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
                    'btnCancelItem.Enabled = True
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////
                    '//////////////////////////////////////////////////




                    'me fijo si está cerrado

                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True
                    btnAnular.Enabled = False
                    btnAnularOk.Enabled = True
                    btnAnularCancel.Enabled = True
                    cmbUsuarioAnulo.Enabled = True
                    txtAnularMotivo.Enabled = True
                    txtAnularPassword.Enabled = True

                    'si es un proveedor, deshabilito la edicion


                    ''habilito el eliminar del renglon
                    'For Each r As GridViewRow In GridView1.Rows
                    '    Dim bt As LinkButton
                    '    'bt = r.FindControl("Elim.")
                    '    bt = r.Controls(4).Controls(0) 'el boton eliminar esta dentro de un control datafield
                    '    If Not bt Is Nothing Then
                    '        'bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '        'bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '    End If
                    'Next

                    'me fijo si está cerrado
                    'DisableControls(Me)
                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'encabezado
                    'txtNumeroComprobanteProveedor1.Enabled = False
                    txtNumeroComprobanteProveedor2.Enabled = False
                    txtFechaComprobante.Enabled = False
                    'txtFechaAprobado.Enabled = False
                    'txtValidezOferta.Enabled = False
                    'txtDetalleCondicionCompra.Enabled = False
                    cmbMoneda.Enabled = False
                    'cmbPlazo.Enabled = False
                    cmbCondicionCompra.Enabled = False
                    'cmbPlazo.Enabled = False
                    txtObservaciones.Enabled = False
                    'txtDescProveedor.Enabled = False
                    'txtFechaCierreCompulsa.Enabled = False
                    'txtDetalle.Enabled = False
                    txtTotBonif.Enabled = False



                    'detalle
                    LinkAgregarRenglon.Enabled = False
                    'txt_AC_Articulo.Enabled = False
                    'txtDetObservaciones.Enabled = False
                    'txtDetTotal.Enabled = False
                    ''5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
                    ''Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
                    'txtDetCantidad.Enabled = False
                    'txtTotBonif.Enabled = False
                    'txtDetFechaEntrega.Enabled = False



                    'links a popups

                    LinkAgregarRenglon.Style.Add("visibility", "hidden")
                    'LinkButton1.Style.Add("visibility", "hidden")
                    LinkButton2.Style.Add("visibility", "hidden")
                    'LinkButton2.Attributes("Visibility") = "Hidden"
                    'LinkButton2.Style.Add("display", "none")

                    'ModalPopupExtender1.Hide()
                    'ModalPopupExtender2.Hide()


                    'links a popups
                    'LinkAgregarRenglon.Style.Add("visibility", "hidden")
                    'LinkButton1.Style.Add("visibility", "hidden")
                    'LinkButton2.Style.Add("visibility", "hidden")

                    MostrarBotonesParaAdjuntar()
                Else
                    'LinkButton1.Enabled = True
                    'LinkButtonPopupDirectoCliente.Enabled = True
                End If

                If False Then 'solo vista
                    btnSave.Visible = False
                    btnAnular.Visible = False
                    btnAnular.Enabled = True
                    btnCancel.Text = "Salir"
                End If

                'If .Anulada = "SI" Then
                '    '////////////////////////////////////////////
                '    'y está ANULADO
                '    '////////////////////////////////////////////
                '    btnAnular.Visible = False
                '    lblAnulado.Visible = True
                '    'lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion '& " por " & .MotivoAnulacion
                '    btnSave.Visible = False
                '    btnCancel.Text = "Salir"
                'End If



            End If
        End With
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////


    End Sub




    Sub AgregarRenglonVacio(ByRef myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)
        With myComprobanteProveedor
            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As ComprobanteProveedorItem = New ComprobanteProveedorItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Eliminado = False
            mItem.Cantidad = 0
            mItem.Cuenta = ""
            ' mItem.Precio = Nothing

            mItem.PorcentajeProvinciaDestino1 = 100
            mItem.IdProvinciaDestino1 = 1


            .Detalles.Add(mItem)
            Rebind(myComprobanteProveedor)
            ''/////////////////////////////////
        End With
    End Sub

    Sub Rebind(ByRef o As Pronto.ERP.BO.ComprobanteProveedor)

        'Dim s = From i As ComprobanteProveedorItem In o.Detalles Order By i.IdCuenta 'i.Eliminado Ascending, i.Id Ascending
        'Dim dt = o.Detalles.ToArray.ToDataTable ' s.ToDataTable '.DefaultView()
        'Dim dv = DataTableORDER(dt, "IdCuenta DESC")
        GridView1.DataSource = o.Detalles
        GridView1.DataBind()
    End Sub






    '////////////////////////////////////////////////////////////////////////////
    '   ALTA SETUP   'preparo la pagina para dar un alta
    '////////////////////////////////////////////////////////////////////////////

    Function AltaSetup() As Pronto.ERP.BO.ComprobanteProveedor


        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = New Pronto.ERP.BO.ComprobanteProveedor
        With myComprobanteProveedor
            .Id = -1


            RefrescarNumeroTalonario()
            txtFechaComprobante.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?
            txtFechaVencimiento.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?
            txtFechaRecepcion.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?

            BuscaTextoEnCombo(cmbTipoComprobante, "FC  Factura compra")
            BuscaTextoEnCombo(cmbMoneda, "PESOS")
            'txtNumeroComprobanteProveedor1.Text = 1


            AgregarRenglonVacio(myComprobanteProveedor)
            AgregarRenglonVacio(myComprobanteProveedor)
            AgregarRenglonVacio(myComprobanteProveedor)
            AgregarRenglonVacio(myComprobanteProveedor)

            ConmutarPanelClienteConPanelCuenta()


            Rebind(myComprobanteProveedor)
            'GridView1.DataSource = .Detalles 'este bind lo copié
            'GridView1.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////



            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If



            txtNumeroReferencia.Text = ParametroManager.ParametroOriginal(SC, ePmOrg.ProximoComprobanteProveedorReferencia)
            'txtFechaComprobanteProveedor.Text = System.DateTime.Now.ToShortDateString()


            ViewState("PaginaTitulo") = "Nuevo Comprobante de Proveedor"
        End With

        Return myComprobanteProveedor
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As Pronto.ERP.BO.ComprobanteProveedor
        'los textbox que no se refresquen ponelos en un UpdatePanel

        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor

        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?
            myComprobanteProveedor = ComprobanteProveedorManager.GetItem(SC, IdComprobanteProveedor, True) 'va a editar ese ID
            'myComprobanteProveedor = ComprobanteProveedorManager.GetItemComPronto(SC, IdComprobanteProveedor, True) 'va a editar ese ID
        Else
            'está haciendo un alta, pero uso los datos de un ID existente
            'myComprobanteProveedor = ComprobanteProveedorManager.GetCopyOfItem(SC, CopiaDeOtroId)
            IdComprobanteProveedor = -1
            'tomar el ultimo de la serie y sumarle uno


            'myComprobanteProveedor.SubNumero = ComprobanteProveedorManager.ProximoSubNumero(SC, myComprobanteProveedor.Numero)

            'limpiar los precios del ComprobanteProveedor original
            For Each i In myComprobanteProveedor.Detalles
                'i.Precio = 0
            Next

            'mKey = "ComprobanteProveedor_" & Me.IdEntity.ToString 'esto es un balurdo. aclarar bien
        End If


        If Not (myComprobanteProveedor Is Nothing) Then
            With myComprobanteProveedor

                ComprobanteProveedorManager.RefrescarDesnormalizados(HFSC.Value, myComprobanteProveedor)

                TraerDatosProveedor(myComprobanteProveedor.IdProveedor)
                RecargarEncabezado(myComprobanteProveedor)


                '/////////////////////////
                '/////////////////////////
                'Grilla
                '/////////////////////////
                '/////////////////////////
                'GridView1.Columns(0).Visible = False
                'GridView1.DataSource = .Detalles 'pero cómo se mantiene esto, si estoy usando un objeto local de la funcion?
                'GridView1.DataBind()

                Rebind(myComprobanteProveedor)





                'Me.Title = "Edición Fondo Fijo " + myComprobanteProveedor.Letra + myComprobanteProveedor.NumeroComprobante1.ToString + myComprobanteProveedor.NumeroComprobante2.ToString
                ViewState("PaginaTitulo") = "Edición Comprobante de Proveedor " + myComprobanteProveedor.Numero.ToString + "/" '+ myComprobanteProveedor.SubNumero.ToString
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
                Me.ViewState.Add(mKey, myComprobanteProveedor)

                'vacío el proveedor (porque es una copia)
                'SelectedReceiver.Value = 0
                'txtDescProveedor.Text = ""
            End If

        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdComprobanteProveedor & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myComprobanteProveedor
    End Function

    Sub RecargarEncabezado(ByVal myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)
        With myComprobanteProveedor

            txtFechaComprobante.Text = .FechaIngreso
            txtFechaVencimiento.Text = .FechaVencimiento
            txtFechaRecepcion.Text = .FechaRecepcion
            txtLetra.Text = .Letra '.TipoABC 
            txtNumeroReferencia.Text = .NumeroReferencia
            'lblLetra.Text = txtLetra.Text
            txtAutocompleteProveedor.Text = EntidadManager.NombreProveedor(SC, .IdProveedor)
            txtAutocompleteCuenta.Text = EntidadManager.NombreCuenta(SC, .IdCuentaOtros)

            'BuscaIDEnCombo(cmbPuntoVenta, .IdPuntoVenta)

            txtNumeroComprobanteProveedor1.Text = .NumeroComprobante1
            txtNumeroComprobanteProveedor2.Text = .NumeroComprobante2



            'txtNumeroCertificadoIIBB.Text = .NumeroCertificadoPercepcionIIBB


            BuscaIDEnCombo(cmbTipoComprobante, .IdTipoComprobante)
            BuscaIDEnCombo(cmbObra, .IdObra)

            If iisNull(.IdProveedor, 0) <> 0 Then
                'de proveedor
                RadioButtonListEsInterna.SelectedValue = 1
            ElseIf iisNull(.IdCuentaOtros, 0) <> 0 Then
                '"otros".  a cuenta
                RadioButtonListEsInterna.SelectedValue = 3
            Else
                'fondo fijo
                'MsgBoxAjax(Me, "Es un fondo fijo")
                'Exit Sub


                'Option2.Value = True
                'If Not IsNull(.Fields("IdOrdenPago").Value) Then
                '    oRs = oAp.OrdenesPago.Item(.Fields("IdOrdenPago").Value).Registro
                '    If oRs.RecordCount > 0 Then
                '        txtOrdenPago.Text = oRs.Fields("NumeroOrdenPago").Value
                '    End If
                '    oRs.Close()
                '    oRs = Nothing
                'End If
            End If
            ConmutarPanelClienteConPanelCuenta()

            RadioButtonBienesOServicios.SelectedValue = .BienesOServicios


            txtAutocompleteCuenta.Text = EntidadManager.NombreCuenta(SC, .IdCuentaOtros)

            BuscaIDEnCombo(cmbCategoriaIIBB1, .IdIBCondicion)
            BuscaIDEnCombo(cmbCategoriaGanancias, .IdTipoRetencionGanancia)

            BuscaIDEnCombo(cmbMoneda, .IdMoneda)
            BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)


            'txtTotal.Text = .total

            txtAjusteIVA.Text = .AjusteIVA



            txtObservaciones.Text = .Observaciones
            chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)


            'pero debiera usar el formato universal...
            'txtTotBonif.Text = String.Format("{0:F2}", DecimalToString(.Bonificacion))
            'txtSubtotal.Text = String.Format("{0:F2}", DecimalToString(.ImporteIva1)) 'o uso {0:c} o {0:F2} ?
            'txtTotal.Text = String.Format("{0:F2}", DecimalToString(.Total))

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

        IniciaCombo(HFSC.Value, cmbTipoComprobante, tipos.TiposComprobanteDeProveedores)





        IniciaCombo(SC, cmbCondicionCompra, tipos.CondicionCompra)


        IniciaCombo(SC, cmbObra, tipos.Obras)
        IniciaCombo(SC, cmbCategoriaIIBB1, tipos.IBCondiciones)
        IniciaCombo(SC, cmbCategoriaGanancias, tipos.TiposRetencionGanancias)
        IniciaCombo(SC, cmbLibero, tipos.Empleados)
        IniciaCombo(SC, cmbCondicionIVA, tipos.CondicionIVA)
        RefrescarTalonariosDisponibles()

        IniciaCombo(SC, cmbUsuarioAnulo, tipos.Empleados)
        IniciaCombo(SC, cmbMoneda, tipos.Monedas)


        'IniciaCombo(SC, cmbDetasienncepto, tipos.Conceptos)
        IniciaCombo(SC, cmbDetCuentaBanco, tipos.CuentasBancarias)
        IniciaCombo(SC, cmbDetCuentaGasto, tipos.CuentasGasto)

        'IniciaCombo(SC, cmbDetAsientoCaja, tipos.Cajas)



        IniciaCombo(SC, cmbDetCuentaGrupo, tipos.TiposCuentaGrupos)



        IniciaCombo(SC, cmbDetObra, tipos.Obras)

        IniciaCombo(SC, cmbDetProvinciaDestino1, tipos.Provincias)
        IniciaCombo(SC, cmbDetProvinciaDestino2, tipos.Provincias)






        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'cmbArticulosDevolucion.DataSource = ArticuloManager.GetListTX(SC, "_PorIdRubroParaCombo", mvarIdRubroDevolucionAnticipos)
        'cmbArticulosDevolucion.DataTextField = "Titulo"
        'cmbArticulosDevolucion.DataValueField = "IdArticulo"
        'cmbArticulosDevolucion.DataBind()

    End Sub

    Function mvarIdRubroDevolucionAnticipos() As Integer
        mvarIdRubroDevolucionAnticipos = 0
        mvarIdRubroDevolucionAnticipos = iisNull(ParametroManager.TraerValorParametro2(SC, "IdRubroDevolucionAnticipos"), 0)
        Return mvarIdRubroDevolucionAnticipos
    End Function


    Function TraerDatosProveedor(ByVal IdProveedor As Long) As Boolean
        Try
            Dim myProveedor = ProveedorManager.GetItem(SC, IdProveedor)
            With myProveedor

                txtCUIT.Text = .Cuit
                BuscaIDEnCombo(cmbCondicionIVA, .IdCodigoIva)
                If cmbCondicionIVA.SelectedValue = -1 Then BuscaIDEnCombo(cmbCondicionIVA, 1) 'por si no encuentra la condicion (me quedaría el combo sin cargar y disabled)

                '///////////////////////////////////////////
                'estos campos solo los debo traer si cambiaron el proveedor explícitamente, y no 
                'en la carga de datos antes de editar -y cómo hago? -bueno, si llamas a la funcion
                'desde el EditarSetup(), que la carga de estos combos venga después
                BuscaIDEnCombo(cmbMoneda, .IdMoneda)
                BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)
                '///////////////////////////////////////////

                'If txtLetra.Text = "" Then
                If .IdCodigoIva = 0 Then
                    txtLetra.Text = "B"  ' y "C"?
                ElseIf .IdCodigoIva = 1 Then
                    txtLetra.Text = "A"
                Else
                    txtLetra.Text = "C"
                End If
                'End If

                txtDireccion.Text = .Direccion
                txtTelefono.Text = .Telefono1

            End With



            If myProveedor.Cuit <> "" Then Return True

        Catch ex As Exception
        End Try


        '////////////////////////////////

        Return False 'no lo encontré



    End Function








    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    Sub RefrescarTalonariosDisponibles()
        'cmbPuntoVenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", EntidadManager.IdTipoComprobante.ComprobanteProveedor, lblLetra.Text.ToUpper)
        'cmbPuntoVenta.DataTextField = "Titulo"
        'cmbPuntoVenta.DataValueField = "IdPuntoVenta"
        'cmbPuntoVenta.DataBind()
        'cmbPuntoVenta.SelectedIndex = 0

        'RefrescarNumeroTalonario()
    End Sub

    Sub RefrescarNumeroTalonario()
        'RESOLVER ESTO (el refresco del talonario por manager)
        'ComprobanteProveedorManager.RefrescarNumeroTalonario()
        'Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

        txtLetra.Text = EntidadManager.LetraSegunTipoIVA(cmbCondicionIVA.SelectedValue)
        lblLetra.Text = txtLetra.Text
        'cmbPuntoVenta.SelectedIndex = 0
        'txtNumeroComprobanteProveedor2.Text = ComprobanteProveedorManager.ProximoNumeroComprobanteProveedorPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.SelectedItem.Text) 'ParametroOriginal(SC, "ProximoComprobanteProveedor")

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

                Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)
                DePaginaHaciaObjeto(myComprobanteProveedor)





                Dim ms As String
                If ComprobanteProveedorManager.IsValid(SC, myComprobanteProveedor, ms) Then
                    Try
                        If ComprobanteProveedorManager.Save(SC, myComprobanteProveedor) = -1 Then
                            MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.ToString)
                    End Try




                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                    IdComprobanteProveedor = myComprobanteProveedor.Id



                    'If myComprobanteProveedor.Numero <> StringToDecimal(txtNumeroComprobanteProveedor2.Text) Then
                    '    EndEditing("La ComprobanteProveedor fue grabada con el número " & myComprobanteProveedor.Numero) 'me voy 
                    'Else

                    'EndEditing("Desea imprimir el comprobante?")
                    EndEditing()
                    'End If

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
                Response.Redirect(String.Format("ComprobantesPrv.aspx"), False)
                Exit Sub
            End If

        Catch ex As Exception
            ErrHandler2.WriteAndRaiseError(ex)
        End Try
    End Sub



    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("ComprobantesPrv.aspx?Imprimir=" & IdComprobanteProveedor))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("ComprobantesPrv.aspx")) 'roundtrip al cuete?
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
    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        AltaItemSetup()
    End Sub


    Sub AltaItemSetup()
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleComprobanteProveedor") = -1
        cmbDetCuentaGrupo.SelectedIndex = 0
        cmbDetCuentaBanco.SelectedIndex = 0
        cmbDetCuentaGasto.SelectedIndex = 0
        cmbDetObra.SelectedIndex = 0
        cmbDetProvinciaDestino1.SelectedIndex = 0
        cmbDetProvinciaDestino2.SelectedIndex = 0
        txtDetAC_Cuenta.Text = ""
        txtDetCodigoCuenta.Text = ""
        txtDetProvinciaPorcentaje1.Text = 100
        txtDetProvinciaPorcentaje2.Text = ""


        txtDetCodigoCuenta.Enabled = True
        txtDetAC_Cuenta.Enabled = True
        cmbDetCuentaGrupo.Enabled = True


        txtDetNumeroPedido.Text = ""
        txtDetNumeroPedidoItem.Text = ""
        txtDetNumeroRecepcion.Text = ""
        txtDetNumeroRequerimiento.Text = ""
        txtDetNumeroRequerimientoItem.Text = ""

        Try
            BuscaIDEnCombo(cmbDetProvinciaDestino1, _
                ProveedorManager.GetItem(HFSC.Value, _
                            BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, HFSC.Value) _
                ).IdProvincia)

        Catch ex As Exception

        End Try


        chkDetIVA1.Checked = False
        chkDetIVA2.Checked = False
        chkDetIVA3.Checked = False
        chkDetIVA4.Checked = False
        chkDetIVA5.Checked = False
        chkDetIVA6.Checked = False
        chkDetIVA7.Checked = False
        chkDetIVA8.Checked = False
        chkDetIVA9.Checked = False
        chkDetIVA10.Checked = False


        chkDetNoIncluirEnIIBBniGanancias.Checked = False
        txtDetImporte.Text = ""



        UpdatePanelDetalle.Update()
        ModalPopupExtender3.Show()


    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'ModalPopupExtender3.Show()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'tachar la linea eliminada
        'http://stackoverflow.com/questions/535769/asp-net-gridview-how-to-strikeout-the-entire-text-in-a-row

        If e.Row.RowIndex Mod 2 = 1 Then
            'e.Row.BackColor = Drawing.Color.Transparent
            e.Row.BackColor = Drawing.Color.White   '&HF7F7F7
        End If

        'Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        If e.Row.RowType = DataControlRowType.DataRow Then 'no es el encabezado
            If e.Row.DataItem.eliminado Then '.item("Eliminado") Then  '.Eliminado Then
                'Las tres columnas de texto (art cant uni)

                'el text decoration es demasiado nuevo, no anda en firefox, es medio buggy
                'e.Row.Cells(0).Style.Value = "text-decoration:line-through;"

                e.Row.Cells(0).Text = "<strike>" + e.Row.Cells(0).Text + "</strike>"
                'e.Row.Cells(1).Text = "<strike>" + e.Row.Cells(1).Text + "</strike>"
                'e.Row.Cells(2).Text = "<strike>" + e.Row.Cells(2).Text + "</strike>"

                'e.Row.FindControl("Eliminar").text = "Restaurar" 'reemplazo el texto del eliminado

                Dim b As LinkButton = e.Row.Cells(3).Controls(0)
                b.Text = "Restaurar" 'reemplazo el texto del eliminado

            End If
        End If








        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion
        If (e.Row.RowType = DataControlRowType.DataRow) Then

            ac = e.Row.FindControl("AutoCompleteExtender200")
            If Not IsNothing(ac) Then
                ac.ContextKey = HFSC.Value
            End If
        End If
    End Sub



    Sub EditarItemSetup(ByRef mIdItem As Long, ByRef myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)

        With myComprobanteProveedor.Detalles(mIdItem)
            'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

            .Eliminado = False

            txtDetCodigoCuenta.Enabled = True
            txtDetAC_Cuenta.Enabled = True
            cmbDetCuentaGrupo.Enabled = True
            cmbDetCuentaGrupo.SelectedIndex = 0

            BuscaIDEnCombo(cmbDetObra, .IdObra)
            txtDetAC_Cuenta.Text = .Cuenta + " " + .CodigoCuenta
            txtDetCodigoCuenta.Text = .CodigoCuenta

            BuscaIDEnCombo(cmbDetCuentaBanco, .IdCuentaBancaria)
            BuscaIDEnCombo(cmbDetCuentaGasto, .IdCuentaGasto)
            txtDetImporte.Text = DecimalToString(.Importe)


            Dim ors1 As DataRow
            If .IdDetalleRecepcion > 0 Then
                ors1 = GetStoreProcedureTop1(HFSC.Value, enumSPs.Recepciones_TX_DatosPorIdDetalleRecepcion, .IdDetalleRecepcion)
                txtDetNumeroRecepcion.Text = iisNull(ors1.Item("NumeroRecepcionAlmacen"))
                txtDetNumeroRequerimiento.Text = iisNull(ors1.Item("NumeroRequerimiento"))
                txtDetNumeroRequerimientoItem.Text = iisNull(ors1.Item("ItemRM"))
                txtDetNumeroPedido.Text = iisNull(ors1.Item("NumeroPedido"))
                txtDetSubnumeroPedido.Text = iisNull(ors1.Item("SubNumero"))
                txtDetNumeroPedidoItem.Text = iisNull(ors1.Item("ItemPedido"))
            ElseIf .IdDetallePedido > 0 Then
                ors1 = GetStoreProcedureTop1(HFSC.Value, enumSPs.Pedidos_TX_DatosPorIdDetalle, .IdDetallePedido)
                txtDetNumeroPedido.Text = iisNull(ors1.Item("NumeroPedido"))
                txtDetSubnumeroPedido.Text = iisNull(ors1.Item("SubNumero"))
                txtDetNumeroPedidoItem.Text = iisNull(ors1.Item("IP"))
            ElseIf .IdPedido > 0 Then
                ors1 = GetStoreProcedureTop1(HFSC.Value, enumSPs.Pedidos_TX_PorId, .IdPedido)
                txtDetNumeroPedido.Text = iisNull(ors1.Item("NumeroPedido"))
                txtDetSubnumeroPedido.Text = iisNull(ors1.Item("SubNumero"))
            End If








            txtDetProvinciaPorcentaje1.Text = .PorcentajeProvinciaDestino1
            txtDetProvinciaPorcentaje2.Text = .PorcentajeProvinciaDestino2


            ProntoCheckSINO(.TomarEnCalculoDeImpuestos, chkDetNoIncluirEnIIBBniGanancias)



            RefrescaDetalleIva()
            For i = 1 To 10
                Dim chk As CheckBox = PanelDetalle.FindControl("chkDetIVA" & i)
                With chk
                    If CallByName(myComprobanteProveedor.Detalles(mIdItem), "AplicarIVA" & i, CallType.Get) = "SI" Then
                        .Checked = True
                    Else
                        .Checked = False
                    End If
                End With
            Next







            Dim oRs As adodb.Recordset
            Dim mAlicuotaIVA_Material As Double, mvarPrecio As Double, mPorcB As Double




        End With



    End Sub






    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

                    'si esta eliminado, lo restaura
                    myComprobanteProveedor.Detalles(mIdItem).Eliminado = Not myComprobanteProveedor.Detalles(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myComprobanteProveedor)
                    'GridView1.DataSource = myComprobanteProveedor.Detalles
                    'GridView1.DataBind()
                    Rebind(myComprobanteProveedor)

                    RecalcularTotalComprobante()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleComprobanteProveedor") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)
                    EditarItemSetup(mIdItem, myComprobanteProveedor)

                    UpdatePanelDetalle.Update()
                    ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                Else
                    'y esto? por si es el renglon vacio?

                    'txtDetCantidad.Text = 1
                    'RadioButtonList1.Items(0).Selected = True
                End If

            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.ToString)
            Exit Sub
        End Try
    End Sub




    Function IsValidItem(ByVal i As ComprobanteProveedorItem, ByRef ms As String) As Boolean
        'este validador tendría que estar en el manager?
        Try
            If txtDetNumeroPedido.Text <> "" Then
                If txtDetNumeroPedidoItem.Text = "" Then
                    i.IdPedido = GetStoreProcedureTop1(HFSC.Value, enumSPs.Pedidos_TX_PorNumero, Val(txtDetNumeroPedido.Text), Val(txtDetSubnumeroPedido.Text), DBNull.Value, DBNull.Value).Item("IdPedido")
                    If i.IdPedido = 0 Then
                        ms = "El pedido no existe, corrijalo o borrelo"
                        Return False
                    End If
                Else
                    i.IdDetallePedido = GetStoreProcedureTop1(HFSC.Value, enumSPs.Pedidos_TX_DetallePorNumeroItem, Val(txtDetNumeroPedido.Text), Val(txtDetSubnumeroPedido.Text), Val(txtDetNumeroPedidoItem.Text), DBNull.Value, DBNull.Value).Item("IdPedido")
                    If i.IdDetallePedido = 0 Then
                        ms = "No se encontro el item " & txtDetNumeroPedidoItem.Text & " del pedido " & txtDetNumeroPedido.Text
                        Return False
                    End If
                End If
            End If
        Catch ex As Exception
            ms = "El pedido no existe, corrijalo o borrelo"
            Return False
            ErrHandler2.WriteError(ex)
            i.IdPedido = 0
            i.IdDetallePedido = 0
        End Try



        If Val(txtDetProvinciaPorcentaje1.Text) + Val(txtDetProvinciaPorcentaje2.Text) <> 100 Then
            ms = "El porcentaje de provincias debe sumar 100"
            Return False
        End If



        Return True
    End Function




    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleComprobanteProveedor"), Integer)
            Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

            'acá tengo que traer el valor id del hidden


            'validar los numeros de remito
            Dim ms As String










            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As ComprobanteProveedorItem = New Pronto.ERP.BO.ComprobanteProveedorItem

                If myComprobanteProveedor.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal (en dinamarca)")
                    Exit Sub
                End If

                mItem.Id = myComprobanteProveedor.Detalles.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myComprobanteProveedor.Detalles.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myComprobanteProveedor.Detalles(mIdItem)

                    .Eliminado = False

                    'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
                    ' de cada valor, como se hace en toda web

                    'ORIGINAL EDU:
                    .IdObra = cmbDetObra.SelectedValue
                    .IdCuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtDetAC_Cuenta.Text, SC)
                    'cmbDetAsientoCuenta.SelectedValue()
                    .CodigoCuenta = EntidadManager.GetItem(SC, "Cuentas", .IdCuenta).Item("Codigo")
                    .Cuenta = EntidadManager.NombreCuenta(SC, .IdCuenta)
                    .IdCuentaBancaria = cmbDetCuentaBanco.SelectedValue
                    .IdCuentaGasto = cmbDetCuentaGasto.SelectedValue

                    'MODIFICADO CON AUTOCOMPLETE:

                    .IdProvinciaDestino1 = cmbDetProvinciaDestino1.SelectedValue
                    .IdProvinciaDestino2 = cmbDetProvinciaDestino2.SelectedValue
                    .PorcentajeProvinciaDestino1 = Val(txtDetProvinciaPorcentaje1.Text)
                    .PorcentajeProvinciaDestino2 = Val(txtDetProvinciaPorcentaje2.Text)




                    If .IdPedidoAnticipo > 0 Then

                        .IdPedido = .IdPedidoAnticipo
                        'oRs1 = Aplicacion.Pedidos.TraerFiltrado("_PorId", Me.IdPedidoAnticipo)
                        'If oRs1.RecordCount > 0 Then
                        '    txtNumeroPedido.Text = IIf(IsNull(oRs1.Fields("NumeroPedido").Value), "", oRs1.Fields("NumeroPedido").Value)
                        '    txtSubNumeroPedido.Text = IIf(IsNull(oRs1.Fields("SubNumero").Value), "", oRs1.Fields("SubNumero").Value)
                        '    .Fields("NumeroSubcontrato").Value = oRs1.Fields("NumeroSubcontrato").Value
                        '    If IIf(IsNull(oRs1.Fields("TotalIva1").Value), 0, oRs1.Fields("TotalIva1").Value) <> 0 Then
                        '        If oRsPar.RecordCount > 0 Then
                        '            For i = 1 To 10
                        '                If Not IsNull(oRsPar.Fields("IdCuentaIvaCompras" & i).Value) Then
                        '                    If oRsPar.Fields("IVAComprasPorcentaje" & i).Value = IIf(IsNull(oRs1.Fields("PorcentajeIva1").Value), 0, oRs1.Fields("PorcentajeIva1").Value) Then
                        '                        Check1(i - 1).Value = 1
                        '                        Exit For
                        '                    End If
                        '                End If
                        '            Next
                        '        End If
                        '    End If
                        'End If
                    End If

                    Try
                        .IdPedido = GetStoreProcedureTop1(HFSC.Value, enumSPs.Pedidos_TX_PorNumero, Val(txtDetNumeroPedido.Text), Val(txtDetSubnumeroPedido.Text)).Item("IdPedido")
                    Catch ex As Exception

                    End Try



                    'If chkDetIVA_21.Checked Then
                    '    .AplicarIVA1 = "SI"
                    '    .IVAComprasPorcentaje1 = 21
                    'End If
                    'If chkDetIVA_27.Checked Then
                    '    .AplicarIVA2 = "SI"
                    '    .IVAComprasPorcentaje2 = 27
                    'End If
                    'If chkDetIVA_105.Checked Then
                    '    .AplicarIVA3 = "SI"
                    '    .IVAComprasPorcentaje3 = 10.5
                    'End If

                    RefrescaDetalleIva()
                    For i = 1 To 10
                        Dim chk As CheckBox = PanelDetalle.FindControl("chkDetIVA" & i)
                        With chk
                            If .Checked Then
                                CallByName(myComprobanteProveedor.Detalles(mIdItem), "AplicarIVA" & i, CallType.Set, "SI")
                            Else
                                CallByName(myComprobanteProveedor.Detalles(mIdItem), "AplicarIVA" & i, CallType.Set, "NO")
                            End If
                        End With
                    Next



                    Dim pm = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(HFSC.Value)
                    For n = 1 To 10
                        If Not IsNull(pm.Item("IdCuentaIvaCompras" & n)) Then
                            CallByName(myComprobanteProveedor.Detalles(mIdItem), "IdCuentaIvaCompras" & n, CallType.Set, pm.Item("IdCuentaIvaCompras" & n))
                            CallByName(myComprobanteProveedor.Detalles(mIdItem), "IVAComprasPorcentaje" & n, CallType.Set, pm.Item("IVAComprasPorcentaje" & n))
                        Else
                            CallByName(myComprobanteProveedor.Detalles(mIdItem), "IdCuentaIvaCompras" & n, CallType.Set, 0)
                            CallByName(myComprobanteProveedor.Detalles(mIdItem), "IVAComprasPorcentaje" & n, CallType.Set, 0)
                        End If
                    Next


                    '.IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
                    '.Articulo = txt_AC_Articulo.Text
                    '.FechaEntrega = ProntoFuncionesGenerales.iisValidSqlDate(txtDetFechaEntrega.Text)

                    '.Cantidad = StringToDecimal(txtDetCantidad.Text)
                    '.Precio = StringToDecimal(txtDetPrecioUnitario.Text)
                    '.PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
                    '.PorcentajeIVA = StringToDecimal(txtDetIVA.Text)
                    '.Costo = StringToDecimal(txtDetCosto.Text)
                    '.PorcentajeCertificacion = StringToDecimal(txtPorcentajeCertificacion.Text)

                    .Importe = StringToDecimal(txtDetImporte.Text)
                    '.IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)
                    '.Unidad = cmbDetUnidades.SelectedItem.Text
                    ''.ArchivoAdjunto1 = FileUpLoad2.FileName

                    ''total

                    ''.ArchivoAdjunto1
                    ''.ArchivoAdjunto2


                    '.OrigenDescripcion = 1 'como por ahora no tengo el option button, le pongo siempre 1
                    '.TipoCancelacion = RadioButtonListFormaCancelacion.SelectedItem.Value + 1







                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As Data.DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With






                    If Not IsValidItem(myComprobanteProveedor.Detalles(mIdItem), ms) Then
                        MsgBoxAjax(Me, ms)
                        ModalPopupExtender3.Show()
                        Exit Sub
                    End If



                End With
            Catch ex As Exception
                'lblError.Visible = True
                'MsgBoxAjax(Me, ex.ToString)
                ErrHandler2.WriteAndRaiseError(ex)
            End Try

            RecalcularTotalComprobante()

            Me.ViewState.Add(mKey, myComprobanteProveedor)

            Rebind(myComprobanteProveedor)

            'GridView1.DataSource = myComprobanteProveedor.Detalles
            'GridView1.DataBind()

            UpdatePanelGrilla.Update()

            GridView1.Focus()

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







    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////


    Sub RecalcularTotalDetalle()


        'Dim mImporte = StringToDecimal(txtDetCantidad.Text) * StringToDecimal(txtDetPrecioUnitario.Text)
        'Dim mBonificacion = Math.Round(mImporte * Val(txtDetBonif.Text) / 100, 4)
        'Dim mIVA = Math.Round((mImporte - mBonificacion) * Val(txtDetIVA.Text) / 100, 4)
        'txtDetTotal.Text = FF2(mImporte - mBonificacion + mIVA)

    End Sub

    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    ' Refrescos por cambio de combos
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////


    Sub TraerCuentaFFAsociadaAObra() 'relacion uno-->varios
    End Sub





    Sub DeObjetoHaciaPagina(ByRef myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)
        RecargarEncabezado(myComprobanteProveedor)

        'GridView1.DataSource = myComprobanteProveedor.Detalles 'pero cómo se mantiene esto, si estoy usando un objeto local de la funcion?
        'GridView1.DataBind()
        Rebind(myComprobanteProveedor)
        'gvImputaciones.DataSource = myRecibo.DetallesImputaciones
        'gvImputaciones.DataBind()
    End Sub

    Sub DePaginaHaciaObjeto(ByRef myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)
        With myComprobanteProveedor


            'traigo parámetros generales
            Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            '.IdMoneda = drParam.Item("ProximoComprobanteProveedorReferencia").ToString 'mIdMonedaPesos




            .NumeroComprobante1 = Val(txtNumeroComprobanteProveedor1.Text)
            .NumeroComprobante2 = Val(txtNumeroComprobanteProveedor2.Text)
            .IdTipoComprobante = cmbTipoComprobante.SelectedValue
            .IdObra = cmbObra.SelectedValue



            If RadioButtonListEsInterna.SelectedValue = 1 Then
                'de proveedor
                .IdProveedor = BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, SC)
                .IdCuentaOtros = Nothing
            ElseIf RadioButtonListEsInterna.SelectedValue = 3 Then
                '"otros".  a cuenta
                .IdProveedor = Nothing
                .IdCuentaOtros = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAutocompleteCuenta.Text, SC)
            End If

            .BienesOServicios = RadioButtonBienesOServicios.SelectedValue

            .IdMoneda = cmbMoneda.SelectedValue
            .IdCondicionCompra = cmbCondicionCompra.SelectedValue

            .Letra = txtLetra.Text

            .FechaIngreso = txtFechaComprobante.Text
            .FechaComprobante = txtFechaComprobante.Text
            .FechaVencimiento = iisValidSqlDate(txtFechaVencimiento.Text)
            .FechaRecepcion = iisValidSqlDate(txtFechaRecepcion.Text)

            .Observaciones = txtObservaciones.Text
            .IdObra = cmbObra.SelectedValue

            .IdIBCondicion = cmbCategoriaIIBB1.SelectedValue


            .ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")

            'myComprobanteProveedor.Observaciones = Convert.ToString(txtObservaciones.Text) '???
            .Observaciones = txtObservaciones.Text

            .AjusteIVA = StringToDecimal(txtAjusteIVA.Text)



            'If txtLibero.Text <> "" Then
            '.ConfirmadoPorWeb = "SI"
            'Else
            '.ConfirmadoPorWeb = "NO"
            'End If


        End With
    End Sub
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////
    ' Refrescos del autocomplete
    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////







    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Pagina Principal de ABM

    Sub RecalcularTotalComprobante()
        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)
        Try
            With myComprobanteProveedor

                DePaginaHaciaObjeto(myComprobanteProveedor)

                ComprobanteProveedorManager.RecalcularTotales(myComprobanteProveedor)


                ''////////////////////////////////////////////
                ''////////////////////////////////////////////

                txtSubtotal.Text = FF2(.TotalBruto)
                ''txtBonificacionPorItem.Text = FF2(.TotalBonifEnItems)
                'lblTotBonif.Text = FF2(.TotalBonifSobreElTotal)
                txtIVA1.Text = FF2(.TotalIva1)
                txtIVA2.Text = FF2(.TotalIva2)
                'lblTotPercepcionIVA.Text = FF2(.PercepcionIVA)
                'lblTotIngresosBrutos.Text = FF2(.IBrutos)
                txtTotal.Text = FF2(.TotalComprobante)


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











    '////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////




















    Protected Sub txtNumeroComprobanteProveedor2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroComprobanteProveedor2.TextChanged
        'txtNumeroComprobanteProveedor1.Text = ComprobanteProveedorManager.ProximoSubNumero(SC, txtNumeroComprobanteProveedor2.Text)
    End Sub

    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        Dim output As String
        'output = ImprimirWordDOT("ComprobanteProveedor_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdComprobanteProveedor)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa





        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1


        'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
        'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
        'llamada a Emision desde el Excel del servidor y ver donde explota.
        '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
        '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!
        '-Por ahora usá la de FontanaNicastro, que no tiene controlcito para codigo de barras
        'Dim p = "ComprobanteProveedor_A_FontanaNicastro.dot" '"ComprobanteProveedor.dot"   "ComprobanteProveedor_PRONTO.dot"
        Dim p = DirApp() & "\Documentos\" & "ComprobanteProveedor_Williams.dot"


        Try
            output = ImprimirWordDOT(p, Me, HFSC.Value, Session, Response, IdComprobanteProveedor, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "ComprobanteProveedor.doc")
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

        If Not bPassOK Then

            'password de pronto
            If txtAnularPassword.Text = ProntoPasswordSegunIdEmpleado(SC, cmbUsuarioAnulo.SelectedValue) Then bPassOK = True
        End If




        If bPassOK Then

            Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

            If Not chkLiberarCDPs.Checked Then
                myComprobanteProveedor.Observaciones = " -- NO LIBERAR CDPS -- " & myComprobanteProveedor.Observaciones
            End If

            'ComprobanteProveedorManager.AnularComprobanteProveedor(SC, myComprobanteProveedor, cmbUsuarioAnulo.SelectedValue)


            'Me.ViewState.Add(mKey, myComprobanteProveedor) 'guardo en el viewstate el objeto
            'ComprobanteProveedorManager.Save(SC, myComprobanteProveedor)


            Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            'BloqueosDeEdicion(myRequerimiento)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If
    End Sub


    Protected Sub txtAutocompleteProveedor_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAutocompleteProveedor.TextChanged
        Dim id As Long = BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, HFSC.Value)
        TraerDatosProveedor(id)
        'txtAutocompleteProveedor.Focus()
        'ClientIDSetfocus = txtAutocompleteProveedor.ID
        GridView1.Focus()
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

        'If mvarId > 0 Then txtNumeroComprobanteProveedor.Text = origen.Registro.Fields("NumeroComprobanteProveedor").Value

        'CalculaComprobanteProveedor()

    End Sub







    'Public Sub AgregarDevolucionAnticipo() 'funcion original de ProntoVB6

    '    Dim mEsta As Boolean, mOk As Boolean
    '    Dim s As String
    '    Dim mIdArticulo As Long, mIdDetalleOrdenCompra As Long, mIdDetFac As Long
    '    Dim mImporte As Double, mPorcentajeCertificacion As Single
    '    Dim oDetOC As ComprobanteProveedorOrdenesCompraItem

    '    Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

    '    mEsta = False
    '    If mEsta Then Exit Sub


    '    mIdDetalleOrdenCompra = 0

    '    Dim DetallesOrdenesCompraTemp As New ComprobanteProveedorOrdenesCompraItemList

    '    If myComprobanteProveedor.DetallesOrdenesCompra.Count = 0 Then
    '        MsgBoxAjax(Me, "No hay imputaciones contra ordenes de compra")
    '        Return
    '    End If
    '    For Each i As ComprobanteProveedorOrdenesCompraItem In myComprobanteProveedor.DetallesOrdenesCompra
    '        With i
    '            If Not .Eliminado Then
    '                mIdDetalleOrdenCompra = .IdDetalleOrdenCompra

    '                mImporte = 0
    '                mPorcentajeCertificacion = 0
    '                Dim oRs = ComprobanteProveedorManager.GetListTX(SC, "_DevolucionAnticipo", mIdDetalleOrdenCompra)
    '                If oRs.Tables(0).Rows.Count > 0 Then
    '                    mImporte = iisNull(oRs.Tables(0).Rows(0).Item("Importe"), 0)
    '                    mPorcentajeCertificacion = iisNull(oRs.Tables(0).Rows(0).Item("PorcentajeCertificacion"), 0)
    '                End If


    '                'creo el item de devolucion a la ComprobanteProveedor
    '                Dim mItem As ComprobanteProveedorItem = New Pronto.ERP.BO.ComprobanteProveedorItem
    '                With mItem
    '                    .Id = myComprobanteProveedor.Detalles.Count
    '                    .Nuevo = True

    '                    .IdArticulo = cmbArticulosDevolucion.SelectedValue
    '                    Dim oArt = ArticuloManager.GetItem(SC, .IdArticulo)
    '                    .Articulo = oArt.Descripcion
    '                    .IdUnidad = oArt.IdUnidad
    '                    .Unidad = EntidadManager.NombreUnidad(SC, oArt.IdUnidad)
    '                    .Cantidad = -1
    '                    .PorcentajeCertificacion = mPorcentajeCertificacion * Val(txtPorcentajeDevolucionAnticipo.Text) / 100 * -1
    '                    .Precio = mImporte * Val(txtPorcentajeDevolucionAnticipo.Text) / 100
    '                    .ImporteTotalItem = .Precio * .Cantidad
    '                    mIdDetFac = .Id
    '                End With
    '                myComprobanteProveedor.Detalles.Add(mItem)


    '                'Creo la imputacion en la coleccion detalle de OC.
    '                'Las agrego a una coleccion temporal, porque tengo que agregarlas a la misma coleccion
    '                'donde estoy haciendo el for each
    '                oDetOC = New ComprobanteProveedorOrdenesCompraItem
    '                With oDetOC
    '                    .Nuevo = True
    '                    .IdDetalleComprobanteProveedor = mIdDetFac
    '                    .Id = mIdDetalleOrdenCompra
    '                End With
    '                DetallesOrdenesCompraTemp.Add(oDetOC)


    '            End If
    '        End With

    '    Next

    '    For Each i In DetallesOrdenesCompraTemp
    '        myComprobanteProveedor.DetallesOrdenesCompra.Add(i)
    '    Next

    '    RecalcularTotalComprobante()


    '    Me.ViewState.Add(mKey, myComprobanteProveedor)
    '    GridView1.DataSource = myComprobanteProveedor.Detalles
    '    GridView1.DataBind()

    '    UpdatePanelGrilla.Update()

    'End Sub




    Protected Sub cmbCategoriaIIBB1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCategoriaIIBB1.SelectedIndexChanged
        RecalcularTotalComprobante()
    End Sub




    Protected Sub RadioButtonListEsInterna_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListEsInterna.SelectedIndexChanged
        RefrescarNumeroTalonario()
        ConmutarPanelClienteConPanelCuenta()
    End Sub

    Sub ConmutarPanelClienteConPanelCuenta()
        PanelEncabezadoCliente.Visible = (RadioButtonListEsInterna.SelectedItem.Value <= 1)
        PanelEncabezadoCuenta.Visible = Not PanelEncabezadoCliente.Visible
        'PanelImputaciones.Visible = PanelEncabezadoCliente.Visible 'los recibos solo tienen imputaciones si son a cliente
        'UpdatePanelImputaciones.Update()
    End Sub

    Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
        GridView1.Focus()

    End Sub




    Protected Sub txtAjusteIVA_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAjusteIVA.TextChanged
        RecalcularTotalComprobante()
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

    Protected Sub ObjGrillaConsulta_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjGrillaConsulta.Selecting
        'En caso de que necesite pasarle parametros
        'e.InputParameters("Parametros") = New String() {"P"}

        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control

        ''If Not ViewState("ObjectDataSource2Mostrar") Then 'para que no busque estos datos si no fueron pedidos explicitamente
        'If txtBuscar.Text = "buscar" Then
        If Not IsPostBack Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        ViewState("ObjectDataSource2Mostrar") = False

    End Sub

    Function GenerarWHERE_Recepciones() As String
        Return "Convert([Nro_recep_alm_], 'System.String') LIKE '*" & txtBuscar.Text & "*'" '_
        '& " OR " & _
        '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Function

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        ObjGrillaConsulta.FilterExpression = "Convert([Req_Nro_], 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"

        RebindGridAuxRecepcionesSinImputar()
    End Sub


    Protected Sub RadioButtonPendientes_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonPendientes.CheckedChanged
        ObjGrillaConsulta.SelectParameters.Add("TX", "_Pendientes1")
        'Requerimientos_TX_Pendientes1 'P' 
    End Sub

    Protected Sub RadioButtonAlaFirma_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonAlaFirma.CheckedChanged
        'Requerimientos_TX_PendientesDeFirma
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click


        ViewState("ObjectDataSource2Mostrar") = True
        'GVGrillaConsulta.DataBind()

        RebindGridAuxRecepcionesSinImputar()

        ModalPopupExtender1.Show()
        SetFocusAjax(Me, txtBuscar.UniqueID)

    End Sub



    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click


        'ViewState("ObjectDataSource2Mostrar") = True
        'GVGrillaConsulta.DataBind()

        RebindGridAuxPedidosAnticipados()

        ModalPopupExtender2.Show()
        SetFocusAjax(Me, TextBox3.UniqueID)

    End Sub


    Sub RebindGridAuxRecepcionesSinImputar()

        With GVGrillaConsulta
            .DataSourceID = ""
            'Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
            Dim dt As DataTable = RecepcionManager.GetListTXDetallesPendientes(SC, BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, HFSC.Value)).Tables(0)
            dt = DataTableWHERE(dt, GenerarWHERE_Recepciones)
            .DataSource = DataTableORDER(dt, "IdRecepcion DESC")
            .DataBind()
        End With

    End Sub

    Protected Sub GVGrillaConsulta_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GVGrillaConsulta.PageIndexChanging
        GVGrillaConsulta.PageIndex = e.NewPageIndex
        RebindGridAuxRecepcionesSinImputar()
    End Sub








    Protected Sub btnAceptarPopupGrilla_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAceptarPopupGrilla.Click

        'restauro el objeto a partir del viewstate
        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        With GVGrillaConsulta
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




                        Dim idRecepcion As Integer = .DataKeys(fila.RowIndex).Values.Item("IdRecepcion")
                        'Dim oRM As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idRM, True)
                        'Dim oDetRM As RequerimientoItem
                        'Dim idDetRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleRequerimiento")
                        'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)


                        IncorporarDesdeRecepcion(idRecepcion, myComprobanteProveedor)


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
                        'If myComprobanteProveedor.Detalles.Find(Function(obj) obj.IdDetallePedido = idDetRM) Is Nothing Then

                        '    Dim mItem As ComprobanteProveedorItem = New Pronto.ERP.BO.ComprobanteProveedorItem
                        '    With mItem
                        '        .Id = myComprobanteProveedor.Detalles.Count
                        '        .Nuevo = True


                        '        Dim oRsDet As Data.DataSet
                        '        oRsDet = RequerimientoManager.GetListTX(SC, "_DatosRequerimiento", idDetRM) 'este sp trae datos del DETALLE de requerimientos (el parametro es un IdDetalleRequerimiento)
                        '        With oRsDet.Tables(0).Rows(0)
                        '            If IsNull(.Item("Aprobo")) Then
                        '                MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " no fue liberado")
                        '                Continue For
                        '            End If
                        '            If IIf(IsNull(.Item("CumplidoReq")), "NO", .Item("CumplidoReq")) = "SI" Or _
                        '                  IIf(IsNull(.Item("CumplidoReq")), "NO", .Item("CumplidoReq")) = "AN" Then
                        '                MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " ya esta cumplido")
                        '                Continue For
                        '            End If
                        '            If Not EntidadManager.CircuitoFirmasCompleto(SC, EntidadManager.EnumFormularios.RequerimientoMateriales, .Item("IdRequerimiento")) Then
                        '                MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " no tiene completo el circuito de firmas")
                        '                Continue For
                        '            End If
                        '            If IIf(IsNull(.Item("Cumplido")), "NO", .Item("Cumplido")) = "SI" Or _
                        '                  IIf(IsNull(.Item("Cumplido")), "NO", .Item("Cumplido")) = "AN" Then
                        '                'MsgBoxAjax(Me, "El requerimiento " & oRs.item("NumeroRequerimiento") & " item " & .Item("NumeroItem") & " ya esta cumplido", vbExclamation)
                        '                Continue For
                        '            End If

                        '            If .Item("TipoDesignacion") = "S/D" Then
                        '                MsgBoxAjax(Me, "El requerimiento " & .Item("NumeroRequerimiento") & " está sin designar")
                        '                Continue For
                        '            End If

                        '            If IsNull(.Item("TipoDesignacion")) Or _
                        '                .Item("TipoDesignacion") = "" Or _
                        '                  .Item("TipoDesignacion") = "CMP" Or _
                        '                  (.Item("TipoDesignacion") = "STK" And _
                        '                   .Item("SalidaPorVales") < IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad"))) Or _
                        '                  (.Item("TipoDesignacion") = "REC" And _
                        '                   .Item("IdObra") = ProntoParamOriginal(SC, "IdObraStockDisponible") And _
                        '                   .Item("SalidaPorVales") < IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad"))) Then

                        '                ' mItem.NumeroItem = myComprobanteProveedor.Detalles.Count
                        '                If .Item("TipoDesignacion") = "STK" Then
                        '                    mItem.Cantidad = IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad")) - .Item("SalidaPorVales")
                        '                Else
                        '                    mItem.Cantidad = IIf(IsNull(.Item("Cantidad")), 0, .Item("Cantidad")) - .Item("Pedido")
                        '                End If


                        '            End If
                        '        End With


                        '    End With
                        '    myComprobanteProveedor.Detalles.Add(mItem)
                    Else
                        'MsgBoxAjax(Me, "El renglon de requerimiento " & idDetRM & " ya está en el detalle")
                    End If


                End If

            Next
        End With

        ComprobanteProveedorManager.RefrescarDesnormalizados(HFSC.Value, myComprobanteProveedor)



        Me.ViewState.Add(mKey, myComprobanteProveedor)
        GridView1.DataSource = myComprobanteProveedor.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()

    End Sub



    Public Sub IncorporarDesdeRecepcion(ByVal IdRecepcion As Long, ByRef myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor)

        Dim oAp
        Dim oPr 'As ComPronto.ComprobanteProveedor 
        Dim oRsPre As DataTable
        Dim oRs As DataRow
        Dim oRs1 As DataTable
        Dim oRsDet As DataRow
        Dim oRsDetTabla As DataTable

        Dim mIdCodigoIva As Integer
        Dim iFilas As Long, iColumnas As Long, mSubNumero As Long, mIdCuentaIvaCompras1 As Long
        Dim mIdTipoComprobante As Long, mIdCuentaDiferenciaCambio As Long
        Dim i As ComprobanteProveedorItem
        Dim j As Long
        Dim mCodigoCuentaDiferenciaCambio As Long, mIdMoneda As Long, mCodBar As Long, mIdObraDefault As Long
        Dim mIdTipoComprobanteNDInternaAcreedores As Long, mIdTipoComprobanteNCInternaAcreedores As Long
        Dim mIdCuentaIvaCompras(10) As Long
        Dim mIVAComprasPorcentaje(10) As Single
        Dim mIVAComprasPorcentaje1 As Single
        Dim mvarImporte As Double, mvarImpuestosInternos As Double
        Dim s As String, mvarConIVA As String, mAplicaIVA As String, mAuxS1 As String, mControl1 As String, mControl2 As String
        Dim mProcesar As Boolean, mOk As Boolean
        Dim Columnas, mAux1
        Dim mError As String

        mControl1 = EntidadManager.BuscarClaveINI("Control por codigo recepcion a comprobante", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario))
        mControl2 = BuscarClaveINI("Legajos para recepcion a comprobante sin pedido", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario))

        Dim pm = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(HFSC.Value)
        For n = 1 To 10
            If Not IsNull(pm.Item("IdCuentaIvaCompras" & n)) Then
                mIdCuentaIvaCompras(n) = pm.Item("IdCuentaIvaCompras" & n)
                mIVAComprasPorcentaje(n) = pm.Item("IVAComprasPorcentaje" & n)
            Else
                mIdCuentaIvaCompras(n) = 0
                mIVAComprasPorcentaje(n) = 0
            End If
        Next


        mAux1 = TraerValorParametro2(HFSC.Value, "IdObraDefault")
        mIdObraDefault = IIf(IsNull(mAux1), 0, mAux1)





        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////




        oRs = GetStoreProcedureTop1(HFSC.Value, enumSPs.Recepciones_T, IdRecepcion)
        oRsDetTabla = GetStoreProcedure(HFSC.Value, enumSPs.Recepciones_TX_DetallesParaComprobantesProveedores, IdRecepcion)

        mProcesar = True
        mIdMoneda = 0
        mvarImpuestosInternos = 0

        With myComprobanteProveedor

            'If Not IsNull(oRs.item("IdPedido")) Then
            oRs1 = GetStoreProcedure(HFSC.Value, enumSPs.Pedidos_TX_PorId, oRs.Item("IdPedido"))
            '    If oRs1.RecordCount > 0 Then
            '        .IdMoneda = oRs1.IdMoneda
            '        mvarImpuestosInternos = IIf(IsNull(oRs1.ImpuestosInternos), 0, oRs1.ImpuestosInternos)
            '        If mControl1 = "SI" And Not IsNull(oRs1.CodigoControl) Then


            '            If (Not mOk Or oRs1.CodigoControl <> mCodBar) And _
            '                  mCodBar <> 0 Then
            '                oRs1.Close()
            '                MsgBox("Codigo de control incorrecto, proceso cancelado", vbExclamation)
            '                GoTo Salida
            '                Exit Sub
            '            End If
            '        End If
            '    End If
            '    oRs1.Close()
            'Else
            '    If Len(mControl2) > 0 Then
            '        If InStr(1, mControl2, "(" & glbLegajo & ")") = 0 Then
            '            MsgBox("Permiso insuficiente para la tarea seleccionada, proceso cancelado", vbExclamation)
            '            GoTo Salida
            '            Exit Sub
            '        End If
            '    End If
            '    mvarImpuestosInternos = IIf(IsNull(oRs.ImpuestosInternos), 0, oRs.ImpuestosInternos)
            'End If
            'If .IdProveedor <> oRs.IdProveedor And _
            '   Lista.ListItems.Count > 0 Then
            '    mError = mError & "La recepcion " & oRsDet.item("Remito & " no se tomo porque no es" & vbCrLf & _
            '             "del proveedor actual." & vbCrLf
            '    mProcesar = False
            'Else
            '    .IdProveedor = oRs.IdProveedor
            'End If
            'If Not IsNull(oRs.Anulada) And oRs.Anulada = "SI" Then
            '    mError = mError & "La recepcion " & oRs.NumeroRecepcionAlmacen & " ha sido anulada." & vbCrLf
            '    mProcesar = False
            'End If
        End With




        If mProcesar Then
            mAplicaIVA = "SI"
            mIdCodigoIva = 0

            If myComprobanteProveedor.IdProveedor > 0 Then
                Dim prov = ProveedorManager.GetItem(HFSC.Value, myComprobanteProveedor.IdProveedor)
                If Not IsNull(prov.IdCodigoIva) And _
                          (prov.IdCodigoIva = 3 Or prov.IdCodigoIva = 5 Or _
                           prov.IdCodigoIva = 8 Or prov.IdCodigoIva = 9) Then
                    mAplicaIVA = "NO"
                End If
                mIdCodigoIva = IIf(IsNull(prov.IdCodigoIva), 0, prov.IdCodigoIva)
            End If

        End If



        For Each oRsDet In oRsDetTabla.Rows
            mProcesar = True
            Dim r = GetStoreProcedureTop1(HFSC.Value, enumSPs.ComprobantesProveedores_TX_DatosPorIdDetalleRecepcion, oRsDet.Item("IdDetalleRecepcion"))
            'If Not IsNothing(r) Then
            '    mError = mError & "El articulo " & r.Item("CodigoArticulo") & " no se tomo porque ya fue incorporado en el comprobante " & _
            '             r.Item("Comprobante") & " del " & r.Item("Fecha") & vbCrLf
            '    mProcesar = False
            'End If



            For Each i In myComprobanteProveedor.Detalles
                If i.IdDetalleRecepcion = oRsDet.Item("IdDetalleRecepcion") Then
                    mProcesar = False
                    Exit For
                End If
            Next



            If mProcesar Then
                mIdCuentaIvaCompras1 = 0
                mIVAComprasPorcentaje1 = 0
                If Not IsNull(oRsDet.Item("PorcentajeIVA")) Then
                    If oRsDet.Item("PorcentajeIVA") <> 0 Then
                        For n = 1 To 10
                            If mIVAComprasPorcentaje(n) = oRsDet.Item("PorcentajeIVA") Then
                                mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(n)
                                mIVAComprasPorcentaje1 = mIVAComprasPorcentaje(n)
                                Exit For
                            End If
                        Next
                    End If
                End If



                If Not IsNull(oRsDet.Item("IdCondicionCompra")) Then
                    'mCondicionDesdePedido = True
                    myComprobanteProveedor.IdCondicionCompra = oRsDet.Item("IdCondicionCompra")
                End If
                If mIdObraDefault = 0 Then
                    If Not IsNull(oRsDet.Item("IdObra")) Then
                        myComprobanteProveedor.IdObra = oRsDet.Item("IdObra")
                    End If
                Else
                    If Not IsNull(oRsDet.Item("IdObraRM")) Then
                        myComprobanteProveedor.IdObra = oRsDet.Item("IdObraRM")
                    End If
                End If




                mvarImporte = iisNull(oRsDet.Item("Importe"), 0)


                i = New ComprobanteProveedorItem
                With i
                    i.Nuevo = True
                    .IdDetalleRecepcion = oRsDet.Item("IdDetalleRecepcion")
                    .IdArticulo = oRsDet.Item("IdArticulo")
                    If mIdObraDefault = 0 Then
                        .IdObra = oRsDet.Item("IdObra")
                    Else
                        .IdObra = iisNull(oRsDet.Item("IdObraRM"), oRsDet.Item("IdObra"))
                    End If
                    .IdCuenta = oRsDet.Item("IdCuenta")
                    .CodigoCuenta = oRsDet.Item("CodigoCuenta")
                    .Importe = mvarImporte
                    If mIdCuentaIvaCompras1 <> 0 And mAplicaIVA = "SI" Then
                        .IdCuentaIvaCompras1 = mIdCuentaIvaCompras1
                        .IVAComprasPorcentaje1 = mIVAComprasPorcentaje1
                        If mIdCodigoIva <> 1 Then
                            .ImporteIVA1 = Math.Round(mvarImporte - (mvarImporte / (1 + (mIVAComprasPorcentaje1 / 100))), 2)
                        Else
                            .ImporteIVA1 = Math.Round(mvarImporte * mIVAComprasPorcentaje1 / 100, 2)
                        End If
                        .AplicarIVA1 = "SI"
                    Else
                        .IdCuentaIvaCompras1 = Nothing
                        .IVAComprasPorcentaje1 = 0
                        .ImporteIVA1 = 0
                        .AplicarIVA1 = "NO"
                    End If

                    For n = 2 To 10
                        CallByName(i, "IdCuentaIvaCompras" & n, CallType.Set, 0)
                        CallByName(i, "IVAComprasPorcentaje" & n, CallType.Set, 0)
                        CallByName(i, "ImporteIVA" & n, CallType.Set, 0)
                        CallByName(i, "AplicarIVA" & n, CallType.Set, "NO")

                    Next

                    .IdPedido = oRs.Item("IdPedido")
                    .Cantidad = oRsDet.Item("Cantidad")
                    .IdDetalleObraDestino = iisNull(oRsDet.Item("IdDetalleObraDestino"), Nothing)
                    .IdPresupuestoObraRubro = iisNull(oRsDet.Item("IdPresupuestoObraRubro"), Nothing)
                    .NumeroSubcontrato = iisNull(oRsDet.Item("NumeroSubcontrato"), Nothing)
                End With
                myComprobanteProveedor.Detalles.Add(i)



            End If

        Next


        If mvarImpuestosInternos <> 0 Then
            i = New ComprobanteProveedorItem
            With i

                .IdDetalleRecepcion = Nothing
                .IdArticulo = Nothing
                .IdObra = Nothing
                .IdCuenta = Nothing
                .CodigoCuenta = Nothing
                .Importe = mvarImpuestosInternos
                For n = 1 To 10
                    CallByName(i, "IdCuentaIvaCompras" & n, CallType.Set, 0)
                    CallByName(i, "IVAComprasPorcentaje" & n, CallType.Set, 0)
                    CallByName(i, "ImporteIVA" & n, CallType.Set, 0)
                    CallByName(i, "AplicarIVA" & n, CallType.Set, "NO")

                Next
                .IdPedido = oRs.Item("IdPedido")

            End With
            myComprobanteProveedor.Detalles.Add(i)
        End If


        If iisNull(oRs.Item("PercepcionIIBB"), 0) <> 0 Then
            i = New ComprobanteProveedorItem
            With i

                .IdDetalleRecepcion = Nothing
                .IdArticulo = Nothing
                .IdObra = Nothing
                .IdCuenta = Nothing
                .CodigoCuenta = Nothing
                .Importe = iisNull(oRs.Item("PercepcionIIBB"))
                For n = 1 To 10
                    CallByName(i, "IdCuentaIvaCompras" & n, CallType.Set, 0)
                    CallByName(i, "IVAComprasPorcentaje" & n, CallType.Set, 0)
                    CallByName(i, "ImporteIVA" & n, CallType.Set, 0)
                    CallByName(i, "AplicarIVA" & n, CallType.Set, "NO")
                Next
                .IdPedido = oRs.Item("IdPedido")
            End With
            myComprobanteProveedor.Detalles.Add(i)
        End If



        If iisNull(oRs.Item("PercepcionIVA"), 0) <> 0 Then
            i = New ComprobanteProveedorItem
            With i
                .IdDetalleRecepcion = Nothing
                .IdArticulo = Nothing
                .IdObra = Nothing
                .IdCuenta = Nothing
                .CodigoCuenta = Nothing
                .Importe = iisNull(oRs.Item("PercepcionIVA"), 0)
                For n = 1 To 10
                    CallByName(i, "IdCuentaIvaCompras" & n, CallType.Set, 0)
                    CallByName(i, "IVAComprasPorcentaje" & n, CallType.Set, 0)
                    CallByName(i, "ImporteIVA" & n, CallType.Set, 0)
                    CallByName(i, "AplicarIVA" & n, CallType.Set, "NO")

                Next
                .IdPedido = oRs.Item("IdPedido")
            End With
            myComprobanteProveedor.Detalles.Add(i)
        End If



    End Sub



    '////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////

    Protected Sub ObjectDataSource2_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource2.Selecting
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        Static Dim ObjectDataSource2Mostrar As Boolean = False

        If Not IsPostBack Then 'TextBox3.Text = "buscar" Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        ObjectDataSource2Mostrar = False
    End Sub

    Function GenerarWHERE() As String
        Return "Convert(Numero, 'System.String') LIKE '*" & TextBox3.Text & "*'" _
                                         & " OR " & _
                                         "Convert(Proveedor, 'System.String') LIKE '*" & TextBox3.Text & "*'"
    End Function

    Protected Sub GridView3_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView3.PageIndexChanging
        GridView3.PageIndex = e.NewPageIndex
        RebindGridAuxPedidosAnticipados()
    End Sub

    Sub RebindGridAuxPedidosAnticipados()
        With GridView3


            Dim pageIndex = GridView1.PageIndex
            ObjectDataSource2.FilterExpression = GenerarWHERE()
            HFIdProveedor.Value = BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, HFSC.Value)
            Dim b As Data.DataView = ObjectDataSource2.Select()
            'b.Sort = "IdDetalleRequerimiento DESC"
            'ViewState("Sort") = b.Sort
            .DataSourceID = ""
            .DataSource = b
            .DataBind()
            .PageIndex = pageIndex


        End With
    End Sub


    Protected Sub GridView3_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView3.RowCommand
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

    Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView3.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView3)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            ObjectDataSource3.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Aux0")
            Try
                gp.DataSource = ObjectDataSource3.Select
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


    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click

        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

        'copio la solicitud elegida
        Dim IdSeleccionado As Integer

        'Dim fila As GridViewRow = GVGrillaConsulta.SelectedRow
        IdSeleccionado = Convert.ToInt32(GridView3.SelectedDataKey.Value)




        Dim mItem As ComprobanteProveedorItem = New Pronto.ERP.BO.ComprobanteProveedorItem
        With mItem
            .Id = myComprobanteProveedor.Detalles.Count

            .Nuevo = True
            .Eliminado = False
            .Cantidad = 0
            .Cuenta = ""



            .IdPedidoAnticipo = IdSeleccionado
            .IdPedido = IdSeleccionado
            .PorcentajeAnticipo = txtGvAuxPorcentajeAnticipo.Text ' mPorcentaje

            Dim oPedido = PedidoManager.GetItem(SC, .IdPedido)

            .Importe = (.PorcentajeAnticipo / 100) * (oPedido.TotalPedido - oPedido.TotalIva1)

            '.Anticipo_O_Devolucion = mTipo


            'esto lo hace cuando se agrega un item normal en el CP.  hay que agregar la propiedad Anticipo_O_Devolucion

            'If Me.IdPedidoAnticipo > 0 Then
            '    .Fields("IdPedidoAnticipo").Value = Me.IdPedidoAnticipo
            '    .Fields("IdPedido").Value = Me.IdPedidoAnticipo
            '    oRs1 = Aplicacion.Pedidos.TraerFiltrado("_PorId", Me.IdPedidoAnticipo)
            '    If oRs1.RecordCount > 0 Then
            '        txtNumeroPedido.Text = IIf(IsNull(oRs1.Fields("NumeroPedido").Value), "", oRs1.Fields("NumeroPedido").Value)
            '        txtSubNumeroPedido.Text = IIf(IsNull(oRs1.Fields("SubNumero").Value), "", oRs1.Fields("SubNumero").Value)
            '        .Fields("NumeroSubcontrato").Value = oRs1.Fields("NumeroSubcontrato").Value
            '        If IIf(IsNull(oRs1.Fields("TotalIva1").Value), 0, oRs1.Fields("TotalIva1").Value) <> 0 Then
            '            If oRsPar.RecordCount > 0 Then
            '                For i = 1 To 10
            '                    If Not IsNull(oRsPar.Fields("IdCuentaIvaCompras" & i).Value) Then
            '                        If oRsPar.Fields("IVAComprasPorcentaje" & i).Value = IIf(IsNull(oRs1.Fields("PorcentajeIva1").Value), 0, oRs1.Fields("PorcentajeIva1").Value) Then
            '                            Check1(i - 1).Value = 1
            '                            Exit For
            '                        End If
            '                    End If
            '                Next
            '            End If
            '        End If
            '        mTotalPedido = IIf(IsNull(oRs1.Fields("TotalPedido").Value), 0, oRs1.Fields("TotalPedido").Value) - _
            '                       IIf(IsNull(oRs1.Fields("TotalIva1").Value), 0, oRs1.Fields("TotalIva1").Value)
            '    End If
            '    oRs1.Close()
            '    If Me.Anticipo_O_Devolucion = "A" Then
            '        .Fields("IdCuenta").Value = Val(TraerValorParametro2("IdCuentaAnticipoAProveedores"))
            '        .Fields("PorcentajeAnticipo").Value = Me.PorcentajeAnticipo
            '        .Fields("PorcentajeCertificacion").Value = Null
            '        .Fields("Importe").Value = Round(mTotalPedido * Me.PorcentajeAnticipo / 100, 2)
            '    ElseIf Me.Anticipo_O_Devolucion = "C1" Then
            '        .Fields("PorcentajeAnticipo").Value = Null
            '        .Fields("PorcentajeCertificacion").Value = Me.PorcentajeAnticipo
            '        .Fields("Importe").Value = Round(mTotalPedido * Me.PorcentajeAnticipo / 100, 2)
            '    Else
            '        oRs1 = Aplicacion.ComprobantesProveedores.TraerFiltrado("_AnticiposPorIdPedido", Me.IdPedidoAnticipo)
            '        If oRs1.RecordCount > 0 Then
            '            mTotalAnticipos = IIf(IsNull(oRs1.Fields("Importe").Value), 0, oRs1.Fields("Importe").Value)
            '        End If
            '        oRs1.Close()
            '        .Fields("IdCuenta").Value = Val(TraerValorParametro2("IdCuentaDevolucionAnticipoAProveedores"))
            '        .Fields("PorcentajeAnticipo").Value = Null
            '        .Fields("PorcentajeCertificacion").Value = Null
            '        .Fields("Importe").Value = Round(mTotalAnticipos * Me.PorcentajeAnticipo / 100 * -1, 2)
            '    End If
            'End If

            ''/////////////////////////////////

        End With


        BuscaTextoEnCombo(cmbCondicionCompra, "ANTICIPADO")


        myComprobanteProveedor.Detalles.Add(mItem)
        GridView1.DataSource = myComprobanteProveedor.Detalles 'este bind lo copié
        GridView1.DataBind()             'este bind lo copié   

        ViewState("IdDetalleComprobanteProveedor") = mItem.Id
        EditarItemSetup(mItem.Id, myComprobanteProveedor)
        UpdatePanelDetalle.Update()
        ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?



    End Sub


    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        'boton de cierre de grilla popup de copia de solicitudes

    End Sub


    '2 metodos para seleccionar el renglon de la grilla de popup sin hacer postback

    'http://www.codeproject.com/KB/grid/GridViewRowColor.aspx?msg=2732537
    'Protected Sub GridView3_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) _
    'Handles GridView3.RowDataBound
    'If (e.Row.RowType = DataControlRowType.DataRow) Then
    ' e.Row.Attributes.Add("onclick", "javascript:ChangeRowColor('" & e.Row.ClientID & "')")
    ' End If
    'End Sub


    ''http://www.dotnetcurry.com/ShowArticle.aspx?ID=123&AspxAutoDetectCookieSupport=1
    'Protected Sub GridView3_RowCreated(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles GridView3.RowCreated
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

        RebindGridAuxPedidosAnticipados()
        'ObjectDataSource2.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & TextBox3.Text & "*'" _
        '                                     & " OR " & _
        '                                     "Convert(Proveedor, 'System.String') LIKE '*" & TextBox3.Text & "*'"


        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub









    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////





    Protected Sub txtDetAC_Cuenta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetAC_Cuenta.TextChanged


        Dim idcuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtDetAC_Cuenta.Text, HFSC.Value)

        Try
            Dim oRs = GetStoreProcedureTop1(HFSC.Value, enumSPs.Cuentas_TX_PorIdConDatos, idcuenta, txtFechaComprobante.Text)
            txtDetCodigoCuenta.Text = oRs.Item("Codigo")
            BuscaIDEnCombo(cmbDetObra, iisNull(oRs.Item("IdObra"), -1))
            RebindCuentaGasto()
        Catch ex As Exception

        End Try

        '.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
        '.Fields("CodigoCuenta").Value = oRs.Fields("Codigo1").Value
        'If Not IsNull(oRs.Fields("IdObra").Value) Then
        '    .Fields("IdObra").Value = oRs.Fields("IdObra").Value
        'End If
        'If Not IsNull(oRs.Fields("IdRubroFinanciero").Value) Then
        '    .Fields("IdRubroContable").Value = oRs.Fields("IdRubroFinanciero").Value
        'End If




        ClientIDSetfocus = txtDetAC_Cuenta.UniqueID
        'txtDetAC_Cuenta.Focus()
    End Sub

    Protected Sub cmbDetObra_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetObra.SelectedIndexChanged
        RebindCuentaGasto()
    End Sub

    Sub RebindCuentaGasto()
        With cmbDetCuentaGasto
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbDetObra.SelectedValue, Today)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()


            .Items.Insert(0, New ListItem("", -1))
        End With

    End Sub





    Protected Sub cmbDetCuentaGrupo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetCuentaGrupo.SelectedIndexChanged
        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
        AutoCompleteExtender20.ContextKey = Join(New String() {SC, cmbDetCuentaGrupo.SelectedValue.ToString}, "|")

    End Sub


    Protected Sub txtDetCodigoCuenta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetCodigoCuenta.TextChanged
        txtDetAC_Cuenta.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtDetCodigoCuenta.Text).Item("IdCuenta"))
    End Sub





    Protected Sub cmbDetCuentaGasto_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetCuentaGasto.SelectedIndexChanged


        Dim oRs = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbDetObra.SelectedValue, cmbDetCuentaGasto.SelectedValue, txtFechaComprobante.Text)



        'If Len(DataCombo1(3).Text) > 0 Then
        '    DataCombo1(3).BoundText = 0
        '    'If glbSeñal1 Then
        '    'DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerFiltrado("_PorFechaParaCombo", Me.FechaComprobante)
        '    'Else
        '    DataCombo1(0).RowSource = Aplicacion.Cuentas.TraerLista
        '    'End If
        'Else
        'End If

        If Not IsNothing(oRs) Then
            txtDetAC_Cuenta.Text = oRs("Descripcion")
            txtDetCodigoCuenta.Text = oRs("Codigo")

            txtDetCodigoCuenta.Enabled = False
            txtDetAC_Cuenta.Enabled = False
            cmbDetCuentaGrupo.Enabled = False
        End If
    End Sub



    Protected Sub butLimpiaCuentaGasto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles butLimpiaCuentaGasto.Click
        'IniciaCombo(SC, cmbDetCuentaGasto, tipos.CuentasGasto)
        RebindCuentaGasto()
        txtDetCodigoCuenta.Enabled = True
        txtDetAC_Cuenta.Enabled = True
        cmbDetCuentaGrupo.Enabled = True
    End Sub









    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////


    Sub RefrescaDetalleIva()
        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(HFSC.Value)

        For i = 1 To 10
            Dim chk As CheckBox = PanelDetalle.FindControl("chkDetIVA" & i)
            With chk
                If IsNumeric(iisNull(p.Item("IdCuentaIvaCompras" & i))) Then
                    .Visible = True
                    .Text = NombreCuenta(SC, p.Item("IdCuentaIvaCompras" & i))
                    .Text &= " (" & p.Item("IVAComprasPorcentaje" & i) & "%)"
                    .Attributes("style") = " visibility:visible; display:inherit;"
                Else
                    .Visible = False
                    .Attributes("style") = "visibility:hidden; display:none;"
                End If

            End With
        Next
    End Sub


    Public Sub AltaItemSetup1() Implements IProntoABM.AltaItemSetup

    End Sub

    Public Sub AltaSetup1() Implements IProntoABM.AltaSetup

    End Sub


    Public Sub ByndTypeDropDown() Implements IProntoABM.ByndTypeDropDown

    End Sub

    Public Sub DeObjetoHaciaPagina1() Implements IProntoABM.DeObjetoHaciaPagina

    End Sub

    Public Sub DePaginaHaciaObjeto1() Implements IProntoABM.DePaginaHaciaObjeto

    End Sub

    Public Sub EditarSetup1() Implements IProntoABM.EditarSetup

    End Sub

    Public Sub RecalcularTotales() Implements IProntoABM.RecalcularTotales

    End Sub

    Public Sub refrescarEncabezado() Implements IProntoABM.refrescarEncabezado

    End Sub

    Public Sub RefrescarTalonariosDisponibles1() Implements IProntoABM.RefrescarTalonariosDisponibles

    End Sub


End Class
