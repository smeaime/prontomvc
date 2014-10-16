Imports System
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports System.Data.SqlClient
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Partial Class Tablas
    Inherits System.Web.UI.Page

    Private mTabla As String, SC As String
    Protected widestData As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not (Request.QueryString.Get("Tabla") Is Nothing) Then
            mTabla = Convert.ToString(Request.QueryString.Get("Tabla"))
        End If
        SC = ConfigurationManager.ConnectionStrings("Pronto").ConnectionString
        If Not Page.IsPostBack Then
            GridView1.DataSource = dtr(mTabla)
            GridView1.DataBind()
        Else
        End If
        widestData = 0
    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        GridView1.PageIndex = e.NewPageIndex
        GridView1.DataSource = dtr(mTabla)
        GridView1.DataBind()
        'For i As Integer = 0 To GridView1.Columns.Count - 1
        '    GridView1.Columns(i).ItemStyle.Wrap = True
        'Next
    End Sub

    Private Function dtr(ByVal Tabla As String) As System.Data.DataSet
        If mTabla = "" Then
            dtr = Nothing
        ElseIf mTabla = "Localidades" Then
            dtr = LocalidadManager.GetList_fm(SC)
        ElseIf mTabla = "Paises" Then
            dtr = PaisManager.GetList_fm(SC)
        ElseIf mTabla = "Provincias" Then
            dtr = ProvinciaManager.GetList_fm(SC)
        ElseIf mTabla = "Rubros" Then
            dtr = RubroManager.GetList_fm(SC)
        ElseIf mTabla = "Subrubros" Then
            dtr = SubrubroManager.GetList_fm(SC)
        Else
            dtr = Nothing
        End If

    End Function

    'Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
    '    Dim drv As System.Data.DataRowView
    '    drv = CType(e.Row.DataItem, System.Data.DataRowView)
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        If drv IsNot Nothing Then
    '            Dim catName As String = drv(1).ToString()
    '            Dim catNameLen As Integer = catName.Length
    '            If catNameLen > widestData Then
    '                widestData = catNameLen
    '                catNameLen = GridView1.Columns.Count
    '                GridView1.Columns(1).ItemStyle.Width = widestData * 30
    '                GridView1.Columns(1).ItemStyle.Wrap = False
    '            End If
    '        End If
    '    End If

    'End Sub
End Class
