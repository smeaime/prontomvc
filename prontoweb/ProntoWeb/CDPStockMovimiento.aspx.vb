
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

Imports CartaDePorteManager

Partial Class CDPStockMovimiento
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Private DIRFTP As String = "C:\"

    Private IdCDPStockMovimiento As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdCDPStockMovimiento"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdCDPStockMovimiento") = Value
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
            IdCDPStockMovimiento = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdCDPStockMovimiento
        End If
        mKey = "CDPStockMovimiento_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        SC = usuario.StringConnection

        AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        AutoCompleteExtender4.ContextKey = SC
        AutoCompleteExtender8.ContextKey = SC

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


            txtDetCantidad.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            txtDetPrecioUnitario.Attributes.Add("onKeyUp", "jsRecalcularItem()")
            txtDetBonif.Attributes.Add("onKeyUp", "jsRecalcularItem()")

            'Carga del objeto
            TextBox1.Text = IdCDPStockMovimiento
            BindTypeDropDown()


            Dim myCDPStockMovimiento As DataSetCDPmovimientos
            If IdCDPStockMovimiento > 0 Then
                myCDPStockMovimiento = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                If Request.QueryString.Get("CopiaDe") IsNot Nothing Then
                    'los textbox que no se refresquen ponelos en un UpdatePanel. No hagas mas esta truchada de un postback general con parametro...
                    myCDPStockMovimiento = EditarSetup(Request.QueryString.Get("CopiaDe"))
                Else
                    myCDPStockMovimiento = AltaSetup()
                End If
            End If



            Me.ViewState.Add(mKey, myCDPStockMovimiento)



            RecalcularTotalComprobante()

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")



            BloqueosDeEdicion(myCDPStockMovimiento)



        End If





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


    Sub BloqueosDeEdicion(ByVal myCDPStockMovimiento As DataSetCDPmovimientos)



        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Then
        If False Then
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
            DisableControls(Me)
            GridView1.Enabled = True
            btnOk.Enabled = True
            btnCancel.Enabled = True

            'encabezado
            'txtNumeroCDPStockMovimiento1.Enabled = False
            'txtNumeroCDPStockMovimiento2.Enabled = False
            txtFechaIngreso.Enabled = False
            'txtFechaAprobado.Enabled = False
            'txtValidezOferta.Enabled = False
            'txtDetalleCondicionCompra.Enabled = False
            cmbMoneda.Enabled = False
            'cmbPlazo.Enabled = False
            'cmbCondicionCompra.Enabled = False
            'cmbPlazo.Enabled = False
            'txtObservaciones.Enabled = False
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

            'LinkButton2.Attributes("Visibility") = "Hidden"
            'LinkButton2.Style.Add("display", "none")

            'ModalPopupExtender1.Hide()
            'ModalPopupExtender2.Hide()

        Else
            'LinkAgregarRenglon.Enabled = True
        End If


        LinkAgregarRenglon.Style.Add("visibility", "hidden")
        LinkButton1.Style.Add("visibility", "hidden")
        LinkButton2.Style.Add("visibility", "hidden")


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or
        With myCDPStockMovimiento.CartasPorteMovimientos(0)

            If .IdCDPMovimiento = -1 Then
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

                LinkImprimir.Visible = False
                'btnAnular.Visible = True
                'btnAnular.Visible = False
                MostrarBotonesParaAdjuntar()


                'If .Aprobo > 0 Then
                If True Then


                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////

                    DisableControls(Me)

                    'btnMasPanel.Enabled = True
                    btnAnular.Enabled = True
                    btnAnularOk.Enabled = True
                    btnAnularCancel.Enabled = True
                    cmbUsuarioAnulo.Enabled = True
                    txtAnularMotivo.Enabled = True
                    txtAnularPassword.Enabled = True

                    LinkImprimir.Enabled = True

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
                    'DisableControls(Me)
                    GridView1.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'encabezado
                    'txtNumeroCDPStockMovimiento1.Enabled = False
                    'txtNumeroCDPStockMovimiento2.Enabled = False
                    txtFechaIngreso.Enabled = False
                    'txtFechaAprobado.Enabled = False
                    'txtValidezOferta.Enabled = False
                    'txtDetalleCondicionCompra.Enabled = False
                    cmbMoneda.Enabled = False
                    'cmbPlazo.Enabled = False
                    'cmbCondicionCompra.Enabled = False
                    'cmbPlazo.Enabled = False
                    'txtObservaciones.Enabled = False
                    'txtDescProveedor.Enabled = False
                    'txtFechaCierreCompulsa.Enabled = False
                    'txtDetalle.Enabled = False

                    'txtTotBonif.Enabled = False



                    'detalle
                    'LinkAgregarRenglon.Enabled = False
                    txt_AC_Articulo.Enabled = False
                    txtDetObservaciones.Enabled = False
                    txtDetTotal.Enabled = False
                    '5057: Logueado como proveedor puedo editar el campo cantidad en el detalle de una solicitud de cotización.
                    'Hablé con Edu y en ese pop-up sólo se puede editar lo relativo a la cotización (moneda, precio, bonificación e Iva) y también debe estar hablitado el campo observaciones para hacer alguna aclaración o salvedad de la cotización
                    txtDetCantidad.Enabled = False
                    'txtTotBonif.Enabled = False
                    txtDetFechaEntrega.Enabled = False



                    'links a popups

                    'LinkAgregarRenglon.Style.Add("visibility", "hidden")
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
                    LinkButton1.Enabled = True
                    'LinkButtonPopupDirectoCliente.Enabled = True
                End If


                'If .Cumplido = "AN" Then
                If Not .IsAnuladaNull AndAlso .Anulada = "SI" Then
                    '////////////////////////////////////////////
                    'y está ANULADO
                    '////////////////////////////////////////////
                    btnAnular.Visible = False
                    lblAnulado.Visible = True
                    'lblAnulado.ToolTip = "Anulado el " & .FechaAnulacion & " por " & . .MotivoAnulacion
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

    Function AltaSetup() As DataSetCDPmovimientos


        Dim myCDPStockMovimiento As DataSetCDPmovimientos = New DataSetCDPmovimientos

        Dim nr = myCDPStockMovimiento.CartasPorteMovimientos.NewCartasPorteMovimientosRow

        With nr ' myCDPStockMovimiento.CartasPorteMovimientos(0)
            .IdCDPMovimiento = -1








            Dim pventa As Integer
            Try
                pventa = If(EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)), New Empleado).PuntoVentaAsociado 'sector del confeccionó
            Catch ex As Exception
                pventa = 0
                ErrHandler2.WriteError(ex)
            End Try
            .IdStock = iisNull(pventa, 0) 'reemplazar el idstock por puntoventa, lo estoy usando para no regenerar el dataset tipado




            'BuscaIDEnCombo(cmbVendedor, session(SESSIONPRONTO_glbIdUsuario))

            'Try
            '    txtNumeroCDPStockMovimiento2.Text = CDPStockMovimientoManager.ProximoNumeroPorPuntoVentaOTalonario(HFSC.Value, cmbPuntoVenta.SelectedValue) ' ParametroOriginal(SC, "ProximoNumeroCDPStockMovimiento") depende el punto de venta
            'Catch ex As Exception

            'End Try

            ConmutarClienteProveedor()

            txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?

            BuscaTextoEnCombo(cmbMoneda, "PESOS")

            'txtNumeroCDPStockMovimiento1.Text = 1

            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            Dim dt As New DataTable
            dt.Columns.Add("IdCDPMovimiento")
            dt.Columns.Add("Cantidad")
            dt.Columns.Add("IdArticulo")
            dt.Columns.Add("CodigoArticulo")
            dt.Columns.Add("DescripcionArticulo")

            dt.Columns.Add("nuevo")
            dt.Columns.Add("eliminado")

            dt.Rows.Add(dt.NewRow)
            'dt.Rows.Add(dt.NewRow)


            'Dim mItem As CDPStockMovimientoItem = New DataSetCDPmovimientosItem
            'mItem.Id = -1
            'mItem.Nuevo = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing



            '.Detalles.Add(mItem)

            GridView1.DataSource = dt 'este bind lo copié
            GridView1.DataBind()             'este bind lo copié   
            ''/////////////////////////////////
            ''/////////////////////////////////



            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If


            'txtReferencia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoCDPStockMovimientoReferencia").ToString
            'txtFechaCDPStockMovimiento.Text = System.DateTime.Now.ToShortDateString()

            .IdAjusteStock = Nothing
            ViewState("PaginaTitulo") = "Nuevo Movimiento"
        End With




        myCDPStockMovimiento.CartasPorteMovimientos.AddCartasPorteMovimientosRow(nr) 'claro, el dataset chilla si queres agregarlo y no se cumplen las restricciones... por eso, no tendrías que laburar con el datarow, en lugar de con el datatable/dataset?


        Return myCDPStockMovimiento
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup(Optional ByVal CopiaDeOtroId As Long = -1) As DataSetCDPmovimientos
        'los textbox que no se refresquen ponelos en un UpdatePanel

        Dim myCDPStockMovimiento As New DataSetCDPmovimientos

        If CopiaDeOtroId = -1 Then 'no debería hacer lo de la copia en el Alta en lugar de acá?



            myCDPStockMovimiento = CDPStockMovimientoManager.GetItem(SC, IdCDPStockMovimiento) 'va a editar ese ID
            'myCDPStockMovimiento = CDPStockMovimientoManager.GetItemComPronto(SC, IdCDPStockMovimiento, True)



            '//////////////////////////////////////
            '//////////////////////////////////////
            '//////////////////////////////////////
            '//////////////////////////////////////


            '////////////////////////////
            '//////////////////////////////////////

        Else
            'está haciendo un alta, pero uso los datos de un ID existente


            ' myCDPStockMovimiento = CDPStockMovimientoManager.GetCopyOfItem(SC, CopiaDeOtroId)
            IdCDPStockMovimiento = -1
            'tomar el ultimo de la serie y sumarle uno





            'limpiar los precios del CDPStockMovimiento original
            'For Each i In myCDPStockMovimiento.Detalles
            '    i.Precio = 0
            'Next

            'mKey = "CDPStockMovimiento_" & Me.IdEntity.ToString 'esto es un balurdo. aclarar bien
        End If


        If Not (myCDPStockMovimiento Is Nothing) Then

            With myCDPStockMovimiento.CartasPorteMovimientos(0)




                RecargarEncabezado(myCDPStockMovimiento)

                'TraerDatosCliente(myCDPStockMovimiento.IdCliente)

                '/////////////////////////
                '/////////////////////////
                'Grilla
                '/////////////////////////
                '/////////////////////////
                'GridView1.Columns(0).Visible = False


                GridView1.DataSource = myCDPStockMovimiento.CartasPorteMovimientos
                GridView1.DataBind()

                Dim gr = GridView1.Rows(0)
                CType(gr.FindControl("txtGrillaDetAC_Articulo"), WebControls.TextBox).Text = EntidadManager.NombreArticulo(SC, .IdArticulo)





                'Me.Title = "Edición Fondo Fijo " + myCDPStockMovimiento.Letra + myCDPStockMovimiento.NumeroComprobante1.ToString + myCDPStockMovimiento.NumeroComprobante2.ToString

                ViewState("PaginaTitulo") = "Movimiento " + .IdCDPMovimiento.ToString '+ myCDPStockMovimiento.SubNumero.ToString
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
                '////////////////////////////////////
                'acá se mete si es una copia de otro
                '////////////////////////////////////
                '////////////////////////////////////

                'Me.ViewState.Add(mKey, myCDPStockMovimiento)

                'vacío el proveedor (porque es una copia)
                'SelectedReceiver.Value = 0
                'txtDescProveedor.Text = ""

                'txtNumeroCDPStockMovimiento2.Text = ParametroOriginal(SC, "ProximoNumeroCDPStockMovimiento")
                txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?
            End If

        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdCDPStockMovimiento & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myCDPStockMovimiento
    End Function

    Sub RecargarEncabezado(ByVal myCDPStockMovimiento As DataSetCDPmovimientos)
        With myCDPStockMovimiento.CartasPorteMovimientos(0)

            txtDeExportador.Text = EntidadManager.NombreCliente(SC, .IdExportadorOrigen)
            txtAExportador.Text = EntidadManager.NombreCliente(SC, .IdExportadorDestino)

            txtPuerto.Text = EntidadManager.NombreDestino(SC, .Puerto)

            ProntoOptionButton(CType(.Entrada_o_Salida, Integer), RadioButtonListEntradaSalida)


            If .IdFacturaImputada > 0 Then
                Dim f As Pronto.ERP.BO.Factura
                f = FacturaManager.GetItem(SC, .IdFacturaImputada)
                'FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,
                linkFactura.Text = "Factura " & f.TipoABC & "-" & f.PuntoVenta.ToString.PadLeft(4, "0") & "-" & f.Numero.ToString.PadLeft(8, "0")
                linkFactura.NavigateUrl = "Factura.aspx?Id=" & .IdFacturaImputada
                linkFactura.Visible = True
                'btnDesfacturar.Visible = True
            Else
                linkFactura.Visible = False
                'btnDesfacturar.Visible = False
            End If


            'txtNumeroMovimiento = .IdCDPMovimiento
            Try
                txtFechaIngreso.Text = .FechaIngreso
                cmbTipoMovimiento.SelectedValue = .Tipo


            Catch ex As Exception

            End Try

            txtVapor.Text = .Vapor
            'txtNumero.Text = .Numero
            txtNumero.Text = .IdCDPMovimiento
            txtContrato.Text = .Contrato

            BuscaTextoEnCombo(cmbPuntoVenta, .IdStock)
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



        cmbLibero.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        cmbLibero.DataTextField = "Titulo"
        cmbLibero.DataValueField = "IdEmpleado"
        cmbLibero.DataBind()


        cmbUsuarioAnulo.DataSource = EmpleadoManager.GetListCombo(SC)
        cmbUsuarioAnulo.DataTextField = "Titulo"
        cmbUsuarioAnulo.DataValueField = "IdEmpleado"
        cmbUsuarioAnulo.DataBind()

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'PUNTO VENTA
        '///////////////////////////////////////////////

        'METODO 1
        RefrescarTalonariosDisponibles()



        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbDetUnidades.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Unidades")
        cmbDetUnidades.DataTextField = "Titulo"
        cmbDetUnidades.DataValueField = "IdUnidad"
        cmbDetUnidades.DataBind()
        cmbDetUnidades.Enabled = False

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////


        cmbUbicacion.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(SC, "Ubicaciones_TL")
        cmbUbicacion.DataTextField = "Titulo"
        cmbUbicacion.DataValueField = "IdUbicacion"
        cmbUbicacion.DataBind()
        cmbUbicacion.Items.Insert(0, New ListItem("", -1))
        'IniciaCombo(SC, cmbUbicacion, tipos.Ubicaciones)






        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(SC)
        ' cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(SC, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0


        Dim pventa As Integer
        Try
            pventa = If(EmpleadoManager.GetItem(SC, Session(SESSIONPRONTO_glbIdUsuario)), New Empleado).PuntoVentaAsociado 'sector del confeccionó
        Catch ex As Exception
            pventa = 0
            ErrHandler2.WriteError(ex)
        End Try

        BuscaTextoEnCombo(cmbPuntoVenta, pventa)
        If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir



    End Sub



    Function TraerDatosCliente(ByVal IdCliente As Long)
        Try
            Dim oCli = ClienteManager.GetItem(SC, IdCliente)
            With oCli
                'BuscaIDEnCombo(cmbCondicionIVA, .IdCodigoIva)
                'txtCUIT.Text = .Cuit
                'BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionVenta)

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



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try

            Dim mOk As Boolean
            Page.Validate("Encabezado")
            mOk = Page.IsValid


            'If Not IsNumeric(txtValorDeclarado.Text) Then
            '    'traté de ponerlo en el IsValid, pero 
            '    'no me deja asignarle Nothing a .ValorDeclarado
            '    MsgBoxAjax(Me, "Debe indicar el valor declarado")
            '    Exit Sub
            'End If





            If mOk Then
                Dim mIdCodigoIva As Integer
                Dim mIdProveedor As Long

                Dim mIdCuentaIvaCompras(10) As Long
                Dim mIVAComprasPorcentaje(10) As Single


                'If Not mAltaItem Then 'y esto?

                Dim myCDPStockMovimiento As DataSetCDPmovimientos = CType(Me.ViewState(mKey), DataSetCDPmovimientos)


                Try
                    DePaginaHaciaObjeto(myCDPStockMovimiento)
                Catch ex As Exception
                    MsgBoxAjax(Me, "El movimiento no es válido")
                    Return
                End Try





                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////

                '////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////
                '//////////////////////////////////////




                Dim ms As String
                If CDPStockMovimientoManager.IsValid(SC, myCDPStockMovimiento, ms) Then
                    Try
                        If CDPStockMovimientoManager.Save(SC, myCDPStockMovimiento) = -1 Then
                            MsgBoxAjax(Me, "El comprobante no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.ToString)
                        Return
                    End Try




                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                    IdCDPStockMovimiento = myCDPStockMovimiento.CartasPorteMovimientos(0).IdCDPMovimiento


                    'If myCDPStockMovimiento.Numero <> StringToDecimal(txtNumeroCDPStockMovimiento2.Text) Then
                    '    EndEditing("El CDPStockMovimiento fue grabado con el número " & myCDPStockMovimiento.Numero) 'me voy 
                    'Else
                    '    EndEditing("Desea imprimir el comprobante?")
                    'End If
                    EndEditing()
                Else
                    MsgBoxAjax(Me, ms)
                    Exit Sub
                End If




            Else
                MsgBoxAjax(Me, "El movimiento no es válido")
                mAltaItem = False
                'LblInfo.Visible = False
                PanelInfo.Visible = True
                PanelInfoNum.Visible = True
                'LblInfo.Visible = True
            End If

            'End If
        Catch ex As Exception
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
            Response.Redirect(String.Format("CDPStockMovimientos.aspx"))
        End If
    End Sub


    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("CDPStockMovimientos.aspx?Imprimir=" & IdCDPStockMovimiento))
    End Sub

    Protected Sub ButVolverSinImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolverSinImprimir.Click
        Response.Redirect(String.Format("CDPStockMovimientos.aspx")) 'roundtrip al cuete?
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

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'ModalPopupExtender3.Show()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'tachar la linea eliminada
        'http://stackoverflow.com/questions/535769/asp-net-gridview-how-to-strikeout-the-entire-text-in-a-row

        'Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        'If eliminado Then e.Row.Style.Value = "text-decoration:line-through;"
        If e.Row.RowType = DataControlRowType.DataRow Then 'no es el encabezado
            'If e.Row.DataItem.eliminado Then
            '    'Las tres columnas de texto (art cant uni)

            '    'el text decoration es demasiado nuevo, no anda en firefox, es medio buggy
            '    'e.Row.Cells(0).Style.Value = "text-decoration:line-through;"
            '    'e.Row.Cells(1).Style.Value = "text-decoration:line-through;"
            '    'e.Row.Cells(2).Style.Value = "text-decoration:line-through;"

            '    e.Row.Cells(0).Text = "<strike>" + e.Row.Cells(0).Text + "</strike>"
            '    e.Row.Cells(1).Text = "<strike>" + e.Row.Cells(1).Text + "</strike>"
            '    e.Row.Cells(2).Text = "<strike>" + e.Row.Cells(2).Text + "</strike>"


            '    'e.Row.FindControl("Eliminar").text = "Restaurar" 'reemplazo el texto del eliminado
            '    Try
            '        Dim b As LinkButton = e.Row.Cells(6).Controls(0)
            '        b.Text = "Restaurar" 'reemplazo el texto del eliminado
            '    Catch ex As Exception

            '    End Try

            'End If
        End If



        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion
        If (e.Row.RowType = DataControlRowType.DataRow) Then

            ac = e.Row.FindControl("AutoCompleteExtender200")
            If Not IsNothing(ac) Then
                ac.ContextKey = HFSC.Value
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


    Sub EditarItemSetup(ByRef mIdItem As Long, ByRef myCDPStockMovimiento As DataSetCDPmovimientos)
        'With myCDPStockMovimiento.CartasPorteMovimientos(0).Detalles(mIdItem)
        '    'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

        '    .Eliminado = False


        '    txtDetObservaciones.Text = .Observaciones

        '    '////////////////////////////////////////////////////////////////////////////////
        '    'HAY QUE ARREGLAR ESTO: me lo tiene que dar directamente el BO.CDPStockMovimiento
        '    'txtDescProveedor = myCDPStockMovimiento.Detalles(mIdItem).descripcion
        '    Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", .IdArticulo)
        '    If ds.Tables(0).Rows.Count > 0 Then
        '        'txtDescProveedor.Text = ds.Tables(0).Rows(0).Item("Descripcion").ToString
        '    End If
        '    '////////////////////////////////////////////////////////////////////////////////

        '    If .IdArticulo > 0 Then txtCodigo.Text = ArticuloManager.GetItem(SC, .IdArticulo).Codigo

        '    SelectedAutoCompleteIDArticulo.Value = .IdArticulo
        '    txt_AC_Articulo.Text = .Articulo

        '    '////////////////////////////////////////////////////////////////////////////////
        '    'elige en combos
        '    '////////////////////////////////////////////////////////////////////////////////
        '    BuscaIDEnCombo(cmbDetUnidades, .IdUnidad)
        '    'BuscaIDEnCombo(cmbCuentaGasto, .Detalles(mIdItem).IdCuentaGasto.ToString)
        '    'BuscaIDEnCombo(cmbDestino, .Detalles(mIdItem).IdDetalleObraDestino)
        '    '////////////////////////////////////////////////////////////////////////////////


        '    txtDetFechaEntrega.Text = .FechaEntrega
        '    'txtCodigo.Text = .Detalles(mIdItem).CodigoCuenta
        '    txtDetCantidad.Text = DecimalToString(.Cantidad)
        '    txtDetPrecioUnitario.Text = DecimalToString(.Precio)
        '    'txtDetIVA.Text = DecimalToString(.PorcentajeIVA)
        '    txtDetBonif.Text = DecimalToString(.PorcentajeBonificacion)

        '    txtDetPartida.Text = .Partida
        '    BuscaIDEnCombo(cmbUbicacion, .IdUbicacion)

        '    txtDetTotal.Text = .ImporteTotalItem
        '    'txtDetTotal.Text = .Cantidad * .Precio * .ImporteIVA

        '    'cmbIVA.Text = DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1)
        '    'BuscaTextoEnCombo(cmbIVA, DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1))

        '    If .ArchivoAdjunto1 <> "" Then
        '        Dim MyFile1 As New FileInfo(.ArchivoAdjunto1)
        '        If MyFile1.Exists Then
        '            lnkDetAdjunto1.Text = .ArchivoAdjunto1 + " (" + MyFile1.Length.ToString + " bytes)"
        '            lnkDetAdjunto1.ToolTip = .ArchivoAdjunto1
        '            lnkDetAdjunto1.Enabled = True
        '        Else
        '            lnkDetAdjunto1.Text = "No se encuentra el archivo " + .ArchivoAdjunto1
        '            lnkDetAdjunto1.Enabled = False
        '        End If
        '    Else
        '        lnkDetAdjunto1.Text = "Vacío"
        '        lnkDetAdjunto1.ToolTip = ""
        '        lnkDetAdjunto1.Enabled = False
        '    End If

        '    'If .ArchivoAdjunto2 <> "" Then
        '    '    Dim MyFile2 As New FileInfo(.ArchivoAdjunto2)
        '    '    If MyFile2.Exists Then
        '    '        lnkDetAdjunto2.Text = .ArchivoAdjunto2 + " (" + MyFile2.Length.ToString + " bytes)"
        '    '        lnkDetAdjunto2.ToolTip = .ArchivoAdjunto2
        '    '        lnkDetAdjunto2.Enabled = True
        '    '    Else
        '    '        lnkDetAdjunto2.Text = "No se encuentra el archivo " + .ArchivoAdjunto2
        '    '        lnkDetAdjunto2.Enabled = False
        '    '    End If
        '    'Else
        '    '    lnkDetAdjunto2.Text = "Vacío"
        '    '    lnkDetAdjunto2.ToolTip = ""
        '    '    lnkDetAdjunto2.Enabled = False
        '    'End If

        '    'txtObservacionesItem.Text = myCDPStockMovimiento.Detalles(mIdItem).Observaciones.ToString
        '    'txtFechaNecesidad.Text = myCDPStockMovimiento.Detalles(mIdItem).FechaEntrega.ToString
        '    Try
        '        RadioButtonListDescripcion.Items(.OrigenDescripcion - 1).Selected = True
        '    Catch ex As Exception
        '        RadioButtonListDescripcion.Items(0).Selected = True
        '    End Try
        '    'ElseIf .OrigenDescripcion = 2 Then
        '    'RadioButtonList1.Items(1).Selected = True
        '    'ElseIf .OrigenDescripcion = 3 Then
        '    'RadioButtonList1.Items(2).Selected = True
        '    'Else
        '    'RadioButtonList1.Items(0).Selected = True
        '    'End If

        '    Try
        '        RadioButtonListFormaCancelacion.SelectedValue = .TipoCancelacion

        '    Catch ex As Exception
        '        RadioButtonListFormaCancelacion.Items(0).Selected = True
        '    End Try

        '    'If .TipoCancelacion = 1 Then
        '    '    RadioButtonList2.Items(0).Selected = True
        '    'ElseIf .TipoCancelacion = 2 Then
        '    '    RadioButtonList2.Items(1).Selected = True
        '    'Else
        '    '    RadioButtonList2.Items(0).Selected = True
        '    'End If



        'End With



        'UpdatePanelDetalle.Update()
        'ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?



    End Sub


    Sub AltaItemSetup()
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleCDPStockMovimiento") = -1
        'cmbCuentaGasto.SelectedIndex = 1
        txtCodigo.Text = ""
        txt_AC_Articulo.Text = ""
        SelectedAutoCompleteIDArticulo.Value = 0
        txtDetCantidad.Text = ""

        cmbUbicacion.SelectedValue = -1
        txtDetPartida.Text = ""
        txtDetObservaciones.Text = ""
        txtDetFechaEntrega.Text = ""

        'RadioButtonListDescripcion.Items(0).Selected = True
        RadioButtonListDescripcion.SelectedValue = 1 'acá hay que usar selectedvalue
        'MostrarElementos(True) 'si no se usa el popup

        '/////////////////////////////////////////////////////
        'traigo el requerimiento, todo para ver el proximo item......
        Dim myCDPStockMovimiento As DataSetCDPmovimientos
        If (Me.ViewState(mKey) IsNot Nothing) Then
            myCDPStockMovimiento = CType(Me.ViewState(mKey), DataSetCDPmovimientos)
            'txtDetItem.Text = CDPStockMovimientoManager.UltimoItemDetalle(myCDPStockMovimiento) + 1
        Else
            txtDetItem.Text = 1
        End If
        '/////////////////////////////////////////////////////
        'txtDetFechaNecesidad.Text = Today

        'Dim eselprimero As Boolean = False
        'If Not eselprimero Then 'creo un nuevo renglon
        '    ViewState("IdDetalleCDPStockMovimiento") = -1
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


    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myCDPStockMovimiento As DataSetCDPmovimientos

        Try
            If e.CommandName.ToLower = "eliminar" Then
                'If (Me.ViewState(mKey) IsNot Nothing) Then
                '    myCDPStockMovimiento = CType(Me.ViewState(mKey), DataSetCDPmovimientos)

                '    'si esta eliminado, lo restaura
                '    myCDPStockMovimiento.Detalles(mIdItem).Eliminado = Not myCDPStockMovimiento.Detalles(mIdItem).Eliminado

                '    Me.ViewState.Add(mKey, myCDPStockMovimiento)
                '    GridView1.DataSource = myCDPStockMovimiento.Detalles
                '    GridView1.DataBind()
                'End If

            ElseIf e.CommandName.ToLower = "editar" Then
                ViewState("IdDetalleCDPStockMovimiento") = mIdItem
                If (Me.ViewState(mKey) IsNot Nothing) Then
                    'MostrarElementos(True)
                    myCDPStockMovimiento = CType(Me.ViewState(mKey), DataSetCDPmovimientos)
                    EditarItemSetup(mIdItem, myCDPStockMovimiento)
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




    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click

        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleCDPStockMovimiento"), Integer)
            Dim myCDPStockMovimiento As DataSetCDPmovimientos = CType(Me.ViewState(mKey), DataSetCDPmovimientos)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then 'si es nuevo, inicializo las cosas el item
                Dim mItem 'As CDPStockMovimientoItem = New DataSetCDPmovimientosItem

                'If myCDPStockMovimiento.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
                '    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                '    Exit Sub
                'End If

                'mItem.Id = myCDPStockMovimiento.Detalles.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                'myCDPStockMovimiento.Detalles.Add(mItem)
            End If


            RecalcularTotalDetalle()


            'Try
            '    With myCDPStockMovimiento.CartasPorteMovimientos(0).Detalles(mIdItem)
            '        'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
            '        ' de cada valor, como se hace en toda web

            '        .IdArticulo = Convert.ToInt32(SelectedAutoCompleteIDArticulo.Value)
            '        .Articulo = txt_AC_Articulo.Text
            '        .FechaEntrega = ProntoFuncionesGenerales.iisValidSqlDate(txtDetFechaEntrega.Text)
            '        '.FechaNecesidad = ProntoFuncionesGenerales.iisValidSqlDate(txtDetFechaNecesidad.Text)
            '        .Cantidad = StringToDecimal(txtDetCantidad.Text)
            '        .Precio = StringToDecimal(txtDetPrecioUnitario.Text)
            '        .PorcentajeBonificacion = StringToDecimal(txtDetBonif.Text)
            '        '.PorcentajeIVA = StringToDecimal(txtDetIVA.Text)

            '        '.IdObra=

            '        .NumeroCaja = Nothing
            '        .DescargaPorKit = Nothing


            '        If .NumeroItem = 0 Then
            '            '.NumeroItem = CDPStockMovimientoManager.UltimoItemDetalle(myCDPStockMovimiento) + 1
            '        End If

            '        .ImporteTotalItem = StringToDecimal(txtDetTotal.Text)
            '        .IdUnidad = Convert.ToInt32(cmbDetUnidades.SelectedValue)
            '        .Unidad = cmbDetUnidades.SelectedItem.Text
            '        '.ArchivoAdjunto1 = FileUpLoad2.FileName

            '        'total

            '        .Partida = txtDetPartida.Text
            '        .IdUbicacion = cmbUbicacion.SelectedValue

            '        .Observaciones = txtDetObservaciones.Text
            '        '.ArchivoAdjunto1
            '        '.ArchivoAdjunto2

            '        If RadioButtonListFormaCancelacion.SelectedItem IsNot Nothing Then
            '            .TipoCancelacion = RadioButtonListFormaCancelacion.SelectedItem.Value
            '        End If

            '        If RadioButtonListDescripcion.SelectedItem IsNot Nothing Then
            '            .OrigenDescripcion = RadioButtonListDescripcion.SelectedItem.Value
            '        End If

            '        '///////////////////////////////////////////////////////////////
            '        'valores que me traigo del encabezado y ensoqueto en el renglon
            '        '///////////////////////////////////////////////////////////////
            '        '.IdObra = cmbObra.SelectedValue

            '        '///////////////////////////////////////////////////////////////
            '        '///////////////////////////////////////////////////////////////

            '        '.IdCuentaGasto = cmbCuentaGasto.SelectedValue
            '        '.CuentaGastoDescripcion = cmbCuentaGasto.SelectedItem.Text
            '        '.IdDetalleObraDestino = IIf(cmbDestino.SelectedValue = "", Nothing, cmbDestino.SelectedValue)



            '        '///////////////////////////////////////////////////////////////
            '        '///////////////////////////////////////////////////////////////
            '        'no entiendo cómo se asigna la IdCuenta del detalle a partir de la IdCuentaGasto
            '        'acá busca la cuentaGasto. Si no la encuentra, en el siguiente sp ya no toma
            '        ' en cuenta la obra

            '        'Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorObraCuentaGasto", .IdObra, .IdCuentaGasto, DBNull.Value)
            '        'If ds.Tables(0).Rows.Count > 0 Then
            '        '    .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
            '        '    '.CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
            '        'Else

            '        '    ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorCodigo", Mid(cmbCuentaGasto.SelectedItem.Text, InStrRev(cmbCuentaGasto.SelectedItem.Text, " ") + 1), DBNull.Value)
            '        '    If ds.Tables(0).Rows.Count > 0 Then
            '        '        .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
            '        '        '.CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
            '        '    Else
            '        '        MsgBoxAjax(me,"No se encuentra la cuenta de la obra correspodiente a esta cuenta de gasto")
            '        '        Exit Sub
            '        '    End If
            '        '    '   oRsAux1.Close()
            '        '    '   oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaGasto)
            '        '    '   If oRsAux1.RecordCount > 0 Then
            '        '    '    mIdCuenta = oRsAux1.Fields("IdCuenta").Value
            '        '    '    'OK, acá se trajo el mIdCuenta. y el mIdCuentaGasto? Queda en cero, no?
            '        '    '    '-en el codigo no lo vuelve a asignar....
            '        '    '    mCodigoCuenta = oRsAux1.Fields("Codigo").Value
            '        '    '   End If
            '        'End If


            '        '///////////////////////////////////////////////////////////////
            '        '///////////////////////////////////////////////////////////////


            '        Dim mIdCuentaIvaCompras1 As Long
            '        'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
            '        Dim drparam As Data.DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
            '        With drparam
            '            mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
            '        End With




            '        'If mIdCuentaIvaCompras1 <> 0 Then
            '        '    .IdCuentaIvaCompras1 = mIdCuentaIvaCompras1
            '        '    .IVAComprasPorcentaje1 = StringToDecimal(cmbIVA.SelectedValue)
            '        '    .ImporteIVA1 = Math.Round(cmbIVA.SelectedValue / 100 * .Importe, 2)
            '        '    .AplicarIVA1 = "SI"
            '        'Else
            '        '    .IdCuentaIvaCompras1 = 0
            '        '    .IVAComprasPorcentaje1 = 0
            '        '    .ImporteIVA1 = 0
            '        '    .AplicarIVA1 = "NO"
            '        'End If




            '        '.FechaEntrega = Convert.ToDateTime(txtFechaNecesidad.Text)
            '        '.Observaciones = txtObservacionesItem.Text.ToString
            '        '.OrigenDescripcion = RadioButtonList1.SelectedItem.Value

            '        'TO DO
            '        '.FechaNecesidad = #1/1/2009#
            '        '.FechaDadoPorCumplido = #1/1/2009#
            '        '.FechaAsignacionCosto = #1/1/2009#
            '    End With
            'Catch ex As Exception
            '    'lblError.Visible = True
            '    MsgBoxAjax(Me, ex.ToString)
            '    Exit Sub
            'End Try

            RecalcularTotalComprobante()

            Me.ViewState.Add(mKey, myCDPStockMovimiento)
            'GridView1.DataSource = myCDPStockMovimiento.Detalles
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




    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="Fecha"></param>
    ''' <param name="IdMoneda"></param>
    ''' <returns></returns>
    ''' <remarks></remarks>

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
        'Busco
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
            '    txtDetPrecioUnitario.Text = ListaPreciosManager.GetPrecioPorLista(SC, myArticulo.Id, cmbListaPrecios.SelectedValue)


            '    Return True
            'End If


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
    Handles btnRecalcularTotal.Click
        ', txtDetCantidad.TextChanged, txtDetBonif.TextChanged, txtDetPrecioUnitario.TextChanged


        '        RecalcularTotalDetalle()

    End Sub



    Sub RecalcularTotalDetalle()
        'txtDetTotal.Text = 2432.4

        txtDetTotal.Text = FF2(CDPStockMovimientoManager.RecalculaItem( _
                                StringToDecimal(txtDetCantidad.Text), _
                                StringToDecimal(txtDetPrecioUnitario.Text), _
                                StringToDecimal(txtDetBonif.Text), _
                                StringToDecimal(txtDetIVA.Text) _
                                ))

        'UpdatePanelDetallePreciosYCantidades.Update()
    End Sub

    Protected Sub txtDetCantidad_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetCantidad.TextChanged
        ' RecalcularTotalDetalle()
        'ClientIDSetfocus = txtDetCantidad.ClientID
    End Sub

    Protected Sub txtDetPrecioUnitario_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetPrecioUnitario.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = txtDetPrecioUnitario.ClientID
    End Sub

    Protected Sub txtDetIVA_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetIVA.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = txtDetIVA.ClientID
    End Sub

    Protected Sub txtDetBonif_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDetBonif.TextChanged
        'RecalcularTotalDetalle()
        'ClientIDSetfocus = txtDetBonif.ClientID
    End Sub

    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Pagina Principal de ABM

    Sub RecalcularTotalComprobante()
        Dim myCDPStockMovimiento As DataSetCDPmovimientos = CType(Me.ViewState(mKey), DataSetCDPmovimientos)
        Try
            'myCDPStockMovimiento.Bonificacion = StringToDecimal(txtTotBonif.Text)

            'CDPStockMovimientoManager.RecalcularTotales(myCDPStockMovimiento)
            'With myCDPStockMovimiento.CartasPorteMovimientos(0)
            '    'txtSubtotal.Text = FF2(.SubTotal)
            '    'txtBonificacionPorItem.Text = FF2(.TotalBonifEnItems)
            '    'lblTotBonif.Text = FF2(.TotalBonifSobreElTotal)
            '    'lblTotSubGravado.Text = FF2(.TotalSubGravado)
            '    'lblTotIVA.Text = FF2(.ImporteIva1)
            '    'txtTotal.Text = FF2(.Total)


            'End With

            UpdatePanelTotales.Update()

        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
        End Try
    End Sub






    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

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
        Dim idcliente = BuscaIdClientePreciso(txtAExportador.Text, HFSC.Value).ToString
        e.InputParameters("Parametros") = New String() {idcliente.ToString}

        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control

        'If Not ViewState("ObjectDataSource2Mostrar") Then 'para que no busque estos datos si no fueron pedidos explicitamente
        'If txtBuscar.Text = "buscar" Then
        If Not IsPostBack Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        ViewState("ObjectDataSource2Mostrar") = False

    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        ObjGrillaConsulta.FilterExpression = "Convert([Req.Nro.], 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Sub


    Protected Sub RadioButtonPendientes_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonPendientes.CheckedChanged
        ObjGrillaConsulta.SelectParameters.Add("TX", "_Pendientes1")
        'CDPStockMovimientos_TX_Pendientes1 'P' 
    End Sub

    Protected Sub RadioButtonAlaFirma_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonAlaFirma.CheckedChanged
        'CDPStockMovimientos_TX_PendientesDeFirma
    End Sub

    Protected Sub LinkButton1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click

        'ObjGrillaConsulta.SelectMethod = "GetListTX"
        'ObjGrillaConsulta.TypeName = "Pronto.ERP.Bll.CDPStockMovimientoManager"
        'ObjGrillaConsulta.SelectParameters.Add("TX", "PendientesDeFirma")
        'ObjGrillaConsulta.SelectParameters.Add("Parametros", "")
        ''ObjGrillaConsulta.Update()
        'UpdatePanelGrillaConsulta.Update()
        ViewState("ObjectDataSource2Mostrar") = True
        GVGrillaConsulta.DataBind()
        ModalPopupExtender1.Show()




        'Select Case Index
        '    Case 0
        '        If mTiposComprobante = "F" Then
        '            oRs = Aplicacion.CDPStockMovimientos.TraerFiltrado("_PendientesDeFirma")
        '        ElseIf mOrigen = "Compras" Then
        'oRs = Aplicacion.CDPStockMovimientos.TraerFiltrado("_Pendientes1", mTiposComprobante)
        '        Else
        'oRs = Aplicacion.CDPStockMovimientos.TraerFiltrado("_PendientesPlaneamiento", mTiposComprobante)
        '        End If
        'Lista.DataSource = oRs
        '    Case 1
        'lblLabels(5).Visible = False
        ''         rchObservaciones.Visible = False
        'oRs = Aplicacion.CDPStockMovimientos.TraerFiltrado("_PendientesPorRM1", mTiposComprobante)
        'Lista.DataSource = oRs
        '    Case 2
        'oRs = Aplicacion.TablasGenerales.TraerFiltrado("Acopios", "_Pendientes1", mTiposComprobante)
        'Lista.DataSource = oRs
        '    Case 3
        'lblLabels(5).Visible = False
        'rchObservaciones.Visible = False
        'oRs = Aplicacion.TablasGenerales.TraerFiltrado("Acopios", "_PendientesPorLA1", mTiposComprobante)
        'Lista.DataSource = oRs
        '    Case 4
        'Unload(Me)
        'Exit Sub
        'End Select


    End Sub





    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////
    'Segunda grilla de Consulta ( copia una solicitud existente). Evento de cuando elige un renglon
    '////////////////////////////////
    '////////////////////////////////

    Protected Sub ObjectDataSource2_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource2.Selecting
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        Static Dim ObjectDataSource2Mostrar As Boolean = False

        If HFSC.Value <> "" Then
            e.InputParameters("Parametros") = New String() {BuscaIdClientePreciso(txtAExportador.Text, HFSC.Value).ToString}
            'exec OrdenesCompra_TX_ItemsPendientesDeRemitirPorIdCliente 591
        End If

        'If TextBox3.Text = "buscar" Then
        If Not IsPostBack Then
            e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        End If

        ObjectDataSource2Mostrar = False
        ViewState("ObjectDataSource2Mostrar") = False
    End Sub


    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click


        'ViewState("ObjectDataSource2Mostrar") = True
        'ObjectDataSource2.Select()
        GridView3.DataBind()
        'Page.Validate("Encabezado")
        'If Page.IsValid Then

        'End If
        'GrillaAuxItemsOC_Rebind()
        UpdatePanel2.Update()
        ModalPopupExtender2.Show()


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
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView3)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

        '    gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, "DetOrdenesCompra_TXOCompra", DataBinder.Eval(e.Row.DataItem, "Id"))
        '    'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
        '    'ObjectDataSource3.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
        '    'gp.DataSource = ObjectDataSource3.Select
        '    Try
        '        gp.DataBind()
        '    Catch ex As Exception
        '        'Debug.Print(ex.ToString)
        '        Throw New ApplicationException("Error en la grabacion " + ex.ToString, ex)
        '    Finally
        '    End Try
        '    gp.Width = 200

        'End If
    End Sub


    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        'restauro el objeto a partir del viewstate
        Dim myCDPStockMovimiento As DataSetCDPmovimientos = CType(Me.ViewState(mKey), DataSetCDPmovimientos)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        With GridView3
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


                        Dim idOC As Integer = .DataKeys(fila.RowIndex).Values.Item("IdOrdenCompra")
                        Dim oOC As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idOC, True)
                        Dim oDetOC As OrdenCompraItem
                        Dim idDetOC As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleOrdenCompra")
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
                        'If myCDPStockMovimiento.Detalles.Find(Function(obj) obj.IdDetalleOrdenCompra = idDetOC) Is Nothing Then

                        '    'Dim mItem As CDPStockMovimientoItem = New DataSetCDPmovimientosItem

                        '    'With mItem
                        '    '    .Id = myCDPStockMovimiento.Detalles.Count
                        '    '    .Nuevo = True

                        '    '    CargarDatosDesdeItemOrdenCompra(mItem, idDetOC)
                        '    'End With

                        '    'myCDPStockMovimiento.Detalles.Add(mItem)



                        'Else
                        '    MsgBoxAjax(Me, "El renglon de requerimiento " & idDetOC & " ya está en el detalle")
                        'End If


                    End If
                End If
            Next
        End With


        Me.ViewState.Add(mKey, myCDPStockMovimiento)
        'GridView1.DataSource = myCDPStockMovimiento.Detalles
        GridView1.DataBind()
        UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()

        ModalPopupExtender2.Hide()
    End Sub



    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        'boton de cierre de grilla popup de copia de solicitudes
        ModalPopupExtender2.Hide()
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


    Protected Sub TextBox3_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox3.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        GrillaAuxItemsOC_Rebind()
        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    Protected Sub Button200_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button200.Click
        'GrillaAuxItemsOC_Rebind()
        'UpdatePanel2.Update()
        'ModalPopupExtender2.Show()
    End Sub


    Sub GrillaAuxItemsOC_Rebind()
        ObjectDataSource2.FilterExpression = "Convert([Orden de compra], 'System.String') LIKE '*" & TextBox3.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Cliente, 'System.String') LIKE '*" & TextBox3.Text & "*'"
        ObjectDataSource2.Select()
        GridView3.DataBind()

    End Sub

    'Protected Sub txtNumeroCDPStockMovimiento2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtNumeroCDPStockMovimiento2.TextChanged
    'txtNumeroCDPStockMovimiento1.Text = CDPStockMovimientoManager.ProximoSubNumero(SC, txtNumeroCDPStockMovimiento2.Text)
    'End Sub

    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click
        Dim output As String
        Dim mPrinter = ""
        Dim mCopias = 1
        Dim Args As String = ""
        'output = ImprimirWordDOT("CDPStockMovimiento_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdCDPStockMovimiento)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa
        output = ImprimirWordDOT(DirApp() & "\Documentos\" & "CDPStockMovimiento_PRONTO_0001.dot", Me, SC, Session, Response, IdCDPStockMovimiento, mPrinter, mCopias, Args, System.IO.Path.GetTempPath & "CDPStockMovimiento.doc")
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
        RequiredFieldValidator4.Enabled = True
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
            'Dim myCDPStockMovimiento 'As DataSetCDPmovimientos = CType(Me.ViewState(mKey), DataSetCDPmovimientos)
            Dim myCDPStockMovimiento = CDPStockMovimientoManager.GetItem(SC, IdCDPStockMovimiento)
            'With myCDPStockMovimiento.CartasPorteMovimientos(0)

            DePaginaHaciaObjeto(myCDPStockMovimiento)

            'End With


            Me.ViewState.Add(mKey, myCDPStockMovimiento) 'guardo en el viewstate el objeto
            CDPStockMovimientoManager.Anular(SC, IdCDPStockMovimiento, cmbUsuarioAnulo.SelectedValue, txtAnularMotivo.Text)
            Response.Redirect(Request.Url.ToString) 'reinicia la pagina
            'BloqueosDeEdicion(myRequerimiento)

            'Y aca tengo que hacer un refresco de todo!...
        Else
            MsgBoxAjax(Me, "PassWord incorrecta")
        End If
    End Sub

    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////

    Sub DePaginaHaciaObjeto(ByRef myCDPStockMovimiento As DataSetCDPmovimientos)
        With myCDPStockMovimiento.CartasPorteMovimientos(0)

            'traigo parámetros generales
            Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)


            .IdExportadorOrigen = BuscaIdClientePreciso(txtDeExportador.Text, SC)
            If .IdExportadorOrigen = -1 Then .IdExportadorOrigen = Nothing
            .IdExportadorDestino = BuscaIdClientePreciso(txtAExportador.Text, SC)
            If .IdExportadorDestino = -1 Then .IdExportadorDestino = Nothing

            .Puerto = BuscaIdWilliamsDestinoPreciso(txtPuerto.Text, SC)
            If .Puerto = -1 Then .Puerto = Nothing

            'ProntoOptionButton(RadioButtonList1, CType(.Entrada_o_Salida, Long))
            .Entrada_o_Salida = RadioButtonListEntradaSalida.SelectedItem.Value

            .NumeroCDPMovimiento = .IdCDPMovimiento 'StringToDecimal(txtNumeroCDPStockMovimiento2.Text)
            .FechaIngreso = txtFechaIngreso.Text

            .Tipo = cmbTipoMovimiento.SelectedValue
            .Vapor = txtVapor.Text
            .Numero = txtNumero.Text
            .Contrato = txtContrato.Text


            .IdStock = Convert.ToInt32(cmbPuntoVenta.Text)





            Dim gr = GridView1.Rows(0)
            .IdArticulo = BuscaIdArticuloPreciso(TextoWebControl(gr.FindControl("txtGrillaDetAC_Articulo")), SC)
            .Cantidad = TextoWebControl(gr.FindControl("txtGrillaDetAC_Cantidad"))


        End With
    End Sub

    Sub DeObjetoHaciaPagina(ByVal myCDPStockMovimiento As DataSetCDPmovimientos)
        RecargarEncabezado(myCDPStockMovimiento)

        'GridView1.DataSource = myCDPStockMovimiento.Detalles
        GridView1.DataBind()
    End Sub

    Protected Sub btnAceptarPopupGrilla_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAceptarPopupGrilla.Click

    End Sub

    Protected Sub btnCancelarPopupGrilla_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelarPopupGrilla.Click

    End Sub


    Protected Sub btnTraerDatosClientes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTraerDatosClientes.Click, txtAExportador.TextChanged
        TraerDatosCliente(BuscaIdClientePreciso(txtAExportador.Text, SC))
        'If Not TraerDatosCliente(SelectedReceiver.Value) Then
        '    'El proveedor no existe

        '    '//////////////////////
        '    'En esta version, voy a sacar esta funcionalidad de alta al vuelo
        '    txtDescProveedor.Text = ""
        '    SelectedReceiver.Value = ""
        '    cmbCondicionIVA.SelectedValue = -1
        '    txtCUIT.Text = ""
        '    Exit Sub
        '    '//////////////////////

        '    cmbCondicionIVA.Enabled = True
        '    txtCUIT.Enabled = True
        '    If SelectedReceiver.Value <> "" Then 'acaban de cambiar un proveedor existente por un alta al vuelo
        '        SelectedReceiver.Value = ""

        '        cmbCondicionIVA.SelectedValue = -1
        '        txtCUIT.Text = ""
        '    End If
        'Else
        '    cmbCondicionIVA.Enabled = False
        '    txtCUIT.Enabled = False
        'End If
    End Sub




    Sub ConmutarClienteProveedor()
        'If RadioButtonListDestino.SelectedItem.Value <> 2 Then
        '    AutoCompleteExtender1.Enabled = True 'cliente
        '    AutoCompleteExtender3.Enabled = False 'proveedor
        '    lblClienteProveedor.Text = "Cliente"
        'Else
        '    AutoCompleteExtender1.Enabled = False
        '    AutoCompleteExtender3.Enabled = True
        '    lblClienteProveedor.Text = "Proveedor"
        'End If
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    Sub RefrescarTalonariosDisponibles()
        'cmbPuntoVenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "PuntosVenta", "TX_PuntosVentaPorIdTipoComprobanteLetra", EntidadManager.IdTipoComprobante.CDPStockMovimiento, "X")
        ''cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT IdPuntoVenta,PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        'cmbPuntoVenta.DataTextField = "Titulo"
        'cmbPuntoVenta.DataValueField = "IdPuntoVenta"
        'cmbPuntoVenta.DataBind()
        'cmbPuntoVenta.SelectedIndex = 0

        'If cmbPuntoVenta.Items.Count = 0 Then
        '    MsgBoxAjax(Me, "No hay talonario para CDPStockMovimientos")
        'Else
        '    RefrescarNumeroTalonario()
        'End If


    End Sub

    Sub RefrescarNumeroTalonario() 'esto tambien podría estar la mitad en el manager
        'está refrescando el talonario tambien en la "vista". Cómo condicionarlo?

        'txtLetra.Text = EntidadManager.LetraSegunTipoIVA(cmbCondicionIVA.SelectedValue)
        'lblLetra.Text = txtLetra.Text


        'If RadioButtonListEsInterna.SelectedItem.Value = 2 Then
        'txtNumeroCDPStockMovimiento2.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaNotaCreditoInterna")
        'Else
        'txtNumeroCDPStockMovimiento2.Text = CDPStockMovimientoManager.ProximoNumeroPorPuntoVentaOTalonario(SC, cmbPuntoVenta.SelectedItem.Text) 'ParametroOriginal(SC, "ProximoFactura")
        'End If

        'cmbPuntoVenta.SelectedIndex = 0


    End Sub


    'Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
    '    Try
    '        RefrescarNumeroTalonario()
    '    Catch ex As Exception

    '    End Try
    'End Sub

    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    Private Function lblClienteProveedor() As Object
        Throw New NotImplementedException
    End Function



    Protected Sub cmbTipoMovimiento_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbTipoMovimiento.TextChanged

        Select Case cmbTipoMovimiento.SelectedItem.Text
            Case "Prestamo", "Transferencia"
                ProntoOptionButton(1, RadioButtonListEntradaSalida) 'entrada
                RadioButtonListEntradaSalida.Enabled = True
            Case "Devolución"
                ProntoOptionButton(2, RadioButtonListEntradaSalida) 'salida
                RadioButtonListEntradaSalida.Enabled = True
            Case "Embarque", "Venta"
                ProntoOptionButton(2, RadioButtonListEntradaSalida) 'salida
                RadioButtonListEntradaSalida.Enabled = False
        End Select

    End Sub
End Class
