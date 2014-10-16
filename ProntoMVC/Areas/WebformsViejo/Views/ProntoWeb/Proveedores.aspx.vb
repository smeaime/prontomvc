Imports System
Imports System.Collections.Generic
Imports System.Reflection
Imports System.Web.UI.WebControls

Imports Pronto.ERP.BO

Partial Class Proveedores
    Inherits System.Web.UI.Page

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdArticulo As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Proveedor.aspx?Id={0}", IdArticulo.ToString))
        End Select
    End Sub

    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click

        Response.Redirect(String.Format("Proveedor.aspx?Id=-1"))

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()
    End Sub

    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function


    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        ObjectDataSource1.FilterExpression = "Convert(RazonSocial, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(CUIT, 'System.String') LIKE '*" & txtBuscar.Text & "*'" _
                                             & " OR " & _
                                             "Convert(Direccion, 'System.String') LIKE '*" & txtBuscar.Text & "*'"

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub
End Class
