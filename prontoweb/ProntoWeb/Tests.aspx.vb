Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Web.Services
Imports System.Diagnostics
Imports System.Linq

Imports CartaDePorteManager

Partial Class TestsPagina
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim Usuario = New Usuario
        Usuario = Session(SESSIONPRONTO_USUARIO)


        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        'que pasa si el usuario es Nothing? Qué se rompió?
        '-en desarrollo, al modificar el codebehind, quedas logueado pero perdes la sesion.... en todo caso, lo importante es no perder a qué base estas conectado
        'lo mismo puede pasar, supongo, en produccion, al pisar un codebehind (sin reciclar). El usuario queda logueado y pierde la sesion
        If Usuario Is Nothing Then
            If Debugger.IsAttached And True Then
                Session(SESSIONPRONTO_UserId) = Membership.GetUser.ProviderUserKey.ToString
                Session(SESSIONPRONTO_UserName) = Membership.GetUser.UserName
                'Session("Empresas") = arrayEmpresas

                Dim idempresa = BDLMasterEmpresasManagerMigrar.IdEmpresaDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)
                'BDLMasterEmpresasManagerMigrar.AddEmpresaToSession("Williams", Session, ConexBDLmaster, Me)

                Usuario = Session(SESSIONPRONTO_USUARIO)

            Else
                'acá podría usar lo mismo, siempre y cuando esten usando una sola empresa. Y de no ser así, redirigirlos, pero no al login, sino al seleccionarempresa
                Response.Redirect(String.Format("../Login.aspx"))
            End If

        End If
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        Dim SC = Usuario.StringConnection

        Dim idtest

        If Not (Request.QueryString.Get("Test") Is Nothing) Then
            idtest = Convert.ToInt32(Request.QueryString.Get("Test"))
        End If

        Select Case idtest
            Case 9066
                Dim output As String = Tests.test1_ReclamoN9066(SC)
                test1_Reclamo11289(SC)
            Case 11065, 11289
                test1_Reclamo11289(SC)
            Case Else
                MsgBoxAjax(Me, "No existe")
                Return
        End Select

        MsgBoxAjax(Me, "listo")

    End Sub

    Sub megatest()
        'importador
        'envios de mails
        'informes
        'sincronismo
    End Sub


    Sub test1_Reclamo11289(sc As String)
        'http://localhost:48391/ProntoWeb/ProntoWeb/Tests.aspx?test=11242
        Dim grid = Nothing
        Dim dt = CDPMailFiltrosManager2.TraerMetadata(sc, 2000)
        Dim dr = dt.Rows(0)
        Dim l, sError, sError2 As String
        'Dim output = CDPMailFiltrosManager.generarNotasDeEntregaConReportViewer(sc, #1/1/1753#, #1/1/2100#, _
        '                                                                        dr, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, l, "", _
        '                                      Server.MapPath("~/Imagenes/Williams.bmp"), 1, , , True, grid)




        'CDPMailFiltrosManager.EnviarMailFiltroPorId(sc, _
        '                                               #1/20/2013#, #1/20/2013#, -1, _
        '                                               4511, "", CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, sError, _
        '                                               False, _
        '                                               ConfigurationManager.AppSettings("SmtpServer"), _
        '                                               ConfigurationManager.AppSettings("SmtpUser"), _
        '                                               ConfigurationManager.AppSettings("SmtpPass"), _
        '                                                ConfigurationManager.AppSettings("SmtpPort"), _
        '                                                   "", sError2)


        'CartaDePorteManager.EnviarMailFiltroPorId_DLL(sc, _
        '                                             #1/20/2013#, #1/20/2013#, -1, _
        '                                             4511, "", CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, sError, _
        '                                             False, _
        '                                             ConfigurationManager.AppSettings("SmtpServer"), _
        '                                             ConfigurationManager.AppSettings("SmtpUser"), _
        '                                             ConfigurationManager.AppSettings("SmtpPass"), _
        '                                              ConfigurationManager.AppSettings("SmtpPort"), _
        '                                                 "", sError2)

    End Sub




End Class
