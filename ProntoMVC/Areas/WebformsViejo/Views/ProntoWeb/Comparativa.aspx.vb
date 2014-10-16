﻿Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.ParametroManager
Imports Pronto.ERP.Bll.EntidadManager
Imports Pronto.ERP.Bll.ComparativaManager
Imports System.Diagnostics 'para usar Debug.Print
Imports System.Linq
Imports Excel = Microsoft.Office.Interop.Excel



Partial Class Comparativa
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////


    Private DIRFTP As String = "C:\"

    Private IdComparativa As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdComparativa"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdComparativa") = Value
        End Set
    End Property

    Private mPresups As Long


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'LOAD
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        If Not (Request.QueryString.Get("Id") Is Nothing) Then 'si trajo el parametro ID, lo guardo aparte
            IdComparativa = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdComparativa
        End If
        mKey = "Comparativa_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)

        SC = usuario.StringConnection
        HFSC.Value = GetConnectionString(Server, Session) 'para que la grilla de consulta sepa la cadena de conexion
        'AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion
        'AutoCompleteExtender2.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion



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
            'Este pedazo se ejecuta si es la PRIMERA VEZ QUE SE CARGA (es decir, no es postback)
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////

            'PanelDetalle.Attributes("style") = "display:none" 'pongo el popup invisible en tiempo de ejecucion


            'http://forums.asp.net/t/1362149.aspx     para que no se apriete dos veces el boton de ok
            'btnSave.Attributes.Add("onclick", "this.disabled=true;" + ClientScript.GetPostBackEventReference(btnSave, "").ToString())

            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            'para que el click sobre la scrollbar del autocomplete no dispare el postback del textbox que extiende
            'http://aadreja.blogspot.com/2009/07/clicking-autocompleteextender-scrollbar.html
            'Page.Form.Attributes.Add("onsubmit", "return checkFocusOnExtender();")
            '///////////////////////////////////////////////

            '///////////////////////////////////////////////
            '///////////////////////////
            'pongo popups invisible en tiempo de ejecucion, así los puedo ver en tiempo de diseño 
            'busco todas las configuraciones de "PopupControlID="
            PanelInfoNum.Attributes("style") = "display:none"
            Panel1.Attributes("style") = "display:none"
            Panel2.Attributes("style") = "display:none"
            PopUpGrillaConsulta.Attributes("style") = "display:none"
            '///////////////////////////


            'Carga del objeto
            TextBox1.Text = IdComparativa
            BindTypeDropDown()


            Dim myComparativa As Pronto.ERP.BO.Comparativa



            If IdComparativa > 0 Then
                myComparativa = EditarSetup()
                'RecalcularTotalComprobante()
            Else
                myComparativa = AltaSetup()
            End If


            Me.ViewState.Add(mKey, myComparativa) 'creo que esto siempre se debiera hacer antes de AltaSetup o EditarSetup

            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "") 'para qué era esto?

            'BloqueosDeEdicion(myComparativa)
        End If



        '////////////////////////////////

        'RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        'txtRendicion.Enabled = False

        'refresco

    End Sub


    Sub BloqueosDeEdicion(ByVal myComparativa As Pronto.ERP.BO.Comparativa)


        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, session(SESSIONPRONTO_UserId), "Comparativas")

        If Not p("PuedeLeer") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            Response.Redirect(String.Format("Principal.aspx"))
        End If


        If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            'si es un proveedor, deshabilito la edicion


            'habilito el eliminar del renglon
            For Each r As GridViewRow In gvCompara.Rows
                Dim bt As Button
                bt = r.FindControl("Elim.")
                bt.Enabled = True
            Next

            'me fijo si está cerrado
            'DisableControls(Me)
            gvCompara.Enabled = True
            btnOk.Enabled = True
            btnCancel.Enabled = True

            'encabezado
            'txtNumeroComparativa1.Enabled = False
            txtNumeroComparativa2.Enabled = False
            txtFechaIngreso.Enabled = False
            'txtFechaAprobado.Enabled = False
            txtValidezOferta.Enabled = False
            'txtDetalleCondicionCompra.Enabled = False
            'cmbMoneda.Enabled = False
            cmbPlazo.Enabled = False
            'cmbCondicionCompra.Enabled = False
            cmbPlazo.Enabled = False
            txtObservaciones.Enabled = False
            'txtDescArt.Enabled = False
            'txtFechaCierreCompulsa.Enabled = False
            'txtDetalle.Enabled = False



        Else
            'LinkAgregarRenglon.Enabled = True
        End If


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or
        With myComparativa

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


                If .IdAprobo > 0 Then
                    '//////////////////////////
                    'si esta APROBADO o ANULADO, deshabilito la edicion
                    '//////////////////////////




                    'me fijo si está cerrado
                    'DisableControls(Me)
                    gvCompara.Enabled = True
                    btnOk.Enabled = True
                    btnCancel.Enabled = True

                    'encabezado
                    txtObservaciones.Enabled = False
                    txtFechaIngreso.Enabled = False
                    TextBox8.Enabled = False
                    TextBox7.Enabled = False
                    cmbConfecciono.Enabled = False
                    btnAprobar.Enabled = False
                    btnAprobar.Style.Add("visibility", "hidden")

                    'detalle
                    LinkButton1.Enabled = False 'boton "+Agregar item"
                    LinkButton7.Enabled = False
                    gvCompara.Enabled = False
                    gvPie.Enabled = False
                    'txtDetObservaciones.Enabled = False
                    'txtDetTotal.Enabled = False


                    'links a popups
                    'LinkAgregarRenglon.Style.Add("visibility", "hidden")
                    LinkButton1.Style.Add("visibility", "hidden")

                    MostrarBotonesParaAdjuntar()
                Else
                    LinkButton1.Enabled = True
                End If


                'If .Cumplido = "AN" Then
                '    '////////////////////////////////////////////
                '    'y está ANULADO (las comparativas no se anulan)
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

    '////////////////////////////////////////////////////////////////////////////
    '   ALTA SETUP   'preparo la pagina para dar un alta
    '////////////////////////////////////////////////////////////////////////////

    Function AltaSetup() As Pronto.ERP.BO.Comparativa

        Dim myComparativa As Pronto.ERP.BO.Comparativa = New Pronto.ERP.BO.Comparativa
        With myComparativa
            .Id = -1


            ''/////////////////////////////////
            ''/////////////////////////////////
            'agrego renglones vacios. Ver si vale la pena

            'Dim mItem As ComparativaItem = New Pronto.ERP.BO.ComparativaItem
            'mItem.Id = -1
            'mItem.Nuevo = True
            'mItem.Cantidad = 0
            'mItem.Precio = Nothing

            '.Detalles.Add(mItem)
            '.Detalles.Add(mItem) 'agrego renglones vacios
            '.Detalles.Add(mItem)


            ''/////////////////////////////////
            ''/////////////////////////////////
            'Carga de la grilla
            ''/////////////////////////////////
            ''/////////////////////////////////

            ''/////////////
            'Metodo normal
            'gvCompara.DataSource = .Detalles

            ''/////////////
            'Metodo con datatable mediador
            Me.ViewState.Add(mKey, myComparativa) 'lo pongo acá porque sino a la grilla le faltan datos en los eventos
            DeDetalleAGrilla(myComparativa) 'si convierto el detalle a una GUI manualmente

            ''/////////////////////////////////
            gvCompara.DataBind()
            ''/////////////////////////////////
            ''/////////////////////////////////
            ''/////////////////////////////////
            ''/////////////////////////////////

            'If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
            'txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
            'End If


            'txtNumeroComparativa1.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximaComparativa").ToString
            txtNumeroComparativa2.Text = ParametroOriginal(SC, "ProximaComparativa")
            'txtFechaComparativa.Text = System.DateTime.Now.ToShortDateString()
            txtFechaIngreso.Text = System.DateTime.Now.ToShortDateString() 'no se puede poner directamente Now?



            ViewState("PaginaTitulo") = "Nueva Comparativa"
        End With

        Return myComparativa
    End Function


    '////////////////////////////////////////////////////////////////////////////
    '   EDICION SETUP 'preparo la pagina para cargar un objeto existente
    '////////////////////////////////////////////////////////////////////////////

    Function EditarSetup() As Pronto.ERP.BO.Comparativa

        Dim myComparativa As Pronto.ERP.BO.Comparativa = ComparativaManager.GetItem(SC, IdComparativa, True)

        If Not (myComparativa Is Nothing) Then
            With myComparativa
                'txtReferencia.Text = myComparativa.Referencia
                'txtLetra.Text = myComparativa.Letra
                'txtNumeroComparativa1.Text = .SubNumero
                txtNumeroComparativa2.Text = .Numero
                txtFechaIngreso.Text = .Fecha.ToString("dd/MM/yyyy")
                'txtFechaAprobado.Text = .FechaAprobacion.ToString("dd/MM/yyyy")
                'txtFechaCierreCompulsa.Text = .FechaCierreCompulsa.ToString("dd/MM/yyyy")
                'txtRendicion.Text = .NumeroRendicionFF

                '///////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////
                'datos traidos de los presupuestos:
                '///////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////


                Try
                    Dim IdPresupuesto As Long = GetStoreProcedureTop1(SC, enumSPs.Presupuestos_TX_PorNumero, .PresupuestoSeleccionado, .SubNumeroSeleccionado).Item("IdPresupuesto")
                    Dim a = PresupuestoManager.GetItem(SC, IdPresupuesto)
                    With a
                        'txtValidezOferta.Text = PresupuestoManager.GetItem(SC, myComparativa.PresupuestoSeleccionado).Validez
                        txtValidezOferta.Text = .Validez
                        'BuscaIDEnCombo(cmbMoneda, .IdMoneda)
                        'BuscaIDEnCombo(cmbPlazo, PresupuestoManager.GetItem(SC, myComparativa.PresupuestoSeleccionado).Plazo)
                        'BuscaIDEnCombo(cmbCondicionCompra, .IdCondicionCompra)
                        BuscaIDEnCombo(cmbPlazo, .IdPlazoEntrega)
                        'TraerDatosProveedor(.IdProveedor)
                    End With
                Catch ex As Exception

                End Try

                'BuscaTextoEnCombo(cmbTipoComprobante, .IdTipoComprobante.ToString)
                'SelectedReceiver.Value = myComparativa.Proveedor
                'txtDescArt.Text = myComparativa.Proveedor

                'txtCUIT.Text = .Proveedor.ToString
                'PresupuestoManager.GetItem(SC, myComparativa.PresupuestoSeleccionado).Id



                'elige combos
                'BuscaIDEnCombo(cmbCondicionIVA, .)
                'BuscaIDEnCombo(cmbCuenta, .IdCuenta)
                'BuscaIDEnCombo(cmbObra, .IdObra)


                'txtDetalle.Text = .Detalle
                'txtDetalleCondicionCompra.Text = .DetalleCondicionCompra
                txtObservaciones.Text = .Observaciones
                'txtCAI.Text = .NumeroCAI
                'txtFechaVtoCAI.Text = .FechaVencimientoCAI
                'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

                'lnkAdjunto1.Text = .ArchivoAdjunto1
                'chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)


                '///////////////////////////////////////////////////////
                'Firmas
                BuscaIDEnCombo(cmbConfecciono, .IdConfecciono)
                BuscaIDEnCombo(cmbAprobo, .IdAprobo)

                'cmbAprobo.Text = EmpleadoManager.GetItem(SC, myComparativa.IdAprobo).Nombre
                'If myComparativa.Aprobo <> 0 Then
                '    'txtLibero.Text = EmpleadoManager.GetItem(SC, myComparativa.Aprobo).Nombre
                'End If


                '///////////////////////////////////////////////////////
                'Totales
                'pero debiera usar el formato universal...
                'txtSubtotal.Text = String.Format("{0:F2}", DecimalToString(.ImporteIva1)) 'o uso {0:c} o {0:F2} ?
                TextBox7.Text = .MontoParaCompra
                TextBox8.Text = .MontoPrevisto

                txtTotal.Text = String.Format("{0:F2}", DecimalToString(.MontoPrevisto))


                '/////////////////////////
                '/////////////////////////
                'Grilla
                '/////////////////////////
                '/////////////////////////
                'gvCompara.Columns(0).Visible = False
                'gvCompara.DataSource = .Detalles   'si se enlaza con el objeto
                'gvCompara.DataSource = DeDetalleAGrilla()  'si convierto el detalle a una GUI manualmente


                Me.ViewState.Add(mKey, myComparativa) 'lo pongo acá porque sino a la grilla le faltan datos en los eventos

                DeDetalleAGrilla(myComparativa) 'si convierto el detalle a una GUI manualmente
                ' myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)


                gvCompara.DataBind()


                If .PresupuestoSeleccionado > 0 Then
                    'Si fue elegido un presupuesto, marcar con un check el header de la columna correspondiente
                    Dim chk As CheckBox = CType(gvCompara.HeaderRow.Cells(.SubNumeroSeleccionado + 2).Controls(3), CheckBox)
                    chk.Checked = True
                End If


                'Me.Title = "Edición Fondo Fijo " + myComparativa.Letra + myComparativa.NumeroComprobante1.ToString + myComparativa.NumeroComprobante2.ToString
                ViewState("PaginaTitulo") = "Edición Comparativa " + .Numero.ToString
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
        Else
            MsgBoxAjax(Me, "El comprobante con ID " & IdComparativa & " no se pudo cargar. Consulte al Administrador")
        End If

        Return myComparativa
    End Function




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

        'cmbLibero.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        'cmbLibero.DataTextField = "Titulo"
        'cmbLibero.DataValueField = "IdEmpleado"
        'cmbLibero.DataBind()

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbPlazo.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "PlazosEntrega")
        cmbPlazo.DataTextField = "Titulo"
        cmbPlazo.DataValueField = "IdPlazoEntrega"
        cmbPlazo.DataBind()
        'If IsNumeric(Session("glbIdCuentaFFUsuario")) Then
        '    cmbPlazo.SelectedValue = Session("glbIdCuentaFFUsuario")
        '    cmbPlazo.Enabled = False
        'Else
        cmbPlazo.Items.Insert(0, New ListItem("-- Elija un Plazo --", -1))
        'cmbPlazo.SelectedIndex = 0
        'End If



        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'Firmas

        'cmbAprobo.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        Try
            cmbAprobo.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "") 'Comparativas solo acepta a gente del sector de compras
        Catch e As Exception
            'como todavia no manejo los parametros opcionales, si explota la nueva version de TX_PorSector, lo llamo con tres parametros
            cmbAprobo.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "", "") 'Comparativas solo acepta a gente del sector de compras
        End Try
        cmbAprobo.DataTextField = "Titulo"
        cmbAprobo.DataValueField = "IdEmpleado"
        cmbAprobo.DataBind()
        cmbAprobo.Items.Insert(0, New ListItem("-- Elija un Usuario --", -1))



        'cmbConfecciono.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        Try
            cmbConfecciono.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "") 'Comparativas solo acepta a gente del sector de compras
        Catch e As Exception
            'como todavia no manejo los parametros opcionales, si explota la nueva version de TX_PorSector, lo llamo con tres parametros
            cmbConfecciono.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "", "") 'Comparativas solo acepta a gente del sector de compras
        End Try
        cmbConfecciono.DataTextField = "Titulo"
        cmbConfecciono.DataValueField = "IdEmpleado"
        cmbConfecciono.DataBind()
        'cmbConfecciono.Items.Insert(0, New ListItem("-- Elija un Usuario --", -1))


        'POPUP de Firma
        'cmbLibero.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        Try
            cmbLibero.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "") 'Comparativas solo acepta a gente del sector de compras
        Catch e As Exception
            'como todavia no manejo los parametros opcionales, si explota la nueva version de TX_PorSector, lo llamo con tres parametros
            cmbLibero.DataSource = EntidadManager.GetListTX(SC, "Empleados", "TX_PorSector", "Compras", "", "") 'Comparativas solo acepta a gente del sector de compras
        End Try
        cmbLibero.DataTextField = "Titulo"
        cmbLibero.DataValueField = "IdEmpleado"
        cmbLibero.DataBind()

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

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
            'If Not IsDate(txtFechaRequerimiento.Text) Then
            'lblFecha.Visible = True
            ' mOk = False
            ' End If

            mOk = True

            If mOk Then
                Dim mIdCodigoIva As Integer
                Dim mIdProveedor As Long

                Dim mIdCuentaIvaCompras(10) As Long
                Dim mIVAComprasPorcentaje(10) As Single



                DeGrillaADetalle()



                'If Not mAltaItem Then 'y esto?

                Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)

                With myComparativa

                    'traigo parámetros generales
                    Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    '.IdMoneda = drParam.Item("ProximoComparativaReferencia").ToString 'mIdMonedaPesos
                    '.IdMoneda = cmbMoneda.SelectedValue

                    '.SubNumero = StringToDecimal(txtNumeroComparativa1.Text)
                    .Numero = StringToDecimal(txtNumeroComparativa2.Text)



                    '.DetalleCondicionCompra = txtDetalleCondicionCompra.Text

                    '.CotizacionMoneda = 1
                    .Fecha = iisValidSqlDate(txtFechaIngreso.Text, Nothing)
                    .FechaAprobacion = .Fecha ' iisValidSqlDate(txtFechaAprobado.Text, Nothing)
                    '.FechaCierreCompulsa = txtFechaCierreCompulsa.Text


                    .MontoParaCompra = StringToDecimal(TextBox7.Text)
                    .MontoPrevisto = StringToDecimal(TextBox8.Text)
                    '.Validez = txtValidezOferta.Text
                    '.IdPlazoEntrega = cmbPlazo.SelectedValue


                    '.Detalle = txtDetalle.Text
                    '.DetalleCondicionCompra = txtDetalleCondicionCompra.Text
                    '.Observaciones = txtObservaciones.Text
                    '.ArchivoAdjunto1 = lnkAdjunto1.Text


                    '.ImporteTotal = StringToDecimal(txtTotal.Text)

                    '//////////////////////////////////////
                    'Firmas
                    .IdConfecciono = cmbConfecciono.SelectedValue
                    .IdAprobo = cmbAprobo.SelectedValue
                    '//////////////////////////////////////


                    '.IdMoneda = cmbMoneda.SelectedValue
                    '.IdPlazoEntrega = cmbPlazo.SelectedValue
                    '.IdCondicionCompra = cmbCondicionCompra.SelectedValue

                    '.IdProveedor = Convert.ToInt32(SelectedReceiver.Value)
                    '.ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
                    .ConfirmadoPorWeb = IIf(.IdAprobo <> 0, "SI", "NO") 'lo doy por confirmado si lo liberan

                    'If .IdComprador = 0 Then .IdComprador = session(SESSIONPRONTO_glbIdUsuario) 'Si lo edita un proveedor, no debe pisar el IdComprador
                    .Observaciones = txtObservaciones.Text




                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'MONO O MULTIPRESUPUESTO?
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    'Me fijo si seleccionó un solo presupuesto
                    'puede quedar en -1 (multi), en NULL (sin terminar )o en el Presupuesto elegido

                    'como la matriz es mas facil para explorar que la lista de items, busco ahí ...
                    Dim tab As DataTable
                    tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa)

                    'primero verifico si estan todos seleccionados
                    Dim FilasSinCompletar As Boolean = False
                    For Each r As DataRow In tab.Rows
                        If Not (iisNull(r("M1"), False) Or iisNull(r("M2"), False) Or iisNull(r("M3"), False) _
                                Or iisNull(r("M4"), False) Or iisNull(r("M5"), False) Or iisNull(r("M6"), False) _
                                Or iisNull(r("M7"), False) Or iisNull(r("M8"), False) Or iisNull(r("M9"), False) _
                                Or iisNull(r("M10"), False) Or iisNull(r("M11"), False) Or iisNull(r("M12"), False)) Then
                            FilasSinCompletar = True
                            Exit For
                        End If
                    Next

                    If FilasSinCompletar Then
                        'No se terminó de elegir en la comparativa

                        .PresupuestoSeleccionado = 0 'se guardan como null
                        .SubNumeroSeleccionado = 0 'se guardan como null
                    Else
                        'Se eligió todo. Pero es multi o mono?

                        'agarro el presupuesto elegido en la primera linea, y lo comparo con los demas
                        Dim PresupuestosDistintos As Boolean = False
                        Dim IdPresuRef As Long = 0
                        If .Detalles.Count = 0 Then
                            MsgBoxAjax(Me, "La comparativa está vacía")
                            Exit Sub
                        End If
                        'esta busqueda sí es más fácil de buscar en la lista de items que en la matriz
                        For Each item As ComparativaItem In .Detalles
                            If item.Estado = "MR" Then
                                'es el primero?
                                'agarro el presupuesto elegido en la primera linea, y lo comparo con los demas
                                If IdPresuRef = 0 Then
                                    IdPresuRef = item.IdPresupuesto
                                Else
                                    If IdPresuRef <> item.IdPresupuesto Then
                                        PresupuestosDistintos = True
                                        Exit For
                                    End If
                                End If
                            End If
                        Next

                        If PresupuestosDistintos Then
                            .PresupuestoSeleccionado = -1
                            .SubNumeroSeleccionado = -1
                        Else
                            .PresupuestoSeleccionado = PresupuestoManager.GetItem(SC, IdPresuRef).Numero
                            .SubNumeroSeleccionado = PresupuestoManager.GetItem(SC, IdPresuRef).SubNumero
                        End If
                    End If
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////


                End With





                If ComparativaManager.IsValid(myComparativa) Then
                    Try
                        If ComparativaManager.Save(SC, myComparativa) = -1 Then
                            'no aduvo
                            MsgBoxAjax(Me, "El objeto fue validado y sin embargo no se pudo grabar. Consulte con el Administrador. Ver en la consola el error")
                            Exit Sub
                        Else
                            'grabó bien
                            '//////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////
                            '//////////////////////////////////////////////////////////////////////////////
                            'http://www.sitepoint.com/forums//showthread.php?t=483413




                            ', "La comparativa fue grabada con el número " & myComparativa.Numero) 'NO! Estos mensajes no van a funcionar si al toque voy a EndEditing y hago el redirect al listado...


                            'poner en el redirect del EndEditing esto:
                            'Response.Write("<script>alert('message') ; window.location.href='nextpage.aspx'</script>")
                            ' o tambien se puede usar un confirm button 

                            '//////////////////////////////////////////////////////////////////////////////

                        End If
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.Message)
                    End Try


                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Incremento de número en capa de UI. Evitar.Fields("
                    If IdComparativa = -1 Then
                        If ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, ParametroManager.ePmOrg.ProximaComparativa, (myComparativa.Numero + 1).ToString) = -1 Then MsgBoxAjax(Me, "Hubo un error al modificar los parámetros")
                    End If
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    If myComparativa.Numero <> StringToDecimal(txtNumeroComparativa2.Text) Then
                        EndEditing("La comparativa fue grabada con el número " & myComparativa.Numero) 'me voy 
                    Else
                        EndEditing()
                    End If

                Else
                    MsgBoxAjax(Me, "El objeto no es válido")
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
            Response.Redirect(String.Format("Comparativas.aspx"))
        End If
    End Sub



    Protected Sub ButVolver_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButVolver.Click

        Response.Redirect(String.Format("Comparativas.aspx"))
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
    'CONVERSION MANUAL DE LA GRILLA <-----> COLECCION DETALLE y viceversa.
    'Como esto depende de cada objeto (de hecho, lo estoy haciendo porque la comparativa tiene
    'una interfaz "loca"), no sé si ponerlo en el codigo de la pagina o en el manager. Esto 
    'con Fede iba siempre en la página. Y creo que tiene que ser así nomás. (pasa que
    'las grillas ahora están enlazadas. En los ABMs al ".Detalles" del comprobante, y en los listados
    'al ObjectDataSource.
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    Sub DeGrillaADetalle()

        'restauro el objeto a partir del viewstate
        Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)


        'En realidad no tengo necesitdad de scanear esta grilla, 
        'si despues de todo está enlazada! -NOOO! precisamente esta grilla NO ESTA enlazada! (el 
        ' datatable mediador de DeDetalleAGrilla es TEMPORAL!)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        With gvCompara
            For Each fila As GridViewRow In .Rows
                '//////////////////////
                'metodo 1
                'If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                '    chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                '    If chkFirmar.Checked Then

                '        Dim idRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdAux2")
                '        Dim oRM As Pronto.ERP.BO.Requerimiento = RequerimientoManager.GetItem(SC, idRM, True)
                '        Dim oDetRM As RequerimientoItem
                '        Dim idDetRM As Integer = .DataKeys(fila.RowIndex).Values.Item("IdDetalleRequerimiento")
                '        'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)
                '    End If
                'End If

                '//////////////////////
                'metodo 2
                For c = 2 To 8
                    'sería bueno tener el ID en la celda

                    'La coleccion Grilla.DataKeys(fila.RowIndex).Values.Item(0) tiene las keys de la grilla. 
                    'Para las columnas, usá Grilla.Rows(fila).Cells(col)
                    'If IsNumeric(GVFirmas.Rows(fila.RowIndex).Cells(3).Text) Then

                    Dim p As ComparativaItem
                    Dim idArticulo As Long = .DataKeys(fila.RowIndex).Values.Item("Id")
                    Dim subNumero As Long = c - 1
                    p = myComparativa.Detalles.Find(Function(obj) obj.IdArticulo = idArticulo And obj.SubNumero = subNumero)

                    'por si no encuentro el nombre del control
                    'For Each Control In fila
                    ' Debug.Print()
                    'Next

                    If p IsNot Nothing Then
                        chkFirmar = CType(fila.FindControl("check" & c - 1), CheckBox)
                        If chkFirmar.Checked Then
                            Debug.Print("fila " & fila.RowIndex & " col " & c - 1)
                            p.Estado = "MR"
                        Else
                            p.Estado = ""
                        End If
                    End If
                Next

            Next
        End With


        '///////////////////////////////////////
        '///////////////////////////////////////
        'Otro metodo: haciendolo con el datasource
        Dim tab As DataTable = gvCompara.DataSource

        'For Each row As DataRow In tab.Rows
        '    For c = 2 To 8
        '        'sería bueno tener el ID en la celda
        '        Dim p As ComparativaItem
        '        Dim idArticulo As Long = row.Item("Id")
        '        Dim idPresupuesto As Long = (c - 2)
        '        p = myComparativa.Detalles.Find(Function(obj) obj.IdArticulo = idArticulo And obj.IdPresupuesto = idPresupuesto)
        '        If row.Item("M" & (c - 2)) Then
        '            p.Estado = "MR"
        '        Else
        '            p.Estado = ""
        '        End If
        '    Next
        'Next



        Me.ViewState.Add(mKey, myComparativa)



    End Sub



    Sub DeDetalleAGrilla(ByVal myComparativa As Pronto.ERP.BO.Comparativa)



        'Dim dr As Data.DataRow = tab.NewRow()
        'tab.Rows.Add(dr)



        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        'gvCompara.AutoGenerateColumns = False
        'gvCompara.DataKeyNames = Nothing
        'gvCompara.Columns(6).ItemStyle=

        'Debug.Print(tab.Rows(11).Item("Producto"), tab.Rows(11).Item("M1"))

        Dim tab As DataTable
        tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa)
        gvCompara.DataSource = tab

        mPresups = From o In myComparativa.Detalles Select New With {Key o.SubNumero} Distinct.Count()
        
        gvCompara.DataBind() 'fijate que este puesto el autogeneratecolumns



        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        'cambiar nombres de las columnas cuando están metidas en un header template

        'Dim row As GridViewRow = gvCompara.HeaderRow
        'Dim lbl As Label = DirectCast(row.FindControl("Titulo1"), Label)
        'lbl.Text = "New Header"


        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        'escondo las columnas de la grilla
        If myComparativa.Detalles IsNot Nothing Then
            For i = 1 To ComparativaManager.kMaximoSubnumeroDePresupuestoAceptable 'myComparativa.Detalles.Count - 1
                Dim p As Pronto.ERP.BO.ComparativaItem
                Dim tempi = i
                p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                If p Is Nothing Then
                    'http://social.msdn.microsoft.com/Forums/en-US/wpf/thread/30b7ed89-2ae1-451f-922a-b82078129a0c
                    gvCompara.Columns.Item(i + 2).Visible = False '2 columnas fijas
                Else
                    gvCompara.Columns.Item(i + 2).Visible = True
                    'gvPie.Columns(i + 1).Width = gvCompara.Columns(i + 2).width
                End If
            Next
        End If


        Dim tab2 As DataTable
        Try
            tab2 = TraerPie(SC, myComparativa)
        Catch ex As Exception
            tab2 = Nothing
        End Try
        gvPie.DataSource = tab2
        gvPie.DataBind() 'fijate que este puesto el autogeneratecolumns


        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        'busco el menor precio de la fila y le pongo ponerhappy visible

        'For Each filagrilla As GridViewRow In gvCompara.Rows
        '    Dim Llave() As Object = {gvCompara.DataKeys(filagrilla.RowIndex).Values.Item("Id"), _
        '                             gvCompara.DataKeys(filagrilla.RowIndex).Values.Item("Cantidad")}
        '    Dim filatabla As DataRow = tab.Rows.Find(Llave)
        '    Dim iconoMenorPrecio As Image
        '    If filatabla Is Nothing Then Continue For

        '    'no se puede usar findcontrol así nomás para buscar anidados. Tengo que indicarle la columna (cell)
        '    Dim col = filatabla.Item("ColumnaConMenorPrecioDeLaFila")
        '    'iconoMenorPrecio = CType(filagrilla.Cells(col + 1).FindControl("Image" & col), Image)
        '    Try
        '        iconoMenorPrecio = CType(filagrilla.Cells(col + 1).Controls(1), Image)
        '        If iconoMenorPrecio IsNot Nothing Then iconoMenorPrecio.Visible = True
        '    Catch
        '    End Try
        'Next



        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////
        'datos del pie
        '//////////////////////////////////////////////////////////
        'gvCompara.Rows.a()

        'Dim h As GridViewRow = gvCompara.HeaderRow
        'For Each col As INamingContainer In gvCompara.c.Columns
        '    gvPie.HeaderRow = h
        'Next
        'una vez que copio las columnas de la grilla, me traigo los datos




    End Sub




    Protected Sub gvCompara_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvCompara.RowDataBound

        Try
            If e.Row.Cells.Count > 2 Then 'por qué no habría de ser así?
                e.Row.Cells(1).Width = 150
                e.Row.Cells(2).Width = 70
            End If
        Catch ex As Exception

        End Try



        Dim anchoCols = (674 - 150 - 70) / mPresups '.....





        If e.Row.RowType = DataControlRowType.DataRow Then

            'si esta check, pinto la celda
            'For Each cell As TableCell In e.Row.Cells
            For i = 3 To e.Row.Cells.Count - 1
                Dim cell As TableCell = e.Row.Cells(i)
                cell.Width = anchoCols
                Try
                    Debug.Print(cell.Controls(5).ClientID)
                    Dim chk As CheckBox = CType(cell.Controls(5), CheckBox)
                    'If DataBinder.Eval(e.Row.DataItem, "unitprice") < 0D Then
                    If chk.Checked Then
                        'lbl.ForeColor = Drawing.Color.Red
                        cell.BackColor = Drawing.Color.PaleGoldenrod
                    Else
                        cell.BackColor = e.Row.Cells(0).BackColor 'copio el color de la celda de la izquierda (ya que no puede ser la primera)
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex)
                    Debug.Print(ex.Message)
                End Try
            Next

        End If


    End Sub

    Protected Sub gvPie_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvPie.RowDataBound
        'Ajusto la grilla pie a las columnas de la grilla principal

        'e.Columns.Item(i + 1).Visible = gvCompara.Columns.Item(i + 2).Visible
        'e.Columns(0).ItemStyle.Width = gvCompara.Columns(0).ItemStyle.Width.Value + gvCompara.Columns(1).ItemStyle.Width.Value

        'e.Row.Cells(0).Width = gvCompara.Columns(1).ItemStyle.Width.Value + gvCompara.Columns(2).ItemStyle.Width.Value 'la de prod y cant
        e.Row.Cells(0).Width = 226 'gvCompara.Columns(1).ItemStyle.Width.Value + 93
        For c = 1 To e.Row.Cells.Count - 1
            '//////////////
            'oculto o muestro
            '//////////////
            e.Row.Cells(c).Visible = gvCompara.Columns(c + 2).Visible




            '//////////////
            'ancho: ajusto el ancho de las columnas a la de la grilla de arriba (
            '                           P1      P2
            ' gv1 :  | prod  | cant  |      |      |
            ' gv2 :  |     sarasa    |      |      |

            '//////////////


            Try
                If gvCompara.Rows.Count > 0 Then 'por qué la grilla no habría de tener renglones?
                    e.Row.Cells(c).Width = gvCompara.Rows(0).Cells(c + 2).Width.Value            'gvCompara.Columns(c + 2).ItemStyle.Width
                    Debug.Print("col " & c & " , ancho " & e.Row.Cells(c).Width.Value)
                End If
            Catch ex As Exception

            End Try


            'e.Row.Cells(c).Width = 200
            'Debug.Print(gvCompara.Columns(c + 2).ItemStyle.Width.Value)
            'Debug.Print(gvCompara.Columns(c + 2).ControlStyle.Width.Value)
            'Dim gvw As GridViewRow = gvCompara.Rows(0)
            'Debug.Print(gvw.Cells(0).Width.Value)


            'http://stackoverflow.com/questions/2420513/how-to-align-columns-in-multiple-gridviews
            '-Is it just too much to ask because the dynamic column widths are up to the browser?
            '-Pretty much. Unless you explictly set the column width, the browser will choose,  
            'so ASP.NET has no knowledge of it. You could probably use some jQuery to compensate though:

            '$(function() {
            '   var maxWidth = 0;
            '   $('TBODY TR:first TD.col1').each(function() {
            '       maxWidth = $(this).width > maxWidth ? $(this).width : maxWidth;
            '   });

            '   $('TBODY TR:first TD.col1').width(maxWidth);
            '});


        Next
    End Sub





    Public Shared Function TraerPie(ByVal SC As String, ByVal myComparativa As Pronto.ERP.BO.Comparativa) As DataTable

        Dim oRsFlex As adodb.Recordset
        Dim oRs As adodb.Recordset
        Dim oFld As adodb.Field
        Dim Campo As String, CampoObs As String, CampoTot As String, mvarProv As String
        Dim mvarObservaciones As String, mvarPlazo As String, mvarCond As String
        Dim mvarArticulo As String, mvarArticuloConObs As String, mvarArticuloSinObs As String
        Dim mvarUnidad As String, mvarMoneda As String, mvarPrimerPresupuesto As String
        Dim mvarCol As Integer, i As Integer, mvarItem As Integer
        Dim mOrigenDescripcion As Integer
        Dim CampoExistente As Boolean, RegistroExistente As Boolean, FlagPrimerPresupuesto As Boolean
        Dim mvarIdPre As Long, mvarPresu As Long, mvarSubNum As Long, mvarIdCond As Long
        Dim mvarIdMoneda As Long
        Dim mvarFecha As Date
        Dim mvarCantidad As Double, mvarPrecio As Double, mvarBonificacionPorItem As Double
        Dim mvarCotizacionMoneda As Double


        Dim tab As Data.DataTable = New Data.DataTable()
        'COLUMNAS
        tab.Columns.Add("   ")
        tab.Columns.Add("prov1")
        tab.Columns.Add("prov2")
        tab.Columns.Add("prov3")
        tab.Columns.Add("prov4")
        tab.Columns.Add("prov5")
        tab.Columns.Add("prov6")
        tab.Columns.Add("prov7")
        tab.Columns.Add("prov8")
        tab.Columns.Add("prov9")
        tab.Columns.Add("prov10")
        tab.Columns.Add("prov11")
        tab.Columns.Add("prov12")



        ' RENGLONES DEL PIE
        ' "Subtotal"
        ' "Bonificacion"
        ' "TOTAL"
        ' "Plazo de entrega"
        ' "Condicion de pago"
        ' "Observaciones"
        ' "Solicitud de cotizacion nro."


        'If tab.Rows.Count > 0 Then

        Dim mvarSubtotal(100), mvarBonificacion(100), mvarIVA(100), mvarTotal(100), mvarPorcIva1(100), mvarPorcIva2(100) As Double
        Dim mPorcIva1 As Double

        With tab

            'Reinicio
            mPorcIva1 = 0
            For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                mvarSubtotal(i) = 0
                mvarBonificacion(i) = 0
                mvarIVA(i) = 0
                mvarTotal(i) = 0
                mvarPorcIva1(i) = 0
                mvarPorcIva2(i) = 0
            Next

            Dim r As DataRow

            '///////////////////////////////////////
            '///////////////////////////////////////
            '///////////////////////////////////////
            'exploro la tabla, y calculo los totales
            '///////////////////////////////////////
            '///////////////////////////////////////
            '///////////////////////////////////////
            Dim t = GUI_DeDetalleAGrilla(SC, myComparativa)

            For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                Dim tempi = i
                Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                If p Is Nothing Then Continue For
                mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                mvarSubNum = i
                oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "Presupuestos", "TX_BonificacionesPorNumero", mvarPresu, mvarSubNum))
                If oRs.RecordCount > 0 Then
                    If Not IsNull(oRs.Fields("Bonificaciones").Value) Then
                        mvarBonificacion(i) = oRs.Fields("Bonificaciones").Value
                    End If
                    oRs.Close()
                End If
                For Each d As DataRow In t.Rows
                    mvarSubtotal(i) = mvarSubtotal(i) + iisNull(d.Item("Cantidad"), 0) * iisNull(d.Item("Precio" & i), 0)
                Next
            Next


            '///////////////////////////////////////
            '///////////////////////////////////////
            '///////////////////////////////////////
            '///////////////////////////////////////
            'agrego los renglones
            '///////////////////////////////////////
            '///////////////////////////////////////
            '///////////////////////////////////////

            With r

                r = tab.NewRow() 'los indices de IdArticulo y Cantidad, truchados para estos renglones adicionales (mmmmm)
                r.Item(0) = "Subtotal"
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    r.Item(i) = "" & FormatVB6(mvarSubtotal(i), "#,##0.00")
                Next
                tab.Rows.Add(r)


                r = tab.NewRow()
                r.Item(0) = "Bonificacion"
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    Dim tempi = i
                    Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                    If p Is Nothing Then Continue For
                    mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                    mvarSubNum = i
                    oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum))
                    If oRs.RecordCount > 0 Then
                        mvarPorcIva1(i) = IIf(IsNull(oRs.Fields("PorcentajeIva1")), 0, oRs.Fields("PorcentajeIva1").Value)
                        mvarPorcIva2(i) = IIf(IsNull(oRs.Fields("PorcentajeIva2")), 0, oRs.Fields("PorcentajeIva2").Value)
                        If mvarPorcIva1(i) > 0 Then
                            mPorcIva1 = mvarPorcIva1(i)
                        End If
                        If Not IsNull(oRs.Fields("Bonificacion").Value) Then
                            If mvarBonificacion(i) = 0 Then r.Item(i) = "" & oRs.Fields("Bonificacion").Value & "%"
                            mvarBonificacion(i) = mvarBonificacion(i) + Math.Round(mvarSubtotal(i) * oRs.Fields("Bonificacion").Value / 100, 2)
                        End If
                    End If
                    oRs.Close()
                    r.Item(i) = mvarBonificacion(i) * -1
                Next
                tab.Rows.Add(r)

                r = tab.NewRow()
                r.Item(0) = "TOTAL"
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    mvarTotal(i) = mvarSubtotal(i) - mvarBonificacion(i) + mvarIVA(i)
                    r.Item(i) = "" & FormatVB6(mvarTotal(i), "#,##0.00")
                Next
                tab.Rows.Add(r)


                r = tab.NewRow()
                r.Item(0) = "Plazo de entrega"
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    Dim tempi = i
                    Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                    If p Is Nothing Then Continue For
                    mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                    mvarSubNum = i
                    oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum))
                    If oRs.RecordCount > 0 Then
                        mvarPlazo = IIf(IsNull(oRs.Fields("PlazoEntrega").Value), "", oRs.Fields("PlazoEntrega").Value)
                    End If
                    oRs.Close()
                    r.Item(i) = mvarPlazo
                Next
                tab.Rows.Add(r)


                r = tab.NewRow()
                r.Item(0) = "Condicion de pago"
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    Dim tempi = i
                    Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                    If p Is Nothing Then Continue For
                    mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                    mvarSubNum = i
                    oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum))
                    If oRs.RecordCount > 0 Then
                        If iisNull(oRs.Fields("DetalleCondicionCompra").Value) = "" Then
                            mvarIdCond = oRs.Fields("IdCondicionCompra").Value
                            oRs.Close()
                            oRs = DataTable_To_Recordset(EntidadManager.GetListTX(SC, "CondicionesCompra", "TX_PorId", mvarIdCond).Tables(0))
                            If oRs.RecordCount > 0 Then
                                mvarCond = oRs.Fields("Descripcion").Value
                            End If
                        Else
                            mvarCond = oRs.Fields("DetalleCondicionCompra").Value
                        End If
                    End If
                    oRs.Close()
                    r.Item(i) = mvarCond
                Next
                tab.Rows.Add(r)


                r = tab.NewRow()
                r.Item(0) = "Observaciones"
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    Dim tempi = i
                    Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                    If p Is Nothing Then Continue For
                    mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                    mvarSubNum = i
                    oRs = ConvertToRecordset(EntidadManager.GetListTX(SC, "Presupuestos", "TX_PorNumero", mvarPresu, mvarSubNum))
                    If oRs.RecordCount > 0 Then
                        mvarObservaciones = IIf(IsNull(oRs.Fields("Observaciones").Value), "", oRs.Fields("Observaciones").Value)
                    End If
                    oRs.Close()
                    r.Item(i) = Mid(mvarObservaciones, 1, 1000)
                Next
                tab.Rows.Add(r)


                r = tab.NewRow()
                r.Item(0) = "Solicitud de cotizacion nro."
                For i = 1 To kMaximoSubnumeroDePresupuestoAceptable
                    Dim tempi = i
                    Dim p As ComparativaItem = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi)
                    If p Is Nothing Then Continue For
                    mvarPresu = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
                    mvarSubNum = i
                    r.Item(i) = FormatVB6(mvarPresu, "000000") & " / " & FormatVB6(mvarSubNum, "00")
                Next
                tab.Rows.Add(r)

            End With
        End With
        'End If
        Return tab
    End Function







    Protected Sub gvCompara_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvCompara.RowCreated
        'parche asqueroso solo para poner los encabezados. hacer bien
        If e.Row.RowIndex <> 0 Then
            'es la primera fila despues del encabezado, así que está creado ya. En realidad, este codigo lo tengo que llamar despues de que se terminó de renderear la grilla
            Dim row As GridViewRow = gvCompara.HeaderRow
            If row IsNot Nothing AndAlso mKey IsNot Nothing Then
                Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)
                If myComparativa IsNot Nothing Then
                    Dim lbl As Label = DirectCast(row.FindControl("Titulo1"), Label)
                    lbl.Text = "New Header"

                    Dim p As Pronto.ERP.BO.ComparativaItem

                    For i = 1 To ComparativaManager.kMaximoSubnumeroDePresupuestoAceptable
                        Dim tempi = i
                        p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = tempi) 'uso tempi por lo del lambda en el find
                        If p IsNot Nothing Then DirectCast(row.FindControl("Titulo" & tempi), Label).Text = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Proveedor
                    Next

                End If
            End If
        End If

    End Sub










    Protected Sub HeaderCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'this is for header checkbox changed event
        'http://onetidbit.wordpress.com/2008/06/23/checking-header-checkbox-checks-all-checkboxes-in-gridview/
        'Dim cbSelectedHeader As CheckBox = gvCompara.HeaderRow.FindControl("cboxhead") '//if u checked header checkbox automatically all the check boxes will be checked,viseversa

        Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)

        Dim nombreCheck As String = "check" + Mid(sender.id, 9) 'sender.id trae la columna que interesa

        If (sender.Checked = True) Then
            'desmarco todo
            For Each row As GridViewRow In gvCompara.Rows
                For i = 0 To row.Cells.Count - 1
                    Dim cell As TableCell = row.Cells(i)
                    For Each c As Control In cell.Controls
                        If TypeOf c Is CheckBox Then
                            Dim check As CheckBox
                            check = c
                            check.Checked = False

                            cell.BackColor = row.Cells(0).BackColor
                        End If
                    Next
                Next
            Next

            'marco los checks de la misma columna
            For Each row As GridViewRow In gvCompara.Rows
                Dim cbSelected As CheckBox = row.FindControl(nombreCheck)
                If (sender.Checked = True) Then
                    cbSelected.Checked = True

                    Dim cell As TableCell = cbSelected.Parent
                    cell.BackColor = Drawing.Color.PaleGoldenrod
                Else
                    cbSelected.Checked = False
                End If
            Next

            '//////////////////////////////////
            'marco el presupuesto en el objeto
            Dim p As Pronto.ERP.BO.ComparativaItem
            p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = Val(Mid(sender.id, 9)))
            myComparativa.PresupuestoSeleccionado = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Numero
            myComparativa.SubNumeroSeleccionado = Mid(sender.id, 9)
            '//////////////////////////////////



            'desmarco los otros headers checks 
            For Each cell As TableCell In gvCompara.HeaderRow.Cells
                For Each c As Control In cell.Controls
                    If TypeOf c Is CheckBox And c.ID <> sender.id Then
                        Dim check As CheckBox
                        check = c
                        check.Checked = False
                    End If
                Next
            Next


        Else
            myComparativa.PresupuestoSeleccionado = -1
            myComparativa.SubNumeroSeleccionado = -1

            'desmarco la columna elegida
            For Each row As GridViewRow In gvCompara.Rows
                Dim cbSelected As CheckBox = row.FindControl(nombreCheck)
                cbSelected.Checked = False

                Dim cell As TableCell = cbSelected.Parent
                cell.BackColor = row.Cells(0).BackColor
            Next

        End If



        Me.ViewState.Add(mKey, myComparativa)


    End Sub

    Protected Sub ItemCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'this is for header checkbox changed event
        'http://onetidbit.wordpress.com/2008/06/23/checking-header-checkbox-checks-all-checkboxes-in-gridview/
        'Dim cbSelectedHeader As CheckBox = gvCompara.HeaderRow.FindControl("cboxhead") '//if u checked header checkbox automatically all the check boxes will be checked,viseversa

        Dim row As GridViewRow = sender.parent.parent  'la row de gvCompara donde marcaron el check

        If sender.Checked = True Then


            Dim nombreCheck As String = sender.id

            For i = 0 To row.Cells.Count - 1
                Dim cell As TableCell = row.Cells(i)
                For Each c As Control In cell.Controls
                    If TypeOf c Is CheckBox Then
                        Dim check As CheckBox
                        check = c
                        If check.ID = sender.id Then
                            check.Checked = True
                            cell.BackColor = Drawing.Color.PaleGoldenrod
                        Else
                            check.Checked = False
                            cell.BackColor = row.Cells(0).BackColor 'copio el color de la celda de la izquierda (ya que no puede ser la primera)
                        End If
                    End If
                Next
            Next
        Else
            Dim cell As TableCell = sender.parent
            cell.BackColor = row.Cells(0).BackColor
        End If


    End Sub

    'Tengo que hacer toda un hissstoria para poner un put0 check en la grilla....
    'Create a template class to represent a dynamic template column.
    'http://msdn.microsoft.com/en-us/library/system.web.ui.webcontrols.templatefield.templatefield.aspx

    'Although you can dynamically add fields to a data-bound control, it is strongly recommended 
    'that fields be statically declared and then shown or hidden, as appropriate. 
    'Statically declaring all your fields reduces the size of the view state for the parent data-bound control.


    Public Class GridViewTemplate
        Implements ITemplate

        Private templateType As DataControlRowType
        Private columnName As String

        Sub New(ByVal type As DataControlRowType, ByVal colname As String)
            templateType = type
            columnName = colname
        End Sub

        Sub InstantiateIn(ByVal container As System.Web.UI.Control) _
          Implements ITemplate.InstantiateIn

            ' Create the content for the different row types.
            Select Case templateType

                Case DataControlRowType.Header
                    ' Create the controls to put in the header
                    ' section and set their properties.
                    Dim lc As New Literal
                    lc.Text = "<b>" & columnName & "</b>"

                    ' Add the controls to the Controls collection
                    ' of the container.
                    container.Controls.Add(lc)

                Case DataControlRowType.DataRow
                    ' Create the controls to put in a data row
                    ' section and set their properties.
                    Dim firstName As New Label
                    Dim lastName As New Label

                    Dim spacer = New Literal
                    spacer.Text = " "

                    ' To support data binding, register the event-handling methods
                    ' to perform the data binding. Each control needs its own event
                    ' handler.
                    AddHandler firstName.DataBinding, AddressOf FirstName_DataBinding
                    AddHandler lastName.DataBinding, AddressOf LastName_DataBinding


                    Dim cx As New CheckBox

                    ' Add the controls to the Controls collection
                    ' of the container.
                    'container.Controls.Add(Precio)
                    container.Controls.Add(spacer)
                    'container.Controls.Add(Cantidad)
                    container.Controls.Add(cx)

                    ' Insert cases to create the content for the other 
                    ' row types, if desired.

                Case Else

                    ' Insert code to handle unexpected values. 

            End Select

        End Sub

        Private Sub FirstName_DataBinding(ByVal sender As Object, ByVal e As EventArgs)

            '' Get the Label control to bind the value. The Label control
            '' is contained in the object that raised the DataBinding 
            '' event (the sender parameter).
            Dim l As Label = CType(sender, Label)

            '' Get the GridViewRow object that contains the Label control. 
            Dim row As GridViewRow = CType(l.NamingContainer, GridViewRow)

            '' Get the field value from the GridViewRow object and 
            '' assign it to the Text property of the Label control.
            l.Text = DataBinder.Eval(row.DataItem, "au_fname").ToString()

        End Sub

        Private Sub LastName_DataBinding(ByVal sender As Object, ByVal e As EventArgs)

            '' Get the Label control to bind the value. The Label control
            '' is contained in the object that raised the DataBinding 
            '' event (the sender parameter).
            Dim l As Label = CType(sender, Label)

            '' Get the GridViewRow object that contains the Label control.
            Dim row As GridViewRow = CType(l.NamingContainer, GridViewRow)

            '' Get the field value from the GridViewRow object and 
            '' assign it to the Text property of the Label control.
            l.Text = DataBinder.Eval(row.DataItem, "au_lname").ToString()

        End Sub

    End Class


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
    'FIRMAS
    '////////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        'y esto? -este btnOK es el del UpdatePanel del coso de Liberar... -Y qué???


        If cmbLibero.SelectedValue > 0 Then
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Empleados", "T", cmbLibero.SelectedValue)
            If ds.Tables(0).Rows.Count > 0 Then
                If txtPass.Text = ds.Tables(0).Rows(0).Item("Password").ToString Then
                    'se lo asigno al combo del abm
                    BuscaIDEnCombo(cmbAprobo, cmbLibero.SelectedValue)
                    'cmbAprobo.Text = ds.Tables(0).Rows(0).Item("Nombre").ToString
                    btnAprobar.Enabled = False
                Else
                    'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "PassWord incorrecta")
                    MsgBoxAjax(Me, "PassWord incorrecta")
                End If
            End If
        End If

    End Sub


    'Protected Sub btnLiberar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLiberar.Click
    'Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)
    'myComparativa.ConfirmadoPorWeb = "SI"
    ''myComparativa.Aprobo = "SI" 'este es cuando lo aprueba el usario pronto
    'End Sub


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



    '////////////////////////////////
    '////////////////////////////////
    'Refrescos de Pagina Principal de ABM

    Sub RecalcularTotalComprobante()
        'Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleComparativa"), Integer)
        Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)
        txtSubtotal.Text = 0
        txtTotal.Text = 0
        Dim temp As Decimal
        Try
            For Each det As ComparativaItem In myComparativa.Detalles
                txtSubtotal.Text = StringToDecimal(txtSubtotal.Text) + det.Cantidad * det.Precio


                temp = (det.Cantidad * det.Precio * ((100) / 100) * ((100 + det.PorcentajeBonificacion) / 100))
                temp = temp + txtTotal.Text 'StringToDecimal(txtTotal.Text)
                Debug.Print(temp)
                txtTotal.Text = temp
            Next
            txtSubtotal.Text = String.Format("{0:F2}", StringToDecimal(txtSubtotal.Text)) ' o uso {0:c} o {0:F2} ?
            txtTotal.Text = DecimalToString(temp) ' o uso {0:c} o {0:F2} ?
            UpdatePanelTotales.Update()
        Catch ex As Exception
            MsgBoxAjax(Me, ex.Message)
        End Try
    End Sub






    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    'Grilla Popup de Consulta
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub ObjGrillaConsulta_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjGrillaConsulta.Selecting
        'En caso de que necesite pasarle parametros
        'e.InputParameters("Parametros") = New String() {"P"}

        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        'If txtBuscar.Text = "buscar" Then 'para que no busque estos datos si no fueron pedidos explicitamente
        If Not IsPostBack Then
            e.Cancel = True
        End If
    End Sub


    Function GenerarWHERE() As String
        ObjGrillaConsulta.FilterExpression = "Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Proveedor, 'System.String') LIKE '*" & txtBuscar.Text & "*'"
    End Function



    Sub RebindGridAuxCopiaPresupuesto()
        With GVGrillaConsulta


            Dim pageIndex = .PageIndex
            ObjGrillaConsulta.FilterExpression = GenerarWHERE()
            Dim b As Data.DataView = ObjGrillaConsulta.Select()
            'b.Sort = "IdDetalleRequerimiento DESC"
            ViewState("Sort") = b.Sort
            .DataSourceID = ""
            .DataSource = b
            .DataBind()
            .PageIndex = pageIndex


        End With
    End Sub



    Protected Sub GVGrillaConsulta_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GVGrillaConsulta.PageIndexChanging
        GVGrillaConsulta.PageIndex = e.NewPageIndex
        RebindGridAuxCopiaPresupuesto()
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset

        RebindGridAuxCopiaPresupuesto()
        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub



    Protected Sub GVGrillaConsulta_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GVGrillaConsulta.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GVGrillaConsulta)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "IdPresupuesto")
            Try
                gp.DataSource = ObjectDataSource2.Select
                gp.DataBind()
            Catch ex As Exception
                'Debug.Print(ex.Message)
                Throw New ApplicationException("Error en la grabacion " + ex.Message, ex)
            Finally
            End Try
            gp.Width = 200
        End If
    End Sub

    Protected Sub RadioButtonPendientes_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonPendientes.CheckedChanged
        ObjGrillaConsulta.SelectParameters.Add("TX", "_Pendientes1")
        'Requerimientos_TX_Pendientes1 'P' 
    End Sub

    Protected Sub RadioButtonAlaFirma_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonAlaFirma.CheckedChanged
        'Requerimientos_TX_PendientesDeFirma
    End Sub

    Protected Sub LinkButton1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click


        'GVGrillaConsulta.DataBind()
        'ModalPopupExtender1.Show()




        'Select Case Index
        '    Case 0
        '        If mTiposComprobante = "F" Then
        '            oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesDeFirma")
        '        ElseIf mOrigen = "Compras" Then
        'oRs = Aplicacion.Requerimientos.TraerFiltrado("_Pendientes1", mTiposComprobante)
        '        Else
        'oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPlaneamiento", mTiposComprobante)
        '        End If
        'Lista.DataSource = oRs
        '    Case 1
        'lblLabels(5).Visible = False
        ''         rchObservaciones.Visible = False
        'oRs = Aplicacion.Requerimientos.TraerFiltrado("_PendientesPorRM1", mTiposComprobante)
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



    Protected Sub btnAceptarPopupGrilla_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAceptarPopupGrilla.Click

        'restauro el objeto a partir del viewstate
        Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)

        Dim chkFirmar As CheckBox
        Dim keys(3) As String

        Dim ms As String = ""
        'Dim fila As GridViewRow = GVGrillaConsulta.SelectedRow

        '///////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////
        'Cargo el renglon (si no me bastan los datos que ya tengo en la grilla)
        '
        'La coleccion Grilla.DataKeys(fila.RowIndex).Values.Item(0) tiene las keys de la grilla. 
        'Para las columnas, usá Grilla.Rows(fila).Cells(col)
        '///////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////
        For Each fila As GridViewRow In GVGrillaConsulta.Rows
            If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                If chkFirmar.Checked Then

                    Dim idPresu As Integer = GVGrillaConsulta.DataKeys(fila.RowIndex).Values.Item("IdPresupuesto")
                    Dim oPresu As Pronto.ERP.BO.Presupuesto = PresupuestoManager.GetItem(SC, idPresu, True)
                    Dim oDetPresu As PresupuestoItem
                    Dim idDetPresu As Integer = GVGrillaConsulta.DataKeys(fila.RowIndex).Values.Item("IdDetalleRequerimiento")
                    'oDetRM = oRM.BuscarRenglonPorIdDetalle(idDetRM)



                    '///////////////////////////////////////////////////////////
                    'lo pongo en la comparativa
                    'migrado de frmComparativa.gvCompara_OLEDragDrop.OLEDragDrop()
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


                    If myComparativa.Detalles Is Nothing OrElse myComparativa.Detalles.Find(Function(obj) obj.IdPresupuesto = idPresu) Is Nothing Then

                        For Each oDetPresu In oPresu.Detalles

                            With oDetPresu
                                Dim mEsta As Boolean = False
                                Dim mCantidad = 0

                                'si ya hay un presupuesto, por ProntoWEB no voy a dejar que ponga uno de otro lote
                                If myComparativa.Detalles.Count > 0 Then
                                    If myComparativa.Detalles(0).NumeroPresupuesto <> oPresu.Numero Then
                                        'Mirá que quizás ya habías agregado alguno
                                        Me.ViewState.Add(mKey, myComparativa)
                                        DeDetalleAGrilla(myComparativa) 'si convierto el detalle a una GUI manualmente
                                        gvCompara.DataBind()
                                        MsgBoxAjax(Me, "ProntoWEB solo permite ingresar presupuestos de un mismo lote/número")
                                        Exit Sub
                                    End If
                                End If

                                '////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////
                                '////////////////////////////////////////////////////////
                                'Se fija si encuentra el mismo IdPresupuesto+ IdArticulo+Precio+OrigenDescripcion+etc... y 
                                'pone la bandera mEsta en TRUE
                                If myComparativa.Detalles IsNot Nothing Then
                                    For Each oDetCompa In myComparativa.Detalles
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
                                    Dim oDetCompa2 As New ComparativaItem
                                    With oDetCompa2
                                        .IdPresupuesto = oPresu.Id
                                        .IdDetallePresupuesto = oDetPresu.Id
                                        .NumeroPresupuesto = oPresu.Numero
                                        .SubNumero = oPresu.SubNumero
                                        .FechaPresupuesto = oPresu.FechaIngreso
                                        .IdMoneda = oPresu.IdMoneda
                                        .IdArticulo = oDetPresu.IdArticulo
                                        .Articulo = oDetPresu.Articulo
                                        .Cantidad = oDetPresu.Cantidad
                                        .Precio = oDetPresu.Precio
                                        .PorcentajeBonificacion = oDetPresu.PorcentajeBonificacion
                                        .IdUnidad = oDetPresu.IdUnidad
                                        .OrigenDescripcion = oDetPresu.OrigenDescripcion
                                        .CotizacionMoneda = IIf(IsNull(oPresu.CotizacionMoneda), 1, oPresu.CotizacionMoneda)

                                        'observaciones
                                        Dim rchObs As String
                                        rchObs = IIf(IsNull(oDetPresu.Observaciones), "", oDetPresu.Observaciones)
                                        Dim mObs As String
                                        mObs = Replace(rchObs, ",", " ")
                                        mObs = Replace(mObs, ";", " ")
                                        mObs = Replace(mObs, Chr(13) + Chr(10) + Chr(13) + Chr(10), " ")
                                        .Observaciones = mObs
                                    End With
                                    If myComparativa.Detalles Is Nothing Then myComparativa.Detalles = New ComparativaItemList
                                    myComparativa.Detalles.Add(oDetCompa2)
                                Else
                                    myComparativa.Detalles.Item(idDetPresu).Cantidad = mCantidad + oDetPresu.Cantidad
                                End If
                            End With
                        Next
                    Else
                        ms += "El renglon de requerimiento " & idDetPresu & " ya está en el detalle" & vbCrLf
                    End If
                End If
            End If
        Next


        Me.ViewState.Add(mKey, myComparativa)
        DeDetalleAGrilla(myComparativa) 'si convierto el detalle a una GUI manualmente
        gvCompara.DataBind()
        'UpdatePanelGrilla.Update()
        mAltaItem = True
        RecalcularTotalComprobante()

        If ms <> "" Then MsgBoxAjax(Me, ms)

    End Sub


    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////
    '////////////////////////////////






    '///////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////

    Protected Sub LinkImprimir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkImprimir.Click

        Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)

        Dim output As String
        output = ImpresionDeComparativa(myComparativa) 'Pronto imprime la planilla de la comparativa usando la Msflexgrid del frmComparativas...
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


    Private Function ImpresionDeComparativa(ByVal myComparativa As Pronto.ERP.BO.Comparativa) As String 'Aunque la comparativa tiene plantilla, no llena los datos sola (de hecho, necesita de la gui de pronto)

        'debug:
        Debug.Print(Session("glbPathPlantillas"))
        'Session("glbPathPlantillas")="\\192.168.66.2\DocumentosPronto\Plantillas"

        Session("glbPathPlantillas") = DirApp() & "\Documentos\"
        'Dim xlt As String = Session("glbPathPlantillas") & "\Comparativa_" & session(SESSIONPRONTO_NombreEmpresa) & ".xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        Dim xlt As String = Session("glbPathPlantillas") & "\Comparativa.xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        Dim output As String = Session("glbPathPlantillas") & "\archivo.xls" 'no funciona bien si uso el raíz


        

        Dim MyFile1 As New FileInfo(xlt)
        Try
            If Not MyFile1.Exists Then
                MsgBoxAjax(Me, "No se encuentra la plantilla " & xlt)
                Return Nothing
            End If

            MyFile1 = New FileInfo(output)
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            MsgBoxAjax(Me, ex.Message)
            Return Nothing
        End Try


        Dim tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa, True)
        Dim tabpie = TraerPie(SC, myComparativa)

        '///////////////////////////////////////////
        '///////////////////////////////////////////



        Dim oEx As Excel.Application
        Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        Dim oBook As Excel.Workbook




        Try
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
            'Acá empieza codigo traido de pronto
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////
            '////////////////////////////////////////////////////////////////////////


            oEx = CreateObject("Excel.Application")




            Dim oAp
            Dim oRsPre As adodb.Recordset
            Dim oRsEmp As adodb.Recordset
            Dim i As Integer, cl As Integer, cl1 As Integer, fl As Integer
            Dim mvarPresu As Long, mvarSubNum As Long
            Dim mvarFecha As Date
            Dim mvarConfecciono As String, mvarAprobo As String, mvarMPrevisto As String, mvarMCompra As String, mvarMoneda As String
            Dim mvarLibero As String
            Dim mvarPrecioIdeal As Double, mvarPrecioReal As Double
            Dim mCabecera

            'oAp = CrearAppCompronto(SC)

            Dim desplaz = 10

            With myComparativa
                mvarPresu = .Numero
                mvarFecha = .Fecha
                If IsNull(.IdConfecciono) Then
                    mvarConfecciono = ""
                Else
                    mvarConfecciono = EmpleadoManager.GetItem(SC, .IdConfecciono).Nombre
                End If
                If iisNull(.IdAprobo, 0) = 0 Then
                    mvarAprobo = ""
                Else
                    mvarAprobo = EmpleadoManager.GetItem(SC, .IdAprobo).Nombre
                End If
                If IsNull(.MontoPrevisto) Then
                    mvarMPrevisto = ""
                Else
                    mvarMPrevisto = Format(.MontoPrevisto, "Fixed")
                End If
                If IsNull(.MontoParaCompra) Then
                    mvarMCompra = ""
                Else
                    mvarMCompra = Format(.MontoParaCompra, "Fixed")
                End If
            End With



            oEx.Visible = False
            oBooks = oEx.Workbooks
            oBook = oBooks.Add(xlt)
            With oBook
                oEx.DisplayAlerts = False



                With .ActiveSheet

                    .Name = "Comparativa"

                    cl1 = 0
                    For cl = 1 To gvCompara.Columns.Count - 1

                        cl1 = cl1 + 1
                        Dim subnumero As Integer = Int((cl1 - 3) / 2)

                        For fl = 0 To tab.Rows.Count - 1 + 7 + 1 '7 son los renglones adicionales del pie




                            If fl = 0 Then
                                '////////////////////////////////////////////
                                '////////////////////////////////////////////
                                'Es la primera fila, le encajo los titulos
                                '////////////////////////////////////////////
                                '////////////////////////////////////////////

                                'Ampliar altura de fila de cabeceras de columna
                                If cl1 > 4 Then
                                    If cl1 Mod 2 = 1 Then
                                        'mCabecera = Split(gvCompara.Rows(fl).Cells(cl).Controls.Text, vbCrLf)
                                        Dim p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = subnumero) 'uso tempi por lo del lambda en el find
                                        If p Is Nothing Then Continue For
                                        .Cells(fl + 7, cl1) = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Proveedor

                                        .Cells(fl + 7, cl1).Font.Bold = True
                                        .Cells(fl + 9, cl1) = "Unitario "
                                        .Cells(fl + 9, cl1 + 1) = "Total "
                                        'mvarMoneda = mCabecera(2)
                                        .Range(oEx.Cells(fl + 7, cl1), oEx.Cells(fl + 7, cl1 + 1)).Select()
                                        With oEx.Selection
                                            .HorizontalAlignment = Excel.Constants.xlCenter
                                            .VerticalAlignment = Excel.Constants.xlCenter
                                            .WrapText = True
                                            .Orientation = 0
                                            .AddIndent = False
                                            .IndentLevel = 0
                                            .ShrinkToFit = False
                                            .MergeCells = True
                                        End With
                                        .Range(oEx.Cells(fl + 8, cl1), oEx.Cells(fl + 8, cl1 + 1)).Select()
                                        With oEx.Selection
                                            .HorizontalAlignment = Excel.Constants.xlCenter
                                            .VerticalAlignment = Excel.Constants.xlCenter
                                            .WrapText = True
                                            .Orientation = 0
                                            .AddIndent = False
                                            .IndentLevel = 0
                                            .ShrinkToFit = False
                                            .MergeCells = True
                                        End With
                                        oEx.ActiveCell.FormulaR1C1 = "Precio"
                                    End If
                                Else
                                    'cosas que voy agregandole al original de edu para adaptarlo
                                    Select Case cl1
                                        Case 1
                                            .Cells(fl + 7, cl1) = "Item"
                                        Case 2
                                            .Cells(fl + 7, cl1) = "Producto"
                                        Case 3
                                            .Cells(fl + 7, cl1) = "Cantidad"
                                        Case 4
                                            .Cells(fl + 7, cl1) = "Unidad"
                                    End Select
                                End If
                            ElseIf fl > 0 And fl < tab.Rows.Count + 1 Then
                                '////////////////////////////////////////////
                                '////////////////////////////////////////////
                                'NO es la primera fila, es un renglon comun 
                                '////////////////////////////////////////////
                                '////////////////////////////////////////////

                                'If gvCompara.row = gvCompara.Rows - 2 Then
                                'rchObservacionesItems.TextRTF = gvCompara.Text
                                '.Cells(fl + 9, cl1) = rchObservacionesItems.Text
                                'Else
                                If cl1 > 4 And cl1 Mod 2 = 1 Then
                                    .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Precio" & subnumero)
                                    .Cells(fl + 9, cl1 + 1) = tab.Rows(fl - 1).Item("Total" & subnumero)
                                Else
                                    Select Case cl1
                                        Case 1
                                            .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Item")
                                        Case 2
                                            .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Producto")
                                        Case 3
                                            .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Cantidad")
                                        Case 4
                                            .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Unidad")
                                    End Select
                                End If
                                '& (iisNull(tab.Rows(fl).Item("Precio" & cl1 - 4), 0) * tab.Rows(fl).Item("Cantidad"))
                                'End If

                            Else
                                '////////////////////////////////////////////
                                '////////////////////////////////////////////
                                'es una fila del pie
                                '////////////////////////////////////////////
                                '////////////////////////////////////////////
                                If cl1 > 4 And cl1 Mod 2 = 1 Then
                                    'valor
                                    Dim p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = subnumero) 'uso tempi por lo del lambda en el find
                                    If p Is Nothing Then Continue For
                                    Debug.Print(tabpie.Rows(fl - tab.Rows.Count - 1).Item(subnumero))
                                    .Cells(fl + desplaz, cl1 + 1) = tabpie.Rows(fl - tab.Rows.Count - 1).Item(subnumero)
                                Else
                                    If cl1 = 4 Then
                                        'titulo
                                        Select Case fl - tab.Rows.Count
                                            Case 0
                                                .Cells(fl + desplaz + 1, cl1) = "Subtotal"
                                            Case 1
                                                .Cells(fl + desplaz + 1, cl1) = "Bonificacion"
                                            Case 2
                                                .Cells(fl + desplaz + 1, cl1) = "TOTAL"
                                            Case 3
                                                .Cells(fl + desplaz + 1, cl1) = "Plazo de entrega"
                                            Case 4
                                                .Cells(fl + desplaz + 1, cl1) = "Condicion de pago"
                                            Case 5
                                                .Cells(fl + desplaz + 1, cl1) = "Observaciones"
                                            Case 6
                                                .Cells(fl + desplaz + 1, cl1) = "Solicitud de cotizacion nro."
                                        End Select
                                    End If
                                End If
                            End If




                            '//////////////////////////////////////////////
                            'Modifica formato de celdas con precios comparados
                            If cl1 > 4 And fl > 0 And fl <= tab.Rows.Count Then 'And IsNumeric(gvCompara.Text) Then
                                If iisNull(tab.Rows(fl - 1).Item("M" & subnumero), False) Then
                                    .Cells(fl + 9, cl1).Font.Bold = True
                                End If

                                'If fl >= gvCompara.Rows - 7 Then
                                .Cells(fl + 9, cl1).NumberFormat = "#,##0.00"
                                'Else
                                '.Cells(fl + 9, cl1).NumberFormat = "#,##0.0000"
                                'End If
                            End If
                            '//////////////////////////////////////////////


                        Next
                    Next



                    '//////////////////////////////////////////////
                    'Informacion en celdas sueltas
                    '//////////////////////////////////////////////
                    .Cells(2, 5) = "COMPARATIVA Nro. : " & mvarPresu
                    .Cells(3, 5) = "FECHA : " & mvarFecha
                    .Cells(4, 5) = "Comprador/a : " & mvarConfecciono
                    '.Cells(5, 2) = "Obra/s : " & txtObras.Text
                    '.Cells(6, 2) = "RM / LA : " & txtNumeroRequerimiento.Text

                    .Cells(gvCompara.Rows.Count + 13, 1).Select()
                    .Rows(gvCompara.Rows.Count + 13).RowHeight = 25
                    .Cells(gvCompara.Rows.Count + 13, 1) = "Obs.Grales. : " & myComparativa.Observaciones

                    .Cells(gvCompara.Rows.Count + 14, 1).Select()
                    .Rows(gvCompara.Rows.Count + 14).RowHeight = 10
                    .Cells(gvCompara.Rows.Count + 14, 1) = "Monto previsto : " & myComparativa.MontoPrevisto

                    .Cells(gvCompara.Rows.Count + 15, 1).Select()
                    .Rows(gvCompara.Rows.Count + 15).RowHeight = 10
                    .Cells(gvCompara.Rows.Count + 15, 1) = "Monto para compra : " & myComparativa.MontoParaCompra
                    '//////////////////////////////////////////////
                    '//////////////////////////////////////////////

                    '//////////////////////////////////////////////
                    '//////////////////////////////////////////////
                    'Formateo (pensé que era el pie, pero no
                    '//////////////////////////////////////////////
                    '//////////////////////////////////////////////
                    'cl1 = 0
                    'For cl = 1 To gvCompara.Columns.Count - 1
                    '    cl1 = cl1 + 1
                    '    If cl1 > 4 And cl1 Mod 2 = 1 Then


                    '        .Range(oEx.Cells(fl + desplaz, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
                    '        With oEx.Selection
                    '            .HorizontalAlignment = Excel.Constants.xlCenter
                    '            .VerticalAlignment = Excel.Constants.xlCenter
                    '            .WrapText = True
                    '            .AddIndent = False
                    '            .MergeCells = True
                    '        End With
                    '        .Range(oEx.Cells(gvCompara.Rows.Count, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
                    '        With oEx.Selection
                    '            .HorizontalAlignment = Excel.Constants.xlCenter
                    '            .VerticalAlignment = Excel.Constants.xlCenter
                    '            .WrapText = True
                    '            .AddIndent = False
                    '            .MergeCells = True
                    '        End With
                    '        .Range(oEx.Cells(fl + desplaz, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
                    '        With oEx.Selection
                    '            .HorizontalAlignment = Excel.Constants.xlLeft
                    '            .VerticalAlignment = Excel.Constants.xlCenter
                    '            .WrapText = True
                    '            .AddIndent = False
                    '            .MergeCells = True
                    '        End With
                    '        .Range(oEx.Cells(fl + desplaz, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
                    '        With oEx.Selection
                    '            .HorizontalAlignment = Excel.Constants.xlCenter
                    '            .VerticalAlignment = Excel.Constants.xlCenter
                    '            .WrapText = True
                    '            .AddIndent = False
                    '            .MergeCells = True
                    '        End With



                    '    End If
                    'Next



                    '//////////////////////////////////////////////
                    '//////////////////////////////////////////////
                    '//////////////////////////////////////////////

                    mvarLibero = ""
                    If iisNull(myComparativa.IdAprobo, 0) <> 0 Then
                        mvarLibero = "" & EmpleadoManager.GetItem(SC, myComparativa.IdAprobo).Nombre
                        If Not IsNull(myComparativa.FechaAprobacion) Then
                            mvarLibero = mvarLibero & "  " & myComparativa.FechaAprobacion
                        End If
                    End If

                    oEx.Rows(gvCompara.Rows.Count + 6).RowHeight = 25
                    oEx.Rows(gvCompara.Rows.Count + 7).RowHeight = 25

                End With





                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////
                'Acá termina codigo traido de pronto
                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////
                '////////////////////////////////////////////////////////////////////////

                'ejecuto la macro
                Dim s As String = "'" & .Name & "'!" & "ArmarFormato"


                Debug.Print("Emision """ & DebugCadenaImprimible(Encriptar(SC)) & """,""" & myComparativa.Id & """,""" & mvarLibero & """,""" & Session("glbPathPlantillas") & """,""" & session(SESSIONPRONTO_NombreEmpresa) & """,""A4""")

                'me funciona acá, pero no puedo hacer que funcione remoto
                'oEx.Run(s, Encriptar(SC), myComparativa.Id, mvarLibero, Session("glbPathPlantillas"), session(SESSIONPRONTO_NombreEmpresa), "A4")



                oEx.Cells(fl + desplaz - 6, 4) = "Subtotal"
                'oEx.Cells(fl + 5, 3) = "Bonificacion"
                'oEx.Cells(fl + 6, 3) = "TOTAL"





                .SaveAs(output, 56) '= xlExcel8 (97-2003 format in Excel 2007-2010, xls) 'no te preocupes, que acá solo llega cuando terminó de ejecutar el script de excel

                oEx.DisplayAlerts = True
            End With

        Catch ex As Exception
            MsgBoxAlert(ex.Message & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla")
            Return Nothing
        Finally
            If Not oBook Is Nothing Then oBook.Close(False)
            NAR(oBook)
            If Not oBooks Is Nothing Then oBooks.Close()
            NAR(oBooks)
            'quit and dispose app
            oEx.Quit()
            NAR(oEx)
            'VERY IMPORTANT
            GC.Collect()
        End Try



        Return output


    End Function


    Protected Sub btnAprobar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAprobar.Click
        Dim mOk As Boolean
        Page.Validate("Encabezado")
        mOk = Page.IsValid

        Dim myComparativa As Pronto.ERP.BO.Comparativa = CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)
        If Not ComparativaManager.IsValid(myComparativa) Then 'hago la validacion manualmente porque no me está andando el CustomValidator que controla la grilla (aunque sí se dispara si aprieto "AgrgarItem", probablemente por el UpdatePanel
            mOk = False
            MsgBoxAjax(Me, "No se puede liberar un comprobante sin items")
        End If
        If mOk Then
            ModalPopupExtender2.Show()
        Else
            'MsgBoxAjax(Me, "El objeto no es válido")
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

End Class
