
Partial Class _Default
    Inherits System.Web.UI.Page


    'Esta pagina solo está para redirigir

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Redirect("Principal.aspx")
    End Sub
End Class