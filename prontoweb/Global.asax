<%@ Application Language="VB" %>

<%@ Import Namespace="StackExchange.Profiling" %>

<%@ Import Namespace="Pronto.ERP.Bll" %>



<script RunAt="server">



    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    'Simulate a Windows Service using ASP.NET to run scheduled jobs
    'Simulate a Windows Service using ASP.NET to run scheduled jobs
    'http://www.codeproject.com/KB/aspnet/ASPNETService.aspx
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////

    'Cómo librarse de este harcodeo????? no es facil. No puedo usar simplemente "localhost" si usan un puerto. Ponerlo en
    'el web config? De todas maneras, lo que es mas preocupante es el harcodeo de la cadena de conexion a la base, en lugar de 
    'usar la bdlMaster, y que ahí se pasee por todas las bases que necesiten tareas programadas.


    '//////////////////
    'urls a los sitios


    '   no puedo llamar al configuration desde acá?????? -SÍIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
    'Const urlLocal = "http://localhost:48391/prontoweb/TestCacheTimeout/WebForm1.aspx"
    'Const urlWilliamsRelease = "http://prontoweb.williamsentregas.com.ar/TestCacheTimeout/WebForm1.aspx"
    'Const urlWilliamsDebug = "http://190.2.243.13/williamsdebug/TestCacheTimeout/WebForm1.aspx"


    Public ReadOnly Property urlLocal() As String
        Get
            Return ConfigurationManager.AppSettings("urlLocal")
        End Get
    End Property
    Public ReadOnly Property urlWilliamsRelease() As String
        Get
            Return ConfigurationManager.AppSettings("urlWilliamsRelease")
        End Get
    End Property
    Public ReadOnly Property urlWilliamsDebug() As String
        Get
            Return ConfigurationManager.AppSettings("urlWilliamsDebug")
        End Get
    End Property




    'Const urlWilliamsReleaseNuevo =  "http://localhost/Pronto/TestCacheTimeout/WebForm1.aspx" 

    '//////////////////
    'conexiones a basesPronto que tienen mails encolados

    'Const scLocal = "Data Source=MARIANO-PC;Initial Catalog=wDemoWilliams;Integrated Security=True"
    'Const scWilliamsRelease = "Data Source=osvm21;Initial catalog=Williams;User ID=sa; Password=Zeekei3quo;Connect Timeout=45"
    'Const scWilliamsDebug = "Data Source=osvm21;Initial catalog=wDemoWilliams2;User ID=sa; Password=Zeekei3quo;Connect Timeout=45"

    'Const scWilliamsReleaseNuevo = "Data Source=119C994749;Initial catalog=Williams;User ID=pronto;Password=MeDuV8NSlxRlnYxhMFL3;Connect Timeout=45"


    Public ReadOnly Property scLocal() As String
        Get
            Return ConfigurationManager.AppSettings("scLocal")
        End Get
    End Property
    Public ReadOnly Property scWilliamsRelease() As String
        Get
            Return ConfigurationManager.AppSettings("scWilliamsRelease")
        End Get
    End Property
    Public ReadOnly Property scWilliamsDebug() As String
        Get
            Return ConfigurationManager.AppSettings("scWilliamsDebug")
        End Get
    End Property



    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////


    'Simulate a Windows Service using ASP.NET to run scheduled jobs
    'Simulate a Windows Service using ASP.NET to run scheduled jobs
    'Simulate a Windows Service using ASP.NET to run scheduled jobs
    'http://www.codeproject.com/KB/aspnet/ASPNETService.aspx
    ' -tambien está piola la contestacion de 	Alphons van der Heijden - Old project, my old opinion [modified] 

    'cómo evita llamarse dos veces?



    Private Const DummyCacheItemKey As String = "GagaGuguGigi"

    Private Function RegisterCacheEntry() As Boolean

        If ConfigurationManager.AppSettings("ColaWebDeTareasActivada") = "NO" Then Return False

        If Not IsNothing(HttpContext.Current.Cache(DummyCacheItemKey)) Then Return False

        HttpContext.Current.Cache.Add(DummyCacheItemKey, "Test", Nothing,
                DateTime.MaxValue, TimeSpan.FromMinutes(1),
                CacheItemPriority.Normal,
                New CacheItemRemovedCallback(AddressOf CacheItemRemovedCallback))

        Return True
    End Function

    Public Sub CacheItemRemovedCallback(ByVal key As String, ByVal value As Object, ByVal reason As CacheItemRemovedReason)

        '        ErrHandler2.WriteError("Cache item callback: " + DateTime.Now.ToString())

        HitPage()
        '// Do the service works

        DoWork()
    End Sub


    'Private Const DummyPageUrl As String = "http://localhost/Pronto/TestCacheTimeout/WebForm1.aspx"
    Private Const DummyPageUrl As String = "~/TestCacheTimeout/WebForm1.aspx"

    Public Sub HitPage()
        Dim client = New Net.WebClient
        'Dim d = DummyPageUrl
        Dim d = System.Web.VirtualPathUtility.ToAbsolute(DummyPageUrl)

        ' http://stackoverflow.com/questions/4163898/how-to-use-webclient-downloaddatato-a-local-dummypage-aspx
        If System.Diagnostics.Debugger.IsAttached() Then
            d = urlLocal
            ' ErrHandler2.WriteError("hit page: " + d)
            Try
                client.DownloadData(d)
            Catch ex As Exception
                ErrHandler2.WriteError("Probablemente estoy depurando")
            End Try
        Else
            'TODO: ah, pero acá como sabes si usar la debug o la otra?...

            Dim tipo As String = ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno")

            If tipo = "Debug" Then
                d = urlWilliamsDebug
                'ErrHandler2.WriteError("hit page: " + d)

                Try
                    client.DownloadData(d)
                Catch ex As Exception
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'http://stackoverflow.com/questions/4150938/system-net-unsafenclnativemethods-ossock-recv-webservice-exception
                    'http://blogs.msdn.com/b/dotnetremoting/archive/2006/10/14/whidbey-remoting-accessviolation-problem-maheshwar-jayaraman.aspx

                    ErrHandler2.WriteError(ex.ToString & ". Revisar el visor de eventos. antivirus. Error al hacer hit en sitio DEBUG: " & d)
                End Try
            Else
                d = urlWilliamsRelease
                ' ErrHandler2.WriteError("hit page: " + d)
                Try
                    client.DownloadData(d)
                Catch ex As Exception
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'guarda con esto, que puede ser que el antivirus se esté quejando!!!!!!! (en Williams tienen el NOD32)
                    'http://stackoverflow.com/questions/4150938/system-net-unsafenclnativemethods-ossock-recv-webservice-exception
                    'http://blogs.msdn.com/b/dotnetremoting/archive/2006/10/14/whidbey-remoting-accessviolation-problem-maheshwar-jayaraman.aspx

                    'The remote name could not be resolved
                    'The remote name could not be resolved
                    'The remote name could not be resolved
                    'http://geekswithblogs.net/TimH/archive/2006/02/09/68811.aspx
                    'http://stackoverflow.com/questions/901340/the-remote-name-could-not-be-resolved


                    ErrHandler2.WriteError(ex.ToString & ". Revisar el visor de eventos. antivirus, proxy, firewall. Error al hacer hit en sitio PRODUCCION: " & d)
                End Try
            End If


        End If


    End Sub





    Protected Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)

        '// If the dummy page is hit, then it means we want to add another item
        '    // in cache

        If (Request.IsLocal And False) Then MiniProfiler.Start()


        Dim d = System.Web.VirtualPathUtility.ToAbsolute(DummyPageUrl)

        If HttpContext.Current.Request.RawUrl.ToLower() = d.ToLower Then
            '// Add the item in cache and when succesful, do the work.

            RegisterCacheEntry()
        End If

    End Sub



    Protected Sub Application_EndRequest()

        MiniProfiler.Stop()
    End Sub



    Private Sub DoWork()

        'Debug.WriteLine("Begin DoWork...");
        'Debug.WriteLine("Running as: " + 
        '      WindowsIdentity.GetCurrent().Name );

        'DoSomeFileWritingStuff();
        'DoSomeDatabaseOperation();
        'DoSomeWebserviceCall();
        'DoSomeMSMQStuff();
        'DoSomeEmailSendStuff();

        'Debug.WriteLine("End DoWork...");

        'TODO: si ya se esta ejecutando, irse...



        'en el metodo de http://www.west-wind.com/weblog/posts/2007/May/10/Forcing-an-ASPNET-Application-to-stay-alive  , hay un
        'comentario:   // *** Ensure that any waiting instances are shut down
        ' cómo hace?



        Dim Usuario = New Usuario
        'Usuario = session(SESSIONPRONTO_USUARIO)
        'que pasa si el usuario es Nothing? Qué se rompió?
        'If Usuario Is Nothing Then Response.Redirect(String.Format("../Login.aspx"))

        Dim SC As String '= Usuario.StringConnection
        'Dim SC = GetConnectionString(Server, Session)

        If System.Diagnostics.Debugger.IsAttached() Then
            SC = Encriptar(scLocal)
            '        ErrHandler2.WriteError("Llamada a mailloopwork: " + DateTime.Now.ToString() + " " + SC)
            Pronto.ERP.Bll.CDPMailFiltrosManager.MailLoopWork(SC)
        Else

            'TODO: ah, pero acá como sabes si usar la debug o la otra?... quizas seria bueno que MailLoopWork se pasease por todas las de la tabla Bases de la BDLmaster

            If ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno") = "Debug" Then
                SC = Encriptar(scWilliamsDebug)
                Pronto.ERP.Bll.CDPMailFiltrosManager.MailLoopWork(SC)
            Else
                SC = Encriptar(scWilliamsRelease)
                Pronto.ERP.Bll.CDPMailFiltrosManager.MailLoopWork(SC)
            End If

            '   ErrHandler2.WriteError("Llamada a mailloopwork: " + DateTime.Now.ToString() + " " + SC)

        End If



    End Sub
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////


    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        Dim empresaList As Pronto.ERP.BO.EmpresaList
        empresaList = Pronto.ERP.Bll.EmpresaManager.GetList(ConexBDLmaster)
        Application("empresaList") = empresaList

        RegisterCacheEntry()


        'AddHandler SiteMap.SiteMapResolve, AddressOf Me.ExpandForumPaths
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs

        ' http://www.asp.net/hosting/tutorials/processing-unhandled-exceptions-cs


        'Get the error details




        'Dim lastErrorWrapper As HttpException = Server.GetLastError()
        Dim lastErrorWrapper As Exception = Server.GetLastError()


        Dim lastError As Exception = lastErrorWrapper
        If lastErrorWrapper.InnerException IsNot Nothing Then
            lastError = lastErrorWrapper.InnerException
        End If

        Dim lastErrorTypeName As String = lastError.GetType().ToString()
        Dim lastErrorMessage As String = lastError.Message
        Dim lastErrorStackTrace As String = lastError.StackTrace

        If lastErrorStackTrace Is Nothing Then lastErrorStackTrace = ""

        Try

            ErrHandler2.WriteError(lastError)
        Catch ex As Exception

        End Try






        ' Attach the Yellow Screen of Death for this error   
        Dim YSODmarkup As String
        Dim lastErrorWrapperHttp As HttpException
        Try
            If Not TypeOf lastErrorWrapper Is Microsoft.Reporting.WebForms.AspNetSessionExpiredException Then



                lastErrorWrapperHttp = lastErrorWrapper

                YSODmarkup = lastErrorWrapperHttp.GetHtmlErrorMessage()
                If (Not String.IsNullOrEmpty(YSODmarkup)) Then

                    Dim YSOD = Net.Mail.Attachment.CreateAttachmentFromString(YSODmarkup, "YSOD.htm")
                    'mm.Attachments.Add(YSOD)

                End If
            End If
        Catch ex As Exception

        End Try

        Dim Body As String = ""

        'If Not IsNothing(lastErrorWrapperHttp) Then
        Try

            Body = String.Format(
                "<html><body> <h1>Hubo un error!</h1>_  <table cellpadding=""5"" cellspacing=""0"" border=""1"">  <tr>  <td style=""text-align: right;font-weight: bold"">URL:</td>  <td>{0}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">User:</td>  <td>{1}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">Exception Type:</td>  <td>{2}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">Message:</td>  <td>{3}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">Stack Trace:</td>  <td>{4}</td>  </tr>   </table></body></html>",
                If(lastErrorWrapperHttp Is Nothing, "NO EXISTE REQUEST", Request.RawUrl),
                 If(lastErrorWrapperHttp Is Nothing, "NO EXISTE USUARIO", User.Identity.Name),
                lastErrorTypeName,
                lastErrorMessage,
                lastErrorStackTrace.Replace(Environment.NewLine, "<br />"))

        Catch ex As Exception

        End Try
        '            End If

        Body &= iisNull(YSODmarkup, "")

        Dim direccion As String
        Try
            direccion = ConfigurationManager.AppSettings("ErrorMail")
        Catch ex As Exception
            direccion = ""
            'Dim direccion = "mscalella911@gmail.com"
        End Try
        If iisNull(direccion, "") = "" Then direccion = "mscalella911@gmail.com,apgurisatti@bdlconsultores.com.ar"


        'me fijo si estoy depurando en el IDE. No lo hago antes para probar el pedazo de codigo de arriba. Es el mail
        'lo que traba todo
        If System.Diagnostics.Debugger.IsAttached() Then Return






        Try

            'si saltó un timeout o un deadlock, podría ejecutar un "EXEC sp_who2"
            'http://stackoverflow.com/questions/7743725/how-to-troubleshoot-intermittent-sql-timeout-errors

            If Body.ToLower.Contains("deadlock") Or Body.ToLower.Contains("timeout") _
                    Or Body.ToLower.Contains("application-defined") Or Body.ToLower.Contains("transport-level") Then



                Body &= ".       Hacer profile del IIS.  avisar si se está backupeando a las 4 de la mañana Ver si el error " &
                            " es de system memory o de report processing, recomendar reinicio del IIS por las sesiones con basura. Adjunto de sp_who2: "

                Dim SC = Encriptar(scWilliamsRelease)
                Dim s = CartaDePorteManager.Log_sp_who2(SC)
                Body &= s




                '"EXEC sp_who2"
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        'TO DO
        '    http://support.microsoft.com/kb/555938
        'A transport-level error has occurred when receiving results from the server. (provider: TCP Provider, error: 0 - The specified network name is no longer available.)
        'The error is being caused by a timeout exception for long running queries. In previous versions of Visual Studio .NET, the exception was properly represented as a exception with a timeout description.



        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////
        'http://stackoverflow.com/questions/178600/microsoft-reportviewer-session-expired-errors
        Dim exc As Exception = Server.GetLastError().GetBaseException()
        If TypeOf exc Is Microsoft.Reporting.WebForms.AspNetSessionExpiredException Then
            ErrHandler2.WriteError("error del AspNetSessionExpiredException")
            Server.ClearError()
            Response.Redirect(FormsAuthentication.LoginUrl + "?ReturnUrl=" + HttpUtility.UrlEncode(Request.Url.PathAndQuery), True)
            Exit Sub
        End If
        '/////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////





        Try
            'apgurisatti@bdlconsultores.com.ar", _
            MandaEmailSimple(direccion,
                         If(lastErrorWrapperHttp Is Nothing, "<nadie>" & " en ", User.Identity.Name & " en ") & ConfigurationManager.AppSettings("ConfiguracionEmpresa") & " ProntoWeb" & ": " & lastErrorMessage,
                           Body,
                            ConfigurationManager.AppSettings("SmtpUser"),
                            ConfigurationManager.AppSettings("SmtpServer"),
                            ConfigurationManager.AppSettings("SmtpUser"),
                            ConfigurationManager.AppSettings("SmtpPass"),
                            iisNull(YSODmarkup, ""),
                            ConfigurationManager.AppSettings("SmtpPort"), , , )

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try






    End Sub




    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)

    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub

    'como modificar el sitemapnode programaticamente para los permisos
    'http://msdn.microsoft.com/en-us/library/ms178425.aspx
    'http://forums.asp.net/p/1221150/2179389.aspx    

    '      Private Function ExpandForumPaths(ByVal sender As Object, ByVal e As SiteMapResolveEventArgs) As SiteMapNode
    '    ' The current node represents a Post page in a bulletin board forum.
    '    ' Clone the current node and all of its relevant parents. This
    '    ' returns a site map node that a developer can then
    '    ' walk, modifying each node.Url property in turn.
    '    ' Since the cloned nodes are separate from the underlying
    '    ' site navigation structure, the fixups that are made do not
    '    ' effect the overall site navigation structure.
    '    Dim currentNode As SiteMapNode = SiteMap.CurrentNode.Clone(True)
    '    Dim tempNode As SiteMapNode = currentNode

    '    ' Obtain the recent IDs.
    '    Dim forumGroupID As Integer = GetMostRecentForumGroupID()
    '    Dim forumID As Integer = GetMostRecentForumID(forumGroupID)
    '    Dim postID As Integer = GetMostRecentPostID(forumID)

    '    ' The current node, and its parents, can be modified to include
    '    ' dynamic querystring information relevant to the currently
    '    ' executing request.
    '    If Not (0 = postID) Then
    '        tempNode.Url = tempNode.Url & "?PostID=" & postID.ToString()
    '    End If

    '    tempNode = tempNode.ParentNode
    '    If Not (0 = forumID) And Not (tempNode Is Nothing) Then
    '        tempNode.Url = tempNode.Url & "?ForumID=" & forumID.ToString()
    '    End If

    '    tempNode = tempNode.ParentNode
    '    If Not (0 = ForumGroupID) And Not (tempNode Is Nothing) Then
    '        tempNode.Url = tempNode.Url & "?ForumGroupID=" & forumGroupID.ToString()
    '    End If

    '    Return currentNode

    'End Function

    Protected Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As System.EventArgs)
        'http://stackoverflow.com/questions/1071095/asp-net-forms-authentication-auto-login-with-a-test-account-while-debugging
        'http://stackoverflow.com/questions/5966735/asp-net-site-auto-login-during-development

        'If System.Diagnostics.Debugger.IsAttached Then ' && User == null

        '    FormsAuthentication.SetAuthCookie("Mariano", False)
        'End If

    End Sub
</script>
