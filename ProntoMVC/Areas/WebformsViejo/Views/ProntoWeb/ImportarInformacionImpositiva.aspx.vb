Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports Pronto.ERP.Bll.ParametroManager
Imports System.IO

Partial Class ImportacionInformacionImpositiva
    Inherits System.Web.UI.Page




    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))

        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////

            'TraerCuentaFFasociadaALaObra()

            'Debug.Print(Session("glbWebIdProveedor"))
            'If Not IsNumeric(Session("glbWebIdProveedor")) Then
            '    ResumenVisible(False)
            'Else
            '    'TraerResumenDeCuentaFF()
            '    Debug.Print(Session("glbWebIdProveedor"))
            '    BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor"))
            'End If

            Me.Title = "Importacion Impositiva"



            ''si estás buscando el filtro, andá a PresupuestoManager.GetList
            'If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
            '    HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            'Else
            '    HFTipoFiltro.Value = ""
            'End If

            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 



            'GridView1.DataSource = EntidadManager.GetStoreProcedure(GetConnectionString(Server, Session), "CartasDePorte_T", -1)
            'GridView1.DataBind()

        End If


        If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            LinkAgregarRenglon.Enabled = False
        Else
            LinkAgregarRenglon.Enabled = True
        End If
    End Sub

    Function GenerarWHERE() As String
        Dim s As String

        '//////////
        'debug
        '//////////
        'Return "ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb ISNothing "
        'Return "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT ISNothing )  AND  (Aprobo ISNothing OR Aprobo=0) "
        's = "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT ISNothing )  AND  (Aprobo ISNothing OR Aprobo=0) "
        'Return s
        '//////////
        '//////////


        'Para filtrar por dataset (en lugar de usar el manager con una lista de comprobantes)

        s = "1=1 "

        s += " AND " & _
                                           "(  Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'   )" '_


        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


        Select Case HFTipoFiltro.Value.ToString  '
            Case "", "AConfirmarEnObra"
                s += " AND (IdAprobo ISNothing OR IdAprobo=0 OR IdAprobo=-1)"
                's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb ISNothing)"

            Case "AConfirmarEnCentral"
                s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT ISNothing)  AND  (Aprobo ISNothing OR Aprobo=0) ) "

            Case "Confirmados"
                s += " AND (IdAprobo NOT ISNothing AND IdAprobo>0)"
                's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT ISNothing)"
        End Select


        Return s
    End Function

    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////

    'Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
    '    Select Case e.CommandName.ToLower
    '        Case "edit"
    '            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
    '            Dim IdPresupuesto As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
    '            Response.Redirect(String.Format("Comparativa.aspx?Id={0}", IdPresupuesto.ToString))
    '    End Select
    'End Sub

    'Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
    '    ''crea la grilla anidada con el detalle
    '    'If e.Row.RowType = DataControlRowType.DataRow Then
    '    '    Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

    '    '    'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
    '    '    ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
    '    '    Try
    '    '        gp.DataSource = ObjectDataSource2.Select
    '    '        gp.DataBind()
    '    '        If gp.Columns.Count > 0 Then gp.Columns(0).Visible = False 'oculto la columna del Id -no funciona
    '    '    Catch ex As Exception
    '    '        Debug.Print(ex.Message)
    '    '        Throw New ApplicationException("Error en la grabacion " + ex.Message, ex)
    '    '    Finally
    '    '    End Try
    '    '    gp.Width = 200

    '    'End If
    'End Sub

    'Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
    '    'Dim records(e.NewValues.Count - 1) As DictionaryEntry
    '    'e.NewValues.CopyTo(records, 0)

    '    'Dim entry As DictionaryEntry
    '    'For Each entry In records
    '    '    e.NewValues(entry.Key) = CType(Server.HtmlEncode(entry.Value.ToString()), DateTime)
    '    'Next


    'End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'Combos
    '////////////////////////////////////////////////////////////////////////////////////

    Private Sub BindTypeDropDown()
        'cmbCuenta.DataSource = Pronto.ERP.Bll.CuentaManager.GetListCombo(SC)
        'cmbCuenta.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")

        'sieltipo tiene una obra asignada, qué hago acá?
        'TraerCuentaFFasociadaALaObra()




    End Sub







    '///////////////////////////////////
    '///////////////////////////////////
    'botones y links
    '///////////////////////////////////



    'Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
    '    Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    'End Sub


    'Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
    '    GridViewExportUtil.Export("Grilla.xls", GridView1)
    'End Sub

    '///////////////////////////////////
    '///////////////////////////////////
    'toggles
    '///////////////////////////////////

    Sub ResumenVisible(ByVal estado As Boolean)
        'txtPendientesReintegrar.Visible = estado
        'txtReposicionSolicitada.Visible = estado
        'txtSaldo.Visible = estado
        'txtTotalAsignados.Visible = estado
    End Sub



    'Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
    '    'http://forums.asp.net/t/1284166.aspx
    '    'esto solo se puede usar si el ODS usa un dataset
    '    ObjectDataSource1.FilterExpression = GenerarWHERE()
    '    '& " OR " & _
    '    '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"


    '    'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    'End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click
        'qué diferencia hay entre ImprimirConExcel y ExportarAExcel? 
        'ImprimirConExcel()
        'ExportarAExcel()
    End Sub


    ' IMPORTADOR DESARROLLADO PARA WILLIAMS, SE EJECUTA POR UNICA VEZ
    Public Sub ImportacionComprobantesVenta1()

        '        Dim oAp 
        '        Dim oEx As Excel.Application
        '        Dim oFac 'As ComPronto.Factura 
        '        Dim oDeb 'As ComPronto.NotaDebito 
        '        Dim oCre 'As ComPronto.NotaCredito 
        '        Dim oCli 'As ComPronto.Cliente 
        '        Dim oVen 'As ComPronto.Vendedor 
        '        Dim oRs As adodb.Recordset
        '        Dim oRsAux As adodb.Recordset
        '        Dim oRsErrores As adodb.Recordset
        '           Dim oF As Form
        '        Dim mArchivo As String, mTipo As String, mLetra As String, mCliente As String, mCorredor As String, mCuit As String
        '        Dim mCuitCorredor As String, mCAI As String, mComprobante As String
        '        Dim fl As Integer, mContador As Integer, mIdMonedaPesos As Integer, mPuntoVenta As Integer, mIdPuntoVenta As Integer
        '        Dim mIdTipoComprobante As Integer, mIdCodigoIva As Integer
        '        Dim mIdArticuloParaImportacionFacturas As Long, mNumero As Long, mIdCliente As Long, mIdVendedor As Long
        '        Dim mIdConceptoParaImportacionNDNC As Long, mNumeroCliente As Long, mIdCuenta As Long
        '        Dim mSubtotal As Double, mIVA As Double, mTotal As Double
        '        Dim mTasa As Single, mCotizacionDolar As Single
        '        Dim mFecha As Date, mFechaCAI As Date
        '        Dim mOk As Boolean, mConProblemas As Boolean
        '        Dim mAux1

        '        '   On Error GoTo Mal

        '        '   Set oF = New frmPathPresto
        '        '   With oF
        '        '    .Id = 16
        '        '    .Show(vbModal)
        '        '    mOk = .Ok
        '        '    If mOk Then
        '        '        mArchivo = .FileBrowser1(0).Text
        '        '    End If
        '        'End With
        '        '   Unload oF
        '        '   Set oF = Nothing

        '        If Not mOk Then Exit Sub

        '        oAp = CrearAppCompronto(HFSC.Value)

        '        oRsErrores = CreateObject("adodb.Recordset")
        '        With oRsErrores
        '            .Fields.Append("Id", adInteger)
        '            .Fields.Append("Detalle", adVarChar, 200)
        '        End With
        '        oRsErrores.Open()

        '        oRs = oAp.Parametros.TraerFiltrado("_PorId", 1)
        '        mIdMonedaPesos = IIf(IsNull.DBNull(oRs.Fields("IdMoneda").Value), 1, oRs.Fields("IdMoneda").Value)
        '        mIdCuenta = IIf(IsNull.DBNull(oRs.Fields("IdCuentaDeudoresVarios").Value), 0, oRs.Fields("IdCuentaDeudoresVarios").Value)
        '        oRs.Close()

        '        If mIdCuenta = 0 Then
        '            MsgBox("No definio en parametros la cuenta contable deudores varios", vbExclamation)
        '            Exit Sub
        '        End If



        '        mAux1 = TraerValorParametro2(HFSC.Value, "IdArticuloParaImportacionFacturas")
        '        mIdArticuloParaImportacionFacturas = IIf(IsNull.DBNull(mAux1), 0, mAux1)
        '        mAux1 = TraerValorParametro2(HFSC.Value, "IdConceptoParaImportacionNDNC")
        '        mIdConceptoParaImportacionNDNC = IIf(IsNull.DBNull(mAux1), 0, mAux1)

        '        If mIdArticuloParaImportacionFacturas = 0 Then
        '            MsgBox("No definio en parametros el articulo generico para importar las facturas", vbExclamation)
        '            Exit Sub
        '        End If

        '           Set oF = New frmAviso
        '           With oF
        '            .Label1 = "Abriendo planilla Excel ..."
        '            .Show()
        '            .Refresh()
        '            DoEvents()
        '        End With

        '           oF.Label1 = oF.Label1 & vbCrLf & "Procesando comprobantes ..."
        '           oF.Label2 = ""
        '           oF.Label3 = ""
        '        DoEvents()

        '        fl = 8

        '        oEx = CreateObject("Excel.Application")
        '        With oEx
        '            .Visible = True
        '            .WindowState = xlMinimized
        '            Me.Refresh()

        '            With .Workbooks.Open(mArchivo)
        '                .Sheets("Hoja1").Select()
        '                With .ActiveSheet
        '                    Do While True
        '                        If Len(Trim(.Cells(fl, 1))) = 0 Then Exit Do
        '                        If Len(Trim(.Cells(fl, 6))) = 0 Then GoTo Continuar

        '                        mConProblemas = False

        '                        mTipo = .Cells(fl, 5)
        '                        If mTipo = "TO" Then GoTo Continuar
        '                        If mTipo = "SC" Then
        '                            mLetra = "A"
        '                        Else
        '                            mLetra = Mid(.Cells(fl, 6), 4, 1)
        '                        End If
        '                        mPuntoVenta = CInt(Mid(.Cells(fl, 6), 6, 4))
        '                        mNumero = CLng(Mid(.Cells(fl, 6), 11, 8))
        '                        If IsDate(.Cells(fl, 3)) Then
        '                            mFecha = CDate(.Cells(fl, 3))
        '                        Else
        '                          mFecha = Date
        '                        End If
        '                        mCliente = .Cells(fl, 1)
        '                        mCorredor = .Cells(fl, 10)
        '                        mSubtotal = Abs(CDbl(.Cells(fl, 7)))
        '                        mTasa = 0
        '                        mIVA = 0
        '                        mTotal = mSubtotal
        '                        mCuit = ""
        '                        mCuitCorredor = ""

        '                        mComprobante = .Cells(fl, 6)

        '                        mContador = mContador + 1
        '                       oF.Label2 = "" & mComprobante
        '                       oF.Label3 = "" & mContador
        '                        DoEvents()

        '                        mIdTipoComprobante = 0
        '                        If mTipo = "FC" Or mTipo = "FZ" Then mIdTipoComprobante = 1
        '                        If mTipo = "ND" Then mIdTipoComprobante = 3
        '                        If mTipo = "NC" Or mTipo = "NZ" Or mTipo = "SC" Then mIdTipoComprobante = 4
        '                        If mIdTipoComprobante = 0 Then
        '                            AgregarMensajeProcesoPresto(oRsErrores, "El tipo de comprobante " & mTipo & _
        '                                  " no existe, el comprobante " & mComprobante & " no fue importado.")
        '                            mConProblemas = True
        '                        End If

        '                        mIdVendedor = 0
        '                        oRsAux = oAp.Vendedores.TraerFiltrado("_PorNombre", mCorredor)
        '                        If oRsAux.RecordCount > 0 Then
        '                            mIdVendedor = oRsAux.Fields(0).Value
        '                        Else
        '                            'AgregarMensajeProcesoPresto oRsErrores, "El vendedor " & mCorredor & _
        '                            '      " no existe, el comprobante " & mComprobante & " no fue importado."
        '                            'mConProblemas = True
        '                        End If
        '                        oRsAux.Close()

        '                        mIdCliente = 0
        '                        mIdCodigoIva = 0
        '                        oRsAux = oAp.Clientes.TraerFiltrado("_PorRazonSocial", mCliente)
        '                        If oRsAux.RecordCount > 0 Then
        '                            mIdCliente = oRsAux.Fields(0).Value
        '                            mIdCodigoIva = oRsAux.Fields("IdCodigoIva").Value
        '                        Else
        '                            AgregarMensajeProcesoPresto(oRsErrores, "El cliente " & mCliente & " con cuit " & mCuit & _
        '                                  " no existe en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                            mConProblemas = True
        '                        End If
        '                        oRsAux.Close()

        '                        mIdPuntoVenta = 0
        '                        mCAI = ""
        '                        mFechaCAI = 0
        '                        oRsAux = oAp.PuntosVenta.TraerFiltrado("_Duplicados", New Object() {mLetra, mIdTipoComprobante, mPuntoVenta, -1))
        '                        If oRsAux.RecordCount > 0 Then
        '                            mIdPuntoVenta = oRsAux.Fields(0).Value
        '                            Select Case mLetra
        '                                Case "A"
        '                                    If mIdTipoComprobante = 1 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_F_A").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_F_A").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_F_A").Value) Then mCAI = oRsAux.Fields("NumeroCAI_F_A").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_F_A").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_F_A").Value), Today, oRsAux.Fields("FechaCAI_F_A").Value)
        '                                        End If
        '                                    ElseIf mIdTipoComprobante = 3 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_D_A").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_D_A").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_D_A").Value) Then mCAI = oRsAux.Fields("NumeroCAI_D_A").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_D_A").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_D_A").Value), Today, oRsAux.Fields("FechaCAI_D_A").Value)
        '                                        End If
        '                                    ElseIf mIdTipoComprobante = 4 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_C_A").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_C_A").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_C_A").Value) Then mCAI = oRsAux.Fields("NumeroCAI_C_A").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_C_A").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_C_A").Value), Today, oRsAux.Fields("FechaCAI_C_A").Value)
        '                                        End If
        '                                    End If
        '                                Case "B"
        '                                    If mIdTipoComprobante = 1 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_F_B").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_F_B").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_F_B").Value) Then mCAI = oRsAux.Fields("NumeroCAI_F_B").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_F_B").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_F_B").Value), Today, oRsAux.Fields("FechaCAI_F_B").Value)
        '                                        End If
        '                                    ElseIf mIdTipoComprobante = 3 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_D_B").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_D_B").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_D_B").Value) Then mCAI = oRsAux.Fields("NumeroCAI_D_B").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_D_B").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_D_B").Value), Today, oRsAux.Fields("FechaCAI_D_B").Value)
        '                                        End If
        '                                    ElseIf mIdTipoComprobante = 4 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_C_B").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_C_B").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_C_B").Value) Then mCAI = oRsAux.Fields("NumeroCAI_C_B").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_C_B").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_C_B").Value), Today, oRsAux.Fields("FechaCAI_C_B").Value)
        '                                        End If
        '                                    End If
        '                                Case "E"
        '                                    If mIdTipoComprobante = 1 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_F_E").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_F_E").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_F_E").Value) Then mCAI = oRsAux.Fields("NumeroCAI_F_E").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_F_E").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_F_E").Value), Today, oRsAux.Fields("FechaCAI_F_E").Value)
        '                                        End If
        '                                    ElseIf mIdTipoComprobante = 3 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_D_E").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_D_E").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_D_E").Value) Then mCAI = oRsAux.Fields("NumeroCAI_D_E").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_D_E").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_D_E").Value), Today, oRsAux.Fields("FechaCAI_D_E").Value)
        '                                        End If
        '                                    ElseIf mIdTipoComprobante = 4 Then
        '                                        If IsNull.DBNull(oRsAux.Fields("NumeroCAI_C_E").Value) Or Len(Trim(oRsAux.Fields("NumeroCAI_C_E").Value)) = 0 Then
        '                                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                                  " no tiene CAI en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                                            mConProblemas = True
        '                                        Else
        '                                            If IsNumeric(oRsAux.Fields("NumeroCAI_C_E").Value) Then mCAI = oRsAux.Fields("NumeroCAI_C_E").Value
        '                                            If IsDate(oRsAux.Fields("FechaCAI_C_E").Value) Then mFechaCAI = IIf(IsNull.DBNull(oRsAux.Fields("FechaCAI_C_E").Value), Today, oRsAux.Fields("FechaCAI_C_E").Value)
        '                                        End If
        '                                    End If
        '                            End Select
        '                        Else
        '                            AgregarMensajeProcesoPresto(oRsErrores, "El punto de venta " & mPuntoVenta & " para la letra " & mLetra & _
        '                                  " no existe en la base de datos, el comprobante " & mComprobante & " no fue importado.")
        '                            mConProblemas = True
        '                        End If
        '                        oRsAux.Close()

        '                        mCotizacionDolar = 3

        '                        Select Case mIdTipoComprobante
        '                            Case 1
        '                                If mIdArticuloParaImportacionFacturas = 0 Then
        '                                    AgregarMensajeProcesoPresto(oRsErrores, "No definio en parametros el articulo generico para la importacion de facturas" & _
        '                                          ", el comprobante " & mComprobante & " no fue importado.")
        '                                    mConProblemas = True
        '                                End If

        '                                oRsAux = oAp.Facturas.TraerFiltrado("_PorNumeroComprobante", New Object() {mLetra, mPuntoVenta, mNumero))
        '                                If oRsAux.RecordCount > 0 Then
        '                                    AgregarMensajeProcesoPresto(oRsErrores, "La factura " & mComprobante & " ya existe y no fue importada.")
        '                                    mConProblemas = True
        '                                End If
        '                                oRsAux.Close()

        '                                If Not mConProblemas Then
        '                                    oFac = oAp.Facturas.Item(-1)
        '                                    With oFac
        '                                        With .Registro
        '                                            .Fields("NumeroFactura").Value = mNumero
        '                                            .Fields("TipoABC").Value = mLetra
        '                                            .Fields("PuntoVenta").Value = mPuntoVenta
        '                                            .Fields("IdCliente").Value = mIdCliente
        '                                            .Fields("FechaFactura").Value = mFecha
        '                                            .Fields("IdVendedor").Value = mIdVendedor
        '                                            .Fields("ImporteTotal").Value = mTotal
        '                                            .Fields("ImporteIva1").Value = mIVA
        '                                            .Fields("ImporteIva2").Value = 0
        '                                            .Fields("ImporteBonificacion").Value = 0
        '                                            .Fields("RetencionIBrutos1").Value = 0
        '                                            .Fields("PorcentajeIBrutos1").Value = 0
        '                                            .Fields("RetencionIBrutos2").Value = 0
        '                                            .Fields("PorcentajeIBrutos2").Value = 0
        '                                            .Fields("ConvenioMultilateral").Value = "NO"
        '                                            .Fields("RetencionIBrutos3").Value = 0
        '                                            .Fields("PorcentajeIBrutos3").Value = 0
        '                                            .Fields("CotizacionDolar").Value = mCotizacionDolar
        '                                            .Fields("PorcentajeIva1").Value = mTasa
        '                                            .Fields("PorcentajeIva2").Value = 0
        '                                            .Fields("FechaVencimiento").Value = mFecha
        '                                            .Fields("IVANoDiscriminado").Value = 0
        '                                            .Fields("IdMoneda").Value = mIdMonedaPesos
        '                                            .Fields("CotizacionMoneda").Value = 1
        '                                            .Fields("PorcentajeBonificacion").Value = 0
        '                                            .Fields("OtrasPercepciones1").Value = 0
        '                                            .Fields("OtrasPercepciones1Desc").Value = ""
        '                                            .Fields("OtrasPercepciones2").Value = 0
        '                                            .Fields("OtrasPercepciones2Desc").Value = ""
        '                                            .Fields("IdPuntoVenta").Value = mIdPuntoVenta
        '                                            .Fields("NumeroCAI").Value = Val(mCAI)
        '                                            .Fields("FechaVencimientoCAI").Value = mFechaCAI
        '                                            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
        '                                            .Fields("FechaIngreso").Value = Now
        '                                            .Fields("IdCodigoIva").Value = mIdCodigoIva
        '                                            .Fields("PercepcionIVA").Value = 0
        '                                            .Fields("PorcentajePercepcionIVA").Value = 0
        '                                        End With
        '                                        With .DetFacturas.Item(-1)
        '                                            With .Registro
        '                                                .Fields("NumeroFactura").Value = mNumero
        '                                                .Fields("TipoABC").Value = mLetra
        '                                                .Fields("PuntoVenta").Value = mPuntoVenta
        '                                                .Fields("IdArticulo").Value = mIdArticuloParaImportacionFacturas
        '                                                .Fields("Cantidad").Value = 1
        '                                                .Fields("Costo").Value = 0
        '                                                .Fields("PrecioUnitario").Value = mTotal - mIVA
        '                                                .Fields("Bonificacion").Value = 0
        '                                                .Fields("OrigenDescripcion").Value = 1
        '                                                .Fields("PrecioUnitarioTotal").Value = mTotal - mIVA
        '                                            End With
        '                                            .Modificado = True
        '                                        End With
        '                                        .Guardar()
        '                                    End With
        '                                    oFac = Nothing
        '                                End If

        '                            Case 3
        '                                If mIdConceptoParaImportacionNDNC = 0 Then
        '                                    AgregarMensajeProcesoPresto(oRsErrores, "No definio en parametros el concepto generico para la importacion de nd/nc" & _
        '                                          ", el comprobante " & mComprobante & " no fue importado.")
        '                                    mConProblemas = True
        '                                End If

        '                                oRsAux = oAp.NotasDebito.TraerFiltrado("_PorNumeroComprobante", New Object() {mLetra, mPuntoVenta, mNumero))
        '                                If oRsAux.RecordCount > 0 Then
        '                                    AgregarMensajeProcesoPresto(oRsErrores, "La nota de debito " & mComprobante & " ya existe y no fue importada.")
        '                                    mConProblemas = True
        '                                End If
        '                                oRsAux.Close()

        '                                If Not mConProblemas Then
        '                                    oDeb = oAp.NotasDebito.Item(-1)
        '                                    With oDeb
        '                                        With .Registro
        '                                            .Fields("NumeroNotaDebito").Value = mNumero
        '                                            .Fields("TipoABC").Value = mLetra
        '                                            .Fields("PuntoVenta").Value = mPuntoVenta
        '                                            .Fields("IdCliente").Value = mIdCliente
        '                                            .Fields("FechaNotaDebito").Value = mFecha
        '                                            .Fields("IdVendedor").Value = mIdVendedor
        '                                            .Fields("ImporteTotal").Value = mTotal
        '                                            .Fields("ImporteIva1").Value = mIVA
        '                                            .Fields("ImporteIva2").Value = 0
        '                                            .Fields("RetencionIBrutos1").Value = 0
        '                                            .Fields("PorcentajeIBrutos1").Value = 0
        '                                            .Fields("RetencionIBrutos2").Value = 0
        '                                            .Fields("PorcentajeIBrutos2").Value = 0
        '                                            .Fields("IdCodigoIva").Value = mIdCodigoIva
        '                                            .Fields("PorcentajeIva1").Value = mTasa
        '                                            .Fields("PorcentajeIva2").Value = 0
        '                                            .Fields("CotizacionDolar").Value = mCotizacionDolar
        '                                            .Fields("CtaCte").Value = "SI"
        '                                            .Fields("IdMoneda").Value = mIdMonedaPesos
        '                                            .Fields("CotizacionMoneda").Value = 1
        '                                            .Fields("IVANoDiscriminado").Value = 0
        '                                            .Fields("ConvenioMultilateral").Value = "NO"
        '                                            .Fields("OtrasPercepciones1").Value = 0
        '                                            .Fields("OtrasPercepciones1Desc").Value = ""
        '                                            .Fields("OtrasPercepciones2").Value = 0
        '                                            .Fields("OtrasPercepciones2Desc").Value = ""
        '                                            .Fields("OtrasPercepciones3").Value = 0
        '                                            .Fields("OtrasPercepciones3Desc").Value = ""
        '                                            .Fields("IdPuntoVenta").Value = mIdPuntoVenta
        '                                            .Fields("NumeroCAI").Value = mCAI
        '                                            .Fields("FechaVencimientoCAI").Value = mFechaCAI
        '                                            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
        '                                            .Fields("FechaIngreso").Value = Now
        '                                            .Fields("AplicarEnCtaCte").Value = "SI"
        '                                            .Fields("RetencionIBrutos3").Value = 0
        '                                            .Fields("PorcentajeIBrutos3").Value = 0
        '                                        End With
        '                                        With .DetNotasDebito.Item(-1)
        '                                            With .Registro
        '                                                .Fields("IdConcepto").Value = mIdConceptoParaImportacionNDNC
        '                                                .Fields("Importe").Value = mTotal - mIVA
        '                                                If mIVA <> 0 Then
        '                                                    .Fields("Gravado").Value = "SI"
        '                                                Else
        '                                                    .Fields("Gravado").Value = "NO"
        '                                                End If
        '                                                .Fields("IvaNoDiscriminado").Value = 0
        '                                            End With
        '                                            .Modificado = True
        '                                        End With
        '                                        .Guardar()
        '                                    End With
        '                                    oDeb = Nothing
        '                                End If

        '                            Case 4
        '                                If mIdConceptoParaImportacionNDNC = 0 Then
        '                                    AgregarMensajeProcesoPresto(oRsErrores, "No definio en parametros el concepto generico para la importacion de nd/nc" & _
        '                                          ", el comprobante " & mComprobante & " no fue importado.")
        '                                    mConProblemas = True
        '                                End If

        '                                oRsAux = oAp.NotasCredito.TraerFiltrado("_PorNumeroComprobante", New Object() {mLetra, mPuntoVenta, mNumero))
        '                                If oRsAux.RecordCount > 0 Then
        '                                    AgregarMensajeProcesoPresto(oRsErrores, "La nota de credito " & mComprobante & " ya existe y no fue importada.")
        '                                    mConProblemas = True
        '                                End If
        '                                oRsAux.Close()

        '                                If Not mConProblemas Then
        '                                    oCre = oAp.NotasCredito.Item(-1)
        '                                    With oCre
        '                                        With .Registro
        '                                            .Fields("NumeroNotaCredito").Value = mNumero
        '                                            .Fields("TipoABC").Value = mLetra
        '                                            .Fields("PuntoVenta").Value = mPuntoVenta
        '                                            .Fields("IdCliente").Value = mIdCliente
        '                                            .Fields("FechaNotaCredito").Value = mFecha
        '                                            .Fields("IdVendedor").Value = mIdVendedor
        '                                            .Fields("ImporteTotal").Value = mTotal
        '                                            .Fields("ImporteIva1").Value = mIVA
        '                                            .Fields("ImporteIva2").Value = 0
        '                                            .Fields("RetencionIBrutos1").Value = 0
        '                                            .Fields("PorcentajeIBrutos1").Value = 0
        '                                            .Fields("RetencionIBrutos2").Value = 0
        '                                            .Fields("PorcentajeIBrutos2").Value = 0
        '                                            .Fields("IdCodigoIva").Value = mIdCodigoIva
        '                                            .Fields("PorcentajeIva1").Value = mTasa
        '                                            .Fields("PorcentajeIva2").Value = 0
        '                                            .Fields("CotizacionDolar").Value = mCotizacionDolar
        '                                            .Fields("CtaCte").Value = "SI"
        '                                            .Fields("IdMoneda").Value = mIdMonedaPesos
        '                                            .Fields("CotizacionMoneda").Value = 1
        '                                            .Fields("IVANoDiscriminado").Value = 0
        '                                            .Fields("ConvenioMultilateral").Value = "NO"
        '                                            .Fields("OtrasPercepciones1").Value = 0
        '                                            .Fields("OtrasPercepciones1Desc").Value = ""
        '                                            .Fields("OtrasPercepciones2").Value = 0
        '                                            .Fields("OtrasPercepciones2Desc").Value = ""
        '                                            .Fields("OtrasPercepciones3").Value = 0
        '                                            .Fields("OtrasPercepciones3Desc").Value = ""
        '                                            .Fields("IdPuntoVenta").Value = mIdPuntoVenta
        '                                            .Fields("NumeroCAI").Value = mCAI
        '                                            .Fields("FechaVencimientoCAI").Value = mFechaCAI
        '                                            .Fields("IdUsuarioIngreso").Value = glbIdUsuario
        '                                            .Fields("FechaIngreso").Value = Now
        '                                            .Fields("AplicarEnCtaCte").Value = "SI"
        '                                            .Fields("RetencionIBrutos3").Value = 0
        '                                            .Fields("PorcentajeIBrutos3").Value = 0
        '                                        End With
        '                                        With .DetNotasCredito.Item(-1)
        '                                            With .Registro
        '                                                .Fields("IdConcepto").Value = mIdConceptoParaImportacionNDNC
        '                                                .Fields("Importe").Value = mTotal - mIVA
        '                                                If mIVA <> 0 Then
        '                                                    .Fields("Gravado").Value = "SI"
        '                                                Else
        '                                                    .Fields("Gravado").Value = "NO"
        '                                                End If
        '                                                .Fields("IvaNoDiscriminado").Value = 0
        '                                            End With
        '                                            .Modificado = True
        '                                        End With
        '                                        With .DetNotasCreditoImp.Item(-1)
        '                                            With .Registro
        '                                                .Fields("IdImputacion").Value = -1
        '                                                .Fields("Importe").Value = mTotal - mIVA
        '                                            End With
        '                                            .Modificado = True
        '                                        End With
        '                                        .Guardar()
        '                                    End With
        '                                    oCre = Nothing
        '                                End If
        '                        End Select
        'Continuar:
        '                        fl = fl + 1
        '                    Loop
        '                End With
        '                .Close(False)
        '            End With
        '            .Quit()
        '        End With

        '           Unload oF
        '           Set oF = Nothing

        '        If Not oRsErrores Is Nothing Then
        '            If oRsErrores.RecordCount > 0 Then
        '                 Set oF = New frmConsulta1
        '                 With oF
        '                    .RecordsetFuente = oRsErrores
        '                    .Id = 13
        '                    .Show(vbModal, Me)
        '                End With
        '            Else
        '                MsgBox("Proceso completo", vbInformation)
        '            End If
        '            oRsErrores = Nothing
        '        End If

        'Salida:
        '        On Error Resume Next

        '           Unload oF
        '           Set oF = Nothing

        '        oRs = Nothing
        '        oRsErrores = Nothing
        '        oRsAux = Nothing
        '        oFac = Nothing
        '        oDeb = Nothing
        '        oCre = Nothing
        '        oCli = Nothing
        '        oEx = Nothing
        '        oAp = Nothing

        '        Exit Sub

        'Mal:
        '        MsgBox("Se ha producido un error al registrar los datos" & vbCrLf & Err.Number & " -> " & Err.Description, vbCritical)
        '        Resume Salida

    End Sub


    Public Sub AgregarMensajeProcesoPresto(ByRef oRsErrores As adodb.Recordset, ByVal Mensaje As String)

        'oRsErrores.AddNew()
        'oRsErrores.Fields(0).Value = 0
        'oRsErrores.Fields(1).Value = Mensaje
        'oRsErrores.Update()

    End Sub






    








    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim mensaje = ClaseMigrar.ImportacionInformacionImpositiva(lnkAdjunto1.Text, HFSC.Value, Session("glbCuit"))
        MsgBoxAlert(mensaje)
    End Sub

    Protected Sub btnAdjuntoSubir_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdjuntoSubir.Click
        'subida de adjunto del encabezado

        'http://forums.asp.net/t/1048832.aspx  'COMO SUBIr de a varios!!!

        'if (FileUpLoad1.HasFile) {

        'http://mattberseth.com/blog/2008/07/aspnet_file_upload_with_realti_1.html

        'http://geekswithblogs.net/ranganh/archive/2008/04/01/file-upload-in-updatepanel-asp.net-ajax.aspx

        Dim DIRFTP = System.IO.Path.GetTempPath

        If FileUpLoad2.FileName <> "" Then
            Try


                Dim MyFile1 As New FileInfo(DIRFTP + FileUpLoad2.FileName)
                Try
                    If MyFile1.Exists Then
                        MyFile1.Delete()
                    End If
                Catch ex As Exception
                End Try


                FileUpLoad2.SaveAs(DIRFTP + FileUpLoad2.FileName)
                lnkAdjunto1.Text = DIRFTP + FileUpLoad2.FileName

                'oculto y muestro los controles hasta que se me ocurra una manera más piola
                MostrarBotonesParaAdjuntar(False)

                'RefrescaGrilla()
                Dim mensaje = ClaseMigrar.ImportacionInformacionImpositiva(lnkAdjunto1.Text, HFSC.Value, Session("glbCuit"))
                MsgBoxAlert(mensaje)

            Catch ex As Exception
                MsgBoxAlert(ex.Message)
            End Try
        Else
            'FileUpLoad2.click 'estaría bueno que se pudiese hacer esto, es decir, llamar al click
        End If


    End Sub

    Sub MostrarBotonesParaAdjuntar(ByVal mostrar As Boolean)
        lnkAdjunto1.Visible = Not mostrar
        lnkBorrarAdjunto.Visible = Not mostrar And lnkAdjunto1.Text <> "" 'si no hay arhcivo, no hay borrar

        FileUpLoad2.Visible = mostrar
        btnAdjuntoSubir.Visible = mostrar
    End Sub

    Protected Sub lnkBorrarAdjunto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBorrarAdjunto.Click
        lnkAdjunto1.Text = ""
        MostrarBotonesParaAdjuntar(True)
    End Sub



    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim FilePath '= GenerarTxtLoteResolucion1361()

        FilePath = "c:\williams.bmp"

        'EL BOTON DE DESCARGA DEBE ESTAR AFUERA DE LOS UPDATEPANEL!!!!!!!
        If FilePath <> "" Then
            Dim MyFile As New System.IO.FileInfo(FilePath)
            If MyFile.Exists Then
                'Set the appropriate ContentType.
                Try
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile.Name)
                    'Write the file directly to the HTTP output stream.
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                    Response.TransmitFile(FilePath)
                    Response.End() 'http://support.microsoft.com/kb/312629/EN-US/
                    'HttpContext.Current.ApplicationInstance.CompleteRequest()
                    'http://forums.asp.net/p/1469271/3399956.aspx
                    'http://support.microsoft.com/kb/312629/EN-US/
                    'PRB: ThreadAbortException Occurs If You Use Response.End, Response.Redirect, or Server.Transfer
                Catch ex As Exception
                    MsgBoxAjax(Me, ex.Message)
                End Try
            End If
        Else
            MsgBoxAjax(Me, "No se encuentra el archivo")
            Exit Sub
        End If
    End Sub
End Class
