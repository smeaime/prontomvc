Imports System
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO


Imports CartaDePorteManager


Partial Class Admin_AsignarEmpresa
	Inherits System.Web.UI.Page
	Private SC As String

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SC = ConexBDLmaster()
		HFSC.Value = SC
		If Not Page.IsPostBack Then
            GetAllUsers()

            Dim Usuario = New Usuario
            Usuario = session(SESSIONPRONTO_USUARIO)
            BuscaTextoEnCombo(DDLUser, Usuario.Nombre)
		End If
	End Sub

	Private Sub GetAllUsers()
        DDLUser.Items.Clear()
        Dim membershipUserCollection As MembershipUserCollection
        membershipUserCollection = Membership.GetAllUsers()
        Dim li As ListItem
        For Each user As MembershipUser In membershipUserCollection
            li = New ListItem
            li.Text = user.UserName
            li.Value = user.ProviderUserKey.ToString
            If Not Page.PreviousPage Is Nothing Then
                'If Not (PreviousPage.UserName Is Nothing) Then
                '    If (li.Text = PreviousPage.UserName) Then
                '        li.Selected = True
                '    End If
                'End If
            End If
            DDLUser.Items.Add(li)
        Next
	End Sub

	Protected Sub DDLUser_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLUser.SelectedIndexChanged
		Dim empresaList As EmpresaList
		empresaList = New EmpresaList
        SC = ConexBDLmaster()
        'empresaList = EmpresaManager.GetEmpresasPorUsuario(SC, DDLUser.SelectedValue.ToString)
		RefreshBinding()
	End Sub

	Protected Sub ButAsisgnar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButAsisgnar.Command
		If Not DDLEmpresas.SelectedItem Is Nothing Then
			EmpresaManager.AddUserInCompanies(SC, DDLUser.SelectedValue, DDLEmpresas.SelectedItem.Value)
			RefreshBinding()
		End If
	End Sub

	Protected Sub ButDeleteUserInCompany_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs) Handles ButDeleteUserInCompany.Command
		If Not LBEmpresas.SelectedItem Is Nothing Then
			EmpresaManager.DeleteUserInCompanies(SC, DDLUser.SelectedValue, LBEmpresas.SelectedItem.Value)
		End If
		RefreshBinding()
	End Sub

	Private Sub RefreshBinding()
		LBEmpresas.Items.Clear()
		LBEmpresas.DataBind()
		DDLEmpresas.Items.Clear()
		DDLEmpresas.DataBind()
	End Sub
End Class
