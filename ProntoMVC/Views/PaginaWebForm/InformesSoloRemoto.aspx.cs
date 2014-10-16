

/*

'http://social.msdn.microsoft.com/Forums/en-US/sqlreportingservices/thread/1688f270-7608-475e-b81b-d077e0664090/



    Sub InitServerReport()

        'https://www.google.com.ar/search?sourceid=chrome&ie=UTF-8&q=rsInvalidItemPath



        ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote
        ReportViewerRemoto.ShowCredentialPrompts = True
        ReportViewerRemoto.ShowExportControls = True
        ReportViewerRemoto.ServerReport.ReportServerCredentials = New ReportsServerCredentials.ReportServerCredentials
        ReportViewerRemoto.ServerReport.ReportServerUrl = New Uri("http://bdlconsultores.dyndns.org:81/ReportServer")
        'ReportViewerRemoto.ServerReport.ReportPath = "Pronto informes/Balance"
        'ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/Balance"
        ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/Pedido"

        ReportViewerRemoto.ServerReport.Refresh()
        ReportViewerRemoto.ServerReport.Timeout = 1000 * 60 * 3 '3minutos

        'ReportServer/Pages/ReportViewer.aspx?%2fPronto+informes%2fPedido&rs:Command=Render
    End Sub
  
 
  
  Public Class ReportsServerCredentials

    <Serializable()> _
    Public NotInheritable Class ReportServerCredentials
        Implements IReportServerCredentials

        Public ReadOnly Property ImpersonationUser() As WindowsIdentity _
            Implements IReportServerCredentials.ImpersonationUser
            Get

                'Use the default windows user. Credentials will be
                'provided by the NetworkCredentials property.
                Return Nothing

            End Get
        End Property

        Public ReadOnly Property NetworkCredentials() As Net.ICredentials _
            Implements IReportServerCredentials.NetworkCredentials
            Get

                'Read the user information from the web.config file. 
                'By reading the information on demand instead of storing 
                'it, the credentials will not be stored in session, 
                'reducing the vulnerable surface area to the web.config 
                'file, which can be secured with an ACL.



                'User name
                Dim userName As String = _
                 If(ConfigurationManager.AppSettings("Administrator"), "administrador")

                If (String.IsNullOrEmpty(userName)) Then
                    Throw New Exception("Missing user name from web.config file")
                End If

                'Password
                Dim password As String = _
                  If(ConfigurationManager.AppSettings("Password"), ".xza2190lkm.")

                If (String.IsNullOrEmpty(password)) Then
                    Throw New Exception("Missing password from web.config file")
                End If

                'Domain
                Dim domain As String = _
                  If(ConfigurationManager.AppSettings("ServerName"), "") 'el dominio del usuario, NO el servidor de informes

                'If (String.IsNullOrEmpty(domain)) Then
                '    Throw New Exception("Missing domain from web.config file")
                'End If

                Return New Net.NetworkCredential(userName, password, domain)



            End Get
        End Property

        Public Function GetFormsCredentials(ByRef authCookie As System.Net.Cookie, _
                          ByRef userName As String, _
                          ByRef password As String, _
                          ByRef authority As String) _
                          As Boolean _
            Implements IReportServerCredentials.GetFormsCredentials

            authCookie = Nothing
            userName = Nothing
            password = Nothing
            authority = Nothing

            'Not using form credentials
            Return False

        End Function
    End Class
End Class



*/