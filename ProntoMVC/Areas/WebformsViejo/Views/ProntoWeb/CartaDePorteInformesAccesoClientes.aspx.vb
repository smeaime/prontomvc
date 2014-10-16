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

Imports CodeEngine.Framework.QueryBuilder

Imports Pronto.ERP.Bll.CartaDePorteManager
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


            Me.Title = "Informes de CDPs"

            BindTypeDropDown()
            refrescaPeriodo()


            'agregar al where que aparezca la razon social de este cliente
            Dim rs As String
            Try
                rs = UserDatosExtendidosManager.Traer(Session(SESSIONPRONTO_UserId)).RazonSocial.ToUpper

            Catch ex As Exception
                ErrHandler.WriteError(ex)
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


        Dim tx As TextBox = Me.Master.FindControl("txtSuperbuscador")
        tx.Visible = False



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

        'Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.CDPs_Facturacion)

        'If Not p("PuedeLeer") Then
        '    'anular la columna de edicion
        '    'getGridIDcolbyHeader(
        '    cmbInforme.Items(14).Enabled = False
        'End If


        'web para clientes de williams
        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7872

        'usuario losgrobo 

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



    Protected Sub cmbInforme_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbInforme.SelectedIndexChanged
        bRecargarInforme = True
        'ReBind()
        'TraerResumenDeCuentaFF()
    End Sub

    Private Sub BindTypeDropDown()
        cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
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
            ErrHandler.WriteError(ex)
        End Try

    End Sub





    Sub AsignaInformeAlReportViewer(Optional ByVal bDescargaExcel As Boolean = False)


        'agregar al where que aparezca la razon social de este cliente
        Dim rs As String
        Try
            rs = UserDatosExtendidosManager.Traer(Session(SESSIONPRONTO_UserId)).RazonSocial.ToUpper
        Catch ex As Exception
            'como no encuentro el usuario en la tabla de datos adicionales de la bdlmaster, 
            ' uso el nombre del usuario como razon social que esperaba encontrar en esa dichosa tabla
            ErrHandler.WriteError(ex)
            rs = Session(SESSIONPRONTO_UserName)
        End Try
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

        If Not (chkTitular.Checked Or chkRemComercial.Checked Or chkRemComercial.Checked Or chkCorredor.Checked Or chkDestinatario.Checked) Then
            'MsgBoxAjax(Me, "Por lo menos hay que tildar un filtro")
            'Exit Sub 'tiene que haber alguno tildado
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
            dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                    "", "", "", 1, 0, _
                    estadofiltro, lblRazonSocial.Text, idVendedor, idCorredor, _
                    idDestinatario, idIntermediario, _
                    idRComercial, idArticulo, idProcedencia, idDestino, _
                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                    DropDownList2.Text, _
                    Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                    Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                    cmbPuntoVenta.SelectedValue, sTitulo, , , , txtQueContenga.Text, idClienteAuxiliar)

        Catch ex As Exception
            ErrHandler.WriteError("Hubo un error al generar el informe. " & ex.Message)
            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.Message)
            Return
        End Try





        If dt.Rows.Count = CartaDePorteManager._CONST_MAXROWS Then
            MsgBoxAjax(Me, "Se llegó al máximo de renglones (" & CartaDePorteManager._CONST_MAXROWS & "). Por favor use un filtro más restringido")
        End If




        Try

            Select Case cmbInforme.Text
                Case "Listado general de cartas de porte"

                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl", _
                                        dt, Nothing, , , sTitulo)


                Case Else
                    'MsgBoxAjax(Me, "El informe no existe. Consulte con el administrador")
            End Select






        Catch ex As Exception
            ErrHandler.WriteError("Hubo un error al generar el informe. " & ex.Message)
            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.Message)
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


    'Function generarWHERE() As String
    '    Dim idVendedor = BuscaIdClientePreciso(txtVendedor.Text, HFSC.Value)
    '    Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
    '    Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
    '    Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
    '    Dim idDestinatario = BuscaIdClientePreciso(txtEntregador.Text, HFSC.Value)
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
    '    ElseIf DropDownList2.Text = "Export" Then
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



    Sub Movimientos_RebindReportViewer(ByVal rdlFile As String, ByVal dtCartasPorte As DataTable, ByVal dtExistencias As DataTable, ByVal dtMovimientos As DataTable, ByVal FechaDesde As DateTime, ByVal fechaHasta As DateTime, ByVal IdDestinoPuerto As Integer, ByVal IdArticulo As Integer)
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


                Dim p1 = New ReportParameter("IdCartaDePorte", -1)
                Dim p2 = New ReportParameter("FechaDesde", FechaDesde)
                Dim p3 = New ReportParameter("IdArticulo", IdArticulo)
                Dim p4 = New ReportParameter("IdPuerto", IdDestinoPuerto)
                Dim p5 = New ReportParameter("FechaHasta", fechaHasta)



                .SetParameters(New ReportParameter() {p1, p2, p3, p4, p5})

                '/////////////////////
                '/////////////////////
                '/////////////////////
                '/////////////////////

            End With

            .DocumentMapCollapsed = True
            .LocalReport.Refresh()
            .DataBind()
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
                        MsgBox(inner.Message)
                        ErrHandler.WriteError(inner.Message)
                        inner = inner.InnerException
                    End While
                End Try


                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()


                Return ArchivoExcelDestino
            Else

                .LocalReport.Refresh()
                .DataBind()

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



    Protected Sub DropDownList1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.TextChanged

        Select Case DropDownList1.Text.ToUpper
            Case "LOS GROBO"
                txtVendedor.Text = "LOS GROBO  AGROPECUARIA S.A."

            Case "ZENI"




            Case "BLD"


            Case "FYO"
                txtCorredor.Text = "FUTUROS Y OPCIONES .COM"

            Case "GRANOS DEL LITORAL"

            Case "GRANOS DEL PARANA"

            Case "TOMAS HNOS"

            Case "DUKAREVICH"

            Case "GRIMALDI GRASSI"


            Case "TECNOCAMPO"

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
        Dim output = RebindReportViewerTexto("ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", dt)

        output = ExcelToText(output)

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





    Sub Importar()

        Dim nombreEmpresa = "wDemoWilliams"
        Dim nombreArchivo = "C:\Users\Mariano\Desktop\Usuarios Web Consultas.xlsx"



        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////

        Dim IdEmpresa As Integer = EntidadManager.ExecDinamico(ConexBDLmaster, "SELECT IdBD FROM bases WHERE descripcion='" & nombreEmpresa & "'").Rows(0).Item(0)
        Dim ds As DataSet = GetExcelToDatatable(nombreArchivo, 1, 5, 2000)

        Const adminRoleName As String = "WilliamsClientes"
        If Not Roles.RoleExists(adminRoleName) Then
            Err.Raise(2222)
            'Roles.CreateRole(adminRoleName)
        End If



        For Each r As DataRow In ds.Tables(0).Rows



            Dim sRazonSocial As String = r(0)
            Dim CUIT As String = r(1) & "-" & r(2).ToString.PadLeft(9, "0")
            CUIT = Left(CUIT, 11) & "-" & Right(CUIT, 1)
            Dim UserName As String = r(3)
            Dim Password As String = IIf(r(4).ToString.Length >= 6, r(4).ToString.Replace(" ", "") & "!", "cambiar!")




            'verificar que hay un cliente con ese nombre
            If BuscaIdClientePreciso(sRazonSocial, HFSC.Value) < 1 Then

                Dim Idaprox = BuscaIdClientePorCUIT(CUIT, HFSC.Value)
                'Dim Idaprox = BuscaIdClienteAproximado(sRazonSocial, HFSC.Value, 3)

                If Idaprox < 1 Then
                    ErrHandler.WriteError("No se encontró la razon social: " & sRazonSocial)
                    Continue For
                Else
                    'encontré uno parecido, lo reemplazo
                    Dim anteriorRazon = sRazonSocial
                    sRazonSocial = EntidadManager.NombreCliente(HFSC.Value, Idaprox)
                    ErrHandler.WriteError("CAMBIO RAZON SOCIAL: " & anteriorRazon & " >>> reemplazada por >>> " & sRazonSocial)
                End If
            End If




            Dim status As MembershipCreateStatus
            Dim mu As MembershipUser
            mu = Membership.GetUser(UserName)
            If mu Is Nothing Then
                mu = Membership.CreateUser(UserName, Password, "a", "a", "a", True, status)
                If status <> MembershipCreateStatus.Success Then
                    ErrHandler.WriteError("Error al crear usuario " & UserName & " " & status.ToString)
                    Continue For
                End If

            Else
                ErrHandler.WriteError("ya existe el usuario: " & sRazonSocial)
                'Continue For
                'Err.Raise(2222)
                'Exit For
            End If


            If Not Roles.IsUserInRole(UserName, adminRoleName) Then
                Roles.AddUserToRole(UserName, adminRoleName)
            End If

            'asignar base default!!!!
            EmpresaManager.AddUserInCompanies(ConexBDLmaster, mu.ProviderUserKey.ToString, IdEmpresa)

            'agregar cuit a la tabla extension
            UserDatosExtendidosManager.Update(mu.ProviderUserKey.ToString, sRazonSocial, CUIT)

        Next


    End Sub



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





    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Importar()
    End Sub

    Protected Sub txtQueContenga_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtQueContenga.TextChanged
        AsignaInformeAlReportViewer()
    End Sub
End Class










