Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print

Partial Class ComprobanteProveedor
    Inherits System.Web.UI.Page


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////

    'una cuenta la pueden compartir varias obras, pero una obra no tiene varias cuentas de FF.


    Private IdComprobanteProveedor As Integer = -1
    Private mKey As String, SC As String
    Private mAltaItem As Boolean
    Private usuario As Usuario = Nothing

    Public Property IdEntity() As Integer
        Get
            Return DirectCast(ViewState("IdComprobanteProveedor"), Integer)
        End Get
        Set(ByVal Value As Integer)
            ViewState("IdComprobanteProveedor") = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("Id") Is Nothing) Then
            IdComprobanteProveedor = Convert.ToInt32(Request.QueryString.Get("Id"))
            Me.IdEntity = IdComprobanteProveedor
        End If
        mKey = "ComprobanteProveedor_" & Me.IdEntity.ToString
        mAltaItem = False
        usuario = New Usuario
        usuario = session(SESSIONPRONTO_USUARIO)
        SC = usuario.StringConnection

        AutoCompleteExtender1.ContextKey = SC 'por acá le paso al webservice la cadena de conexion

        btnNuevoProveedor.Attributes.Add("onclick", "return ConmutarNuevoProveedor();")
        'PanelDetalle.Attributes.Add("style" "display:none"


        If Not Page.IsPostBack Then

            'Carga del objeto
            TextBox1.Text = IdComprobanteProveedor
            BindTypeDropDown()



            Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor
            If IdComprobanteProveedor > 0 Then

                '////////////////////////////////////////////////////////////////////////////
                '   EDICION
                '////////////////////////////////////////////////////////////////////////////

                myComprobanteProveedor = ComprobanteProveedorManager.GetItem(SC, IdComprobanteProveedor, True)
                If Not (myComprobanteProveedor Is Nothing) Then
                    With myComprobanteProveedor
                        txtReferencia.Text = myComprobanteProveedor.NumeroReferencia
                        txtLetra.Text = myComprobanteProveedor.Letra
                        txtNumeroComprobanteProveedor1.Text = .NumeroComprobante1
                        txtNumeroComprobanteProveedor2.Text = .NumeroComprobante2
                        txtFechaComprobanteProveedor.Text = .FechaComprobante.ToString("dd/MM/yyyy")
                        txtRendicion.Text = .NumeroRendicionFF

                        BuscaTextoEnCombo(cmbTipoComprobante, .IdTipoComprobante.ToString)
                        'If Not (cmbTipoComprobante.Items.FindByValue(.IdTipoComprobante.ToString) Is Nothing) Then
                        ' cmbTipoComprobante.SelectedIndex = -1
                        ' cmbTipoComprobante.Items.FindByValue(.IdTipoComprobante.ToString).Selected = True
                        ' End If

                        SelectedReceiver.Value = myComprobanteProveedor.IdProveedorEventual
                        txtDescArt.Text = myComprobanteProveedor.ProveedorEventual

                        'txtCUIT.Text = .Proveedor.ToString

                        BuscaIDEnCombo(cmbCondicionIVA, .IdCodigoIva)
                        'If Not (cmbCondicionIVA.Items.FindByValue(.IdCodigoIva.ToString) Is Nothing) Then
                        '    cmbCondicionIVA.Items.FindByValue(.IdCodigoIva.ToString).Selected = True
                        'End If

                        BuscaIDEnCombo(cmbCuenta, .IdCuenta)
                        'If Not (cmbCuenta.Items.FindByValue(.IdCuenta.ToString) Is Nothing) Then
                        '    cmbCuenta.SelectedIndex = -1
                        '    cmbCuenta.Items.FindByValue(.IdCuenta.ToString).Selected = True
                        'End If

                        BuscaIDEnCombo(cmbObra, .IdObra)
                        'If Not (cmbObra.Items.FindByValue(.IdObra.ToString) Is Nothing) Then
                        '    cmbObra.SelectedIndex = -1
                        '    cmbObra.Items.FindByValue(.IdObra.ToString).Selected = True
                        'End If

                        txtObservaciones.Text = .Observaciones
                        txtCAI.Text = .NumeroCAI
                        txtFechaVtoCAI.Text = .FechaVencimientoCAI
                        chkConfirmadoDesdeWeb.Checked = IIf(.ConfirmadoPorWeb = "SI", True, False)

                        'txtLibero.Text = myComprobanteProveedor.Aprobo
                        'GridView1.Columns(0).Visible = False
                        GridView1.DataSource = .Detalles
                        GridView1.DataBind()
                        ViewState("PaginaTitulo") = "Edición Fondo Fijo " + myComprobanteProveedor.Letra + myComprobanteProveedor.NumeroComprobante1.ToString + myComprobanteProveedor.NumeroComprobante2.ToString

                        If iisNull(.Confirmado, "NO") = "SI" Then
                            'me fijo si está cerrado
                            DisableControls(Me)
                            btnCancel.Enabled = True
                        End If

                    End With





                Else
                    MsgBoxAjax(Me, "El comprobante con ID " & IdComprobanteProveedor & " no se pudo cargar. Consulte al Administrador")
                End If
            Else

                '////////////////////////////////////////////////////////////////////////////
                '   ALTA
                '////////////////////////////////////////////////////////////////////////////

                myComprobanteProveedor = New Pronto.ERP.BO.ComprobanteProveedor
                With myComprobanteProveedor
                    .Id = -1


                    ''/////////////////////////////////
                    ''/////////////////////////////////
                    'agrego renglones vacios. Ver si vale la pena

                    Dim mItem As ComprobanteProveedorItem = New Pronto.ERP.BO.ComprobanteProveedorItem
                    mItem.Id = -1
                    mItem.Nuevo = True
                    mItem.Importe = Nothing

                    .Detalles.Add(mItem)
                    '.Detalles.Add(mItem)
                    '.Detalles.Add(mItem)
                    GridView1.DataSource = .Detalles 'este bind lo copié
                    GridView1.DataBind()             'este bind lo copié   
                    ''/////////////////////////////////
                    ''/////////////////////////////////

                    If cmbCuenta.SelectedValue <> -1 Then 'esto solo se ejecuta si la cuenta tiene default
                        txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
                    End If

                    'txtReferencia.Text = Pronto.ERP.Dal.GeneralDB.TraerDatos(SC, "wParametros_T").Tables(0).Rows(0).Item("ProximoComprobanteProveedorReferencia").ToString
                    txtReferencia.Text = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC).Item("ProximoComprobanteProveedorReferencia").ToString
                    txtFechaComprobanteProveedor.Text = System.DateTime.Now.ToShortDateString()



                    ViewState("PaginaTitulo") = "Nuevo Fondo Fijo"
                End With
            End If
            MostrarElementos(False)
            Me.ViewState.Add(mKey, myComprobanteProveedor)
            btnOk.OnClientClick = String.Format("fnClickOK('{0}','{1}')", btnOk.UniqueID, "")
        End If






        '////////////////////////////////

        RangeValidator1.MinimumValue = iisValidSqlDate(txtFechaComprobanteProveedor, Today.ToString) 'fecha cai
        txtRendicion.Enabled = False

        'refresco
        btnTraerDatos_Click(Nothing, Nothing)



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

        'cmbLibero.DataSource = Pronto.ERP.Bll.EmpleadoManager.GetListCombo(SC)
        'cmbLibero.DataTextField = "Titulo"
        'cmbLibero.DataValueField = "IdEmpleado"
        'cmbLibero.DataBind()


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbObra.DataSource = ObraManager.GetListCombo(SC)
        If cmbObra.DataSource.Tables(0).Rows.Count = 0 Then
        End If
        cmbObra.DataTextField = "Titulo"
        cmbObra.DataValueField = "IdObra"
        cmbObra.DataBind()
        If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
            cmbObra.SelectedValue = session(SESSIONPRONTO_glbIdObraAsignadaUsuario)
            cmbObra.Enabled = False
        Else
            cmbObra.Items.Insert(0, New ListItem("-- Elija una Obra --", -1))
            cmbObra.SelectedIndex = 0
        End If


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        'cmbCuenta.DataSource = Pronto.ERP.Bll.CuentaManager.GetListCombo(SC)
        'cmbCuenta.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")
        cmbCuenta.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_FondosFijos", DBNull.Value)
        cmbCuenta.DataTextField = "Titulo"
        cmbCuenta.DataValueField = "IdCuenta"
        cmbCuenta.DataBind()
        If IsNumeric(Session("glbIdCuentaFFUsuario")) Then
            cmbCuenta.SelectedValue = Session("glbIdCuentaFFUsuario")
            cmbCuenta.Enabled = False
        Else
            cmbCuenta.Items.Insert(0, New ListItem("-- Elija una Cuenta --", -1))
            cmbCuenta.SelectedIndex = 0
        End If


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbTipoComprobante.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "TiposComprobante", "TX_ParaComboProveedores")
        If cmbTipoComprobante.DataSource.Tables(0).Rows.Count = 0 Then
        End If
        cmbTipoComprobante.DataTextField = "Titulo"
        cmbTipoComprobante.DataValueField = "IdTipoComprobante"
        cmbTipoComprobante.DataBind()


        'elegir automaticamente "Factura de Compra"
        BuscaTextoEnCombo(cmbTipoComprobante, "FC  Factura compra")
        'If Not (cmbTipoComprobante.Items.FindByValue("FC Factura de Compra") Is Nothing) Then
        ' cmbTipoComprobante.SelectedIndex = -1
        ' cmbTipoComprobante.Items.FindByValue("FC Factura de Compra").Selected = True
        ' End If

        'If IsNumeric(Session("glbIdCuentaFFUsuario")) Then
        'If False Then
        '    'cmbTipoComprobante.SelectedValue = 
        '    'cmbTipoComprobante.Enabled = False
        'Else
        '    cmbTipoComprobante.Items.Insert(0, New ListItem("-- Elija un Tipo --", -1))
        '    cmbTipoComprobante.SelectedIndex = 0
        'End If


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbCondicionIVA.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "DescripcionIVA")
        cmbCondicionIVA.DataTextField = "Titulo"
        cmbCondicionIVA.DataValueField = "IdCodigoIVA"
        cmbCondicionIVA.DataBind()
        cmbCondicionIVA.Items.Insert(0, New ListItem("-- Elija una Condición --", -1))

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        cmbDestino.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Obras", "TX_DestinosParaComboPorIdObra", cmbObra.SelectedValue)
        cmbDestino.DataTextField = "Titulo"
        cmbDestino.DataValueField = "IdDetalleObraDestino"
        cmbDestino.DataBind()


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////

        ''cmbCuentaGasto.DataSource = Pronto.ERP.Bll.CuentaManager.GetListCombo(SC)
        If cmbObra.SelectedValue = -1 Then
            cmbCuentaGasto.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "CuentasGastos", "TL")
        Else
            cmbCuentaGasto.DataSource = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_CuentasGastoPorObraParaCombo", cmbObra.SelectedValue, System.DBNull.Value)
        End If
        cmbCuentaGasto.DataTextField = "Titulo"
        cmbCuentaGasto.DataValueField = "IdCuentaGasto"
        cmbCuentaGasto.DataBind()

    End Sub







    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim mOk As Boolean
        Page.Validate()
        mOk = Page.IsValid

        If Not IsDate(txtFechaComprobanteProveedor.Text) Then
            'lblFecha.Visible = True
            mOk = False
        End If

        'cómo puedo saber si tiene renglones, si los datos estan en el ViewState?

        'If myComprobanteProveedor.Detalles Is Nothing Then
        '    MsgBoxAjax(me,"no tiene detalle")
        '    mOk = False
        'End If

        'Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)
        'If myComprobanteProveedor.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
        '    MsgBoxAjax(me,"Está editando pero el comprobante no tiene detalle. Hay algo mal")
        '    Exit Sub
        'End If

        'Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String, mBienesOServicios As String
        'Dim mObservaciones As String, mRazonSocial As String, mIncrementarReferencia As String, mCondicionCompra As String
        'Dim mCodProv As String, mNumeroCAI As String, mFecha1 As String, mError As String, mCodObra As String
        'Dim mInformacionAuxiliar As String, mCuitDefault As String, mCodigoCuentaGasto As String, mTipo As String
        'Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
        'Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer, mIdUnidadPorUnidad As Integer, fl As Integer
        'Dim mContador As Integer, mIdCuentaIvaCompras1 As Integer, mIdCuentaGasto As Integer, i As Integer, mIdUO As Integer
        Dim mvarProvincia As Integer, mIdCodigoIva As Integer
        'Dim mIdTipoComprobante As Integer, mIdCuentaFF As Integer
        Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer, mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer
        Dim mIdProveedor As Long
        'dim mNumeroComprobante1 As Long, mNumeroComprobante2 As Long, mCodigoCuenta As Long
        'Dim mNumeroReferencia As Long, mCodigoCuentaFF As Long, mNumeroOP As Long, mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long
        'Dim mNumeroRendicion As Long, mIdCuenta As Long, mIdCuenta1 As Long, mIdObra As Long, mCodigoCuenta1 As Long
        'Dim mvarCotizacionDolar As Single
        Dim mPorcentajeIVA As Single
        Dim mTotalItem As Double, mIva1 As Double, mTotalBruto As Double
        'Dim mGravado As Double, mNoGravado As Double
        Dim mTotalIva1 As Double, mTotalComprobante As Double, mTotalAjusteIVA As Double
        'Dim mTotalPercepcion As Double
        'Dim mAjusteIVA As Double, mPercepcion As Double
        Dim mBruto As Double

        Dim mIdCuentaIvaCompras(10) As Long
        Dim mIVAComprasPorcentaje(10) As Single



        If mOk Then

            txtLetra.Text = txtLetra.Text.ToUpper
            If cmbCondicionIVA.SelectedValue = 6 Or cmbCondicionIVA.SelectedValue = 7 Then
                'si es monotributo, solo acepto C y M
                If txtLetra.Text <> "C" And txtLetra.Text <> "M" Then
                    MsgBoxAjax(Me, "Los proveedores monotributistas solo pueden tener comprobantes con letra C o M")
                    Exit Sub
                End If
            End If

            '//////////////////////////////////
            '//////////////////////////////////
            'alta al vuelo de proveedor
            'arreglar donde se debe poner este pedazo de codigo y como huir de la funcion llegado el caso
            'If SelectedReceiver.Value = "" Then
            If txtCUIT.Enabled Then
                If txtDescArt.Text <> "" And txtCUIT.Text <> "" And cmbCondicionIVA.SelectedValue <> -1 Then


                    '////////////////////////////////////////////////
                    '/////////         CUIT           ///////////////
                    '////////////////////////////////////////////////
                    If Not mkf_validacuit(txtCUIT.Text) Then
                        MsgBoxAjax(Me, "El CUIT no es valido")
                        Exit Sub
                    End If

                    'verificar que no existe el cuit 'en realidad lo debería verificar el objeto, no?
                    'If (mvarId <= 0 Or BuscarClaveINI("Control estricto del CUIT") = "SI") And _
                    Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Proveedores", "TX_PorCuit", txtCUIT.Text)
                    If ds.Tables(0).Rows.Count > 0 Then
                        For Each dr As Data.DataRow In ds.Tables(0).Rows
                            'If mvarId <> oRs.Fields(0).Value And IsNull(oRs.Fields("Exterior").Value) Then
                            MsgBoxAjax(Me, "El CUIT ya fue asignado al proveedor " & dr!RazonSocial)
                            Exit Sub
                        Next
                    End If
                    '////////////////////////////////////////////////
                    '////////////////////////////////////////////////
                    '////////////////////////////////////////////////




                    Dim myProveedor As New Pronto.ERP.BO.Proveedor
                    With myProveedor
                        .Confirmado = "NO"
                        .RazonSocial = txtDescArt.Text
                        .Cuit = txtCUIT.Text
                        .EnviarEmail = 1
                        .IdCodigoIva = cmbCondicionIVA.SelectedValue



                        If txtLetra.Text = "B" Or txtLetra.Text = "C" Then
                            mIdCodigoIva = 0
                        Else
                            mIdCodigoIva = 1
                        End If


                        'Cómo es esto?
                        '.IdCondicionCompra = 
                    End With
                    ProveedorManager.Save(SC, myProveedor)

                    SelectedReceiver.Value = myProveedor.Id
                Else
                    Exit Sub
                End If
            End If
            '//////////////////////////////////
            '//////////////////////////////////




            If Not mAltaItem Then
                Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

                With myComprobanteProveedor

                    Dim drParam As System.Data.DataRow = ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    .IdMoneda = drParam.Item("ProximoComprobanteProveedorReferencia").ToString 'mIdMonedaPesos
                    .CotizacionMoneda = 1
                    .CotizacionDolar = Cotizacion(SC, Now, drParam.Item("IdMonedaDolar")) 'mvarCotizacionDolar
                    .IdOrdenPago = Nothing
                    .IdUsuarioIngreso = Session(SESSIONPRONTO_glbIdUsuario)
                    .FechaIngreso = Now
                    .NumeroRendicionFF = Convert.ToInt32(txtRendicion.Text)

                    .NumeroReferencia = Convert.ToInt32(txtReferencia.Text)
                    .Letra = txtLetra.Text
                    .NumeroComprobante1 = Convert.ToInt32(txtNumeroComprobanteProveedor1.Text)
                    .NumeroComprobante2 = Convert.ToInt32(txtNumeroComprobanteProveedor2.Text)
                    .FechaComprobante = Convert.ToDateTime(txtFechaComprobanteProveedor.Text)
                    .FechaRecepcion = .FechaComprobante
                    .FechaVencimiento = .FechaComprobante
                    .IdTipoComprobante = cmbTipoComprobante.SelectedValue
                    .IdProveedorEventual = Convert.ToInt32(SelectedReceiver.Value)


                    .ConfirmadoPorWeb = IIf(chkConfirmadoDesdeWeb.Checked, "SI", "NO")
                    .IdProveedor = Nothing
                    .IdCuentaOtros = Nothing

                    'txtCUIT.Text 
                    'cmbCondicionIVA.
                    .IdCuenta = cmbCuenta.SelectedValue
                    .IdObra = cmbObra.SelectedValue
                    myComprobanteProveedor.Observaciones = Convert.ToString(txtObservaciones.Text)
                    .Observaciones = txtObservaciones.Text
                    .NumeroCAI = txtCAI.Text

                    If iisValidSqlDate(txtFechaVtoCAI.Text) Is Nothing Then
                        .FechaVencimientoCAI = Nothing
                    Else
                        .FechaVencimientoCAI = Convert.ToDateTime(txtFechaVtoCAI.Text)
                    End If

                    'myComprobanteProveedor.IdAprobo = Convert.ToInt32(cmbLibero.SelectedValue)
                    'myComprobanteProveedor.LugarEntrega = Convert.ToString(txtLugarEntrega.Text)
                    'myComprobanteProveedor.IdComprador = Convert.ToInt32(cmbComprador.SelectedValue)

                    .IdComprobanteImputado = Nothing






                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'no sé qué hace con el proveedor
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    'Dim gblFechaUltimoCierre As Date
                    'If mFechaRecepcion > gblFechaUltimoCierre Then
                    If True Then
                        mIdProveedor = 0
                        .BienesOServicios = "B"


                        If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
                            .IdIBCondicion = mvarIdIBCondicion
                        Else
                            .IdIBCondicion = Nothing
                        End If


                        If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
                            .IdTipoRetencionGanancia = mvarIdTipoRetencionGanancia
                        Else
                            .IdTipoRetencionGanancia = Nothing
                        End If

                        .IdProvinciaDestino = mvarProvincia

                        .DestinoPago = "O"
                        .InformacionAuxiliar = ""
                        If mIdCodigoIva <> 0 Then .IdCodigoIva = mIdCodigoIva



                        For Each det As ComprobanteProveedorItem In myComprobanteProveedor.Detalles

                            'If det.IdCuentaGasto = 0 Then 'verifico que no pase un renglon en blanco
                            ' det.Eliminado = True
                            ' Else
                            'mPercepcion = det.
                            mBruto = det.Importe
                            mIva1 = det.ImporteIVA1
                            mTotalItem = mBruto + mIva1

                            mTotalBruto = mTotalBruto + mBruto
                            mTotalIva1 = mTotalIva1 + mIva1
                            'mTotalPercepcion = mTotalPercepcion + mPercepcion
                            mTotalComprobante = mTotalComprobante + mTotalItem
                            'mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
                            mPorcentajeIVA = 0
                            'If mIva1 <> 0 And mBruto <> 0 Then mPorcentajeIVA = .Cells(fl, 11)
                            'End If
                        Next


                        '////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////
                        'Estos son de total.... Así que vas a tener que sacar cuentas


                        .Confirmado = "NO"
                        .TotalBruto = mTotalBruto
                        .TotalIva1 = mTotalIva1
                        .TotalIva2 = 0
                        .TotalBonificacion = 0
                        .TotalComprobante = mTotalComprobante
                        .PorcentajeBonificacion = 0
                        .TotalIVANoDiscriminado = 0
                        .AjusteIVA = mTotalAjusteIVA
                        'If mIncrementarReferencia <> "SI" Then .AutoincrementarNumeroReferencia = "NO"
                        .AutoincrementarNumeroReferencia = "SI"

                        '////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////
                        '////////////////////////////////////////////////////

                    End If
                End With



                Dim ms As String
                If ComprobanteProveedorManager.IsValid(SC, myComprobanteProveedor, ms) Then
                    Try
                        ComprobanteProveedorManager.Save(SC, myComprobanteProveedor)
                    Catch ex As Exception
                        MsgBoxAjax(Me, ex.Message)
                    End Try


                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////
                    'Incremento de número en capa de UI. Evitar!
                    'If ParametroManager.GrabarRenglonUnicoDeTablaParametroOriginal(SC, "ProximoComprobanteProveedorReferencia", myComprobanteProveedor.NumeroReferencia + 1) = -1 Then MsgBoxAjax(me,"Hubo un error al modificar los parámetros")
                    '////////////////////////////////////////////////////
                    '////////////////////////////////////////////////////

                    EndEditing()
                Else
                    'MsgBoxAjax(me,"El objeto no es válido")
                    'MessageBox("prueba")
                    MsgBoxAjax(Me, ms)
                    'Response.Write("<script>alert('mensaje');</script>")
                    Exit Sub
                End If




            Else
                mAltaItem = False
                'LblInfo.Visible = False
                PanelInfo.Visible = True
                PanelInfoNum.Visible = True
                'LblInfo.Visible = True
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click
        If Not mAltaItem Then
            EndEditing()
        Else
            mAltaItem = False
        End If
    End Sub

    Private Sub EndEditing()
        Response.Redirect(String.Format("FondoFijos.aspx"))
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
    'Eventos de Grilla : Botones de edicion y eliminar
    '////////////////////////////////////////////////////////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim mIdItem As Integer = Convert.ToInt32(e.CommandArgument)
        Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor
        If e.CommandName.ToLower = "eliminar" Then
            If (Me.ViewState(mKey) IsNot Nothing) Then
                myComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)
                myComprobanteProveedor.Detalles(mIdItem).Eliminado = True
                Me.ViewState.Add(mKey, myComprobanteProveedor)
                GridView1.DataSource = myComprobanteProveedor.Detalles
                GridView1.DataBind()
            End If

        ElseIf e.CommandName.ToLower = "editar" Then
            ViewState("IdDetalleComprobanteProveedor") = mIdItem
            If (Me.ViewState(mKey) IsNot Nothing) Then
                MostrarElementos(True)
                myComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)
                With myComprobanteProveedor
                    'If .Detalles(mIdItem).Id = -1 Then 'no quiere editar uno que no está vacío, así que lo dejo

                    .Detalles(mIdItem).Eliminado = False

                    '////////////////////////////////////////////////////////////////////////////////
                    'HAY QUE ARREGLAR ESTO: me lo tiene que dar directamente el BO.ComprobanteProveedor
                    'txtDescArt = myComprobanteProveedor.Detalles(mIdItem).descripcion
                    Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorId", myComprobanteProveedor.Detalles(mIdItem).IdArticulo)
                    If ds.Tables(0).Rows.Count > 0 Then
                        'txtDescArt.Text = ds.Tables(0).Rows(0).Item("Descripcion").ToString
                    End If
                    '////////////////////////////////////////////////////////////////////////////////
                    BuscaIDEnCombo(cmbCuentaGasto, .Detalles(mIdItem).IdCuentaGasto.ToString)
                    BuscaIDEnCombo(cmbDestino, .Detalles(mIdItem).IdDetalleObraDestino)


                    'If Not (cmbCuentaGasto.Items.FindByValue(myComprobanteProveedor.Detalles(mIdItem).IdCuentaGasto.ToString) Is Nothing) Then
                    ' cmbCuentaGasto.Items.FindByValue(myComprobanteProveedor.Detalles(mIdItem).IdCuentaGasto.ToString).Selected = True
                    'End If

                    txtCodigo.Text = .Detalles(mIdItem).CodigoCuenta
                    'txtCantidad.Text = .Detalles(mIdItem).Importe.ToString(System.Globalization.CultureInfo.InvariantCulture)
                    txtCantidad.Text = DecimalToString(.Detalles(mIdItem).Importe)
                    cmbIVA.Text = DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1)
                    'BuscaTextoEnCombo(cmbIVA, DecimalToString(.Detalles(mIdItem).IVAComprasPorcentaje1))

                    'txtObservacionesItem.Text = myComprobanteProveedor.Detalles(mIdItem).Observaciones.ToString
                    'txtFechaNecesidad.Text = myComprobanteProveedor.Detalles(mIdItem).FechaEntrega.ToString
                    'If myComprobanteProveedor.Detalles(mIdItem).OrigenDescripcion = 1 Then
                    '    RadioButtonList1.Items(0).Selected = True
                    'ElseIf myComprobanteProveedor.Detalles(mIdItem).OrigenDescripcion = 2 Then
                    '    RadioButtonList1.Items(1).Selected = True
                    'ElseIf myComprobanteProveedor.Detalles(mIdItem).OrigenDescripcion = 3 Then
                    '    RadioButtonList1.Items(2).Selected = True
                    'Else
                    '    RadioButtonList1.Items(0).Selected = True
                    'End If
                End With

                ModalPopupExtender3.Show()

            Else
                'y esto? por si es el renglon vacio?

                txtCantidad.Text = 1
                'RadioButtonList1.Items(0).Selected = True
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
    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        '(si el boton no reacciona, probá sacando el CausesValidation)


        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!

        ViewState("IdDetalleComprobanteProveedor") = -1

        Try

            cmbCuentaGasto.SelectedIndex = 1
        Catch ex As Exception
            'probablemente no hay cuentas disponibles
        End Try

        txtCodigo.Text = 0
        txtCantidad.Text = 0
        MostrarElementos(True)


        'Dim eselprimero As Boolean = False
        'If Not eselprimero Then 'creo un nuevo renglon
        '    ViewState("IdDetalleComprobanteProveedor") = -1
        '    cmbCuentaGasto.SelectedIndex = 1
        '    txtCodigo.Text = 0
        '    txtCantidad.Text = 0
        '    MostrarElementos(True)
        'Else 'uso el vacío por default
        '    'GridView1_RowCommand()
        'End If


        'Cuando agrega un renglon, deshabilito algunos combos
        cmbObra.Enabled = False
        cmbCuenta.Enabled = False

        ModalPopupExtender3.Show()

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'ModalPopupExtender3.Show()
    End Sub



    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="Modo"></param>
    ''' <remarks></remarks>
    Private Sub MostrarElementos(ByVal Modo As Boolean)




        Exit Sub 'esta funcion no debe usarse si uso un modalpopup

        PanelDetalle.Visible = Modo
        txtCantidad.Visible = Modo
        'txtFechaNecesidad.Visible = Modo
        'txtObservacionesItem.Visible = Modo
        'txtCodigo.Visible = Modo
        'cmbArticulos.Visible = Modo
        '        RadioButtonList1.Visible = Modo
        lblCantidad.Visible = Modo
        '        lblFechaNecesidad.Visible = Modo
        lblArticulo.Visible = Modo
        'lblObservaciones.Visible = Modo
        btnSaveItem.Visible = Modo
        btnCancelItem.Visible = Modo
        btnSave.Enabled = Not Modo
        btnCancel.Enabled = Not Modo
    End Sub

    Protected Sub btnCancelItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelItem.Click
        MostrarElementos(False)
        mAltaItem = True
    End Sub

    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click
        If (Me.ViewState(mKey) IsNot Nothing) Then
            Dim mIdItem As Integer = DirectCast(ViewState("IdDetalleComprobanteProveedor"), Integer)
            Dim myComprobanteProveedor As Pronto.ERP.BO.ComprobanteProveedor = CType(Me.ViewState(mKey), Pronto.ERP.BO.ComprobanteProveedor)

            'acá tengo que traer el valor id del hidden


            If mIdItem = -1 Then
                Dim mItem As ComprobanteProveedorItem = New Pronto.ERP.BO.ComprobanteProveedorItem

                If myComprobanteProveedor.Detalles Is Nothing Then 'no debiera ser null si es una edicion, pero...
                    MsgBoxAjax(Me, "Está editando pero el comprobante no tiene detalle. Hay algo mal")
                    Exit Sub
                End If

                mItem.Id = myComprobanteProveedor.Detalles.Count
                mItem.Nuevo = True
                mIdItem = mItem.Id
                myComprobanteProveedor.Detalles.Add(mItem)
            End If



            Try
                With myComprobanteProveedor.Detalles(mIdItem)
                    'acá como hago? agrego un control de excepcion? o valido uno por uno? habría que poner un mensaje al costado
                    ' de cada valor, como se hace en toda web

                    'ORIGINAL EDU:
                    '.IdArticulo = Convert.ToInt32(cmbArticulos.SelectedValue)
                    '.Articulo = cmbArticulos.Items(cmbArticulos.SelectedIndex).Text
                    'MODIFICADO CON AUTOCOMPLETE:
                    '.IdArticulo = Convert.ToInt32(SelectedReceiver.Value)
                    '.Articulo = txtDescArt.Text



                    'definir conversion decimal de una vez.........
                    .Importe = Convert.ToDecimal(txtCantidad.Text)
                    'no hay otra manera para no tener que ir aclarando esto todo el tiempo?
                    .Importe = Decimal.Parse(txtCantidad.Text, System.Globalization.CultureInfo.InvariantCulture)
                    .Importe = StringToDecimal(txtCantidad.Text)



                    .IdObra = cmbObra.SelectedValue


                    .IdCuentaGasto = cmbCuentaGasto.SelectedValue
                    .CuentaGastoDescripcion = cmbCuentaGasto.SelectedItem.Text
                    .IdDetalleObraDestino = IIf(cmbDestino.SelectedValue = "", Nothing, cmbDestino.SelectedValue)

                    'no entiendo cómo se asigna la IdCuenta del detalle a partir de la IdCuentaGasto
                    'acá busca la cuentaGasto. Si no la encuentra, en el siguiente sp ya no toma
                    ' en cuenta la obra

                    Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorObraCuentaGasto", .IdObra, .IdCuentaGasto, DBNull.Value)
                    If ds.Tables(0).Rows.Count > 0 Then
                        .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
                        .CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
                    Else

                        ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorCodigo", Mid(cmbCuentaGasto.SelectedItem.Text, InStrRev(cmbCuentaGasto.SelectedItem.Text, " ") + 1), DBNull.Value)
                        If ds.Tables(0).Rows.Count > 0 Then
                            .IdCuenta = ds.Tables(0).Rows(0).Item("IdCuenta").ToString
                            .CodigoCuenta = ds.Tables(0).Rows(0).Item("Codigo").ToString
                        Else
                            MsgBoxAjax(Me, "No se encuentra la cuenta de la obra correspodiente a esta cuenta de gasto")
                            Exit Sub
                        End If
                        '   oRsAux1.Close()
                        '   oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaGasto)
                        '   If oRsAux1.RecordCount > 0 Then
                        '    mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                        '    'OK, acá se trajo el mIdCuenta. y el mIdCuentaGasto? Queda en cero, no?
                        '    '-en el codigo no lo vuelve a asignar....
                        '    mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                        '   End If
                    End If



                    'oAp.RubrosContables.TraerFiltrado("_PorCodigo", mAux1)
                    ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "RubrosContables", "TX_Financieros")
                    If ds.Tables(0).Rows.Count > 0 Then
                        For Each dr As Data.DataRow In ds.Tables(0).Rows
                            If InStr(dr.Item("Rubro").ToString.ToLower, "fijos") > 0 Then
                                .IdRubroContable = dr.Item("IdRubroContable")
                                Exit For
                            End If
                        Next
                    End If



                    .PorcentajeProvinciaDestino1 = 100

                    'oRsAux1 = oAp.CuentasGastos.TraerFiltrado("_PorCodigo2", mCodigoCuentaGasto)
                    'If oRsAux1.RecordCount > 0 Then
                    '    mIdCuentaGasto = oRsAux1.Fields("IdCuentaGasto").Value
                    '    oRsAux1.Close()
                    '    oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))
                    '    If oRsAux1.RecordCount > 0 Then
                    '        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                    '        mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                    '    End If
                    'Else
                    '   oRsAux1.Close()
                    '   oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaGasto)
                    '   If oRsAux1.RecordCount > 0 Then
                    '    mIdCuenta = oRsAux1.Fields("IdCuenta").Value
                    '    'OK, acá se trajo el mIdCuenta. y el mIdCuentaGasto? Queda en cero, no?
                    '    '-en el codigo no lo vuelve a asignar....
                    '    mCodigoCuenta = oRsAux1.Fields("Codigo").Value
                    '   End If
                    'End If

                    Dim mIdCuentaIvaCompras1 As Long
                    'ds = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Parametros", "TX_PorId", 1)
                    Dim drparam As Data.DataRow = Pronto.ERP.Bll.ParametroManager.TraerRenglonUnicoDeTablaParametroOriginal(SC)
                    With drparam
                        mIdCuentaIvaCompras1 = .Item("IdCuentaIvaCompras1")
                    End With




                    If mIdCuentaIvaCompras1 <> 0 Then
                        .IdCuentaIvaCompras1 = mIdCuentaIvaCompras1
                        .IVAComprasPorcentaje1 = StringToDecimal(cmbIVA.SelectedValue)
                        .ImporteIVA1 = Math.Round(cmbIVA.SelectedValue / 100 * .Importe, 2)
                        .AplicarIVA1 = "SI"
                    Else
                        .IdCuentaIvaCompras1 = 0
                        .IVAComprasPorcentaje1 = 0
                        .ImporteIVA1 = 0
                        .AplicarIVA1 = "NO"
                    End If



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
                    .IdCuentaIvaCompras2 = Nothing
                    .IVAComprasPorcentaje2 = 0
                    .ImporteIVA2 = 0
                    .AplicarIVA2 = "NO"
                    .IdCuentaIvaCompras3 = Nothing
                    .IVAComprasPorcentaje3 = 0
                    .ImporteIVA3 = 0
                    .AplicarIVA3 = "NO"
                    .IdCuentaIvaCompras4 = Nothing
                    .IVAComprasPorcentaje4 = 0
                    .ImporteIVA4 = 0
                    .AplicarIVA4 = "NO"
                    .IdCuentaIvaCompras5 = Nothing
                    .IVAComprasPorcentaje5 = 0
                    .ImporteIVA5 = 0
                    .AplicarIVA5 = "NO"
                    .IdCuentaIvaCompras6 = Nothing
                    .IVAComprasPorcentaje6 = 0
                    .ImporteIVA6 = 0
                    .AplicarIVA6 = "NO"
                    .IdCuentaIvaCompras7 = Nothing
                    .IVAComprasPorcentaje7 = 0
                    .ImporteIVA7 = 0
                    .AplicarIVA7 = "NO"
                    .IdCuentaIvaCompras8 = Nothing
                    .IVAComprasPorcentaje8 = 0
                    .ImporteIVA8 = 0
                    .AplicarIVA8 = "NO"
                    .IdCuentaIvaCompras9 = Nothing
                    .IVAComprasPorcentaje9 = 0
                    .ImporteIVA9 = 0
                    .AplicarIVA9 = "NO"
                    .IdCuentaIvaCompras10 = Nothing
                    .IVAComprasPorcentaje10 = 0
                    .ImporteIVA10 = 0
                    .AplicarIVA10 = "NO"



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


            Me.ViewState.Add(mKey, myComprobanteProveedor)
            GridView1.DataSource = myComprobanteProveedor.Detalles
            GridView1.DataBind()

            UpdatePanelGrilla.Update()

        End If
        MostrarElementos(False)
        mAltaItem = True
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////


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
                txtCodigo.Text = ds.Tables(0).Rows(0).Item("Codigo").ToString
            End If
        End If

    End Sub

    Protected Sub txtCodigo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCodigo.TextChanged

        If Len(txtCodigo.Text) > 0 Then
            Dim ds As System.Data.DataSet = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Articulos", "PorCodigo", txtCodigo.Text)
            If ds.Tables(0).Rows.Count > 0 Then
                'cmbArticulos.SelectedValue = ds.Tables(0).Rows(0).Item(0)
            End If
        End If

    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
        'y esto? -este btnOK es el del UpdatePanel... -Y qué???


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


    Protected Sub cmbCuenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCuenta.SelectedIndexChanged
        txtRendicion.Text = iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"), 1)
        TraerObrasAsociadaAlaCuentaFF()
    End Sub


    Sub TraerObrasAsociadaAlaCuentaFF() 'relacion varios-->uno


        'Lleno el combo
        cmbObra.DataSource = EntidadManager.GetListTX(SC, "Obras", "TX_PorIdCuentaFFParaCombo", cmbCuenta.SelectedValue)
        If cmbObra.DataSource.Tables(0).Rows.Count = 0 Then
            cmbObra.DataSource = ObraManager.GetListCombo(SC)

            'ElseIf cmbObra.DataSource.Tables(0).Rows.Count = 1 Then
        End If
        cmbObra.DataTextField = "Titulo"
        cmbObra.DataValueField = "IdObra"
        cmbObra.DataBind()


        'Veo si asigno un valor default
        If IsNumeric(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
            If Not BuscaIDEnCombo(cmbObra, session(SESSIONPRONTO_glbIdObraAsignadaUsuario)) Then
                MsgBoxAjax(Me, "La obra asignada al empleado no se encuentra en la lista de obras disponibles para la cuenta de fondo fijo")
            Else
                Return 'encontró la obra y la asignó. Me las tomo
            End If
        End If



        If cmbObra.DataSource.Tables(0).Rows.Count > 1 Then
            'Agrego línea vacía
            cmbObra.Items.Insert(0, New ListItem("-- Elija una Obra --", -1))
            cmbObra.SelectedIndex = 0
        End If

    End Sub

    Sub TraerCuentaFFAsociadaAObra() 'relacion uno-->varios
    End Sub


    Protected Sub cmbObra_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbObra.SelectedIndexChanged
        If cmbObra.SelectedValue = -1 Then
            cmbCuentaGasto.DataSource = EntidadManager.GetListTX(SC, "CuentasGastos", "TL")
        Else
            cmbCuentaGasto.DataSource = EntidadManager.GetListTX(SC, "Cuentas", "TX_CuentasGastoPorObraParaCombo", cmbObra.SelectedValue, System.DBNull.Value)
        End If
        cmbCuentaGasto.DataTextField = "Titulo"
        cmbCuentaGasto.DataValueField = "IdCuentaGasto"
        cmbCuentaGasto.DataBind()
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////


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



    Protected Sub btnTraerDatos_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTraerDatos.Click, txtDescArt.TextChanged
        If Not TraerDatosProveedor(SelectedReceiver.Value) Then
            cmbCondicionIVA.Enabled = True
            txtCUIT.Enabled = True
            If SelectedReceiver.Value <> "" Then 'acaban de cambiar un proveedor existente por un alta al vuelo
                SelectedReceiver.Value = ""

                cmbCondicionIVA.SelectedValue = -1
                txtCUIT.Text = ""
            End If
        Else
            cmbCondicionIVA.Enabled = False
            txtCUIT.Enabled = False
        End If
    End Sub



    Function TraerDatosProveedor(ByVal IdProveedor As String) As Boolean 'es string porque el hidden con el ID puede ser ""

        If Not IsNumeric(IdProveedor) Then
            IdProveedor = BuscaIdProveedorPreciso(IdProveedor, SC)
        End If



        Try
            Dim myProveedor = ProveedorManager.GetItem(SC, IdProveedor)


            With myProveedor
                txtCUIT.Text = .Cuit
                BuscaIDEnCombo(cmbCondicionIVA, .IdCodigoIva)

                If txtLetra.Text = "" Then
                    If .IdCodigoIva = 0 Then
                        txtLetra.Text = "B"  ' y "C"?
                    ElseIf .IdCodigoIva = 1 Then
                        txtLetra.Text = "A"
                    Else
                        txtLetra.Text = "C"
                    End If
                End If
            End With

            Try
                Dim dsTemp As System.Data.DataSet
                dsTemp = Pronto.ERP.Bll.EntidadManager.GetListTX(SC, "ComprobantesProveedores", "TX_UltimoComprobantePorIdProveedor", SelectedReceiver.Value)
                If dsTemp.Tables(0).Rows.Count > 0 Then
                    With dsTemp.Tables(0).Rows(0)
                        'estos se tocan solo si estan vacios
                        If txtCAI.Text = "" Then txtCAI.Text = iisNull(.Item("NumeroCAI"))
                        If txtFechaVtoCAI.Text = "" Then txtFechaVtoCAI.Text = iisNull(.Item("FechaVencimientoCAI"))
                    End With

                End If

                If myProveedor.Cuit <> "" Then Return True
            Catch ex As Exception
            End Try

        Catch
            Return False 'no lo encontré
        End Try
    End Function



    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)

        'Response.Write(msg);
    End Sub






    Protected Sub txtLetra_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtLetra.TextChanged

    End Sub
End Class



'Código original de importacion

'Public Sub ImportacionComprobantesFondoFijo2()

'    Dim oAp 
'    Dim oCP 'As ComPronto.ComprobanteProveedor 
'    Dim oPr 'As ComPronto.Proveedor 
'    Dim oPar 'As ComPronto.Parametro 
'    Dim oOP 'As ComPronto.OrdenPago 
'    Dim oRsAux1 As adodb.Recordset
'    Dim oRsAux2 As adodb.Recordset
'    Dim oF As Form
'    Dim oEx As Excel.Application

'    Dim mOk As Boolean, mConProblemas As Boolean
'    Dim mArchivo As String, mComprobante As String, mCuit As String, mLetra As String, mBienesOServicios As String
'    Dim mObservaciones As String, mRazonSocial As String, mIncrementarReferencia As String, mCondicionCompra As String
'    Dim mCodProv As String, mNumeroCAI As String, mFecha1 As String, mError As String, mCodObra As String
'    Dim mInformacionAuxiliar As String, mCuitDefault As String, mCodigoCuentaGasto As String, mTipo As String
'    Dim mFechaFactura As Date, mFechaVencimientoCAI As Date, mFechaRecepcion As Date
'    Dim mIdMonedaPesos As Integer, mIdTipoComprobanteFacturaCompra As Integer, mIdUnidadPorUnidad As Integer, fl As Integer
'    Dim mContador As Integer, mIdCuentaIvaCompras1 As Integer, mIdCuentaGasto As Integer, i As Integer, mIdUO As Integer
'    Dim mvarProvincia As Integer, mIdTipoComprobante As Integer, mIdCuentaFF As Integer, mIdCodigoIva As Integer
'    Dim mvarIBCondicion As Integer, mvarIdIBCondicion As Integer, mvarIGCondicion As Integer, mvarIdTipoRetencionGanancia As Integer
'    Dim mIdProveedor As Long, mNumeroComprobante1 As Long, mNumeroComprobante2 As Long, mCodigoCuenta As Long
'    Dim mNumeroReferencia As Long, mCodigoCuentaFF As Long, mNumeroOP As Long, mIdOrdenPago As Long, mAux1 As Long, mAux2 As Long
'    Dim mNumeroRendicion As Long, mIdCuenta As Long, mIdCuenta1 As Long, mIdObra As Long, mCodigoCuenta1 As Long
'    Dim mvarCotizacionDolar As Single, mPorcentajeIVA As Single
'    Dim mTotalItem As Double, mIva1 As Double, mGravado As Double, mNoGravado As Double, mTotalBruto As Double
'    Dim mTotalIva1 As Double, mTotalComprobante As Double, mTotalPercepcion As Double, mTotalAjusteIVA As Double
'    Dim mAjusteIVA As Double, mBruto As Double, mPercepcion As Double
'    Dim mIdCuentaIvaCompras(10) As Long
'    Dim mIVAComprasPorcentaje(10) As Single

'    On Error GoTo Mal



'    If Not mOk Then Exit Sub

'    oAp = Aplicacion

'    mIncrementarReferencia = BuscarClaveINI("IncrementarReferenciaEnImportacionDeComprobantes")
'    mCondicionCompra = BuscarClaveINI("Condicion de compra default para fondos fijos")
'    mFecha1 = BuscarClaveINI("Fecha recepcion igual fecha comprobante en fondo fijo")
'    mCuitDefault = BuscarClaveINI("Cuit por defecto en la importacion de fondos fijos")

'    oRsAux1 = oAp.Parametros.TraerFiltrado("_PorId", 1)
'    mIdMonedaPesos = oRsAux1.Fields("IdMoneda").Value
'    mIdTipoComprobanteFacturaCompra = oRsAux1.Fields("IdTipoComprobanteFacturaCompra").Value
'    mIdUnidadPorUnidad = IIf(IsNull(oRsAux1.Fields("IdUnidadPorUnidad").Value), 0, oRsAux1.Fields("IdUnidadPorUnidad").Value)
'    gblFechaUltimoCierre = IIf(IsNull(oRsAux1.Fields("FechaUltimoCierre").Value), DateSerial(1980, 1, 1), oRsAux1.Fields("FechaUltimoCierre").Value)
'    For i = 1 To 10
'        If Not IsNull(oRsAux1.Fields("IdCuentaIvaCompras" & i).Value) Then
'            mIdCuentaIvaCompras(i) = oRsAux1.Fields("IdCuentaIvaCompras" & i).Value
'            mIVAComprasPorcentaje(i) = oRsAux1.Fields("IVAComprasPorcentaje" & i).Value
'        Else
'            mIdCuentaIvaCompras(i) = 0
'            mIVAComprasPorcentaje(i) = 0
'        End If
'    Next
'    oRsAux1.Close()


'    fl = 7
'    mContador = 0
'    mNumeroRendicion = 0
'    mIdCuentaFF = 0

'    oEx = CreateObject("Excel.Application")

'    With oEx

'        With .Workbooks.Open(mArchivo)
'            With .ActiveSheet
'                Do While True

'                    If mNumeroRendicion = 0 And IsNumeric(.Cells(2, 16)) Then mNumeroRendicion = .Cells(2, 16)
'                    mContador = mContador + 1


'                    mTipo = .Cells(fl, 4)
'                    If Len(.Cells(fl, 5)) > 0 Then
'                        mIdTipoComprobante = .Cells(fl, 5)
'                    Else
'                        mIdTipoComprobante = mIdTipoComprobanteFacturaCompra
'                    End If


'                    If IsDate(.Cells(fl, 19)) Then
'                        mFechaVencimientoCAI = CDate(.Cells(fl, 19))
'                    Else
'                        mFechaVencimientoCAI = 0
'                    End If
'                    If mFecha1 = "SI" Then mFechaRecepcion = mFechaFactura

'                    mIdObra = 0
'                    oRsAux1 = oAp.Obras.TraerFiltrado("_PorNumero", mCodObra)
'                    If oRsAux1.RecordCount > 0 Then
'                        mIdObra = oRsAux1.Fields("IdObra").Value
'                    Else
'                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
'                                 "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Obra " & mCodObra & " inexistente"
'                        fl = fl + 1
'                        GoTo FinLoop
'                    End If
'                    oRsAux1.Close()

'                    If mFechaRecepcion > gblFechaUltimoCierre Then
'                        mIdProveedor = 0
'                        oRsAux1 = oAp.Proveedores.TraerFiltrado("_PorCuit", mCuit)
'                        If oRsAux1.RecordCount > 0 Then
'                            mIdProveedor = oRsAux1.Fields(0).Value
'                            mvarProvincia = IIf(IsNull(oRsAux1.Fields("IdProvincia").Value), 0, oRsAux1.Fields("IdProvincia").Value)
'                            mvarIBCondicion = IIf(IsNull(oRsAux1.Fields("IBCondicion").Value), 0, oRsAux1.Fields("IBCondicion").Value)
'                            mvarIdIBCondicion = IIf(IsNull(oRsAux1.Fields("IdIBCondicionPorDefecto").Value), 0, oRsAux1.Fields("IdIBCondicionPorDefecto").Value)
'                            mvarIGCondicion = IIf(IsNull(oRsAux1.Fields("IGCondicion").Value), 0, oRsAux1.Fields("IGCondicion").Value)
'                            mvarIdTipoRetencionGanancia = IIf(IsNull(oRsAux1.Fields("IdTipoRetencionGanancia").Value), 0, oRsAux1.Fields("IdTipoRetencionGanancia").Value)
'                            mBienesOServicios = IIf(IsNull(oRsAux1.Fields("BienesOServicios").Value), "B", oRsAux1.Fields("BienesOServicios").Value)
'                            mIdCodigoIva = IIf(IsNull(oRsAux1.Fields("IdCodigoIva").Value), 0, oRsAux1.Fields("IdCodigoIva").Value)
'                        Else
'                            If mLetra = "B" Or mLetra = "C" Then
'                                mIdCodigoIva = 0
'                            Else
'                                mIdCodigoIva = 1
'                            End If
'                            oPr = oAp.Proveedores.Item(-1)
'                            With oPr.Registro
'                                .Fields("Confirmado").Value = "NO"
'                                .Fields("RazonSocial").Value = Mid(mRazonSocial, 1, 50)
'                                .Fields("CUIT").Value = mCuit
'                                .Fields("EnviarEmail").Value = 1
'                                If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
'                                If IsNumeric(mCondicionCompra) Then .Fields("IdCondicionCompra").Value = CInt(mCondicionCompra)
'                            End With
'                            oPr.Guardar()
'                            mIdProveedor = oPr.Registro.Fields(0).Value
'                            oPr = Nothing
'                            mvarProvincia = 0
'                            mvarIBCondicion = 0
'                            mvarIdIBCondicion = 0
'                            mvarIGCondicion = 0
'                            mvarIdTipoRetencionGanancia = 0
'                            mBienesOServicios = "B"
'                        End If
'                        oRsAux1.Close()

'                        oRsAux1 = oAp.ComprobantesProveedores.TraerFiltrado("_PorNumeroComprobante", _
'                                       Array(mIdProveedor, mLetra, mNumeroComprobante1, mNumeroComprobante2, -1, mIdTipoComprobante))
'                        If oRsAux1.RecordCount = 0 Then
'                            mvarCotizacionDolar = Cotizacion(mFechaFactura, glbIdMonedaDolar)
'                            If mvarCotizacionDolar = 0 Then mConProblemas = True
'                            oCP = oAp.ComprobantesProveedores.Item(-1)
'                            With oCP
'                                With .Registro

'                                    .Fields("IdTipoComprobante").Value = mIdTipoComprobante
'                                    .Fields("IdObra").Value = mIdObra
'                                    .Fields("FechaComprobante").Value = mFechaFactura
'                                    .Fields("FechaRecepcion").Value = mFechaRecepcion
'                                    .Fields("FechaVencimiento").Value = mFechaFactura
'                                    .Fields("IdMoneda").Value = mIdMonedaPesos
'                                    .Fields("CotizacionMoneda").Value = 1
'                                    .Fields("CotizacionDolar").Value = mvarCotizacionDolar
'                                    .Fields("IdProveedorEventual").Value = mIdProveedor
'                                    .Fields("IdProveedor").Value = Null
'                                    .Fields("IdCuenta").Value = mIdCuentaFF
'                                    .Fields("IdOrdenPago").Value = Null

'                                    .Fields("NumeroRendicionFF").Value = mNumeroRendicion
'                                    If (mvarIBCondicion = 2 Or mvarIBCondicion = 3) And mvarIdIBCondicion <> 0 Then
'                                        .Fields("IdIBCondicion").Value = mvarIdIBCondicion
'                                    Else
'                                        .Fields("IdIBCondicion").Value = Null
'                                    End If
'                                    If (mvarIGCondicion = 2 Or mvarIGCondicion = 3) And mvarIdTipoRetencionGanancia <> 0 Then
'                                        .Fields("IdTipoRetencionGanancia").Value = mvarIdTipoRetencionGanancia
'                                    Else
'                                        .Fields("IdTipoRetencionGanancia").Value = Null
'                                    End If
'                                    .Fields("IdProvinciaDestino").Value = mvarProvincia
'                                    .Fields("BienesOServicios").Value = Null
'                                    .Fields("NumeroCAI").Value = mNumeroCAI
'                                    If mFechaVencimientoCAI <> 0 Then
'                                        .Fields("FechaVencimientoCAI").Value = mFechaVencimientoCAI
'                                    Else
'                                        .Fields("FechaVencimientoCAI").Value = Null
'                                    End If
'                                    .Fields("DestinoPago").Value = "O"
'                                    .Fields("InformacionAuxiliar").Value = mInformacionAuxiliar
'                                    If mIdCodigoIva <> 0 Then .Fields("IdCodigoIva").Value = mIdCodigoIva
'                                End With
'                            End With




'                            mTotalBruto = 0
'                            mTotalIva1 = 0
'                            mTotalPercepcion = 0
'                            mTotalComprobante = 0
'                            mTotalAjusteIVA = 0
'                            mAjusteIVA = 0

'                            Do While Len(Trim(.Cells(fl, 2))) > 0 And mLetra = Trim(.Cells(fl, 6)) And _
'                                  mNumeroComprobante1 = .Cells(fl, 7) And mNumeroComprobante2 = .Cells(fl, 8) And _
'                                  (mCuit = .Cells(fl, 10) Or mCuit = mCuitDefault)
'                                mCodigoCuentaGasto = .Cells(fl, 22)
'                                mIdCuentaGasto = 0
'                                mIdCuenta = 0
'                                mCodigoCuenta = 0
'                                oRsAux1 = oAp.CuentasGastos.TraerFiltrado("_PorCodigo2", mCodigoCuentaGasto)
'                                If oRsAux1.RecordCount > 0 Then
'                                    mIdCuentaGasto = oRsAux1.Fields("IdCuentaGasto").Value
'                                    oRsAux1.Close()
'                                    oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorObraCuentaGasto", Array(mIdObra, mIdCuentaGasto))
'                                    If oRsAux1.RecordCount > 0 Then
'                                        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
'                                        mCodigoCuenta = oRsAux1.Fields("Codigo").Value
'                                    Else
'                                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
'                                           "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuenta de gasto codigo :" & mCodigoCuentaGasto & " inexistente"
'                                        fl = fl + 1
'                                        GoTo FinLoop
'                                    End If
'                                Else
'                                    oRsAux1.Close()
'                                    oRsAux1 = oAp.Cuentas.TraerFiltrado("_PorCodigo", mCodigoCuentaGasto)
'                                    If oRsAux1.RecordCount > 0 Then
'                                        mIdCuenta = oRsAux1.Fields("IdCuenta").Value
'                                        mCodigoCuenta = oRsAux1.Fields("Codigo").Value
'                                    Else
'                                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
'                                           "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Cuenta contable inexistente"
'                                        fl = fl + 1
'                                        GoTo FinLoop
'                                    End If
'                                End If
'                                oRsAux1.Close()

'                                mBruto = Abs(CDbl(.Cells(fl, 13)))
'                                mIva1 = Round(Abs(CDbl(.Cells(fl, 14))), 4)
'                                mPercepcion = Abs(CDbl(.Cells(fl, 15)))
'                                mTotalItem = Round(Abs(CDbl(.Cells(fl, 16))), 2)
'                                mObservaciones = "Rendicion : " & mNumeroRendicion & vbCrLf & .Cells(fl, 20) & vbCrLf

'                                mTotalBruto = mTotalBruto + mBruto
'                                mTotalIva1 = mTotalIva1 + mIva1
'                                mTotalPercepcion = mTotalPercepcion + mPercepcion
'                                mTotalComprobante = mTotalComprobante + mTotalItem
'                                mTotalAjusteIVA = mTotalAjusteIVA + mAjusteIVA
'                                mPorcentajeIVA = 0
'                                If mIva1 <> 0 And mBruto <> 0 Then mPorcentajeIVA = .Cells(fl, 11)

'                                mIdCuentaIvaCompras1 = 0
'                                If mPorcentajeIVA <> 0 Then
'                                    For i = 1 To 10
'                                        If mIVAComprasPorcentaje(i) = mPorcentajeIVA Then
'                                            mIdCuentaIvaCompras1 = mIdCuentaIvaCompras(i)
'                                            Exit For
'                                        End If
'                                    Next
'                                End If
'                                If mIva1 <> 0 And mIdCuentaIvaCompras1 = 0 Then
'                                    mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
'                                    "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - No se encontro el porcentaje de iva " & mPorcentajeIVA
'                                    fl = fl + 1
'                                    GoTo FinLoop
'                                End If

'                                With oCP.DetComprobantesProveedores.Item(-1)
'                                    With .Registro
'                                        .Fields("IdObra").Value = mIdObra
'                                        .Fields("IdCuentaGasto").Value = mIdCuentaGasto
'                                        .Fields("IdCuenta").Value = mIdCuenta
'                                        .Fields("CodigoCuenta").Value = mCodigoCuenta
'                                        .Fields("Importe").Value = mBruto
'                                        If mIdCuentaIvaCompras1 <> 0 Then
'                                            .Fields("IdCuentaIvaCompras1").Value = mIdCuentaIvaCompras1
'                                            .Fields("IVAComprasPorcentaje1").Value = mPorcentajeIVA
'                                            .Fields("ImporteIVA1").Value = Round(mIva1, 2)
'                                            .Fields("AplicarIVA1").Value = "SI"
'                                        Else
'                                            .Fields("IdCuentaIvaCompras1").Value = Null
'                                            .Fields("IVAComprasPorcentaje1").Value = 0
'                                            .Fields("ImporteIVA1").Value = 0
'                                            .Fields("AplicarIVA1").Value = "NO"
'                                        End If
'                                        .Fields("IdCuentaIvaCompras2").Value = Null
'                                        .Fields("IVAComprasPorcentaje2").Value = 0
'                                        .Fields("ImporteIVA2").Value = 0
'                                        .Fields("AplicarIVA2").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras3").Value = Null
'                                        .Fields("IVAComprasPorcentaje3").Value = 0
'                                        .Fields("ImporteIVA3").Value = 0
'                                        .Fields("AplicarIVA3").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras4").Value = Null
'                                        .Fields("IVAComprasPorcentaje4").Value = 0
'                                        .Fields("ImporteIVA4").Value = 0
'                                        .Fields("AplicarIVA4").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras5").Value = Null
'                                        .Fields("IVAComprasPorcentaje5").Value = 0
'                                        .Fields("ImporteIVA5").Value = 0
'                                        .Fields("AplicarIVA5").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras6").Value = Null
'                                        .Fields("IVAComprasPorcentaje6").Value = 0
'                                        .Fields("ImporteIVA6").Value = 0
'                                        .Fields("AplicarIVA6").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras7").Value = Null
'                                        .Fields("IVAComprasPorcentaje7").Value = 0
'                                        .Fields("ImporteIVA7").Value = 0
'                                        .Fields("AplicarIVA7").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras8").Value = Null
'                                        .Fields("IVAComprasPorcentaje8").Value = 0
'                                        .Fields("ImporteIVA8").Value = 0
'                                        .Fields("AplicarIVA8").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras9").Value = Null
'                                        .Fields("IVAComprasPorcentaje9").Value = 0
'                                        .Fields("ImporteIVA9").Value = 0
'                                        .Fields("AplicarIVA9").Value = "NO"
'                                        .Fields("IdCuentaIvaCompras10").Value = Null
'                                        .Fields("IVAComprasPorcentaje10").Value = 0
'                                        .Fields("ImporteIVA10").Value = 0
'                                        .Fields("AplicarIVA10").Value = "NO"
'                                        'If mAux2 <> 0 Then .Fields("IdRubroContable").Value = mAux2
'                                    End With
'                                    .Modificado = True
'                                End With

'                                fl = fl + 1
'                            Loop

'                            With oCP
'                                With .Registro
'                                    .Fields("NumeroReferencia").Value = mNumeroReferencia
'                                    .Fields("Confirmado").Value = "NO"
'                                    .Fields("TotalBruto").Value = mTotalBruto
'                                    .Fields("TotalIva1").Value = mTotalIva1
'                                    .Fields("TotalIva2").Value = 0
'                                    .Fields("TotalBonificacion").Value = 0
'                                    .Fields("TotalComprobante").Value = mTotalComprobante
'                                    .Fields("PorcentajeBonificacion").Value = 0
'                                    .Fields("TotalIVANoDiscriminado").Value = 0
'                                    .Fields("AjusteIVA").Value = mTotalAjusteIVA
'                                    .Fields("Observaciones").Value = mObservaciones
'                                    If mIncrementarReferencia <> "SI" Then .Fields("AutoincrementarNumeroReferencia").Value = "NO"
'                                End With
'                                .Guardar()
'                            End With
'                            oCP = Nothing

'                            mNumeroReferencia = mNumeroReferencia + 1
'                        Else
'                            fl = fl + 1
'                        End If
'                    Else
'                        mError = mError & vbCrLf & mTipo & " " & mLetra & "-" & Format(mNumeroComprobante1, "0000") & _
'                                 "-" & Format(mNumeroComprobante2, "00000000") & ", fila " & fl & "  - Fecha es anterior al ultimo cierre contable : " & mComprobante
'                        fl = fl + 1
'                    End If
'                    Else
'                    Exit Do
'                    End If
'                Loop
'            End With
'            .Close(False)
'        End With
'        .Quit()
'    End With

'    If Len(mError) > 0 Then
'        MsgBoxAjax(me,"Los siguientes comprobantes no se importaron :" & vbCrLf & mError, vbExclamation)
'    End If

'End Sub

