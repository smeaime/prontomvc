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

Imports Excel = Microsoft.Office.Interop.Excel
Imports System.Data.SqlClient

Imports CartaDePorteManager

Imports LogicaInformesWilliams
Imports Pronto.ERP.Bll.EntidadManager


Partial Class CartaDePorteInformesConReportViewerSincronismos
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


        If Session(SESSIONPRONTO_UserName) <> "Mariano" Then Button1.Visible = False


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            Me.Title = "Informes de CDPs"

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

        Dim ffa = New String() {"mgarcia", "dberzoni", "lcesar", "mcabrera", "cflores", "Mariano"}
        If ffa.Contains(Session(SESSIONPRONTO_UserName)) Then
            cmbInforme.Items.FindByText("Totales generales por mes").Enabled = True
        End If




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
            'ErrHandler.WriteAndRaiseError(ex.Message)
            ErrHandler.WriteError(ex.Message)
            'MsgBoxAjax(Me, ex.Message)
            Return
        End Try



    End Sub




    Protected Sub btnDescargaSincro_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDescargaSincro.Click
        Dim output As String = ""

        'Dim dt = EntidadManager.ExecDinamicoConStrongTypedDataset(HFSC.Value, strSQLsincronismo)

        ' cómo le digo al dataset tipado a qué base conectarse?
        'http://blogs.msdn.com/b/marcelolr/archive/2010/04/06/changing-the-connection-string-for-typed-datasets.aspx

        'Interesante!!! Uso una RuntimeConnectionString !!! -mmmm, cambiar esos datos en tiempo
        'de ejecucion???? No pinta muy bueno.... -Bueno! es un hack....
        'http://rajmsdn.wordpress.com/2009/12/09/strongly-typed-dataset-connection-string/
        'http://stackoverflow.com/questions/695491/best-way-to-set-strongly-typed-dataset-connection-string-at-runtime
        'http://forums.asp.net/p/1068777/1553283.aspx


   

        If cmbSincronismo.Text = "" Then
            MsgBoxAjax(Me, "Elija un sincronismo")
            Return
        End If


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


        Dim sForzarNombreDescarga As String = ""

        ErrHandler.WriteError("Generando sincro para " & cmbSincronismo.Text & " " & _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & " " & _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & " " & _
                                idVendedor & " " & idCorredor & " " & idDestinatario & " " & idIntermediario & " " & _
                                idRComercial & " " & idArticulo & " " & idProcedencia & " " & idDestino)


        Using ds As New WillyInformesDataSet





            '// Customize the connection string.
            Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value)) ' Properties.Settings.Default.DistXsltDbConnectionString)
            'builder.DataSource = builder.DataSource.Replace(".", Environment.MachineName)
            Dim desiredConnectionString = builder.ConnectionString

            '// Set it directly on the adapter.

            'esta seria la cuestion, aca llega con 30 segs nada mas de timeout, diferente del timeout de la conexion
            Try
                'http://blogs.msdn.com/b/smartclientdata/archive/2005/08/16/increasetableadapterquerytimeout.aspx

                Using adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter
                    adapter.SetCommandTimeOut(60)

                    adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
                    'adapter.Connection..Adapter.SelectCommand.CommandTimeout = 60

                    adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                idVendedor, idCorredor, idDestinatario, idIntermediario, _
                                idRComercial, idArticulo, idProcedencia, idDestino, CartaDePorteManager._CONST_MAXROWS, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas)
                End Using

            Catch ex As OutOfMemoryException
                '       puede ser timeout. en este y en el caso del outofmemory, logear los parametros

                ErrHandler.WriteAndRaiseError(ex)
                MandarMailDeError(ex)

            Catch ex As Exception
                '        puede ser timeout. en este y en el caso del outofmemory, logear los parametros

                ErrHandler.WriteAndRaiseError(ex)
                '    'Dim conn = New SqlConnection(builder.ConnectionString)
                '    'conn.Open()

                '    'Dim sampleCMD As SqlCommand = New SqlCommand("wCartasDePorte_TX_InformesCorregido", conn)
                '    'sampleCMD.CommandType = CommandType.StoredProcedure
                '    'sampleCMD.CommandTimeout = 60

                '    'Dim da = New SqlDataAdapter(sampleCMD)
                '    'da.Fill(ds.wCartasDePorte_TX_InformesCorregido)

                MandarMailDeError(ex)

            End Try




            Dim sWHERE As String

            Try


                sWHERE = CartaDePorteManager.generarWHEREparaDatasetParametrizadoConFechaEnNumerales(HFSC.Value, _
                                            sTitulo, _
                                            CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                           IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue)
                sWHERE = sWHERE.Replace("CDP.", "")


                For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In ds.wCartasDePorte_TX_InformesCorregido
                    With cdp
                        .Observaciones = .Observaciones.Replace(vbLf, "").Replace(vbCr, "")
                    End With
                Next

                FiltrarCopias(ds.wCartasDePorte_TX_InformesCorregido) 'ds.wCartasDePorte_TX_InformesCorregido)


            Catch ex As Exception
                ErrHandler.WriteError(ex)


            End Try



            Dim registrosFiltrados As Integer

            Try

                Select Case cmbSincronismo.Text.ToUpper
                    Case "A.C.A."
                        '        el sincro de A.C.A toma de varios clientes (ACA NAON, ACA SARASA). en lugar de usar CUIT, se les pasa un numero de cuenta
                        '100001: A.C.A.EXPORTACION()
                        '100002: A.C.A.CORREDOR()
                        '100005: A.C.A.PTA.SAN(NICOLAS)

                        ' en Williams los meten en los campos de cliente (los vi en el remcomercial y intermediario, y tambien en el titular)
                        '-sí, pero no hay necesidad de hacerse drama, porque en esos casos tambien ponen el corredor en A.C.A LMTDA

                        'Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
                        'Dim clientesACA = From i In db.linqClientes Where i.RazonSocial Like "A.C.A" Select i.IdCliente, i.RazonSocial



                        Try


                            sWHERE = CartaDePorteManager.generarWHEREparaDatasetParametrizadoConFechaEnNumerales(HFSC.Value, _
                                                        sTitulo, _
                                                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "A.C.A", idVendedor, idCorredor, _
                                                        idDestinatario, idIntermediario, _
                                                        idRComercial, idArticulo, idProcedencia, idDestino, _
                                                       IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                                        cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue)
                            sWHERE = sWHERE.Replace("CDP.", "")


                            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In ds.wCartasDePorte_TX_InformesCorregido
                                With cdp
                                    .Observaciones = .Observaciones.Replace(vbLf, "").Replace(vbCr, "")
                                End With
                            Next

                            FiltrarCopias(ds)
                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try


                        output = Sincronismo_ACA(HFSC.Value, ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count





                    Case "LOS GROBO"
                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                     "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"
                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        'txtTitular.Text = "LOS GROBO  AGROPECUARIA S.A."
                        'dt = DataTableWHERE(dt, "Titular='LOS GROBO  AGROPECUARIA S.A.'") '30-60445647-5
                        'TODO: cnflicto por el where a puntoventa?
                        'Log Entry : 
                        '08/10/2012 18:34:28
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error 'Message:Generando sincro para Los Grobo
                        '__________________________'''
                        '
                        'Log Entry : 
                        '08/10/2012 18:34:31
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error 'Message:Error en DataTableWHERECannot perform '=' operation on System.String and System.Int32.1=1  AND (1=0              OR 'CuentaOrden2=2871             OR  Entregador=3749  )               AND Destino=14 AND NOT (Vendedor IS NULL OR Corredor IS NULL 'OR Entregador IS NULL OR IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(Anulada,'NO')<>'SI'    AND isnull(FechaDescarga, 'FechaArribo) >= #2012/08/01#     AND isnull(FechaDescarga, FechaArribo) <= #2012/08/31#   AND ISNULL(Exporta,'NO')='NO'  AND '(PuntoVenta=1)
                        '__________________________'
                        '
                        'Log Entry : 
                        '08/10/2012 18:34:31
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error 'Message:System.Data.EvaluateException

                        'estoy usando "destino=16" como filtro, pero strSQLsincronismo me devuelve una cadena ahi...
                        Try
                            dt = DataTableWHERE(dt, sWHERE)
                        Catch ex As Exception
                            ErrHandler.WriteAndRaiseError("Error al filtrar destino")
                        End Try

                        FiltrarCopias(dt)
                        'dt = ProntoFuncionesGenerales.DataTableWHERE(dt, generarWHERE())
                        Dim sErrores As String
                        output = Sincronismo_LosGrobo(dt, sErrores, "")

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = dt.Rows.Count

                    Case "ARGENCER"
                        output = Sincronismo_Argencer(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "ZENI"
                        Dim sErrores As String

                        output = Sincronismo_ZENI(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)
                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        'If iisNull(sErrores, "") <> "" Then Exit Sub

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "ANDREOLI"


                        Dim sErrores As String

                        output = Sincronismo_AndreoliDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "AMAGGI (DESCARGAS)"


                        Dim sErrores As String

                        output = Sincronismo_AmaggiDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "AMAGGI (CALIDADES)"


                        output = Sincronismo_AmaggiCalidades(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, HFSC.Value)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "DOW"

                        'If ds.wCartasDePorte_TX_InformesCorregido.Rows.Count = 0 Then
                        '    MsgBoxAjax(Me, "No hay cartas que cumplan los filtros")
                        '    Return
                        'End If

                        'output = Sincronismo_DOW(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

                        sTitulo = ""
                        Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                        "", "", "", 1, 0, _
                                        CartaDePorteManager.enumCDPestado.Todas, "", idVendedor, idCorredor, _
                                        idDestinatario, idIntermediario, _
                                        idRComercial, idArticulo, idProcedencia, idDestino, "1", DropDownList2.Text, Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), cmbPuntoVenta.SelectedValue, sTitulo, , , , , idClienteAuxiliar)

                        FiltrarCopias(dt)
                        'dt = DataTableWHERE(dt, sWHERE)

                        Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroDOW" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                        output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                    "ProntoWeb\Informes\Sincronismo DOW.rdl", _
                                            dt, ArchivoExcelDestino) 'sTitulo)



                        CambiarElNombreDeLaPrimeraHojaDeDow(output)

                        registrosFiltrados = dt.Rows.Count



                    Case "BLD x"
                        'output = Sincronismo_BLD(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        Err.Raise(646546)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "BLD"
                        ErrHandler.WriteError("Generando sincro BLD")
                        Try


                            sTitulo = ""
                            Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                            "", "", "", 1, 0, _
                                            CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                                "1", DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            cmbPuntoVenta.SelectedValue, sTitulo, , , , , idClienteAuxiliar)



                            ErrHandler.WriteError("filas bld sincro " & dt.Rows.Count)


                            FiltrarCopias(dt)

                            Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroBLD" & Now.ToString("ddMMMyyyy_HHmmss") & ".pronto" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                            ErrHandler.WriteError(" generar en " & ArchivoExcelDestino & " Mirá que puede explotar por los permisos de NETWORK SERVICE para usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")

                            Try
                                output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                            "ProntoWeb\Informes\Sincronismo BLD.rdl", _
                                                   dt, ArchivoExcelDestino) 'sTitulo)
                            Catch ex As Exception
                                ErrHandler.WriteError("No se pudo generar el informe de bld! ")

                            End Try


                            ErrHandler.WriteError("Se generó el reporte en " & output)


                            'como hacer para que no agregue las columnas vacias?

                            output = ExcelToCSV_SincroBLD(output, 49)

                        Catch ex As Exception
                            ErrHandler.WriteError("Error en el sincro BLD" & ex.Message)
                            ErrHandler.WriteError(ex)
                        End Try
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "BLD (POSICIÓN DEMORADOS)"

                        sTitulo = ""

                        Dim dt As DataTable

                        Try
                            cmbEstado.Text = "Posición"
                            Dim estadofiltro = CartaDePorteManager.enumCDPestado.Posicion


                            dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                            "", "", "", 1, 0, _
                                            estadofiltro, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar)
                            FiltrarCopias(dt)
                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                            ErrHandler.WriteError(sTitulo)
                            MandarMailDeError(ex)
                            'ErrHandler.WriteErrorYMandarMail(sTitulo)
                            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.Message & " " & " Filtro usado: " & sTitulo)
                            Return
                        End Try


                        Dim ArchivoExcelDestino = IO.Path.GetTempPath & "DemoradosBLD" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                        output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                    "ProntoWeb\Informes\Posiciones BLD demorados.rdl", _
                                            dt, ArchivoExcelDestino)

                        registrosFiltrados = dt.Rows.Count

                    Case "BLD (CALIDADES)"
                        output = Sincronismo_BLDCalidades(HFSC.Value, ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count

                    Case "PSA LA CALIFORNIA"
                        ErrHandler.WriteError("Generando sincro PSA La California")
                        Try


                            sTitulo = ""
                            Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                            "", "", "", 1, 0, _
                                            CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                                "1", DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            cmbPuntoVenta.SelectedValue, sTitulo, , , , , idClienteAuxiliar)



                            ErrHandler.WriteError("filas bld sincro " & dt.Rows.Count)


                            FiltrarCopias(dt)

                            Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroPSA" & Now.ToString("ddMMMyyyy_HHmmss") & ".pronto" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                            ErrHandler.WriteError(" generar en " & ArchivoExcelDestino & " Mirá que puede explotar por los permisos de NETWORK SERVICE para usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")

                            Try
                                output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                            "ProntoWeb\Informes\Sincronismo BLD.rdl", _
                                                   dt, ArchivoExcelDestino) 'sTitulo)
                            Catch ex As Exception
                                ErrHandler.WriteError("No se pudo generar el informe de bld! ")

                            End Try


                            ErrHandler.WriteError("Se generó el reporte en " & output)


                            'como hacer para que no agregue las columnas vacias?

                            output = ExcelToCSV_SincroBLD(output, 46)

                        Catch ex As Exception
                            ErrHandler.WriteError("Error en el sincro BLD" & ex.Message)
                            ErrHandler.WriteError(ex)
                        End Try
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "PSA LA CALIFORNIA (CALIDADES)"
                        output = Sincronismo_PSALaCalifornia_Calidades(HFSC.Value, ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count

                    Case "BUNGE"
                        Dim sErr As String

                        output = Sincronismo_Bunge(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErr) 'AbrirSegunTipoComprobante (HFSC.Value, ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        lblErrores.Text = sErr
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "DIAZ RIGANTI"
                        output = Sincronismo_DiazRiganti(HFSC.Value, ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "FYO"
                        'txtCorredor.Text = "FUTUROS Y OPCIONES .COM"
                        'Dim dttemp As wCartasDePorte_TX_InformesCorregidoDataTable
                        'ds.wCartasDePorte_TX_InformesCorregido
                        'dttemp = DataTableWHERE(ds.wCartasDePorte_TX_InformesCorregido, generarWHERE())
                        'ds.wCartasDePorte_TX_InformesCorregido.Select(generarWHERE())
                        output = Sincronismo_FYO(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count

                    Case "FYO (POSICIÓN)"

                        Try


                            sWHERE = CartaDePorteManager.generarWHEREparaDatasetParametrizadoConFechaEnNumerales(HFSC.Value, _
                                                        sTitulo, _
                                                         enumCDPestado.Posicion, "", idVendedor, idCorredor, _
                                                        idDestinatario, idIntermediario, _
                                                        idRComercial, idArticulo, idProcedencia, idDestino, _
                                                       IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                                        cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue)
                            sWHERE = sWHERE.Replace("CDP.", "")


                            'For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In ds.wCartasDePorte_TX_InformesCorregido
                            '    With cdp
                            '        .Observaciones = .Observaciones.Replace(vbLf, "").Replace(vbCr, "")
                            '    End With
                            'Next

                            'FiltrarCopias(ds)
                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try

                        Try
                            'http://blogs.msdn.com/b/smartclientdata/archive/2005/08/16/increasetableadapterquerytimeout.aspx

                            Using adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter
                                adapter.SetCommandTimeOut(60)

                                adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
                                'adapter.Connection..Adapter.SelectCommand.CommandTimeout = 60

                                adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, _
                                             Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                             Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            idVendedor, idCorredor, idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, CartaDePorteManager._CONST_MAXROWS, CartaDePorteManager.enumCDPestado.Posicion)
                            End Using

                        Catch ex As OutOfMemoryException

                            ErrHandler.WriteAndRaiseError(ex)
                            MandarMailDeError(ex)

                        Catch ex As Exception
                            ErrHandler.WriteAndRaiseError(ex)
                            '    'Dim conn = New SqlConnection(builder.ConnectionString)
                            '    'conn.Open()

                            '    'Dim sampleCMD As SqlCommand = New SqlCommand("wCartasDePorte_TX_InformesCorregido", conn)
                            '    'sampleCMD.CommandType = CommandType.StoredProcedure
                            '    'sampleCMD.CommandTimeout = 60

                            '    'Dim da = New SqlDataAdapter(sampleCMD)
                            '    'da.Fill(ds.wCartasDePorte_TX_InformesCorregido)

                            MandarMailDeError(ex)

                        End Try


                        output = Sincronismo_FYO_Posicion(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "GRANOS DEL LITORAL"

                        output = Sincronismo_GranosDelLitoral(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "GRANOS DEL PARANA"
                        output = Sincronismo_GranosDelParana(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "TOMAS HNOS"
                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                       "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"

                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        dt = DataTableWHERE(dt, sWHERE)
                        FiltrarCopias(dt)
                        output = Sincronismo_TomasHnos(dt)
                        registrosFiltrados = dt.Rows.Count

                    Case "SANTA CATALINA"
                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                       "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"

                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        dt = DataTableWHERE(dt, sWHERE)
                        FiltrarCopias(dt)
                        output = Sincronismo_SantaCatalina(dt)
                        registrosFiltrados = dt.Rows.Count

                    Case "ALABERN (CALIDADES)"
                        Dim sErrores As String

                        output = Sincronismo_AlabernCalidades(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                        Select Case cmbPuntoVenta.SelectedValue
                            Case 1
                                sForzarNombreDescarga = "AnalisisW_BA.txt"
                            Case 2
                                sForzarNombreDescarga = "AnalisisW_SL.txt"
                            Case 3
                                sForzarNombreDescarga = "AnalisisW_AS.txt"
                            Case 4
                                sForzarNombreDescarga = "AnalisisW_BB.txt"
                            Case Else
                                sForzarNombreDescarga = "AnalisisW.txt"
                        End Select


                    Case "ALABERN"
                        Dim sErrores As String

                        output = Sincronismo_Alabern(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)
                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count

                        Select Case cmbPuntoVenta.SelectedValue
                            Case 1
                                sForzarNombreDescarga = "DescargasW_BA.txt"
                            Case 2
                                sForzarNombreDescarga = "DescargasW_SL.txt"
                            Case 3
                                sForzarNombreDescarga = "DescargasW_AS.txt"
                            Case 4
                                sForzarNombreDescarga = "DescargasW_BB.txt"
                            Case Else
                                sForzarNombreDescarga = "DescargasW.txt"
                        End Select

                    Case "LARTIRIGOYEN"
                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                 "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"
                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        'txtTitular.Text = "LOS GROBO  AGROPECUARIA S.A."
                        'dt = DataTableWHERE(dt, "Titular='LOS GROBO  AGROPECUARIA S.A.'") '30-60445647-5
                        'TODO: cnflicto por el where a puntoventa?
                        'Log Entry : 
                        '08/10/2012 18:34:28
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error 'Message:Generando sincro para Los Grobo
                        '__________________________'''
                        '
                        'Log Entry : 
                        '08/10/2012 18:34:31
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error 'Message:Error en DataTableWHERECannot perform '=' operation on System.String and System.Int32.1=1  AND (1=0              OR 'CuentaOrden2=2871             OR  Entregador=3749  )               AND Destino=14 AND NOT (Vendedor IS NULL OR Corredor IS NULL 'OR Entregador IS NULL OR IdArticulo IS NULL) AND ISNULL(NetoProc,0)>0 AND ISNULL(Anulada,'NO')<>'SI'    AND isnull(FechaDescarga, 'FechaArribo) >= #2012/08/01#     AND isnull(FechaDescarga, FechaArribo) <= #2012/08/31#   AND ISNULL(Exporta,'NO')='NO'  AND '(PuntoVenta=1)
                        '__________________________'
                        '
                        'Log Entry : 
                        '08/10/2012 18:34:31
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error 'Message:System.Data.EvaluateException

                        dt = DataTableWHERE(dt, sWHERE)
                        FiltrarCopias(dt)
                        'dt = ProntoFuncionesGenerales.DataTableWHERE(dt, generarWHERE())
                        Dim sErrores As String
                        output = Sincronismo_Lartirigoyen(dt, sErrores, "")

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = dt.Rows.Count

                    Case "EL ENLACE"
                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                       "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"

                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        dt = DataTableWHERE(dt, sWHERE)
                        FiltrarCopias(dt)
                        output = Sincronismo_ElEnlace(dt)
                        registrosFiltrados = dt.Rows.Count

                    Case "MIGUEL CINQUE"
                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                       "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"

                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        dt = DataTableWHERE(dt, sWHERE)
                        FiltrarCopias(dt)
                        output = Sincronismo_MiguelCinque(dt)
                        registrosFiltrados = dt.Rows.Count


                    Case "DUKAREVICH"
                        output = Sincronismo_Dukarevich(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "GRIMALDI GRASSI"
                        If False Then
                            output = Path.GetTempPath & "lala" & Now.ToString("ddMMMyyyy_HHmmss") & ".csv"
                            WriteToXmllocal(output, HFSC.Value, "SELECT * FROM CartasDePorte")
                            'sForzarNombreDescarga = output
                            Exit Sub

                        Else
                            output = Sincronismo_GrimaldiGrassi(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        End If
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "NOBLE"
                        Dim sErrores As String
                        output = Sincronismo_NOBLE(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "NOBLE (ANEXO CALIDADES)"
                        output = Sincronismo_NOBLEarchivoadicional(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "SYNGENTA"

                        output = Sincronismo_Syngenta(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        sForzarNombreDescarga = "HPESA.TXT"
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "TECNOCAMPO"



                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                        "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"

                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)
                        FiltrarCopias(dt)
                        'txtDestinatario.Text = "NIDERA S.A."
                        dt = DataTableWHERE(dt, sWHERE)
                        'dt = DataTableWHERE(dt, "Destinatario='NIDERA S.A.'") '30-60445647-5


                        output = Sincronismo_TecnoCampo(dt)
                        'UpdatePanelResumen.Update()

                        registrosFiltrados = dt.Rows.Count


                    Case "RIVARA"


                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                            "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"
                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)

                        FiltrarCopias(dt)
                        dt = DataTableWHERE(dt, sWHERE)
                        Dim sErrores As String
                        output = Sincronismo_Rivara(dt, sErrores, "")

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = dt.Rows.Count


                        'sForzarNombreDescarga = "HPESA.TXT"


                    Case "ALEA"


                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                            "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"
                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)

                        FiltrarCopias(dt)
                        dt = DataTableWHERE(dt, sWHERE)
                        Dim sErrores As String
                        output = Sincronismo_Alea(dt, sErrores, "")

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()



                        'sForzarNombreDescarga = "HPESA.TXT"

                        registrosFiltrados = dt.Rows.Count


                    Case "AIBAL"


                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                            "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"
                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)

                        FiltrarCopias(dt)
                        dt = DataTableWHERE(dt, sWHERE)
                        Dim sErrores As String
                        output = Sincronismo_Aibal(dt, sErrores, "")

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = dt.Rows.Count



                        'sForzarNombreDescarga = "HPESA.TXT"



                    Case "LA BRAGADENSE"


                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                            "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"
                        Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)

                        FiltrarCopias(dt)
                        dt = DataTableWHERE(dt, sWHERE)
                        Dim sErrores As String
                        output = Sincronismo_LaBragadense(dt, sErrores, "")

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = dt.Rows.Count



                        'sForzarNombreDescarga = "HPESA.TXT"



                    Case Else
                        ErrHandler.WriteError("No se está eligiendo bien el sincro" & cmbSincronismo.Text)
                        MsgBoxAjax(Me, "Elija un sincronismo")
                        Return
                End Select




                If lblErrores.Text <> "" Then
                    'También, ver de diferenciar el mensaje que salta cuando ninguna carta de porte cumple con 
                    'los filtros de cuando el sincro no sale porque alguna de las cartas no cumple con los requisitos.
                    Dim registrosGenerados = 0
                    Try
                        Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
                        If MyFile1.Exists Then
                            registrosGenerados = File.ReadAllLines(output).Length
                        End If

                    Catch ex As Exception

                    End Try

                    Dim renglonesEnErrores = lblErrores.Text.Split("<br/>").Count - 1
                    'Dim renglonesEnDataset = dt.Rows.Count
                    'output cantidad de renglones

                    lblErrores.Text = "" & registrosFiltrados & " cartas filtradas<br/>" & registrosGenerados & " cartas exportadas al sincronismo <br/> <br/>" & lblErrores.Text
                    'renglonesEnErrores & " errores en " &

                    'si el archivo está vacío, no enviarlo



                End If


            Catch ex As OutOfMemoryException
                MandarMailDeError(ex)
                ErrHandler.WriteError(ex)
                MsgBoxAjax(Me, "Disculpame, no pude manejar la cantidad de datos. Por favor, intentá achicando los filtros. Ya mandé un mail al administrador con el error.")
                Return
            Catch ex As Exception
                ErrHandler.WriteAndRaiseError(ex)

            End Try

        End Using

        If output = "" Then
            ErrHandler.WriteError("No se pudo generar nada " & cmbSincronismo.Text)
            MsgBoxAjax(Me, "No se encontraron registros")
            Return
        End If



        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & IIf(sForzarNombreDescarga = "", MyFile1.Name, sForzarNombreDescarga))
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el sincronismo. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler.WriteAndRaiseError(ex.Message)
            ErrHandler.WriteError(ex.Message)
            'MsgBoxAjax(Me, ex.Message)
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
            Throw ex
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
        optDivisionSyngenta.DataSource = CartaDePorteManager.excepciones
        optDivisionSyngenta.DataBind()


        cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
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


        ErrHandler.WriteError("Generando informe para " & cmbInforme.Text)


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
                                cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text, , idClienteAuxiliar)
            End If
        Catch ex As Exception
            ErrHandler.WriteError(ex)
            ErrHandler.WriteError(sTitulo)
            MandarMailDeError(ex)
            'ErrHandler.WriteErrorYMandarMail(sTitulo)
            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.Message & " " & " Filtro usado: " & sTitulo)
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

                Case "Cartas Duplicadas pendientes de asignar"
                    '  Dim q = LogicaFacturacion.CartasConCopiaSinAsignarLINQ(HFSC.Value)
                    Dim ms As String = ""
                    'el filtro tiene que incluir duplicados (el True despues de syngenta)
                    LogicaFacturacion.CorrectorSubnumeroFacturacion(HFSC.Value, ms)

                    Dim q = CartasLINQ(HFSC.Value, _
                                "", "", "", 1, 0, _
                                estadofiltro, "", idVendedor, idCorredor, _
                                idDestinatario, idIntermediario, _
                                idRComercial, idArticulo, idProcedencia, idDestino, _
                                IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), _
                                 "Ambos", _
                                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text)
                    Dim qq = LogicaFacturacion.CartasConCopiaPendiente(q, ms).OrderBy(Function(x) x.NumeroCartaDePorte).ThenBy(Function(x) x.SubnumeroDeFacturacion).ToList()


                    Dim serv As String


                    If System.Diagnostics.Debugger.IsAttached() Then
                        serv = "http://localhost:48391/ProntoWeb"
                    Else
                        serv = "http://prontoclientes.williamsentregas.com.ar/"
                    End If

                    RebindReportViewerLINQ("ProntoWeb\Informes\Cartas con Copia sin asignar.rdl", qq, New ReportParameter() {New ReportParameter("sServidor", serv)})
                    'CartasConCopiaSinAsignar()

                Case "Listado general de cartas de porte (solo originales)"
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

                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", _
                                        dt, Nothing, , , sTitulo)
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
                              cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar)

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
                              cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, True, txtContrato.Text, , idClienteAuxiliar)

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
                    ErrHandler.WriteError(dt.Rows.Count & " lineas exportando a excel de Notas de entrega")

                    'y acá tomo el excel y lo transformo en el txt para la EPSON
                    output = ExcelToTextNotasDeEntrega(output)

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

                    estadsucmodo()
                Case "Estadísticas de Toneladas descargadas (Modo-Sucursal)"
                    estadmodosuc()
                Case "Volumen de Carga"
                    VolumenCarga()

                Case "Diferencias por Destino por Mes"
                    DiferenciasPorDestino()

                Case "Cartas Duplicadas"
                    'TraerDataset = TotalesPorMes()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    CartasDuplicadas()


                Case "Taras por Camiones"



                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))
                    RebindReportViewer("ProntoWeb\Informes\Taras por Titular.rdl", dt)


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
                    Dim dta = TotalesPorDestinos(HFSC.Value)
                    RebindReportViewer("ProntoWeb\Informes\Valorizado por SubContratista.rdl", ProntoFuncionesGenerales.DataTableWHERE(dta, sWHERE2))
                    'la primera, algunos destinos no son puertos si no que son fabricas, no se porque hacen la diferencia
                    'no, es todo lo mismo, son todos destinos, simplemente le pusieron ese nombre


                Case "Liquidación de Subcontratistas"
                    LiquidacionDeSubcontratistas()


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
                    GeneroDataTablesDeMovimientosDeStock(dtCDPs, dt2, dtMOVs, idDestinatario, idDestino, idArticulo, _
                                                        fechadesde, fechahasta, HFSC.Value)

                    Movimientos_RebindReportViewer("ProntoWeb\Informes\Movimientos.rdl", dtCDPs, dt2, dtMOVs, _
                                                  fechadesde, fechahasta, idDestino, idArticulo, idDestinatario)


                Case "Resumen de facturación"

                    ResumenFacturacion()




                Case "Proyección de facturación"

                    ProyeccionFacturacion()










                Case "Ranking de Cereales"
                    rankcereales()
                Case "Ranking de Clientes"
                    rankingclientes()
                Case Else
                    'MsgBoxAjax(Me, "El informe no existe. Consulte con el administrador")
            End Select






        Catch ex As Exception
            Dim s As String = "Hubo un error al generar el informe. " & cmbInforme.Text & " " & ex.Message
            ErrHandler.WriteError(s)
            MandarMailDeError(s)
            'MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.Message)
            MsgBoxAlert("Hubo un error al generar el informe. " & ex.Message)
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
            'ErrHandler.WriteAndRaiseError(ex.Message)
            ErrHandler.WriteError(ex.Message)
            'MsgBoxAjax(Me, ex.Message)
            Return
        End Try

    End Sub




    Function estadmodosuc()
        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)


        Dim p2 As ReportParameter
        Dim q = ConsultasLinq.EstadisticasDescargas(p2, txtFechaDesde.Text, txtFechaHasta.Text, cmbPeriodo.Text, cmbPuntoVenta.SelectedValue, DropDownList2.Text, HFSC.Value)

        RebindReportViewerLINQ("ProntoWeb\Informes\Estadísticas de Toneladas descargadas.rdl", q, New ReportParameter() {New ReportParameter("Titulo", fechadesde.ToShortDateString & " al " & fechahasta.ToShortDateString), p2})

    End Function

    Function estadsucmodo()
        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
        Dim p2 As ReportParameter

        Dim q = ConsultasLinq.EstadisticasDescargas(p2, txtFechaDesde.Text, txtFechaHasta.Text, cmbPeriodo.Text, cmbPuntoVenta.SelectedValue, DropDownList2.Text, HFSC.Value)
        RebindReportViewerLINQ("ProntoWeb\Informes\Estadísticas de Toneladas descargadas Sucursal-Modo.rdl", q, New ReportParameter() {New ReportParameter("Titulo", fechadesde.ToShortDateString & " al " & fechahasta.ToShortDateString), p2})

    End Function

    Function VolumenCarga()


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




        Dim q = ConsultasLinq.VolumenCarga(HFSC.Value, _
                                    sTitulo, _
                                    "", "", 0, 999999, CartaDePorteManager.enumCDPestado.Todas, "", _
                                    idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                       DropDownList2.Text, _
                                   fechadesde, fechahasta, pv)



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Volumen de Carga.rdl", q, New ReportParameter() {New ReportParameter("Titulo", fechadesde.ToShortDateString & " al " & fechahasta.ToShortDateString)})



    End Function


    Function DiferenciasPorDestino()



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




        Dim q = ConsultasLinq.DiferenciasDestino(HFSC.Value, _
                                    sTitulo, _
                                    "", "", 0, 999999, CartaDePorteManager.enumCDPestado.Todas, "", _
                                    idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                       DropDownList2.Text, _
                                   fechadesde, fechahasta, pv)



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Diferencias Por Destino.rdl", q, New ReportParameter() {New ReportParameter("Titulo", fechadesde.ToShortDateString & " al " & fechahasta.ToShortDateString)})



    End Function


    Sub rankcereales()
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
        '////////////////////////////////////////////////////
        '////////////////////////////////////////////////////


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        Dim q = (From cdp In db.CartasDePortes _
                Join cli In db.linqClientes On cli.IdCliente Equals cdp.Vendedor _
                Join art In db.linqArticulos On art.IdArticulo Equals cdp.IdArticulo _
                Where cdp.Vendedor > 0 _
                   And cli.RazonSocial IsNot Nothing _
                   And (cdp.FechaDescarga >= fechadesde2 And cdp.FechaDescarga <= fechahasta) _
                  And (cdp.Anulada <> "SI") _
                                      And ((DropDownList2.Text = "Ambos") Or (DropDownList2.Text = "Entregas" And If(cdp.Exporta, "NO") = "NO") Or (DropDownList2.Text = "Export" And If(cdp.Exporta, "NO") = "SI")) _
                Group cdp By Producto = art.Descripcion Into g = Group _
                Select New With { _
                        .Producto = Producto, _
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
                ).Where(Function(i) i.Total > 0).ToList




        '



        'Cereal
        'BA (Tn sin mermas de Buenos Aires si se saca de todos los PV)
        'SL (Tn sin mermas de San Lorenzo si se saca de todos los PV)
        'AS (Tn sin mermas de Arroyo Seco si se saca de todos los PV)
        'BB (Tn sin mermas de Bahia Blanca si se saca de todos los PV)
        'Total (Tn netas sin mermas)
        '% (Sobre la suma de todos los clientes)
        'Total Periodo Anterior (*)
        'Diferencia (Total - Total Periodo Anterior)
        '%Dif (Diferencia/Total).



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Ranking de Cereales.rdl", q)

        'RebindReportViewer("ProntoWeb\Informes\Ranking de Cereales.rdl", dt)

    End Sub






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
            i.Sucursal = CartaDePorteManager.NombrePuntoVentaWilliams(Val(i.Sucursal))
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


    Sub LiquidacionDeSubcontratistas()
        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))


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




        Dim qq = From cdp In db.CartasDePortes _
                From art In db.linqArticulos.Where(Function(i) i.IdArticulo = cdp.IdArticulo).DefaultIfEmpty _
                From clitit In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Vendedor).DefaultIfEmpty _
                From clidest In db.linqClientes.Where(Function(i) i.IdCliente = cdp.Entregador).DefaultIfEmpty _
                From cliint In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden1).DefaultIfEmpty _
                From clircom In db.linqClientes.Where(Function(i) i.IdCliente = cdp.CuentaOrden2).DefaultIfEmpty _
                From corr In db.linqCorredors.Where(Function(i) i.IdVendedor = cdp.Corredor).DefaultIfEmpty _
                From cal In db.Calidades.Where(Function(i) i.IdCalidad = CInt(cdp.Calidad)).DefaultIfEmpty _
                From estab In db.linqCDPEstablecimientos.Where(Function(i) i.IdEstablecimiento = cdp.IdEstablecimiento).DefaultIfEmpty _
                From tr In db.Transportistas.Where(Function(i) i.IdTransportista = cdp.IdTransportista).DefaultIfEmpty _
                From loc In db.Localidades.Where(Function(i) i.IdLocalidad = CInt(cdp.Procedencia)).DefaultIfEmpty _
                From chf In db.Choferes.Where(Function(i) i.IdChofer = cdp.IdChofer).DefaultIfEmpty _
                From emp In db.linqEmpleados.Where(Function(i) i.IdEmpleado = cdp.IdUsuarioIngreso).DefaultIfEmpty _
                From dest In db.WilliamsDestinos.Where(Function(i) i.IdWilliamsDestino = cdp.Destino).DefaultIfEmpty _
                From clisub1 In db.linqClientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr1, dest.Subcontratista1)).DefaultIfEmpty _
                From clisub2 In db.linqClientes.Where(Function(i) i.IdCliente = If(cdp.Subcontr2, dest.Subcontratista2)).DefaultIfEmpty _
                From l1 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub1.IdListaPrecios).DefaultIfEmpty _
                From pd1 In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l1.IdListaPrecios).DefaultIfEmpty _
                From l2 In db.ListasPrecios.Where(Function(i) i.IdListaPrecios = clisub2.IdListaPrecios).DefaultIfEmpty _
                From pd2 In db.ListasPreciosDetalles.Where(Function(i) i.IdListaPrecios = l2.IdListaPrecios).DefaultIfEmpty _
                Where _
                 (cdp.FechaDescarga >= fechadesde And cdp.FechaDescarga <= fechahasta) _
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
                Select cdp, _
                    VendedorDesc = clitit.RazonSocial, _
                    CuentaOrden1Desc = cliint.RazonSocial, _
                    CuentaOrden2Desc = clircom.RazonSocial, _
                    CorredorDesc = corr.Nombre, _
                    EntregadorDesc = clidest.RazonSocial, _
                    ProcedenciaDesc = loc.Nombre, _
                    DestinoDesc = dest.Descripcion, _
                    Subcontr1Desc = clisub1.RazonSocial, _
                    Subcontr2Desc = clisub2.RazonSocial, _
                   tarif1 = CDec(If(IIf(cdp.Exporta <> "SI", pd1.PrecioCaladaLocal, pd1.PrecioCaladaExportacion), 0)), _
                   tarif2 = CDec(If(IIf(cdp.Exporta <> "SI", pd2.PrecioDescargaLocal, pd2.PrecioDescargaExportacion), 0))

        'http://stackoverflow.com/questions/5568860/linq-to-sql-join-issues-with-firstordefault


        Dim q = qq.Where(Function(i) If(i.cdp.ExcluirDeSubcontratistas, "NO") = "NO" And If(i.cdp.SubnumeroDeFacturacion, 0) <= 0)


        Dim q4 As List(Of infLiqui) = (From i In q _
                     Select New infLiqui With { _
                        .DestinoDesc = i.DestinoDesc & " Calada", _
                        .SubcontrDesc = i.Subcontr1Desc, _
                        .NetoPto = i.cdp.NetoFinal / 1000, _
                        .Tarifa = i.tarif1, _
                        .Comision = i.cdp.NetoFinal * i.tarif1 / 1000}).ToList

        Dim q5 As List(Of infLiqui) = (From i In q _
                    Select New infLiqui With { _
                        .DestinoDesc = i.DestinoDesc & " Balanza", _
                        .SubcontrDesc = i.Subcontr2Desc, _
                        .NetoPto = i.cdp.NetoFinal / 1000, _
                        .Tarifa = i.tarif2, _
                        .Comision = i.cdp.NetoFinal * i.tarif2 / 1000}).ToList


        Dim q6 As New List(Of infLiqui) '= q4.Union(q5)
        q6.AddRange(q4)
        q6.AddRange(q5)



        Dim q3 = From i In q6 _
                Group i By DestinoDesc = i.DestinoDesc, SubcontrDesc = i.SubcontrDesc, Tarifa = i.Tarifa Into g = Group _
                Select DestinoDesc = DestinoDesc, SubcontrDesc = SubcontrDesc, Tarifa = Tarifa, _
                NetoPto = g.Sum(Function(i) i.NetoPto), Comision = g.Sum(Function(i) i.Comision), CantCartas = g.Count


        'RebindReportViewerLINQ("ProntoWeb\Informes\Valorizado por SubContratista.rdl", q2.ToList)
        RebindReportViewerLINQ("ProntoWeb\Informes\Liquidación de SubContratistas.rdl", q3.ToList)


        'la funcion ComisionesPorDestinoYArticulo hacía un UNION con las 2 tarifas de subcontratistas

        '        Unificar los informes \"Liquidacion de subcontratistas\" y \"Comisiones Por Puerto y Cereal\"
        '        Debe quedar uno, de nombre \"Liquidacion de subcontratistas\".
        'En el caso que haya Cartas de Porte de exportacion, mostrarlas separadas de las que no lo son, con la tarifa correspondiente





    End Sub


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



            RebindReportViewerLINQ("ProntoWeb\Informes\Resumen de facturación.rdl", s, params)

        Catch ex As Exception
            Throw ex
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
                '    ErrHandler.WriteError(ex.Message)
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
                        '    ErrHandler.WriteError("Error al buscar los parametros")
                        'End If
                    Else
                        ErrHandler.WriteError("Error al buscar los parametros")
                    End If
                Catch ex As Exception
                    ErrHandler.WriteError(ex.Message)
                    Dim inner As Exception = ex.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler.WriteError("Error al buscar los parametros.  " & inner.Message)
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
                ErrHandler.WriteAndRaiseError(ex)
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
                '    ErrHandler.WriteError(ex.Message)
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

                        ErrHandler.WriteError(inner.Message)
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
                    ErrHandler.WriteError(ex.Message)
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

                '            ErrHandler.WriteError(inner.Message)
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

        output = ExcelToTextNotasDeEntrega(output)

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
            'ErrHandler.WriteAndRaiseError(ex.Message)
            ErrHandler.WriteError(ex.Message)
            'MsgBoxAjax(Me, ex.Message)
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
                    ErrHandler.WriteError(ex)
                End Try


                'If .GetParameters.Count = 1 Then
                '    If .GetParameters.Item(0).Name = "ReportParameter1" Then
                '        Dim p1 = New ReportParameter("ReportParameter1", titulo)
                '        'Dim p2 = New ReportParameter("FechaDesde", Today)
                '        'Dim p3 = New ReportParameter("FechaHasta", Today)
                '        '.SetParameters(New ReportParameter() {p1, p2, p3})
                '        .SetParameters(New ReportParameter() {p1})

                '    Else
                '        ErrHandler.WriteError("Error al buscar los parametros")
                '    End If
                'Else
                '    ErrHandler.WriteError("Error al buscar los parametros")
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

                    ErrHandler.WriteError(inner.Message)
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


        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        Dim pv1, pv2, pv3, pv4 As Decimal
        If True Then
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



            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////
            'Calculo lo que se supuestamente se facturaria este mes
            '//////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////
            'TODO: truco para que traiga TODAS las filas, sin paginar
            ViewState("pagina") = 1
            ViewState("IdTanda") = 0
            Dim PuntoVenta = 1
            Dim aa = LogicaFacturacion.GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                              Session.SessionID, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", Session.SessionID, 0, 0, "")
            Dim totalEsteMes = Aggregate o In aa.AsEnumerable _
                        Into monto = Sum(CDec(o("TarifaFacturada") * o("KgNetos")))






            ViewState("pagina") = 1
            ViewState("IdTanda") = 0
            PuntoVenta = 2
            aa = LogicaFacturacion.GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                              Session.SessionID, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", Session.SessionID, 0, 0, "")
            Dim totalEsteMes2 = Aggregate o In aa.AsEnumerable _
                        Into monto = Sum(CDec(o("TarifaFacturada") * o("KgNetos")))






            ViewState("pagina") = 1
            ViewState("IdTanda") = 0
            PuntoVenta = 3
            aa = LogicaFacturacion.GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                              Session.SessionID, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", "", "", "", "", Session.SessionID, 0, 0, "")

            Dim totalEsteMes3 = Aggregate o In aa.AsEnumerable _
                        Into monto = Sum(CDec(o("TarifaFacturada") * o("KgNetos")))





            ViewState("pagina") = 1
            ViewState("IdTanda") = 0
            PuntoVenta = 4
            aa = LogicaFacturacion.GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, 999999, PuntoVenta, _
                                                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                              Session.SessionID, "", 5, _
                                                           "", "", "", "", _
                                                           "", "", "", "", _
                                                           "", "", "", "", "", "", "", "", "", Session.SessionID, 0, 0, "")
            Dim totalEsteMes4 = Aggregate o In aa.AsEnumerable _
                        Into monto = Sum(CDec(o("TarifaFacturada") * o("KgNetos")))

        End If

        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////


        Dim lista As New Generic.List(Of tipoloco)
        Dim i As tipoloco


        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////
        'los meses anteriores
        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////
        For m = 0 To 8
            Dim primerodemes = GetFirstDayInMonth(DateAdd(DateInterval.Month, -m, Today))
            Dim ultimomes = GetLastDayInMonth(primerodemes)
            Dim total = Aggregate f In db.linqFacturas _
                        Where f.FechaFactura >= primerodemes And f.FechaFactura <= ultimomes _
                        And If(f.Anulada, "") <> "SI" _
                        Into Sum(f.ImporteTotal)

            i = New tipoloco
            i.ano = primerodemes.Year
            i.mes = MonthName(primerodemes.Month)
            i.orden = primerodemes.Month
            i.monto = total
            i.serie = ""
            lista.Add(i)
        Next



        '//////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////
        'proyeccion de este mes
        '//////////////////////////////////////////////////////////////////////////////////
        'Dim proyeccion = (totalEsteMes + totalEsteMes2 + totalEsteMes3 + totalEsteMes4) * 1.21
        Dim proyeccion = (pv1 + pv2 + pv3 + pv4) * 1.21


        i = New tipoloco
        i.ano = Today.Year
        i.mes = "cartas por facturar" 'MonthName(Today.Month)
        i.orden = Today.Month
        i.monto = proyeccion
        i.serie = MonthName(i.orden)
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





        Dim q2 = From l In lista Select Monto = l.monto, Mes = l.mes, Ano = l.ano, Orden = l.orden, Serie = l.serie 'ojo que es CaseSensitive!!!!
        'Mes
        'ano tarifa netofinal precio

        RebindReportViewerLINQ("ProntoWeb\Informes\Proyección de facturación.rdl", q2)




    End Sub




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
                        Console.WriteLine(ex.Message)  'que no te confunda el orden de los colid. Por ejemplo, Titular era el 11. Es decir, depende del datatable. No?
                        ErrHandler.WriteError(ex)
                        Throw ex
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

Class LogicaInformesWilliams


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////




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
                 desde, hasta, -1, sTitulo)



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

    Shared Function f(ByVal i As Integer) As String
        Dim TiposMovs() As String = {"Préstamo", "Transferencia", "Devolución", "Embarque", "Venta"}
        Try
            Return TiposMovs(i - 1)
        Catch ex As Exception
            Return ""
        End Try
    End Function



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


    '////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////

End Class


Class tipoloco
    Public monto
    Public mes
    Public ano
    Public orden
    Public serie
End Class

'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
















