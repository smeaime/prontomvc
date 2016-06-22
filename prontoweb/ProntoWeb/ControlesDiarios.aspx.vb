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


Partial Class ControlesDiarios
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
            'refrescaPeriodo()



            BloqueosDeEdicion()
        End If


        ' AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnTexto)

        'AutoCompleteExtender2.ContextKey = HFSC.Value

    End Sub

    Protected Sub Page_LoadComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.LoadComplete
        'If bRecargarInforme Then AsignaInformeAlReportViewer()
    End Sub










    Private Sub BindTypeDropDown()


        'optDivisionSyngenta.DataTextField = "desc"
        'optDivisionSyngenta.DataValueField = "desc"
        ''optDivisionSyngenta.DataValueField = "idacopio"
        'optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(HFSC.Value).Select(Function(z) New With {z.desc})
        'optDivisionSyngenta.DataBind()


        'cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
        ''cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
        'cmbPuntoVenta.DataTextField = "PuntoVenta"
        'cmbPuntoVenta.DataValueField = "PuntoVenta"
        'cmbPuntoVenta.DataBind()
        'cmbPuntoVenta.SelectedIndex = 0
        'cmbPuntoVenta.Items.Insert(0, New ListItem("Todos los puntos de venta", -1))
        'cmbPuntoVenta.SelectedIndex = 0

        'If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
        '    Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
        '    BuscaTextoEnCombo(cmbPuntoVenta, pventa)
        '    If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
        'End If

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


End Class


