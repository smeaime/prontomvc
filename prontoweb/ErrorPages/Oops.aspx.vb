Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll

Imports CartaDePorteManager


Partial Class ProntoWeb_Principal
    Inherits System.Web.UI.Page

    Public imgPath As String = System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/bck_header.jpg") 'http://forums.asp.net/t/1370779.aspx para tener acceso a la imagen de fondo en otros directorios



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        HFSC.Value = GetConnectionString(Server, Session)



        'si no tiene empresa elegida, redirigirlo a seleccionarempresa  o hacer un logout
        Try
            Dim Usuario As Usuario = Session(SESSIONPRONTO_USUARIO) 'acá puede quedar con nothing. por qué lo dejé?

            If Usuario Is Nothing Then logout()
            If Usuario.StringConnection = "" Then logout()
        Catch ex As Exception
            logout()
        End Try





        ' http://www.asp.net/hosting/tutorials/processing-unhandled-exceptions-cs
        'MandaEmail("mscalella911@gmail.com",

        ' http://www.asp.net/hosting/tutorials/displaying-a-custom-error-page-cs
        '        Notifying Developers and Logging Error Details
        'Errors that occur in the development environment were caused by the developer sitting at her computer. 
        'She is shown the exception's information in the Exception Details YSOD, and she knows what steps she was 
        'performing when the error occurred. But when an error occurs on production, the 
        'developer has no knowledge that an error occurred unless the end user visiting the site 
        'takes the time to report the error. And even if the user goes out of his way to alert the development team that an error 
        'occurred, without knowing the exception type, message, and stack trace it can be difficult to diagnose 
        'the cause of the error, let alone fix it.
        'For these reasons it is paramount that any error in the production environment 
        'is logged to some persistent store (such as a database) and that the developers are alerted of this error. 
        '    The custom error page may seem like a good place to do this logging and notification. Unfortunately, the custom 
        'error page does not have access to the error details and therefore cannot be used to log this information. 
        '    The good news is that there are a number of ways to intercept the error details and to log them, and 
        '    the next three tutorials explore this topic in more detail.


        '        MsgBoxAjax(Me, "El sistema no pudo manejar la cantidad de datos. Por favor, reduzcala achicando el filtro. 
        '                   Ya se le ha enviado un mail automático al administrador con el error. 
        '                   Si el error sigue sucediendo, llamenos
        'BDL Consultores 011 - 486
        '")

        '        Catch ex As OutOfMemoryException
        '            MsgBoxAjax(Me, "El sistema no pudo manejar la cantidad de datos. Por favor, reduzcala achicando el filtro. Ya se le ha enviado un mail automático al administrador con el error.")

        '        Catch ex As timeout

        '        Catch ex As pagenotfound

        'MsgBoxAjax(Me, "Disculpame, no pude manejar la cantidad de datos. Por favor, intentá achicando los filtros. Ya mandé un mail al administrador con el error.")



    End Sub


    Protected Sub lnkLogOut_Click(sender As Object, e As System.EventArgs) Handles lnkLogOut.Click
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        'Response.Redirect("~/" + FormsAuthentication.LoginUrl)
        Response.Redirect("~/Login.aspx")
    End Sub

    Protected Sub LoginStatus1_LoggedOut(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        FormsAuthentication.RedirectToLoginPage()
    End Sub

    Function logout()
        Session("IdUser") = Nothing
        FormsAuthentication.SignOut()
        Roles.DeleteCookie()
        Session.Clear()
        Session("DebugPronto") = "NO"
        FormsAuthentication.RedirectToLoginPage()
    End Function

End Class


