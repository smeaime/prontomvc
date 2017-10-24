Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports System.Data
Imports System.Linq

Imports Microsoft.Reporting.WebForms
Imports ProntoFuncionesGenerales

Imports Pronto.ERP.Bll.SincronismosWilliamsManager
Imports Pronto.ERP.Bll.InformesCartaDePorteManager

Imports System.Xml
Imports System.Collections.Generic

Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports System.Data.SqlClient

Imports CartaDePorteManager

Imports LogicaInformesWilliams
Imports Pronto.ERP.Bll.EntidadManager

Imports System.Web.Services

Partial Class SituacionCalidadMovil
    Inherits System.Web.UI.Page

    Dim bRecargarInforme As Boolean
    Private _sWHERE As Object
    Dim btnTexto As Control
    Private _sincronismo_LosGrobo As String

    Private Property sWHERE As Object
        Get
            Return _sWHERE
        End Get
        Set(ByVal value As Object)
            _sWHERE = value
        End Set
    End Property

    Dim globalDesde As Date
    Dim globalHasta As Date


    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(Session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, Session(SESSIONPRONTO_glbIdObraAsignadaUsuario))

        bRecargarInforme = False

        'Report Viewer Error - Parameter name: panelsCreated[1]   http://ajaxcontroltoolkit.codeplex.com/workitem/26778
        'AjaxControlToolkit.ToolkitScriptManager.ScriptMode = ScriptMode.Release
        'scriptmanager1.


        'If Session(SESSIONPRONTO_UserName) <> "Mariano" Then Button1.Visible = False


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            Me.Title = "Cartas de Porte"

            BindTypeDropDown()


            'refrescaPeriodo()
            cmbPeriodo.Text = "Personalizar"
            'txtFechaDesde.Text = DateAdd(DateInterval.Day, -2, Today)
            'txtFechaHasta.Text = Today
            cmbEstado.Enabled = False



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



            BloqueosDeEdicion()

        End If


        'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(informe)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnExportarGrilla)
        'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpScript1", "$('#Lista').trigger('reloadGrid');", True)

        'AutoCompleteExtender2.ContextKey = HFSC.Value
        AutoCompleteExtender26.ContextKey = HFSC.Value


        txtFechaDesde.Enabled = True
        txtFechaHasta.Enabled = True

    End Sub

    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        'If bRecargarInforme Then AsignaInformeAlReportViewer()
    End Sub










    Private Sub BindTypeDropDown()


        'optDivisionSyngenta.DataTextField = "desc"
        'optDivisionSyngenta.DataValueField = "desc"
        ''optDivisionSyngenta.DataValueField = "idacopio"
        'optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(HFSC.Value).Select(Function(z) New With {z.desc})
        'optDivisionSyngenta.DataBind()


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0
        cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
        cmbPuntoVenta.SelectedIndex = 0

        Try
            If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                BuscaTextoEnCombo(cmbPuntoVenta, pventa)
                If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
    End Sub


    'Protected Sub informe_Click(sender As Object, e As EventArgs) Handles informe.Click

    '    Dim rep = New Microsoft.Reporting.WebForms.ReportViewer()

    '    Dim FechaDesde = New DateTime(1980, 1, 1)
    '    Dim FechaHasta = New DateTime(2050, 1, 1)

    '    Try

    '        FechaDesde = DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", Nothing)
    '    Catch ex As Exception

    '    End Try

    '    Try
    '        FechaHasta = DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", Nothing)

    '    Catch ex As Exception

    '    End Try


    '    'Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
    '    Dim pventa = cmbPuntoVenta.SelectedValue
    '    Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


    '    Dim yourParams As ReportParameter() = New ReportParameter(5) {}

    '    Dim ArchivoExcelDestino As String = Path.GetTempPath & "ControlDiario_" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls"

    '    yourParams(0) = New ReportParameter("CadenaConexion", Encriptar(HFSC.Value))
    '    yourParams(1) = New ReportParameter("sServidorWeb", "kjhkjlh")
    '    yourParams(2) = New ReportParameter("FechaDesde", FechaDesde)
    '    yourParams(3) = New ReportParameter("FechaHasta", FechaHasta)
    '    yourParams(4) = New ReportParameter("IdDestino", idDestino)
    '    yourParams(5) = New ReportParameter("IdPuntoVenta", pventa)
    '    'yourParams(7) = New ReportParameter("Consulta", Sql)



    '    Dim output = CartaDePorteManager.RebindReportViewer_ServidorExcel(rep, _
    '                  "Williams - Controles Diarios.rdl", yourParams, ArchivoExcelDestino, False)


    '    Try
    '        Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
    '        If MyFile1.Exists Then
    '            Response.ContentType = "application/octet-stream"
    '            Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
    '            'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
    '            'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
    '            'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
    '            Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
    '            Response.End()
    '        Else
    '            MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
    '        End If
    '    Catch ex As Exception
    '        'ErrHandler2.WriteAndRaiseError(ex.ToString)
    '        ErrHandler2.WriteError(ex.ToString)
    '        'MsgBoxAjax(Me, ex.ToString)
    '        Return
    '    End Try

    'End Sub





    Sub BloqueosDeEdicion()
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'Bloqueos de edicion
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_ControlDiario)


        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            'TabContainer2.Visible = False
            'lnkNuevo.Visible = False

            MsgBoxAjaxAndRedirect(Me, "No tenés permisos para esta página", String.Format("Principal.aspx"))


        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            'GridView1.Columns(0).Visible = False
            'btnGenerarFacturas.Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            'GridView1.Columns(7).Visible = False
        End If




        Dim a = New String() {"Mariano", "Andres", "hwilliams"}






        '        [02:10:43 p.m.] Mariano Scalella: apuntamelo en una consulta. tengo enel codigo harcodeado q mgarcia y mgarcia2 no pueden ver totales generales. q hago?
        '[02:11:19 p.m.] an78gubad: tengo el ok de hugo, asi que mgarcia y dberzoni tienen que verlo


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////





    End Sub


    Protected Sub cmbPeriodo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodo.SelectedIndexChanged
        refrescaPeriodo()

    End Sub

    Sub refrescaPeriodo()
        txtFechaDesde.Enabled = False
        txtFechaHasta.Enabled = False
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
                txtFechaDesde.Enabled = True
                txtFechaHasta.Enabled = True
        End Select


    End Sub

    Protected Sub LoginStatus1_LoggedOut(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        'FormsAuthentication.RedirectToLoginPage();
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
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////   SINCRONISMOS  //////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////



    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function ExportarGrilla(filters As String, fechadesde As String, fechahasta As String, destino As String) As String

        Dim SC As String
        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim idDestino = BuscaIdWilliamsDestinoPreciso(destino, SC)

        Dim output As String = "\DataBackupear\Listado " + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls"
        Dim fisico As String = ConfigurationManager.AppSettings("DirApp") + output
        Dim url As String = ConfigurationManager.AppSettings("UrlDominio").ToString + output




        Dim ReporteLocal As ReportViewer = New Microsoft.Reporting.WebForms.ReportViewer()


        Dim s = New ServicioCartaPorte.servi()

        Dim sqlquery4 = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, True, filters,
                                             fechadesde,
                                             fechahasta,
                                              -1, idDestino, SC, "Mariano")

        CartaDePorteManager.RebindReportViewer_ServidorExcel(ReporteLocal, "Sincronismo BLD.rdl", sqlquery4, SC, False, fisico)

        Return url
    End Function



    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function ExportarGrillaNormal3(filters As String, fechadesde As String, fechahasta As String, destino As String) As String

        Dim SC As String
        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim idDestino = BuscaIdWilliamsDestinoPreciso(destino, SC)

        Dim output As String = "\DataBackupear\Listado " + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls"
        Dim fisico As String = ConfigurationManager.AppSettings("DirApp") + output
        Dim url As String = ConfigurationManager.AppSettings("UrlDominio").ToString + output




        Dim ReporteLocal As ReportViewer = New Microsoft.Reporting.WebForms.ReportViewer()


        Dim s = New ServicioCartaPorte.servi()

        Dim sqlquery4 = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, True, filters,
                                             fechadesde,
                                             fechahasta,
                                              -1, idDestino, SC, "Mariano")






        Dim yourParams As ReportParameter() = New ReportParameter(9) {}

        yourParams(0) = New ReportParameter("webservice", "")
        yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
        yourParams(2) = New ReportParameter("idArticulo", -1)
        yourParams(3) = New ReportParameter("idDestino", -1)
        yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
        yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
        yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
        yourParams(7) = New ReportParameter("Consulta", sqlquery4)
        yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(SC))
        yourParams(9) = New ReportParameter("titulo", "_")




        RebindReportViewer_ServidorExcel(ReporteLocal,
                     "Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, fisico, False)


        Return url
    End Function



    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function ExportarGrillaNormal(filters As String, fechadesde As String, fechahasta As String, destino As String) As String

        Dim SC As String
        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If


        Dim idDestino = BuscaIdWilliamsDestinoPreciso(destino, SC)

        Dim output As String = "\DataBackupear\Listado " + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls"
        Dim fisico As String = ConfigurationManager.AppSettings("DirApp") + output
        Dim url As String = ConfigurationManager.AppSettings("UrlDominio").ToString + output




        Dim ReporteLocal As ReportViewer = New Microsoft.Reporting.WebForms.ReportViewer()


        Dim s = New ServicioCartaPorte.servi()

        Dim sqlquery4 = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, True, filters,
                                             fechadesde,
                                             fechahasta,
                                              -1, idDestino, SC, "Mariano")



        CartaDePorteManager.RebindReportViewer_ServidorExcel(ReporteLocal, "Carta Porte - Situacion.rdl", sqlquery4, SC, False, fisico)



        'Dim yourParams As ReportParameter() = New ReportParameter(9) {}

        'yourParams(0) = New ReportParameter("webservice", "")
        'yourParams(1) = New ReportParameter("sServidor", ConfigurationManager.AppSettings("UrlDominio"))
        'yourParams(2) = New ReportParameter("idArticulo", -1)
        'yourParams(3) = New ReportParameter("idDestino", -1)
        'yourParams(4) = New ReportParameter("desde", New DateTime(2012, 11, 1)) ' txtFechaDesde.Text)
        'yourParams(5) = New ReportParameter("hasta", New DateTime(2012, 11, 1)) ', txtFechaHasta.Text)
        'yourParams(6) = New ReportParameter("quecontenga", "ghkgk")
        'yourParams(7) = New ReportParameter("Consulta", sqlquery4)
        'yourParams(8) = New ReportParameter("sServidorSQL", Encriptar(SC))
        'yourParams(9) = New ReportParameter("titulo", "_")



        'RebindReportViewer_ServidorExcel(ReporteLocal, "Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, fisico, False)


        Return url
    End Function




    Protected Sub btnExportarGrilla_Click(sender As Object, e As EventArgs) Handles btnExportarGrilla.Click
        'asdfasdf()
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)

        Dim Filtro = ""

        Dim ReporteLocal As ReportViewer = New Microsoft.Reporting.WebForms.ReportViewer()

        Dim output As String = Path.GetTempPath() + "Listado " + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls"

        Dim s = New ServicioCartaPorte.servi()

        'Dim output3 = s.CartasPorte_DynamicGridData_ExcelExportacion("IdCartaDePorte", "desc", 1, 999999, True, Filtro,
        '                                     txtFechaDesde.Text,
        '                                     txtFechaHasta.Text,
        '                                      -1, idDestino, HFSC.Value, "Mariano")

        Dim sqlquery4 = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, True, Filtro,
                                             txtFechaDesde.Text,
                                             txtFechaHasta.Text,
                                              -1, idDestino, HFSC.Value, "Mariano")

        CartaDePorteManager.RebindReportViewer_ServidorExcel(ReporteLocal, "Sincronismo BLD.rdl", sqlquery4, HFSC.Value, False, output)


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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try
    End Sub




    <WebMethod()>
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)>
    Public Shared Function PanelInforme(filters As String, fechadesde As String, fechahasta As String, destino As String) As String

        Dim SC As String
        If Not Diagnostics.Debugger.IsAttached Then
            'SC = Encriptar("Data Source=10.2.64.30;Initial catalog=Williams;User ID=pronto; Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=200")
            SC = Encriptar(scWilliamsRelease())
            'dddddd()
        Else
            SC = Encriptar("Data Source=serversql3;Initial catalog=Williams2;User ID=sa; Password=.SistemaPronto.;Connect Timeout=200")
        End If



        Dim idDestino = BuscaIdWilliamsDestinoPreciso(destino, SC)
        Dim dFechaDesde = New DateTime(1980, 1, 1)
        Dim dFechaHasta = New DateTime(2050, 1, 1)

        Try

            dFechaDesde = DateTime.ParseExact(fechadesde, "dd/MM/yyyy", Nothing)
        Catch ex As Exception

        End Try

        Try
            dFechaHasta = DateTime.ParseExact(fechahasta, "dd/MM/yyyy", Nothing)

        Catch ex As Exception

        End Try


        Dim s = New ServicioCartaPorte.servi()
        'Dim q = s.InformeSituacion_string(idDestino, FechaDesde, FechaHasta, HFSC.Value)
        Dim q As String = s.InformeSituacion_html(idDestino, dFechaDesde, dFechaHasta, SC)



        Return q
    End Function



    Protected Sub btnPanelInforme_Click(sender As Object, e As EventArgs) Handles btnPanelInforme.Click
        'salida = se InformeSituacion()

        '       var s = new ServicioCartaPorte.servi();
        '    var q = s.InformeSituacion();

        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        Dim FechaDesde = New DateTime(1980, 1, 1)
        Dim FechaHasta = New DateTime(2050, 1, 1)

        Try

            FechaDesde = DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", Nothing)
        Catch ex As Exception

        End Try

        Try
            FechaHasta = DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", Nothing)

        Catch ex As Exception

        End Try


        Dim s = New ServicioCartaPorte.servi()
        'Dim q = s.InformeSituacion_string(idDestino, FechaDesde, FechaHasta, HFSC.Value)
        Dim q = s.InformeSituacion_html(idDestino, FechaDesde, FechaHasta, HFSC.Value)
        salida.Text = q

    End Sub
End Class


