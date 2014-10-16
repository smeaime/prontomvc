Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports Excel = Microsoft.Office.Interop.Excel
Imports System.IO

Partial Class ComprobantesProveedor
    Inherits System.Web.UI.Page

    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, session(SESSIONPRONTO_glbIdObraAsignadaUsuario))

        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            TraerCuentaFFasociadaALaObra()


            If Not IsNumeric(Session("glbIdCuentaFFUsuario")) Then
                ResumenVisible(False)
            Else
                TraerResumenDeCuentaFF()
                BuscaIDEnCombo(cmbCuenta, Session("glbIdCuentaFFUsuario"))
            End If



            cmbCuenta.Enabled = False
            Dim rol() As String
            rol = Roles.GetRolesForUser()
            For Each x As String In rol
                If x = "Administrador" Then
                    cmbCuenta.Enabled = True
                End If
            Next


            Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
            Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)
            txtFechaDesde.Text = GetFirstDayInMonth(Today)
            txtFechahasta.Text = GetLastDayInMonth(Today)



            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo")
            Else
                HFTipoFiltro.Value = ""
            End If
        End If

        Me.Title = "Fondos Fijos"


    End Sub



    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdComprobanteProveedor As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("FondoFijo.aspx?Id={0}", IdComprobanteProveedor.ToString))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")

            gp.DataSource = ObjectDataSource2.Select
            gp.DataBind()
            gp.Width = 200
        End If
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        'Dim records(e.NewValues.Count - 1) As DictionaryEntry
        'e.NewValues.CopyTo(records, 0)

        'Dim entry As DictionaryEntry
        'For Each entry In records
        '    e.NewValues(entry.Key) = CType(Server.HtmlEncode(entry.Value.ToString()), DateTime)
        'Next
    End Sub


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'Combos
    '////////////////////////////////////////////////////////////////////////////////////

    Private Sub BindTypeDropDown()
        'cmbCuenta.DataSource = Pronto.ERP.Bll.CuentaManager.GetListCombo(SC)
        'cmbCuenta.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")

        'sieltipo tiene una obra asignada, qué hago acá?
        TraerCuentaFFasociadaALaObra()




    End Sub




    '///////////////////////////////////
    '///////////////////////////////////
    'refrescos
    '(el datasource de la grilla se refresca automaticamente. 
    '    Se llama a ComprobanteProveedorManager.GetList_FondosFijos
    '    Los parametros estan en la seccion <SelectParameters> del datasource)
    '///////////////////////////////////


    Protected Sub txtRendicion_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtRendicion.TextChanged
        TraerResumenDeCuentaFF()

        'UpdatePanelResumen.Update()

    End Sub

    Protected Sub cmbCuenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCuenta.SelectedIndexChanged

        'traigo la rendicion actual de la cuenta elegida
        txtRendicion.Text = iisNull(EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))

        TraerResumenDeCuentaFF()



        'UpdatePanelResumen.Update()

        ''traerme las OP o los CP y filtrarlos por IdCuenta=IdCuentaFF, y ahí hacer un distinct de el NumeroRendicionFF

        ''/////////////////////////////////////////
        ''Traigo tambien las rendiciones
        'cmbRendicion.DataSource = EntidadManager.GetListTX(HFSC.Value, "FondosFijos", "TX_RendicionesPorIdCuentaParaCombo", cmbCuenta.SelectedValue)
        ''y si hago una consulta dinámica?

        'cmbRendicion.DataTextField = "Titulo"
        'cmbRendicion.DataValueField = "Rendicion"
        'cmbRendicion.DataBind()

    End Sub



    Sub TraerCuentaFFasociadaALaObra()

        cmbCuenta.DataSource = EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_FondosFijos", DBNull.Value)
        cmbCuenta.DataTextField = "Titulo"
        cmbCuenta.DataValueField = "IdCuenta"
        cmbCuenta.DataBind()

        Try
            If IsNumeric(Session("glbIdCuentaFFUsuario")) Then
                BuscaIDEnCombo(cmbCuenta, Session("glbIdCuentaFFUsuario")) 'uso datos de la tabla "empleados"
                'cmbCuenta.Enabled = False
            ElseIf ObraManager.GetItem(HFSC.Value, HFIdObra.Value).IdCuentaContableFF Then 'uso datos de la tabla "obras"
                BuscaIDEnCombo(cmbCuenta, ObraManager.GetItem(HFSC.Value, HFIdObra.Value).IdCuentaContableFF)
                'cmbCuenta.Enabled = False
            Else
                cmbCuenta.Items.Insert(0, New ListItem("-- Elija una Cuenta --", -1))
                cmbCuenta.SelectedIndex = 0
            End If
        Catch ex As Exception
        End Try

    End Sub

    Sub TraerResumenDeCuentaFF()
        Dim dsTemp As System.Data.DataSet


        If IsNumeric(txtRendicion.Text) Then
            'uso los sp de la plantilla ComprasTerceros.xlt  

            ResumenVisible(True)
            dsTemp = EntidadManager.GetListTX(HFSC.Value, "OrdenesPago", "TX_ResumenPorRendicionFF", cmbCuenta.SelectedValue, txtRendicion.Text) ' cmbRendicion.SelectedValue)
            With dsTemp.Tables(0).Rows(0)
                txtPendientesReintegrar.Text = iisNull(.Item("TotalPendiente"), 0)
                txtTotalAsignados.Text = iisNull(.Item("FondoAsignado"), 0)
            End With


            dsTemp = EntidadManager.GetListTX(HFSC.Value, "ComprobantesProveedores", "TX_ResumenPorRendicionFF", cmbCuenta.SelectedValue, txtRendicion.Text, -1)
            'guarda, acá sumo COLUMNAS
            With dsTemp.Tables(0)
                txtReposicionSolicitada.Text = iisNull(.Compute("Sum(Neto)+Sum(IVA)+Sum(Percepciones)", ""), 0)
            End With


            txtSaldo.Text = txtTotalAsignados.Text - txtPendientesReintegrar.Text - txtReposicionSolicitada.Text





        Else
            'uso el SP del resumen (el informe que incluye todas las rendiciones)
            dsTemp = EntidadManager.GetListTX(HFSC.Value, "FondosFijos", "TX_ResumenPorIdCuenta", cmbCuenta.SelectedValue)


            If dsTemp.Tables(0).Rows.Count > 0 Then
                ResumenVisible(True)
                With dsTemp.Tables(0).Rows(0)
                    txtPendientesReintegrar.Text = iisNull(.Item("PagosPendientesReintegrar"))
                    txtReposicionSolicitada.Text = iisNull(.Item("Reposicion solicitada"))
                    txtSaldo.Text = iisNull(.Item("Saldo"))
                    txtTotalAsignados.Text = iisNull(.Item("Fondos asignados"))

                    'Campos de FondosFijos_TX_Resumen:
                    'IdCuenta,
                    '[Cuenta FF],
                    '[Rendicion],
                    '[Fondos asignados],
                    '[Reposicion solicitada],
                    '[Rendiciones reintegradas],
                    ' IsNull(FondosAsignados,0)-IsNull(ReposicionSolicitada,0)+IsNull(RendicionesReintegradas,0) as [Saldo],
                    ' PagosPendientesReintegrar as [PagosPendientesReintegrar],

                End With
            Else
                ResumenVisible(False)
            End If
        End If
    End Sub


    '///////////////////////////////////
    '///////////////////////////////////
    'botones y links
    '///////////////////////////////////

    'Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
    '    Response.Redirect(String.Format("FondoFijo.aspx?Id=-1"))
    'End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Response.Redirect(String.Format("FondoFijo.aspx?Id=-1"))
    'End Sub

    'Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
    '    GridViewExportUtil.Export("Grilla.xls", GridView1)
    'End Sub

    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        Response.Redirect(String.Format("FondoFijo.aspx?Id=-1"))
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        GridViewExportUtil.Export("Grilla.xls", GridView1)
    End Sub

    '///////////////////////////////////
    '///////////////////////////////////
    'toggles
    '///////////////////////////////////

    Sub ResumenVisible(ByVal estado As Boolean)
        txtPendientesReintegrar.Visible = estado
        txtReposicionSolicitada.Visible = estado
        txtSaldo.Visible = estado
        txtTotalAsignados.Visible = estado
    End Sub




    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click

        'Verificar:
        '1) Permisos ASPNET (o IUSR_<machine> si usas impersonate)   
        '        http://geeks.ms/blogs/lruiz/archive/2007/03/15/como-utilizar-com-interop-office-excel-en-tus-proyectos-asp-net-y-no-morir-en-el-intento.aspx  
        '        http://blog.crowe.co.nz/archive/2006/03/02/589.aspx  
        '   Reiniciar IIS
        '2) Trust Center de Excel 07
        '3) ComPronto mal referenciada en la plantilla XLT
        '4) Hotfix     http://kbalertz.com/968494/Description-Excel-hotfix-March.aspx


        'http://www.developerdotstar.com/community/automate_excel_dotnet


        If cmbCuenta.SelectedValue = -1 Or Not IsNumeric(txtRendicion.Text) Then
            'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
            MsgBoxAjax(Me, "Elija una Cuenta y Rendición")
            Exit Sub
        End If
        Dim Rendicion As Integer = txtRendicion.Text 'iisNull(Pronto.ERP.Bll.EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
        Dim mImprime As String = "N"
        Dim mObra As Long = iisNull(session(SESSIONPRONTO_glbIdObraAsignadaUsuario), -1)

        '///////////////////////////////////////////
        '///////////////////////////////////////////
        'es importante en estos dos archivos poner bien el directorio. 
        Dim xlt As String = Session("glbPathPlantillas") & "\WebComprasTerceros.xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        'Dim xlt As String = Server.MapPath("../..WebComprasTerceros.xlt")

        'Dim xlt As String = "\\192.168.66.2\inetpub\wwwroot\WebComprasTerceros.xlt" 'Server.MapPath("../..WebComprasTerceros) 'http://support.microsoft.com/kb/311731/es   C:\Inetpub\Wwwroot
        'Dim output As String = Path.GetTempPath() & "archivo.xls" 'no funciona bien si uso el raíz
        Dim output As String = Session("glbPathPlantillas") & "\archivo.xls" 'no funciona bien si uso el raíz


        Dim MyFile1 As New FileInfo(xlt)
        Try
            If Not MyFile1.Exists Then
                MsgBoxAjax(Me, "No se encuentra la plantilla " & xlt)
                Return
            End If

            MyFile1 = New FileInfo(output)
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If

        Catch ex As Exception
            MsgBoxAjax(Me, ex.Message)
            Return
        End Try

        '///////////////////////////////////////////
        '///////////////////////////////////////////






        Dim oEx As Excel.Application
        Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        Dim oBook As Excel.Workbook


        Try
            'oEx = CreateObject("Excel.Application")
            oEx.Visible = False

            oBooks = oEx.Workbooks



            'estaría bueno que si acá tarda mucho, salga
            'puede colgarse en este Add o en el Run. Creo que se cuelga en el Add si no tiene
            '  permisos, y en el Run si está mal referenciada la dll
            '-pero se pianta porque no tiene permisos para usar el Excel, o por no poder usar la carpeta con el archivo?
            oBook = oBooks.Add(xlt)


            'ProntoFuncionesUIWeb.Current_Alert("Hasta aca llega")
            'Return


            With oBook


                'Declaracion de la funcion en la plantilla:
                'Public Sub GenerarResFF(ByVal StringConexion As String, _
                '            ByVal Rendicion As Long, _
                '            ByVal IdCuentaFF As Long, _
                '            ByVal mEmpresa As String, _
                '            ByVal mImprime As String, _
                '            ByVal mCopias As Integer, _
                '            ByVal IdObra As Long)




                oEx.DisplayAlerts = False

                'txtPendientesReintegrar.Text = Encriptar(HFSC.Value)
                'ProntoFuncionesUIWeb.Current_Alert("Depurar GenerarResFF " & Encriptar(HFSC.Value) & " " & Rendicion & " " & cmbCuenta.SelectedValue & " EmpresaNombre " & mImprime & " 1 " & mObra)
                'Return

                'Try

                '//////////////////////
                'ejecuto la macro
                Dim s As String = "'" & .Name & "'!GenerarResFF"

                oEx.Run(s, Encriptar(HFSC.Value), txtRendicion.Text, cmbCuenta.SelectedValue, "EmpresaNombre", mImprime, 1, mObra)
                '//////////////////////



                'Catch ex As Exception
                'ProntoFuncionesUIWeb.Current_Alert("Llega a ejecutar la macro")
                'Return
                'End Try



                .SaveAs(output, 56) '= xlExcel8 (97-2003 format in Excel 2007-2010, xls) 'no te preocupes, que acá solo llega cuando terminó de ejecutar el script de excel

                'oEx.SaveWorkspace(output) 'no usar esto, usar el del workbook
                oEx.DisplayAlerts = True
            End With





            'ProntoFuncionesUIWeb.Current_Alert("Ahora se va a transmitir")

        Catch ex As Exception
            MsgBoxAjax(Me, ex.Message & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla")
            Return
        Finally
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBook)
            'oBook = Nothing
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oBooks)
            'oBooks = Nothing
            'oEx.Quit()
            'System.Runtime.InteropServices.Marshal.ReleaseComObject(oEx)
            'oEx = Nothing
            'http://forums.devx.com/showthread.php?threadid=155202
            'MAKE SURE TO KILL ALL INSTANCES BEFORE QUITING! if you fail to do this
            'The service (excel.exe) will continue to run
            If Not oBook Is Nothing Then oBook.Close(False)
            NAR(oBook)
            oBooks.Close()
            NAR(oBooks)
            'quit and dispose app
            oEx.Quit()
            NAR(oEx)
            'VERY IMPORTANT
            GC.Collect()
        End Try




        Try
            MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output)
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.Message)
            Return
        End Try



        ''Mandar el excel al cliente
        'HttpContext.Current.Response.Clear()
        'HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", fileName))
        'HttpContext.Current.Response.ContentType = "application/ms-excel"
        'Dim sw As StringWriter = New StringWriter
        'Dim htw As HtmlTextWriter = New HtmlTextWriter(sw)
        ''  Create a form to contain the grid
        'Dim table As Table = New Table
        'table.GridLines = gv.GridLines
        ''  render the table into the htmlwriter
        'table.RenderControl(htw)
        ''  render the htmlwriter into the response
        'HttpContext.Current.Response.Write(sw.ToString)
        'HttpContext.Current.Response.End()



    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        If cmbCuenta.SelectedValue = -1 Then
            'ProntoFuncionesUIWeb.MsgBoxAjax(Me, "Elija una Cuenta")
            MsgBoxAjax(Me, "Elija una Cuenta")
            Exit Sub
        End If

        Dim Rendicion As Integer = iisNull(EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))

        'verficar que haya una op complementaria


        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////
        ''Uso de Compronto
        ''Alta de la segunda Orden de Pago (la complementaria) que se usa para cerrar una rendicion
        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////

        'Dim Aplicacion = CrearAppCompronto(HFSC.Value)

        'Dim oOP 'As ComPronto.OrdenPago 
        'Dim DetOP 'As ComPronto.DetOrdenPago 

        'oOP = Aplicacion.OrdenesPago.Item(-1)


        'With oOP.Registro
        '    .Fields("opcion fondo fijo").Value = "SI"
        '    .Fields("inic?").Value = "SI"

        '    .Fields("Observaciones").Value = "La op de FF necesita una observacion"


        'End With


        'Dim DetOPV 'As ComPronto.DetOrdenPagoValores 
        'DetOPV = oOP.DetOrdenesPagoValores.Item(-1)
        'With DetOPV.Registro
        '    .Fields("Cuenta").Value = 1 'buscar("Caja")
        '    .Fields("Monto").Value = 10000

        'End With
        'DetOPV.Modificado = True


        'Dim DetOPrc 'As ComPronto.DetOrdenPagoRubrosContables 
        'DetOPrc = oOP.DetOrdenesPagoRubrosContables.Item(-1)
        'With DetOPrc.Registro
        '    .Fields("Cuenta").Value = 1 'buscar("Caja")
        '    .Fields("Monto").Value = 10000 'el mismo monto que puse en valores

        'End With
        'DetOPrc.Modificado = True


        ''esto (el asiento) lo genera automaticamente el form. Lo hace el objeto? Si no, lo tengo que hacer a mano 
        'Dim DetOPcu 'As ComPronto.DetOrdenPagoCuentas 
        'DetOPcu = oOP.DetOrdenesPagoCuentas.Item(-1)
        'With DetOPcu.Registro
        '    .Fields("Cuenta").Value = 1 'buscar("Caja")
        '    .Fields("Monto").Value = 10000 'el mismo monto que puse en valores
        'End With
        'DetOPcu.Modificado = True
        'DetOPcu = oOP.DetOrdenesPagoCuentas.Item(-1)
        'With DetOPcu.Registro
        '    .Fields("Cuenta").Value = 1 'buscar("cuenta de fondo fijo")
        '    .Fields("Monto").Value = 10000 'el mismo monto que puse en valores
        'End With
        'DetOPcu.Modificado = True



        'oOP.Guardar()
        'oOP = Nothing



        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////
        ''///////////////////////////////////////////////////////

        EntidadManager.Tarea(HFSC.Value, "Cuentas_IncrementarRendicionFF", cmbCuenta.SelectedValue, Rendicion + 1)



        txtRendicion.Text = iisNull(EntidadManager.GetListTX(HFSC.Value, "Cuentas", "TX_PorId", cmbCuenta.SelectedValue).Tables(0).Rows(0).Item("NumeroAuxiliar"))
        TraerResumenDeCuentaFF()


    End Sub


End Class
