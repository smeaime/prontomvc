Imports System.IO
Imports System.Data
Imports Pronto.ERP.Bll
Imports System.Linq


Imports CartaDePorteManager

Partial Class ProntoWeb_Principal
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        HFSC.Value = GetConnectionString(Server, Session)
        'Rebind()







        'If BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(HFSC.Value) = "Williams" Then

        Dim rol = Roles.GetRolesForUser(Membership.GetUser().UserName) ' (Session(SESSIONPRONTO_UserName))

        If rol.Count > 0 AndAlso rol(0) = "WilliamsCliente" Then
            Response.Redirect(String.Format("~/ProntoWeb/CartaDePorteInformesAccesoClientes.aspx"))
        Else
            Response.Redirect(String.Format("~/ProntoWeb/CartasDePortes.aspx?tipo=Todas"))
            'Server.Transfer(String.Format("~/ProntoWeb/CartasDePortes.aspx?tipo=Descargas"))
        End If

        'ElseIf BDLMasterEmpresasManager.EmpresaPropietariaDeLaBase(HFSC.Value) = "Autotrol" Then
        '    Response.Redirect(String.Format("~/ProntoWeb/RequerimientosB.aspx?tipo=Todas"))

        'End If

        If InStr(Request.Url.ToString, "Principal") = 0 Then
            Response.Redirect(String.Format("~/ProntoWeb/Principal.aspx"))
        End If








        'Dim FilePath As String = lnkAdjunto1.Text  'si lo grabó el pronto, va a venir con el directorio original...
        Dim FileName As String = System.IO.Path.GetFileName("\")
        Dim MyFile As New FileInfo("Debug.bat")
        'If MyFile.Exists Then
        If ConfigurationManager.AppSettings("Debug") = "SI" Then
            Button1.Visible = True
            Button2.Visible = True
            Button3.Visible = True
            Button8.Visible = True
        Else
            Button1.Visible = False
            Button2.Visible = False
            Button3.Visible = False
            Button8.Visible = False
        End If



        'Try
        '    Dim NombreArchivo As String = ErrHandler2.WriteError("Prueba")
        '    If InStr(NombreArchivo, "Error") = 0 Then
        '        MsgBoxAjax(Me, "El directorio de log de errores no está habilitado o el archivo " & NombreArchivo & "  está en modo de solo lectura")
        '    End If
        'Catch ex As Exception
        '    MsgBoxAjax(Me, "El directorio de log de errores no está habilitado. " & ex.ToString)
        'End Try





        If Not IsPostBack Then
            Try
                If Session("DebugPronto") = "SI" Then
                    Tests.TestAsiento(Me, HFSC.Value, Session)
                    MsgBoxAjax(Me, "MODO DEBUG: Test terminado")
                    Exit Sub
                End If

            Catch ex As Exception
                MsgBoxAjax(Me, "MODO DEBUG: Test terminado" + ex.ToString)
                Exit Sub
            End Try

            Dim tb = Me.Master.FindControl("txtSuperbuscador")
            ScriptManager.GetCurrent(Me).SetFocus(tb)
        End If

        'debug
        'Dim usuario As Usuario
        'Dim sc As String
        'usuario = New Usuario
        'usuario = session(SESSIONPRONTO_USUARIO)
        'sc = usuario.StringConnection
        'Dim depurandoRM As Pronto.ERP.BO.RequerimientoList = Pronto.ERP.Bll.RequerimientoManager.GetList(sc)
        'Dim depurandoPED As Pronto.ERP.BO.PedidoList = Pronto.ERP.Bll.PedidoManager.GetList(sc)
        'Dim depurandoPRE As Pronto.ERP.BO.PresupuestoList = Pronto.ERP.Bll.PresupuestoManager.GetList(sc)
        'Dim depurandoCOMP As Pronto.ERP.BO.ComparativaList = Pronto.ERP.Bll.ComparativaManager.GetList(sc)


    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Links de mapa de compras 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click
        Response.Redirect(String.Format("frmConsultaRMsPendientesDeAsignacion.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton3.Click
        Response.Redirect(String.Format("Presupuesto.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton4.Click
        Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Response.Redirect(String.Format("Requerimiento.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton5.Click
        Response.Redirect(String.Format("Pedido.aspx?Id=-1"))
    End Sub


    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    ' Tests 
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        '        Tests.Firmas(sc, Session)
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestFondoFijo(sc, Session)
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        'Tests.TestSolicitudes(sc, Session)
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection
        ' Tests.Firmas(sc, Session)
        'Tests.TestFondoFijo(sc, Session)
        'Tests.TestSolicitudes(sc, Session)
    End Sub



    Protected Sub gvEstadoPorTrs_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand

        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdEntidad As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Item("Id"))
                'Dim IdTipoEntidad As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Item("Tipo"))
                Dim sTipoEntidad As String = GridView1.DataKeys(rowIndex).Item("Tipo")




                Dim sUrl = AbrirSegunTipoEntidad(sTipoEntidad, IdEntidad)





                If True Then
                    'metodo 1: abro usando la misma ventana
                    Response.Redirect(sUrl)
                Else
                    'metodo 2
                    'abro otra ventana. probablemente sea mejor hacerlo con un Hiperlink
                    Dim str As String
                    str = "window.open('" & sUrl & "');"
                    'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
                    AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)
                End If
        End Select

    End Sub




    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection

        'Tests.ImportarArticulosWilliams(sc)
        'Tests.ImportarHumedadesWilliams(sc)
        'Tests.ImportarChoferesWilliams(sc)
        'Tests.ImportarTransportistasWilliams(sc)
        'Tests.ImportarCalidadesWilliams(sc)

    End Sub




    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button5.Click
        Dim usuario As Usuario
        Dim sc As String
        usuario = New Usuario
        usuario = Session(SESSIONPRONTO_USUARIO)
        sc = usuario.StringConnection

        ' ImportarListaDePrecios()

        'Tests.ImportarArticulosWilliams(sc)
        'Tests.ImportarHumedadesWilliams(sc)
        'Tests.ImportarChoferesWilliams(sc)
        'Tests.ImportarTransportistasWilliams(sc)
        'Tests.ImportarCalidadesWilliams(sc)

    End Sub














    Sub Rebind()

        Try

            Dim pageIndex = GridView1.PageIndex



            Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, "wUltimosComprobantesCreados", "")


            'dt.add("Nueva RM", "Requerimiento?=-1")



            'chupo
            'Dim dt As DataTable = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.ComprobantesProveedores_TT).Tables(0)
            'Dim dt As DataTable = RequerimientoManager.GetListTXDetallesPendientes(SC).Tables(0) ' EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_Pendientes1).Tables(0)
            'filtro
            'dt = DataTableWHERE(dt, GenerarWHERE)
            'ordeno


            With dt
                '.Columns("IdComprobanteProveedor").ColumnName = "Id"
                '.Columns("Factura").ColumnName = "Numero"
                '.Columns("FechaFactura").ColumnName = "Fecha"
            End With


            Dim b As Data.DataView = DataTableORDER(dt, "Fecha DESC")



            'b.Sort = "IdDetalleRequerimiento DESC"
            'ObjectDataSource1.FilterExpression = GenerarWHERE()
            'Dim b As Data.DataView = ObjectDataSource1.Select()

            'b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
            'b.Sort = "Fecha DESC,Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
            'b.Sort = "Id DESC"

            ViewState("Sort") = b.Sort
            GridView1.DataSourceID = ""
            GridView1.DataSource = b
            GridView1.DataBind()
            GridView1.PageIndex = pageIndex
        Catch ex As Exception

        End Try

    End Sub

End Class


