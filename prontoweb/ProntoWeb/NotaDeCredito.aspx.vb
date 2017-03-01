
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
Imports System.Linq
Imports Pronto.ERP.Bll.EntidadManager

Imports CartaDePorteManager



Partial Class NotaDeCreditoABM
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'Cuidadito con las variables de modulo que no se guardan en el ViewState!!!
    '////////////////////////////////////////////////////////////////////////////////////

    Private DIRFTP As String = "C:\"

    Private IdNotaDeCredito As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdNotaDeCredito"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdNotaDeCredito") = Value
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
            IdNotaDeCredito = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdNotaDeCredito
        End If
        mKey = "NotaDeCredito_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        SC = usuario.StringConnection
        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion

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
            PanelDetalle.Attributes("style") = "display:none"
            PanelInfoNum.Attributes("style") = "display:none"
            Panel1.Attributes("style") = "display:none"
            Panel2.Attributes("style") = "display:none"
            'Panel4.Attributes("style") = "display:none"
            Panel5.Attributes("style") = "display:none"
            'PopupGrillaSolicitudes.Attributes("style") = "display:none"
            '///////////////////////////



            'Carga del objeto
            TextBox1.Text = IdNotaDeCredito
            BindTypeDropDown()


            Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito
            If IdNotaDeCredito > 0 Then
                myNotaDeCredito = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myNotaDeCredito = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    myNotaDeCredito = AltaSetup()
                End If
            End If



            Me.ViewState.Add(mKey, myNotaDeCredito)



            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")



            BloqueosDeEdicion(myNotaDeCredito)



        End If




        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(LinkImprimirXML)

        '////////////////////////////////

        'RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        'txtRendicion.Enabled = False

        'refresco
        'btnTraerDatos_Click(Nothing, Nothing)

        Me.Title = ViewState("PaginaTitulo") 'lo estoy perdiendo, así que guardo el titulo en el viewstate

    End Sub


    Sub BloqueosDeEdicion(ByVal myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito)
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
            'txtNumeroNotaDeCredito1.Enabled = False
            txtNumeroNotaDeCredito2.Enabled = False
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
            'btnLiberar.Enabled = False
            txtCodigo.Enabled = False
            'txtTotBonif.Enabled = False



            'detalle
            LinkAgregarRenglon.Enabled = False
            txt_AC_Articulo.Enabled = False
            txtDetObservaciones.Enabled = False
            'txtDetTotal.Enabled = False
            '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
            'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
            'txtDetCantidad.Enabled = False
            txtDetFechaEntrega.Enabled = False



            'links a popups

            LinkAgregarRenglon.Style.Add("visibility", "hidden")
            'LinkButton1.Style.Add("visibility", "hidden")
            'LinkButton2.Style.Add("visibility", "hidden")
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
        With myNotaDeCredito

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
                    'For Each r As GridViewRow In GridView1.Rows
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
                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'si es un proveedor, deshabilito la edicion


                    ''habilito el eliminar del renglon
                    'For Each r As GridViewRow In GridView1.Rows
                    '    Dim bt As LinkButton
                    '    'bt = r.FindControl("Elim.")
                    '    bt = r.Controls(6).Controls(0) 'el boton eliminar esta dentro de un control datafield
                    '    If Not bt Is Nothing Then
                    '        'bt.Enabled = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '        'bt.Visible = False 'podría ocultar la columna directamente, no? -sí, y tambien la del check
                    '    End If
                    'Next

                    'me fijo si está cerrado
                    DisableControls(Me)
                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True
                    LinkImprimir.Enabled = True
                    LinkImprimirXML.Enabled = True

                    btnAnular.Enabled = True
                    btnAnularOk.Enabled = True
                    btnAnularCancel.Enabled = True
                    cmbUsuarioAnulo.Enabled = True
                    txtAnularMotivo.Enabled = True
                    txtAnularPassword.Enabled = True

                    'encabezado
                    'txtNumeroNotaDeCredito1.Enabled = False
                    txtNumeroNotaDeCredito2.Enabled = False
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
                    'btnLiberar.Enabled = False
                    txtTotBonif.Enabled = False



                    'detalle
                    LinkAgregarRenglon.Enabled = False
                    txt_AC_Articulo.Enabled = False
                    txtDetObservaciones.Enabled = False
                    'txtDetTotal.Enabled = False
                    '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
                    'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
                    'txtDetCantidad.Enabled = False
                    txtTotBonif.Enabled = False
                    txtDetFechaEntrega.Enabled = False



                    'links a popups

                    LinkAgregarRenglon.Style.Add("visibility", "hidden")
                    'LinkButton1.Style.Add("visibility", "hidden")
                    'LinkButton2.Style.Add("visibility", "hidden")
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


                If .anulada = "SI" Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    btnAnular.Visible = False
                    lblAnulado.Visible = True
                    lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & .MotivoAnulacion
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

    Function AltaSetup() As Pronto.ERP.BO.NotaDeCredito


        Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = New Pronto.ERP.BO.NotaDeCredito
        With myNotaDeCredito
            .Id = -1

            RefrescarNumeroTalonario()
            BuscaIDEnCombo(cmbVendedor, session(SESSIONPRONTO_glbIdUsuario))


            'txtNumeroNotaDeCredito2.Text = ParametroOriginal(SC, "ProximoNotaDeCredito")
            txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?

            'txtNumeroNotaDeCredito1.Text = 1

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItem As NotaDeCreditoItem = New Pronto.ERP.BO.NotaDeCreditoItem
            mItem.Id = -1
            mItem.Nuevo = True
            mItem.Eliminado = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing


            .Detalles.Add(mItem)
            GridView1.DataSource = .Detalles 'este bind lo copié
            GridView1.DataBind()             'este bind lo copié   

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim mItemImp As NotaDeCreditoImpItem = New NotaDeCreditoImpItem
            mItemImp.Id = -1
            mItemImp.Nuevo = True
            mItemImp.Eliminado = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing


            .DetallesImp.Add(mItemImp)
            gvImputaciones.DataSource = .DetallesImp 'este bind lo copié
            gvImputaciones.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////


            Dim mItemImpOC As NotaDeCreditoOCItem = New NotaDeCreditoOCItem
            mItemImpOC.Id = -1
            mItemImpOC.Nuevo = True
            mItemImpOC.Eliminado = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing


            .DetallesOC.Add(mItemImpOC)
            gvOCimputaciones.DataSource = .DetallesOC 'este bind lo copié
            gvOCimputaciones.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////


            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If


            'txtReferencia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNotaDeCreditoReferencia").ToString
            'txtFechaNotaDeCredito.Text = System.DateTime.Now.ToShortDateString()


            ViewState("PaginaTitulo") = "Nueva Nota de crédito"
        End With

        Return myNotaDeCredito
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As Pronto.ERP.BO.NotaDeCredito
        'los textbox que no se refresquen ponelos en un UpdatePanel

        Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito

        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?
            myNotaDeCredito = NotaDeCreditoManager.GetItem(SC, IdNotaDeCredito, True) 'va a editar ese ID
            'myNotaDeCredito = NotaDeCreditoManager.GetItemComPronto(SC, IdNotaDeCredito, True)
        Else
            'está haciendo un alta, pero uso los datos de un ID existente
            myNotaDeCredito = NotaDeCreditoManager.GetCopyOfItem(SC, CopiaDeOtroId)
            IdNotaDeCredito = -1
            'tomar el ultimo de la serie y sumarle uno


            'myNotaDeCredito.SubNumero = NotaDeCreditoManager.ProximoSubNumero(SC, myNotaDeCredito.Numero)

            'limpiar los precios del NotaDeCredito original
            For Each i In myNotaDeCredito.Detalles
                i.ImporteTotalItem = 0
            Next

            'mKey = "NotaDeCredito_" & Me.IdEntity.ToString 'esto es un balurdo. aclarar bien
        End If


        If Not (myNotaDeCredito Is Nothing) Then
            With myNotaDeCredito

                TraerDatosCliente(myNotaDeCredito.IdCliente)
                RecargarEncabezado(myNotaDeCredito)

                '

                '/////////////////////////
                '/////////////////////////
                'Grilla
                '/////////////////////////
                '/////////////////////////
                'GridView1.Columns(0).Visible = False
                GridView1.DataSource = .Detalles 'pero cómo se mantiene esto, si estoy usando un objeto local de la funcion?
                GridView1.DataBind()

                gvImputaciones.DataSource = .DetallesImp 'este bind lo copié
                gvImputaciones.DataBind()             'este bind lo copié   

                gvOCimputaciones.DataSource = .DetallesOC 'este bind lo copié
                gvOCimputaciones.DataBind()             'este bind lo copié   





                'Me.Title = "Edición Fondo Fijo " + myNotaDeCredito.Letra + myNotaDeCredito.NumeroComprobante1.ToString + myNotaDeCredito.NumeroComprobante2.ToString
                ViewState("PaginaTitulo") = "Edición Nota de crédito " + myNotaDeCredito.Numero.ToString + "/" '+ myNotaDeCredito.SubNumero.ToString
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
                'Me.ViewState.Add(mKey, myNotaDeCredito)

                'vacío el proveedor (porque es una copia)
                'SelectedReceiver.Value = 0
                'txtDescProveedor.Text = ""
            End If

        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdNotaDeCredito & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myNotaDeCredito
    End Function

    Sub RecargarEncabezado(ByVal myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito)
        With myNotaDeCredito
            'txtReferencia.Text = myNotaDeCredito.Referencia
            'txtLetra.Text = myNotaDeCredito.Letra
            'txtNumeroNotaDeCredito1.Text = .SubNumero
            txtNumeroNotaDeCredito2.Text = .Numero
            txtFechaIngreso.Text = .FechaIngreso '.ToString("dd/MM/yyyy")
            'txtFechaAprobado.Text = .FechaAprobacion.ToString("dd/MM/yyyy")
            'txtFechaCierreCompulsa.Text = .FechaCierreCompulsa.ToString("dd/MM/yyyy")
            'txtRendicion.Text = .NumeroRendicionFF


            'txtValidezOferta.Text = .Validez
            'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra

            'BuscaTextoEnCombo(cmbTipoComprobante, .IdTipoComprobante.ToString)
            'txtCUIT.Text = .Proveedor.ToString


            '////////////////////////////////////////////////////////
            'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
            'SelectedReceiver.Value = myNotaDeCredito.IdProveedor
            'txtDescProveedor.Text = myNotaDeCredito.Proveedor
            'TraerDatosProveedor(myNotaDeCredito.IdProveedor) 'guarda con esto, que pisa combos editables (moneda y condicioncompra). Es decir, esta funcion la debo llamar antes que los BuscaIDComboxxxx
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
            BuscaIDEnCombo(cmbPuntoVenta, .IdPuntoVenta)

            'BuscaIDEnCombo(cmbVendedor, .IdVendedor)
            BuscaIDEnCombo(cmbMoneda, .IdMoneda)
            'BuscaIDEnCombo(cmbIVA, .IdCodigoIVA)

            'txtTotal.Text = .Total




            'txtDetalle.Text = .Detalle
            'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra
            txtObservaciones.Text = .Observaciones
            'txtCAI.Text = .NumeroCAI
            'txtFechaVtoCAI.Text = .FechaVencimientoCAI
            'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

            'lnkAdjunto1.Text = .ArchivoAdjunto1
            chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)


            'If myNotaDeCredito.Aprobo <> 0 Then
            '    txtLibero.Text = EmpleadoManager.GetItem(SC, myNotaDeCredito.Aprobo).Nombre
            'End If


            'pero debiera usar el formato universal...
            txtTotBonif.Text = String.Format("{0:F2}", DecimalToString(.Bonificacion))
            txtSubtotal.Text = String.Format("{0:F2}", DecimalToString(.ImporteIva1)) 'o uso {0:c} o {0:F2} ?
            lblTotal.Text = String.Format("{0:F2}", DecimalToString(.ImporteTotal))

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





        IniciaCombo(SC, cmbCondicionVenta, tipos.CondicionCompra)


        IniciaCombo(SC, cmbObra, tipos.Obras)
        IniciaCombo(SC, cmbCategoriaIIBB1, tipos.IBCondiciones)
        IniciaCombo(SC, cmbLibero, tipos.Empleados)
        IniciaCombo(SC, cmbCondicionIVA, tipos.CondicionIVA)
        RefrescarTalonariosDisponibles()

        IniciaCombo(SC, cmbUsuarioAnulo, tipos.Empleados)
        IniciaCombo(SC, cmbListaPrecios, tipos.ListasPrecios)
        IniciaCombo(SC, cmbVendedor, tipos.Vendedores)
        IniciaCombo(SC, cmbMoneda, tipos.Monedas)


        IniciaCombo(SC, cmbDetConcepto, tipos.Conceptos)

        Try
            IniciaCombo(SC, cmbDetCuentaBanco, tipos.CuentasBancarias)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        IniciaCombo(SC, cmbDetCaja, tipos.Cajas)




    End Sub


    Protected Sub txtAutocompleteCliente_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtAutocompleteCliente.TextChanged

        Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)

        With myNotaDeCredito
            If .DetallesImp.Count > .DetallesImp.Where(Function(i) i.Eliminado = True).Count() Then
                txtAutocompleteCliente.Text = ViewState("ClienteAnterior")
                MsgBoxAjax(Me, "Elimine las imputaciones que corresponden a otro cliente")
                Exit Sub
            Else
                ViewState("ClienteAnterior") = txtAutocompleteCliente.Text
                TraerDatosCliente(BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value))

                'si cambia el cliente, vacío las imputaciones
                .DetallesImp.Clear()

                Dim mItem As NotaDeCreditoImpItem = New Pronto.ERP.BO.NotaDeCreditoImpItem
                mItem.Id = -1
                mItem.Nuevo = True
                mItem.Eliminado = True
                .DetallesImp.Add(mItem)

                Me.ViewState.Add(mKey, myNotaDeCredito)
                RebindImp()
            End If
        End With


    End Sub




    Function TraerDatosCliente(ByVal IdCliente As Long)
        Try
            Dim oCli = ClienteManager.GetItem(SC, IdCliente)
            With oCli
                BuscaIDEnCombo(cmbCondicionIVA, EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("IdCodigoIva"))
                txtCUIT.Text = EntidadManager.GetItem(SC, "Clientes", IdCliente).Item("CUIT")
                BuscaIDEnCombo(cmbCondicionVenta, .IdCondicionVenta)

                MostrarDatos(0)

                RefrescarTalonariosDisponibles()
                ReBindGvOCimputadas()

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
        cmbPuntoVenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", EntidadManager.IdTipoComprobante.NotaCredito, lblLetra.Text.ToUpper)
        cmbPuntoVenta.DataTextField = "Titulo"
        cmbPuntoVenta.DataValueField = "IdPuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0

        If cmbPuntoVenta.Items.Count = 0 Then
            MsgBoxAjax(Me, "No hay talonario para notas de credito")
        Else
            'está refrescando el talonario tambien en la "vista". Cómo condicionarlo?
            If IdNotaDeCredito <= 0 Then RefrescarNumeroTalonario()
        End If
    End Sub

    Sub RefrescarNumeroTalonario() 'esto tambien podría estar la mitad en el manager
        'está refrescando el talonario tambien en la "vista". Cómo condicionarlo?

        txtLetra.Text = EntidadManager.LetraSegunTipoIVA(cmbCondicionIVA.SelectedValue)
        lblLetra.Text = txtLetra.Text


        If RadioButtonListEsInterna.SelectedItem.Value = 2 Then
            txtNumeroNotaDeCredito2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaNotaCreditoInterna")
        Else
            txtNumeroNotaDeCredito2.Text = NotaDeCreditoManager.ProximoNumeroNotaCreditoPorIdCodigoIvaYNumeroDePuntoVenta(SC, cmbCondicionIVA.SelectedValue, cmbPuntoVenta.SelectedItem.Text) 'ParametroOriginal(SC, "ProximoFactura")
        End If

        'cmbPuntoVenta.SelectedIndex = 0


    End Sub


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

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

                Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)

                With myNotaDeCredito

                    'traigo parámetros generales
                    Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    '.IdMoneda = drParam.Item("ProximoNotaDeCreditoReferencia").ToString 'mIdMonedaPesos
                    .IdMoneda = cmbMoneda.SelectedValue

                    '.SubNumero = StringToDecimal(txtNumeroNotaDeCredito1.Text)
                    .TipoABC = txtLetra.Text

                    'Qué nombre estandar defino para estas propiedades genericas?
                    .Numero = StringToDecimal(txtNumeroNotaDeCredito2.Text)
                    '.NumeroNotaCredito = StringToDecimal(txtNumeroNotaDeCredito2.Text)
                    .FechaIngreso = txtFechaIngreso.Text
                    .Fecha = txtFechaIngreso.Text
                    '.FechaNotaCredito = txtFechaIngreso.Text



                    '.IdPuntoVenta = cmbPuntoVenta.SelectedValue
                    '.IdPuntoVenta = NotaDeCreditoManager.IdPuntoVentaComprobanteNotaCreditoSegunSubnumeroYLetra(SC, cmbPuntoVenta.Text, txtLetra.Text)
                    .PuntoVenta = cmbPuntoVenta.SelectedItem.Text


                    .IdCliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, SC)
                    .IdCondicionVenta = cmbCondicionVenta.SelectedValue



                    .IdObra = 1

                    '.Validez = txtValidezOferta.Text
                    '.DetalleCondicionCompra = txtDetalleCondicionCompra.Text

                    '.CotizacionMoneda = 1
                    '.CotizacionDolar = Cotizacion(Now, drParam.Item("IdMonedaDolar")) 'mvarCotizacionDolar
                    '.IdOrdenPago = Nothing
                    '.IdUsuarioIngreso = session(SESSIONPRONTO_glbIdUsuario)
                    '.FechaIngreso = txtFechaIngreso.Text
                    '.FechaAprobacion = txtFechaAprobado.Text
                    '.FechaCierreCompulsa = txtFechaCierreCompulsa.Text

                    '.Aprobo = IIf(txtLibero.Text <> "" And txtLibero.Text <> "Password Incorrecta", Convert.ToInt32(cmbLibero.SelectedValue), 0)

                    '.Detalle = txtDetalle.Text
                    '.DetalleCondicionCompra = txtDetalleCondicionCompra.Text
                    .Observaciones = txtObservaciones.Text

                    '.ArchivoAdjunto1 = lnkAdjunto1.Text


                    '.ImporteTotal = .Total ' StringToDecimal(txtTotal.Text)

                    .IdMoneda = 1 ' cmbMoneda.SelectedValue
                    '.IdPlazoEntrega = cmbPlazo.SelectedValue
                    '.IdCondicionCompra = cmbCondicionCompra.SelectedValue
                    .IdComprador = cmbVendedor.SelectedValue
                    '.IdPlazoEntrega = cmbPlazo.SelectedValue

                    '.Bonificacion = StringToDecimal(txtTotBonif.Text)

                    '.NumeroRendicionFF = Convert.ToInt32(txtRendicion.Text)

                    '.NumeroReferencia = Convert.ToInt32(txtReferencia.Text)
                    '.Letra = txtLetra.Text
                    '.NumeroComprobante1 = Convert.ToInt32(txtNumeroNotaDeCredito1.Text)
                    '.NumeroComprobante2 = Convert.ToInt32(txtNumeroNotaDeCredito2.Text)
                    '.FechaComprobante = Convert.ToDateTime(txtFechaNotaDeCredito.Text)
                    '.IdTipoComprobante = cmbTipoComprobante.SelectedValue
                    '.IdProveedorEventual = Convert.ToInt32(SelectedReceiver.Value)
                    '.IdProveedor = Convert.ToInt32(SelectedReceiver.Value)
                    '.IdCuentaOtros = Nothing


                    .ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
                    If .IdComprador = 0 Then .IdComprador = session(SESSIONPRONTO_glbIdUsuario) 'Si lo edita un proveedor, no debe pisar el IdComprador

                    'myNotaDeCredito.Observaciones = Convert.ToString(txtObservaciones.Text) '???
                    .Observaciones = txtObservaciones.Text

                    '.NumeroCAI = txtCAI.Text

                    'If iisValidSqlDate(txtFechaVtoCAI.Text) Is Nothing Then
                    '    .FechaVencimientoCAI = Nothing
                    'Else
                    '    .FechaVencimientoCAI = Convert.ToDateTime(txtFechaVtoCAI.Text)
                    'End If

                    'myNotaDeCredito.IdAprobo = Convert.ToInt32(cmbLibero.SelectedValue)
                    'myNotaDeCredito.LugarEntrega = Convert.ToString(txtLugarEntrega.Text)
                    'myNotaDeCredito.IdComprador = Convert.ToInt32(cmbComprador.SelectedValue)

                    '.IdComprobanteImputado = Nothing



                    AsignaImputacionesOCalObjeto()


                    'If txtLibero.Text <> "" Then
                    '.ConfirmadoPorWeb = "SI"
                    'Else
                    '.ConfirmadoPorWeb = "NO"
                    'End If

                End With




                Dim ms As String
                If NotaDeCreditoManager.IsValid(SC, myNotaDeCredito, ms) Then
                    Try
                        If NotaDeCreditoManager.Save(SC, myNotaDeCredito) = -1 Then
                            MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.ToString)
                    End Try


                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Incremento de número en capa de UI. Evitar.Fields("
                    'esto es lo que está mal. no tenés que aumentarlo si es una edicion! -pero si está idNotaDeCredito=-1! sí, pero puedo ser una alta a partir de una copia
                    'cuando el usuario modifico manualmente el numero, o se está usando una copia de otro comprobante, por
                    'más que sea un alta, no tenés que incrementar el numerador... -En Pronto pasa lo mismo!
                    'If IdNotaDeCredito = -1 And myNotaDeCredito.SubNumero = 1 Then 'es un NotaDeCredito nuevo y TAMBIEN empieza el subnumero
                    '    If GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNotaDeCredito", TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoNotaDeCredito") + 1) = -1 Then
                    '        MsgBoxAjax(Me, "Hubo un error al modificar los parámetros")
                    '    End If
                    'End If





                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    IdNotaDeCredito = myNotaDeCredito.Id

                    If myNotaDeCredito.Numero <> StringToDecimal(txtNumeroNotaDeCredito2.Text) Then
                        EndEditing("La Nota de credito fue grabada con el número " & myNotaDeCredito.Numero & " . Desea imprimir el comprobante?") 'me voy 
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
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "El objeto no es válido. " & ex.ToString)

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
            Response.Redirect(String.Format("NotaDeCreditos.aspx"))
        End If
    End Sub

    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("NotaDeCreditos.aspx?Imprimir=" & IdNotaDeCredito))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("NotaDeCreditos.aspx")) 'roundtrip al cuete?
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
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleNotaDeCredito") = -1
        'cmbCuentaGasto.SelectedIndex = 1
        'txtCodigo.Text = 0
        txt_AC_Articulo.Text = ""
        SelectedAutoCompleteIDArticulo.Value = 0
        'txtDetCantidad.Text = 0
        'MostrarElementos(True) 'si no se usa el popup


        'Dim eselprimero As Boolean = False
        'If Not eselprimero Then 'creo un nuevo renglon
        '    ViewState("IdDetalleNotaDeCredito") = -1
        '    cmbCuentaGasto.SelectedIndex = 1
        '    txtCodigo.Text = 0
        '    txtCantidad.Text = 0
        '    MostrarElementos(True)
        'Else 'uso el vacío por default
        '    'GridView1_RowCommand()
        'End If


        'Cuando agrega un renglon, deshabilito algunos combos
        'cmbObra.Enabled = False
        'cmbCuenta.Enabled = False

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

                'Dim b As LinkButton = e.Row.Cells(5).Controls(0)
                'b.Text = "Restaurar" 'reemplazo el texto del eliminado

                Dim b As ImageButton = e.Row.Cells(4).Controls(0)
                b.ImageUrl = "../Imagenes/reestablecer.png" 'reemplazo el texto del eliminado
            End If
        End If
    End Sub



    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="Modo"></param>
    ''' <remarks></remarks>
    Private Sub MostrarElementos(ByVal Modo As Boolean)
        'esta funcion no debe usarse si uso un modalpopup
        Exit Sub
        'PanelDetalle.Visible = Modo
        'txtDetCantidad.Visible = Modo
        ''txtFechaNecesidad.Visible = Modo
        ''txtObservacionesItem.Visible = Modo
        ''txtCodigo.Visible = Modo
        ''cmbArticulos.Visible = Modo
        ''        RadioButtonList1.Visible = Modo
        'lblCantidad.Visible = Modo
        ''        lblFechaNecesidad.Visible = Modo
        ''lblArticulo.Visible = Modo
        ''lblObservaciones.Visible = Modo
        'btnSaveItem.Visible = Modo
        'btnCancelItem.Visible = Modo
        'btnSave.Enabled = Not Modo
        'btnCancel.Enabled = Not Modo
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    'Eventos de Grilla de Detalle: Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myNotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)

                    'si esta eliminado, lo restaura
                    myNotaDeCredito.Detalles(mIdItem).Eliminado = Not myNotaDeCredito.Detalles(mIdItem).Eliminado

                    Me.ViewState.Add(mKey, myNotaDeCredito)
                    GridView1.DataSource = myNotaDeCredito.Detalles
                    GridView1.DataBind()
                End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleNotaDeCredito") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myNotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)
                    With myNotaDeCredito.Detalles(mIdItem)
                        'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                        .Eliminado = False


                        'txtDetObservaciones.Text = .Observaciones

                        '////////////////////////////////////////////////////////////////////////////////
                        'HAY QUE ARREGLAR ESTO: me lo tiene que dar directamente el BO.NotaDeCredito
                        'txtDescProveedor = myNotaDeCredito.Detalles(mIdItem).descripcion
                        'Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", .IdArticulo)
                        'If ds.Tables(0).Rows.Count > 0 Then
                        '    'txtDescProveedor.Text = ds.Tables(0).Rows(0).Item("Descripcion").ToString
                        'End If
                        '////////////////////////////////////////////////////////////////////////////////

                        'If .IdArticulo > 0 Then txtCodigo.Text = ArticuloManager.GetItem(SC, .IdArticulo).Codigo

                        'SelectedAutoCompleteIDArticulo.Value = .IdArticulo
                        'txt_AC_Articulo.Text = .Articulo

                        '////////////////////////////////////////////////////////////////////////////////
                        'elige en combos
                        '////////////////////////////////////////////////////////////////////////////////
                        'BuscaIDEnCombo(cmbDetUnidades, .IdUnidad)
                        'BuscaIDEnCombo(cmbCuentaGasto, .Detalles(mIdItem).IdCuentaGasto.ToString)
                        'BuscaIDEnCombo(cmbDestino, .Detalles(mIdItem).IdDetalleObraDestino)
                        '////////////////////////////////////////////////////////////////////////////////


                        BuscaIDEnCombo(cmbDetConcepto, .IdConcepto)
                        BuscaIDEnCombo(cmbDetCaja, .IdCaja)
                        'BuscaIDEnCombo(, .IdUnidad)
                        RadioButtonListGravado.SelectedItem.Value = IIf(.Gravado = "SI", 0, 1)




                        'txtDetFechaEntrega.Text = .FechaEntrega
                        'txtCodigo.Text = .Detalles(mIdItem).CodigoCuenta
                        'txtDetCantidad.Text = DecimalToString(.Cantidad)
                        txtImporte.Text = DecimalToString(.ImporteTotalItem)
                        'txtDetIVA.Text = DecimalToString(.PorcentajeIVA)
                        'txtDetBonif.Text = DecimalToString(._PorcentajeBonificacion)


                        'txtDetTotal.Text = .ImporteTotalItem
                        'txtDetTotal.Text = .Cantidad * .Precio * .ImporteIVA

                        'cmbIVA.Text = DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1)
                        'BuscaTextoEnCombo(cmbIVA, DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1))

                        'If .ArchivoAdjunto1 <> "" Then
                        '    Dim MyFile1 As New FileInfo(.ArchivoAdjunto1)
                        '    If MyFile1.Exists Then
                        '        lnkDetAdjunto1.Text = .ArchivoAdjunto1 + " (" + MyFile1.Length.ToString + " bytes)"
                        '        lnkDetAdjunto1.ToolTip = .ArchivoAdjunto1
                        '        lnkDetAdjunto1.Enabled = True
                        '    Else
                        '        lnkDetAdjunto1.Text = "No se encuentra el archivo " + .ArchivoAdjunto1
                        '        lnkDetAdjunto1.Enabled = False
                        '    End If
                        'Else
                        '    lnkDetAdjunto1.Text = "Vacío"
                        '    lnkDetAdjunto1.ToolTip = ""
                        '    lnkDetAdjunto1.Enabled = False
                        'End If

                        'If .ArchivoAdjunto2 <> "" Then
                        '    Dim MyFile2 As New FileInfo(.ArchivoAdjunto2)
                        '    If MyFile2.Exists Then
                        '        lnkDetAdjunto2.Text = .ArchivoAdjunto2 + " (" + MyFile2.Length.ToString + " bytes)"
                        '        lnkDetAdjunto2.ToolTip = .ArchivoAdjunto2
                        '        lnkDetAdjunto2.Enabled = True
                        '    Else
                        '        lnkDetAdjunto2.Text = "No se encuentra el archivo " + .ArchivoAdjunto2
                        '        lnkDetAdjunto2.Enabled = False
                        '    End If
                        'Else
                        '    lnkDetAdjunto2.Text = "Vacío"
                        '    lnkDetAdjunto2.ToolTip = ""
                        '    lnkDetAdjunto2.Enabled = False
                        'End If

                        'txtObservacionesItem.Text = myNotaDeCredito.Detalles(mIdItem).Observaciones.ToString
                        'txtFechaNecesidad.Text = myNotaDeCredito.Detalles(mIdItem).FechaEntrega.ToString
                        'If myNotaDeCredito.Detalles(mIdItem).OrigenDescripcion = 1 Then
                        '    RadioButtonList1.Items(0).Selected = True
                        'ElseIf myNotaDeCredito.Detalles(mIdItem).OrigenDescripcion = 2 Then
                        '    RadioButtonList1.Items(1).Selected = True
                        'ElseIf myNotaDeCredito.Detalles(mIdItem).OrigenDescripcion = 3 Then
                        '    RadioButtonList1.Items(2).Selected = True
                        'Else
                        '    RadioButtonList1.Items(0).Selected = True
                        'End If
                    End With

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




    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleNotaDeCredito"), Integer)
            Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem As NotaDeCreditoItem = New Pronto.ERP.BO.NotaDeCreditoItem

                If myNotaDeCredito.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myNotaDeCredito.Detalles.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myNotaDeCredito.Detalles.Add(mItem)
            End If


            RecalcularTotalDetalle()


            Try
                With myNotaDeCredito.Detalles(mIdItem)
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
                    '.Precio = StringToDecimal(txtImporte.Text)
                    '.PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
                    '.PorcentajeIVA = StringToDecimal(txtDetIVA.Text)

                    '.ImporteTotalItem = StringToDecimal(txtDetTotal.Text)
                    '.IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)
                    '.Unidad = cmbDetUnidades.SelectedItem.Text
                    '.ArchivoAdjunto1 = FileUpLoad2.FileName


                    .IdConcepto = cmbDetConcepto.SelectedValue
                    .Concepto = cmbDetConcepto.SelectedItem.Text
                    .ImporteTotalItem = StringToDecimal(txtImporte.Text)
                    .IdCaja = cmbDetCaja.SelectedValue
                    .Gravado = IIf(RadioButtonListGravado.SelectedItem.Value = 1, "SI", "NO")

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

                    'Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorObraCuentaGasto", .IdObra, .IdCuentaGasto, DBNull.Value)
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
                    Dim drparam As Data.DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
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

            RecalcularTotalComprobante()

            Me.ViewState.Add(mKey, myNotaDeCredito)
            GridView1.DataSource = myNotaDeCredito.Detalles
            GridView1.DataBind()

            UpdatePanelGrilla.Update()

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
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", Id)
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
    '        Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorCodigo", txtCodigo.Text)
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
        '    Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Empleados", "T", cmbLibero.SelectedValue)
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


    Protected Sub btnRecalcularTotal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecalcularTotal.Click ', txtDetCantidad.TextChanged, txtDetBonif.TextChanged, txtImporte.TextChanged
        RecalcularTotalDetalle()
    End Sub

    Sub RecalcularTotalDetalle()
        'txtDetTotal.Text = 2432.4

        'Dim mImporte = StringToDecimal(txtDetCantidad.Text) * StringToDecimal(txtImporte.Text)
        'Dim mBonificacion = Math.Round(mImporte * Val(txtDetBonif.Text) / 100, 4)
        'Dim mIVA = Math.Round((mImporte - mBonificacion) * Val(txtDetIVA.Text) / 100, 4)
        'txtDetTotal.Text = FF2(mImporte - mBonificacion + mIVA)

        'UpdatePanelDetallePreciosYCantidades.Update()
    End Sub

    'Protected Sub txtDetCantidad_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetCantidad.TextChanged
    '    RecalcularTotalDetalle()
    'End Sub

    Protected Sub txtImporte_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtImporte.TextChanged
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
        Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)
        Try
            'myNotaDeCredito.Bonificacion = StringToDecimal(txtTotBonif.Text)
            myNotaDeCredito.PorcentajeIva1 = IIf(lblLetra.Text = "A", 21, 0) 'HORROR!

            NotaDeCreditoManager.RecalcularTotales(myNotaDeCredito)
            With myNotaDeCredito
                txtSubtotal.Text = FF2(.SubTotal)
                'txtBonificacionPorItem.Text = FF2(.TotalBonifEnItems)
                'lblTotBonif.Text = FF2(.TotalBonifSobreElTotal)
                'lblTotSubGravado.Text = FF2(.TotalSubGravado)
                lblTotIVA.Text = FF2(.ImporteIva1)
                lblPercepcionIVA.Text = FF2(.PercepcionIVA)
                lblTotal.Text = FF2(.ImporteTotal)


                Try
                    'está explotando cuando veo recibos que se grabaron 
                    'sin valores, y entonces la grilla no tiene pie, y entonces esssplota
                    gvImputaciones.FooterRow.Cells(3).Text = .TotalImputaciones
                Catch ex As Exception

                End Try
            End With

            UpdatePanelTotales.Update()

        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
        End Try
    End Sub









    'Protected Sub btnLiberar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
    '    'Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)
    '    'myNotaDeCredito.ConfirmadoPorWeb = "SI"


    '    Dim mOk As Boolean
    '    Page.Validate("Encabezado")
    '    mOk = Page.IsValid

    '    Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)
    '    If Not NotaDeCreditoManager.IsValid(myNotaDeCredito) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
    '        mOk = False
    '        MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
    '    End If
    '    If mOk Then
    '        ModalPopupExtender4.Show()
    '    Else
    '        'MsgBoxAjax(Me, "El objeto no es válido")
    '    End If
    '    'myNotaDeCredito.Aprobo = "SI" 'este es cuando lo aprueba el usario pronto
    'End Sub



    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    'Grilla Popup de Consulta de items de RMs pendientes
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////



    'Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
    '    ObjGrillaConsulta.FilterExpression = "Convert([Req.Nro.], 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
    '                                         & " OR " & _
    '                                         "Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    'End Sub










    '////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////





    Protected Sub gvOCimputaciones_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvOCimputaciones.RowCommand
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

















    Protected Sub gvImputaciones_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvImputaciones.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myNotaDeCredito As NotaDeCredito

        Try
            If e.CommandName.ToLower = "eliminar" Then
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    myNotaDeCredito = CType(Me.ViewState(mKey), NotaDeCredito)

                    'si esta eliminado, lo restaura
                    myNotaDeCredito.DetallesImp(mIdItem).Eliminado = Not myNotaDeCredito.DetallesImp(mIdItem).Eliminado


                    Me.ViewState.Add(mKey, myNotaDeCredito)
                    gvImputaciones.DataSource = myNotaDeCredito.DetallesImp
                    gvImputaciones.DataBind()

                    UpdatePanelImputaciones.Update()
                    'RecalcularRegistroContable()
                    'RecalcularTotalComprobante()

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
                    Dim b As ImageButton = gvImputaciones.Rows(e.CommandArgument).Cells(5).Controls(0)
                    b.ImageUrl = "../Imagenes/editar.png"
                Else
                    'quiere editar
                    gvImputaciones.EditIndex = e.CommandArgument
                    Dim b As ImageButton = gvImputaciones.Rows(e.CommandArgument).Cells(5).Controls(0)
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
                    myNotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)
                    With myNotaDeCredito.DetallesImp(mIdItem)
                        .Importe = TextoWebControl(gvImputaciones.Rows(mIdItem).FindControl("txtGvImputacionesImporte"))
                    End With


                    Me.ViewState.Add(mKey, myNotaDeCredito)
                    gvImputaciones.DataSource = myNotaDeCredito.DetallesImp
                    gvImputaciones.DataBind()
                    UpdatePanelImputaciones.Update()
                    mAltaItem = True

                    'RecalcularRegistroContable()
                    'RecalcularTotalComprobante()
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
                Try
                    Dim b As ImageButton = e.Row.Cells(6).Controls(0)
                    b.ImageUrl = "../Imagenes/reestablecer.png" 'reemplazo el texto del eliminado
                Catch ex As Exception

                End Try


            End If
        End If
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
                .ImporteTotalItem = TextoWebControl(gvImputaciones.Rows(gvr.RowIndex).FindControl("txtGvImputacionesImporte"))
                .Importe = .ImporteTotalItem
            End With



            Me.ViewState.Add(mKey, myRecibo)

            gvImputaciones.EditIndex = -1
            RebindImp()

            gvImputaciones.DataSource = myRecibo.DetallesImputaciones
            gvImputaciones.DataBind()
            UpdatePanelImputaciones.Update()
            mAltaItem = True



            'RecalcularRegistroContable()
            'RecalcularTotalComprobante()
        End If

    End Sub


    Sub RebindImp()
        Dim myNotaDeCredito As NotaDeCredito = CType(Me.ViewState(mKey), NotaDeCredito)
        gvImputaciones.DataSource = myNotaDeCredito.DetallesImp
        gvImputaciones.DataBind()

        gvImputaciones.FooterRow.Cells(3).Text = myNotaDeCredito.TotalImputaciones
        UpdatePanelImputaciones.Update()
    End Sub




    Protected Sub LinkButtonImputacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonImputacion.Click
        RebindAuxPendientesImputar()
        ModalPopupExtenderImputacion.Show()
    End Sub

    Sub RebindAuxPendientesImputar()
        Dim dtv As DataTable '= ObjectDataSource2.Select()

        Dim idcliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value).ToString
        'dtv = EntidadManager.TraerFiltrado(HFSC.Value, enumSPs.CtasCtesD_TXParaImputar, idcliente)
        dtv = CtaCteDeudorManager.GetListTX(HFSC.Value, "ParaImputar", idcliente).Tables(0)

        Dim dt = AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(dtv)
        'gvAuxPendientesImputar.DataSourceID = ""
        gvAuxPendientesImputar.DataSource = dt
        gvAuxPendientesImputar.DataBind()
    End Sub



    Sub ReBindGvOCimputadas()
        Dim dtv As DataTable '= ObjectDataSource2.Select()

        Dim idcliente = BuscaIdClientePreciso(txtAutocompleteCliente.Text, HFSC.Value).ToString
        dtv = EntidadManager.TraerFiltrado(HFSC.Value, enumSPs.OrdenesCompra_TX_PorIdClienteTodosParaCredito, idcliente, -1)
        'dtv = OrdenCompraManager.GetListTXDetallesPendientes(HFSC.Value,  raImputar", idcliente).Tables(0)
        'Dim dt = AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(dtv)
        'gvAuxPendientesImputar.DataSourceID = ""

        Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
        With dc
            .ColumnName = "Eliminado"
            .DataType = System.Type.GetType("System.Int32")
            .DefaultValue = 0
        End With

        dtv.Columns("Cant_").ColumnName = "Cantidad"
        dtv.Columns("O_Compra").ColumnName = "NumeroOrdenCompra"
        dtv.Columns("O_C_(Cli_)").ColumnName = "NumeroOrdenCompraCliente"
        dtv.Columns("Item").ColumnName = "ItemOC"

        dtv.Columns.Add(dc)

        gvOCimputaciones.DataSource = dtv
        gvOCimputaciones.DataBind()
        'UpdatePanel7.Update()
    End Sub



    Private Function AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(ByRef dt As DataTable) As DataView






        'Dim dtCopia As DataTable = dt.Table.Copy 'esto era cuando dt era un dataview
        Dim dtCopia As DataTable = dt

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



    End Function

    'Protected Sub btnSaveItemValor_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemValor.Click

    '    If (Me.ViewState(mKey) IsNot Nothing) Then
    '        Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleRecibo"), Integer)
    '        Dim myRecibo As Pronto.ERP.BO.Recibo = CType(Me.ViewState(mKey), Pronto.ERP.BO.Recibo)

    '        'acá tengo que traer el valor id del hidden


    '        'If txtDetValorCUIT.Enabled And Val(txtDetValorCUIT.Text) <> 0 And Not ProntoMVC.Data.FuncionesGenericasCSharp.mkf_validacuit(Val(txtDetValorCUIT.Text)) Then
    '        '    ModalPopupExtenderValor.Show()
    '        '    MsgBoxAjax(Me, "El CUIT no es valido")
    '        '    Exit Sub
    '        'End If


    '        If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
    '            Dim mItem As ReciboValoresItem = New Pronto.ERP.BO.ReciboValoresItem

    '            If myRecibo.DetallesImputaciones Is Nothing Then 'no debiera ser null si es una edicion, pero...
    '                MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
    '                Exit Sub
    '            End If

    '            mItem.Id = myRecibo.DetallesValores.Count
    '            mItem.Nuevo = True
    '            mIdItem = mItem.Id
    '            myRecibo.DetallesValores.Add(mItem)
    '        End If


    '        'RecalcularTotalDetalle()


    '        Try
    '            With myRecibo.DetallesValores(mIdItem)


    '                '.IdTipoValor = cmbDetValorTipo.SelectedValue
    '                '.Tipo = cmbDetValorTipo.SelectedItem.Text
    '                '.IdBanco = cmbDetValorBancoOrigen.SelectedValue
    '                '.NumeroInterno = Val(txtDetValorNumeroInterno.Text)
    '                '.IdCuentaBancariaTransferencia = cmbDetValorBancoCuenta.SelectedValue
    '                '.NumeroValor = Val(txtDetValorCheque.Text)
    '                '.CuitLibrador = Val(txtDetValorCUIT.Text)
    '                '.NumeroTransferencia = Val(txtDetValorNumeroTransferencia.Text)
    '                '.IdTipoCuentaGrupo = cmbDetValorGrupoCuentaContable.SelectedValue
    '                '.IdCuenta = cmbDetValorCuentaContable.SelectedValue
    '                '.Importe = StringToDecimal(txtDetValorImporte.Text)
    '                '.FechaVencimiento = iisValidSqlDate(txtDetValorVencimiento.Text)


    '                ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoNumeroInterno", .NumeroInterno + 1)


    '                '.ImporteTotalItem = StringToDecimal(txtDetValorImporte.Text)


    '                '///////////////////////////////////////////////////////////////
    '                '///////////////////////////////////////////////////////////////


    '                Dim mIdCuentaIvaCompras1 As Long
    '                'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
    '                Dim drparam As DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
    '                With drparam
    '                    mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
    '                End With





    '            End With
    '        Catch ex As Exception
    '            'lblError.Visible = True
    '            MsgBoxAjax(Me, ex.ToString)
    '            Exit Sub
    '        End Try

    '        'RecalcularTotalComprobante()

    '        Me.ViewState.Add(mKey, myRecibo)
    '        'gvValores.DataSource = myRecibo.DetallesValores
    '        'gvValores.DataBind()

    '        'UpdatePanelAsiento.Update()

    '        'RecalcularRegistroContable()
    '    End If

    '    'MostrarElementos(False)
    '    mAltaItem = True
    'End Sub



    '2 metodos para seleccionar el renglon de la grilla de popup sin hacer postback

    'http://www.codeproject.com/KB/grid/GridViewRowColor.aspx?msg=2732537
    'Protected Sub gvOCimputaciones_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) _
    'Handles gvOCimputaciones.RowDataBound
    'If (e.Row.RowType = DataControlRowType.DataRow) Then
    ' e.Row.Attributes.Add("onclick", "javascript:ChangeRowColor('" & e.Row.ClientID & "')")
    ' End If
    'End Sub


    ''http://www.dotnetcurry.com/ShowArticle.aspx?ID=123&AspxAutoDetectCookieSupport=1
    'Protected Sub gvOCimputaciones_RowCreated(ByVal sender As Object, ByVal e As GridViewRowEventArgs) Handles gvOCimputaciones.RowCreated
    '    e.Row.Attributes.Add("onMouseOver", "this.style.background='#eeff00'")
    '    e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'")
    'End Sub


    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////





    Protected Sub txtNumeroNotaDeCredito2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroNotaDeCredito2.TextChanged
        'txtNumeroNotaDeCredito1.Text = NotaDeCreditoManager.ProximoSubNumero(SC, txtNumeroNotaDeCredito2.Text)
    End Sub

    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        Dim output As String

        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1
        'output = ImprimirWordDOT("NotaDeCredito_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdNotaDeCredito)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa
        Dim p = DirApp() & "\Documentos\" & "NotaCredito.dot"
        output = ImprimirWordDOT(p, Me, SC, Session, Response, IdNotaDeCredito, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "NotaCredito.doc")
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
            Dim myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito = CType(Me.ViewState(mKey), Pronto.ERP.BO.NotaDeCredito)
            With myNotaDeCredito
                'esto tiene que estar en el manager, dios!
                DeObjetoHaciaPagina(myNotaDeCredito)

            End With


            Me.ViewState.Add(mKey, myNotaDeCredito) 'guardo en el viewstate el objeto
            NotaDeCreditoManager.Anular(SC, IdNotaDeCredito, cmbUsuarioAnulo.SelectedValue, txtAnularMotivo.Text)
            Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            'BloqueosDeEdicion(myRequerimiento)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If
    End Sub

    Sub DeObjetoHaciaPagina(ByVal myNotaDeCredito As Pronto.ERP.BO.NotaDeCredito)
        RecargarEncabezado(myNotaDeCredito)

        GridView1.DataSource = myNotaDeCredito.Detalles
        GridView1.DataBind()
    End Sub

    Protected Sub RadioButtonListEsInterna_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListEsInterna.SelectedIndexChanged
        RefrescarNumeroTalonario()
    End Sub






    Protected Sub btnSaveItemImputacionAux_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemImputacionAux.Click

        Dim myNotaDeCredito As NotaDeCredito = CType(Me.ViewState(mKey), NotaDeCredito)

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
                        If myNotaDeCredito.DetallesImp.Find(Function(obj) obj.IdImputacion = idCtaCte) Is Nothing Then

                            Dim mItem As NotaDeCreditoImpItem = New NotaDeCreditoImpItem

                            With mItem
                                'vendría a ser el código de frmRecibo.Editar

                                .Id = myNotaDeCredito.DetallesImp.Count
                                .Nuevo = True

                                .IdImputacion = idCtaCte
                                .TipoComprobanteImputado = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Comp_")

                                .SaldoParteEnPesosAnterior = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_")
                                .FechaComprobanteImputado = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Fecha")
                                .TotalComprobanteImputado = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Imp_orig_")





                                Try
                                    .NumeroComprobanteImputado = Mid(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero"), InStrRev(gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero"), "-"))
                                Catch ex As Exception

                                End Try

                                .ComprobanteImputadoNumeroConDescripcionCompleta = .TipoComprobanteImputado & " " & gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Numero")




                                .Importe = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("Saldo Comp_")
                                'CargarDatosDesdeItemOrdenCompra(mItem, idDetOC)









                            End With

                            myNotaDeCredito.DetallesImp.Add(mItem)



                        Else
                            MsgBoxAjax(Me, "El renglon de imputacion " & idCtaCte & " ya está en el detalle")
                        End If


                    End If
                End If
            Next
        End With


        Me.ViewState.Add(mKey, myNotaDeCredito)
        gvImputaciones.DataSource = myNotaDeCredito.DetallesImp
        gvImputaciones.DataBind()
        UpdatePanelImputaciones.Update()
        mAltaItem = True

        'RecalcularRegistroContable()
        RecalcularTotalComprobante()

        ModalPopupExtenderImputacion.Hide()

    End Sub



    Sub AsignaImputacionesOCalObjeto()
        Dim myNotaDeCredito As NotaDeCredito = CType(Me.ViewState(mKey), NotaDeCredito)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String

        myNotaDeCredito.DetallesOC.Clear()

        With gvOCimputaciones
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

                        Dim IdDetalleOrdenCompra As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleOrdenCompra")
                        'Dim oOC As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idOC, True)
                        'Dim oDetOC As OrdenCompraItem
                        'Dim idDetOC As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleOrdenCompra")
                        'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)


                        'me fijo si ya existe en el detalle
                        If myNotaDeCredito.DetallesOC.Find(Function(obj) obj.IdDetalleOrdenCompra = IdDetalleOrdenCompra) Is Nothing Then

                            Dim mItem As NotaDeCreditoOCItem = New NotaDeCreditoOCItem

                            With mItem
                                .Id = myNotaDeCredito.DetallesImp.Count
                                .Nuevo = True


                                .IdDetalleOrdenCompra = IdDetalleOrdenCompra ' myOC.Detalles(0).Id
                                .Cantidad = gvOCimputaciones.DataKeys(fila.RowIndex).Values.Item("Cantidad")
                                '.PorcentajeCertificacion = gvAuxPendientesImputar.DataKeys(fila.RowIndex).Values.Item("PorcentajeCertificacion")
                            End With

                            myNotaDeCredito.DetallesOC.Add(mItem)

                        End If
                    End If
                End If
            Next
        End With

    End Sub



    Protected Sub gvAuxPendientesImputar_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvAuxPendientesImputar.PageIndexChanging
        gvAuxPendientesImputar.PageIndex = e.NewPageIndex
        RebindAuxPendientesImputar()
    End Sub


    Protected Sub gvOCimputaciones_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvOCimputaciones.PageIndexChanging
        gvOCimputaciones.PageIndex = e.NewPageIndex
        ReBindGvOCimputadas()
    End Sub



    Protected Sub LinkButtonImputacionSinAplicacion_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonImputacionSinAplicacion.Click
        Dim myNotaDeCredito As NotaDeCredito = CType(Me.ViewState(mKey), NotaDeCredito)
        NotaDeCreditoManager.AgregarImputacionSinAplicacionOPagoAnticipado(myNotaDeCredito)
        RebindImp()
        Me.ViewState.Add(mKey, myNotaDeCredito)
    End Sub

    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
        Try
            RefrescarNumeroTalonario()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub cmbDetConcepto_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbDetConcepto.SelectedIndexChanged
        'Popup detalle concepto: Habilitar combo de banco o combo de caja o ninguno, dependiendo del grupo al que 
        'pertenezca la cuenta asociada al concepto elegido

        Dim oRs = GetStoreProcedureTop1(HFSC.Value, enumSPs.Conceptos_TX_PorIdConDatos, cmbDetConcepto.SelectedValue)

        With oRs

            'txtCodigoCuenta.Text = IsNull(oRs.Item("Codigo"))
            'txtCuenta.Text = oRs.Item("Cuenta")
            If Not iisNull(.Item("GravadoDefault")) = "NO" Or RadioButtonListEsInterna.SelectedValue = "SI" Then
                RadioButtonListGravado.SelectedValue = 1 '"SI"
            Else
                RadioButtonListGravado.SelectedValue = 2 '"NO"
            End If

            If iisNull(.Item("EsCajaBanco")) = "BA" Then
                cmbDetCuentaBanco.Enabled = True
            Else
                'origen.Registro.Fields("IdCuentaBancaria").Value = Null
                cmbDetCuentaBanco.Enabled = False
            End If

            If iisNull(.Item("EsCajaBanco")) = "CA" Then
                cmbDetCaja.Enabled = True
            Else
                cmbDetCaja.Enabled = False
            End If


        End With
    End Sub

    Protected Sub LinkImprimirXML_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimirXML.Click


        Dim oNC = NotaDeCreditoManager.GetCopyOfItem(SC, IdNotaDeCredito)
        Dim f = OpenXML_Pronto.NotaCreditoXML_DOCX(oNC, SC)


        Dim MyFile1 = New FileInfo(f)
        Try
            Dim nombrearchivo = "NotaCredito.docx"
            If Not IsNothing(f) Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & nombrearchivo)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnNotaCreditoXML)

                Response.TransmitFile(f)
                'Response.BinaryWrite()
                'Response.OutputStream


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
