Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports Pronto.ERP.Bll.ParametroManager

Partial Class Resolucion1361
    Inherits System.Web.UI.Page




    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))

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

            Me.Title = "Resolucion 1361"

            txtFechaDesde.Text = Today


            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If


        Else

            Try
                'ReBind()

            Catch ex As Exception

            End Try
            

        End If


        If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            LinkAgregarRenglon.Enabled = False
        Else
            LinkAgregarRenglon.Enabled = True
        End If
    End Sub

    Sub ReBind()
        'extraido de frmConsulta





        'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 


        Try
            If RadioButtonList1.selectedvalue = 1 Then
                GridView1.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "InformesContables_TX_1361_CabeceraFacturas", iisValidSqlDate(txtFechaDesde.Text, #1/1/1900#), iisValidSqlDate(txtFechaHasta.Text, Today))
                'oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_CabeceraFacturas", Array(DTFields(0).Value, DTFields(1).Value))
            ElseIf RadioButtonList1.SelectedValue = 2 Then
                GridView1.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "InformesContables_TX_1361_DetalleFacturas", iisValidSqlDate(txtFechaDesde.Text, #1/1/1900#), iisValidSqlDate(txtFechaHasta.Text, Today))
                'oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_DetalleFacturas", Array(DTFields(0).Value, DTFields(1).Value))
            ElseIf RadioButtonList1.SelectedValue = 3 Then
                GridView1.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "InformesContables_TX__1361_Ventas", iisValidSqlDate(txtFechaDesde.Text, #1/1/1900#), iisValidSqlDate(txtFechaHasta.Text, Today))
                'oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_Ventas", Array(DTFields(0).Value, DTFields(1).Value))
            ElseIf RadioButtonList1.SelectedValue = 4 Then

                Dim mCampo1 = EntidadManager.BuscarClaveINI("IdCuentas adicionales para impuestos internos", HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario))
                If Len(mCampo1) > 0 Then
                    Dim mVectorAux = Split(mCampo1, ",")
                    mCampo1 = ""
                    For i = 0 To UBound(mVectorAux)
                        mCampo1 = mCampo1 & "(" & CLng(mVectorAux(i)) & ")"
                    Next
                End If
                GridView1.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "InformesContables_TX_1361_Compras", iisValidSqlDate(txtFechaDesde.Text, #1/1/1900#), iisValidSqlDate(txtFechaHasta.Text, Today), mCampo1)
                'oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_1361_Compras", Array(DTFields(0).Value, DTFields(1).Value, mCampo1))
            End If


            'esta explotando si uso una fecha muy vieja
            'EntidadManager.GetStoreProcedure(GetConnectionString(Server, Session), "CartasDePorte_T", -1)

            Debug.Print(GridView1.DataSource.tables(0).rows.count)
        Catch ex As Exception

        End Try

        GridView1.DataBind()

    End Sub


    Function GenerarWHERE() As String
        Dim s As String

        '//////////
        'debug
        '//////////
        'Return "ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL "
        'Return "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL )  AND  (Aprobo IS NULL OR Aprobo=0) "
        's = "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL )  AND  (Aprobo IS NULL OR Aprobo=0) "
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
                s += " AND (IdAprobo IS NULL OR IdAprobo=0 OR IdAprobo=-1)"
                's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

            Case "AConfirmarEnCentral"
                s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)  AND  (Aprobo IS NULL OR Aprobo=0) ) "

            Case "Confirmados"
                s += " AND (IdAprobo NOT IS NULL AND IdAprobo>0)"
                's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
        End Select


        Return s
    End Function

    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdPresupuesto As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Comparativa.aspx?Id={0}", IdPresupuesto.ToString))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        ''crea la grilla anidada con el detalle
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

        '    'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
        '    ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
        '    Try
        '        gp.DataSource = ObjectDataSource2.Select
        '        gp.DataBind()
        '        If gp.Columns.Count > 0 Then gp.Columns(0).Visible = False 'oculto la columna del Id -no funciona
        '    Catch ex As Exception
        '        Debug.Print(ex.Message)
        '        Throw New ApplicationException("Error en la grabacion " + ex.Message, ex)
        '    Finally
        '    End Try
        '    gp.Width = 200

        'End If


        Try
            e.Row.Cells(0).Visible = False
            e.Row.Cells(e.Row.Cells.Count - 1).Visible = False
            e.Row.Cells(e.Row.Cells.Count - 2).Visible = False
            e.Row.Cells(e.Row.Cells.Count - 3).Visible = False
            'e.Row.Cells(0).Width = 0
            'e.Row.Cells(e.Row.Cells.Count - 1).Width = 0
            'e.Row.Cells(e.Row.Cells.Count - 2).Width = 0
        Catch ex As Exception

        End Try

    End Sub






    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        'Dim records(e.NewValues.Count - 1) As DictionaryEntry
        'e.NewValues.CopyTo(records, 0)

        'Dim entry As DictionaryEntry
        'For Each entry In records
        '    e.NewValues(entry.Key) = CType(Server.HtmlEncode(entry.Value.ToString()), DateTime)
        'Next


    End Sub

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
    'refrescos
    '///////////////////////////////////





    '///////////////////////////////////
    '///////////////////////////////////
    'botones y links
    '///////////////////////////////////



    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        GridViewExportUtil.Export("Grilla.xls", GridView1)
    End Sub

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





    Public Sub AgregarMensajeProcesoPresto(ByRef oRsErrores As adodb.Recordset, ByVal Mensaje As String)

        'oRsErrores.AddNew()
        'oRsErrores.Fields(0).Value = 0
        'oRsErrores.Fields(1).Value = Mensaje
        'oRsErrores.Update()

    End Sub


    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim FilePath = GenerarTxtLoteResolucion1361()

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






    Sub ListaDeComprobantesParaProcesar()



        'If Option3.Value Then
        '    oTab = EntidadManager.GetListTX("InformesContables", "_1361_CabeceraFacturas", Array(DTFields(0).Value, DTFields(1).Value))
        'ElseIf Option4.Value Then
        '    oTab = EntidadManager.GetListTX("InformesContables", "_1361_DetalleFacturas", Array(DTFields(0).Value, DTFields(1).Value))
        'ElseIf Option5.Value Then
        '    oTab = EntidadManager.GetListTX("InformesContables", "_1361_Ventas", Array(DTFields(0).Value, DTFields(1).Value))
        'ElseIf Option10.Value Then
        '    mCampo1 = BuscarClaveINI("IdCuentas adicionales para impuestos internos")
        '    If Len(mCampo1) > 0 Then
        '        mVectorAux = VBA.Split(mCampo1, ",")
        '        mCampo1 = ""
        '        For i = 0 To UBound(mVectorAux)
        '            mCampo1 = mCampo1 & "(" & CLng(mVectorAux(i)) & ")"
        '        Next
        '    End If
        '    oTab = EntidadManager.GetListTX("InformesContables", "_1361_Compras", Array(DTFields(0).Value, DTFields(1).Value, mCampo1))
        'ElseIf Option11.Value Then

        'End If

    End Sub






    Function GenerarTxtLoteResolucion1361() As String

        'If ListaVacia Then Exit Sub
        Dim mArchivoTxt As String
        Dim mPos As Long

        'mArchivoTxt = "PRUEBA"
        If RadioButtonList1.SelectedValue = 1 Then
            mArchivoTxt = "CABECERA_" & Format(Year(txtFechaDesde.Text), "0000") & _
                           Format(Month(txtFechaDesde.Text), "00")
            mPos = 30 + 1
        ElseIf RadioButtonList1.SelectedValue = 2 Then
            mArchivoTxt = "DETALLE_" & Format(Year(txtFechaDesde.Text), "0000") & _
                           Format(Month(txtFechaDesde.Text), "00")
            mPos = 15 + 1
        ElseIf RadioButtonList1.SelectedValue = 3 Then
            mArchivoTxt = "VENTAS_" & Format(Year(txtFechaDesde.Text), "0000") & _
                           Format(Month(txtFechaDesde.Text), "00")
            mPos = 28 + 1
        ElseIf RadioButtonList1.SelectedValue = 4 Then
            mArchivoTxt = "COMPRAS_" & Format(Year(txtFechaDesde.Text), "0000") & _
                           Format(Month(txtFechaDesde.Text), "00")
            mPos = 34 + 1
        ElseIf RadioButtonList1.SelectedValue = 5 Then
            mArchivoTxt = "OTRASPERCEP_" & Format(Year(txtFechaDesde.Text), "0000") & _
                           Format(Month(txtFechaDesde.Text), "00")
            mPos = 8 + 1
        End If

        Dim s As String = ""
        For Each oL As GridViewRow In GridView1.Rows 'Lista.ListItems
            'tiene que grabar la columna titulada "Registro"
            If Len(oL.Cells(mPos).Text) > 0 Then s = s & oL.Cells(mPos).Text & vbCrLf
        Next
        If Len(s) > 0 Then s = Mid(s, 1, Len(s) - 2)

        Dim FullPathArch = System.IO.Path.GetTempPath & mArchivoTxt & ".TXT"
        GuardarArchivoSecuencial(FullPathArch, s)
        Return FullPathArch
        'MsgBox "Se ha generado el archivo : " & mvarPathArchivosExportados & mArchivoTxt & ".txt", vbInformation
    End Function






    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        ReBind()
    End Sub
End Class
