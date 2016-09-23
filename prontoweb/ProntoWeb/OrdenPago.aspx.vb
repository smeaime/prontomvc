﻿
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

Imports OrdenPagoManager
Imports Pronto.ERP.Dal

Imports Word = Microsoft.Office.Interop.Word
Imports Microsoft.Office.Interop.Word.WdUnits
Imports Microsoft.Office.Interop.Word.WdGoToItem


Imports adodb.ObjectStateEnum

Imports CartaDePorteManager


Partial Class OrdenPagoABM
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Private DIRFTP As String = "C:\"

    Private IdOrdenPago As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdOrdenPago"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdOrdenPago") = Value
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
            IdOrdenPago = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdOrdenPago
        End If
        mKey = "OrdenPago_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        SC = usuario.StringConnection

        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender3.ContextKey = SC

        'AutoCompleteExtenderOtros1.ContextKey = SC
        'AutoCompleteExtenderOtros2.ContextKey = SC
        'AutoCompleteExtenderOtros3.ContextKey = SC
        'AutoCompleteExtenderOtros4.ContextKey = SC
        'AutoCompleteExtenderOtros5.ContextKey = SC
        AutoCompleteExtender20.ContextKey = SC

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkCertificarIVA)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkCertificarGanancias)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkCertificarSSUS)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkCertificarIIBB)

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

            Me.LinkButtonValorChequeDeTercero.Attributes.Add("onclick", "javascript:return OpenPopup()")

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
            TextBox1.Text = IdOrdenPago
            BindTypeDropDown()



            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago
            If IdOrdenPago > 0 Then
                myOrdenPago = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myOrdenPago = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    myOrdenPago = AltaSetup()
                End If
            End If



            'gvImputaciones.Columns(7).Visible = False
            'gvImputaciones.Columns(6).Visible = False


            Me.ViewState.Add(mKey, myOrdenPago)


            ConmutarPanelClienteConPanelCuenta()
            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")


            BloqueosDeEdicion(myOrdenPago)



        End If


        txtAutocompleteProveedor.Attributes("onfocus") = "javascript:this.select();" 'para marcar todo el texto con un clic
        txtAutocompleteCuenta.Attributes.Add("onfocus", "this.select();")

        '////////////////////////////////

        'RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        'txtRendicion.Enabled = False

        'refresco
        'btnTraerDatos_Click(Nothing, Nothing)

        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

    End Sub


    Sub BloqueosDeEdicion(ByVal myOrdenPago As Pronto.ERP.BO.OrdenPago)




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
            'txtNumeroOrdenPago1.Enabled = False
            txtNumeroOrdenPago2.Enabled = False
            txtFechaIngreso.Enabled = False
            'txtFechaAprobado.Enabled = False
            'txtValidezOferta.Enabled = False
            'txtDetalleCondicionCompra.Enabled = False
            cmbMoneda.Enabled = False
            'cmbPlazo.Enabled = False
            'cmbRetencionGanancia.Enabled = False
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
        With myOrdenPago

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


                'lnkCertificarIVA.Enabled = True
                'lnkCertificarGanancias.Enabled = True
                'lnkCertificarSSUS.Enabled = True
                'lnkCertificarIIBB.Enabled = True

                btnAnular.Visible = True
                MostrarBotonesParaAdjuntar()


                'If .Aprobo > 0 Then
                If False Then
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
                    'DisableControls(Me)

                    lnkAgregarCaja.Visible = False

                    ''habilito el eliminar del renglon
                    For Each r As GridViewRow In gvImputaciones.Rows
                        'Dim bt As LinkButton
                        'bt = r.FindControl("Elim.")
                        'bt = r.Controls(6).Controls(0) 'el boton eliminar esta dentro de un control datafield

                        Dim bt As ImageButton '= r.Cells(11).Controls(0)

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
                    'txtNumeroOrdenPago1.Enabled = False
                    txtNumeroOrdenPago2.Enabled = False
                    txtFechaIngreso.Enabled = False
                    'txtFechaAprobado.Enabled = False
                    'txtValidezOferta.Enabled = False
                    'txtDetalleCondicionCompra.Enabled = False
                    cmbMoneda.Enabled = False
                    'cmbPlazo.Enabled = False
                    'cmbRetencionGanancia.Enabled = False
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


                If .Anulada = EnumPRONTO_SiNo.SI Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    btnAnular.Visible = False
                    lblAnulado.Visible = True
                    'lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & .MotivoAnulacion
                    btnSave.Visible = False
                    btnCancel.Text = "Salir"
                End If

                If False Then 'solo vista
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

    Function AltaSetup() As Pronto.ERP.BO.OrdenPago


        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = New Pronto.ERP.BO.OrdenPago
        With myOrdenPago
            .Id = -1

            RefrescarNumeroTalonario()
            BuscaIDEnCombo(cmbVendedor, session(SESSIONPRONTO_glbIdUsuario))


            'txtNumeroOrdenPago2.Text = ParametroOriginal(SC, "ProximoOrdenPago")
            txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?


            'txtNumeroOrdenPago1.Text = 1

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As OrdenPagoItem = New Pronto.ERP.BO.OrdenPagoItem
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

            Dim mItemC As OrdenPagoCuentasItem = New Pronto.ERP.BO.OrdenPagoCuentasItem
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

            Dim mItemV As OrdenPagoValoresItem = New Pronto.ERP.BO.OrdenPagoValoresItem
            mItemV.Id = -1
            mItemV.Nuevo = True
            mItemV.Eliminado = True
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

            Dim mItemR As OrdenPagoRubrosContablesItem = New Pronto.ERP.BO.OrdenPagoRubrosContablesItem
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


            'Dim mItemI As OrdenPagoImpuestosItem = New Pronto.ERP.BO.OrdenPagoImpuestosItem
            'mItemI.Id = -1
            'mItemI.Nuevo = True
            'mItemI.Eliminado = True
            ''mItem.Cantidad = 0
            ''mItem.Precio = Nothing

            '.DetallesImpuestos.Add(mItemI)
            gvImpuestosCalculados.DataSource = .DetallesImpuestos 'este bind lo copié
            gvImpuestosCalculados.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////


            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If


            'txtReferencia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoOrdenPagoReferencia").ToString
            'txtFechaOrdenPago.Text = System.DateTime.Now.ToShortDateString()


            ViewState("PaginaTitulo") = "Nueva Orden de pago"
        End With

        Return myOrdenPago
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As Pronto.ERP.BO.OrdenPago
        'los textbox que no se refresquen ponelos en un UpdatePanel

        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago

        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?
            myOrdenPago = OrdenPagoManager.GetItem(SC, IdOrdenPago, True) 'va a editar ese ID
            'myOrdenPago = OrdenPagoManager.GetItemComPronto(SC, IdOrdenPago, True)
        Else
            'está haciendo un alta, pero uso los datos de un ID existente
            myOrdenPago = OrdenPagoManager.GetCopyOfItem(SC, CopiaDeOtroId)
            IdOrdenPago = -1
            'tomar el ultimo de la serie y sumarle uno


            'myOrdenPago.SubNumero = OrdenPagoManager.ProximoSubNumero(SC, myOrdenPago.Numero)

            'limpiar los precios del OrdenPago original
            For Each i In myOrdenPago.DetallesImputaciones
                i.ImporteTotalItem = 0
            Next

            'mKey = "OrdenPago_" & Me.IdEntity.ToString 'esto es un balurdo. aclarar bien
        End If


        If Not (myOrdenPago Is Nothing) Then
            With myOrdenPago

                DeObjetoHaciaPagina(myOrdenPago)


                'Me.Title = "Edición Fondo Fijo " + myOrdenPago.Letra + myOrdenPago.NumeroComprobante1.ToString + myOrdenPago.NumeroComprobante2.ToString
                ViewState("PaginaTitulo") = "Edición OrdenPago " + myOrdenPago.NumeroOrdenPago.ToString + "/" '+ myOrdenPago.SubNumero.ToString
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
                'Me.ViewState.Add(mKey, myOrdenPago)

                'vacío el proveedor (porque es una copia)
                'SelectedReceiver.Value = 0
                'txtDescProveedor.Text = ""
            End If

        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdOrdenPago & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myOrdenPago
    End Function

    Sub RecargarEncabezado(ByVal myOrdenPago As Pronto.ERP.BO.OrdenPago)
        With myOrdenPago
            'txtReferencia.Text = myOrdenPago.Referencia
            'txtLetra.Text = myOrdenPago.Letra
            'txtNumeroOrdenPago1.Text = .SubNumero
            txtNumeroOrdenPago2.Text = .NumeroOrdenPago
            txtFechaIngreso.Text = .FechaOrdenPago '.ToString("dd/MM/yyyy")
            'txtFechaAprobado.Text = .FechaAprobacion.ToString("dd/MM/yyyy")
            'txtFechaCierreCompulsa.Text = .FechaCierreCompulsa.ToString("dd/MM/yyyy")
            'txtRendicion.Text = .NumeroRendicionFF



            'txtValidezOferta.Text = .Validez
            'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra

            'BuscaTextoEnCombo(cmbTipoComprobante, .IdTipoComprobante.ToString)
            'txtCUIT.Text = .Proveedor.ToString


            '////////////////////////////////////////////////////////
            'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
            'SelectedReceiver.Value = myOrdenPago.IdProveedor
            'txtDescProveedor.Text = myOrdenPago.Proveedor
            'TraerDatosProveedor(myOrdenPago.IdProveedor) 'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
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

            txtAutocompleteProveedor.Text = EntidadManager.NombreProveedor(SC, .IdProveedor)

            Select Case .Tipo
                Case OrdenPago.tipoOP.CC
                    RadioButtonListEsInterna.SelectedValue = 1
                Case OrdenPago.tipoOP.OT
                    RadioButtonListEsInterna.SelectedValue = 2
                Case OrdenPago.tipoOP.FF
                    RadioButtonListEsInterna.SelectedValue = 3
            End Select

            txtAutocompleteCuenta.Text = EntidadManager.NombreCuenta(SC, .IdCuenta)

            'BuscaIDEnCombo(cmbRetencionGanancia, .IdTipoRetencionGanancia)


            'BuscaIDEnCombo(cmbPuntoVenta, .IdPuntoVenta)




            'BuscaIDEnCombo(cmbVendedor, .IdVendedor)
            BuscaIDEnCombo(cmbMoneda, .IdMoneda)
            'BuscaIDEnCombo(cmbIVA, .IdCodigoIVA)

            'txtTotal.Text = .Total

            'txtCertificadoGanancias.Text = .NumeroCertificadoRetencionGanancias
            'txtCertificadoIngresosBrutos.Text = .NumeroCertificadoRetencionIngresosBrutos
            'txtCertificadoRetencionIVA.Text = .NumeroCertificadoRetencionIVA


            'txtDetalle.Text = .Detalle
            'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra
            txtObservaciones.Text = .Observaciones
            'txtCAI.Text = .NumeroCAI
            'txtFechaVtoCAI.Text = .FechaVencimientoCAI
            'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

            'lnkAdjunto1.Text = .ArchivoAdjunto1
            'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)


            'If myOrdenPago.Aprobo <> 0 Then
            '    txtLibero.Text = EmpleadoManager.GetItem(SC, myOrdenPago.Aprobo).Nombre
            'End If

            txtTotalRetencionGanancias.Text = .RetencionGanancias
            txtTotalRetencionIVA.Text = .RetencionIVA


            ProntoCheckSINO(.Dolarizada, chkCalcularDiferenciaCambio)
            ProntoCheckSINO(.Exterior, chkExterior)

            txtNumeroRendicionFondoFijo.Text = .NumeroRendicionFF

            ProntoCheckSINO(.OPInicialFF, chkInicialFondoFijo)

            '.IdOPComplementariaFF

            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            Try
                txtNumeroOPcomplementariaFF = GetStoreProcedureTop1(SC, enumSPs.OrdenesPago_T, .IdOPComplementariaFF).Item("NumeroOrdenPago")
            Catch ex As Exception

            End Try



            txtTotalRetencionIVA.Text = FF2(.RetencionIVA)
            txtTotalRetencionGanancias.Text = FF2(.RetencionGanancias)
            txtTotalRetencionSUSS.Text = FF2(.RetencionSUSS)
            txtTotalRetencionIIBB.Text = FF2(.RetencionIBrutos)
            lblTotalDiferencia.Text = FF2(.TotalDiferencia)



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



        'IniciaCombo(SC, cmbDetasienncepto, tipos.Conceptos)
        IniciaCombo(SC, cmbDetAsientoCuentaBanco, tipos.CuentasBancarias)
        IniciaCombo(SC, cmbDetAsientoCuentaGasto, tipos.CuentasGasto)
        IniciaCombo(SC, cmbDetAsientoCuentaGrupo, tipos.TiposCuentaGrupos)
        'IniciaCombo(SC, cmbDetAsientoCaja, tipos.Cajas)









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


        Try
            cmbDetRubroRubro.DataSource = EntidadManager.GetStoreProcedure(SC, "RubrosContables_TX_ParaComboFinancierosIngresos", -1)
            cmbDetRubroRubro.DataTextField = "Titulo"
            cmbDetRubroRubro.DataValueField = "IdRubroContable"
            cmbDetRubroRubro.DataBind()
            cmbDetRubroRubro.Items.Insert(0, New ListItem("-- Elija un rubro --", -1))
        Catch ex As Exception

        End Try



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

        'IniciaCombo(SC, cmbOtrosObra1, tipos.Obras)
        ''IniciaCombo(SC, cmbOtrosCtaGastos1, tipos.CuentasGasto)
        'IniciaCombo(SC, cmbOtrosGrupo1, tipos.TiposCuentaGrupos)

        'IniciaCombo(SC, cmbOtrosObra2, tipos.Obras)
        ''IniciaCombo(SC, cmbOtrosCtaGastos2, tipos.CuentasGasto)
        'IniciaCombo(SC, cmbOtrosGrupo2, tipos.TiposCuentaGrupos)

        'IniciaCombo(SC, cmbOtrosObra3, tipos.Obras)
        ''IniciaCombo(SC, cmbOtrosCtaGastos3, tipos.CuentasGasto)
        'IniciaCombo(SC, cmbOtrosGrupo3, tipos.TiposCuentaGrupos)

        'IniciaCombo(SC, cmbOtrosObra4, tipos.Obras)
        ''IniciaCombo(SC, cmbOtrosCtaGastos4, tipos.CuentasGasto)
        'IniciaCombo(SC, cmbOtrosGrupo4, tipos.TiposCuentaGrupos)

        'IniciaCombo(SC, cmbOtrosObra5, tipos.Obras)
        ''IniciaCombo(SC, cmbOtrosCtaGastos5, tipos.CuentasGasto)
        'IniciaCombo(SC, cmbOtrosGrupo5, tipos.TiposCuentaGrupos)

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


    Protected Sub txtAutocompleteProveedor_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAutocompleteProveedor.TextChanged

        TraerDatosCliente(BuscaIdClientePreciso(txtAutocompleteProveedor.Text, HFSC.Value))



        'si cambia el cliente, vacío las imputaciones
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
        myOrdenPago.DetallesImputaciones.Clear()

        Dim mItem As OrdenPagoItem = New Pronto.ERP.BO.OrdenPagoItem
        mItem.Id = -1
        mItem.Nuevo = True
        mItem.Eliminado = True
        myOrdenPago.DetallesImputaciones.Add(mItem)

        Me.ViewState.Add(mKey, myOrdenPago)
        RebindImp()
    End Sub


    Function TraerDatosCliente(ByVal IdCliente As Long)
        Try
            Dim oCli = ClienteManager.GetItem(SC, IdCliente)
            With oCli
                BuscaIDEnCombo(cmbCondicionIVA, EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("IdCodigoIva"))
                txtCUIT.Text = EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("CUIT")
                'BuscaIDEnCombo(cmbRetencionGanancia, .IdCondicionVenta)

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
        cmbPuntoVenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", EntidadManager.IdTipoComprobante.OrdenPago, "X")
        cmbPuntoVenta.DataTextField = "Titulo"
        cmbPuntoVenta.DataValueField = "IdPuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0

        If cmbPuntoVenta.Items.Count = 0 Then
            MsgBoxAjax(Me, "No hay talonario para ordenes de pago")
        Else

            RefrescarNumeroTalonario()
        End If
    End Sub


    Sub RefrescarNumeroTalonario() 'esto tambien podría estar la mitad en el manager
        'está refrescando el talonario tambien en la "vista". Cómo condicionarlo?

        'txtLetra.Text = EntidadManager.LetraSegunTipoIVA(cmbCondicionIVA.SelectedValue)
        'lblLetra.Text = txtLetra.Text


        If chkExterior.Checked Then
            txtNumeroOrdenPago2.Text = TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoExterior")
        Else

            If RadioButtonListEsInterna.SelectedItem.Value = 1 Then
                txtNumeroOrdenPago2.Text = TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPago")
            ElseIf RadioButtonListEsInterna.SelectedItem.Value = 2 Then
                txtNumeroOrdenPago2.Text = TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoFF")
            Else
                txtNumeroOrdenPago2.Text = TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoOtros")
            End If

        End If

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

                Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

                DePaginaHaciaObjeto(myOrdenPago)


                Dim ms As String
                If OrdenPagoManager.IsValid(SC, myOrdenPago, ms) Then
                    Try
                        If OrdenPagoManager.Save(SC, myOrdenPago) = -1 Then
                            MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.ToString)
                    End Try



                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                    IdOrdenPago = myOrdenPago.Id




                    If myOrdenPago.NumeroOrdenPago <> StringToDecimal(txtNumeroOrdenPago2.Text) Then
                        EndEditing("El OrdenPago fue grabado con el número " & myOrdenPago.NumeroOrdenPago) 'me voy 
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
            'MsgBoxAjax(Me, ex.ToString)
            ErrHandler2.WriteError(ex)
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

        Dim DEBUG As Boolean = True

        If MensajeFinal <> "" And Not DEBUG Then
            'Response.Write("<script>alert('message') ; window.location.href='Comparativas.aspx'</script>")

            'PreRedirectMsgbox.OnOkScript = "window.location = ""Comparativas.aspx"""
            'ButVolver.PostBackUrl = "Comparativas.aspx"
            LblPreRedirectMsgbox.Text = MensajeFinal
            PreRedirectMsgbox.Show()
            'el confirmbutton tambien me sirve si el usuario aprieta sin querer en el menu!!!!!! -no, no sirve para eso
        Else
            'PreRedirectConfirmButtonExtender.Enabled = False 'http://stackoverflow.com/questions/2096262/conditional-confirmbuttonextender
            Response.Redirect(String.Format("OrdenesPago.aspx"))
        End If
    End Sub

    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("OrdenesPago.aspx?Imprimir=" & IdOrdenPago))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("OrdenesPago.aspx")) 'roundtrip al cuete?
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
                Dim b As ImageButton = e.Row.Cells(e.Row.Cells.Count - 2).Controls(0)
                b.ImageUrl = "../Imagenes/reestablecer.png" 'reemplazo el texto del eliminado


            End If
        End If
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub gvImputaciones_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvImputaciones.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

                    'si esta eliminado, lo restaura
                    myOrdenPago.DetallesImputaciones(mIdItem).Eliminado = Not myOrdenPago.DetallesImputaciones(mIdItem).Eliminado


                    Me.ViewState.Add(mKey, myOrdenPago) 'hay que encontrar otra manera.... esto de pasarselo así no va

                    'RecalcularRegistroContable(myOrdenPago)
                    'RecalcularTotalComprobante(True, myOrdenPago)

                    'UpdatePanelValores.Update()
                    'UpdatePanelAsiento.Update()

                    'myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
                    'gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
                    'gvImputaciones.DataBind()
                    'UpdatePanelImputaciones.Update()

                    SuperReBind(myOrdenPago)

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
                    Dim b As ImageButton = gvImputaciones.Rows(e.CommandArgument).Cells(gvImputaciones.Rows(e.CommandArgument).Cells.Count - 1).Controls(0)
                    b.ImageUrl = "../Imagenes/editar.png"
                Else
                    'quiere editar
                    gvImputaciones.EditIndex = e.CommandArgument
                    Dim b As ImageButton = gvImputaciones.Rows(e.CommandArgument).Cells(gvImputaciones.Rows(e.CommandArgument).Cells.Count - 1).Controls(0)
                    b.ImageUrl = "../Imagenes/aplicar.png" 'reemplazo el texto del eliminado

                End If


                RebindImp()
                UpdatePanelImputaciones.Update()





                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////////////////
            ElseIf e.CommandName.ToLower = "cmdCambioImporte" Then
                'editó el importe directo sobre la grilla

                ViewState("IdDetalleOrdenPago") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
                    With myOrdenPago.DetallesImputaciones(mIdItem)
                        .ImporteTotalItem = TextoWebControl(gvImputaciones.Rows(mIdItem).FindControl("txtGvImputacionesImporte"))
                    End With


                    Me.ViewState.Add(mKey, myOrdenPago)
                    mAltaItem = True



                    RecalcularRegistroContable(myOrdenPago)
                    RecalcularTotalComprobante(True, myOrdenPago)

                    UpdatePanelValores.Update()
                    UpdatePanelAsiento.Update()

                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
                    gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
                    gvImputaciones.DataBind()
                    UpdatePanelImputaciones.Update()




                End If


            End If
        Catch ex As Exception
            'lblError.Visible = True
            MsgBoxAjax(Me, ex.ToString)
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

        ViewState("IdDetalleOrdenPago") = mIdItem
        If (Me.ViewState(mKey) IsNot Nothing) Then
            'MostrarElementos(True)
            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
            With myOrdenPago.DetallesImputaciones(mIdItem)
                Dim ImporteIngresado As Double = TextoWebControl(gvImputaciones.Rows(gvr.RowIndex).FindControl("txtGvImputacionesImporte"))
                Dim Saldo As Double = TextoWebControl(gvImputaciones.Rows(gvr.RowIndex).FindControl("txtGvImputacionesImporte"))
                If ImporteIngresado > .SaldoParteEnPesosAnterior Or ImporteIngresado < 0 Then
                    MsgBoxAjax(Me, "El importe debe ser menor que el saldo")
                    Exit Sub
                End If

                .ImporteTotalItem = ImporteIngresado
                .Importe = .ImporteTotalItem
            End With



            Me.ViewState.Add(mKey, myOrdenPago)




            RecalcularRegistroContable(myOrdenPago)
            RecalcularTotalComprobante(True, myOrdenPago)

            gvImputaciones.EditIndex = -1
            RebindImp()

            gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
            gvImputaciones.DataBind()
            UpdatePanelImputaciones.Update()
            mAltaItem = True
        End If

    End Sub


    Sub SuperReBind(ByRef myOrdenPago As OrdenPago)
        RecalcularRegistroContable(myOrdenPago)
        RecalcularTotalComprobante(True, myOrdenPago)


        Me.ViewState.Add(mKey, myOrdenPago)


        RebindImp()

        gvValores.DataSource = myOrdenPago.DetallesValores
        gvValores.DataBind()
        UpdatePanelValores.Update()

        gvCuentas.DataSource = myOrdenPago.DetallesCuentas 'este bind lo copié
        gvCuentas.DataBind()             'este bind lo copié   
        UpdatePanelAsiento.Update()

    End Sub



    Sub RecalcularRegistroContable(Optional ByRef myOP As OrdenPago = Nothing)
        If chkRecalculoAutomatico.Checked Then Exit Sub

        If IsNothing(myOP) Then myOP = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

        DePaginaHaciaObjeto(myOP)

        OrdenPagoManager.RecalcularImpuestos(SC, myOP)
        gvImpuestosCalculados.DataSource = myOP.DetallesImpuestos 'este bind lo copié
        gvImpuestosCalculados.DataBind()             'este bind lo copié   
        'UpdatePanelImpuestos.Update()



        '/////////////////////////////////////
        'tengo que dejar de usar ese recordset temporal (que usaba el pronto solo por
        'motivos de presentacion)
        '/////////////////////////////////////


        Dim dt As DataTable = RecordSet_To_DataTable(OrdenPagoManager._RegistroContableOriginalVB6conADORrecordsets(SC, myOP))
        myOP.DetallesCuentas.Clear()
        For Each i In dt.Rows

            Dim cuentaitem As New OrdenPagoCuentasItem

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

            myOP.DetallesCuentas.Add(cuentaitem)
        Next

        If dt.Rows.Count = 0 Then
            myOP.DetallesCuentas.Add(New OrdenPagoCuentasItem)
        End If


        Me.ViewState.Add(mKey, myOP)


        gvCuentas.DataSource = myOP.DetallesCuentas 'este bind lo copié
        gvCuentas.DataBind()             'este bind lo copié   
        UpdatePanelAsiento.Update()



        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////


    End Sub



    Sub RebindImp()
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
        gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
        gvImputaciones.DataBind()

        gvImputaciones.FooterRow.Cells(getGridIDcolbyHeader("Importe", gvImputaciones)).Text = FF2(myOrdenPago.TotalImputaciones)
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




                If e.Row.Cells(getGridIDcolbyHeader("Vence", gvValores)).Text = "01/1/0001" Then
                    e.Row.Cells(getGridIDcolbyHeader("Vence", gvValores)).Text = ""
                End If



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
        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)

        ViewState("IdDetalleOrdenPago") = -1
        'cmbCuentaGasto.SelectedIndex = 1
        'txtCodigo.Text = 0
        txt_AC_Articulo.Text = ""
        SelectedAutoCompleteIDArticulo.Value = 0
        'txtDetCantidad.Text = 0
        'MostrarElementos(True) 'si no se usa el popup

        BuscaTextoEnCombo(cmbDetValorTipo, "Cheque")

        BuscaIDEnCombo(cmbDetValorBancoCuenta, -1)
        BuscaIDEnCombo(cmbDetValorChequeras, -1)


        txtDetValorImporte.Text = OrdenPagoManager.FaltanteDePagar(SC, myOrdenPago)

        txtDetValorNumeroInterno.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNumeroInterno")


        txtDetValorCheque.Text = ""


        txtDetValorVencimiento.Text = Today

        'Dim eselprimero As Boolean = False
        'If Not eselprimero Then 'creo un nuevo renglon
        '    ViewState("IdDetalleOrdenPago") = -1
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
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

                    'si esta eliminado, lo restaura
                    myOrdenPago.DetallesValores(mIdItem).Eliminado = Not myOrdenPago.DetallesValores(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myOrdenPago)

                    RecalcularRegistroContable(myOrdenPago)
                    RecalcularTotalComprobante(True, myOrdenPago)

                    gvValores.DataSource = myOrdenPago.DetallesValores
                    gvValores.DataBind()

                    UpdatePanelValores.Update()
                    UpdatePanelAsiento.Update()

                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
                    gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
                    gvImputaciones.DataBind()
                    UpdatePanelImputaciones.Update()


                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleOrdenPago") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)


                    If myOrdenPago.DetallesValores(mIdItem).IdCaja <> 0 Then
                        'es una caja

                        With myOrdenPago.DetallesValores(mIdItem)
                            'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo
                            .Eliminado = False
                            BuscaIDEnCombo(cmbDetValorTipo, .IdTipoValor)
                            txtDetValorImporte.Text = DecimalToString(.ImporteTotalItem)


                        End With

                        UpdatePanelCaja.Update()
                        ModalPopupExtenderCaja.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?

                    Else
                        'es un cheque o valor

                        With myOrdenPago.DetallesValores(mIdItem)
                            'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                            .Eliminado = False

                            BuscaIDEnCombo(cmbDetValorTipo, .IdTipoValor)
                            BuscaIDEnCombo(cmbDetValorBancoCuenta, .IdCuentaBancaria)
                            Rebind_cmbDetValorChequeras()
                            BuscaIDEnCombo(cmbDetValorChequeras, .IdBancoChequera)


                            txtDetValorNumeroInterno.Text = .NumeroInterno
                            txtDetValorCheque.Text = .NumeroValor

                            txtDetValorVencimiento.Text = .FechaVencimiento
                            txtDetValorImporte.Text = DecimalToString(.Importe)
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
            MsgBoxAjax(Me, ex.ToString)
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
                Dim b As ImageButton = e.Row.Cells(4).Controls(0)
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

        If RadioButtonListEsInterna.SelectedItem.Value <> 2 Then Return 'solo se puede editar cuando es "OTROS"

        ViewState("IdDetalleOrdenPago") = -1


        BuscaIDEnCombo(cmbDetAsientoObra, cmbObra.SelectedValue) ' -1)
        'BuscaIDEnCombo(cmbDetAsientoCuenta, -1)
        txtAsientoAC_Cuenta.Text = ""
        txtDetAsientoCodigoCuenta.Text = ""
        BuscaIDEnCombo(cmbDetAsientoCuentaBanco, -1)
        BuscaIDEnCombo(cmbDetAsientoCuentaGasto, -1)
        BuscaIDEnCombo(cmbDetAsientoCaja, -1)
        BuscaTextoEnCombo(cmbDetAsientoMoneda, "PESOS") '        BuscaIDEnCombo(cmbDetAsientoMoneda, -1)

        cmbDetAsientoCaja.Enabled = False
        cmbDetAsientoCuentaBanco.Enabled = False
        cmbDetAsientoMoneda.Enabled = False


        txtDetAsientoDebe.Text = ""
        txtDetAsientoHaber.Text = ""

        txtDetValorImporte.Text = ""

        UpdatePanelAsiento.Update()
        ModalPopupExtenderAsiento.Show()
    End Sub


    Protected Sub gvRubrosContables_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvRubrosContables.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

                    'si esta eliminado, lo restaura
                    myOrdenPago.DetallesRubrosContables(mIdItem).Eliminado = Not myOrdenPago.DetallesRubrosContables(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myOrdenPago)
                    gvRubrosContables.DataSource = myOrdenPago.DetallesRubrosContables
                    gvRubrosContables.DataBind()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleOrdenPago") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
                    With myOrdenPago.DetallesRubrosContables(mIdItem)
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
            MsgBoxAjax(Me, ex.ToString)
            Exit Sub
        End Try
    End Sub

    Protected Sub gvCuentas_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvCuentas.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

                    'si esta eliminado, lo restaura
                    myOrdenPago.DetallesCuentas(mIdItem).Eliminado = Not myOrdenPago.DetallesCuentas(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myOrdenPago)


                    gvCuentas.DataSource = myOrdenPago.DetallesCuentas
                    gvCuentas.DataBind()
                    RecalcularTotalComprobante()

                    UpdatePanelAsiento.Update()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleOrdenPago") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
                    With myOrdenPago.DetallesCuentas(mIdItem)
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


                        'txtObservacionesItem.Text = myOrdenPago.Detalles(mIdItem).Observaciones.ToString
                        'txtFechaNecesidad.Text = myOrdenPago.Detalles(mIdItem).FechaEntrega.ToString
                        'If myOrdenPago.Detalles(mIdItem).OrigenDescripcion = 1 Then
                        '    RadioButtonList1.Items(0).Selected = True
                        'ElseIf myOrdenPago.Detalles(mIdItem).OrigenDescripcion = 2 Then
                        '    RadioButtonList1.Items(1).Selected = True
                        'ElseIf myOrdenPago.Detalles(mIdItem).OrigenDescripcion = 3 Then
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
            MsgBoxAjax(Me, ex.ToString)
            Exit Sub
        End Try
    End Sub

    Protected Sub btnSaveItemValor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemValor.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleOrdenPago"), Integer)
            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

            'acá tengo que traer el valor id del hidden





            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As OrdenPagoValoresItem = New Pronto.ERP.BO.OrdenPagoValoresItem

                If myOrdenPago.DetallesImputaciones Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myOrdenPago.DetallesValores.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myOrdenPago.DetallesValores.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myOrdenPago.DetallesValores(mIdItem)


                    .IdTipoValor = cmbDetValorTipo.SelectedValue
                    .Tipo = cmbDetValorTipo.SelectedItem.Text

                    '.IdValor=

                    .NumeroInterno = Val(txtDetValorNumeroInterno.Text)
                    .IdCuentaBancariaTransferencia = cmbDetValorBancoCuenta.SelectedValue
                    .IdCuentaBancaria = cmbDetValorBancoCuenta.SelectedValue
                    .NumeroValor = Val(txtDetValorCheque.Text)
                    .IdBancoChequera = cmbDetValorChequeras.SelectedValue

                    Dim oRs = TraerFiltradoVB6(SC, enumSPs.CuentasBancarias_TX_PorId, .IdCuentaBancaria)
                    If oRs.RecordCount > 0 Then .IdBanco = oRs.Fields("IdBanco").Value

                    .Importe = StringToDecimal(txtDetValorImporte.Text)
                    .FechaVencimiento = iisValidSqlDate(txtDetValorVencimiento.Text)
                    ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximoNumeroInterno, .NumeroInterno + 1)
                    .ImporteTotalItem = StringToDecimal(txtDetValorImporte.Text)


                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////


                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With




                    Dim msItem As String
                    If Not IsValidItemValor(SC, myOrdenPago.DetallesValores(mIdItem), msItem, myOrdenPago) Then
                        MsgBoxAjax(Me, msItem)
                        Exit Sub
                    End If



                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.ToString)
                Exit Sub
            End Try


            Me.ViewState.Add(mKey, myOrdenPago)
            gvValores.DataSource = myOrdenPago.DetallesValores
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
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleOrdenPago"), Integer)
            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As OrdenPagoValoresItem = New Pronto.ERP.BO.OrdenPagoValoresItem

                If myOrdenPago.DetallesValores Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myOrdenPago.DetallesValores.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myOrdenPago.DetallesValores.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myOrdenPago.DetallesValores(mIdItem)
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

                    .IdTipoValor = ParametroOriginal(SC, ePmOrg.IdTipoComprobanteCajaEgresos)
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
                MsgBoxAjax(Me, ex.ToString)
                Exit Sub
            End Try


            Me.ViewState.Add(mKey, myOrdenPago)
            gvValores.DataSource = myOrdenPago.DetallesValores
            gvValores.DataBind()


            UpdatePanelAsiento.Update()


            DePaginaHaciaObjeto(myOrdenPago)


            RecalcularRegistroContable()


            RecalcularTotalComprobante()

        End If

        'MostrarElementos(False)
        mAltaItem = True
    End Sub


    Protected Sub btnSaveItemAsiento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemAsiento.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleOrdenPago"), Integer)
            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As OrdenPagoCuentasItem = New Pronto.ERP.BO.OrdenPagoCuentasItem

                If myOrdenPago.DetallesCuentas Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myOrdenPago.DetallesCuentas.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myOrdenPago.DetallesCuentas.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myOrdenPago.DetallesCuentas(mIdItem)


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



                    Dim msItem As String
                    If Not IsValidItemCuentas(SC, myOrdenPago.DetallesCuentas(mIdItem), msItem, myOrdenPago) Then
                        MsgBoxAjax(Me, msItem)
                        Exit Sub
                    End If


                End With
            Catch ex As Exception
                'lblError.Visible = True
                MsgBoxAjax(Me, ex.ToString)
                Exit Sub
            End Try


            Me.ViewState.Add(mKey, myOrdenPago)
            gvCuentas.DataSource = myOrdenPago.DetallesCuentas
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
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleOrdenPago"), Integer)
            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As OrdenPagoRubrosContablesItem = New Pronto.ERP.BO.OrdenPagoRubrosContablesItem

                If myOrdenPago.DetallesRubrosContables Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myOrdenPago.DetallesRubrosContables.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myOrdenPago.DetallesRubrosContables.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myOrdenPago.DetallesRubrosContables(mIdItem)
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
                MsgBoxAjax(Me, ex.ToString)
                Exit Sub
            End Try

            RecalcularTotalComprobante()

            Me.ViewState.Add(mKey, myOrdenPago)
            gvRubrosContables.DataSource = myOrdenPago.DetallesRubrosContables
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
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
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
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
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

    Sub RecalcularTotalComprobanteSinRecalcularRetenciones()
        RecalcularTotalComprobante(False)
    End Sub

    Sub RecalcularTotalComprobante()
        RecalcularTotalComprobante(True)
    End Sub

    Sub RecalcularTotalComprobante(ByVal bRecalcularRetenciones As Boolean, Optional ByRef myOrdenPago As OrdenPago = Nothing)
        If IsNothing(myOrdenPago) Then myOrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

        'myOrdenPago.Bonificacion = StringToDecimal(txtTotBonif.Text)


        DePaginaHaciaObjeto(myOrdenPago)
        OrdenPagoManager.RecalcularTotales(SC, myOrdenPago, bRecalcularRetenciones)


        With myOrdenPago
            '.RetencionIVA = Val(txtTotalRetencionIVA.Text)
            '.RetencionGanancias = Val(txtTotalRetencionGanancias.Text)
            '.Otros1 = StringToDecimal(txtOtrosImporte1.Text)
            '.Otros2 = StringToDecimal(txtOtrosImporte2.Text)
            '.Otros3 = StringToDecimal(txtOtrosImporte3.Text)
            txtTotalRetencionIVA.Text = FF2(.RetencionIVA)
            'txtBonificacionPorItem.Text = FF2(.RetencionGanancias)
            txtTotalRetencionGanancias.Text = FF2(.RetencionGanancias)
            txtTotalRetencionSUSS.Text = FF2(.RetencionSUSS)
            txtTotalRetencionIIBB.Text = FF2(.RetencionIBrutos)
            'lblTotSubGravado.Text = FF2(.TotalSubGravado)
            'lblTotIVA.Text = FF2(.ImporteIva1)
            'lblPercepcionIVA.Text = FF2(.PercepcionIVA)
            'lblTotalOtrosConceptos.Text = FF2(.TotalOtrosConceptos)
            lblTotalDiferencia.Text = FF2(.TotalDiferencia)




            gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
            gvImputaciones.DataBind()
            UpdatePanelImputaciones.Update()

            Try
                'está explotando cuando veo OrdenPagos que se grabaron 
                'sin valores, y entonces la grilla no tiene pie, y entonces esssplota
                gvImputaciones.FooterRow.Cells(getGridIDcolbyHeader("Importe", gvImputaciones)).Text = FF2(.TotalImputaciones)
                gvValores.FooterRow.Cells(getGridIDcolbyHeader("Importe", gvValores)).Text = FF2(.TotalValores)
                gvCuentas.FooterRow.Cells(getGridIDcolbyHeader("Debe", gvCuentas)).Text = FF2(.TotalDebe)
                gvCuentas.FooterRow.Cells(getGridIDcolbyHeader("Haber", gvCuentas)).Text = FF2(.TotalHaber)

            Catch ex As Exception

            End Try


        End With

        Me.ViewState.Add(mKey, myOrdenPago)

        UpdatePanelTotales.Update()
        UpdatePanelImputaciones.Update()
        UpdatePanelAsiento.Update()
        UpdatePanelValores.Update()


    End Sub




    'Protected Sub btnLiberar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
    '    'Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
    '    'myOrdenPago.ConfirmadoPorWeb = "SI"


    '    Dim mOk As Boolean
    '    Page.Validate("Encabezado")
    '    mOk = Page.IsValid

    '    Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
    '    If Not OrdenPagoManager.IsValid(myOrdenPago) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
    '        mOk = False
    '        MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
    '    End If
    '    If mOk Then
    '        ModalPopupExtender4.Show()
    '    Else
    '        'MsgBoxAjax(Me, "El objeto no es válido")
    '    End If
    '    'myOrdenPago.Aprobo = "SI" 'este es cuando lo aprueba el usario pronto
    'End Sub









    '////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////




    Protected Sub btnSaveItemImputacionAux_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemImputacionAux.Click


        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

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


                        Dim idCtaCte As Integer = iisNull(.DataKeys(fila.RowIndex).Values.Item("IdCtaCte"), -1)
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
                        If myOrdenPago.DetallesImputaciones.Find(Function(obj) obj.IdImputacion = idCtaCte) Is Nothing Then

                            Dim mItem As OrdenPagoItem = New Pronto.ERP.BO.OrdenPagoItem

                            With mItem
                                'vendría a ser el código de frmOrdenPago.Editar

                                .Id = myOrdenPago.DetallesImputaciones.Count
                                .Nuevo = True

                                .IdImputacion = idCtaCte
                                .TipoComprobanteImputado = iisNull(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Comp_"))

                                .SaldoParteEnPesosAnterior = iisNull(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_"), 0)
                                .FechaComprobanteImputado = iisNull(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Fecha"), 0)
                                .TotalComprobanteImputado = iisNull(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Imp_orig_"), 0)

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
                                '.ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & " " & gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero")
                                .ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & " " & gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Nro_comp_")


                                'traido de Compronto.DetOrdenesPago.RegistrosConFormato
                                'supongo que, segun el tipo de retencion del proveedor al que le estoy pagando
                                ' yo (que soy agente de la AFIP), le cobro distinto...
                                Try

                                    Dim dr As DataRow = GetStoreProcedureTop1(SC, enumSPs.CtasCtesA_T, .IdImputacion)
                                    If dr.Item("IdComprobante") > 0 Then 'por qué a veces es negativo?
                                        Dim oRsComp1 = TraerFiltradoVB6(SC, enumSPs.ComprobantesProveedores_TX_PorIdConDatos, dr.Item("IdComprobante"))

                                        .IdTipoRetencionGanancia = iisNull(oRsComp1.Fields("IdTipoRetencionGanancia").Value, Nothing)
                                        .IdIBCondicion = iisNull(oRsComp1.Fields("IdIBCondicion").Value, Nothing)

                                        .IVA = oRsComp1.Fields("TotalIVA1").Value

                                        'Debug.Print(DebugGetDataTableColumnNamesRSconValores(oRsComp1))

                                    Else
                                        Debug.Print("")
                                    End If



                                    .Importe = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_")
                                    '.ImportePagadoSinImpuestos = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_")

                                    '.ImportePagadoSinImpuestos = .Importe - .IVA
                                    '.TotalComprobanteImputado = .Importe
                                    '.ImporteRetencionIVA=
                                    'CargarDatosDesdeItemOrdenCompra(mItem, idDetOC)


                                Catch ex As Exception

                                End Try







                            End With

                            myOrdenPago.DetallesImputaciones.Add(mItem)
                            OrdenPagoManager.RefrescarDesnormalizados(SC, myOrdenPago)


                        Else
                            MsgBoxAjax(Me, "El renglon de imputacion " & idCtaCte & " ya está en el detalle")
                        End If


                    End If
                End If
            Next
        End With


        Me.ViewState.Add(mKey, myOrdenPago)
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
        RebindAuxPendientesImputar()
        'ObjectDataSource2.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & txtBuscaGrillaImputaciones.Text & "*'"


        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    Protected Sub txtNumeroOrdenPago2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroOrdenPago2.TextChanged
        'txtNumeroOrdenPago1.Text = OrdenPagoManager.ProximoSubNumero(SC, txtNumeroOrdenPago2.Text)
    End Sub




    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click

        Dim output As String

        Dim mvarClausula = False
        Dim mPrinter As String = "", mPrinterAnt As String = ""
        Dim mCopias = 1
        Dim EmpresaSegunString As String = ""
        Dim PathLogo As String = ""

        'output = ImprimirWordDOT("OrdenPago_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdOrdenPago)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa
        Dim p = DirApp() & "\Documentos\" & "OrdenPago_PRONTO.dot"

        Dim mAuxS1 As String



        Dim mvarConCotizacion As Boolean
        mvarConCotizacion = False ' .Option1.Value 'boolean "Emite cotizacion dolar ? : "

        Dim mvarOK As Boolean

        'mPrinterAnt = Printer.DeviceName & " on " & Printer.Port

        'If Index = 0 Then
        '    mCopias = Val(BuscarClaveINI("CopiasOrdenesPago"))
        '    If mCopias = 0 Then mCopias = 2

        '    mCopias = 1
        'End If


        Dim mAuxS2 As String, mDestino As String

        mAuxS2 = BuscarClaveINI("No mostrar imputaciones en OP fondo fijo", SC, session(SESSIONPRONTO_glbIdUsuario))
        'If Index = 0 Then
        ' mDestino = "Printer"
        ' Else
        mDestino = "Word"
        ' End If
        mAuxS1 = "||" & "1" & "|||" & mCopias & "|||" & IIf(mvarConCotizacion, "SI", "NO") & "|" & _
                          mPrinterAnt & "|" & mPrinter & "|" & mAuxS2





        'Index = CInt(mInfo(2))
        'mCarpeta = mInfo(3)
        'mImprime = mInfo(4)
        'mCopias = CInt(mInfo(5))
        'mFormulario = mInfo(6)
        'mConSinAviso = mInfo(7)
        'mNoMostrarImputaciones = mInfo(8)


        output = ImprimirWordDOT(p, Me, SC, Session, Response, IdOrdenPago, mAuxS1, , , System.IO.Path.GetTempPath & "OrdenPago.doc")
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
            Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
            With myOrdenPago
                'esto tiene que estar en el manager, dios!
                DeObjetoHaciaPagina(myOrdenPago)

            End With


            Me.ViewState.Add(mKey, myOrdenPago) 'guardo en el viewstate el objeto
            OrdenPagoManager.Anular(SC, IdOrdenPago, cmbUsuarioAnulo.SelectedValue, txtAnularMotivo.Text)
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

        'acomodar esto por favor

        PanelEncabezadoCliente.Visible = (RadioButtonListEsInterna.SelectedItem.Value <= 1)

        'If RadioButtonListEsInterna.SelectedItem.Value = 3 Then 'Fondo fijo
        '    LinkButtonAsiento.Style.Add("visibility", "hidden")
        'Else
        '    LinkButtonAsiento.Style.Add("visibility", "visible")
        'End If

        chkRecalculoAutomatico.Visible = Not (RadioButtonListEsInterna.SelectedItem.Value <> 2)
        chkRecalculoAutomatico.Checked = False
        'LinkButtonAsiento.Visible = Not (RadioButtonListEsInterna.SelectedItem.Value <> 2)

        PanelEncabezadoFondoFijo.Visible = (RadioButtonListEsInterna.SelectedItem.Value > 2)
        txtNumeroOPcomplementariaFF.Enabled = (RadioButtonListEsInterna.SelectedItem.Value > 2)
        'txtTotalOPComplementariaFF.Enabled = (RadioButtonListEsInterna.SelectedItem.Value > 2)

        PanelEncabezadoCuenta.Visible = Not PanelEncabezadoCliente.Visible
        PanelImputaciones.Visible = RadioButtonListEsInterna.SelectedItem.Value <> 2   'los OrdenPagos solo tienen imputaciones si son a cliente


        UpdatePanelImputaciones.Update()
        UpdatePanelTotales.Update()
        UpdatePanel15.Update()
    End Sub


    Protected Sub lnkAgregarCaja_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAgregarCaja.Click


        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)

        ViewState("IdDetalleOrdenPago") = -1

        'BuscaTextoEnCombo(cmbDetCaja, "Cheque")
        'cmbDetCaja.SelectedValue = -1
        cmbDetCaja.SelectedIndex = 1
        txtDetCajaImporte.Text = OrdenPagoManager.FaltanteDePagar(SC, myOrdenPago)
        ModalPopupExtenderCaja.Show()
    End Sub



    Protected Sub LinkButtonRubro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonRubro.Click

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleOrdenPago") = -1
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
        '    ViewState("IdDetalleOrdenPago") = -1
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
        Dim dtv As DataView
        Dim dt As DataTable
        Dim dt2 As DataTable


        Dim sWHERE = "Convert(Nro_comp_, 'System.String') LIKE '*" & txtBuscaGrillaImputaciones.Text & "*'"

        If RadioButtonListEsInterna.SelectedValue = 1 Then

            dtv = ObjectDataSource2.Select()
            dt = DataTableWHERE(dtv.ToTable, sWHERE)
            dt = DataTableWHERE(dt, "[Saldo Comp_]<>0")
            Dim dtv2 = AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(New DataView(dt))
            gvAuxPendientesImputar.DataSource = dtv2


        ElseIf RadioButtonListEsInterna.SelectedValue = 3 Then 'Fondo Fijo
            dt2 = GetStoreProcedure(SC, enumSPs.OrdenesPago_TX_TraerGastosPendientes, -1, 1, -1, -1)
            'dt = DataTableWHERE(dt2, sWHERE)




            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With
            dt2.Columns.Add(dc)



            With dt2

                dt2.Columns.Add("IdCtaCte")
                dt2.Columns.Add("IdImputacion")
                dt2.Columns.Add("Pedido")
                dt2.Columns.Add("Saldo Comp_")
                dt2.Columns.Add("SaldoTrs")


                '.Columns("IdOrdenPago").ColumnName = "Id"
                .Columns("IdComprobanteProveedor").ColumnName = "IdComprobante"
                .Columns("Tipo comp_").ColumnName = "Comp_"
                .Columns("Numero").ColumnName = "Nro_comp_"
                .Columns("Nro_interno").ColumnName = "Numero"
                .Columns("Fecha comp_").ColumnName = "Fecha"
                .Columns("Total").ColumnName = "Imp_orig_"
            End With




            gvAuxPendientesImputar.DataSource = dt2
        End If


        gvAuxPendientesImputar.DataSourceID = ""
        gvAuxPendientesImputar.DataBind()
    End Sub

    Protected Sub gvAuxPendientesImputar_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvAuxPendientesImputar.PageIndexChanging
        gvAuxPendientesImputar.PageIndex = e.NewPageIndex
        RebindAuxPendientesImputar()
    End Sub


    Protected Sub ObjectDataSource2_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource2.Selecting
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        Dim idproveed = BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, HFSC.Value).ToString
        e.InputParameters("Parametros") = New String() {idproveed.ToString}

        Static Dim ObjectDataSource2Mostrar As Boolean = False

        'If txtBuscaGrillaImputaciones.Text = "buscar" Then
        If Not IsPostBack Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        ObjectDataSource2Mostrar = False
    End Sub

    Protected Sub btnRecalcularAsiento_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecalcularAsiento.Click
        RecalcularRegistroContable()
    End Sub

    Protected Sub cmbDetValorTipo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetValorTipo.SelectedIndexChanged
        OcultarControlesDePopupValorSegunTipoValor()
    End Sub

    Sub OcultarControlesDePopupValorSegunTipoValor()
        Return
        Dim oRs = ConvertToRecordset(EntidadManager.GetStoreProcedure(SC, "TiposComprobante_TX_PorId", cmbDetValorTipo.SelectedValue))

        If iisNull(oRs.Fields("PideBancoCuenta").Value) = "SI" Then
            'ES UNA TRANSFERENCIA BANCARIA

            txtDetValorNumeroInterno.Enabled = False

            txtDetValorCheque.Enabled = False

            cmbDetValorBancoCuenta.Enabled = True

            'txtCodigoCuenta.Enabled = False

            txtDetValorVencimiento.Enabled = True


        ElseIf iisNull(oRs.Fields("PideCuenta").Value) = "SI" Then
            'UN LECOP?

            txtDetValorNumeroInterno.Enabled = False

            txtDetValorCheque.Enabled = False
            cmbDetValorBancoCuenta.Enabled = False

            txtDetValorVencimiento.Enabled = True


        Else
            'ES UN CHEQUE
            txtDetValorNumeroInterno.Enabled = True

            txtDetValorCheque.Enabled = True

            cmbDetValorBancoCuenta.Enabled = False

            'txtCodigoCuenta.Enabled = False
            txtDetValorVencimiento.Enabled = True

        End If


        'If cmbDetValorTipo.SelectedValue = mvarIdTarjetaCredito Then txtNumeroValor.Enabled = False
    End Sub

    Private Function AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(ByRef dt As DataView) As DataView




        If dt.Count = 0 Then Return dt

        Dim dtCopia As DataTable = dt.Table.Copy


        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////

        'genero los registros con los totales (la transaccion)
        Dim q = From i In dtCopia.AsEnumerable() _
               Group By IdImputacion = i("IdImputacion") _
               Into Group _
               Select New With {.IdImputacion = IdImputacion, _
                                .SaldoComp = Group.Sum(Function(i) i.Field(Of Decimal)("Saldo Comp_")), _
                                .RegsEnTransac = Group.Count _
                    }




        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        'inserto esos registros en la tabla original
        Dim dtTotales As DataTable = q.ToDataTable()
        For Each r As DataRow In dtTotales.Rows

            'If r("RegsEnTransac") = 1 Then Continue For

            Dim dr = dtCopia.NewRow
            dr.Item("IdImputacion") = r.Item("IdImputacion")
            dr.Item("SaldoTrs") = r.Item("SaldoComp")

            dtCopia.Rows.Add(dr)

        Next

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////



        'borrar transaccaciones en cero
        dtCopia = BorraTransacciones(dtCopia)

        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////
        '/////////////////////////////////////////////////



        If IsNothing(dtCopia) Then Return Nothing
        Return DataTableORDER(dtCopia, "IdImputacion")




    End Function


    Function BorraTransacciones(ByVal dtCopia As DataTable) As DataTable
        Dim dtDest As DataTable = dtCopia.Clone

        Dim ImputacionesConTransEnCero = From i In dtCopia.AsEnumerable() _
                Where iisNull(i("SaldoTrs"), -1) = 0 _
                       Select iisNull(i("IdImputacion"), -1)


        Dim a = ImputacionesConTransEnCero.ToList

        '//////////////////////
        '//////////////////////
        'metodo 1 (no anda porque despues no puedo convertirlo en datatable)
        Dim Filtradas = From i In dtCopia.AsEnumerable _
                    Where (Not ImputacionesConTransEnCero.Contains(i("IdImputacion"))) _
                    Select i




        If Filtradas.Count > 0 Then
            Return Filtradas.CopyToDataTable
        Else
            Return Nothing
        End If




        '//////////////////////
        '//////////////////////

        'metodo 2

        'Dim dt = ImputacionesConTransEnCero.ToDataTable
        For Each r In dtCopia.Rows
            'ImputacionesConTransEnCero.

            Dim bEsta As Boolean = False
            For Each i In a
                Dim Id As Long = iisNull(i, -1)
                If Id = iisNull(r("IdImputacion"), -1) Then

                    'If Id = -1 Then
                    '    bEsta = True
                    '    Exit For
                End If
            Next
            If Not bEsta Then
                dtDest.ImportRow(r)
            End If

            'Next

            'If From ImputacionesConTransEnCero   Then
            ' where (rows1.Any(x => x.COLUMN_B == t2.COLUMN_A))
            '    If Not ImputacionesConTransEnCero("IdImputacion").Contains(r("IdImputacion")) Then
            '        dtDest.ImportRow(r)
            '    End If
        Next



        '//////////////////////
        '//////////////////////

        Return dtDest
        'Return Filtradas.ToDataTable
        'Dim dtFiltradas As DataTable = Filtradas.ToDataTable()

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


    'Protected Sub txtOtrosImporte_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) _
    '    Handles txtOtrosImporte1.TextChanged, _
    '            txtOtrosImporte2.TextChanged, _
    '            txtOtrosImporte3.TextChanged, _
    '            txtOtrosImporte4.TextChanged, _
    '            txtOtrosImporte5.TextChanged

    '    RecalcularTotalComprobante()
    'End Sub










    Protected Sub LinkButtonImputacionPagoAnticipado_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonImputacionPagoAnticipado.Click
        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)
        OrdenPagoManager.AgregarImputacionSinAplicacionOPagoAnticipado(SC, myOrdenPago)
        'ecalcularRegistroContable()
        SuperReBind(myOrdenPago)
        Me.ViewState.Add(mKey, myOrdenPago)
    End Sub








    Sub DeObjetoHaciaPagina(ByRef myOrdenPago As Pronto.ERP.BO.OrdenPago)
        RecargarEncabezado(myOrdenPago)

        OrdenPagoManager.RefrescarDesnormalizados(SC, myOrdenPago)

        gvImputaciones.DataSource = myOrdenPago.DetallesImputaciones
        gvImputaciones.DataBind()

        gvValores.DataSource = myOrdenPago.DetallesValores
        gvValores.DataBind()

        gvImpuestosCalculados.DataSource = myOrdenPago.DetallesImpuestos
        gvImpuestosCalculados.DataBind()

        gvCuentas.DataSource = myOrdenPago.DetallesCuentas
        gvCuentas.DataBind()

        gvRubrosContables.DataSource = myOrdenPago.DetallesRubrosContables
        gvRubrosContables.DataBind()


    End Sub

    Sub DePaginaHaciaObjeto(ByRef myOrdenPago As Pronto.ERP.BO.OrdenPago)
        With myOrdenPago

            'traigo parámetros generales
            Dim drParam As DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            '.IdMoneda = drParam.Item("ProximoOrdenPagoReferencia").ToString 'mIdMonedaPesos
            .IdMoneda = cmbMoneda.SelectedValue

            '.SubNumero = StringToDecimal(txtNumeroOrdenPago1.Text)
            '.TipoABC = txtLetra.Text
            '.Cotizacion = 1
            .CotizacionMoneda = 1

            'Qué nombre estandar defino para estas propiedades genericas?
            .NumeroOrdenPago = StringToDecimal(txtNumeroOrdenPago2.Text)
            '.NumeroOrdenPago = StringToDecimal(txtNumeroOrdenPago2.Text)
            '.FechaIngreso = txtFechaIngreso.Text
            .FechaIngreso = txtFechaIngreso.Text
            .FechaOrdenPago = txtFechaIngreso.Text

            '.NumeroCertificadoRetencionGanancias = Val(txtCertificadoGanancias.Text)
            '.NumeroCertificadoRetencionIngresosBrutos = Val(txtCertificadoIngresosBrutos.Text)
            '.NumeroCertificadoRetencionIVA = Val(txtCertificadoRetencionIVA.Text)





            .Dolarizada = ProntoCheckSINO(chkCalcularDiferenciaCambio)
            .Exterior = ProntoCheckSINO(chkExterior)


            .NumeroRendicionFF = Val(txtNumeroRendicionFondoFijo.Text)



            '.destinatario=
            .OPInicialFF = ProntoCheckSINO(chkInicialFondoFijo)

            '.IdOPComplementariaFF=




            '.IdPuntoVenta = cmbPuntoVenta.SelectedValue
            '.IdPuntoVenta = OrdenPagoManager.IdPuntoVentaComprobanteOrdenPagoSegunSubnumeroYLetra(SC, cmbPuntoVenta.Text, txtLetra.Text)
            '.PuntoVenta = cmbPuntoVenta.SelectedItem.Text

            If RadioButtonListEsInterna.SelectedValue = 1 Then
                'de proveedor
                .Tipo = OrdenPago.tipoOP.CC
                .IdProveedor = BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, SC)
                .IdCuenta = Nothing
            ElseIf RadioButtonListEsInterna.SelectedValue = 2 Then
                '"otros".  a cuenta
                .IdProveedor = Nothing
                .IdCuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAutocompleteCuenta.Text, SC)
                .Tipo = OrdenPago.tipoOP.OT
            Else 'fondofijo
                .Tipo = OrdenPago.tipoOP.FF
            End If



            'Select Case RadioButtonListEsInterna.SelectedItem.Value - 1
            '    Case 1
            '        .Tipo = "CC"
            '    Case 2
            '        .Tipo = "OT"
            '    Case 3
            '        .Tipo = "FF"
            'End Select


            If .Estado <> OrdenPago.tipoEstado.CA And .Estado <> OrdenPago.tipoEstado.EN Then .Estado = OrdenPago.tipoEstado.FI 'CA,FI,EN

            '.IdProveedor = BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, SC)
            '.IdCuenta = BuscaIdCuentaPreciso(txtAutocompleteCuenta.Text, SC)
            '.IdCondicionVenta = cmbRetencionGanancia.SelectedValue
            '.IdTipoRetencionGanancia = cmbRetencionGanancia.SelectedValue


            .IdObra = cmbObra.SelectedValue

            .Observaciones = txtObservaciones.Text


            .IdMoneda = cmbMoneda.SelectedValue


            '.ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
            .Observaciones = txtObservaciones.Text

            .Descuentos = Val(txtTotalDescuentos.Text)
            .RetencionGanancias = Val(txtTotalRetencionGanancias.Text)
            .RetencionIBrutos = Val(txtTotalRetencionIIBB.Text)
            .RetencionIVA = Val(txtTotalRetencionIVA.Text)
            .RetencionSUSS = Val(txtTotalRetencionSUSS.Text)





            Try
                .IdOPComplementariaFF = GetStoreProcedureTop1(SC, enumSPs.OrdenesPago_TX_PorNumeroFF, txtNumeroOPcomplementariaFF.Text).Item("IdOrdenPago")
                .TotalOPcomplementaria = Val(txtTotalOPComplementariaFF.Text)
            Catch ex As Exception

            End Try



            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////
            '////////////////////////////////////////////////////


        End With

    End Sub


    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
        Try
            RefrescarNumeroTalonario()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnCertificarGanancias_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCertificarGanancias.Click
        'If Len(txtRetGan.Text) = 0 Then
        '    MsgBox("No ha ingresado el monto de retencion", vbExclamation)
        '    Exit Sub
        'End If

        'If Not mvarGrabado Then
        '    MsgBox("Antes de imprimir debe grabar el comprobante!", vbCritical)
        '    Exit Sub
        'End If
        MandarArchivo(EmisionCertificadoRetencionGanancias(IdOrdenPago, "Word", 0, SC, Session))
    End Sub

    Protected Sub btnCertificarIIBB_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCertificarIIBB.Click
        'If Len(txtIngBru.Text) = 0 Then
        '    MsgBox("No ha ingresado el monto de retencion", vbExclamation)
        '    Exit Sub
        'End If

        'If Not mvarGrabado Then
        '    MsgBox("Antes de imprimir debe grabar el comprobante!", vbCritical)
        '    Exit Sub
        'End If

        MandarArchivo(EmisionCertificadoRetencionIIBB(IdOrdenPago, "Word", 0, SC, Session))
    End Sub

    Protected Sub btnCertificarIVA_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCertificarIVA.Click
        'If Len(txtRetIva.Text) = 0 Then
        '    MsgBox("No ha ingresado el monto de retencion", vbExclamation)
        '    Exit Sub
        'End If

        'If Not mvarGrabado Then
        '    MsgBox("Antes de imprimir debe grabar el comprobante!", vbCritical)
        '    Exit Sub
        'End If

        Dim output = EmisionCertificadoRetencionIVA(IdOrdenPago, "Word", 0, SC, Session)
        MandarArchivo(output)

        Return

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

    Sub MandarArchivo(ByVal output As String)

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
                ErrHandler2.WriteError("No se pudo generar el informe. Consulte al administrador")
                'MsgBoxAjax(Yo, "No se pudo generar el informe. Consulte al administrador")
                Return
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'MsgBoxAjax(Yo, ex.ToString)
            'Return ""
        End Try


    End Sub



    Protected Sub btnCertificarSSUS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkCertificarSSUS.Click
        'If Len(txtRetencionSUSS.Text) = 0 Then
        '    MsgBox("No ha ingresado el monto de retencion", vbExclamation)
        '    Exit Sub
        'End If

        'If Not mvarGrabado Then
        '    MsgBox("Antes de imprimir debe grabar el comprobante!", vbCritical)
        '    Exit Sub
        'End If

        MandarArchivo(EmisionCertificadoRetencionSUSS(IdOrdenPago, "Word", 0, SC, Session))
    End Sub

    Protected Sub txtNumeroOPcomplementariaFF_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroOPcomplementariaFF.TextChanged

        If Len(txtNumeroOPcomplementariaFF.Text) <> 0 Then
            If IsNumeric(txtNumeroOPcomplementariaFF.Text) Then
                Dim oRs = GetStoreProcedureTop1(SC, enumSPs.OrdenesPago_TX_PorNumeroFF, txtNumeroOPcomplementariaFF.Text)
                If oRs Is Nothing Then
                    txtNumeroOPcomplementariaFF.Text = ""
                    txtTotalOPComplementariaFF.Text = ""
                    MsgBoxAjax(Me, "Numero de orden de pago inexistente")
                Else
                    'oRs.Item("IdOPComplementariaFF").Value = oRs.Item(0)
                    txtTotalOPComplementariaFF.Text = oRs.Item("Valores")
                End If
            Else
                txtNumeroOPcomplementariaFF.Text = ""
                txtTotalOPComplementariaFF.Text = ""
                MsgBoxAjax(Me, "El campo debe ser numerico")
            End If
        End If

    End Sub




    Protected Sub chkExterior_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkExterior.CheckedChanged
        RefrescarNumeroTalonario()
    End Sub

    Protected Sub chkCalcularDiferenciaCambio_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkCalcularDiferenciaCambio.CheckedChanged
        MostrarDiferenciaCambio()
    End Sub




    Public Sub MostrarDiferenciaCambio()
        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)

        If Not chkCalcularDiferenciaCambio.Checked Then
            txtTotalDiferenciaCambio.Text = 0
        Else

            txtTotalDiferenciaCambio.Text = FF2(OrdenPagoManager.ValorDiferenciaCambio(SC, myOrdenPago))
        End If

    End Sub



    Protected Sub LinkButtonAplicarDiferenciaDeCambio_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonAplicarDiferenciaDeCambio.Click

        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)
        DePaginaHaciaObjeto(myOrdenPago)

        OrdenPagoManager.AgregarDiferenciaCambio(SC, myOrdenPago)

        'RebindImp()
        SuperReBind(myOrdenPago)
        Me.ViewState.Add(mKey, myOrdenPago)

    End Sub













    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////





    Public Shared Function EmisionCertificadoRetencionGanancias(ByVal mIdOrdenPago As String, _
                                                            ByVal mDestino As String, _
                                                            ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

        Dim oW As Word.Application
        Dim oRs As adodb.Recordset
        Dim mNumeroCertificado As Long, mIdProveedor As Long
        Dim mCopias As Integer
        Dim mFecha As Date
        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String
        Dim mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String, mPlantilla As String
        Dim mRetenido As Double, mCotMon As Double, mMontoOrigen As Double



        'mPlantilla = session("glbPathPlantillas") & "\CertificadoRetencionGanancias_" & session("glbEmpresaSegunString") & ".dot"
        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionGanancias.dot" '_" & Session("glbEmpresaSegunString") & ".dot"

        mCopias = 1
        mAux1 = BuscarClaveINI("Copias retenciones en op", SC, session(SESSIONPRONTO_glbIdUsuario))
        If IsNumeric(mAux1) Then mCopias = Val(mAux1)

        Try
            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
            With oRs
                mComprobante = FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000")
                mIdProveedor = .Fields("IdProveedor").Value
                mCotMon = .Fields("CotizacionMoneda").Value
                mFecha = .Fields("FechaOrdenPago").Value
                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
                .Close()
            End With

        Catch ex As Exception

        End Try

        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
        If oRs.RecordCount > 0 Then
            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
        End If
        oRs.Close()
        oRs = Nothing

        oW = CreateObject("Word.Application")



        oRs = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPagoImpuestos_TXOrdenPago, mIdOrdenPago)
        If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
                oRs.MoveFirst()
                Do While Not oRs.EOF
                    If iisNull(oRs.Fields("Tipo").Value) = "Ganancias" And _
                          Not IsNull(oRs.Fields("Certif_Gan_").Value) Then

                        mNumeroCertificado = oRs.Fields("Certif_Gan_").Value
                        mMontoOrigen = oRs.Fields("Pago s/imp_").Value * mCotMon
                        mRetenido = oRs.Fields("Retencion").Value * mCotMon

                        With oW
                            .Visible = False

                            With .Documents.Add(mPlantilla)
                                oW.DisplayAlerts = False
                                oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
                                oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                                oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
                                oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
                                oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
                                oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                                oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                                oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                                oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
                                oW.ActiveDocument.FormFields("Regimen").Result = iisNull(oRs.Fields("Categoria").Value)
                                oW.ActiveDocument.FormFields("MontoOrigen").Result = FormatVB6(mMontoOrigen, "$ #,##0.00")
                                oW.ActiveDocument.FormFields("Retencion").Result = FormatVB6(mRetenido, "$ #,##0.00")
                                oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
                                mAux1 = BuscarClaveINI("Aclaracion para certificado de retencion de ganancias", SC, session(SESSIONPRONTO_glbIdUsuario))
                                If Len(mAux1) > 0 Then
                                    oW.ActiveDocument.FormFields("Aclaracion").Result = mAux1
                                End If
                            End With
                        End With

                        'If mDestino = "Printer" Then
                        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
                        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
                        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                        '    oW.Documents(1).Close(False)
                        'End If

                        Exit Do

                    End If
                    oRs.MoveNext()
                Loop
            End If
        End If
        oRs.Close()

        'oW.Selection.HomeKey(Word.WdUnits.wdStory)

        Dim output As String = System.IO.Path.GetTempPath & "CertificadoGanancias.doc"

        Try
            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
        Catch ex As Exception
            'ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.ToString)
            'Throw
        End Try


        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
        'If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
        'NAR(oDoc)
        oW.Quit()
        NAR(oW)
        GC.Collect()


        Return output

        If mDestino = "Printer" Then oW.Quit()
        oW = Nothing
        oRs = Nothing

    End Function






    Public Shared Function EmisionCertificadoRetencionIIBB(ByVal mIdOrdenPago As String, _
                                                    ByVal mDestino As String, _
                                                    ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

        Dim oW As Word.Application
        Dim cALetra 'As New clsNum2Let
        Dim oRs As adodb.Recordset
        Dim oRsAux As adodb.Recordset
        Dim mNumeroCertificado As Long, mIdProveedor As Long
        Dim mCopias As Integer
        Dim mFecha As Date
        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mCuitSujeto As String, mProvincia As String
        Dim mPrinterAnt As String, mIBNumeroInscripcion As String, mAux1 As String, mPlantilla As String, mPlantilla1 As String
        Dim mCodPos As String, mImporteLetras As String, mAnulada As String
        Dim mRetenido As Double, mRetencionAdicional As Double, mCotMon As Double



        mCopias = 1
        mAux1 = BuscarClaveINI("Copias retenciones en op", SC, session(SESSIONPRONTO_glbIdUsuario))
        If IsNumeric(mAux1) Then mCopias = Val(mAux1)

        Try

            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
            With oRs
                mComprobante = FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000")
                mIdProveedor = .Fields("IdProveedor").Value
                mCotMon = .Fields("CotizacionMoneda").Value
                mFecha = .Fields("FechaOrdenPago").Value
                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
                .Close()
            End With
        Catch ex As Exception

        End Try

        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
        If oRs.RecordCount > 0 Then
            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
            mIBNumeroInscripcion = IIf(IsNull(oRs.Fields("IBNumeroInscripcion").Value), "", oRs.Fields("IBNumeroInscripcion").Value)
            mCodPos = IIf(IsNull(oRs.Fields("CodigoPostal").Value), "", oRs.Fields("CodigoPostal").Value)
            '      If Not IsNull(oRs.Fields("PlantillaRetencionIIBB").Value) Then
            '         If Len(RTrim(oRs.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
            '            mPlantilla = oRs.Fields("PlantillaRetencionIIBB").Value
            '         End If
            '      End If
        End If
        oRs.Close()
        oRs = Nothing

        oW = CreateObject("Word.Application")

        oRs = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPagoImpuestos_TXOrdenPago, mIdOrdenPago)
        If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
                oRs.MoveFirst()
                Do While Not oRs.EOF
                    If iisNull(oRs.Fields("Tipo").Value) = "I.Brutos" And _
                          Not IsNull(oRs.Fields("Certif_IIBB").Value) Then

                        mNumeroCertificado = oRs.Fields("Certif_IIBB").Value
                        mRetenido = oRs.Fields("Retencion").Value * mCotMon
                        mRetencionAdicional = IIf(IsNull(oRs.Fields("Impuesto adic_").Value), 0, oRs.Fields("Impuesto adic_").Value) * mCotMon

                        mPlantilla = "CertificadoRetencionIIBB.dot"
                        oRsAux = TraerFiltradoVB6(SC, enumSPs.IBCondiciones_TX_IdCuentaPorProvincia, oRs.Fields("IdTipoImpuesto").Value)
                        If oRsAux.RecordCount > 0 Then
                            If Not IsNull(oRsAux.Fields("PlantillaRetencionIIBB").Value) Then
                                If Len(RTrim(oRsAux.Fields("PlantillaRetencionIIBB").Value)) > 0 Then
                                    mPlantilla = oRsAux.Fields("PlantillaRetencionIIBB").Value
                                End If
                            End If
                        End If
                        oRsAux.Close()

                        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionIIBB.dot" '_" & Session("glbEmpresaSegunString") & ".dot"


                        'mPlantilla1 = Mid(mPlantilla, 1, Len(mPlantilla) - 4)
                        'mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & "_" & glbEmpresaSegunString & ".dot"
                        'If Len(Dir(mPlantilla)) = 0 Then
                        '    mPlantilla = glbPathPlantillas & "\" & mPlantilla1 & ".dot"
                        '    If Len(Dir(mPlantilla)) = 0 Then
                        '        MsgBox("Plantilla " & mPlantilla & " inexistente", vbExclamation)
                        '        Exit Sub
                        '    End If
                        'End If



                        With oW
                            .Visible = False
                            With .Documents.Add(mPlantilla)

                                If InStr(1, mPlantilla, "Salta") = 0 Then
                                    oW.DisplayAlerts = False
                                    oW.ActiveDocument.FormFields("NumeroCertificado").Result = FormatVB6(mNumeroCertificado, "00000000")
                                    oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                                    oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
                                    oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
                                    oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
                                    oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                                    oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                                    oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                                    oW.ActiveDocument.FormFields("NumeroInscripcion").Result = mIBNumeroInscripcion
                                    oW.ActiveDocument.FormFields("Anulada").Result = mAnulada

                                    oW.Selection.GoTo(What:=wdGoToBookmark, Name:="DetalleComprobantes")
                                    oW.Selection.MoveDown(Unit:=wdLine)
                                    oW.Selection.MoveLeft(Unit:=wdCell)
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & oRs.Fields("Categoria").Value)
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00"))
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(oRs.Fields("Pagos mes").Value, "#,##0.00"))
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(oRs.Fields("Ret_ mes").Value, "#,##0.00"))
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & oRs.Fields("% a tomar s/base").Value)
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & oRs.Fields("Alicuota_IIBB").Value)
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido - mRetencionAdicional, "#,##0.00"))
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & oRs.Fields("% adic_").Value)
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetencionAdicional, "#,##0.00"))
                                    oW.Selection.MoveRight(Unit:=wdCell)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido, "#,##0.00"))

                                    oW.Selection.GoTo(What:=wdGoToBookmark, Name:="TotalRetencion")
                                    oW.Selection.MoveRight(Unit:=wdCell, Count:=2)
                                    oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido, "#,##0.00"))

                                ElseIf InStr(1, mPlantilla, "Salta") > 0 Then
                                    oW.DisplayAlerts = False
                                    cALetra.Numero = mRetenido
                                    mImporteLetras = cALetra.ALetra
                                    oW.ActiveDocument.FormFields("NombreSujeto1").Result = mNombreSujeto
                                    oW.ActiveDocument.FormFields("CuitSujeto1").Result = mCuitSujeto
                                    oW.ActiveDocument.FormFields("DomicilioSujeto1").Result = mDomicilioSujeto
                                    oW.ActiveDocument.FormFields("CodigoPostal1").Result = mCodPos
                                    oW.ActiveDocument.FormFields("Monto1").Result = FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00")
                                    oW.ActiveDocument.FormFields("Alicuota1").Result = oRs.Fields("Alicuota_IIBB").Value
                                    oW.ActiveDocument.FormFields("Retencion1").Result = mRetenido
                                    oW.ActiveDocument.FormFields("ImporteEnLetras1").Result = mImporteLetras
                                    oW.ActiveDocument.FormFields("Fecha1").Result = mFecha

                                    oW.ActiveDocument.FormFields("NombreSujeto2").Result = mNombreSujeto
                                    oW.ActiveDocument.FormFields("CuitSujeto2").Result = mCuitSujeto
                                    oW.ActiveDocument.FormFields("DomicilioSujeto2").Result = mDomicilioSujeto
                                    oW.ActiveDocument.FormFields("CodigoPostal2").Result = mCodPos
                                    oW.ActiveDocument.FormFields("Monto2").Result = FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00")
                                    oW.ActiveDocument.FormFields("Alicuota2").Result = oRs.Fields("Alicuota_IIBB").Value
                                    oW.ActiveDocument.FormFields("Retencion2").Result = mRetenido
                                    oW.ActiveDocument.FormFields("ImporteEnLetras2").Result = mImporteLetras
                                    oW.ActiveDocument.FormFields("Fecha2").Result = mFecha

                                    oW.ActiveDocument.FormFields("NombreSujeto3").Result = mNombreSujeto
                                    oW.ActiveDocument.FormFields("CuitSujeto3").Result = mCuitSujeto
                                    oW.ActiveDocument.FormFields("DomicilioSujeto3").Result = mDomicilioSujeto
                                    oW.ActiveDocument.FormFields("CodigoPostal3").Result = mCodPos
                                    oW.ActiveDocument.FormFields("Monto3").Result = FormatVB6(oRs.Fields("Pago s/imp_").Value * mCotMon, "#,##0.00")
                                    oW.ActiveDocument.FormFields("Alicuota3").Result = oRs.Fields("Alicuota_IIBB").Value
                                    oW.ActiveDocument.FormFields("Retencion3").Result = mRetenido
                                    oW.ActiveDocument.FormFields("ImporteEnLetras3").Result = mImporteLetras
                                    oW.ActiveDocument.FormFields("Fecha3").Result = mFecha

                                End If

                            End With
                        End With

                        'If mDestino = "Printer" Then
                        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
                        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
                        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
                        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
                        '    oW.Documents(1).Close(False)
                        'End If



                        Exit Do



                    End If
                    oRs.MoveNext()
                Loop
            End If
        End If
        oRs.Close()

        ' oW.Selection.HomeKey(wdStory)


        Dim output As String = System.IO.Path.GetTempPath & "CertificadoIIBB.doc"

        Try
            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
        Catch ex As Exception
            ErrHandler2.WriteError("Explotó el .SaveAs()  ") ' & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.ToString)
            'MsgBoxAjax(Me, "No se generó el certificado")

        End Try


        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
        'If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
        'NAR(oW.ActiveDocument)
        oW.Quit()
        NAR(oW)
        GC.Collect()

        Return output


    End Function









    Public Shared Function EmisionCertificadoRetencionIVA(ByVal mIdOrdenPago As String, _
                                                    ByVal mDestino As String, _
                                                    ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

        Dim oW As Word.Application
        Dim oRs As adodb.Recordset
        Dim oRsDet As adodb.Recordset
        Dim mNumeroCertificado As Long, mIdProveedor As Long
        Dim mCopias As Integer
        Dim mFecha As Date
        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mPlantilla As String
        Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String
        Dim mRetenido As Double, mCotMon As Double



        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionIVA.dot" '_" & Session("glbEmpresaSegunString") & ".dot"

        'mPlantilla = glbPathPlantillas & "\CertificadoRetencionIVA_" & glbEmpresaSegunString & ".dot"
        'If Len(Dir(mPlantilla)) = 0 Then
        '    mPlantilla = glbPathPlantillas & "\CertificadoRetencionIVA.dot"
        '    If Len(Dir(mPlantilla)) = 0 Then
        '        MsgBox("Plantilla " & mPlantilla & " inexistente", vbExclamation)
        '        Exit Sub
        '    End If
        'End If

        mCopias = 1
        mAux1 = BuscarClaveINI("Copias retenciones en op", SC, session(SESSIONPRONTO_glbIdUsuario))
        If IsNumeric(mAux1) Then mCopias = Val(mAux1)

        Try
            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
            With oRs
                mNumeroCertificado = iisNull(.Fields("NumeroCertificadoRetencionIVA").Value, 0)
                mComprobante = iisNull(FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000"), 0)
                mIdProveedor = iisNull(.Fields("IdProveedor").Value, 0)
                mCotMon = iisNull(.Fields("CotizacionMoneda").Value, 0)
                mFecha = .Fields("FechaOrdenPago").Value
                mRetenido = .Fields("RetencionIVA").Value * mCotMon
                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
                .Close()
            End With
        Catch ex As Exception

        End Try

        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
        If oRs.RecordCount > 0 Then
            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
        End If
        oRs.Close()
        oRs = Nothing

        oW = CreateObject("Word.Application")

        With oW
            .Visible = False
            With .Documents.Add(mPlantilla)
                oW.DisplayAlerts = False
                oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
                oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
                oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
                oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
                oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                '         oW.ActiveDocument.FormFields("Comprobante").Result = mComprobante
                oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
            End With
        End With

        oRsDet = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPago_TXOrdenPago, mIdOrdenPago)
        oW.Selection.GoTo(What:=wdGoToBookmark, Name:="DetalleComprobantes")
        oW.Selection.MoveDown(Unit:=wdLine)
        oW.Selection.MoveLeft(Unit:=wdCell)
        With oRsDet
            If .RecordCount > 0 Then
                .MoveFirst()
                Do While Not .EOF
                    If Not IsNull(.Fields("Ret_Iva").Value) And .Fields("Ret_Iva").Value <> 0 Then
                        oW.Selection.MoveRight(Unit:=wdCell)
                        oW.Selection.TypeText(Text:="" & .Fields("Comp_").Value & " " & _
                              .Fields("Numero").Value)
                        oW.Selection.MoveRight(Unit:=wdCell)
                        oW.Selection.TypeText(Text:="" & .Fields("Fecha").Value)
                        oW.Selection.MoveRight(Unit:=wdCell)
                        oW.Selection.TypeText(Text:="" & Math.Round(.Fields("Tot_Comp_").Value * IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value), 2))
                        oW.Selection.MoveRight(Unit:=wdCell)
                        oW.Selection.TypeText(Text:="" & Math.Round(.Fields("IVA").Value * IIf(IsNull(.Fields("CotizacionMoneda").Value), 1, .Fields("CotizacionMoneda").Value), 2))
                        oW.Selection.MoveRight(Unit:=wdCell)
                        oW.Selection.TypeText(Text:="" & .Fields("Ret_Iva").Value * mCotMon)
                    End If
                    .MoveNext()
                Loop
            End If
            .Close()
        End With
        oRsDet = Nothing

        oW.Selection.GoTo(What:=wdGoToBookmark, Name:="TotalRetencion")
        oW.Selection.MoveRight(Unit:=wdCell, Count:=2)
        oW.Selection.TypeText(Text:="" & FormatVB6(mRetenido, "#,##0.00"))

        'If mDestino = "Printer" Then
        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
        '    oW.Documents(1).Close(False)
        'End If

        oW.Selection.HomeKey(wdStory)

Mal:

        Dim output As String = System.IO.Path.GetTempPath & "CertificadoIVA.doc"

        Try
            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
        Catch ex As Exception
            ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.ToString)
            Throw
        End Try


        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
        If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
        'NAR(oDoc)
        oW.Quit()
        NAR(oW)
        GC.Collect()


        Return output 'porque no estoy pudiendo ejecutar el response desde acá

    End Function























    Public Shared Function EmisionCertificadoRetencionSUSS(ByVal mIdOrdenPago As String, _
                                                    ByVal mDestino As String, _
                                                    ByVal mPrinter As String, ByVal SC As String, ByVal Session As System.Web.SessionState.HttpSessionState) As String

        Dim oW As Word.Application
        Dim oRs As adodb.Recordset
        Dim oRsDet As adodb.Recordset
        Dim oRsAux As adodb.Recordset
        Dim mNumeroCertificado As Long, mIdProveedor As Long
        Dim mCopias As Integer
        Dim mFecha As Date
        Dim mComprobante As String, mNombreSujeto As String, mDomicilioSujeto As String, mPlantilla As String
        Dim mCuitSujeto As String, mProvincia As String, mPrinterAnt As String, mAux1 As String, mAnulada As String
        Dim mRetenido As Double, mCotMon As Double, mvarPorcentajeRetencionSUSS As Double
        Dim mvarBaseCalculoSUSS As Double



        mPlantilla = DirApp() & "\Documentos" & "\CertificadoRetencionSUSS.dot" '_" & Session("glbEmpresaSegunString") & ".dot"

        'mPlantilla = glbPathPlantillas & "\CertificadoRetencionSUSS_" & glbEmpresaSegunString & ".dot"
        'If Len(Dir(mPlantilla)) = 0 Then
        '    mPlantilla = glbPathPlantillas & "\CertificadoRetencionSUSS.dot"
        '    If Len(Dir(mPlantilla)) = 0 Then
        '        MsgBox("Plantilla " & mPlantilla & " inexistente", vbExclamation)
        '        Exit Sub
        '    End If
        'End If

        mCopias = 1
        mAux1 = BuscarClaveINI("Copias retenciones en op", SC, session(SESSIONPRONTO_glbIdUsuario))
        If IsNumeric(mAux1) Then mCopias = Val(mAux1)


        mvarPorcentajeRetencionSUSS = iisNull(ParametroOriginal(SC, ePmOrg.PorcentajeRetencionSUSS), 0)

        Try
            oRs = TraerFiltradoVB6(SC, enumSPs.OrdenesPago_TX_PorId, mIdOrdenPago)
            With oRs
                mNumeroCertificado = iisNull(.Fields("NumeroCertificadoRetencionSUSS").Value, 0)
                mComprobante = FormatVB6(.Fields("NumeroOrdenPago").Value, "00000000")
                mIdProveedor = iisNull(.Fields("IdProveedor").Value, 0)
                mCotMon = iisNull(.Fields("CotizacionMoneda").Value, 0)
                mFecha = iisNull(.Fields("FechaOrdenPago").Value)
                mRetenido = .Fields("RetencionSUSS").Value * mCotMon
                If IIf(IsNull(.Fields("Anulada").Value), "", .Fields("Anulada").Value) = "SI" Then mAnulada = "ANULADA"
                .Close()
            End With

        Catch ex As Exception

        End Try

        oRs = TraerFiltradoVB6(SC, enumSPs.Proveedores_TX_ConDatos, mIdProveedor)
        If oRs.RecordCount > 0 Then
            mNombreSujeto = IIf(IsNull(oRs.Fields("RazonSocial").Value), "", oRs.Fields("RazonSocial").Value)
            mProvincia = IIf(IsNull(oRs.Fields("Provincia").Value), "", oRs.Fields("Provincia").Value)
            If UCase(mProvincia) = "CAPITAL FEDERAL" Then mProvincia = ""
            mDomicilioSujeto = Trim(IIf(IsNull(oRs.Fields("Direccion").Value), "", oRs.Fields("Direccion").Value)) & " " & _
                                 Trim(IIf(IsNull(oRs.Fields("Localidad").Value), "", oRs.Fields("Localidad").Value)) & " " & mProvincia
            mCuitSujeto = IIf(IsNull(oRs.Fields("Cuit").Value), "", oRs.Fields("Cuit").Value)
            If Not IsNull(oRs.Fields("IdImpuestoDirectoSUSS").Value) Then
                oRsAux = TraerFiltradoVB6(SC, enumSPs.ImpuestosDirectos_TX_PorId, oRs.Fields("IdImpuestoDirectoSUSS").Value)
                If oRsAux.RecordCount > 0 Then
                    mvarPorcentajeRetencionSUSS = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
                End If
                oRsAux.Close()
            End If
        End If
        oRs.Close()

        oRsDet = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPago_TXOrdenPago, mIdOrdenPago)
        mvarBaseCalculoSUSS = 0
        With oRsDet
            If .RecordCount > 0 Then
                .MoveFirst()
                Do While Not .EOF
                    If Not IsNull(.Fields("s/impuesto").Value) And .Fields("Gravado IVA").Value <> 0 Then
                        mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Gravado IVA").Value
                    Else
                        mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + .Fields("Importe").Value
                    End If
                    .MoveNext()
                Loop
            End If
            .Close()
        End With

        oW = CreateObject("Word.Application")

        With oW
            .Visible = False
            With .Documents.Add(mPlantilla)
                oW.ActiveDocument.FormFields("NumeroCertificado").Result = mNumeroCertificado
                oW.ActiveDocument.FormFields("Fecha").Result = mFecha
                oW.ActiveDocument.FormFields("NombreAgente").Result = Session("glbEmpresa")
                oW.ActiveDocument.FormFields("CuitAgente").Result = Session("glbCuit")
                oW.ActiveDocument.FormFields("DomicilioAgente").Result = Session("glbDireccion") & " " & Session("glbLocalidad") & " " & Session("glbProvincia")
                oW.ActiveDocument.FormFields("NombreSujeto").Result = mNombreSujeto
                oW.ActiveDocument.FormFields("CuitSujeto").Result = mCuitSujeto
                oW.ActiveDocument.FormFields("DomicilioSujeto").Result = mDomicilioSujeto
                oW.ActiveDocument.FormFields("Comprobante").Result = "OP " & mComprobante
                oW.ActiveDocument.FormFields("Porcentaje").Result = mvarPorcentajeRetencionSUSS
                oW.ActiveDocument.FormFields("BaseCalculoSUSS").Result = FormatVB6(mvarBaseCalculoSUSS, "#,##0.00")
                oW.ActiveDocument.FormFields("Retenido").Result = FormatVB6(mRetenido, "#,##0.00")
                oW.ActiveDocument.FormFields("Anulada").Result = mAnulada
            End With
        End With

        oW.Selection.HomeKey(wdStory)

        'If mDestino = "Printer" Then
        '    mPrinterAnt = Printer.DeviceName & " on " & Printer.Port
        '    If Len(mPrinter) > 0 Then oW.ActivePrinter = mPrinter
        '    oW.Documents(1).PrintOut(False, , , , , , , mCopias)
        '    If Len(mPrinterAnt) > 0 Then oW.ActivePrinter = mPrinterAnt
        '    oW.Documents(1).Close(False)
        'End If


        Dim output As String = System.IO.Path.GetTempPath & "CertificadoSUSS.doc"

        Try
            oW.ActiveDocument.SaveAs(output, wrdFormatDocument) 'adherir extension ".doc"
        Catch ex As Exception
            ErrHandler2.WriteError("Explotó el .SaveAs()  " & IsNothing(oW.ActiveDocument) & " " & output & " " & wrdFormatDocument & ex.ToString)
            Throw
        End Try


        'oW.DisplayAlerts  = True '  Word.WdAlertLevel.wdAlertsAll ' True
        If Not oW.ActiveDocument Is Nothing Then oW.ActiveDocument.Close(False)
        'NAR(oDoc)
        oW.Quit()
        NAR(oW)
        GC.Collect()


        Return output

Mal:

        If mDestino = "Printer" Then oW.Quit()
        oW = Nothing
        oRs = Nothing
        oRsDet = Nothing
        oRsAux = Nothing

    End Function




    Protected Sub cmbDetValorBancoCuenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetValorBancoCuenta.SelectedIndexChanged

        Rebind_cmbDetValorChequeras()
        'If oRs.RecordCount > 0 Then
        '    If Not IsNull(origen.Registro.Fields("IdBancoChequera").Value) Then
        '        DataCombo1(2).BoundText = origen.Registro.Fields("IdBancoChequera").Value
        '    End If
        'End If

    End Sub

    Sub Rebind_cmbDetValorChequeras()
        Dim oRs As DataTable

        If IdOrdenPago < 1 Then
            oRs = TraerFiltrado(SC, enumSPs.BancoChequeras_TX_ActivasPorIdCuentaBancariaParaCombo, cmbDetValorBancoCuenta.SelectedValue)
        Else
            oRs = TraerFiltrado(SC, enumSPs.BancoChequeras_TX_PorIdCuentaBancaria, cmbDetValorBancoCuenta.SelectedValue)
        End If

        IniciaCombo(cmbDetValorChequeras, oRs, "Titulo", "IdBancoChequera", "")

    End Sub




    Protected Sub cmbDetValorChequeras_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetValorChequeras.SelectedIndexChanged
        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)

        If txtDetValorCheque.Text = "" Then
            txtDetValorCheque.Text = OrdenPagoManager.ProximoNumeroCheque(SC, myOrdenPago, cmbDetValorChequeras.SelectedValue)
        End If
    End Sub

    Protected Sub LinkButtonAplicacionAutomatica_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonAplicacionAutomatica.Click
        Dim myOrdenPago As OrdenPago = CType(Me.ViewState(mKey), OrdenPago)

        'OrdenPagoManager.
        ImputacionAutomatica(myOrdenPago)
        SuperReBind(myOrdenPago)
    End Sub

    Private Sub ImputacionAutomatica(ByRef myOP As OrdenPago)

        'If Len(Trim(dcfields(0).BoundText)) = 0 Then
        '    MsgBox("Falta completar el campo Proveedor", vbCritical)
        '    Exit Sub
        'End If

        'If Len(Trim(txtNumeroOrdenPago.Text)) = 0 Then
        '    MsgBox("Falta completar el campo numero de Orden de Pago", vbCritical)
        '    Exit Sub
        'End If

        Dim oRs As adodb.Recordset
        Dim oRs1 As adodb.Recordset
        Dim mvarDif As Double
        Dim oL As ListItem
        Dim Esta As Boolean

        RecalcularTotales(SC, myOP)
        mvarDif = myOP.TotalDiferencia * -1

        oRs = TraerFiltrado(SC, enumSPs.CtasCtesA_TX_ACancelar, myOP.IdProveedor)
        oRs1 = myOP.DetallesImputaciones

        If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
                oRs.MoveFirst()
                Do While Not oRs.EOF And mvarDif > 0
                    Esta = False
                    If oRs1.Fields.Count > 0 Then
                        If oRs1.RecordCount > 0 Then
                            oRs1.MoveFirst()
                            Do While Not oRs1.EOF
                                If oRs.Fields(0).Value = oRs1.Fields("IdImputacion").Value Then
                                    Esta = True
                                    Exit Do
                                End If
                                oRs1.MoveNext()
                            Loop
                        End If
                    End If
                    If Not Esta Then


                        Dim it As New OrdenPagoItem
                        With it
                            .IdImputacion = oRs.Fields(0).Value
                            If mvarDif >= oRs.Fields("Saldo").Value Then
                                mvarDif = mvarDif - oRs.Fields("Saldo").Value
                                .Importe = oRs.Fields("Saldo").Value
                            Else
                                .Importe = mvarDif
                                mvarDif = 0
                            End If
                        End With
                        myOP.DetallesImputaciones.Add(it)


                    End If
                    oRs.MoveNext()
                Loop
            End If
            oRs.Close()
        End If
        oRs = Nothing

        If oRs1.Fields.Count > 0 Then oRs1.Close()
        oRs1 = Nothing

        'If mvarDif > 0 Then
        '    With origen.DetOrdenesPago.Item(-1)
        '        .Registro.Fields("IdImputacion").Value = -1
        '        .Registro.Fields("Importe").Value = mvarDif
        '        mvarDif = 0
        '        .Modificado = True
        '    End With
        'End If

        'Lista.DataSource = origen.DetOrdenesPago.RegistrosConFormato

        'CalcularRetencionGanancias()
        'CalcularRetencionIVA()
        'CalcularRetencionIngresosBrutos()
        'CalcularRetencionSUSS()
        'CalculaTotales()
        MostrarDiferenciaCambio()

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

    'Protected Sub txtDetAC_Cuenta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAsientoAC_Cuenta.TextChanged


    '    Dim idcuenta = BuscaIdCuentaPreciso(txtAsientoAC_Cuenta.Text, HFSC.Value)

    '    Try
    '        Dim oRs = GetStoreProcedureTop1(HFSC.Value, enumSPs.Cuentas_TX_PorIdConDatos, idcuenta, txtFechaIngreso.Text)
    '        txtDetAsientoCodigoCuenta.Text = oRs.Item("Codigo")
    '        BuscaIDEnCombo(cmbDetAsientoObra, iisNull(oRs.Item("IdObra"), -1))
    '        RebindCuentaGasto()
    '    Catch ex As Exception

    '    End Try

    '    '.Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
    '    '.Fields("CodigoCuenta").Value = oRs.Fields("Codigo1").Value
    '    'If Not IsNull(oRs.Fields("IdObra").Value) Then
    '    '    .Fields("IdObra").Value = oRs.Fields("IdObra").Value
    '    'End If
    '    'If Not IsNull(oRs.Fields("IdRubroFinanciero").Value) Then
    '    '    .Fields("IdRubroContable").Value = oRs.Fields("IdRubroFinanciero").Value
    '    'End If

    '    ModalPopupExtenderAsiento.Show()


    '    'ClientIDSetfocus = txtAsientoAC_Cuenta.UniqueID
    '    'txtAsientoAC_Cuenta.Focus()
    'End Sub


    Protected Sub txtAsientoAC_Cuenta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAsientoAC_Cuenta.TextChanged
        Dim idcuenta = BuscaIdCuentaPrecisoConCodigoComoSufijo(txtAsientoAC_Cuenta.Text, HFSC.Value)
        If idcuenta = -1 Then
            txtAsientoAC_Cuenta.Text = ""
            Return
        End If
        Dim oRs = TraerFiltradoVB6(SC, enumSPs.Cuentas_TX_PorIdConDatos, idcuenta, txtFechaIngreso.Text)
        'With origen.Registro
        '    .Fields(DataCombo1(Index).DataField).Value = DataCombo1(Index).BoundText
        '    .Fields("CodigoCuenta").Value = oRs.Fields("Codigo1").Value
        'End With


        txtDetAsientoCodigoCuenta.Text = oRs.Fields("Codigo").Value
        BuscaIDEnCombo(cmbDetAsientoObra, iisNull(oRs.Fields("IdObra").Value, -1))



        If iisNull(oRs.Fields("EsCajaBanco").Value) = "BA" Then


            cmbDetAsientoCuentaBanco.Enabled = True
            With cmbDetAsientoCuentaBanco
                .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Bancos_TX_PorCuentasBancariasIdCuentaIdMoneda, idcuenta, 1)
                .DataTextField = "Titulo"
                .DataValueField = "IdCuentaBancaria"
                .DataBind()


                .Items.Insert(0, New ListItem("", -1))
            End With


        Else
            'origen.Registro.Fields("IdCuentaBancaria").Value = Null
            cmbDetAsientoCuentaBanco.Enabled = False
        End If
        cmbDetAsientoCuentaBanco.Visible = True
        'DataCombo1(7).Visible = False
        cmbDetAsientoCaja.Enabled = False
        If iisNull(oRs.Fields("EsCajaBanco").Value) = "CA" Then
            cmbDetAsientoCaja.Enabled = True
        ElseIf iisNull(oRs.Fields("EsCajaBanco").Value) = "TC" Then
            cmbDetAsientoCuentaBanco.Visible = False
            'DataCombo1(7).Visible = True
        Else
            'origen.Registro.Fields("IdCaja").Value = Null
        End If
        cmbDetAsientoCaja.Enabled = cmbDetAsientoCuentaBanco.Enabled Or cmbDetAsientoCaja.Enabled
        'txtCotizacionMonedaDestino.Enabled = cmbDetAsientoCaja.Enabled


        BuscaIDEnCombo(cmbDetAsientoObra, iisNull(oRs.Fields("IdObra").Value, -1))
        RebindCuentaGasto()

        oRs.Close()
        ModalPopupExtenderAsiento.Show()

    End Sub



    Protected Sub cmbDetCuentaGasto_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetAsientoCuentaGasto.SelectedIndexChanged


        Dim oRs = GetStoreProcedureTop1(SC, enumSPs.Cuentas_TX_PorObraCuentaGasto, cmbDetAsientoObra.SelectedValue, cmbDetAsientoCuentaGasto.SelectedValue, txtFechaIngreso.Text)



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
            txtAsientoAC_Cuenta.Text = oRs("Descripcion")
            txtDetAsientoCodigoCuenta.Text = oRs("Codigo")

            txtDetAsientoCodigoCuenta.Enabled = False
            txtAsientoAC_Cuenta.Enabled = False
            cmbDetAsientoCuentaGrupo.Enabled = False
        End If
        ModalPopupExtenderAsiento.Show()
    End Sub



    Protected Sub cmbDetObra_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetAsientoObra.SelectedIndexChanged
        RebindCuentaGasto()
        ModalPopupExtenderAsiento.Show()
    End Sub

    Sub RebindCuentaGasto()
        With cmbDetAsientoCuentaGasto
            .DataSource = EntidadManager.GetStoreProcedure(SC, enumSPs.Cuentas_TX_CuentasGastoPorObraParaCombo, cmbDetAsientoObra.SelectedValue, Today)
            .DataTextField = "Titulo"
            .DataValueField = "IdCuentaGasto"
            .DataBind()


            .Items.Insert(0, New ListItem("", -1))
        End With

    End Sub





    Protected Sub cmbDetCuentaGrupo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetAsientoCuentaGrupo.SelectedIndexChanged
        'tengo que usar GetStoreProcedure(SC, enumSPs.Cuentas_TX_PorGrupoParaCombo, cmbOtrosGrupo1.SelectedValue)
        'pero como hago acá para filtrar el Autocomplete?????
        txtDetAsientoCodigoCuenta.Text = ""
        txtAsientoAC_Cuenta.Text = ""

        AutoCompleteExtender20.ContextKey = Join(New String() {SC, cmbDetAsientoCuentaGrupo.SelectedValue.ToString}, "|")

        ModalPopupExtenderAsiento.Show()
    End Sub


    Protected Sub txtDetCodigoCuenta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetAsientoCodigoCuenta.TextChanged
        Try
            txtAsientoAC_Cuenta.Text = NombreCuenta(SC, GetStoreProcedureTop1(SC, enumSPs.Cuentas_TXCod, txtDetAsientoCodigoCuenta.Text).Item("IdCuenta"))
        Catch ex As Exception
            txtAsientoAC_Cuenta.Text = ""
        End Try

        ModalPopupExtenderAsiento.Show()
    End Sub

    Protected Sub butLimpiaCuentaGasto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles butLimpiaCuentaGasto.Click
        'IniciaCombo(SC, cmbDetAsientoCuentaGasto, tipos.CuentasGasto)
        RebindCuentaGasto()
        txtDetAsientoCodigoCuenta.Enabled = True
        txtAsientoAC_Cuenta.Enabled = True
        cmbDetAsientoCuentaGrupo.Enabled = True
        ModalPopupExtenderAsiento.Show()
    End Sub


    Protected Sub txtPopupRetorno_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtPopupRetorno.TextChanged
        AgregarItemsACarteraValores()
    End Sub


    Sub AgregarItemsACarteraValores()


        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)

        Dim a = Split(txtPopupRetorno.Text)
        For Each id As Long In a




            'me fijo si ya existe en el detalle
            If myOrdenPago.DetallesValores.Find(Function(obj) obj.IdValor = id) Is Nothing Then

                Dim mItem As OrdenPagoValoresItem = New Pronto.ERP.BO.OrdenPagoValoresItem

                With mItem
                    'vendría a ser el código de ListaVal_OLEDragDrop

                    .Id = myOrdenPago.DetallesValores.Count
                    .Nuevo = True


                    Dim v = GetStoreProcedureTop1(SC, enumSPs.Valores_T, id)

                    .IdTipoValor = v("IdTipoValor") ' cmbDetValorTipo.SelectedValue
                    .Tipo = NombreValorTipo(SC, .IdTipoValor) 'cmbDetValorTipo.SelectedItem.Text





                    .NumeroInterno = v("NumeroInterno") ' Val(txtDetValorNumeroInterno.Text)
                    .NumeroValor = v("NumeroValor") ' Val(txtDetValorCheque.Text)
                    .IdCuentaBancaria = iisNull(v("IdCuentaBancaria"), Nothing)
                    .IdCuentaBancariaTransferencia = iisNull(v("IdCuentaBancaria"), Nothing) 'cmbDetValorBancoCuenta.SelectedValue
                    Dim oRs = TraerFiltradoVB6(SC, enumSPs.CuentasBancarias_TX_PorId, .IdCuentaBancariaTransferencia)
                    'If oRs.RecordCount > 0 Then .IdBanco = oRs.Fields("IdBanco").Value
                    .IdBanco = iisNull(v("IdBanco"), Nothing)
                    .Importe = v("Importe") 'StringToDecimal(txtDetValorImporte.Text)
                    .FechaVencimiento = v("FechaValor") ' iisValidSqlDate(txtDetValorVencimiento.Text)


                    'ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximoNumeroInterno, .NumeroInterno + 1)


                    .ImporteTotalItem = v("Importe") 'StringToDecimal(txtDetValorImporte.Text)


                    '///////////////////////////////////////////////////////////////
                    '///////////////////////////////////////////////////////////////


                    Dim msItem As String
                    If Not IsValidItemValor(SC, mItem, msItem, myOrdenPago) Then
                        MsgBoxAjax(Me, msItem)
                        Exit Sub
                    End If

                End With

                myOrdenPago.DetallesValores.Add(mItem)
            Else
                MsgBoxAjax(Me, "El renglon de imputacion " & id & " ya está en el detalle")
            End If


        Next



        Me.ViewState.Add(mKey, myOrdenPago)
        gvValores.DataSource = myOrdenPago.DetallesValores
        gvValores.DataBind()



        RecalcularRegistroContable()
        RecalcularTotalComprobante()
        UpdatePanelValores.Update()
        UpdatePanelAsiento.Update()


        'MostrarElementos(False)
        mAltaItem = True

    End Sub



End Class





Public Class OrdenPagoManager
    'Inherits ServicedComponent


    Public Shared Function TraerRegistrosPorImpuesto(ByVal OP As OrdenPago, ByVal impuesto As String) As adodb.Recordset

    End Function



    Public Shared Function AgregarDiferenciaCambio(ByVal SC As String, ByRef OP As OrdenPago)

        With OP



            Dim oRs As adodb.Recordset
            Dim mvarDifCam As Double

            RecalcularTotales(SC, OP)


            mvarDifCam = ValorDiferenciaCambio(SC, OP)

            Dim mItemImp As OrdenPagoItem = New OrdenPagoItem
            mItemImp.Id = -1
            mItemImp.Nuevo = True


            mItemImp.ComprobanteImputadoNumeroConDescripcionCompleta = "PA"

            mItemImp.IdTipoRetencionGanancia = ProveedorManager.GetItem(SC, OP.IdProveedor).IdTipoRetencionGanancia
            mItemImp.Importe = mvarDifCam



            If mvarDifCam > 0 Then
                mItemImp.IdImputacion = -1

            Else
                mItemImp.IdImputacion = -2
            End If

            .DetallesImputaciones.Add(mItemImp)





            RecalcularTotales(SC, OP)
            'CalcularRetencionGanancias()
            'CalculaTotales()



        End With

    End Function


    Public Shared Function ValorDiferenciaCambio(ByVal SC As String, ByRef OP As OrdenPago)

        Dim oRs As adodb.Recordset
        Dim oRs1 As adodb.Recordset
        Dim mDifer As Double


        mDifer = 0
        For Each i In OP.DetallesImputaciones
            With i
                If Not .Eliminado Then
                    If Not IsNull(.IdImputacion) And Not IsNull(.Importe) Then
                        oRs1 = TraerFiltradoVB6(SC, enumSPs.DiferenciasCambio_TX_ParaCalculoIndividual, _
                              .IdImputacion, 4, .Importe, OP.IdMoneda)
                        If oRs1.RecordCount > 0 Then
                            mDifer = mDifer + iisNull(oRs1.Fields("Dif_cambio $").Value, 0)
                        End If
                        oRs1.Close()
                        oRs1 = Nothing
                    End If
                End If
            End With
        Next

        oRs = Nothing

        ValorDiferenciaCambio = Math.Round(mDifer, 2)
    End Function

    Public Shared Sub RefrescarTalonario(ByVal SC As String, ByRef myOrdenPago As OrdenPago)
        With myOrdenPago
            'Dim ocli = ClienteManager.GetItem(SC, .IdCliente)

            ''estos debieran ser READ only, no?
            '.IdCodigoIva = ocli.IdCodigoIva
            '.TipoABC = EntidadManager.LetraSegunTipoIVA(.IdCodigoIva)
            '.IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(SC, .PuntoVenta, .TipoABC)
            '.Numero = ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(SC, .IdCodigoIva, .PuntoVenta)
            ''.Numero = ProximoNumeroFactura(SC, myFactura.IdPuntoVenta)


            '.IdPuntoVenta = IdPuntoVentaComprobanteOrdenPagoSegunSubnumero(SC, .PuntoVenta)
            .NumeroOrdenPago = OrdenPagoManager.ProximoNumeroOrdenPagoPorNumeroDePuntoVenta(SC, myOrdenPago)

        End With
    End Sub



    Public Shared Function Save(ByVal SC As String, ByVal myOrdenPago As OrdenPago, Optional ByVal sError As String = "") As Integer
        'Dim myTransactionScope As TransactionScope = New TransactionScope
        'Try




        Dim esNuevo As Boolean
        If myOrdenPago.Id = -1 Then esNuevo = True Else esNuevo = False

        If esNuevo Then
            'RefrescarTalonario(SC, myOrdenPago)
        End If




        Dim rs = _RegistroContableOriginalVB6conADORrecordsets(SC, myOrdenPago) 'este, cuando se llama en pronto?
        RecalcularImpuestos(SC, myOrdenPago)



        Dim OrdenPagoId As Integer = OrdenPagoDB.Save(SC, myOrdenPago)



        'For Each myOrdenPagoItem As OrdenPagoItem In myOrdenPago.Detalles
        '    myOrdenPagoItem.IdOrdenPago = OrdenPagoId
        '    OrdenPagoItemDB.Save(myOrdenPagoItem)
        'Next

        If myOrdenPago.Id = -1 Then
            Try


                'If myOrdenPago.CtaCte = "NO" Then
                '    ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximaOrdenPagoInterna", ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoInterna") + 1)
                'Else
                '    EntidadManager.AsignarNumeroATalonario(SC, myOrdenPago.IdPuntoVenta, myOrdenPago.NumeroOrdenPago + 1)
                'End If

                With myOrdenPago

                    If .Exterior = "SI" Then
                        GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximaOrdenPagoExterior, .NumeroOrdenPago + 1)
                    Else

                        If .Tipo = OrdenPago.tipoOP.CC Then
                            GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximaOrdenPago, .NumeroOrdenPago + 1)
                        ElseIf .Tipo = OrdenPago.tipoOP.FF Then
                            GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximaOrdenPagoFF, .NumeroOrdenPago + 1)
                        ElseIf .Tipo = OrdenPago.tipoOP.OT Then
                            GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximaOrdenPagoOtros, .NumeroOrdenPago + 1)
                        Else
                            GrabarRenglonUnicoDeTablaParametroOriginal(SC, ePmOrg.ProximaOrdenPago, .NumeroOrdenPago + 1)
                            'Err.Raise(3233, , "Falta el tipo de la OP para asignarle el talonario correspondiente")
                        End If


                    End If

                End With


            Catch ex As Exception
                sError = "No se pudo incrementar el talonario. Verificar existencia de PuntosVenta_M. " & ex.ToString
                Exit Function
            End Try
        End If

        Guardar_CodigoOriginalDeVB6(SC, myOrdenPago)

        myOrdenPago.Id = OrdenPagoId




        'myTransactionScope.Complete()
        'ContextUtil.SetComplete()
        Return OrdenPagoId




        'Catch ex As Exception
        '    'ContextUtil.SetAbort()
        '    ErrHandler2.WriteError(ex)
        '    'Debug.Print(ex.ToString)
        '    Return -1
        'Finally
        '    'CType(myTransactionScope, IDisposable).Dispose()
        'End Try
    End Function


    Private Shared Function GuardarNoConfirmados(ByVal SC As String, ByRef oOP As OrdenPago) As ICompMTSManager.MisEstados

        '        Dim oCont 'As ObjectContext
        '        Dim oDet As ICompMTSManager
        '        Dim Resp As ICompMTSManager.MisEstados
        '        Dim lErr As Long, sSource As String, sDesc As String
        '        Dim Datos As adodb.Recordset
        '        Dim i As Integer
        '        Dim oFld As adodb.Field

        '        On Error GoTo Mal

        '        'oCont = GetObjectContext

        '        If oCont Is Nothing Then
        '            oDet = CreateObject("MTSPronto.General") 
        '        Else
        '            oDet = oCont.CreateInstance("MTSPronto.General")
        '        End If

        '        Resp = oDet.GuardarPorRef(SC, "OrdenesPago", OrdenPago)

        '        For Each iDet In OrdenPago.DetallesImputaciones
        '            With iDet


        '                .Fields("IdOrdenPago").Value = OrdenPago.Fields(0).Value
        '                .Update()

        '                If .Fields("Eliminado").Value Then
        '                    oDet.Eliminar(, "DetOrdenesPago", .Fields(0).Value)
        '                Else
        '                    Datos = CreateObject("adodb.Recordset")
        '                    For i = 0 To .Fields.Count - 2
        '                        With .Fields(i)
        '                            Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
        '                            Datos.Fields(.Name).Precision = .Precision
        '                            Datos.Fields(.Name).NumericScale = .NumericScale
        '                        End With
        '                    Next
        '                    Datos.Open()
        '                    Datos.AddNew()
        '                    For i = 0 To .Fields.Count - 2
        '                        With .Fields(i)
        '                            Datos.Fields(i).Value = .Value
        '                        End With
        '                    Next
        '                    Datos.Update()
        '                    Resp = oDet.Guardar(SC, "DetOrdenesPago", Datos)
        '                    Datos.Close()
        '                    Datos = Nothing
        '                End If

        '            End With
        '        Next



        '        For Each iVal In OrdenPago.DetallesValores
        '            With iVal

        '                .Fields("IdOrdenPago").Value = OrdenPago.Fields(0).Value
        '                .Update()

        '                If .Fields("Eliminado").Value Then
        '                    oDet.Eliminar("DetOrdenesPagoValores", .Fields(0).Value)
        '                Else
        '                    Datos = CreateObject("adodb.Recordset")
        '                    For i = 0 To .Fields.Count - 2
        '                        With .Fields(i)
        '                            Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
        '                            Datos.Fields(.Name).Precision = .Precision
        '                            Datos.Fields(.Name).NumericScale = .NumericScale
        '                        End With
        '                    Next
        '                    Datos.Open()
        '                    Datos.AddNew()
        '                    For i = 0 To .Fields.Count - 2
        '                        With .Fields(i)
        '                            Datos.Fields(i).Value = .Value
        '                        End With
        '                    Next
        '                    Datos.Update()
        '                    Resp = oDet.Guardar(SC, "DetOrdenesPagoValores", Datos)
        '                    Datos.Close()
        '                    Datos = Nothing
        '                End If


        '            End With
        '        Next

        '        For Each icta In OrdenPago.
        '            With icta

        '                If .State <> adStateClosed Then

        '                    If Not .EOF Then
        '                        .Update()
        '                        .MoveFirst()
        '                    End If

        '                    Do While Not .EOF

        '                        .Fields("IdOrdenPago").Value = OrdenPago.Fields(0).Value
        '                        .Update()

        '                        If .Fields("Eliminado").Value Then
        '                            oDet.Eliminar("DetOrdenesPagoCuentas", .Fields(0).Value)
        '                        Else
        '                            Datos = CreateObject("adodb.Recordset")
        '                            For i = 0 To .Fields.Count - 2
        '                                With .Fields(i)
        '                                    Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
        '                                    Datos.Fields(.Name).Precision = .Precision
        '                                    Datos.Fields(.Name).NumericScale = .NumericScale
        '                                End With
        '                            Next
        '                            Datos.Open()
        '                            Datos.AddNew()
        '                            For i = 0 To .Fields.Count - 2
        '                                With .Fields(i)
        '                                    Datos.Fields(i).Value = .Value
        '                                End With
        '                            Next
        '                            Datos.Update()
        '                            Resp = oDet.Guardar(SC, "DetOrdenesPagoCuentas", Datos)
        '                            Datos.Close()
        '                            Datos = Nothing
        '                        End If

        '                        .MoveNext()

        '                    Loop

        '                End If

        '            End With

        '            If Not oCont Is Nothing Then
        '                With oCont
        '                    If .IsInTransaction Then .SetComplete()
        '                End With
        '            End If

        'Salir:
        '            GuardarNoConfirmados = Resp
        '            oDet = Nothing
        '            oCont = Nothing
        '            On Error GoTo 0
        '            If lErr Then
        '                Err.Raise(lErr, sSource, sDesc)
        '            End If
        '            Exit Function

        'Mal:
        '            If Not oCont Is Nothing Then
        '                With oCont
        '                    If .IsInTransaction Then .SetAbort()
        '                End With
        '            End If
        '            With Err()
        '                lErr = .Number
        '                sSource = .Source
        '                sDesc = .Description
        '            End With
        '            Resume Salir

    End Function

    Public Shared Function RecalcularRegistroContable(ByVal SC As String, ByRef oOP As OrdenPago) As DataTable

        Dim oSrv As ICompMTSManager
        Dim oRs As adodb.Recordset
        Dim oRsAux As adodb.Recordset
        Dim oRsCont As adodb.Recordset
        Dim oRsDet As adodb.Recordset
        Dim oRsDetCtas As adodb.Recordset
        Dim oRsBco As adodb.Recordset
        Dim oRsProv As adodb.Recordset
        Dim oRsDetBD As adodb.Recordset
        Dim oFld As adodb.Field
        Dim mvarEjercicio As Long, mvarCuentaCaja As Long, mvarCuentaProveedor As Long, mvarCuentaValores As Long
        Dim mvarCuentaRetencionIva As Long, mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
        Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long, mvarCuentaReventas As Long
        Dim mvarCuentaDescuentos As Long, mvarCuentaDescuentosyRetenciones As Long, mvarCuentaValores1 As Long
        Dim mvarCuentaCajaTitulo As Long, mvarCuentaValoresTitulo As Long, mvarCuentaDescuentosyRetencionesTitulo As Long
        Dim mvarPosicion As Long, mvarCuentaRetencionSUSS As Long, mvarIdImpuestoDirectoSUSS As Long
        Dim mvarIdIBCondicionPorDefecto As Long, mvarCuentaRetencionIvaComprobantesM As Long
        Dim mvarRetencionIvaComprobantesM As Double, mvarTotalValores As Double, mvarImporte As Double, mvarDebe As Double
        Dim mvarHaber As Double
        Dim mvarDetalleValor As String, mvarDetalle As String, mvarDebeHaber As String, mvarChequeraPagoDiferido As String
        Dim mvarActivarCircuitoChequesDiferidos As String, mvarDetVal As String
        Dim mvarEsta As Boolean, mvarProcesar As Boolean

        'oSrv = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

        oRs = oSrv.LeerUno(SC, "Parametros", 1)
        mvarEjercicio = IIf(IsNull(oRs.Fields("EjercicioActual").Value), 0, oRs.Fields("EjercicioActual").Value)
        mvarCuentaCaja = IIf(IsNull(oRs.Fields("IdCuentaCaja").Value), 0, oRs.Fields("IdCuentaCaja").Value)
        mvarCuentaCajaTitulo = IIf(IsNull(oRs.Fields("IdCuentaCajaTitulo").Value), 0, oRs.Fields("IdCuentaCajaTitulo").Value)
        mvarCuentaValores = IIf(IsNull(oRs.Fields("IdCuentaValores").Value), 0, oRs.Fields("IdCuentaValores").Value)
        mvarCuentaValoresTitulo = IIf(IsNull(oRs.Fields("IdCuentaValoresTitulo").Value), 0, oRs.Fields("IdCuentaValoresTitulo").Value)
        mvarCuentaRetencionIva = IIf(IsNull(oRs.Fields("IdCuentaRetencionIva").Value), 0, oRs.Fields("IdCuentaRetencionIva").Value)
        mvarCuentaRetencionIvaComprobantesM = IIf(IsNull(oRs.Fields("IdCuentaRetencionIvaComprobantesM").Value), 0, oRs.Fields("IdCuentaRetencionIvaComprobantesM").Value)
        mvarCuentaRetencionGanancias = IIf(IsNull(oRs.Fields("IdCuentaRetencionGanancias").Value), 0, oRs.Fields("IdCuentaRetencionGanancias").Value)
        mvarCuentaRetencionIBrutos = IIf(IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value), 0, oRs.Fields("IdCuentaRetencionIBrutos").Value)
        mvarCuentaDescuentos = IIf(IsNull(oRs.Fields("IdCuentaDescuentos").Value), 0, oRs.Fields("IdCuentaDescuentos").Value)
        mvarCuentaDescuentosyRetenciones = IIf(IsNull(oRs.Fields("IdCuentaDescuentosyRetenciones").Value), 0, oRs.Fields("IdCuentaDescuentosyRetenciones").Value)
        mvarCuentaDescuentosyRetencionesTitulo = IIf(IsNull(oRs.Fields("IdCuentaDescuentosyRetencionesTitulo").Value), 0, oRs.Fields("IdCuentaDescuentosyRetencionesTitulo").Value)
        mvarCuentaRetencionSUSS = IIf(IsNull(oRs.Fields("IdCuentaRetencionSUSS").Value), 0, oRs.Fields("IdCuentaRetencionSUSS").Value)
        mvarActivarCircuitoChequesDiferidos = IIf(IsNull(oRs.Fields("ActivarCircuitoChequesDiferidos").Value), "NO", oRs.Fields("ActivarCircuitoChequesDiferidos").Value)
        oRs.Close()

        If Not IsNull(oOP.IdProveedor) Then
            oRs = oSrv.LeerUno(SC, "Proveedores", oOP.IdProveedor)
            mvarCuentaProveedor = IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value)
            mvarIdImpuestoDirectoSUSS = IIf(IsNull(oRs.Fields("IdImpuestoDirectoSUSS").Value), 0, oRs.Fields("IdImpuestoDirectoSUSS").Value)
            mvarIdIBCondicionPorDefecto = IIf(IsNull(oRs.Fields("IdIBCondicionPorDefecto").Value), 0, oRs.Fields("IdIBCondicionPorDefecto").Value)
            oRs.Close()
            If mvarIdImpuestoDirectoSUSS <> 0 Then
                oRs = oSrv.LeerUno(SC, "ImpuestosDirectos", mvarIdImpuestoDirectoSUSS)
                If oRs.RecordCount > 0 Then
                    If Not IsNull(oRs.Fields("IdCuenta").Value) Then
                        mvarCuentaRetencionSUSS = oRs.Fields("IdCuenta").Value
                    End If
                End If
                oRs.Close()
            End If
            If mvarIdIBCondicionPorDefecto <> 0 Then
                oRs = oSrv.TraerFiltrado(SC, "IBCondiciones", "_IdCuentaPorProvincia", mvarIdIBCondicionPorDefecto)
                If oRs.RecordCount > 0 Then
                    If Not IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value) Then
                        mvarCuentaRetencionIBrutos = oRs.Fields("IdCuentaRetencionIBrutos").Value
                    End If
                End If
                oRs.Close()
            End If
        Else
            mvarCuentaProveedor = IIf(IsNull(oOP.IdCuenta), 0, oOP.IdCuenta)
        End If

        oRsCont = CreateObject("adodb.Recordset")
        oRs = oSrv.TraerFiltrado(SC, "Subdiarios", "_Estructura")

        With oRs
            For Each oFld In .Fields
                With oFld
                    oRsCont.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    oRsCont.Fields.Item(.Name).Precision = .Precision
                    oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
                End With
            Next
            oRsCont.Open()
        End With
        oRs.Close()

        If Not IsNull(oOP.AsientoManual) And oOP.AsientoManual = "SI" Then

            For Each oRsDetCtas In oOP.DetallesCuentas
                With oRsCont
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                    .Fields("IdCuenta").Value = oRsDetCtas.Fields("IdCuenta").Value
                    .Fields("IdTipoComprobante").Value = 17
                    .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                    .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                    .Fields("IdComprobante").Value = oOP.Id
                    If Not IsNull(oRsDetCtas.Fields("Debe").Value) Then
                        .Fields("Debe").Value = oRsDetCtas.Fields("Debe").Value
                    End If
                    If Not IsNull(oRsDetCtas.Fields("Haber").Value) Then
                        .Fields("Haber").Value = oRsDetCtas.Fields("Haber").Value
                    End If
                    .Fields("IdMoneda").Value = oOP.IdMoneda
                    .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda

                    mvarDetalleValor = ""
                    For Each oRsDet In oOP.DetallesValores
                        With oRsDet
                            If Not .Fields("Eliminado").Value Then
                                mvarCuentaValores1 = mvarCuentaValores
                                mvarProcesar = True

                                oRsBco = oSrv.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
                                mvarDetVal = ""
                                If oRsBco.RecordCount > 0 Then
                                    mvarDetVal = IIf(IsNull(oRsBco.Fields("DescripcionAb").Value), "", oRsBco.Fields("DescripcionAb").Value)
                                End If
                                oRsBco.Close()

                                If IsNull(.Fields("IdValor").Value) Then
                                    If Not IsNull(.Fields("IdBanco").Value) Then
                                        If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
                                            mvarProcesar = False
                                        End If
                                        If mvarProcesar Then
                                            mvarChequeraPagoDiferido = "NO"
                                            If Not IsNull(.Fields("IdBancoChequera").Value) Then
                                                oRsBco = oSrv.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
                                                If oRsBco.RecordCount > 0 Then
                                                    If Not IsNull(oRsBco.Fields("ChequeraPagoDiferido").Value) Then
                                                        mvarChequeraPagoDiferido = oRsBco.Fields("ChequeraPagoDiferido").Value
                                                    End If
                                                End If
                                                oRsBco.Close()
                                            End If
                                            oRsBco = oSrv.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
                                            If oRsBco.RecordCount > 0 Then
                                                If mvarActivarCircuitoChequesDiferidos = "NO" Or _
                                                      mvarChequeraPagoDiferido = "NO" Or _
                                                      IsNull(oRsBco.Fields("IdCuentaParaChequesDiferidos").Value) Then
                                                    If Not IsNull(oRsBco.Fields("IdCuenta").Value) Then
                                                        mvarCuentaValores1 = oRsBco.Fields("IdCuenta").Value
                                                    End If
                                                Else
                                                    mvarCuentaValores1 = oRsBco.Fields("IdCuentaParaChequesDiferidos").Value
                                                End If
                                            End If
                                            oRsBco.Close()
                                        End If
                                    End If
                                End If
                                If mvarProcesar Then
                                    If Not IsNull(.Fields("NumeroValor").Value) And oRsDetCtas.Fields("IdCuenta").Value = mvarCuentaValores1 Then
                                        mvarDetalleValor = mvarDetalleValor & mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value & " "
                                    End If
                                End If
                            End If
                        End With

                    Next


                    oRsDet = Nothing

                    .Fields("Detalle").Value = Mid(mvarDetalleValor, 1, .Fields("Detalle").DefinedSize)
                    .Update()
                End With
                oRsDetCtas.MoveNext()
            Next
            oRsDetCtas = Nothing

        Else

            If Not IsNull(oOP.Efectivo) Then
                If oOP.Efectivo <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.Efectivo
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaCaja
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        .Fields("Haber").Value = mvarImporte
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        mvarDebeHaber = "Debe"
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields(mvarDebeHaber).Value = mvarImporte
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarImporte
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.GastosGenerales) And Not IsNull(oOP.IdCuenta) Then
                If oOP.GastosGenerales <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.GastosGenerales
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = oOP.IdCuenta
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        .Fields("Haber").Value = mvarImporte
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        mvarDebeHaber = "Debe"
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaCaja
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields(mvarDebeHaber).Value = mvarImporte
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarImporte
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.Descuentos) Then
                If oOP.Descuentos <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.Descuentos
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaDescuentos
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            mvarRetencionIvaComprobantesM = IIf(IsNull(oOP.RetencionIVAComprobantesM), 0, oOP.RetencionIVAComprobantesM)

            If Not IsNull(oOP.RetencionIVA) Then
                If oOP.RetencionIVA - mvarRetencionIvaComprobantesM <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.RetencionIVA - mvarRetencionIvaComprobantesM
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaRetencionIva
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            If mvarImporte > 0 Then
                                .Fields("Debe").Value = mvarImporte
                            Else
                                .Fields("Haber").Value = Math.Abs(mvarImporte)
                            End If
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If mvarRetencionIvaComprobantesM <> 0 Then
                With oRsCont
                    mvarImporte = mvarRetencionIvaComprobantesM
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                    .Fields("IdCuenta").Value = mvarCuentaRetencionIvaComprobantesM
                    .Fields("IdTipoComprobante").Value = 17
                    .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                    .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                    .Fields("IdComprobante").Value = oOP.Id
                    If mvarImporte > 0 Then
                        .Fields("Haber").Value = mvarImporte
                    Else
                        .Fields("Debe").Value = Math.Abs(mvarImporte)
                    End If
                    .Fields("IdMoneda").Value = oOP.IdMoneda
                    .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                    .Update()
                    If mvarImporte > 0 Then
                        mvarDebeHaber = "Debe"
                    Else
                        mvarDebeHaber = "Haber"
                    End If
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaProveedor
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Debe").Value = mvarImporte
                        Else
                            .Fields("Haber").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                    End If
                    .Update()
                End With
            End If

            If Not IsNull(oOP.RetencionGanancias) Then
                If oOP.RetencionGanancias <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.RetencionGanancias
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaRetencionGanancias
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        If Not IsNull(oOP.IdProveedor) Then
                            mvarDetalle = ""
                            If Not IsNull(oOP.NumeroCertificadoRetencionGanancias) Then
                                mvarDetalle = mvarDetalle & "Cert.: " & oOP.NumeroCertificadoRetencionGanancias
                            End If
                            oRsProv = oSrv.LeerUno(SC, "Proveedores", oOP.IdProveedor)
                            If oRsProv.RecordCount > 0 Then
                                If Not IsNull(oRsProv.Fields("RazonSocial").Value) Then
                                    mvarDetalle = mvarDetalle & " Prov.: " & Trim(oRsProv.Fields("RazonSocial").Value)
                                End If
                                If Not IsNull(oRsProv.Fields("Cuit").Value) Then
                                    mvarDetalle = mvarDetalle & " Cuit: " & Trim(oRsProv.Fields("Cuit").Value)
                                End If
                            End If
                            .Fields("Detalle").Value = mvarDetalle
                            oRsProv.Close()
                            oRsProv = Nothing
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.RetencionIBrutos) Then
                If oOP.RetencionIBrutos <> 0 Then

                    With oRsCont
                        If oOP.DetallesImpuestos.Count > 0 Then
                            For Each iImp In oOP.DetallesImpuestos
                                If iImp.TipoImpuesto <> "I.Brutos" Then Continue For

                                mvarImporte = oRsAux.Fields("ImpuestoRetenido").Value
                                .AddNew()
                                .Fields("Ejercicio").Value = mvarEjercicio
                                .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo

                                'codigo extradido de TraerRegistrosPorImpuesto
                                Dim mvarCuenta = mvarCuentaRetencionIBrutos
                                oRs = oSrv.TraerFiltrado(SC, "IBCondiciones", "_IdCuentaPorProvincia", .Fields("IdIBCondicion").Value)
                                If oRs.RecordCount > 0 Then
                                    If Not IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value) Then
                                        mvarCuenta = oRs.Fields("IdCuentaRetencionIBrutos").Value
                                    End If
                                End If
                                .Fields("IdCuenta").Value = mvarCuenta






                                .Fields("IdTipoComprobante").Value = 17
                                .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                                .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                .Fields("IdComprobante").Value = oOP.Id
                                If mvarImporte > 0 Then
                                    .Fields("Haber").Value = mvarImporte
                                Else
                                    .Fields("Debe").Value = Math.Abs(mvarImporte)
                                End If
                                .Fields("IdMoneda").Value = oOP.IdMoneda
                                .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                
                            Next

                        Else
                            mvarImporte = oOP.RetencionIBrutos
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaRetencionIBrutos
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            If mvarImporte > 0 Then
                                .Fields("Haber").Value = mvarImporte
                            Else
                                .Fields("Debe").Value = Math.Abs(mvarImporte)
                            End If
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Update()
                        End If
                                oRsAux.Close()
                                mvarImporte = oOP.RetencionIBrutos
                                If mvarImporte > 0 Then
                                    mvarDebeHaber = "Debe"
                                Else
                                    mvarDebeHaber = "Haber"
                                End If
                                mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                                If mvarPosicion = 0 Then
                                    .AddNew()
                                    .Fields("Ejercicio").Value = mvarEjercicio
                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                                    .Fields("IdCuenta").Value = mvarCuentaProveedor
                                    .Fields("IdTipoComprobante").Value = 17
                                    .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                                    .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                    .Fields("IdComprobante").Value = oOP.Id
                                    .Fields("IdMoneda").Value = oOP.IdMoneda
                                    .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                    .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                                Else
                                    .AbsolutePosition = mvarPosicion
                                    .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                                End If
                                .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.Otros1) Then
                If oOP.Otros1 <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.Otros1
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = oOP.IdCuenta1
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.Otros2) Then
                If oOP.Otros2 <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.Otros2
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = oOP.IdCuenta2
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.Otros3) Then
                If oOP.Otros3 <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.Otros3
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = oOP.IdCuenta3
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(oOP.RetencionSUSS) Then
                If oOP.RetencionSUSS <> 0 Then
                    With oRsCont
                        mvarImporte = oOP.RetencionSUSS
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaRetencionSUSS
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                            .Fields("IdComprobante").Value = oOP.Id
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            mvarTotalValores = 0

            For Each oRsDet In oOP.DetallesValores
                With oRsDet
                    If Not .Fields("Eliminado").Value Then
                        mvarCuentaValores1 = mvarCuentaValores
                        mvarProcesar = True

                        oRsBco = oSrv.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
                        mvarDetVal = ""
                        If oRsBco.RecordCount > 0 Then
                            mvarDetVal = IIf(IsNull(oRsBco.Fields("DescripcionAb").Value), "", oRsBco.Fields("DescripcionAb").Value)
                        End If
                        oRsBco.Close()

                        If IsNull(.Fields("IdValor").Value) Then
                            If Not IsNull(.Fields("IdBanco").Value) Then
                                '                           Set oRsBco = oSrv.TraerFiltrado(sc,"Valores", "_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
                                '                           If oRsBco.RecordCount > 0 Then
                                '                              If IIf(IsNull(oRsBco.Fields("Anulado").Value), "NO", oRsBco.Fields("Anulado").Value) = "SI" Then
                                '                                 mvarProcesar = False
                                '                              End If
                                '                           End If
                                '                           oRsBco.Close
                                If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
                                    mvarProcesar = False
                                End If
                                If mvarProcesar Then
                                    mvarChequeraPagoDiferido = "NO"
                                    If Not IsNull(.Fields("IdBancoChequera").Value) Then
                                        oRsBco = oSrv.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
                                        If oRsBco.RecordCount > 0 Then
                                            If Not IsNull(oRsBco.Fields("ChequeraPagoDiferido").Value) Then
                                                mvarChequeraPagoDiferido = oRsBco.Fields("ChequeraPagoDiferido").Value
                                            End If
                                        End If
                                        oRsBco.Close()
                                    End If
                                    oRsBco = oSrv.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
                                    If oRsBco.RecordCount > 0 Then
                                        If mvarActivarCircuitoChequesDiferidos = "NO" Or mvarChequeraPagoDiferido = "NO" Or _
                                              IsNull(oRsBco.Fields("IdCuentaParaChequesDiferidos").Value) Then
                                            If Not IsNull(oRsBco.Fields("IdCuenta").Value) Then
                                                mvarCuentaValores1 = oRsBco.Fields("IdCuenta").Value
                                            End If
                                        Else
                                            mvarCuentaValores1 = oRsBco.Fields("IdCuentaParaChequesDiferidos").Value
                                        End If
                                    End If
                                    oRsBco.Close()
                                End If
                            ElseIf Not IsNull(.Fields("IdTarjetaCredito").Value) Then
                                oRsBco = oSrv.LeerUno(SC, "TarjetasCredito", .Fields("IdTarjetaCredito").Value)
                                If oRsBco.RecordCount > 0 Then
                                    If Not IsNull(oRsBco.Fields("IdCuenta").Value) Then
                                        mvarCuentaValores1 = oRsBco.Fields("IdCuenta").Value
                                    End If
                                End If
                                oRsBco.Close()
                            Else
                                oRsBco = oSrv.LeerUno(SC, "Cajas", .Fields("IdCaja").Value)
                                If oRsBco.RecordCount > 0 Then
                                    If Not IsNull(oRsBco.Fields("IdCuenta").Value) Then
                                        mvarCuentaValores1 = oRsBco.Fields("IdCuenta").Value
                                    End If
                                End If
                                oRsBco.Close()
                            End If
                        End If
                        If mvarProcesar Then
                            mvarTotalValores = mvarTotalValores + .Fields("Importe").Value
                            mvarDetalleValor = ""
                            If Not IsNull(.Fields("NumeroValor").Value) Then
                                mvarDetalleValor = mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value
                            End If
                            With oRsCont
                                .AddNew()
                                .Fields("Ejercicio").Value = mvarEjercicio
                                .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                                .Fields("IdCuenta").Value = mvarCuentaValores1
                                .Fields("IdTipoComprobante").Value = 17
                                .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                                .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                .Fields("Detalle").Value = mvarDetalleValor
                                .Fields("IdComprobante").Value = oOP.Id
                                .Fields("Haber").Value = oRsDet.Fields("Importe").Value
                                .Fields("IdMoneda").Value = oOP.IdMoneda
                                .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                .Update()
                            End With
                        End If
                    End If
                End With
            Next

            oRsDetBD = oSrv.TraerFiltrado(SC, "DetOrdenesPagoValores", "_PorIdCabecera", oOP.Id)
            With oRsDetBD
                If .RecordCount > 0 Then
                    .MoveFirst()
                    Do While Not .EOF
                        mvarEsta = False
                        If oRsDet.Fields.Count > 0 Then
                            If oRsDet.RecordCount > 0 Then
                                oRsDet.MoveFirst()
                                Do While Not oRsDet.EOF
                                    If .Fields(0).Value = oRsDet.Fields(0).Value Then
                                        mvarEsta = True
                                        Exit Do
                                    End If
                                    oRsDet.MoveNext()
                                Loop
                            End If
                        End If
                        If Not mvarEsta Then
                            mvarCuentaValores1 = mvarCuentaValores
                            mvarProcesar = True

                            oRsBco = oSrv.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
                            mvarDetVal = ""
                            If oRsBco.RecordCount > 0 Then
                                mvarDetVal = IIf(IsNull(oRsBco.Fields("DescripcionAb").Value), "", oRsBco.Fields("DescripcionAb").Value)
                            End If
                            oRsBco.Close()

                            If Not IsNull(.Fields("IdBanco").Value) Then
                                '                     Set oRsBco = oSrv.TraerFiltrado(sc,"Valores", "_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
                                '                     If oRsBco.RecordCount > 0 Then
                                '                        If IIf(IsNull(oRsBco.Fields("Anulado").Value), "NO", oRsBco.Fields("Anulado").Value) = "SI" Then
                                '                           mvarProcesar = False
                                '                        End If
                                '                     End If
                                '                     oRsBco.Close
                                If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
                                    mvarProcesar = False
                                End If
                                If mvarProcesar Then
                                    mvarChequeraPagoDiferido = "NO"
                                    If Not IsNull(.Fields("IdBancoChequera").Value) Then
                                        oRsBco = oSrv.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
                                        If oRsBco.RecordCount > 0 Then
                                            If Not IsNull(oRsBco.Fields("ChequeraPagoDiferido").Value) Then
                                                mvarChequeraPagoDiferido = oRsBco.Fields("ChequeraPagoDiferido").Value
                                            End If
                                        End If
                                        oRsBco.Close()
                                    End If
                                    oRsBco = oSrv.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
                                    If oRsBco.RecordCount > 0 Then
                                        If mvarActivarCircuitoChequesDiferidos = "NO" Or mvarChequeraPagoDiferido = "NO" Or _
                                              IsNull(oRsBco.Fields("IdCuentaParaChequesDiferidos").Value) Then
                                            If Not IsNull(oRsBco.Fields("IdCuenta").Value) Then
                                                mvarCuentaValores1 = oRsBco.Fields("IdCuenta").Value
                                            End If
                                        Else
                                            mvarCuentaValores1 = oRsBco.Fields("IdCuentaParaChequesDiferidos").Value
                                        End If
                                    End If
                                    oRsBco.Close()
                                End If
                            Else
                                oRsBco = oSrv.LeerUno(SC, "Cajas", .Fields("IdCaja").Value)
                                If oRsBco.RecordCount > 0 Then
                                    If Not IsNull(oRsBco.Fields("IdCuenta").Value) Then
                                        mvarCuentaValores1 = oRsBco.Fields("IdCuenta").Value
                                    End If
                                End If
                                oRsBco.Close()
                            End If
                            If mvarProcesar Then
                                mvarTotalValores = mvarTotalValores + .Fields("Importe").Value
                                mvarDetalleValor = ""
                                If Not IsNull(.Fields("NumeroValor").Value) Then
                                    mvarDetalleValor = mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value
                                End If
                                With oRsCont
                                    .AddNew()
                                    .Fields("Ejercicio").Value = mvarEjercicio
                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                                    .Fields("IdCuenta").Value = mvarCuentaValores1
                                    .Fields("IdTipoComprobante").Value = 17
                                    .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                                    .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                    .Fields("Detalle").Value = mvarDetalleValor
                                    .Fields("IdComprobante").Value = oOP.Id
                                    .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value
                                    .Fields("IdMoneda").Value = oOP.IdMoneda
                                    .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                    .Update()
                                End With
                            End If
                        End If
                        .MoveNext()
                    Loop
                End If
                .Close()
            End With
            oRsDetBD = Nothing

            If oRsDet.Fields.Count > 0 Then oRsDet.Close()
            oRsDet = Nothing

            If mvarTotalValores <> 0 Then
                With oRsCont
                    mvarDebeHaber = "Debe"
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaProveedor
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = oOP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                        .Fields("IdComprobante").Value = oOP.Id
                        .Fields(mvarDebeHaber).Value = mvarTotalValores
                        .Fields("IdMoneda").Value = oOP.IdMoneda
                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarTotalValores
                    End If
                    .Update()
                End With
            End If

        End If

        With oRsCont
            If .RecordCount > 0 Then
                .MoveFirst()
                Do While Not .EOF
                    mvarDebe = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value)
                    mvarHaber = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value)
                    If mvarDebe < 0 Then
                        mvarHaber = mvarHaber + Math.Abs(mvarDebe)
                        mvarDebe = 0
                        .Fields("Haber").Value = mvarHaber
                        .Fields("Debe").Value = DBNull.Value
                        .Update()
                    End If
                    If mvarHaber < 0 Then
                        mvarDebe = mvarDebe + Math.Abs(mvarHaber)
                        mvarHaber = 0
                        .Fields("Debe").Value = mvarDebe
                        .Fields("Haber").Value = DBNull.Value
                        .Update()
                    End If
                    .MoveNext()
                Loop
                .MoveFirst()
            End If
        End With

        RecalcularRegistroContable = oRsCont

        oRs = Nothing
        oRsAux = Nothing
        oRsCont = Nothing
        oRsBco = Nothing
        oSrv = Nothing


    End Function

    Private Shared Function Guardar_CodigoOriginalDeVB6(ByVal SC As String, ByRef oOP As OrdenPago)
        '            'todo esto estaba en el mts

        'Public Function Guardar(ByRef OrdenPago As adodb.Recordset, _
        '                        ByVal Detalles As adodb.Recordset, _
        '                        ByVal DetallesValores As adodb.Recordset, _
        '                        ByVal DetallesCuentas As adodb.Recordset, _
        '                        ByVal RegistroContable As adodb.Recordset, _
        '                        ByVal AnticiposAlPersonal As adodb.Recordset, _
        '                        ByVal DetallesImpuestos As adodb.Recordset, _
        '                        ByVal DetallesRubrosContables As adodb.Recordset) As InterFazMTS.MisEstados

        If Not IsDBNull(oOP.Confirmado) And _
              oOP.Confirmado = "NO" Then
            Guardar_CodigoOriginalDeVB6 = GuardarNoConfirmados(SC, oOP)
            Exit Function
        End If

        Dim RegistroContable As adodb.Recordset = DataTable_To_Recordset(OrdenPagoManager.RecalcularRegistroContable(SC, oOP))

        Dim oCont 'As ObjectContext
        Dim oDet As ICompMTSManager
        Dim Resp As ICompMTSManager.MisEstados
        Dim lErr As Long, sSource As String, sDesc As String
        Dim Datos As adodb.Recordset
        Dim DatosCtaCte As adodb.Recordset
        Dim DatosCtaCteNv As adodb.Recordset
        Dim DatosProveedor As adodb.Recordset
        Dim oRsValores As adodb.Recordset
        Dim oRsValoresNv As adodb.Recordset
        Dim oRsComp As adodb.Recordset
        Dim DatosAsiento As adodb.Recordset
        Dim DatosAsientoNv As adodb.Recordset
        Dim oRsParametros As adodb.Recordset
        Dim DatosDetAsiento As adodb.Recordset
        Dim DatosDetAsientoNv As adodb.Recordset
        Dim DatosAnt As adodb.Recordset
        Dim oRsAux As adodb.Recordset
        Dim oFld As adodb.Field
        Dim i As Integer, mvarIdBanco As Integer
        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdentificador As Long
        Dim mvarIdCuenta As Long, mIdDetalleOrdenPago As Long, mvarIdProveedorAnterior As Long
        Dim mvarIdDetalleOrdenPagoCuentas As Long, mIdDetalleOrdenPagoValores As Long
        Dim mIdValor As Long, mNumeroOrdenPago As Long
        Dim Tot As Double, Sdo As Double, TotDol As Double, SdoDol As Double
        Dim TotEu As Double, SdoEu As Double, mvarCotizacionEuro As Double
        Dim mAcreedores As Double, mvarCotizacion As Double, mvarCotizacionMoneda As Double
        Dim mvarCotizacionMonedaAnt As Double, mvarDebe As Double, mvarHaber As Double
        Dim mvarAnulada As Boolean, mvarBorrarEnValores As Boolean
        Dim mvarEsCajaBanco As String, mvarFormaAnulacionCheques As String



        With oOP


            'On Error GoTo Mal

            'oCont = GetObjectContext

            'oDet = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

            mvarIdentificador = oOP.Id

            mvarAnulada = False
            If oOP.Anulada = "OK" Then
                mvarAnulada = True
                oOP.Anulada = "SI"
            End If
            mvarCotizacion = IIf(IsDBNull(oOP.CotizacionDolar), 1, oOP.CotizacionDolar)
            mvarCotizacionEuro = IIf(IsDBNull(oOP.CotizacionEuro), 1, oOP.CotizacionEuro)
            mvarCotizacionMoneda = IIf(IsDBNull(oOP.CotizacionMoneda), 1, oOP.CotizacionMoneda)
            mvarFormaAnulacionCheques = IIf(IsDBNull(oOP.FormaAnulacionCheques), "", oOP.FormaAnulacionCheques)

            mAcreedores = 0
            mvarIdProveedorAnterior = 0
            If mvarIdentificador > 0 Then
                DatosAnt = oDet.LeerUno("OrdenesPago", mvarIdentificador)
                If DatosAnt.RecordCount > 0 Then
                    mvarCotizacionMonedaAnt = IIf(IsDBNull(DatosAnt.Fields("CotizacionMoneda").Value), 1, DatosAnt.Fields("CotizacionMoneda").Value)
                    mAcreedores = DatosAnt.Fields("Acreedores").Value
                    If Not IsDBNull(DatosAnt.Fields("IdProveedor").Value) Then
                        mvarIdProveedorAnterior = DatosAnt.Fields("IdProveedor").Value
                    End If
                End If
                DatosAnt.Close()
                DatosAnt = Nothing
            End If

            Resp = oDet.GuardarPorRef(SC, "OrdenesPago", oOP)

            mNumeroOrdenPago = oOP.NumeroOrdenPago
            DatosAnt = oDet.LeerUno("OrdenesPago", oOP.Id)
            If DatosAnt.RecordCount > 0 Then
                mNumeroOrdenPago = DatosAnt.Fields("NumeroOrdenPago").Value
            End If
            DatosAnt.Close()

            If Not IsDBNull(oOP.IdOPComplementariaFF) Then
                oDet.Tarea(SC, "OrdenesPago_ActualizarIdOrdenPagoComplementaria", ArrayVB6(oOP.IdOPComplementariaFF, oOP.Id))
                oDet.Tarea(SC, "OrdenesPago_ActualizarDiferenciaBalanceo", ArrayVB6(0, oOP.Id))
            End If

            If mvarIdProveedorAnterior <> 0 Then
                DatosProveedor = oDet.LeerUno("Proveedores", mvarIdProveedorAnterior)
                If IsDBNull(DatosProveedor.Fields("Saldo").Value) Then
                    DatosProveedor.Fields("Saldo").Value = 0
                End If
                DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value - (mAcreedores * mvarCotizacionMonedaAnt)
                Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
                DatosProveedor.Close()
                DatosProveedor = Nothing
            End If
            If Not IsDBNull(oOP.IdProveedor) And Not mvarAnulada Then
                DatosProveedor = oDet.LeerUno("Proveedores", oOP.IdProveedor)
                If IsDBNull(DatosProveedor.Fields("Saldo").Value) Then
                    DatosProveedor.Fields("Saldo").Value = 0
                End If
                DatosProveedor.Fields("Saldo").Value = DatosProveedor.Fields("Saldo").Value + (oOP.Acreedores * mvarCotizacionMoneda)
                Resp = oDet.Guardar(SC, "Proveedores", DatosProveedor)
                DatosProveedor.Close()
                DatosProveedor = Nothing
            End If

            If mvarIdentificador > 0 And mvarAnulada Then
                DatosAnt = oDet.TraerFiltrado(SC, "DetOrdenesPago", "_PorIdOrdenPago", mvarIdentificador)
                If DatosAnt.RecordCount > 0 Then
                    DatosAnt.MoveFirst()
                    Do While Not DatosAnt.EOF
                        DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_PorDetalleOrdenPago", DatosAnt.Fields(0).Value)
                        If DatosCtaCteNv.RecordCount > 0 Then
                            Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
                            TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
                            TotEu = IIf(IsDBNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                                     IIf(IsDBNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

                            If Not IsDBNull(DatosAnt.Fields("IdImputacion").Value) Then
                                If DatosAnt.Fields("IdImputacion").Value > 0 Then
                                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", DatosAnt.Fields("IdImputacion").Value)
                                    If DatosCtaCte.RecordCount > 0 Then
                                        '                        If DatosCtaCte.Fields("IdTipoComp").Value <> 17 Then
                                        DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
                                        DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
                                        DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsDBNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
                                        Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)

                                        If IIf(IsDBNull(DatosAnt.Fields("ImporteRetencionIVA").Value), 0, DatosAnt.Fields("ImporteRetencionIVA").Value) <> 0 Then
                                            oDet.Tarea(SC, "ComprobantesProveedores_ImputarOPRetencionIVAAplicada", _
                                                  ArrayVB6(DatosCtaCte.Fields("IdComprobante").Value, 0))
                                        End If
                                        '                        End If
                                    End If
                                    DatosCtaCte.Close()
                                    DatosCtaCte = Nothing
                                End If
                            End If

                            oDet.Eliminar(SC, "CtasCtesA", DatosCtaCteNv.Fields(0).Value)
                        End If
                        DatosCtaCteNv.Close()
                        DatosCtaCteNv = Nothing

                        DatosAnt.MoveNext()
                    Loop
                End If
                DatosAnt.Close()
                DatosAnt = Nothing
            End If



            For Each item In oOP.DetallesImputaciones
                With item

                    'Safar de choclazos con muchos bloques anidados:
                    'Folding is used to mask excessive length. The presence of folded code can lull developers into 
                    'a false sense of what clean code looks like. Under the cover of folding, you can end up writing long, 
                    'horrible spaghetti code blocks. If the code needs the crutch of folding to look organized, it's bad code.
                    '-Finally someone who hates this useless #region crap. I have the same opinion - it drives me crazy when 
                    'im looking at someone's code and can't see a thing. Linus Torvalds once wrote: if you need more than 3 levels 
                    'of indentation, you're screwed anyway. If you need to use #refion - see above :-)

                    .Id = oOP.Id


                    If mvarIdentificador > 0 And Not mvarAnulada Then
                        DatosAnt = oDet.TraerFiltrado(SC, "DetOrdenesPago", "_PorIdDetalleOrdenPago", .Id)
                        If DatosAnt.RecordCount > 0 Then
                            DatosAnt.MoveFirst()
                            Do While Not DatosAnt.EOF

                                DatosCtaCteNv = oDet.TraerFiltrado(SC, "CtasCtesA", "_PorDetalleOrdenPago", .Id)
                                If DatosCtaCteNv.RecordCount > 0 Then

                                    Tot = DatosCtaCteNv.Fields("ImporteTotal").Value - DatosCtaCteNv.Fields("Saldo").Value
                                    TotDol = DatosCtaCteNv.Fields("ImporteTotalDolar").Value - DatosCtaCteNv.Fields("SaldoDolar").Value
                                    TotEu = IIf(IsDBNull(DatosCtaCteNv.Fields("ImporteTotalEuro").Value), 0, DatosCtaCteNv.Fields("ImporteTotalEuro").Value) - _
                                             IIf(IsDBNull(DatosCtaCteNv.Fields("SaldoEuro").Value), 0, DatosCtaCteNv.Fields("SaldoEuro").Value)

                                    If Not IsDBNull(DatosAnt.Fields("IdImputacion").Value) Then
                                        If DatosAnt.Fields("IdImputacion").Value > 0 Then
                                            DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", DatosAnt.Fields("IdImputacion").Value)
                                            If DatosCtaCte.RecordCount > 0 Then
                                                '                                 If DatosCtaCte.Fields("IdTipoComp").Value <> 17 Then
                                                DatosCtaCte.Fields("Saldo").Value = DatosCtaCte.Fields("Saldo").Value + Tot
                                                DatosCtaCte.Fields("SaldoDolar").Value = DatosCtaCte.Fields("SaldoDolar").Value + TotDol
                                                DatosCtaCte.Fields("SaldoEuro").Value = IIf(IsDBNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value) + TotEu
                                                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)
                                                '                                 End If
                                            End If
                                            DatosCtaCte.Close()
                                            DatosCtaCte = Nothing
                                        End If
                                    End If

                                    oDet.Eliminar(SC, "CtasCtesA", DatosCtaCteNv.Fields(0).Value)

                                End If
                                DatosCtaCteNv.Close()
                                DatosCtaCteNv = Nothing

                                DatosAnt.MoveNext()
                            Loop
                        End If
                        DatosAnt.Close()
                        DatosAnt = Nothing

                    ElseIf mvarIdentificador > 0 And mvarAnulada Then
                        oDet.Tarea(SC, "DiferenciasCambio_Eliminar", ArrayVB6(17, .Id))
                    End If





                    If .Eliminado Then

                        If .Id > 0 Then
                            'Si borro la imputacion y tenia retencion iva, borra la marca en comprobante de proveedores
                            DatosAnt = oDet.TraerFiltrado(SC, "DetOrdenesPago", "_PorIdDetalleOrdenPago", .Id)
                            If DatosAnt.RecordCount > 0 Then
                                If IIf(IsDBNull(DatosAnt.Fields("ImporteRetencionIVA").Value), 0, DatosAnt.Fields("ImporteRetencionIVA").Value) <> 0 And _
                                      IIf(IsDBNull(DatosAnt.Fields("IdImputacion").Value), 0, DatosAnt.Fields("IdImputacion").Value) > 0 Then
                                    DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", DatosAnt.Fields("IdImputacion").Value)
                                    If DatosCtaCte.RecordCount > 0 Then
                                        oDet.Tarea(SC, "ComprobantesProveedores_ImputarOPRetencionIVAAplicada", ArrayVB6(DatosCtaCte.Fields("IdComprobante").Value, 0))
                                    End If
                                    DatosCtaCte.Close()
                                End If
                            End If
                            DatosAnt.Close()
                            oDet.Eliminar(SC, "DetOrdenesPago", .Id)
                        End If

                    ElseIf Not mvarAnulada Then

                        Resp = oDet.Guardar(SC, "DetOrdenesPago", Datos)
                        mIdDetalleOrdenPago = Datos.Fields(0).Value
                        Datos.Close()

                        DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Struc")
                        DatosCtaCteNv = CopiarRs(DatosCtaCte)
                        DatosCtaCte.Close()
                        DatosCtaCte = Nothing

                        With DatosCtaCteNv
                            Tot = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda), 2)
                            TotDol = 0
                            If mvarCotizacion <> 0 Then
                                TotDol = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / mvarCotizacion, 2)
                            End If
                            TotEu = 0
                            If mvarCotizacionEuro <> 0 Then
                                TotEu = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / mvarCotizacionEuro, 2)
                            End If
                            .Fields("IdProveedor").Value = oOP.IdProveedor
                            .Fields("NumeroComprobante").Value = mNumeroOrdenPago
                            .Fields("Fecha").Value = oOP.FechaOrdenPago
                            .Fields("FechaVencimiento").Value = oOP.FechaOrdenPago
                            If item.IdImputacion <> -2 Then
                                .Fields("IdTipoComp").Value = 17
                            Else
                                .Fields("IdTipoComp").Value = 16
                            End If
                            .Fields("IdComprobante").Value = oOP.Id
                            If item.IdImputacion <> -1 And _
                                  item.IdImputacion <> -2 Then
                                .Fields("IdImputacion").Value = item.IdImputacion
                            End If
                            .Fields("ImporteTotal").Value = Tot
                            .Fields("Saldo").Value = Tot
                            .Fields("IdDetalleOrdenPago").Value = mIdDetalleOrdenPago
                            .Fields(0).Value = -1
                            .Fields("CotizacionDolar").Value = mvarCotizacion
                            .Fields("ImporteTotalDolar").Value = TotDol
                            .Fields("SaldoDolar").Value = TotDol
                            .Fields("CotizacionEuro").Value = mvarCotizacionEuro
                            .Fields("ImporteTotalEuro").Value = TotEu
                            .Fields("SaldoEuro").Value = TotEu
                            .Fields("IdMoneda").Value = oOP.IdMoneda
                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                            If Not IsNothing(.Fields("IdImputacion").Value) And _
                                  Not IsDBNull(.Fields("IdImputacion").Value) Then
                                DatosCtaCte = oDet.TraerFiltrado(SC, "CtasCtesA", "_Imputacion", item.IdImputacion)
                                If DatosCtaCte.RecordCount > 0 Then
                                    Sdo = DatosCtaCte.Fields("Saldo").Value
                                    SdoDol = IIf(IsDBNull(DatosCtaCte.Fields("SaldoDolar").Value), 0, DatosCtaCte.Fields("SaldoDolar").Value)
                                    SdoEu = IIf(IsDBNull(DatosCtaCte.Fields("SaldoEuro").Value), 0, DatosCtaCte.Fields("SaldoEuro").Value)
                                Else
                                    Sdo = 0
                                    SdoDol = 0
                                    SdoEu = 0
                                End If
                                If oOP.Dolarizada = "NO" Then
                                    TotDol = 0
                                    If DatosCtaCte.Fields("CotizacionDolar").Value <> 0 Then
                                        TotDol = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / DatosCtaCte.Fields("CotizacionDolar").Value, 2)
                                    End If
                                    .Fields("CotizacionDolar").Value = DatosCtaCte.Fields("CotizacionDolar").Value
                                    .Fields("ImporteTotalDolar").Value = TotDol
                                    .Fields("SaldoDolar").Value = TotDol

                                    TotEu = 0
                                    If DatosCtaCte.Fields("CotizacionEuro").Value <> 0 Then
                                        TotEu = Math.Round(Math.Abs(item.Importe * mvarCotizacionMoneda) / DatosCtaCte.Fields("CotizacionEuro").Value, 2)
                                    End If
                                    .Fields("CotizacionEuro").Value = DatosCtaCte.Fields("CotizacionEuro").Value
                                    .Fields("ImporteTotalEuro").Value = TotEu
                                    .Fields("SaldoEuro").Value = TotEu
                                End If

                                If Tot > Sdo Then
                                    Tot = Math.Round(Tot - Sdo, 2)
                                    DatosCtaCte.Fields("Saldo").Value = 0
                                    .Fields("Saldo").Value = Tot
                                Else
                                    Sdo = Math.Round(Sdo - Tot, 2)
                                    DatosCtaCte.Fields("Saldo").Value = Sdo
                                    .Fields("Saldo").Value = 0
                                End If
                                If TotDol > SdoDol Then
                                    TotDol = Math.Round(TotDol - SdoDol, 2)
                                    DatosCtaCte.Fields("SaldoDolar").Value = 0
                                    .Fields("SaldoDolar").Value = TotDol
                                Else
                                    SdoDol = Math.Round(SdoDol - TotDol, 2)
                                    DatosCtaCte.Fields("SaldoDolar").Value = SdoDol
                                    .Fields("SaldoDolar").Value = 0
                                End If
                                If TotEu > SdoEu Then
                                    TotEu = Math.Round(TotEu - SdoEu, 2)
                                    DatosCtaCte.Fields("SaldoEuro").Value = 0
                                    .Fields("SaldoEuro").Value = TotEu
                                Else
                                    SdoEu = Math.Round(SdoEu - TotEu, 2)
                                    DatosCtaCte.Fields("SaldoEuro").Value = SdoEu
                                    .Fields("SaldoEuro").Value = 0
                                End If

                                .Fields("IdImputacion").Value = DatosCtaCte.Fields("IdImputacion").Value
                                oRsComp = oDet.TraerFiltrado(SC, "TiposComprobante", "_Buscar", DatosCtaCte.Fields("IdTipoComp").Value)
                                If oRsComp.Fields("Coeficiente").Value = -1 Then
                                    .Fields("IdTipoComp").Value = 16
                                End If
                                oRsComp.Close()
                                If DatosCtaCte.Fields("IdTipoComp").Value <> 16 And DatosCtaCte.Fields("IdTipoComp").Value <> 17 Then
                                    If Not IsDBNull(item.ImporteRetencionIVA) Then
                                        If item.ImporteRetencionIVA <> 0 Then
                                            oRsComp = oDet.LeerUno("ComprobantesProveedores", DatosCtaCte.Fields("IdComprobante").Value)
                                            If oRsComp.RecordCount > 0 Then
                                                If IsDBNull(oRsComp.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value) Or _
                                                      oRsComp.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value = 0 Then
                                                    oDet.Tarea(SC, "ComprobantesProveedores_ImputarOPRetencionIVAAplicada", _
                                                          ArrayVB6(DatosCtaCte.Fields("IdComprobante").Value, mIdDetalleOrdenPago))
                                                    '                                    oRsComp.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value = mIdDetalleOrdenPago
                                                    '                                    Resp = oDet.Guardar(sc,"ComprobantesProveedores", oRsComp)
                                                End If
                                            End If
                                            oRsComp.Close()
                                        End If
                                    End If
                                End If
                                oRsComp = Nothing
                                Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCte)
                                DatosCtaCte.Close()
                                DatosCtaCte = Nothing
                            End If
                        End With

                        If Not IsNothing(DatosCtaCteNv.Fields("IdImputacion").Value) Then
                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
                        Else
                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
                            DatosCtaCteNv.Fields("IdImputacion").Value = DatosCtaCteNv.Fields(0).Value
                            item.IdImputacion = DatosCtaCteNv.Fields(0).Value
                            Resp = oDet.Guardar(SC, "CtasCtesA", DatosCtaCteNv)
                        End If
                        DatosCtaCteNv.Close()
                        DatosCtaCteNv = Nothing

                        If mvarIdentificador > 0 Then
                            oDet.Tarea(SC, "DiferenciasCambio_Eliminar", ArrayVB6(17, mIdDetalleOrdenPago))
                        End If
                        If oOP.Dolarizada = "SI" Then
                            Datos = CopiarRs(oDet.TraerFiltrado(SC, "DiferenciasCambio", "_Struc"))
                            Datos.Fields(0).Value = -1
                            Datos.Fields("IdTipoComprobante").Value = 17
                            Datos.Fields("IdRegistroOrigen").Value = mIdDetalleOrdenPago
                            Resp = oDet.Guardar(SC, "DiferenciasCambio", Datos)
                            Datos.Close()
                        End If
                        Datos = Nothing


                    End If





                End With
            Next




            If mvarIdentificador > 0 And mvarAnulada Then
                oRsAux = oDet.TraerFiltrado(SC, "DetOrdenesPagoValores", "_PorIdCabecera", mvarIdentificador)
                With oRsAux
                    If .RecordCount > 0 Then
                        .MoveFirst()
                        Do While Not .EOF
                            If Not IsDBNull(.Fields("IdValor").Value) Then
                                oRsValores = oDet.LeerUno("Valores", .Fields("IdValor").Value)
                                With oRsValores
                                    .Fields("Estado").Value = DBNull.Value
                                    .Fields("IdProveedor").Value = DBNull.Value
                                    .Fields("NumeroOrdenPago").Value = DBNull.Value
                                    .Fields("FechaOrdenPago").Value = DBNull.Value
                                End With
                                Resp = oDet.Guardar(SC, "Valores", oRsValores)
                                oRsValores.Close()
                                oRsValores = Nothing
                            End If
                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", .Fields(0).Value)
                            .MoveNext()
                        Loop
                    End If
                    .Close()
                End With




                oRsAux = Nothing
            End If


            For Each itV In .DetallesValores

                With itV
                    itV.IdOrdenPago = oOP.Id

                    If itV.Eliminado Then
                        If .Id > 0 Then
                            If Not IsDBNull(itV.IdValor) Then
                                oRsValores = oDet.LeerUno("Valores", itV.IdValor)
                                With oRsValores
                                    .Fields("Estado").Value = DBNull.Value
                                    .Fields("IdProveedor").Value = DBNull.Value
                                    .Fields("NumeroOrdenPago").Value = DBNull.Value
                                    .Fields("FechaOrdenPago").Value = DBNull.Value
                                End With
                                Resp = oDet.Guardar(SC, "Valores", oRsValores)
                                oRsValores.Close()
                                oRsValores = Nothing
                            End If
                            oDet.Eliminar(SC, "DetOrdenesPagoValores", .Id)
                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", .Id)
                        End If
                    Else

                        Resp = oDet.Guardar(SC, "DetOrdenesPagoValores", Datos)
                        mIdDetalleOrdenPagoValores = Datos.Fields(0).Value

                        mvarBorrarEnValores = True

                        mIdValor = -1
                        oRsValores = oDet.TraerFiltrado(SC, "Valores", "_PorIdDetalleOrdenPagoValores", mIdDetalleOrdenPagoValores)
                        If oRsValores.RecordCount > 0 Then mIdValor = oRsValores.Fields(0).Value
                        oRsValores.Close()
                        oRsValores = Nothing

                        If Not IsDBNull(itV.IdCaja) Then
                            If Not mvarAnulada Then
                                oRsValores = oDet.TraerFiltrado(SC, "Valores", "_Struc")
                                oRsValoresNv = CopiarRs(oRsValores)
                                oRsValores.Close()
                                With oRsValoresNv
                                    .Fields("IdTipoValor").Value = itV.IdTipoValor
                                    .Fields("Importe").Value = itV.Importe
                                    .Fields("NumeroComprobante").Value = mNumeroOrdenPago
                                    .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                    If Not IsDBNull(oOP.IdProveedor) Then
                                        .Fields("IdProveedor").Value = oOP.IdProveedor
                                    End If
                                    .Fields("IdTipoComprobante").Value = 17
                                    .Fields("IdDetalleOrdenPagoValores").Value = mIdDetalleOrdenPagoValores
                                    .Fields("IdCaja").Value = itV.IdCaja
                                    .Fields("IdMoneda").Value = oOP.IdMoneda
                                    .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                    .Fields(0).Value = mIdValor
                                End With
                                Resp = oDet.Guardar(SC, "Valores", oRsValoresNv)
                                oRsValoresNv.Close()
                                oRsValoresNv = Nothing
                            End If
                            mvarBorrarEnValores = False
                        Else
                            If Not IsDBNull(.IdValor) Then
                                If Not mvarAnulada Then
                                    oRsValores = oDet.LeerUno("Valores", .IdValor)
                                    With oRsValores
                                        .Fields("Estado").Value = "E"
                                        If Not IsDBNull(oOP.IdProveedor) Then
                                            .Fields("IdProveedor").Value = oOP.IdProveedor
                                        End If
                                        .Fields("NumeroOrdenPago").Value = mNumeroOrdenPago
                                        .Fields("FechaOrdenPago").Value = oOP.FechaOrdenPago
                                    End With
                                    Resp = oDet.Guardar(SC, "Valores", oRsValores)
                                    oRsValores.Close()
                                    oRsValores = Nothing
                                End If
                            Else
                                If Not mvarAnulada Or (Not IsDBNull(.Anulado) And .Anulado = "SI") Then
                                    If mIdValor > 0 Then
                                        oRsValores = oDet.TraerFiltrado(SC, "Valores", "_PorId", mIdValor)
                                        ' oRsValoresNv = ClaseMigrar.CopiarUnRegistro(oRsValores)
                                    Else
                                        oRsValores = oDet.TraerFiltrado(SC, "Valores", "_Struc")
                                        oRsValoresNv = CopiarRs(oRsValores)
                                    End If
                                    oRsValores.Close()
                                    oRsValores = Nothing
                                    With oRsValoresNv
                                        .Fields("IdTipoValor").Value = itV.IdTipoValor
                                        .Fields("NumeroValor").Value = itV.NumeroValor
                                        .Fields("NumeroInterno").Value = itV.NumeroInterno
                                        .Fields("FechaValor").Value = itV.FechaVencimiento
                                        .Fields("IdCuentaBancaria").Value = itV.IdCuentaBancaria
                                        .Fields("IdBanco").Value = itV.IdBanco
                                        .Fields("Importe").Value = itV.Importe
                                        .Fields("NumeroComprobante").Value = mNumeroOrdenPago
                                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                        If Not IsDBNull(oOP.IdProveedor) Then
                                            .Fields("IdProveedor").Value = oOP.IdProveedor
                                        End If
                                        .Fields("IdTipoComprobante").Value = 17
                                        .Fields("IdDetalleOrdenPagoValores").Value = mIdDetalleOrdenPagoValores
                                        .Fields("IdMoneda").Value = oOP.IdMoneda
                                        .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                        .Fields("Anulado").Value = itV.Anulado
                                        .Fields("IdUsuarioAnulo").Value = itV.IdUsuarioAnulo
                                        .Fields("FechaAnulacion").Value = itV.FechaAnulacion
                                        .Fields("MotivoAnulacion").Value = itV.MotivoAnulacion
                                        .Fields("IdTarjetaCredito").Value = itV.IdTarjetaCredito
                                        .Fields(0).Value = mIdValor
                                    End With
                                    Resp = oDet.Guardar(SC, "Valores", oRsValoresNv)
                                    oRsValoresNv.Close()
                                    oRsValoresNv = Nothing

                                    mvarBorrarEnValores = False
                                    If mvarAnulada And mvarFormaAnulacionCheques = "E" Then mvarBorrarEnValores = True

                                    If mIdValor > 0 And Not IsDBNull(.Anulado) And .Anulado = "SI" Then
                                        oDet.Tarea(SC, "Asientos_EliminarItemChequePagoDiferido", ArrayVB6("0", 0, mIdValor))
                                        oDet.Tarea(SC, "Conciliaciones_BorrarPorIdValor", mIdValor)
                                    End If

                                    If Not .Id > 0 And Not IsDBNull(itV.IdBancoChequera) Then
                                        oRsValores = oDet.TraerFiltrado(SC, "BancoChequeras", "_PorId", itV.IdBancoChequera)
                                        If oRsValores.RecordCount > 0 Then
                                            '                           If itV.NumeroValor = oRsValores.Fields("ProximoNumeroCheque").Value Then
                                            '                              oRsValores.Fields("ProximoNumeroCheque").Value = oRsValores.Fields("ProximoNumeroCheque").Value + 1
                                            '                              Resp = oDet.Guardar(sc,"BancoChequeras", oRsValores)
                                            '                           End If
                                            If itV.NumeroValor >= oRsValores.Fields("ProximoNumeroCheque").Value Then
                                                oRsValores.Fields("ProximoNumeroCheque").Value = itV.NumeroValor + 1
                                                If oRsValores.Fields("ProximoNumeroCheque").Value >= oRsValores.Fields("HastaCheque").Value Then
                                                    oRsValores.Fields("Activa").Value = "NO"
                                                End If
                                                oRsValores.Update()
                                            End If
                                            Resp = oDet.Guardar(SC, "BancoChequeras", oRsValores)
                                        End If
                                        oRsValores.Close()
                                    End If
                                End If
                                oRsValores = Nothing
                            End If
                        End If
                        Datos.Close()
                        Datos = Nothing

                        If mvarIdentificador > 0 And mvarBorrarEnValores Then
                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoValores", .Id)
                        End If
                    End If

                End With
            Next

            If mvarIdentificador > 0 And mvarAnulada Then
                oRsAux = oDet.TraerFiltrado(SC, "DetOrdenesPagoCuentas", "_PorIdOrdenPago", mvarIdentificador)
                With oRsAux
                    If .RecordCount > 0 Then
                        .MoveFirst()
                        Do While Not .EOF
                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoCuentas", .Fields(0).Value)
                            .MoveNext()
                        Loop
                    End If
                    .Close()
                End With
                oRsAux = Nothing
            End If

            For Each iCta In .DetallesCuentas
                With iCta
                    iCta.IdOrdenPago = oOP.Id

                    If iCta.Eliminado Then
                        If .Id > 0 Then
                            oDet.Eliminar(SC, "DetOrdenesPagoCuentas", .Id)
                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoCuentas", .Id)
                        End If
                    Else

                        Resp = oDet.Guardar(SC, "DetOrdenesPagoCuentas", Datos)
                        mvarIdDetalleOrdenPagoCuentas = Datos.Fields(0).Value
                        Datos.Close()
                        Datos = Nothing

                        mvarBorrarEnValores = True

                        If Not IsDBNull(iCta.Debe) And iCta.Debe <> 0 Then
                            oRsAux = oDet.TraerFiltrado(SC, "Cuentas", "_CuentaCajaBanco", iCta.IdCuenta)
                            If oRsAux.RecordCount > 0 Then
                                mvarEsCajaBanco = ""
                                If Not IsDBNull(oRsAux.Fields("EsCajaBanco").Value) And _
                                      (oRsAux.Fields("EsCajaBanco").Value = "BA" Or oRsAux.Fields("EsCajaBanco").Value = "CA" Or _
                                       oRsAux.Fields("EsCajaBanco").Value = "TC") Then
                                    mvarEsCajaBanco = oRsAux.Fields("EsCajaBanco").Value
                                    oRsAux.Close()
                                End If
                                If Len(mvarEsCajaBanco) > 0 Then
                                    mIdValor = -1
                                    oRsAux = oDet.TraerFiltrado(SC, "Valores", "_PorIdDetalleOrdenPagoCuentas", mvarIdDetalleOrdenPagoCuentas)
                                    If oRsAux.RecordCount > 0 Then mIdValor = oRsAux.Fields(0).Value
                                    oRsAux.Close()

                                    mvarIdBanco = 0
                                    If mvarEsCajaBanco = "BA" And Not IsDBNull(iCta.IdCuentaBancaria) Then
                                        oRsAux = oDet.TraerFiltrado(SC, "CuentasBancarias", "_PorId", iCta.IdCuentaBancaria)
                                        If oRsAux.RecordCount > 0 Then mvarIdBanco = oRsAux.Fields("IdBanco").Value
                                    End If

                                    oRsValores = oDet.TraerFiltrado(SC, "Valores", "_Struc")
                                    oRsValoresNv = CopiarRs(oRsValores)
                                    oRsValores.Close()
                                    oRsValores = Nothing
                                    With oRsValoresNv
                                        If mvarEsCajaBanco = "BA" Then
                                            .Fields("IdTipoValor").Value = 21
                                            .Fields("IdBanco").Value = mvarIdBanco
                                            .Fields("IdCuentaBancaria").Value = iCta.IdCuentaBancaria
                                        ElseIf mvarEsCajaBanco = "TC" Then
                                            .Fields("IdTipoValor").Value = 43
                                            .Fields("IdTarjetaCredito").Value = iCta.IdTarjetaCredito
                                        Else
                                            .Fields("IdTipoValor").Value = 32
                                            .Fields("IdCaja").Value = iCta.IdCaja
                                        End If
                                        .Fields("NumeroValor").Value = 0
                                        .Fields("NumeroInterno").Value = 0
                                        .Fields("FechaValor").Value = oOP.FechaOrdenPago
                                        If iCta.CotizacionMonedaDestino <> 0 Then
                                            If Not IsDBNull(iCta.Debe) And iCta.Debe <> 0 Then
                                                .Fields("Importe").Value = (iCta.Debe * _
                                                                            oOP.CotizacionMoneda) / _
                                                                            iCta.CotizacionMonedaDestino * -1
                                            End If
                                            If Not IsDBNull(iCta.Haber) And iCta.Haber <> 0 Then
                                                .Fields("Importe").Value = (iCta.Haber * _
                                                                            oOP.CotizacionMoneda) / _
                                                                            iCta.CotizacionMonedaDestino
                                            End If
                                            .Fields("CotizacionMoneda").Value = iCta.CotizacionMonedaDestino
                                        Else
                                            If Not IsDBNull(iCta.Debe) And iCta.Debe <> 0 Then
                                                .Fields("Importe").Value = iCta.Debe * -1
                                            End If
                                            If Not IsDBNull(iCta.Haber) And iCta.Haber <> 0 Then
                                                .Fields("Importe").Value = iCta.Haber
                                            End If
                                            .Fields("CotizacionMoneda").Value = oOP.CotizacionMoneda
                                        End If
                                        .Fields("NumeroComprobante").Value = mNumeroOrdenPago
                                        .Fields("FechaComprobante").Value = oOP.FechaOrdenPago
                                        If Not IsDBNull(oOP.IdProveedor) Then
                                            .Fields("IdProveedor").Value = oOP.IdProveedor
                                        End If
                                        .Fields("IdTipoComprobante").Value = 17
                                        .Fields("IdDetalleOrdenPagoCuentas").Value = mvarIdDetalleOrdenPagoCuentas
                                        .Fields("IdMoneda").Value = iCta.IdMoneda
                                        .Fields(0).Value = mIdValor
                                    End With
                                    Resp = oDet.Guardar(SC, "Valores", oRsValoresNv)
                                    oRsValoresNv.Close()
                                    oRsValoresNv = Nothing
                                    mvarBorrarEnValores = False
                                End If
                            Else
                                oRsAux.Close()
                            End If
                            oRsAux = Nothing
                        End If
                        If mvarIdentificador > 0 And mvarBorrarEnValores Then
                            oDet.Tarea(SC, "Valores_BorrarPorIdDetalleOrdenPagoCuentas", .Id)
                        End If
                    End If

                End With
            Next

            If mvarIdentificador > 0 And mvarAnulada Then
                oDet.Tarea(SC, "AnticiposAlPersonal_BorrarPorIdOrdenPago", mvarIdentificador)
            End If

            'Borra la registracion contable anterior si la orden de pago fue modificada
            If mvarIdentificador > 0 Or mvarAnulada Then
                DatosAnt = oDet.TraerFiltrado(SC, "Subdiarios", "_PorIdComprobante", ArrayVB6(mvarIdentificador, 17))
                With DatosAnt
                    If .RecordCount > 0 Then
                        .MoveFirst()
                        Do While Not .EOF
                            oDet.Eliminar(SC, "Subdiarios", .Fields(0).Value)
                            .MoveNext()
                        Loop
                    End If
                    .Close()
                End With
                DatosAnt = Nothing
            End If

            mvarDebe = 0
            mvarHaber = 0

            With RegistroContable
                If .State <> adStateClosed And Not mvarAnulada Then
                    If .RecordCount > 0 Then
                        .Update()
                        .MoveFirst()
                    End If
                    Do While Not .EOF
                        If Not IsDBNull(.Fields("Debe").Value) Then
                            .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
                            .Update()
                            mvarDebe = mvarDebe + .Fields("Debe").Value
                        End If
                        If Not IsDBNull(.Fields("Haber").Value) Then
                            .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
                            .Update()
                            mvarHaber = mvarHaber + .Fields("Haber").Value
                        End If
                        .MoveNext()
                    Loop
                    If .RecordCount > 0 Then
                        .MoveFirst()
                        If mvarDebe - mvarHaber <> 0 Then
                            If Not IsDBNull(.Fields("Debe").Value) Then
                                .Fields("Debe").Value = .Fields("Debe").Value - Math.Round(mvarDebe - mvarHaber, 2)
                            Else
                                .Fields("Haber").Value = .Fields("Haber").Value + Math.Round(mvarDebe - mvarHaber, 2)
                            End If
                        End If
                    End If
                    Do While Not .EOF
                        Datos = CreateObject("adodb.Recordset")
                        For i = 0 To .Fields.Count - 1
                            With .Fields(i)
                                Datos.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                                Datos.Fields(.Name).Precision = .Precision
                                Datos.Fields(.Name).NumericScale = .NumericScale
                            End With
                        Next
                        Datos.Open()
                        Datos.AddNew()
                        For i = 0 To .Fields.Count - 1
                            With .Fields(i)
                                Datos.Fields(i).Value = .Value
                            End With
                        Next
                        Datos.Fields("IdComprobante").Value = oOP.Id
                        Datos.Fields("NumeroComprobante").Value = mNumeroOrdenPago
                        Datos.Update()
                        Resp = oDet.Guardar(SC, "Subdiarios", Datos)
                        Datos.Close()
                        Datos = Nothing
                        .MoveNext()
                    Loop
                End If
            End With

            If mvarIdentificador > 0 And mvarAnulada Then
                oDet.Tarea(SC, "DetOrdenesPagoRubrosContables_BorrarPorIdOrdenPago", mvarIdentificador)
            End If


            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetComplete()
                End With
            End If

Salir:
            Guardar_CodigoOriginalDeVB6 = Resp
            oDet = Nothing
            oCont = Nothing
            On Error GoTo 0
            If lErr Then
                Err.Raise(lErr, sSource, sDesc)
            End If
            Exit Function

Mal:
            If Not oCont Is Nothing Then
                With oCont
                    If .IsInTransaction Then .SetAbort()
                End With
            End If
            With Err()
                lErr = .Number
                sSource = .Source
                sDesc = .Description
            End With
            'oDet.Tarea(sc,"Log_InsertarRegistro", ArrayVB6("MTSOP", oop.id, 0, Now, 0, _
            '      "Error " & Err.Number & Err.Description & ", " & Err.Source, _
            '      "MTSPronto " & App.Major & " " & App.Minor & " " & App.Revision))
            Resume Salir

        End With

    End Function





    Public Shared Function GetList(ByVal SC As String) As OrdenPagoList
        Return OrdenPagoDB.GetList(SC)
    End Function


    Public Shared Function GetCopyOfItem(ByVal SC As String, ByVal id As Integer) As OrdenPago
        If id <= 0 Then Return Nothing

        GetCopyOfItem = GetItem(SC, id, True)
        'me trigo el mismo item, pero lo marco como nuevo -pero no deberías hacer lo mismo con el detalle?
        GetCopyOfItem.Id = -1
        For Each item As OrdenPagoItem In GetCopyOfItem.DetallesImputaciones
            item.Id = -1
        Next
    End Function


    Public Shared Function GetListByEmployee(ByVal SC As String, ByVal IdSolicito As String, ByVal orderBy As String) As OrdenPagoList
        Dim OrdenPagoList As Pronto.ERP.BO.OrdenPagoList = OrdenPagoDB.GetListByEmployee(SC, IdSolicito)
        If OrdenPagoList IsNot Nothing Then
            Select Case orderBy
                'Case "Fecha"
                '    OrdenPagoList.Sort(AddressOf Pronto.ERP.BO.OrdenPagoList.CompareFecha)
                'Case "Obra"
                '    OrdenPagoList.Sort(AddressOf Pronto.ERP.BO.OrdenPagoList.CompareObra)
                'Case "Sector"
                '    OrdenPagoList.Sort(AddressOf Pronto.ERP.BO.OrdenPagoList.CompareSector)
                'Case Else 'Ordena por id
                '    OrdenPagoList.Sort(AddressOf Pronto.ERP.BO.OrdenPagoList.CompareId)
            End Select
        End If
        Return OrdenPagoList
    End Function


    Public Shared Function GetList_fm(ByVal SC As String) As System.Data.DataSet
        Return OrdenPagoDB.GetList_fm(SC)
    End Function


    Public Shared Function GetListDataset(ByVal SC As String) As System.Data.DataTable



        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        'Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        'With dc
        '    .ColumnName = "ColumnaTilde"
        '    .DataType = System.Type.GetType("System.Int32")
        '    .DefaultValue = 0
        'End With


        Try
            ds = GeneralDB.TraerDatos(SC, "wOrdenPagos_T", -1)
        Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "OrdenPagos_TT")
        End Try


        'acá hago que los nombres de columna del dataset coincidan con los del objeto, así
        'la gridview puede enlazarse a GetListDataset o a GetList sin tener que cambiar los nombres
        With ds.Tables(0)
            .Columns("IdOrdenPago").ColumnName = "Id"
            .Columns("OrdenPago").ColumnName = "Numero"
            '.Columns("FechaOrdenPago").ColumnName = "Fecha"
        End With

        'ds.Tables(0).Columns.Add(dc)
        Dim dt As DataTable = ds.Tables(0)
        dt.DefaultView.Sort = "Id DESC"
        Return dt.DefaultView.Table
    End Function


    Public Shared Function GetListTXDetallesPendientes(ByVal SC As String) As System.Data.DataSet
        Return GetListTX(SC, "_Pendientes1", "P")
    End Function



    Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String, ByVal ParamArray Parametros() As Object) As System.Data.DataSet
        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox            'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        With dc
            .ColumnName = "ColumnaTilde"
            .DataType = System.Type.GetType("System.Int32")
            .DefaultValue = 0
        End With


        Try
            ds = GeneralDB.TraerDatos(SC, "wOrdenPagos_TX" & TX, Parametros)
        Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "OrdenPagos_TX" & TX, Parametros)
        End Try
        ds.Tables(0).Columns.Add(dc)
        Return ds
    End Function


    Public Shared Function GetListTX(ByVal SC As String, ByVal TX As String) As System.Data.DataSet
        'En realidad lo que hace esta funcion es devolverme un dataset en lugar de un list, y le ensoqueta una
        ' variable para guardar el valor del checkbox


        'If Parametros Is Nothing Then Parametros = New String() {""}
        Dim ds As DataSet
        Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta
        With dc
            .ColumnName = "ColumnaTilde"
            .DataType = System.Type.GetType("System.Int32")
            .DefaultValue = 0
        End With


        Try
            ds = GeneralDB.TraerDatos(SC, "wOrdenPagos_TX" & TX)
        Catch ex As Exception
            ds = GeneralDB.TraerDatos(SC, "OrdenPagos_TX" & TX)
        End Try
        ds.Tables(0).Columns.Add(dc)
        Return ds
    End Function






    Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer) As OrdenPago
        Return GetItem(SC, id, False)
    End Function


    Public Shared Function GetItem(ByVal SC As String, ByVal id As Integer, ByVal getOrdenPagoDetalles As Boolean) As OrdenPago
        Dim myOrdenPago As OrdenPago
        myOrdenPago = OrdenPagoDB.GetItem(SC, id)

        If Not (myOrdenPago Is Nothing) AndAlso getOrdenPagoDetalles Then
            'traigo el detalle
            myOrdenPago.DetallesImputaciones = OrdenPagoItemDB.GetList(SC, id)
            myOrdenPago.DetallesImpuestos = OrdenPagoImpuestosItemDB.GetList(SC, id)
            myOrdenPago.DetallesCuentas = OrdenPagoCuentasItemDB.GetList(SC, id)
            myOrdenPago.DetallesRubrosContables = OrdenPagoRubrosContablesItemDB.GetList(SC, id)
            myOrdenPago.DetallesValores = OrdenPagoValoresItemDB.GetList(SC, id)
            'myOrdenPago.DetallesAnticiposAlPersonal = OrdenPagoAnticiposAlPersonalItemDB.GetList(SC, id)


            RefrescarDesnormalizados(SC, myOrdenPago)


        End If

        Return myOrdenPago
    End Function






    Public Shared Function GetListItems(ByVal SC As String, ByVal id As Integer) As OrdenPagoItemList
        Dim list As OrdenPagoItemList = OrdenPagoItemDB.GetList(SC, id)
        For Each i As OrdenPagoItem In list
            If i.IdImputacion > 0 Then
                Dim dr As DataRow = CtaCteDeudorManager.TraerMetadata(SC, i.IdImputacion).Rows(0)
                i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
                i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(SC, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
            End If
        Next
        Return list
    End Function


    Public Shared Function ConvertirComProntoOrdenPagoAPuntoNET(ByVal oOrdenPago) As Pronto.ERP.BO.OrdenPago 'As ComPronto.OrdenPago ) As Pronto.ERP.BO.OrdenPago
        Dim oDest As New Pronto.ERP.BO.OrdenPago

        '///////////////////////////
        '///////////////////////////
        'ENCABEZADO
        With oOrdenPago.Registro

            oDest.Id = oOrdenPago.Id

            'oDest.Fecha = .Fields("FechaOrdenPago").Value
            'oDest.IdCliente = .Fields("IdCliente").Value

            'oDest.TipoFactura = .Fields("TipoABC").Value

            'oDest.IdPuntoVenta = .Fields("IdPuntoVenta").Value
            'oDest.Numero = .Fields("NumeroOrdenPago").Value


            'oDest.IdVendedor = iisNull(.Fields("IdVendedor").Value, 0)
            'oDest.Total = .Fields("ImporteTotal").Value
            oDest.IdMoneda = iisNull(.Fields("IdMoneda").Value, 0)
            'oDest.IdCodigoIVA = iisNull(.Fields("Idcodigoiva").Value, 0)

            oDest.Observaciones = iisNull(.Fields("observaciones").Value, 0)

            'oDest.Bonificacion = .Fields("PorcentajeBonificacion").Value
            'oDest.ImporteIva1 = .Fields("ImporteIVA1").Value
            'oDest.ImporteTotal = .Fields("ImporteTotal").Value
        End With



        '///////////////////////////
        '///////////////////////////
        'DETALLE
        Dim rsDet As adodb.Recordset = oOrdenPago.DetOrdenPagos.TraerTodos

        With rsDet
            If Not .EOF Then .MoveFirst()

            Do While Not .EOF

                Dim oDetOrdenPago 'As ComPronto.DetOrdenPago  = oOrdenPago.DetOrdenPagos.Item(rsDet.Fields("IdDetalleOrdenPago"))

                Dim item As New OrdenPagoItem


                With oDetOrdenPago.Registro

                    'item.IdConcepto = .Fields("IdConcepto").Value
                    'item.Concepto = rsDet.Fields(3).Value
                    item.ImporteTotalItem = .Fields("Importe").Value
                    'item.gravado = .Fields("Gravado").Value
                    'item.Precio = .Fields("IvaNoDiscriminado").Value
                    'item.Precio = .Fields("PrecioUnitarioTotal").Value

                End With

                oDest.DetallesImputaciones.Add(item)
                .MoveNext()
            Loop

        End With


        Return oDest
    End Function



    '<DataObjectMethod(DataObjectMethodType.Select, False)> _
    'Public Shared Function GetItemComPronto(ByVal SC As String, ByVal id As Integer, ByVal getOrdenPagoDetalles As Boolean) As OrdenPago
    '    Dim myOrdenPago As OrdenPago
    '    'myOrdenPago = OrdenPagoDB.GetItem(SC, id)
    '    myOrdenPago = New OrdenPago

    '    Dim Aplicacion = CrearAppCompronto(SC)
    '    'myOrdenPago.__COMPRONTO_OrdenPago = Aplicacion.OrdenPagos.Item(id)

    '    myOrdenPago = ConvertirComProntoOrdenPagoAPuntoNET(Aplicacion.OrdenPagos.Item(id))
    '    Return myOrdenPago
    'End Function







    Public Shared Function Delete(ByVal SC As String, ByVal myOrdenPago As OrdenPago) As Boolean
        Return OrdenPagoDB.Delete(SC, myOrdenPago.Id)
    End Function


    Public Shared Function Delete(ByVal SC As String, ByVal empleado As Pronto.ERP.BO.Empleado) As Integer
        Return OrdenPagoDB.GetCountRequemientoForEmployee(SC, empleado.Id)
    End Function


    Public Shared Function Anular(ByVal SC As String, ByVal Id As Integer, ByVal IdUsuario As Long, ByVal motivo As String) As String

        'Dim myRemito As Pronto.ERP.BO.Remito = GetItem(SC, IdRemito)
        Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = GetItem(SC, Id, True)

        With myOrdenPago
            '.MotivoAnulacion = motivo
            '.FechaAnulacion = Today
            '.UsuarioAnulacion = IdUsuario
            '.Anulada = "SI"
            '.IdAutorizaAnulacion = cmbUsuarioAnulo.SelectedValue
            '.Cumplido = "AN"
            '.Anulada = "SI"
            '.IdAutorizaAnulacion = IdUsuario

            For Each i As OrdenPagoItem In .DetallesImputaciones
                With i
                    '.Cumplido = "AN"
                    '.EnviarEmail = 1
                End With
            Next






            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            'TO DO: No encontré el campo CAE en la nota de debito
            'If iisNull(.CAE, "") <> "" Then
            '    Return "No puede anular un comprobante electronico (CAE)"
            'End If



            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////
            ''reviso si hay facturas que esten imputadas al remito que se quiere anular
            'Dim dr As DataRow
            'Try
            '    dr = EntidadManager.GetStoreProcedureTop1(SC, "CtasCtesD_TX_BuscarComprobante", Id, EntidadManager.IdTipoComprobante.OrdenPago)
            'Catch ex As Exception

            'End Try

            'If Not IsNothing(dr) Then
            '    If dr.Item("ImporteTotal") <> dr.Item("Saldo") Then
            '        Return "La nota de debito ha sido cancelada parcial o totalmente y no puede anularse"
            '    End If
            'End If

            '////////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////////







            'If ExistenAnticiposAplicados() Then
            '    MsgBox("El OrdenPago contiene anticipos que en cuenta corriente han sido aplicados." & vbCrLf & _
            '          "No puede anular este OrdenPago", vbInformation)
            '    Exit Function
            'End If

            'Dim oRs As adodb.Recordset
            'Dim mError As String
            'oRs = Aplicacion.OrdenPagos.TraerFiltrado("_PorEstadoValores", mvarId)
            'mError = ""
            'If oRs.RecordCount > 0 Then
            '    mError = "El OrdenPago no puede anularse porque tiene valores ingresados "
            '    Do While Not oRs.EOF
            '        If oRs.Fields("Estado").Value = "E" Then
            '            mError = mError & "endosados "
            '        ElseIf oRs.Fields("Estado").Value = "D" Then
            '            mError = mError & "depositados "
            '        End If
            '        oRs.MoveNext()
            '    Loop
            'End If



            .Anulada = EnumPRONTO_SiNo.SI '  "SI" ?????


            Save(SC, myOrdenPago)
        End With


    End Function


    Public Shared Function GetCountRequemientoForEmployee(ByVal SC As String, ByVal IdEmpleado As Integer) As Integer
        Return OrdenPagoDB.GetCountRequemientoForEmployee(SC, IdEmpleado)
    End Function





    Public Shared Function IsValidItemValor(ByVal SC As String, ByRef myItemValor As OrdenPagoValoresItem, Optional ByRef ms As String = "", Optional ByRef myOrdenPago As OrdenPago = Nothing) As Boolean

        With myItemValor

            'If Len(DataCombo1(0).BoundText) = 0 Then
            '    MsgBox("No definio el tipo de valor", vbExclamation)
            '    Exit Function
            'End If

            'If DataCombo1(1).Visible And Len(DataCombo1(1).BoundText) = 0 Then
            '    MsgBox("No definio la cuenta bancaria", vbExclamation)
            '    Exit Function
            'End If

            'If DataCombo1(0).BoundText = 6 And Len(DataCombo1(2).BoundText) = 0 Then
            '    MsgBox("No definio la chequera", vbExclamation)
            '    Exit Function
            'End If

            'If DataCombo1(3).Visible And Len(DataCombo1(3).BoundText) = 0 Then
            '    MsgBox("No definio la tarjeta de credito", vbExclamation)
            '    Exit Function
            'End If

            'If Not origen.NumeroValorValido Then
            '    MsgBox("Numero de valor existente", vbExclamation)
            '    Exit Function
            'End If



            'mDiasCheque = 1
            'If BuscarClaveINI("No controlar fecha de cheques de pago diferido en op") = "SI" Then mDiasCheque = 0
            'If Not Me.Exterior And mvarChequeraPagoDiferido = "SI" And DateDiff("d", Me.FechaOP, DTFields(0).Value) < mDiasCheque Then
            '    MsgBox("La fecha del cheque no puede ser anterior al " & DateAdd("d", mDiasCheque, Me.FechaOP), vbExclamation)
            '    Exit Function
            'End If


            Dim mvarChequeraDesde, mvarChequeraHasta, mvarChequeraPagoDiferido

            Dim oRs = TraerFiltradoVB6(SC, enumSPs.BancoChequeras_TX_PorId, .IdBancoChequera)
            If oRs.RecordCount > 0 Then
                mvarChequeraDesde = IIf(IsNull(oRs.Fields("DesdeCheque").Value), 0, oRs.Fields("DesdeCheque").Value)
                mvarChequeraHasta = IIf(IsNull(oRs.Fields("HastaCheque").Value), 0, oRs.Fields("HastaCheque").Value)
                mvarChequeraPagoDiferido = IIf(IsNull(oRs.Fields("ChequeraPagoDiferido").Value), "NO", oRs.Fields("ChequeraPagoDiferido").Value)
            End If

            If mvarChequeraDesde <> 0 And mvarChequeraHasta <> 0 And .NumeroValor < mvarChequeraDesde Or .NumeroValor > mvarChequeraHasta Then
                ms = "El numero de valor debe estar entre " & mvarChequeraDesde & " y el " & mvarChequeraHasta
            End If


        End With


        Return True

    End Function


    Public Shared Function IsValidItemCuentas(ByVal SC As String, ByRef myItemCuenta As OrdenPagoCuentasItem, Optional ByRef ms As String = "", Optional ByRef myOrdenPago As OrdenPago = Nothing) As Boolean

        With myItemCuenta

            'If Not IsNumeric(DataCombo1(0).BoundText) Then
            '    MsgBox("Debe indicar la cuenta", vbExclamation)
            '    Exit Function
            'End If

            'If DataCombo1(4).Enabled And Not IsNumeric(DataCombo1(4).BoundText) Then
            '    MsgBox("Debe indicar la cuenta banco", vbExclamation)
            '    Exit Function
            'End If

            'If DataCombo1(5).Enabled And Not IsNumeric(DataCombo1(5).BoundText) Then
            '    MsgBox("Debe indicar la cuenta caja", vbExclamation)
            '    Exit Function
            'End If

            'If (DataCombo1(4).Enabled Or DataCombo1(5).Enabled) And Not IsNumeric(DataCombo1(6).BoundText) Then
            '    MsgBox("Debe indicar la moneda", vbExclamation)
            '    Exit Function
            'End If

            'If DataCombo1(6).Enabled And Val(txtCotizacionMonedaDestino.Text) = 0 Then
            '    MsgBox("No hay cotizacion de la moneda destino")
            '    Exit Function
            'End If

            'If Len(txtDebe.Text) = 0 Or Not IsNumeric(txtDebe.Text) Then
            '    origen.Registro.Fields("Debe").Value = Null
            'End If
            'If Len(txtHaber.Text) = 0 Or Not IsNumeric(txtHaber.Text) Then
            '    origen.Registro.Fields("Haber").Value = Null
            'End If

            If .Debe = 0 And .Haber = 0 Then
                ms = "Debe indicar el importe (Debe o Haber)"
                Return False
            End If

            If .Debe > 0 And .Haber > 0 Then
                ms = "No puede ingresar importes al debe y al haber simultaneamente"
                Return False
            End If



            'If DataCombo1(7).Visible And Len(DataCombo1(7).BoundText) = 0 Then
            '    MsgBox("No definio la tarjeta de credito", vbExclamation)
            '    Exit Function
            'End If





        End With


        Return True

    End Function



    Public Shared Function IsValid(ByVal SC As String, ByRef myOrdenPago As OrdenPago, Optional ByRef ms As String = "") As Boolean

        With myOrdenPago

            RecalcularTotales(SC, myOrdenPago)

            Dim eliminados As Integer
            'verifico el detalle
            For Each det As OrdenPagoItem In .DetallesImputaciones
                If det.IdImputacion = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                If det.Eliminado Then eliminados = eliminados + 1

            Next




            For Each det As OrdenPagoCuentasItem In .DetallesCuentas
                If det.IdCuenta = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                'If det.Eliminado Then eliminados = eliminados + 1

            Next

            For Each det As OrdenPagoValoresItem In .DetallesValores
                If det.IdTipoValor = 0 And det.IdCaja = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                'If det.Eliminado Then eliminados = eliminados + 1

            Next

            For Each det As OrdenPagoRubrosContablesItem In .DetallesRubrosContables
                If det.IdRubroContable = 0 Then 'verifico que no pase un renglon en blanco
                    det.Eliminado = True
                End If
                'If det.Eliminado Then eliminados = eliminados + 1

            Next
            '          If DTFields(0).Value <= gblFechaUltimoCierre And _
            'Not AccesoHabilitado(OpcionesAcceso, DTFields(0).Value) Then
            '              MsgBox("La fecha no puede ser anterior al ultimo cierre : " & gblFechaUltimoCierre, vbInformation)
            '              Exit Function
            '          End If

            '          If Not IsNumeric(txtNumeroOrdenPago.Text) Or Len(txtNumeroOrdenPago.Text) = 0 Then
            '              MsgBox("No ingreso el numero de OrdenPago", vbCritical)
            '              Exit Function
            '          End If

            '          If Not IsNumeric(dcfields(10).BoundText) Or Len(dcfields(10).Text) = 0 Then
            '              MsgBox("No ha ingresado el punto de venta", vbCritical)
            '              Exit Function
            '          End If




            '.Tipo = OrdenPago.tipoOrdenPago.CC
            If .Tipo = OrdenPago.tipoOP.CC And (.DetallesImputaciones.Count = eliminados Or .DetallesImputaciones.Count = 0) Then
                ms = "La lista de items no puede estar vacía"
                Return False
            End If

            If Val(.NumeroOrdenPago) = 0 Then
                ms = "Debe ingresar el numero de orden de compra del cliente"
                Return False
            End If


            If .Tipo = OrdenPago.tipoOP.CC Then
                If .TotalDiferencia <> 0 Then 'OrdenPago.tipoOrdenPago.OT Then
                    ms = "La Orden de pago no cierra, ajuste los valores e intente nuevamente"
                    Return False
                End If
            Else
                'verificar que si es FF tenga items en gastos, y si es OT tenga items en anticipos:
                '  If Val(txtDif.Text) <> 0 And _
                'Not (Option2.Value And ItemsDeGastosMarcados = 0) And _
                'Not (Option3.Value And ListaAnticipos.ListItems.Count = 0) Then
                '      MsgBox("La Orden de Pago no cierra, ajuste los valores e intente nuevamente", vbCritical)
                '      Exit Function
                '  End If
            End If



            If Math.Round(.TotalDebe, 2) <> Math.Round(.TotalHaber, 2) Then
                ms = "No balancea el registro contable"
                Return False
            End If

            '          If Lista.ListItems.Count = 0 And Not Option2.Value Then
            '              MsgBox("No se puede almacenar un OrdenPago sin detalles")
            '              Exit Function
            '          End If

            '          If Len(txtCotizacionMoneda.Text) = 0 Then
            '              MsgBox("No ingreso el valor de conversion a pesos", vbInformation)
            '              Exit Function
            '          End If

            '          If Val(txtCotizacionMoneda.Text) <= 0 Then
            '              MsgBox("La cotizacion debe ser mayor a cero", vbInformation)
            '              Exit Function
            '          End If

            '          If mvarCotizacion = 0 Then
            '              MsgBox("No hay cotizacion dolar al " & DTFields(0).Value, vbInformation)
            '              Exit Function
            '          End If

            '          If txtNumeroCertificadoRetencionGanancias.Visible Then
            '              If Len(txtNumeroCertificadoRetencionGanancias.Text) > 0 And Not IsNumeric(dcfields1(3).BoundText) Then
            '                  MsgBox("Debe indicar el tipo de retencion ganancias")
            '                  Exit Function
            '              End If
            '          End If

            '          If Option2.Value And Len(Combo1(0).Text) = 0 Then
            '              MsgBox("Debe indicar el tipo de operacion", vbInformation)
            '              Exit Function
            '          End If

            '          If mvarId > 0 Then
            '              If ExistenAnticiposAplicados() Then
            '                  MsgBox("Hay anticipos que en cuenta corriente tienen aplicado el saldo" & vbCrLf & _
            '                        "No puede modificar este OrdenPago", vbInformation)
            '                  Exit Function
            '              End If
            '          End If

            '          If mvarControlarRubrosContablesEnOP = "SI" Then
            '              If mvarTotalValores <> mvarTotalRubrosContables And _
            '                    (Not Combo1(0).Visible Or (Combo1(0).Visible And Combo1(0).ListIndex = 1)) Then
            '                  MsgBox("El total de rubros contables asignados debe ser igual al total de valores", vbExclamation)
            '                  Exit Function
            '              End If
            '          End If

            '          If Option1.Value Then
            '              If EstadoEntidad("Clientes", origen.Registro.Fields("IdCliente").Value) = "INACTIVO" Then
            '                  MsgBox("Cliente inhabilitado", vbExclamation)
            '                  Exit Function
            '              End If
            '          End If

            '          If ListaCta.ListItems.Count = 0 Then
            '              MsgBox("No hay registro contable, revise la definicion de cuentas utilizadas en este OrdenPago.", vbExclamation)
            '              Exit Function
            '          End If

            '          If Not (mvarId <= 0 And mNumeroOrdenPagoPagoAutomatico = "SI") Then
            '              oRs = Aplicacion.OrdenPagos.TraerFiltrado("Cod", Array(dcfields(10).Text, Val(txtNumeroOrdenPago.Text)))
            '              If oRs.RecordCount > 0 Then
            '                  If oRs.Fields("IdOrdenPago").Value <> mvarId Then
            '                      MsgBox("Numero de OrdenPago existente ( " & oRs.Fields("FechaOrdenPago").Value & " )", vbCritical)
            '                      oRs.Close()
            '                      oRs = Nothing
            '                      Exit Function
            '                  End If
            '              End If
            '              oRs.Close()
            '          End If

            '          oRs = origen.DetOrdenPagosCuentas.TodosLosRegistros
            '          If oRs.Fields.Count > 0 Then
            '              If oRs.RecordCount > 0 Then
            '                  oRs.MoveFirst()
            '                  Do While Not oRs.EOF
            '                      If Not oRs.Fields("Eliminado").Value Then
            '                          If IIf(IsNull(oRs.Fields("IdCuenta").Value), 0, oRs.Fields("IdCuenta").Value) = 0 Then
            '                              oRs = Nothing
            '                              MsgBox("Hay cuentas contables no definidas, no puede registrar el OrdenPago", vbExclamation)
            '                              Exit Function
            '                          End If
            '                      End If
            '                      oRs.MoveNext()
            '                  Loop
            '              End If
            '          End If
            '          oRs = Nothing

            '          Dim dc As DataCombo
            '          Dim dtp As DTPicker
            '          Dim est As EnumAcciones
            '          Dim i As Integer
            '          Dim mAux1 As String

            '          If mvarId > 0 Then
            '              oRs = Aplicacion.OrdenPagos.TraerFiltrado("_ValoresEnConciliacionesPorIdOrdenPago", mvarId)
            '              If oRs.RecordCount > 0 Then
            '                  mAux1 = ""
            '                  oRs.MoveFirst()
            '                  Do While Not oRs.EOF
            '                      mAux1 = mAux1 & IIf(IsNull(oRs.Fields("Numero").Value), 0, oRs.Fields("Numero").Value) & " "
            '                      oRs.MoveNext()
            '                  Loop
            '                  MsgBox("Cuidado, hay valores en este OrdenPago que estan en" & vbCrLf & _
            '                        "la(s) conciliacion(es) : " & mAux1 & vbCrLf & _
            '                        "tome las precauciones del caso." & vbCrLf & _
            '                        "El mensaje es solo informativo.", vbExclamation)
            '              End If
            '              oRs.Close()
            '          End If

            '          oRs = Nothing

            '          With origen.Registro
            '              .Fields("NumeroOrdenPago").Value = Val(txtNumeroOrdenPago.Text)
            '              .Fields("PuntoVenta").Value = IIf(Len(dcfields(10).Text) > 0, Val(dcfields(10).Text), 1)
            '              .Fields("Cotizacion").Value = mvarCotizacion
            '              If IsNull(.Fields("Efectivo").Value) Then
            '                  .Fields("Efectivo").Value = 0
            '              End If
            '              If IsNull(.Fields("Valores").Value) Then
            '                  .Fields("Valores").Value = 0
            '              End If
            '              If IsNull(.Fields("Documentos").Value) Then
            '                  .Fields("Documentos").Value = 0
            '              End If
            '              If IsNull(.Fields("RetencionGanancias").Value) Then
            '                  .Fields("RetencionGanancias").Value = 0
            '              End If
            '              If IsNull(.Fields("RetencionIBrutos").Value) Then
            '                  .Fields("RetencionIBrutos").Value = 0
            '              End If
            '              If IsNull(.Fields("RetencionIVA").Value) Then
            '                  .Fields("RetencionIVA").Value = 0
            '              End If
            '              If IsNull(.Fields("GastosGenerales").Value) Then
            '                  .Fields("GastosGenerales").Value = 0
            '              End If

            '              If Check1.Value = 1 Then
            '                  .Fields("Dolarizada").Value = "SI"
            '              Else
            '                  .Fields("Dolarizada").Value = "NO"
            '              End If

            '              For Each dtp In DTFields
            '                  .Fields(dtp.DataField).Value = dtp.Value
            '              Next

            '              For Each dc In dcfields
            '                  If Len(Trim(dc.BoundText)) = 0 And dc.Index <> 3 And _
            '                        dc.Index <> 4 And dc.Index <> 5 And dc.Index <> 8 And dc.Index <> 10 And _
            '                        dc.Visible Then
            '                      MsgBox("Falta completar el campo " & dc.Tag, vbCritical)
            '                      Exit Function
            '                  End If
            '                  If IsNumeric(dc.BoundText) Then .Fields(dc.DataField).Value = dc.BoundText
            '              Next

            '              If Option1.Value Then
            '                  .Fields("Tipo").Value = "CC"
            '              Else
            '                  .Fields("Tipo").Value = "OT"
            '              End If

            '              If Check3.Value = 1 Then
            '                  .Fields("AsientoManual").Value = "SI"
            '              Else
            '                  .Fields("AsientoManual").Value = "NO"
            '              End If

            '              .Fields("CotizacionMoneda").Value = txtCotizacionMoneda.Text

            '              If mvarId < 0 Then
            '                  .Fields("IdUsuarioIngreso").Value = glbIdUsuario
            '                  .Fields("FechaIngreso").Value = Now
            '              Else
            '                  .Fields("IdUsuarioModifico").Value = glbIdUsuario
            '                  .Fields("FechaModifico").Value = Now
            '              End If

            '              .Fields("Observaciones").Value = rchObservaciones.Text

            '              If Option2.Value Then
            '                  .Fields("TipoOperacionOtros").Value = Combo1(0).ListIndex
            '              Else
            '                  .Fields("TipoOperacionOtros").Value = Null
            '              End If

            '              .Fields("CuitOpcional").Value = Null
            '              If CUIT1.Visible Then .Fields("CuitOpcional").Value = CUIT1.Text
            '          End With

            '          If mvarId < 0 Then
            '              Dim mvarNumero As Long
            '              Dim oPar 'As ComPronto.Parametro 

            '              mvarNumero = origen.Registro.Fields("NumeroOrdenPago").Value

            '              oPar = Aplicacion.Parametros.Item(1)
            '              With oPar.Registro
            '                  If IsNull(.Fields("NumeroOrdenPagoPagoAutomatico").Value) Or .Fields("NumeroOrdenPagoPagoAutomatico").Value = "SI" Then
            '                  Else
            '                      oPar = Nothing
            '                      oRs = Aplicacion.OrdenPagos.TraerFiltrado("_PorIdPuntoVenta_Numero", Array(dcfields(10).BoundText, mvarNumero))
            '                      If oRs.RecordCount > 0 Then
            '                          oRs.Close()
            '                          MsgBox("El OrdenPago ya existe, verifique el numero")
            '                          Exit Function
            '                      End If
            '                      oRs.Close()
            '                  End If
            '              End With
            '              oPar = Nothing
            '          End If

        End With



        Return True
    End Function





    ''' <summary>
    ''' ' OJO: es el numero, no el ID del punto de venta. El OrdenPago es letra X, no necesita el IdCodigoIVA
    ''' </summary>
    ''' <param name="SC"></param>
    ''' <param name="NumeroDePuntoVenta"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Public Shared Function ProximoNumeroOrdenPagoPorNumeroDePuntoVenta(ByVal SC As String, ByRef oOP As OrdenPago) As Long

        Try
            ' la letra del OrdenPago de pago es X

            'averiguo el id del talonario 
            'Dim IdPuntoVenta = IdPuntoVentaComprobanteOrdenPagoSegunSubnumero(SC, NumeroDePuntoVenta)

            With oOP
                If .Exterior = "SI" Then
                    Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoExterior")
                Else

                    If .Tipo = OrdenPago.tipoOP.CC Then
                        Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPago")
                    ElseIf .Tipo = OrdenPago.tipoOP.FF Then
                        Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoFF")
                    ElseIf .Tipo = OrdenPago.tipoOP.OT Then
                        Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoOtros")
                    Else
                        Return TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPago")
                        'Err.Raise(3233, , "Falta el tipo de la OP para asignarle el talonario correspondiente")
                    End If


                End If
            End With

            'Dim oPto = EntidadManager.GetItem(SC, "PuntosVenta", IdPuntoVenta)
            'Return oPto.Item("ProximoNumero")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return -1
        End Try

    End Function

    Shared Function IdPuntoVentaComprobanteOrdenPagoSegunSubnumero(ByVal sc As String, ByVal NumeroDePuntoVenta As Integer) As Long
        Dim mvarPuntoVenta = EntidadManager.TablaSelectId(sc, "PuntosVenta", "PuntoVenta=" & NumeroDePuntoVenta & " AND Letra='X' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.OrdenPago)
        Return mvarPuntoVenta
    End Function

    Public Shared Function UltimoItemDetalle(ByVal SC As String, ByVal IdOrdenPago As Long) As Integer

        Dim oRs As adodb.Recordset
        Dim UltItem As Integer



        oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "DetOrdenPagos", "TX_Req", IdOrdenPago))

        If oRs.RecordCount = 0 Then
            UltItem = 0
        Else
            oRs.MoveLast()
            UltItem = IIf(IsNull(oRs.Fields("Item").Value), 0, oRs.Fields("Item").Value)
        End If

        oRs.Close()

        'oRs = Registros

        If oRs.Fields.Count > 0 Then
            If oRs.RecordCount > 0 Then
                oRs.MoveFirst()
                While Not oRs.EOF
                    If Not oRs.Fields("Eliminado").Value Then
                        If oRs.Fields("NumeroItem").Value > UltItem Then
                            UltItem = oRs.Fields("NumeroItem").Value
                        End If
                    End If
                    oRs.MoveNext()
                End While
            End If
        End If

        oRs = Nothing

        UltimoItemDetalle = UltItem + 1

    End Function

    Public Shared Function UltimoItemDetalle(ByVal myOrdenPago As OrdenPago) As Integer

        For Each i As OrdenPagoItem In myOrdenPago.DetallesImputaciones
            'If UltimoItemDetalle < i.NumeroItem And Not i.Eliminado Then UltimoItemDetalle = i.NumeroItem
        Next

    End Function


    Public Shared Sub RefrescaTalonarioIVA(ByRef myOrdenPago As OrdenPago)
        'myOrdenPago.letra=

        ' If glbIdCodigoIva = 1 Then
        '     Select Case mvarTipoIVA
        '         Case 1
        '             mvarTipoABC = "A"
        '             mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
        '         Case 2
        '             mvarTipoABC = "A"
        '             mvarIVA1 = Round(TSumaGravado * Val(txtPorcentajeIva1.Text) / 100, mvarDecimales)
        '             mvarIVA2 = Round(TSumaGravado * Val(txtPorcentajeIva2.Text) / 100, mvarDecimales)
        '         Case 3
        '             mvarTipoABC = "E"
        '         Case 8
        '             mvarTipoABC = "B"
        '         Case 9
        '             mvarTipoABC = "A"
        '         Case Else
        '             mvarTipoABC = "B"
        '     End Select
        ' Else
        '     mvarTipoABC = "C"
        ' End If

        'If .ctacte = 2 Then
        '    txtNumeroOrdenPago2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaOrdenPagoInterna")
        'Else
        '    txtNumeroOrdenPago2.Text = OrdenPagoManager.ProximoNumeroOrdenPagoPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.Text) 'ParametroOriginal(SC, "ProximoFactura")
        'End If
    End Sub





    Public Function GuardarRegistroContable(ByVal RegistroContable As adodb.Recordset)

        Dim oCont ' As ObjectContext
        Dim oDet 'As iCompMTS
        Dim Resp 'As InterFazMTS.MisEstados
        Dim oRsComprobante As adodb.Recordset
        Dim Datos As adodb.Recordset
        Dim DatosAsiento As adodb.Recordset
        Dim DatosAsientoNv As adodb.Recordset
        Dim oRsParametros As adodb.Recordset
        Dim DatosDetAsiento As adodb.Recordset
        Dim DatosDetAsientoNv As adodb.Recordset
        Dim oFld As adodb.Field
        Dim lErr As Long, sSource As String, sDesc As String
        Dim i As Integer
        Dim mvarNumeroAsiento As Long, mvarIdAsiento As Long, mvarIdCuenta As Long
        Dim mvarCotizacionMoneda As Double, mvarDebe As Double, mvarHaber As Double

        On Error GoTo Mal

        'oCont = GetObjectContext

        'oDet = ClaseMigrar.ProntoFuncionesGeneralesCOMPRONTO.CrearMTSpronto

        mvarCotizacionMoneda = 0
        mvarDebe = 0
        mvarHaber = 0

        'With RegistroContable
        '    If .State <> adStateClosed Then
        '        If .RecordCount > 0 Then
        '            .Update()
        '            .MoveFirst()
        '            oRsComprobante = oDet.LeerUno("OrdenPagos", RegistroContable.Fields("IdComprobante").Value)
        '            mvarCotizacionMoneda = oRsComprobante.Fields("CotizacionMoneda").Value
        '            oRsComprobante.Close()
        '            oRsComprobante = Nothing
        '        End If
        '        Do While Not .EOF
        '            If Not IsNull(.Fields("Debe").Value) Then
        '                .Fields("Debe").Value = .Fields("Debe").Value * mvarCotizacionMoneda
        '                .Update()
        '                mvarDebe = mvarDebe + .Fields("Debe").Value
        '            End If
        '            If Not IsNull(.Fields("Haber").Value) Then
        '                .Fields("Haber").Value = .Fields("Haber").Value * mvarCotizacionMoneda
        '                .Update()
        '                mvarHaber = mvarHaber + .Fields("Haber").Value
        '            End If
        '            .MoveNext()
        '        Loop
        '        If .RecordCount > 0 Then
        '            .MoveFirst()
        '            If mvarDebe - mvarHaber <> 0 Then
        '                If Not IsNull(.Fields("Debe").Value) Then
        '                    .Fields("Debe").Value = .Fields("Debe").Value - Round(mvarDebe - mvarHaber, 2)
        '                Else
        '                    .Fields("Haber").Value = .Fields("Haber").Value + Round(mvarDebe - mvarHaber, 2)
        '                End If
        '            End If
        '        End If
        '        Do While Not .EOF
        '            Datos = CreateObject("adodb.Recordset")
        '            For i = 0 To .Fields.Count - 1
        '                With .Fields(i)
        '                    Datos.Fields.Append.Name, .Type, .DefinedSize, .Attributes
        '                    Datos.Fields(.Name).Precision = .Precision
        '                    Datos.Fields(.Name).NumericScale = .NumericScale
        '                End With
        '            Next
        '            Datos.Open()
        '            Datos.AddNew()
        '            For i = 0 To .Fields.Count - 1
        '                With .Fields(i)
        '                    Datos.Fields(i).Value = .Value
        '                End With
        '            Next
        '            Datos.Update()
        '            Resp = oDet.Guardar("Subdiarios", Datos)
        '            Datos.Close()
        '            Datos = Nothing
        '            .MoveNext()
        '        Loop
        '    End If
        'End With

        If Not oCont Is Nothing Then
            With oCont
                If .IsInTransaction Then .SetComplete()
            End With
        End If

Salir:
        GuardarRegistroContable = Resp
        oDet = Nothing
        oCont = Nothing
        On Error GoTo 0
        If lErr Then
            Err.Raise(lErr, sSource, sDesc)
        End If
        Exit Function

Mal:
        If Not oCont Is Nothing Then
            With oCont
                If .IsInTransaction Then .SetAbort()
            End With
        End If
        With Err()
            lErr = .Number
            sSource = .Source
            sDesc = .Description
        End With
        Resume Salir

    End Function



    'Public Shared Function RecalcularRegistroContable(ByVal SC As String, ByRef OrdenPago As OrdenPago) As DataTable

    '    Dim oRsCont As DataTable
    '    Dim mvarEjercicio As Long, mvarCuentaCajaTitulo As Long
    '    Dim mvarCuentaClienteMonedaLocal As Long, mvarCuentaClienteMonedaExtranjera As Long
    '    Dim mvarCliente As Double
    '    Dim mvarCuentaCliente As Long

    '    IsValid(SC, OrdenPago) 'para marcar los vacios

    '    mvarCuentaClienteMonedaLocal = 0
    '    mvarCuentaClienteMonedaExtranjera = 0
    '    mvarCliente = 0

    '    With OrdenPago

    '        '//////////////////////////////////
    '        'no sé qué hace con el cliente 
    '        '-Dependiendo si el OrdenPago es a Cliente o a Cuenta, asigna las cuentas de moneda
    '        '//////////////////////////////////

    '        If Not IsNull(.IdCliente) And .IdCliente > 0 And .Tipo = BO.OrdenPago.tipoOrdenPago.CC Then
    '            'OrdenPago normal a Cliente

    '            Dim oCli = ClienteManager.GetItem(SC, .IdCliente)
    '            mvarCuentaCliente = oCli.IdCuenta
    '            mvarCuentaClienteMonedaLocal = oCli.IdCuenta
    '            If Not oCli.idcuentaMonedaExt Then
    '                mvarCuentaClienteMonedaExtranjera = oCli.idcuentaMonedaExt
    '            End If

    '        Else
    '            'OrdenPago a Cuentas

    '            mvarCuentaCliente = .IdCuenta
    '            mvarCuentaClienteMonedaLocal = .IdCuenta
    '        End If

    '        '//////////////////////////////////
    '        '//////////////////////////////////




    '        '//////////////////////////////////
    '        'trae el formato de un subdiario
    '        '//////////////////////////////////

    '        oRsCont = EntidadManager.GetListTX(SC, "Subdiarios", "TX_Estructura").Tables(0)

    '        oRsCont.Rows.Clear()


    '        If Not IsNull(.AsientoManual) And .AsientoManual = "SI" Then

    '            'Recalculo de edicion manual

    '            For Each i As OrdenPagoCuentasItem In .DetallesCuentas
    '                If i.Eliminado Then Continue For

    '                With oRsCont
    '                    Dim dr = .NewRow()
    '                    With dr

    '                        .item("Ejercicio") = mvarEjercicio
    '                        .item("IdCuentaSubdiario") = mvarCuentaCajaTitulo
    '                        .item("IdCuenta") = i.IdCuenta
    '                        .item("IdTipoComprobante") = 2
    '                        .Item("NumeroComprobante") = OrdenPago.NumeroOrdenPago
    '                        .Item("FechaComprobante") = OrdenPago.FechaOrdenPago
    '                        .item("IdComprobante") = OrdenPago.Id
    '                        If Not IsNull(i.Debe) Then
    '                            .item("Debe") = i.Debe
    '                        End If
    '                        If Not IsNull(i.Haber) Then
    '                            .item("Haber") = i.Haber
    '                        End If
    '                        .Item("IdMoneda") = OrdenPago.IdMoneda
    '                        .Item("CotizacionMoneda") = OrdenPago.CotizacionMoneda

    '                    End With
    '                    .Rows.Add(dr)
    '                End With
    '            Next

    '        Else

    '            'recalculo automatico, aplica restricciones

    '            RecalcularRegistroContable_SubRecalculoAutomatico(SC, OrdenPago, oRsCont, mvarCliente, mvarCuentaClienteMonedaLocal, mvarCuentaClienteMonedaExtranjera, mvarEjercicio, mvarCuentaCajaTitulo, mvarCuentaCliente)
    '        End If


    '    End With
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////
    '    '/////////////////////////////////////////////////////////////////////////////






    '    Return oRsCont


    'End Function














    Public Shared Sub RecalcularTotales(ByVal sc As String, ByRef myOrdenPago As OrdenPago, Optional ByVal bRecalcularRetenciones As Boolean = True)

        Dim mvarSubTotal, mvarIVA1 As Single

        With myOrdenPago


            RefrescaTalonarioIVA(myOrdenPago)

            If bRecalcularRetenciones Then
                Try
                    CalcularRetencionGanancias(sc, myOrdenPago)
                    CalcularRetencionIVA(sc, myOrdenPago)
                    CalcularRetencionIngresosBrutos(sc, myOrdenPago)
                    CalcularRetencionSUSS(sc, myOrdenPago)

                Catch ex As Exception

                End Try
            End If




            Dim i As Integer
            Dim oRs As adodb.Recordset

            myOrdenPago.TotalImputaciones = 0
            myOrdenPago.TotalDebe = 0
            myOrdenPago.TotalHaber = 0
            myOrdenPago.TotalValores = 0
            myOrdenPago.TotalRubrosContables = 0
            myOrdenPago.TotalOtrosConceptos = 0
            myOrdenPago.TotalAnticipos = 0




            If .Tipo <> OrdenPago.tipoOP.OT Then ' .Tipo = "CC" Then ' "CC" Then ' OrdenPago.tipoOrdenPago.CC Then
                'tipo de OrdenPago: cliente
                For Each det As OrdenPagoItem In .DetallesImputaciones

                    With det
                        If .Eliminado Then Continue For
                        myOrdenPago.TotalImputaciones += .Importe
                    End With
                Next

            ElseIf .Tipo = OrdenPago.tipoOP.OT Then 'OrdenPago.tipoOrdenPago.OT Then
                'tipo de OrdenPago: otros
                For Each det As OrdenPagoAnticiposAlPersonalItem In .DetallesAnticiposAlPersonal
                    With det
                        If .Eliminado Then Continue For
                        myOrdenPago.TotalAnticipos += .ImporteTotalItem
                    End With
                Next
            End If



            For Each det As OrdenPagoValoresItem In .DetallesValores
                With det
                    If .Eliminado Then Continue For
                    myOrdenPago.TotalValores += .Importe
                End With
            Next


            For Each det As OrdenPagoCuentasItem In .DetallesCuentas
                With det

                    If .Eliminado Then Continue For

                    myOrdenPago.TotalDebe += .Debe


                    myOrdenPago.TotalHaber += .Haber

                End With
            Next



            For Each det As OrdenPagoRubrosContablesItem In .DetallesRubrosContables
                With det
                    If .Eliminado Then Continue For

                    myOrdenPago.TotalRubrosContables += .Importe
                End With
            Next



            '.TotalOtrosConceptos = .Otros1 + .Otros2 + .Otros3 + .Otros4 + .Otros5 + _
            '.Otros6(+.Otros7 + .Otros8 + .Otros9 + .Otros10)


            'With origen.Registro
            '    For i = 1 To 10
            '        mvarTotalOtrosConceptos = mvarTotalOtrosConceptos + _
            '              IIf(IsNull(.Fields("Otros" & i).Value), 0, .Fields("Otros" & i).Value)
            '    Next
            'End With



            .TotalDiferencia = Math.Round(.TotalImputaciones + .TotalGastos + .TotalAnticipos, 2) _
            - Math.Round(.TotalOPcomplementaria + .TotalValores + .Efectivo + .RetencionIVA _
                            + .RetencionGanancias + .RetencionIBrutos + .RetencionSUSS + .TotalOtrosConceptos + .Descuentos, 2)



            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////
            '///////////////////////////////////////////////////////////////////////////////////






        End With
    End Sub

    Sub refrescar()
        '    RefrescarNumeroTalonario()
        '    refrescartotales()
        '    refrescarRegistroContable()
    End Sub


    Public Shared Sub AgregarImputacionSinAplicacionOPagoAnticipado(ByVal sc As String, ByRef myOrdenPago As OrdenPago)

        With myOrdenPago
            'If mvarId > 0 Then
            '    MsgBox("No puede modificar una nota de credito ya registrada!", vbCritical)
            '    Exit Sub
            'End If

            'If Len(Trim(dcfields(0).BoundText)) = 0 Then
            '    MsgBox("Falta completar el campo cliente", vbCritical)
            '    Exit Sub
            'End If

            'If Len(Trim(txtNumeroNotaCredito.Text)) = 0 Then
            '    MsgBox("Falta completar el campo numero de nota de credito", vbCritical)
            '    Exit Sub
            'End If


            Dim oRs As adodb.Recordset
            Dim mvarDif As Double

            RecalcularTotales(sc, myOrdenPago)
            mvarDif = Math.Round(.TotalValores - .TotalImputaciones, 2)

            If mvarDif > 0 Then
                Dim mItemImp As OrdenPagoItem = New OrdenPagoItem
                mItemImp.Id = -1
                mItemImp.Nuevo = True
                mItemImp.IdImputacion = -1
                mItemImp.ComprobanteImputadoNumeroConDescripcionCompleta = "PA"

                mItemImp.IdTipoRetencionGanancia = ProveedorManager.GetItem(sc, myOrdenPago.IdProveedor).IdTipoRetencionGanancia
                mItemImp.Importe = mvarDif
                mvarDif = 0
                .DetallesImputaciones.Add(mItemImp)
            End If

            RecalcularTotales(sc, myOrdenPago)
        End With
    End Sub


    Public Shared Function FaltanteDePagar(ByVal sc As String, ByRef myOrdenPago As OrdenPago) As Double

        With myOrdenPago
            Dim mvarDif As Double

            RecalcularTotales(sc, myOrdenPago)
            mvarDif = .TotalDiferencia ' .DiferenciaBalanceo ' Math.Round(.TotalImputaciones - .TotalValores, 2)
            If mvarDif < 0 Then mvarDif = 0
            Return mvarDif

        End With
    End Function




    Public Shared Sub CalcularRetencionGanancias(ByVal SC As String, ByRef oOP As OrdenPago)

        Dim mvarImpuesto As Double
        Dim i As Integer

        Dim oRs As adodb.Recordset

        Dim mvarTotalBaseGanancias = 0
        mvarImpuesto = 0

        'If mvarRetenerGanancias And IsNumeric(origen.Registro.Fields("IdProveedor").Value) And Check2.Value = 0 Then
        If oOP.IdProveedor > 0 Then


            RecalcularImpuestos(SC, oOP)

            For Each oL In oOP.DetallesImpuestos
                If oL.TipoImpuesto = "Ganancias" Then

                    'If Val(oL.SubItems(3)) <> 0 Then
                    mvarTotalBaseGanancias = mvarTotalBaseGanancias + oL.ImporteTotalItem 'Val(oL.SubItems(3))
                    'End If

                    ' If Val(oL.SubItems(4)) <> 0 Then
                    mvarImpuesto = mvarImpuesto + oL.ImpuestoRetenido  'Retenido ' Val(oL.SubItems(4))
                    'End If

                End If
            Next

            oOP.RetencionGanancias = mvarImpuesto

            'If mvarId <= 0 Or Check6.Value = 1 Then
            '    origen.Registro.Fields("RetencionGanancias").Value = mvarImpuesto
            'End If


        Else
            'origen.DetOrdenesPagoImpuestos.BorrarRegistrosPorImpuesto("Ganancias")
            'oRs = origen.DetOrdenesPagoImpuestos.RegistrosConFormato
            'If oRs.RecordCount > 0 Then
            '    ListaImpuestos.DataSource = oRs
            'Else
            '    ListaImpuestos.ListItems.Clear()
            'End If
            'oRs = Nothing
            'ListaImpuestos.Refresh()
        End If

    End Sub


    Sub CodigoVB6conDeclaracionDeVariablesGlobalesDeOrdenDePago()


        'Dim mvarId As Long, mvarIdProveedor As Long, mIGCondicionExcepcion As Long
        'Dim mvarTipoIVA As Integer, mvarIdTipoCuentaGrupoAnticiposAlPersonal As Integer, mvarIdTipoComprobanteNDInternaAcreedores As Integer
        'Dim mvarIdTipoComprobanteNCInternaAcreedores As Integer, mvarCodigoSituacionRetencionIVA As Integer
        'Dim mvarIdImpuestoDirectoSUSS As Integer, mvarIdMonedaPesos As Integer, mvarIdMonedaDolar As Integer, mvarIdMonedaEuro As Integer
        'Dim mvarTotalImputaciones As Double, mvarTotalDebe As Double, mvarTotalHaber As Double, mvarTotalValores As Double
        'Dim mvarTotalGastos As Double, mvarCotizacion As Double, mvarCotizacionEuro As Double, mvarTotalPagoSinRetencion As Double
        'Dim mvarTotalBaseGanancias As Double, mvarDiferenciaBalanceo As Double, mvarExceptuadoRetencionIVA As Double
        'Dim mvarImporteTotalMinimoAplicacionRetencionIVA As Double, mvarImporteMinimoRetencionIVA As Double
        'Dim mvarTotalAnticipos As Double, mvarImporteMinimoRetencionIVAServicios As Double, mvarBaseCalculoSUSS As Double
        'Dim mvarTotalRubrosContables As Double, mvarImporteComprobantesMParaRetencionIVA As Double
        'Dim mvarImporteMinimoBaseRetencionSUSS As Double, mvarTopeMinimoRetencionIVA As Double, mvarTopeMinimoRetencionIVAServicios As Double
        'Dim mvarPorcentajeBaseRetencionIVABienes As Single, mvarPorcentajeBaseRetencionIVAServicios As Single
        'Dim mvarPorcentajeRetencionSUSS As Single, mvarPorcentajeRetencionSUSS1 As Single, mvarPorcentajeRetencionIVAComprobantesM As Single
        'Dim mControlLoop As Boolean, mvarGrabado As Boolean, mvarRetenerGanancias As Boolean, mvarAnuloValor As Boolean
        'Dim mvarOP_AnticiposAlPersonal As Boolean, mvarRetenerIIBB As Boolean, mvarControlCheck As Boolean, mvarPrimeraVez As Boolean
        'Dim mvarAgenteRetencionIVA As String, mvarAgenteRetencionSUSS As String, mvarAnulada As String, mvarRetenerSUSSAProveedor As String
        'Dim mPrinterSeleccionada As String, mvarControlarRubrosContablesEnOP As String, mvarAgenteRetencionIIBB As String
        'Dim mRegimenEspecialConstruccionIIBB As String
        'Dim mvarSUSSFechaCaducidadExencion As Date

        'mvarExceptuadoRetencionIVA = 0
        'mvarTipoIVA = 0
        'mvarCodigoSituacionRetencionIVA = 0
        ''            mvarOP_AnticiposAlPersonal = False


        'oRs = Aplicacion.Proveedores.TraerFiltrado("_PorId", dcfields(Index).BoundText)

        'If Not IsNull(oRs.Fields("IdCodigoIva").Value) Then
        '    mvarTipoIVA = oRs.Fields("IdCodigoIva").Value
        'End If
        'If Not IsNull(oRs.Fields("IvaExencionRetencion").Value) And oRs.Fields("IvaExencionRetencion").Value = "SI" Then
        '    mvarExceptuadoRetencionIVA = 100
        'Else
        '    If IsNull(oRs.Fields("IvaFechaInicioExencion").Value) Or _
        '          oRs.Fields("IvaFechaInicioExencion").Value <= DTFields(0).Value Then
        '        If Not IsNull(oRs.Fields("IvaFechaCaducidadExencion").Value) And _
        '              oRs.Fields("IvaFechaCaducidadExencion").Value >= DTFields(0).Value Then
        '            If Not IsNull(oRs.Fields("IvaPorcentajeExencion").Value) Then
        '                mvarExceptuadoRetencionIVA = oRs.Fields("IvaPorcentajeExencion").Value
        '            End If
        '        End If
        '    End If
        'End If

        'If Not IsNull(oRs.Fields("CodigoSituacionRetencionIVA").Value) Then
        '    mvarCodigoSituacionRetencionIVA = Val(oRs.Fields("CodigoSituacionRetencionIVA").Value)
        'End If

        'mRegimenEspecialConstruccionIIBB = ""
        'If Not IsNull(oRs.Fields("RegimenEspecialConstruccionIIBB").Value) Then
        '    mRegimenEspecialConstruccionIIBB = oRs.Fields("RegimenEspecialConstruccionIIBB").Value
        'End If

        'If IsNull(oRs.Fields("IBCondicion").Value) Or oRs.Fields("IBCondicion").Value = 4 Then
        '    mvarRetenerIIBB = False
        'ElseIf oRs.Fields("IBCondicion").Value = 1 And _
        '      (IsNull(oRs.Fields("FechaLimiteExentoIIBB").Value) Or oRs.Fields("FechaLimiteExentoIIBB").Value >= DTFields(0).Value) Then
        '    mvarRetenerIIBB = False
        'Else
        '    mvarRetenerIIBB = True
        'End If

        '   mvarSUSSFechaCaducidadExencion = IIf(IsNull(oRs.Fields("SUSSFechaCaducidadExencion").Value), Date, oRs.Fields("SUSSFechaCaducidadExencion").Value)

        'mvarIdImpuestoDirectoSUSS = 0
        'If Not IsNull(oRs.Fields("RetenerSUSS").Value) Then
        '    mvarRetenerSUSSAProveedor = IIf(IsNull(oRs.Fields("RetenerSUSS").Value), "NO", oRs.Fields("RetenerSUSS").Value)
        '    If mvarRetenerSUSSAProveedor = "SI" And Not Check5.Enabled Then
        '        With Check5
        '            .Enabled = True
        '            .Value = 1
        '        End With
        '    End If
        '    mvarPorcentajeRetencionSUSS1 = 0
        '    mvarImporteMinimoBaseRetencionSUSS = 0
        '    If Not IsNull(oRs.Fields("IdImpuestoDirectoSUSS").Value) Then
        '        mvarIdImpuestoDirectoSUSS = oRs.Fields("IdImpuestoDirectoSUSS").Value
        '        oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", oRs.Fields("IdImpuestoDirectoSUSS").Value)
        '        If oRsAux.RecordCount > 0 Then
        '            mvarPorcentajeRetencionSUSS1 = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
        '            mvarImporteMinimoBaseRetencionSUSS = IIf(IsNull(oRsAux.Fields("BaseMinima").Value), 0, oRsAux.Fields("BaseMinima").Value)
        '        End If
        '        oRsAux.Close()
        '        oRsAux = Nothing
        '    Else
        '        mvarPorcentajeRetencionSUSS1 = -1
        '    End If
        'Else
        '    mvarRetenerSUSSAProveedor = "NO"
        'End If

        'If Not IsNull(oRs.Fields("IGCondicion").Value) Then
        '    If oRs.Fields("IGCondicion").Value = mIGCondicionExcepcion And _
        '          (IsNull(oRs.Fields("FechaLimiteExentoGanancias").Value) Or _
        '           oRs.Fields("FechaLimiteExentoGanancias").Value >= DTFields(0).Value) Then
        '        '                     cmd(6).Visible = False
        '        cmd(7).Visible = False
        '        '                     lblRetencion(0).Visible = False
        '        '                     txtBaseGanancias.Visible = False
        '        origen.Registro.Fields("BaseGanancias").Value = Null
        '        mvarRetenerGanancias = False
        '    Else
        '        If IsNull(oRs.Fields("IdTipoRetencionGanancia").Value) Then
        '            MsgBox("El proveedor no tiene definido el tipo de retencion para ganancias!", vbExclamation)
        '            origen.Registro.Fields(dcfields(Index).DataField).Value = Null
        '            dcfields(Index).BoundText = ""
        '        Else
        '            '                        cmd(6).Visible = True
        '            cmd(7).Visible = True
        '            '                        lblRetencion(0).Visible = True
        '            '                        txtBaseGanancias.Visible = True
        '            If mvarId > 0 Then
        '                oRs.Close()
        '                oRs = origen.DetOrdenesPago.TodosLosRegistros
        '                If oRs.Fields.Count > 0 Then
        '                    If oRs.RecordCount > 0 Then
        '                        oRs.MoveFirst()
        '                        Do While Not oRs.EOF
        '                            origen.DetOrdenesPago.Item(oRs.Fields(0).Value).Modificado = True
        '                            oRs.MoveNext()
        '                        Loop
        '                    End If
        '                End If
        '            End If
        '            mvarRetenerGanancias = True
        '        End If
        '    End If
        'Else
        '    'MsgBox("El proveedor no tiene definida la categoria de retencion para ganancias!", vbExclamation)
        '    'origen.Registro.Fields(dcfields(Index).DataField).Value = Null
        '    'dcfields(Index).BoundText = ""
        'End If

        ''If oRs.State <> 0 Then oRs.Close()
        ''oRs = Nothing

        ''If IsNumeric(dcfields(Index).BoundText) Then
        ''    If EstadoEntidad("Proveedores", dcfields(Index).BoundText) = "INACTIVO" Then
        ''        MsgBox("Proveedor inhabilitado, no podra registrar este comprobante", vbExclamation)
        ''    End If
        ''End If

    End Sub





    Public Shared Sub CalcularRetencionIVA(ByVal SC As String, ByRef oOP As OrdenPago)



        '//////////////////////////////////////////////////////////
        'de tabla proveedores
        '//////////////////////////////////////////////////////////
        Dim oPrv = ProveedorManager.GetItem(SC, oOP.IdProveedor)
        Dim mvarTipoIVA = oPrv.IdCodigoIva

        Dim mvarExceptuadoRetencionIVA
        If Not IsNull(oPrv.IvaExencionRetencion) And oPrv.IvaExencionRetencion = "SI" Then
            mvarExceptuadoRetencionIVA = 100
        Else
            'If IsNull(oPrv.IvaFechaInicioExencion) Or oPrv.IvaFechaInicioExencion <= oOP.FechaOrdenPago Then
            If Not IsNull(oPrv.IvaFechaCaducidadExencion) And oPrv.IvaFechaCaducidadExencion >= oOP.FechaOrdenPago Then
                If Not IsNull(oPrv.IvaPorcentajeExencion) Then
                    mvarExceptuadoRetencionIVA = oPrv.IvaPorcentajeExencion
                End If
            End If
            'End If
        End If


        Dim mvarCodigoSituacionRetencionIVA = oPrv.CodigoSituacionRetencionIVA


        '//////////////////////////////////////////////////////////
        'de tabla parametros
        '//////////////////////////////////////////////////////////
        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginalClase(SC)

        Dim mvarAgenteRetencionIVA = iisNull(p.p(ePmOrg.AgenteRetencionIVA), "NO")
        Dim mvarTopeMinimoRetencionIVA = iisNull(p.p(ePmOrg.TopeMinimoRetencionIVA), 0)
        Dim mvarTopeMinimoRetencionIVAServicios = iisNull(p.p(ePmOrg.TopeMinimoRetencionIVAServicios), 0)
        Dim mvarImporteMinimoRetencionIVA = iisNull(p.p(ePmOrg.ImporteMinimoRetencionIVA), 0)
        Dim mvarImporteMinimoRetencionIVAServicios = iisNull(p.p(ePmOrg.ImporteMinimoRetencionIVAServicios), 0)
        Dim mvarPorcentajeBaseRetencionIVABienes = iisNull(p.p(ePmOrg.PorcentajeBaseRetencionIVABienes), 0)
        Dim mvarPorcentajeBaseRetencionIVAServicios = iisNull(p.p(ePmOrg.PorcentajeBaseRetencionIVAServicios), 0)
        Dim mvarImporteTotalMinimoAplicacionRetencionIVA = iisNull(p.p(ePmOrg.ImporteTotalMinimoAplicacionRetencionIVA), 0)
        Dim mvarImporteComprobantesMParaRetencionIVA = iisNull(p.p(ePmOrg.ImporteComprobantesMParaRetencionIVA), 0)
        Dim mvarPorcentajeRetencionIVAComprobantesM = iisNull(p.p(ePmOrg.PorcentajeRetencionIVAComprobantesM), 0)


        Dim glbTopeMonotributoAnual_Bienes = iisNull(TraerValorParametro2(SC, "TopeMonotributoAnual_Bienes"), 0)
        Dim glbTopeMonotributoAnual_Servicios = iisNull(TraerValorParametro2(SC, "TopeMonotributoAnual_Servicios"), 0)

        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////




        With oOP

            If .Id < 1 Then







                Dim mvarRetencionIVA As Double, mvarRetencionIVAComprobantesM As Double, mvarRetencionIVAIndividual As Double
                Dim mvarBase As Double, mvarBienesUltimoAño As Double, mvarServiciosUltimoAño As Double
                Dim oRs As adodb.Recordset

                mvarRetencionIVA = 0
                mvarRetencionIVAComprobantesM = 0
                mvarBienesUltimoAño = 0
                mvarServiciosUltimoAño = 0

                If mvarTipoIVA = 6 Then
                    oRs = TraerFiltradoVB6(SC, enumSPs.ComprobantesProveedores_TX_TotalBSUltimoAño, oOP.IdProveedor, oOP.FechaOrdenPago, 6)
                    If oRs.RecordCount > 0 Then
                        mvarBienesUltimoAño = IIf(IsNull(oRs.Fields("Importe_Bienes").Value), 0, oRs.Fields("Importe_Bienes").Value)
                        mvarServiciosUltimoAño = IIf(IsNull(oRs.Fields("Importe_Servicios").Value), 0, oRs.Fields("Importe_Servicios").Value)
                    End If
                    oRs.Close()
                End If









                For Each oL In oOP.DetallesImputaciones
                    With oL
                        If Not .Eliminado Then
                            mvarRetencionIVAIndividual = 0
                            If Len(oL.RetIVAenOP) = 0 Or oL.RetIVAenOP = oOP.NumeroOrdenPago Then
                                mvarBase = Val(oL.IVA)
                                If False Then 'Mid(oL.SubItems(1), 1, 1) = "M" Then
                                    'If (Val(oL.TotalComprobanteImputado) - Val(oL.IVA)) >= mvarImporteComprobantesMParaRetencionIVA Then
                                    '    mvarRetencionIVAIndividual = Math.Round(mvarBase * mvarPorcentajeRetencionIVAComprobantesM / 100, 2)
                                    '    mvarRetencionIVAComprobantesM = mvarRetencionIVAComprobantesM + mvarRetencionIVAIndividual
                                    'End If
                                ElseIf mvarAgenteRetencionIVA = "SI" Then
                                    If mvarCodigoSituacionRetencionIVA = 2 Then
                                        mvarRetencionIVAIndividual = mvarBase
                                    Else
                                        If Val(oL.TotalComprobanteImputado) > mvarImporteTotalMinimoAplicacionRetencionIVA Then
                                            If oL.Bien_o_Servicio = "B" Then
                                                If mvarBase > mvarTopeMinimoRetencionIVA Then
                                                    mvarBase = mvarBase * mvarPorcentajeBaseRetencionIVABienes / 100
                                                    If mvarExceptuadoRetencionIVA <> 0 Then
                                                        mvarRetencionIVAIndividual = Math.Round((mvarBase * (100 - mvarExceptuadoRetencionIVA) / 100), 2)
                                                    Else
                                                        mvarRetencionIVAIndividual = mvarBase
                                                        If mvarRetencionIVAIndividual < mvarImporteMinimoRetencionIVA Then
                                                            mvarRetencionIVAIndividual = 0
                                                        End If
                                                    End If
                                                    If mvarTipoIVA <> 1 Then mvarRetencionIVAIndividual = 0
                                                End If
                                            ElseIf oL.Bien_o_Servicio = "S" Then
                                                If mvarBase > mvarTopeMinimoRetencionIVAServicios Then
                                                    mvarBase = mvarBase * mvarPorcentajeBaseRetencionIVAServicios / 100
                                                    If mvarExceptuadoRetencionIVA <> 0 Then
                                                        mvarRetencionIVAIndividual = Math.Round((mvarBase * (100 - mvarExceptuadoRetencionIVA) / 100), 2)
                                                    Else
                                                        mvarRetencionIVAIndividual = mvarBase
                                                        If mvarRetencionIVAIndividual < mvarImporteMinimoRetencionIVAServicios Then
                                                            mvarRetencionIVAIndividual = 0
                                                        End If
                                                    End If
                                                    If mvarTipoIVA <> 1 Then mvarRetencionIVAIndividual = 0
                                                End If
                                            Else
                                                mvarBase = 0
                                            End If
                                        End If
                                    End If
                                End If



                                '/////////////////////////////////////////////////////////////////////////
                                '/////////////////////////////////////////////////////////////////////////
                                'Si es monotributista verifico la facturacion del ultimo año y recalculo la retencion
                                '/////////////////////////////////////////////////////////////////////////
                                '/////////////////////////////////////////////////////////////////////////
                                'If mvarTipoIVA = 6 Then
                                '    If mvarBienesUltimoAño > glbTopeMonotributoAnual_Bienes Or mvarServiciosUltimoAño > glbTopeMonotributoAnual_Servicios Then
                                '        mvarBase = Val(oL.SubItems(6))
                                '        If Val(oL.SubItems(19)) = 21 Then mvarRetencionIVAIndividual = mvarBase * 0.168
                                '        If Val(oL.SubItems(19)) = 10.5 Then mvarRetencionIVAIndividual = mvarBase * 0.084
                                '    End If
                                'End If
                                'oL.RetIVA = mvarRetencionIVAIndividual
                                'With origen.DetOrdenesPago.Item(oL.Tag)
                                '    .Registro.Fields("ImporteRetencionIVA").Value = mvarRetencionIVAIndividual
                                '    .Modificado = True
                                'End With
                                '/////////////////////////////////////////////////////////////////////////
                                '/////////////////////////////////////////////////////////////////////////
                                '/////////////////////////////////////////////////////////////////////////



                            End If
                            .ImporteRetencionIVA = mvarRetencionIVAIndividual
                            mvarRetencionIVA = mvarRetencionIVA + mvarRetencionIVAIndividual
                        End If
                    End With
                Next

                .RetencionIVA = mvarRetencionIVA
                .RetencionIVAComprobantesM = mvarRetencionIVAComprobantesM

                oRs = Nothing
            End If


        End With

    End Sub




    Public Shared Sub CalcularRetencionIngresosBrutos(ByVal SC As String, ByRef oOP As OrdenPago)


        Dim mvarRetencionIB As Double, mvarRetencionIBIndividual As Double
        Dim oRs As adodb.Recordset
        Dim mvarRetenerIIBB As Boolean

        mvarRetencionIB = 0


        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginalClase(SC)
        Dim oPrv = ProveedorManager.GetItem(SC, oOP.IdProveedor)



        If iisNull(oPrv.IBCondicion, 4) = 4 Then
            mvarRetenerIIBB = False
        ElseIf oPrv.IBCondicion = 1 Then ' And iisNull(oPrv.FechaLimiteExentoIIBB >= DTFields(0).Value) Then
            mvarRetenerIIBB = False
        Else
            mvarRetenerIIBB = True
        End If


        'Para retenerle el IIBB, yo debo ser agente de retencion Y el proveedor debe entrar en una categoria de IIBB
        If p.p(ePmOrg.AgenteRetencionIIBB) = "SI" And mvarRetenerIIBB And oOP.IdProveedor > 0 And oOP.Exterior = "NO" Then

            RecalcularImpuestos(SC, oOP)

            For Each oL In oOP.DetallesImpuestos
                If oL.TipoImpuesto = "I.Brutos" And oL.ImpuestoRetenido <> 0 Then
                    mvarRetencionIB = mvarRetencionIB + oL.ImpuestoRetenido
                End If
            Next

        Else

        End If
        oOP.RetencionIBrutos = mvarRetencionIB
    End Sub

    Public Shared Sub CalcularRetencionSUSS(ByVal SC As String, ByRef oOP As OrdenPago)
        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginalClase(SC)


        Dim mvarPorcentajeRetencionSUSS1 As Double = -1
        Dim mvarImporteMinimoBaseRetencionSUSS As Double
        'TO DO: definir
        Dim mvarPorcentajeRetencionSUSS As Double = p.p(ePmOrg.PorcentajeRetencionSUSS)


        Dim mvarRetencionSUSS As Double, mvarRetencionSUSSIndividual As Double
        Dim mvarTotalGravadoIVA As Double






        If p.p(ePmOrg.AgenteRetencionSUSS) = "SI" Then



            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////
            'si el proveedor tiene la fecha vencida, se pide al usuario que explicite la categoria
            'If mvarSUSSFechaCaducidadExencion < Today And Visible And IsNumeric(dcfields(0).BoundText) And mvarAgenteRetencionIVA = "SI" Then
            If False Then
                MsgBox("El proveedor tiene la fecha de excencion al SUSS vencida," & vbCrLf & _
                       "se requerira la categoria para realizar la retencion", vbExclamation)

                Dim mIdImpuestoDirecto As Long
                Dim mOk As Boolean
                Dim oRsAux As adodb.Recordset

                'Set oF = New frm_Aux
                'With oF
                '         .Caption = "Retencion SUSS"
                '         .Width = .Width * 2
                '         .Text1.Visible = False
                '         With .Label1
                '             .Caption = "Cat.SUSS:"
                '             .Visible = True
                '         End With
                '         With .dcfields(0)
                '      .Left = oF.Text1.Left
                '      .Top = oF.Text1.Top
                '      .Width = oF.DTFields(0).Width * 3
                '             .BoundColumn = "IdImpuestoDirecto"
                '             .RowSource = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorTipoParaCombo", "SUSS")
                '             .Visible = True
                '         End With
                '         .Show(vbModal, Me)
                '         mOk = .Ok
                '         If IsNumeric(.dcfields(0).BoundText) Then
                '             mIdImpuestoDirecto = .dcfields(0).BoundText
                '         Else
                '             mIdImpuestoDirecto = 0
                '         End If
                '     End With
                'Unload oF
                'Set oF = Nothing

                'If Not mOk Then Exit Sub

                'If mIdImpuestoDirecto = 0 Then
                '    MsgBox("No ingreso la categoria de SUSS", vbExclamation)
                '    Exit Sub
                'End If

                'oPrv = ProveedorManager.GetItem(SC, oOP.IdProveedor)
                'With oPrv
                '    With .Registro
                '        .Fields("IdImpuestoDirectoSUSS").Value = mIdImpuestoDirecto
                '        .Fields("RetenerSUSS").Value = "SI"
                '        .Fields("SUSSFechaCaducidadExencion").Value = Null
                '    End With
                '    .Guardar()
                'End With
                'oPrv = Nothing



                'mvarSUSSFechaCaducidadExencion = Today

                'mvarPorcentajeRetencionSUSS1 = 0
                'mvarImporteMinimoBaseRetencionSUSS = 0
                'oRsAux = Aplicacion.ImpuestosDirectos.TraerFiltrado("_PorId", mIdImpuestoDirecto)
                'If oRsAux.RecordCount > 0 Then
                '    mvarPorcentajeRetencionSUSS1 = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
                '    mvarImporteMinimoBaseRetencionSUSS = IIf(IsNull(oRsAux.Fields("BaseMinima").Value), 0, oRsAux.Fields("BaseMinima").Value)
                'End If
                'oRsAux.Close()
                'oRsAux = Nothing

                'With Check5
                '    .Enabled = True
                '    .Value = 1
                'End With
                'mvarRetenerSUSSAProveedor = "SI"
            End If
            '//////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////



            Dim oPrv = ProveedorManager.GetItem(SC, oOP.IdProveedor)

            If oPrv.RetenerSUSS <> "SI" Then Exit Sub

            mvarRetencionSUSS = 0
            Dim mvarBaseCalculoSUSS = 0
            mvarTotalGravadoIVA = 0

            'If Check5.Value = 1 Then




            Dim mvarIdImpuestoDirectoSUSS = 0
            Dim mvarRetenerSUSSAProveedor
            If oPrv.RetenerSUSS = "SI" Then
                mvarRetenerSUSSAProveedor = iisNull(oPrv.RetenerSUSS, "NO")

                mvarPorcentajeRetencionSUSS1 = 0
                mvarImporteMinimoBaseRetencionSUSS = 0
                If Not IsNull(oPrv.IdImpuestoDirectoSUSS) Then
                    mvarIdImpuestoDirectoSUSS = oPrv.IdImpuestoDirectoSUSS
                    Dim oRsAux = TraerFiltradoVB6(SC, enumSPs.ImpuestosDirectos_TX_PorId, oPrv.IdImpuestoDirectoSUSS)
                    If oRsAux.RecordCount > 0 Then
                        mvarPorcentajeRetencionSUSS1 = IIf(IsNull(oRsAux.Fields("Tasa").Value), 0, oRsAux.Fields("Tasa").Value)
                        mvarImporteMinimoBaseRetencionSUSS = IIf(IsNull(oRsAux.Fields("BaseMinima").Value), 0, oRsAux.Fields("BaseMinima").Value)
                    End If
                    oRsAux.Close()
                    oRsAux = Nothing
                Else
                    mvarPorcentajeRetencionSUSS1 = -1
                End If
            Else
                mvarRetenerSUSSAProveedor = "NO"
            End If





            For Each i In oOP.DetallesImputaciones
                'If Len(i.Tag) > 0 Then
                '    CalculaTotales()
                If Not i.Eliminado Then
                    mvarTotalGravadoIVA = mvarTotalGravadoIVA + i.GravadoIVA
                End If
                'End If
            Next

            If mvarTotalGravadoIVA >= mvarImporteMinimoBaseRetencionSUSS Then

                For Each i In oOP.DetallesImputaciones

                    mvarRetencionSUSSIndividual = 0
                    If Not i.Eliminado Then

                        If mvarPorcentajeRetencionSUSS1 = -1 Then
                            mvarRetencionSUSSIndividual = Math.Round(i.GravadoIVA * mvarPorcentajeRetencionSUSS / 100, 2)
                        Else
                            mvarRetencionSUSSIndividual = Math.Round(i.GravadoIVA * mvarPorcentajeRetencionSUSS1 / 100, 2)
                        End If
                        mvarBaseCalculoSUSS = mvarBaseCalculoSUSS + i.GravadoIVA

                    End If
                    mvarRetencionSUSS = mvarRetencionSUSS + mvarRetencionSUSSIndividual

                Next
            End If



            'End If

            'If mvarId <= 0 Or Check6.Value = 1 Then
            '    origen.Registro.Fields("RetencionSUSS").Value = mvarRetencionSUSS
            '    If mvarPrimeraVez And mvarTipoIVA = 6 And mvarRetencionSUSS > 0 Then
            '        MsgBox("El proveedor es monotributista, el sistema calcula el SUSS por aplicacion directa," & vbCrLf & _
            '              "verifique si existen pagos en el mes a este proveedor y ajuste el calculo.", vbInformation)
            '        mvarPrimeraVez = False
            '    End If
            'End If

        Else

            'With Check5
            '    .Value = 0
            '    .Enabled = False
            'End With

        End If

        oOP.RetencionSUSS = mvarRetencionSUSS

    End Sub












    Public Shared Function _RegistroContableOriginalVB6conADORrecordsets(ByVal SC As String, ByRef OP As OrdenPago) As adodb.Recordset


        'Traido de Compronto.OrdenPago.RegistroContable()

        Dim oRs As adodb.Recordset
        Dim oRsAux As adodb.Recordset
        Dim oRsCont As adodb.Recordset
        Dim oRsDet As adodb.Recordset
        Dim oRsDetCtas As adodb.Recordset
        Dim oRsBco As DataRow
        Dim oRsProv As adodb.Recordset
        Dim oRsDetBD As adodb.Recordset
        Dim oFld As adodb.Field
        Dim mvarEjercicio As Long, mvarCuentaCaja As Long, mvarCuentaProveedor As Long, mvarCuentaValores As Long
        Dim mvarCuentaRetencionIva As Long, mvarCuentaRetencionGanancias As Long, mvarCuentaRetencionIBrutos As Long
        Dim mvarCuentaRetencionIBrutosBsAs As Long, mvarCuentaRetencionIBrutosCap As Long, mvarCuentaReventas As Long
        Dim mvarCuentaDescuentos As Long, mvarCuentaDescuentosyRetenciones As Long, mvarCuentaValores1 As Long
        Dim mvarCuentaCajaTitulo As Long, mvarCuentaValoresTitulo As Long, mvarCuentaDescuentosyRetencionesTitulo As Long
        Dim mvarPosicion As Long, mvarCuentaRetencionSUSS As Long, mvarIdImpuestoDirectoSUSS As Long
        Dim mvarIdIBCondicionPorDefecto As Long, mvarCuentaRetencionIvaComprobantesM As Long
        Dim mvarRetencionIvaComprobantesM As Double, mvarTotalValores As Double, mvarImporte As Double, mvarDebe As Double
        Dim mvarHaber As Double
        Dim mvarDetalleValor As String, mvarDetalle As String, mvarDebeHaber As String, mvarChequeraPagoDiferido As String
        Dim mvarActivarCircuitoChequesDiferidos As String, mvarDetVal As String
        Dim mvarEsta As Boolean, mvarProcesar As Boolean




        'mvarEjercicio = IIf(IsNull(oRs.Fields("EjercicioActual").Value), 0, oRs.Fields("EjercicioActual").Value)
        'mvarCuentaCaja = IIf(IsNull(oRs.Fields("IdCuentaCaja").Value), 0, oRs.Fields("IdCuentaCaja").Value)
        'mvarCuentaCajaTitulo = IIf(IsNull(oRs.Fields("IdCuentaCajaTitulo").Value), 0, oRs.Fields("IdCuentaCajaTitulo").Value)
        'mvarCuentaValores = IIf(IsNull(oRs.Fields("IdCuentaValores").Value), 0, oRs.Fields("IdCuentaValores").Value)
        'mvarCuentaValoresTitulo = IIf(IsNull(oRs.Fields("IdCuentaValoresTitulo").Value), 0, oRs.Fields("IdCuentaValoresTitulo").Value)
        'mvarCuentaRetencionIva = IIf(IsNull(oRs.Fields("IdCuentaRetencionIva").Value), 0, oRs.Fields("IdCuentaRetencionIva").Value)
        'mvarCuentaRetencionIvaComprobantesM = IIf(IsNull(oRs.Fields("IdCuentaRetencionIvaComprobantesM").Value), 0, oRs.Fields("IdCuentaRetencionIvaComprobantesM").Value)
        'mvarCuentaRetencionGanancias = IIf(IsNull(oRs.Fields("IdCuentaRetencionGanancias").Value), 0, oRs.Fields("IdCuentaRetencionGanancias").Value)
        'mvarCuentaRetencionIBrutos = IIf(IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value), 0, oRs.Fields("IdCuentaRetencionIBrutos").Value)
        'mvarCuentaDescuentos = IIf(IsNull(oRs.Fields("IdCuentaDescuentos").Value), 0, oRs.Fields("IdCuentaDescuentos").Value)
        'mvarCuentaDescuentosyRetenciones = IIf(IsNull(oRs.Fields("IdCuentaDescuentosyRetenciones").Value), 0, oRs.Fields("IdCuentaDescuentosyRetenciones").Value)
        'mvarCuentaDescuentosyRetencionesTitulo = IIf(IsNull(oRs.Fields("IdCuentaDescuentosyRetencionesTitulo").Value), 0, oRs.Fields("IdCuentaDescuentosyRetencionesTitulo").Value)
        'mvarCuentaRetencionSUSS = IIf(IsNull(oRs.Fields("IdCuentaRetencionSUSS").Value), 0, oRs.Fields("IdCuentaRetencionSUSS").Value)
        'mvarActivarCircuitoChequesDiferidos = IIf(IsNull(oRs.Fields("ActivarCircuitoChequesDiferidos").Value), "NO", oRs.Fields("ActivarCircuitoChequesDiferidos").Value)
        'oRs.Close()





        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
        With p
            mvarEjercicio = .Item("EjercicioActual")
            mvarCuentaCaja = .Item("IdCuentaCaja")
            mvarCuentaCajaTitulo = .Item("IdCuentaCajaTitulo")
            mvarCuentaValores = .Item("IdCuentaValores")
            mvarCuentaValoresTitulo = .Item("IdCuentaValoresTitulo")
            mvarCuentaRetencionIva = .Item("IdCuentaRetencionIva")
            mvarCuentaRetencionIvaComprobantesM = .Item("IdCuentaRetencionIvaComprobantesM")
            mvarCuentaRetencionGanancias = .Item("IdCuentaRetencionGananciasCobros")
            mvarCuentaRetencionIBrutos = .Item("IdCuentaRetencionIBrutos")
            mvarCuentaDescuentos = .Item("IdCuentaDescuentos")
            mvarCuentaDescuentosyRetenciones = .Item("IdCuentaDescuentosyRetenciones")
            mvarCuentaDescuentosyRetencionesTitulo = .Item("IdCuentaDescuentosyRetencionesTitulo")
            mvarCuentaRetencionSUSS = iisNull(.Item("IdCuentaRetencionSUSS"), 0)
            mvarActivarCircuitoChequesDiferidos = iisNull(.Item("ActivarCircuitoChequesDiferidos"), "NO")
        End With















        If OP.IdProveedor > 0 Then
            Dim prov = ProveedorManager.GetItem(SC, OP.IdProveedor)
            mvarCuentaProveedor = prov.IdCuenta
            mvarIdImpuestoDirectoSUSS = prov.IdImpuestoDirectoSUSS
            mvarIdIBCondicionPorDefecto = prov.IdIBCondicionPorDefecto

            If mvarIdImpuestoDirectoSUSS <> 0 Then
                oRs = LeerUnoVB6(SC, "ImpuestosDirectos", mvarIdImpuestoDirectoSUSS)
                If oRs.RecordCount > 0 Then
                    If Not IsNull(oRs.Fields("IdCuenta").Value) Then
                        mvarCuentaRetencionSUSS = oRs.Fields("IdCuenta").Value
                    End If
                End If
                oRs.Close()
            End If
            If mvarIdIBCondicionPorDefecto <> 0 Then
                oRs = TraerFiltradoVB6(SC, enumSPs.IBCondiciones_TX_IdCuentaPorProvincia, mvarIdIBCondicionPorDefecto)
                If oRs.RecordCount > 0 Then
                    If Not IsNull(oRs.Fields("IdCuentaRetencionIBrutos").Value) Then
                        mvarCuentaRetencionIBrutos = oRs.Fields("IdCuentaRetencionIBrutos").Value
                    End If
                End If
                oRs.Close()
            End If
        Else
            mvarCuentaProveedor = IIf(IsNull(OP.IdCuenta), 0, OP.IdCuenta)
        End If

        oRsCont = CreateObject("adodb.Recordset")
        oRs = TraerFiltradoVB6(SC, enumSPs.Subdiarios_TX_Estructura)

        With oRs
            For Each oFld In .Fields
                With oFld
                    oRsCont.Fields.Append(.Name, .Type, .DefinedSize, .Attributes)
                    oRsCont.Fields.Item(.Name).Precision = .Precision
                    oRsCont.Fields.Item(.Name).NumericScale = .NumericScale
                End With
            Next
            oRsCont.Open()
        End With
        oRs.Close()

        If Not IsNull(OP.AsientoManual) And OP.AsientoManual = "SI" Then
            'oRsDetCtas = DetOrdenesPagoCuentas.TodosLosRegistros
            oRsDetCtas = OP.DetallesCuentas
            If oRsDetCtas.RecordCount > 0 Then
                oRsDetCtas.MoveFirst()
                Do While Not oRsDetCtas.EOF
                    With oRsCont
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = oRsDetCtas.Fields("IdCuenta").Value
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If Not IsNull(oRsDetCtas.Fields("Debe").Value) Then
                            .Fields("Debe").Value = oRsDetCtas.Fields("Debe").Value
                        End If
                        If Not IsNull(oRsDetCtas.Fields("Haber").Value) Then
                            .Fields("Haber").Value = oRsDetCtas.Fields("Haber").Value
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda

                        mvarDetalleValor = ""
                        oRsDet = OP.DetallesValores
                        With oRsDet
                            If .Fields.Count > 0 Then
                                If .RecordCount > 0 Then
                                    .MoveFirst()
                                    Do While Not .EOF
                                        If Not .Fields("Eliminado").Value Then
                                            mvarCuentaValores1 = mvarCuentaValores
                                            mvarProcesar = True

                                            oRsBco = EntidadManager.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
                                            mvarDetVal = ""
                                            If Not IsNothing(oRsBco) Then
                                                mvarDetVal = IIf(IsNull(oRsBco.Item("DescripcionAb")), "", oRsBco.Item("DescripcionAb"))
                                            End If
                                            oRsBco = Nothing

                                            If IsNull(.Fields("IdValor").Value) Then
                                                If Not IsNull(.Fields("IdBanco").Value) Then
                                                    If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
                                                        mvarProcesar = False
                                                    End If
                                                    If mvarProcesar Then
                                                        mvarChequeraPagoDiferido = "NO"
                                                        If Not IsNull(.Fields("IdBancoChequera").Value) Then
                                                            oRsBco = EntidadManager.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
                                                            If Not IsNothing(oRsBco) Then
                                                                If Not IsNull(oRsBco.Item("ChequeraPagoDiferido")) Then
                                                                    mvarChequeraPagoDiferido = oRsBco.Item("ChequeraPagoDiferido")
                                                                End If
                                                            End If

                                                        End If
                                                        oRsBco = EntidadManager.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
                                                        If Not IsNothing(oRsBco) Then
                                                            If mvarActivarCircuitoChequesDiferidos = "NO" Or _
                                                                  mvarChequeraPagoDiferido = "NO" Or _
                                                                  IsNull(oRsBco.Item("IdCuentaParaChequesDiferidos")) Then
                                                                If Not IsNull(oRsBco.Item("IdCuenta")) Then
                                                                    mvarCuentaValores1 = oRsBco.Item("IdCuenta")
                                                                End If
                                                            Else
                                                                mvarCuentaValores1 = oRsBco.Item("IdCuentaParaChequesDiferidos")
                                                            End If
                                                        End If

                                                    End If
                                                End If
                                            End If
                                            If mvarProcesar Then
                                                If Not IsNull(.Fields("NumeroValor").Value) And oRsDetCtas.Fields("IdCuenta").Value = mvarCuentaValores1 Then
                                                    mvarDetalleValor = mvarDetalleValor & mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value & " "
                                                End If
                                            End If
                                        End If
                                        .MoveNext()
                                    Loop
                                End If
                            End If
                        End With
                        oRsDet = Nothing

                        .Fields("Detalle").Value = Mid(mvarDetalleValor, 1, .Fields("Detalle").DefinedSize)
                        .Update()
                    End With
                    oRsDetCtas.MoveNext()
                Loop
                oRsDetCtas.MoveFirst()
            End If
            oRsDetCtas = Nothing

        Else




            If OP.Efectivo <> 0 Then
                With oRsCont
                    mvarImporte = OP.Efectivo
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                    .Fields("IdCuenta").Value = mvarCuentaCaja
                    .Fields("IdTipoComprobante").Value = 17
                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                    .Fields("IdComprobante").Value = OP.Id
                    .Fields("Haber").Value = mvarImporte
                    .Fields("IdMoneda").Value = OP.IdMoneda
                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    .Update()
                    mvarDebeHaber = "Debe"
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaProveedor
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        .Fields(mvarDebeHaber).Value = mvarImporte
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarImporte
                    End If
                    .Update()
                End With
            End If



            If OP.GastosGenerales <> 0 And OP.IdCuenta <> 0 Then
                With oRsCont
                    mvarImporte = OP.GastosGenerales
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                    .Fields("IdCuenta").Value = OP.IdCuenta
                    .Fields("IdTipoComprobante").Value = 17
                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                    .Fields("IdComprobante").Value = OP.Id
                    .Fields("Haber").Value = mvarImporte
                    .Fields("IdMoneda").Value = OP.IdMoneda
                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    .Update()
                    mvarDebeHaber = "Debe"
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaCaja
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        .Fields(mvarDebeHaber).Value = mvarImporte
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarImporte
                    End If
                    .Update()
                End With

            End If

            If OP.Descuentos <> 0 Then
                With oRsCont
                    mvarImporte = OP.Descuentos
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                    .Fields("IdCuenta").Value = mvarCuentaDescuentos
                    .Fields("IdTipoComprobante").Value = 17
                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                    .Fields("IdComprobante").Value = OP.Id
                    If mvarImporte > 0 Then
                        .Fields("Haber").Value = mvarImporte
                    Else
                        .Fields("Debe").Value = Math.Abs(mvarImporte)
                    End If
                    .Fields("IdMoneda").Value = OP.IdMoneda
                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    .Update()
                    If mvarImporte > 0 Then
                        mvarDebeHaber = "Debe"
                    Else
                        mvarDebeHaber = "Haber"
                    End If
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaProveedor
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                    End If
                    .Update()
                End With

            End If

            mvarRetencionIvaComprobantesM = IIf(IsNull(OP.RetencionIVAComprobantesM), 0, OP.RetencionIVAComprobantesM)

            If Not IsNull(OP.RetencionIVA) Then
                If OP.RetencionIVA - mvarRetencionIvaComprobantesM <> 0 Then
                    With oRsCont
                        mvarImporte = OP.RetencionIVA - mvarRetencionIvaComprobantesM
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaRetencionIva
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            If mvarImporte > 0 Then
                                .Fields("Debe").Value = mvarImporte
                            Else
                                .Fields("Haber").Value = Math.Abs(mvarImporte)
                            End If
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If mvarRetencionIvaComprobantesM <> 0 Then
                With oRsCont
                    mvarImporte = mvarRetencionIvaComprobantesM
                    .AddNew()
                    .Fields("Ejercicio").Value = mvarEjercicio
                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                    .Fields("IdCuenta").Value = mvarCuentaRetencionIvaComprobantesM
                    .Fields("IdTipoComprobante").Value = 17
                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                    .Fields("IdComprobante").Value = OP.Id
                    If mvarImporte > 0 Then
                        .Fields("Haber").Value = mvarImporte
                    Else
                        .Fields("Debe").Value = Math.Abs(mvarImporte)
                    End If
                    .Fields("IdMoneda").Value = OP.IdMoneda
                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    .Update()
                    If mvarImporte > 0 Then
                        mvarDebeHaber = "Debe"
                    Else
                        mvarDebeHaber = "Haber"
                    End If
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaProveedor
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Debe").Value = mvarImporte
                        Else
                            .Fields("Haber").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                    End If
                    .Update()
                End With
            End If

            If Not IsNull(OP.RetencionGanancias) Then
                If OP.RetencionGanancias <> 0 Then
                    With oRsCont
                        mvarImporte = OP.RetencionGanancias
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaRetencionGanancias
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        If Not IsNull(OP.IdProveedor) Then
                            mvarDetalle = ""
                            If Not IsNull(OP.NumeroCertificadoRetencionGanancias) Then
                                mvarDetalle = mvarDetalle & "Cert.: " & OP.NumeroCertificadoRetencionGanancias
                            End If
                            oRsProv = EntidadManager.LeerUnoVB6(SC, "Proveedores", OP.IdProveedor)
                            If oRsProv.RecordCount > 0 Then
                                If Not IsNull(oRsProv.Fields("RazonSocial").Value) Then
                                    mvarDetalle = mvarDetalle & " Prov.: " & Trim(oRsProv.Fields("RazonSocial").Value)
                                End If
                                If Not IsNull(oRsProv.Fields("Cuit").Value) Then
                                    mvarDetalle = mvarDetalle & " Cuit: " & Trim(oRsProv.Fields("Cuit").Value)
                                End If
                            End If
                            .Fields("Detalle").Value = mvarDetalle
                            oRsProv.Close()
                            oRsProv = Nothing
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(OP.RetencionIBrutos) Then
                If OP.RetencionIBrutos <> 0 Then
                    With oRsCont


                        'oRsAux = OrdenPagoManager.TraerRegistrosPorImpuesto(OP, "I.Brutos")
                        If True Then ' oRsAux.RecordCount > 0 Then
                            For Each i In OP.DetallesImpuestos
                                If i.TipoImpuesto = "I.Brutos" Then
                                    mvarImporte = i.ImpuestoRetenido
                                    .AddNew()
                                    .Fields("Ejercicio").Value = mvarEjercicio
                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                                    .Fields("IdCuenta").Value = mvarCuentaRetencionIBrutos 'i.Idcuenta
                                    .Fields("IdTipoComprobante").Value = 17
                                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                                    .Fields("IdComprobante").Value = OP.Id
                                    If mvarImporte > 0 Then
                                        .Fields("Haber").Value = mvarImporte
                                    Else
                                        .Fields("Debe").Value = Math.Abs(mvarImporte)
                                    End If
                                    .Fields("IdMoneda").Value = OP.IdMoneda
                                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                                    .Update()
                                End If
                            Next

                        Else
                            mvarImporte = OP.RetencionIBrutos
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaRetencionIBrutos
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            If mvarImporte > 0 Then
                                .Fields("Haber").Value = mvarImporte
                            Else
                                .Fields("Debe").Value = Math.Abs(mvarImporte)
                            End If
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Update()
                            oRsAux.Close()
                        End If

                        mvarImporte = OP.RetencionIBrutos
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(OP.Otros1) Then
                If OP.Otros1 <> 0 Then
                    With oRsCont
                        mvarImporte = OP.Otros1
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = OP.IdCuenta1
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(OP.Otros2) Then
                If OP.Otros2 <> 0 Then
                    With oRsCont
                        mvarImporte = OP.Otros2
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = OP.IdCuenta2
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(OP.Otros3) Then
                If OP.Otros3 <> 0 Then
                    With oRsCont
                        mvarImporte = OP.Otros3
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = OP.IdCuenta3
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            If Not IsNull(OP.RetencionSUSS) Then
                If OP.RetencionSUSS <> 0 Then
                    With oRsCont
                        mvarImporte = OP.RetencionSUSS
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaRetencionSUSS
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        If mvarImporte > 0 Then
                            .Fields("Haber").Value = mvarImporte
                        Else
                            .Fields("Debe").Value = Math.Abs(mvarImporte)
                        End If
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                        .Update()
                        If mvarImporte > 0 Then
                            mvarDebeHaber = "Debe"
                        Else
                            mvarDebeHaber = "Haber"
                        End If
                        mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                        If mvarPosicion = 0 Then
                            .AddNew()
                            .Fields("Ejercicio").Value = mvarEjercicio
                            .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                            .Fields("IdCuenta").Value = mvarCuentaProveedor
                            .Fields("IdTipoComprobante").Value = 17
                            .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                            .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                            .Fields("IdComprobante").Value = OP.Id
                            .Fields("IdMoneda").Value = OP.IdMoneda
                            .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                            .Fields(mvarDebeHaber).Value = Math.Abs(mvarImporte)
                        Else
                            .AbsolutePosition = mvarPosicion
                            .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + Math.Abs(mvarImporte)
                        End If
                        .Update()
                    End With
                End If
            End If

            mvarTotalValores = 0


            'oRsDet = DataTable_To_Recordset(GetDataSetNative(OP.DetallesValores).Tables(0))
            'oRsDet = DataTable_To_Recordset(ConvertToDataTable(OP.DetallesValores))


            For Each oRsDetItem In OP.DetallesValores
                With oRsDetItem





                    If Not .Eliminado Then
                        mvarCuentaValores1 = mvarCuentaValores
                        mvarProcesar = True

                        oRsBco = EntidadManager.LeerUno(SC, "TiposComprobante", .IdTipoValor)
                        mvarDetVal = ""
                        If Not IsNothing(oRsBco) Then
                            mvarDetVal = IIf(IsNull(oRsBco.Item("DescripcionAb")), "", oRsBco.Item("DescripcionAb"))
                        End If
                        oRsBco = Nothing

                        If .IdValor < 1 Then
                            If .IdBanco > 0 Then
                                '                           Set oRsBco = EntidadManager.TraerFiltrado("Valores", "_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
                                '                           If Not IsNothing(oRsBco) Then
                                '                              If IIf(IsNull(oRsBco.Item("Anulado")), "NO", oRsBco.Item("Anulado")) = "SI" Then
                                '                                 mvarProcesar = False
                                '                              End If
                                '                           End If
                                '                           oRsBco.Close
                                If IIf(IsNull(.Anulado), "NO", .Anulado) = "SI" Then
                                    mvarProcesar = False
                                End If
                                If mvarProcesar Then
                                    mvarChequeraPagoDiferido = "NO"
                                    If .IdBancoChequera > 0 Then
                                        oRsBco = EntidadManager.LeerUno(SC, "BancoChequeras", .IdBancoChequera)
                                        If Not IsNothing(oRsBco) Then
                                            If Not IsNull(oRsBco.Item("ChequeraPagoDiferido")) Then
                                                mvarChequeraPagoDiferido = oRsBco.Item("ChequeraPagoDiferido")
                                            End If
                                        End If
                                        oRsBco = Nothing
                                    End If
                                    oRsBco = EntidadManager.LeerUno(SC, "Bancos", .IdBanco)
                                    If Not IsNothing(oRsBco) Then
                                        If mvarActivarCircuitoChequesDiferidos = "NO" Or mvarChequeraPagoDiferido = "NO" Or _
                                              IsNull(oRsBco.Item("IdCuentaParaChequesDiferidos")) Then
                                            If Not IsNull(oRsBco.Item("IdCuenta")) Then
                                                mvarCuentaValores1 = oRsBco.Item("IdCuenta")
                                            End If
                                        Else
                                            mvarCuentaValores1 = oRsBco.Item("IdCuentaParaChequesDiferidos")
                                        End If
                                    End If
                                    oRsBco = Nothing
                                End If
                            ElseIf .IdTarjetaCredito > 0 Then
                                oRsBco = EntidadManager.LeerUno(SC, "TarjetasCredito", .IdTarjetaCredito)
                                If Not IsNothing(oRsBco) Then
                                    If Not IsNull(oRsBco.Item("IdCuenta")) Then
                                        mvarCuentaValores1 = oRsBco.Item("IdCuenta")
                                    End If
                                End If
                                oRsBco = Nothing
                            Else
                                oRsBco = EntidadManager.LeerUno(SC, "Cajas", .IdCaja)
                                If Not IsNothing(oRsBco) Then
                                    If Not IsNull(oRsBco.Item("IdCuenta")) Then
                                        mvarCuentaValores1 = oRsBco.Item("IdCuenta")
                                    End If
                                End If
                                oRsBco = Nothing
                            End If
                        End If
                        If mvarProcesar Then
                            mvarTotalValores = mvarTotalValores + .Importe
                            mvarDetalleValor = ""
                            If Not IsNull(.NumeroValor) Then
                                mvarDetalleValor = mvarDetVal & " " & .NumeroValor & " [" & .NumeroInterno & "] Vto.:" & .FechaVencimiento
                            End If
                            With oRsCont
                                .AddNew()
                                .Fields("Ejercicio").Value = mvarEjercicio
                                .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                                .Fields("IdCuenta").Value = mvarCuentaValores1
                                .Fields("IdTipoComprobante").Value = 17
                                .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                                .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                                .Fields("Detalle").Value = mvarDetalleValor
                                .Fields("IdComprobante").Value = OP.Id
                                .Fields("Haber").Value = oRsDetItem.Importe
                                .Fields("IdMoneda").Value = OP.IdMoneda
                                .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                                .Update()
                            End With
                        End If
                    End If

                End With
            Next

            oRsDetBD = TraerFiltradoVB6(SC, enumSPs.DetOrdenesPagoValores_TX_PorIdCabecera, OP.Id)
            With oRsDetBD
                If .RecordCount > 0 Then
                    .MoveFirst()
                    Do While Not .EOF
                        mvarEsta = False

                        For Each i In OP.DetallesValores
                            If .Fields(0).Value = i.Id Then
                                mvarEsta = True
                                Exit For
                            End If
                        Next


                        If Not mvarEsta Then
                            mvarCuentaValores1 = mvarCuentaValores
                            mvarProcesar = True

                            oRsBco = EntidadManager.LeerUno(SC, "TiposComprobante", .Fields("IdTipoValor").Value)
                            mvarDetVal = ""
                            If Not IsNothing(oRsBco) Then
                                mvarDetVal = IIf(IsNull(oRsBco.Item("DescripcionAb")), "", oRsBco.Item("DescripcionAb"))
                            End If
                            oRsBco = Nothing

                            If Not IsNull(.Fields("IdBanco").Value) Then
                                '                     Set oRsBco = EntidadManager.TraerFiltrado("Valores", "_PorIdDetalleOrdenPagoValores", .Fields(0).Value)
                                '                     If Not IsNothing(oRsBco) Then
                                '                        If IIf(IsNull(oRsBco.Item("Anulado")), "NO", oRsBco.Item("Anulado")) = "SI" Then
                                '                           mvarProcesar = False
                                '                        End If
                                '                     End If
                                '                     oRsBco.Close
                                If IIf(IsNull(.Fields("Anulado").Value), "NO", .Fields("Anulado").Value) = "SI" Then
                                    mvarProcesar = False
                                End If
                                If mvarProcesar Then
                                    mvarChequeraPagoDiferido = "NO"
                                    If Not IsNull(.Fields("IdBancoChequera").Value) Then
                                        oRsBco = EntidadManager.LeerUno(SC, "BancoChequeras", .Fields("IdBancoChequera").Value)
                                        If Not IsNothing(oRsBco) Then
                                            If Not IsNull(oRsBco.Item("ChequeraPagoDiferido")) Then
                                                mvarChequeraPagoDiferido = oRsBco.Item("ChequeraPagoDiferido")
                                            End If
                                        End If
                                        oRsBco = Nothing
                                    End If
                                    oRsBco = EntidadManager.LeerUno(SC, "Bancos", .Fields("IdBanco").Value)
                                    If Not IsNothing(oRsBco) Then
                                        If mvarActivarCircuitoChequesDiferidos = "NO" Or mvarChequeraPagoDiferido = "NO" Or _
                                              IsNull(oRsBco.Item("IdCuentaParaChequesDiferidos")) Then
                                            If Not IsNull(oRsBco.Item("IdCuenta")) Then
                                                mvarCuentaValores1 = oRsBco.Item("IdCuenta")
                                            End If
                                        Else
                                            mvarCuentaValores1 = oRsBco.Item("IdCuentaParaChequesDiferidos")
                                        End If
                                    End If
                                    oRsBco = Nothing
                                End If
                            Else
                                oRsBco = EntidadManager.LeerUno(SC, "Cajas", .Fields("IdCaja").Value)
                                If Not IsNothing(oRsBco) Then
                                    If Not IsNull(oRsBco.Item("IdCuenta")) Then
                                        mvarCuentaValores1 = oRsBco.Item("IdCuenta")
                                    End If
                                End If
                                oRsBco = Nothing
                            End If
                            If mvarProcesar Then
                                mvarTotalValores = mvarTotalValores + .Fields("Importe").Value
                                mvarDetalleValor = ""
                                If Not IsNull(.Fields("NumeroValor").Value) Then
                                    mvarDetalleValor = mvarDetVal & " " & .Fields("NumeroValor").Value & " [" & .Fields("NumeroInterno").Value & "] Vto.:" & .Fields("FechaVencimiento").Value
                                End If
                                With oRsCont
                                    .AddNew()
                                    .Fields("Ejercicio").Value = mvarEjercicio
                                    .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                                    .Fields("IdCuenta").Value = mvarCuentaValores1
                                    .Fields("IdTipoComprobante").Value = 17
                                    .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                                    .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                                    .Fields("Detalle").Value = mvarDetalleValor
                                    .Fields("IdComprobante").Value = OP.Id
                                    .Fields("Haber").Value = oRsDetBD.Fields("Importe").Value
                                    .Fields("IdMoneda").Value = OP.IdMoneda
                                    .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                                    .Update()
                                End With
                            End If
                        End If
                        .MoveNext()
                    Loop
                End If
                .Close()
            End With
            oRsDetBD = Nothing

            'If oRsDet.Fields.Count > 0 Then oRsDet.Close()
            oRsDet = Nothing

            If mvarTotalValores <> 0 Then
                With oRsCont
                    mvarDebeHaber = "Debe"
                    mvarPosicion = BuscarUnRegistroPorCampo(oRsCont, "IdCuenta", mvarCuentaProveedor, mvarDebeHaber)
                    If mvarPosicion = 0 Then
                        .AddNew()
                        .Fields("Ejercicio").Value = mvarEjercicio
                        .Fields("IdCuentaSubdiario").Value = mvarCuentaCajaTitulo
                        .Fields("IdCuenta").Value = mvarCuentaProveedor
                        .Fields("IdTipoComprobante").Value = 17
                        .Fields("NumeroComprobante").Value = OP.NumeroOrdenPago
                        .Fields("FechaComprobante").Value = OP.FechaOrdenPago
                        .Fields("IdComprobante").Value = OP.Id
                        .Fields(mvarDebeHaber).Value = mvarTotalValores
                        .Fields("IdMoneda").Value = OP.IdMoneda
                        .Fields("CotizacionMoneda").Value = OP.CotizacionMoneda
                    Else
                        .AbsolutePosition = mvarPosicion
                        .Fields(mvarDebeHaber).Value = .Fields(mvarDebeHaber).Value + mvarTotalValores
                    End If
                    .Update()
                End With
            End If

        End If

        With oRsCont
            If .RecordCount > 0 Then
                .MoveFirst()
                Do While Not .EOF
                    mvarDebe = IIf(IsNull(.Fields("Debe").Value), 0, .Fields("Debe").Value)
                    mvarHaber = IIf(IsNull(.Fields("Haber").Value), 0, .Fields("Haber").Value)
                    If mvarDebe < 0 Then
                        mvarHaber = mvarHaber + Math.Abs(mvarDebe)
                        mvarDebe = 0
                        .Fields("Haber").Value = mvarHaber
                        .Fields("Debe").Value = DBNull.Value
                        .Update()
                    End If
                    If mvarHaber < 0 Then
                        mvarDebe = mvarDebe + Math.Abs(mvarHaber)
                        mvarHaber = 0
                        .Fields("Debe").Value = mvarDebe
                        .Fields("Haber").Value = DBNull.Value
                        .Update()
                    End If
                    .MoveNext()
                Loop
                .MoveFirst()
            End If
        End With

        _RegistroContableOriginalVB6conADORrecordsets = oRsCont

        oRs = Nothing
        oRsAux = Nothing
        oRsCont = Nothing
        oRsBco = Nothing

    End Function





    'Public Shared Function ConvertToDataTable(Of T)(ByVal list As Generic.List(Of T)) As DataTable
    '    Dim table As New DataTable()
    '    Dim fields() As FieldInfo = GetType(T).GetFields()
    '    For Each field As FieldInfo In fields
    '        table.Columns.Add(field.Name, field.FieldType)
    '    Next
    '    For Each item As T In list
    '        Dim row As DataRow = table.NewRow()
    '        For Each field As FieldInfo In fields
    '            row(field.Name) = field.GetValue(item)
    '        Next
    '        table.Rows.Add(row)
    '    Next
    '    Return table
    'End Function


    'Private Shared Function GetDataSetNative(Of T)(ByVal list As Generic.List(Of T)) As DataSet
    '    'http://www.codeproject.com/KB/vb/List2DataSet.aspx

    '    Dim _resultDataSet As New DataSet()
    '    Dim _resultDataTable As New DataTable("results")
    '    Dim _resultDataRow As DataRow = Nothing
    '    Dim _itemProperties() As PropertyInfo = _
    '         list.Item(0).GetType().GetProperties()
    '    '    
    '    ' Meta Data. 
    '    '
    '    _itemProperties = list.Item(0).GetType().GetProperties()
    '    For Each p As PropertyInfo In _itemProperties
    '        _resultDataTable.Columns.Add(p.Name, _
    '                  p.GetGetMethod.ReturnType())
    '    Next
    '    '
    '    ' Data
    '    '
    '    For Each item As T In list
    '        '
    '        ' Get the data from this item into a DataRow
    '        ' then add the DataRow to the DataTable.
    '        ' Eeach items property becomes a colunm.
    '        '
    '        _itemProperties = item.GetType().GetProperties()
    '        _resultDataRow = _resultDataTable.NewRow()
    '        For Each p As PropertyInfo In _itemProperties
    '            _resultDataRow(p.Name) = p.GetValue(item, Nothing)
    '        Next
    '        _resultDataTable.Rows.Add(_resultDataRow)
    '    Next
    '    '
    '    ' Add the DataTable to the DataSet, We are DONE!
    '    '
    '    _resultDataSet.Tables.Add(_resultDataTable)
    '    Return _resultDataSet
    'End Function








    Public Shared Sub RecalcularImpuestos(ByVal SC As String, ByRef myOP As OrdenPago)

        ' traido de Compronto.DetOrdenesPagoImpuestos.RegistrosConFormato (de la coleccion de impuestos)

        Dim mCol As OrdenPagoImpuestosItemList = myOP.DetallesImpuestos
        Dim Item As OrdenPagoImpuestosItem


        'Dim oRs As adodb.Recordset
        'Dim oRsFmt As adodb.Recordset
        Dim oRsAux As adodb.Recordset
        Dim oRsAux1 As Pronto.ERP.BO.Proveedor
        Dim oC As OrdenPagoImpuestosItem '  DetOrdenPagoImpuestos 
        Dim oFld As adodb.Field
        Dim VectorX As String, VectorT As String, mLeyendaPorcentajeAdicional As String, GeneraImpuestos As String
        Dim mRegimenEspecialConstruccionIIBB As String
        Dim mFecha As Date, mFechaInicioVigenciaIBDirecto As Date, mFechaFinVigenciaIBDirecto As Date
        Dim mEsta As Boolean, mFacturaM As Boolean, mAplicarAlicuotaConvenio As Boolean, mAplicarAlicuotaDirecta As Boolean
        Dim i As Integer, mIdMoneda As Integer
        Dim mIdProveedor As Long
        Dim mImporte As Double, mImpuestoRetenido As Double, mBaseIIBB As Double, mImpuestoAdicional As Double
        Dim mImpuestoARetener As Double, mImporteComprobantesMParaRetencionGanancias As Double
        Dim mPorcentajeATomarSobreBase As Single, mPorcentajeAdicional As Single, mCoeficienteUnificado As Single
        Dim mAlicuota As Single, mAlicuotaConvenio As Single, mPorcentajeRetencionGananciasComprobantesM As Single
        Dim mAlicuotaDirecta As Single



        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
        With p
            mImporteComprobantesMParaRetencionGanancias = If(.Item("ImporteComprobantesMParaRetencionGanancias"), 0)
            mPorcentajeRetencionGananciasComprobantesM = If(.Item("PorcentajeRetencionGananciasComprobantesM"), 0)
        End With


        mIdMoneda = IIf(IsNull(myOP.IdMoneda), 1, myOP.IdMoneda)
        Dim r = GetStoreProcedureTop1(SC, enumSPs.Monedas_T, mIdMoneda)
        If iisNull(r.Item("GeneraImpuestos"), "NO") = "NO" Then
            GeneraImpuestos = "NO"
        Else
            GeneraImpuestos = "SI"
        End If


        'oRs = GetStoreProcedureTop1(SC, enumSPs.DetOrdenesPagoImpuestos_TXPrimero)



        oRsAux = myOP.Detalle

        mIdProveedor = 0
        If Not IsNull(myOP.IdProveedor) Then
            mIdProveedor = myOP.IdProveedor
        End If

        mFecha = Today
        If Not IsNull(myOP.FechaOrdenPago) Then
            mFecha = myOP.FechaOrdenPago
        End If



        For Each oC In mCol
            If Not oC.Eliminado Then
                With oC
                    .ImportePagado = 0
                    .ImpuestoRetenido = 0
                    .ImporteTotalFacturasMPagadasSujetasARetencion = 0
                End With
            End If
        Next

        If GeneraImpuestos = "NO" Then
            GoTo Salida
        End If

        'Generar registros de Ganancias
        For Each it In myOP.DetallesImputaciones

            If it.Eliminado Then Continue For

            With it
                If .IdTipoRetencionGanancia > 0 Then
                    If Mid(.Numero, 1, 1) = "M" Then mFacturaM = True Else mFacturaM = False

                    mImporte = iisNull(.ImportePagadoSinImpuestos, .Importe)

                    mEsta = False
                    For Each oC In mCol
                        If Not oC.Eliminado Then
                            With oC
                                If .TipoImpuesto = "Ganancias" And _
                                      .IdTipoRetencionGanancia = it.IdTipoRetencionGanancia Then

                                    .ImportePagado += mImporte

                                    mEsta = True
                                    Exit For
                                End If
                            End With
                        End If
                    Next
                    If Not mEsta Then
                        Item = New OrdenPagoImpuestosItem
                        With Item
                            .TipoImpuesto = "Ganancias"





                            .IdTipoRetencionGanancia = it.IdTipoRetencionGanancia
                            .ImporteTotalFacturasMPagadasSujetasARetencion = 0
                            .ImportePagado = mImporte
                            .ImpuestoRetenido = 0
                        End With
                        mCol.Add(Item)
                    End If
                End If
            End With
        Next



        'Generar registros de Ingresos Brutos
        For Each it In myOP.DetallesImputaciones

            If it.Eliminado Then Continue For

            With it
                If .IdIBCondicion > 0 Then
                    If .BaseCalculoIIBB = "SIN IMPUESTOS" Then
                        mImporte = iisNull(.ImportePagadoSinImpuestos, .Importe)
                    Else
                        mImporte = iisNull(.Importe, .ImportePagadoSinImpuestos)
                    End If
                    mEsta = False


                    For Each oC In mCol
                        If Not oC.Eliminado Then
                            With oC
                                If .TipoImpuesto = "I.Brutos" And _
                                      Not IsNull(it.IdIBCondicion) And _
                                      .IdIBCondicion = it.IdIBCondicion Then
                                    .ImportePagado += mImporte
                                    mEsta = True
                                    Exit For
                                End If
                            End With
                        End If
                    Next
                    If Not mEsta Then
                        Item = New OrdenPagoImpuestosItem
                        With Item

                            .TipoImpuesto = "I.Brutos"
                            .IdIBCondicion = it.IdIBCondicion
                            .ImportePagado = mImporte
                            .ImpuestoRetenido = 0


                        End With
                        mCol.Add(Item)
                    End If
                End If
            End With
        Next

        oRsAux = Nothing




        For Each oC In mCol
            If Not oC.Eliminado Then
                With oC
                    If .IdTipoRetencionGanancia > 0 Then
                        '///////////////////////////////////////////////////////////////////////////////
                        '///////////////////////////////////////////////////////////////////////////////
                        'Ganancias
                        '///////////////////////////////////////////////////////////////////////////////
                        '///////////////////////////////////////////////////////////////////////////////


                        .Categoria = GetStoreProcedureTop1(SC, enumSPs.TiposRetencionGanancia_TX_PorId, .IdTipoRetencionGanancia).Item("Descripcion")
                        .NumeroCertificadoRetencionGanancias = .NumeroCertificadoRetencionGanancias
                        mImporte = IIf(IsNull(.ImportePagado), 0, .ImportePagado)
                        oRsAux = TraerFiltradoVB6(SC, enumSPs.Ganancias_TX_ImpuestoPorIdTipoRetencionGanancia, mIdProveedor, mFecha, .IdTipoRetencionGanancia, mImporte, myOP.Id)
                        mImpuestoARetener = 0
                        If oRsAux.RecordCount > 0 Then
                            mImpuestoARetener = oRsAux.Fields("ImpuestoARetener").Value
                            .PagosMes = oRsAux.Fields("ImporteAcumulado").Value
                            .RetencionesMes = oRsAux.Fields("Retenido").Value
                        End If
                        oRsAux.Close()
                        If .ImporteTotalFacturasMPagadasSujetasARetencion <> 0 Then
                            mImpuestoARetener = mImpuestoARetener + _
                                           Math.Round(.ImporteTotalFacturasMPagadasSujetasARetencion * mPorcentajeRetencionGananciasComprobantesM / 100, 2)
                        End If
                        .ImpuestoRetenido = mImpuestoARetener

                    ElseIf .IdIBCondicion > 0 Then
                        '///////////////////////////////////////////////////////////////////////////////
                        '///////////////////////////////////////////////////////////////////////////////
                        'IIBB
                        '///////////////////////////////////////////////////////////////////////////////
                        '///////////////////////////////////////////////////////////////////////////////


                        .ImpuestoRetenido = 0
                        '.NumeroCertificadoRetencionIIBB = .Fields("NumeroCertificadoRetencionIIBB").Value
                        mImpuestoAdicional = 0
                        mImpuestoRetenido = 0
                        mAlicuotaConvenio = 0
                        mCoeficienteUnificado = 0
                        mAlicuotaDirecta = 0
                        mFechaInicioVigenciaIBDirecto = Nothing
                        mFechaFinVigenciaIBDirecto = Nothing
                        mAplicarAlicuotaConvenio = False
                        mAplicarAlicuotaDirecta = False
                        mRegimenEspecialConstruccionIIBB = ""


                        oRsAux1 = ProveedorManager.GetItem(SC, mIdProveedor)
                        mCoeficienteUnificado = oRsAux1.CoeficienteIIBBUnificado
                        mAlicuotaDirecta = IIf(IsNull(oRsAux1.PorcentajeIBDirecto), 0, oRsAux1.PorcentajeIBDirecto)
                        mFechaInicioVigenciaIBDirecto = IIf(IsNull(oRsAux1.FechaInicioVigenciaIBDirecto), 0, oRsAux1.FechaInicioVigenciaIBDirecto)
                        mFechaFinVigenciaIBDirecto = IIf(IsNull(oRsAux1.FechaFinVigenciaIBDirecto), 0, oRsAux1.FechaFinVigenciaIBDirecto)
                        'mRegimenEspecialConstruccionIIBB = oRsAux1.RegimenEspecialConstruccionIIBB
                        If Not IsNull(oRsAux1.IBCondicion) And oRsAux1.IBCondicion = 2 Then
                            Dim oRsAux3 = GetStoreProcedureTop1(SC, enumSPs.DetProveedoresIB_TX_PorIdProveedorIdIBCondicion, mIdProveedor, .IdIBCondicion)
                            If Not IsNothing(oRsAux3) Then
                                mAlicuotaConvenio = iisNull(oRsAux3.Item("AlicuotaAAplicar"), 0)
                                mAplicarAlicuotaConvenio = True
                            End If
                        End If


                        Dim oRsAux2 = DataTable_To_Recordset(GetStoreProcedure(SC, enumSPs.IBCondiciones_T, .IdIBCondicion))
                        If oRsAux2.RecordCount > 0 Then
                            mPorcentajeATomarSobreBase = IIf(IsNull(oRsAux2.Fields("PorcentajeATomarSobreBase").Value), 100, oRsAux2.Fields("PorcentajeATomarSobreBase").Value)
                            mPorcentajeAdicional = IIf(IsNull(oRsAux2.Fields("PorcentajeAdicional").Value), 0, oRsAux2.Fields("PorcentajeAdicional").Value)
                            mLeyendaPorcentajeAdicional = IIf(IsNull(oRsAux2.Fields("LeyendaPorcentajeAdicional").Value), "", oRsAux2.Fields("LeyendaPorcentajeAdicional").Value)
                            If IIf(IsNull(oRsAux2.Fields("IdProvinciaReal").Value), oRsAux2.Fields("IdProvincia").Value, oRsAux2.Fields("IdProvinciaReal").Value) = 2 And _
                                  mFecha >= mFechaInicioVigenciaIBDirecto And mFecha <= mFechaFinVigenciaIBDirecto And mRegimenEspecialConstruccionIIBB <> "SI" Then
                                'mAlicuotaDirecta <> 0 And
                                mAlicuota = mAlicuotaDirecta
                                mAplicarAlicuotaDirecta = True
                            Else
                                mAlicuota = IIf(IsNull(oRsAux2.Fields("Alicuota").Value), 0, oRsAux2.Fields("Alicuota").Value)
                            End If
                            .Categoria = oRsAux2.Fields("Descripcion").Value
                            .ImporteTopeMinimoIIBB = IIf(IsNull(oRsAux2.Fields("ImporteTopeMinimo").Value), 0, oRsAux2.Fields("ImporteTopeMinimo").Value)
                            .AlicuotaIIBB = mAlicuota
                            .AlicuotaConvenioIIBB = mAlicuotaConvenio
                            .PagosMes = 0
                            .RetencionesMes = 0
                            .ImpuestoRetenido = 0
                            .PorcentajeATomarSobreBase = 100
                            .PorcentajeAdicional = 0
                            .ImpuestoAdicional = 0
                            mImporte = IIf(IsNull(.ImportePagado), 0, .ImportePagado)
                            If Not IsNull(oRsAux2.Fields("AcumulaMensualmente").Value) And oRsAux2.Fields("AcumulaMensualmente").Value = "SI" Then
                                oRsAux = DataTable_To_Recordset(GetStoreProcedure(SC, enumSPs.IBCondiciones_TX_AcumuladosPorIdProveedorIdIBCondicion, mIdProveedor, mFecha, .IdIBCondicion, myOP.Id))
                                If oRsAux.RecordCount > 0 Then
                                    .PagosMes = oRsAux.Fields("ImporteAcumulado").Value
                                    .RetencionesMes = oRsAux.Fields("ImpuestoRetenido").Value
                                End If
                                oRsAux.Close()
                            End If
                            If mImporte > .ImporteTopeMinimoIIBB Then
                                mBaseIIBB = (mImporte + .PagosMes * mPorcentajeATomarSobreBase / 100)
                                If mCoeficienteUnificado > 0 And mCoeficienteUnificado <= 100 Then
                                    mBaseIIBB = mBaseIIBB * mCoeficienteUnificado / 100
                                End If
                                If mAplicarAlicuotaConvenio And Not mAplicarAlicuotaDirecta Then
                                    mImpuestoRetenido = Math.Round(mBaseIIBB * mAlicuotaConvenio / 100, 2)
                                Else
                                    mImpuestoRetenido = Math.Round(mBaseIIBB * mAlicuota / 100, 2)
                                End If
                                mImpuestoAdicional = Math.Round(mImpuestoRetenido * mPorcentajeAdicional / 100, 2)
                                mImpuestoRetenido = mImpuestoRetenido + mImpuestoAdicional
                                mImpuestoRetenido = mImpuestoRetenido - .RetencionesMes
                                If mImpuestoRetenido < 0 Then mImpuestoRetenido = 0
                            End If
                            .ImpuestoRetenido = mImpuestoRetenido
                            If mCoeficienteUnificado > 0 And mCoeficienteUnificado <= 100 Then
                                .PorcentajeATomarSobreBase = mCoeficienteUnificado
                            Else
                                .PorcentajeATomarSobreBase = mPorcentajeATomarSobreBase
                            End If
                            .PorcentajeAdicional = mPorcentajeAdicional
                            .ImpuestoAdicional = mImpuestoAdicional
                            .PorcentajeATomarSobreBase = mPorcentajeATomarSobreBase
                            .PorcentajeAdicional = mPorcentajeAdicional
                            '.LeyendaPorcentajeAdicional = mLeyendaPorcentajeAdicional
                            .ImpuestoAdicional = mImpuestoAdicional
                            .ImpuestoRetenido = mImpuestoRetenido
                            If mAplicarAlicuotaConvenio And Not mAplicarAlicuotaDirecta Then
                                .AlicuotaAplicada = Nothing
                                .AlicuotaConvenioAplicada = mAlicuotaConvenio
                            Else
                                .AlicuotaAplicada = mAlicuota
                                .AlicuotaConvenioAplicada = Nothing
                            End If
                        End If
                    End If
                End With
            End If
        Next


        RefrescarDesnormalizados(SC, myOP)


Salida:

        'oRs.Close()

        'oRs = Nothing
        oRsAux = Nothing
        oRsAux1 = Nothing
        oC = Nothing
        oFld = Nothing


    End Sub





    Shared Sub RefrescarDesnormalizados(ByVal sc As String, ByRef myOP As OrdenPago)
        'en parte, esto de RefrescarDesnormalizados es lo de RegistrosConFormato


        With myOP

            For Each i In .DetallesImpuestos
                With i

                    If .IdTipoRetencionGanancia > 0 Then
                        .Categoria = GetStoreProcedureTop1(sc, enumSPs.TiposRetencionGanancia_T, .IdTipoRetencionGanancia).Item("Descripcion")
                    ElseIf .IdIBCondicion > 0 Then
                        .Categoria = GetStoreProcedureTop1(sc, enumSPs.IBCondiciones_T, .IdIBCondicion).Item("Descripcion")
                    Else

                    End If

                End With
            Next

            If Not IsNothing(.DetallesImputaciones) Then
                For Each i In .DetallesImputaciones
                    If i.IdImputacion > 0 Then
                        Try
                            Dim dr As DataRow = CtaCteAcreedorManager.TraerMetadata(sc, i.IdImputacion).Rows(0)
                            i.TipoComprobanteImputado = EntidadManager.TipoComprobanteAbreviatura(dr.Item("IdTipoComp"))
                            i.TipoComprobanteImputado = GetStoreProcedureTop1(sc, enumSPs.TiposComprobante_T, dr.Item("IdTipoComp")).Item("DescripcionAb")
                            i.NumeroComprobanteImputado = EntidadManager.NombreComprobante(sc, dr.Item("IdTipoComp"), dr.Item("IdComprobante"))
                            If dr.Item("IdTipoComp") = 11 Then
                                Dim a = GetStoreProcedureTop1(sc, enumSPs.ComprobantesProveedores_T, dr.Item("IdComprobante"))
                                i.ComprobanteImputadoNumeroConDescripcionCompleta = i.TipoComprobanteImputado & " " & a.Item("Letra") & " " & a.Item("NumeroComprobante1") & "-" & a.Item("NumeroComprobante2")
                            End If

                        Catch ex As Exception

                        End Try
                    Else
                        i.TipoComprobanteImputado = "PA" 'pagoanticipado
                    End If


                    If i.ComprobanteImputadoNumeroConDescripcionCompleta = "" Or i.ComprobanteImputadoNumeroConDescripcionCompleta = "0" Then
                        i.ComprobanteImputadoNumeroConDescripcionCompleta = i.TipoComprobanteImputado & " " & i.NumeroComprobanteImputado
                    End If



                    With i


                        Dim mIdMoneda = myOP.IdMoneda
                        Dim oRsAux As adodb.Recordset
                        Dim mImportePagadoSinImpuestos As Double, mTotalBruto As Double
                        Dim MonedaGeneraImpuesto As String
                        Dim mIdOrdenPago As Long, mIdMonedaPesos As Integer, mIdMonedaDolar As Integer, mIdMonedaEuro As Integer
                        Dim mIvaCredito As Double

                        Dim p = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(sc)
                        With p
                            mIdMonedaPesos = iisNull(.Item("IdMoneda"), 1)
                            mIdMonedaDolar = iisNull(.Item("IdMonedaDolar"), 2)
                            mIdMonedaEuro = iisNull(.Item("IdMonedaEuro"), 2)
                        End With
                        oRsAux = TraerFiltradoVB6(sc, enumSPs.Monedas_T, mIdMoneda)
                        If IsNull(oRsAux.Fields("GeneraImpuestos").Value) Or _
                              oRsAux.Fields("GeneraImpuestos").Value = "NO" Then
                            MonedaGeneraImpuesto = "NO"
                        Else
                            MonedaGeneraImpuesto = "SI"
                        End If



                        If .IdImputacion <> 0 Then
                            If .IdImputacion = -1 Then
                                .TipoComprobanteImputado = "PA"
                                .Saldo = .Importe
                                If .IdIBCondicion > 0 Then
                                    oRsAux = TraerFiltrado(sc, enumSPs.IBCondiciones_TX_PorId, .IdIBCondicion)
                                    If oRsAux.RecordCount > 0 Then
                                        .BaseCalculoIIBB = oRsAux.Fields("BaseCalculo").Value
                                    End If
                                    oRsAux.Close()
                                End If
                            ElseIf .IdImputacion = -2 Then
                                .TipoComprobanteImputado = "CO"
                                .Saldo = .Importe
                            Else

                                Dim oRsCtaCte = TraerFiltradoVB6(sc, enumSPs.CtasCtesA_T, .IdImputacion)
                                If Not IsNull(oRsCtaCte.Fields("IdTipoComp").Value) Then
                                    Dim oRsComp = TraerFiltradoVB6(sc, enumSPs.TiposComprobante_T, oRsCtaCte.Fields("IdTipoComp").Value)
                                    Dim oRsComp1 = TraerFiltradoVB6(sc, enumSPs.ComprobantesProveedores_TX_PorIdConDatos, oRsCtaCte.Fields("IdComprobante").Value)
                                    .TipoComprobanteImputado = oRsComp.Fields("DescripcionAb").Value
                                    .FechaComprobanteImputado = oRsCtaCte.Fields("Fecha").Value
                                    If mIdMoneda = mIdMonedaPesos Then
                                        .Imp = oRsCtaCte.Fields("ImporteTotal").Value * oRsComp.Fields("Coeficiente").Value
                                        .Saldo = oRsCtaCte.Fields("Saldo").Value * oRsComp.Fields("Coeficiente").Value
                                    ElseIf mIdMoneda = mIdMonedaDolar Then
                                        .Imp = oRsCtaCte.Fields("ImporteTotalDolar").Value * oRsComp.Fields("Coeficiente").Value
                                        .Saldo = oRsCtaCte.Fields("SaldoDolar").Value * oRsComp.Fields("Coeficiente").Value
                                    ElseIf mIdMoneda = mIdMonedaEuro Then
                                        .Imp = oRsCtaCte.Fields("ImporteTotalEuro").Value * oRsComp.Fields("Coeficiente").Value
                                        .Saldo = oRsCtaCte.Fields("SaldoEuro").Value * oRsComp.Fields("Coeficiente").Value
                                    Else
                                        If oRsComp1.RecordCount > 0 Then
                                            .Imp = Math.Round(oRsCtaCte.Fields("ImporteTotal").Value * _
                                                            oRsComp.Fields("Coeficiente").Value / _
                                                            IIf(IsNull(oRsComp1.Fields("CotizacionMoneda").Value), 1, oRsComp1.Fields("CotizacionMoneda").Value), 2)
                                            .Saldo = Math.Round(oRsCtaCte.Fields("Saldo").Value * _
                                                            oRsComp.Fields("Coeficiente").Value / _
                                                            IIf(IsNull(oRsComp1.Fields("CotizacionMoneda").Value), 1, oRsComp1.Fields("CotizacionMoneda").Value), 2)
                                        End If
                                    End If
                                    If Not IsNull(oRsComp.Fields("Agrupacion1").Value) And oRsComp.Fields("Agrupacion1").Value = "PROVEEDORES" Then
                                        If oRsComp1.RecordCount > 0 Then
                                            mTotalBruto = IIf(IsNull(oRsComp1.Fields("TotalBruto").Value), 0, oRsComp1.Fields("TotalBruto").Value) - _
                                                           IIf(IsNull(oRsComp1.Fields("RestarAlBruto").Value), 0, oRsComp1.Fields("RestarAlBruto").Value)
                                            .Numero = oRsComp1.Fields("Letra").Value & "-" & _
                                                     FormatVB6(oRsComp1.Fields("NumeroComprobante1").Value, "0000") & "-" & _
                                                     FormatVB6(oRsComp1.Fields("NumeroComprobante2").Value, "00000000")

                                            .IdTipoRetencionGanancia = iisNull(oRsComp1.Fields("IdTipoRetencionGanancia").Value, -1)
                                            .IdIBCondicion = oRsComp1.Fields("IdIBCondicion").Value
                                            .PorcentajeIVAParaMonotributistas = iisNull(oRsComp1.Fields("PorcentajeIVAParaMonotributistas").Value, 0)
                                            If mTotalBruto = 0 Then
                                                ._ImportePagadoSinImpuestos = 0
                                                .GravadoIVA = 0
                                            End If
                                            If MonedaGeneraImpuesto = "SI" And oRsCtaCte.Fields("ImporteTotal").Value <> 0 And mTotalBruto <> 0 Then
                                                mImportePagadoSinImpuestos = (.Importe * _
                                                      (IIf(IsNull(oRsComp1.Fields("GravadoIVA").Value), 0, oRsComp1.Fields("GravadoIVA").Value) * _
                                                      oRsComp1.Fields("CotizacionMoneda").Value) / oRsCtaCte.Fields("ImporteTotal").Value)
                                                .GravadoIVA = mImportePagadoSinImpuestos
                                                mImportePagadoSinImpuestos = (.Importe * _
                                                               (mTotalBruto * oRsComp1.Fields("CotizacionMoneda").Value) / _
                                                               oRsCtaCte.Fields("ImporteTotal").Value)
                                                .ImportePagadoSinImpuestos = mImportePagadoSinImpuestos
                                                If oRsComp.Fields("Coeficiente").Value = 1 Then
                                                    mIvaCredito = IIf(IsNull(oRsComp1.Fields("IvaCreditos").Value), 0, oRsComp1.Fields("IvaCreditos").Value)
                                                    If (oRsComp1.Fields("TotalIva1").Value * oRsComp1.Fields("CotizacionMoneda").Value) - mIvaCredito > 0 Then
                                                        .IVA = (oRsComp1.Fields("TotalIva1").Value * oRsComp1.Fields("CotizacionMoneda").Value) - mIvaCredito
                                                    Else
                                                        .IVA = 0
                                                    End If
                                                    .TotalComprobanteImputado = oRsComp1.Fields("TotalComprobante").Value * oRsComp1.Fields("CotizacionMoneda").Value
                                                End If
                                                If Not IsNull(oRsComp1.Fields("BienesOServicios").Value) Then
                                                    .Bien_o_Servicio = oRsComp1.Fields("BienesOServicios").Value
                                                Else
                                                    oRsAux = TraerFiltradoVB6(sc, enumSPs.Proveedores_T, oRsCtaCte.Fields("IdProveedor").Value)
                                                    If oRsAux.RecordCount > 0 Then
                                                        If Not IsNull(oRsAux.Fields("BienesOServicios").Value) Then
                                                            .Bien_o_Servicio = oRsAux.Fields("BienesOServicios").Value
                                                        End If
                                                    End If
                                                    oRsAux.Close()
                                                End If
                                                If Not IsNull(oRsComp1.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value) Then
                                                    oRsAux = TraerFiltradoVB6(sc, enumSPs.OrdenesPago_TX_PorIdDetalleOrdenPago, oRsComp1.Fields("IdDetalleOrdenPagoRetencionIVAAplicada").Value)
                                                    If oRsAux.RecordCount > 0 Then
                                                        .RetIVAenOP = oRsAux.Fields("NumeroOrdenPago").Value
                                                    End If
                                                    oRsAux.Close()
                                                End If
                                            End If
                                            If Not IsNull(oRsComp1.Fields("IdIBCondicion").Value) Then
                                                oRsAux = TraerFiltradoVB6(sc, enumSPs.IBCondiciones_TX_PorId, oRsComp1.Fields("IdIBCondicion").Value)
                                                If oRsAux.RecordCount > 0 Then
                                                    .BaseCalculoIIBB = oRsAux.Fields("BaseCalculo").Value
                                                End If
                                                oRsAux.Close()
                                            End If
                                        End If
                                    Else
                                        .ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & "-" & _
                                                                FormatVB6(oRsCtaCte.Fields("NumeroComprobante").Value, "00000000")
                                    End If
                                    oRsComp1.Close()
                                    oRsComp1 = Nothing
                                    oRsComp.Close()
                                    oRsComp = Nothing
                                End If




                                '        oRsCtaCte.Close()
                                '        oRsCtaCte = Nothing
                                '        oRsAux = Nothing
                                '        oRsAux1 = Nothing
                            End If
                            '    oRsFmt.Fields("Importe").Value = oC.Registro.Fields("Importe").Value
                        End If



                    End With


                Next
            End If

            If Not IsNothing(.DetallesCuentas) Then
                For Each i In .DetallesCuentas
                    i.DescripcionCuenta = EntidadManager.NombreCuenta(sc, i.IdCuenta)
                Next
            End If

            If Not IsNothing(.DetallesValores) Then
                For Each i In .DetallesValores
                    i.Tipo = EntidadManager.NombreValorTipo(sc, i.IdTipoValor)
                Next
            End If

            If Not IsNothing(.DetallesRubrosContables) Then
                For Each i In .DetallesRubrosContables
                    i.DescripcionRubroContable = EntidadManager.NombreRubroContable(sc, i.IdRubroContable)
                Next
            End If

        End With
    End Sub


    Public Shared Function ProximoNumeroCheque(ByVal sc As String, ByRef myOP As OrdenPago, ByVal IdBancoChequera As Long) As Long

        Dim oSrv As Pronto.ERP.Bll.ICompMTSManager
        Dim oRs As ADODB.Recordset
        Dim mOk As Boolean
        Dim mNroChq As Long


        mNroChq = 1
        oRs = TraerFiltradoVB6(sc, enumSPs.BancoChequeras_TX_PorId, IdBancoChequera)
        If oRs.RecordCount > 0 Then
            If Not IsNull(oRs.Fields("ProximoNumeroCheque").Value) Then
                mNroChq = oRs.Fields("ProximoNumeroCheque").Value
            End If
        End If
        oRs.Close()


        mOk = True
        Do While mOk
            mOk = False
            For Each i In myOP.DetallesValores
                If i.IdBancoChequera = IdBancoChequera And _
                      i.NumeroValor = mNroChq And _
                      Not i.Eliminado Then
                    mOk = True
                    mNroChq = mNroChq + 1
                    Exit Do
                End If
            Next
        Loop

        oRs = Nothing
        oSrv = Nothing

        ProximoNumeroCheque = mNroChq

    End Function

End Class