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


Partial Class SincronismosAutomaticos
    Inherits System.Web.UI.Page

    Dim bRecargarInforme As Boolean
    Private _sWHERE As Object
    Dim btnTexto As Control

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


        'If Session(SESSIONPRONTO_UserName) <> "Mariano" Then Button1.Visible = False


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            Me.Title = "Sincros Automáticos"

            'BindTypeDropDown()
            refrescaPeriodo()



            BloqueosDeEdicion()

            txtRedirigirA.Text = UsuarioSesion.Mail(HFSC.Value, Session)


            txtMailAibal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAibal").ToString
            txtMailACA.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteACA").ToString
            txtMailAlabern.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAlabern").ToString
            txtMailAlabernCal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAlabernCal").ToString
            txtMailAlea.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAlea").ToString
            txtMailAibal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAibal").ToString
            txtMailAmaggi.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggi").ToString
            txtMailAmaggiCal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggiCal").ToString
            txtMailAndreoli.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAndreoli").ToString
            txtMailArgencer.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteArgencer").ToString
            txtMailBLD.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBLD").ToString
            txtMailBunge.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBunge").ToString
            txtMailDiazRiganti.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDiazRiganti").ToString
            txtMailDOW.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDOW").ToString
            txtMailDukarevich.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDukarevich").ToString
            txtMailElEnlace.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteElEnlace").ToString
            txtMailLartirigoyen.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteLartirigoyen").ToString
            txtMailBragadense.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBragadense").ToString
            txtMailFYO.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteFYO").ToString
            txtMailGrobo.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGrobo").ToString
            txtMailGranosdelParana.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelParana").ToString
            txtMailGranosdelLitoral.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelLitoral").ToString
            txtMailGrimaldi.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGrimaldi").ToString
            txtMailCinque.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteCinque").ToString
            txtMailNoble.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteNoble").ToString
            txtMailNobleCalidad.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteNobleCalidad").ToString
            txtMailPSA.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPortePSA").ToString
            txtMailPSAcalid.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPortePSAcalid").ToString
            txtMailRivara.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteRivara").ToString
            txtMailSantaCatalina.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteSantaCatalina").ToString
            txtMailSyngenta.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteSyngenta").ToString
            txtMailTomas.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteTomas").ToString
            txtMailTecnocampo.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteTecnocampo").ToString
            txtMailZENI.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteZENI").ToString

        End If


        ' AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnTexto)

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

        End If






        '        [02:10:43 p.m.] Mariano Scalella: apuntamelo en una consulta. tengo enel codigo harcodeado q mgarcia y mgarcia2 no pueden ver totales generales. q hago?
        '[02:11:19 p.m.] an78gubad: tengo el ok de hugo, asi que mgarcia y dberzoni tienen que verlo


        '////////////////////////////////////////////
        '////////////////////////////////////////////
        '////////////////////////////////////////////





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














    Protected Sub lnkEnviarVistaPrevia_Click(sender As Object, e As System.EventArgs) Handles lnkEnviarVistaPrevia.Click


        enviarTodos(True)
    End Sub


    Protected Sub Button2_Click(sender As Object, e As System.EventArgs) Handles Button2.Click
        'Dim archivoAibal = generarAibal()
        'Enviar(generarAibal(), txtMailAibal.Text)



        enviarTodos(False)
    End Sub

    Sub enviarTodos(bVistaPrevia As Boolean)


        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAibal", txtMailAibal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteACA", txtMailACA.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAlabern", txtMailAlabern.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAlea", txtMailAlea.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAibal", txtMailAibal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggi", txtMailAmaggi.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAndreoli", txtMailAndreoli.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteArgencer", txtMailArgencer.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBLD", txtMailBLD.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBunge", txtMailBunge.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDiazRiganti", txtMailDiazRiganti.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDOW", txtMailDOW.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDukarevich", txtMailDukarevich.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteElEnlace", txtMailElEnlace.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteLartirigoyen", txtMailLartirigoyen.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBragadense", txtMailBragadense.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteFYO", txtMailFYO.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGrobo", txtMailGrobo.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelParana", txtMailGranosdelParana.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelLitoral", txtMailGranosdelLitoral.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGrimaldi", txtMailGrimaldi.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteCinque", txtMailCinque.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteNoble", txtMailNoble.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPortePSA", txtMailPSA.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteRivara", txtMailRivara.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteSantaCatalina", txtMailSantaCatalina.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteSyngenta", txtMailSyngenta.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteTomas", txtMailTomas.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteTecnocampo", txtMailTecnocampo.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteZENI", txtMailZENI.Text)



        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAlabernCal", txtMailAlabernCal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggiCal", txtMailAmaggiCal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteNobleCalidad", txtMailNobleCalidad.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPortePSAcalid", txtMailPSAcalid.Text)


        Dim sErr = "", sTodosErr As String
        If (CheckBoxAibal.Checked) Then sTodosErr += Enviar("AIBAL", txtMailAibal.Text, sErr, bVistaPrevia)

        If (chkACA.Checked) Then sTodosErr += Enviar("A.C.A.", txtMailACA.Text, sErr, bVistaPrevia)
        If (CheckBoxAlabern.Checked) Then sTodosErr += Enviar("Alabern", txtMailAlabern.Text, sErr, bVistaPrevia)
        If (CheckBoxAlabernCal.Checked) Then sTodosErr += Enviar("Alabern", txtMailAlabern.Text, sErr, bVistaPrevia)
        If (CheckBoxAlea.Checked) Then sTodosErr += Enviar("Alea", txtMailAlea.Text, sErr, bVistaPrevia)
        If (CheckBoxAibal.Checked) Then sTodosErr += Enviar("Aibal", txtMailAibal.Text, sErr, bVistaPrevia)
        If (CheckBoxAmaggi.Checked) Then sTodosErr += Enviar("Amaggi (descargas)", txtMailAmaggi.Text, sErr, bVistaPrevia)
        If (CheckBoxAmaggiCal.Checked) Then sTodosErr += Enviar("Amaggi (descargas)", txtMailAmaggi.Text, sErr, bVistaPrevia)
        If (CheckBoxAndreoli.Checked) Then sTodosErr += Enviar("Andreoli", txtMailAndreoli.Text, sErr, bVistaPrevia)
        If (CheckBoxArgencer.Checked) Then sTodosErr += Enviar("Argencer", txtMailArgencer.Text, sErr, bVistaPrevia)
        If (CheckBoxBLD.Checked) Then sTodosErr += Enviar("BLD", txtMailBLD.Text, sErr, bVistaPrevia)
        If (CheckBoxBunge.Checked) Then sTodosErr += Enviar("Bunge", txtMailBunge.Text, sErr, bVistaPrevia)
        If (CheckBoxDiazRiganti.Checked) Then sTodosErr += Enviar("Diaz Riganti", txtMailDiazRiganti.Text, sErr, bVistaPrevia)
        If (CheckBoxDOW.Checked) Then sTodosErr += Enviar("DOW", txtMailDOW.Text, sErr, bVistaPrevia)
        If (CheckBoxDukarevich.Checked) Then sTodosErr += Enviar("Dukarevich", txtMailDukarevich.Text, sErr, bVistaPrevia)
        If (CheckBoxElEnlace.Checked) Then sTodosErr += Enviar("El Enlace", txtMailElEnlace.Text, sErr, bVistaPrevia)
        If (CheckBoxLartirigoyen.Checked) Then sTodosErr += Enviar("Lartirigoyen", txtMailLartirigoyen.Text, sErr, bVistaPrevia)
        If (CheckBoxBragadense.Checked) Then sTodosErr += Enviar("La Bragadense", txtMailBragadense.Text, sErr, bVistaPrevia)
        If (CheckBoxGrobo.Checked) Then sTodosErr += Enviar("Los Grobo", txtMailGrobo.Text, sErr, bVistaPrevia)
        If (CheckBoxFYO.Checked) Then sTodosErr += Enviar("FYO", txtMailFYO.Text, sErr, bVistaPrevia)
        If (CheckBoxGranosdelParana.Checked) Then sTodosErr += Enviar("Granos del Parana", txtMailGranosdelParana.Text, sErr, bVistaPrevia)
        If (CheckBoxGranosdelLitoral.Checked) Then sTodosErr += Enviar("Granos del Litoral", txtMailGranosdelLitoral.Text, sErr, bVistaPrevia)
        If (CheckBoxGrimaldi.Checked) Then sTodosErr += Enviar("Grimaldi Grassi", txtMailGrimaldi.Text, sErr, bVistaPrevia)
        If (CheckBoxCinque.Checked) Then sTodosErr += Enviar("Miguel Cinque", txtMailCinque.Text, sErr, bVistaPrevia)
        If (CheckBoxNoble.Checked) Then sTodosErr += Enviar("Noble", txtMailNoble.Text, sErr, bVistaPrevia)
        If (CheckBoxNobleCalidad.Checked) Then sTodosErr += Enviar("Noble (anexo calidades)", txtMailNobleCalidad.Text, sErr, bVistaPrevia)
        If (CheckBoxPSA.Checked) Then sTodosErr += Enviar("PSA La California", txtMailPSA.Text, sErr, bVistaPrevia)
        If (CheckBoxPSAcalid.Checked) Then sTodosErr += Enviar("PSA La California", txtMailPSA.Text, sErr, bVistaPrevia)
        If (CheckBoxRivara.Checked) Then sTodosErr += Enviar("Rivara", txtMailRivara.Text, sErr, bVistaPrevia)
        If (CheckBoxSantaCatalina.Checked) Then sTodosErr += Enviar("Santa Catalina", txtMailSantaCatalina.Text, sErr, bVistaPrevia)
        If (CheckBoxSyngenta.Checked) Then sTodosErr += Enviar("Syngenta", txtMailSyngenta.Text, sErr, bVistaPrevia)
        If (CheckBoxTomas.Checked) Then sTodosErr += Enviar("Tomas Hnos", txtMailTomas.Text, sErr, bVistaPrevia)
        If (CheckBoxTecnocampo.Checked) Then sTodosErr += Enviar("Tecnocampo", txtMailTecnocampo.Text, sErr, bVistaPrevia)
        If (CheckBoxZENI.Checked) Then sTodosErr += Enviar("Zeni", txtMailZENI.Text, sErr, bVistaPrevia)



      

        lblErrores.Text = sTodosErr






        MsgBoxAjax(Me, "Listo")
    End Sub




    Function Enviar(sincro As String, sEmail As String, ByRef sErr As String, bvistaPrevia As Boolean) As String
        Try

            Dim sArchivo = GenerarSincro(sincro, sErr)

            If sArchivo = "" Then Return ""


            Dim dest As String = IIf(bvistaPrevia, txtRedirigirA.Text, sEmail + "," + txtRedirigirA.Text)


            EnviarEmail(dest, "Sincro automático " + sincro, "", _
                  ConfigurationManager.AppSettings("SmtpUser"), _
                  ConfigurationManager.AppSettings("SmtpServer"), _
                  ConfigurationManager.AppSettings("SmtpUser"), _
                  ConfigurationManager.AppSettings("SmtpPass"), _
                 sArchivo, _
                  ConfigurationManager.AppSettings("SmtpPort"), , "", , "Williams Entregas")

        Catch ex As Exception
            ErrHandler.WriteError(ex)
            sErr += ex.ToString
        End Try

        Return sErr
    End Function













    Protected Sub ElegirCombosSegunParametro(sSincronismo As String)



        cmbEstado.Text = "Descargas"
        txtTitular.Text = ""
        txtCorredor.Text = ""
        txtDestinatario.Text = ""
        cmbCriterioWHERE.SelectedValue = "alguno"
        'ojo, en sincro automaticos, cuales puedo filtrar?


        Select Case sSincronismo.ToUpper
            Case "A.C.A."
                txtTitular.Text = ""
                txtCorredor.Text = "A.C.A. LTDA"
            Case "AIBAL"
                txtTitular.Text = "AIBAL S.A"
            Case "ALABERN"
                txtTitular.Text = ""
                txtCorredor.Text = "ALABERN, FABREGA & CIA S.A."
            Case "ALEA"
                txtTitular.Text = "ALEA Y CIA. SA"
            Case "ARGENCER"
                txtTitular.Text = ""
                txtCorredor.Text = "ARGENCER SA"
            Case "ANDREOLI"
                txtDestinatario.Text = "ANDREOLI S.A."
            Case "AMAGGI (CALIDADES)", "AMAGGI (DESCARGAS)"
                txtCorredor.Text = ""
                txtDestinatario.Text = "AMAGGI ARGENTINA SA"
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

            Case "DIAZ RIGANTI"
                txtTitular.Text = ""
                txtCorredor.Text = "DIAZ RIGANTI CEREALES S.R.L."

            Case "DOW"

                txtTitular.Text = "DOW AGROSCIENCES ARG. SA"
                txtCorredor.Text = ""

            Case "DUKAREVICH"
                txtTitular.Text = ""
                txtCorredor.Text = "DUKAREVICH S.A"

            Case "EL ENLACE"
                txtTitular.Text = "EL ENLACE S.A."

            Case "LARTIRIGOYEN"
                txtTitular.Text = "LARTIRIGOYEN S.A."

            Case "FYO"
                txtTitular.Text = ""
                txtCorredor.Text = "FUTUROS Y OPCIONES .COM"

            Case "FYO (POSICIÓN)"
                txtTitular.Text = ""
                txtCorredor.Text = "FUTUROS Y OPCIONES .COM"
                cmbEstado.Text = "Posición"

            Case "GRANOS DEL LITORAL"
                txtTitular.Text = ""
                txtCorredor.Text = "GRANOS DEL LITORAL S.A."

            Case "GRANOS DEL PARANA"
                txtTitular.Text = ""
                txtCorredor.Text = "GRANOS DEL PARANA S.A."

            Case "NOBLE", "NOBLE (ANEXO CALIDADES)"
                txtDestinatario.Text = "NOBLE ARGENTINA S.A."
                txtCorredor.Text = ""
                txtTitular.Text = "NOBLE ARGENTINA S.A."

            Case "GRIMALDI GRASSI"
                txtTitular.Text = ""
                txtCorredor.Text = "GRIMALDI GRASSI S.A."

            Case "LA BRAGADENSE"
                txtTitular.Text = "LA BRAGADENSE S.A"

            Case "LOS GROBO"
                txtTitular.Text = "LOS GROBO  AGROPECUARIA S.A."
                txtCorredor.Text = ""
            Case "SYNGENTA"
                txtRcomercial.Text = "SYNGENTA AGRO S.A."
                'txtIntermediario.Text = "SYNGENTA AGRO S.A."
                txtCorredor.Text = ""

            Case "PSA LA CALIFORNIA", "PSA LA CALIFORNIA (CALIDADES)"
                txtCorredor.Text = "PSA LA CALIFORNIA SA"

            Case "RIVARA"
                txtTitular.Text = "RIVARA S.A"
                txtRcomercial.Text = "RIVARA S.A"


            Case "MIGUEL CINQUE"
                txtTitular.Text = "CINQUE MIGUEL MARTIN"
            Case "SANTA CATALINA"
                txtTitular.Text = "SANTA CATALINA SA"


            Case "TOMAS HNOS"
                txtTitular.Text = "TOMAS HNOS Y CIA. S.A."
                txtCorredor.Text = ""

            Case "TECNOCAMPO"
                txtTitular.Text = "TECNOCAMPO SA"
                txtCorredor.Text = ""
            Case "ZENI"
                txtTitular.Text = ""
                txtCorredor.Text = "ZENI ENRIQUE y CIA SACIAF e I"



            Case Else
                Throw New Exception(sSincronismo.ToUpper + " No existe ese sincro")




        End Select
    End Sub


    Function GenerarSincro(sSincronismo As String, ByRef err As String) As String
        Dim output As String = ""

        ElegirCombosSegunParametro(sSincronismo)

        'Dim dt = EntidadManager.ExecDinamicoConStrongTypedDataset(HFSC.Value, strSQLsincronismo)

        ' cómo le digo al dataset tipado a qué base conectarse?
        'http://blogs.msdn.com/b/marcelolr/archive/2010/04/06/changing-the-connection-string-for-typed-datasets.aspx

        'Interesante!!! Uso una RuntimeConnectionString !!! -mmmm, cambiar esos datos en tiempo
        'de ejecucion???? No pinta muy bueno.... -Bueno! es un hack....
        'http://rajmsdn.wordpress.com/2009/12/09/strongly-typed-dataset-connection-string/
        'http://stackoverflow.com/questions/695491/best-way-to-set-strongly-typed-dataset-connection-string-at-runtime
        'http://forums.asp.net/p/1068777/1553283.aspx


        ErrHandler.WriteError("Generando sincro para " & sSincronismo)

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





        Using ds As New WillyInformesDataSet

            '// Customize the connection string.
            Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(HFSC.Value)) ' Properties.Settings.Default.DistXsltDbConnectionString)
            'builder.DataSource = builder.DataSource.Replace(".", Environment.MachineName)
            Dim desiredConnectionString = builder.ConnectionString

            '// Set it directly on the adapter.

            'esta seria la cuestion, aca llega con 30 segs nada mas de timeout, diferente del timeout de la conexion
            Try

                Using adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter

                    'http://blogs.msdn.com/b/smartclientdata/archive/2005/08/16/increasetableadapterquerytimeout.aspx
                    adapter.SetCommandTimeOut(60)

                    adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
                    'adapter.Connection..Adapter.SelectCommand.CommandTimeout = 60


                    'limitar el fill  -supongo que tendrías que poner el top en wCartasDePorte_TX_InformesCorregido
                    'limitar el fill  -supongo que tendrías que poner el top en wCartasDePorte_TX_InformesCorregido
                    'limitar el fill  -supongo que tendrías que poner el top en wCartasDePorte_TX_InformesCorregido
                    'limitar el fill  -supongo que tendrías que poner el top en wCartasDePorte_TX_InformesCorregido



                    adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), _
                                 Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), _
                                idVendedor, idCorredor, idDestinatario, idIntermediario, _
                                idRComercial, idArticulo, idProcedencia, idDestino, CartaDePorteManager._CONST_MAXROWS, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas)





                    '     using(SqlDataAdapter dataAdapter = new SqlDataAdapter(strSQL, strConnStr))
                    '{
                    '   using(SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter))
                    '   {


                    '            }

                    '            }

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
                                           Val(cmbPuntoVenta.SelectedValue), optDivisionSyngenta.SelectedValue)
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


            Dim sForzarNombreDescarga As String = ""

            Dim registrosFiltrados As Integer

            Try

                Select Case sSincronismo.ToUpper
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
                                                      Val(cmbPuntoVenta.SelectedValue), optDivisionSyngenta.SelectedValue)
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

                        registrosFiltrados = dt.Rows.Count

                    Case "ARGENCER"
                        output = Sincronismo_Argencer(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "ZENI"
                        Dim sErrores As String

                        output = Sincronismo_ZENI(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)
                        lblErrores.Text = sErrores

                        'If iisNull(sErrores, "") <> "" Then Exit Sub

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count



                    Case "ANDREOLI"


                        Dim sErrores As String

                        output = Sincronismo_AndreoliDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores

                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "AMAGGI (DESCARGAS)"


                        Dim sErrores As String

                        output = Sincronismo_AmaggiDescargas(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE, sErrores)


                        lblErrores.Text = sErrores

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
                                        idRComercial, idArticulo, idProcedencia, idDestino, "1", DropDownList2.Text, Convert.ToDateTime(iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)), Convert.ToDateTime(iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)), Val(cmbPuntoVenta.SelectedValue), sTitulo, , , , , idClienteAuxiliar)

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
                                          Val(cmbPuntoVenta.SelectedValue), sTitulo, , , , , idClienteAuxiliar)



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
                            Return ""
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
                                            Val(cmbPuntoVenta.SelectedValue), sTitulo, , , , , idClienteAuxiliar)



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
                            Exit Function

                        Else
                            output = Sincronismo_GrimaldiGrassi(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)
                        End If
                        registrosFiltrados = ds.wCartasDePorte_TX_InformesCorregido.Count


                    Case "NOBLE"
                        Dim sErrores As String
                        output = Sincronismo_NOBLE(ds.wCartasDePorte_TX_InformesCorregido, "", sWHERE, sErrores)

                        lblErrores.Text = sErrores
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
                        registrosFiltrados = dt.Rows.Count



                        'sForzarNombreDescarga = "HPESA.TXT"



                    Case Else
                        ErrHandler.WriteError("No se está eligiendo bien el sincro" & sSincronismo)
                        MsgBoxAjax(Me, "Elija un sincronismo. " + sSincronismo)
                        Return ""
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
                Return ""
            Catch ex As Exception
                ErrHandler.WriteAndRaiseError(ex)

            End Try

            If output = "" Then
                ErrHandler.WriteError("No se pudo generar nada " & sSincronismo)
                MsgBoxAjax(Me, "No se encontraron registros")
                Return ""
            End If


            '+ registrosFiltrados.ToString + " registros "

            err = vbCrLf + vbCrLf + "<hr/><strong>" + sSincronismo + "</strong><br/>" + vbCrLf + "  <br/> " + lblErrores.Text + "<br/><br/><br/>"

            If registrosFiltrados = 0 Then
                err = vbCrLf + vbCrLf + "<hr/><strong>" + sSincronismo + "</strong><br/>" + "SIN REGISTROS  <br/> <br/>"
                output = ""
            End If


        End Using


        Return output



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
            Throw ex
        Finally
            myConnection.Close()
            myConnection.Dispose()
        End Try
    End Sub


End Class



















