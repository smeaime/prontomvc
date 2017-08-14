Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports System.Data
Imports System.Linq
Imports Microsoft.Reporting.WebForms
Imports ProntoFuncionesGenerales
Imports Pronto.ERP.Bll.EntidadManager

Imports Pronto.ERP.Bll.SincronismosWilliamsManager
Imports Pronto.ERP.Bll.InformesCartaDePorteManager

Imports CodeEngine.Framework.QueryBuilder

'Imports Pronto.ERP.Bll.CartaDePorteManager

Imports System.Threading

Imports CartaDePorteManager

Partial Class CartaDePorteInformesAccesoClientes
    Inherits System.Web.UI.Page

    Dim bRecargarInforme As Boolean

    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////


    'TODO:
    '/Login.aspx?ReturnUrl=%2fProntoWeb%2fCartaDePorteInformesAccesoClientes.aspx%3f_TSM_HiddenField_%3dctl00_ScriptManager1_HiddenField%26_TSM_CombinedScripts_%3d%253b%253bAjaxControlToolkit%252c%2bVersion%253d3.5.50927.0%252c%2bCulture%253dneutral%252c%2bPublicKeyToken%253d28f01b0e84b6d53e%253aen-US%253a4a126967-c4d4-4d5c-8f94-b4e3e72d7549%253ade1feab2%253af9cec9bc%253a35576c48%253af2c8e708%253a720a52bf%253a589eaa30%
    'Assembly "AjaxControlToolkit, Version=3.5.50927.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" does not contain a script with hash code "a4b66312/".

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(Session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, Session(SESSIONPRONTO_glbIdObraAsignadaUsuario))


        If HFSC.Value = "" Then
            Response.Redirect("~/SeleccionarEmpresa.aspx")
        End If



        bRecargarInforme = False

        'Report Viewer Error - Parameter name: panelsCreated[1]   http://ajaxcontroltoolkit.codeplex.com/workitem/26778
        'AjaxControlToolkit.ToolkitScriptManager.ScriptMode = ScriptMode.Release
        'scriptmanager1.


        'Invalid postback or callback argument. Event validation is enabled using in configuration or <%@ Page EnableEventValidation="true" %> in a page. For security purposes, this feature verifies that arguments to postback or callback events originate from the server control that originally rendered them. If the data is valid and expected, use the ClientScriptManager.RegisterForEventValidation method in order to register the postback or callback data for validation.


        If CartaDePorteManager.EsClienteBLDcorredor(HFSC.Value) Then
            Response.Redirect("CartaDePorteInformesAccesoClientesBLDcorredor.aspx")
        End If


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            Me.Title = "Informes de CDPs"


            Try
                BindTypeDropDown()
            Catch ex As Exception
                MandarMailDeError(ex)
            End Try




            refrescaPeriodo()


            'agregar al where que aparezca la razon social de este cliente
            Dim rs As String
            Try
                rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(Session(SESSIONPRONTO_UserId), ConexBDLmaster, HFSC.Value)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                rs = Session(SESSIONPRONTO_UserName) 'como no encuentro el usuario en la tabla de datos adicionales de la bdlmaster, uso el nombre del usuario como razon social que esperaba encontrar en esa dichosa tabla
            End Try


            If rs <> "" Then
                Dim idcli = BuscaIdClientePreciso(rs, HFSC.Value)
                If idcli = -1 Then

                    MsgBoxAjax(Me, "No existe el cliente: " & rs)
                    Exit Sub
                End If
            End If


            lblRazonSocial.Text = rs



            Dim clientes As List(Of String) = TraerCUITClientesSegunUsuario(Session(SESSIONPRONTO_UserName), HFSC.Value, ConexBDLmaster).Where(Function(x) x <> "").ToList  'c.ToList()
            'If clientes.Count > 0 Then

            '    chkTitular.Checked = False
            '    chkTitular.Visible = False
            '    chkIntermediario.Checked = False
            '    chkIntermediario.Visible = False
            '    chkRemComercial.Checked = False
            '    chkRemComercial.Visible = False
            '    chkClienteAuxiliar.Checked = False
            '    chkClienteAuxiliar.Visible = False
            '    chkCorredor.Checked = False
            '    chkCorredor.Visible = False
            '    chkDestinatario.Checked = False
            '    chkDestinatario.Visible = False
            '    cmbCriterioWHERE.Visible = False

            'End If




            BloqueosDeEdicion()

        End If


        'Dim tx As TextBox = Me.Master.FindControl("txtSuperbuscador")
        'tx.Visible = False



        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnDescargaSincro)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImagenes)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImagenesPDF)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImagenesTiffReducido)
        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnExcel)
        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnTexto)

        AutoCompleteExtender2.ContextKey = HFSC.Value
        AutoCompleteExtender21.ContextKey = HFSC.Value
        AutoCompleteExtender24.ContextKey = HFSC.Value
        AutoCompleteExtender25.ContextKey = HFSC.Value
        AutoCompleteExtender26.ContextKey = HFSC.Value
        AutoCompleteExtender27.ContextKey = HFSC.Value
        AutoCompleteExtender3.ContextKey = HFSC.Value
        AutoCompleteExtender4.ContextKey = HFSC.Value


    End Sub

    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        'If bRecargarInforme Then AsignaInformeAlReportViewer()
    End Sub


    Protected Sub LoginStatus1_LoggedOut(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        'FormsAuthentication.RedirectToLoginPage();
    End Sub



    Protected Sub btnRefrescar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefrescar.Click
        AsignaInformeAlReportViewer()
        'bRecargarInforme = True
    End Sub


    Sub BloqueosDeEdicion()
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_ImagenesDescarga)

        If Not p("PuedeLeer") Then
            btnImagenes.Visible = False
        End If


        'web para clientes de williams
        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7872

        'usuario losgrobo 

        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

    End Sub


  

    Private Sub BindTypeDropDown()
        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "Nombre"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0
        cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
        cmbPuntoVenta.SelectedIndex = 0

        Try
            If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                BuscaIDEnCombo(cmbPuntoVenta, pventa)
                'BuscaTextoEnCombo(cmbPuntoVenta, pventa)
                If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try




        'agregar al where que aparezca la razon social de este cliente
        Dim rs As String
        Try
            rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(Session(SESSIONPRONTO_UserId), ConexBDLmaster, HFSC.Value)

        Catch ex As Exception
            'como no encuentro el usuario en la tabla de datos adicionales de la bdlmaster, 
            ' uso el nombre del usuario como razon social que esperaba encontrar en esa dichosa tabla
            ErrHandler2.WriteError(ex)
            rs = Session(SESSIONPRONTO_UserName)
        End Try

        If InStr(rs, "A.C.A") > 0 Then
            optDivisionSyngenta.Visible = True


            Dim li = CartaDePorteManager.excepcionesAcopios(HFSC.Value).Select(Function(z) New With {z.idacopio, z.desc})
            'li.Remove("Agro")
            'li.Remove("Seeds")

            optDivisionSyngenta.DataTextField = "desc"
            optDivisionSyngenta.DataValueField = "idacopio"
            optDivisionSyngenta.DataSource = li 'New String() {"", "CDC Pehua.", "CDC Olavar", "CDC Naon", "CDC G.Vill", "CDC Iriart", "CDC Wright", "OTROS"}
            optDivisionSyngenta.DataBind()

            Select Case rs
                Case "A.C.A.LTDA"
                    optDivisionSyngenta.Enabled = True

                Case "A.C.A - ACOPIO  IRIARTE"
                    BuscaTextoEnCombo(optDivisionSyngenta, "CDC Iriart")
                    optDivisionSyngenta.Enabled = False

                Case "A.C.A. LTDA. (ACOPIO BRAGADO )"
                    BuscaTextoEnCombo(optDivisionSyngenta, "CDC Iriart")
                    optDivisionSyngenta.Enabled = False

                Case "A.C.A. LTDA. (ACOPIO PEHUAJO )"
                    BuscaTextoEnCombo(optDivisionSyngenta, "CDC Pehua.")
                    optDivisionSyngenta.Enabled = False

                Case "A.C.A. LTDA. (ACOPIO NAON )"
                    BuscaTextoEnCombo(optDivisionSyngenta, "CDC Naon")
                    optDivisionSyngenta.Enabled = False

                Case Else
                    Try
                        rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(Session(SESSIONPRONTO_UserId), ConexBDLmaster, HFSC.Value)

                        Dim acopio As String = Mid(rs, InStr(rs, "A.C.A. ") + Len("A.C.A. "))
                        BuscaTextoEnCombo(optDivisionSyngenta, acopio)

                    Catch ex As Exception

                        ErrHandler2.WriteError(ex)
                        Throw New Exception("No tenés acopio asignado")

                    End Try


            End Select


        Else
            optDivisionSyngenta.Visible = False
        End If


    End Sub





    Sub AsignaInformeAlReportViewer(Optional ByVal bDescargaExcel As Boolean = False)

        '        Log(Entry)
        '04/21/2014 12:37:52
        'Error in: http://prontoclientes.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesAccesoClientes.aspx. Error Message:Error en GetDataTableFiltradoYPaginado. Probable timeout.         ver si el error es de system memory o de report processing, recomendar reinicio del IIS por las sesiones con basura. Incluir sp_who2. Filtro: Descargas,              (Exporta: Entregas, Punto de venta: Todos, Criterio: ALGUNOS Contiene: FUTUROS Y OPCIONES .COM)Error: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
        '        __________________________()

        '        Log(Entry)
        '04/21/2014 12:37:52
        'Error in: http://prontoclientes.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesAccesoClientes.aspx. Error Message:Hubo un error al generar el informe. System.ApplicationException: WriteAndRaiseError: Error en GetDataTableFiltradoYPaginado. Probable timeout.         ver si el error es de system memory o de report processing, recomendar reinicio del IIS por las sesiones con basura. Incluir sp_who2. Filtro: Descargas,              (Exporta: Entregas, Punto de venta: Todos, Criterio: ALGUNOS Contiene: FUTUROS Y OPCIONES .COM)Error: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
        '   at ErrHandler2.WriteAndRaiseError(String errorMessage) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 143
        '   at CartaDePorteManager.GetDataTableFiltradoYPaginado(String SC, String ColumnaParaFiltrar, String TextoParaFiltrar, String sortExpression, Int64 startRowIndex, Int64 maximumRows, enumCDPestado estado, String QueContenga, Int32 idVendedor, Int32 idCorredor, Int32 idDestinatario, Int32 idIntermediario, Int32 idRemComercial, Int32 idArticulo, Int32 idProcedencia, Int32 idDestino, FiltroANDOR AplicarANDuORalFiltro, String ModoExportacion, DateTime fechadesde, DateTime fechahasta, Int32 puntoventa, String& sTituloFiltroUsado, String optDivisionSyngenta, Boolean bTraerDuplicados, String Contrato, String QueContenga2, Int32 idClienteAuxiliar, Int32 AgrupadorDeTandaPeriodos, Int32 Vagon, String Patente, Boolean bInsertarEnTablaTemporal)
        '   at CartaDePorteInformesAccesoClientes.AsignaInformeAlReportViewer(Boolean bDescargaExcel)


        'agregar al where que aparezca la razon social de este cliente
        Dim rs As String
        Try
            rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(Session(SESSIONPRONTO_UserId), ConexBDLmaster, HFSC.Value)
        Catch ex As Exception
            'como no encuentro el usuario en la tabla de datos adicionales de la bdlmaster, 
            ' uso el nombre del usuario como razon social que esperaba encontrar en esa dichosa tabla
            ErrHandler2.WriteError(ex)
            rs = Session(SESSIONPRONTO_UserName)
        End Try


        If InStr(rs, "A.C.A") > 0 Then
            'verifica que exista el cliente "A.C.A.LTDA" y que no le hayan cambiado el nombre

            rs = "A.C.A. LTDA"
            If BuscaIdClientePreciso(rs, HFSC.Value) = -1 Then
                MsgBoxAjax(Me, "No existe el cliente: " & rs)
                Exit Sub

            End If
        End If





        If rs <> "" Then
            Dim idcli = BuscaIdClientePreciso(rs, HFSC.Value)
            If idcli = -1 Then
                MsgBoxAjax(Me, "No existe el cliente: " & rs)
                Exit Sub
            End If
        End If




        If chkTitular.Checked Then txtVendedor.Text = rs Else txtVendedor.Text = ""
        If chkIntermediario.Checked Then txtIntermediario.Text = rs Else txtIntermediario.Text = ""
        If chkRemComercial.Checked Then txtRcomercial.Text = rs Else txtRcomercial.Text = ""
        If chkClienteAuxiliar.Checked Then txtClienteAuxiliar.Text = rs Else txtClienteAuxiliar.Text = ""
        If chkCorredor.Checked Then txtCorredor.Text = rs Else txtCorredor.Text = ""
        If chkDestinatario.Checked Then txtEntregador.Text = rs Else txtEntregador.Text = ""

        If Not (chkTitular.Checked Or chkRemComercial.Checked Or chkIntermediario.Checked Or chkCorredor.Checked Or chkDestinatario.Checked Or chkClienteAuxiliar.Checked) Then
            MsgBoxAjax(Me, "Por lo menos hay que tildar un filtro")
            Exit Sub 'tiene que haber alguno tildado


            Dim clientes As List(Of String) = TraerCUITClientesSegunUsuario(Session(SESSIONPRONTO_UserName), HFSC.Value, ConexBDLmaster).Where(Function(x) x <> "").ToList  'c.ToList()
            If clientes.Count = 0 Then
                Exit Sub 'tiene que haber alguno tildado
            Else
                rs = ""
            End If
        End If





        Dim output As String = ""


        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtVendedor.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar '= BuscaIdClientePreciso(chkClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtEntregador.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        'lblRazonSocial.Text






        Dim estadofiltro As CartaDePorteManager.enumCDPestado
        Select Case cmbEstado.Text  '
            Case "TodasMenosLasRechazadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
            Case "Incompletas"
                estadofiltro = CartaDePorteManager.enumCDPestado.Incompletas
            Case "Posición"
                estadofiltro = CartaDePorteManager.enumCDPestado.Posicion
            Case "Descargas"
                estadofiltro = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
            Case "Facturadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.Facturadas
            Case "NoFacturadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.NoFacturadas
            Case "Rechazadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.Rechazadas
            Case "EnNotaCredito"
                estadofiltro = CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito
            Case Else
                Return
        End Select



        'Dim idcliente = BuscaIdClientePreciso(rs, HFSC.Value)







        Dim serv
        If System.Diagnostics.Debugger.IsAttached() Then
            serv = "http://localhost:48391/ProntoWeb"
        Else
            serv = "http://prontoclientes.williamsentregas.com.ar/"
        End If

        'RebindReportViewerLINQ("ProntoWeb\Informes\Cartas con Copia sin asignar.rdl", qq, New ReportParameter() {New ReportParameter("sServidor", serv)})












        If False Then



            'Dim dt = DataTablePorCliente(HFSC.Value, _
            '            "", "", "", 1, 0, _
            '            estadofiltro, rs, idVendedor, idCorredor, _
            '            idDestinatario, idIntermediario, _
            '            idRComercial, idArticulo, idProcedencia, idDestino, _
            '            IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
            '                            DropDownList2.Text, _
            '            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '            cmbPuntoVenta.SelectedValue, Session(SESSIONPRONTO_UserName), ConexBDLmaster)








            'Try


            '    If dt.Rows.Count = 1 Then
            '        If dt.Rows(0).Item("PathImagen").ToString <> "" Then
            '            ' lblErrores.Text = "~/ProntoWeb/CartasDePorteImagenEncriptada.aspx?Id=" & dt.Rows(0).Item("ClaveEncriptada")
            '            iframeAAAA.Attributes("src") = "CartasDePorteImagenEncriptada.aspx?Id=" & dt.Rows(0).Item("ClaveEncriptada")
            '            iframeAAAA.Visible = True
            '        End If
            '    Else
            '        iframeAAAA.Attributes("src") = ""
            '        iframeAAAA.Visible = False
            '    End If

            'Catch ex As Exception
            '    Dim ms = ex.ToString & "   " & dt.Rows.Count() & " " & dt.Rows(0).Item("IdCartaDePorte") & " " & dt.Rows(0).Item("NumeroCDP")
            '    MandarMailDeError(ms)
            '    ErrHandler2.WriteError(ms)

            '    MsgBoxAjax(Me, ms)
            'End Try



            'ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
            '            "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl", _
            '                    dt, Nothing, , , sTitulo)


        Else


            Dim strSQL = DataTablePorClienteSQL(HFSC.Value, _
                               "", "", "", 1, 0, _
                               estadofiltro, rs, idVendedor, idCorredor, _
                               idDestinatario, idIntermediario, _
                               idRComercial, idArticulo, idProcedencia, idDestino, _
                               IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                               DropDownList2.Text, _
                               Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                               Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                               cmbPuntoVenta.SelectedValue, txtQueContenga.Text, Session(SESSIONPRONTO_UserName), ConexBDLmaster(), _
            chkTitular.Checked, chkIntermediario.Checked, chkRemComercial.Checked, chkClienteAuxiliar.Checked, chkCorredor.Checked, chkDestinatario.Checked)




            Dim yourParams As ReportParameter() = New ReportParameter(9) {}

                yourParams(0) = New ReportParameter("webservice", "")
                yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
                yourParams(2) = New ReportParameter("idArticulo", -1)
                yourParams(3) = New ReportParameter("idDestino", -1)
                yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
                yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
                yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
                yourParams(7) = New ReportParameter("Consulta", strSQL)
                yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(HFSC.Value))
                yourParams(9) = New ReportParameter("titulo", "Informe")


                RebindReportViewer_Servidor_SalidaNormal(ReportViewer2, "Listado general de Cartas de Porte (simulando original) con foto 2", yourParams)



            End If






            If output = "" Then Return

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
                'ErrHandler2.WriteAndRaiseError(ex.tostring)
                ErrHandler2.WriteError(ex.ToString)
                'MsgBoxAjax(Me, ex.tostring)
                Return
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



    Sub sacaColumnas(ByRef dt)


        'Tratando de aligerar el dataset que enlazo
        'dt.Columns.Remove("IdCartaDePorte")
        'dt.Columns.Remove("NumeroCartaDePorte")
        'dt.Columns.Remove("FechaIngreso")
        'dt.Columns.Remove("Anulada")
        'dt.Columns.Remove("IdUsuarioAnulo")
        'dt.Columns.Remove("FechaAnulacion")
        'dt.Columns.Remove("Observaciones")
        dt.Columns.Remove("FechaTimeStamp")
        'dt.Columns.Remove("Vendedor")
        'dt.Columns.Remove("CuentaOrden1")
        'dt.Columns.Remove("CuentaOrden2")
        'dt.Columns.Remove("Corredor")
        'dt.Columns.Remove("Entregador")
        'dt.Columns.Remove("Procedencia")
        'dt.Columns.Remove("Patente")
        'dt.Columns.Remove("IdArticulo")
        dt.Columns.Remove("IdStock")
        dt.Columns.Remove("Partida")
        dt.Columns.Remove("IdUnidad")
        dt.Columns.Remove("IdUbicacion")
        dt.Columns.Remove("Cantidad")
        dt.Columns.Remove("Cupo")
        'dt.Columns.Remove("NetoProc")
        'dt.Columns.Remove("Calidad")
        'dt.Columns.Remove("BrutoPto")
        'dt.Columns.Remove("TaraPto")
        'dt.Columns.Remove("NetoPto")
        'dt.Columns.Remove("Acoplado")
        'dt.Columns.Remove("Humedad")
        'dt.Columns.Remove("Merma")
        'dt.Columns.Remove("NetoFinal")
        'dt.Columns.Remove("FechaDeCarga")
        'dt.Columns.Remove("FechaVencimiento")
        dt.Columns.Remove("CEE")
        'dt.Columns.Remove("IdTransportista")
        'dt.Columns.Remove("TransportistaCUIT")
        'dt.Columns.Remove("IdChofer")
        'dt.Columns.Remove("ChoferCUIT")
        dt.Columns.Remove("CTG")
        'dt.Columns.Remove("Contrato")
        'dt.Columns.Remove("Destino")
        dt.Columns.Remove("Subcontr1")
        dt.Columns.Remove("Subcontr2")
        'dt.Columns.Remove("Contrato1")
        'dt.Columns.Remove("contrato2")
        dt.Columns.Remove("KmARecorrer")
        dt.Columns.Remove("Tarifa")
        'dt.Columns.Remove("FechaDescarga")
        dt.Columns.Remove("Hora")
        dt.Columns.Remove("NRecibo")
        'dt.Columns.Remove("CalidadDe")
        'dt.Columns.Remove("TaraFinal")
        'dt.Columns.Remove("BrutoFinal")
        dt.Columns.Remove("Fumigada")
        dt.Columns.Remove("Secada")
        'dt.Columns.Remove("Exporta")
        dt.Columns.Remove("NobleExtranos")
        dt.Columns.Remove("NobleNegros")
        dt.Columns.Remove("NobleQuebrados")
        dt.Columns.Remove("NobleDaniados")
        dt.Columns.Remove("NobleChamico")
        dt.Columns.Remove("NobleChamico2")
        dt.Columns.Remove("NobleRevolcado")
        dt.Columns.Remove("NobleObjetables")
        dt.Columns.Remove("NobleAmohosados")
        dt.Columns.Remove("NobleHectolitrico")
        dt.Columns.Remove("NobleCarbon")
        dt.Columns.Remove("NoblePanzaBlanca")
        dt.Columns.Remove("NoblePicados")
        dt.Columns.Remove("NobleMGrasa")
        dt.Columns.Remove("NobleAcidezGrasa")
        dt.Columns.Remove("NobleVerdes")
        dt.Columns.Remove("NobleGrado")
        dt.Columns.Remove("NobleConforme")
        dt.Columns.Remove("NobleACamara")
        'dt.Columns.Remove("Cosecha")
        'dt.Columns.Remove("HumedadDesnormalizada")
        dt.Columns.Remove("Factor")
        dt.Columns.Remove("IdFacturaImputada")
        'dt.Columns.Remove("PuntoVenta")
        'dt.Columns.Remove("SubnumeroVagon")
        dt.Columns.Remove("TarifaFacturada")
        dt.Columns.Remove("TarifaSubcontratista1")
        dt.Columns.Remove("TarifaSubcontratista2")
        'dt.Columns.Remove("FechaArribo")
        dt.Columns.Remove("Version")
        dt.Columns.Remove("MotivoAnulacion")
        'dt.Columns.Remove("Corredor2")
        dt.Columns.Remove("CodigoSAJPYA")
        'dt.Columns.Remove("VendedorDesc")
        'dt.Columns.Remove("CuentaOrden1Desc")
        'dt.Columns.Remove("CuentaOrden2Desc")
        'dt.Columns.Remove("CorredorDesc")
        'dt.Columns.Remove("EntregadorDesc")
        dt.Columns.Remove("Subcontr1Desc")
        dt.Columns.Remove("Subcontr2Desc")
        'dt.Columns.Remove("Producto")
        'dt.Columns.Remove("TransportistaDesc")
        dt.Columns.Remove("Mes")
        dt.Columns.Remove("Ano")
        dt.Columns.Remove("Factura")
        dt.Columns.Remove("FechaFactura")
        dt.Columns.Remove("ClienteFacturado")
        'dt.Columns.Remove("CalidadDesc")

    End Sub





    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////



    Protected Sub txt_AC_Articulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txt_AC_Articulo.TextChanged

        bRecargarInforme = True
    End Sub

    Protected Sub txtEntregador_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtEntregador.TextChanged
        bRecargarInforme = True
    End Sub

    Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
        bRecargarInforme = True
    End Sub

    Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
        bRecargarInforme = True
    End Sub

    Protected Sub txtDestino_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestino.TextChanged
        bRecargarInforme = True

    End Sub

    Protected Sub txtVendedor_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtVendedor.TextChanged
        bRecargarInforme = True

    End Sub

    Protected Sub txtProcedencia_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtProcedencia.TextChanged
        bRecargarInforme = True

    End Sub



    Protected Sub txtCorredor_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCorredor.TextChanged
        bRecargarInforme = True
    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////











    Protected Sub cmbPeriodo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodo.SelectedIndexChanged
        refrescaPeriodo()

    End Sub

    Sub refrescaPeriodo()
        txtFechaDesde.Visible = False
        txtFechaHasta.Visible = False
        Select Case cmbPeriodo.Text

            Case "Cualquier fecha"
                txtFechaDesde.Text = ""
                txtFechaHasta.Text = ""

            Case "Hoy"
                txtFechaDesde.Text = Today
                txtFechaHasta.Text = ""

            Case "Ayer"
                txtFechaDesde.Text = DateAdd(DateInterval.Day, -1, Today)
                txtFechaHasta.Text = DateAdd(DateInterval.Day, -1, Today)

            Case "Este mes"
                txtFechaDesde.Text = GetFirstDayInMonth(Today)
                txtFechaHasta.Text = GetLastDayInMonth(Today)
            Case "Mes anterior"
                txtFechaDesde.Text = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
                txtFechaHasta.Text = GetLastDayInMonth(DateAdd(DateInterval.Month, -1, Today))
            Case "Personalizar"
                txtFechaDesde.Visible = True
                txtFechaHasta.Visible = True
        End Select


    End Sub



    Function RebindReportViewerTexto(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing, Optional ByRef ArchivoExcelDestino As String = "") As String


        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = Path.GetTempPath & "DescargasDetalladasPorTitular " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = rdlFile
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim bytes As Byte() = ReportViewer2.LocalReport.Render( _
                       "Excel", Nothing, mimeType, encoding, _
                         extension, _
                        streamids, warnings)

            Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()



            Return ArchivoExcelDestino

        End With


    End Function









    Public Function BuscaIdClientePorCUIT(ByVal CUIT As String, ByVal SC As String) As Integer

        If CUIT = "" Then Return -1

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////

        'http://www.codeproject.com/KB/database/SelectQueryBuilder.aspx

        Dim query As New SelectQueryBuilder
        query.SelectFromTable("Clientes")
        query.SelectAllColumns()
        query.TopRecords = 1
        query.AddWhere("CUIT", Enums.Comparison.Equals, CUIT, 1) 'el ultimo parametro es para el OR

        Dim statement = query.BuildQuery()

        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////



        Dim ds = EntidadManager.ExecDinamico(SC, statement)

        If ds.Rows.Count < 1 Then Return -1

        Return ds.Rows(0).Item("IdCliente")
    End Function





    Protected Sub txtQueContenga_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtQueContenga.TextChanged
        AsignaInformeAlReportViewer()
    End Sub





    Sub desc(b As Boolean, reducido As Boolean)
        Dim rs As String
        Try
            rs = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(Session(SESSIONPRONTO_UserId), ConexBDLmaster, HFSC.Value)
        Catch ex As Exception
            'como no encuentro el usuario en la tabla de datos adicionales de la bdlmaster, 
            ' uso el nombre del usuario como razon social que esperaba encontrar en esa dichosa tabla
            ErrHandler2.WriteError(ex)
            rs = Session(SESSIONPRONTO_UserName)
        End Try


        If InStr(rs, "A.C.A") > 0 Then
            'verifica que exista el cliente "A.C.A.LTDA" y que no le hayan cambiado el nombre

            rs = "A.C.A. LTDA"
            If BuscaIdClientePreciso(rs, HFSC.Value) = -1 Then
                MsgBoxAjax(Me, "No existe el cliente: " & rs)
                Exit Sub

            End If
        End If





        If rs <> "" Then
            Dim idcli = BuscaIdClientePreciso(rs, HFSC.Value)
            If idcli = -1 Then
                MsgBoxAjax(Me, "No existe el cliente: " & rs)
                Exit Sub
            End If
        End If




        If chkTitular.Checked Then txtVendedor.Text = rs Else txtVendedor.Text = ""
        If chkIntermediario.Checked Then txtIntermediario.Text = rs Else txtIntermediario.Text = ""
        If chkRemComercial.Checked Then txtRcomercial.Text = rs Else txtRcomercial.Text = ""
        If chkClienteAuxiliar.Checked Then txtClienteAuxiliar.Text = rs Else txtClienteAuxiliar.Text = ""
        If chkCorredor.Checked Then txtCorredor.Text = rs Else txtCorredor.Text = ""
        If chkDestinatario.Checked Then txtEntregador.Text = rs Else txtEntregador.Text = ""



        If Not (chkTitular.Checked Or chkRemComercial.Checked Or chkRemComercial.Checked Or chkCorredor.Checked Or chkDestinatario.Checked Or chkClienteAuxiliar.Checked) Then

            Dim clientes As List(Of String) = TraerCUITClientesSegunUsuario(Membership.GetUser.UserName, HFSC.Value, ConexBDLmaster).Where(Function(x) x <> "").ToList  'c.ToList()
            If clientes.Count = 0 Then
                MsgBoxAjax(Me, "Por lo menos hay que tildar un filtro")
                Exit Sub 'tiene que haber alguno tildado
            Else
                rs = ""
            End If

            '    txtQueContenga.Text = rs
            'Else
            '    txtQueContenga.Text = ""
        End If






        Dim output As String = ""


        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtVendedor.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar '= BuscaIdClientePreciso(chkClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtEntregador.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        'lblRazonSocial.Text






        Dim estadofiltro As CartaDePorteManager.enumCDPestado
        Select Case cmbEstado.Text  '
            Case "TodasMenosLasRechazadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
            Case "Incompletas"
                estadofiltro = CartaDePorteManager.enumCDPestado.Incompletas
            Case "Posición"
                estadofiltro = CartaDePorteManager.enumCDPestado.Posicion
            Case "Descargas"
                estadofiltro = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
            Case "Facturadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.Facturadas
            Case "NoFacturadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.NoFacturadas
            Case "Rechazadas"
                estadofiltro = CartaDePorteManager.enumCDPestado.Rechazadas
            Case "EnNotaCredito"
                estadofiltro = CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito
            Case Else
                Return
        End Select



        Dim idcliente = BuscaIdClientePreciso(rs, HFSC.Value)


        Dim dt As DataTable
        Try

            'dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
            '        "", "", "", 1, 0, _
            '        estadofiltro, rs, idVendedor, idCorredor, _
            '        idDestinatario, idIntermediario, _
            '        idRComercial, idArticulo, idProcedencia, idDestino, _
            '        IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
            '                        DropDownList2.Text, _
            '        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '        cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , , txtQueContenga.Text, idClienteAuxiliar)




            dt = DataTablePorCliente(HFSC.Value, _
                        "", "", "", 1, 0, _
                        estadofiltro, rs, idVendedor, idCorredor, _
                        idDestinatario, idIntermediario, _
                        idRComercial, idArticulo, idProcedencia, idDestino, _
                        IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                        DropDownList2.Text, _
                        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                        cmbPuntoVenta.SelectedValue, txtQueContenga.Text, Membership.GetUser.UserName, ConexBDLmaster, chkTitular.Checked, chkIntermediario.Checked, chkRemComercial.Checked, chkClienteAuxiliar.Checked, chkCorredor.Checked, chkDestinatario.Checked)








            'Catch timeout
            '    adasdad()

        Catch ex As Exception
            '            Log(Entry)
            '04/10/2014 08:57:49
            'Error in: http://prontoclientes.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesAccesoClientes.aspx. Error Message: -  Error 
            '   en ExecDinamico. - System.Data.SqlClient.SqlException: Timeout expired.  The timeout period elapsed prior 
            '   to completion of the operation or the server is not responding.
            '   at Microsoft.VisualBasic.CompilerServices.Symbols.Container.InvokeMethod(Method TargetProcedure, Object[] Arguments, Boolean[] CopyBack, BindingFlags Flags)
            '   at Microsoft.VisualBasic.CompilerServices.NewLateBinding.CallMethod(Container BaseReference, String MethodName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, BindingFlags InvocationFlags, Boolean ReportErrors, ResolutionFailure& Failure)
            '   at Microsoft.VisualBasic.CompilerServices.NewLateBinding.LateCall(Object Instance, Type Type, String MemberName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, Boolean IgnoreReturn)

            MandarMailDeError(ex)
            ErrHandler2.WriteError("Hubo un error al generar el informe. " & ex.ToString)
            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.ToString)
            Return
        End Try





        If dt.Rows.Count = CartaDePorteManager._CONST_MAXROWS Then
            MsgBoxAjax(Me, "Se llegó al máximo de renglones (" & CartaDePorteManager._CONST_MAXROWS & "). Por favor use un filtro más restringido")
        End If


        Try


            If dt.Rows.Count = 1 Then
                If dt.Rows(0).Item("PathImagen").ToString <> "" Then
                    ' lblErrores.Text = "~/ProntoWeb/CartasDePorteImagenEncriptada.aspx?Id=" & dt.Rows(0).Item("ClaveEncriptada")
                    iframeAAAA.Attributes("src") = "CartasDePorteImagenEncriptada.aspx?Id=" & dt.Rows(0).Item("ClaveEncriptada")
                    iframeAAAA.Visible = True
                End If
            Else
                iframeAAAA.Attributes("src") = ""
                iframeAAAA.Visible = False
            End If

        Catch ex As Exception
            Dim ms = ex.ToString & "   " & dt.Rows.Count() & " " & dt.Rows(0).Item("IdCartaDePorte") '& " " & dt.Rows(0).Item("NumeroCDP") 
            MandarMailDeError(ms)
            ErrHandler2.WriteError(ms)

            MsgBoxAjax(Me, ms)
        End Try







        Dim serv
        If System.Diagnostics.Debugger.IsAttached() Then
            serv = "http://localhost:48391/ProntoWeb"
        Else
            serv = "http://prontoclientes.williamsentregas.com.ar/"
        End If

        'RebindReportViewerLINQ("ProntoWeb\Informes\Cartas con Copia sin asignar.rdl", qq, New ReportParameter() {New ReportParameter("sServidor", serv)})




        If Not b Then
            If reducido Then
                output = DescargarImagenesAdjuntas_TIFF(dt, HFSC.Value, True, ConfigurationManager.AppSettings("AplicacionConImagenes"), True)
            Else
                output = DescargarImagenesAdjuntas(dt, HFSC.Value, True, ConfigurationManager.AppSettings("AplicacionConImagenes"))
            End If
        Else
            output = DescargarImagenesAdjuntas_PDF(dt, HFSC.Value, False, ConfigurationManager.AppSettings("AplicacionConImagenes"))
        End If










        If output = "" Then Return

        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then


                'como limitar la velocidad de descarga?
                If False Then
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)

                    Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx

                Else
                    WriteFile(output, "application/octet-stream", 200)
                End If








                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.tostring)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.tostring)
            Return
        End Try


    End Sub


    'http://stackoverflow.com/questions/14076855/how-to-limit-bandwidth-and-allow-multiple-downloads-when-downloading-a-file
    Sub WriteFile(fileName As String, contentType As String, ratekbps As Double)
        Dim _bufferSize As Integer = Math.Round(1024 * ratekbps)
        Dim buffer(_bufferSize) As Byte

        Dim outputStream = Response.OutputStream

        Using Stream = File.OpenRead(fileName)

            'Response.ContentType = "application/octet-stream"
            'Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)

            Response.AddHeader("Cache-control", "private")
            Response.AddHeader("Content-Type", "application/octet-stream")
            Response.AddHeader("Content-Length", Stream.Length.ToString())
            Response.AddHeader("Content-Disposition", String.Format("filename={0}", New FileInfo(fileName).Name))
            Response.Flush()


            While (True)

                If (Not Response.IsClientConnected) Then Exit While

                Dim bytesRead = Stream.Read(buffer, 0, _bufferSize)

                If (bytesRead = 0) Then Exit While

                outputStream.Write(buffer, 0, bytesRead)
                Response.Flush()
                Thread.Sleep(1000) 'tantos bytes por segundo

            End While
        End Using
    End Sub


    Protected Sub btnImagenesPDF_Click(sender As Object, e As EventArgs) Handles btnImagenesPDF.Click
        desc(True, True)
    End Sub


    Protected Sub btnImagenes_Click(sender As Object, e As EventArgs) Handles btnImagenes.Click
        desc(False, False)


    End Sub




    Protected Sub btnImagenesTiffReducido_Click(sender As Object, e As EventArgs) Handles btnImagenesTiffReducido.Click
        desc(False, True)
    End Sub
End Class










