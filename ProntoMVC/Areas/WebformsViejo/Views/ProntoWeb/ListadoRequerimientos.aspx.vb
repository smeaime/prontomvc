Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Agilmind.RemotingServer
Imports System.Data

Partial Class ProntoWeb_ListadoRequerimientos
    Inherits System.Web.UI.Page
    Private _IdRequerimiento As Integer = 0
    Private _NumeroRequerimiento As Integer = 0

    Public Property IdRequerimiento() As Integer
        Get
            Return _IdRequerimiento
        End Get
        Set(ByVal value As Integer)
            _IdRequerimiento = value
        End Set
    End Property

    Public Property NumeroRequerimiento() As Integer
        Get
            Return _NumeroRequerimiento
        End Get
        Set(ByVal value As Integer)
            _NumeroRequerimiento = value
        End Set
    End Property

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'TODO: Sacar esto a la masterPage
        'If (session(SESSIONPRONTO_UserId) Is Nothing) Then
        'Server.Transfer("~/Login.aspx")
        'If (Master.HaveSession()) Then
        '    HFSC.Value = Master.GetConnectionString(Convert.ToInt32(Session("IdEmpresa")))
        'End If
    End Sub

    Protected Sub DLListReq_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DLListReq.ItemCreated
        Dim id As Integer
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            id = DirectCast(e.Item.DataItem(), Pronto.ERP.BO.Requerimiento).Id
            Dim hfId As HiddenField
            hfId = DirectCast(e.Item.FindControl("HFIdReq"), HiddenField)
            hfId.Value = id.ToString
        End If
    End Sub

    'Protected Sub DVArticulo_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertEventArgs)
    '    Dim myRequerimientoItem As RequerimientoItem
    '    Dim hfId As HiddenField
    '    hfId = DirectCast(sender.Parent.FindControl("HFIdReq"), HiddenField)
    '    myRequerimientoItem = New Pronto.ERP.BO.RequerimientoItem
    '    myRequerimientoItem.IdRequerimiento = Convert.ToInt32(hfId.Value)
    '    myRequerimientoItem.IdArticulo = Convert.ToInt32(HFIdArticulo.Value)
    '    myRequerimientoItem.FechaEntrega = e.Values("FechaEntrega")
    '    myRequerimientoItem.Cantidad = e.Values("Cantidad")
    '    myRequerimientoItem.Observaciones = e.Values("Observaciones")
    '    RequerimientoItemManager.Save(HFSC.Value, myRequerimientoItem)
    '    e.Cancel = True

    '    Dim gridView As GridView
    '    gridView = DirectCast(sender.Parent.FindControl("GVListItems"), GridView)
    '    gridView.DataBind()
    'End Sub

    Protected Sub IButDelete_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        RequerimientoItemManager.Delete(HFSC.Value, Convert.ToInt32(e.CommandArgument))
        ObjDsListItems.DataBind()
        GVListItems.DataBind()
    End Sub

    Protected Sub ObjDsListItems_Deleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceMethodEventArgs)
        e.Cancel = True
    End Sub

    Protected Sub ImageButton1_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        RequerimientoItemManager.Delete(HFSC.Value, Convert.ToInt32(e.CommandArgument))
        ObjDsListItems.DataBind()
        GVListItems.DataBind()
    End Sub

    Protected Sub ObjDsListItems_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceMethodEventArgs)
        e.Cancel = True
    End Sub

    Protected Sub DLListReq_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles DLListReq.ItemDataBound
        Dim butEdit As Button = DirectCast(e.Item.FindControl("ButEdit"), Button)
        Dim butEliminar As Button = DirectCast(e.Item.FindControl("ButEliminar"), Button)
        If butEdit IsNot Nothing Then
            Dim liberdado As String = DirectCast(e.Item.DataItem(), Pronto.ERP.BO.Requerimiento).Aprobo
            If (liberdado <> Nothing) Then
                butEdit.Enabled = False
                butEdit.BackColor = Drawing.Color.Silver
                butEdit.ForeColor = Drawing.Color.LightGray
                butEdit.Text = "Lib"
                butEliminar.Enabled = False
                butEliminar.BackColor = Drawing.Color.Silver
                butEliminar.ForeColor = Drawing.Color.LightGray
            End If
        End If
    End Sub

    Protected Sub ButEdit_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        Dim command() As Object = Convert.ToString(e.CommandArgument).Split("#")
        _IdRequerimiento = command(0).ToString
        _NumeroRequerimiento = command(1).ToString
    End Sub

    Protected Sub DDLOrden_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        order.Value = DirectCast(sender, DropDownList).Text
        Me.ViewState.Add("Order", order.Value)
    End Sub

    Protected Sub DLListReq_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DLListReq.ItemCommand
        ObjDsListItems.TypeName = "Pronto.ERP.Bll.RequerimientoManager"
        ObjDsListItems.SelectMethod = "GetListItems"
        ObjDsListItems.SelectParameters.Add("SC", TypeCode.String, HFSC.Value)
        Dim idReq As Integer = Convert.ToInt32(DirectCast(e.Item.FindControl("HFIdReq"), HiddenField).Value)
        ObjDsListItems.SelectParameters.Add("id", idReq)
        ObjDsListItems.Select()
        ObjDsListItems.DataBind()
        Dim requerimientoItemList As RequerimientoItemList
        requerimientoItemList = DirectCast(ObjDsListItems.Select(), RequerimientoItemList)

        Dim gvListItems As GridView
        gvListItems = DirectCast(e.Item.FindControl("GVListItems"), GridView)

        gvListItems.DataSource = ObjDsListItems
        gvListItems.DataBind()
    End Sub

    Protected Sub DDLOrden_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.ViewState("Order") IsNot Nothing Then
            DirectCast(sender, DropDownList).SelectedValue = Me.ViewState("Order")
        End If
    End Sub

    Private IdAnulado As Integer = 0

    Protected Sub ButEliminar_Command(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.CommandEventArgs)
        RequerimientoManager.Anular(HFSC.Value, Convert.ToInt32(e.CommandArgument))
        Response.Redirect("ListadoRequerimientos.aspx")
    End Sub
End Class
