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


Partial Class SincronismosAutomaticos
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


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            Me.Title = "Sincros Automáticos"

            BindTypeDropDown()
            refrescaPeriodo()



            BloqueosDeEdicion()

            txtRedirigirA.Text = UsuarioSesion.Mail(HFSC.Value, Session)


            Dim pv As String = Val(cmbPuntoVenta.SelectedValue)
            If pv <= 1 Then pv = ""
            txtMailAibal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAibal" & pv).ToString
            txtMailACA.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteACA" & pv).ToString
            txtMailAJNari.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAJNari").ToString
            txtMailAlabern.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAlabern" & pv).ToString
            txtMailAlabernCal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAlabernCal").ToString
            txtMailAlea.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAlea").ToString
            txtMailAibal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAibal").ToString
            txtMailAmaggi.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggi").ToString
            txtMailAmaggiCal.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggiCal").ToString
            txtMailAndreoli.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAndreoli" & pv).ToString
            txtMailAreco.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAreco" & pv).ToString
            txtMailArgencer.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteArgencer" & pv).ToString
            txtMailBeraza.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBeraza" & pv).ToString
            txtMailBLD.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBLD" & pv).ToString
            txtMailBunge.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBunge" & pv).ToString
            txtMailDiazForti.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDiazForti" & pv).ToString
            txtMailDiazRiganti.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDiazRiganti" & pv).ToString
            txtMailDOW.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDOW" & pv).ToString
            txtMailDukarevich.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteDukarevich" & pv).ToString
            txtMailElEnlace.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteElEnlace" & pv).ToString
            txtMailEstanar.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteEstanar" & pv).ToString
            txtMailLeiva.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteLeiva" & pv).ToString
            txtMailLartirigoyen.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteLartirigoyen" & pv).ToString
            txtMailBiznaga.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBiznaga" & pv).ToString
            txtMailBragadense.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBragadense" & pv).ToString
            txtMailFYO.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteFYO" & pv).ToString

            txtMailGesagro.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGesagro" & pv).ToString

            txtMailGranar.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGranar" & pv).ToString
            txtMailGrobo.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGrobo" & pv).ToString
            txtMailGranosdelParana.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelParana" & pv).ToString
            txtMailGranosdelLitoral.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelLitoral" & pv).ToString
            txtMailGrimaldi.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGrimaldi" & pv).ToString
            txtMailGualeguay.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteGualeguay" & pv).ToString
            txtMailCinque.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteCinque" & pv).ToString
            txtMailMorgan.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteMorgan" & pv).ToString
            txtMailMonsanto.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteMonsanto" & pv).ToString
            txtMailNoble.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteNoble" & pv).ToString
            txtMailNobleCalidad.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteNobleCalidad" & pv).ToString
            txtMailPelayo.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPortePelayo" & pv).ToString
            txtMailPetroagro.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPortePetroAgro" & pv).ToString
            txtMailPSA.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPortePSA" & pv).ToString
            txtMailPSAcalid.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPortePSAcalid" & pv).ToString
            txtMailRivara.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteRivara" & pv).ToString
            txtMailSantaCatalina.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteSantaCatalina" & pv).ToString
            txtMailSyngenta.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteSyngenta" & pv).ToString
            txtMailTerraverde.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteTerraverde" & pv).ToString
            txtMailTomas.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteTomas" & pv).ToString
            txtMailTecnocampo.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteTecnocampo" & pv).ToString
            txtMailZENI.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteZENI" & pv).ToString


            txtMailAgrosur.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteAgrosur" & pv).ToString
            txtMailLelfun.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteLelfun" & pv).ToString
            txtMailOjeda.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteOjeda" & pv).ToString
            txtMailBTGPactual.Text = ParametroManager.TraerValorParametro2(HFSC.Value, "CasillaCartasPorteBTGPactual" & pv).ToString


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
                txtFechaDesde.Text = DateTime.MinValue
                txtFechaHasta.Text = DateTime.MaxValue

            Case "Hoy"
                txtFechaDesde.Text = Today
                txtFechaHasta.Text = DateAdd(DateInterval.Day, 1, Today)

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


    Sub grabar()
        Dim pv As String = Val(cmbPuntoVenta.SelectedValue)
        If pv <= 1 Then pv = ""

        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteACA" & pv, txtMailACA.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAJNari" & pv, txtMailAJNari.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAlabern" & pv, txtMailAlabern.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAlea" & pv, txtMailAlea.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAibal" & pv, txtMailAibal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggi" & pv, txtMailAmaggi.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAndreoli" & pv, txtMailAndreoli.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAreco" & pv, txtMailAreco.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteArgencer" & pv, txtMailArgencer.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBeraza" & pv, txtMailBeraza.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBLD" & pv, txtMailBLD.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBunge" & pv, txtMailBunge.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDiazForti" & pv, txtMailDiazForti.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDiazRiganti" & pv, txtMailDiazRiganti.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDOW" & pv, txtMailDOW.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteDukarevich" & pv, txtMailDukarevich.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteElEnlace" & pv, txtMailElEnlace.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteEstanar" & pv, txtMailElEnlace.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteLeiva" & pv, txtMailLeiva.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteLartirigoyen" & pv, txtMailLartirigoyen.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBiznaga" & pv, txtMailBiznaga.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBragadense" & pv, txtMailBragadense.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteFYO" & pv, txtMailFYO.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGesagro" & pv, txtMailGesagro.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGrobo" & pv, txtMailGrobo.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGranar" & pv, txtMailGranar.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelParana" & pv, txtMailGranosdelParana.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGranosdelLitoral" & pv, txtMailGranosdelLitoral.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGrimaldi" & pv, txtMailGrimaldi.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteGualeguay" & pv, txtMailGualeguay.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteCinque" & pv, txtMailCinque.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteMonsanto" & pv, txtMailMonsanto.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteMorgan" & pv, txtMailMorgan.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteNoble" & pv, txtMailNoble.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPortePelayo" & pv, txtMailPelayo.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPortePetroAgro" & pv, txtMailPetroagro.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPortePSA" & pv, txtMailPSA.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteRivara" & pv, txtMailRivara.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteSantaCatalina" & pv, txtMailSantaCatalina.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteSyngenta" & pv, txtMailSyngenta.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteTerraverde" & pv, txtMailTerraverde.Text)

        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteTomas" & pv, txtMailTomas.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteTecnocampo" & pv, txtMailTecnocampo.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteZENI" & pv, txtMailZENI.Text)



        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAlabernCal" & pv, txtMailAlabernCal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAmaggiCal" & pv, txtMailAmaggiCal.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteNobleCalidad" & pv, txtMailNobleCalidad.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPortePSAcalid" & pv, txtMailPSAcalid.Text)


        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteAgrosur" & pv, txtMailAgrosur.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteLelfun" & pv, txtMailLelfun.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteOjeda" & pv, txtMailOjeda.Text)
        ParametroManager.GuardarValorParametro2(HFSC.Value, "CasillaCartasPorteBTGPactual" & pv, txtMailBTGPactual.Text)



    End Sub


    Sub enviarTodos(bVistaPrevia As Boolean)


        grabar()
        Dim sErr = "", sTodosErr As String


        Try
            'http://stackoverflow.com/questions/801818/how-to-covert-mm-dd-yyyy-to-dd-mm-yyyy
            globalDesde = DateTime.ParseExact(txtFechaDesde.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) '.ToString("MM'/'dd'/'yyyy")
            globalHasta = DateTime.ParseExact(txtFechaHasta.Text, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture) '.ToString("MM'/'dd'/'yyyy")
        Catch ex As Exception
            ErrHandler2.WriteError("Error en la fecha")
            ErrHandler2.WriteError(txtFechaDesde.Text)
            ErrHandler2.WriteError(txtFechaHasta.Text)
            MandarMailDeError("Error en la fecha:" + txtFechaDesde.Text + ";" + txtFechaHasta.Text + ";" + ex.ToString)
            MsgBoxAjax(Me, "El formato de las fechas debe ser dd/mm/aaaa")
            Return
        End Try

        If (chkACA.Checked) Then sTodosErr += Enviar("A.C.A.", txtMailACA.Text, sErr, bVistaPrevia)
        If (chkAJNari.Checked) Then sTodosErr += Enviar("AJNari", txtMailAJNari.Text, sErr, bVistaPrevia)
        If (chkAgrosur.Checked) Then sTodosErr += Enviar("Agrosur", txtMailAgrosur.Text, sErr, bVistaPrevia)
        If (CheckBoxAlabern.Checked) Then sTodosErr += Enviar("Alabern", txtMailAlabern.Text, sErr, bVistaPrevia)
        If (CheckBoxAlabernCal.Checked) Then sTodosErr += Enviar("ALABERN (CALIDADES)", txtMailAlabernCal.Text, sErr, bVistaPrevia)
        If (CheckBoxAlea.Checked) Then sTodosErr += Enviar("Alea", txtMailAlea.Text, sErr, bVistaPrevia)
        If (CheckBoxAibal.Checked) Then sTodosErr += Enviar("Aibal", txtMailAibal.Text, sErr, bVistaPrevia)
        If (CheckBoxAmaggi.Checked) Then sTodosErr += Enviar("Amaggi (descargas)", txtMailAmaggi.Text, sErr, bVistaPrevia)
        If (CheckBoxAmaggiCal.Checked) Then sTodosErr += Enviar("AMAGGI (CALIDADES)", txtMailAmaggi.Text, sErr, bVistaPrevia)
        If (CheckBoxAndreoli.Checked) Then sTodosErr += Enviar("Andreoli", txtMailAndreoli.Text, sErr, bVistaPrevia)
        If (CheckBoxAreco.Checked) Then sTodosErr += Enviar("Areco", txtMailAreco.Text, sErr, bVistaPrevia)
        If (CheckBoxArgencer.Checked) Then sTodosErr += Enviar("Argencer", txtMailArgencer.Text, sErr, bVistaPrevia)
        If (CheckBoxBeraza.Checked) Then sTodosErr += Enviar("Beraza", txtMailBeraza.Text, sErr, bVistaPrevia)
        If (CheckBoxBLD.Checked) Then sTodosErr += Enviar("BLD", txtMailBLD.Text, sErr, bVistaPrevia)
        If (CheckBoxBLD.Checked) Then sTodosErr += Enviar("BLD (CALIDADES)", txtMailBLD.Text, sErr, bVistaPrevia)
        If (CheckBoxBTGPactual.Checked) Then sTodosErr += Enviar("BTG PACTUAL [BIT]", txtMailBTGPactual.Text, sErr, bVistaPrevia)
        If (CheckBoxBunge.Checked) Then sTodosErr += Enviar("Bunge", txtMailBunge.Text, sErr, bVistaPrevia)
        If (CheckBoxDiazForti.Checked) Then sTodosErr += Enviar("Diaz Forti", txtMailDiazForti.Text, sErr, bVistaPrevia)
        If (CheckBoxDiazRiganti.Checked) Then sTodosErr += Enviar("Diaz Riganti", txtMailDiazRiganti.Text, sErr, bVistaPrevia)
        If (CheckBoxDOW.Checked) Then sTodosErr += Enviar("DOW", txtMailDOW.Text, sErr, bVistaPrevia)
        If (CheckBoxDukarevich.Checked) Then sTodosErr += Enviar("Dukarevich", txtMailDukarevich.Text, sErr, bVistaPrevia)
        If (CheckBoxElEnlace.Checked) Then sTodosErr += Enviar("El Enlace", txtMailElEnlace.Text, sErr, bVistaPrevia)
        If (CheckBoxEstanar.Checked) Then sTodosErr += Enviar("El Enlace", txtMailEstanar.Text, sErr, bVistaPrevia)
        If (CheckBoxLeiva.Checked) Then sTodosErr += Enviar("Leiva", txtMailLeiva.Text, sErr, bVistaPrevia)
        If (CheckBoxLartirigoyen.Checked) Then sTodosErr += Enviar("Lartirigoyen", txtMailLartirigoyen.Text, sErr, bVistaPrevia)
        If (CheckBoxBiznaga.Checked) Then sTodosErr += Enviar("La Biznaga", txtMailBiznaga.Text, sErr, bVistaPrevia)
        If (CheckBoxBragadense.Checked) Then sTodosErr += Enviar("La Bragadense", txtMailBragadense.Text, sErr, bVistaPrevia)
        If (CheckBoxLelfun.Checked) Then sTodosErr += Enviar("Lelfun", txtMailLelfun.Text, sErr, bVistaPrevia)
        If (CheckBoxGrobo.Checked) Then sTodosErr += Enviar("Los Grobo", txtMailGrobo.Text, sErr, bVistaPrevia)
        If (CheckBoxGesagro.Checked) Then sTodosErr += Enviar("Gesagro", txtMailGesagro.Text, sErr, bVistaPrevia)
        If (CheckBoxGranar.Checked) Then sTodosErr += Enviar("Granar", txtMailGranar.Text, sErr, bVistaPrevia)
        If (CheckBoxFYO.Checked) Then sTodosErr += Enviar("FYO", txtMailFYO.Text, sErr, bVistaPrevia)
        If (CheckBoxGranosdelParana.Checked) Then sTodosErr += Enviar("Granos del Parana", txtMailGranosdelParana.Text, sErr, bVistaPrevia)
        If (CheckBoxGranosdelLitoral.Checked) Then sTodosErr += Enviar("Granos del Litoral", txtMailGranosdelLitoral.Text, sErr, bVistaPrevia)
        If (CheckBoxGrimaldi.Checked) Then sTodosErr += Enviar("Grimaldi Grassi", txtMailGrimaldi.Text, sErr, bVistaPrevia)
        If (CheckBoxGualeguay.Checked) Then sTodosErr += Enviar("Gualeguay", txtMailGualeguay.Text, sErr, bVistaPrevia)
        If (CheckBoxCinque.Checked) Then sTodosErr += Enviar("Miguel Cinque", txtMailCinque.Text, sErr, bVistaPrevia)
        If (CheckBoxMonsanto.Checked) Then sTodosErr += Enviar("Monsanto", txtMailMonsanto.Text, sErr, bVistaPrevia)
        If (CheckBoxMorgan.Checked) Then sTodosErr += Enviar("Morgan (descargas)", txtMailMorgan.Text, sErr, bVistaPrevia)
        If (CheckBoxNoble.Checked) Then sTodosErr += Enviar("Noble", txtMailNoble.Text, sErr, bVistaPrevia)
        If (CheckBoxNobleCalidad.Checked) Then sTodosErr += Enviar("Noble (anexo calidades)", txtMailNobleCalidad.Text, sErr, bVistaPrevia)
        If (CheckBoxOjeda.Checked) Then sTodosErr += Enviar("Ojeda", txtMailOjeda.Text, sErr, bVistaPrevia)
        If (CheckBoxPelayo.Checked) Then sTodosErr += Enviar("Pelayo", txtMailPelayo.Text, sErr, bVistaPrevia)
        If (CheckBoxPetroagro.Checked) Then sTodosErr += Enviar("PetroAgro", txtMailPetroagro.Text, sErr, bVistaPrevia)
        If (CheckBoxPSA.Checked) Then sTodosErr += Enviar("PSA La California", txtMailPSA.Text, sErr, bVistaPrevia)
        'If (CheckBoxPSAcalid.Checked) Then sTodosErr += Enviar("PSA La California (calidades)", txtMailPSA.Text, sErr, bVistaPrevia)
        If (CheckBoxRivara.Checked) Then sTodosErr += Enviar("Rivara", txtMailRivara.Text, sErr, bVistaPrevia)
        If (CheckBoxSantaCatalina.Checked) Then sTodosErr += Enviar("Santa Catalina", txtMailSantaCatalina.Text, sErr, bVistaPrevia)


        If (CheckBoxSyngenta.Checked) Then sTodosErr += Enviar("Syngenta", txtMailSyngenta.Text, sErr, bVistaPrevia)



        If (CheckBoxTerraVerde.Checked) Then sTodosErr += Enviar("Terra Verde", txtMailTerraverde.Text, sErr, bVistaPrevia)
        If (CheckBoxTomas.Checked) Then sTodosErr += Enviar("Tomas Hnos", txtMailTomas.Text, sErr, bVistaPrevia)
        If (CheckBoxTecnocampo.Checked) Then sTodosErr += Enviar("Tecnocampo", txtMailTecnocampo.Text, sErr, bVistaPrevia)
        If (CheckBoxZENI.Checked) Then sTodosErr += Enviar("Zeni", txtMailZENI.Text, sErr, bVistaPrevia)






        SincronismosWilliamsManager.ElegirCombosSegunParametro("LIMPIAR", txtTitular, txtCorredor, txtIntermediario, txtDestinatario, txtRcomercial, txtPopClienteAuxiliar, cmbEstado, cmbCriterioWHERE, DropDownList2, HFSC.Value)




        lblErrores.Text = sTodosErr






        MsgBoxAjax(Me, "Listo")
    End Sub


    Function verificarTamañoArchivo(f As String) As Boolean

        Try
            Dim myFile As New FileInfo(f)
            Dim sizeInBytes As Long = myFile.Length

            Return (sizeInBytes > 0)

        Catch ex As Exception
            Return False

        End Try


    End Function

    Function Enviar(sincro As String, sEmail As String, ByRef sErr As String, bvistaPrevia As Boolean) As String


        ' Los mails salen desde la cuenta general de Bs As , cuando tienen que salir desde la general de 
        'cada sucursal, te paso un ejemplo todos los que pasamos anoche salieron a dos direcciones cualquiera y a 
        'ningun mail de los clientes (que no estaban) ; fijate que todos los sincros salieron a la direccion de Maxi la de arroyo. (adjunto los mails)

        Try

            If Not IsValidEmail(sEmail) And False Then
                sErr = sincro & ": La casilla de correo es inválida"
                Return sErr
            End If



            SincronismosWilliamsManager.ElegirCombosSegunParametro(sincro, txtTitular, txtCorredor, txtIntermediario, txtDestinatario, txtRcomercial, txtPopClienteAuxiliar, cmbEstado, cmbCriterioWHERE, DropDownList2, HFSC.Value)



            Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
            Dim idCorredor = BuscaIdVendedorPreciso(txtCorredor.Text, HFSC.Value)
            Dim idIntermediario = BuscaIdClientePreciso(txtIntermediario.Text, HFSC.Value)
            Dim idRComercial = BuscaIdClientePreciso(txtRcomercial.Text, HFSC.Value)
            Dim idClienteAuxiliar = BuscaIdClientePreciso(txtPopClienteAuxiliar.Text, HFSC.Value)
            Dim idDestinatario = BuscaIdClientePreciso(txtDestinatario.Text, HFSC.Value)
            Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
            Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)
            Dim idDestino = BuscaIdWilliamsDestinoPreciso(txtDestino.Text, HFSC.Value)


            'si los filtros estan vacíos, debería deshabilitar esta descarga. Cómo manejar estos casos, más allá de los automaticos?
            If idVendedor <= 0 _
                 And idCorredor <= 0 _
                 And idIntermediario <= 0 _
                 And idRComercial <= 0 _
                 And idClienteAuxiliar <= 0 _
                 And idDestinatario <= 0 _
                 And idArticulo <= 0 _
                 And idProcedencia <= 0 _
                 And idDestino <= 0 _
                 Then
                sErr += vbCrLf + "No se puede enviar el sincro si no se aplican filtros" + vbCrLf
                Return sErr
            End If



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
                    'Return
            End Select


            Dim sArchivo = SincronismosWilliamsManager.GenerarSincro(sincro, sErr,
                                                             HFSC.Value, ConfigurationManager.AppSettings("UrlDominio"),
                                                             "", estadofiltro, "", idVendedor, idCorredor,
                                                            idDestinatario, idIntermediario,
                                                            idRComercial, idArticulo, idProcedencia, idDestino,
                                                            IIf(cmbCriterioWHERE.SelectedValue = "todos",
                                                                CartaDePorteManager.FiltroANDOR.FiltroAND,
                                                              CartaDePorteManager.FiltroANDOR.FiltroOR),
                                                            DropDownList2.Text,
                                                             globalDesde, globalHasta,
                                                               cmbPuntoVenta.SelectedValue, optDivisionSyngenta.SelectedValue, , , , idClienteAuxiliar
)

            If sArchivo <> "" And verificarTamañoArchivo(sArchivo) Then



                Dim dest As String = IIf(bvistaPrevia, txtRedirigirA.Text, sEmail + "," + txtRedirigirA.Text)
                Dim puntoventa As Integer = cmbPuntoVenta.SelectedValue
                Dim De, CCOaddress As String

                Select Case puntoventa
                    Case 1
                        De = "buenosaires@williamsentregas.com.ar"
                        CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                    Case 2
                        De = "sanlorenzo@williamsentregas.com.ar"
                        CCOaddress = "descargas-sl@williamsentregas.com.ar" ' & CCOaddress
                    Case 3
                        De = "arroyoseco@williamsentregas.com.ar"
                        CCOaddress = "descargas-as@williamsentregas.com.ar" '& CCOaddress
                    Case 4
                        De = "bahiablanca@williamsentregas.com.ar"
                        CCOaddress = "descargas-bb@williamsentregas.com.ar" ' & CCOaddress
                    Case Else
                        De = "buenosaires@williamsentregas.com.ar"
                        CCOaddress = "descargas-ba@williamsentregas.com.ar" ' & CCOaddress
                End Select

                Dim cuerpo = ""
                cuerpo = CDPMailFiltrosManager2.AgregarFirmaHtml(puntoventa)



                If False Then

                    EnviarEmail(dest, "Sincro automático " + sincro, cuerpo,
                           De,
                            ConfigurationManager.AppSettings("SmtpServer"),
                          ConfigurationManager.AppSettings("SmtpUser"),
                          ConfigurationManager.AppSettings("SmtpPass"),
                         sArchivo,
                            ConfigurationManager.AppSettings("SmtpPort"), , CCOaddress, , "Williams Entregas")

                Else


                    MandaEmail_Nuevo(dest, "Sincro automático " + sincro, cuerpo,
                           De,
                            ConfigurationManager.AppSettings("SmtpServer"),
                          ConfigurationManager.AppSettings("SmtpUser"),
                          ConfigurationManager.AppSettings("SmtpPass"),
                         sArchivo,
                            ConfigurationManager.AppSettings("SmtpPort"), , CCOaddress, , "Williams Entregas", , True)
                End If





                If (sincro.ToUpper = "SYNGENTA") Then
                    EnviarSyngenta()
                    sErr += vbCrLf + "Enviado a Syngenta Webservice" + vbCrLf
                End If




            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MandarMailDeError(ex)
            sErr += ex.ToString
        End Try

        Return sErr
    End Function




    Function EnviarSyngenta()


        'Dim idcliente = 4333 'syngenta

        'Dim dbcartas = CartaDePorteManager.ListadoSegunCliente(HFSC.Value, idcliente, globalDesde, globalHasta, CartaDePorteManager.enumCDPestado.Todas)

        Dim s = New ServicioCartaPorte.servi()
        'Dim endpointStr = ConfigurationManager.AppSettings("SyngentaServiceEndpoint")
        'Dim UserName = ConfigurationManager.AppSettings("SyngentaServiceUser")
        'Dim Password = ConfigurationManager.AppSettings("SyngentaServicePass")
        'Dim x = s.WebServiceSyngenta(dbcartas, endpointStr, UserName, Password)


        'Dim DIRFTP = DirApp() + @"\DataBackupear\"
        '            Dim archivoExcel = DIRFTP + "Syngenta_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx"


        's.GenerarExcelSyngentaWebService(x, archivoExcel)


        's.UploadFtpFile(ConfigurationManager.AppSettings("SyngentaFTPdominio"),
        '                    ConfigurationManager.AppSettings("SyngentaFTPdir"),
        '                    archivoExcel,
        '                    ConfigurationManager.AppSettings("SyngentaFTPuser"),
        '                    ConfigurationManager.AppSettings("SyngentaFTPpass"))



        's.EnviarSyngenta( )

        s.EnviarSyngenta(HFSC.Value,
                        globalDesde, globalHasta,
                        ConfigurationManager.AppSettings("SyngentaServiceEndpoint"),
                            ConfigurationManager.AppSettings("SyngentaServiceUser"),
                            ConfigurationManager.AppSettings("SyngentaServicePass"),
                            ConfigurationManager.AppSettings("SyngentaFTPdominio"),
                            ConfigurationManager.AppSettings("SyngentaFTPdir"),
                            ConfigurationManager.AppSettings("SyngentaFTPuser"),
                            ConfigurationManager.AppSettings("SyngentaFTPpass"),
                            DirApp)


    End Function


















    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        grabar()
    End Sub
End Class







































































