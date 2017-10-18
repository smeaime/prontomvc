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


        If Membership.GetUser().UserName = "Mariano" Then
            lala.Visible = True
        Else
            lala.Visible = False
        End If


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




            BloqueosDeEdicion()

            'http://localhost:48391/ProntoWeb/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?sincro=YPF&Destinatario=Y.P.F. S.A&desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos
            'sincro=YPF&Destinatario=Y.P.F. S.A&desde=14/1/2013&hasta=15/1/2013&idarticulo=SOJA&modo=ambos

            cmbSincronismo.Text = If(Request.QueryString.Get("sincro"), "")
            cmbInforme.Text = If(Request.QueryString.Get("informe"), "")
            txt_AC_Articulo.Text = If(Request.QueryString.Get("articulo"), "")
            txtFechaDesde.Text = If(Request.QueryString.Get("desde"), "")
            txtFechaHasta.Text = If(Request.QueryString.Get("hasta"), "")
            DropDownList2.Text = If(Request.QueryString.Get("modo"), "")
            txtDestinatario.Text = If(Request.QueryString.Get("Destinatario"), "")

            'If If(Request.Params("__EVENTTARGET"), "").ToString() <> "ctl00$ContentPlaceHolder1$cmbPeriodo" Then
            If Request.QueryString.Get("sincro") IsNot Nothing Then btnDescargaSincro_Click(sender, e)
            If Request.QueryString.Get("informe") IsNot Nothing Then btnRefrescar_Click(sender, e)
            'End If

            refrescaPeriodo()



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



    'Protected Sub ElegirCombosSegunParametro(sSincronismo As String)

    '    ReportViewer2.Visible = False
    '    cmbEstado.Text = "Descargas"
    '    txtTitular.Text = ""
    '    txtCorredor.Text = ""
    '    txtDestinatario.Text = ""

    '    Select Case sSincronismo.ToUpper
    '        Case "LIMPIAR"
    '            txtTitular.Text = ""
    '            txtCorredor.Text = ""
    '            txtDestinatario.Text = ""
    '            txtRcomercial.Text = ""
    '            txtPopClienteAuxiliar.Text = ""
    '        Case "A.C.A."
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "A.C.A. LTDA"
    '        Case "AIBAL"
    '            txtTitular.Text = "AIBAL SERVICIOS AGROPECUARIOS  S.A."
    '            txtIntermediario.Text = "AIBAL SERVICIOS AGROPECUARIOS  S.A."
    '            txtRcomercial.Text = "AIBAL SERVICIOS AGROPECUARIOS  S.A."
    '            txtPopClienteAuxiliar.Text = "AIBAL SERVICIOS AGROPECUARIOS  S.A."

    '        Case "ALABERN", "ALABERN (CALIDADES)"
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "ALABERN, FABREGA & CIA S.A."
    '        Case "ALEA"
    '            txtTitular.Text = "ALEA Y CIA. SA"
    '        Case "ARGENCER"
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "ARGENCER SA"

    '        Case "ANDREOLI"
    '            txtTitular.Text = "ANDREOLI S.A."
    '            txtIntermediario.Text = "ANDREOLI S.A."
    '            txtRcomercial.Text = "ANDREOLI S.A."
    '            txtPopClienteAuxiliar.Text = "ANDREOLI S.A."
    '        Case "ANDREOLI EXPORTACION"
    '            txtDestinatario.Text = "ANDREOLI S.A."
    '            DropDownList2.Text = "Export"
    '        Case "AMAGGI (CALIDADES) [BIT]", "AMAGGI (DESCARGAS) [BIT]"
    '            txtCorredor.Text = ""
    '            txtDestinatario.Text = "AMAGGI ARGENTINA S.A."


    '        Case "BTG PACTUAL [BIT]"

    '            txtIntermediario.Text = "BTG PACTUAL COMMODITIES S.A."
    '            txtRcomercial.Text = "BTG PACTUAL COMMODITIES S.A."
    '            txtDestinatario.Text = "BTG PACTUAL COMMODITIES S.A."


    '        Case "BLD", "BLD 2", "BLD (CALIDADES)"
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "BLD S.A"
    '            'txtPopClienteAuxiliar.Text = "BLD S.A"
    '        Case "BLD (POSICIÓN DEMORADOS)"
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "BLD S.A"
    '            txtDestinatario.Text = ""
    '            cmbEstado.Text = "Posición"

    '        Case "BUNGE"
    '            'BUNGE: INTERMEDIARIO / RTTE COMERCIAL / DESTINATARIO 
    '            'txtTitular.Text = "BUNGE ARGENTINA S.A."

    '            txtIntermediario.Text = "BUNGE ARGENTINA S.A."
    '            txtRcomercial.Text = "BUNGE ARGENTINA S.A."
    '            txtDestinatario.Text = "BUNGE ARGENTINA S.A."


    '        Case "DIAZ RIGANTI"
    '            '               DIAZ(RIGANTI) : CORREDOR()
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "DIAZ RIGANTI CEREALES S.R.L."

    '        Case "DOW", "DOW FORMATO ANTERIOR"
    '            'DOW:            RTTE(COMERCIAL / DESTINATARIO)


    '            txtRcomercial.Text = "DOW AGROSCIENCES ARG. SA"
    '            txtDestinatario.Text = "DOW AGROSCIENCES ARG. SA"

    '        Case "DUKAREVICH"
    '            'DUKAREVICH:     CORREDOR()
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "DUKAREVICH S.A"

    '        Case "EL ENLACE"
    '            txtTitular.Text = "EL ENLACE S.A."

    '        Case "LARTIRIGOYEN"
    '            'LARTIRIGOYEN: TITULAR / INTERMEDIARIO / RTTE COMERCIAL / CLIENTE OBSERVACIONES 
    '            txtTitular.Text = "LARTIRIGOYEN S.A."
    '            txtIntermediario.Text = "LARTIRIGOYEN S.A."
    '            txtRcomercial.Text = "LARTIRIGOYEN S.A."
    '            txtPopClienteAuxiliar.Text = "LARTIRIGOYEN S.A."

    '        Case "FYO"
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "FUTUROS Y OPCIONES .COM"

    '        Case "FYO (POSICIÓN)"
    '            'FYO:            CORREDOR()
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "FUTUROS Y OPCIONES .COM"
    '            cmbEstado.Text = "Posición"

    '        Case "GRANOS DEL LITORAL"
    '            'GRANOS DEL LITORAL: CORREDOR
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "GRANOS DEL LITORAL S.A."

    '        Case "GRANOS DEL PARANA"
    '            'GRANOS DEL PARANA : CORREDOR
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "GRANOS DEL PARANA S.A."

    '        Case "NOBLE", "NOBLE (ANEXO CALIDADES)"
    '            'NOBLE ARG: INTERMEDIARIO / RTTE COMERCIAL / DESTINATARIO
    '            txtDestinatario.Text = "NOBLE ARGENTINA S.A."
    '            txtIntermediario.Text = "NOBLE ARGENTINA S.A."
    '            txtRcomercial.Text = "NOBLE ARGENTINA S.A."


    '        Case "GRIMALDI GRASSI"
    '            'GRIMALDI(GRASSI) : CORREDOR()
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "GRIMALDI GRASSI S.A."

    '        Case "LA BRAGADENSE"
    '            'LA BRAGADENSE: TITULAR / INTERMEDIARIO / RTTE COMERCIAL 
    '            txtTitular.Text = "LA BRAGADENSE S.A"

    '            txtTitular.Text = "LA BRAGADENSE S.A"
    '            txtIntermediario.Text = "LA BRAGADENSE S.A"
    '            txtRcomercial.Text = "LA BRAGADENSE S.A"


    '        Case "LOS GROBO [ALGORITMO]"
    '            txtTitular.Text = "LOS GROBO  AGROPECUARIA S.A."
    '            txtCorredor.Text = ""
    '        Case "SYNGENTA"
    '            'SYNGENTA : TITULAR / INTERMEDIARIO / RTTE COMERCIAL / CLIENTE OBSERVACIONES
    '            txtRcomercial.Text = "SYNGENTA AGRO S.A."
    '            'txtIntermediario.Text = "SYNGENTA AGRO S.A."
    '            txtCorredor.Text = ""

    '            txtTitular.Text = "SYNGENTA AGRO S.A."
    '            txtIntermediario.Text = "SYNGENTA AGRO S.A."
    '            txtRcomercial.Text = "SYNGENTA AGRO S.A."
    '            txtPopClienteAuxiliar.Text = "" '"SYNGENTA AGRO S.A."

    '        Case "SYNGENTA FACTURACIÓN"
    '            'SYNGENTA : TITULAR / INTERMEDIARIO / RTTE COMERCIAL / CLIENTE OBSERVACIONES
    '            txtRcomercial.Text = "SYNGENTA AGRO S.A."
    '            'txtIntermediario.Text = "SYNGENTA AGRO S.A."
    '            txtCorredor.Text = ""

    '            txtTitular.Text = "SYNGENTA AGRO S.A."
    '            txtIntermediario.Text = "SYNGENTA AGRO S.A."
    '            txtRcomercial.Text = "SYNGENTA AGRO S.A."
    '            txtPopClienteAuxiliar.Text = "" '"SYNGENTA AGRO S.A."

    '            cmbEstado.Text = "Facturadas"

    '        Case "PSA LA CALIFORNIA", "PSA LA CALIFORNIA (CALIDADES)"
    '            'PSA LA CALIFORNIA: CORREDOR
    '            txtCorredor.Text = "PSA LA CALIFORNIA SA"

    '        Case "RIVARA"
    '            ' RIVARA : TITULAR / INTERMEDIARIO / RTTE COMERCIAL / CLIENTE OBSERVACIONES
    '            txtTitular.Text = "RIVARA S.A"
    '            txtRcomercial.Text = "RIVARA S.A"


    '            txtTitular.Text = "RIVARA S.A"
    '            txtIntermediario.Text = "RIVARA S.A"
    '            txtRcomercial.Text = "RIVARA S.A"
    '            txtPopClienteAuxiliar.Text = "RIVARA S.A"


    '        Case "MIGUEL CINQUE"
    '            txtTitular.Text = "CINQUE MIGUEL MARTIN"
    '        Case "SANTA CATALINA"
    '            txtTitular.Text = "SANTA CATALINA SA"


    '        Case "TOMAS HNOS"
    '            txtTitular.Text = "TOMAS HNOS Y CIA. S.A."
    '            txtIntermediario.Text = "TOMAS HNOS Y CIA. S.A."
    '            txtRcomercial.Text = "TOMAS HNOS Y CIA. S.A."
    '            txtPopClienteAuxiliar.Text = "TOMAS HNOS Y CIA. S.A."

    '        Case "TOMAS HNOS EXPORTACION"
    '            txtDestinatario.Text = "TOMAS HNOS Y CIA. S.A."
    '            DropDownList2.Text = "Export"

    '        Case "TECNOCAMPO"
    '            ' TECNOCAMPO: TITULAR / INTERMEDIARIO / RTTE COMERCIAL / CLIENTE OBSERVACIONES
    '            txtTitular.Text = "TECNOCAMPO SA"
    '            txtCorredor.Text = ""

    '            txtTitular.Text = "TECNOCAMPO SA"
    '            txtIntermediario.Text = "TECNOCAMPO SA"
    '            txtRcomercial.Text = "TECNOCAMPO SA"
    '            txtPopClienteAuxiliar.Text = "TECNOCAMPO SA"

    '        Case "ZENI"
    '            'ZENI:           CORREDOR()
    '            txtTitular.Text = ""
    '            txtCorredor.Text = "ZENI ENRIQUE y CIA SACIAF e I"


    '        Case "YPF"
    '            'txtIntermediario.Text = "Y.P.F. S.A"
    '            'txtRcomercial.Text = "Y.P.F. S.A"
    '            'txtDestinatario.Text = "Y.P.F. S.A"

    '        Case "OJEDA"
    '            txtCorredor.Text = "OJEDA ARIEL RUBEN"


    '        Case "LELFUN"
    '            '                ENTREGAS: titular, Intermediario, Rte comercial y cliente Obs.
    '            'EXPORTACION:    Destinatario()
    '            txtCorredor.Text = ""
    '            txtTitular.Text = "LELFUN S.A."
    '            txtIntermediario.Text = "LELFUN S.A."
    '            txtRcomercial.Text = "LELFUN S.A."
    '            txtPopClienteAuxiliar.Text = "LELFUN S.A."

    '        Case "ROAGRO"


    '        Case "AGROSUR"
    '            '                ENTREGAS: titular, Intermediario, Rte comercial y cliente Obs.
    '            'EXPORTACION:    Destinatario()
    '            txtCorredor.Text = ""
    '            txtTitular.Text = "AGROSUR S.A"
    '            txtIntermediario.Text = "AGROSUR S.A"
    '            txtRcomercial.Text = "AGROSUR S.A"
    '            txtPopClienteAuxiliar.Text = "AGROSUR S.A"

    '        Case "ARECO"
    '            txtCorredor.Text = "ARECO SEMILLAS SA"

    '        Case "PETROAGRO"
    '            txtCorredor.Text = "PETROAGRO SA"

    '        Case Else
    '            Throw New Exception(sSincronismo.ToUpper + " No existe ese sincro")

    '    End Select

    'End Sub


    Protected Sub cmbSincronismo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbSincronismo.TextChanged

        If cmbSincronismo.Text = "--- elija un Sincronismo ----" Then Exit Sub

        Try

            SincronismosWilliamsManager.ElegirCombosSegunParametro(cmbSincronismo.Text.ToUpper, txtTitular, txtCorredor, txtIntermediario, txtDestinatario, txtRcomercial, txtPopClienteAuxiliar, cmbEstado, cmbCriterioWHERE, DropDownList2, HFSC.Value)
        Catch ex As Exception

            MandarMailDeError(ex)
        End Try

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

        Try


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
                'cmbInforme.Items.FindByText("Ranking de Cereales").Enabled = False
                'cmbInforme.Items.FindByText("Ranking de Clientes").Enabled = False
                'cmbInforme.Items.FindByText("Proyección de facturación").Enabled = False

                'cmbInforme.Items.FindByText("Totales generales por mes").Enabled = False
                cmbInforme.Items.FindByText("Cartas Duplicadas").Enabled = False
                'cmbInforme.Items.FindByText("Resumen de facturación").Enabled = False

                'cmbInforme.Items.FindByText("Estadísticas de Toneladas descargadas (Modo-Sucursal)").Enabled = False
                'cmbInforme.Items.FindByText("Estadísticas de Toneladas descargadas (Sucursal-Modo)").Enabled = False
                'cmbInforme.Items.FindByText("Volumen de Carga").Enabled = False
                'cmbInforme.Items.FindByText("Diferencias por Destino por Mes").Enabled = False

                'cmbInforme.Items.FindByText("Totales generales por mes").Enabled = False
                'cmbInforme.Items.FindByText("Totales generales por mes por sucursal").Enabled = False
                'cmbInforme.Items.FindByText("Totales generales por mes por modo y sucursal").Enabled = False
                'cmbInforme.Items.FindByText("Totales generales por mes por modo").Enabled = False
            End If




            Dim l = New String() {"Mariano", "Andres", "hwilliams", "factbsas", "factas", "factbb", "factbsas", "factsl", "cflores", "lcesar", "dberzoni", "mgarcia"}
            If Not l.Contains(Session(SESSIONPRONTO_UserName)) Then
                cmbInforme.Items.FindByText("Liquidación de Subcontratistas").Enabled = False
                ' cmbInforme.Items(13).Enabled = False 'liquidacion de subcontratistas
            End If


            Dim ff = New String() {"mgarcia", "mgarcia2"}
            If ff.Contains(Session(SESSIONPRONTO_UserName)) Then
                'cmbInforme.Items.FindByText("Totales generales por mes").Enabled = False
                'cmbInforme.Items.FindByText("Totales generales por mes por sucursal").Enabled = False
                'cmbInforme.Items.FindByText("Totales generales por mes por modo y sucursal").Enabled = False
                'cmbInforme.Items.FindByText("Totales generales por mes por modo").Enabled = False
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

        Catch ex As Exception
            MandarMailDeError("Error en BloqueosDeEdicion: " + ex.ToString)
        End Try




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




        If cmbSincronismo.Text = "" Or InStr(cmbSincronismo.Text, "elija") > 0 Then
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
        Dim sErrores As String


        'esto ya me crea un timeout:
        'DOW 26/03/2014 26/03/2014 -1 -1 -1 -1 -1 -1 -1 38 (san jeronimo)
        'es al tomar los datos? o al procesarlos?
        'ver desde el profiler
        'hizo explotar por timeout al superbuscador, al alta de carta, al importador, a los autocomplete, etc.!!!!!
        '-en DOW, yo por default pongo el idVendedor. Pero ahí lo sacan.



        Dim sDescSincro = "Generando sincro para " & cmbSincronismo.Text & " " & _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & " " & _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & " " & _
                                idVendedor & " " & idCorredor & " " & idDestinatario & " " & idIntermediario & " " & _
                                idRComercial & " " & idArticulo & " " & idProcedencia & " " & idDestino & " " & Membership.GetUser.UserName


        ErrHandler2.WriteError(sDescSincro)

        '// Customize the connection string.
        Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value)) ' Properties.Settings.Default.DistXsltDbConnectionString)
        'builder.DataSource = builder.DataSource.Replace(".", Environment.MachineName)
        Dim desiredConnectionString = builder.ConnectionString



        Using ds As New WillyInformesDataSet


            If cmbSincronismo.Text.ToUpper <> "YPF" And cmbSincronismo.Text.ToUpper <> "SYNGENTA FACTURACIÓN" _
                And cmbSincronismo.Text.ToUpper <> "PELAYO" _
                And cmbSincronismo.Text.ToUpper <> "ESTANAR" _
                And InStr(cmbSincronismo.Text.ToUpper, "DOW") = 0 _
                And (InStr(cmbSincronismo.Text.ToUpper, "BLD") = 0 Or cmbSincronismo.Text.ToUpper = "BLD (CALIDADES)") Then


                '// Set it directly on the adapter.

                'esta seria la cuestion, aca llega con 30 segs nada mas de timeout, diferente del timeout de la conexion
                Try
                    'http://blogs.msdn.com/b/smartclientdata/archive/2005/08/16/increasetableadapterquerytimeout.aspx

                    Using adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter
                        adapter.SetCommandTimeOut(150)

                        adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
                        'adapter.Connection..Adapter.SelectCommand.CommandTimeout = 60

                        'sí. otra vez saltó en el fill
                        Dim maxx = 5000  'CartaDePorteManager._CONST_MAXROWS
                        'el TOP usando RowCount no sirve.... 
                        adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, _
                                     Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                     Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                    idVendedor, idCorredor, idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, maxx, enumCDPestado.DescargasMasFacturadas)





                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        'esta tardando una banda. aunque la consulta se genere rapido, es como que el fill tarda un monton



                        'Why would a stored procedure that returns a table with 9 columns, 89 rows using this code 
                        'take 60 seconds to execute (.NET 1.1) when it takes < 1 second to run in SQL Server Management Studio? 
                        'It's being run on the local machine so little/no network latency, fast dev machine
                        'http://stackoverflow.com/questions/250713/sqldataadapter-fill-method-slow
                        'http://stackoverflow.com/questions/834124/ado-net-calling-t-sql-stored-procedure-causes-a-sqltimeoutexception?lq=1
                        'http://sqlperformance.com/2013/08/t-sql-queries/parameter-sniffing-embedding-and-the-recompile-options

                        'Warning This answer is only an extremely short term fix and completely unnecessarily brutal. 
                        'DBCC DROPCLEANBUFFERS will drop most of the data pages from cache and have no effect. 
                        'DBCC FREEPROCCACHE will flush the entire procedure cache all just to remove one problematic plan! 
                        'There is no guarantee that the problem won't reoccur at some future stage. 
                        'The issue is parameter sniffing.
                        ' Please see this article for fuller explanation

                        'terminé agregando "OPTION (RECOMPILE)" en el store wCartasDePorte_TX_InformesCorregido. Ver qué tal anda


                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



                        '                        __________________________()

                        '                        Log Entry
                        '12/29/2014 02:34:15
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error Message:Generando sincro para BLD 27/12/2014 28/12/2014 -1 43 -1 -1 -1 -1 -1 -1 vfaccioli
                        '                        __________________________()

                        '                        Log Entry
                        '12/29/2014 02:35:55
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=2. Error Message:System.Data.SqlClient.SqlException: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
                        '   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
                        '   at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
                        '   at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
                        '                        at System.Data.SqlClient.SqlDataReader.ConsumeMetaData()
                        '                        at System.Data.SqlClient.SqlDataReader.get_MetaData()
                        '   at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
                        '   at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
                        '   at System.Data.SqlClient.SqlCommand.ExecuteReader(CommandBehavior behavior, String method)
                        '   at System.Data.SqlClient.SqlCommand.ExecuteDbDataReader(CommandBehavior behavior)
                        '   at System.Data.Common.DbCommand.System.Data.IDbCommand.ExecuteReader(CommandBehavior behavior)
                        '   at System.Data.Common.DbDataAdapter.FillInternal(DataSet dataset, DataTable[] datatables, Int32 startRecord, Int32 maxRecords, String srcTable, IDbCommand command, CommandBehavior behavior)
                        '   at System.Data.Common.DbDataAdapter.Fill(DataTable[] dataTables, Int32 startRecord, Int32 maxRecords, IDbCommand command, CommandBehavior behavior)
                        '   at System.Data.Common.DbDataAdapter.Fill(DataTable dataTable)
                        '   at WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter.Fill(wCartasDePorte_TX_InformesCorregidoDataTable dataTable, Nullable`1 IdCartaDePorte, Nullable`1 FechaDesde, Nullable`1 FechaHasta, Nullable`1 idVendedor, Nullable`1 idCorredor, Nullable`1 idDestinatario, Nullable`1 idIntermediario, Nullable`1 idRComercial, Nullable`1 idArticulo, Nullable`1 idProcedencia, Nullable`1 idDestino, Nullable`1 top, Nullable`1 Estado)
                        '   at CartaDePorteInformesConReportViewerSincronismos.btnDescargaSincro_Click(Object sender, EventArgs e) - al generar sincro para BLD 27/12/2014 28/12/2014 -1 43 -1 -1 -1 -1 -1 -1
                        '                        __________________________()




                    End Using

                Catch ex As OutOfMemoryException
                    '       puede ser timeout. en este y en el caso del outofmemory, logear los parametros

                    ErrHandler2.WriteError("TIMEOUT! al generar sincro para " & cmbSincronismo.Text & " " & _
                                             Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & " " & _
                                             Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & " " & _
                                            idVendedor & " " & idCorredor & " " & idDestinatario & " " & idIntermediario & " " & _
                                            idRComercial & " " & idArticulo & " " & idProcedencia & " " & idDestino)
                    ErrHandler2.WriteAndRaiseError(ex)
                    MandarMailDeError(ex)

                Catch ex As System.Data.SqlClient.SqlException
                    '        puede ser timeout. en este y en el caso del outofmemory, logear los parametros
                    ErrHandler2.WriteError(ex.ToString & " - al generar sincro para " & cmbSincronismo.Text & " " & _
                                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & " " & _
                                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & " " & _
                                  idVendedor & " " & idCorredor & " " & idDestinatario & " " & idIntermediario & " " & _
                                  idRComercial & " " & idArticulo & " " & idProcedencia & " " & idDestino)
                    ErrHandler2.WriteAndRaiseError(ex)
                    MandarMailDeError(ex)

                Catch ex As Exception
                    '        puede ser timeout. en este y en el caso del outofmemory, logear los parametros
                    ErrHandler2.WriteError(ex.ToString & " - al generar sincro para " & cmbSincronismo.Text & " " & _
                                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & " " & _
                                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & " " & _
                                  idVendedor & " " & idCorredor & " " & idDestinatario & " " & idIntermediario & " " & _
                                  idRComercial & " " & idArticulo & " " & idProcedencia & " " & idDestino)
                    ErrHandler2.WriteAndRaiseError(ex)
                    '    'Dim conn = New SqlConnection(builder.ConnectionString)
                    '    'conn.Open()

                    '    'Dim sampleCMD As SqlCommand = New SqlCommand("wCartasDePorte_TX_InformesCorregido", conn)
                    '    'sampleCMD.CommandType = CommandType.StoredProcedure
                    '    'sampleCMD.CommandTimeout = 60

                    '    'Dim da = New SqlDataAdapter(sampleCMD)
                    '    'da.Fill(ds.wCartasDePorte_TX_InformesCorregido)

                    MandarMailDeError(ex)

                End Try


            End If

            Dim estadofiltro As enumCDPestado
            Select Case cmbEstado.Text  '
                Case "TodasMenosLasRechazadas"
                    estadofiltro = enumCDPestado.TodasMenosLasRechazadas
                Case "Incompletas"
                    estadofiltro = enumCDPestado.Incompletas
                Case "Posición"
                    estadofiltro = enumCDPestado.Posicion
                Case "Descargas"
                    estadofiltro = enumCDPestado.DescargasMasFacturadas
                Case "Facturadas"
                    estadofiltro = enumCDPestado.Facturadas
                Case "NoFacturadas"
                    estadofiltro = enumCDPestado.NoFacturadas
                Case "Rechazadas"
                    estadofiltro = enumCDPestado.Rechazadas
                Case "EnNotaCredito"
                    estadofiltro = enumCDPestado.FacturadaPeroEnNotaCredito
                Case Else
                    Return
            End Select

            Dim sWHERE As String

            Try


                sWHERE = CartaDePorteManager.generarWHEREparaDatasetParametrizadoConFechaEnNumerales2(HFSC.Value, _
                                            sTitulo, _
                                            enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                            IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                            DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , txtContrato.Text, , idClienteAuxiliar, Val(txtVagon.Text), txtPatente.Text, optCamionVagon.SelectedValue)




                sWHERE = sWHERE.Replace("CDP.", "")


                For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In ds.wCartasDePorte_TX_InformesCorregido
                    With cdp
                        'If .IsHumedadNull Then .Humedad = 0
                        'If .IsHumedadDesnormalizadaNull Then .HumedadDesnormalizada = 0
                        'If .IsNReciboNull Then .NRecibo = 0

                        If .IsObservacionesNull Then .Observaciones = ""
                        .Observaciones = .Observaciones.Replace(vbLf, "").Replace(vbCr, "")
                    End With
                Next

                FiltrarCopias(ds.wCartasDePorte_TX_InformesCorregido) 'ds.wCartasDePorte_TX_InformesCorregido)


            Catch ex As Exception
                ErrHandler2.WriteError(ex)


            End Try



            Dim registrosFiltrados As Integer

            Try

                Select Case cmbSincronismo.Text.ToUpper

                    Case "ESTANAR"

                        output = SincronismosWilliamsManager.GenerarSincro("ESTANAR", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""



                    Case "PELAYO"

                        output = SincronismosWilliamsManager.GenerarSincro("PELAYO", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""





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


                            sWHERE = CartaDePorteManager.generarWHEREparaDatasetParametrizadoConFechaEnNumerales2(HFSC.Value, _
                                                        sTitulo, _
                                                        enumCDPestado.DescargasMasFacturadas, "A.C.A", idVendedor, idCorredor, _
                                                        idDestinatario, idIntermediario, _
                                                        idRComercial, idArticulo, idProcedencia, idDestino, _
                                                       IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , txtContrato.Text, , idClienteAuxiliar, Val(txtVagon.Text), txtPatente.Text, optCamionVagon.SelectedValue)

                            sWHERE = sWHERE.Replace("CDP.", "")


                            For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In ds.wCartasDePorte_TX_InformesCorregido
                                With cdp
                                    .Observaciones = .Observaciones.Replace(vbLf, "").Replace(vbCr, "")
                                End With
                            Next

                            FiltrarCopiasW(ds)


                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try


                        output = Sincronismo_ACA(HFSC.Value, ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count





                        lblErrores.Text = sErrores



                    Case "LOS GROBO", "LOS GROBO [ALGORITMO]"

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
                            ErrHandler2.WriteAndRaiseError("Error al filtrar destino")
                        End Try

                        FiltrarCopias(dt)
                        'dt = ProntoFuncionesGenerales.DataTableWHERE(dt, generarWHERE())
                        output = Sincronismo_LosGrobo(dt, sErrores, "", HFSC.Value)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = dt.Rows.Count

                    Case "LEIVA"
                        output = SincronismosWilliamsManager.GenerarSincro("LEIVA", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""



                    Case "GUALEGUAY"
                        output = SincronismosWilliamsManager.GenerarSincro("GUALEGUAY", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""


                    Case "AGROSUR"
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
                            ErrHandler2.WriteAndRaiseError("Error al filtrar destino")
                        End Try

                        FiltrarCopias(dt)
                        'dt = ProntoFuncionesGenerales.DataTableWHERE(dt, generarWHERE())
                        output = Sincronismo_Agrosur(dt, sErrores, "", HFSC.Value)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = dt.Rows.Count


                    Case "YPF 2"
                        'MsgBoxAjax(Me, "El sincro YPF todavía no está terminado. Disculpen las molestias")
                        'Return

                        '                        Log(Entry)
                        '04/29/2014 11:43:05
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. 
                        '    Error Message:Generando sincro para YPF 01/04/2014 28/04/2014 -1 -1 -1 -1 -1 -1 -1 -1 cflores
                        '                        __________________________()

                        '                        Log(Entry)
                        '04/29/2014 11:43:15
                        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesConReportViewerSincronismos.aspx?tipo=Confirmados. 
                        '                        Error Message
                        'Informe: Descargas, Descargas,  del 01/04/2014 al 28/04/2014           (Exporta: Entregas, Punto de venta: BahiaBlanca, Criterio: ALGUNOS)
                        '                        __________________________()

                        '                        Log(Entry)
                        '04/29/2014 11:43:47
                        'Error in: https://prontoweb.williamsentregas.com.ar/Reserved.ReportViewerWebControl.axd?Culture=1033&CultureOverrides=True&UICulture=1033&UICultureOverrides=True&ReportStack=1&ControlID=1ecf9e92fa3542bc92d53044deb1bd14&Mode=true&OpType=Export&FileName=Sincronismo+YPF&ContentDisposition=OnlyHtmlInline&Format=Excel. Error Message:Microsoft.ReportingServices.ReportProcessing.ReportProcessingException
                        'An unexpected error occurred in Report Processing.
                        '   at Microsoft.ReportingServices.ReportProcessing.ReportProcessing.RenderFromOdpSnapshot(IRenderingExtension newRenderer, String streamName, ProcessingContext pc, RenderingContext rc)
                        '   at Microsoft.ReportingServices.ReportProcessing.ReportProcessing.RenderSnapshot(IRenderingExtension newRenderer, RenderingContext rc, ProcessingContext pc)
                        '   at Microsoft.Reporting.LocalService.Render(CatalogItemContextBase itemContext, Boolean allowInternalRenderers, ParameterInfoCollection reportParameters, IEnumerable dataSources, DatasourceCredentialsCollection credentials, CreateAndRegisterStream createStreamCallback, ReportRuntimeSetup runtimeSetup)
                        '   at Microsoft.Reporting.WebForms.LocalReport.InternalRender(String format, Boolean allowInternalRenderers, String deviceInfo, PageCountMode pageCountMode, CreateAndRegisterStream createStreamCallback, Warning[]& warnings)
                        '                        Microsoft.ReportViewer.Common()
                        '                        __________________________()




                        Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                           "", "", "", 1, 0, _
                           estadofiltro, "", idVendedor, idCorredor, _
                           idDestinatario, idIntermediario, _
                           idRComercial, idArticulo, idProcedencia, idDestino, _
                                                             IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                           cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text, , idClienteAuxiliar, -1, Val(txtVagon.Text), txtPatente.Text, )




                        'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, strSQLsincronismo() & " WHERE " & s)


                        Dim s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" & FechaANSI(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)) & _
                                     "'     AND   '" & FechaANSI(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)) & "' )"





                        If False Then

                            ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                "ProntoWeb\Informes\Sincronismo YPF.rdl", _
                        dt, Nothing, , , sTitulo)

                        Else

                            '            ProntoFuncionesUIWeb.RebindReportViewerPasandoleConsultaDinamica(ReportViewer2, _
                            '"ProntoWeb\Informes\Sincronismo YPF.rdl", _
                            '        HFSC.Value, strSQLsincronismo() & " WHERE " & s, Nothing, , , sTitulo)

                            Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroYPF" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                            output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                        "ProntoWeb\Informes\Sincronismo YPF.rdl", _
                                               dt, ArchivoExcelDestino) 'sTitulo)

                            registrosFiltrados = dt.Rows.Count


                            CambiarElNombreDeLaPrimeraHojaDeYPF(output)

                        End If




                    Case "DOW"



                        Dim q As Generic.List(Of CartasConCalada) = CartasLINQlocalSimplificadoTipadoConCalada3(HFSC.Value, _
                           "", "", "", 1, 3000, _
                           estadofiltro, "", idVendedor, idCorredor, _
                           idDestinatario, idIntermediario, _
                           idRComercial, idArticulo, idProcedencia, idDestino, _
                           IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                           cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text).ToList



                        If False Then

                            Dim q4 = (From cdp In q _
                                     Select New With { _
                                            cdp.IdCartaDePorte, _
                                            cdp.NumeroCartaDePorte, _
                                            .NumeroSubfijo = cdp.NumeroSubfijo, _
                                            .SubnumeroVagon = cdp.SubnumeroVagon, _
                                            .FechaArribo = cdp.FechaArribo, _
                                            .FechaModificacion = cdp.FechaModificacion, _
                                            .FechaDescarga = cdp.FechaDescarga, _
                                            .Observaciones = cdp.Observaciones, _
 _
                                            .NobleExtranos = cdp.NobleExtranos, _
                                            .NobleNegros = cdp.NobleNegros, _
                                            .NobleQuebrados = cdp.NobleQuebrados, _
                                            .NobleDaniados = cdp.NobleDaniados, _
                                            .NobleChamico = cdp.NobleChamico, _
                                            .NobleChamico2 = cdp.NobleChamico2, _
                                            .NobleRevolcado = cdp.NobleRevolcado, _
                                            .NobleObjetables = cdp.NobleObjetables, _
                                            .NobleAmohosados = cdp.NobleObjetables, _
                                            .NobleHectolitrico = cdp.NobleObjetables, _
                                            .NobleCarbon = cdp.NobleObjetables, _
                                             .NoblePanzaBlanca = cdp.NoblePanzaBlanca, _
                                            .NoblePicados = cdp.NobleObjetables, _
                                            .NobleMGrasa = cdp.NobleObjetables, _
                                            .NobleAcidezGrasa = cdp.NobleObjetables, _
                                            .NobleVerdes = cdp.NobleObjetables, _
                                            .NobleGrado = cdp.NobleObjetables, _
                                            .NobleConforme = cdp.NobleObjetables, _
                                            .NobleACamara = cdp.NobleACamara, _
                                            .CalidadPuntaSombreada = cdp.CalidadPuntaSombreada, _
                                            .CalidadGranosQuemados = cdp.CalidadGranosQuemados, _
                                            .CalidadGranosQuemadosBonifRebaja = cdp.CalidadGranosQuemadosBonifRebaja, _
                                            .CalidadTierra = cdp.CalidadTierra, _
                                            .CalidadTierraBonifRebaja = cdp.CalidadPuntaSombreada, _
                                            .CalidadMermaChamico = cdp.CalidadMermaChamico, _
                                            .CalidadMermaChamicoBonifRebaja = cdp.CalidadMermaChamicoBonifRebaja, _
                                            .CalidadMermaZarandeo = cdp.CalidadMermaZarandeo, _
                                            .CalidadMermaZarandeoBonifRebaja = cdp.CalidadMermaZarandeoBonifRebaja, _
 _
                                            .TitularCUIT = cdp.TitularCUIT, _
                                            .TitularDesc = cdp.TitularDesc, _
                                            .IntermediarioDesc = cdp.IntermediarioDesc, _
                                            .IntermediarioCUIT = cdp.IntermediarioCUIT, _
                                            .RComercialDesc = cdp.RComercialDesc, _
                                            .RComercialCUIT = cdp.RComercialCUIT, _
                                            .DestinatarioDesc = cdp.DestinatarioDesc, _
                                            .DestinatarioCUIT = cdp.DestinatarioCUIT, _
                                            .CorredorDesc = cdp.CorredorDesc, _
                                            .CorredorCUIT = cdp.CorredorCUIT, _
                                            .DestinoDesc = cdp.DestinoDesc, _
                                            .ProcedenciaDesc = cdp.ProcedenciaDesc, _
                                            .Producto = cdp.Producto, _
 _
                                            .NetoProc = cdp.NetoProc, _
                                            .NetoFinal = cdp.NetoFinal, _
                                            .TaraFinal = cdp.TaraFinal, _
                                            .BrutoFinal = cdp.BrutoFinal, _
 _
                .ProcedenciaLocalidadONCCA = cdp.ProcedenciaLocalidadONCCA_SAGPYA, _
                .ProcedenciaPartidoONCCA = cdp.ProcedenciaPartidoONCCA, _
 _
                                            .Patente = cdp.Patente, _
                                            .Acoplado = cdp.Acoplado, _
                                            .DestinoCodigoYPF = cdp.DestinoCodigoYPF, _
 _
                                            .TransportistaCUIT = cdp.TransportistaCUIT, _
                                            .ChoferCUIT = cdp.ChoferCUIT, _
                                            .TransportistaDesc = cdp.TransportistaDesc, _
                                            .ChoferDesc = cdp.ChoferDesc, _
 _
                                            .EspecieONCCA = cdp.EspecieONCCA, _
                                            .Cosecha = cdp.Cosecha, _
                                            .Establecimiento = cdp.Establecimiento _
                                    }).ToList


                            Dim q5 = (From cdp In q _
                                     Select cdp).ToDataTable

                        End If
                        'Dim q9 = q.SelectMany(Function(x) x)




                        output = Sincronismo_DOW_ConLINQ(q, sErrores, "", HFSC.Value)


                        Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroDOW" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net



                        ' http://stackoverflow.com/questions/398871/update-all-objects-in-a-collection-using-linq
                        'tendría que agregar una propiedad más para pasarle por ahí 
                        'q.ForEach(Function(x) IIf(x.NobleACamara, x. = 1, x.NobleRevolcado = 2))


                        ' Dim q6 = q.Select(Function(x) DirectCast(x, InformeYPF)).ToList
                        ' q6.ForEach(Function(x) IIf(x.NobleACamara, x.Camara = "1", x.Camara = "2"))

                        'Dim q7 = (From cdp In q _
                        '             Select cdp, Camara = "2")

                        'Dim d = ProntoCSharp2.FuncionesUIWebCSharp2.ToDataSet()
                        '   Dim dt2 = ToDataTableNull(q3)

                        registrosFiltrados = q.Count

                        If registrosFiltrados > 0 Then
                            output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                        "ProntoWeb\Informes\Sincronismo DOW2.rdl", _
                                              q.ToDataTable, ArchivoExcelDestino) 'sTitulo)

                            CambiarElNombreDeLaPrimeraHojaDeDow(output)
                        End If



                    Case "YPF"


                        Dim limit = 3000
                        If System.Diagnostics.Debugger.IsAttached Then limit = 300

                        Dim q As Generic.List(Of CartasConCalada) = CartasLINQlocalSimplificadoTipadoConCalada3(HFSC.Value, _
                           "", "", "", 1, limit, _
                           estadofiltro, "", idVendedor, idCorredor, _
                           idDestinatario, idIntermediario, _
                           idRComercial, idArticulo, idProcedencia, idDestino, _
                                                             IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                           cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text).ToList


                        'Dim q2 = CartasLINQlocalSimplificadoQueryable(HFSC.Value, _
                        '   "", "", "", 1, 100, _
                        '   estadofiltro, "", idVendedor, idCorredor, _
                        '   idDestinatario, idIntermediario, _
                        '   idRComercial, idArticulo, idProcedencia, idDestino, _
                        '                                     IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                        '   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                        '   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                        '   cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text)





                        'Dim q3 = CartasLINQlocalSimplificadoTipado2(HFSC.Value, _
                        '   "", "", "", 1, 100, _
                        '   estadofiltro, "", idVendedor, idCorredor, _
                        '   idDestinatario, idIntermediario, _
                        '   idRComercial, idArticulo, idProcedencia, idDestino, _
                        '                                     IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                        '   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                        '   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                        '   cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text).ToList()

                        If False Then

                            Dim q4 = (From cdp In q _
                                     Select New With { _
                                            cdp.IdCartaDePorte, _
                                            cdp.NumeroCartaDePorte, _
                                            .NumeroSubfijo = cdp.NumeroSubfijo, _
                                            .SubnumeroVagon = cdp.SubnumeroVagon, _
                                            .FechaArribo = cdp.FechaArribo, _
                                            .FechaModificacion = cdp.FechaModificacion, _
                                            .FechaDescarga = cdp.FechaDescarga, _
                                            .Observaciones = cdp.Observaciones, _
 _
                                            .NobleExtranos = cdp.NobleExtranos, _
                                            .NobleNegros = cdp.NobleNegros, _
                                            .NobleQuebrados = cdp.NobleQuebrados, _
                                            .NobleDaniados = cdp.NobleDaniados, _
                                            .NobleChamico = cdp.NobleChamico, _
                                            .NobleChamico2 = cdp.NobleChamico2, _
                                            .NobleRevolcado = cdp.NobleRevolcado, _
                                            .NobleObjetables = cdp.NobleObjetables, _
                                            .NobleAmohosados = cdp.NobleObjetables, _
                                            .NobleHectolitrico = cdp.NobleObjetables, _
                                            .NobleCarbon = cdp.NobleObjetables, _
                                             .NoblePanzaBlanca = cdp.NoblePanzaBlanca, _
                                            .NoblePicados = cdp.NobleObjetables, _
                                            .NobleMGrasa = cdp.NobleObjetables, _
                                            .NobleAcidezGrasa = cdp.NobleObjetables, _
                                            .NobleVerdes = cdp.NobleObjetables, _
                                            .NobleGrado = cdp.NobleObjetables, _
                                            .NobleConforme = cdp.NobleObjetables, _
                                            .NobleACamara = cdp.NobleACamara, _
                                            .CalidadPuntaSombreada = cdp.CalidadPuntaSombreada, _
                                            .CalidadGranosQuemados = cdp.CalidadGranosQuemados, _
                                            .CalidadGranosQuemadosBonifRebaja = cdp.CalidadGranosQuemadosBonifRebaja, _
                                            .CalidadTierra = cdp.CalidadTierra, _
                                            .CalidadTierraBonifRebaja = cdp.CalidadPuntaSombreada, _
                                            .CalidadMermaChamico = cdp.CalidadMermaChamico, _
                                            .CalidadMermaChamicoBonifRebaja = cdp.CalidadMermaChamicoBonifRebaja, _
                                            .CalidadMermaZarandeo = cdp.CalidadMermaZarandeo, _
                                            .CalidadMermaZarandeoBonifRebaja = cdp.CalidadMermaZarandeoBonifRebaja, _
 _
                                            .TitularCUIT = cdp.TitularCUIT, _
                                            .TitularDesc = cdp.TitularDesc, _
                                            .IntermediarioDesc = cdp.IntermediarioDesc, _
                                            .IntermediarioCUIT = cdp.IntermediarioCUIT, _
                                            .RComercialDesc = cdp.RComercialDesc, _
                                            .RComercialCUIT = cdp.RComercialCUIT, _
                                            .DestinatarioDesc = cdp.DestinatarioDesc, _
                                            .DestinatarioCUIT = cdp.DestinatarioCUIT, _
                                            .CorredorDesc = cdp.CorredorDesc, _
                                            .CorredorCUIT = cdp.CorredorCUIT, _
                                            .DestinoDesc = cdp.DestinoDesc, _
                                            .ProcedenciaDesc = cdp.ProcedenciaDesc, _
                                            .Producto = cdp.Producto, _
 _
                                            .NetoProc = cdp.NetoProc, _
                                            .NetoFinal = cdp.NetoFinal, _
                                            .TaraFinal = cdp.TaraFinal, _
                                            .BrutoFinal = cdp.BrutoFinal, _
 _
                .ProcedenciaLocalidadONCCA = cdp.ProcedenciaLocalidadONCCA_SAGPYA, _
                .ProcedenciaPartidoONCCA = cdp.ProcedenciaPartidoONCCA, _
 _
                                            .Patente = cdp.Patente, _
                                            .Acoplado = cdp.Acoplado, _
                                            .DestinoCodigoYPF = cdp.DestinoCodigoYPF, _
 _
                                            .TransportistaCUIT = cdp.TransportistaCUIT, _
                                            .ChoferCUIT = cdp.ChoferCUIT, _
                                            .TransportistaDesc = cdp.TransportistaDesc, _
                                            .ChoferDesc = cdp.ChoferDesc, _
 _
                                            .EspecieONCCA = cdp.EspecieONCCA, _
                                            .Cosecha = cdp.Cosecha, _
                                            .Establecimiento = cdp.Establecimiento _
                                    }).ToList


                            Dim q5 = (From cdp In q _
                                     Select cdp).ToDataTable

                        End If
                        'Dim q9 = q.SelectMany(Function(x) x)





                        output = Sincronismo_YPF_ConLINQ(q, sErrores, "", HFSC.Value)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()



                        Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroYPF" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net



                        ' http://stackoverflow.com/questions/398871/update-all-objects-in-a-collection-using-linq
                        'tendría que agregar una propiedad más para pasarle por ahí 
                        'q.ForEach(Function(x) IIf(x.NobleACamara, x. = 1, x.NobleRevolcado = 2))


                        ' Dim q6 = q.Select(Function(x) DirectCast(x, InformeYPF)).ToList
                        ' q6.ForEach(Function(x) IIf(x.NobleACamara, x.Camara = "1", x.Camara = "2"))

                        'Dim q7 = (From cdp In q _
                        '             Select cdp, Camara = "2")

                        'Dim d = ProntoCSharp2.FuncionesUIWebCSharp2.ToDataSet()
                        '   Dim dt2 = ToDataTableNull(q3)

                        registrosFiltrados = q.Count

                        If registrosFiltrados > 0 Then 'And sErrores = "" Then
                            output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                        "ProntoWeb\Informes\Sincronismo YPF.rdl", _
                                              q.ToDataTable, ArchivoExcelDestino) 'sTitulo)

                            CambiarElNombreDeLaPrimeraHojaDeYPF(output)
                        End If






                    Case "OJEDA"

                        Dim q As Generic.List(Of CartasConCalada) = CartasLINQlocalSimplificadoTipadoConCalada3(HFSC.Value, _
                           "", "", "", 1, 3000, _
                           estadofiltro, "", idVendedor, idCorredor, _
                           idDestinatario, idIntermediario, _
                           idRComercial, idArticulo, idProcedencia, idDestino, _
                                                             IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                           Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                           cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text).ToList


                        output = Sincronismo_Ojeda(q, "", sWHERE, sErrores, HFSC.Value)

                    Case "ARGENCER"

                        output = Sincronismo_Argencer(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores, HFSC.Value)
                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "ROAGRO"
                        output = Sincronismo_Roagro(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "ZENI"

                        output = Sincronismo_ZENI(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)
                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        'If iisNull(sErrores, "") <> "" Then Exit Sub

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "ANDREOLI"



                        output = Sincronismo_AndreoliDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count





                    Case "BTG PACTUAL [BIT]"



                        output = Sincronismo_BTGDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count





                    Case "AMAGGI (DESCARGAS) [BIT]"


                        If False Then

                            Dim q As Generic.List(Of CartasConCalada) = CartasLINQlocalSimplificadoTipadoConCalada(HFSC.Value, _
                             "", "", "", 1, 3000, _
                             estadofiltro, "", idVendedor, idCorredor, _
                             idDestinatario, idIntermediario, _
                             idRComercial, idArticulo, idProcedencia, idDestino, _
                                                               IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                             Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                             Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text).ToList


                            output = Sincronismo_AmaggiDescargas_Nuevo(q, , sWHERE, sErrores)

                        Else
                            'como verificar que solo venga una sin copia? -una opcion en el 
                            '-no se puede filtrar el datatable?
                            'BorrarCartasRepetidas(ds.wCartasDePorte_TX_InformesCorregido) 'ahora BorrarCartasRepetidas esta dentro del sincro
                            ' http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14373
                            output = Sincronismo_AmaggiDescargas2(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores, HFSC.Value)

                        End If



                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "AMAGGI (CALIDADES) [BIT]"



                        output = Sincronismo_AmaggiCalidades(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, HFSC.Value)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "DOW FORMATO ANTERIOR"

                        'If ds.wCartasDePorte_TX_InformesCorregido.Rows.Count = 0 Then
                        '    MsgBoxAjax(Me, "No hay cartas que cumplan los filtros")
                        '    Return
                        'End If

                        'output = Sincronismo_DOW(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

                        sTitulo = ""
                        Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                         "", "", "", 1, 0, _
                                        enumCDPestado.Todas, "", idVendedor, idCorredor, _
                                        idDestinatario, idIntermediario, _
                                        idRComercial, idArticulo, idProcedencia, idDestino, "1", DropDownList2.Text, _
                                        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                        cmbPuntoVenta.SelectedValue, sTitulo, , , , , idClienteAuxiliar, , , , )


                        FiltrarCopias(dt)
                        'dt = DataTableWHERE(dt, sWHERE)

                        Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroDOW" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                        output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                    "ProntoWeb\Informes\Sincronismo DOW.rdl", _
                                            dt, ArchivoExcelDestino) 'sTitulo)



                        CambiarElNombreDeLaPrimeraHojaDeDow(output)

                        registrosFiltrados = dt.Rows.Count



                    Case "LA BIZNAGA"


                        output = SincronismosWilliamsManager.GenerarSincro("LA BIZNAGA", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""





                    Case "AJNARI"


                        output = SincronismosWilliamsManager.GenerarSincro("AJNARI", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""


                    Case "GRANAR"


                        output = SincronismosWilliamsManager.GenerarSincro("GRANAR", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                           iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                           iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""

                    Case "BERAZA"


                        output = SincronismosWilliamsManager.GenerarSincro("BERAZA", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                           iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                           iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""

                    Case "NIDERA"


                        output = SincronismosWilliamsManager.GenerarSincro("NIDERA", sErrores, _
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                           "", estadofiltro, "", idVendedor, idCorredor, _
                          idDestinatario, idIntermediario, _
                          idRComercial, idArticulo, idProcedencia, idDestino, _
                          IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                              CartaDePorteManager.FiltroANDOR.FiltroAND, _
                            CartaDePorteManager.FiltroANDOR.FiltroOR), _
                          DropDownList2.Text, _
                           iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                           iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)
                        'lblErrores.Text = sErrores
                        sErrores = ""



                    Case "BLD x"
                        'output = Sincronismo_BLD(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        Err.Raise(646546)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "BLD"

                        If True Then

                            output = SincronismosWilliamsManager.GenerarSincro("BLD", sErrores, _
                               HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                               "", estadofiltro, "", idVendedor, idCorredor, _
                              idDestinatario, idIntermediario, _
                              idRComercial, idArticulo, idProcedencia, idDestino, _
                              IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                                  CartaDePorteManager.FiltroANDOR.FiltroAND, _
                                CartaDePorteManager.FiltroANDOR.FiltroOR), _
                              DropDownList2.Text, _
                               iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                               iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                 cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)
                            'lblErrores.Text = sErrores
                            sErrores = ""



                        Else




                            ErrHandler2.WriteError("Generando sincro BLD")
                            Try


                                sTitulo = ""
                                Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                                "", "", "", 1, 0, _
                                                enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
                                                idDestinatario, idIntermediario, _
                                                idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                                    "1", DropDownList2.Text, _
                                                Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                                Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                                cmbPuntoVenta.SelectedValue, sTitulo, , , , , idClienteAuxiliar, , , , )



                                ErrHandler2.WriteError("filas bld sincro " & dt.Rows.Count)


                                FiltrarCopias(dt)

                                Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroBLD" & Now.ToString("ddMMMyyyy_HHmmss") & ".pronto" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                                ErrHandler2.WriteError(" generar en " & ArchivoExcelDestino & " Mirá que puede explotar silenciosamente " & _
                                " al llamar a ExcelToCSV_SincroBLD -Mejor dicho, suele explotar el viewer RebindReportViewerExcel2 " & _
                                " (el error del Office Automation pinta que no se puede capturar) por los permisos de NETWORK SERVICE " & _
                                " para usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores. " & _
                                "-Me parece que esto no funciona cuando despues del ReportViewer llamas al " & _
                                " Interop de Office, si los usas individualmente andan, pero juntos explotan")








                                If False Then
                                    output = "C:\Windows\TEMP\SincroBLD22jul2014_131456.pronto"
                                Else

                                    Try
                                        output = RebindReportViewerExcel2(HFSC.Value, _
                                                    "ProntoWeb\Informes\Sincronismo BLD.rdl", _
                                                           dt, ArchivoExcelDestino) 'sTitulo)
                                    Catch ex As Exception
                                        ErrHandler2.WriteError("No se pudo generar el informe de bld! ")
                                        MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.ToString & " " & " Filtro usado: " & sTitulo)
                                        Return

                                    End Try

                                End If

                                'System.Threading.Thread.Sleep(1000 * 5)
                                'File.Copy(ArchivoExcelDestino, ArchivoExcelDestino & ".copia")
                                'ArchivoExcelDestino = ArchivoExcelDestino & ".copia"



                                ErrHandler2.WriteError("Se generó el reporte en " & output)







                                'como hacer para que no agregue las columnas vacias?
                                If True Then





                                    Session("output") = output

                                    Response.Redirect("CartaDePorteInformesConReportViewerSincronismos.aspx?sincro=BLDCONVERTIR" & _
                                                      "&articulo=" & txt_AC_Articulo.Text & _
                                                        "&desde=" & txtFechaDesde.Text & _
                                                        "&hasta=" & txtFechaHasta.Text & _
                                                        "&modo=" & DropDownList2.Text & _
                                                        "&Destinatario=" & txtDestinatario.Text)
                                    Return
                                    SincronismosWilliamsManager.Sincronismo_BLD_ExcelToCSV_SincroBLD2(output, 55)
                                ElseIf False Then

                                    output = SincronismosWilliamsManager.Sincronismo_BLD_ExcelToCSV_SincroBLD2(output, 55)
                                Else
                                    Dim s = ExcelToCSV_SinAutomation(output)
                                    ErrHandler2.WriteError(s)
                                    'ExcelToCSV_SincroBLD_SalidaAString(output, 51)
                                    ' Dim html=ExcelToHtml (output)
                                    output = ""
                                End If




                            Catch ex As Exception
                                ErrHandler2.WriteError("Error en el sincro BLD" & ex.ToString)
                                ErrHandler2.WriteError(ex)
                            End Try
                            registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count

                        End If

                    Case "BLDCONVERTIR"
                        output = Session("output")
                        output = SincronismosWilliamsManager.Sincronismo_BLD_ExcelToCSV_SincroBLD2(output, 58)
                        registrosFiltrados = 100 ' ds.wCartasDePorte_TX_InformesCorregido.Count

                    Case "BLD (POSICIÓN DEMORADOS)"

                        sTitulo = ""

                        Dim dt As DataTable

                        Try
                            cmbEstado.Text = "Posición"
                            estadofiltro = enumCDPestado.Posicion


                            dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                            "", "", "", 1, 0, _
                                            estadofiltro, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, , , , )
                            FiltrarCopias(dt)
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                            ErrHandler2.WriteError(sTitulo)
                            MandarMailDeError(ex)
                            'ErrHandler2.WriteErrorYMandarMail(sTitulo)
                            MsgBoxAjax(Me, "Hubo un error al generar el informe. " & ex.ToString & " " & " Filtro usado: " & sTitulo)
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
                        ErrHandler2.WriteError("Generando sincro PSA La California")
                        Try


                            sTitulo = ""
                            Dim dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(HFSC.Value, _
                                            "", "", "", 1, 0, _
                                            enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
                                            idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                                                                "1", DropDownList2.Text, _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            cmbPuntoVenta.SelectedValue, sTitulo, , , , , idClienteAuxiliar, , , , )



                            ErrHandler2.WriteError("filas bld sincro " & dt.Rows.Count)


                            FiltrarCopias(dt)

                            Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroPSA" & Now.ToString("ddMMMyyyy_HHmmss") & ".pronto" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

                            ErrHandler2.WriteError(" generar en " & ArchivoExcelDestino & " Mirá que puede explotar por los permisos de NETWORK SERVICE para usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")



                            Try
                                output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
                                            "ProntoWeb\Informes\Sincronismo BLD.rdl", _
                                                   dt, ArchivoExcelDestino) 'sTitulo)
                            Catch ex As Exception
                                ErrHandler2.WriteError("No se pudo generar el informe de bld! ")

                            End Try








                            ErrHandler2.WriteError("Se generó el reporte en " & output)


                            'como hacer para que no agregue las columnas vacias?

                            output = SincronismosWilliamsManager.Sincronismo_BLD_ExcelToCSV_SincroBLD2(output, 46)

                        Catch ex As Exception
                            ErrHandler2.WriteError("Error en el sincro BLD" & ex.ToString)
                            ErrHandler2.WriteError(ex)
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



                        sForzarNombreDescarga = "DESCAR947.dat"

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


                            sWHERE = CartaDePorteManager.generarWHEREparaDatasetParametrizadoConFechaEnNumerales2(HFSC.Value, _
                                                        sTitulo, _
                                                         enumCDPestado.Posicion, "", idVendedor, idCorredor, _
                                                        idDestinatario, idIntermediario, _
                                                        idRComercial, idArticulo, idProcedencia, idDestino, _
                                                       IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                                        Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , txtContrato.Text, , idClienteAuxiliar, Val(txtVagon.Text), txtPatente.Text, optCamionVagon.SelectedValue)

                            sWHERE = sWHERE.Replace("CDP.", "")


                            'For Each cdp As WillyInformesDataSet.wCartasDePorte_TX_InformesCorregidoRow In ds.wCartasDePorte_TX_InformesCorregido
                            '    With cdp
                            '        .Observaciones = .Observaciones.Replace(vbLf, "").Replace(vbCr, "")
                            '    End With
                            'Next

                            'FiltrarCopias(ds)
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try

                        Try
                            'http://blogs.msdn.com/b/smartclientdata/archive/2005/08/16/increasetableadapterquerytimeout.aspx

                            Using adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter
                                adapter.SetCommandTimeOut(120) 'se queda corto con 60???

                                adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
                                'adapter.Connection..Adapter.SelectCommand.CommandTimeout = 60

                                adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, _
                                             Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                             Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                            idVendedor, idCorredor, idDestinatario, idIntermediario, _
                                            idRComercial, idArticulo, idProcedencia, idDestino, CartaDePorteManager._CONST_MAXROWS, enumCDPestado.Posicion)
                            End Using

                        Catch ex As OutOfMemoryException

                            ErrHandler2.WriteAndRaiseError(ex)
                            MandarMailDeError(ex)

                        Catch ex As Exception
                            ErrHandler2.WriteAndRaiseError(ex)
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
                        output = Sincronismo_TomasHnos2(dt, "", HFSC.Value)

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


                    Case "MORGAN (DESCARGAS) [BIT]"

                        'como verificar que solo venga una sin copia? -una opcion en el 
                        '-no se puede filtrar el datatable?
                        'BorrarCartasRepetidas(ds.wCartasDePorte_TX_InformesCorregido) 'ahora BorrarCartasRepetidas esta dentro del sincro
                        ' http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14373
                        output = Sincronismo_MorganDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "MORGAN (CALIDADES) [BIT]"

                        output = Sincronismo_MorganCalidades(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, HFSC.Value)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "GESAGRO"


                        output = SincronismosWilliamsManager.GenerarSincro("GESAGRO", sErrores, _
                                                   HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                                                   "", estadofiltro, "", idVendedor, idCorredor, _
                                                  idDestinatario, idIntermediario, _
                                                  idRComercial, idArticulo, idProcedencia, idDestino, _
                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                                                      CartaDePorteManager.FiltroANDOR.FiltroAND, _
                                                    CartaDePorteManager.FiltroANDOR.FiltroOR), _
                                                  DropDownList2.Text, _
                                                   iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                                                   iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                     cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)
                        'lblErrores.Text = sErrores
                        sErrores = ""



                    Case "MONSANTO"


                        output = SincronismosWilliamsManager.GenerarSincro("MONSANTO", sErrores, _
                                                   HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                                                   "", estadofiltro, "", idVendedor, idCorredor, _
                                                  idDestinatario, idIntermediario, _
                                                  idRComercial, idArticulo, idProcedencia, idDestino, _
                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                                                      CartaDePorteManager.FiltroANDOR.FiltroAND, _
                                                    CartaDePorteManager.FiltroANDOR.FiltroOR), _
                                                  DropDownList2.Text, _
                                                   iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                                                   iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                     cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)
                        'lblErrores.Text = sErrores
                        sErrores = ""


                    Case "DIAZ FORTI", "DIAZ FORTI [BIT]"


                        output = SincronismosWilliamsManager.GenerarSincro("DIAZ FORTI", sErrores, _
                                                   HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                                                   "", estadofiltro, "", idVendedor, idCorredor, _
                                                  idDestinatario, idIntermediario, _
                                                  idRComercial, idArticulo, idProcedencia, idDestino, _
                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                                                      CartaDePorteManager.FiltroANDOR.FiltroAND, _
                                                    CartaDePorteManager.FiltroANDOR.FiltroOR), _
                                                  DropDownList2.Text, _
                                                   iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                                                   iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                     cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)
                        'lblErrores.Text = sErrores
                        sErrores = ""

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
                        output = Sincronismo_NOBLE(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "NOBLE (ANEXO CALIDADES)"
                        output = Sincronismo_NOBLEarchivoadicional(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "CGG"
                        output = Sincronismo_CGG(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores, HFSC.Value)

                        lblErrores.Text = sErrores


                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "CGG (CALIDADES)"
                        output = Sincronismo_CGGcalidades(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "SYNGENTA"
                        output = Sincronismo_Syngenta(ds.wCartasDePorte_TX_InformesCorregido, sTitulo, sWHERE, sErrores, HFSC.Value)
                        sForzarNombreDescarga = "HPESA.TXT"
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "SYNGENTA FACTURACIÓN"
                        Dim q As Generic.List(Of CartasConCalada) = CartasLINQlocalSimplificadoTipadoConCalada3(HFSC.Value, _
                       "", "", "", 1, 3000, _
                       estadofiltro, "", idVendedor, idCorredor, _
                       idDestinatario, idIntermediario, _
                       idRComercial, idArticulo, idProcedencia, idDestino, _
                                                         IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                       Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                       Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                       cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text).ToList

                        Try

                            output = Sincronismo_SyngentaFacturacion_ConLINQ(q, sErrores, "", HFSC.Value)
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex.ToString)
                        End Try

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()



                        'Dim ArchivoExcelDestino = IO.Path.GetTempPath & "SincroYPF" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net




                        registrosFiltrados = q.Count


                        sForzarNombreDescarga = "ENTREGADOR.CSV"

                    Case "PETROAGRO"
                        output = SincronismosWilliamsManager.GenerarSincro("PETROAGRO", sErrores, _
                                                   HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"), _
                                                   "", estadofiltro, "", idVendedor, idCorredor, _
                                                  idDestinatario, idIntermediario, _
                                                  idRComercial, idArticulo, idProcedencia, idDestino, _
                                                  IIf(cmbCriterioWHERE.SelectedValue = "todos", _
                                                      CartaDePorteManager.FiltroANDOR.FiltroAND, _
                                                    CartaDePorteManager.FiltroANDOR.FiltroOR), _
                                                  DropDownList2.Text, _
                                                   iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#),
                                                   iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                     cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)
                        'lblErrores.Text = sErrores
                        sErrores = ""

                    Case "LELFUN"
                        output = Sincronismo_Lelfun(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)
                        'sForzarNombreDescarga = "HPESA.TXT"
                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
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

                        Dim aaa = dt.Rows.Count

                        'va a haber lio si llega al top


                        FiltrarCopias(dt)
                        dt = DataTableWHERE(dt, sWHERE)

                        ErrHandler2.WriteError("RIVARA " & dt.Rows.Count & " " & aaa & " " & ds.wCartasDePorte_TX_InformesCorregido.Count & "  " & sWHERE)


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
                        output = Sincronismo_LaBragadense(dt, sErrores, "", HFSC.Value)

                        lblErrores.Text = sErrores
                        UpdatePanel2.Update()
                        registrosFiltrados = dt.Rows.Count



                        'sForzarNombreDescarga = "HPESA.TXT"



                    Case Else


                        output = SincronismosWilliamsManager.GenerarSincro(cmbSincronismo.Text, sErrores,
                           HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"),
                           "", estadofiltro, "", idVendedor, idCorredor,
                          idDestinatario, idIntermediario,
                          idRComercial, idArticulo, idProcedencia, idDestino,
                          IIf(cmbCriterioWHERE.SelectedValue = "todos",
                              CartaDePorteManager.FiltroANDOR.FiltroAND,
                            CartaDePorteManager.FiltroANDOR.FiltroOR),
                          DropDownList2.Text,
                   Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)),
                   Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)),
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar, registrosFiltrados)

                        lblErrores.Text = sErrores
                        sErrores = ""




                        'ErrHandler2.WriteError("No se está eligiendo bien el sincro" & cmbSincronismo.Text)
                        'MsgBoxAjax(Me, "Elija un sincronismo")
                        'Return
                End Select




                If lblErrores.Text <> "" Then
                    'También, ver de diferenciar el mensaje que salta cuando ninguna carta de porte cumple con 
                    'los filtros de cuando el sincro no sale porque alguna de las cartas no cumple con los requisitos.
                    Dim registrosGenerados = 0
                    Try
                        If output <> "" Then
                            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
                            If MyFile1.Exists Then
                                registrosGenerados = File.ReadAllLines(output).Length
                            End If
                        End If
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
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
                ErrHandler2.WriteError(ex)
                MsgBoxAjax(Me, "Disculpame, no pude manejar la cantidad de datos. Por favor, intentá achicando los filtros. Ya mandé un mail al administrador con el error.")
                Return
            Catch ex As System.Threading.ThreadAbortException

            Catch ex As Exception
                MandarMailDeError(ex)
                ErrHandler2.WriteError(ex)
                Throw
            End Try

        End Using





        If output = "" Or (sErrores <> "" And Not chkOmitirErrores.Checked) Then
            ErrHandler2.WriteError("No se pudo generar nada " & cmbSincronismo.Text)
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
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try
    End Sub




    Public Function RebindReportViewerExcel2(ByVal SC As String, ByVal rdlFile As String, ByVal dt As DataTable, ByVal ArchivoExcelDestino As String) As String

        If ArchivoExcelDestino = "" Then
            ArchivoExcelDestino = IO.Path.GetTempPath & "Excel" & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
            'Dim vFileName As String = Path.GetTempPath & "SincroLosGrobo.txt" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net
        End If

        ''Dim vFileName As String = "c:\archivo.txt"
        '' FileOpen(1, ArchivoExcelDestino, OpenMode.Output)



        'ErrHandler2.WriteError("Este reportviewer EXPORTA a excel, pueden andar los mails y esto no. " & _
        '                      "-Eh? la otra función RebindReportViewer tambien exporta a EXCEL con un flag. Quizas lo hace con otro usuario... " & _
        '                      "-En fin. Puede llegar a explotar sin rastro. Fijate en los permisos de NETWORK SERVICE para " & _
        '                      "usar el com de EXCEL. Revisá el visor de eventos si no se loguean errores")

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

            End With

            .DocumentMapCollapsed = True

            '.LocalReport.Refresh()
            '.DataBind()

            'Exportar a EXCEL directo http://msdn.microsoft.com/en-us/library/ms251839(VS.80).aspx
            Dim warnings As Warning()
            Dim streamids As String()
            Dim mimeType, encoding, extension As String

            Dim format = "Excel"

            Dim bytes As Byte()

            Try
                bytes = ReportViewer2.LocalReport.Render( _
                           format, Nothing, mimeType, encoding, _
                             extension, _
                            streamids, warnings)



            Catch e As System.Exception
                Dim inner As Exception = e.InnerException
                While Not (inner Is Nothing)
                    If System.Diagnostics.Debugger.IsAttached() Then
                        'MsgBox(inner.Message)
                        'Stop
                    End If
                    ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                    inner = inner.InnerException
                End While
                Throw
            End Try



            Dim fs = New IO.FileStream(ArchivoExcelDestino, IO.FileMode.Create)
            fs.Write(bytes, 0, bytes.Length)
            fs.Close()





            'dimensiones. Letra condensada (supongo que el alto es el mismo y el ancho es la mitad de la normal)
            'Notas de Entrega: 160 ancho x 36 alt
            'Facturas y Adjuntos: 160 ancho x 78 alto

            'ArchivoExcelDestino = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextWilliamsAdjunto(ArchivoExcelDestino)

        End With

        'ReportViewer2.Dispose()

        Return ArchivoExcelDestino

    End Function



    Function ExcelToCSV_SinAutomation(ArchivoExcelDestino As String, Optional grid As GridView = Nothing) As String

        Dim ds As DataSet = New DataSet()

        Dim err As String
        Dim firstSheetName As String
        'Dim connString As String = ConfigurationManager.ConnectionStrings("xls").ConnectionString
        ' Create the connection object
        Dim oledbConn As System.Data.OleDb.OleDbConnection
        Try
            'Microsoft.Jet.OLEDB.4.0 to Microsoft.ACE.OLEDB.12.0
            'oledbConn = New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + ArchivoExcelDestino + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';")
            oledbConn = New System.Data.OleDb.OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + ArchivoExcelDestino + ";Extended Properties='Excel 8.0;HDR=Yes;IMEX=1';")
            ' Open connection
            oledbConn.Open()



            '                          // Get the name of the first worksheet:
            Dim dbSchema As DataTable = oledbConn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, Nothing)
            If (dbSchema Is Nothing Or dbSchema.Rows.Count < 1) Then

                Throw New Exception("Error: Could not determine the name of the first worksheet.")
            End If

            firstSheetName = dbSchema.Rows(0)("TABLE_NAME").ToString()


            ErrHandler2.WriteError("Nombre  " & firstSheetName)

            ' Create OleDbCommand object and select data from worksheet Sheet1
            Dim cmd As System.Data.OleDb.OleDbCommand = New System.Data.OleDb.OleDbCommand("SELECT * FROM  [" & firstSheetName & "]", oledbConn)

            ' Create new OleDbDataAdapter
            Dim oleda As System.Data.OleDb.OleDbDataAdapter = New System.Data.OleDb.OleDbDataAdapter()

            oleda.SelectCommand = cmd

            ' Create a DataSet which will hold the data extracted from the worksheet.

            ' Fill the DataSet from the data extracted from the worksheet.
            oleda.Fill(ds, "Employees")

            ' Bind the data to the GridView
            'GridView1.DataSource = ds.Tables(0).DefaultView
            'GridView1.DataBind()
        Catch e As Exception


            'http://stackoverflow.com/questions/96150/oledbconnection-open-generates-unspecified-error
            'http://stackoverflow.com/questions/472079/c-asp-net-oledb-ms-excel-read-unspecified-error
            'http://stackoverflow.com/questions/15828/reading-excel-files-from-c-sharp

            err = e.ToString
            ErrHandler2.WriteError(err)
            Throw
        Finally
            ' Close connection
            oledbConn.Close()
        End Try



        Dim s As String
        Try
            If ds.Tables.Count = 0 Then Return "NoSeConvirtieronTablas" & "_" & firstSheetName & "_" & ArchivoExcelDestino & "_" & err
            ErrHandler2.WriteError("Tablas  " & ds.Tables.Count.ToString())
            ErrHandler2.WriteError("Convertido " + ArchivoExcelDestino + " Lineas: " + ds.Tables(0).Rows.Count.ToString())
            '  s = DatatableToHtmlUsandoGridview(ds.Tables(0), grid)
            's = DatatableToHtml(ds.Tables(0))

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            Return "ErrorHtml" + ex.ToString + "          " + ArchivoExcelDestino + " Lineas: " + ds.Tables(0).Rows.Count.ToString()
        End Try


        Return s
    End Function




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





    Sub AsignaInformeAlReportViewer(Optional ByVal bDescargaExcel As Boolean = False)
        Dim output As String = ""


        ErrHandler2.WriteError("Generando informe para " & cmbInforme.Text)


        ReportViewer2.Visible = True

        Dim sTitulo As String = ""
        Dim idVendedor As Long = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
        Dim idCorredor As Long = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
        Dim idIntermediario As Long = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
        Dim idRComercial As Long = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
        Dim idClienteAuxiliar As Long = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
        Dim idDestinatario As Long = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
        Dim idArticulo As Long = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
        Dim idProcedencia As Long = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
        Dim idDestino As Long = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)
        Dim idCorredor2 As Long = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)


        If txtFechaDesde.Text <> "" And iisValidSqlDate(txtFechaDesde.Text) Is Nothing Then
            MsgBoxAlert("La fecha inicial es inválida")
        End If

        If txtFechaHasta.Text <> "" And iisValidSqlDate(txtFechaHasta.Text) Is Nothing Then
            MsgBoxAlert("La fecha final es inválida")
        End If





        If cmbInforme.Text = "Notas de entrega (a matriz de puntos)" Then cmbEstado.Text = "Descargas" 'solo mostrar descargas+facturadas


        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7789





        Dim estadofiltro As enumCDPestado
        Select Case cmbEstado.Text  '
            Case "TodasMenosLasRechazadas"
                estadofiltro = enumCDPestado.TodasMenosLasRechazadas
            Case "Incompletas"
                estadofiltro = enumCDPestado.Incompletas
            Case "Posición"
                estadofiltro = enumCDPestado.Posicion
            Case "Descargas"
                estadofiltro = enumCDPestado.DescargasMasFacturadas
            Case "Facturadas"
                estadofiltro = enumCDPestado.Facturadas
            Case "NoFacturadas"
                estadofiltro = enumCDPestado.NoFacturadas
            Case "Rechazadas"
                estadofiltro = enumCDPestado.Rechazadas
            Case "EnNotaCredito"
                estadofiltro = enumCDPestado.FacturadaPeroEnNotaCredito
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
                                cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , _
                                txtContrato.Text, , idClienteAuxiliar, -1, Val(txtVagon.Text), txtPatente.Text, , optCamionVagon.SelectedValue)


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

                Case "Cartas Duplicadas pendientes de asignar"
                    '  Dim q = LogicaFacturacion.CartasConCopiaSinAsignarLINQ(HFSC.Value)
                    Dim ms As String = ""
                    'el filtro tiene que incluir duplicados (el True despues de syngenta)
                    If Not Debugger.IsAttached Then
                        Try
                            LogicaFacturacion.CorrectorParcheSubnumeroFacturacion(HFSC.Value, ms)
                        Catch ex As Exception
                            MandarMailDeError(ex)
                        End Try
                    End If


                    Dim db As New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(Encriptar(HFSC.Value)))


                    Dim q As IQueryable(Of ProntoMVC.Data.Models.CartasDePorte) = CartasLINQ(HFSC.Value, _
                                    "", "", "", 1, 0, _
                                    estadofiltro, "", idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), _
                                     "Ambos", _
                                    Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                    Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                    cmbPuntoVenta.SelectedValue, sTitulo, optDivisionSyngenta.SelectedValue, , txtContrato.Text, _
                                    , , , , , db)


                    Dim qq As List(Of ProntoMVC.Data.Models.CartasDePorte) = LogicaFacturacion.CartasConCopiaPendiente(q, ms, HFSC.Value)
                    Dim qq2 = qq.OrderBy(Function(x) x.NumeroCartaDePorte).ThenBy(Function(x) x.SubnumeroDeFacturacion)


                    Dim serv As String


                    If System.Diagnostics.Debugger.IsAttached() Then
                        serv = "http://localhost:59798/"
                    Else
                        'es importante el HTTPS
                        'serv = "http://prontoclientes.williamsentregas.com.ar"
                        serv = "https://prontoweb.williamsentregas.com.ar"

                    End If

                    RebindReportViewerLINQ("ProntoWeb\Informes\Cartas con Copia sin asignar.rdl", qq2, New ReportParameter() {New ReportParameter("sServidor", serv)})
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


                    If False Then
                        ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                            "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Multigrain.rdl", _
                                dt, Nothing, , , sTitulo)

                    Else
                        ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                    "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) .rdl", _
                                            dt, Nothing, , , sTitulo)


                    End If


                Case "Descargar imágenes"

                    output = DescargarImagenesAdjuntas(dt, HFSC.Value, False, ConfigurationManager.AppSettings("AplicacionConImagenes"))

                Case "Descargar imágenes en PDF"

                    output = DescargarImagenesAdjuntas_PDF(dt, HFSC.Value, False, DirApp)

                Case "Descargar imágenes en TIFF"

                    output = DescargarImagenesAdjuntas_TIFF(dt, HFSC.Value, False, DirApp, False)

                Case "Listado general de cartas de porte (con imagen)"

                    'MsgBoxAjax(Me, "Listo")
                    'Exit Sub
                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto .rdl", _
                                        dt, Nothing, , , sTitulo)

                    'output = DescargarImagenesAdjuntas(dt)

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


                Case "Listado general de Cartas de Porte - Con Recibidor Oficial"
                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) recibidor oficial.rdl", _
                                        dt, Nothing, , , sTitulo)




                Case "Listado general de Cartas de Porte - Con tipo de movimiento"

                    usando servidor?
                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2,
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) recibidor oficial.rdl",
                                        dt, Nothing, , , sTitulo)





                Case "Listado general formato Cresud"

                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de Cartas de Porte (simulando original) con foto  - Cresud.rdl", _
                                        dt, Nothing, , , sTitulo)


                Case "Listado general de cartas + columna de acopio"

                    ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
                                "ProntoWeb\Informes\Listado general de cartas + columna de acopio.rdl", _
                                        dt, Nothing, , , sTitulo)



                Case "Notas de entrega (a matriz de puntos)"

                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=7789


                    'solo mostrar descargas+facturadas


                    'quien es el que tarda acá??????


                    'Acá genero un excel
                    AgruparYPaginarOrdenandoPorNumeroDeCarta(dt) ' esta funcion esta vacia


                    ErrHandler2.WriteError(dt.Rows.Count & " generar de Notas de entrega")

                    If False Then
                        output = RebindReportViewerTexto("ProntoWeb\Informes\Notas de entrega (a impresora de matriz de puntos).rdl", dt)
                    Else
                        'RebindReportViewerExcel2(HFSC.Value, "ProntoWeb\Informes\Notas de entrega (a impresora de matriz de puntos).rdl", dt, output)
                        RebindReportViewerExcel3("ProntoWeb\Informes\Notas de entrega (a impresora de matriz de puntos).rdl", dt, , output)
                    End If


                    ErrHandler2.WriteError(dt.Rows.Count & " lineas exportando a excel de Notas de entrega")



                    If True Then
                        Session("output") = output

                        Response.Redirect("CartaDePorteInformesConReportViewerSincronismos.aspx?informe=NotasEntregaCONVERTIR" & _
                                          "&articulo=" & txt_AC_Articulo.Text & _
                                            "&desde=" & txtFechaDesde.Text & _
                                            "&hasta=" & txtFechaHasta.Text & _
                                            "&modo=" & DropDownList2.Text & _
                                            "&Destinatario=" & txtDestinatario.Text)
                        Return


                    Else
                        'y acá tomo el excel y lo transformo en el txt para la EPSON
                        output = ImpresoraMatrizDePuntosEPSONTexto.ExcelToTextNotasDeEntrega(output)

                    End If

                Case "NotasEntregaCONVERTIR"
                    output = Session("output")
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


                Case "Control Kilos de Descarga"


                    Dim ArchivoExcelDestino = Path.GetTempPath & "Control Kilos de Descarga " & Now.ToString("ddMMMyyyy_HHmmss") & ".xls" 'http://

                    Dim rep As Microsoft.Reporting.WebForms.ReportViewer = New Microsoft.Reporting.WebForms.ReportViewer()

                    Dim yourParams(27) As ReportParameter
                    yourParams(0) = New ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(HFSC.Value))
                    yourParams(1) = New ReportParameter("sServidorWeb", ConfigurationManager.AppSettings("UrlDominio"))
                    yourParams(2) = New ReportParameter("FechaDesde", Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#).ToString))
                    yourParams(3) = New ReportParameter("FechaHasta", Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#).ToString))
                    yourParams(4) = New ReportParameter("IdDestino", idDestino.ToString)

                    yourParams(5) = New ReportParameter("puntoventa", cmbPuntoVenta.SelectedValue.ToString)


                    yourParams(6) = New ReportParameter("startRowIndex", "0")
                    yourParams(7) = New ReportParameter("maximumRows", "100000")
                    yourParams(8) = New ReportParameter("estado", estadofiltro)
                    yourParams(9) = New ReportParameter("QueContenga", "0")
                    yourParams(10) = New ReportParameter("idVendedor", idVendedor.ToString())
                    yourParams(11) = New ReportParameter("idCorredor", idCorredor.ToString())
                    yourParams(12) = New ReportParameter("idDestinatario", idDestinatario.ToString())
                    yourParams(13) = New ReportParameter("idIntermediario", idIntermediario)
                    yourParams(14) = New ReportParameter("idRemComercial", idRComercial)
                    yourParams(15) = New ReportParameter("idArticulo", idArticulo)
                    yourParams(16) = New ReportParameter("idProcedencia", idProcedencia)
                    yourParams(17) = New ReportParameter("AplicarANDuORalFiltro", CInt(IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR)))
                    yourParams(18) = New ReportParameter("ModoExportacion", DropDownList2.Text)
                    yourParams(19) = New ReportParameter("optDivisionSyngenta", optDivisionSyngenta.Text)
                    yourParams(20) = New ReportParameter("Contrato", "-1")
                    yourParams(21) = New ReportParameter("QueContenga2", "-1")
                    yourParams(22) = New ReportParameter("idClienteAuxiliarint", idClienteAuxiliar.ToString)
                    yourParams(23) = New ReportParameter("AgrupadorDeTandaPeriodos", "-1")
                    yourParams(24) = New ReportParameter("Vagon", IIf(txtVagon.Text = "", 0, txtVagon.Text).ToString)
                    yourParams(25) = New ReportParameter("Patente", txtPatente.Text)
                    yourParams(26) = New ReportParameter("optCamionVagon", optCamionVagon.Text)


                    Dim titulo As String = ""
                    titulo = FormatearTitulo(HFSC.Value, _
                              titulo, estadofiltro, "", idVendedor, idCorredor, _
                            idDestinatario, idIntermediario, _
                            idRComercial, idArticulo, idProcedencia, idDestino, _
                                                              IIf(cmbCriterioWHERE.SelectedValue = "todos", CartaDePorteManager.FiltroANDOR.FiltroAND, CartaDePorteManager.FiltroANDOR.FiltroOR), DropDownList2.Text, _
                            Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                            Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                             cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , _
                            txtContrato.Text, idClienteAuxiliar)
                    yourParams(27) = New ReportParameter("Titulo", titulo)





                    output = CartaDePorteManager.RebindReportViewer_ServidorExcel(rep, "Williams - Controles De Kilos Clientes.rdl", yourParams, ArchivoExcelDestino, False)






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


           
                Case "Volumen de Carga"
                    VolumenCarga()

                Case "Diferencias por Destino por Mes"
                    DiferenciasPorDestino()

                Case "Cartas Duplicadas"
                    'TraerDataset = TotalesPorMes()
                    'Dim dt = EntidadManager.GetStoreProcedure(HFSC.Value, "wCartasDePorte_TX_Informes", -1, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#))

                    CartasDuplicadas()


                Case "Taras por Camiones"

                    For Each r In dt.Rows
                        r("Patente") = r("Patente").ToString.ToUpper
                    Next

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
                    Dim dta = TotalesPorDestinos(HFSC.Value)
                    RebindReportViewer("ProntoWeb\Informes\Valorizado por SubContratista.rdl", ProntoFuncionesGenerales.DataTableWHERE(dta, sWHERE2))
                    'la primera, algunos destinos no son puertos si no que son fabricas, no se porque hacen la diferencia
                    'no, es todo lo mismo, son todos destinos, simplemente le pusieron ese nombre


                Case "Liquidación de Subcontratistas"
                    MsgBoxAjax(Me, "Usar la nueva página especial para este informe")


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

                    GeneroDataTablesDeMovimientosDeStock(dtCDPs, dt2, dtMOVs, idDestinatario, idDestino, idArticulo, fechadesde, fechahasta, HFSC.Value, cmbPuntoVenta.SelectedValue)


                    'al informe le llega "entrada" y solo toma eso en cuenta

                    Movimientos_RebindReportViewer("ProntoWeb\Informes\Movimientos.rdl", dtCDPs, dt2, dtMOVs, _
                                                  fechadesde, fechahasta, idDestino, idArticulo, idDestinatario)







                Case "Ranking de Cereales"
                    'rankcereales()
                Case "Ranking de Clientes"
                    'rankingclientes()

                Case "Listado de Tarifas"
                    'listadoTarifas()

                Case Else
                    'MsgBoxAjax(Me, "El informe no existe. Consulte con el administrador")
            End Select






        Catch ex As Exception
            Dim s As String = "Hubo un error al generar el informe. " & cmbInforme.Text & " " & ex.ToString
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
                                    "", "", 0, 999999, enumCDPestado.Todas, "", _
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
                                    "", "", 0, 999999, enumCDPestado.Todas, "", _
                                    idVendedor, idCorredor, _
                                    idDestinatario, idIntermediario, _
                                    idRComercial, idArticulo, idProcedencia, idDestino, _
                                    IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                       DropDownList2.Text, _
                                   fechadesde, fechahasta, pv)



        'dt = q.ToDataTable 'revisar cómo mandar directo la lista de linq en lugar de convertir a datatable
        RebindReportViewerLINQ("ProntoWeb\Informes\Diferencias Por Destino.rdl", q, New ReportParameter() {New ReportParameter("Titulo", fechadesde.ToShortDateString & " al " & fechahasta.ToShortDateString)})



    End Function






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
                                    "", "", 0, 999999, enumCDPestado.Todas, "", _
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
                                    "", "", 0, 999999, enumCDPestado.Todas, "", _
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




        Dim q = ConsultasLinq.totpormesmodo(HFSC.Value, _
                                 sTitulo, _
                                 "", "", 0, 999999, enumCDPestado.Todas, "", _
                                 idVendedor, idCorredor, _
                                 idDestinatario, idIntermediario, _
                                 idRComercial, idArticulo, idProcedencia, idDestino, _
                                 IIf(cmbCriterioWHERE.SelectedValue = "todos", FiltroANDOR.FiltroAND, FiltroANDOR.FiltroOR), _
                                    DropDownList2.Text, _
                                fechadesde, fechahasta, pv)


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
                                    "", "", 0, 999999, enumCDPestado.Todas, "", _
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



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////



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



    '    strWHERE += CartaDePorteManager.EstadoWHERE(enumCDPestado.DescargasMasFacturadas, "")

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
            ' .EnableViewState = False

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

    Sub RebindReportViewerExcel3(ByVal rdlFile As String, ByVal dt As DataTable, Optional ByVal dt2 As DataTable = Nothing, Optional ByRef ArchivoExcelDestino As String = "")


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

                ' Dim p1 = New ReportParameter("RenglonesPorBoleta", 8)
                Try
                    '   .SetParameters(New ReportParameter() {p1})
                Catch e As Exception
                    ErrHandler2.WriteError(e)
                    Dim inner As Exception = e.InnerException
                    While Not (inner Is Nothing)
                        If System.Diagnostics.Debugger.IsAttached() Then
                            'MsgBox(inner.Message)
                            'Stop
                        End If
                        ErrHandler2.WriteError("Error al hacer el SetParameters()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                        inner = inner.InnerException
                    End While
                    'Throw
                End Try



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
                        'MsgBox(inner.Message)
                        'Stop
                    End If
                    ErrHandler2.WriteError("Error al hacer el LocalReport.Render()  " & inner.Message) ' & "   Filas:" & dt.Rows.Count & " Filtro:" & titulo)
                    inner = inner.InnerException
                End While
                Throw
            End Try


            Try
                Dim fs = New FileStream(ArchivoExcelDestino, FileMode.Create)
                fs.Write(bytes, 0, bytes.Length)
                fs.Close()

            Catch ex As Exception
                ErrHandler2.WriteError("explotó el write")
                ErrHandler2.WriteError(ex)
                Throw
            End Try




        End With


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





    Protected Sub btnTexto_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTexto.Click

        'Dim sWHERE As String = CDPMailFiltrosManager.generarWHEREparaDatasetParametrizado(HFSC.Value, _
        '                    sTitulo, _
        '                    enumCDPestado.DescargasMasFacturadas, "", idVendedor, idCorredor, _
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




'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
'////////////////////////////////////////////////////////////////////////////////////////////////////////////
















