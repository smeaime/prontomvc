
Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection
Imports System.IO
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.ParametroManager
Imports Pronto.ERP.Bll.EntidadManager

Imports Pronto.ERP.BO

Imports System.Diagnostics 'para usar Debug.Print

Imports System.Linq
Imports System.Linq.Expressions
Imports System.Collections.Generic
Imports System.Linq.Dynamic

Imports ProntoCSharp.FuncionesUIWebCSharpEnDllAparte

Imports Pronto.ERP.Dal

Imports Word = Microsoft.Office.Interop.Word
Imports Microsoft.Office.Interop.Word.WdUnits
Imports Microsoft.Office.Interop.Word.WdGoToItem

Partial Class popupGrid
    Inherits System.Web.UI.Page



    Private SC As String



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SC = GetConnectionString(Server, Session)
        HFSC.Value = SC


        If Not (Request.QueryString.Get("q") Is Nothing) Then
            ViewState("consulta") = Request.QueryString.Get("q")
        End If

        Dim consulta As String = ViewState("consulta")

        With ObjectDataSource2
            Select Case consulta
                Case "TodosLosItemsDeRequerimientosParaCopiar"
                    .TypeName = "Pronto.ERP.Bll.RequerimientoManager"

                    .SelectMethod = "GetItemsRequerimientoPendientes"
                    .SelectCountMethod = "GetItemsRequerimientoPendientes_Count"


                Case "ItemsRequerimientosLiberadosParaComprar"

                    .TypeName = "Pronto.ERP.Bll.RequerimientoManager"
                    '.TypeName = "popupGrid"
                    .SelectMethod = "ItemsRequerimientosLiberadosParaComprar"
                    .SelectCountMethod = "GetItemsRequerimientoPendientes_Count"

                    Me.Title = "Requerimientos pendientes"


             


                Case "GetItemsPedidos"

                    .TypeName = "Pronto.ERP.Bll.PedidoManager"
                    .SelectMethod = "GetItemsPedidos"
                    .SelectCountMethod = "GetItemsPedidos_Count"

                Case Else

                    .TypeName = "Pronto.ERP.Bll.RequerimientoManager" ' GetType(Pronto.ERP.Bll.RequerimientoManager).Name

                    .SelectMethod = "GetItemsRequerimientoPendientes"
                    .SelectCountMethod = "GetItemsRequerimientoPendientes_Count"
            End Select
        End With




        'Dim a As wDetRequerimientos_TResult



        If Not IsPostBack Then
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////

            gvAuxPendientesImputar.DataKeyNames(0) = "Id"
            '//////////////////////////////////////////////////
            '//////////////////////////////////////////////////
        End If



        'AutoCompleteExtender1.ContextKey = SC 'para que el autocomplete sepa la cadena de conexion


    End Sub




    Sub RebindAuxPendientesImputar()
        Dim dtv As DataView
        Dim dt As DataTable
        Dim dt2 As DataTable

        Dim q As String

        q = ViewState("consulta")


        Dim sWHERE = "Convert(Numero, 'System.String') LIKE '*" & txtBuscaGrillaImputaciones.Text & "*'"

        If True Then '  RadioButtonListEsInterna.SelectedValue = 1 Then

            ' dtv = GetStoreProcedure(SC, enumSPs.Valores_TX_EnCartera) ' ObjectDataSource2.Select()

            If q = "ItemsRequerimientos" Then

                '   dt = GetDatasource(SC, gvAuxPendientesImputar.PageIndex, gvAuxPendientesImputar.PageSize, "", "", #1/1/1900#, #1/1/2100#)
            Else
                dt = DataTableWHERE(GetStoreProcedure(SC, enumSPs.Valores_TX_EnCartera), sWHERE)
            End If

            Dim dc As New DataColumn 'le agrego una columna para los checks de las grillas de consulta http://msdn.microsoft.com/en-us/library/system.data.datacolumn.datatype(VS.71).aspx
            With dc
                .ColumnName = "ColumnaTilde"
                .DataType = System.Type.GetType("System.Int32")
                .DefaultValue = 0
            End With
            dt.Columns.Add(dc)


            With dt
                '.Columns("IdRequerimiento").ColumnName = "Id"
                '.Columns("OrdenPago").ColumnName = "Numero"
                '.Columns("FechaOrdenPago").ColumnName = "Fecha"
            End With

            'ds.Tables(0).Columns.Add(dc)
            dt.DefaultView.Sort = "Id DESC"

            'dt = DataTableWHERE(dt, "[Saldo Comp_]<>0")
            'Dim dtv2 = AgregarTotalesTransALaGrillaAuxiliarDeImputaciones(New DataView(dt))
            'gvAuxPendientesImputar.DataSource = dt.DefaultView.Table


        End If


        'gvAuxPendientesImputar.DataSourceID = ""
        gvAuxPendientesImputar.DataBind()
    End Sub

    Protected Sub gvAuxPendientesImputar_PageIndexChanged(sender As Object, e As System.EventArgs) Handles gvAuxPendientesImputar.PageIndexChanged
        'RestoreSelection(sender)

    End Sub

    Protected Sub gvAuxPendientesImputar_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvAuxPendientesImputar.PageIndexChanging
        Try
            KeepSelection(sender)
        Catch ex As Exception
            'ErrHandler2WriteErrorLogPronto( ex)
            ErrHandler2.WriteError(ex)
        End Try
        'gvAuxPendientesImputar.PageIndex = e.NewPageIndex
        'RebindAuxPendientesImputar()
    End Sub


    Protected Sub gvAuxPendientesImputar_PreRender(sender As Object, e As System.EventArgs) Handles gvAuxPendientesImputar.PreRender
        RestoreSelection(sender)

        If False Then

            If Not IsPostBack Then
                cmbBuscarEsteCampo.Items.Clear()
                cmbBuscarEsteCampo.Items.Add("")
                For i = 0 To gvAuxPendientesImputar.HeaderRow.Cells.Count - 1
                    Dim s = gvAuxPendientesImputar.HeaderRow.Cells(i).Text
                    cmbBuscarEsteCampo.Items.Add(s)
                Next
            End If

        End If

    End Sub


    Protected Sub ObjectDataSource2_DataBinding(sender As Object, e As System.EventArgs) Handles ObjectDataSource2.DataBinding
        ' KeepSelection(gvAuxPendientesImputar)
    End Sub

    Protected Sub ObjectDataSource2_PreRender(sender As Object, e As System.EventArgs) Handles ObjectDataSource2.PreRender

    End Sub

    Protected Sub ObjectDataSource2_Selected(sender As Object, e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource2.Selected
        '   KeepSelection(gvAuxPendientesImputar)

        Try
            '  RestoreSelection(gvAuxPendientesImputar)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try
    End Sub




    Protected Sub ObjectDataSource2_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles ObjectDataSource2.Selecting
        'http://forums.asp.net/t/1277517.aspx
        'http://bytes.com/topic/visual-basic-net/answers/478590-disable-objectdatasource-control
        'Dim idproveed = 100 ' BuscaIdProveedorPreciso(txtAutocompleteProveedor.Text, HFSC.Value).ToString
        'e.InputParameters("Parametros") = New String() {idproveed.ToString}
        Try
            '  KeepSelection(gvAuxPendientesImputar)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        'Static Dim ObjectDataSource2Mostrar As Boolean = False

        ''If txtBuscaGrillaImputaciones.Text = "buscar" Then
        ''If Not IsPostBack Then
        ''    e.Cancel = True 'está cancelando tambien cuando pasa a otra pagina dentro de la gridview
        ''End If

        'ObjectDataSource2Mostrar = False
    End Sub

    Protected Sub btnSaveItemImputacionAux_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveItemImputacionAux.Click


        'Dim myOrdenPago As Pronto.ERP.BO.OrdenPago = CType(Me.ViewState(mKey), Pronto.ERP.BO.OrdenPago)
        Dim a As New Generic.List(Of String)

        'Dim chkFirmar As CheckBox
        'Dim keys(3) As String
        'With gvAuxPendientesImputar
        '    For Each fila As GridViewRow In .Rows
        '        If fila.RowType = DataControlRowType.DataRow AndAlso TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
        '            chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)

        '            If chkFirmar.Checked Then



        '                Dim id As Integer = iisNull(.DataKeys(fila.RowIndex).Values.Item("Id"), -1)
        '                a.Add(id)


        '            Else
        '                'MsgBoxAjax(Me, "El renglon de imputacion " & idCtaCte & " ya está en el detalle")
        '            End If


        '        End If
        '    Next
        'End With

        Dim s = ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.TraerListaEnStringConComas(gvAuxPendientesImputar)

        s = s.Replace(",", " ")
        'Dim s As String = Join(a.ToArray)

        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me, Me.GetType(), "StartUpScript1", "javascript:GetRowValue('" & s & "');", True)
        'será devuelto en txtPopupRetorno, ver markup 

    End Sub



    Protected Sub txtBuscaGrillaImputaciones_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscaGrillaImputaciones.TextChanged
        'RebindAuxPendientesImputar()
        'gvAuxPendientesImputar.DataBind() 'el databind se hace solo
        SetFocus(txtBuscaGrillaImputaciones)
    End Sub



    Protected Sub Button4_Click(sender As Object, e As System.EventArgs) Handles Button4.Click

    End Sub



End Class



