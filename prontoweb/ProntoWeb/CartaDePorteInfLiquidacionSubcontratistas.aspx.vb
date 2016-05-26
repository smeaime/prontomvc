Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports System.Data
Imports System.Linq

Imports System.Data.Linq
Imports System.Xml.Linq

Imports Microsoft.Reporting.WebForms
Imports ProntoFuncionesGenerales

Imports Pronto.ERP.Bll.SincronismosWilliamsManager
Imports Pronto.ERP.Bll.InformesCartaDePorteManager

Imports System.Xml
Imports System.Collections.Generic

Imports Excel = Microsoft.Office.Interop.Excel
Imports System.Data.SqlClient

Imports CartaDePorteManager

Imports LogicaInformesWilliams
Imports Pronto.ERP.Bll.EntidadManager


Partial Class CartaDePorteInfLiquidacionSubcontratistas
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


        AutoCompleteExtender2.ContextKey = HFSC.Value
        AutoCompleteExtender9.ContextKey = HFSC.Value
        AutoCompleteExtender26.ContextKey = HFSC.Value

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

        Dim a = New String() {"Mariano", "Andres", "hwilliams", "factbsas", "factas", "factbb", "factbsas", "factsl", "cflores", "lcesar", "dberzoni", "mgarcia"}

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

        End If




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


        cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        '  cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
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
        Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


        If txtFechaDesde.Text <> "" And iisValidSqlDate(txtFechaDesde.Text) Is Nothing Then
            MsgBoxAlert("La fecha inicial es inválida")
        End If

        If txtFechaHasta.Text <> "" And iisValidSqlDate(txtFechaHasta.Text) Is Nothing Then
            MsgBoxAlert("La fecha final es inválida")
        End If






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


            Dim f = LiquidacionDeSubcontratistas()

            


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



    Const IdWilliams = 12454
    Const IdCorredorBLD = 43

    Shared Function EsExporta(exporta As String, corredor As Long, entregador As Long) As Boolean
        'http://bdlconsultores.sytes.net/Consultas/Admin/VerConsultas1.php?recordid=13216
        'En el informe de liquidación de subcontratistas, las cartas de porte de corredor BLD y un entregador distinto de Williams deben tomarse como de exportación


        Return (exporta = "SI" Or (corredor = IdCorredorBLD And (entregador <> IdWilliams Or entregador <= 0)))


    End Function





    Function LiquidacionDeSubcontratistas() As String


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        Dim ms As String = ""
        'el filtro tiene que incluir duplicados (el True despues de syngenta)
        Try
            LogicaFacturacion.CorrectorParcheSubnumeroFacturacion(HFSC.Value, ms)
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
        Dim idDestino As Integer = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        Dim idSubcontr As Integer = BuscaIdClientePrecisoConCUIT(txtSubcontr1.Text, HFSC.Value)
        Dim pv As Integer = cmbPuntoVenta.SelectedValue

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)


        'supongo que hay quilombo en el join del detalle de precios        'http://stackoverflow.com/questions/492683/how-to-limit-a-linq-left-outer-join-to-one-row
        'no puedo usae el take(1) en sql2000!!!! -y si agrupo esos registros con un Average?  .Average(Function(i) i.PrecioCaladaLocal).
        Dim qq = From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = CInt(cdp.Calidad)).DefaultIfEmpty _
                From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From clisub1 In db.linqClientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr1, dest.Subcontratista1)).DefaultIfEmpty _
                From clisub2 In db.linqClientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr2, dest.Subcontratista2)).DefaultIfEmpty _
                From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty _
                From pd1 In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo)).DefaultIfEmpty _
                From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty _
                From pd2 In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios And (i.IdArticulo = cdp.IdArticulo)).DefaultIfEmpty _
                Where _
                 (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
                    And (cdp.Anulada <> "SI") _
                    And ((DropDownList2.Text = "Ambos") Or (DropDownList2.Text = "Entregas" _
                            And If(cdp.Exporta, "NO") = "NO") Or (DropDownList2.Text = "Export" And If(cdp.Exporta, "NO") = "SI") _
                        ) _
                    And (cdp.Vendedor.HasValue And cdp.Corredor.HasValue And cdp.Entregador.HasValue) _
                  And (idVendedor = -1 Or cdp.Vendedor = idVendedor) _
                  And (idCorredor = -1 Or cdp.Corredor = idCorredor) _
                  And (idDestinatario = -1 Or cdp.Entregador = idDestinatario) _
                  And (idIntermediario = -1 Or cdp.CuentaOrden1 = idIntermediario) _
                  And (idArticulo = -1 Or cdp.IdArticulo = idArticulo) _
                  And (idDestino = -1 Or cdp.Destino = idDestino) _
                  And (idSubcontr = -1 Or cdp.Subcontr1 = idSubcontr Or cdp.Subcontr2 = idSubcontr) _
                  And (pv = -1 Or cdp.PuntoVenta = pv) _
                Select _
                    cdp.NumeroCartaDePorte, _
                    cdp.IdCartaDePorte, _
                    cdp.FechaDescarga, _
                    cdp.NetoFinal, _
                    cdp.Subcontr1, _
                    cdp.Subcontr2, _
                    cdp.ExcluirDeSubcontratistas, _
                    cdp.SubnumeroDeFacturacion, _
                    VendedorDesc = clitit.RazonSocial, _
                    CuentaOrden1Desc = cliint.RazonSocial, _
                    CuentaOrden2Desc = clircom.RazonSocial, _
                    CorredorDesc = corr.Nombre, _
                    EntregadorDesc = clidest.RazonSocial, _
                    ProcedenciaDesc = loc.Nombre, _
                    DestinoDesc = dest.Descripcion, _
                    Subcontr1Desc = clisub1.RazonSocial, _
                    Subcontr2Desc = clisub2.RazonSocial, _
                   tarif1 = CDec(If(IIf( _
                                    (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                                        , pd1.PrecioCaladaExportacion, pd1.PrecioCaladaLocal), 0)), _
                   tarif2 = CDec(If(IIf( _
                                    (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                                            , pd2.PrecioDescargaExportacion, pd2.PrecioDescargaLocal), 0)), _
                    Exporta = cdp.Exporta, _
                    cdp.Corredor, _
                    cdp.IdClienteEntregador
        'IdListaPreciosDetalle1 = pd1.IdListaPreciosDetalle, IdListaPreciosDetalle2 = pd2.IdListaPreciosDetalle



        'Dim a = qq.FirstOrDefault


        'http://stackoverflow.com/questions/5568860/linq-to-sql-join-issues-with-firstordefault




        'Dim qq2 = qq.ToList
        Dim aa = qq
        Dim filtr As Integer
        If False Then
            'que pasa con las cartas que tienen varios subnumerodefacturacion y el 0 anulado? y no se puede tirar un listado viendo el subnumerodefac?


            aa = qq.Where(Function(i) False Or (If(i.ExcluirDeSubcontratistas, "NO") = "NO" And If(i.SubnumeroDeFacturacion, 0) <= 0))
            filtr = qq.Count - aa.Count
        Else

        End If












        Dim q = From i In aa _
                Group By _
                    i.IdCartaDePorte, _
                    i.NumeroCartaDePorte, _
                    i.FechaDescarga, _
                    i.NetoFinal, _
                    i.Subcontr1, _
                    i.Subcontr2, _
                    i.ExcluirDeSubcontratistas, _
                    i.SubnumeroDeFacturacion, _
                    i.VendedorDesc, _
                    i.CuentaOrden1Desc, _
                    i.CuentaOrden2Desc, _
                    i.CorredorDesc, _
                    i.EntregadorDesc, _
                    i.ProcedenciaDesc, _
                    i.DestinoDesc, _
                    i.Subcontr1Desc, _
                    i.Subcontr2Desc, _
                    i.Exporta, _
                    i.Corredor, _
                    i.IdClienteEntregador
                Into Group _
                Select New With { _
                    IdCartaDePorte, _
                    NumeroCartaDePorte, _
                    FechaDescarga, _
                    NetoFinal, _
                    Subcontr1, _
                    Subcontr2, _
                    ExcluirDeSubcontratistas, _
                    SubnumeroDeFacturacion, _
                    VendedorDesc, _
                    CuentaOrden1Desc, _
                    CuentaOrden2Desc, _
                    CorredorDesc, _
                    EntregadorDesc, _
                    ProcedenciaDesc, _
                    DestinoDesc, _
                    Subcontr1Desc, _
                    Subcontr2Desc, _
                    Exporta, _
                    .tarif1 = Group.Average(Function(x) x.tarif1), _
                    .tarif2 = Group.Average(Function(x) x.tarif2), _
                    Corredor, _
                    IdClienteEntregador
                     }
        'IdListaPreciosDetalle1, IdListaPreciosDetalle2






        Dim a = From x In q Order By x.FechaDescarga, x.IdCartaDePorte Select x.NumeroCartaDePorte.ToString & " " & x.IdCartaDePorte.ToString & " " & x.tarif1 & " " & x.tarif2 ' & " " & x.IdListaPreciosDetalle1 & " " & x.IdListaPreciosDetalle2

        ErrHandler2.WriteError(vbCrLf & Join(a.ToArray, vbCrLf))












        Dim q4 As List(Of infLiqui) = (From cdp In q _
                    Where (idSubcontr = -1 Or cdp.Subcontr1 = idSubcontr) _
                    Select New infLiqui With { _
                        .DestinoDesc = cdp.DestinoDesc & " Calada" & IIf( _
                            (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                                   , " - Export.", " - Entrega"), _
                        .SubcontrDesc = cdp.Subcontr1Desc, _
                        .NetoPto = cdp.NetoFinal, _
                        .Tarifa = cdp.tarif1, _
                        .Comision = cdp.NetoFinal * cdp.tarif1 / 1000}).ToList

        Dim q5 As List(Of infLiqui) = (From cdp In q _
                   Where (idSubcontr = -1 Or cdp.Subcontr2 = idSubcontr) _
                    Select New infLiqui With { _
                        .DestinoDesc = cdp.DestinoDesc & " Balanza" & IIf( _
                                      (cdp.Exporta = "SI" Or (cdp.Corredor = IdCorredorBLD And (cdp.IdClienteEntregador <> IdWilliams Or cdp.IdClienteEntregador <= 0))) _
                                    , " - Export.", " - Entrega"), _
                        .SubcontrDesc = cdp.Subcontr2Desc, _
                        .NetoPto = cdp.NetoFinal, _
                        .Tarifa = cdp.tarif2, _
                        .Comision = cdp.NetoFinal * cdp.tarif2 / 1000}).ToList


        Dim q6 As New List(Of infLiqui) '= q4.Union(q5)
        q6.AddRange(q4)
        q6.AddRange(q5)



        Dim q3 = From i In q6 _
                Group i By DestinoDesc = i.DestinoDesc, SubcontrDesc = i.SubcontrDesc, Tarifa = i.Tarifa Into g = Group _
                Select DestinoDesc = DestinoDesc, SubcontrDesc = SubcontrDesc, Tarifa = Tarifa, _
                NetoPto = g.Sum(Function(i) i.NetoPto), Comision = g.Sum(Function(i) i.Comision), CantCartas = g.Count


        ErrHandler2.WriteError("     Excluidas por nofacturarasubcontratistas o duplicadas: " & filtr)


        Dim titulo As String = NombreCliente(HFSC.Value, idSubcontr) ' & "     Excluidas por nofacturarasubcontratistas o duplicadas: " & filtr ' & Join(aa.Select(Function(x) x.NumeroCartaDePorte.ToString).ToArray, ",")

        Dim params = New ReportParameter() { _
                        New ReportParameter("Concepto1", txtConcepto1.Text), _
                        New ReportParameter("titulo", If(titulo, "")), _
                        New ReportParameter("Concepto2", txtConcepto2.Text), _
                        New ReportParameter("Concepto1Importe", Val(txtConcepto1Importe.Text)), _
                        New ReportParameter("Concepto2Importe", Val(txtConcepto2Importe.Text)) _
                    }




        'RebindReportViewerLINQ("ProntoWeb\Informes\Valorizado por SubContratista.rdl", q2.ToList)
        Dim f = RebindReportViewerLINQ_Excel("ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q3.ToList, , params)
        Return f


        'la funcion ComisionesPorDestinoYArticulo hacía un UNION con las 2 tarifas de subcontratistas

        '        Unificar los informes \"Liquidacion de subcontratistas\" y \"Comisiones Por Puerto y Cereal\"
        '        Debe quedar uno, de nombre \"Liquidacion de subcontratistas\".
        'En el caso que haya Cartas de Porte de exportacion, mostrarlas separadas de las que no lo son, con la tarifa correspondiente





    End Function


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

    Protected Sub txtDestino_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestino.TextChanged
        bRecargarInforme = True

    End Sub




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
                txtFechaDesde.Visible = True
                txtFechaHasta.Visible = True
        End Select


    End Sub


End Class
















