
Imports CartaDePorteManager

Partial Class Consultas
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()

        If Not Page.IsPostBack Then
            ReportViewer1.ServerReport.ReportServerUrl = New Uri("http://" & ConfigurationManager.AppSettings("ReportServer") & "/ReportServer")
            ReportViewer1.ServerReport.Refresh()
        End If
    End Sub

    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (Session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function

    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox1.SelectedIndexChanged
        ReportViewer1.ServerReport.ReportPath = ListBox1.SelectedValue
        ReportViewer1.ServerReport.Refresh()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'http://blogs.msdn.com/bobmeyers/archive/2006/01/24/report-builder-launch-parameters.aspx
        'To launch Report Builder, use one of the following URLs (also documented on MSDN):

        'http://<servername>/reportserver/reportbuilder/reportbuilder.application (Full Trust)
        'http://<servername>/reportserver/reportbuilder/reportbuilderlocalintranet.application (LocalIntranet permissions only)

        'In addition to this, several launch parameters are supported:

        'To automatically open a specific report:
        'Append "?<reportpath>" to the URL (e.g. http://.../reportbuilder.application?/My+Reports/Quarterly+Sales+By+Region)

        'To automatically load a specific report model:
        'Append "?model=<modelpath>" to the URL (e.g. http://.../reportbuilder.application?model=/Models/Adventure+Works)

        'To automatically load a perspective of a specific report model:
        'Append "?model=<modelpath>&perspective=<perspectiveID>" to the URL. Note this is the ID of the perspective, not the Name.

        If ListBox1.SelectedValue <> "" Then
            Response.Redirect(String.Format("http://" & ConfigurationManager.AppSettings("ReportServer") & "/ReportServer/ReportBuilder/ReportBuilder_2_0_0_0.application?model=" & ListBox1.SelectedValue))
        End If
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        'me está pidiendo usuario y clave!
        Response.Redirect(String.Format("http://" & ConfigurationManager.AppSettings("ReportServer") & "/Reports/Pages/Folder.aspx"))

    End Sub


End Class
