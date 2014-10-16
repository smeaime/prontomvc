Imports System
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports System.IO
Imports System.Reflection
Imports System.Web.UI.WebControls
Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO

Partial Class Firmas_DocumentosAFirmar
    Inherits System.Web.UI.Page

    Private SCconexBDLmaster As String
    Private empresaList As EmpresaList = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SCconexBDLmaster = ConexBDLmaster()
        HFSC.Value = SCconexBDLmaster

        'http://forums.asp.net/p/1498291/3541070.aspx
        'http://forums.asp.net/t/1421847.aspx
        'esto parece que es para que no tenga que cargar en la masterpage el link al codigo javascript
        '-Pero es tanto ahorro?
        Page.ClientScript.RegisterClientScriptInclude("selective", ResolveUrl("../../JavaScript/firmas.js"))
        Page.ClientScript.RegisterClientScriptInclude("selective", ResolveUrl("../../JavaScript/dragAndDrop.js"))



        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            
            Rebind()
        End If


        If Request.QueryString.Count > 0 Then 'viene de apretar "ver"?
            'En GVFirmas_RowDataBound le asigno por código al evento click de ButVer (boton "ver") unas 
            ' llamadas a ShowPedido y ShowRequerimiento, que estan en jsamCore.js o firmas.js


            If Request.QueryString("cmd") = "showReq" Then
                GetRequrimientoAjax(Request.QueryString("id"), Request.QueryString("empresaName"))
            End If
            If Request.QueryString("cmd") = "showPed" Then
                GetPedidoAjax(Request.QueryString("id"), Request.QueryString("empresaName"))
            End If
        End If

        EnableMenu()
        If Not User.Identity.IsAuthenticated Then
            Server.Transfer("/Firmas/Login.aspx")
        End If

        HFUserName.Value = User.Identity.Name
        empresaList = EmpresaManager.GetEmpresasPorUsuario(HFSC.Value, GetUserId())
    End Sub

    Private Sub EnableMenu()
        Dim menu As TreeView
        menu = DirectCast(Master.FindControl("TreeView1"), TreeView)
        'menu.Visible = False
    End Sub

    Function GetUserId() As String
        Dim UserId As String = String.Empty
        If Not (session(SESSIONPRONTO_UserId) Is Nothing) Then
            UserId = session(SESSIONPRONTO_UserId)
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return UserId
    End Function







    Function GenerarWHERE() As String
        Dim s As String

        '//////////
        'debug
        '//////////
        'Return "ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL "
        'Return "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL )  AND  (Aprobo IS NULL OR Aprobo=0) "
        's = "(ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL )  AND  (Aprobo IS NULL OR Aprobo=0) "
        'Return s
        '//////////
        '//////////


        'Para filtrar por dataset (en lugar de usar el manager con una lista de comprobantes)

        s = "1=1 "

        If txtBuscar.Text <> "" Then
            s += " AND ( " & _
                                       "Convert(" & cmbBuscarEsteCampo.SelectedValue & ", 'System.String') LIKE '*" & txtBuscar.Text & "*' )" '_
        End If

        '& " OR " & _
        '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"



        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


        'Select Case HFTipoFiltro.Value.ToString  '
        '    Case "", "AConfirmarEnObra"
        '        s += " AND (Aprobo IS NULL OR Aprobo=0)"
        '        's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

        '    Case "AConfirmarEnCentral"
        '        s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)  AND  (Aprobo IS NULL OR Aprobo=0) ) "

        '    Case "Confirmados"
        '        s += " AND (Aprobo NOT IS NULL AND Aprobo>0)"
        '        's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
        'End Select


        Return s
    End Function


    Protected Sub GVFirmas_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GVFirmas.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GVFirmas.PageIndex = e.NewPageIndex
        Rebind()

    End Sub


    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        Rebind()
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

        Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)

        Dim pageIndex = GVFirmas.PageIndex

        'chupo
        'Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.OrdenesPago_TXFecha, txtFechaDesde.Text, txtFechahasta.Text).Tables(0)
        Dim dt As DataTable = FirmaDocumentoManager.GetDocumetosAFirmar(SCconexBDLmaster, User.Identity.Name).Tables(0)

        'Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes(SC).Tables(0) ' EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)


        'filtro
        dt = DataTableWHERE(dt, GenerarWHERE)



        'ordeno
        Dim b As Data.DataView = DataTableORDER(dt, "Fecha DESC")




        'b.Sort = "IdDetalleRequerimiento DESC"
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'Dim b As Data.DataView = ObjectDataSource1.Select()

        'b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'b.Sort = "Fecha DESC,Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'b.Sort = "Id DESC"

        ViewState("Sort") = b.Sort
        GVFirmas.DataSourceID = ""
        GVFirmas.DataSource = b
        GVFirmas.DataBind()
        GVFirmas.PageIndex = pageIndex

        If dt.Rows.Count > 0 Then
            lblvacio.visible = False
            GVFirmas.Visible = True
        Else
            lblvacio.visible = True
            GVFirmas.Visible = False
        End If


        'gvDEVEX.DataSource = b
        'gvDEVEX.DataBind()
    End Sub



    Protected Sub GVFirmas_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GVFirmas.RowDataBound
        Dim idFormulario As Integer
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim but As Button
            but = DirectCast(e.Row.FindControl("ButVer"), Button)
            idFormulario = Convert.ToUInt32(DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("IdFormulario").ToString)
            Dim db As String = DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("BD").ToString
            but.CommandArgument = idFormulario.ToString + "#"
            but.CommandArgument += DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("IdComprobante").ToString + "#"
            but.CommandArgument += db
            Dim idComprobante As String = DirectCast(e.Row.DataItem, System.Data.DataRowView).Row("IdComprobante").ToString
            If idFormulario = 3 Then
                but.OnClientClick = String.Format("javascript:ShowRequerimiento('{0}','{1}', elReq); return false;", idComprobante, db)
            ElseIf idFormulario = 4 Then
                but.OnClientClick = String.Format("javascript:ShowPedido('{0}','{1}', elPed); return false;", idComprobante, db)
            End If



        End If
    End Sub





    Protected Sub GVFirmas_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GVFirmas.RowCommand

        If e.CommandName = "Page" Then Exit Sub 'si es un cambio de pagina, que no haga nada

        Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
        Dim IdFormulario As Integer = GVFirmas.DataKeys(rowIndex).Item("IdFormulario") ' Convert.ToUInt32(DirectCast(GVFirmas.Rows(rowIndex).DataItem, System.Data.DataRowView).Row("IdFormulario").ToString) ' Convert.ToInt32(GVFirmas.DataKeys(rowIndex).Value)
        Dim IdComprobante As Integer = GVFirmas.DataKeys(rowIndex).Item("IdComprobante")

        Dim db As String = GVFirmas.DataKeys(rowIndex).Item("BD")

        Select Case e.CommandName.ToLower

            Case "ver"


                Dim sConex As String = Pronto.ERP.Bll.BDLMasterEmpresasManager.GetConnectionStringEmpresa(Session(SESSIONPRONTO_UserId), 0, SCconexBDLmaster, db)
                sConex = Encriptar(sConex)
                Session("ConexionBaseAlternativa") = sConex

                Dim sUrl As String
                ProntoFuncionesUIWeb.AbrirSegunTipoComprobante(IdFormulario, IdComprobante)
                If IdFormulario = 3 Then
                    'sUrl = String.Format("../RequerimientoB.aspx?Id={0}&SC={1}", IdComprobante.ToString, Server.UrlEncode(sConex))
                    sUrl = String.Format("../RequerimientoB.aspx?Id={0}&SC={1}", IdComprobante.ToString, db)
                    'Response.Redirect(String.Format("../RequerimientoB.aspx?Id={0}", IdComprobante.ToString))
                Else
                    'sUrl = String.Format("../Pedido.aspx?Id={0}&SC={1}", IdComprobante.ToString, Server.UrlEncode(sConex))
                    sUrl = String.Format("../Pedido.aspx?Id={0}&SC={1}", IdComprobante.ToString, db)
                End If




                'Response.Redirect(sUrl)
                'Exit Sub


                Dim str As String
                str = "window.open('" & sUrl & "', 'List', 'scrollbars=no,resizable=no,width=1200,height=800,left=0,top=0,toolbar=No,status=No,fullscreen=No');"
                AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)




            Case "ver2"

                'uso las mismas funciones de javascript. es por esto, pinta, que el postback del 
                ' ViewState no funciona una vez que vi un popup. 


                If IdFormulario = 3 Then

                    'ExecuteCall("DocumentosAFirmar.aspx?cmd=showReq&id="+id+"&empresaName="+empresa,pt);
                    GetRequrimientoAjax(IdComprobante, db)

                ElseIf IdFormulario = 4 Then

                    'ExecuteCall("DocumentosAFirmar.aspx?cmd=showPed&id="+id+"&empresaName="+empresa,pt);
                    GetPedidoAjax(IdComprobante, db)

                End If




        End Select



        'Dim command() = Convert.ToString(e.CommandArgument).Split("#")
        'Dim IdFormulario = command(0).ToString
        'Dim IdComprobante = command(1).ToString
        'Dim empresaName = command(2).ToString

        'Dim stringConn As String = String.Empty
        'For Each empresa As Empresa In empresaList
        '    If (empresa.Descripcion = empresaName) Then
        '        stringConn = empresa.ConnectionString
        '    End If
        'Next

        'If e.CommandName.ToLower = "ver" Then
        '    If IdFormulario = 3 Then
        '        RequerimientoShowData(IdComprobante, stringConn)
        '    ElseIf IdFormulario = 4 Then
        '        PedidoShowData(IdComprobante, stringConn)
        '    End If
        'End If
    End Sub

    Private Sub PedidoShowData(ByVal idPedido As Integer, ByVal stringConn As String)
        Dim myPedido As Pronto.ERP.BO.Pedido
        If idPedido > 0 Then
            myPedido = PedidoManager.GetItem(stringConn, idPedido, True)
            If Not (myPedido Is Nothing) Then
                lblNumero.Text = myPedido.Numero
                lblFecha.Text = myPedido.Fecha.ToString("dd/MM/yyyy")
                LblContacto.Text = myPedido.Contacto
                lblObra.Text = myPedido.Obras
                LlblLiberado.Text = myPedido.Aprobo
                LblCondCompra.Text = myPedido.CondicionCompra
                LblCompador.Text = myPedido.Comprador
                LblAclaracion.Text = myPedido.DetalleCondicionCompra
                LblMoneda.Text = myPedido.Moneda & " (Cotiz.u$s : " & myPedido.CotizacionDolar & ")"
                lblMon4.Text = myPedido.Moneda
                LblNroComparativa.Text = myPedido.NumeroComparativa
                lblObservaciones.Text = myPedido.Observaciones
                lblSubtotal.Text = Format(myPedido.TotalPedido - myPedido.ImpuestosInternos - myPedido.TotalIva1, "#,##0.00")
                lblIVA.Text = Format(myPedido.TotalIva1, "#,##0.00")
                lblImpInt.Text = Format(myPedido.ImpuestosInternos, "#,##0.00")
                lblTotal.Text = Format(myPedido.TotalPedido, "#,##0.00")

                GVPedidoItems.DataSource = myPedido.Detalles
                GVPedidoItems.DataBind()
                ProveedorShowData(myPedido.IdProveedor, stringConn)
            End If
        End If
    End Sub

    Private Sub ProveedorShowData(ByVal idProveedor As Integer, ByVal stringConn As String)
        Dim myProveedor As Pronto.ERP.BO.Proveedor
        myProveedor = ProveedorManager.GetItem(stringConn, idProveedor, True)
        If Not (myProveedor Is Nothing) Then
            LblProveedor.Text = myProveedor.RazonSocial
            LblDirecProveedor.Text = myProveedor.Direccion
            LblLocacProveedor.Text = myProveedor.Localidad
            LblProvProveedor.Text = myProveedor.Provincia
            LblTelProvredor.Text = myProveedor.Telefono1
            LblEmailProvredor.Text = myProveedor.Email
            LblIVAProvredor.Text = myProveedor.CodigoIva
            LblCuitProvredor.Text = myProveedor.Cuit
        End If
    End Sub

    Private Sub EmpleadoShowData(ByVal idEmpleado As Integer, ByVal stringConn As String)
        Dim myEmpleado As Pronto.ERP.BO.Empleado
        myEmpleado = EmpleadoManager.GetItem(stringConn, idEmpleado)
        If Not (myEmpleado Is Nothing) Then
            'LblTelComprador.Text = myEmpleado.
            'LblDirecProveedor.Text = myEmpleado.Direccion
        End If
    End Sub

    Private Sub GetRequrimientoAjax(ByVal idRequerimiento As Integer, ByVal empresaName As String)
        Response.Clear()
        Dim myRequerimiento As Pronto.ERP.BO.Requerimiento
        If idRequerimiento > 0 Then
            myRequerimiento = RequerimientoManager.GetItem(Encriptar(GetSC(empresaName)), idRequerimiento, True)
            If Not (myRequerimiento Is Nothing) Then
                lblNumero2.Text = myRequerimiento.Numero
                lblFecha2.Text = myRequerimiento.Fecha.ToString("dd/MM/yyyy")
                lblObra2.Text = myRequerimiento.Obra
                lblConfecciono.Text = myRequerimiento.Solicito
                lblSector.Text = myRequerimiento.Sector
                LblLugarEntrega.Text = myRequerimiento.LugarEntrega
                LblLiberada.Text = myRequerimiento.Aprobo
                LblEqDestino.Text = myRequerimiento.IdEquipoDestino
                LblFechaLib.Text = myRequerimiento.FechaAprobacion
                LblObs.Text = myRequerimiento.Observaciones
                LblDetalle.Text = myRequerimiento.Detalle
                GVRequerimientoItems.DataSource = myRequerimiento.Detalles
                GVRequerimientoItems.DataBind()
            End If
        End If
        Dim html As String = GetHtml(GVRequerimientoItems, PanelReq, PanelGrillaReq)


        Dim sNombreArchivo As String = "aaaa.html"
        File.WriteAllText(sNombreArchivo, html)



        Dim str As String
        str = "window.open('" & sNombreArchivo & "');"
        'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)


        'Response.Write(html)
        'Response.End()
    End Sub

    Private Sub GetPedidoAjax(ByVal idPedido As Integer, ByVal empresaName As String)
        Dim myPedido As Pronto.ERP.BO.Pedido
        Dim sc As String = GetSC(empresaName)
        If idPedido > 0 Then
            myPedido = PedidoManager.GetItem(Encriptar(GetSC(empresaName)), idPedido, True)
            If Not (myPedido Is Nothing) Then
                lblNumero.Text = myPedido.Numero
                lblFecha.Text = myPedido.Fecha.ToString("dd/MM/yyyy")
                LblContacto.Text = myPedido.Contacto
                lblObra.Text = myPedido.Obras
                LlblLiberado.Text = myPedido.Aprobo
                LblCondCompra.Text = myPedido.CondicionCompra
                LblCompador.Text = myPedido.Comprador
                LblAclaracion.Text = myPedido.DetalleCondicionCompra
                LblMoneda.Text = myPedido.Moneda & " (Cotiz.u$s : " & myPedido.CotizacionDolar & ")"
                lblMon4.Text = myPedido.Moneda
                LblNroComparativa.Text = myPedido.NumeroComparativa
                lblObservaciones.Text = myPedido.Observaciones
                lblSubtotal.Text = Format(myPedido.TotalPedido - myPedido.ImpuestosInternos - myPedido.TotalIva1, "#,##0.00")
                lblIVA.Text = Format(myPedido.TotalIva1, "#,##0.00")
                lblImpInt.Text = Format(myPedido.ImpuestosInternos, "#,##0.00")
                lblTotal.Text = Format(myPedido.TotalPedido, "#,##0.00")

                GVPedidoItems.DataSource = myPedido.Detalles
                GVPedidoItems.DataBind()
                ProveedorShowData(myPedido.IdProveedor, Encriptar(sc))
            End If
        End If

        Dim html As String = GetHtml(GVPedidoItems, PanelPed, PanelGrillaPed)
        Response.Write(html)
        Response.End()

    End Sub

    Function GetHtml(ByVal gv As GridView, ByVal panel As Panel, ByVal panelGrilla As Panel) As String
        Dim sb As StringBuilder = New StringBuilder()
        Dim tw As StringWriter = New StringWriter(sb)
        Dim hw As HtmlTextWriter = New HtmlTextWriter(tw)
        Dim page As Page = New Page()
        Dim form As HtmlForm = New HtmlForm()
        page.Controls.Add(form)
        form.Controls.Add(gv)
        panelGrilla.Controls.Add(form)
        panel.Visible = True
        panel.RenderControl(hw)
        panel.Visible = False
        Return sb.ToString
    End Function

    Function GetSC(ByVal empresaName As String) As String
        Dim empresaList As EmpresaList = EmpresaManager.GetEmpresasPorUsuario(HFSC.Value, GetUserId())
        Dim stringConn As String = String.Empty
        For Each empresa As Empresa In empresaList
            If (UCase(empresa.Descripcion) = UCase(empresaName)) Then
                stringConn = empresa.ConnectionString
            End If
        Next
        Return stringConn
    End Function

    Protected Sub btnMarcar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMarcar.Click
        Dim chkFirmar As CheckBox
        For Each fila As GridViewRow In GVFirmas.Rows
            Select Case fila.RowType
                Case DataControlRowType.DataRow
                    If TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                        chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                        chkFirmar.Checked = True
                    End If
            End Select
        Next
    End Sub

    Protected Sub btnDesmarcar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDesmarcar.Click
        Dim chkFirmar As CheckBox
        For Each fila As GridViewRow In GVFirmas.Rows
            Select Case fila.RowType
                Case DataControlRowType.DataRow
                    If TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                        chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                        chkFirmar.Checked = False
                    End If
            End Select
        Next
    End Sub

    Protected Sub btnFirmar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFirmar.Click
        Dim chkFirmar As CheckBox
        Dim keys(3) As String
        For Each fila As GridViewRow In GVFirmas.Rows
            Select Case fila.RowType
                Case DataControlRowType.DataRow
                    If TypeOf fila.FindControl("CheckBox1") Is CheckBox Then
                        chkFirmar = CType(fila.FindControl("CheckBox1"), CheckBox)
                        If chkFirmar.Checked Then
                            keys(0) = keys(0) & GVFirmas.DataKeys(fila.RowIndex).Values.Item(0).ToString & ","
                            keys(1) = keys(1) & GVFirmas.DataKeys(fila.RowIndex).Values.Item(1).ToString & ","
                            keys(2) = keys(2) & GVFirmas.DataKeys(fila.RowIndex).Values.Item(2).ToString & ","
                            keys(3) = keys(3) & GVFirmas.DataKeys(fila.RowIndex).Values.Item(3).ToString & ","
                        End If
                    End If
            End Select
        Next
        If Len(keys(0)) > 0 Then
            Dim BD As Array, IdFormulario As Array, IdComprobante As Array, NumeroOrden As Array
            Dim i As Integer
            Dim myConnection As SqlConnection = New SqlConnection(Encriptar(SCconexBDLmaster))
            Try
                Dim myCommand As SqlCommand = New SqlCommand("wFirmasDocumentos_PorBD", myConnection)
                myCommand.CommandType = CommandType.StoredProcedure
                myCommand.Parameters.Add("@BD", SqlDbType.VarChar)
                myCommand.Parameters.Add("@IdFormulario", SqlDbType.Int)
                myCommand.Parameters.Add("@IdComprobante", SqlDbType.Int)
                myCommand.Parameters.Add("@OrdenAutorizacion", SqlDbType.Int)
                myCommand.Parameters.Add("@Usuario", SqlDbType.VarChar)
                myConnection.Open()

                BD = Split(keys(0), ",")
                IdFormulario = Split(keys(1), ",")
                IdComprobante = Split(keys(2), ",")
                NumeroOrden = Split(keys(3), ",")
                For i = 0 To UBound(BD)
                    If Len(BD(i)) > 0 Then
                        myCommand.Parameters.Item("@BD").Value = BD(i)
                        myCommand.Parameters.Item("@IdFormulario").Value = IdFormulario(i)
                        myCommand.Parameters.Item("@IdComprobante").Value = IdComprobante(i)
                        myCommand.Parameters.Item("@OrdenAutorizacion").Value = NumeroOrden(i)
                        myCommand.Parameters.Item("@IdFormulario").Value = IdFormulario(i)
                        myCommand.Parameters.Item("@Usuario").Value = User.Identity.Name
                        myCommand.ExecuteNonQuery()
                    End If
                Next
                myConnection.Close()
            Finally
                CType(myConnection, IDisposable).Dispose()
            End Try
        End If

        Rebind()
    End Sub

End Class
