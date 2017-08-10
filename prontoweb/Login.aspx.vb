Imports Pronto.ERP.Bll
Imports System.Diagnostics 'para usar Debug.Print

Imports CartaDePorteManager

Imports System.Web.Services

Partial Class Login

    Inherits System.Web.UI.Page

    Public imgPath As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_header.jpg")
    Dim Williams As String
    'Public imgPath As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_headerliv2.jpg")

    'TODO: y si copias la onda del http://blog.pyrolupus.com/wp-login.php ?

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        'para saltar el login agrego este saltito
        'http://www.daniweb.com/forums/thread6028-8.html   
        '-Y cómo sabe la empresa???
        Dim _DEBUG As Boolean = False


        ''http://erlend.oftedal.no/blog/?blogid=55
        'If Request.IsAuthenticated And Not IsPostBack Then
        '    Response.Redirect("/NotAuthorized.aspx")
        'End If



        If Request.Browser("IsMobileDevice") = "true" Then
            'Response.Redirect("CartaDePorteInformesAccesoClientesMovil.aspx")
        End If






        If Not IsPostBack Then
            '///////////////////////////////////
            '///////////////////////////////////
            '///////////////////////////////////
            'PRIMERA VEZ QUE ABRE EL LOGIN
            '///////////////////////////////////
            '///////////////////////////////////
            '///////////////////////////////////




            'If session(SESSIONPRONTO_UserId) IsNot Nothing Then
            '    'ya sesión en marcha, que vaya a principal

            '    'Y la returnurl....

            '    Dim mu As MembershipUser
            '    FormsAuthentication.SetAuthCookie(usuario, False)
            '    mu = Membership.GetUser(usuario)

            '    'AddUserToSession()
            '    session(SESSIONPRONTO_UserId) = mu.ProviderUserKey.ToString
            '    session(SESSIONPRONTO_UserName) = mu.UserName

            '    pero por qué no figura en la session el usuario????
            '    'MsgBoxAjaxAndRedirect(Me, "Ya hay una sesión en marcha. Si quiere loguearse con otro usuario, cierre antes la sesión en marcha", "SeleccionarEmpresa.aspx")
            '    Response.Redirect("~/SeleccionarEmpresa.aspx")

            'End If



            'qué pasa si lo da por autenticado pero no está el UserId?
            Dim s As String = Request.QueryString("ReturnUrl")
            If InStr(s, ".jpg") = 0 And InStr(s, ".png") = 0 And InStr(s, ".css") = 0 And InStr(s, "TestCache") = 0 Then
                If s IsNot Nothing Then
                    Session(SESSIONPRONTO_MiRequestUrl) = s
                End If
            End If

            ConfiguracionDeLaEmpresa()
        End If

        Session(SESSIONPRONTO_SelectedIndexAnteriorDelAcordion) = Nothing


        Dim mensaje As String = ConfigurationManager.AppSettings("AvisoTipoDeSitioDesarrolloDebugTestReleaseExterno")
        If mensaje <> "" Then lblAvisoTipoDeSitio.Text = mensaje Else lblAvisoTipoDeSitio.Visible = False

        ' If Login1.FailureText="" then Login1.FailureText

        'If Not IsPostBack Then
        'Dim tb As TextBox = Me.Master.FindControl("TextBox3")
        Login1.Focus()
        'ScriptManager.GetCurrent(Me).SetFocus(tb)
        'End If

        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////
        'intercambiar cadenas de conexion
        'http://forums.asp.net/p/1381271/2922300.aspx#2922300

        'SC = ConfigurationManager.ConnectionStrings("VPN-BDL").ConnectionString

        'Dim a As New System.Configuration.ConnectionStringSettings
        'a = ConfigurationManager.ConnectionStrings("EnCASA")
        'a = ConfigurationManager.ConnectionStrings("VPN-BDL")
        'a.Name = "LocalSqlServer"
        'ConfigurationManager.ConnectionStrings.Add(a)
        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////



        Dim usuario As String
        Dim SC As String
        SC = ConexBDLmaster()

        lblMensajeErrorSuplementario.Text = Session("MensajeErrorLogin")
        Session("MensajeErrorLogin") = ""

        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////
        'If txtUserName.Text = "Test" Then
        'If _DEBUG Then




        If False And Debugger.IsAttached And ConfigurationManager.AppSettings("Debug") = "SI" Then ' Session("DebugPronto") <> "NO" Then ' And InStr(Encriptar(SC).ToUpper, "MARIANO") <> 0 Then

            'probar si conecta a la base, si no hacer como siempre

            Session("DebugPronto") = "SI"

            If True Or InStr(Encriptar(SC).ToUpper, "MARIANO") <> 0 Then
                usuario = "Mariano"
                ' usuario = "administrador" 'LeoAdmin!  base de casa
            Else
                usuario = "administrador" 'utecutec! base de BDL
            End If


            Dim mu As MembershipUser
            FormsAuthentication.SetAuthCookie(usuario, False)
            mu = Membership.GetUser(usuario)


            'AddUserToSession()
            Session(SESSIONPRONTO_UserId) = mu.ProviderUserKey.ToString
            Session(SESSIONPRONTO_UserName) = mu.UserName
            'Session("Empresas") = arrayEmpresas

            Dim idempresa = BDLMasterEmpresasManagerMigrar.IdEmpresaDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))

            Try

                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)
                'Dim usuario As Usuario = Nothing
                'usuario = New Usuario
                'usuario.UserId = session(SESSIONPRONTO_UserId)
                'usuario.Nombre = session(SESSIONPRONTO_UserName)
                'usuario.IdEmpresa = Convert.ToInt32(DDLEmpresas.SelectedValue)
                'usuario.Empresa = DDLEmpresas.SelectedItem.Text
                'usuario.StringConnection = GetConnectionString(usuario.UserId, usuario.IdEmpresa)
                'session(SESSIONPRONTO_USUARIO) = usuario

                'Response.Redirect("~/ProntoWeb/Principal.aspx")
                Dim lista As Pronto.ERP.BO.EmpresaList = EmpresaManager.GetEmpresasPorUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
                Session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion
                If (Request.QueryString("ReturnUrl") IsNot Nothing) Then
                    Response.Redirect(Request.QueryString("ReturnUrl"))
                ElseIf Not Request.Url.AbsoluteUri.ToLower.Contains("login.aspx") Then
                    Response.Redirect(Request.Url.AbsoluteUri)
                Else

                    Try
                        If Request.UrlReferrer Is Nothing Then Exit Try
                        If Not Request.UrlReferrer.AbsoluteUri.ToLower.Contains("login.aspx") Then Response.Redirect(Request.UrlReferrer.AbsoluteUri)
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try

                End If

                Exit Sub
                'Response.Redirect("~/SeleccionarEmpresa.aspx")


            Catch ex As Exception
                ErrHandler2.WriteError(ex)

            End Try

        Else
            Session("DebugPronto") = "NO"
        End If
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////


        Dim a = Roles.GetAllRoles()
        For Each i In a
            If i = "WilliamsAdmin" Then
                Return
            End If

        Next
        MandarMailDeError("Crear los roles de williams")
        Throw New ApplicationException("Crear los roles de williams")

        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////







    End Sub






  
    <WebMethod()> _
    <System.Web.Script.Services.ScriptMethod(ResponseFormat:=System.Web.Script.Services.ResponseFormat.Json)> _
    Public Shared Function LoginCookie(user As String, pass As String) As String
        'http://stackoverflow.com/questions/4939533/cookie-confusion-with-formsauthentication-setauthcookie-method
        'http://stackoverflow.com/questions/12840410/how-to-get-a-cookie-from-an-ajax-response
        'http://stackoverflow.com/questions/23109810/cant-retrieve-cookie-value-in-php-for-cookie-set-using-asp-net



        '/////////////////////////////////////////////////////////////////////////////////////////
        'configurar en el web.config!!!!!
        '/////////////////////////////////////////////////////////////////////////////////////////
        '<system.web>
        '       <httpCookies domain=".williamsentregas.com.ar"/>
        '</system.web>
        '
        'y esto:
        '
        '<httpProtocol>
        '  <customHeaders>
        '    <add name="Access-Control-Allow-Origin" value="*" />
        '    <add name="Access-Control-Allow-Headers" value="Content-Type" />
        '    <add name="Access-Control-Allow-Methods" value="GET, POST, PUT, DELETE, OPTIONS" />
        '  </customHeaders>
        '</httpProtocol>

        '/////////////////////////////////////////////////////////////////////////////////////////
        'y despues poniendo explicito todo en la llamada desde la pagina php (poniendo el dominio)

        'document.cookie = ".ASPXAUTH=40C9C30616F0BDA11B77ED39C12E716FCE37FCACDA845F257F65B3FF34EA6F209AE6D27D227CB86E9AC05E3623675505FDEF949A6D7AB108DC6BBDDF34A4D2F3B2E8B3086CD763AA9F4B0B63B658C2B2E3DA6FAC5951EB80F7639B926204FE1B092733D337E6385E5297BD40AC339CDFCE9B6700D861AFC580934F84D5FD6866E19D98D611C1114E66031E58ED0D685C;path=/; expires=Fri, 19 May 2017 19:59:57 GMT;domain=williamsentregas.com.ar"

        '/////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////////////////////////



        If Not Membership.ValidateUser(user, pass) Then Return "NO AUTENTICADO"


        Dim bRecordame As Boolean = False


        Dim t = FormsAuthentication.GetAuthCookie(user, bRecordame)
        t.Path = "\"
        t.Domain = "williamsentregas.com.ar"

        FormsAuthentication.SetAuthCookie(user, bRecordame, "\")


        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        'Quilombos con la session

        Dim mu As MembershipUser
        mu = Membership.GetUser(user)
        HttpContext.Current.Session(SESSIONPRONTO_UserId) = mu.ProviderUserKey.ToString
        HttpContext.Current.Session(SESSIONPRONTO_UserName) = mu.UserName

        'HttpContext.Current.Session(SESSIONPRONTO_glbIdUsuario) 'esto es el idempleado en la base elegida


        'el problema es q va a buscar datos de la session...  -el ID de la session tambien se manda por cookie

        Dim lista As Pronto.ERP.BO.EmpresaList
        'Como las conexiones del web.config que apuntan a la BDLmaster no estan encriptadas,
        'las encripto para que la capa inferior la use desencriptada cuando
        'cree que la encripta por primera vez
        Dim sConex As String
        sConex = ConexBDLmaster()
        lista = EmpresaManager.GetEmpresasPorUsuario(sConex, mu.ProviderUserKey.ToString)
        Dim usuario As Usuario = Nothing
        usuario = New Usuario
        usuario.UserId = mu.ProviderUserKey.ToString
        usuario.Nombre = mu.UserName
        usuario.IdEmpresa = 18
        If Debugger.IsAttached Then usuario.IdEmpresa = 52
        usuario.StringConnection = Encriptar(BDLMasterEmpresasManager.GetConnectionStringEmpresa(usuario.UserId, usuario.IdEmpresa, sConex, "XXXXXX"))

        HttpContext.Current.Session(SESSIONPRONTO_USUARIO) = usuario


        DatosDeSesion(usuario.StringConnection, usuario.Nombre, HttpContext.Current.Session, sConex, Nothing, usuario.IdEmpresa)
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////

        ' document.cookie = "cucu=2222;domain=.williamsentregas.com.ar;path=/"

        '//create a cookie
        Dim myCookie As HttpCookie = New HttpCookie("Holaaaa")
        '//Add key-values in the cookie
        myCookie.Values.Add("trulala", "lalalalal")
        '//set cookie expiry date-time. Made it to last for next 12 hours.
        myCookie.Expires = DateTime.Now.AddHours(12)

        myCookie.Domain = "williamsentregas.com.ar"
        myCookie.Path = "/"
        '//Most important, write the cookie to client.
        HttpContext.Current.Response.Cookies.Add(myCookie)

        HttpContext.Current.Response.Cookies.Add(t)




        If False Then
            'si es Tomás Williams, reducir el timeout
            Dim expira As Date
            If user = "twilliams2" Then
                expira = DateTime.Now.AddMinutes(3)
            Else
                expira = DateTime.Now.AddDays(15)
            End If

            '// http://stackoverflow.com/questions/13276368/asp-net-mvc-4-custom-authorization-ticket-redirect-issue
            Dim authTicket As FormsAuthenticationTicket = New  _
                     FormsAuthenticationTicket(1, _
                     user, _
                     DateTime.Now, _
                     expira, _
                     True, _
                       "")

            Dim ck As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, _
                            FormsAuthentication.Encrypt(authTicket))
            ck.Path = FormsAuthentication.FormsCookiePath

            'ck.Value

            HttpContext.Current.Response.Cookies.Add(ck)
        End If


        'HttpContext.Current.Response.AppendHeader("Access-Control-Allow-Origin", "*") 'no lo repitas aca si esta en el web.config



        Return t.Value

    End Function







    Sub ConfiguracionDeLaEmpresa()

        '

        'http://www.vbdotnetforums.com/graphics-gdi/22004-how-can-i-transparent-image-picture-box.html
        'Dim bmp As New Bitmap(My.Resources.lite1)
        'bmp.MakeTransparent(Color.Blue)
        'PictureBox1.Image = bmp

        'http://msdn.microsoft.com/en-us/library/ms172507.aspx


        'If Session("IdEmpresa") Is Nothing Then
        '    'LogoImage.ImageUrl = "~/Imagenes/icon_biggrin.gif" ' 
        '    LogoImage.ImageUrl = "~/Imagenes/0bak.gif" '"~/Imagenes/0.jpg"
        '    LogoImage.ImageUrl = "~/Imagenes/williams.gif" '"~/Imagenes/0.jpg"
        'Else
        '    LogoImage.ImageUrl = String.Format("~/Imagenes/{0}.jpg", Session("IdEmpresa"))
        'End If


        LogoImage.ImageUrl = BDLMasterEmpresasManagerMigrar.SetLogoImage_LoginPage(ConexBDLmaster())



        PanelEsuco.Visible = False
        PanelBDL.Visible = False
        PanelWilliams.Visible = False
        PanelAutotrol.Visible = False

        Select Case ConfigurationManager.AppSettings("ConfiguracionEmpresa")

            Case "Williams"
                PanelWilliams.Visible = True

            Case "Esuco"
                PanelEsuco.Visible = True

            Case "Autotrol"
                PanelAutotrol.Visible = True

            Case Else
                PanelBDL.Visible = True

        End Select

    End Sub

    Protected Sub Login1_LoggedIn(ByVal sender As Object, ByVal e As System.EventArgs) Handles Login1.LoggedIn

        '////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////
        'DestinationPageUrl (propiedad del control login en el markup) dice a dónde 
        'se va despues de loguearse (al terminar esta funcion). Es SeleccionarEmpresa.aspx donde se ve 
        'si tiene una o más empresas asignadas
        '////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////

        Dim ms As String

        Try
            ms = AddUserToSession()
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            ms = "No se pudo conectar a la BDLmaster." & ex.ToString
            'MsgBoxAlert("No se pudo conectar a la BDLmaster." & ex.ToString)
            Response.Write(ms)
            lblMensajeErrorSuplementario.Text = ms
            Session("MensajeErrorLogin") = ms
            Exit Sub
        End Try





        If ms <> "" Then
            'MsgBoxAlert(ms)
            'forzar error de login
            Response.Write(ms)
            lblMensajeErrorSuplementario.Text = ms
            Session("MensajeErrorLogin") = ms
            Return
        Else
            lblMensajeErrorSuplementario.Text = ""
        End If





        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        'persistencia del ticket igual que lo tengo en mvc
        '////////////////////////////////////////
        '////////////////////////////////////////
        'FormsAuthentication.Initialize();




        FormsAuthentication.SetAuthCookie(Session(SESSIONPRONTO_UserName), Login1.RememberMeSet)



        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


        '        'ojo si te está pasando lo de que te patea el login!!!
        '        si, un solo proceso
        'luciano me aseguro que los workers comparten las sesiones, con lo cual si una sesion pasa de un worker al otro deberia ser transparente
        '        Mariano Scalella
        '        mirate esto
        '   Having multiple worker processes and using InProc does not seem to be compatible.
        '        See this
        'If you enable Web-garden mode by setting the webGarden attribute to true in the processModel element of the application's Web.config file, do not use InProc session state mode. If you do, data loss can occur if different requests for the same session are served by different worker processes.22:28
        'y estamos usando el InProc
        '            Andrés Gurisatti
        'si, lo lei recien}
        '            Mariano Scalella
        'usemos un rato un solo proceso. ahora lo pongo
        '            Andrés Gurisatti
        'aca tambien hay info de eso en los comentarios
        'http://stackoverflow.com/questions/2151251/asp-net-web-garden-how-many-worker-processes-do-i-need
        '@AkashKava: InProc session state, which is the default, is not shared between worker processes. The only way to share it is if you are using out-of-process session state. Which means that you must have a session state server configured.
        '            Mariano Scalella
        'jaj yo estaba en esta  http://stackoverflow.com/questions/2147578/asp-net-session-state-and-multiple-worker-processes
        '            Andrés Gurisatti
        'avisame cuando lo dejes como antes, asi voy probandolo con vos
        '            Mariano Scalella
        'bueno ahi estan todos los pools con 1 solo proceso, reinicie
        '            Andrés Gurisatti
        'pinta mejor ahora. voy a probarlo unos 10 minutos antes de avisarles nada
        '            Mariano Scalella
        ' tiene buena pinta toquemos madera
        'por ahora todo bien aca
        '            Andrés Gurisatti
        'si, yo tambien, inclusive saque grandes reportes y me envie mails
        'y todo bien por ahora
        '            Mariano Scalella
        'mandale un mail a luciano para q no cambie este asunto
        '            Andrés Gurisatti
        'si, ya voy a avisarle a todos y le voy a mandar un correo a luciano
        '            Mariano Scalella
        'menos mal q tuviste la corazonada sino no se 
        '            Andrés Gurisatti
        'jaja, todo el finde largo luchando con esto. igual me voy a quedar atento estos dias
        '            Mariano Scalella
        'llamame al cel si no reacciono por aca
        '            Andrés Gurisatti
        '            dale()
        'gracias mariano, ojala no tenga que joderte.
        '            buen finde
        '            Mariano Scalella
        'felices pascuas la casa esta en orden
        '            Andrés Gurisatti
        '            jaja()
        '            Mariano Scalella
        '            se vemo

        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        'si es Tomás Williams, reducir el timeout
        Dim expira As Date
        If Session(SESSIONPRONTO_UserName) = "twilliams2" Then
            expira = DateTime.Now.AddMinutes(3)
        Else
            expira = DateTime.Now.AddDays(15)
        End If




        '// http://stackoverflow.com/questions/13276368/asp-net-mvc-4-custom-authorization-ticket-redirect-issue
        Dim authTicket As FormsAuthenticationTicket = New  _
                 FormsAuthenticationTicket(1, _
                 Session(SESSIONPRONTO_UserName), _
                 DateTime.Now, _
                 expira, _
                 True, _
                   "")





        Dim ck As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, _
                        FormsAuthentication.Encrypt(authTicket))
        ck.Path = FormsAuthentication.FormsCookiePath
        Response.Cookies.Add(ck) 'quizas se está perdiendo al hacer redirects o al cambiar la destinationpage del login o algo... 
        '-no uses el destinationpage. directamente usa el redirect
        'http://msdn.microsoft.com/es-AR/library/system.web.security.formsauthentication.getredirecturl.aspx
        If Session(SESSIONPRONTO_UserName) = "Mariano" And False Then

            Dim conexbase = BDLMasterEmpresasManagerMigrar.ConexionDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
            Dim idempresa = BDLMasterEmpresasManagerMigrar.IdEmpresaDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
            Dim lista As Pronto.ERP.BO.EmpresaList = EmpresaManager.GetEmpresasPorUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
            Session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion
            BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)


            Response.Redirect(FormsAuthentication.GetRedirectUrl(Session(SESSIONPRONTO_UserName), Login1.RememberMeSet))
            Exit Sub
        End If



        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////
        '////////////////////////////////////////


        If Session(SESSIONPRONTO_MiRequestUrl) = "" And Not Request.UrlReferrer.AbsoluteUri.ToLower.Contains("login.aspx") Then
            'Session(SESSIONPRONTO_MiRequestUrl) = Request.UrlReferrer.AbsoluteUri 'tenes que mandar la conexion a la Session, si no no sabe
        End If






        'Tratando evitar los loop redirect y ERR_TOO_MANY_REDIRECTS de Chrome
        If BDLMasterEmpresasManagerMigrar.ElUsuarioTieneUnaSolaEmpresa(ConexBDLmaster, Session(SESSIONPRONTO_UserId)) Then

            Dim conexbase = BDLMasterEmpresasManagerMigrar.ConexionDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
            Dim idempresa = BDLMasterEmpresasManagerMigrar.IdEmpresaDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))

            Dim lista As Pronto.ERP.BO.EmpresaList = EmpresaManager.GetEmpresasPorUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
            Session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion

            If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(conexbase) = "Williams" Then
                'Server.Transfer(String.Format("CartasDePortes.aspx?tipo=Descargas"))
                If Session(SESSIONPRONTO_MiRequestUrl) <> "" Then
                    Login1.DestinationPageUrl = Session(SESSIONPRONTO_MiRequestUrl)
                ElseIf Not Request.UrlReferrer.AbsoluteUri.ToLower.Contains("login.aspx") Then
                    Login1.DestinationPageUrl = Request.UrlReferrer.AbsoluteUri
                Else
                    Login1.DestinationPageUrl = "~/ProntoWeb/CartasDePortes.aspx?tipo=Todas"
                End If

                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)

                Try
                    Dim rol = Roles.GetRolesForUser(Session(SESSIONPRONTO_UserName))
                    If rol(0) = "Cliente" Or rol(0) = "WilliamsClientes" Then Login1.DestinationPageUrl = "~/ProntoWeb/CartaDePorteInformesAccesoClientes.aspx"
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


                Return
            Else

                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)


                If Session(SESSIONPRONTO_MiRequestUrl) <> "" Then
                    Login1.DestinationPageUrl = Session(SESSIONPRONTO_MiRequestUrl)
                Else
                    Login1.DestinationPageUrl = "~/ProntoWeb/Principal.aspx"
                End If

            End If
        End If



        '////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////

        Dim temp As String
        Dim empresa As String


        'Cómo hacer para redirigir después del login?
        'http://www.velocityreviews.com/forums/t113819-how-to-redirect-to-a-requested-page-instead-of-default-page-after-login.html
        'Acá puedo llegar desde el Load de un ABM, que tendrá la gentileza de guardarme, en una 
        'variable del session, la URL original


        'Describir cada caso, porque así es un caos
        If Request.QueryString("ReturnUrl") IsNot Nothing And Session(SESSIONPRONTO_MiRequestUrl) <> "" Then
            'CASO 1

            temp = Session(SESSIONPRONTO_MiRequestUrl)
            If InStr(Session(SESSIONPRONTO_MiRequestUrl), "empresa=") > 0 Then
                empresa = Mid(Session(SESSIONPRONTO_MiRequestUrl), InStr(Session(SESSIONPRONTO_MiRequestUrl), "empresa=") + 8)
            End If
            Session(SESSIONPRONTO_MiRequestUrl) = ""


            If empresa = "" Then
                Response.Redirect("~/SeleccionarEmpresa.aspx")
            Else

                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(Request.QueryString("Empresa"), Session, ConexBDLmaster, Me)

                Response.Redirect(Request.QueryString("ReturnUrl"))
            End If

        ElseIf Session(SESSIONPRONTO_MiRequestUrl) IsNot Nothing And Session(SESSIONPRONTO_MiRequestUrl) <> "" Then
            'CASO 2

            temp = Session(SESSIONPRONTO_MiRequestUrl)
            empresa = Mid(Session(SESSIONPRONTO_MiRequestUrl), InStr(Session(SESSIONPRONTO_MiRequestUrl), "empresa=") + 8)
            Session(SESSIONPRONTO_MiRequestUrl) = ""
            If empresa = "" Then
                Response.Redirect("~/SeleccionarEmpresa.aspx")
            Else
                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(empresa, Session, ConexBDLmaster, Me)

                Debug.Print(temp)
                Response.Redirect(temp) 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion
            End If
            'Response.Redirect("presupuesto.aspx?id=65&empresa=marcalba") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion
            'Response.Redirect("~/presupuesto.aspx?id=65&empresa=marcalba") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion
            'Response.Redirect("~/prontoweb/presupuesto.aspx?id=65&empresa=marcalba") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion

            'Debug.Print(ex.ToString)
            'ProntoFuncionesUIWeb.Current_Alert("La URL no incluía la empresa")
            'Response.Redirect("SeleccionarEmpresa.aspx") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion

        ElseIf Request.QueryString("ReturnUrl") IsNot Nothing AndAlso Request.QueryString("ReturnUrl") <> "" Then
            'CASO 3
            Debug.Print(Session(SESSIONPRONTO_MiRequestUrl))

            'temp = Request.RawUrl.ToLower
            temp = Request.QueryString("ReturnUrl")
            empresa = Request.QueryString("Empresa")
            Session(SESSIONPRONTO_MiRequestUrl) = ""
            If empresa = "" Then
                Response.Redirect("~/SeleccionarEmpresa.aspx")
            Else
                BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(empresa, Session, ConexBDLmaster, Me)

                Debug.Print(temp)
                Response.Redirect(temp) 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion
            End If

            'Debug.Print(ex.ToString)
            'ProntoFuncionesUIWeb.Current_Alert("La URL no incluía la empresa")
            'Response.Redirect("SeleccionarEmpresa.aspx") 'no usar Redirect dentro de un try Catch, porque siempre tira excepcion



        Else
            'CASO 4
            'Response.Redirect("default.aspx")


            'BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(empresa, Session, ConexBDLmaster, Me)
            Session(SESSIONPRONTO_MiRequestUrl) = ""
        End If



        'Tratando evitar los loop redirect y ERR_TOO_MANY_REDIRECTS de Chrome
        If BDLMasterEmpresasManagerMigrar.ElUsuarioTieneUnaSolaEmpresa(ConexBDLmaster, Session(SESSIONPRONTO_UserId)) Then

            ' If Session(SESSIONPRONTO_UserName) = "Mariano" Then Login1.DestinationPageUrl = "CartasDePortes.aspx?tipo=Todas"

            If empresa = "Williams" Then
                'Server.Transfer(String.Format("CartasDePortes.aspx?tipo=Descargas"))
                Login1.DestinationPageUrl = "CartasDePortes.aspx?tipo=Todas"
            End If
            Return

            If empresa = Williams Then

            Else
                Login1.DestinationPageUrl = "~/ProntoWeb/Principal.aspx"
            End If
        End If


        '////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////
        'DestinationPageUrl (propiedad del control login en el markup) dice a dónde 
        'se va despues de loguearse (al terminar esta funcion). Es SeleccionarEmpresa.aspx donde se ve 
        'si tiene una o más empresas asignadas
        '////////////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////////////

    End Sub



    Function AddUserToSession() As String
        Dim mu As MembershipUser
        mu = Membership.GetUser(Login1.UserName)
        Session(SESSIONPRONTO_UserId) = mu.ProviderUserKey.ToString
        Session(SESSIONPRONTO_UserName) = mu.UserName

        Dim lista As Pronto.ERP.BO.EmpresaList

        'Como las conexiones del web.config que apuntan a la BDLmaster no estan encriptadas,
        'las encripto para que la capa inferior la use desencriptada cuando
        'cree que la encripta por primera vez
        Dim sConex As String
        sConex = ConexBDLmaster()
        lista = EmpresaManager.GetEmpresasPorUsuario(sConex, mu.ProviderUserKey.ToString)
        If lista Is Nothing Then
            'forzar error del login
            If False Then
                Return "El usuario " & Session(SESSIONPRONTO_UserName) & " no tiene asignada ninguna empresa. Contacte al Administrador del sistema"
            End If
        Else
            Dim arrayEmpresas(lista.Count - 1) As Integer
            For i As Integer = 0 To lista.Count - 1
                arrayEmpresas(i) = lista(i).Id
            Next
            Session("Empresas") = arrayEmpresas
        End If



        Return ""
    End Function




    Protected Sub Login1_LoginError(ByVal sender As Object, ByVal e As System.EventArgs) Handles Login1.LoginError

        'http://forums.asp.net/p/1568846/3927005.aspx

        '//InvalidCredentialsLogDataSource.InsertParameters("ApplicationName").DefaultValue = Membership.ApplicationName;

        '//InvalidCredentialsLogDataSource.InsertParameters("UserName").DefaultValue = Login1.UserName;

        '//InvalidCredentialsLogDataSource.InsertParameters("IPAddress").DefaultValue = Request.UserHostAddress;



        '//The password is only supplied if the user enters an invalid username or invalid password - set it to Nothing, by default

        '// InvalidCredentialsLogDataSource.InsertParameters("Password").DefaultValue = null;



        '//There was a problem logging in the user

        '//See if this user exists in the database

        Try


            Dim userInfo As MembershipUser = Membership.GetUser(Login1.UserName)

            If IsNothing(userInfo) Then



                '//The user entered an invalid username...

                Login1.FailureText = "El usuario no existe " + Login1.UserName

                'LoginErrorDetails.Text = "There is no user in the database with the username " + Login1.UserName
                'emailerror.Visible = True
                'lnkResendActivation.Visible = False


                '//The password is only supplied if the user enters an invalid username or invalid password

                '//InvalidCredentialsLogDataSource.InsertParameters("Password").DefaultValue = Login1.Password;



            Else


                '//See if the user is locked out or not approved



                If Not userInfo.IsApproved Then


                    If userInfo.LastLoginDate = userInfo.CreationDate Then

                        Login1.FailureText = "Your account has not yet been activated.Please activate your account.If you did not get confirmation mail than"

                        'LoginErrorDetails.Text = "Your account has not yet been activated.Please activate your account.If you did not get confirmation mail than"
                        'emailerror.Visible = True
                        'lnkResendActivation.Visible = True

                    Else

                        Login1.FailureText = "Your account has been terminated."

                        'LoginErrorDetails.Text = "Your account has been terminated."
                        'emailerror.Visible = True
                        'lnkResendActivation.Visible = False


                    End If

                ElseIf (userInfo.IsLockedOut) Then

                    'Login1.FailureText = "Your account has been locked out because of a maximum number of incorrect login attempts. You will NOT be able to login until you contact a site administrator and have your account unlocked."
                    Login1.FailureText = "Tu cuenta fue bloqueada por motivos de seguridad. Contactá al administrador"

                    'LoginErrorDetails.Text = "Your account has been locked out because of a maximum number of incorrect login attempts. You will NOT be able to login until you contact a site administrator and have your account unlocked."
                    'emailerror.Visible = True
                    'lnkResendActivation.Visible = False






                Else

                    'http://forums.asp.net/t/1589407.aspx 'no está mostrando el mensaje de error

                    ' //The password was incorrect (don't show anything, the Login control already describes the problem)

                    Login1.FailureText = "El usuario o la contraseña son incorrectos" 'Your login attempt was not successful. Please try again."
                    'LoginErrorDetails.Text = "Your login attempt was not successful. Please try again."
                    'emailerror.Visible = True
                    'lnkResendActivation.Visible = False

                    '//The password is only supplied if the user enters an invalid username or invalid password

                    '//InvalidCredentialsLogDataSource.InsertParameters("Password").DefaultValue = Login1.Password;
                    'Return False
                End If



            End If

        Catch ex As Exception


            Throw New Exception(ex.ToString)



        End Try



        '//Add a new record to the InvalidCredentialsLog table

        '// InvalidCredentialsLogDataSource.Insert();
    End Sub
End Class