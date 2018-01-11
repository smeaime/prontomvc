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


Partial Class CartaDePorteAnalisisTarifa
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




    Function AnalisisTarifa() As String


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        Dim ms As String = ""
        'el filtro tiene que incluir duplicados (el True despues de syngenta)
        Try
            'LogicaFacturacion.CorrectorSubnumeroFacturacion(HFSC.Value, ms)


            'If Not Debugger.IsAttached Then
            '    EntidadManager.ExecDinamico(HFSC.Value, "RefrescarCartasPorteDetalleFacturas", 300)
            'End If



        Catch ex As Exception
            MandarMailDeError(ex)
        End Try


        Dim sTitulo As String = ""
        Dim idVendedor As Integer = -1  '= BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor As Integer = -1 '= BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario As Integer = -1 ' = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial As Integer = -1  '= BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idDestinatario As Integer = -1 '= BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo As Integer = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia As Integer = -1 '= BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        'Dim idDestino As Integer = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        'Dim idSubcontr As Integer = BuscaIdClientePrecisoConCUIT(txtSubcontr1.Text, HFSC.Value)
        'Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        Dim modo = DropDownList2.Text


        Dim minimatarifa = Val(txtConcepto1Importe.Text)
        Dim max = Val(txtConcepto2Importe.Text)

        'Dim a = qq.FirstOrDefault


        'http://stackoverflow.com/questions/5568860/linq-to-sql-join-issues-with-firstordefault

        'http://localhost:48391/ProntoWeb/ProntoWeb/CartaDePorteAnalisisTarifa.aspx?desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos&min=1.44&max=30.77

        Dim tit = ""

        Dim cartasFiltradas = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada(HFSC.Value, _
            "", "", "", 1, 100000, CartaDePorteManager.enumCDPestado.Facturadas, _
             "", -1, -1, _
            -1, -1, -1, _
            idArticulo, -1, -1, _
            CartaDePorteManager.FiltroANDOR.FiltroAND, modo, _
           fechadesde, _
           fechahasta, -1, _
             tit, "", False, "", db) _
            .Where(Function(x) x.IdFacturaImputada > 0) _
            .Select(Function(x) New With {x.IdCartaDePorte, x.NumeroCartaDePorte, x.ClienteFacturado, x.PrecioUnitarioTotal, x.NetoFinal})



        Dim cartasagrupadas = (From c In cartasFiltradas _
                              Group c By PrecioUnitarioTotal = c.PrecioUnitarioTotal, _
                                            ClienteFacturado = c.ClienteFacturado _
                              Into g = Group _
                              Select New With { _
                                    .PrecioUnitarioTotal = PrecioUnitarioTotal, _
                                    .ClienteFacturado = ClienteFacturado, _
                                    .Cartas = g.Count(), _
                                    .NetoFinal = g.Sum(Function(i) i.NetoFinal) / 1000 _
                              }).ToList()



        ErrHandler2.WriteError("Cartas filtradas en analisis de tarifa: " & String.Join(",", cartasFiltradas.Select(Function(c) c.IdCartaDePorte.ToString())))


        Dim cartasConEsaTarifa = cartasagrupadas _
                        .Where(Function(x) x.PrecioUnitarioTotal >= minimatarifa And x.PrecioUnitarioTotal <= max)



        Dim cuantas = cartasagrupadas.Sum(Function(x) x.Cartas)
        Dim total = cartasagrupadas.Sum(Function(x) x.NetoFinal)

        Dim cuantas2 = cartasConEsaTarifa.Sum(Function(x) x.Cartas)
        Dim total2 = cartasConEsaTarifa.Sum(Function(x) x.NetoFinal)



        Dim titulo As String '= NombreCliente(HFSC.Value, idSubcontr) ' & "     Excluidas por nofacturarasubcontratistas o duplicadas: " & filtr ' & Join(aa.Select(Function(x) x.NumeroCartaDePorte.ToString).ToArray, ",")

        titulo = FF2(total) + " Tn en " + cuantas.ToString + " cartas facturadas " + vbCrLf + FF2(total2.ToString) + " Tn en " + cuantas2.ToString + " cartas dentro de ese rango (" + FF2(100 * total2 / IIf(total > 0, total, 0.00001)) + "%)"

        Dim params = New ReportParameter() { _
                        New ReportParameter("Concepto1", "sdfsfd"), _
                        New ReportParameter("titulo", If(titulo, "")), _
                        New ReportParameter("Concepto2", "sdfsf"), _
                        New ReportParameter("Concepto1Importe", 0), _
                        New ReportParameter("Concepto2Importe", 0) _
                    }




        RebindReportViewerLINQ("ProntoWeb\Informes\Análisis de Tarifa.rdl", cartasagrupadas, cartasagrupadas, , params)
        'Dim f = RebindReportViewerLINQ_Excel("ProntoWeb\Informes\Análisis de Tarifa.rdl", cartasFiltradas.ToList, , params)
        'Return f


        'la funcion ComisionesPorDestinoYArticulo hacía un UNION con las 2 tarifas de subcontratistas

        '        Unificar los informes \"Liquidacion de subcontratistas\" y \"Comisiones Por Puerto y Cereal\"
        '        Debe quedar uno, de nombre \"Liquidacion de subcontratistas\".
        'En el caso que haya Cartas de Porte de exportacion, mostrarlas separadas de las que no lo son, con la tarifa correspondiente





    End Function


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




        'http://localhost:48391/ProntoWeb/CartaDePorteAnalisisTarifa.aspx?desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos&min=1.44&max=30.77



        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////



            Me.Title = "Informes"

            BindTypeDropDown()




            BloqueosDeEdicion()

            txt_AC_Articulo.Text = If(Request.QueryString.Get("idarticulo"), "")
            txtFechaDesde.Text = If(Request.QueryString.Get("desde"), "")
            txtFechaHasta.Text = If(Request.QueryString.Get("hasta"), "")
            DropDownList2.Text = If(Request.QueryString.Get("modo"), "")
            txtConcepto1Importe.Text = If(Request.QueryString.Get("min"), "")
            txtConcepto2Importe.Text = If(Request.QueryString.Get("max"), "")

            refrescaPeriodo()

            '  AsignaInformeAlReportViewer()
        End If



        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnRefrescar)


        AutoCompleteExtender2.ContextKey = HFSC.Value
        'AutoCompleteExtender9.ContextKey = HFSC.Value
        'AutoCompleteExtender26.ContextKey = HFSC.Value

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

        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_InfAnalisisTarifa)

        p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_InfAnalisisTarifa)
        If Not p("PuedeLeer") Then
            MsgBoxAjaxAndRedirect(Me, "No tenés permisos", String.Format("Principal.aspx"))
            'Response.Redirect(String.Format("Principal.aspx"))
            Exit Sub
        End If


        'If Not p("PuedeLeer") Then fff()
        'If Not a.Contains(Session(SESSIONPRONTO_UserName)) Then
        '    'anular la columna de edicion
        '    'getGridIDcolbyHeader(


        '    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=8918
        '    '            Ranking de Cereales
        '    'Ranking de Clientes
        '    'Proyeccion de Facturacion
        '    'Totales Grales por Mes
        '    'Resumen de Facturacion

        'End If




        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////





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



    Sub habilitarFiltros()

    End Sub







    Private Sub BindTypeDropDown()


        'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        'cmbPuntoVenta.DataTextField = "PuntoVenta"
        'cmbPuntoVenta.DataValueField = "PuntoVenta"
        'cmbPuntoVenta.DataBind()
        'cmbPuntoVenta.SelectedIndex = 0
        'cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
        'cmbPuntoVenta.SelectedIndex = 0

        'If If(EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)), New Pronto.ERP.BO.Empleado()) .PuntoVentaAsociado > 0 Then
        '    Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
        '    BuscaTextoEnCombo(cmbPuntoVenta, pventa)
        '    If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
        'End If

    End Sub


    Sub AsignaInformeAlReportViewer(Optional ByVal bDescargaExcel As Boolean = False)
        Dim output As String = ""


        ErrHandler2.WriteError("Generando informe")


        ReportViewer2.Visible = True

        Dim sTitulo As String = ""

        Dim idVendedor '= BuscaIdClientePreciso(txtVendedor.Text, HFSC.Value)
        Dim idCorredor '= BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario ' = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial '= BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar '= BuscaIdClientePreciso(chkClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario '= BuscaIdClientePreciso(txtEntregador.Text, HFSC.Value)
        Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia ' = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        ' Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        If txtFechaDesde.Text <> "" And iisValidSqlDate(txtFechaDesde.Text) Is Nothing Then
            MsgBoxAlert("La fecha inicial es inválida")
        End If

        If txtFechaHasta.Text <> "" And iisValidSqlDate(txtFechaHasta.Text) Is Nothing Then
            MsgBoxAlert("La fecha final es inválida")
        End If






        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7789





        'Dim estadofiltro As CartaDePorteManager.enumCDPestado
        'Select Case cmbEstado.Text  '
        '    Case "TodasMenosLasRechazadas"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas
        '    Case "Incompletas"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.Incompletas
        '    Case "Posición"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.Posicion
        '    Case "Descargas"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
        '    Case "Facturadas"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.Facturadas
        '    Case "NoFacturadas"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.NoFacturadas
        '    Case "Rechazadas"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.Rechazadas
        '    Case "EnNotaCredito"
        '        estadofiltro = CartaDePorteManager.enumCDPestado.FacturadaPeroEnNotaCredito
        '    Case Else
        '        Return
        'End Select







        'lblRazonSocial.Text


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



            'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Todas", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
            'sTitulo = ""
            'Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
            '                "", "", "", 1, 0, _
            '                estadofiltro, "", idVendedor, idCorredor, _
            '                idDestinatario, idIntermediario, _
            '                idRComercial, idArticulo, idProcedencia, idDestino, _
            '                "1", DropDownList2.Text, _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
            '                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
            '                cmbPuntoVenta.SelectedValue, sTitulo)


            'dt = DataTableWHERE(dt, sWHERE)

            'ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
            '            "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", _
            '                    dt, Nothing, , , sTitulo)


            Dim f = AnalisisTarifa()




        Catch ex As Exception
            Dim s As String = "Hubo un error al generar el informe. " & ex.ToString
            ErrHandler2.WriteError(s)
            MandarMailDeError(s)
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



    Class infLiqui
        Public DestinoDesc
        Public SubcontrDesc
        Public NetoPto
        Public Tarifa
        Public Comision As Decimal
    End Class







    Protected Sub txt_AC_Articulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txt_AC_Articulo.TextChanged

        bRecargarInforme = True
    End Sub



    Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
        bRecargarInforme = True
    End Sub

    Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
        bRecargarInforme = True
    End Sub

    'Protected Sub txtDestino_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestino.TextChanged
    '    bRecargarInforme = True

    'End Sub




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


    Function RebindReportViewerLINQ(ByVal rdlFile As String, ByVal q As Object, q2 As Object, Optional ByRef ArchivoExcelDestino As String = "", Optional parametros As IEnumerable(Of ReportParameter) = Nothing) As String
        'http://forums.asp.net/t/1183208.aspx

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local
            .Visible = True

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", q)) '//the first parameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet2", q2)) '//the first parameter is the name of the datasource which you bind your report table to.

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



    Function RebindReportViewerLINQ_Excel(ByVal rdlFile As String, ByVal q As Object, Optional ByRef ArchivoExcelDestino As String = "", Optional parametros As IEnumerable(Of ReportParameter) = Nothing) As String


        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = Path.GetTempPath & "Informe " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        'Dim vFileName As String = "c:\archivo.txt"
        ' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)


        'http://forums.asp.net/t/1183208.aspx

        With ReportViewer2
            .ProcessingMode = ProcessingMode.Local
            .Visible = True

            .Reset()


            With .LocalReport
                .ReportPath = rdlFile
                .EnableHyperlinks = True

                .DataSources.Clear()

                '.DataSources.Add(New ReportDataSource("DataSet1", TraerDataset)) '//the first patameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet1", q)) '//the first parameter is the name of the datasource which you bind your report table to.
                .DataSources.Add(New ReportDataSource("DataSet2", q)) '//the first parameter is the name of the datasource which you bind your report table to.

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
                Throw
            End Try


            Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()



        End With

        Return ArchivoExcelDestino
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
                If txtFechaDesde.Text = "" Then txtFechaDesde.Text = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
                If txtFechaHasta.Text = "" Then txtFechaHasta.Text = GetLastDayInMonth(DateAdd(DateInterval.Month, -1, Today))
                txtFechaDesde.Visible = True
                txtFechaHasta.Visible = True
        End Select


    End Sub

    Private Function cmbPuntoVenta() As Object
        ' Throw New NotImplementedException
    End Function


End Class
















