Imports System.IO

Imports System.Text.RegularExpressions
Imports System.Net


Imports CartaDePorteManager


Partial Class CircuitoDeCompras
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim FilePath As String = lnkAdjunto1.Text  'si lo grabó el pronto, va a venir con el directorio original...

        ConfiguroPaginaAsincrona()

        Dim FileName As String = System.IO.Path.GetFileName("\")
        Dim MyFile As New FileInfo("Debug.bat")
        'If MyFile.Exists Then
        If ConfigurationManager.AppSettings("Debug") = "SI" Then
            Button1.Visible = True
            Button2.Visible = True
            Button3.Visible = True
            Button8.Visible = True
        Else
            Button1.Visible = False
            Button2.Visible = False
            Button3.Visible = False
            Button8.Visible = False
        End If

        Try
            If InStr(Pronto.ERP.Bll.ErrHandler2.WriteError("Prueba"), "Error") = 0 Then
                MsgBoxAjax(Me, "El directorio de log de errores no está habilitado")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, "El directorio de log de errores no está habilitado")
        End Try


        'debug
        'Dim usuario As Usuario
        'Dim sc As String
        'usuario = New Usuario
        'usuario = session(SESSIONPRONTO_USUARIO)
        'sc = usuario.StringConnection
        'Dim depurandoRM As Pronto.ERP.BO.RequerimientoList = Pronto.ERP.Bll.RequerimientoManager.GetList(sc)
        'Dim depurandoPED As Pronto.ERP.BO.PedidoList = Pronto.ERP.Bll.PedidoManager.GetList(sc)
        'Dim depurandoPRE As Pronto.ERP.BO.PresupuestoList = Pronto.ERP.Bll.PresupuestoManager.GetList(sc)
        'Dim depurandoCOMP As Pronto.ERP.BO.ComparativaList = Pronto.ERP.Bll.ComparativaManager.GetList(sc)


    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Links de mapa de compras 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click
        Response.Redirect(String.Format("frmConsultaRMsPendientesDeAsignacion.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton3.Click
        Response.Redirect(String.Format("Presupuesto.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Response.Redirect(String.Format("Requerimiento.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton5.Click
        Response.Redirect(String.Format("Pedido.aspx?Id=-1"))
    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Tests 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.Firmas(sc, Session)
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestFondoFijo(sc, Session)
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestSolicitudes(sc, Session)
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.Firmas(sc, Session)
        'Tests.TestFondoFijo(sc, Session)
        'Tests.TestSolicitudes(sc, Session)
    End Sub







    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection

        'Tests.ImportarArticulosWilliams(sc)
        'Tests.ImportarHumedadesWilliams(sc)
        'Tests.ImportarChoferesWilliams(sc)
        'Tests.ImportarTransportistasWilliams(sc)
        'Tests.ImportarCalidadesWilliams(sc)

    End Sub

    Protected Sub lnkTest_CP3_OP_Equimac_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkTest_CP3_OP_Equimac.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        Tests.TestCompras_CP3_OP_Equimac(Me, sc, Session)
        MsgBoxAjax(Me, "Listo")
    End Sub

    Protected Sub LinkButton6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton6.Click

        Session.Timeout = 60 'System.Threading.Timeout.Infinite
        Server.ScriptTimeout = 1000 * 60 * 10

        'http://helpondesk.blogspot.com.ar/2011/06/how-to-script-manager-async-post-back.html
        Dim s As ScriptManager = ScriptManager.GetCurrent(Me)
        s.AsyncPostBackTimeout = 3600 * 15


        'http://dimitri-kondis.blogspot.com.ar/2011/02/syswebformspagerequestmanagertimeoutexc.html

        Dim ajax As AjaxControlToolkit.ToolkitScriptManager = Me.Page.Master.FindControl("ScriptManager1")
        ajax.AsyncPostBackTimeout = 3600 * 15

        System.Threading.Thread.Sleep(1000 * 60 * 10)

        MsgBoxAjax(Me, "Me esperaste")
    End Sub














    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'http://www.aspnettutorials.com/tutorials/performance/asynchronous-page-vb.aspx
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Dim _request As WebRequest

    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    Sub ConfiguroPaginaAsincrona()
        AddOnPreRenderCompleteAsync(New BeginEventHandler(AddressOf BeginAsyncOperation), New EndEventHandler(AddressOf EndAsyncOperation))
        Me.lblUrl.Text = Me.txtUrl.Text
    End Sub

    Function BeginAsyncOperation(ByVal sender As Object, ByVal e As EventArgs, ByVal cb As AsyncCallback, ByVal state As Object) As IAsyncResult
        _request = WebRequest.Create(Me.txtUrl.Text.Trim())
        Return _request.BeginGetResponse(cb, state)
    End Function 'BeginAsyncOperation

    Sub EndAsyncOperation(ByVal ar As IAsyncResult)
        Dim [text] As String
        Dim response As WebResponse = _request.EndGetResponse(ar)
        Try
            Dim reader As New StreamReader(response.GetResponseStream())
            Try
                [text] = reader.ReadToEnd()
            Finally
                reader.Dispose()
            End Try
        Finally
            response.Close()
        End Try
        Dim regex As New Regex("href\s*=\s*""([^""]*)""", RegexOptions.IgnoreCase)
        Dim matches As MatchCollection = regex.Matches([text])
        Dim builder As New System.Text.StringBuilder(1024)
        Dim match As Match
        For Each match In matches
            builder.Append(match.Groups(1))
            builder.Append("<br>")
        Next match
        Output.Text = builder.ToString()
    End Sub 'EndAsyncOperation

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Public Sub New()

    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        AddOnPreRenderCompleteAsync(New BeginEventHandler(AddressOf BeginAsyncOperation), New EndEventHandler(AddressOf EndAsyncOperation))
    End Sub
End Class