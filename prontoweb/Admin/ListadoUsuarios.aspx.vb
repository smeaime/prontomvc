Imports System.Linq


Partial Class Admin_Roles
    Inherits System.Web.UI.Page
    Private _UserName As String
    Dim ErrHandler2 As Object

    Public Property UserName() As String
        Get
            Return _UserName
        End Get
        Set(ByVal value As String)
            _UserName = value
        End Set
    End Property

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not Page.IsPostBack Then
            Rebind()
        End If


        'SincronizarTablaDeUsuariosConSitioDePHP()
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        Rebind()
        'GridView1.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub Rebind()

        Dim a As MembershipUserCollection = Membership.GetAllUsers()
        Dim c = (From i As MembershipUser In a Where i.UserName.ToUpper.Contains(txtBuscar.Text.ToUpper)).ToList
        GVUsuarios.DataSource = c

        GVUsuarios.DataBind()

    End Sub


    Protected Sub ButAssign_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        UserName = e.CommandArgument.ToString
        Response.Redirect("~/Admin/AsignarEmpresa.aspx")
    End Sub

    Protected Sub GVUsuarios_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GVUsuarios.PageIndexChanging
        GVUsuarios.PageIndex = e.NewPageIndex
        GVUsuarios.DataSource = Membership.GetAllUsers()
        GVUsuarios.DataBind()

    End Sub



    Protected Sub GVUsuarios_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GVUsuarios.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim user As MembershipUser
            user = DirectCast(e.Row.DataItem, MembershipUser)
            Dim lblRol As Label
            lblRol = DirectCast(e.Row.FindControl("LblRol"), Label)
            Dim rol() As String
            rol = Roles.GetRolesForUser(user.UserName)
            If (rol.Length <> 1) Then
                lblRol.Text = "-- --"
            Else
                lblRol.Text = rol(0)
            End If
        End If
    End Sub

    Protected Sub ButEditar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        UserName = e.CommandArgument.ToString
        Response.Redirect("~/Admin/EditarUsuario.aspx?UserName=" & UserName)
        'Server.Transfer("~/Admin/EditarUsuario.aspx")
    End Sub

    Protected Sub ButEliminar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Membership.DeleteUser(e.CommandArgument.ToString)
        Rebind()
    End Sub


    Protected Sub ButDesbloquear_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)

        UserName = e.CommandArgument.ToString
        Dim membershipUser As MembershipUser
        membershipUser = Membership.GetUser(UserName)
        membershipUser.UnlockUser()
        Membership.UpdateUser(membershipUser)
        Rebind()
    End Sub

    Protected Sub ButResetearPass_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        'http://stackoverflow.com/questions/287320/how-do-you-change-a-hashed-password-using-asp-net-membership-provider-if-you-don
        'http://www.asp.net/web-forms/tutorials/security/admin/recovering-and-changing-passwords-cs (en especial el punto 3)}

        'But what if your client insists that administrative users should be able to change other users' passwords? Unfortunately, 
        'adding this functionality can be a bit of work. To change a user's password, both the old and new password must be supplied to 
        'the MembershipUser object's ChangePassword method, but an administrator shouldn't have to know a user's password in order to modify it.

        'The problem is that this code only works if the Membership system configuration is set such that RequiresQuestionAndAnswer is 
        'False. If RequiresQuestionAndAnswer is True, as it is with our application, then the ResetPassword method needs to be passed the security 
        'answer, otherwise it will throw an exception.

        '-pero hete aquí que con este provider (AspNetSqlMembershipProvider) no tengo esa opcion! 
        'http://peterkellner.net/2007/02/15/resetpasswordaspnet/
        'You will find that if you have in your web.config requiresQuestionAnswer="true", you will get 
        'an error when you try and reset the password.  The elegant solution to this is to create an additional membeship tag in 
        'your web.config and reference it when you change passwords.  

        'If Membership.PasswordStrengthRegularExpression() Then

        'End If
        'Membership.MinRequiredPasswordLength()
        'Membership.MinRequiredNonAlphanumericCharacters()


        ViewState("UsuarioModificar") = e.CommandArgument.ToString
        ModalPopupExtender1.Show()
        'resetearContr(e.CommandArgument.ToString)


    End Sub


    Protected Sub btnOk_Click(sender As Object, e As System.EventArgs) Handles btnOk.Click
        Dim s As String = ViewState("UsuarioModificar")


        If txtPass.Text <> txtPassConfirmar.Text Then
            ModalPopupExtender1.Show()
            MsgBoxAjax(Me, "La contraseña es diferente que la confirmación")
            Exit Sub
        End If

        If txtPass.Text.Length < 7 Then
            'If Not Membership.ValidateUser(s, txtPass.Text) Then
            ModalPopupExtender1.Show()
            MsgBoxAjax(Me, "La contraseña es inválida. Debe tener por lo menos 7 caracteres") ' y uno no alfanumérico")
            Exit Sub
        End If


        Dim rgx = New Regex("[a-zA-Z0-9 -]")
        Dim str = rgx.Replace(txtPass.Text, "")
        If str.Length = 0 Then
            'If Not Membership.ValidateUser(s, txtPass.Text) Then
            ModalPopupExtender1.Show()
            MsgBoxAjax(Me, "La contraseña es inválida. Debe tener por lo menos un carácter no alfanumérico") ' y uno no alfanumérico")
            Exit Sub
        End If


        resetearContr(s)
    End Sub

    Sub resetearContr(UserName As String)
        Dim membershipUser As MembershipUser
        'membershipUser = Membership.Providers("SqlMembershipProviderOther").GetUser(UserName, False)
        membershipUser = Membership.GetUser(UserName, True)
        If False Then

            Dim oldpass = membershipUser.ResetPassword()
            membershipUser.ChangePassword(oldpass, "myAwesomePassword") 'obligatorio requiresQuestionAndAnswer = "false" en el membership provider
        Else
            'http://team.desarrollosnea.com.ar/blogs/jfernandez/archive/2009/12/10/asp-net-membership-reset-password-with-ts-sql-por-si-las-moscas-tenerlo-a-mano.aspx
            Try
                Dim dt = Pronto.ERP.Bll.EntidadManager.ExecDinamico(ConexBDLmaster, "[wResetearPass] '" & UserName & "'," & _c(txtPass.Text))

                Try
                    Dim cuerpo = "Vuelva al sitio e inicie sesión utilizando la siguiente información. Nombre de usuario: " & UserName & " Contraseña: " & txtPass.Text
                    MandaEmailSimple(membershipUser.Email, "Contraseña", cuerpo, _
                       ConfigurationManager.AppSettings("SmtpUser"), _
                       ConfigurationManager.AppSettings("SmtpServer"), _
                       ConfigurationManager.AppSettings("SmtpUser"), _
                       ConfigurationManager.AppSettings("SmtpPass"), _
                        "", _
                       ConfigurationManager.AppSettings("SmtpPort"), , , )
                Catch ex As Exception
                    Pronto.ERP.Bll.ErrHandler2.WriteError(ex)
                End Try

                'MsgBoxAlert("Contraseña cambiada con éxito")
                MsgBoxAjax(Me, "Contraseña cambiada con éxito. Se envió un correo de notificación a " & membershipUser.Email)
                Rebind()

            Catch ex As Exception
                ErrHandler2.WriteAndRaiseError(ex)
                MsgBoxAjax(Me, "La contraseña debe tener al menos 7 caracteres y debe tener un carácter no alfanumérico")
                ' MsgBoxAlert(ex.ToString)
            End Try

        End If

    End Sub



    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click
        Response.Redirect(String.Format("~/Admin/AgregarUsuarios.aspx"))
    End Sub





    Sub SincronizarTablaDeUsuariosConSitioDePHP()
        Dim a As MembershipUserCollection = Membership.GetAllUsers()
        'Dim c = (From i As MembershipUser In a Where i.UserName.ToUpper.Contains(txtBuscar.Text.ToUpper)).ToList
        'GVUsuarios.DataSource = c


        For Each c As MembershipUser In a
            'Dim membershipUser As MembershipUser
            'membershipUser = Membership.GetUser(UserName)
            'Dim userInfo As MembershipUser = Membership.GetUser(Login1.UserName)
            Dim pass = c.GetPassword 'enablePasswordRetrieval="true" en web.config
        Next


    End Sub


End Class
