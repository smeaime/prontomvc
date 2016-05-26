
Partial Class mailPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("q") Is Nothing) Then
            Dim sMailCliente As String = Request.QueryString.Get("q")
            Dim tit As String = Request.QueryString.Get("e")

            If True Then Return 'por ahora, suspender la notificacion

            'http://en.wikipedia.org/wiki/Return_receipt
            'http://www.4guysfromrolla.com/articles/101707-1.aspx

            MandaEmail(sMailCliente, _
                    "Aviso de lectura: " & tit, _
                  "El correo fue leído", _
                ConfigurationManager.AppSettings("SmtpUser"), _
                ConfigurationManager.AppSettings("SmtpServer"), _
                ConfigurationManager.AppSettings("SmtpUser"), _
                ConfigurationManager.AppSettings("SmtpPass"), _
                 , _
                ConfigurationManager.AppSettings("SmtpPort"), _
                , _
                   )

        End If
    End Sub
End Class
