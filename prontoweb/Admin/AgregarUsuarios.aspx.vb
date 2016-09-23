Imports System.Security

Partial Class Admin_Usuarios
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not Page.IsPostBack Then
			GetAllRoles()
		End If
	End Sub

	Private Sub GetAllRoles()
        Dim r() As String

        If ConfigurationManager.AppSettings("ConfiguracionEmpresa") = "Esuco" Then
            ReDim r(1)
            r(0) = "Administrador"
            r(1) = "Usuario"
        ElseIf ConfigurationManager.AppSettings("ConfiguracionEmpresa") = "Williams" Then
            r = Roles.GetAllRoles()
            For i = 0 To r.Length - 1
                If r(i) = "Administrador" Then r(i) = "WilliamsAdmin"
            Next
        Else
            r = Roles.GetAllRoles()
        End If



        For Each rol As String In r
            RBListRoles.DataSource = r
            RBListRoles.DataBind()
        Next
    End Sub




    Protected Sub CreateUserWizard_CreatedUser(ByVal sender As Object, ByVal e As System.EventArgs) Handles CreateUserWizard.CreatedUser
        Roles.AddUserToRole(CreateUserWizard.UserName, RBListRoles.SelectedValue)
        'PanelRoles.Visible = False
        Response.Redirect(String.Format("ListadoUsuarios.aspx"))
    End Sub


	Protected Sub CreateUserWizard_CreatingUser(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.LoginCancelEventArgs) Handles CreateUserWizard.CreatingUser
		If (RBListRoles.SelectedValue <> String.Empty) Then
        Else
            LblInfo.Visible = True
            e.Cancel = True
		End If
	End Sub



End Class
