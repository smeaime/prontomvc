
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.ParametroManager
Imports Pronto.ERP.Bll.EntidadManager
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.Linq


Partial Class ReciboABM
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Private DIRFTP As String = "C:\"

    Private IdRecibo As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdRecibo"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdRecibo") = Value
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
            IdRecibo = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdRecibo
        End If
        mKey = "Recibo_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        SC = usuario.StringConnection

        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender3.ContextKey = SC

        AutoCompleteExtenderOtros1.ContextKey = SC
        AutoCompleteExtenderOtros2.ContextKey = SC
        AutoCompleteExtenderOtros3.ContextKey = SC
        AutoCompleteExtenderOtros4.ContextKey = SC
        AutoCompleteExtenderOtros5.ContextKey = SC
        AutoCompleteExtender20.ContextKey = SC

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
            PanelValor.Attributes("style") = "display:none"
            PanelInfoNum.Attributes("style") = "display:none"
            Panel1.Attributes("style") = "display:none"
            'Panel4.Attributes("style") = "display:none"
            Panel5.Attributes("style") = "display:none"
            PopupGrillaSolicitudes.Attributes("style") = "display:none"
            '///////////////////////////



            'Carga del objeto
            TextBox1.Text = IdRecibo
            BindTypeDropDown()



            Dim myRecibo As Pronto.ERP.BO.Recibo
            If IdRecibo > 0 Then
                myRecibo = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myRecibo = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    myRecibo = AltaSetup()
                End If
            End If



            'gvImputaciones.Columns(7).Visible = False
            'gvImputaciones.Columns(6).Visible = False


            Me.ViewState.Add(mKey, myRecibo)


            ConmutarPanelClienteConPanelCuenta()
            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")


            BloqueosDeEdicion(myRecibo)



        End If


        txtAutocompleteCliente.Attributes("onfocus") = "javascript:this.select();" 'para marcar todo el texto con un clic



        '////////////////////////////////

        'RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        'txtRendicion.Enabled = False

        'refresco
        'btnTraerDatos_Click(Nothing, Nothing)

        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

    End Sub


    Sub BloqueosDeEdicion(ByVal myRecibo As Pronto.ERP.BO.Recibo)
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Then
            'si es un proveedor, deshabilito la edicion


            'habilito el eliminar del renglon
            'For Each r As GridViewRow In gvImputaciones.Rows
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
            gvImputaciones.Enabled = True
            btnOk.Enabled = True
            btnCancel.Enabled = True

            'encabezado
            'txtNumeroRecibo1.Enabled = False
            txtNumerorecibo2.Enabled = False
            txtFechaIngreso.Enabled = False
            'txtFechaAprobado.Enabled = False
            'txtValidezOferta.Enabled = False
            'txtDetalleCondicionCompra.Enabled = False
            cmbMoneda.Enabled = False
            'cmbPlazo.Enabled = False
            cmbRetencionGanancia.Enabled = False
            'cmbPlazo.Enabled = False
            txtObservaciones.Enabled = False
            'txtDescProveedor.Enabled = False
            'txtFechaCierreCompulsa.Enabled = False
            'txtDetalle.Enabled = False
            'btnLiberar.Enabled = False
            txtCodigo.Enabled = False
            'txtTotBonif.Enabled = False



            'detalle
            LinkButtonValor.Enabled = False
            txt_AC_Articulo.Enabled = False
            'txtDetObservaciones.Enabled = False
            'txtDetTotal.Enabled = False
            '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
            'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
            'txtDetCantidad.Enabled = False
            txtDetFechaEntrega.Enabled = False



            'links a popups

            LinkButtonValor.Style.Add("visibility", "hidden")
            'LinkButton1.Style.Add("visibility", "hidden")
            LinkButtonImputacion.Style.Add("visibility", "hidden")
            'LinkButtonImputacion.Attributes("Visibility") = "Hidden"
            'LinkButtonImputacion.Style.Add("display", "none")

            'ModalPopupExtender1.Hide()
            'ModalPopupExtenderImputacion.Hide()

        Else
            LinkButtonValor.Enabled = True
        End If


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or
        With myRecibo

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


                'If .Aprobo > 0 Then
                If True Then
                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////


                    ''habilito el eliminar del renglon
                    'For Each r As GridViewRow In gvImputaciones.Rows
                    '    Dim bt As LinkButton = r.Cells(5).Controls(0)
                    '    If Not bt Is Nothing Then
                    '        bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '        bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '    End If
                    '    bt = r.Cells(6).Controls(0)
                    '    If Not bt Is Nothing Then
                    '        bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '        bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '    End If
                    'Next

                    'me fijo si está cerrado
                    'DisableControls(Me)
                    gvImputaciones.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'si es un proveedor, deshabilito la edicion



                    'me fijo si está cerrado
                    DisableControls(Me)

                    lnkAgregarCaja.Visible = False

                    ''habilito el eliminar del renglon
                    For Each r As GridViewRow In gvImputaciones.Rows
                        'Dim bt As LinkButton
                        'bt = r.FindControl("Elim.")
                        'bt = r.Controls(6).Controls(0) 'el boton eliminar esta dentro de un control datafield

                        Dim bt As ImageButton = r.Cells(6).Controls(0)

                        If Not bt Is Nothing Then
                            bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                            bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                        End If
                    Next


                    btnMasPanel.Enabled = True
                    gvImputaciones.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True
                    LinkImprimir.Enabled = True
                    btnAnular.Enabled = True
                    btnAnularOk.Enabled = True
                    btnAnularCancel.Enabled = True
                    cmbUsuarioAnulo.Enabled = True
                    txtAnularMotivo.Enabled = True
                    txtAnularPassword.Enabled = True

                    'encabezado
                    'txtNumeroRecibo1.Enabled = False
                    txtNumerorecibo2.Enabled = False
                    txtFechaIngreso.Enabled = False
                    'txtFechaAprobado.Enabled = False
                    'txtValidezOferta.Enabled = False
                    'txtDetalleCondicionCompra.Enabled = False
                    cmbMoneda.Enabled = False
                    'cmbPlazo.Enabled = False
                    cmbRetencionGanancia.Enabled = False
                    'cmbPlazo.Enabled = False
                    txtObservaciones.Enabled = False
                    'txtDescProveedor.Enabled = False
                    'txtFechaCierreCompulsa.Enabled = False
                    'txtDetalle.Enabled = False
                    'btnLiberar.Enabled = False
                    txtTotBonif.Enabled = False



                    'detalle
                    LinkButtonValor.Enabled = False
                    txt_AC_Articulo.Enabled = False
                    'txtDetObservaciones.Enabled = False
                    'txtDetTotal.Enabled = False
                    '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
                    'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
                    'txtDetCantidad.Enabled = False
                    txtTotBonif.Enabled = False
                    txtDetFechaEntrega.Enabled = False



                    'links a popups

                    LinkButtonValor.Style.Add("visibility", "hidden")
                    'LinkButton1.Style.Add("visibility", "hidden")
                    LinkButtonImputacion.Style.Add("visibility", "hidden")
                    'LinkButtonImputacion.Attributes("Visibility") = "Hidden"
                    'LinkButtonImputacion.Style.Add("display", "none")

                    'ModalPopupExtender1.Hide()
                    'ModalPopupExtenderImputacion.Hide()


                    'links a popups
                    'LinkButtonValor.Style.Add("visibility", "hidden")
                    'LinkButton1.Style.Add("visibility", "hidden")
                    'LinkButtonImputacion.Style.Add("visibility", "hidden")

                    MostrarBotonesParaAdjuntar()
                Else
                    'LinkButton1.Enabled = True
                    'LinkButtonPopupDirectoCliente.Enabled = True
                End If


                If .Anulado = EnumPRONTO_SiNo.SI Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    btnAnular.Visible = False
                    lblAnulado.Visible = True
                    'lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & .MotivoAnulacion
                    btnSave.Visible = False
                    btnCancel.Text = "Salir"
                End If

                If True Then 'solo vista
                    btnSave.Visible = False
                    btnCancel.Text = "Salir"
                End If
            End If

        End With
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////


    End Sub


    '////////////////////////////////////////////////////////////////////////////
    '   ALTA SETUP   'preparo la pagina para dar un alta
    '////////////////////////////////////////////////////////////////////////////

    Function AltaSetup() As Pronto.ERP.BO.Recibo


        Dim myRecibo As Pronto.ERP.BO.Recibo = New Pronto.ERP.BO.Recibo
        With myRecibo
            .Id = -1

            RefrescarNumeroTalonario()
            BuscaIDEnCombo(cmbVendedor, Session(SESSIONPRONTO_glbIdUsuario))


            'txtNumeroRecibo2.Text = ParametroOriginal(SC, "ProximoRecibo")
            txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?

            'txtNumeroRecibo1.Text = 1

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As ReciboItem = New Pronto.ERP.BO.ReciboItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Eliminado = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing

            .DetallesImputaciones.Add(mItem)
            gvImputaciones.DataSource = .DetallesImputaciones 'este bind lo copié
            gvImputaciones.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItemC As ReciboCuentasItem = New Pronto.ERP.BO.ReciboCuentasItem
            mItemC.Id = -1
            mItemC.Nuevo = True
            mItemC.Eliminado = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing

            .DetallesCuentas.Add(mItemC)
            gvCuentas.DataSource = .DetallesCuentas 'este bind lo copié
            gvCuentas.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItemV As ReciboValoresItem = New Pronto.ERP.BO.ReciboValoresItem
            mItemV.Id = -1
            mItemV.Nuevo = True
            mItemV.Eliminado = True
            mItemV.FechaVencimiento = Nothing
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing

            .DetallesValores.Add(mItemV)
            gvValores.DataSource = .DetallesValores 'este bind lo copié
            gvValores.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItemR As ReciboRubrosContablesItem = New Pronto.ERP.BO.ReciboRubrosContablesItem
            mItemR.Id = -1
            mItemR.Nuevo = True
            mItemR.Eliminado = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing

            .DetallesRubrosContables.Add(mItemR)
            gvRubrosContables.DataSource = .DetallesRubrosContables 'este bind lo copié
            gvRubrosContables.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////

            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If


            'txtReferencia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoReciboReferencia").ToString
            'txtFechaRecibo.Text = System.DateTime.Now.ToShortDateString()


            ViewState("PaginaTitulo") = "Nuevo Recibo"
        End With

        Return myRecibo
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As Pronto.ERP.BO.Recibo
        'los textbox que no se refresquen ponelos en un UpdatePanel

        Dim myRecibo As Pronto.ERP.BO.Recibo

        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?
            myRecibo = ReciboManager.GetItem(SC, IdRecibo, True) 'va a editar ese ID
            'myRecibo = ReciboManager.GetItemComPronto(SC, IdRecibo, True)
        Else
            'está haciendo un alta, pero uso los datos de un ID existente
            myRecibo = ReciboManager.GetCopyOfItem(SC, CopiaDeOtroId)
            IdRecibo = -1
            'tomar el ultimo de la serie y sumarle uno


            'myRecibo.SubNumero = ReciboManager.ProximoSubNumero(SC, myRecibo.Numero)

            'limpiar los precios del Recibo original
            For Each i In myRecibo.DetallesImputaciones
                i.ImporteTotalItem = 0
            Next

            'mKey = "Recibo_" & Me.IdEntity.ToString 'esto es un balurdo. aclarar bien
        End If


        If Not (myRecibo Is Nothing) Then
            With myRecibo


                RecargarEncabezado(myRecibo)

                'TraerDatosCliente(myRecibo.IdCliente)

                '/////////////////////////
                '/////////////////////////
                'Grilla
                '/////////////////////////
                '/////////////////////////
                'gvImputaciones.Columns(0).Visible = False

                gvImputaciones.DataSource = .DetallesImputaciones 'pero cómo se mantiene esto, si estoy usando un objeto local de la funcion?
                gvImputaciones.DataBind()


                gvValores.DataSource = .DetallesValores
                gvValores.DataBind()

                gvCuentas.DataSource = .DetallesCuentas
                gvCuentas.DataBind()

                gvRubrosContables.DataSource = .DetallesRubrosContables
                gvRubrosContables.DataBind()


                'Me.Title = "Edición Fondo Fijo " + myRecibo.Letra + myRecibo.NumeroComprobante1.ToString + myRecibo.NumeroComprobante2.ToString
                ViewState("PaginaTitulo") = "Edición Recibo " + myRecibo.NumeroRecibo.ToString + "/" '+ myRecibo.SubNumero.ToString
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
                'Me.ViewState.Add(mKey, myRecibo)

                'vacío el proveedor (porque es una copia)
                'SelectedReceiver.Value = 0
                'txtDescProveedor.Text = ""
            End If

        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdRecibo & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myRecibo
    End Function

    Sub RecargarEncabezado(ByVal myRecibo As Pronto.ERP.BO.Recibo)
        With myRecibo
            'txtReferencia.Text = myRecibo.Referencia
            'txtLetra.Text = myRecibo.Letra
            'txtNumeroRecibo1.Text = .SubNumero
            txtNumerorecibo2.Text = .NumeroRecibo
            txtFechaIngreso.Text = .FechaRecibo '.ToString("dd/MM/yyyy")
            'txtFechaAprobado.Text = .FechaAprobacion.ToString("dd/MM/yyyy")
            'txtFechaCierreCompulsa.Text = .FechaCierreCompulsa.ToString("dd/MM/yyyy")
            'txtRendicion.Text = .NumeroRendicionFF


            'txtValidezOferta.Text = .Validez
            'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra

            'BuscaTextoEnCombo(cmbTipoComprobante, .IdTipoComprobante.ToString)
            'txtCUIT.Text = .Proveedor.ToString


            '////////////////////////////////////////////////////////
            'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
            'SelectedReceiver.Value = myRecibo.IdProveedor
            'txtDescProveedor.Text = myRecibo.Proveedor
            'TraerDatosProveedor(myRecibo.IdProveedor) 'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
            '////////////////////////////////////////////////////////

            'elige combos
            BuscaIDEnCombo(cmbMoneda, .IdMoneda)
            'BuscaIDEnCombo(cmbPlazo, .IdPlazoEntrega)
            'BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)
            'BuscaIDEnCombo(cmbComprador, .IdComprador)
            'BuscaIDEnCombo(cmbPlazo, .IdPlazoEntrega)
            'BuscaIDEnCombo(cmbCondicionIVA, .)
            'BuscaIDEnCombo(cmbCuenta, .IdCuenta)
            'BuscaIDEnCombo(cmbObra, .IdObra)


            'txtLetra.Text = .TipoFactura

            txtAutocompleteCliente.Text = EntidadManager.NombreCliente(SC, .IdCliente)

            ProntoOptionButton(.Tipo, RadioButtonListEsInterna)

            txtAutocompleteCuenta.Text = EntidadManager.NombreCuenta(SC, .IdCuenta)

            BuscaIDEnCombo(cmbRetencionGanancia, .IdTipoRetencionGanancia)


            BuscaIDEnCombo(cmbPuntoVenta, .IdPuntoVenta)







            'BuscaIDEnCombo(cmbVendedor, .IdVendedor)
            BuscaIDEnCombo(cmbMoneda, .IdMoneda)
            'BuscaIDEnCombo(cmbIVA, .IdCodigoIVA)

            'txtTotal.Text = .Total

            txtCertificadoGanancias.Text = .NumeroCertificadoRetencionGanancias
            txtCertificadoIngresosBrutos.Text = .NumeroCertificadoRetencionIngresosBrutos
            txtCertificadoRetencionIVA.Text = .NumeroCertificadoRetencionIVA


            'txtDetalle.Text = .Detalle
            'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra
            txtObservaciones.Text = .Observaciones
            'txtCAI.Text = .NumeroCAI
            'txtFechaVtoCAI.Text = .FechaVencimientoCAI
            'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

            'lnkAdjunto1.Text = .ArchivoAdjunto1
            chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)


            'If myRecibo.Aprobo <> 0 Then
            '    txtLibero.Text = EmpleadoManager.GetItem(SC, myRecibo.Aprobo).Nombre
            'End If

            txtTotalRetencionGanancias.Text = .RetencionGanancias
            txtTotalRetencionIVA.Text = .RetencionIVA


            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////

            BuscaIDEnCombo(cmbOtrosObra1, .IdObra1)
            BuscaIDEnCombo(cmbOtrosCtaGastos1, .IdCuentaGasto1)
            txtAC_OtrosCuenta1.Text = EntidadManager.NombreCuenta(SC, .IdCuenta1)
            txtOtrosNumero1.Text = .NumeroComprobante1
            txtOtrosImporte1.Text = .Otros1

            BuscaIDEnCombo(cmbOtrosObra2, .IdObra2)
            BuscaIDEnCombo(cmbOtrosCtaGastos2, .IdCuentaGasto2)
            txtAC_OtrosCuenta2.Text = EntidadManager.NombreCuenta(SC, .IdCuenta2)
            txtOtrosNumero2.Text = .NumeroComprobante2
            txtOtrosImporte2.Text = .Otros2

            BuscaIDEnCombo(cmbOtrosObra3, .IdObra3)
            BuscaIDEnCombo(cmbOtrosCtaGastos3, .IdCuentaGasto3)
            txtAC_OtrosCuenta3.Text = EntidadManager.NombreCuenta(SC, .IdCuenta3)
            txtOtrosNumero3.Text = .NumeroComprobante3
            txtOtrosImporte3.Text = .Otros3

            BuscaIDEnCombo(cmbOtrosObra4, .IdObra4)
            BuscaIDEnCombo(cmbOtrosCtaGastos4, .IdCuentaGasto4)
            txtAC_OtrosCuenta4.Text = EntidadManager.NombreCuenta(SC, .IdCuenta4)
            txtOtrosNumero4.Text = .NumeroComprobante4
            txtOtrosImporte4.Text = .Otros4

            BuscaIDEnCombo(cmbOtrosObra5, .IdObra5)
            BuscaIDEnCombo(cmbOtrosCtaGastos5, .IdCuentaGasto5)
            txtAC_OtrosCuenta5.Text = EntidadManager.NombreCuenta(SC, .IdCuenta5)
            txtOtrosNumero5.Text = .NumeroComprobante5
            txtOtrosImporte5.Text = .Otros5





            'pero debiera usar el formato universal...
            'txtTotBonif.Text = String.Format("{0:F2}", DecimalToString(.Bonificacion))
            'txtTotalRetencionIVA.Text = String.Format("{0:F2}", DecimalToString(.ImporteIva1)) 'o uso {0:c} o {0:F2} ?
            'lblTotal.Text = String.Format("{0:F2}", DecimalToString(.ImporteTotal))

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

        cmbLibero.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        cmbLibero.DataTextField = "Titulo"
        cmbLibero.DataValueField = "IdEmpleado"
        cmbLibero.DataBind()


        IniciaCombo(SC, cmbObra, tipos.Obras)


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        cmbCondicionIVA.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "DescripcionIVA")
        cmbCondicionIVA.DataTextField = "Titulo"
        cmbCondicionIVA.DataValueField = "IdCodigoIVA"
        cmbCondicionIVA.DataBind()
        cmbCondicionIVA.Items.Insert(0, New ListItem("-- Elija una Condición --", -1))


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        RefrescarTalonariosDisponibles()



        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        cmbCategoriaIIBB1.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "IBCondiciones")
        cmbCategoriaIIBB1.DataTextField = "Titulo"
        cmbCategoriaIIBB1.DataValueField = "IdIBCondicion"
        cmbCategoriaIIBB1.DataBind()

        cmbUsuarioAnulo.DataSource = EmpleadoManager.GetListCombo(SC)
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()

        cmbListaPrecios.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "ListasPrecios_TL")
        cmbListaPrecios.DataTextField = "Titulo"
        cmbListaPrecios.DataValueField = "IdListaPrecios"
        cmbListaPrecios.DataBind()


        Try
            cmbVendedor.DataSource = EntidadManager.GetListTX(SC, "Vendedores", "TL") 'Comparativas solo acepta a gente del sector de compras
        Catch e As Exception
            'como todavia no manejo los parametros opcionales, si explota la nueva version de TX_PorSector, lo llamo con tres parametros
            'cmbVendedor.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "", "") 'Comparativas solo acepta a gente del sector de compras
        End Try
        cmbVendedor.DataTextField = "Titulo"
        cmbVendedor.DataValueField = "IdVendedor"
        cmbVendedor.DataBind()

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbRetencionGanancia.DataSource = EntidadManager.GetListCombo(SC, "TiposRetencionGanancia")
        If cmbRetencionGanancia.DataSource.Tables(0).Rows.Count = 0 Then
        End If
        cmbRetencionGanancia.DataTextField = "Titulo"
        cmbRetencionGanancia.DataValueField = "IdTipoRetencionGanancia"
        cmbRetencionGanancia.DataBind()
        'If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
        '    BuscaIDEnCombo(cmbCondicionCompra, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))
        '    cmbCondicionCompra.Enabled = False
        'Else
        cmbRetencionGanancia.Items.Insert(0, New ListItem("-- Elija una retención --", -1))
        cmbRetencionGanancia.SelectedIndex = 0
        'End If


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////




        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbMoneda.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Monedas")
        cmbMoneda.DataTextField = "Titulo"
        cmbMoneda.DataValueField = "IdMoneda"
        cmbMoneda.DataBind()
        'If IsNumeric(Session("glbIdCuentaFFUsuario")) Then
        '   cmbMoneda.SelectedValue = Session("glbIdCuentaFFUsuario")
        '   cmbMoneda.Enabled = False
        'Else
        AgregaLeyendaEnCombo(cmbMoneda, "-- Elija una Moneda --")
        BuscaTextoEnCombo(cmbMoneda, "PESOS")
        'End If



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



        cmbDetRubroRubro.DataSource = EntidadManager.GetStoreProcedure(SC, "RubrosContables_TX_ParaComboFinancierosIngresos")
        cmbDetRubroRubro.DataTextField = "Titulo"
        cmbDetRubroRubro.DataValueField = "IdRubroContable"
        cmbDetRubroRubro.DataBind()
        cmbDetRubroRubro.Items.Insert(0, New ListItem("-- Elija un rubro --", -1))


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'popup asiento
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'IniciaCombo(SC, cmbDetAsientoCuenta, tipos.Cuentas)

        IniciaCombo(SC, cmbDetAsientoCuentaBanco, tipos.CuentasBancarias)

        IniciaCombo(SC, cmbDetAsientoCuentaGasto, tipos.CuentasGasto)

        IniciaCombo(SC, cmbDetAsientoCaja, tipos.Cajas)

        IniciaCombo(SC, cmbDetAsientoMoneda, tipos.Monedas)

        IniciaCombo(SC, cmbDetAsientoObra, tipos.Obras)


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'popup valor
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////


        IniciaCombo(SC, cmbDetValorTipo, tipos.TiposValor)

        IniciaCombo(SC, cmbDetValorBancoCuenta, tipos.CuentasBancarias)

        IniciaCombo(SC, cmbDetValorBancoOrigen, tipos.Bancos)

        IniciaCombo(SC, cmbDetValorCuentaContable, tipos.CuentasBancarias)

        IniciaCombo(SC, cmbDetValorGrupoCuentaContable, tipos.TiposCuentaGrupos)



        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'popup caja
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        IniciaCombo(SC, cmbDetCaja, tipos.Cajas)

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbDetUnidades.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
        cmbDetUnidades.DataTextField = "Titulo"
        cmbDetUnidades.DataValueField = "IdUnidad"
        cmbDetUnidades.DataBind()
        cmbDetUnidades.Enabled = False




        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'Otros conceptos
        '///////////////////////////////////////////////

        IniciaCombo(SC, cmbOtrosObra1, tipos.Obras)
        'IniciaCombo(SC, cmbOtrosCtaGastos1, tipos.CuentasGasto)
        IniciaCombo(SC, cmbOtrosGrupo1, tipos.TiposCuentaGrupos)

        IniciaCombo(SC, cmbOtrosObra2, tipos.Obras)
        'IniciaCombo(SC, cmbOtrosCtaGastos2, tipos.CuentasGasto)
        IniciaCombo(SC, cmbOtrosGrupo2, tipos.TiposCuentaGrupos)

        IniciaCombo(SC, cmbOtrosObra3, tipos.Obras)
        'IniciaCombo(SC, cmbOtrosCtaGastos3, tipos.CuentasGasto)
        IniciaCombo(SC, cmbOtrosGrupo3, tipos.TiposCuentaGrupos)

        IniciaCombo(SC, cmbOtrosObra4, tipos.Obras)
        'IniciaCombo(SC, cmbOtrosCtaGastos4, tipos.CuentasGasto)
        IniciaCombo(SC, cmbOtrosGrupo4, tipos.TiposCuentaGrupos)

        IniciaCombo(SC, cmbOtrosObra5, tipos.Obras)
        'IniciaCombo(SC, cmbOtrosCtaGastos5, tipos.CuentasGasto)
        IniciaCombo(SC, cmbOtrosGrupo5, tipos.TiposCuentaGrupos)

    End Sub




    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Protected Sub txtAutocompleteCliente_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAutocompleteCliente.TextChanged

        Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

        If myRecibo.DetallesImputaciones.Count > myRecibo.DetallesImputaciones.Where(Function(i) i.Eliminado = True).Count() Then
            txtAutocompleteCliente.Text = ViewState("ClienteAnterior")
            MsgBoxAjax(Me, "Elimine las imputaciones que corresponden a otro cliente")
            Exit Sub
        Else
            ViewState("ClienteAnterior") = txtAutocompleteCliente.Text
            TraerDatosCliente(BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value))

            'si cambia el cliente, vacío las imputaciones
            myRecibo.DetallesImputaciones.Clear()

            Dim mItem As ReciboItem = New Pronto.ERP.BO.ReciboItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Eliminado = True
            myRecibo.DetallesImputaciones.Add(mItem)

            Me.ViewState.Add(mKey, myRecibo)
            RebindImp()
        End If
    End Sub


    Function TraerDatosCliente(ByVal IdCliente As Long)
        Try
            Dim oCli = ClienteManager.GetItem(SC, IdCliente)
            With oCli
                BuscaIDEnCombo(cmbCondicionIVA, EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("IdCodigoIva"))
                txtCUIT.Text = EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("CUIT")
                BuscaIDEnCombo(cmbRetencionGanancia, .IdCondicionVenta)

                MostrarDatos(0)

                RefrescarTalonariosDisponibles()
            End With
        Catch ex As Exception
            Return -1
        End Try
    End Function


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    Sub RefrescarTalonariosDisponibles()
        cmbPuntoVenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", EntidadManager.IdTipoComprobante.Recibo, "X")
        cmbPuntoVenta.DataTextField = "Titulo"
        cmbPuntoVenta.DataValueField = "IdPuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0

        If cmbPuntoVenta.Items.Count = 0 Then
            MsgBoxAjax(Me, "No hay talonario para recibos")
        Else

            RefrescarNumeroTalonario()
        End If
    End Sub


    Sub RefrescarNumeroTalonario() 'esto tambien podría estar la mitad en el manager
        'está refrescando el talonario tambien en la "vista". Cómo condicionarlo?

        'txtLetra.Text = EntidadManager.LetraSegunTipoIVA(cmbCondicionIVA.SelectedValue)
        'lblLetra.Text = txtLetra.Text


        'If RadioButtonListEsInterna.SelectedItem.Value = 2 Then
        '    txtNumerorecibo2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaReciboInterna")
        'Else
        txtNumerorecibo2.Text = ReciboManager.ProximoNumeroReciboPorNumeroDePuntoVenta(SC, cmbPuntoVenta.SelectedItem.Text) 'ParametroOriginal(SC, "ProximoFactura")
        'End If

        'cmbPuntoVenta.SelectedIndex = 0


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

    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
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

                Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

                DePaginaHaciaObjeto(myRecibo)


                Dim ms As String
                If ReciboManager.IsValid(SC, myRecibo, ms) Then
                    Try
                        If ReciboManager.Save(SC, myRecibo) = -1 Then
                            MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.Message)
                    End Try



                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                    IdRecibo = myRecibo.Id




                    If myRecibo.NumeroRecibo <> StringToDecimal(txtNumerorecibo2.Text) Then
                        EndEditing("El recibo fue grabado con el número " & myRecibo.NumeroRecibo) 'me voy 
                        Exit Sub
                    Else
                        EndEditing("Desea imprimir el comprobante?")
                        Exit Sub
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
            'MsgBoxAjax(Me, ex.Message)
            ErrHandler.WriteError(ex)
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

        If MensajeFinal <> "" Then
            'Response.Write("<script>alert('message') ; window.location.href='Comparativas.aspx'</script>")

            'PreRedirectMsgbox.OnOkScript = "window.location = ""Comparativas.aspx"""
            'ButVolver.PostBackUrl = "Comparativas.aspx"
            LblPreRedirectMsgbox.Text = MensajeFinal
            PreRedirectMsgbox.Show()
            'el confirmbutton tambien me sirve si el usuario aprieta sin querer en el menu!!!!!! -no, no sirve para eso
        Else
            'PreRedirectConfirmButtonExtender.Enabled = False 'http://stackoverflow.com/questions/2096262/conditional-confirmbuttonextender
            Response.Redirect(String.Format("Recibos.aspx"))
        End If
    End Sub

    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("Recibos.aspx?Imprimir=" & IdRecibo))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("Recibos.aspx")) 'roundtrip al cuete?
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



    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'ModalPopupExtenderValor.Show()
    End Sub





    Protected Sub gvImputaciones_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvImputaciones.RowDataBound
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

                'e.Row.Cells(0).Text = "<strike>" + e.Row.Cells(0).Text + "</strike>"
                'e.Row.Cells(1).Text = "<strike>" + e.Row.Cells(1).Text + "</strike>"
                'e.Row.Cells(2).Text = "<strike>" + e.Row.Cells(2).Text + "</strike>"
                e.Row.Cells(2).Text = "<strike>" + e.Row.Cells(3).Text + "</strike>"


                Dim tb As Label = CType(e.Row.Cells(1).Controls(1), Label)
                tb.Text = "<strike>" + tb.Text + "</strike>"

                'e.Row.FindControl("Eliminar").text = "Restaurar" 'reemplazo el texto del eliminado

                'Dim b As LinkButton = e.Row.Cells(5).Controls(0)
                'b.Text = "Restaurar" 'reemplazo el texto del eliminado
                Dim b As ImageButton = e.Row.Cells(6).Controls(0)
                b.ImageUrl = "../Imagenes/reestablecer.png" 'reemplazo el texto del eliminado


            End If
        End If
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub gvImputaciones_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvImputaciones.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myRecibo As Pronto.ERP.BO.Recibo

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

                    'si esta eliminado, lo restaura
                    myRecibo.DetallesImputaciones(mIdItem).Eliminado = Not myRecibo.DetallesImputaciones(mIdItem).Eliminado


                    Me.ViewState.Add(mKey, myRecibo)
                    gvImputaciones.DataSource = myRecibo.DetallesImputaciones
                    gvImputaciones.DataBind()

                    UpdatePanelImputaciones.Update()
                    RecalcularRegistroContable()
                    RecalcularTotalComprobante()

                End If


                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
            ElseIf e.CommandName.ToLower = "editar" Then



                If gvImputaciones.EditIndex > -1 Then
                    'ya estaba editando


                    gvImputaciones.EditIndex = -1
                    Dim b As ImageButton = gvImputaciones.Rows(e.CommandArgument).Cells(7).Controls(0)
                    b.ImageUrl = "../Imagenes/editar.png"
                Else
                    'quiere editar
                    gvImputaciones.EditIndex = e.CommandArgument
                    Dim b As ImageButton = gvImputaciones.Rows(e.CommandArgument).Cells(7).Controls(0)
                    b.ImageUrl = "../Imagenes/aplicar.png" 'reemplazo el texto del eliminado

                End If


                RebindImp()
                UpdatePanelImputaciones.Update()
                '    ViewState("IdDetalleRecibo") = mIdItem
                '    If (Me.ViewState(mKey) IsNot Nothing) Then
                '        'MostrarElementos(True)
                '        myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
                '        With myRecibo.DetallesImputaciones(mIdItem)
                '            'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                '            .Eliminado = False


                '            'txtDetObservaciones.Text = .Observaciones

                '            txtDetValorImporte.Text = DecimalToString(.ImporteTotalItem)

                '        End With

                '        UpdatePanellValor.Update()
                '        ModalPopupExtenderValor.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                '    Else
                '        'y esto? por si es el renglon vacio?

                '        'txtDetCantidad.Text = 1
                '        'RadioButtonList1.Items(0).Selected = True
                '    End If





                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
            ElseIf e.CommandName.ToLower = "cmdCambioImporte" Then
                'editó el importe directo sobre la grilla

                ViewState("IdDetalleRecibo") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
                    With myRecibo.DetallesImputaciones(mIdItem)
                        .ImporteTotalItem = TextoWebControl(gvImputaciones.Rows(mIdItem).FindControl("txtGvImputacionesImporte"))
                    End With


                    Me.ViewState.Add(mKey, myRecibo)
                    gvImputaciones.DataSource = myRecibo.DetallesImputaciones
                    gvImputaciones.DataBind()
                    UpdatePanelImputaciones.Update()
                    mAltaItem = True

                    RecalcularRegistroContable()
                    RecalcularTotalComprobante()
                End If


            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.Message)
            Exit Sub
        End Try
    End Sub



    Protected Sub gvImputaciones_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvImputaciones.RowUpdating
        'se aplican los cambios editados
        With gvImputaciones.Rows(e.RowIndex)


            'Metodo con datatable
            ' Dim Id = gvImputaciones.DataKeys(e.RowIndex).Values(0).ToString()
            'Dim dt = TraerMetadata(HFSC.Value, Id)
            'Dim dr = dt.rows(0)

            'dr.Item("Descripcion") = TextoWebControl(.FindControl("txtDescripcion"))
            'dr.Item("Subcontratista1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtSubcontratista1")), HFSC.Value))
            'dr.Item("Subcontratista2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtSubcontratista2")), HFSC.Value))
            'dr.Item("CodigoONCAA") = TextoWebControl(.FindControl("txtCodigoONCAA"))

            'Update(HFSC.Value, dt)


            ''metodo con objetito
            'Dim o As New CDPMailFiltro
            'o.Emails = TextoWebControl(.FindControl("txtEmails")) 'txtEmails.Text
            'o.Vendedor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtVendedor")), HFSC.Value)
            'o.CuentaOrden1 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden1")), HFSC.Value)
            'o.CuentaOrden2 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden2")), HFSC.Value)
            'o.Corredor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCorredor")), HFSC.Value)
            'o.Entregador = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtEntregador")), HFSC.Value)
            'o.IdArticulo = CType(.FindControl("cmbArticulo"), DropDownList).SelectedValue

            'Update(HFSC.Value, gvImputaciones.DataKeys(e.RowIndex).Values(0).ToString(), o.Emails, o.Entregador, o.IdArticulo)
        End With

        gvImputaciones.EditIndex = -1
        RebindImp() 'hay que volver a pedir los datos...

    End Sub

    Protected Sub gvImputaciones_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvImputaciones.RowEditing
        'se empieza a editar un renglon
        gvImputaciones.EditIndex = e.NewEditIndex
        RebindImp() 'hay que volver a pedir los datos...
    End Sub

    Protected Sub gvImputaciones_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvImputaciones.RowCancelingEdit
        'se cancelan los datos editados
        gvImputaciones.EditIndex = -1
        RebindImp() 'hay que volver a pedir los datos...
    End Sub





    Protected Sub txtGvImputacionesImporte_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb1 As TextBox = CType(sender, TextBox)

        Dim mIdItem As Integer '= Val(tb1.NamingContainer)



        Dim gvr As GridViewRow = CType(tb1.Parent.Parent, GridViewRow)
        mIdItem = gvr.DataItemIndex
        'gvr.DataItem

        ' int i = edititem.ItemIndex; 

        ViewState("IdDetalleRecibo") = mIdItem
        If (Me.ViewState(mKey) IsNot Nothing) Then
            'MostrarElementos(True)
            Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
            With myRecibo.DetallesImputaciones(mIdItem)
                Dim ImporteIngresado As Double = TextoWebControl(gvImputaciones.Rows(gvr.RowIndex).FindControl("txtGvImputacionesImporte"))
                Dim Saldo As Double = TextoWebControl(gvImputaciones.Rows(gvr.RowIndex).FindControl("txtGvImputacionesImporte"))
                If ImporteIngresado > .SaldoParteEnPesosAnterior Or ImporteIngresado < 0 Then
                    MsgBoxAjax(Me, "El importe debe ser menor que el saldo")
                    Exit Sub
                End If

                .ImporteTotalItem = ImporteIngresado
                .Importe = .ImporteTotalItem
            End With



            Me.ViewState.Add(mKey, myRecibo)

            gvImputaciones.EditIndex = -1
            RebindImp()

            gvImputaciones.DataSource = myRecibo.DetallesImputaciones
            gvImputaciones.DataBind()
            UpdatePanelImputaciones.Update()
            mAltaItem = True



            RecalcularRegistroContable()
            RecalcularTotalComprobante()
        End If

    End Sub





    Sub RebindImp()
        Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
        gvImputaciones.DataSource = myRecibo.DetallesImputaciones
        gvImputaciones.DataBind()

        gvImputaciones.FooterRow.Cells(3).Text = myRecibo.TotalImputaciones
        UpdatePanelImputaciones.Update()
    End Sub






    Protected Sub gvvalores_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvValores.RowDataBound
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

                'Dim b As LinkButton = e.Row.Cells(5).Controls(0)
                'b.Text = "Restaurar" 'reemplazo el texto del eliminado
                Dim b As ImageButton = e.Row.Cells(6).Controls(0)
                b.ImageUrl = "../Imagenes/reestablecer.png" 'reemplazo el texto del eliminado


            End If
        End If
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
    Protected Sub LinkButtonValor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonValor.Click
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleRecibo") = -1
        'cmbCuentaGasto.SelectedIndex = 1
        'txtCodigo.Text = 0
        txt_AC_Articulo.Text = ""
        SelectedAutoCompleteIDArticulo.Value = 0
        'txtDetCantidad.Text = 0
        'MostrarElementos(True) 'si no se usa el popup

        BuscaTextoEnCombo(cmbDetValorTipo, "Cheque")
        BuscaIDEnCombo(cmbDetValorBancoOrigen, -1)
        BuscaIDEnCombo(cmbDetValorBancoCuenta, -1)
        BuscaIDEnCombo(cmbDetValorGrupoCuentaContable, -1)
        BuscaIDEnCombo(cmbDetValorCuentaContable, -1)



        txtDetValorNumeroInterno.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNumeroInterno")


        txtDetValorCheque.Text = ""
        txtDetValorCUIT.Text = ""
        txtDetValorNumeroTransferencia.Text = ""
        txtDetValorImporte.Text = ""

        txtDetValorVencimiento.Text = ""

        'Dim eselprimero As Boolean = False
        'If Not eselprimero Then 'creo un nuevo renglon
        '    ViewState("IdDetalleRecibo") = -1
        '    cmbCuentaGasto.SelectedIndex = 1
        '    txtCodigo.Text = 0
        '    txtCantidad.Text = 0
        '    MostrarElementos(True)
        'Else 'uso el vacío por default
        '    'gvImputaciones_RowCommand()
        'End If


        'Cuando agrega un renglon, deshabilito algunos combos
        'cmbObra.Enabled = False
        'cmbCuenta.Enabled = False

        UpdatePanellValorAux.Update()
        ModalPopupExtenderValor.Show()

    End Sub


    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub gvvalores_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvValores.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myRecibo As Pronto.ERP.BO.Recibo

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

                    'si esta eliminado, lo restaura
                    myRecibo.DetallesValores(mIdItem).Eliminado = Not myRecibo.DetallesValores(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myRecibo)
                    gvValores.DataSource = myRecibo.DetallesValores
                    gvValores.DataBind()

                    RecalcularRegistroContable()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleRecibo") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)


                    If myRecibo.DetallesValores(mIdItem).IdCaja <> 0 Then
                        'es una caja

                        With myRecibo.DetallesValores(mIdItem)
                            'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo
                            .Eliminado = False
                            BuscaIDEnCombo(cmbDetValorTipo, .IdTipoValor)
                            txtDetValorImporte.Text = DecimalToString(.ImporteTotalItem)
                        End With

                        UpdatePanelCaja.Update()
                        ModalPopupExtenderCaja.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?

                    Else
                        'es un cheque o valor

                        With myRecibo.DetallesValores(mIdItem)
                            'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                            .Eliminado = False

                            BuscaIDEnCombo(cmbDetValorTipo, .IdTipoValor)
                            BuscaIDEnCombo(cmbDetValorBancoOrigen, .IdBanco)
                            BuscaIDEnCombo(cmbDetValorBancoCuenta, .IdCuentaBancariaTransferencia)
                            BuscaIDEnCombo(cmbDetValorGrupoCuentaContable, .IdTipoCuentaGrupo)
                            BuscaIDEnCombo(cmbDetValorCuentaContable, .IdCuenta)

                            txtDetValorNumeroInterno.Text = .NumeroInterno
                            txtDetValorCheque.Text = .NumeroValor
                            txtDetValorCUIT.Text = .CuitLibrador
                            txtDetValorNumeroTransferencia.Text = .NumeroTransferencia
                            txtDetValorImporte.Text = .Importe

                            txtDetValorVencimiento.Text = .FechaVencimiento
                            txtDetValorImporte.Text = DecimalToString(.ImporteTotalItem)
                            'txtDetIVA.Text = DecimalToString(.PorcentajeIVA)
                            'txtDetBonif.Text = DecimalToString(._PorcentajeBonificacion)


                        End With

                        UpdatePanellValorAux.Update()
                        ModalPopupExtenderValor.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                    End If
                Else
                    'y esto? por si es el renglon vacio?

                    'txtDetCantidad.Text = 1
                    'RadioButtonList1.Items(0).Selected = True
                End If

            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.Message)
            Exit Sub
        End Try
    End Sub




    Protected Sub gvCuentas_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvCuentas.RowDataBound
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

                'Dim b As LinkButton = e.Row.Cells(5).Controls(0)
                'b.Text = "Restaurar" 'reemplazo el texto del eliminado
                Dim b As ImageButton = e.Row.Cells(5).Controls(0)
                b.ImageUrl = "../Imagenes/reestablecer.png" 'reemplazo el texto del eliminado


            End If
        End If
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////
    Protected Sub LinkButtonAsiento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonAsiento.Click

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleRecibo") = -1



        BuscaIDEnCombo(cmbDetAsientoObra, -1)
        'BuscaIDEnCombo(cmbDetAsientoCuenta, -1)
        txtAsientoAC_Cuenta.Text = ""
        BuscaIDEnCombo(cmbDetAsientoCuentaBanco, -1)
        BuscaIDEnCombo(cmbDetAsientoCuentaGasto, -1)
        BuscaIDEnCombo(cmbDetAsientoCaja, -1)
        BuscaIDEnCombo(cmbDetAsientoMoneda, -1)

        txtDetAsientoDebe.Text = ""
        txtDetAsientoHaber.Text = ""

        txtDetValorImporte.Text = ""

        UpdatePanelAsiento.Update()
        ModalPopupExtenderAsiento.Show()
    End Sub


    Protected Sub gvRubrosContables_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvRubrosContables.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myRecibo As Pronto.ERP.BO.Recibo

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

                    'si esta eliminado, lo restaura
                    myRecibo.DetallesRubrosContables(mIdItem).Eliminado = Not myRecibo.DetallesRubrosContables(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myRecibo)
                    gvRubrosContables.DataSource = myRecibo.DetallesRubrosContables
                    gvRubrosContables.DataBind()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleRecibo") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
                    With myRecibo.DetallesRubrosContables(mIdItem)
                        'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                        .Eliminado = False

                        BuscaIDEnCombo(cmbDetRubroRubro, .IdRubroContable)
                        txtDetRubroImporte.Text = .ImporteTotalItem


                    End With

                    UpdatePanelRubros.Update()
                    ModalPopupExtenderRubro.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                Else
                    'y esto? por si es el renglon vacio?

                    'txtDetCantidad.Text = 1
                    'RadioButtonList1.Items(0).Selected = True
                End If

            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.Message)
            Exit Sub
        End Try
    End Sub

    Protected Sub gvCuentas_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvCuentas.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myRecibo As Pronto.ERP.BO.Recibo

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

                    'si esta eliminado, lo restaura
                    myRecibo.DetallesCuentas(mIdItem).Eliminado = Not myRecibo.DetallesCuentas(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myRecibo)
                    gvCuentas.DataSource = myRecibo.DetallesCuentas
                    gvCuentas.DataBind()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleRecibo") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myRecibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
                    With myRecibo.DetallesCuentas(mIdItem)
                        'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                        .Eliminado = False



                        BuscaIDEnCombo(cmbDetAsientoObra, .IdObra)
                        txtAsientoAC_Cuenta.Text = NombreCuenta(SC, .IdCuenta)
                        ' BuscaIDEnCombo(cmbDetAsientoCuenta, .IdCuenta)
                        BuscaIDEnCombo(cmbDetAsientoCuentaBanco, .IdCuentaBancaria)
                        BuscaIDEnCombo(cmbDetAsientoCuentaGasto, .IdCuentaGasto)
                        BuscaIDEnCombo(cmbDetAsientoCaja, .IdCaja)
                        BuscaIDEnCombo(cmbDetAsientoMoneda, .IdMoneda)

                        txtDetAsientoDebe.Text = .Debe
                        txtDetAsientoHaber.Text = .Haber

                        txtDetValorImporte.Text = DecimalToString(.ImporteTotalItem)


                        'txtDetIVA.Text = DecimalToString(.PorcentajeIVA)
                        'txtDetBonif.Text = DecimalToString(._PorcentajeBonificacion)


                        'txtDetTotal.Text = .ImporteTotalItem
                        'txtDetTotal.Text = .Cantidad * .Precio * .ImporteIVA

                        'cmbIVA.Text = DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1)
                        'BuscaTextoEnCombo(cmbIVA, DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1))


                        'txtObservacionesItem.Text = myRecibo.Detalles(mIdItem).Observaciones.ToString
                        'txtFechaNecesidad.Text = myRecibo.Detalles(mIdItem).FechaEntrega.ToString
                        'If myRecibo.Detalles(mIdItem).OrigenDescripcion = 1 Then
                        '    RadioButtonList1.Items(0).Selected = True
                        'ElseIf myRecibo.Detalles(mIdItem).OrigenDescripcion = 2 Then
                        '    RadioButtonList1.Items(1).Selected = True
                        'ElseIf myRecibo.Detalles(mIdItem).OrigenDescripcion = 3 Then
                        '    RadioButtonList1.Items(2).Selected = True
                        'Else
                        '    RadioButtonList1.Items(0).Selected = True
                        'End If
                    End With

                    UpdatePanelAsiento.Update()
                    ModalPopupExtenderAsiento.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?
                Else
                    'y esto? por si es el renglon vacio?

                    'txtDetCantidad.Text = 1
                    'RadioButtonList1.Items(0).Selected = True
                End If

            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.Message)
            Exit Sub
        End Try
    End Sub

    Protected Sub btnSaveItemValor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemValor.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleRecibo"), Integer)
            Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

            'acá tengo que traer el valor id del hidden


            If txtDetValorCUIT.Enabled And Val(txtDetValorCUIT.Text) <> 0 And Not mkf_validacuit(Val(txtDetValorCUIT.Text)) Then
                ModalPopupExtenderValor.Show()
                MsgBoxAjax(Me, "El CUIT no es valido")
                Exit Sub
            End If


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As ReciboValoresItem = New Pronto.ERP.BO.ReciboValoresItem

                If myRecibo.DetallesImputaciones Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myRecibo.DetallesValores.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myRecibo.DetallesValores.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myRecibo.DetallesValores(mIdItem)


                    .IdTipoValor = cmbDetValorTipo.SelectedValue
                    .Tipo = cmbDetValorTipo.SelectedItem.Text
                    .IdBanco = cmbDetValorBancoOrigen.SelectedValue
                    .NumeroInterno = Val(txtDetValorNumeroInterno.Text)
                    .IdCuentaBancariaTransferencia = cmbDetValorBancoCuenta.SelectedValue
                    .NumeroValor = Val(txtDetValorCheque.Text)
                    .CuitLibrador = Val(txtDetValorCUIT.Text)
                    .NumeroTransferencia = Val(txtDetValorNumeroTransferencia.Text)
                    .IdTipoCuentaGrupo = cmbDetValorGrupoCuentaContable.SelectedValue
                    .IdCuenta = cmbDetValorCuentaContable.SelectedValue
                    .Importe = StringToDecimal(txtDetValorImporte.Text)
                    .FechaVencimiento = iisValidSqlDate(txtDetValorVencimiento.Text)


                    ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNumeroInterno", .NumeroInterno + 1)


                    .ImporteTotalItem = StringToDecimal(txtDetValorImporte.Text)


                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////


                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With





                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.Message)
                Exit Sub
            End Try


            Me.ViewState.Add(mKey, myRecibo)
            gvValores.DataSource = myRecibo.DetallesValores
            gvValores.DataBind()



            RecalcularRegistroContable()
            RecalcularTotalComprobante()
            UpdatePanelValores.Update()
            UpdatePanelAsiento.Update()

        End If

        'MostrarElementos(False)
        mAltaItem = True
    End Sub



    Protected Sub btnSaveItemCaja_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemCaja.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleRecibo"), Integer)
            Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As ReciboValoresItem = New Pronto.ERP.BO.ReciboValoresItem

                If myRecibo.DetallesValores Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myRecibo.DetallesValores.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myRecibo.DetallesValores.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myRecibo.DetallesValores(mIdItem)
                    'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
                    ' de cada valor, como se hace en toda web

                    'ORIGINAL EDU:
                    '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
                    '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
                    'MODIFICADO CON AUTOCOMPLETE:

                    '.IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
                    '.Articulo = txt_AC_Articulo.Text
                    '.FechaEntrega = ProntoFuncionesGenerales.iisValidSqlDate(txtDetFechaEntrega.Text)

                    '.Cantidad = StringToDecimal(txtDetCantidad.Text)
                    '.Precio = StringToDecimal(txtDetValorImporte.Text)
                    '.PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
                    '.PorcentajeIVA = StringToDecimal(txtDetIVA.Text)

                    '.ImporteTotalItem = StringToDecimal(txtDetTotal.Text)
                    '.IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)
                    '.Unidad = cmbDetUnidades.SelectedItem.Text
                    '.ArchivoAdjunto1 = FileUpLoad2.FileName


                    '.IdConcepto = cmbDetConcepto.SelectedValue
                    '.Concepto = cmbDetConcepto.SelectedItem.Text


                    .IdCaja = cmbDetCaja.SelectedValue
                    .Tipo = cmbDetCaja.SelectedItem.Text
                    .Importe = StringToDecimal(txtDetCajaImporte.Text)
                    .FechaVencimiento = Nothing
                    '.IdCaja = cmbDetCaja.SelectedValue
                    '.Gravado = IIf(RadioButtonListGravado.SelectedItem.Value = 1, "SI", "NO")

                    'total

                    '.ArchivoAdjunto1
                    '.ArchivoAdjunto2


                    '.OrigenDescripcion = 1 'como por ahora no tengo el option button, le pongo siempre 1



                    '///////////////////////////////////////////////////////////////
                    'valores que me traigo del encabezado y ensoqueto en el renglon
                    '///////////////////////////////////////////////////////////////
                    '.IdObra = cmbObra.SelectedValue

                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////

                    '.IdCuentaGasto = cmbCuentaGasto.SelectedValue
                    '.CuentaGastoDescripcion = cmbCuentaGasto.SelectedItem.Text
                    '.IdDetalleObraDestino = IIf(cmbDestino.SelectedValue = "", Nothing, cmbDestino.SelectedValue)



                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////
                    'no entiendo cómo se asigna la IdCuenta del detalle a partir de la IdCuentaGasto
                    'acá busca la cuentaGasto. Si no la encuentra, en el siguiente sp ya no toma
                    ' en cuenta la obra

                    'Dim ds As System.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorObraCuentaGasto", .IdObra, .IdCuentaGasto, DBNull.Value)
                    'If ds.Tables(0).Rows.Count > 0 Then
                    '    .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
                    '    '.CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
                    'Else

                    '    ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorCodigo", Mid(cmbCuentaGasto.SelectedItem.Text, InStrRev(cmbCuentaGasto.SelectedItem.Text, " ") + 1), DBNull.Value)
                    '    If ds.Tables(0).Rows.Count > 0 Then
                    '        .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
                    '        '.CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
                    '    Else
                    '        MsgBoxAjax(me,"No se encuentra la cuenta de la obra correspodiente a esta cuenta de gasto")
                    '        Exit Sub
                    '    End If
                    '    '   oRsAux1.Close()
                    '    '   oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaGasto)
                    '    '   If oRsAux1.RecordCount > 0 Then
                    '    '    mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                    '    '    'OK, acá se trajo el mIdCuenta. y el mIdCuentaGasto? Queda en cero, no?
                    '    '    '-en el codigo no lo vuelve a asignar....
                    '    '    mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                    '    '   End If
                    'End If


                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////


                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With




                    'If mIdCuentaIvaCompras1 <> 0 Then
                    '    .IdCuentaIvaCompras1 = mIdCuentaIvaCompras1
                    '    .IVAComprasPorcentaje1 = StringToDecimal(cmbIVA.SelectedValue)
                    '    .ImporteIVA1 = Math.Round(cmbIVA.SelectedValue / 100 * .ImporteTotalItem, 2)
                    '    .AplicarIVA1 = "SI"
                    'Else
                    '    .IdCuentaIvaCompras1 = 0
                    '    .IVAComprasPorcentaje1 = 0
                    '    .ImporteIVA1 = 0
                    '    .AplicarIVA1 = "NO"
                    'End If



                    'If mIdCuentaIvaCompras1 <> 0 Then
                    '    .IdCuentaIvaCompras1 = mIdCuentaIvaCompras1
                    '    .IVAComprasPorcentaje1 = mPorcentajeIVA
                    '    .ImporteIVA1 = Round(mIva1, 2)
                    '    .AplicarIVA1 = "SI"
                    'Else
                    '    .IdCuentaIvaCompras1 = 0
                    '    .IVAComprasPorcentaje1 = 0
                    '    .ImporteIVA1 = 0
                    '    .AplicarIVA1 = "NO"
                    'End If
                    '.IdCuentaIvaCompras2 = Nothing
                    '.IVAComprasPorcentaje2 = 0
                    '.ImporteIVA2 = 0
                    '.AplicarIVA2 = "NO"
                    '.IdCuentaIvaCompras3 = Nothing
                    '.IVAComprasPorcentaje3 = 0
                    '.ImporteIVA3 = 0
                    '.AplicarIVA3 = "NO"
                    '.IdCuentaIvaCompras4 = Nothing
                    '.IVAComprasPorcentaje4 = 0
                    '.ImporteIVA4 = 0
                    '.AplicarIVA4 = "NO"
                    '.IdCuentaIvaCompras5 = Nothing
                    '.IVAComprasPorcentaje5 = 0
                    '.ImporteIVA5 = 0
                    '.AplicarIVA5 = "NO"
                    '.IdCuentaIvaCompras6 = Nothing
                    '.IVAComprasPorcentaje6 = 0
                    '.ImporteIVA6 = 0
                    '.AplicarIVA6 = "NO"
                    '.IdCuentaIvaCompras7 = Nothing
                    '.IVAComprasPorcentaje7 = 0
                    '.ImporteIVA7 = 0
                    '.AplicarIVA7 = "NO"
                    '.IdCuentaIvaCompras8 = Nothing
                    '.IVAComprasPorcentaje8 = 0
                    '.ImporteIVA8 = 0
                    '.AplicarIVA8 = "NO"
                    '.IdCuentaIvaCompras9 = Nothing
                    '.IVAComprasPorcentaje9 = 0
                    '.ImporteIVA9 = 0
                    '.AplicarIVA9 = "NO"
                    '.IdCuentaIvaCompras10 = Nothing
                    '.IVAComprasPorcentaje10 = 0
                    '.ImporteIVA10 = 0
                    '.AplicarIVA10 = "NO"



                    '.FechaEntrega = Convert.ToDateTime(txtFechaNecesidad.Text)
                    '.Observaciones = txtObservacionesItem.Text.ToString
                    '.OrigenDescripcion = RadioButtonList1.SelectedItem.Value

                    'TO DO
                    '.FechaNecesidad = #1/1/2009#
                    '.FechaDadoPorCumplido = #1/1/2009#
                    '.FechaAsignacionCosto = #1/1/2009#
                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.Message)
                Exit Sub
            End Try


            Me.ViewState.Add(mKey, myRecibo)
            gvValores.DataSource = myRecibo.DetallesValores
            gvValores.DataBind()


            UpdatePanelAsiento.Update()


            DePaginaHaciaObjeto(myRecibo)


            RecalcularRegistroContable()


            RecalcularTotalComprobante()

        End If

        'MostrarElementos(False)
        mAltaItem = True
    End Sub


    Protected Sub btnSaveItemAsiento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemAsiento.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleRecibo"), Integer)
            Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As ReciboCuentasItem = New Pronto.ERP.BO.ReciboCuentasItem

                If myRecibo.DetallesCuentas Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myRecibo.DetallesCuentas.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myRecibo.DetallesCuentas.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myRecibo.DetallesCuentas(mIdItem)


                    .IdObra = cmbDetAsientoObra.SelectedValue
                    .IdCuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAsientoAC_Cuenta.Text, SC)
                    'cmbDetAsientoCuenta.SelectedValue()
                    .CodigoCuenta = EntidadManager.GetItem(SC, "Cuentas", .IdCuenta).Item("Codigo")
                    .DescripcionCuenta = EntidadManager.NombreCuenta(SC, .IdCuenta)
                    .IdCuentaBancaria = cmbDetAsientoCuentaBanco.SelectedValue
                    .IdCuentaGasto = cmbDetAsientoCuentaGasto.SelectedValue
                    .IdCaja = cmbDetAsientoCaja.SelectedValue
                    .IdMoneda = cmbDetAsientoMoneda.SelectedValue
                    .Debe = StringToDecimal(txtDetAsientoDebe.Text)
                    .Haber = StringToDecimal(txtDetAsientoHaber.Text)




                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With





                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.Message)
                Exit Sub
            End Try


            Me.ViewState.Add(mKey, myRecibo)
            gvCuentas.DataSource = myRecibo.DetallesCuentas
            gvCuentas.DataBind()

            RecalcularTotalComprobante()

            RecalcularRegistroContable()

            UpdatePanelAsiento.Update()

        End If

        'MostrarElementos(False)
        mAltaItem = True
    End Sub

    Protected Sub btnSaveItemRubro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemRubro.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleRecibo"), Integer)
            Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As ReciboRubrosContablesItem = New Pronto.ERP.BO.ReciboRubrosContablesItem

                If myRecibo.DetallesRubrosContables Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myRecibo.DetallesRubrosContables.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myRecibo.DetallesRubrosContables.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myRecibo.DetallesRubrosContables(mIdItem)
                    'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
                    ' de cada valor, como se hace en toda web



                    .IdRubroContable = cmbDetRubroRubro.SelectedValue
                    .DescripcionRubroContable = EntidadManager.NombreRubroContable(SC, .IdRubroContable)
                    .ImporteTotalItem = StringToDecimal(txtDetRubroImporte.Text)
                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////


                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With




                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.Message)
                Exit Sub
            End Try

            RecalcularTotalComprobante()

            Me.ViewState.Add(mKey, myRecibo)
            gvRubrosContables.DataSource = myRecibo.DetallesRubrosContables
            gvRubrosContables.DataBind()

            UpdatePanelRubros.Update()

        End If

        'MostrarElementos(False)
        mAltaItem = True
    End Sub
    'Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
    '    'MostrarElementos(False)
    '    mAltaItem = True
    'End Sub






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
                MostrarBotonesParaAdjuntar()
            Catch ex As Exception
                MsgBoxAjax(Me, ex.Message)
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
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                    Response.TransmitFile(FilePath)
                    'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON.Fields(".Fields(".Fields(".Fields("

                    ''Write the file directly to the HTTP output stream.
                    'Response.WriteFile(FilePath)
                    Response.End()



                Catch ex As Exception
                    MsgBoxAjax(Me, ex.Message)
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
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                    Response.TransmitFile(FilePath)
                    'RECORDAR AGRWGAR EL PostBackTrigger POR CADA LINKBUTTON.Fields(".Fields(".Fields(".Fields("


                    ''Write the file directly to the HTTP output stream.
                    'Response.WriteFile(FilePath)
                    Response.End()



                Catch ex As Exception
                    MsgBoxAjax(Me, ex.Message)
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
            Dim ds As DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", Id)
            If ds.Tables(0).Rows.Count > 0 Then
                'txtCodigo.Text = ds.Tables(0).Rows(0).Item("Codigo").ToString
            End If
        End If

    End Sub

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="IdMoneda"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>


    'Protected Sub txtCodigo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCodigo.TextChanged

    '    If Len(txtCodigo.Text) > 0 Then
    '        Dim ds As System.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorCodigo", txtCodigo.Text)
    '        If ds.Tables(0).Rows.Count > 0 Then
    '            'cmbArticulos.SelectedValue = ds.Tables(0).Rows(0).Item(0)
    '        End If
    '    End If

    'End Sub


    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click

        'If cmbLibero.SelectedValue > 0 Then
        '    Dim ds As System.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Empleados", "T", cmbLibero.SelectedValue)
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


    'Protected Sub cmbCuenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCuenta.SelectedIndexChanged
    '   txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"), 1)
    '   TraerObrasAsociadaAlaCuentaFF()
    'End Sub


    Sub TraerObrasAsociadaAlaCuentaFF() 'relacion varios-->uno


        ''Lleno el combo
        'cmbObra.DataSource = EntidadManager.GetListTX(SC, "Obras", "TX_PorIdCuentaFFParaCombo", cmbCuenta.SelectedValue)
        'If cmbObra.DataSource.Tables(0).Rows.Count = 0 Then
        '    cmbObra.DataSource = ObraManager.GetListCombo(SC)

        '    'ElseIf cmbObra.DataSource.Tables(0).Rows.Count = 1 Then
        'End If
        'cmbObra.DataTextField = "Titulo"
        'cmbObra.DataValueField = "IdObra"
        'cmbObra.DataBind()


        ''Veo si asigno un valor default
        'If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
        '    If Not BuscaIDEnCombo(cmbObra, session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
        '        MsgBoxAjax(me,"La obra asignada al empleado no se encuentra en la lista de obras disponibles para la cuenta de fondo fijo")
        '    Else
        '        Return 'encontró la obra y la asignó. Me las tomo
        '    End If
        'End If



        'If cmbObra.DataSource.Tables(0).Rows.Count > 1 Then
        '    'Agrego línea vacía
        '    cmbObra.Items.Insert(0, New ListItem("-- Elija una Obra --", -1))
        '    cmbObra.SelectedIndex = 0
        'End If

    End Sub

    Sub TraerCuentaFFAsociadaAObra() 'relacion uno-->varios
    End Sub


    'Protected Sub cmbObra_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbObra.SelectedIndexChanged
    '    If cmbObra.SelectedValue = -1 Then
    '        cmbCuentaGasto.DataSource = EntidadManager.GetListTX(SC, "CuentasGastos", "TL")
    '    Else
    '        cmbCuentaGasto.DataSource = EntidadManager.GetListTX(SC, "Cuentas", "TX_CuentasGastoPorObraParaCombo", cmbObra.SelectedValue, System.DBNull.Value)
    '    End If
    '    cmbCuentaGasto.DataTextField = "Titulo"
    '    cmbCuentaGasto.DataValueField = "IdCuentaGasto"
    '    cmbCuentaGasto.DataBind()
    'End Sub


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

    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Popup
    Protected Sub txtCodigo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCodigo.TextChanged
        If Len(txtCodigo.Text) <> 0 Then
            Dim oRs As adodb.Recordset
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


    Protected Sub btnRecalcularTotal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecalcularTotal.Click ', txtDetCantidad.TextChanged, txtDetBonif.TextChanged, txtDetValorImporte.TextChanged
        RecalcularTotalDetalle()
    End Sub

    Sub RecalcularTotalDetalle()
        'txtDetTotal.Text = 2432.4

        'Dim mImporte = StringToDecimal(txtDetCantidad.Text) * StringToDecimal(txtDetValorImporte.Text)
        'Dim mBonificacion = Math.Round(mImporte * Val(txtDetBonif.Text) / 100, 4)
        'Dim mIVA = Math.Round((mImporte - mBonificacion) * Val(txtDetIVA.Text) / 100, 4)
        'txtDetTotal.Text = FF2(mImporte - mBonificacion + mIVA)

        'UpdatePanellValorPreciosYCantidades.Update()
    End Sub

    'Protected Sub txtDetCantidad_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetCantidad.TextChanged
    '    RecalcularTotalDetalle()
    'End Sub

    Protected Sub txtImporte_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetValorImporte.TextChanged
        RecalcularTotalDetalle()
    End Sub

    'Protected Sub txtDetIVA_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetIVA.TextChanged
    '    RecalcularTotalDetalle()
    'End Sub

    'Protected Sub txtDetBonif_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetBonif.TextChanged
    '    RecalcularTotalDetalle()
    'End Sub

    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Pagina Principal de ABM

    Sub RecalcularTotalComprobante()
        Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
        Try
            'myRecibo.Bonificacion = StringToDecimal(txtTotBonif.Text)


            With myRecibo
                .RetencionIVA = Val(txtTotalRetencionIVA.Text)
                .RetencionGanancias = Val(txtTotalRetencionGanancias.Text)
                .Otros1 = StringToDecimal(txtOtrosImporte1.Text)
                .Otros2 = StringToDecimal(txtOtrosImporte2.Text)
                .Otros3 = StringToDecimal(txtOtrosImporte3.Text)
                .Otros4 = StringToDecimal(txtOtrosImporte4.Text)
                .Otros5 = StringToDecimal(txtOtrosImporte5.Text)


                ReciboManager.RecalcularTotales(myRecibo)




                txtTotalRetencionIVA.Text = FF2(.RetencionIVA)
                'txtBonificacionPorItem.Text = FF2(.RetencionGanancias)
                txtTotalRetencionGanancias.Text = FF2(.RetencionGanancias)
                'lblTotSubGravado.Text = FF2(.TotalSubGravado)
                'lblTotIVA.Text = FF2(.ImporteIva1)
                'lblPercepcionIVA.Text = FF2(.PercepcionIVA)
                lblTotalOtrosConceptos.Text = FF2(.TotalOtrosConceptos)
                lblTotalDiferencia.Text = FF2(.TotalDiferencia)



                Try
                    'está explotando cuando veo recibos que se grabaron 
                    'sin valores, y entonces la grilla no tiene pie, y entonces esssplota
                    gvImputaciones.FooterRow.Cells(3).Text = .TotalImputaciones
                    gvValores.FooterRow.Cells(4).Text = .TotalValores
                    gvCuentas.FooterRow.Cells(2).Text = .TotalDebe
                    gvCuentas.FooterRow.Cells(3).Text = .TotalHaber

                Catch ex As Exception

                End Try


            End With

            UpdatePanelTotales.Update()
            UpdatePanelImputaciones.Update()
            UpdatePanelAsiento.Update()
            UpdatePanelValores.Update()

        Catch ex As Exception
            Err.Raise(4646)
            'MsgBoxAjax(Me, ex.Message)
        End Try
    End Sub




    'Protected Sub btnLiberar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
    '    'Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
    '    'myRecibo.ConfirmadoPorWeb = "SI"


    '    Dim mOk As Boolean
    '    Page.Validate("Encabezado")
    '    mOk = Page.IsValid

    '    Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
    '    If Not ReciboManager.IsValid(myRecibo) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
    '        mOk = False
    '        MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
    '    End If
    '    If mOk Then
    '        ModalPopupExtender4.Show()
    '    Else
    '        'MsgBoxAjax(Me, "El objeto no es válido")
    '    End If
    '    'myRecibo.Aprobo = "SI" 'este es cuando lo aprueba el usario pronto
    'End Sub









    '////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////

    Protected Sub ObjectDataSource2_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource2.Selecting
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        Dim idcliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value).ToString
        e.InputParameters("Parametros") = New String() {idcliente.ToString}

        Static Dim ObjectDataSource2Mostrar As Boolean = False

        'If txtBuscaGrillaImputaciones.Text = "buscar" Then
        If Not IsPostBack Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        ObjectDataSource2Mostrar = False
    End Sub




    Protected Sub btnSaveItemImputacionAux_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemImputacionAux.Click


        Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        With gvAuxPendientesImputar
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


                        Dim idCtaCte As Integer = .DataKeys(fila.RowIndex).Values.Item("IdCtaCte")
                        'Dim oOC As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idOC, True)
                        'Dim oDetOC As OrdenCompraItem
                        'Dim idDetOC As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleOrdenCompra")
                        'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)


                        '///////////////////////////////////////////////////////////
                        'Si copio de varios RMs, de cual copio los datos de encabezado? 
                        '///////////////////////////////////////////////////////////
                        'myPresupuesto.IdPlazoEntrega=oRM.
                        'myPresupuesto.Validez=oRM.
                        'oDetRM.Id


                        '///////////////////////////////////////////////////////////
                        'lo pongo en la solicitud  
                        'migrado de frmPresupuesto.Lista.OLEDragDrop()
                        '///////////////////////////////////////////////////////////

                        'me fijo si ya existe en el detalle
                        If myRecibo.DetallesImputaciones.Find(Function(obj) obj.IdImputacion = idCtaCte) Is Nothing Then

                            Dim mItem As ReciboItem = New Pronto.ERP.BO.ReciboItem

                            With mItem
                                'vendría a ser el código de frmRecibo.Editar

                                .Id = myRecibo.DetallesImputaciones.Count
                                .Nuevo = True

                                .IdImputacion = idCtaCte
                                .TipoComprobanteImputado = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Comp_")

                                .SaldoParteEnPesosAnterior = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_")
                                .FechaComprobanteImputado = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Fecha")
                                .TotalComprobanteImputado = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Imp_orig_")

                                '.idcuenta()
                                '.Registro.Fields("SaldoParteEnDolaresAnterior").Value = vSaldos(0)
                                '.Registro.Fields("PagadoParteEnDolares").Value = vSaldos(1)
                                '.Registro.Fields("NuevoSaldoParteEnDolares").Value = vSaldos(2)
                                '.Registro.Fields("SaldoParteEnPesosAnterior").Value = vSaldos(3)
                                '.Registro.Fields("PagadoParteEnPesos").Value = vSaldos(4)
                                '.Registro.Fields("NuevoSaldoParteEnPesos").Value = vSaldos(5)




                                Try
                                    .NumeroComprobanteImputado = Mid(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero"), InStrRev(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero"), "-"))
                                Catch ex As Exception

                                End Try

                                '.ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & " " &  & "-" & Format(.NumeroComprobanteImputado, "00000000")
                                .ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & " " & gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero")




                                .Importe = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_")
                                'CargarDatosDesdeItemOrdenCompra(mItem, idDetOC)









                            End With

                            myRecibo.DetallesImputaciones.Add(mItem)



                        Else
                            MsgBoxAjax(Me, "El renglon de imputacion " & idCtaCte & " ya está en el detalle")
                        End If


                    End If
                End If
            Next
        End With


        Me.ViewState.Add(mKey, myRecibo)
        gvImputaciones.DataSource = myRecibo.DetallesImputaciones
        gvImputaciones.DataBind()
        UpdatePanelImputaciones.Update()
        mAltaItem = True

        RecalcularRegistroContable()
        RecalcularTotalComprobante()

        ModalPopupExtenderImputacion.Hide()



    End Sub


    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        'boton de cierre de grilla popup de copia de solicitudes

    End Sub


    '2 metodos para seleccionar el renglon de la grilla de popup sin hacer postback

    'http://www.codeproject.com/KB/grid/GridViewRowColor.aspx?msg=2732537
    'Protected Sub gvAuxPendientesImputar_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) _
    'Handles gvAuxPendientesImputar.RowDataBound
    'If (e.Row.RowType = DataControlRowType.DataRow) Then
    ' e.Row.Attributes.Add("onclick", "javascript:ChangeRowColor('" & e.Row.ClientID & "')")
    ' End If
    'End Sub


    ''http://www.dotnetcurry.com/ShowArticle.aspx?ID=123&AspxAutoDetectCookieSupport=1
    'Protected Sub gvAuxPendientesImputar_RowCreated(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles gvAuxPendientesImputar.RowCreated
    '    e.Row.Attributes.Add("onMouseOver", "this.style.background='#eeff00'")
    '    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'")
    'End Sub


    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////



    Protected Sub txtBuscaGrillaImputaciones_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscaGrillaImputaciones.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        ObjectDataSource2.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & txtBuscaGrillaImputaciones.Text & "*'"


        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    Protected Sub txtNumeroRecibo2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumerorecibo2.TextChanged
        'txtNumeroRecibo1.Text = ReciboManager.ProximoSubNumero(SC, txtNumeroRecibo2.Text)
    End Sub




    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        Dim output As String



        Dim mvarClausula = False
        Dim mPrinter As String = ""
        Dim mCopias = 1
        Dim EmpresaSegunString As String = ""
        Dim PathLogo As String = ""

        'output = ImprimirWordDOT("Recibo_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdRecibo)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa
        Dim p = DirApp() & "\Documentos\" & "Recibo_PRONTO.dot"
        output = ImprimirWordDOT(p, Me, SC, Session, Response, IdRecibo, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Recibo.doc", EmpresaSegunString, PathLogo)
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
            Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)
            With myRecibo
                'esto tiene que estar en el manager, dios!
                DeObjetoHaciaPagina(myRecibo)

            End With


            Me.ViewState.Add(mKey, myRecibo) 'guardo en el viewstate el objeto
            ReciboManager.Anular(SC, IdRecibo, cmbUsuarioAnulo.SelectedValue, txtAnularMotivo.Text)
            Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            'BloqueosDeEdicion(myRequerimiento)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If
    End Sub




























    Protected Sub RadioButtonListEsInterna_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListEsInterna.SelectedIndexChanged
        RefrescarNumeroTalonario()
        ConmutarPanelClienteConPanelCuenta()
    End Sub

    Sub ConmutarPanelClienteConPanelCuenta()
        PanelEncabezadoCliente.Visible = (RadioButtonListEsInterna.SelectedItem.Value <= 1)
        PanelEncabezadoCuenta.Visible = Not PanelEncabezadoCliente.Visible
        PanelImputaciones.Visible = PanelEncabezadoCliente.Visible 'los recibos solo tienen imputaciones si son a cliente
        UpdatePanelImputaciones.Update()
    End Sub


    Protected Sub lnkAgregarCaja_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAgregarCaja.Click


        Dim myRecibo As Recibo = CType(Me.ViewState(mKey), Recibo)

        ViewState("IdDetalleRecibo") = -1

        'BuscaTextoEnCombo(cmbDetCaja, "Cheque")
        'cmbDetCaja.SelectedValue = -1
        cmbDetCaja.SelectedIndex = 1
        txtDetCajaImporte.Text = ReciboManager.FaltanteDePagar(myRecibo)
        ModalPopupExtenderCaja.Show()
    End Sub



    Protected Sub LinkButtonRubro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonRubro.Click

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleRecibo") = -1
        'cmbCuentaGasto.SelectedIndex = 1
        'txtCodigo.Text = 0
        'txt_AC_Articulo.Text = ""
        'SelectedAutoCompleteIDArticulo.Value = 0
        cmbDetRubroRubro.SelectedValue = -1
        txtDetRubroImporte.Text = ""
        'txtDetCantidad.Text = 0
        'MostrarElementos(True) 'si no se usa el popup


        'Dim eselprimero As Boolean = False
        'If Not eselprimero Then 'creo un nuevo renglon
        '    ViewState("IdDetalleRecibo") = -1
        '    cmbCuentaGasto.SelectedIndex = 1
        '    txtCodigo.Text = 0
        '    txtCantidad.Text = 0
        '    MostrarElementos(True)
        'Else 'uso el vacío por default
        '    'gvImputaciones_RowCommand()
        'End If


        'Cuando agrega un renglon, deshabilito algunos combos
        'cmbObra.Enabled = False
        'cmbCuenta.Enabled = False

        UpdatePanelRubros.Update()
        ModalPopupExtenderRubro.Show()
    End Sub

    Protected Sub LinkButtonImputacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonImputacion.Click
        RebindAuxPendientesImputar()
        ModalPopupExtenderImputacion.Show()
    End Sub

    Sub RebindAuxPendientesImputar()
        Dim dtv As DataView = ObjectDataSource2.Select()
        Dim dt = AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(dtv)
        gvAuxPendientesImputar.DataSourceID = ""
        gvAuxPendientesImputar.DataSource = dt
        gvAuxPendientesImputar.DataBind()
    End Sub

    Protected Sub gvAuxPendientesImputar_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvAuxPendientesImputar.PageIndexChanging
        gvAuxPendientesImputar.PageIndex = e.NewPageIndex
        RebindAuxPendientesImputar()
    End Sub


    Sub RecalcularRegistroContable()
        If chkRecalculoAutomatico.Checked Then Exit Sub

        Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

        '/////////////////////////////////////
        'tengo que dejar de usar ese recordset temporal (que usaba el pronto solo por
        'motivos de presentacion)
        '/////////////////////////////////////

        myRecibo.IdCliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value)
        Dim dt As DataTable = ReciboManager.RecalcularRegistroContable(SC, myRecibo)
        myRecibo.DetallesCuentas.Clear()
        For Each i In dt.Rows

            Dim cuentaitem As New ReciboCuentasItem

            With i
                cuentaitem.IdCuenta = .item("IdCuenta")
                cuentaitem.Nuevo = True
                Try
                    cuentaitem.CodigoCuenta = EntidadManager.GetItem(SC, "Cuentas", cuentaitem.IdCuenta).Item("Codigo")
                    cuentaitem.DescripcionCuenta = EntidadManager.NombreCuenta(SC, cuentaitem.IdCuenta)
                Catch ex As Exception
                End Try
                cuentaitem.Haber = iisNull(i.item("Haber"), 0)
                cuentaitem.Debe = iisNull(i.item("Debe"), 0)
            End With

            myRecibo.DetallesCuentas.Add(cuentaitem)
        Next

        If dt.Rows.Count = 0 Then
            myRecibo.DetallesCuentas.Add(New ReciboCuentasItem)
        End If
        '/////////////////////////////////////
        '/////////////////////////////////////


        Me.ViewState.Add(mKey, myRecibo)
        gvCuentas.DataSource = myRecibo.DetallesCuentas 'este bind lo copié
        gvCuentas.DataBind()             'este bind lo copié   
        UpdatePanelAsiento.Update()
    End Sub

    Protected Sub btnRecalcularAsiento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecalcularAsiento.Click
        RecalcularRegistroContable()
    End Sub

    Protected Sub cmbDetValorTipo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetValorTipo.SelectedIndexChanged
        OcultarControlesDePopupValorSegunTipoValor()

    End Sub

    Sub OcultarControlesDePopupValorSegunTipoValor()

        Dim oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(SC, "TiposComprobante_TX_PorId", cmbDetValorTipo.SelectedValue))

        If iisNull(oRs.Fields("PideBancoCuenta").Value) = "SI" Then
            'ES UNA TRANSFERENCIA BANCARIA

            txtDetValorNumeroInterno.Enabled = False
            cmbDetValorBancoOrigen.Enabled = False


            txtDetValorCheque.Enabled = False
            txtDetValorCUIT.Enabled = False
            cmbDetValorBancoCuenta.Enabled = True
            txtDetValorNumeroTransferencia.Enabled = True
            cmbDetValorGrupoCuentaContable.Enabled = False
            'txtCodigoCuenta.Enabled = False
            cmbDetValorCuentaContable.Enabled = False
            txtDetValorVencimiento.Enabled = True


        ElseIf iisNull(oRs.Fields("PideCuenta").Value) = "SI" Then
            'UN LECOP?

            txtDetValorNumeroInterno.Enabled = False
            cmbDetValorBancoOrigen.Enabled = False
            txtDetValorCheque.Enabled = False
            txtDetValorCUIT.Enabled = False
            cmbDetValorBancoCuenta.Enabled = False
            txtDetValorNumeroTransferencia.Enabled = False
            cmbDetValorGrupoCuentaContable.Enabled = True
            cmbDetValorCuentaContable.Enabled = True
            txtDetValorVencimiento.Enabled = True


        Else
            'ES UN CHEQUE
            txtDetValorNumeroInterno.Enabled = True
            cmbDetValorBancoOrigen.Enabled = True
            txtDetValorCheque.Enabled = True
            txtDetValorCUIT.Enabled = True
            cmbDetValorBancoCuenta.Enabled = False
            txtDetValorNumeroTransferencia.Enabled = False
            cmbDetValorGrupoCuentaContable.Enabled = False
            cmbDetValorCuentaContable.Enabled = False
            'txtCodigoCuenta.Enabled = False
            txtDetValorVencimiento.Enabled = True

        End If

        RequiredFieldValidator1.Enabled = cmbDetValorBancoOrigen.Enabled

        'If cmbDetValorTipo.SelectedValue = mvarIdTarjetaCredito Then txtNumeroValor.Enabled = False
    End Sub

    Private Function AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(ByRef dt As DataView) As DataView






        Dim dtCopia As DataTable = dt.Table.Copy

        Dim q = From i In dtCopia.AsEnumerable() _
               Group By IdImputacion = i("IdImputacion") _
               Into Group _
               Select New With {.IdImputacion = IdImputacion, _
                                .SaldoComp = Group.Sum(Function(i) i.Field(Of Decimal)("Saldo Comp_")) _
               }

        Dim dtTotales As DataTable = q.ToDataTable()





        For Each r As DataRow In dtTotales.Rows

            Dim dr = dtCopia.NewRow
            dr.Item("IdImputacion") = r.Item("IdImputacion")
            dr.Item("SaldoTrs") = r.Item("SaldoComp")

            dtCopia.Rows.Add(dr)

        Next




        Return DataTableORDER(dtCopia, "IdImputacion")

        'Dim oRsTotales As adodb.Recordset
        'Dim Trs As Long, i As Long
        'Dim Sdo As Double
        'Dim mTransaccionesSaldoCero As String

        'Sdo = 0
        'mTransaccionesSaldoCero = ""


        'With d

        '    'agrupa por IdImputacion para hacer totales: fijate que asigna Trs, y si cambia, agrega un registro
        '    'lo podria hacer con LINQ....

        '    Trs = IIf(IsNull(.Fields("IdImputacion").), -1, .("IdImputacion").)
        '    For i = 0 To dt.Count
        '        Dim dr As DataRowView = dt(i)

        '        If Trs <> IIf(IsNull(.("IdImputacion").), -1, .("IdImputacion").) Then
        '            oRsTotales.AddNew()
        '            oRsTotales.("IdImputacion"). = Trs
        '            oRsTotales.("SaldoTrs"). = Sdo
        '            oRsTotales.Update()
        '            If Sdo = 0 Then mTransaccionesSaldoCero = mTransaccionesSaldoCero & Trs & "|"
        '            Trs = IIf(IsNull(.Fields("IdImputacion").Value), -1, .Fields("IdImputacion").Value)
        '            Sdo = 0
        '        End If
        '        Sdo = Sdo + IIf(IsNull(.Fields("Saldo Comp.").Value), 0, .Fields("Saldo Comp.").Value)
        '        'If Not IsNull(.Fields("Observaciones").Value) Then
        '        '    rchObservaciones.TextRTF = .Fields("Observaciones").Value
        '        '    .Fields("Observaciones").Value = "" & rchObservaciones.Text
        '        '    .Update()
        '        'End If

        '    Next


        '    oRsTotales.AddNew()
        '    oRsTotales.Fields("IdImputacion").Value = Trs
        '    oRsTotales.Fields("SaldoTrs").Value = Sdo
        '    oRsTotales.Update()
        '    If Sdo = 0 Then mTransaccionesSaldoCero = mTransaccionesSaldoCero & Trs & "|"

        '    'agarra todos los totales de la tablita temporal y los agrega a la original
        '    oRsTotales.MoveFirst()
        '    Do While Not oRsTotales.EOF
        '        .AddNew()
        '        .Fields("IdImputacion").Value = oRsTotales.Fields("IdImputacion").Value
        '        .Fields("SaldoTrs").Value = oRsTotales.Fields("SaldoTrs").Value
        '        .Update()
        '        oRsTotales.MoveNext()
        '    Loop


        '    '.Sort = "IdImputacion"
        '    'BorraTransacciones(oTab, mTransaccionesSaldoCero)
        'End With


    End Function



    Protected Sub LinkButtonEnsancharGrillaImputaciones_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonEnsancharGrillaImputaciones.Click
        'gvImputaciones.

        If Not gvImputaciones.Columns(7).Visible Then
            LinkButtonEnsancharGrillaImputaciones.Text = "ocultar"
            gvImputaciones.Columns(7).Visible = True
            gvImputaciones.Columns(6).Visible = True
        Else
            LinkButtonEnsancharGrillaImputaciones.Text = "más..."
            gvImputaciones.Columns(7).Visible = False
            gvImputaciones.Columns(6).Visible = False
        End If

        UpdatePanelImputaciones.Update()

    End Sub



    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////







    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    'Extension del encabezado: Otros conceptos
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub txtOtrosImporte_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) _
        Handles txtOtrosImporte1.TextChanged, _
                txtOtrosImporte2.TextChanged, _
                txtOtrosImporte3.TextChanged, _
                txtOtrosImporte4.TextChanged, _
                txtOtrosImporte5.TextChanged

        RecalcularTotalComprobante()
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub cmbOtrosObra1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosObra1.SelectedIndexChanged
        With cmbOtrosCtaGastos1
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbOtrosObra1.SelectedValue, #1/1/1900#)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()
        End With
    End Sub


    Protected Sub cmbOtrosCtaGastos1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosCtaGastos1.SelectedIndexChanged
        Dim dr = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbOtrosObra1.SelectedValue, cmbOtrosCtaGastos1.SelectedValue, #1/1/1900#)
        'Dim idCuenta As Long = dr.item("IdCuenta")
        txtAC_OtrosCuenta1.Text = dr.Item("Descripcion") ' NombreCuenta(SC, idCuenta)
        txtOtrosCodigo1.Text = dr.Item("Codigo")
    End Sub


    Protected Sub cmbOtrosGrupo1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosGrupo1.SelectedIndexChanged

        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
    End Sub


    Protected Sub txtOtrosCodigo1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOtrosCodigo1.TextChanged
        txtAC_OtrosCuenta1.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtOtrosCodigo1.Text).Item("IdCuenta"))
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub cmbOtrosObra2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosObra2.SelectedIndexChanged
        With cmbOtrosCtaGastos2
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbOtrosObra2.SelectedValue, #1/1/1900#)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()
        End With
    End Sub


    Protected Sub cmbOtrosCtaGastos2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosCtaGastos2.SelectedIndexChanged
        Dim dr = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbOtrosObra2.SelectedValue, cmbOtrosCtaGastos2.SelectedValue, #1/1/1900#)
        'Dim idCuenta As Long = dr.item("IdCuenta")
        txtAC_OtrosCuenta2.Text = dr.Item("Descripcion") ' NombreCuenta(SC, idCuenta)
        txtOtrosCodigo2.Text = dr.Item("Codigo")
    End Sub


    Protected Sub cmbOtrosGrupo2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosGrupo2.SelectedIndexChanged

        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
    End Sub


    Protected Sub txtOtrosCodigo2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOtrosCodigo1.TextChanged
        txtAC_OtrosCuenta2.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtOtrosCodigo1.Text).Item("IdCuenta"))
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub cmbOtrosObra3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosObra3.SelectedIndexChanged
        With cmbOtrosCtaGastos3
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbOtrosObra3.SelectedValue, #1/1/1900#)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()
        End With
    End Sub


    Protected Sub cmbOtrosCtaGastos3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosCtaGastos3.SelectedIndexChanged
        Dim dr = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbOtrosObra3.SelectedValue, cmbOtrosCtaGastos3.SelectedValue, #1/1/1900#)
        'Dim idCuenta As Long = dr.item("IdCuenta")
        txtAC_OtrosCuenta1.Text = dr.Item("Descripcion") ' NombreCuenta(SC, idCuenta)
        txtOtrosCodigo1.Text = dr.Item("Codigo")
    End Sub


    Protected Sub cmbOtrosGrupo3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosGrupo3.SelectedIndexChanged

        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
    End Sub


    Protected Sub txtOtrosCodigo3_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOtrosCodigo3.TextChanged
        txtAC_OtrosCuenta3.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtOtrosCodigo3.Text).Item("IdCuenta"))
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub cmbOtrosObra4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosObra4.SelectedIndexChanged
        With cmbOtrosCtaGastos4
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbOtrosObra4.SelectedValue, #1/1/1900#)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()
        End With
    End Sub


    Protected Sub cmbOtrosCtaGastos4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosCtaGastos4.SelectedIndexChanged
        Dim dr = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbOtrosObra4.SelectedValue, cmbOtrosCtaGastos4.SelectedValue, #1/1/1900#)
        'Dim idCuenta As Long = dr.item("IdCuenta")
        txtAC_OtrosCuenta4.Text = dr.Item("Descripcion") ' NombreCuenta(SC, idCuenta)
        txtOtrosCodigo4.Text = dr.Item("Codigo")
    End Sub


    Protected Sub cmbOtrosGrupo4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosGrupo4.SelectedIndexChanged

        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
    End Sub


    Protected Sub txtOtrosCodigo4_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOtrosCodigo4.TextChanged
        txtAC_OtrosCuenta4.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtOtrosCodigo4.Text).Item("IdCuenta"))
    End Sub

    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub cmbOtrosObra5_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosObra5.SelectedIndexChanged
        With cmbOtrosCtaGastos5
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbOtrosObra5.SelectedValue, #1/1/1900#)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()
        End With
    End Sub


    Protected Sub cmbOtrosCtaGastos5_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosCtaGastos5.SelectedIndexChanged
        Dim dr = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbOtrosObra5.SelectedValue, cmbOtrosCtaGastos5.SelectedValue, #1/1/1900#)
        'Dim idCuenta As Long = dr.item("IdCuenta")
        txtAC_OtrosCuenta5.Text = dr.Item("Descripcion") ' NombreCuenta(SC, idCuenta)
        txtOtrosCodigo5.Text = dr.Item("Codigo")
    End Sub


    Protected Sub cmbOtrosGrupo5_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbOtrosGrupo5.SelectedIndexChanged

        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
    End Sub


    Protected Sub txtOtrosCodigo5_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtOtrosCodigo5.TextChanged
        txtAC_OtrosCuenta5.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtOtrosCodigo5.Text).Item("IdCuenta"))
    End Sub





    Protected Sub LinkButtonImputacionPagoAnticipado_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonImputacionPagoAnticipado.Click
        Dim myRecibo As Recibo = CType(Me.ViewState(mKey), Recibo)
        ReciboManager.AgregarImputacionSinAplicacionOPagoAnticipado(myRecibo)
        RecalcularRegistroContable()
        RebindImp()
        Me.ViewState.Add(mKey, myRecibo)
    End Sub








    Sub DeObjetoHaciaPagina(ByRef myRecibo As Pronto.ERP.BO.Recibo)
        RecargarEncabezado(myRecibo)

        gvImputaciones.DataSource = myRecibo.DetallesImputaciones
        gvImputaciones.DataBind()
    End Sub

    Sub DePaginaHaciaObjeto(ByRef myRecibo As Pronto.ERP.BO.Recibo)
        With myRecibo

            'traigo parámetros generales
            Dim drParam As DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            '.IdMoneda = drParam.Item("ProximoReciboReferencia").ToString 'mIdMonedaPesos
            .IdMoneda = cmbMoneda.SelectedValue

            '.SubNumero = StringToDecimal(txtNumeroRecibo1.Text)
            '.TipoABC = txtLetra.Text
            .Cotizacion = 1
            .CotizacionMoneda = 1

            'Qué nombre estandar defino para estas propiedades genericas?
            .NumeroRecibo = StringToDecimal(txtNumerorecibo2.Text)
            '.NumeroRecibo = StringToDecimal(txtNumeroRecibo2.Text)
            '.FechaIngreso = txtFechaIngreso.Text
            .FechaIngreso = txtFechaIngreso.Text
            .FechaRecibo = txtFechaIngreso.Text

            .NumeroCertificadoRetencionGanancias = Val(txtCertificadoGanancias.Text)
            .NumeroCertificadoRetencionIngresosBrutos = Val(txtCertificadoIngresosBrutos.Text)
            .NumeroCertificadoRetencionIVA = Val(txtCertificadoRetencionIVA.Text)


            .Tipo = RadioButtonListEsInterna.SelectedItem.Value - 1



            .IdPuntoVenta = cmbPuntoVenta.SelectedValue
            '.IdPuntoVenta = ReciboManager.IdPuntoVentaComprobanteReciboSegunSubnumeroYLetra(SC, cmbPuntoVenta.Text, txtLetra.Text)
            .PuntoVenta = cmbPuntoVenta.SelectedItem.Text


            .IdCliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, SC)
            .IdCuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAutocompleteCuenta.Text, SC)
            '.IdCondicionVenta = cmbRetencionGanancia.SelectedValue
            .IdTipoRetencionGanancia = cmbRetencionGanancia.SelectedValue


            .IdObra = 1

            .Observaciones = txtObservaciones.Text


            .IdMoneda = 1 ' cmbMoneda.SelectedValue


            .ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
            .Observaciones = txtObservaciones.Text



            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////

            Try

                .IdObra1 = cmbOtrosObra1.SelectedValue
                .IdCuentaGasto1 = cmbOtrosCtaGastos1.SelectedValue
                .IdCuenta1 = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAC_OtrosCuenta1.Text, SC)
                .NumeroComprobante1 = Val(txtOtrosNumero1.Text)
                .Otros1 = StringToDecimal(txtOtrosImporte1.Text)

                .IdObra2 = cmbOtrosObra2.SelectedValue
                .IdCuentaGasto2 = cmbOtrosCtaGastos2.SelectedValue
                .IdCuenta2 = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAC_OtrosCuenta2.Text, SC)
                .NumeroComprobante2 = Val(txtOtrosNumero2.Text)
                .Otros2 = StringToDecimal(txtOtrosImporte2.Text)

                .IdObra3 = cmbOtrosObra3.SelectedValue
                .IdCuentaGasto3 = cmbOtrosCtaGastos3.SelectedValue
                .IdCuenta3 = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAC_OtrosCuenta3.Text, SC)
                .NumeroComprobante3 = Val(txtOtrosNumero3.Text)
                .Otros3 = StringToDecimal(txtOtrosImporte3.Text)


                .IdObra4 = cmbOtrosObra4.SelectedValue
                .IdCuentaGasto4 = cmbOtrosCtaGastos4.SelectedValue
                .IdCuenta4 = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAC_OtrosCuenta4.Text, SC)
                .NumeroComprobante4 = Val(txtOtrosNumero4.Text)
                .Otros4 = StringToDecimal(txtOtrosImporte4.Text)


                .IdObra5 = cmbOtrosObra5.SelectedValue
                .IdCuentaGasto5 = cmbOtrosCtaGastos5.SelectedValue
                .IdCuenta5 = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAC_OtrosCuenta5.Text, SC)
                .NumeroComprobante5 = Val(txtOtrosNumero5.Text)
                .Otros5 = StringToDecimal(txtOtrosImporte5.Text)

            Catch ex As Exception

            End Try


        End With

    End Sub


    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
        Try
            RefrescarNumeroTalonario()
        Catch ex As Exception

        End Try
    End Sub

End Class