﻿Imports Pronto.ERP.Bll
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

Imports Excel = Microsoft.Office.Interop.Excel
Imports System.Data.SqlClient

Imports CartaDePorteManager

Imports LogicaInformesWilliamsGerenc
Imports Pronto.ERP.Bll.EntidadManager

Imports StackExchange.Profiling



Partial Class CartaDePorteInformesFertilizantes
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


        optDivisionSyngenta.DataTextField = "desc"
        optDivisionSyngenta.DataValueField = "desc"
        'optDivisionSyngenta.DataValueField = "idacopio"
        optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(HFSC.Value).Select(Function(z) New With {z.desc})
        optDivisionSyngenta.DataBind()


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        cmbPuntoVenta.DataTextField = "PuntoVenta"
        cmbPuntoVenta.DataValueField = "PuntoVenta"
        cmbPuntoVenta.DataBind()
        cmbPuntoVenta.SelectedIndex = 0
        cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
        cmbPuntoVenta.SelectedIndex = 0

        If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
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
                Case "Cupos por producto"


                    Dim db2 As ProntoMVC.Data.Models.DemoProntoEntities = _
                           New ProntoMVC.Data.Models.DemoProntoEntities(
                               ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(
                                   Encriptar(HFSC.Value)))

                    Dim q = From c In db2.FertilizantesCupos _
                            Select
                            c.NumeradorTexto,
                            Articulo = If(c.Articulo Is Nothing, "", c.Articulo.Descripcion)

                    Dim stock = ExistenciasAlDiaPorPuerto(Encriptar(HFSC.Value), Now, 1, 1, 1)

                    '                    GeneroDataTablesDeMovimientosDeStock()



                    Dim serv As String

                    If System.Diagnostics.Debugger.IsAttached() Then
                        serv = "http://localhost:48391/ProntoWeb"
                    Else
                        serv = "http://prontoclientes.williamsentregas.com.ar/"
                    End If

                    RebindReportViewerLINQ("ProntoWeb\Informes\Cupos por producto.rdl", q) ', New ReportParameter() {New ReportParameter("sServidor", serv)})



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




    Shared Sub GeneroDataTablesDeMovimientosDeStock(ByRef dtCDPs As DataTable, ByRef dtRenglonUnicoConLasExistencias As Object, _
                                             ByRef dtMOVs As Object, _
                                             ByVal idDestinatario As Integer, ByVal idDestino As Integer, ByVal idarticulo As Integer, _
                                             ByVal desde As Date, ByVal hasta As Date, ByVal sc As String)


        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=10263  rechazadas están saliendo en el informe de existencias
        'no tengo que incluir los rechazos!

        'aca uso el _informes, y en el .rdl uso _informescorregido ....
        'efectivamente, ahí usa VendedorDesc en lugar de TitularDesc....


        Dim sTitulo As String = ""

        dtCDPs = CartaDePorteManager.GetDataTableFiltradoYPaginado(sc, _
                "", "", "", 1, 0, _
                CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1, _
                idDestinatario, -1, _
                -1, idarticulo, -1, idDestino, _
                "1", "Export", _
                 desde, hasta, -1, sTitulo, , , , , , , , , )



        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))


        Dim movs = (From i In db.CartasPorteMovimientos _
                    Join c In db.linqClientes On i.IdExportadorOrigen Equals c.IdCliente _
                    Where _
                        (i.FechaIngreso >= desde And i.FechaIngreso <= hasta) _
                        And (i.IdArticulo = idarticulo) _
                        And (i.Puerto = idDestino) _
                        And ( _
                                (i.IdExportadorOrigen = idDestinatario) _
                                Or (i.IdExportadorDestino = idDestinatario) _
                        ) _
                        And If(i.Anulada, "NO") <> "SI" _
                    Select Tipo = f(i.Tipo), _
                                ExportadorOrigen = c.RazonSocial, i.FechaIngreso, _
                                i.Entrada_o_Salida, i.Cantidad, i.Vapor, i.Contrato, i.IdCDPMovimiento, i.Numero _
                ).ToList







        dtMOVs = movs

        'Dim dsVistaMOVS = CDPStockMovimientoManager.GetList(sc)







        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        'mejunje: le estoy pasando un segundo dataset con las existencias calculadas
        'en VBasic. Tambien se podría usar la funcion SQL wExistencias......, pero es mas
        'piola calcularlo por visual. -Sí, pero así haces al informe dependiente del codigo... qué
        'se hace en un caso así?
        '/////////////////////////////////////////////////////

        'dt2 = New DataTable
        'dt2.Columns.Add("Existencias", GetType(Double))
        'dt2.Rows.Add(dt2.NewRow)
        ''dt2 = EntidadManager.ExecDinamico(HFSC.Value, "SELECT dbo.wExistenciasCartaPorteMovimientos (null,null,null) as Existencias")
        Dim ex = ExistenciasAlDiaPorPuerto(sc, desde, idarticulo, idDestino, idDestinatario)

        dtRenglonUnicoConLasExistencias = (From i In db.CartasDePortes.Take(1) Select Existencias = ex, CampoDummyParaQueGuardeElNombre = 0).ToList


        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////






    End Sub
    Shared Function ExistenciasAlDiaPorPuerto(ByVal sc As String, ByVal Fecha As DateTime, _
                                              ByVal IdArticulo As Integer, ByVal IdDestinoWilliams As Integer, _
                                              ByVal iddestinatario As Integer) As Double

        Dim entradasMOV, entradasCDP, salidasMOV As Double
        Dim db As New LinqCartasPorteDataContext(Encriptar(sc))


        '///////////////////////////////////////////////
        'entradas por cartas de porte
        '///////////////////////////////////////////////

        Dim q = Aggregate i In db.CartasDePortes _
                Where (If(i.FechaDescarga, i.FechaDeCarga) < Fecha) _
                    And i.Exporta = "SI" And i.Anulada <> "SI" _
                    And If(i.Destino, 0) = IdDestinoWilliams _
                    And If(i.IdArticulo, 0) = IdArticulo _
                    And If(i.Entregador, 0) = iddestinatario _
                Into Sum(CType(i.NetoProc, Decimal?))

        entradasCDP = iisNull(q, 0)


        '///////////////////////////////////////////////
        'movimientos:
        '///////////////////////////////////////////////


        Dim temp = From i In db.CartasPorteMovimientos _
                   Where _
                        (i.FechaIngreso < Fecha) _
                    And (i.IdArticulo = IdArticulo) _
                    And (i.Puerto = IdDestinoWilliams) _
                    And ( _
                            (i.IdExportadorOrigen = iddestinatario) _
                            Or (i.IdExportadorDestino = iddestinatario) _
                        ) _
                    And If(i.Anulada, "NO") <> "SI"

        Dim etemp = temp.Where(Function(i) ((i.Entrada_o_Salida = 1) And (i.FechaIngreso < Fecha))).DefaultIfEmpty
        Debug.Print(etemp.Count)
        entradasMOV = etemp.Sum(Function(i) If(i.Cantidad, 0))



        Dim stemp = temp.Where(Function(i) ((i.Entrada_o_Salida = 2) And (i.FechaIngreso < Fecha))).DefaultIfEmpty
        Debug.Print(stemp.Count)
        salidasMOV = stemp.Sum(Function(i) If(i.Cantidad, 0))


        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////




        Return entradasCDP + entradasMOV - salidasMOV

    End Function
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












