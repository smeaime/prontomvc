Imports Pronto.ERP.Bll

Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports System.IO
Imports System.IO.Packaging
Imports System.Data
Imports Pronto.ERP.Bll.EntidadManager
Imports Microsoft.Reporting.WebForms

Imports ClaseMigrar.SQLdinamico

Imports OfficeOpenXml

'Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'esto si la muevo al Bll, como debo
Imports Pronto.ERP.Bll.CDPMailFiltrosManager 'como la capa de negocios la tengo acá para debuguear en tiempo de ejecucion, la importo desde acá

Imports CartaDePorteManager
Imports CDPMailFiltrosManager2




'    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

Partial Class CDPMailing
    Inherits System.Web.UI.Page


    Const TIMEOUT_MANUAL_EN_SEGUNDOS = 60 * 15 '. lo restablezco en el Unload
    Const TIMEOUT_SCRIPT = TIMEOUT_MANUAL_EN_SEGUNDOS + 300 'para que explote despues del timeout controlado


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim rebotes As String = ""

        ''Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(Session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, Session(SESSIONPRONTO_glbIdObraAsignadaUsuario))



        If Not IsPostBack Then 'es decir, si es la primera vez que se carga

            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////
            '    'PRIMERA CARGA
            '    'inicializacion de varibles y preparar pantalla
            '    '////////////////////////////////////////////
            '    '////////////////////////////////////////////


            '////////////////////////////////////////////////
            ViewState("timeOut") = Server.ScriptTimeout 'http://codebetter.com/petervanooijen/2006/06/15/timeout-of-an-asp-net-page/
            Server.ScriptTimeout = TIMEOUT_SCRIPT
            'ErrHandler2.WriteError("Server.ScriptTimeout puesto en " & Server.ScriptTimeout & "s. Valor original: " & ViewState("timeOut") & "s.")
            '///////////////////////////////////////////////


            If Membership.GetUser().UserName = "Mariano" Then Button1.Visible = True


            ResetChecks()

            lnkCuentaGMail.NavigateUrl = "https://mail.google.com/mail"
            
            Try
            	txtRedirigirA.Text = UsuarioSesion.Mail(HFSC.Value, Session)
 			Catch ex As Exception
                ErrHandler2.WriteError(ex.ToString)
            End Try

            BindTypeDropDown()


            refrescaPeriodo()

            RebindPrimeraPagina()

            Try
                'rebotes = VerificoMailsRebotados()
            Catch ex As Exception
                ErrHandler2.WriteError("Problemas con los mails: " & ex.ToString)
            End Try

        End If

        AutoCompleteExtender1.ContextKey = HFSC.Value
        AutoCompleteExtender27.ContextKey = HFSC.Value
        AutoCompleteExtender3.ContextKey = HFSC.Value
        AutoCompleteExtender4.ContextKey = HFSC.Value
        AutoCompleteExtender5.ContextKey = HFSC.Value
        AutoCompleteExtender6.ContextKey = HFSC.Value
        AutoCompleteExtender8.ContextKey = HFSC.Value
        AutoCompleteExtender9.ContextKey = HFSC.Value
        AutoCompleteExtender11.ContextKey = HFSC.Value
        AutoCompleteExtender13.ContextKey = HFSC.Value

        Permisos()

        If rebotes <> "" Then
            MsgBoxAlert(rebotes)
            'rebotes = ""
        End If

    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        Try
            If Not IsNothing(ViewState("timeOut")) Then Server.ScriptTimeout = ViewState("timeOut")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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

        If If(EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)), New Pronto.ERP.BO.Empleado()) .PuntoVentaAsociado > 0 Then
            Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
            BuscaTextoEnCombo(cmbPuntoVenta, pventa)
            If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
        End If




    End Sub




    'Envio a clientes

    Protected Sub lnkEnviarAClientes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEnviarAClientes.Click
        Select Case cmbEstado.Text
            Case "Descargas"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas)
            Case "Posición"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.Posicion)
            Case "Rechazos"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.Rechazadas)
            Case "DescargasDeHoyMasTodasLasPosiciones"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones)
            Case "DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha)
        End Select
    End Sub


    Protected Sub lnkEnviarVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEnviarVistaPrevia.Click
        Select Case cmbEstado.Text
            Case "Descargas"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, True)
            Case "Posición"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.Posicion, True)
            Case "Rechazos"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.Rechazadas, True)
            Case "DescargasDeHoyMasTodasLasPosiciones"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones, True)

            Case "DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                GeneraYEnviaLosMailsTildadosDeLaGrilla(CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha, True)
        End Select
    End Sub


    Sub test()
        '    Dim dt=
        'DatatableToHtmlUsandoGridview(dt, gridParaEmbeberEnMail)
    End Sub


    'Enviar ya (el envio inmediato no tiene opcion de vista previa)

    Protected Sub lnkEnviarYa_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEnviarYa.Click

        Dim dr = TraerMetadata(HFSC.Value, -1).NewRow

        dr.Item("Emails") = txtPopEmails.Text
        dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(txtPopTitular.Text, HFSC.Value))
        dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(txtPopIntermediario.Text, HFSC.Value))
        dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(txtPopRComercial.Text, HFSC.Value))
        dr.Item("IdClienteAuxiliar") = IdNull(BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value))
        dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(txtPopCorredor.Text, HFSC.Value))
        dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(txtPopDestinatario.Text, HFSC.Value))
        dr.Item("Destino") = IdNull(BuscaIdWilliamsDestinoPreciso(txtPopDestino.Text, HFSC.Value))
        dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(txtPopProcedencia.Text, HFSC.Value))



        dr.Item("FechaDesde") = iisValidSqlDate(txtFechaDesdePopup.Text, DBNull.Value)
        dr.Item("FechaHasta") = iisValidSqlDate(txtFechaHastaPopup.Text, DBNull.Value)

        Dim s As String
        ProntoOptionButton(CriterioWHERE, s)
        dr.Item("AplicarANDuORalFiltro") = s



        txtFechaDesde.Text = txtFechaDesdePopup.Text
        txtFechaHasta.Text = txtFechaHastaPopup.Text


        dr.Item("Modo") = cmbPopModo.SelectedValue
        dr.Item("Orden") = Val(txtPopOrden.Text)
        dr.Item("Contrato") = Val(txtPopContrato.Text)
        dr.Item("EnumSyngentaDivision") = optDivisionSyngenta.Text
        dr.Item("ModoImpresion") = cmbPopModoImpresion.SelectedValue


        dr.Item("EsPosicion") = (cmbPopPosicion.SelectedValue = "Posicion")
        dr.Item("IdArticulo") = IdNull(BuscaIdArticuloPreciso(txtPopArticulo.Text, HFSC.Value))

        'lo manda a la casilla del destino
        Dim destinatario = dr.Item("EMails")
        Dim cuerpo = ""



        Dim output As String

        With dr
            Dim l As Long
            Dim tit = "" ' titulo
            Dim estado As CartaDePorteManager.enumCDPestado


            Select Case cmbEstadoPopup.SelectedValue
                Case "Posición"
                    estado = CartaDePorteManager.enumCDPestado.Posicion
                Case "Descargas"
                    estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
                Case "Rechazos"
                    estado = CartaDePorteManager.enumCDPestado.Rechazadas

                Case "DescargasDeHoyMasTodasLasPosiciones"
                    estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
                Case "DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                    estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
            End Select



            If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
                txtFechaDesde.Text = #1/1/1753#
                txtFechaHasta.Text = #1/1/2100#
            ElseIf estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha Then

            End If

            'tit = cmbEstadoPopup.SelectedValue
            'Dim sWHERE = generarWHEREparaDataset(HFSC.Value, dr, tit, estado, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)


            Dim sError As String
            Dim sError2 As String




            If True Then

                Try

                    CDPMailFiltrosManager.EnviarMailFiltroPorRegistro(HFSC.Value, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                      iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                  cmbPuntoVenta.SelectedValue, "", estado, _
                                                dr, sError, False, _
                                                ConfigurationManager.AppSettings("SmtpServer"), _
                                                ConfigurationManager.AppSettings("SmtpUser"), _
                                                ConfigurationManager.AppSettings("SmtpPass"), _
                                                 ConfigurationManager.AppSettings("SmtpPort"), _
                                                  "", sError2)

                Catch ex As Exception

                    ErrHandler2.WriteError("Error al enviar mail. " & ex.ToString & " " & destinatario & " " & tit & " " & output.Length)
                    MsgBoxAjax(Me, "Error al enviar mail. " & ex.ToString & " Para: " & destinatario & " CC: " & UsuarioSesion.Mail(HFSC.Value, Session) & " Filtro: " & tit & " Tamaño:" & output.Length)
                    ModalPopupExtender3.Show()
                    Exit Sub
                End Try



                MsgBoxAjax(Me, "Enviada con éxito.") ' CDPs filtradas: " & l)
                ModalPopupExtender3.Show()
                Exit Sub
            End If




        End With


    End Sub

    Protected Sub lnkEnviarYaVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEnviarYaVistaPrevia.Click

        Dim dr = TraerMetadata(HFSC.Value, -1).NewRow

        dr.Item("Emails") = txtPopEmails.Text
        dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(txtPopTitular.Text, HFSC.Value))
        dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(txtPopIntermediario.Text, HFSC.Value))
        dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(txtPopRComercial.Text, HFSC.Value))
        dr.Item("IdClienteAuxiliar") = IdNull(BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value))
        dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(txtPopCorredor.Text, HFSC.Value))
        dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(txtPopDestinatario.Text, HFSC.Value))
        dr.Item("Destino") = IdNull(BuscaIdWilliamsDestinoPreciso(txtPopDestino.Text, HFSC.Value))
        dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(txtPopProcedencia.Text, HFSC.Value))



        dr.Item("FechaDesde") = iisValidSqlDate(txtFechaDesdePopup.Text, DBNull.Value)
        dr.Item("FechaHasta") = iisValidSqlDate(txtFechaHastaPopup.Text, DBNull.Value)

        Dim s As String
        ProntoOptionButton(CriterioWHERE, s)
        dr.Item("AplicarANDuORalFiltro") = s



        txtFechaDesde.Text = txtFechaDesdePopup.Text
        txtFechaHasta.Text = txtFechaHastaPopup.Text


        dr.Item("Modo") = cmbPopModo.SelectedValue
        dr.Item("Orden") = Val(txtPopOrden.Text)
        dr.Item("Contrato") = Val(txtPopContrato.Text)
        dr.Item("EnumSyngentaDivision") = optDivisionSyngenta.Text
        dr.Item("ModoImpresion") = cmbPopModoImpresion.SelectedValue


        dr.Item("EsPosicion") = (cmbPopPosicion.SelectedValue = "Posicion")
        dr.Item("IdArticulo") = IdNull(BuscaIdArticuloPreciso(txtPopArticulo.Text, HFSC.Value))


        Dim estado As CartaDePorteManager.enumCDPestado
        Select Case cmbEstadoPopup.SelectedValue
            Case "Posición"
                estado = CartaDePorteManager.enumCDPestado.Posicion
            Case "Descargas"
                estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
            Case "Rechazos"
                estado = CartaDePorteManager.enumCDPestado.Rechazadas

            Case "DescargasDeHoyMasTodasLasPosiciones"
                estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones
            Case "DescargasDeHoyMasTodasLasPosicionesEnRangoFecha"
                estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha
        End Select


        'lo manda a la casilla del destino
        Dim destinatario = UsuarioSesion.Mail(HFSC.Value, Session)
        Dim cuerpo = ""

        
        Dim output As String



        With dr
            Dim l As Long
            Dim tit = "" ' titulo
    



            If estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosiciones Then
                txtFechaDesde.Text = #1/1/1753#
                txtFechaHasta.Text = #1/1/2100#
            ElseIf estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha Then

            End If







            If output = "-1" Then
                MsgBoxAjax(Me, "No hay cartas de porte que cumplan con el filtro")
                ModalPopupExtender3.Show()
                Exit Sub
            ElseIf output = "-2" Then
                MsgBoxAjax(Me, "Mail grande para modo IDE")
                ModalPopupExtender3.Show()
                Exit Sub
            End If





            Dim De As String
            Dim ccoaddress As String = UsuarioSesion.Mail(HFSC.Value, Session)  'agregar en la copia a descargas sarasa

            If UsuarioSesion.Mail(HFSC.Value, Session) = "" Then
                MsgBoxAjax(Me, "Tu registro de empleado no tiene configurado el mail")
                Exit Sub
            End If



            Select Case cmbPuntoVenta.SelectedValue
                Case 1
                    De = "buenosaires@williamsentregas.com.ar"
                    ccoaddress = UsuarioSesion.Mail(HFSC.Value, Session) + ", descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                Case 2
                    De = "sanlorenzo@williamsentregas.com.ar"
                    ccoaddress = UsuarioSesion.Mail(HFSC.Value, Session) + ", descargas-sl@williamsentregas.com.ar" ' & CCOaddress
                Case 3
                    De = "arroyoseco@williamsentregas.com.ar"
                    ccoaddress = UsuarioSesion.Mail(HFSC.Value, Session) + ", descargas-as@williamsentregas.com.ar" '& CCOaddress
                Case 4
                    De = "bahiablanca@williamsentregas.com.ar"
                    ccoaddress = UsuarioSesion.Mail(HFSC.Value, Session) + ", descargas-bb@williamsentregas.com.ar" ' & CCOaddress
                Case Else
                    De = "buenosaires@williamsentregas.com.ar"
                    ccoaddress = UsuarioSesion.Mail(HFSC.Value, Session) + ", descargas-ba@williamsentregas.com.ar" ' & CCOaddress
            End Select


    


            Dim AgrupadorDeTandaPeriodos As String = iisNull(.Item("AgrupadorDeTandaPeriodos"), -1)




            Dim AplicarANDuORalFiltro, ModoExportacion, optDivisionSyngenta

            Dim fechadesde As DateTime
            Dim fechahasta As DateTime

            Try

                Try
                    fechadesde = iisValidSqlDate(DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture), #1/1/1753#)

                Catch ex As Exception

                    fechadesde = iisValidSqlDate(DateTime.ParseExact(txtFechaDesde.Text, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture), #1/1/1753#)

                End Try

                Try
                    fechahasta = iisValidSqlDate(DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture), #1/1/2100#)

                Catch ex As Exception
                    fechahasta = iisValidSqlDate(DateTime.ParseExact(txtFechaHasta.Text, "MM/dd/yyyy", System.Globalization.CultureInfo.InvariantCulture), #1/1/2100#)

                End Try
            Catch ex As Exception

            End Try





            Dim sError As String
            Dim sError2 As String

            dr.Item("Emails") = destinatario


            If True Then

                Try

                    CDPMailFiltrosManager.EnviarMailFiltroPorRegistro(HFSC.Value, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
                                                                      iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                  cmbPuntoVenta.SelectedValue, "", estado, _
                                                dr, sError, False, _
                                                ConfigurationManager.AppSettings("SmtpServer"), _
                                                ConfigurationManager.AppSettings("SmtpUser"), _
                                                ConfigurationManager.AppSettings("SmtpPass"), _
                                                 ConfigurationManager.AppSettings("SmtpPort"), _
                                                  "", sError2)

                Catch ex As Exception

                    ErrHandler2.WriteError("Error al enviar mail. " & ex.ToString & " " & destinatario & " " & tit & " " & output.Length)
                    MsgBoxAjax(Me, "Error al enviar mail. " & ex.ToString & "De:" & De & " Para: " & destinatario & " CC: " & UsuarioSesion.Mail(HFSC.Value, Session) & " Filtro: " & tit & " Tamaño:" & output.Length)
                    ModalPopupExtender3.Show()
                    Exit Sub
                End Try



                MsgBoxAjax(Me, "Enviada con éxito.") ' CDPs filtradas: " & l)
                ModalPopupExtender3.Show()
                Exit Sub
            End If


        End With



    End Sub

    Function ConvertirExcelEnHtml(xlsFile As String)

        '        grabo el excel como pagina web?
        '        Excel()

        Dim out As String
        '        using (ExcelPackage pck = new ExcelPackage(newFile))
        '{
        '  ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Accounts");
        '  ws.Cells["A1"].LoadFromDataTable(dataTable, true);
        '  pck.Save();
        '}

        'Dim x As New OpenXmlPowerTools.WordprocessingDocumentManager
        'x.


        'If False Then


        '    Dim newFile = New FileInfo(xlsFile)

        '    Dim pck = New ExcelPackage(newFile)

        'Else

        '    outf = ExcelToCSV(xlsFile, 20)
        'End If
        ''pck.SaveAs(
        'Return outf
    End Function





    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'http://forums.asp.net/t/1002747.aspx?PageIndex=1

    '    Re: GridView RowDeleting event fires twice ! (My Solution)
    '06-19-2007, 11:27 PM	
    'Contact
    'Favorites
    'Reply

    '2 point Member
    'Mimix
    'Member since 06-20-2007
    'Posts 1
    'I have a solution to this issue that is probably the cleanest I have seen.  I will allow you to make the fewest changes to your code and continue using the RowDeleting and RowDeleted events for the  GridView.
    'Currently when you build a command field for a delete button it will look something like this.

    ' <asp:CommandField ButtonType="Image" DeleteImageUrl="images/delete.gif" ShowDeleteButton="true"  />

    'By Changing the ButtonType to "Link" and modifying the DeleteText you will have the same delete image that works exactly like the Image Button Type but without the double firing event.  Here is the modified code.

    '<asp:CommandField ButtonType="Link" DeleteText="<img src='images/delete.gif' alt='Delete this' border='0' />" ShowDeleteButton="true" />

    'Additionally, I am constantly being asked about how to add a confirm dialog box to the delete button.  You can use the following code on the RowDataBound event to add the confirmation.

    ' If e.Row.RowType = DataControlRowType.DataRow Then
    '    Dim lnk As LinkButton = e.Row.Cells(1).Controls(0)
    '    lnk.OnClientClick = "if(!confirm('Are you sure you want to delete this?')) return false;"
    ' End If

    'I hope this helps!
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub cmbBuscarEsteCampo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.TextChanged
        ReBind()
    End Sub




    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "CDPs Mails")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            GridView1.Visible = False
            LinkAgregarRenglon.Visible = False
        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            GridView1.Columns(1).Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            GridView1.Columns(GridView1.Columns.Count - 1).Visible = False
        End If

    End Sub


    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GuardaChecks()
        GridView1.PageIndex = e.NewPageIndex
        ReBind()
    End Sub





    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////
    '////////////////////////////////////////////
    '////////////////////////////////////////////



    Sub ResetChecks()
        Dim lista As New Generic.List(Of String)
        For Each Item In Session.Contents
            If Left(Item, 4) = "page" Then lista.Add(Item)
        Next
        For Each i In lista
            Session.Remove(i)
        Next
    End Sub

    Sub GuardaChecks()
        'persistencia de los checks http://forums.asp.net/t/1147075.aspx
        'Response.Write(GridView1.PageIndex.ToString()) 'esto para qué es? si lo descomento, no cambia la pagina
        Dim d = GridView1.PageCount
        Dim values(GridView1.PageSize) As Boolean
        Dim chb As CheckBox
        Dim count = 0
        For i = 0 To GridView1.Rows.Count - 1
            chb = GridView1.Rows(i).FindControl("CheckBox1")
            If Not IsNothing(chb) Then values(i) = chb.Checked
        Next
        Session("page" & GridView1.PageIndex) = values

    End Sub


    Protected Sub HeaderCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'this is for header checkbox changed event


        'For p = 0 To GridView1.PageCount - 1

        '    'reviso cada pagina de checks
        '    Dim values() As Boolean = Session("page" & p)

        '    For Each row As GridViewRow In GridView1.Rows
        '        For i = 0 To row.Cells.Count - 1
        '            Dim cell As TableCell = row.Cells(i)
        '            Dim c As CheckBox = row.Cells(0).Controls(1)
        '            c.Checked = sender.Checked
        '        Next
        '    Next
        'Next

        For Each row As GridViewRow In GridView1.Rows
            For i = 0 To row.Cells.Count - 1
                Dim cell As TableCell = row.Cells(i)
                Dim c As CheckBox = row.Cells(0).Controls(1)
                c.Checked = sender.Checked
            Next
        Next



        MarcarTodosLosChecks(sender.Checked)


        'GuardaChecks() 'acá tendría que grabar tambien el estado 
    End Sub

    Sub MarcarTodosLosChecks(ByVal check As Boolean)
        Dim d = GridView1.PageCount
        Dim values(GridView1.PageSize) As Boolean
        'Dim values(GridView1.Rows.Count) As Boolean
        Dim ids(GridView1.Rows.Count) As Long


        For p = 0 To GridView1.PageCount
            For i = 0 To GridView1.PageSize
                values(i) = check
            Next
            Session("page" & p) = values
        Next
    End Sub



    Function ListaDeCDPTildados() As String
        GuardaChecks()

        'hay que filtrar el datatable por el mismo criterio de la grilla
        Dim puntoventa = Val(cmbPuntoVenta.SelectedValue)
        If puntoventa = -1 Then puntoventa = 0


        Dim dt As DataTable = CDPMailFiltrosManager2.Fetch(HFSC.Value, puntoventa)
        Dim sWHERE = CDPMailFiltrosManager2.GenerarWHEREparaFiltrarFiltros_ODS(HFSC.Value, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, cmbPuntoVenta.SelectedValue)
        Dim dv As DataView = New DataView(dt, sWHERE, "", DataViewRowState.OriginalRows)




        Dim chb As CheckBox
        Dim s As String = "0"
        For p = 0 To GridView1.PageCount - 1

            'reviso cada pagina de checks
            Dim values() As Boolean = Session("page" & p)


            If Not IsNothing(values) Then

                For i = 0 To GridView1.PageSize - 1  'si en el paso 2 reseteo el datasource de la grilla del paso 1, no sé más qué buscar...
                    'chb = GridView1.Rows(i).FindControl("CheckBox1")
                    'chb.Checked = values(i)
                    Dim indice = i + p * GridView1.PageSize
                    If indice < dv.Count Then
                        If values(i) Then


                            s = s & "," & dv(indice).Item("IdWilliamsMailFiltro")
                            'Debug.Print(dt.Rows(indice).Item(2))
                            'Debug.Print(dv(indice).Item("IdWilliamsMailFiltro"))
                        End If
                    End If
                Next
            End If

        Next
        Return s
    End Function

    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////


    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    'BIND de combos
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        If (e.Row.RowType = DataControlRowType.DataRow) Then

            'Hago el bind de los controles para EDICION

            Dim cmbArticulo As DropDownList = e.Row.FindControl("cmbArticulo")

            If Not IsNothing(cmbArticulo) Then
                cmbArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
                cmbArticulo.DataTextField = "Titulo"
                cmbArticulo.DataValueField = "IdArticulo"
                cmbArticulo.DataBind()
                cmbArticulo.Items.Insert(0, New ListItem("", -1)) 'recorda que hay DOS combos (uno para alta y otro para edicion)


                'cmbType.DataSource = .FetchCustomerType()
                'cmbType.DataBind()
                'cmbType.SelectedValue = GridView1.DataKeys(e.Row.RowIndex).Values(1).ToString()






                ac = e.Row.FindControl("AutoCompleteExtender21")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender22")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender23")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender24")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender25")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender26")
                ac.ContextKey = HFSC.Value
                ac = e.Row.FindControl("AutoCompleteExtender27")
                ac.ContextKey = HFSC.Value

            End If

            'Dim btnExcel As Button = e.Row.FindControl("cmbArticulo")
            'If AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnExcel) Then


        End If


        If (e.Row.RowType = DataControlRowType.Footer) Then

            'Hago el bind de los controles para ALTA

            Dim cmbNewArticulo As DropDownList = e.Row.FindControl("cmbNewArticulo")
            cmbNewArticulo.DataSource = ArticuloManager.GetListCombo(HFSC.Value)
            cmbNewArticulo.DataTextField = "Titulo"
            cmbNewArticulo.DataValueField = "IdArticulo"
            cmbNewArticulo.DataBind()
            cmbNewArticulo.Items.Insert(0, New ListItem("", -1))   'recorda que hay DOS combos (uno para alta y otro para edicion)
            'cmbNewType.DataSource = .FetchCustomerType()
            'cmbNewType.DataBind()


            ac = e.Row.FindControl("AutoCompleteExtender1")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender2")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender3")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender4")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender5")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender6")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender7")
            ac.ContextKey = HFSC.Value

        End If

    End Sub


    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub

    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////


    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx
    '    http://www.aspdotnetcodes.com/GridView_Insert_Edit_Update_Delete.aspx

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If (e.CommandName.Equals("Excel")) Then

            Dim r = Convert.ToInt32(e.CommandArgument)
            m_Id = GridView1.DataKeys(r Mod GridView1.PageSize).Value

            Dim sWHERE = GenerarWHEREparaFiltrarFiltros_ODS(HFSC.Value, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, _
                                                          cmbPuntoVenta.SelectedValue)
            Dim dt = DataTableWHERE(Fetch(HFSC.Value, 0), sWHERE)
            'DebugDatatableAlEscritorio(dt)
            Dim dr As DataRow = DataTableWHERE(dt, "IdWilliamsMailFiltro=" & m_Id).Rows(0)


            Dim l As Long
            Dim estado As CartaDePorteManager.enumCDPestado
            Select Case cmbEstado.Text
                Case "Descargas"
                    estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas
                Case "Posición"
                    estado = CartaDePorteManager.enumCDPestado.Posicion
                Case "Rechazos"
                    estado = CartaDePorteManager.enumCDPestado.Rechazadas
            End Select

            Dim tit As String
            Dim output As String
            'Dim sWhereOtro = generarWHEREparaDataset(HFSC.Value, dr, "", estado, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), cmbPuntoVenta.SelectedValue)
            output = generarNotasDeEntregaConReportViewer(HFSC.Value, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), dr, estado, l, tit, Server.MapPath("~/Imagenes/Williams.bmp"), cmbPuntoVenta.SelectedValue)

            Try
                Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
                If MyFile1.Exists Then
                    Response.ContentType = "application/octet-stream"
                    Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                    'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                    'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                    'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                    Response.TransmitFile(output)
                    Response.End()
                Else
                    MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
                End If
            Catch ex As Exception
                MsgBoxAjax(Me, ex.ToString)
                Return
            End Try

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

        ElseIf (e.CommandName.Equals("AddNew")) Then
            'Se hace un alta en la grilla 
            '(si se está llamando dos veces, fijate que la funcion no esté vinculada al evento 
            'tanto con el Handles como con el OnRowCommand del markup)

            Dim r As GridViewRow
            r = GridView1.FooterRow
            With r

                'Metodo con datatable
                Dim dt = TraerMetadata(HFSC.Value)
                Dim dr = dt.NewRow
                dr.Item("Emails") = TextoWebControl(.FindControl("txtNewEmails"))
                dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewVendedor")), HFSC.Value))
                dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden1")), HFSC.Value))
                dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden2")), HFSC.Value))
                dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(TextoWebControl(.FindControl("txtNewCorredor")), HFSC.Value))
                dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewEntregador")), HFSC.Value))
                dr.Item("Destino") = IdNull(BuscaIdWilliamsDestinoPreciso(TextoWebControl(.FindControl("txtNewDestino")), HFSC.Value))
                dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtNewProcedencia")), HFSC.Value))

                dr.Item("FechaDesde") = iisValidSqlDate(TextoWebControl(.FindControl("txtNewFechaDesde")), DBNull.Value)
                dr.Item("FechaHasta") = iisValidSqlDate(TextoWebControl(.FindControl("txtNewFechaHasta")), DBNull.Value)
                Dim s As String
                ProntoOptionButton(CriterioWHERE, s)
                dr.Item("AplicarANDuORalFiltro") = s


                dr.Item("Modo") = TextoWebControl(.FindControl("cmbNewModo"))
                dr.Item("Orden") = Val(TextoWebControl(.FindControl("txtNewOrden")))
                dr.Item("Contrato") = Val(TextoWebControl(.FindControl("txtNewContrato")))

                dr.Item("EsPosicion") = (TextoWebControl(.FindControl("cmbNewPosicion")) = "Posicion")
                dr.Item("IdArticulo") = IdNull(CType(.FindControl("cmbNewArticulo"), DropDownList).SelectedValue)

                dr.Item("PuntoVenta") = IIf(cmbPuntoVenta.SelectedValue < 1, 1, cmbPuntoVenta.SelectedValue)

                dt.Rows.Add(dr)

                Insert(HFSC.Value, dt)




                ''metodo con objetito
                'Dim o As New CDPMailFiltro
                'o.Emails = TextoWebControl(.FindControl("txtNewEmails")) 'txtEmails.Text
                'o.Vendedor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewVendedor")), HFSC.Value)
                'o.CuentaOrden1 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden1")), HFSC.Value)
                'o.CuentaOrden2 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCuentaOrden2")), HFSC.Value)
                'o.Corredor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewCorredor")), HFSC.Value)
                'o.Entregador = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewEntregador")), HFSC.Value)
                'o.IdArticulo = CType(.FindControl("cmbNewArticulo"), DropDownList).SelectedValue

                'Insert(HFSC.Value, o)

            End With

            ReBind()

        ElseIf (e.CommandName.Equals("AddNewPopup")) Then
            AltaPopupABM()
        ElseIf (e.CommandName.Equals("EditPopup")) Then

            Dim r = Convert.ToInt32(e.CommandArgument)
            m_Id = GridView1.DataKeys(r Mod GridView1.PageSize).Value






            If False Then
                Dim dt = DataTableWHERE(Fetch(HFSC.Value, 0), GenerarWHEREparaFiltrarFiltros_ODS(HFSC.Value, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, cmbPuntoVenta.SelectedValue))

                'DebugDatatableAlEscritorio(dt)
                Dim draaaa As DataRow = DataTableWHERE(dt, "IdWilliamsMailFiltro=" & m_Id).Rows(0)
                'm_Id = dr.Item(0)
            End If

            Dim dr = FetchById(HFSC.Value, m_Id)

            EditarPopupABM(dr)
        End If

    End Sub


    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        'se aplican los cambios editados
        With GridView1.Rows(e.RowIndex)


            'Metodo con datatable
            Dim Id = GridView1.DataKeys(e.RowIndex).Values(0).ToString()
            Dim dt = TraerMetadata(HFSC.Value, Id)
            Dim dr = dt.Rows(0)

            dr.Item("Emails") = TextoWebControl(.FindControl("txtEmails"))
            dr.Item("Orden") = Val(TextoWebControl(.FindControl("txtOrden")))
            dr.Item("Contrato") = Val(TextoWebControl(.FindControl("txtContrato")))

            dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtVendedor")), HFSC.Value))
            dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden1")), HFSC.Value))
            dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden2")), HFSC.Value))
            dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(TextoWebControl(.FindControl("txtCorredor")), HFSC.Value))
            dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtEntregador")), HFSC.Value))
            dr.Item("Destino") = IdNull(BuscaIdWilliamsDestinoPreciso(TextoWebControl(.FindControl("txtDestino")), HFSC.Value))
            dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(TextoWebControl(.FindControl("txtProcedencia")), HFSC.Value))

            dr.Item("FechaDesde") = iisValidSqlDate(TextoWebControl(.FindControl("txtFechaDesde")), DBNull.Value)
            dr.Item("FechaHasta") = iisValidSqlDate(TextoWebControl(.FindControl("txtFechaHasta")), DBNull.Value)

            dr.Item("Modo") = TextoWebControl(.FindControl("cmbModo")) 'CType(.FindControl("cmbModo"), DropDownList).SelectedValue
            dr.Item("EsPosicion") = (TextoWebControl(.FindControl("cmbPosicion")) = "Posicion")
            dr.Item("IdArticulo") = IdNull(CType(.FindControl("cmbArticulo"), DropDownList).SelectedValue)

            Dim s As String = iisNull(dr.Item("AplicarANDuORalFiltro"))
            ProntoOptionButton(s, CriterioWHERE)


            Update(HFSC.Value, dt)


            ''metodo con objetito
            'Dim o As New CDPMailFiltro
            'o.Emails = TextoWebControl(.FindControl("txtEmails")) 'txtEmails.Text
            'o.Vendedor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtVendedor")), HFSC.Value)
            'o.CuentaOrden1 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden1")), HFSC.Value)
            'o.CuentaOrden2 = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCuentaOrden2")), HFSC.Value)
            'o.Corredor = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtCorredor")), HFSC.Value)
            'o.Entregador = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtEntregador")), HFSC.Value)
            'o.IdArticulo = CType(.FindControl("cmbArticulo"), DropDownList).SelectedValue

            'Update(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString(), o.Emails, o.Entregador, o.IdArticulo)
        End With

        GridView1.EditIndex = -1
        ReBind() 'hay que volver a pedir los datos...

    End Sub

    Sub ShowPopup()

        ViewState("IdDetallePresupuesto") = -1
        'txt_AC_Articulo.Text = ""
        'SelectedAutoCompleteIDArticulo.Value = 0
        'txtDetCantidad.Text = 0

        'UpdatePanelDetalle.Update()
        ModalPopupExtender3.Show()
    End Sub

    Sub SavePopup()

        'asd()

        'Me.ViewState.Add(mKey, myPresupuesto)
        'GridView1.DataSource = myPresupuesto.Detalles
        'GridView1.DataBind()

        'UpdatePanelGrilla.Update()

        'End If

        ''MostrarElementos(False)
        'mAltaItem = True
    End Sub


    Protected Sub GridView1_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView1.RowEditing
        'se empieza a editar un renglon
        GridView1.EditIndex = e.NewEditIndex
        ReBind() 'hay que volver a pedir los datos...
    End Sub

    Protected Sub GridView1_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView1.RowCancelingEdit
        'se cancelan los datos editados
        GridView1.EditIndex = -1
        ReBind() 'hay que volver a pedir los datos...
    End Sub


    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    Function TextoWebControl(ByVal c As WebControl) As String
        Try
            Select Case c.GetType.Name
                Case "Label"
                    Return CType(c, WebControls.Label).Text
                Case "DropDownList"
                    Return CType(c, WebControls.DropDownList).Text
                Case "TextBox"
                    Return CType(c, WebControls.TextBox).Text
                Case Else
                    Return Nothing
            End Select
        Catch ex As Exception
            'Tiene que explotar, para advertir que se le pasó un control invalido
        End Try

    End Function


    Function renglonControl(ByVal r As GridViewRow, ByVal sHeader As String) As WebControls.Label ' WebControls.TextBox
        If getGridIDcolbyHeader(sHeader, GridView1) = -1 Then Return New WebControls.Label 'si devuelvo Nothing para que no explote 

        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView1)).Controls(1), WebControls.Label)
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal sHeader As String) As String
        If getGridIDcolbyHeader(sHeader, GridView1) = -1 Then Return Nothing

        'Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView2)).Controls(1), WebControls.TextBox).Text()
        Return CType(r.Cells(getGridIDcolbyHeader(sHeader, GridView1)).Controls(1), WebControls.Label).Text()
    End Function

    Function renglon(ByVal r As GridViewRow, ByVal col As Integer) As String
        Return CType(r.Cells(col).Controls(1), WebControls.TextBox).Text()
    End Function
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub AltaPopupABM()
        '(si el boton no reacciona, probá sacando el CausesValidation)

        'OJO! si el popup es disparado por este boton antes, no va a ejecutarse este codigo, y no va a quedar en el
        'viestate el -1!!!!!
        m_Id = -1

        'RequiredFieldValidator1.Enabled = True 'desactivo validators del popup

        'RequiredFieldValidator1.IsValid = True 'porque me está apareciendo antes de aceptar. este problema no lo tengo en el abm de pedidos

        Timer1.Enabled = False

        ''Limpio el popup
        txtPopEmails.Text = ""

        txtPopEmails.Text = ""
        txtPopTitular.Text = ""
        txtPopIntermediario.Text = ""
        txtPopRComercial.Text = ""
        txtPopClienteAuxiliar.Text = ""
        txtPopCorredor.Text = ""
        txtPopDestinatario.Text = ""
        txtPopDestino.Text = ""
        txtPopProcedencia.Text = ""

        txtPopFechaDesde.Text = ""
        txtPopFechaHasta.Text = ""


        cmbPopModo.SelectedValue = 0
        txtPopOrden.Text = """"
        txtPopContrato.Text = ""



        refrescaPeriodoPopup()


        'UpdatePanelDetalle.Update()
        ModalPopupExtender3.Show()

    End Sub

    Sub EditarPopupABM(ByVal dr As DataRow)

        Timer1.Enabled = False


        txtPopEmails.Text = iisNull(dr.Item("Emails"))
        txtPopTitular.Text = iisNull(dr.Item("VendedorDesc"))
        txtPopIntermediario.Text = iisNull(dr.Item("CuentaOrden1Desc"))
        txtPopRComercial.Text = iisNull(dr.Item("CuentaOrden2Desc"))
        txtPopClienteAuxiliar.Text = NombreCliente(HFSC.Value, iisNull(dr.Item("IdClienteAuxiliar")))
        txtPopCorredor.Text = iisNull(dr.Item("CorredorDesc"))
        txtPopDestinatario.Text = iisNull(dr.Item("EntregadorDesc"))
        txtPopDestino.Text = iisNull(dr.Item("DestinoDesc"))
        txtPopProcedencia.Text = iisNull(dr.Item("ProcedenciaDesc"))

        txtPopFechaDesde.Text = iisNull(dr.Item("FechaDesde"))
        txtPopFechaHasta.Text = iisNull(dr.Item("FechaHasta"))

        'Dim s As Integer = IIf(iisNull(dr.Item("AplicarANDuORalFiltro")) = "", 1, 2)
        Dim s As String = iisNull(dr.Item("AplicarANDuORalFiltro"))
        ProntoOptionButton(s, CriterioWHERE)

        cmbPopModo.SelectedValue = iisNull(dr.Item("Modo"), 0)
        txtPopOrden.Text = iisNull(dr.Item("Orden"))
        txtPopContrato.Text = iisNull(dr.Item("Contrato"))
        txtPopArticulo.Text = iisNull(dr.Item("Producto"))

        Dim ss = iisNull(dr.Item("EnumSyngentaDivision"), "")
        Try
            optDivisionSyngenta.Text = IIf(ss = "Ambas", "", ss)
        Catch ex As Exception
            ErrHandler2.WriteError(ss + " " + ex.ToString)
        End Try

        cmbPopModoImpresion.SelectedValue = iisNull(dr.Item("ModoImpresion"), 0)


        refrescaPeriodoPopup()
        ModalPopupExtender3.Show() 'muestro el popup. Pero tengo que hacerlo explicito? No lo hace ya?


    End Sub

    Protected Sub btnSaveItem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItem.Click
        Dim mOk As Boolean

        Page.Validate("Detalle")
        mOk = Page.IsValid

        If Not EntidadManager.IsValidEmail(txtPopEmails.Text) And False Then
            MsgBoxAjax(Me, "Casilla de correo inválida")
            ModalPopupExtender3.Show()
            Return
        End If

        'If (Me.ViewState(mKey) IsNot Nothing) Then 'y esto?????
        If mOk Then




            Dim r As GridViewRow
            r = GridView1.FooterRow

            Dim dr As DataRow
            'Metodo con datatable
            Dim dt = TraerMetadata(HFSC.Value, m_Id)
            If m_Id < 1 Then
                dr = dt.NewRow
            Else
                dr = dt.Rows(0)
            End If

            dr.Item("Emails") = txtPopEmails.Text
            dr.Item("Vendedor") = IdNull(BuscaIdClientePreciso(txtPopTitular.Text, HFSC.Value))
            dr.Item("CuentaOrden1") = IdNull(BuscaIdClientePreciso(txtPopIntermediario.Text, HFSC.Value))
            dr.Item("CuentaOrden2") = IdNull(BuscaIdClientePreciso(txtPopRComercial.Text, HFSC.Value))
            dr.Item("IdClienteAuxiliar") = IdNull(BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value))
            dr.Item("Corredor") = IdNull(BuscaIdVendedorPreciso(txtPopCorredor.Text, HFSC.Value))
            dr.Item("Entregador") = IdNull(BuscaIdClientePreciso(txtPopDestinatario.Text, HFSC.Value))
            dr.Item("Destino") = IdNull(BuscaIdWilliamsDestinoPreciso(txtPopDestino.Text, HFSC.Value))
            dr.Item("Procedencia") = IdNull(BuscaIdLocalidadPreciso(txtPopProcedencia.Text, HFSC.Value))

            dr.Item("FechaDesde") = iisValidSqlDate(txtPopFechaDesde.Text, DBNull.Value)
            dr.Item("FechaHasta") = iisValidSqlDate(txtPopFechaHasta.Text, DBNull.Value)


            dr.Item("Corredor2") = IdNull(BuscaIdVendedorPreciso(txtPopCorredor2.Text, HFSC.Value))


            dr.Item("Orden") = Val(txtPopOrden.Text)
            dr.Item("Contrato") = Val(txtPopContrato.Text)

            dr.Item("EsPosicion") = (cmbPopPosicion.SelectedValue = "Posicion")
            dr.Item("IdArticulo") = IdNull(BuscaIdArticuloPreciso(txtPopArticulo.Text, HFSC.Value))

            dr.Item("PuntoVenta") = IIf(cmbPuntoVenta.SelectedValue < 1, 1, cmbPuntoVenta.SelectedValue)


            dr.Item("EnumSyngentaDivision") = optDivisionSyngenta.Text

            dr.Item("ModoImpresion") = cmbPopModoImpresion.SelectedValue


            Dim s As String
            ProntoOptionButton(CriterioWHERE, s)
            dr.Item("AplicarANDuORalFiltro") = s


            dr.Item("Modo") = cmbPopModo.SelectedValue


            If m_Id = -1 Then
                dt.Rows.Add(dr)
                Insert(HFSC.Value, dt)
            Else
                Update(HFSC.Value, dt)
            End If






            'GridView1.DataBind()

            'UpdatePanelDetalle.Update()
            If Not Debugger.IsAttached Then
                ReBind() 'si traigo un top 120, cuando marco las tildes sólo las marca de esas 120....
            Else
                RebindPrimeraPagina()
            End If


            'gv1rebind()
        Else

            'como el item es inválido, no oculto el popup
            ModalPopupExtender3.Show()
        End If

    End Sub

    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    'Persistencia en el viewstate
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    Public Property m_Datatable() As DataTable
        Get
            Return ViewState("m_Datatable")
        End Get
        Set(ByVal value As DataTable)
            ViewState("m_Datatable") = value
        End Set
    End Property

    Public Property m_Id() As Long
        Get
            Return ViewState("m_Id")
        End Get
        Set(ByVal value As Long)
            ViewState("m_Id") = value
        End Set
    End Property


    Sub gv1rebind(Optional ByVal dt As Data.DataTable = Nothing)


        Dim dta = CDPMailFiltrosManager2.Fetch(HFSC.Value, 0)
        'Dim c = DataTableWHERE(dta, "UltimoResultado='En Cola'").Rows.Count
        RefrescaCantidadEncolada()


        If IsNothing(dt) Then
            dt = ViewstateToDatatable()
        End If

        Dim dv As DataView = New DataView(dt, CDPMailFiltrosManager2.GenerarWHEREparaFiltrarFiltros_ODS(HFSC.Value, txtBuscar.Text, cmbBuscarEsteCampo.SelectedValue, cmbPuntoVenta.SelectedValue), "", DataViewRowState.OriginalRows)

        If dt.Rows.Count > 0 Then
            GridView1.DataSource = dv
            GridView1.DataBind()
        Else
            'la grilla está vacia. Creo un renglon nuevo para el alta y un cartel de aviso
            dt.Rows.Add(dt.NewRow())
            GridView1.DataSource = dt
            GridView1.DataBind()

            Dim TotalColumns = GridView1.Rows(0).Cells.Count
            GridView1.Rows(0).Cells.Clear()
            GridView1.Rows(0).Cells.Add(New TableCell())
            GridView1.Rows(0).Cells(0).ColumnSpan = TotalColumns
            GridView1.Rows(0).Cells(0).Text = "No Record Found"
        End If

        lblGrilla1Info.Text = dt.Rows.Count & " filas"

        GridView1.DataBind()
    End Sub





    Sub DatatableToViewstate(ByVal dt As Data.DataTable)
        'ViewState("MyData") = dt
    End Sub

    Function ViewstateToDatatable() As Data.DataTable

        Dim x As Data.DataTable

        'x = CType(ViewState("MyData"), Data.DataTable)

        Return x
    End Function

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        CDPMailFiltrosManager2.Delete(HFSC.Value, GridView1.DataKeys(e.RowIndex).Values(0).ToString())
        ReBind()
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////


    Private Sub ReBind()
        Dim dtFiltros As DataTable

        ''METODO 2
        'Dim pageIndex = GridView1.PageIndex
        ''filtrar por pagina
        'Dim lTopRow = pageIndex * GridView1.PageSize + 1
        'Dim dtFiltros = GetListDatasetPaginadoConWHERE(HFSC.Value, "", "", Val(cmbPuntoVenta.SelectedValue), "", lTopRow, GridView1.PageSize).Tables(0)


        'METODO 1
        Dim puntoventa = Val(cmbPuntoVenta.SelectedValue)
        If puntoventa = -1 Then puntoventa = 0
        dtFiltros = Fetch(HFSC.Value, puntoventa)

        gv1rebind(dtFiltros)
        DatatableToViewstate(dtFiltros)

    End Sub


    Sub RebindPrimeraPagina()
        If Not Debugger.IsAttached Then
            ReBind() 'si traigo un top 120, cuando marco las tildes sólo las marca de esas 120....
            Return
        End If



        Dim puntoventa = Val(cmbPuntoVenta.SelectedValue)
        If puntoventa = -1 Then puntoventa = 0
        Dim dtFiltros = FetchPrimeraPagina(HFSC.Value, Val(puntoventa))


        'For Each dr In dtFiltros.Rows
        ' dr("Emails") = dr("Emails").ToString.Replace(";", "; ")
        ' Next

        gv1rebind(dtFiltros)
        DatatableToViewstate(dtFiltros)
        lblGrilla1Info.Text = ""
    End Sub



    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub cmbEstadoPopup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbEstadoPopup.SelectedIndexChanged

        refrescaPeriodoPopup()
    End Sub

    Protected Sub cmbEstado_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbEstado.SelectedIndexChanged
        refrescaPeriodo()

    End Sub



    Protected Sub cmbPeriodoPopup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodoPopup.SelectedIndexChanged
        refrescaPeriodoPopup()
        'no hace falta q haga rebind, porque este es un caso loco... no se aplica a la grilla, sino a lo que generan los filtros
        'ReBind()
    End Sub

    Sub refrescaPeriodoPopup()
        txtFechaDesdePopup.Visible = False
        txtFechaHastaPopup.Visible = False




        If cmbEstadoPopup.Text = "DescargasDeHoyMasTodasLasPosiciones" Then
            cmbPeriodoPopup.Text = "Cualquier fecha"
            cmbPeriodoPopup.Enabled = False

        ElseIf cmbEstadoPopup.Text = "DescargasDeHoyMasTodasLasPosicionesEnRangoFecha" Then
            'dejando por default dos días antes a la fecha
            'cmbPeriodo.Text = "Ayer"
            cmbPeriodoPopup.Text = "Personalizar"
            txtFechaDesdePopup.Text = DateAdd(DateInterval.Day, -2, Today)
            txtFechaHastaPopup.Text = Today
        Else
            cmbPeriodoPopup.Enabled = True
        End If





        Select Case cmbPeriodoPopup.Text

            Case "Cualquier fecha"
                txtFechaDesdePopup.Text = ""
                txtFechaHastaPopup.Text = ""

            Case "Hoy"
                txtFechaDesdePopup.Text = Today
                txtFechaHastaPopup.Text = ""

            Case "Ayer"
                txtFechaDesdePopup.Text = DateAdd(DateInterval.Day, -1, Today)
                txtFechaHastaPopup.Text = DateAdd(DateInterval.Day, -1, Today)

            Case "Este mes"
                txtFechaDesdePopup.Text = GetFirstDayInMonth(Today)
                txtFechaHastaPopup.Text = GetLastDayInMonth(Today)
            Case "Mes anterior"
                txtFechaDesdePopup.Text = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
                txtFechaHastaPopup.Text = GetLastDayInMonth(DateAdd(DateInterval.Month, -1, Today))
            Case "Personalizar"
                txtFechaDesdePopup.Visible = True
                txtFechaHastaPopup.Visible = True
        End Select

        'UpdatePanel4.Update()
        ModalPopupExtender3.Show()
    End Sub


    Protected Sub cmbPeriodo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodo.SelectedIndexChanged
        refrescaPeriodo()
        'no hace falta q haga rebind, porque este es un caso loco... no se aplica a la grilla, sino a lo que generan los filtros
        'ReBind()
    End Sub

    Sub refrescaPeriodo()



        txtFechaDesde.Visible = False
        txtFechaHasta.Visible = False

        If cmbEstado.Text = "DescargasDeHoyMasTodasLasPosiciones" Then
            cmbPeriodo.Text = "Cualquier fecha"
            cmbPeriodo.Enabled = False

        ElseIf cmbEstado.Text = "DescargasDeHoyMasTodasLasPosicionesEnRangoFecha" Then
            'dejando por default dos días antes a la fecha
            'cmbPeriodo.Text = "Ayer"
            cmbPeriodo.Text = "Personalizar"
            txtFechaDesde.Text = DateAdd(DateInterval.Day, -2, Today)
            txtFechaHasta.Text = Today
        Else
            cmbPeriodo.Enabled = True
        End If


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













    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



















    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        AltaPopupABM()
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        'persistencia de los checks http://forums.asp.net/t/1147075.aspx
        If Not IsNothing(Session("page" & GridView1.PageIndex)) Then
            Dim chb As CheckBox
            Dim values() As Boolean = Session("page" & GridView1.PageIndex)
            For i = 0 To IIf(values.Length < GridView1.Rows.Count, values.Length, GridView1.Rows.Count) - 1
                chb = GridView1.Rows(i).FindControl("CheckBox1")
                chb.Checked = values(i)
            Next
        End If
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        ReBind()
        'gv1rebind()
    End Sub




    Protected Sub LinkButton6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton6.Click

        Dim rebotes As String = ""
        Try
            rebotes = VerificoMailsRebotados(HFSC.Value, Session)
        Catch ex As Exception
            ErrHandler2.WriteError("Problemas con los mails: " & ex.ToString)
        End Try


        If rebotes <> "" Then
            MsgBoxAlert(rebotes)
            'rebotes = ""
        End If

    End Sub









    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Public ReadOnly Property urlLocal() As String
        Get
            Return ConfigurationManager.AppSettings("urlLocal")
        End Get
    End Property
    Public ReadOnly Property urlWilliamsRelease() As String
        Get
            Return ConfigurationManager.AppSettings("urlWilliamsRelease")
        End Get
    End Property
    Public ReadOnly Property urlWilliamsDebug() As String
        Get
            Return ConfigurationManager.AppSettings("urlWilliamsDebug")
        End Get
    End Property


  


    Sub GeneraYEnviaLosMailsTildadosDeLaGrilla(ByVal estado As CartaDePorteManager.enumCDPestado, Optional ByVal bVistaPrevia As Boolean = False)
        'Cómo hacer este proceso desatendido?????? -Un windows service en .net, como dice el tipo de abajo
        'http://codebetter.com/blogs/brendan.tompkins/archive/2004/05/13/13484.aspx
        'http://forums.asp.net/t/309249.aspx

        'IMHO the solution to this problem would be this: 
        '- create a windows Service in .Net that generated the printouts 
        '- have you ASP.NET application talk to the service to print it out. 
        'This way the two processes can be run under completely different account/securty contexts. The tricky stuff is where you communicate between the two processes. 

        Dim tHoraEmpieza, tHoraTermina As Date

        Dim nMailsEncolados, nMailsVacios, nMailsExitosos, nMailsConError As Integer

        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        Dim sError As String = ""

        tHoraEmpieza = Now
        lblAlerta.Text = ""

        Dim ss As String = ""



        Dim s() As String = Split(ListaDeCDPTildados(), ",") 'y este está trayendo otro renglon!


        'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse
        'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse

        Dim AgrupadorDeTandaPeriodos As Integer = Rnd() * 20000 'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse
        'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse
        'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse

        'hacer update de todas las cartas que cumplan con ese periodo, para ayudar en el filtro a MailWork

        If False Then

            'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse
            'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse
            'no usarlo acá al agrupador, sino en el MailLoopWork, así puede manejar varias tandas sin pisarse
            Dim fechadesde = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            Dim fechahasta = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)
            'Dim db As New LinqCartasPorteDataContext(HFSC.Value) 'no uses linq, porque necesitas más bien hacer updates
            Try

                Dim sWHERE As String = CartaDePorteManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
                                       "", _
                                      estado, "", -1, -1, _
                                      -1, -1, _
                                      -1, -1, -1, -1, _
                                       CartaDePorteManager.FiltroANDOR.FiltroOR, "", _
                                      fechadesde, fechahasta, _
                                       -1, , , , , )

                EntidadManager.ExecDinamico(HFSC.Value, "UPDATE CartasDePorte  SET AgrupadorDeTandaPeriodos=" & AgrupadorDeTandaPeriodos & " FROM CartasDePorte CDP  WHERE " & sWHERE)
            Catch ex As Exception
                ErrHandler2.WriteError("Falló el AgrupadorDeTandaPeriodos. " & ex.ToString)
            End Try
        End If





        nMailsEncolados = ColaMails.EncolarFiltros(s, estado, bVistaPrevia, AgrupadorDeTandaPeriodos, cmbPuntoVenta.SelectedValue, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), txtRedirigirA.Text, HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario))




        If nMailsEncolados = 0 Then
            MsgBoxAjax(Me, "No hay filtros tildados para enviar")
            Exit Sub
        End If


        'despertar worker
        'despertar worker
        'despertar worker

        'Dim  getitnow As Global
        'getitnow.
        'despertar()
        'Global.hitpa()
        'Me.Context.ApplicationInstance
        'despertar worker
        'despertar worker
        'despertar worker
        'despertar worker

        'http://200.80.65.13/Pronto/ProntoWeb/CartasDePortes.aspx
        'Const urlLocal = "http://localhost:48391/prontoweb/TestCacheTimeout/WebForm1.aspx"
        'no usés un alias del tipo  prontoweb.williamsentregas.com.ar  porque desde el servidor no lo encuentra. usá "localhost" o la ip harcodeada
        '       Const urlWilliamsRelease = "http://localhost/Pronto/TestCacheTimeout/WebForm1.aspx"
        '        Const urlWilliamsDebug = "http://190.2.243.13/williamsdebug/TestCacheTimeout/WebForm1.aspx"


        Try
            Dim client = New Net.WebClient
            If System.Diagnostics.Debugger.IsAttached() Then
                client.DownloadData(urlLocal)
                CDPMailFiltrosManager.MailLoopWork(HFSC.Value)
            Else
                client.DownloadData(urlWilliamsRelease)
            End If

        Catch ex As Exception
            ErrHandler2.WriteError("Falló el despertar. " & ex.ToString & " " & urlWilliamsRelease)
        End Try



        If True Then 'usando el metodo del servicio de mail
            'Process.Start()
            'Mailservicio.start()
            ' ReBind()
            RefrescaCantidadEncolada()
            Exit Sub
        End If





        'For Each id As Long In s

        '    If id = 0 Then Continue For

        '    'cortar un minuto antes del timeout
        '    If DateDiff(DateInterval.Second, tHoraEmpieza, Now) > TIMEOUT_MANUAL_EN_SEGUNDOS Then
        '        ss &= "Tiempo de espera superado. "
        '        ErrHandler2.WriteError(sError)
        '        Exit For
        '    End If


        '    Dim ccoaddress As String '= iisNull(UsuarioSesion.Mail(HFSC.Value, Session))
        '    Dim sSmtpUser As String = ConfigurationManager.AppSettings("SmtpUser")
        '    Select Case cmbPuntoVenta.SelectedValue
        '        Case 1
        '            sSmtpUser = ConfigurationManager.AppSettings("SmtpUserPuntoVenta1") ' "buenosaires@williamsentregas.com.ar"
        '            ccoaddress = "descargas-ba@williamsentregas.com.ar"
        '        Case 2
        '            sSmtpUser = ConfigurationManager.AppSettings("SmtpUserPuntoVenta2") '  "sanlorenzo@williamsentregas.com.ar"
        '            ccoaddress = "descargas-sl@williamsentregas.com.ar"
        '        Case 3
        '            sSmtpUser = ConfigurationManager.AppSettings("SmtpUserPuntoVenta3") '  "arroyoseco@williamsentregas.com.ar"
        '            ccoaddress = "descargas-as@williamsentregas.com.ar"
        '        Case 4
        '            sSmtpUser = ConfigurationManager.AppSettings("SmtpUserPuntoVenta4") '  "bahiablanca@williamsentregas.com.ar"
        '            ccoaddress = "descargas-bb@williamsentregas.com.ar"
        '        Case Else
        '            sSmtpUser = ConfigurationManager.AppSettings("SmtpUserPuntoVenta1") '  "buenosaires@williamsentregas.com.ar"
        '            ccoaddress = "descargas-ba@williamsentregas.com.ar"
        '    End Select






        '    Try
        '        Dim output = EnviarMailFiltroPorId(HFSC.Value, _
        '                                iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), _
        '                                iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
        '                                cmbPuntoVenta.SelectedValue, _
        '                                id, "", estado, sError, bVistaPrevia, _
        '                               ConfigurationManager.AppSettings("SmtpServer"), _
        '                                            sSmtpUser, _
        '                                            ConfigurationManager.AppSettings("SmtpPass"), _
        '                                            ConfigurationManager.AppSettings("SmtpPort"), _
        '                                               ccoaddress)

        '        If output = "-1" Or output = "-2" Then
        '            nMailsVacios += 1
        '        Else
        '            nMailsExitosos += 1
        '        End If
        '    Catch ex As Exception
        '        ErrHandler2.WriteError(sError & vbCrLf & "ERROR. IdFiltro " & id & " :: " & ex.ToString)
        '        nMailsConError += 1
        '        '2 excepciones comunes acá:
        '        '* The process cannot access the file 'C:\WINDOWS\TEMP\Listado general 09nov2011_085755.xls' because it is being used by another process.
        '        '* Thread was being aborted.
        '    End Try

        'Next



        ''VerificoMailsRebotados()
        'tHoraTermina = Now

        'ss &= " Tiempo usado: " & DateDiff(DateInterval.Second, tHoraEmpieza, tHoraTermina) & " segundos. " & vbCrLf & _
        '        " Seleccionados: " & nMailsEncolados & vbCrLf & _
        '        ". Vacios " & nMailsVacios & vbCrLf & _
        '        ". Enviados " & nMailsExitosos & vbCrLf & _
        '        ". Erróneos " & nMailsConError & vbCrLf & _
        '        ". Pendientes " & nMailsConError & vbCrLf ' & ". Errores" & sError

        ''MsgBoxAlert(ss)
        'ErrHandler2.WriteError(ss)
        'MsgBoxAjax(Me, ss)
        'lblAlerta.Text = ss
        'ReBind()

    End Sub


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged

        'TODO (tarea) tiene que filtar la lista de filtros Y lo generado?

    End Sub

    Protected Sub cmbPuntoVenta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.TextChanged

    End Sub


    Protected Sub btnRefresca_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresca.Click


        ReBind()
    End Sub

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click


        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx
        'TestCacheTimeout/WebForm1.aspx



        'Dim s = ExcelToHtml("C:\WINDOWS\TEMP\Listado general 14Nov2013_090820_YOD.xls")
        'Dim s = ExcelToHtml("C:\WINDOWS\TEMP\Listado general 15nov2013_070539_NYP.xls")

        MandaEmail_Nuevo("mscalella911@gmail.com", _
                                "ccc", _
                              "", _
                             "buenosaires@williamsentregas.com.ar", _
                            ConfigurationManager.AppSettings("SmtpServer"), _
                            ConfigurationManager.AppSettings("SmtpUser"), _
                            ConfigurationManager.AppSettings("SmtpPass"), _
                            "", _
                            ConfigurationManager.AppSettings("SmtpPort"), _
                            , _
                            "", )


        'MsgBoxAjax(Me, s)



    End Sub

    Protected Sub btnPaginaAvanza_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaAvanza.Click





        Try
            GridView1.PageIndex += 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        ReBind()
    End Sub

    Protected Sub btnPaginaRetrocede_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaRetrocede.Click
        Try
            If GridView1.PageIndex < 1 Then Return
            GridView1.PageIndex -= 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        ReBind()
    End Sub

    Protected Sub btnCancelarTrabajos_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelarTrabajos.Click

        ColaMails.CancelarCola(HFSC.Value)

        ReBind()
    End Sub

    Protected Sub Timer1_Tick(ByVal sender As Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        'ReBind()
        RefrescaCantidadEncolada()
    End Sub

    Sub RefrescaCantidadEncolada()
        'Dim dt = ExecDinamico(HFSC.Value, "select count(*) from WilliamsMailFiltrosCola where UltimoResultado='En Cola' ")
        'lblAlerta.Text = dt.Rows(0).Item(0) & " trabajos en cola"

        Dim c = ColaMails.TraerEncoladosCount(HFSC.Value).Rows(0).Item(0)
        Dim a = ColaMails.TraerAtrasadosCount(HFSC.Value).Rows(0).Item(0)


        lblAlerta.Text = c & " trabajos en cola"
        lblAlerta.Text &= "            -----     " & a & " atendidos"

    End Sub



    Protected Sub btnVerLog_Click(sender As Object, e As System.EventArgs) Handles btnVerLog.Click



        Dim dr As DataRow
        'Metodo con datatable
        Dim dt = TraerMetadata(HFSC.Value, m_Id)
        'If m_Id < 1 Then
        '    dr = dt.NewRow

        '    dddd()
        'Else
        '    dr = dt.Rows(0)
        'End If



        Dim s = "select Detalle + AuxString1 + AuxString2 + AuxString3 + AuxString4 + AuxString5 " & _
                " from log  where   tipo='ALTAI'  AND  idcomprobante =" & m_Id & _
                " ORDER BY FechaRegistro ASC"



        Debug.Print(s)
        Dim dt2 = EntidadManager.ExecDinamico(HFSC.Value, s)

        Dim ss As String
        For Each r In dt2.Rows
            'Dim texto As String = r.Item(0) & " " & r.Item(1) & " " & r.Item(2) & " " & r.Item(3) & " " & r.Item(4) & " " & r.Item(5) & " " & r.Item(6) & " " & r.Item(7) & "\n\n <br/>"
            Dim texto As String = r.Item(0) & " <br/> " ' & " " & r.Item(6)
            'Dim idcarta = TextoEntre(texto, "CartaPorte", "CDP")
            'listaCartas.Add(Val(idcarta))
            's &= "<a href=""CartaDePorte.aspx?Id=" & idcarta & """ target=""_blank"">" & texto & "</a> <br/>"
            ss &= texto
        Next

        'como el item es inválido, no oculto el popup
        ModalPopupExtender3.Show()
        'MsgBoxAjax(Me, ss)
        log.Text = ss
    End Sub


End Class


