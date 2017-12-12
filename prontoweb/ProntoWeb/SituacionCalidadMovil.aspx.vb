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

Imports Pronto.ERP.Bll.BDLmasterPermisosManager.EntidadesPermisos



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




        If Not Request.Browser("IsMobileDevice") = "true" Then
            Response.Redirect("SituacionCalidad.aspx")
        End If




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


        RebindAcordion(sender, e)



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
            If If(EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)), New Pronto.ERP.BO.Empleado()) .PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                BuscaTextoEnCombo(cmbPuntoVenta, pventa)
                If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        If Not (Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsComercial") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsAdmin") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsFacturacion")) Then
            btnsituacion.Visible = False
        End If




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

        Return

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
        FormsAuthentication.RedirectToLoginPage()
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
                                              -1, idDestino, SC, "Mariano", 11)

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

        Dim sqlquery4 As String = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, True, filters,
                                             fechadesde,
                                             fechahasta,
                                              -1, idDestino, SC, "Mariano", 11)






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
                                              -1, idDestino, SC, "Mariano", 11)



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
                                              -1, idDestino, HFSC.Value, "Mariano", 11)

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
        Dim q As String = s.InformeSituacion_html(idDestino, dFechaDesde, dFechaHasta, SC, 11)



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
        Dim q = s.InformeSituacion_html(idDestino, FechaDesde, FechaHasta, HFSC.Value, 11)
        salida.Text = q

    End Sub






    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'Acordion
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Sub RebindAcordion(ByVal sender As Object, ByVal e As System.EventArgs)


        ConfiguracionDeLaEmpresa()



        Dim siteMapView As SiteMapDataSourceView = CType(SiteMapDataSource.GetView(String.Empty), SiteMapDataSourceView)
        Dim nodes As SiteMapNodeCollection = CType(siteMapView.Select(DataSourceSelectArguments.Empty), SiteMapNodeCollection)


        'NodosRequerimientos(nodes)


        '///////////////////////////////////////////////////////


        'Dim Children As SiteMapNodeCollection
        'Dim n As SiteMapNode
        'Children = From n In SiteMap.CurrentNode.ChildNodes.Cast(Of SiteMapNode)() _
        '                    Where n.Url <> "/Registration.aspx" _
        '                    Select n


        '///////////////////////////////////////////////////////


        Accordion1.DataSource = nodes
        Accordion1.DataBind()

        'con SelectedIndex=-1 el acordion cierra solito los panes
        'SelectedIndex=0 es el panel de arriba de todo
        If Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) Is Nothing Then
            Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = -1
        End If

        If Session("SelectedPane") Is Nothing Then
            'panel abierto por default del acordion 

            If True Then
                Session("SelectedPane") = 5
            ElseIf BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(ConexBDLmaster) = "Williams" Then
                Session("SelectedPane") = 5
            Else
                Session("SelectedPane") = 5 '-1
            End If

        End If

        Accordion1.SelectedIndex = Session("SelectedPane")
        If False Then
            If Accordion1.SelectedIndex > -1 And SiteMap.CurrentNode IsNot Nothing Then
                AccordionSiteMap_OpenCurrentPane(sender, e)         'http://forums.asp.net/p/1092148/1921906.aspx
                Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = Accordion1.SelectedIndex
            ElseIf SiteMap.CurrentNode IsNot Nothing Then
                AccordionSiteMap_OpenCurrentPane(sender, e)
                'Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = Accordion1.SelectedIndex
            Else
                If Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) > -1 Then
                    'AccordionSiteMap_OpenCurrentPane(sender, e)
                    Accordion1.SelectedIndex = Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion)
                    Accordion1.SelectedIndex = Session("SelectedPane")
                    'Los problemas son por acá

                Else
                    'cierro los panelcitos
                    Accordion1.SelectedIndex = -1
                End If
                Accordion1.SelectedIndex = Session("SelectedPane")
            End If
        End If

        'ResaltarNodoElegido()


    End Sub



    Protected Sub AccordionSiteMap_OpenCurrentPane(ByVal sender As Object, ByVal e As EventArgs)


        'Debug.Print(SiteMap.RootNode.ChildNodes(0).Title) 'si imprime "FAVORITOS", es que está usando el otro sitemap....

        Dim siteMapView As SiteMapDataSourceView = CType(SiteMapDataSource.GetView(String.Empty), SiteMapDataSourceView)
        Dim nodes As SiteMapNodeCollection = CType(siteMapView.Select(DataSourceSelectArguments.Empty), SiteMapNodeCollection)


        If SiteMap.CurrentNode Is Nothing Then
            Accordion1.SelectedIndex = -1
        Else
            Accordion1.SelectedIndex = RootIndexofCurrentNode(SiteMap.RootNode.ChildNodes)
            'Accordion1.SelectedIndex = RootIndexofCurrentNode(nodes)
        End If
    End Sub



    Private Function RootIndexofCurrentNode(ByVal Nodes As SiteMapNodeCollection) As Short
        'busca el indice del padre del nodo elegido, para poder elegir el panelcito del acordion correspondiente

        Dim index As Short = -2
        If Nodes Is Nothing Then
            RootIndexofCurrentNode = -1
        ElseIf Nodes.Contains(SiteMap.CurrentNode) Then
            RootIndexofCurrentNode = Nodes.IndexOf(SiteMap.CurrentNode)
        Else
            For Each n As SiteMapNode In Nodes
                index = RootIndexofCurrentNode(n.ChildNodes)
                If index <> -1 Then
                    If n.ParentNode.ToString = SiteMap.RootNode.ToString Then
                        Return SiteMap.RootNode.ChildNodes.IndexOf(n)
                    Else
                        Return index
                    End If
                End If
            Next
            Return -1
        End If
    End Function




    Protected Sub Accordion1_DataBound(ByVal sender As Object, ByVal e As AjaxControlToolkit.AccordionItemEventArgs) Handles Accordion1.ItemDataBound
        If CType(e, AjaxControlToolkit.AccordionItemEventArgs).ItemType = AjaxControlToolkit.AccordionItemType.Content Then
            Dim cPanel As AjaxControlToolkit.AccordionContentPanel = e.AccordionItem
            Dim rptr As System.Web.UI.WebControls.Repeater = CType(cPanel.Controls(1), System.Web.UI.WebControls.Repeater)
            Dim sNode As System.Web.SiteMapNode = CType(CType(e, AjaxControlToolkit.AccordionItemEventArgs).AccordionItem.DataItem, System.Web.SiteMapNode)
            Dim childNodes As System.Web.SiteMapNodeCollection = sNode.ChildNodes
            If Not childNodes Is Nothing AndAlso childNodes.Count > 0 Then
                rptr.DataSourceID = Nothing
                rptr.DataSource = childNodes
                rptr.DataBind()
            End If
        End If
    End Sub



    '///////////////////////////////////
    Sub RepeaterItemDataBound(ByVal sender As Object, ByVal e As RepeaterItemEventArgs)
        'http://forums.asp.net/t/1695206.aspx/1

        Dim item As RepeaterItem = e.Item

        Dim node As SiteMapNode = item.DataItem

        Dim hl As HyperLink = e.Item.FindControl("HyperLink2")

        Dim td = e.Item.FindControl("AccordionSideBarItem")
        Dim a = e.Item.FindControl("aLink1")


        'If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
        'DirectCast(e.Item.FindControl("HyperLink1"), HyperLink).ForeColor = System.Drawing.Color.Red
        'End If

        'si una rama se queda sin nodos, tambien hay que volarla


        If HayQueOcultarEsteNodo(hl.NavigateUrl) Then
            e.Item.Visible = False
            Return
        End If



        Dim bEncontro = False
        If Not IsNothing(hl) Then
            If hl.NavigateUrl = Request.Url.PathAndQuery.ToString() Then
                'If InStr(Request.Url.PathAndQuery.ToString(), hl.NavigateUrl) > 0 Then
                'hl.ForeColor = System.Drawing.Color.Red
                'hl.Font.Bold = True

                'hl.BorderStyle = BorderStyle.Solid
                hl.CssClass = "AccordionItemSeleccionado"
                'hl.Style.Add("border", "solid 1px 0px 0px 0px")
                '                text-decoration: none;
                'border-width: 2px;
                'margin: 2px;
                'border-style: solid;
                '}

                Try
                    Debug.Print(item.ItemIndex)
                    Debug.Print(item.Parent.ClientID)
                    Session("SelectedPane") = CInt(TextoEntre(item.Parent.ClientID, "Pane_", "_content"))
                Catch ex As Exception

                End Try

                bEncontro = True
            End If
        End If

        If Not bEncontro Then Accordion1.SelectedIndex = Session("SelectedPane")

        If Not IsNothing(td) Or Not IsNothing(a) Or Not IsNothing(hl) Then
            'Stop
        End If

    End Sub


    Sub RepeaterPreRender(sender As Object, e As System.EventArgs)
        'Repeater()

        'Repeater1.

        ''http://stackoverflow.com/questions/6281559/asp-net-repeater-loop-through-items-in-the-item-template
        ''You would want to do that in the Page PreRender, after the Repeater has been bound.



        'For Each sss


        'Next

        'Dim item As RepeaterItem = e.Item

    End Sub

    Sub AccordionPreRender(sender As Object, e As System.EventArgs)

        'oculto el panel si no tiene nodos

        For Each p In Accordion1.Panes
            Debug.Print(p.Visible)
            'Debug.Print(p.ContentContainer.Controls.Count)
            Dim n As SiteMapNode = p.ContentContainer.DataItem
            Debug.Print(n.Title)
            Debug.Print(n.ChildNodes.Count)
            If n.ChildNodes.Count <= 0 Then p.Visible = False
        Next



    End Sub



    Function HayQueOcultarEsteNodo(ByVal url As String) As Boolean

        Try
            If Session(SESSIONPRONTO_UserId) Is Nothing Then Return True


            If InStr(url, "CartaDePorteAnalisisTarifa.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), CDPs_InfAnalisisTarifa)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If


            If InStr(url, "CartaDePorteInformesGerenciales.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), CDPs_InfGerenciales)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If



            If InStr(url, "CDPFacturacion.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), CDPs_Facturacion)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "Facturas.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), Facturas)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "ListasPrecios.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), Listas_de_Precios)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "Vendedores.aspx") Then
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), Vendedores)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Clientes.aspx") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Clientes)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If


            If InStr(url, "/Obra") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Obras)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Requerimiento") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Requerimientos)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Articulo") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Artículos)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If


            If InStr(url, "/Unidad") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Unidades)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

            If InStr(url, "/Sector") Then 'si sacas la "/", tambien vuela el accesoinformesclientes.aspx
                Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Sectores)
                If Not p("PuedeLeer") Then
                    Return True
                End If
            End If

        Catch ex As Exception

        End Try

        Return False
    End Function



    Sub ConfiguracionDeLaEmpresa()
        Try

            Dim Usuario = New Usuario
            Usuario = Session(SESSIONPRONTO_USUARIO)


            'LogoImage.ImageUrl = BDLMasterEmpresasManagerMigrar.SetLogoImage_MasterPage(Usuario)
            SiteMapDataSource.SiteMapProvider = BDLMasterEmpresasManagerMigrar.SetSiteMap(Usuario)


        Catch ex As Exception

            ErrHandler.WriteError(ex)
        End Try

    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'fin del Acordion
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

End Class


