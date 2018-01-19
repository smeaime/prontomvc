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

Imports LogicaInformesWilliamsGerenc
Imports Pronto.ERP.Bll.EntidadManager


Partial Class CartaDePorteBuscador
    Inherits System.Web.UI.Page

    Dim bRecargarInforme As Boolean
    Private _sWHERE As Object

    Private Property sWHERE As Object
        Get
            Return _sWHERE
        End Get
        Set(ByVal value As Object)
            _sWHERE = value
        End Set
    End Property

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

        Dim a = New String() {"Mariano", "Andres", "hwilliams"}
        If Session(SESSIONPRONTO_UserName) <> "Mariano" Then Button1.Visible = False




        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            Me.Title = "Informes"

            BindTypeDropDown()
            refrescaPeriodo()



            BloqueosDeEdicion()

        End If





        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnRefrescar)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnDescargaSincro)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnExcel)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnTexto)

        AutoCompleteExtender2.ContextKey = HFSC.Value
        AutoCompleteExtender21.ContextKey = HFSC.Value
        AutoCompleteExtender24.ContextKey = HFSC.Value
        AutoCompleteExtender25.ContextKey = HFSC.Value
        AutoCompleteExtender26.ContextKey = HFSC.Value
        AutoCompleteExtender27.ContextKey = HFSC.Value
        AutoCompleteExtender3.ContextKey = HFSC.Value
        AutoCompleteExtender4.ContextKey = HFSC.Value
        AutoCompleteExtender11.ContextKey = HFSC.Value

    End Sub

    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        'If bRecargarInforme Then AsignaInformeAlReportViewer()
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

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_Facturacion)


        Dim a = New String() {"Mariano", "Andres", "hwilliams"}
        If Not a.Contains(Session(SESSIONPRONTO_UserName).ToString) Then
            MsgBoxAjaxAndRedirect(Me, "No tenés acceso a esta página", String.Format("Principal.aspx"))
            Exit Sub
        End If


        'If Not p("PuedeLeer") Then
        If Not a.Contains(Session(SESSIONPRONTO_UserName)) Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(


            'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8918
            '            Ranking de Cereales
            'Ranking de Clientes
            'Proyeccion de Facturacion
            'Totales Grales por Mes
            'Resumen de Facturacion
            cmbInforme.Items.FindByText("Ranking de Cereales").Enabled = False
            cmbInforme.Items.FindByText("Ranking de Clientes").Enabled = False
            cmbInforme.Items.FindByText("Proyección de facturación").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes").Enabled = False
            cmbInforme.Items.FindByText("Cartas Duplicadas").Enabled = False
            cmbInforme.Items.FindByText("Resumen de facturación").Enabled = False

            cmbInforme.Items.FindByText("Estadísticas de Toneladas descargadas (Modo-Sucursal)").Enabled = False
            cmbInforme.Items.FindByText("Estadísticas de Toneladas descargadas (Sucursal-Modo)").Enabled = False
            cmbInforme.Items.FindByText("Volumen de Carga").Enabled = False
            cmbInforme.Items.FindByText("Diferencias por Destino por Mes").Enabled = False

            cmbInforme.Items.FindByText("Totales generales por mes").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes por sucursal").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes por modo y sucursal").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes por modo").Enabled = False
        End If




        Dim l = New String() {"Mariano", "Andres", "hwilliams", "factbsas", "factas", "factbb", "factbsas", "factsl", "cflores", "lcesar", "dberzoni", "mgarcia"}
        If Not l.Contains(Session(SESSIONPRONTO_UserName)) Then
            cmbInforme.Items.FindByText("Liquidación de Subcontratistas").Enabled = False
            ' cmbInforme.Items(13).Enabled = False 'liquidacion de subcontratistas
        End If


        Dim ff = New String() {"mgarcia", "mgarcia2"}
        If ff.Contains(Session(SESSIONPRONTO_UserName)) Then
            cmbInforme.Items.FindByText("Totales generales por mes").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes por sucursal").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes por modo y sucursal").Enabled = False
            cmbInforme.Items.FindByText("Totales generales por mes por modo").Enabled = False
        End If


        '        [02:10:43 p.m.] Mariano Scalella: apuntamelo en una consulta. tengo enel codigo harcodeado q mgarcia y mgarcia2 no pueden ver totales generales. q hago?
        '[02:11:19 p.m.] an78gubad: tengo el ok de hugo, asi que mgarcia y dberzoni tienen que verlo

        'Dim ffa = New String() {"mgarcia", "dberzoni", "lcesar", "mcabrera", "cflores", "Mariano"}
        'If ffa.Contains(Session(SESSIONPRONTO_UserName)) Then
        '    cmbInforme.Items.FindByText("Totales generales por mes").Enabled = True
        'End If




        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////





    End Sub


    Protected Sub btnExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExcel.Click
        Dim output As String


        AsignaInformeAlReportViewer(True)

        'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
        'sacaColumnas(dt)
        'RebindReportViewerExcel("ProntoWeb\Informes\Descargas por Titular - Detallado.rdl", DataTableWHERE(dt, generarWHERE()), Nothing, output)


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













    Public Sub WriteToXmllocal(ByVal xmlFileName As String, ByVal connectionString As String, ByVal comando As String)
        '  http://stackoverflow.com/questions/1473806/net-system-outofmemoryexception-filling-a-datatable
        'http://stackoverflow.com/questions/356645/exception-of-type-system-outofmemoryexception-was-thrown-why
        Dim writer As XmlWriter
        writer = XmlWriter.Create(xmlFileName)

        Dim myConnection As SqlConnection = New SqlConnection(Encriptar(connectionString))


        Dim myCommand As SqlCommand
        myCommand = New SqlCommand(comando, myConnection)
        'If timeoutSegundos <> 0 Then myCommand.CommandTimeout = timeoutSegundos
        myCommand.CommandType = CommandType.Text


        Response.ContentType = "application/octet-stream"
        Response.AddHeader("Content-Disposition", "attachment; filename=" & xmlFileName)

        Try
            myConnection.Open()

            Dim reader As SqlDataReader
            reader = myCommand.ExecuteReader()

            While reader.Read()
                Dim s = reader(0) & "," & reader(1) & "," & reader(2) & "," & reader(3) & vbCrLf
                writer.WriteRaw(s)
                Response.Write(s)
            End While





            'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
            'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
            'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
            'Response.TransmitFile(xmlFileName) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
            Response.End()

        Catch ex As Exception
            Throw
        Finally
            myConnection.Close()
            myConnection.Dispose()
        End Try
    End Sub


    Protected Sub cmbInforme_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbInforme.SelectedIndexChanged
        bRecargarInforme = True

        habilitarFiltros()


        AsignaInformeAlReportViewer()
        'ReBind()
        'TraerResumenDeCuentaFF()
    End Sub

    Sub habilitarFiltros()
        txtTitular.Enabled = True
        txtCorredor.Enabled = True
        txtIntermediario.Enabled = True
        txtProcedencia.Enabled = True
        txtRcomercial.Enabled = True
        txtPopClienteAuxiliar.Enabled = True
        txtIntermediario.Enabled = True
        DropDownList2.Enabled = True



        If cmbInforme.Text = "Notas de entrega (a matriz de puntos)" Then
            cmbEstado.Text = "Descargas" 'solo mostrar descargas+facturadas
            cmbEstado.Enabled = False
        Else
            cmbEstado.Enabled = True
        End If


        If cmbInforme.Text = "Ranking de Clientes" Then
            lblTopClientes.Visible = True
            lblMinimoNeto.Visible = True
            txtTopClientes.Visible = True
            txtMinimoNeto.Visible = True
        Else
            lblTopClientes.Visible = False
            lblMinimoNeto.Visible = False
            txtTopClientes.Visible = False
            txtMinimoNeto.Visible = False
        End If


        If cmbInforme.Text = "Planilla de movimientos" Then
            txtTitular.Text = ""
            txtTitular.Enabled = False

            txtCorredor.Text = ""
            txtCorredor.Enabled = False

            txtIntermediario.Text = ""
            txtIntermediario.Enabled = False

            txtProcedencia.Text = ""
            txtProcedencia.Enabled = False

            txtRcomercial.Text = ""
            txtRcomercial.Enabled = False

            txtPopClienteAuxiliar.Text = ""
            txtPopClienteAuxiliar.Enabled = False

            txtIntermediario.Text = ""
            txtIntermediario.Enabled = False

            DropDownList2.Enabled = False
            DropDownList2.Text = "Export"

            If System.Diagnostics.Debugger.IsAttached() Then
                txtDestino.Text = "JAUREGUI BS AS"
                txtDestinatario.Text = "J. H. SRL"
                txt_AC_Articulo.Text = "SORGO GRANIFERO"
            End If

        End If
    End Sub







    Private Sub BindTypeDropDown()
        optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(HFSC.Value)
        optDivisionSyngenta.DataBind()


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0
        cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
        cmbPuntoVenta.SelectedIndex = 0

        If If(EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)), New Pronto.ERP.BO.Empleado()) .PuntoVentaAsociado > 0 Then
            Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
            BuscaTextoEnCombo(cmbPuntoVenta, pventa)
            If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
        End If

    End Sub


    Sub AsignaInformeAlReportViewer(Optional ByVal bDescargaExcel As Boolean = False)
        Dim output As String = ""


        ErrHandler2.WriteError("Generando informe para " & cmbInforme.Text)


        ReportViewer2.Visible = True

        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        If txtFechaDesde.Text <> "" And iisValidSqlDate(txtFechaDesde.Text) Is Nothing Then
            MsgBoxAlert("La fecha inicial es inválida")
        End If

        If txtFechaHasta.Text <> "" And iisValidSqlDate(txtFechaHasta.Text) Is Nothing Then
            MsgBoxAlert("La fecha final es inválida")
        End If





        If cmbInforme.Text = "Notas de entrega (a matriz de puntos)" Then cmbEstado.Text = "Descargas" 'solo mostrar descargas+facturadas


        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7789





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




        If cmbInforme.Text = "Planilla de movimientos" And (idArticulo = -1 Or idDestino = -1 Or idDestinatario = -1) Then
            'ReportViewer2.
            ReportViewer2.LocalReport.DataSources.Clear()
            MsgBoxAjax(Me, "Para la planilla de movimientos, debe especificar el Destinatario, el Puerto, y el Producto")
            Exit Sub
        End If




        '        Log(Entry)
        '04/30/2014 12:23:43
        'Error in: https://prontoweb.williamsentregas.com.ar/Reserved.ReportViewerWebControl.axd?Culture=1033&CultureOverrides=True&UICulture=1033&UICultureOverrides=True&ReportStack=1&ControlID=a8a94618cdb24ea6886776d994363370&Mode=true&OpType=Export&FileName=Totales+por+Mes&ContentDisposition=OnlyHtmlInline&Format=PDF. 
        ' Error Message : Microsoft.ReportingServices.ReportProcessing.ReportProcessingException()
        'An unexpected error occurred in Report Processing.
        '   at Microsoft.ReportingServices.ReportProcessing.ReportProcessing.RenderFromOdpSnapshot(IRenderingExtension newRenderer, String streamName, ProcessingContext pc, RenderingContext rc)
        '   at Microsoft.ReportingServices.ReportProcessing.ReportProcessing.RenderSnapshot(IRenderingExtension newRenderer, RenderingContext rc, ProcessingContext pc)
        '   at Microsoft.Reporting.LocalService.Render(CatalogItemContextBase itemContext, Boolean allowInternalRenderers, ParameterInfoCollection reportParameters, IEnumerable dataSources, DatasourceCredentialsCollection credentials, CreateAndRegisterStream createStreamCallback, ReportRuntimeSetup runtimeSetup)
        '   at Microsoft.Reporting.WebForms.LocalReport.InternalRender(String format, Boolean allowInternalRenderers, String deviceInfo, PageCountMode pageCountMode, CreateAndRegisterStream createStreamCallback, Warning[]& warnings)
        '        Microsoft.ReportViewer.Common()



        'chilló cuando quiso convertirlo a pdf????



        sTitulo = ""

        Dim dt As DataTable

        Try
            If cmbInforme.Text <> "Resumen de facturación" And _
                cmbInforme.Text <> "Totales generales por mes" And _
                cmbInforme.Text <> "Totales generales por mes por modo" And _
                cmbInforme.Text <> "Totales generales por mes por sucursal" And _
                cmbInforme.Text <> "Cartas Duplicadas" And _
                cmbInforme.Text <> "Ranking de Cereales" And _
                cmbInforme.Text <> "Ranking de Clientes" And _
                cmbInforme.Text <> "Diferencias por Destino por Mes" And _
                 cmbInforme.Text <> "Cartas Duplicadas pendientes de asignar" And _
                cmbInforme.Text <> "Liquidación de Subcontratistas" Then
                dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                "", "", "", 1, 0, _
                                estadofiltro, "", idVendedor, idCorredor, _
                                idDestinatario, idIntermediario, _
                                idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text, , idClienteAuxiliar, -1, Val(txtVagon.Text), txtPatente.Text, )


            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            ErrHandler2.WriteError(sTitulo)
            MandarMailDeError("Qué hacemos con los timeout?  " + ex.ToString)
            'ErrHandler2.WriteErrorYMandarMail(sTitulo)
            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.ToString & " " & " Filtro usado: " & sTitulo)

            '        Log(Entry)
            '01/08/2014 10:04:57
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:  Informe: Todas (menos las rechazadas),  del 01/12/2013 al 31/12/2013       Destino: FABRICA VICENTIN    (Exporta: Entregas, Punto de venta: Todos, Criterio: ALGUNOS)
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:05:46
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message: -  Error en ExecDinamico. - Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding. -   SELECT TOP 15000  CDP.*, 			cast (cdp.NumeroCartaDePorte as varchar) +					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						ELSE             ''            End				as NumeroCompleto,			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT, 			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,             isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 			choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,        isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,           isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		Calidades.Descripcion AS CalidadDesc, 					E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS as EstablecimientoDesc, 			isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,          isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido    FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  WHERE 1=1              AND CDP.Destino=34 AND ISNULL(CDP.Anulada,'NO')<>'SI'    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '17530101'     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '21000101'  and EXISTS ( SELECT * FROM CartasDePorte COPIAS  where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon    AND ISNULL(COPIAS.Exporta,'NO')='NO'    )  AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  AND ISNULL(CDP.Anulada,'NO')<>'SI'
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:05:46
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:05:46
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:Error en GetDataTableFiltradoYPaginado. Probable timeout.         ver si el error es de system memory o de report processing, recomendar reinicio del IIS por las sesiones con basura. Incluir sp_who2. Filtro: Todas (menos las rechazadas),          Destino: FABRICA VICENTIN    (Exporta: Entregas, Punto de venta: Todos, Criterio: ALGUNOS)Error: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:05:46
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:System.ApplicationException
            'WriteAndRaiseError: Error en GetDataTableFiltradoYPaginado. Probable timeout.         ver si el error es de system memory o de report processing, recomendar reinicio del IIS por las sesiones con basura. Incluir sp_who2. Filtro: Todas (menos las rechazadas),          Destino: FABRICA VICENTIN    (Exporta: Entregas, Punto de venta: Todos, Criterio: ALGUNOS)Error: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
            '   at ErrHandler2.WriteAndRaiseError(String errorMessage) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 143
            '   at CartaDePorteManager.GetDataTableFiltradoYPaginado(String SC, String ColumnaParaFiltrar, String TextoParaFiltrar, String sortExpression, Int64 startRowIndex, Int64 maximumRows, enumCDPestado estado, String QueContenga, Int32 idVendedor, Int32 idCorredor, Int32 idDestinatario, Int32 idIntermediario, Int32 idRemComercial, Int32 idArticulo, Int32 idProcedencia, Int32 idDestino, FiltroANDOR AplicarANDuORalFiltro, String ModoExportacion, DateTime fechadesde, DateTime fechahasta, Int32 puntoventa, String& sTituloFiltroUsado, String optDivisionSyngenta, Boolean bTraerDuplicados, String Contrato, String QueContenga2, Int32 idClienteAuxiliar, Int32 AgrupadorDeTandaPeriodos, Int32 Vagon, String Patente)
            '   at CartaDePorteInformesConReportViewerSincronismos.AsignaInformeAlReportViewer(Boolean bDescargaExcel)
            '        BusinessObject()
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:05:46
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:Todas (menos las rechazadas),          Destino: FABRICA VICENTIN    (Exporta: Entregas, Punto de venta: Todos, Criterio: ALGUNOS)
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:06:20
            '. Error Message:Cache item callback: 1/8/2014 10:06:20 AM
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:06:20
            '. Error Message:hit page: http://prontoweb.williamsentregas.com.ar/TestCacheTimeout/WebForm1.aspx
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:06:20
            '. Error Message:Llamada a mailloopwork: 1/8/2014 10:06:20 AM xusv*8hautv4hcqj>~T%ynbEvj`tusvjwqO_njAnuzdS
            'dvu(%jPcLT*pvctegusO^wvCwmQgawTxwihMtb`;mzwgrcO=z
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:06:29
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message:Generando informe para Listado general de cartas de porte (con imagen)
            '        __________________________()

            '        Log(Entry)
            '01/08/2014 10:06:42
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. Error Message: GetListDataTableDinamicoConWHERE_2 llegó al máximo de renglones    SELECT TOP 15000  CDP.*, 			cast (cdp.NumeroCartaDePorte as varchar) +					CASE WHEN cdp.numerosubfijo<>0 OR cdp.subnumerovagon<>0 THEN            '  ' + cast (cdp.numerosubfijo as varchar) + '/' +cast (cdp.subnumerovagon as varchar) 						ELSE             ''            End				as NumeroCompleto,			datediff(minute,cdp.FechaModificacion,GETDATE()) as MinutosModifico,  			ISNULL(Articulos.AuxiliarString5,'') AS EspecieONCAA,	  			ISNULL(Articulos.AuxiliarString6,'') AS CodigoSAJPYA,	  			ISNULL(Articulos.AuxiliarString7,'') AS txtCodigoZeni,	 			isnull(CLIVEN.Razonsocial,'') AS TitularDesc,             isnull(CLIVEN.cuit,'') AS TitularCUIT, 			isnull(CLICO1.Razonsocial,'') AS IntermediarioDesc,             isnull(CLICO1.cuit,'') AS IntermediarioCUIT, 			isnull(CLICO2.Razonsocial,'') AS RComercialDesc,             isnull(CLICO2.cuit,'') AS RComercialCUIT, 			isnull(CLICOR.Nombre,'') AS CorredorDesc,             isnull(CLICOR.cuit,'') AS CorredorCUIT, 			isnull(CLIENT.Razonsocial,'') AS DestinatarioDesc, 			isnull(CLIENTREG.Razonsocial,'') AS EntregadorDesc,             isnull(CLIENT.cuit,'') AS DestinatarioCUIT, 			isnull(CLIAUX.Razonsocial,'') AS ClienteAuxiliarDesc, 			isnull(CLISC1.Razonsocial,'') AS Subcontr1Desc,             isnull(CLISC2.Razonsocial,'') AS Subcontr2Desc,              isnull(Articulos.Descripcion,'') AS Producto, 			 Transportistas.cuit as  TransportistaCUIT,             isnull(Transportistas.RazonSocial,'') AS TransportistaDesc, 			choferes.cuil as  ChoferCUIT, 			choferes.Nombre as  ChoferDesc,            isnull(LOCORI.Nombre,'') AS ProcedenciaDesc, 		isnull(LOCORI.CodigoPostal,'') AS ProcedenciaCodigoPostal, 		isnull(LOCORI.CodigoONCAA,'') AS ProcedenciaCodigoONCAA,            isnull(PROVORI.Nombre,'') AS ProcedenciaProvinciaDesc,        isnull(LOCDES.Descripcion,'') AS DestinoDesc,             '' AS  DestinoCodigoPostal, 			isnull(LOCDES.codigoONCAA,'') AS  DestinoCodigoONCAA,            DATENAME(month, FechaDescarga) AS Mes,           DATEPART(year, FechaDescarga) AS Ano,        	FAC.TipoABC + '-' + CAST(FAC.PuntoVenta AS VARCHAR) + '-' + CAST(FAC.NumeroFactura AS VARCHAR) AS Factura,            FAC.FechaFactura,           isnull(CLIFAC.RazonSocial,'') AS ClienteFacturado,          isnull(CLIFAC.cuit,'') AS ClienteFacturadoCUIT, 		Calidades.Descripcion AS CalidadDesc, 					E1.Nombre as UsuarioIngreso,isnull(ESTAB.Descripcion,'') COLLATE SQL_Latin1_General_CP1_CI_AS +' '+ isnull(ESTAB.AuxiliarString1,'') COLLATE SQL_Latin1_General_CP1_CI_AS+ ' '+ isnull(ESTAB.AuxiliarString2,'') COLLATE SQL_Latin1_General_CP1_CI_AS as EstablecimientoDesc, 			isnull(CLIENTFLET.Razonsocial,'') AS ClientePagadorFleteDesc ,          isnull(LOCORI.Partido,'') AS ProcedenciaProvinciaPartido    FROM    CartasDePorte CDP           LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente        LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente        LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente        LEFT OUTER JOIN Clientes CLIAUX ON CDP.IdClienteAuxiliar= CLIAUX.IdCliente        LEFT OUTER JOIN Clientes CLIENTREG ON CDP.IdClienteEntregador= CLIENTREG.IdCliente        LEFT OUTER JOIN Clientes CLIENTFLET ON CDP.IdClientePagadorFlete= CLIENTFLET.IdCliente        LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor        LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente         LEFT OUTER JOIN Clientes CLISC1 ON CDP.Subcontr1 = CLISC1.IdCliente          LEFT OUTER JOIN Clientes CLISC2 ON CDP.Subcontr2 = CLISC2.IdCliente          LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo           LEFT OUTER JOIN Calidades ON CDP.CalidadDe = Calidades.IdCalidad            LEFT OUTER JOIN Transportistas ON CDP.IdTransportista = Transportistas.IdTransportista 			LEFT OUTER JOIN Choferes ON CDP.IdChofer = Choferes.IdChofer            LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad            LEFT OUTER JOIN Provincias PROVORI ON LOCORI.IdProvincia = PROVORI.IdProvincia            LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino            LEFT OUTER JOIN CDPEstablecimientos ESTAB ON CDP.IdEstablecimiento = ESTAB.IdEstablecimiento             LEFT OUTER JOIN Facturas FAC ON CDP.idFacturaImputada = FAC.IdFactura             LEFT OUTER JOIN Clientes CLIFAC ON CLIFAC.IdCliente = FAC.IdCliente   LEFT OUTER JOIN Empleados E1 ON CDP.IdUsuarioIngreso = E1.IdEmpleado  WHERE 1=1  AND ISNULL(CDP.Anulada,'NO')<>'SI'    AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') >= '20131001'     AND isnull(isnull(FechaDescarga, FechaArribo),'1/1/1753') <= '20131201'  and EXISTS ( SELECT * FROM CartasDePorte COPIAS  where COPIAS.NumeroCartaDePorte=CDP.NumeroCartaDePorte and COPIAS.SubnumeroVagon=CDP.SubnumeroVagon    AND ISNULL(COPIAS.Exporta,'NO')='NO'    )  AND ISNULL(CDP.SubnumeroDeFacturacion, 0) <= 0  AND ISNULL(CDP.Anulada,'NO')<>'SI'
            '        __________________________()

            Return
        End Try







        Dim sWHERE = ""
        'Dim sWHERE As String = CartaDePorteManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
        '                            sTitulo, _
        '                            estadofiltro, "", idVendedor, idCorredor, _
        '                            idDestinatario, idIntermediario, _
        '                            idRComercial, idArticulo, idProcedencia, idDestino, _
        '                            "1", DropDownList2.Text, _
        '                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
        '                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
        '                            cmbPuntoVenta.SelectedValue)




        Try

            Select Case cmbInforme.Text

                Case "Listado general de cartas de porte (con imagen)"

                    'MsgBoxAjax(Me, "Listo")
                    'Exit Sub
                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl", _
                                        dt, Nothing, , , sTitulo)


                Case "Listado general de cartas de porte + copias"

                    dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                             "", "", "", 1, 0, _
                             estadofiltro, "", idVendedor, idCorredor, _
                             idDestinatario, idIntermediario, _
                             idRComercial, idArticulo, idProcedencia, idDestino, _
                                                               IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                              Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                             Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                              cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar, , , , )

                    sTitulo = "Incluyendo Duplicados. " + sTitulo
                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", _
                                        dt, Nothing, , , sTitulo)

                Case "Listado general de cartas de porte sin copias ni originales copiados"

                    dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                             "", "", "", 1, 0, _
                             estadofiltro, "", idVendedor, idCorredor, _
                             idDestinatario, idIntermediario, _
                             idRComercial, idArticulo, idProcedencia, idDestino, _
                                                               IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                              Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                             Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                              cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar, , , , )


                    sTitulo = "Solo originales sin copia. " + sTitulo
                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", _
                                        dt, Nothing, , , sTitulo)



                Case "Notas de entrega (a matriz de puntos)"

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7789


                    'solo mostrar descargas+facturadas


                    'Acá genero un excel
                    AgruparYPaginarOrdenandoPorNumeroDeCarta(dt)

                    output = RebindReportViewerTexto("ProntoWeb\Informes\Notas de entrega (a impresora de matriz de puntos).rdl", dt)
                    ErrHandler2.WriteError(dt.Rows.Count & " lineas exportando a excel de Notas de entrega")

                    'y acá tomo el excel y lo transformo en el txt para la EPSON
                    output = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextNotasDeEntrega(output)

                Case "Notas de entrega (a laser)"
                    RebindReportViewer("ProntoWeb\Informes\Notas de entrega (a laser).rdl", dt)


                Case "Descargas por Titular compactado"
                    'TraerDataset = NotasDeEntrega()

                    '//LINQ - Strongly Typed DataSet
                    '                DataRow(row = ds.Customers.AsEnumerable())
                    '     .Where(i => i.CustID == 4)
                    '     .FirstOrDefault();

                    '//DataTable Example
                    'DataRow row = customers.Select("CustID = 4")[0];

                    ' Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
                    RebindReportViewer("ProntoWeb\Informes\Descargas por Titular - Compactado.rdl", ProntoFuncionesGenerales.DataTableWHERE(dt, sWHERE))


                Case "Descargas por Titular detallado"
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    RebindReportViewer("ProntoWeb\Informes\Descargas por Titular - Detallado.rdl", DataTableWHERE(dt, sWHERE))


                Case "Descargas por Corredor compactado"
                    'TraerDataset = DescargasPorCorredorDetallado()
                    ' Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
                    RebindReportViewer("ProntoWeb\Informes\Descargas por Corredor - Compactado.rdl", DataTableWHERE(dt, sWHERE))

                Case "Descargas por Corredor detallado"
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
                    RebindReportViewer("ProntoWeb\Informes\Descargas por Corredor - Detallado.rdl", DataTableWHERE(dt, sWHERE))

                Case "Descargas por Contrato compactado"
                    'TraerDataset = DescargasPorContratoDetallado()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    RebindReportViewer("ProntoWeb\Informes\Descargas por Contrato - Compactado.rdl", ProntoFuncionesGenerales.DataTableWHERE(dt, sWHERE))

                Case "Descargas por Contrato detallado"
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    RebindReportViewer("ProntoWeb\Informes\Descargas por Contrato - Detallado.rdl", ProntoFuncionesGenerales.DataTableWHERE(dt, sWHERE))

                Case "Totales generales por puerto"
                    'TraerDataset = DescargasPorContratoDetallado()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesCorregido", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    RebindReportViewer("ProntoWeb\Informes\Descargas por Destino-Articulo.rdl", ProntoFuncionesGenerales.DataTableWHERE(dt, sWHERE))


                Case "Totales generales por mes"
                    'TraerDataset = TotalesPorMes()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    totpormes()

                Case "Totales generales por mes por sucursal"
                    'TraerDataset = TotalesPorMes()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    'CartaDePorteManager.
                    totpormessucursal()
                Case "Totales generales por mes por modo"
                    'TraerDataset = TotalesPorMes()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    'CartaDePorteManager.
                    totpormesmodo()
                Case "Totales generales por mes por modo y sucursal"
                    totpormesmodoysucursal()


                Case "Estadísticas de Toneladas descargadas (Sucursal-Modo)"

                    ' estadsucmodo()
                Case "Estadísticas de Toneladas descargadas (Modo-Sucursal)"
                    'estadmodosuc()
                Case "Volumen de Carga"
                    'VolumenCarga()

                Case "Diferencias por Destino por Mes"
                    'DiferenciasPorDestino()

                Case "Cartas Duplicadas"
                    'TraerDataset = TotalesPorMes()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    CartasDuplicadas()


                Case "Taras por Camiones"



                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
                    If True Then
                        RebindReportViewer("ProntoWeb\Informes\Taras por Titular.rdl", dt)
                    Else


                        ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                    "ProntoWeb\Informes\Taras por Titular.rdl", _
                                            dt, Nothing, , , sTitulo)

                    End If

                Case "Totales por puerto y por fábrica" 'qué dif con destino/articulo?
                    Dim sWHERE2 As String = CartaDePorteManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
                                                sTitulo, _
                                                estadofiltro, "", idVendedor, idCorredor, _
                                                idDestinatario, idIntermediario, _
                                                idRComercial, idArticulo, idProcedencia, idDestino, _
                                                "1", DropDownList2.Text, _
                                                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                                cmbPuntoVenta.SelectedValue, , , , , idClienteAuxiliar)
                    sWHERE2 = sWHERE2.Replace("CDP.", "")
                    Dim dta = InformesCartaDePorteManager.TotalesPorDestinos(HFSC.Value)
                    RebindReportViewer("ProntoWeb\Informes\Valorizado por SubContratista.rdl", ProntoFuncionesGenerales.DataTableWHERE(dta, sWHERE2))
                    'la primera, algunos destinos no son puertos si no que son fabricas, no se porque hacen la diferencia
                    'no, es todo lo mismo, son todos destinos, simplemente le pusieron ese nombre



                Case "Planilla de movimientos"

                    'MsgBoxAjax(Me, "No hay movimientos para mostrar")
                    'Return




                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7977


                    Dim dtMOVs, dt2 As Object
                    Dim dtCDPs As DataTable

                    txtTitular.Text = ""
                    txtTitular.Enabled = False

                    txtCorredor.Text = ""
                    txtCorredor.Enabled = False

                    txtIntermediario.Text = ""
                    txtIntermediario.Enabled = False

                    txtProcedencia.Text = ""
                    txtProcedencia.Enabled = False

                    txtRcomercial.Text = ""
                    txtRcomercial.Enabled = False
                    txtPopClienteAuxiliar.Text = ""
                    txtPopClienteAuxiliar.Enabled = False
                    txtIntermediario.Text = ""
                    txtIntermediario.Enabled = False

                    DropDownList2.Enabled = False
                    DropDownList2.Text = "Export"

                    Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
                    Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
                    ' llamada al informe de movimientos, calculo existencias

                    '////////////////////////////////////////////////////




                    If idArticulo = -1 Or idDestino = -1 Or idDestinatario = -1 Then
                        'ReportViewer2.
                        ReportViewer2.LocalReport.DataSources.Clear()
                        MsgBoxAjax(Me, "Para la planilla de movimientos, debe especificar el Destinatario, el Puerto, y el Producto")
                        Exit Sub
                    End If


                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10263  rechazadas están saliendo en el informe de existencias
                    'no tengo que incluir los rechazos!
                  

                    Movimientos_RebindReportViewer("ProntoWeb\Informes\Movimientos.rdl", dtCDPs, dt2, dtMOVs, _
                                                  fechadesde, fechahasta, idDestino, idArticulo, idDestinatario)


                Case "Resumen de facturación"

                    ResumenFacturacion()




                Case "Proyección de facturación"

                    ProyeccionFacturacion()




                Case "Listado de Tarifas"
                    listadoTarifas()





                Case "Ranking de Cereales"
                    'rankcereales()
                Case "Ranking de Clientes"
                    'rankingclientes()
                Case Else
                    'MsgBoxAjax(Me, "El informe no existe. Consulte con el administrador")
            End Select






        Catch ex As Exception
            Dim s As String = "Hubo un error al generar el informe. " & cmbInforme.Text & " " & ex.ToString
            ErrHandler2.WriteError(s)
            MandarMailDeError(ex)
            'MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.ToString)
            MsgBoxAlert("Hubo un error al generar el informe. " & ex.ToString)
            Return
        End Try



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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub listadoTarifas()
        Dim pv As Integer = cmbPuntoVenta.SelectedValue


        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)

        Dim serv As String
        Dim estadofiltro As CartaDePorteManager.enumCDPestado = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas


        If System.Diagnostics.Debugger.IsAttached() Then
            serv = "http://localhost:48391/ProntoWeb"
        Else
            'es importante el HTTPS
            'serv = "https://prontoclientes.williamsentregas.com.ar"
            serv = "https://prontoweb.williamsentregas.com.ar"

        End If


        Dim db = New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
        Dim q = CartasLINQlocalSimplificadoTipadoConCalada(HFSC.Value, _
                          "", "", "", 1, 10000, _
                          estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                                                            IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                          Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                          Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                           cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text, db)

        If True Then


            Dim q2 = ( _
                        From cdp In q _
                        Join fac In db.linqFacturas On cdp.IdFacturaImputada Equals fac.IdFactura _
                        Join cli In db.linqClientes On fac.IdCliente Equals cli.IdCliente _
                        Join lp In db.ListasPrecios On cli.IdListaPrecios Equals lp.IdListaPrecios _
                        Join lpdet In db.ListasPreciosDetalles On lp.IdListaPrecios Equals lpdet.IdListaPrecios _
                        Select New With {.Tarifa = lpdet.Precio, .TarifaFacturada = 0, cli.RazonSocial, .Descripcion = cdp.Producto, .destino = cdp.DestinoDesc} _
                    ).Distinct.ToList

            RebindReportViewerLINQ("ProntoWeb\Informes\Tarifas.rdl", q2, New ReportParameter() {New ReportParameter("sServidor", serv)})


        Else



            Dim dt = EntidadManager.ExecDinamico(HFSC.Value, _
                    "select distinct Precio as Tarifa,clientes.RazonSocial,Articulos.Descripcion,WilliamsDestinos.Descripcion as destino " & _
                    "from ListasPreciosDetalle " & _
                    "left join ListasPrecios on ListasPrecios.IdListaPrecios=ListasPreciosDetalle.IdListaPrecios " & _
                    "left join clientes on clientes.IdListaPrecios=ListasPrecios.IdListaPrecios " & _
                    "left join Articulos on Articulos.IdArticulo=ListasPreciosDetalle.IdArticulo " & _
                    "left join WilliamsDestinos on WilliamsDestinos.IdWilliamsDestino=ListasPreciosDetalle.IdDestinoDeCartaDePorte " & _
                    "left join CartasDePorte CDP on CDP.IdArticulo=ListasPreciosDetalle.IdArticulo AND CDP.IdClienteAFacturarle=clientes.idcliente " & _
                    "left join Facturas FAC on CDP.IdFacturaImputada=FAC.IdFactura " & _
                    "where " & _
                    " ( " & idArticulo & "=-1 or ListasPreciosDetalle.idarticulo=" & idArticulo & " ) " & _
                    " AND ( " & idDestino & "=-1 or CDP.Destino=" & idDestino & " ) " & _
                    "order by Precio desc,clientes.RazonSocial asc " & _
                    "")

            RebindReportViewerLINQ("ProntoWeb\Informes\Tarifas.rdl", dt, New ReportParameter() {New ReportParameter("sServidor", serv)})

        End If


    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////


    
 



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Sub totpormesmodo()

        Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        Dim sWHERE As String




        Dim q = ConsultasLinq.totpormesmodo(HFSC.Value, _
                                    sTitulo, _
                                    "", "", 0, 999999, CartaDePorteManager.enumCDPestado.Todas, "", _
                                    idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                        DropDownList2.Text, _
                                   fechadesde, fechahasta, pv)



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Totales por Mes por Modo.rdl", q)



    End Sub
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Sub totpormesmodoysucursal()

        Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        Dim sWHERE As String





        Dim q = ConsultasLinq.totpormesmodoysucursal(HFSC.Value, _
                                    sTitulo, _
                                    "", "", 0, 999999, CartaDePorteManager.enumCDPestado.Todas, "", _
                                    idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                       DropDownList2.Text, _
                                   fechadesde, fechahasta, pv)



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Totales por Mes por Modo y Sucursal.rdl", q)



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



    Sub totpormes()
        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))


        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
                From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                Where _
                    cdp.Vendedor > 0 _
                    And cli.RazonSocial IsNot Nothing _
                    And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                    And (cdp.Anulada <> "SI") _
                    And ((DropDownList2.Text = "Ambos") Or (DropDownList2.Text = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (DropDownList2.Text = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                    And (idDestino = -1 Or cdp.Destino = idDestino) _
                    And (pv = -1 Or cdp.PuntoVenta = pv) _
                Group cdp By Ano = cdp.FechaDescarga.Value.Year, _
                            MesNumero = cdp.FechaDescarga.Value.Month, _
                            Producto = art.Descripcion Into g = Group _
                Select New With { _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) i.NetoFinal.GetValueOrDefault) / 1000, _
                    .Merma = g.Sum(Function(i) (i.Merma.GetValueOrDefault + i.HumedadDesnormalizada.GetValueOrDefault)) / 1000, _
                    .NetoFinal = g.Sum(Function(i) i.NetoProc.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero _
                }).ToList




        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////

        Dim q2 = LogicaFacturacion.ListaEmbarquesQueryable(HFSC.Value, fechadesde, fechahasta).ToList
        Dim a = (From i In q2 _
                Join art In db.linqArticulos On art.IdArticulo Equals i.IdArticulo _
                    Group i By Ano = i.FechaIngreso.Value.Year, _
                            MesNumero = i.FechaIngreso.Value.Month, _
                            Producto = art.Descripcion _
                    Into g = Group _
                    Select New With { _
                    .Ano = Ano, _
                    .Mes = MonthName(MesNumero), _
                    .Producto = Producto, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                    .Merma = CDec(0), _
                    .NetoFinal = g.Sum(Function(i) i.Cantidad.GetValueOrDefault) / 1000, _
                    .MesNumero = MesNumero _
                    }).ToList

        Dim x = q.Union(a).ToList()

        'http://connect.microsoft.com/VisualStudio/feedback/details/590217/editor-very-slow-when-code-contains-linq-queries

        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Totales por Mes.rdl", q)

    End Sub



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////'///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub totpormessucursal()
        Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        Dim sWHERE As String




        Dim q = ConsultasLinq.totpormessucursal(HFSC.Value, _
                                    sTitulo, _
                                    "", "", 0, 999999, CartaDePorteManager.enumCDPestado.Todas, "", _
                                    idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                       DropDownList2.Text, _
                                   fechadesde, fechahasta, pv)




        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Totales por Mes por Sucursal.rdl", q)

    End Sub



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Sub CartasDuplicadas()

        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))


        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)


        Dim cant = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                Where _
                    cdp.Vendedor > 0 _
                    And cli.RazonSocial IsNot Nothing _
                    And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                    And (cdp.Anulada <> "SI") _
                    And ((DropDownList2.Text = "Ambos") Or (DropDownList2.Text = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (DropDownList2.Text = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                    And (idDestino = -1 Or cdp.Destino = idDestino) _
                    And (pv = -1 Or cdp.PuntoVenta = pv)).Count



        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                Where _
                    cdp.Vendedor > 0 _
                    And cli.RazonSocial IsNot Nothing _
                    And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                    And (cdp.Anulada <> "SI") _
                    And ((DropDownList2.Text = "Ambos") Or (DropDownList2.Text = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (DropDownList2.Text = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                    And (idDestino = -1 Or cdp.Destino = idDestino) _
                    And (pv = -1 Or cdp.PuntoVenta = pv) _
                Group cdp By _
                    numerocartadeporte = cdp.NumeroCartaDePorte, _
                    subnumerovagon = cdp.SubnumeroVagon, _
                     Sucursal = cdp.PuntoVenta.ToString _
                Into g = Group _
                Select New With { _
                    .numerocartadeporte = numerocartadeporte, _
                    .subnumerovagon = subnumerovagon, _
                    .CantCartas = g.Count, _
                    .NetoPto = g.Sum(Function(i) CInt(i.NetoPto.GetValueOrDefault / 1000)), _
                    .Sucursal = Sucursal, _
                    .CartasProcesadas = cant, _
                    .Originales = 0 _
                }).Where(Function(i) i.CantCartas > 1).ToList()


        Dim orig = q.Count

        For Each i In q
            i.Sucursal = PuntoVentaWilliams.NombrePuntoVentaWilliams4(Val(i.Sucursal))
            i.Originales = orig

            'Select Case i.Sucursal
            '    Case "1"
            '        i.Sucursal = "Buenos Aires"
            '    Case 2
            '    Case 3
            '    Case 4

            '    Case Else
            'End Select
        Next
        '        --Armar un nuevo informe que detalle la cantidad de cartas de porte duplicadas y los montos.

        '--Detallar:

        '--* Numero de Carta de Porte
        '--* Cantidad de copias (contar la original)
        '--* Cantidad de kg (contar la original)

        '--Mostrar totales de las columnas 2 y 3

        'select numerocartadeporte,subnumerovagon,count(numerocartadeporte), sum(netopto) from cartasdeporte
        'group by numerocartadeporte,subnumerovagon


        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Duplicadas.rdl", q)

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





    Class infLiqui
        Public DestinoDesc
        Public SubcontrDesc
        Public NetoPto
        Public Tarifa
        Public Comision As Decimal
    End Class


    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub rankingclientes()


        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        Dim pv As Integer = cmbPuntoVenta.SelectedValue


        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////
        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim fechadesde2 As Date

        'la fecha del periodo anterior a comparar
        If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
            fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
        Else
            fechadesde2 = fechadesde - (fechahasta - fechadesde)
        End If
        fechadesde2 = iisValidSqlDate(fechadesde2, #1/1/1753#)
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        'mostrar(top)
        'pedir(minimo)

        Dim topclie As Integer = IIf(Val(txtTopClientes.Text) = 0, 99999, Val(txtTopClientes.Text))






        Dim q9 = (From cdp In db.CartasDePortes _
                From fac In db.linqFacturas.Where(Function(i) cdp.IdFacturaImputada = i.IdFactura).DefaultIfEmpty() _
                From clifac In db.linqClientes.Where(Function(i) fac.IdCliente = i.IdCliente).DefaultIfEmpty() _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                Join art In db.linqArticulos On art.IdArticulo Equals cdp.IdArticulo _
                Where cdp.Vendedor > 0 _
                And (cdp.PuntoVenta = cmbPuntoVenta.SelectedValue Or cmbPuntoVenta.SelectedValue = -1) _
                   And cli.RazonSocial IsNot Nothing _
                   And (cdp.FechaDescarga >= fechadesde2 And cdp.FechaDescarga <= fechahasta) _
                   And (cdp.IdFacturaImputada > 0) _
                                     And ((DropDownList2.Text = "Ambos") Or (DropDownList2.Text = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (DropDownList2.Text = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                   And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                    And (idDestino = -1 Or cdp.Destino = idDestino) _
                    And (pv = -1 Or cdp.PuntoVenta = pv) _
                Group cdp By Cliente = clifac.RazonSocial Into g = Group _
                Select New With { _
                        .Producto = Cliente, _
                        .PV1 = g.Sum(Function(i) IIf(i.PuntoVenta = 1 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV2 = g.Sum(Function(i) IIf(i.PuntoVenta = 2 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV3 = g.Sum(Function(i) IIf(i.PuntoVenta = 3 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .PV4 = g.Sum(Function(i) IIf(i.PuntoVenta = 4 And i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Total = g.Sum(Function(i) IIf(i.FechaDescarga >= fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Porcent = 0, _
                        .PeriodoAnterior = g.Sum(Function(i) IIf(i.FechaDescarga < fechadesde, CInt(i.NetoFinal / 1000), 0)), _
                        .Diferen = 0, _
                        .DiferencPorcent = 0 _
                    } _
                ).Where(Function(i) i.Total > Val(txtMinimoNeto.Text)).OrderByDescending(Function(i) i.Total).Take(topclie).tolist







        Dim p1 = New ReportParameter("TopClientes", Val(txtTopClientes.Text))
        Dim p2 = New ReportParameter("MinimoNeto", Val(txtMinimoNeto.Text))
        Dim params = New ReportParameter() {p1, p2}

        RebindReportViewerLINQ("ProntoWeb\Informes\Ranking de Clientes.rdl", q9)


    End Sub

    Function AgruparYPaginarOrdenandoPorNumeroDeCarta(ByVal dt As DataTable)


        'Dim q = From i In dt.AsEnumerable() _
        '        Group By Numero = i("Titular"), _
        '              IdFacturarselaAExplicito = i("Corredor"),
        '              IdFacturarselaAExplicito = i("Destinatario"),
        '              IdFacturarselaAExplicito = i("Producto"),
        '              IdFacturarselaAExplicito = i("Contrato"),
        '              IdFacturarselaAExplicito = i("Destino")
        '                Into Group _
        '        Where IdFacturarselaAExplicito <= 0 _
        '        Order By i("Factura") _
        '        Select New With {.Factura = i("Factura"), _
        '                            .Cliente = i("ClienteFacturado"), _
        '                            .FechaFactura = i("FechaFactura"), _
        '                            .CDP = i("NumeroCartaDePorte"), _
        '                            .VendedorDesc = i("VendedorDesc"), _
        '                            .CuentaOrden1Desc = i("CuentaOrden1Desc"), _
        '                            .CuentaOrden2Desc = i("CuentaOrden2Desc"), _
        '                            .CorredorDesc = i("CorredorDesc"), _
        '                            .EntregadorDesc = i("EntregadorDesc"), _
        '                            .ProcedenciaDesc = i("ProcedenciaDesc"), _
        '                            .DestinoDesc = i("DestinoDesc"), _
        '                            .Producto = i("Producto"), _
        '                            .CalidadDesc = i("CalidadDesc"), _
        '                            .Obs = i("Observaciones"), _
        '                            .FechaDescarga = i("FechaDescarga"), _
        '                            .KgNetos = i("NetoFinal"), _
        '                            .TarifaFacturada = i("TarifaFacturada"), _
        '                            .Count = Group.Count() _
        '                        }



        'solucion a lo cursor:


        '1 ordeno el datatable por titular/corredor/dest...
        '2 hago un for donde le pongo en dos columnas nuevas: el grupo, y el numero 

        'Dim dtv = From i In dt.AsEnumerable Order By i("Titular")
        'Dim grupo As Integer = 0
        'Dim subgrupo As Integer = 0
        'Dim linea As Integer = 0


        'For n = 1 To dtv.Count - 1

        '    If dtv(n).Item("Titular") <> dtv(n + 1).Item("Titular") Then
        '        grupo += 1
        '        linea = 0
        '    End If

        '    linea += 1
        '    subgrupo = linea Mod 8
        'Next

        'al final safamos ordenando las notas por el primer numero de carta que aparece en cada notita

    End Function




    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub ResumenFacturacion()

        Try

            Dim dt4 As DataTable
            'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, #1/1/1753#, #1/1/2100#  )

            'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "wCartasDePorte_TX_InformesLiviano -1, " _
            '                                                 & _c(FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#))) & " , " _
            '                                                & _c(FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))), 200)

            'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "wCartasDePorte_TX_Informes -1, " _
            '                                   & _c(FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#))) & " , " _
            '                                   & _c(FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))), 200)



            Dim sTitulo As String = ""
            Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
            Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
            Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
            Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
            Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
            Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
            Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
            Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
            Dim pv As Integer = cmbPuntoVenta.SelectedValue

            Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
            Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))




            'Dim a = Aggregate f In db.linqFacturas Where f.FechaFactura >= fechadesde And f.FechaFactura < fechahasta Into Sum(f.ImporteTotal)

            'los from con where son para simular el LEFT JOIN
            Dim s = From fac In db.linqFacturas _
                    From cdp In db.CartasDePortes.Where(Function(i) i.IdFacturaImputada = fac.IdFactura).DefaultIfEmpty _
                    From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                    From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                    From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                    From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                    From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                    From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                    From clifac In db.linqClientes.Where(Function(i) i.IdCliente = fac.IdCliente).DefaultIfEmpty _
                    From cal In db.Calidades.Where(Function(i) i.IdCalidad = cdp.Calidad).DefaultIfEmpty _
                    From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                    From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                    From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                    From loc In db.Localidades.Where(Function(i) i.IdLocalidad = cdp.Procedencia).DefaultIfEmpty _
                    From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                    From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                    Where fac.FechaFactura >= fechadesde And fac.FechaFactura < fechahasta _
                        And (cdp.IdFacturaImputada > 0) _
                        And (cdp.NetoProc > 0 And cdp.FechaDescarga.HasValue) _
                        And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                        And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                        And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                        And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                        And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                        And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                        And (idDestino = -1 Or cdp.Destino = idDestino) _
                        And (pv = -1 Or cdp.PuntoVenta = pv) _
                    Select fac.IdFactura, _
                            fac.IdCliente, _
                            Factura = fac.TipoABC.ToString & "-" & fac.PuntoVenta.ToString & "-" & fac.NumeroFactura.ToString, _
                            CDP = cdp.NumeroCartaDePorte, _
                            FechaFactura = fac.FechaFactura, _
                            Obs = cdp.Observaciones, _
                            KgNetos = cdp.NetoFinal, _
                            Cliente = clifac.RazonSocial, _
                            VendedorDesc = clitit.RazonSocial, _
                            CuentaOrden1Desc = cliint.RazonSocial, _
                            CuentaOrden2Desc = clircom.RazonSocial, _
                            CorredorDesc = corr.Nombre, _
                            EntregadorDesc = clidest.RazonSocial, _
                            ProcedenciaDesc = loc.Nombre, _
                            DestinoDesc = dest.Descripcion, _
                            Producto = art.Descripcion, _
                            CalidadDesc = cal.Descripcion, _
                            TarifaFacturada = cdp.TarifaFacturada








            'pero cómo sé qué período tengo que tomar para filtrar las cartas, si lo 
            'estaba aplicando sobre el de la fecha de la factura que las contenía?


            'Dim a = s.ToList


            Dim facturadasenelperiodo = (From cdp In db.CartasDePortes _
                                Where (If(cdp.FechaDescarga, cdp.FechaArribo) >= fechadesde And If(cdp.FechaDescarga, cdp.FechaArribo) <= fechahasta) _
                                And cdp.IdFacturaImputada > 0 _
                            ).Count


            Dim facturadas = s.Count

            If facturadas > 50000 Then
                MsgBoxAlert("Reduzca con los filtros la cantidad de datos")
                Exit Sub

            End If

            Dim descargassinfacturar = (From cdp In db.CartasDePortes _
                                Where (If(cdp.FechaDescarga, cdp.FechaArribo) >= fechadesde And If(cdp.FechaDescarga, cdp.FechaArribo) <= fechahasta) _
                                    And (cdp.Anulada <> "SI") _
                                    And (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                                    And (DropDownList2.Text <> "Entregas" Or cdp.Exporta <> "SI") _
                                    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                                    And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                                    And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                                    And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                                    And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                                    And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                                    And (idDestino = -1 Or cdp.Destino = idDestino) _
                                    And (pv = -1 Or cdp.PuntoVenta = pv) _
                                    And Not cdp.IdFacturaImputada > 0 _
                                ).Count

            'Dim facturadas = s.Where(Function(i) i.CDP > 0).Count
            'Dim descargas = s.Where(Function(i) i.FechaDescarga.HasValue > 0).Count
            'Dim posicion = s.Where(Function(i) Not i.FechaDescarga.HasValue).Count


            'If dt4.Rows.Count = 0 Then
            '    MsgBoxAlert("No hay registros que mostrar")
            '    Exit Sub
            'End If

            Dim p1 = New ReportParameter("facturadas", facturadas)
            Dim p2 = New ReportParameter("descargas", descargassinfacturar)
            Dim p3 = New ReportParameter("Titulo", "desde " & fechadesde & " hasta " & fechahasta)
            Dim params = New ReportParameter() {p1, p2, p3}



            Dim t = From c In s _
                    Group c By _
                            c.Factura, _
                            c.FechaFactura, _
                            c.Cliente _
                    Into g = Group _
                    Select New With { _
                            Factura, _
                            FechaFactura, _
                            Cliente, _
                            .KgNetos = g.Sum(Function(i) i.KgNetos) _
                    }

            RebindReportViewerLINQ("ProntoWeb\Informes\Resumen de facturación.rdl", t, params)

        Catch ex As Exception
            Throw
        End Try

    End Sub




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
        'dt.Columns.Remove("Export")
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


    'Function generarWHERE() As String
    '    Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
    '    Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
    '    Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
    '    Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
    '    Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
    '    Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
    '    Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
    '    Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


    '    Dim strWHERE As String '= " WHERE " 

    '    strWHERE += " 1=1 " & _
    '    iisIdValido(idVendedor, "           AND Vendedor = " & idVendedor, "") & _
    '    iisIdValido(idIntermediario, "           AND CuentaOrden1 = " & idIntermediario, "") & _
    '    iisIdValido(idRComercial, "           AND CuentaOrden2 = " & idRComercial, "") & _
    '    iisIdValido(idCorredor, "             AND Corredor=" & idCorredor, "") & _
    '    iisIdValido(idArticulo, "           AND IdArticulo=" & idArticulo, "") & _
    '    iisIdValido(idProcedencia, "             AND Procedencia=" & idProcedencia, "") & _
    '    iisIdValido(idDestino, "             AND Destino=" & idDestino, "") & _
    '    iisIdValido(idDestinatario, "             AND Entregador=" & idDestinatario, "") '& _


    '    If DropDownList2.Text = "Local" Then
    '        strWHERE += "  AND ISNULL(Exporta,'NO')='NO'  "
    '    ElseIf DropDownList2.Text = "Exporta" Then
    '        strWHERE += "  AND ISNULL(Exporta,'NO')='SI'  "
    '    End If

    '    If cmbPuntoVenta.SelectedValue > 0 Then
    '        strWHERE += "AND (PuntoVenta=" & cmbPuntoVenta.SelectedValue & ")"   ' OR PuntoVenta=0)"  'lo del punto de venta=0 era por las importaciones donde alguien (con acceso a todos los puntos de venta) no tenía donde elegir cual 
    '    End If


    '    ' "  AND ISNULL(IdFacturaImputada,-1)<=0 " '& _
    '    '"                               AND (FechaDescarga Between '" & iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#) & "' AND '" & iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#) & "')" & _
    '    '" AND IdCartaDePorte NOT IN (" & ListaDeCDPtildadas() & ") "



    '    strWHERE += CartaDePorteManager.EstadoWHERE(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "")

    '    'strWHERE += " ORDER BY " & facturarselaA & " ASC,NumeroCartaDePorte ASC "

    '    Return strWHERE
    'End Function




    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////



    Protected Sub txt_AC_Articulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txt_AC_Articulo.TextChanged

        bRecargarInforme = True
    End Sub

    Protected Sub txtDestinatario_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestinatario.TextChanged
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

    Protected Sub txtTitular_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtTitular.TextChanged
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



    Sub Movimientos_RebindReportViewer(ByVal rdlFile As String, ByVal dtCartasPorte As DataTable, ByVal dtExistencias As Object, _
                                       ByVal dtMovimientos As Object, ByVal FechaDesde As DateTime, ByVal fechaHasta As DateTime, _
                                       ByVal IdDestinoPuerto As Integer, ByVal IdArticulo As Integer, ByVal iddestinatario As Integer)
        'http://forums.asp.net/t/1183208.aspx



        With ReportViewer2
            .Reset()
            .ProcessingMode = ProcessingMode.Local

            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True



                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSetVistaCartasPorteMovimientos", dtMovimientos)) '//the first parameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet2", dtExistencias))
                .DataSources.Add(New ReportDataSource("DataSetCartasDePorte_TX_InformesCorregido", dtCartasPorte))

                '.ReportEmbeddedResource = rdlFile

                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////



                'Try
                '    If .GetParameters.Count > 1 Then
                '        If .GetParameters.Item(1).Name = "FechaDesde" Then
                '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                '            Dim p2 = New ReportParameter("FechaDesde", Today)
                '            Dim p3 = New ReportParameter("FechaHasta", Today)
                '            .SetParameters(New ReportParameter() {p1, p2, p3})
                '        End If
                '    End If
                'Catch ex As Exception
                '    ErrHandler2.WriteError(ex.ToString)
                'End Try


                Try
                    If .GetParameters.Count = 6 Then
                        Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                        Dim p2 = New ReportParameter("FechaDesde", FechaDesde)
                        Dim p3 = New ReportParameter("IdArticulo", IdArticulo)
                        Dim p4 = New ReportParameter("IdPuerto", IdDestinoPuerto)
                        Dim p5 = New ReportParameter("FechaHasta", fechaHasta)
                        Dim p6 = New ReportParameter("Titulo", NombreArticulo(HFSC.Value, IdArticulo) & "-" & _
                                                        NombreDestino(HFSC.Value, IdDestinoPuerto) & "-" & _
                                                        NombreCliente(HFSC.Value, iddestinatario))


                        .SetParameters(New ReportParameter() {p1, p2, p3, p4, p5, p6})
                        'If .GetParameters.Item(0).Name = "ReportParameter1" Then
                        '    Dim p1 = New ReportParameter("ReportParameter1", titulo)
                        '    'Dim p2 = New ReportParameter("FechaDesde", Today)
                        '    'Dim p3 = New ReportParameter("FechaHasta", Today)
                        '    '.SetParameters(New ReportParameter() {p1, p2, p3})
                        '    .SetParameters(New ReportParameter() {p1})

                        'Else
                        '    ErrHandler2.WriteError("Error al buscar los parametros")
                        'End If
                    Else
                        ErrHandler2.WriteError("Error al buscar los parametros")
                    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al buscar los parametros.  " & inner.Message)
                        inner = inner.InnerException
                    End While
                End Try


                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With

            .DocumentMapCollapsed = True
            .LocalReport.Refresh()

            Try
                .DataBind()
            Catch ex As Exception
                ErrHandler2.WriteAndRaiseError(ex)
            End Try

        End With


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        'ReportViewer2.Reset()
        'Dim rep As Microsoft.Reporting.WebForms.LocalReport = ReportViewer2.LocalReport

        ''rep.ReportPath = "SampleReport.rdlc"
        'Dim myConnection As SqlConnection = New SqlConnection(HFSC.Value)

        'Dim ds As Data.DataSet = RequerimientoManager.GetListTXDetallesPendientes(HFSC.Value) 'RequerimientoManager.GetListTX(HFSC.Value, )

        'Dim dsSalesOrder As New Microsoft.Reporting.WebForms.ReportDataSource()
        'dsSalesOrder.Name = "DataSet1"
        'dsSalesOrder.Value = ds.Tables(0)

        'rep.DataSources.Add(dsSalesOrder)

        'ds.ReadXml(Server.MapPath("SalesDataFile.xml"))
        'ds.ReadXml(HttpContext.Current.Request.MapPath("SalesDataFile.xml"))



        'ReportViewer2.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSource1", myConnection))
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Sub


    Sub RebindReportViewerExcel(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing, Optional ByRef ArchivoExcelDestino As String = "")


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



        End With


    End Sub



    Function RebindReportViewer(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing, Optional ByVal bDescargaExcel As Boolean = False, Optional ByRef ArchivoExcelDestino As String = "") As String
        'http://forums.asp.net/t/1183208.aspx

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.
                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                'Try
                '    If .GetParameters.Count > 1 Then
                '        If .GetParameters.Item(1).Name = "FechaDesde" Then
                '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                '            Dim p2 = New ReportParameter("FechaDesde", Today)
                '            Dim p3 = New ReportParameter("FechaHasta", Today)
                '            .SetParameters(New ReportParameter() {p1, p2, p3})
                '        End If
                '    End If
                'Catch ex As Exception
                '    ErrHandler2.WriteError(ex.ToString)
                'End Try
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True




            If bDescargaExcel Then
                .Visible = False

                'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                Dim warnings As Warning()
                Dim streamids As String()
                Dim mimeType, encoding, extension As String
                Dim bytes As Byte()

                Try
                    bytes = ReportViewer2.LocalReport.Render( _
                          "Excel", Nothing, mimeType, encoding, _
                            extension, _
                           streamids, warnings)

                Catch e As System.Exception
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)

                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                        End If

                        ErrHandler2.WriteError(inner.Message)
                        inner = inner.InnerException
                    End While
                End Try


                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()


                Return ArchivoExcelDestino
            Else
                'nononono chambon, no se puede (y no tiene sentido) usar los parametros en un informe local
                '.ShowParameterPrompts = True

                .LocalReport.Refresh()
                .DataBind()

            End If

        End With

        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function


    Function RebindReportViewerLINQ(ByVal rdlFile As String, ByVal q As Object, Optional ByVal parametros As ReportParameter() = Nothing) As String
        'http://forums.asp.net/t/1183208.aspx

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", q)) '//the first parameter is the name of the datasource which you bind your report table to.

                '.ReportEmbeddedResource = rdlFile


                .EnableExternalImages = True


                '.DataSources.Add(New ReportDataSource("http://www.google.com/intl/en_ALL/images/logo.gif", "Image1"))
                'DataSource.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";
                '.ImgPath = "http://www.google.com/intl/en_ALL/images/logo.gif";



                '/////////////////////
                'parametros (no uses la @ delante del parametro!!!!)
                '/////////////////////
                Try
                    If parametros IsNot Nothing Then
                        .SetParameters(parametros)
                    End If
                    '    If .GetParameters.Count > 1 Then
                    '        If .GetParameters.Item(1).Name = "FechaDesde" Then
                    '            Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                    '            Dim p2 = New ReportParameter("FechaDesde", Today)
                    '            Dim p3 = New ReportParameter("FechaHasta", Today)
                    '            .SetParameters(New ReportParameter() {p1, p2, p3})
                    '        End If
                    '    End If
                Catch ex As Exception
                    ErrHandler2.WriteError(ex.ToString)
                End Try
                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With


            .DocumentMapCollapsed = True




            If False Then
                'If bDescargaExcel Then
                '    .Visible = False

                '    'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
                '    Dim warnings As Warning()
                '    Dim streamids As String()
                '    Dim mimeType, encoding, extension As String
                '    Dim bytes As Byte()

                '    Try
                '        bytes = ReportViewer2.LocalReport.Render( _
                '              "Excel", Nothing, mimeType, encoding, _
                '                extension, _
                '               streamids, warnings)

                '    Catch e As System.Exception
                '        Dim inner As Exception = e.InnerException
                '        While Not (inner Is Nothing)

                '            If System.Diagnostics.Debugger.IsAttached() Then
                '                MsgBox(inner.Message)
                '            End If

                '            ErrHandler2.WriteError(inner.Message)
                '            inner = inner.InnerException
                '        End While
                '    End Try


                '    Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                '    fs.Write(bytes, 0, bytes.Length)
                '    fs.Close()


                '    Return ArchivoExcelDestino
            Else
                'nononono chambon, no se puede (y no tiene sentido) usar los parametros en un informe local
                '.ShowParameterPrompts = True




                .LocalReport.Refresh()
                .DataBind()
                UpdatePanel2.Update()
                'puede llegar a no decir nada si le falta un parámetro que no sea nullable
            End If

        End With



        '////////////////////////////////////////////

        'este me salvo! http://social.msdn.microsoft.com/Forums/en-US/winformsdatacontrols/thread/bd60c434-f61a-4252-a7f9-1606fdca6b41

        'http://social.msdn.microsoft.com/Forums/en-US/vsreportcontrols/thread/505ffb1c-324e-4623-9cce-d84662d92b1a
    End Function






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



    Protected Sub cmbSincronismo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbSincronismo.TextChanged

        If cmbSincronismo.Text = "--- elija un Sincronismo ----" Then Exit Sub

        ReportViewer2.Visible = False
        cmbEstado.Text = "Descargas"
        txtTitular.Text = ""
        txtCorredor.Text = ""
        txtDestinatario.Text = ""

        Select Case cmbSincronismo.Text.ToUpper
            Case "A.C.A."
                txtTitular.Text = ""
                txtCorredor.Text = "A.C.A. LTDA"
            Case "ARGENCER SA"
                txtTitular.Text = ""
                ' txtCorredor.Text = "ARGENCER SA"

            Case "DIAZ RIGANTI"
                txtTitular.Text = ""
                txtCorredor.Text = "DIAZ RIGANTI CEREALES S.R.L."

            Case "ANDREOLI"

                txtDestinatario.Text = "ANDREOLI S.A."
            Case "AMAGGI (CALIDADES)", "AMAGGI (DESCARGAS)"
                txtCorredor.Text = ""
                txtDestinatario.Text = "AMAGGI ARGENTINA SA"
            Case "LOS GROBO"
                txtTitular.Text = "LOS GROBO  AGROPECUARIA S.A."
                txtCorredor.Text = ""
            Case "ZENI"
                txtTitular.Text = ""
                txtCorredor.Text = "ZENI ENRIQUE y CIA SACIAF e I"

            Case "DOW"

                txtTitular.Text = "DOW AGROSCIENCES ARG. SA"
                txtCorredor.Text = ""

            Case "BLD", "BLD 2", "BLD (CALIDADES)"
                txtTitular.Text = ""
                txtCorredor.Text = "BLD S.A"
            Case "BLD (POSICIÓN DEMORADOS)"
                txtTitular.Text = ""
                cmbEstado.Text = "Posición"
                txtCorredor.Text = "BLD S.A"
                txtDestinatario.Text = ""
                cmbEstado.Text = "Posición"

            Case "BUNGE"
                'txtTitular.Text = "BUNGE ARGENTINA S.A."
                txtDestinatario.Text = "BUNGE ARGENTINA S.A."

            Case "FYO"
                txtTitular.Text = ""
                txtCorredor.Text = "FUTUROS Y OPCIONES .COM"

            Case "FYO (POSICIÓN)"
                txtTitular.Text = ""
                txtCorredor.Text = "FUTUROS Y OPCIONES .COM"
                cmbEstado.Text = "Posición"

            Case "GRANOS DEL LITORAL"

            Case "GRANOS DEL PARANA"
                txtTitular.Text = ""
                txtCorredor.Text = "GRANOS DEL PARANA S.A."

            Case "DUKAREVICH"
                txtTitular.Text = ""
                txtCorredor.Text = "DUKAREVICH S.A"

            Case "NOBLE", "NOBLE (ANEXO CALIDADES)"
                txtDestinatario.Text = "NOBLE ARGENTINA S.A."
                txtCorredor.Text = ""
                txtTitular.Text = "NOBLE ARGENTINA S.A."

            Case "GRIMALDI GRASSI"
                txtTitular.Text = ""
                txtCorredor.Text = "GRIMALDI GRASSI S.A."

            Case "SYNGENTA"
                txtRcomercial.Text = "SYNGENTA AGRO S.A."
                'txtIntermediario.Text = "SYNGENTA AGRO S.A."
                txtCorredor.Text = ""

            Case "TOMAS HNOS"
                txtTitular.Text = "TOMAS HNOS Y CIA. S.A."
                txtCorredor.Text = ""

            Case "TECNOCAMPO"
                txtTitular.Text = "TECNOCAMPO SA"
                txtCorredor.Text = ""

        End Select
    End Sub



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


    Protected Sub btnTexto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTexto.Click

        'Dim sWHERE As String = CDPMailFiltrosManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
        '                    sTitulo, _
        '                    CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
        '                    idDestinatario, idIntermediario, _
        '                    idRComercial, idArticulo, idProcedencia, idDestino, _
        '                    "1", DropDownList2.Text, _
        '                    Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
        '                    Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
        '                    cmbPuntoVenta.SelectedValue)


        'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_InformesLiviano", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
        Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))



        'Dim output = RebindReportViewerTexto("ProntoWeb\Informes\Adjuntos de Facturacion (a impresora de matriz de puntos).rdl", dt)
        'Dim output = RebindReportViewerTexto("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)
        Dim output = RebindReportViewerTexto("ProntoWeb\Informes\Notas de entrega (a impresora de matriz de puntos).rdl", dt)

        output = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextNotasDeEntrega(output)

        'ImpresoraMatrizDePuntosEPSONTexto.

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


    Function RebindReportViewerTexto(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing, Optional ByRef ArchivoExcelDestino As String = "") As String


        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = Path.GetTempPath & "DescargasDetalladasPorTitular " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)

        With ReportViewer2
            .Reset()

            .ProcessingMode = ProcessingMode.Local

            .Visible = False

            With .LocalReport

                .ReportPath = rdlFile
                .EnableHyperlinks = True
                .DataSources.Clear()

                .EnableExternalImages = True

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", dt)) '//the first parameter is the name of the datasource which you bind your report table to.

                Dim p1 = New ReportParameter("RenglonesPorBoleta", 8)
                Try
                    .SetParameters(New ReportParameter() {p1})
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                'If .GetParameters.Count = 1 Then
                '    If .GetParameters.Item(0).Name = "ReportParameter1" Then
                '        Dim p1 = New ReportParameter("ReportParameter1", titulo)
                '        'Dim p2 = New ReportParameter("FechaDesde", Today)
                '        'Dim p3 = New ReportParameter("FechaHasta", Today)
                '        '.SetParameters(New ReportParameter() {p1, p2, p3})
                '        .SetParameters(New ReportParameter() {p1})

                '    Else
                '        ErrHandler2.WriteError("Error al buscar los parametros")
                '    End If
                'Else
                '    ErrHandler2.WriteError("Error al buscar los parametros")
                'End If


                If Not IsNothing(dt2) Then .DataSources.Add(New ReportDataSource("DataSet2", dt2))

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()




            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim bytes As Byte()

            Try
                bytes = ReportViewer2.LocalReport.Render( _
                           "Excel", Nothing, mimeType, encoding, _
                             extension, _
                            streamids, warnings)

            Catch e As System.Exception
                Dim inner As Exception = e.InnerException

                While Not (inner Is Nothing)

                    If System.Diagnostics.Debugger.IsAttached() Then
                        MsgBox(inner.Message)
                    End If

                    ErrHandler2.WriteError(inner.Message)
                    inner = inner.InnerException
                End While

            End Try


            Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()



            Return ArchivoExcelDestino

        End With


    End Function








    Sub ProyeccionFacturacion()

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim fechadesde2 As Date

        'la fecha del periodo anterior a comparar
        If cmbPeriodo.Text = "Este mes" Or cmbPeriodo.Text = "Mes anterior" Then
            fechadesde2 = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, fechadesde))
        Else
            fechadesde2 = fechadesde - (fechahasta - fechadesde)
        End If
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////


        'cual es el tema con la proyeccion de facturacion? las cartas que no tienen tarifa???

        Dim lista As New Generic.List(Of tipoloco)
        Dim i As tipoloco

        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        Dim c1, c2, c3, c4
        Dim neto1, neto2, neto3, neto4
        Dim pv1, pv2, pv3, pv4 As Decimal

        If False Then
            'Dim fechamin = #10/30/2011# 'fecha maxima de las cartas que fueron importadas, y ademas largada del sistema
            Dim fechamin = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))


            pv1 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(1) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv2 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(2) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv3 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(3) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

            pv4 = Aggregate cdp In db.wCartasDePorte_TX_FacturacionAutomatica(4) _
                    Where cdp.FechaArribo > fechamin _
                    Into monto = Sum(CDec(cdp.TarifaFacturada) * cdp.KgNetos / 1000)

        Else


            Dim sErr

            Dim TarifaDefault As Decimal = 2.55

            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////
            'Calculo lo que se supuestamente se facturaria este mes
            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////
            'TODO: truco para que traiga TODAS las filas, sin paginar

            'tendrias que agregar las cartas en la tabla Grillaxxx????
            Dim idtanda = 0 '=0 si es 0, el generador va a llamar automaticamente al generarTabla. -sí, 
            '                               pero usando lo que le pases a través de sLista.  -Pero yo necesito que la genere! La que genera es 
            '                               la tabla con las facturas ya asinadas, la que yo le paso es wGrillaPersistencia, y la 
            '                               devolucion es por store, si tabla temporal (wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia no usa un tabla para exportar,
            '                               aunque podría...) -Como que no??? quedan en wTempCartasPorteFacturacionAutomatica



            Dim sLista = AgregarALaTandaDeFacturacionAutomatica(Nothing, HFSC.Value, idtanda)

            If sLista = "" Then
                MsgBoxAjax(Me, "No hay cartas elegidas")
                Return
            End If
            'y entonces para qué me piden despues los filtros, si le paso la lista de cartas?


            ViewState("pagina") = 1
            ViewState("IdTanda") = idtanda
            Dim PuntoVenta = 1
            Dim aa As IQueryable(Of wTempCartasPorteFacturacionAutomatica) = LogicaFacturacion.GetIQueryableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                                 sLista, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", idtanda, 0, 0, "", sErr, "", True, db, False, Nothing, "", Session.SessionID)

            If aa.Count <> 0 Then
                pv1 = Aggregate o In aa _
                                    Into monto = Sum(CDec(IIf(If(o.TarifaFacturada, 0) = 0, _
                                                              If(db.wTarifaWilliamsEstimada(o.IdFacturarselaA, o.IdArticulo, o.IdDestino, 0), 0), _
                                                              If(o.TarifaFacturada, 0))) _
                                                      * o.KgNetos)
                pv1 /= 1000
            End If

            Dim aaa = aa.Where(Function(o) If(o.TarifaFacturada, 0) = 0).Count

            Dim ccc = From o In aa Select New With {.asasd = db.wTarifaWilliamsEstimada(o.IdFacturarselaA, o.IdArticulo, o.IdDestino, 0), o.TarifaFacturada}


            If True Then

                c1 = aa.Count
                neto1 = aa.Sum(Function(x) x.KgNetos)

                i = New tipoloco
                i.Ano = Today.Year
                i.Mes = "cartas pv1"
                i.Orden = Today.Month
                i.Monto = pv1
                i.Orden = 99
                i.Serie = "" 'MonthName(i.orden)

                i.Cartas = c1
                'i.Tarifa = aa.Average(Function(x) IIf(If(x.TarifaFacturada, 0) = 0, CDec(TarifaDefault), CDec(If(x.TarifaFacturada, 0))))
                i.Tarifa = IIf(c1 = 0, 0, pv1 / c1)
                i.NetoFinal = neto1
                lista.Add(i)

            End If





            ViewState("pagina") = 1
            ViewState("IdTanda") = idtanda
            PuntoVenta = 2
            aa = LogicaFacturacion.GetIQueryableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                             sLista, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", idtanda, 0, 0, "", sErr, "", True, db, False, Nothing, "", Session.SessionID)


            'http://stackoverflow.com/questions/2455500/how-to-do-linq-aggregates-when-there-might-be-an-empty-set
            'In SQL, SUM(no rows) returns null, not zero. However, the type inference for your query gives 
            'you decimal as the type parameter, instead of decimal?. The fix is to help type inference select the correct type, i.e.:
            'Employees.Where(e => e.EmployeeID == -999).Sum(e => (int?)e.EmployeeID)

            If aa.Count <> 0 Then
                pv2 = Aggregate o In aa _
                                Into monto = Sum(CDec(IIf(If(o.TarifaFacturada, 0) = 0, _
                                                              If(db.wTarifaWilliamsEstimada(o.IdFacturarselaA, o.IdArticulo, o.IdDestino, 0), 0), _
                                                              If(o.TarifaFacturada, 0))) _
                                                      * o.KgNetos)
                pv2 /= 1000

            End If


            If True Then

                c2 = aa.Count
                neto2 = aa.Sum(Function(x) x.KgNetos)

                i = New tipoloco
                i.Ano = Today.Year
                i.Mes = "cartas pv2"
                i.Orden = Today.Month
                i.Monto = pv2
                i.Orden = 99
                i.Serie = "" 'MonthName(i.orden)

                i.Cartas = c2

                i.NetoFinal = neto2


                lista.Add(i)

            End If



            ViewState("pagina") = 1
            ViewState("IdTanda") = idtanda
            PuntoVenta = 3
            aa = LogicaFacturacion.GetIQueryableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                              sLista, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", "", "", "", "", idtanda, 0, 0, "", sErr, "", True, db, False, Nothing, "", Session.SessionID)

            If aa.Count <> 0 Then
                pv3 = Aggregate o In aa _
                                      Into monto = Sum(CDec(IIf(If(o.TarifaFacturada, 0) = 0, _
                                                              If(db.wTarifaWilliamsEstimada(o.IdFacturarselaA, o.IdArticulo, o.IdDestino, 0), 0), _
                                                              If(o.TarifaFacturada, 0))) _
                                                      * o.KgNetos)
                pv3 /= 1000

            End If
            If True Then

                c3 = aa.Count
                neto3 = aa.Sum(Function(x) x.KgNetos)

                i = New tipoloco
                i.Ano = Today.Year
                i.Mes = "cartas pv3 "
                i.Monto = pv3
                i.Orden = 99
                i.Serie = "" 'MonthName(i.orden)

                i.Cartas = c3
                ' i.Tarifa = IIf(c1 = 0, 0, pv1 / c1)
                i.NetoFinal = neto3

                lista.Add(i)

            End If


            ViewState("pagina") = 1
            ViewState("IdTanda") = idtanda
            PuntoVenta = 4
            aa = LogicaFacturacion.GetIQueryableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                              sLista, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", idtanda, 0, 0, "", sErr, "", True, db, False, Nothing, "", Session.SessionID)
            If aa.Count <> 0 Then
                pv4 = Aggregate o In aa _
                                   Into monto = Sum(CDec(IIf(If(o.TarifaFacturada, 0) = 0, _
                                                              If(db.wTarifaWilliamsEstimada(o.IdFacturarselaA, o.IdArticulo, o.IdDestino, 0), 0), _
                                                              If(o.TarifaFacturada, 0))) _
                                                      * o.KgNetos)
                pv4 /= 1000

            End If




            If True Then

                c4 = aa.Count
                neto4 = aa.Sum(Function(x) x.KgNetos)

                i = New tipoloco
                i.Ano = Today.Year
                i.Mes = "cartas pv4 "
                i.Orden = 99 'Today.Month
                i.Monto = pv4
                i.NetoFinal = neto1
                i.Cartas = c1
                'i.serie = MonthName(i.orden)

                i.Cartas = c4

                i.NetoFinal = neto4


                lista.Add(i)

            End If
        End If

        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////




        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////
        'los meses anteriores
        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////

        'del mismo mes del año anterior, solo incluir los mismos dias que transcurrieron del mes actual

        If True Then
            Dim primerodemes = GetFirstDayInMonth(DateAdd(DateInterval.Month, -12, Today))
            Dim ultimodemes = DateAdd(DateInterval.Day, Today.Day - 1, primerodemes)    'del mismo mes del año anterior, solo incluir los mismos dias que transcurrieron del mes actual
            Dim total = Aggregate f In db.linqFacturas _
                        Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimodemes _
                        And If(f.Anulada, "") <> "SI" _
                        Into Sum(f.ImporteTotal)
            Dim cartasimputadas As Integer = (From f In db.linqFacturas _
                      Join c In db.CartasDePortes On c.IdFacturaImputada Equals f.IdFactura _
                    Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimodemes _
                    And If(f.Anulada, "") <> "SI" _
                    Select c.IdCartaDePorte).Distinct.Count

            Dim cartasneto = (From f In db.linqFacturas _
                                Join c In db.CartasDePortes On c.IdFacturaImputada Equals f.IdFactura _
                              Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimodemes _
                              And If(f.Anulada, "") <> "SI" _
                              Select c.NetoFinal).Sum
            i = New tipoloco
            i.Ano = primerodemes.Year
            i.Mes = MonthName(primerodemes.Month) + " (hasta el " + ultimodemes.Day.ToString + ")"
            i.Orden = primerodemes.Month
            i.Monto = total
            i.NetoFinal = cartasneto
            i.Serie = ""
            i.Cartas = cartasimputadas
            lista.Add(i)
        End If

        For m = 0 To 11
            Dim primerodemes = GetFirstDayInMonth(DateAdd(DateInterval.Month, -m, Today))
            Dim ultimodemes = GetLastDayInMonth(primerodemes)
            Dim total = Aggregate f In db.linqFacturas _
                        Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimodemes _
                        And If(f.Anulada, "") <> "SI" _
                        Into Sum(f.ImporteTotal)

            Dim cartasimputadas As Integer = (From f In db.linqFacturas _
                                  Join c In db.CartasDePortes On c.IdFacturaImputada Equals f.IdFactura _
                                Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimodemes _
                                And If(f.Anulada, "") <> "SI" _
                                Select c.IdCartaDePorte).Distinct.Count

            Dim cartasneto = (From f In db.linqFacturas _
                                Join c In db.CartasDePortes On c.IdFacturaImputada Equals f.IdFactura _
                              Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimodemes _
                              And If(f.Anulada, "") <> "SI" _
                              Select c.NetoFinal).Sum


            i = New tipoloco
            i.Ano = primerodemes.Year
            i.Mes = MonthName(primerodemes.Month)
            i.Orden = primerodemes.Month
            i.Monto = total
            i.NetoFinal = cartasneto
            i.Serie = ""
            i.Cartas = cartasimputadas
            lista.Add(i)
        Next



        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////
        'proyeccion de este mes
        '//////////////////////////////////////////////////////////////////////////////////
        'Dim proyeccion = (totalEsteMes + totalEsteMes2 + totalEsteMes3 + totalEsteMes4) * 1.21
        Dim proyeccion = (pv1 + pv2 + pv3 + pv4) * 1.21


        i = New tipoloco
        i.Ano = Today.Year
        i.Mes = "cartas por facturar del período seleccionado + IVA (" & fechadesde & " " & fechahasta & ")" 'MonthName(Today.Month)
        i.Mes = "cartas por facturar del período + IVA"
        i.Orden = Today.Month
        i.Monto = proyeccion
        i.Serie = MonthName(i.Orden)

        i.Cartas = c1 + c2 + c3 + c4
        i.NetoFinal = neto1 + neto2 + neto3 + neto4

        lista.Add(i)


        'i = New tipoloco
        'i.ano = Today.Year
        'i.mes = "cartas por facturar" 'MonthName(Today.Month)
        'i.orden = Today.Month
        'i.monto = pv1 * 1.21 * 666
        'i.serie = "agosto"
        'lista.Add(i)

        'así definis un tipo anonimo
        Dim lklk = New With {.s = 3, .sssss = 235435}
        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////





        Dim q2 = From l In lista Select Monto = l.Monto, Mes = l.Mes, Ano = l.Ano, Orden = l.Orden, Serie = l.Serie 'ojo que es CaseSensitive!!!!
        'Mes
        'ano tarifa netofinal precio

        RebindReportViewerLINQ("ProntoWeb\Informes\Proyección de facturación.rdl", lista.ToDataTable)




    End Sub





    Function AgregarALaTandaDeFacturacionAutomatica(ByVal g As GridView, ByVal sc As String, ByVal sesionIdentificador As String) As String



        Dim sTitulo As String = ""
        Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        Dim l = CartasLINQlocalSimplificadoTipadoConCalada(HFSC.Value, _
                           "", "", "", 1, 40000, _
                            CartaDePorteManager.enumCDPestado.NoFacturadas, "", idVendedor, idCorredor, _
                           idDestinatario, idIntermediario, _
                           idRComercial, idArticulo, idProcedencia, idDestino, _
                           IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                           cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text) _
                        .Where(Function(x) x.IdFacturaImputada <= 0).Select(Function(i) i.IdCartaDePorte).ToList()

        'Dim l '= TraerLista(g)




        If l.Count = 0 And False Then Throw New Exception("No hay cartas seleccionadas")

        ErrHandler2.WriteError("Cartas elegidas " & l.Count)

        'Dim db As New LinqCartasPorteDataContext(Encriptar(sc))

        Dim a As wGrillaPersistencia


        ExecDinamico(sc, "delete wGrillaPersistencia where Sesion='" & sesionIdentificador & "'") 'cómo refrescar?


        Dim dt = ExecDinamico(sc, "SELECT * from  wGrillaPersistencia where 1=0")



        For Each i In l
            Dim r = dt.NewRow
            r("IdRenglon") = i
            r("Sesion") = sesionIdentificador
            r("Tilde") = True
            dt.Rows.Add(r)
        Next

        Dim sLista = String.Join(",", l.Select(Function(x) x.ToString).ToArray)


        Using destinationConnection As SqlConnection = New SqlConnection(Encriptar(sc))
            destinationConnection.Open()

            ' Set up the bulk copy object. 
            ' The column positions in the source data reader 
            ' match the column positions in the destination table, 
            ' so there is no need to map columns.
            Using bulkCopy As SqlBulkCopy = New SqlBulkCopy(destinationConnection)
                bulkCopy.DestinationTableName = "dbo.wGrillaPersistencia"

                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdRenglon", "IdRenglon"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Sesion", "Sesion"))
                bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Tilde", "Tilde"))

                Try
                    ' Write from the source to the destination.
                    bulkCopy.WriteToServer(dt)
                Catch ex As Exception
                    Console.WriteLine(ex.ToString)  'que no te confunda el orden de los colid. Por ejemplo, Titular era el 11. Es decir, depende del datatable. No?
                    ErrHandler2.WriteError(ex)
                    Throw
                End Try

            End Using
        End Using


        Return sLista
    End Function




    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        EmparchadorDeTarifasVaciasDeSubcontratistas(HFSC.Value)
    End Sub

    Public Shared Sub EmparchadorDeTarifasVaciasDeSubcontratistas(ByVal SC)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))


        Dim q = (From cdp In db.CartasDePortes _
                 Join dest In db.WilliamsDestinos On cdp.Destino Equals dest.IdWilliamsDestino _
                 Where _
                     (cdp.IdFacturaImputada Is Nothing Or cdp.IdFacturaImputada = 0 Or cdp.IdFacturaImputada = -1) _
                 And (cdp.Anulada <> "SI") _
                 And (cdp.Subcontr1 Is Nothing Or cdp.Subcontr2 Is Nothing) _
                        Select cdp, subcontr1Default = dest.Subcontratista1, subcontr2Default = dest.Subcontratista2).ToList


        'cdp.IdCartaDePorte, cdp.Destino, _
        'cdp.Subcontr1, cdp.Subcontr2, _
        'cdp.TarifaSubcontratista1, cdp.TarifaSubcontratista2, _
        'subcontr1Default = dest.Subcontratista1).ToList

        If True Then
            For Each i In q
                i.cdp.Subcontr1 = i.subcontr1Default
                i.cdp.Subcontr2 = i.subcontr2Default
                'i.cdp.TarifaSubcontratista2 = subc
                'i.cdp.TarifaSubcontratista1 = db.wTarifaWilliams(cdp.Subcontr1, , , )
                'i.cdp.TarifaSubcontratista2=
            Next

            db.SubmitChanges()

        Else

            Dim a As wGrillaPersistencia

            'ExecDinamico(SC, "delete wGrillaPersistencia")
            Dim dt '= ExecDinamico(SC, "SELECT * from  wGrillaPersistencia where 1=0")

            'For Each i In l
            '    Dim r = dt.NewRow
            '    r("IdRenglon") = i
            '    r("Sesion") = sesionIdentificador
            '    r("Tilde") = True
            '    dt.Rows.Add(r)
            'Next

            Using destinationConnection As SqlConnection = New SqlConnection(Encriptar(SC))
                destinationConnection.Open()

                ' Set up the bulk copy object. 
                ' The column positions in the source data reader 
                ' match the column positions in the destination table, 
                ' so there is no need to map columns.
                Using bulkCopy As SqlBulkCopy = New SqlBulkCopy(destinationConnection)
                    bulkCopy.DestinationTableName = "dbo.wGrillaPersistencia"

                    bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("IdRenglon", "IdRenglon"))
                    bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Sesion", "Sesion"))
                    bulkCopy.ColumnMappings.Add(New SqlBulkCopyColumnMapping("Tilde", "Tilde"))

                    Try
                        ' Write from the source to the destination.
                        bulkCopy.WriteToServer(dt)
                    Catch ex As Exception
                        Console.WriteLine(ex.ToString)  'que no te confunda el orden de los colid. Por ejemplo, Titular era el 11. Es decir, depende del datatable. No?
                        ErrHandler2.WriteError(ex)
                        Throw
                    End Try

                End Using
            End Using
        End If

    End Sub






    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Private Sub EstadisticasDescargasSucursalModo()
        Throw New NotImplementedException
    End Sub
















End Class





Class tipoloco
    Public Mes ' As String
    Public Ano 'As String
    Public Tarifa 'As Decimal?
    Public NetoFinal 'As Decimal?

    Public Precio 'As Decimal?
    Public FechaDescarga 'As Date?
    Public Monto ' As Decimal?
    Public Orden 'As Integer?
    Public Serie 'As String
    Public Cartas 'As Integer?
End Class

'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
















