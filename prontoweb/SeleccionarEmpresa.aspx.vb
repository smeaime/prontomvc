Imports System
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics

Imports CartaDePorteManager



Partial Class SeleccionarEmpresa
    Inherits System.Web.UI.Page
    Private SC As String

    Public imgPath As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_header.jpg")


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'hacer que se elija automaticamente el primero

        If Not Page.IsPostBack Then
            'Primera carga

            SC = ConexBDLmaster()
            'HFSC.Value = SC
            ViewState("SC") = SC 'Parece que no le gusta guardar algunos caracteres en el hidden field. Parece
            'que voy a tener que dejar de usarlo, ahora que la cadena está encriptada.



            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////
            'Dim Usuario = New Usuario
            'Usuario = session(SESSIONPRONTO_USUARIO)

            If False Then
                If Not Request.IsAuthenticated And Session(SESSIONPRONTO_UserId) Is Nothing Then
                    'qué pasó?
                    ErrHandler2.WriteError("Está autenticado y no hay UserId?")
                    'http://forums.asp.net/t/1260615.aspx/1
                    FormsAuthentication.SignOut()
                    Response.Redirect(FormsAuthentication.LoginUrl)
                    Return
                End If

                If Session(SESSIONPRONTO_UserId) Is Nothing Then
                    'qué pasó?
                    ErrHandler2.WriteError("Está autenticado y no hay UserId?")
                    'http://forums.asp.net/t/1260615.aspx/1
                    FormsAuthentication.SignOut()
                    Response.Redirect(FormsAuthentication.LoginUrl)
                    Return
                End If

                If Not Request.IsAuthenticated Then
                    'qué pasó?
                    ErrHandler2.WriteError("Está autenticado y no hay UserId?")
                    'http://forums.asp.net/t/1260615.aspx/1
                    FormsAuthentication.SignOut()
                    Response.Redirect(FormsAuthentication.LoginUrl)
                    Return
                End If
            End If

            ''que pasa si el usuario es Nothing? Qué se rompió? Y qué pasa si YA ESTA autenticado y solo falta el UserId,
            ''y el Login lo da por aceptado y se produce lo del bucle de redireccionamiento?
            'If Usuario Is Nothing Then
            '    Response.Redirect(String.Format("../Login.aspx"))
            'End If


            ErrHandler2.WriteError("sesion: " & Session(SESSIONPRONTO_UserName) & " " & Request.IsAuthenticated)

            If Membership.GetUser IsNot Nothing Then
                ErrHandler2.WriteError("Pasa nomas. membership: " & Membership.GetUser.UserName)
            Else
                'me está pasando cuando ANDREOLI está logueado en prontoclientes, y aparece en prontoweb
                ErrHandler2.WriteError("No hay usuario membership!!! echemoslo")

                ' verificá el <httpCookies domain=".williamsentregas.com.ar"/> para q todos los cookies se generen en el mismo dominio

                'https://stackoverflow.com/questions/412300/formsauthentication-signout-does-not-log-the-user-out
                FormsAuthentication.SignOut()
                Session.Abandon()

                '// clear authentication cookie
                Dim cookie1 As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, "")
                cookie1.Expires = DateTime.Now.AddYears(-1)
                Response.Cookies.Add(cookie1)

                '// clear session cookie (Not necessary for your current problem but i would recommend you do it anyway)
                Dim sessionStateSection As System.Web.Configuration.SessionStateSection = System.Web.Configuration.WebConfigurationManager.GetSection("system.web/sessionState")
                Dim cookie2 As HttpCookie = New HttpCookie(sessionStateSection.CookieName, "")
                cookie2.Expires = DateTime.Now.AddYears(-1)
                Response.Cookies.Add(cookie2)

                FormsAuthentication.RedirectToLoginPage()
                Return
            End If







            Try



                If Session(SESSIONPRONTO_UserName) <> Membership.GetUser.UserName Then
                    Dim mu As MembershipUser
                    mu = Membership.GetUser(Membership.GetUser.UserName)
                    Session(SESSIONPRONTO_UserId) = mu.ProviderUserKey.ToString
                    Session(SESSIONPRONTO_UserName) = mu.UserName

                    'AddUserToSession()
                    'Throw New Exception("ojo, que en el session(SESSIONPRONTO_UserId) te puede quedar un usuario distinto que en el membership!!!!")

                End If

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            'If Membership.GetUser Is Nothing Then
            '    Session(SESSIONPRONTO_UserName) = "SINUSUARIO"
            'End If
            '//////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////



            HFIdUser.Value = Session(SESSIONPRONTO_UserId) 'DirectCast(session(SESSIONPRONTO_USUARIO), Usuario).UserId




            '///////////////////////////////////////////////
            '///////////////////////////////////////////////
            'Cuantas empresas tiene asignadas?




            DDLEmpresas.DataSource = EmpresaManager.GetEmpresasPorUsuario(SC, Session(SESSIONPRONTO_UserId))
            DDLEmpresas.DataTextField = "Descripcion"
            DDLEmpresas.DataValueField = "Id"
            DDLEmpresas.DataBind()

            If BDLMasterEmpresasManagerMigrar.ElUsuarioTieneUnaSolaEmpresa(ConexBDLmaster, Session(SESSIONPRONTO_UserId)) Then

                Dim conexbase = BDLMasterEmpresasManagerMigrar.ConexionDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))
                Dim idempresa = BDLMasterEmpresasManagerMigrar.IdEmpresaDeLaUnicaBaseDelUsuario(ConexBDLmaster, Session(SESSIONPRONTO_UserId))


                If Request.QueryString("ReturnUrl") IsNot Nothing Then Response.Redirect(Request.QueryString("ReturnUrl"))


                If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(conexbase) = "Williams" Then
                    'Server.Transfer(String.Format("CartasDePortes.aspx?tipo=Descargas"))
                    Server.Transfer("~/ProntoWeb/CartasDePortes.aspx?tipo=Todas")
                    BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)
                    Return
                ElseIf BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(conexbase) = "Autotrol" Then
                    'Server.Transfer(String.Format("CartasDePortes.aspx?tipo=Descargas"))
                    Server.Transfer("~/ProntoWeb/RequerimientosB.aspx?tipo=Todas")
                    BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(idempresa, Session, ConexBDLmaster, Me)
                    Return

                Else
                    Server.Transfer("~/ProntoWeb/Principal.aspx")
                    Return
                End If
            End If



            PanelInfo.Visible = False

            DDLEmpresas.Focus()

            Dim bMeterseDirectoEnLaPrimeraEmpresa As Boolean = True 'False
            'If Debugger.IsAttached Then bMeterseDirectoEnLaPrimeraEmpresa = True

            Dim UsuarioExiste As Boolean
            Dim lista As EmpresaList = EmpresaManager.GetEmpresasPorUsuario(SC, Session(SESSIONPRONTO_UserId))

            If lista Is Nothing Then
                SinEmpresaAsignada()
            ElseIf lista.Count = 0 Then 'por qué lo pongo en otro if?
                SinEmpresaAsignada()
            ElseIf lista.Count = 1 Then 'si solo tiene una empresa 
                'si solo tiene una empresa o se loguea por primera vez, que vaya directo

                'DDLEmpresas.SelectedIndex = 0
                'AddUserToSession()



                Session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion


                Try
                    UsuarioExiste = BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(lista.Item(0).Id, Session, SC, Me)
                Catch ex As Exception
                    'si hubo un problema conectandose con la base, probar ir directo a modo administrador 
                    ErrHandler2.WriteError(ex)
                    Session(SESSIONPRONTO_NombreEmpresa) = ""
                    If EstaEsteRol("Administrador") Then
                        MsgBoxAjaxAndRedirect(Me, "No se pudo conectar a la base. Se continuará sin base asignada. " & ex.ToString, "ProntoWeb/Principal.aspx")

                        'Response.Redirect("~/ProntoWeb/Principal.aspx")
                    Else
                        MsgBoxAlert("No se pudo conectar a la base.  Consulte con el Administrador")
                    End If
                    Exit Sub
                End Try


                If Not UsuarioExiste Then
                    MsgBoxAjaxAndRedirect(Me, "No se pudo conectar a la base. Se continuará sin base asignada. ", "ProntoWeb/Principal.aspx")
                    Return
                    'Response.Redirect("~/ProntoWeb/Principal.aspx")
                    'DisplayAlertAndThenRedirect
                End If


                If EstaEsteRol("Cliente") And False Then
                    'el proveedor no debe ver el mapa...
                    Response.Redirect("~/ProntoWeb/Presupuestos.aspx?tipo=AConfirmarEnObra.aspx")
                Else
                    'Server.Transfer(String.Format("~/ProntoWeb/CartasDePortes.aspx?tipo=Descargas"))
                    Server.Transfer("~/ProntoWeb/Principal.aspx")
                    'Response.Redirect("~/ProntoWeb/Principal.aspx")
                End If

            ElseIf False Then
                'que se meta en la ultima que se metio




            ElseIf Session(SESSIONPRONTO_NombreEmpresa) <> "" Then

                If True Then
                    Try
                        'UsuarioExiste = BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(lista.Item(0).Id, Session, SC, Me)
                        UsuarioExiste = BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(Session(SESSIONPRONTO_NombreEmpresa), Session, SC, Me)
                    Catch ex As Exception
                        'si hubo un problema conectandose con la base, probar ir directo a modo administrador 
                        ErrHandler2.WriteError(ex)
                        Session(SESSIONPRONTO_NombreEmpresa) = ""
                        If EstaEsteRol("Administrador") Then
                            MsgBoxAjaxAndRedirect(Me, "No se pudo conectar a la base. Se continuará sin base asignada. " & ex.ToString, "ProntoWeb/Principal.aspx")

                            'Response.Redirect("~/ProntoWeb/Principal.aspx")
                        Else
                            MsgBoxAlert("No se pudo conectar a la base.  Consulte con el Administrador")
                        End If
                        Exit Sub
                    End Try

                    If Not UsuarioExiste Then
                        MsgBoxAjaxAndRedirect(Me, "No se pudo conectar a la base. Se continuará sin base asignada. ", "ProntoWeb/Principal.aspx")
                        Return
                        'Response.Redirect("~/ProntoWeb/Principal.aspx")
                        'DisplayAlertAndThenRedirect
                    End If


                    If EstaEsteRol("Cliente") And False Then
                        'el proveedor no debe ver el mapa...
                        Server.Transfer("~/ProntoWeb/Presupuestos.aspx?tipo=AConfirmarEnObra.aspx")
                    Else

                        If Session(SESSIONPRONTO_MiRequestUrl) <> "" Then
                            Server.Transfer(Session(SESSIONPRONTO_MiRequestUrl))
                        Else
                            Server.Transfer("~/ProntoWeb/Principal.aspx")
                        End If

                    End If

                End If


            ElseIf bMeterseDirectoEnLaPrimeraEmpresa And If(Session(SESSIONPRONTO_NombreEmpresa), "") = "" And Session("SaltarSeleccionarEmpresa") <> "NO" Then
                'si tiene mas de una empresa o se loguea por segunda vez, que vaya directo

                Session(SESSIONPRONTO_NombreEmpresa) = BDLMasterEmpresasManagerMigrar.GetUltimaBaseQueAccedioUsuario(Session(SESSIONPRONTO_UserId))

                If False Then
                    If Session(SESSIONPRONTO_NombreEmpresa) = "" Then Session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion
                Else

                    Dim f As Boolean = False
                    For n = 0 To lista.Count - 1
                        If Session(SESSIONPRONTO_NombreEmpresa) = lista(n).Descripcion Then
                            f = True
                            Exit For
                        End If
                    Next
                    If Not f Then Session(SESSIONPRONTO_NombreEmpresa) = lista(0).Descripcion
                End If

                Session("SaltarSeleccionarEmpresa") = ""

                Try
                    'UsuarioExiste = BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(lista.Item(0).Id, Session, SC, Me)
                    UsuarioExiste = BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(Session(SESSIONPRONTO_NombreEmpresa), Session, SC, Me)
                Catch ex As Exception
                    'si hubo un problema conectandose con la base, probar ir directo a modo administrador 
                    ErrHandler2.WriteError(ex)
                    Session(SESSIONPRONTO_NombreEmpresa) = ""
                    If EstaEsteRol("Administrador") Then
                        MsgBoxAjaxAndRedirect(Me, "No se pudo conectar a la base. Se continuará sin base asignada. " & ex.ToString, "ProntoWeb/Principal.aspx")

                        'Response.Redirect("~/ProntoWeb/Principal.aspx")
                    Else
                        MsgBoxAlert("No se pudo conectar a la base.  Consulte con el Administrador")
                    End If
                    Exit Sub
                End Try

                If Not UsuarioExiste Then
                    MsgBoxAjaxAndRedirect(Me, "No se pudo conectar a la base. Se continuará sin base asignada. ", "ProntoWeb/Principal.aspx")
                    Return
                    'Response.Redirect("~/ProntoWeb/Principal.aspx")
                    'DisplayAlertAndThenRedirect
                End If


                If EstaEsteRol("Cliente") And False Then
                    'el proveedor no debe ver el mapa...
                    Server.Transfer("~/ProntoWeb/Presupuestos.aspx?tipo=AConfirmarEnObra.aspx")
                Else


                    If Session(SESSIONPRONTO_MiRequestUrl) <> "" Then
                        Server.Transfer(Session(SESSIONPRONTO_MiRequestUrl))
                    Else
                        Server.Transfer("~/ProntoWeb/Principal.aspx")
                    End If




                End If

            End If
            '///////////////////////////////////////////////
            '///////////////////////////////////////////////


            DDLEmpresas.SelectedIndex = 0


            'como tiene más de una empresa, tiene que elegir del combo
        End If
    End Sub



    Sub SinEmpresaAsignada() 'no tiene empresas asignadas, pero quizas es un admin
        'verifico si es administrador
        If EstaEsteRol("Administrador") Then
            MsgBoxAlert("Este usuario administrador no tiene asignada ninguna empresa. Se continuará sin base asignada")
            Response.Redirect("~/ProntoWeb/Principal.aspx")
        End If

        'no es administrador
        MsgBoxAlert("El usuario no tiene asignada ninguna empresa. Consulte con el Administrador")
    End Sub


    Protected Sub ButContinuar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButContinuar.Command

        ' le exploto a andy porque no eligió seguramente empresa en el listbox???
        'y lo peor es que en la pantalla de error, te redirige a la principal, que explota nuevamente, y no podes escapar!!!!!!

        'agregar logout a la pantalla de error

        If DDLEmpresas.SelectedItem Is Nothing Then
            MsgBoxAlert("Elegí una empresa")
            Return
        End If

        Try

            If BDLMasterEmpresasManagerMigrar.AddEmpresaToSession(DDLEmpresas.SelectedValue, Session, ViewState("SC"), Me) Then
                Session(SESSIONPRONTO_NombreEmpresa) = DDLEmpresas.SelectedItem.Text  'item("Descripcion")


                BDLMasterEmpresasManagerMigrar.SetUltimaBaseQueAccedioUsuario(Session(SESSIONPRONTO_UserId), Session(SESSIONPRONTO_NombreEmpresa))
                BDLMasterEmpresasManagerMigrar.UltimaVezAccedida(Session(SESSIONPRONTO_UserId), Session(SESSIONPRONTO_NombreEmpresa)) = Now




                If Request.QueryString("ReturnUrl") IsNot Nothing Then Response.Redirect(Request.QueryString("ReturnUrl"))




                If EstaEsteRol("Cliente") And False Then
                    'el proveedor no debe ver el mapa...
                    Response.Redirect("~/ProntoWeb/Presupuestos.aspx?tipo=AConfirmarEnObra.aspx")
                Else

                    Response.Redirect("~/ProntoWeb/Principal.aspx")
                End If
            Else
                'lo bochó, probablemente porque en la Session no está UserId. Pero cómo, si ya está autenticado?

                'está el usuario en la empresa? qué pasó? -lo bocha porque el usuario no está en la empresa. loguearlo igual

                MsgBoxAjaxAndRedirect(Me, "El usuario no tiene empresa asignada", "ProntoWeb/Principal.aspx")
                'Response.Redirect("~/ProntoWeb/Principal.aspx")

                'If usuario Is Nothing Or session(SESSIONPRONTO_UserId) Is Nothing Then
                '    If Not Request.IsAuthenticated Then
                '        FormsAuthentication.SignOut()
                '    End If

                '    Response.Redirect(FormsAuthentication.LoginUrl)
                '    Return
                'End If


                'Stop

                'como hago para mostrar los mensajes y redirigir recien despues?

                'Session.Clear()
                'Response.Redirect("~/Login.aspx")
                'MsgBoxAjaxAndRedirect()

            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            ' MsgBoxAjaxAndRedirect(Me, "El usuario no tiene empresa asignada", "ProntoWeb/Principal.aspx")

            'Response.Redirect("~/ProntoWeb/Principal.aspx")
        End Try

        'Response.Redirect("~/ProntoWeb/SelleccionarEmpresa.aspx")
    End Sub





    Protected Sub ButContinuar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButContinuar.Click

    End Sub

    Protected Sub DDLEmpresas_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLEmpresas.SelectedIndexChanged
        'If (e.ReturnValue Is Nothing) Then
        '    PanelInfo.Visible = True
        '    PanelListEmpresas.Visible = False
        'Else
        '    PanelInfo.Visible = False
        '    PanelListEmpresas.Visible = True
        'End If
    End Sub



    Protected Sub LoginStatus1_LoggedOut(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        'FormsAuthentication.RedirectToLoginPage();
    End Sub




End Class

