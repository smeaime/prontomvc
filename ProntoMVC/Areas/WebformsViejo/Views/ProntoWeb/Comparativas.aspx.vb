Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports System.IO
Imports Pronto.ERP.Bll.EntidadManager

Partial Class Comparativas
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
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////

            'TraerCuentaFFasociadaALaObra()

            'Debug.Print(Session("glbWebIdProveedor"))
            'If Not IsNumeric(Session("glbWebIdProveedor")) Then
            '    ResumenVisible(False)
            'Else
            '    'TraerResumenDeCuentaFF()
            '    Debug.Print(Session("glbWebIdProveedor"))
            '    BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor"))
            'End If

            Me.Title = "Comparativas"



            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            ElseIf Not (Request.QueryString.Get("Imprimir") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                Imprimir(Request.QueryString.Get("Imprimir")) 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If

            ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
        End If


        If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            LinkAgregarRenglon.Enabled = False
        Else
            LinkAgregarRenglon.Enabled = True
        End If
        Permisos()
    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, session(SESSIONPRONTO_UserId), "Comparativas")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            GridView1.Visible = False
            LinkAgregarRenglon.Visible = False
        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            GridView1.Columns(0).Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            GridView1.Columns(7).Visible = False
        End If

    End Sub


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

        s += " AND " & _
                                           "(  Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'   )" '_


        ''si es un usuario proveedor, filtro sus comprobantes
        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    GenerarWHERE += " AND  IdProveedor=" & Session("glbWebIdProveedor")
        'End If


        Select Case HFTipoFiltro.Value.ToString  '
            Case "", "AConfirmarEnObra"
                s += " AND (IdAprobo IS NULL OR IdAprobo=0 OR IdAprobo=-1)"
                's += " AND (ConfirmadoPorWeb='NO' OR ConfirmadoPorWeb IS NULL)"

            Case "AConfirmarEnCentral"
                s += " AND ( (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)  AND  (Aprobo IS NULL OR Aprobo=0) ) "

            Case "Confirmados"
                s += " AND (IdAprobo NOT IS NULL AND IdAprobo>0)"
                's += " AND (ConfirmadoPorWeb='SI' AND ConfirmadoPorWeb NOT IS NULL)"
        End Select


        Return s
    End Function

    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "edit"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdPresupuesto As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                Response.Redirect(String.Format("Comparativa.aspx?Id={0}", IdPresupuesto.ToString))
        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        'crea la grilla anidada con el detalle
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...

            'gp.Attributes.Add("runat", "server") 'esto lo agregué antes de solucionarlo con VerifyRenderingInServerForm
            ObjectDataSource2.SelectParameters(1).DefaultValue = DataBinder.Eval(e.Row.DataItem, "Id")
            Try
                gp.DataSource = ObjectDataSource2.Select
                gp.DataBind()
                If gp.Columns.Count > 0 Then gp.Columns(0).Visible = False 'oculto la columna del Id -no funciona
            Catch ex As Exception
                ErrHandler.WriteError(ex)
                Debug.Print(ex.Message)
                Throw New ApplicationException("Error en la grabacion " + ex.Message, ex)
            Finally
            End Try
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

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        GridView1.PageIndex = e.NewPageIndex
        Rebind()
    End Sub

    Sub Rebind()
        Dim pageIndex = GridView1.PageIndex
        ObjectDataSource1.FilterExpression = GenerarWHERE()
        Dim b As Data.DataView = ObjectDataSource1.Select()
        'Debug.Print(DebugGetDataTableColumnNames(b.d))
        'b.Sort = "[Fecha Factura],Numero DESC" ' e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection)
        'b.Sort = "[Fecha Factura] DESC,Numero DESC" 
        b.Sort = "Id DESC"
        ViewState("Sort") = b.Sort
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex
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
    '///////////////////////////////////


    Protected Sub cmbCuenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbCuenta.SelectedIndexChanged
        TraerResumenDeCuentaFF()
    End Sub


    Sub TraerCuentaFFasociadaALaObra()

        'cmbCuenta.DataSource = Pronto.ERP.Bll.ProveedorManager.GetListCombo(HFSC.Value)
        'cmbCuenta.DataTextField = "Titulo"
        'cmbCuenta.DataValueField = "IdProveedor"
        'cmbCuenta.DataBind()  'BEEEESSSTTIIAAA!!!! un combo con los proveedores?????? Eso es una pagina gordita!

        'If IsNumeric(Session("glbWebIdProveedor")) Then
        '    BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor")) 'uso datos de la tabla "empleados"
        '    'cmbCuenta.Enabled = False
        '    'ElseIf Pronto.ERP.Bll.ObraManager.GetItem(HFSC.Value, HFIdObra.Value).IdCuentaContableFF Then 'uso datos de la tabla "obras"
        '    '    BuscaIDEnCombo(cmbCuenta, Pronto.ERP.Bll.ObraManager.GetItem(HFSC.Value, HFIdObra.Value).IdCuentaContableFF)
        '    '    'cmbCuenta.Enabled = False
        'Else
        '    cmbCuenta.Items.Insert(0, New ListItem("-- Elija una Cuenta --", -1))
        '    cmbCuenta.SelectedIndex = 0
        'End If
    End Sub



    Sub TraerResumenDeCuentaFF()
        Dim dsTemp As System.Data.DataSet
        dsTemp = Pronto.ERP.Bll.EntidadManager.GetListTX(GetConnectionString(Server, Session), "FondosFijos", "TX_ResumenPorIdCuenta", cmbCuenta.SelectedValue)
        If dsTemp.Tables(0).Rows.Count > 0 Then
            ResumenVisible(True)
            With dsTemp.Tables(0).Rows(0)
                'txtPendientesReintegrar.Text = iisNull(.Item("PagosPendientesReintegrar"))
                'txtReposicionSolicitada.Text = iisNull(.Item("Reposicion solicitada"))
                'txtSaldo.Text = iisNull(.Item("Saldo"))
                'txtTotalAsignados.Text = iisNull(.Item("Fondos asignados"))

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
    End Sub


    '///////////////////////////////////
    '///////////////////////////////////
    'botones y links
    '///////////////////////////////////

    

    Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
        Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        GridViewExportUtil.Export("Grilla.xls", GridView1)
    End Sub

    '///////////////////////////////////
    '///////////////////////////////////
    'toggles
    '///////////////////////////////////

    Sub ResumenVisible(ByVal estado As Boolean)
        'txtPendientesReintegrar.Visible = estado
        'txtReposicionSolicitada.Visible = estado
        'txtSaldo.Visible = estado
        'txtTotalAsignados.Visible = estado
    End Sub



    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        ObjectDataSource1.FilterExpression = GenerarWHERE()
        '& " OR " & _
        '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"


        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub


    Sub Imprimir(ByVal IdComparativa)

        Dim myComparativa As Pronto.ERP.BO.Comparativa '= CType(Me.ViewState(mKey), Pronto.ERP.BO.Comparativa)

        Dim output As String
        output = ImpresionDeComparativa(myComparativa) 'Pronto imprime la planilla de la comparativa usando la Msflexgrid del frmComparativas...
        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
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

    End Sub

    Private Function ImpresionDeComparativa(ByVal myComparativa As Pronto.ERP.BO.Comparativa) As String 'Aunque la comparativa tiene plantilla, no llena los datos sola (de hecho, necesita de la gui de pronto)

        ''debug:
        'Debug.Print(Session("glbPathPlantillas"))
        ''Session("glbPathPlantillas")="\\192.168.66.2\DocumentosPronto\Plantillas"


        'Dim xlt As String = Session("glbPathPlantillas") & "\Comparativa_" & session(SESSIONPRONTO_NombreEmpresa) & ".xlt" '"C:\ProntoWeb\Proyectos\Pronto\Documentos\ComprasTerceros.xlt"
        'Dim output As String = Session("glbPathPlantillas") & "\archivo.xls" 'no funciona bien si uso el raíz





        'Dim MyFile1 As New FileInfo(xlt)
        'Try
        '    If Not MyFile1.Exists Then
        '        MsgBoxAjax(Me, "No se encuentra la plantilla " & xlt)
        '        Return Nothing
        '    End If

        '    MyFile1 = New FileInfo(output)
        '    If MyFile1.Exists Then
        '        MyFile1.Delete()
        '    End If

        'Catch ex As Exception
        '    MsgBoxAjax(Me, ex.Message)
        '    Return Nothing
        'End Try


        'Dim tab = ComparativaManager.GUI_DeDetalleAGrilla(SC, myComparativa, True)
        'Dim tabpie = TraerPie(SC, myComparativa)

        ''///////////////////////////////////////////
        ''///////////////////////////////////////////



        'Dim oEx AsCreateObject("Excel.Application")
        'Dim oBooks As Excel.Workbooks 'haciendolo así, no queda abierto el proceso en el servidor http://support.microsoft.com/?kbid=317109
        'Dim oBook As Excel.Workbook


        'Try
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////
        '    'Acá empieza codigo traido de pronto
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////
        '    '////////////////////////////////////////////////////////////////////////




        '    Dim oAp 
        '    Dim oRsPre As adodb.Recordset
        '    Dim oRsEmp As adodb.Recordset
        '    Dim i As Integer, cl As Integer, cl1 As Integer, fl As Integer
        '    Dim mvarPresu As Long, mvarSubNum As Long
        '    Dim mvarFecha As Date
        '    Dim mvarConfecciono As String, mvarAprobo As String, mvarMPrevisto As String, mvarMCompra As String, mvarMoneda As String
        '    Dim mvarLibero As String
        '    Dim mvarPrecioIdeal As Double, mvarPrecioReal As Double
        '    Dim mCabecera

        '    oAp = CrearAppCompronto(SC)

        '    Dim desplaz = 10

        '    With myComparativa
        '        mvarPresu = .Numero
        '        mvarFecha = .Fecha
        '        If IsNull(.IdConfecciono) Then
        '            mvarConfecciono = ""
        '        Else
        '            mvarConfecciono = EmpleadoManager.GetItem(SC, .IdConfecciono).Nombre
        '        End If
        '        If iisNull(.IdAprobo, 0) = 0 Then
        '            mvarAprobo = ""
        '        Else
        '            mvarAprobo = EmpleadoManager.GetItem(SC, .IdAprobo).Nombre
        '        End If
        '        If IsNull(.MontoPrevisto) Then
        '            mvarMPrevisto = ""
        '        Else
        '            mvarMPrevisto = Format(.MontoPrevisto, "Fixed")
        '        End If
        '        If IsNull(.MontoParaCompra) Then
        '            mvarMCompra = ""
        '        Else
        '            mvarMCompra = Format(.MontoParaCompra, "Fixed")
        '        End If
        '    End With



        '    oEx.Visible = False
        '    oBooks = oEx.Workbooks
        '    oBook = oBooks.Add(xlt)
        '    With oBook
        '        oEx.DisplayAlerts = False



        '        With .ActiveSheet

        '            .Name = "Comparativa"

        '            cl1 = 0
        '            For cl = 1 To gvCompara.Columns.Count - 1

        '                cl1 = cl1 + 1
        '                Dim subnumero As Integer = Int((cl1 - 3) / 2)

        '                For fl = 0 To tab.Rows.Count - 1 + 7 + 1 '7 son los renglones adicionales del pie




        '                    If fl = 0 Then
        '                        '////////////////////////////////////////////
        '                        '////////////////////////////////////////////
        '                        'Es la primera fila, le encajo los titulos
        '                        '////////////////////////////////////////////
        '                        '////////////////////////////////////////////

        '                        'Ampliar altura de fila de cabeceras de columna
        '                        If cl1 > 4 Then
        '                            If cl1 Mod 2 = 1 Then
        '                                'mCabecera = Split(gvCompara.Rows(fl).Cells(cl).Controls.Text, vbCrLf)
        '                                Dim p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = subnumero) 'uso tempi por lo del lambda en el find
        '                                If p Is Nothing Then Continue For
        '                                .Cells(fl + 7, cl1) = PresupuestoManager.GetItem(SC, p.IdPresupuesto).Proveedor

        '                                .Cells(fl + 7, cl1).Font.Bold = True
        '                                .Cells(fl + 9, cl1) = "Unitario "
        '                                .Cells(fl + 9, cl1 + 1) = "Total "
        '                                'mvarMoneda = mCabecera(2)
        '                                .Range(oEx.Cells(fl + 7, cl1), oEx.Cells(fl + 7, cl1 + 1)).Select()
        '                                With oEx.Selection
        '                                    .HorizontalAlignment = Excel.Constants.xlCenter
        '                                    .VerticalAlignment = Excel.Constants.xlCenter
        '                                    .WrapText = True
        '                                    .Orientation = 0
        '                                    .AddIndent = False
        '                                    .IndentLevel = 0
        '                                    .ShrinkToFit = False
        '                                    .MergeCells = True
        '                                End With
        '                                .Range(oEx.Cells(fl + 8, cl1), oEx.Cells(fl + 8, cl1 + 1)).Select()
        '                                With oEx.Selection
        '                                    .HorizontalAlignment = Excel.Constants.xlCenter
        '                                    .VerticalAlignment = Excel.Constants.xlCenter
        '                                    .WrapText = True
        '                                    .Orientation = 0
        '                                    .AddIndent = False
        '                                    .IndentLevel = 0
        '                                    .ShrinkToFit = False
        '                                    .MergeCells = True
        '                                End With
        '                                oEx.ActiveCell.FormulaR1C1 = "Precio"
        '                            End If
        '                        Else
        '                            'cosas que voy agregandole al original de edu para adaptarlo
        '                            Select Case cl1
        '                                Case 1
        '                                    .Cells(fl + 7, cl1) = "Item"
        '                                Case 2
        '                                    .Cells(fl + 7, cl1) = "Producto"
        '                                Case 3
        '                                    .Cells(fl + 7, cl1) = "Cantidad"
        '                                Case 4
        '                                    .Cells(fl + 7, cl1) = "Unidad"
        '                            End Select
        '                        End If
        '                    ElseIf fl > 0 And fl < tab.Rows.Count + 1 Then
        '                        '////////////////////////////////////////////
        '                        '////////////////////////////////////////////
        '                        'NO es la primera fila, es un renglon comun 
        '                        '////////////////////////////////////////////
        '                        '////////////////////////////////////////////

        '                        'If gvCompara.row = gvCompara.Rows - 2 Then
        '                        'rchObservacionesItems.TextRTF = gvCompara.Text
        '                        '.Cells(fl + 9, cl1) = rchObservacionesItems.Text
        '                        'Else
        '                        If cl1 > 4 And cl1 Mod 2 = 1 Then
        '                            .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Precio" & subnumero)
        '                            .Cells(fl + 9, cl1 + 1) = tab.Rows(fl - 1).Item("Total" & subnumero)
        '                        Else
        '                            Select Case cl1
        '                                Case 1
        '                                    .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Item")
        '                                Case 2
        '                                    .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Producto")
        '                                Case 3
        '                                    .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Cantidad")
        '                                Case 4
        '                                    .Cells(fl + 9, cl1) = tab.Rows(fl - 1).Item("Unidad")
        '                            End Select
        '                        End If
        '                        '& (iisNull(tab.Rows(fl).Item("Precio" & cl1 - 4), 0) * tab.Rows(fl).Item("Cantidad"))
        '                        'End If

        '                    Else
        '                        '////////////////////////////////////////////
        '                        '////////////////////////////////////////////
        '                        'es una fila del pie
        '                        '////////////////////////////////////////////
        '                        '////////////////////////////////////////////
        '                        If cl1 > 4 And cl1 Mod 2 = 1 Then
        '                            'valor
        '                            Dim p = myComparativa.Detalles.Find(Function(obj) obj.SubNumero = subnumero) 'uso tempi por lo del lambda en el find
        '                            If p Is Nothing Then Continue For
        '                            Debug.Print(tabpie.Rows(fl - tab.Rows.Count - 1).Item(subnumero))
        '                            .Cells(fl + desplaz, cl1 + 1) = tabpie.Rows(fl - tab.Rows.Count - 1).Item(subnumero)
        '                        Else
        '                            If cl1 = 4 Then
        '                                'titulo
        '                                Select Case fl - tab.Rows.Count
        '                                    Case 0
        '                                        .Cells(fl + desplaz + 1, cl1) = "Subtotal"
        '                                    Case 1
        '                                        .Cells(fl + desplaz + 1, cl1) = "Bonificacion"
        '                                    Case 2
        '                                        .Cells(fl + desplaz + 1, cl1) = "TOTAL"
        '                                    Case 3
        '                                        .Cells(fl + desplaz + 1, cl1) = "Plazo de entrega"
        '                                    Case 4
        '                                        .Cells(fl + desplaz + 1, cl1) = "Condicion de pago"
        '                                    Case 5
        '                                        .Cells(fl + desplaz + 1, cl1) = "Observaciones"
        '                                    Case 6
        '                                        .Cells(fl + desplaz + 1, cl1) = "Solicitud de cotizacion nro."
        '                                End Select
        '                            End If
        '                        End If
        '                    End If




        '                    '//////////////////////////////////////////////
        '                    'Modifica formato de celdas con precios comparados
        '                    If cl1 > 4 And fl > 0 And fl <= tab.Rows.Count Then 'And IsNumeric(gvCompara.Text) Then
        '                        If iisNull(tab.Rows(fl - 1).Item("M" & subnumero), False) Then
        '                            .Cells(fl + 9, cl1).Font.Bold = True
        '                        End If

        '                        'If fl >= gvCompara.Rows - 7 Then
        '                        .Cells(fl + 9, cl1).NumberFormat = "#,##0.00"
        '                        'Else
        '                        '.Cells(fl + 9, cl1).NumberFormat = "#,##0.0000"
        '                        'End If
        '                    End If
        '                    '//////////////////////////////////////////////


        '                Next
        '            Next



        '            '//////////////////////////////////////////////
        '            'Informacion en celdas sueltas
        '            '//////////////////////////////////////////////
        '            .Cells(2, 5) = "COMPARATIVA Nro. : " & mvarPresu
        '            .Cells(3, 5) = "FECHA : " & mvarFecha
        '            .Cells(4, 5) = "Comprador/a : " & mvarConfecciono
        '            '.Cells(5, 2) = "Obra/s : " & txtObras.Text
        '            '.Cells(6, 2) = "RM / LA : " & txtNumeroRequerimiento.Text

        '            .Cells(gvCompara.Rows.Count + 13, 1).Select()
        '            .Rows(gvCompara.Rows.Count + 13).RowHeight = 25
        '            .Cells(gvCompara.Rows.Count + 13, 1) = "Obs.Grales. : " & myComparativa.Observaciones

        '            .Cells(gvCompara.Rows.Count + 14, 1).Select()
        '            .Rows(gvCompara.Rows.Count + 14).RowHeight = 10
        '            .Cells(gvCompara.Rows.Count + 14, 1) = "Monto previsto : " & myComparativa.MontoPrevisto

        '            .Cells(gvCompara.Rows.Count + 15, 1).Select()
        '            .Rows(gvCompara.Rows.Count + 15).RowHeight = 10
        '            .Cells(gvCompara.Rows.Count + 15, 1) = "Monto para compra : " & myComparativa.MontoParaCompra
        '            '//////////////////////////////////////////////
        '            '//////////////////////////////////////////////

        '            '//////////////////////////////////////////////
        '            '//////////////////////////////////////////////
        '            'Formateo (pensé que era el pie, pero no
        '            '//////////////////////////////////////////////
        '            '//////////////////////////////////////////////
        '            'cl1 = 0
        '            'For cl = 1 To gvCompara.Columns.Count - 1
        '            '    cl1 = cl1 + 1
        '            '    If cl1 > 4 And cl1 Mod 2 = 1 Then


        '            '        .Range(oEx.Cells(fl + desplaz, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
        '            '        With oEx.Selection
        '            '            .HorizontalAlignment = Excel.Constants.xlCenter
        '            '            .VerticalAlignment = Excel.Constants.xlCenter
        '            '            .WrapText = True
        '            '            .AddIndent = False
        '            '            .MergeCells = True
        '            '        End With
        '            '        .Range(oEx.Cells(gvCompara.Rows.Count, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
        '            '        With oEx.Selection
        '            '            .HorizontalAlignment = Excel.Constants.xlCenter
        '            '            .VerticalAlignment = Excel.Constants.xlCenter
        '            '            .WrapText = True
        '            '            .AddIndent = False
        '            '            .MergeCells = True
        '            '        End With
        '            '        .Range(oEx.Cells(fl + desplaz, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
        '            '        With oEx.Selection
        '            '            .HorizontalAlignment = Excel.Constants.xlLeft
        '            '            .VerticalAlignment = Excel.Constants.xlCenter
        '            '            .WrapText = True
        '            '            .AddIndent = False
        '            '            .MergeCells = True
        '            '        End With
        '            '        .Range(oEx.Cells(fl + desplaz, cl1), oEx.Cells(fl + desplaz, cl1 + 1)).Select()
        '            '        With oEx.Selection
        '            '            .HorizontalAlignment = Excel.Constants.xlCenter
        '            '            .VerticalAlignment = Excel.Constants.xlCenter
        '            '            .WrapText = True
        '            '            .AddIndent = False
        '            '            .MergeCells = True
        '            '        End With



        '            '    End If
        '            'Next



        '            '//////////////////////////////////////////////
        '            '//////////////////////////////////////////////
        '            '//////////////////////////////////////////////

        '            mvarLibero = ""
        '            If iisNull(myComparativa.IdAprobo, 0) <> 0 Then
        '                mvarLibero = "" & EmpleadoManager.GetItem(SC, myComparativa.IdAprobo).Nombre
        '                If Not IsNull(myComparativa.FechaAprobacion) Then
        '                    mvarLibero = mvarLibero & "  " & myComparativa.FechaAprobacion
        '                End If
        '            End If

        '            oEx.Rows(gvCompara.Rows.Count + 6).RowHeight = 25
        '            oEx.Rows(gvCompara.Rows.Count + 7).RowHeight = 25

        '        End With





        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////
        '        'Acá termina codigo traido de pronto
        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////
        '        '////////////////////////////////////////////////////////////////////////

        '        'ejecuto la macro
        '        Dim s As String = "'" & .Name & "'!" & "ArmarFormato"


        '        Debug.Print("Emision """ & DebugCadenaImprimible(Encriptar(SC)) & """,""" & myComparativa.Id & """,""" & mvarLibero & """,""" & Session("glbPathPlantillas") & """,""" & session(SESSIONPRONTO_NombreEmpresa) & """,""A4""")

        '        'me funciona acá, pero no puedo hacer que funcione remoto
        '        'oEx.Run(s, Encriptar(SC), myComparativa.Id, mvarLibero, Session("glbPathPlantillas"), session(SESSIONPRONTO_NombreEmpresa), "A4")



        '        oEx.Cells(fl + desplaz - 6, 4) = "Subtotal"
        '        'oEx.Cells(fl + 5, 3) = "Bonificacion"
        '        'oEx.Cells(fl + 6, 3) = "TOTAL"





        '        .SaveAs(output, 56) '= xlExcel8 (97-2003 format in Excel 2007-2010, xls) 'no te preocupes, que acá solo llega cuando terminó de ejecutar el script de excel

        '        oEx.DisplayAlerts = True
        '    End With

        'Catch ex As Exception
        '    MsgBoxAjax(Me, ex.Message & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla")
        '    Return Nothing
        'Finally
        '    If Not oBook Is Nothing Then oBook.Close(False)
        '    NAR(oBook)
        '    If Not oBooks Is Nothing Then oBooks.Close()
        '    NAR(oBooks)
        '    'quit and dispose app
        '    oEx.Quit()
        '    NAR(oEx)
        '    'VERY IMPORTANT
        '    GC.Collect()
        'End Try



        'Return output


    End Function

End Class
