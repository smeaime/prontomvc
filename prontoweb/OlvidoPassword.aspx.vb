imports System
imports System.Data
imports System.Configuration
imports System.Collections
imports System.Web
imports System.Web.Security
imports System.Web.UI
imports System.Web.UI.WebControls
imports System.Web.UI.WebControls.WebParts
imports System.Web.UI.HtmlControls



Partial Class OlvidoContrasena
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        PasswordRecovery1.MailDefinition.CC = Utils.EmailCC
        PasswordRecovery1.MailDefinition.From = Utils.EmailFrom
    End Sub



    '    http://forums.asp.net/t/1124257.aspx
    Protected Sub PasswordRecovery1_SendingMail(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MailMessageEventArgs)

        'Dim mm As New Net.Mail.MailMessage()
        'mm.From = e.Message.From
        'mm.Subject = e.Message.Subject.ToString()
        'mm.[To].Add(e.Message.[To](0))
        'mm.Body = e.Message.Body

        'Dim smtp As New Net.Mail.SmtpClient()
        'smtp.EnableSsl = True
        'smtp.Send(mm)


        MandaEmailSimple(e.Message.[To](0).address, _
                        e.Message.Subject.ToString, _
                      e.Message.Body.ToString(), _
                       ConfigurationManager.AppSettings("SmtpUser"), _
                       ConfigurationManager.AppSettings("SmtpServer"), _
                       ConfigurationManager.AppSettings("SmtpUser"), _
                       ConfigurationManager.AppSettings("SmtpPass"), _
                        "", _
                       ConfigurationManager.AppSettings("SmtpPort"), , , )

        e.Cancel = True


    End Sub

End Class