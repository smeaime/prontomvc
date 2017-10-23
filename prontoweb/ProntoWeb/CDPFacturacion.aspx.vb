Imports Pronto.ERP.Bll
Imports Pronto.ERP.BO
Imports System.Diagnostics 'para usar Debug.Print
Imports ExcelOffice = Microsoft.Office.Interop.Excel
Imports Pronto.ERP.Bll.ParametroManager
Imports System.Data
Imports System.IO
Imports System.Linq
Imports ProntoFuncionesGenerales
Imports FuncionesUIWebCSharp

Imports System.Data.SqlClient

Imports ClaseMigrar.SQLdinamico
Imports ClaseMigrar


Imports CartaDePorteManager
Imports System.Collections.Generic

Imports Pronto.ERP.Bll.EntidadManager
'Imports Pronto.ERP.Bll.CartaDePorteManager
'Imports Pronto.ERP.Bll.LogicaFacturacion


Imports LogicaFacturacion

Imports ProntoCSharp.FuncionesUIWebCSharpEnDllAparte



Partial Class CDPFacturacion
    Inherits System.Web.UI.Page


    Const TIMEOUT_SCRIPT = 2 * 60 * 60 'para que explote despues del timeout controlado. Tenes este timeout y el del (toolkit)ScriptManager

    Dim q As String 'busqueda en el paso 2

    Function EsteUsuarioPuedeVerTarifa() As Boolean
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "CDPs Facturacion")

        Return p("PuedeModificar")
    End Function





    '///////////////////////////////////
    '///////////////////////////////////
    'load
    '///////////////////////////////////
    '///////////////////////////////////


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString(Server, Session)
        HFIdObra.Value = IIf(IsDBNull(Session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, Session(SESSIONPRONTO_glbIdObraAsignadaUsuario))




        GridView2.Columns(9).Visible = EsteUsuarioPuedeVerTarifa()



        If Not IsPostBack Then

     
            'es decir, es la primera vez que se carga

            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////


            '////////////////////////////////////////////////
            ViewState("timeOut") = Server.ScriptTimeout 'http://codebetter.com/petervanooijen/2006/06/15/timeout-of-an-asp-net-page/
            Server.ScriptTimeout = TIMEOUT_SCRIPT
            ErrHandler2.WriteError("Server.ScriptTimeout puesto en " & Server.ScriptTimeout & "s. Valor original: " & ViewState("timeOut") & "s.")
            '///////////////////////////////////////////////


            optDivisionSyngenta.DataTextField = "desc"
            optDivisionSyngenta.DataValueField = "desc"
            'optDivisionSyngenta.DataValueField = "idacopio"
            optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(HFSC.Value).Select(Function(z) New With {z.desc})
            optDivisionSyngenta.DataBind()



            'TraerCuentaFFasociadaALaObra()

            'Debug.Print(Session("glbWebIdProveedor"))
            'If Not IsNumeric(Session("glbWebIdProveedor")) Then
            '    ResumenVisible(False)
            'Else
            '    'TraerResumenDeCuentaFF()
            '    Debug.Print(Session("glbWebIdProveedor"))
            '    BuscaIDEnCombo(cmbCuenta, Session("glbWebIdProveedor"))
            'End If

            Me.Title = "Facturación de Cartas porte"


            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            'http://fernandof.wordpress.com/2008/02/05/how-to-check-the-type-of-a-com-object-system__comobject-with-visual-c-net/
            '("ComPronto.Aplicacion")
            '("MTSPronto.General")
            Try
                Dim type As Type = type.GetTypeFromProgID("ComPronto.Aplicacion")
                Dim a = CreateObject("ComPronto.Aplicacion")

            Catch ex As Exception

            End Try
            'type.version()
            'Label2.Text = a.Version ' versiondelcompronto  y si se esta corriendo 64bits
            'object instance = Activator.CreateInstance(type);
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////


            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            Else
                HFTipoFiltro.Value = ""
            End If

            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 

            If System.Diagnostics.Debugger.IsAttached Or Membership.GetUser().UserName = "Mariano" Then lnkReintentarPaso2.Visible = True

            refrescaPeriodo()


            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////

            'cmbPuntoVenta.DataSource = EntidadManager.GetStoreProcedure(HFSC.Value, "PuntosVenta_TX_PuntosVentaTodos", ).Tables(0)
            cmbPuntoVenta.DataSource = PuntoVentaWilliams.IniciaComboPuntoVentaWilliams3(HFSC.Value)
            'cmbPuntoVenta.DataSource = EntidadManager.ExecDinamico(HFSC.Value, "SELECT DISTINCT PuntoVenta FROM PuntosVenta WHERE not PuntoVenta is null")
            cmbPuntoVenta.DataTextField = "PuntoVenta"
            cmbPuntoVenta.DataValueField = "PuntoVenta"
            cmbPuntoVenta.DataBind()
            cmbPuntoVenta.SelectedIndex = 0

            If EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                BuscaTextoEnCombo(cmbPuntoVenta, pventa)
                If iisNull(pventa, 0) <> 0 Then cmbPuntoVenta.Enabled = False 'si tiene un punto de venta, que no lo pueda elegir
            End If

            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////
            '//////////////////////////////////////////////////////////////////////////////////////////////////////////


            If System.Diagnostics.Debugger.IsAttached() Or Session(SESSIONPRONTO_UserName) = "Mariano" Then
                btnTarifaCero.Visible = True
                txtNuevaTarifa.Visible = True
            End If


            Try
                CartaPorteManagerAux.RefrescarAnulacionesyConsistenciaDeImputacionesEntreCDPyFacturasOnotasDeCredito(HFSC.Value, Session(SESSIONPRONTO_Busqueda))
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            'GridView1.DataSource = EntidadManager.GetStoreProcedure(GetConnectionString(Server, Session), "CartasDePorte_T", -1)

            MarcarTodas(GridView1)
            gv1ReBind()
            'ResetChecks()
            'MarcarTodosLosChecks(True)


            'alarma = 
            'VerificadorDeSeparadorEnClientesContraCorredores(HFSC.Value)

            TabContainer2.ActiveTabIndex = 0
        End If


        AutoCompleteExtender1.ContextKey = HFSC.Value
        AutoCompleteExtender2.ContextKey = HFSC.Value
        AutoCompleteExtender21.ContextKey = HFSC.Value
        AutoCompleteExtender24.ContextKey = HFSC.Value
        AutoCompleteExtender25.ContextKey = HFSC.Value
        AutoCompleteExtender26.ContextKey = HFSC.Value
        AutoCompleteExtender27.ContextKey = HFSC.Value
        AutoCompleteExtender3.ContextKey = HFSC.Value
        AutoCompleteExtender4.ContextKey = HFSC.Value
        AutoCompleteExtender5.ContextKey = HFSC.Value
        AutoCompleteExtender11.ContextKey = HFSC.Value
        AutoCompleteExtender7.ContextKey = HFSC.Value
        AutoCompleteExtender8.ContextKey = HFSC.Value


        'para poder llamar a transmitfile desde un updatepanel
        '  AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button7)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkVistaPrevia)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkVistaDetallada)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkExcelDelPaso2Detallada)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(lnkExcelDelPaso2Resumido)



        If ProntoFuncionesUIWeb.EstaEsteRol("Proveedor") Then
            '            LinkAgregarRenglon.Enabled = False
        Else
            '           LinkAgregarRenglon.Enabled = True
        End If


        Permisos()
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        Try
            If Not IsNothing(ViewState("timeOut")) Then Server.ScriptTimeout = ViewState("timeOut")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub


    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), "CDPs Facturacion")

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            TabContainer2.Visible = False
            'lnkNuevo.Visible = False

           
            'Response.Redirect(String.Format("Principal.aspx"))
           
        End If

        If Not p("PuedeModificar") Then
            'anular la columna de edicion
            'getGridIDcolbyHeader(
            GridView1.Columns(0).Visible = False
            btnGenerarFacturas.Visible = False
        End If

        If Not p("PuedeEliminar") Then
            'anular la columna de eliminar
            GridView1.Columns(7).Visible = False
        End If

    End Sub





    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging



        ' GuardaChecksGrilla1()




        'hago el gv1ReBind porque no tiene datasource
        GridView1.PageIndex = e.NewPageIndex
        gv1ReBind(False) 'es el unico caso donde no tengo que retildar al reenlazar los datos



    End Sub





    Protected Sub HeaderCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'this is for header checkbox changed event


        For Each row As GridViewRow In GridView1.Rows
            For i = 0 To row.Cells.Count - 1
                Dim cell As TableCell = row.Cells(i)
                Dim c As CheckBox = row.Cells(1).Controls(1)
                c.Checked = sender.Checked
            Next
        Next

        If Not sender.Checked Then
            DesmarcarTodasEnGrilla1()
        Else
            'MarcarTodasEnGrilla1
        End If

        KeepSelection(GridView1)
        'MarcarTodosLosChecks(sender.Checked)

        'GuardaChecks() 'acá tendría que grabar tambien el estado 
    End Sub


    'Sub MarcarTodosLosChecks(ByVal check As Boolean)
    '    Dim d = GridView1.PageCount
    '    Dim values(GridView1.PageSize) As Boolean
    '    'Dim values(GridView1.Rows.Count) As Boolean
    '    Dim ids(GridView1.Rows.Count) As Long


    '    For p = 0 To GridView1.PageCount
    '        For i = 0 To GridView1.PageSize
    '            values(i) = check
    '        Next
    '        Session("page" & p) = values
    '    Next
    'End Sub


    'Sub MarcarTodosLosChecks2(ByVal check As Boolean)
    '    With GridView2
    '        Dim d = .PageCount
    '        Dim values(.PageSize) As Boolean
    '        'Dim values(GridView1.Rows.Count) As Boolean
    '        Dim ids(.Rows.Count) As Long


    '        For p = 0 To .PageCount
    '            For i = 0 To .PageSize
    '                values(i) = check
    '            Next
    '            Session("gv2page" & p) = values
    '        Next
    '    End With
    'End Sub


    'Sub ResetChecks()
    '    Dim lista As New Generic.List(Of String)
    '    For Each Item In Session.Contents
    '        If Left(Item, 4) = "page" Then lista.Add(Item)
    '    Next
    '    For Each i In lista
    '        Session.Remove(i)
    '    Next
    'End Sub


    'Sub ResetChecksGrilla2()
    '    Dim lista As New Generic.List(Of String)
    '    For Each Item In Session.Contents
    '        If Left(Item, 7) = "gv2page" Then lista.Add(Item)
    '    Next
    '    For Each i In lista
    '        Session.Remove(i)
    '    Next
    'End Sub



    'Sub GuardaChecksGrilla1()
    '    'persistencia de los checks http://forums.asp.net/t/1147075.aspx
    '    'Response.Write(GridView1.PageIndex.ToString()) 'esto para qué es? si lo descomento, no cambia la pagina

    '    'y esta version? http://ltuttini.blogspot.com/search?updated-min=2012-01-01T00:00:00-08:00&updated-max=2013-01-01T00:00:00-08:00&max-results=1

    '    Dim d = GridView1.PageCount
    '    'Dim values(GridView1.PageSize) As Boolean
    '    Dim values(GridView1.Rows.Count) As Boolean
    '    Dim ids(GridView1.Rows.Count) As Long

    '    Dim chb As CheckBox
    '    Dim count = 0
    '    For i = 0 To GridView1.Rows.Count - 1
    '        chb = GridView1.Rows(i).FindControl("CheckBox1")
    '        If Not IsNothing(chb) Then values(i) = chb.Checked
    '    Next
    '    Session("page" & GridView1.PageIndex) = values

    'End Sub


    'Sub GuardaChecksGrilla2()
    '    'persistencia de los checks http://forums.asp.net/t/1147075.aspx
    '    'Response.Write(GridView1.PageIndex.ToString()) 'esto para qué es? si lo descomento, no cambia la pagina

    '    'y esta version? http://ltuttini.blogspot.com/search?updated-min=2012-01-01T00:00:00-08:00&updated-max=2013-01-01T00:00:00-08:00&max-results=1

    '    With GridView2
    '        Dim d = .PageCount
    '        'Dim values(GridView1.PageSize) As Boolean
    '        Dim values(.Rows.Count) As Boolean
    '        Dim ids(.Rows.Count) As Long

    '        Dim chb As CheckBox
    '        Dim count = 0
    '        For i = 0 To .Rows.Count - 1
    '            chb = .Rows(i).FindControl("CheckBoxGv2")
    '            If Not IsNothing(chb) Then values(i) = chb.Checked
    '        Next
    '        Session("gv2page" & .PageIndex) = values
    '    End With

    'End Sub


    'Function StringListaDeCDPTildadosEnEl1erPaso() As String



    '    Dim dtoo = CDPsSinMarcar_GrillaEnPaso1de3()
    '    Dim dtv = DataTableORDER(dtoo, "NumeroCartaDePorte ASC") '        ordenar por numero de carta porte

    '    GuardaChecksGrilla1()

    '    Dim chb As CheckBox
    '    Dim s As String = "0"
    '    For p = 0 To GridView1.PageCount - 1
    '        Dim values() As Boolean = Session("page" & p)
    '        If Not IsNothing(values) Then
    '            For i = 0 To GridView1.PageSize - 1  'si en el paso 2 reseteo el datasource de la grilla del paso 1, no sé más qué buscar...
    '                'chb = GridView1.Rows(i).FindControl("CheckBox1")
    '                'chb.Checked = values(i)
    '                Dim indice = i + p * GridView1.PageSize
    '                If indice < dtv.Count Then

    '                    Try
    '                        If values(i) Then
    '                            s = s & "," & dtv(indice).Item("IdCartaDePorte")
    '                            Debug.Print(iisNull(dtv(indice).Item(2)))
    '                        End If
    '                    Catch ex As Exception
    '                        ErrHandler2.WriteError(ex)
    '                    End Try
    '                End If
    '            Next
    '        End If
    '    Next
    '    Return s
    'End Function





    'Function ListaDeCDPTildadosEnEl1erPaso() As Generic.List(Of Integer)
    '    Dim dtoo = CDPsSinMarcar_GrillaEnPaso1de3()
    '    Dim dtv = DataTableORDER(dtoo, "NumeroCartaDePorte ASC") '        ordenar por numero de carta porte

    '    GuardaChecksGrilla1()



    '    Dim lista As New Generic.List(Of Integer)

    '    Dim chb As CheckBox
    '    Dim s As String = "0"
    '    For p = 0 To GridView1.PageCount - 1
    '        Dim values() As Boolean = Session("page" & p)
    '        If Not IsNothing(values) Then
    '            For i = 0 To GridView1.PageSize - 1  'si en el paso 2 reseteo el datasource de la grilla del paso 1, no sé más qué buscar...
    '                'chb = GridView1.Rows(i).FindControl("CheckBox1")
    '                'chb.Checked = values(i)
    '                Dim indice = i + p * GridView1.PageSize
    '                If indice < dtv.Count Then

    '                    Try
    '                        If values(i) Then
    '                            lista.Add(dtv(indice).Item("IdCartaDePorte"))
    '                            Debug.Print(iisNull(dtv(indice).Item(2)))
    '                        End If
    '                    Catch ex As Exception
    '                        ErrHandler2.WriteError(ex)
    '                    End Try
    '                End If
    '            Next
    '        End If
    '    Next

    '    Return lista
    'End Function




    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender

        'persistencia de los checks http://forums.asp.net/t/1147075.aspx
        'If Not IsNothing(Session("page" & GridView1.PageIndex)) Then
        '    Dim chb As CheckBox
        '    Dim values() As Boolean = Session("page" & GridView1.PageIndex)
        '    For i = 0 To IIf(values.Length < GridView1.Rows.Count, values.Length, GridView1.Rows.Count) - 1
        '        chb = GridView1.Rows(i).FindControl("CheckBox1")
        '        chb.Checked = values(i)
        '    Next
        'End If
    End Sub




    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender

        'persistencia de los checks http://forums.asp.net/t/1147075.aspx
        'If Not IsNothing(Session("gv2page" & GridView2.PageIndex)) Then
        '    Dim chb As CheckBox
        '    Dim values() As Boolean = Session("gv2page" & GridView2.PageIndex)
        '    For i = 0 To IIf(values.Length < GridView2.Rows.Count, values.Length, GridView2.Rows.Count) - 1
        '        'If GridView2.Rows(i).RowState <4= DataControlRowState.Normal Then
        '        Try
        '            chb = GridView2.Rows(i).FindControl("CheckBoxGv2")
        '            chb.Checked = values(i)
        '        Catch ex As Exception
        '            ErrHandler2.WriteError("grilla2 fact " & ex.ToString)
        '        End Try
        '        'End If
        '    Next
        'End If
    End Sub


    Sub gv1ReBind(Optional ByVal bTildarTodo As Boolean = True)

        KeepSelection(GridView1)
        ViewState("sesionId") = Nothing



        Label3.Text = ""


        Dim dt = CDPsSinMarcar_GrillaEnPaso1de3(Label3.Text)


        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////


        lblGrilla1Info.Text = dt.Rows.Count & " fila(s)"



        Dim dtv = DataTableORDER(dt, "NumeroCartaDePorte ASC") '        ordenar por numero de carta porte
        GridView1.DataSource = dtv
        GridView1.DataBind()

        'si cambió la cantidad de renglones, hay que marcar los nuevos
        If bTildarTodo Then
            'ResetChecks()
            'MarcarTodosLosChecks(True)
            MarcarTodasEnGrilla1(dt)
        End If


        RestoreSelection(GridView1)


        gvBuquesBind()
    End Sub


    Sub MarcarTodasEnGrilla1(ByRef dt As DataTable)
        Dim l = (From i In dt.AsEnumerable Select CInt(i("IdCartaDePorte"))).ToList
        ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.MarcarLista(GridView1, l)

    End Sub

    Sub DesmarcarTodasEnGrilla1()
        'ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.ResetLista(GridView1)
        HttpContext.Current.Session("ProdSelection" + GridView1.ID) = Nothing
    End Sub



    Sub gvBuquesBind()

        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        ' Dim q = From i In db.CartasPorteMovimientos

        Dim embarques = LogicaFacturacion.ListaEmbarques(HFSC.Value, fechadesde, fechahasta, BuscaIdClientePreciso(txtTitular.Text, HFSC.Value), Val(cmbPuntoVenta.Text), BuscaIdClientePreciso(txtBuscar.Text, HFSC.Value))

        gvBuques.DataSource = embarques ' AgregarEmbarques(lista, SC, desde, hasta)
        gvBuques.DataBind()
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

        's += " AND " & _
        '                                   "(  Convert(Numero, 'System.String') LIKE '*" & txtBuscar.Text & "*'   )" '_


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

    Protected Sub GridView2_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView2.PageIndexChanging

        KeepSelection(GridView2)


        ' GuardaChecksGrilla2()


        'hago el gv1ReBind porque no tiene datasource
        GridView2.PageIndex = e.NewPageIndex
        gv2ReBind(False)



    End Sub

    Protected Sub GridView2_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PageIndexChanged
        RestoreSelection(GridView2)
    End Sub

    Protected Sub GridView2_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridView2.RowCancelingEdit
        GridView2.EditIndex = -1
        gv2ReBind()
        'FillCustomerInGrid()
    End Sub

    '///////////////////////////////////
    '///////////////////////////////////
    'grilla con listado
    '///////////////////////////////////
    '///////////////////////////////////


    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        Dim ac As AjaxControlToolkit.AutoCompleteExtender 'para que el autocomplete sepa la cadena de conexion

        If (e.Row.RowType = DataControlRowType.DataRow) Then

            ac = e.Row.FindControl("AutoCompleteExtender24")
            If Not IsNothing(ac) Then ac.ContextKey = HFSC.Value 'por qué pregunta esto???
            ac = e.Row.FindControl("AutoCompleteExtender21")
            If Not IsNothing(ac) Then ac.ContextKey = HFSC.Value 'por qué pregunta esto???

          
        End If


        If (e.Row.RowType = DataControlRowType.Footer) Then
            ac = e.Row.FindControl("AutoCompleteExtender4")
            ac.ContextKey = HFSC.Value
            ac = e.Row.FindControl("AutoCompleteExtender1")
            ac.ContextKey = HFSC.Value
        End If


        PasearAutoComplete()

    End Sub






    Protected Sub GridView2_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView2.RowCommand

        If (e.CommandName.Equals("Excel")) Then
            Dim renglon = Convert.ToInt32(e.CommandArgument)
            Dim Entregador As Label = GridView2.Rows(renglon).FindControl("lblEntregador")

            Dim output As String
            'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, HFSC.Value), Nothing)

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
                MsgBoxAjax(Me, ex.ToString)
                Return
            End Try

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

        ElseIf (e.CommandName.Equals("AddNew")) Then
            Dim dt = dtViewstateRenglonesManuales
            'Se hace un alta en la grilla 
            '(si se está llamando dos veces, fijate que la funcion no esté vinculada al evento 
            'tanto con el Handles como con el OnRowCommand del markup)

            'If dt is nothing then dt=viestate clone

            Dim r As GridViewRow
            r = GridView2.FooterRow
            With r

                Try

                    If TextoWebControl(.FindControl("txtNewVendedor")) = "" Then
                        MsgBoxAjax(Me, "Ingrese un cliente")
                        Return
                    End If

                    If TextoWebControl(.FindControl("txtNewArticulo")) = "" Then
                        MsgBoxAjax(Me, "Ingrese un articulo")
                        Return
                    End If


                    'If TextoWebControl(.FindControl("txtNewTarifa")) < 10 Or TextoWebControl(.FindControl("txtNewTarifa")) Mod 10 <> 0 Then
                    'MsgBoxAjax(Me, "Use como tarifa un multiplo de 10")
                    'Return
                    ' End If


                    'Metodo con datatable
                    'Dim dt = TraerMetadata(HFSC.Value)
                    If TextoWebControl(.FindControl("txtNewVendedor")) <> "" Then
                        Dim dr = dt.NewRow

                        'TODO: Al agregar un item con este articulo en facturación, la tarifa quedo correcta pero no se grabo la cantidad

                        dr.Item("FacturarselaA") = TextoWebControl(.FindControl("txtNewVendedor"))
                        dr.Item("IdFacturarselaA") = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewVendedor")), HFSC.Value)

                        'si es un "cambio de carta porte", no dividir por mil. 
                        'Es decir, la "Tarifa" en los renglones normales es por "Tonelada", y en estos es por "Unidad".
                        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11379
                        'dr.Item("TarifaFacturada") = Int(StringToDecimal(TextoWebControl(.FindControl("txtNewTarifa"))) / 10) * 10
                        dr.Item("TarifaFacturada") = StringToDecimal(TextoWebControl(.FindControl("txtNewTarifa")))

                        dr.Item("KgNetos") = StringToDecimal(TextoWebControl(.FindControl("txtNewKilos")))
                        dr.Item("Producto") = TextoWebControl(.FindControl("txtNewArticulo"))

                        dt.Rows.Add(dr)



                    End If


                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                    MsgBoxAjax(Me, ex.ToString)
                    Return
                End Try


            End With

            dtViewstateRenglonesManuales = dt
            gv2ReBind()

        End If

    End Sub


    Protected Sub GridView2_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView2.RowUpdating
        Dim tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2()



        Dim dt = DataTableUNION(tablaEditadaDeFacturasParaGenerar, dtViewstateRenglonesManuales)  'esta es la grilla, incluye las manuales
        Dim idClienteAfacturarle As Long
        Dim tarif As Double
        Dim idart As Long

        Try

            'se aplican los cambios editados
            With GridView2.Rows(e.RowIndex)



                Dim dr = dt.Rows(e.RowIndex + GridView2.PageIndex * GridView2.PageSize)


                'If dr.Item("NumeroCDP") = "" Then 'es un renglon agregado manualmente
                If Not IsNumeric(dr.Item("NumeroCartaDePorte")) Then 'es un renglon agregado manualmente

                    'TODO: Otro tema, cuando quisimos editar un item agregado de esta manera tiro un error
                    'TODO: Al agregar un item con este articulo en facturación, la tarifa quedo correcta pero no se grabo la cantidad

                    If TextoWebControl(.FindControl("txtTarifa")) < 10 Or TextoWebControl(.FindControl("txtTarifa")) Mod 10 <> 0 Then
                        ' MsgBoxAjax(Me, "Use como tarifa un multiplo de 10")
                        'Return
                    End If



                    Dim indiceManual = (e.RowIndex + GridView2.PageIndex * GridView2.PageSize) - tablaEditadaDeFacturasParaGenerar.Rows.Count
                    Dim dtmanual = dtViewstateRenglonesManuales

                    Dim tarifaoriginal As Double = StringToDecimal(TextoWebControl(.FindControl("txtTarifa")))

                    'no usar mas el redondeador
                    'si es un "cambio de carta porte", no dividir por mil. 
                    'Es decir, la "Tarifa" en los renglones normales es por "Tonelada", y en estos es por "Unidad".
                    'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=11379
                    'Dim tarifa As Double = Int(tarifaoriginal / 10) * 10
                    Dim tarifa As Double = tarifaoriginal



                    dtmanual.Rows(indiceManual).Item("TarifaFacturada") = tarifa

                    Try
                        dtmanual.Rows(indiceManual).Item("FacturarselaA") = TextoWebControl(.FindControl("txtTitular"))
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try

                    dtmanual.Rows(indiceManual).Item("KgNetos") = StringToDecimal(TextoWebControl(.FindControl("txtKilos")))
                    dtmanual.Rows(indiceManual).Item("Producto") = TextoWebControl(.FindControl("txtArticulo"))



                    Try
                        Dim idarti = BuscaIdArticuloPreciso(TextoWebControl(.FindControl("txtArticulo")), HFSC.Value)
                        Dim idcli = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtTitular")), HFSC.Value)
                        ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idcli, idarti, tarifa)

                        ErrHandler2.WriteError("Tarifa1  " & idcli & " " & idarti & " " & tarifa)
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try


                    dtViewstateRenglonesManuales = dtmanual

                    If tarifa <> tarifaoriginal Then
                        MsgBoxAjax(Me, "Se corrigió la tarifa de " & tarifaoriginal & " a " & tarifa & " para que termine en cero")
                    End If




                ElseIf dr.Item("IdCartaDePorte") < -1 Then '= LogicaFacturacion.IDEMBARQUES Then

                    'es un embarque

                    idClienteAfacturarle = iisNull(BuscaIdClientePreciso(TextoWebControl(.FindControl("txtTitular")), HFSC.Value), -1)
                    tarif = StringToDecimal(TextoWebControl(.FindControl("txtTarifa")))
                    idart = BuscaIdArticuloPreciso(TextoWebControl(.FindControl("txtArticulo")), HFSC.Value)


                    ' aca tendria que pasarle tambien la cantidad....? (para que el precio se asigne al rango que corresponda)
                    ListaPreciosManager.SavePrecioEmbarquePorCliente(HFSC.Value, idClienteAfacturarle, idart, tarif)

                    ErrHandler2.WriteError("Tarifa2  " & idClienteAfacturarle & " " & idart & " " & tarif)

                    ' RefrescaTarifaTablaTemporal(dt, HFSC.Value, optFacturarA.SelectedValue, txtFacturarATerceros.Text)

                Else 'es una cdp

                    'Metodo con datatable
                    'Dim Id = GridView2.DataKeys(e.RowIndex).Values(0).ToString()
                    'Dim dt = TraerMetadata(HFSC.Value, Id)
                    If TextoWebControl(.FindControl("txtTitular")) <> "" Then


                        Try
                            dr.Item("FacturarselaA") = TextoWebControl(.FindControl("txtTitular"))
                        Catch ex As Exception
                            ErrHandler2.WriteError(ex)
                        End Try




                        dr.Item("TarifaFacturada") = StringToDecimal(TextoWebControl(.FindControl("txtTarifa")))
                        dr.Item("KgNetos") = StringToDecimal(TextoWebControl(.FindControl("txtKilos")))
                        dr.Item("Producto") = TextoWebControl(.FindControl("txtArticulo"))





                        '/////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////
                        'actualizo la lista de precio al vuelo (tanto el precio del articulo, como el precio del articulo+destino)
                        '-cuando es a terceros, parece que no anda muy bien la edicion de la tarifa. No sospecho tanto de
                        'esta funcion q modifia el precio, sino de quien lo trae, que creo es RefrescaTarifa


                        'TO DO
                        'TO DO
                        'TO DO
                        'TO DO
                        'TO DO
                        'TO DO
                        'TO DO
                        'TO DO
                        'aca tenemos el temita de que si repiten la razon social, y no sé a quien actualizarle la tarifa,
                        ' porque no tengo el Id, solo la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social
                        'aca tenemos el temita de que si repiten la razon social

                        idClienteAfacturarle = iisNull(BuscaIdClientePreciso(dr.Item("FacturarselaA"), HFSC.Value), -1)



                        Dim ocdp As Pronto.ERP.BO.CartaDePorte = CartaDePorteManager.GetItem(HFSC.Value, dr.Item("idCartaDePorte"))
                        idart = ocdp.IdArticulo
                        tarif = dr.Item("TarifaFacturada")
                        'ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, dr.Item("TarifaFacturada"))



                        If cmbModo.Text <> "Entregas" AndAlso ocdp.Exporta Then
                            'guarda, porque puede ser que haya que cambiar la tarifa de exportacion.....

                            ListaPreciosManager.SavePrecioExportacionPorCliente(HFSC.Value, idClienteAfacturarle, idart, tarif)
                            ErrHandler2.WriteError("Tarifa3Exp  " & idClienteAfacturarle & " " & idart & " " & tarif)
                        Else

                            ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, idart, tarif)
                            ErrHandler2.WriteError("Tarifa3Loc  " & idClienteAfacturarle & " " & idart & " " & tarif)
                            'RECLAMO 8094: Al editar tarifas en el paso 2, no agregar una con destino y una sin destino. 
                            'Hace confuso el listado de precios, si ellos tienen que agregar una excepción lo harán a mano.	
                            'ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, ocdp.IdArticulo, dr.Item("TarifaFacturada"))
                        End If


                        ErrHandler2.WriteError("Tarifa3  " & idClienteAfacturarle & " " & idart & " " & tarif)

                    End If
                End If
            End With



        Catch ex As Exception
            ErrHandler2.WriteError("Edicion en 2do paso " & ex.ToString)
            GridView2.EditIndex = -1
            gv2ReBind()

            'MsgBoxAlert("La tarifa está vencida")
            'MsgBoxAlert(ex.ToString())
            MsgBoxAjax(Me, "La tarifa está vencida")
            Return
            Throw ex
        End Try



        If True Then 'optFacturarA.SelectedValue = 5 Then
            Try
                'LinksDeCartasConflictivas(tablaEditadaDeFacturasParaGenerar) 'así quita los renglones repetidos



                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////
                ' refresco la tarifa de la tabla temporal
                '///////////////////////////////////////////////////////////////////////////
                '///////////////////////////////////////////////////////////////////////////

                RefrescaTarifaTablaTemporal(dt, HFSC.Value, optFacturarA.SelectedValue, txtFacturarATerceros.Text, ViewState("sesionId"), idClienteAfacturarle, idart, tarif, cmbModo.Text <> "Entregas")

            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try
        End If


        GridView2.EditIndex = -1

        'dtDatasourcePaso2 = dt
        gv2ReBind()
        'gv1ReBind() 'hay que volver a pedir los datos...

        'DatatableToViewstate(dt)
    End Sub

    Protected Sub gridview2_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView2.RowEditing
        'se empieza a editar un renglon
        GridView2.EditIndex = e.NewEditIndex

        gv2ReBind(False) 'hay que volver a pedir los datos...


        Try
            SetFocus(GridView2.Rows(e.NewEditIndex).FindControl("txtTarifa"))
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            'MandarMailDeError(ex)
        End Try



    End Sub


    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'esto es necesario para que  se pueda hacer render de la grilla (parece que es un bug de la gridview)
        'http://forums.asp.net/p/901776/986762.aspx#986762
        ''
    End Sub





    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub gvGastosAdmin_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvGastosAdmin.RowCommand

        If (e.CommandName.Equals("Excel")) Then
            Dim renglon = Convert.ToInt32(e.CommandArgument)
            Dim Entregador As Label = gvGastosAdmin.Rows(renglon).FindControl("lblEntregador")

            Dim output As String
            'output = generarNotasDeEntrega(#1/1/1753#, #1/1/2020#, Nothing, Nothing, Nothing, Nothing, Nothing, BuscaIdClientePreciso(Entregador.Text, HFSC.Value), Nothing)

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
                MsgBoxAjax(Me, ex.ToString)
                Return
            End Try

            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////

        ElseIf (e.CommandName.Equals("AddNew")) Then
            Dim dt = dtViewstateRenglonesManuales
            'Se hace un alta en la grilla 
            '(si se está llamando dos veces, fijate que la funcion no esté vinculada al evento 
            'tanto con el Handles como con el OnRowCommand del markup)

            'If dt is nothing then dt=viestate clone

            Dim r As GridViewRow
            r = gvGastosAdmin.FooterRow
            With r

                If TextoWebControl(.FindControl("txtNewVendedor")) = "" Then
                    MsgBoxAjax(Me, "Ingrese un cliente")
                    Return
                End If

                If TextoWebControl(.FindControl("txtNewArticulo")) = "" Then
                    MsgBoxAjax(Me, "Ingrese un articulo")
                    Return
                End If


                If TextoWebControl(.FindControl("txtNewTarifa")) < 10 Or TextoWebControl(.FindControl("txtNewTarifa")) Mod 10 <> 0 Then
                    'MsgBoxAjax(Me, "Use como tarifa un multiplo de 10")
                    'Return


                End If



                'Metodo con datatable
                'Dim dt = TraerMetadata(HFSC.Value)
                If TextoWebControl(.FindControl("txtNewVendedor")) <> "" Then
                    Dim dr = dt.NewRow

                    'TODO: Al agregar un item con este articulo en facturación, la tarifa quedo correcta pero no se grabo la cantidad

                    dr.Item("FacturarselaA") = TextoWebControl(.FindControl("txtNewVendedor"))
                    dr.Item("IdFacturarselaA") = BuscaIdClientePreciso(TextoWebControl(.FindControl("txtNewVendedor")), HFSC.Value)

                    dr.Item("TarifaFacturada") = Int(StringToDecimal(TextoWebControl(.FindControl("txtNewTarifa"))) / 10) * 10

                    dr.Item("KgNetos") = StringToDecimal(TextoWebControl(.FindControl("txtNewKilos")))
                    dr.Item("Producto") = TextoWebControl(.FindControl("txtNewArticulo"))

                    dt.Rows.Add(dr)
                End If

            End With

            dtViewstateRenglonesManuales = dt
            gvGastosRebind()

        End If

    End Sub


    Protected Sub gvGastosAdmin_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvGastosAdmin.RowUpdating

        Try

            'se aplican los cambios editados
            With gvGastosAdmin.Rows(e.RowIndex)


                'Dim dr = dt.Rows(e.RowIndex + gvGastosAdmin.PageIndex * gvGastosAdmin.PageSize)

                Dim FacturarselaA As String = TextoWebControl(.FindControl("txtTitular"))
                Dim TarifaFacturada As Double = StringToDecimal(TextoWebControl(.FindControl("txtTarifa")))
                Dim idClienteAfacturarle As Long = iisNull(BuscaIdClientePreciso(FacturarselaA, HFSC.Value), -1)
                Dim idArticuloCambioCarta As Long = GetIdArticuloParaCambioDeCartaPorte(HFSC.Value)

                ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, idArticuloCambioCarta, TarifaFacturada)


            End With

        Catch ex As Exception
            ErrHandler2.WriteError("Edicion en grilla de gastos administrativos " & ex.ToString)
        End Try


        gvGastosAdmin.EditIndex = -1
        gvGastosRebind()

    End Sub




    Protected Sub gvGastosAdmin_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvGastosAdmin.RowEditing
        'se empieza a editar un renglon

        Try


            gvGastosAdmin.EditIndex = e.NewEditIndex


            gvGastosRebind()


            'gvGastosRebind(False) 'hay que volver a pedir los datos...

            SetFocus(gvGastosAdmin.Rows(e.NewEditIndex).FindControl("txtTarifa"))

        Catch ex As Exception
            ErrHandler2.WriteError("Edicion en grilla de gastos administrativos ")
            ErrHandler2.WriteError(ex)
        End Try
    End Sub


    Protected Sub gvGastosAdmin_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles gvGastosAdmin.RowCancelingEdit
        gvGastosAdmin.EditIndex = -1
        gvGastosRebind()
    End Sub


    Sub gvGastosRebind(Optional ByVal bRefrescarTarifa As Boolean = True)

        gvGastosAdmin.DataSource = DatasourceGastosAdministrativos()
        gvGastosAdmin.DataBind()


    End Sub

    Function DatasourceGastosAdministrativos() As DataTable
        If True Then 'optFacturarA.SelectedValue = 5 Then
            'modo automatico: los datos salen de una tabla temporal que se pagina

            DatasourceGastosAdministrativos = RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(ViewState("sesionId"), dtViewstateRenglonesManuales, dtViewstateRenglonesManuales, HFSC.Value)

        Else
            'modo manual

            DatasourceGastosAdministrativos = RecalcGastosAdminDeCambioDeCarta(dtDatasourcePaso2, dtViewstateRenglonesManuales, HFSC.Value)

        End If

    End Function


    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////
    'Combos
    '////////////////////////////////////////////////////////////////////////////////////

    Private Sub BindTypeDropDown()
        'cmbCuenta.DataSource = Pronto.ERP.Bll.CuentaManager.GetListCombo(SC)
        'cmbCuenta.DataSource = Pronto.ERP.Bll.EntidadManager.GetListCombo(SC, "Cuentas")

        'sieltipo tiene una obra asignada, qué hago acá?
        'TraerCuentaFFasociadaALaObra()




    End Sub









    Public Property dtViewstateRenglonesManuales() As DataTable
        Get
            Return ViewState("dtViewstateRenglonesManuales")
        End Get
        Set(ByVal value As DataTable)
            ViewState("dtViewstateRenglonesManuales") = value
        End Set
    End Property


    Public Property dtDatasourcePaso2EnPaso3() As DataTable
        Get
            Return ViewState("dtDatasourcePaso2EnPaso3")
        End Get
        Set(ByVal value As DataTable)
            ViewState("dtDatasourcePaso2EnPaso3") = value
        End Set
    End Property



    '///////////////////////////////////
    '///////////////////////////////////
    'refrescos
    '///////////////////////////////////






    '///////////////////////////////////
    '///////////////////////////////////
    'botones y links
    '///////////////////////////////////



    'Protected Sub LinkAgregarRenglon_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkAgregarRenglon.Click
    '    Response.Redirect(String.Format("Comparativa.aspx?Id=-1"))
    'End Sub


    'Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
    '    GridViewExportUtil.Export("Grilla.xls", GridView1)
    'End Sub

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



    'Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
    '    'http://forums.asp.net/t/1284166.aspx
    '    'esto solo se puede usar si el ODS usa un dataset
    '    'ObjectDataSource1.FilterExpression = GenerarWHERE()
    '    '& " OR " & _
    '    '"Convert(Obra, 'System.String') LIKE '*" & txtBuscar.Text & "*'"


    '    'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    'End Sub

    'Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton2.Click
    '    'qué diferencia hay entre ImprimirConExcel y ExportarAExcel? 
    '    'ImprimirConExcel()
    '    'ExportarAExcel()
    'End Sub






    'Function ListaDeCartasTildadasEnLaGrillaDel2doPaso(ByRef dtv As DataView, ByVal IdCarta As Long, ByVal IdClienteAFacturar As Long) As Boolean


    '    'este tipo de funciones que maneja las tildes, debe usar dataviews, no datatables....

    '    usar la biblioteca de keepselection

    '    Dim vals(1) As Object
    '    vals(0) = IdCarta
    '    vals(1) = IdClienteAFacturar
    '    Dim indice As Integer = dtv.Find(vals)



    '    Dim pag As Integer = indice / GridView1.PageSize
    '    Dim offset As Integer = indice Mod GridView1.PageSize
    '    Dim values() As Boolean = Session("gv2page" & pag)
    '    'If Not IsNothing(values) Then
    '    Return values(offset)


    'End Function





    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    'GENERACION de facturas
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////







    Function Validar2doPaso(ByRef tablaEditadaDeFacturasParaGenerar As DataTable) As Boolean
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        'Valida que no haya mas de un cliente por carta no duplicada
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////

        'GuardaChecksGrilla2()

        'ResaltarDuplicadosVer_Como_Dar_a_Elegir(tablaEditadaDeFacturasParaGenerar)

        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                'MsgBoxAlert("Elija un cliente como tercero a facturarle")
                MsgBoxAlert("Elija un cliente como tercero a facturarle")
                Return False
            End If
        End If


        If False Then
            ValidarTildadosEnEl2Paso(tablaEditadaDeFacturasParaGenerar)
        End If


        Dim repet = From i In tablaEditadaDeFacturasParaGenerar.AsEnumerable() _
                    Group By Numero = CLng(i("NumeroCartaDePorte")), _
                            IdFacturarselaAExplicito = CLng(iisNull(i("IdFacturarselaA"), -1)) Into Group _
                    Where IdFacturarselaAExplicito <= 0 _
                        And Group.Count() > 1 _
                    Select Numero

        'Dim repet = TraerSubconjuntoDeRepetidosAutomaticos(tablaEditadaDeFacturasParaGenerar)

        If optFacturarA.SelectedValue = 5 Then
            Dim slinks As String
            'LinksDeCartasConflictivas(tablaEditadaDeFacturasParaGenerar, slinks) 'así quita los renglones repetidos
            'ViewState("sLinks") = slinks
        Else
            ViewState("sLinks") = ""
        End If





        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////

        'saco las que no estén tildadas

        Dim a = TraerListaEnStringConComas(GridView2)
        'dt = DataTableWHERE(dt, "IdCartaDePorte<>-1")

        tablaEditadaDeFacturasParaGenerar = DataTableWHERE(tablaEditadaDeFacturasParaGenerar, "IdCartaDePorte IN (" & a & ")")



        '//////////////////////////////////////
        'y los buques como los saca?????
        'tablaEditadaDeFacturasParaGenerar = DataTableWHERE(tablaEditadaDeFacturasParaGenerar, "IdCartaDePorte<>" & LogicaFacturacion.IDEMBARQUES & _
        '                                                                                  " OR SubNumeroVagon IN (" & a & ")")

        'a.IdCartaOriginal = i.IdCDPMovimiento 'uso IdCartaOriginal al boleo (obviamente, no es una cartaporte)
        'a.SubNumeroVagon = i.IdCDPMovimiento
        'a.Corredor = i.Vapor 'es un texto
        'a.NumeroCartaDePorte = Val(i.Vapor)  ' -1




        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////





        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        'Valida que no haya tarifas en 0
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////

        If Not ValidaTarifasEnCero(tablaEditadaDeFacturasParaGenerar) Then
            ErrHandler2.WriteError("Hay tarifas en cero")
            Return False
        End If




        'validar lo de bloq por cobranzas

        ddddd



        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////


        ErrHandler2.WriteError("Tarifas ok. Se factura. " & Now.ToString & " " & optFacturarA.SelectedValue & " " & txtFacturarATerceros.Text & " " & Session(SESSIONPRONTO_UserName))

        Return True

        TabContainer2.ActiveTabIndex = 2


    End Function


    Function ValidaTarifasEnCero(ByRef tablaEditadaDeFacturasParaGenerar As DataTable) As Boolean


        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////
        ' acá ya llegan las cartas tildadas filtradas desde la funcion Validar2doPaso
        '-sí, pero cómo reviso las tildes de los buques???? Y ESTAS chamuyando: acá hago la primera consulta 
        '               sobre db.wTempCartasPorteFacturacionAutomaticas, y no sobre la tablaEditadaDeFacturasParaGenerar!!!
        '//////////////////////////////////////
        '//////////////////////////////////////
        '//////////////////////////////////////






        If True Then 'optFacturarA.SelectedValue = 5 Then
            Dim ids As Integer = ViewState("sesionId")
            Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))





            'Dim pri = (From i In db.wTempCartasPorteFacturacionAutomaticas _
            '           Where i.IdSesion = ids Select i.IdTempCartasPorteFacturacionAutomatica Take 1).SingleOrDefault



            'que esté tildada...


            'cómo verifico que esté tildada
            'no incluir buques


            Dim primeraSinTarifa = (From i In db.wTempCartasPorteFacturacionAutomaticas _
                    Where i.IdSesion = ids And i.TarifaFacturada = 0 _
                    And i.IdCartaDePorte <> LogicaFacturacion.IDEMBARQUES And i.IdCartaDePorte > 0 _
                    Order By i.NumeroCartaDePorte, i.FacturarselaA _
                    Take 1).SingleOrDefault

            If primeraSinTarifa IsNot Nothing Then

                Dim lista = (From i In db.wTempCartasPorteFacturacionAutomaticas Where i.IdSesion = ids _
                             Order By i.NumeroCartaDePorte, i.FacturarselaA Select i.IdCartaDePorte).ToList


                Dim indice = lista.IndexOf(primeraSinTarifa.IdCartaDePorte)


                'ViewState("pagina") = CInt(indice / GridView2.PageSize)  'hacer que se redirija a la pagina que contiene la carta
                ViewState("pagina") = 1 'en el automatico, se ordena las tarifas en 0 al principio

                gv2ReBind()
                MsgBoxAjax(Me, "Hay tarifas en 0. Se mostrará la primera aparición ")
                btnGenerarFacturas.Enabled = True 'para volver a habilitarlo despues de que se lo deshabilité por javascript para evitar mas de un click
                Return False

            End If
        Else

            'modos no automatico

            For i As Integer = 0 To tablaEditadaDeFacturasParaGenerar.Rows.Count - 1
                If iisNull(tablaEditadaDeFacturasParaGenerar.Rows(i).Item("TarifaFacturada"), 0) = 0 Then
                    If GridView2.PageIndex <> i / GridView2.PageSize Then
                        GridView2.PageIndex = Int(i / GridView2.PageSize)
                        gv2ReBind()
                    End If

                    MsgBoxAjax(Me, "Hay tarifas en 0. Se mostrará la primera aparición ")
                    btnGenerarFacturas.Enabled = True 'para volver a habilitarlo despues de que se lo deshabilité por javascript para evitar mas de un click
                    Return False

                End If
            Next
        End If


        Dim dtGastosAdministrativos As DataTable = DatasourceGastosAdministrativos()
        For i As Integer = 0 To dtGastosAdministrativos.Rows.Count - 1
            If iisNull(dtGastosAdministrativos.Rows(i).Item("TarifaFacturada"), 0) = 0 Then
                If gvGastosAdmin.PageIndex <> i / gvGastosAdmin.PageSize Then
                    gvGastosAdmin.PageIndex = Int(i / gvGastosAdmin.PageSize)
                    gvGastosRebind()
                End If

                MsgBoxAjax(Me, "Hay tarifas en 0 en los gastos administrativos")
                btnGenerarFacturas.Enabled = True
                Return False
            End If
        Next





        Try

            'grabo tambien el articulo admin
            Dim IdArticuloGastoAdministrativo = BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", HFSC.Value)
            Dim oArt As Pronto.ERP.BO.Articulo = ArticuloManager.GetItem(HFSC.Value, IdArticuloGastoAdministrativo)
            oArt.CostoReposicion = StringToDecimal(txtTarifaGastoAdministrativo.Text)
            If oArt.CostoReposicion = 0 Then
                MsgBoxAjax(Me, "La tarifa de gasto administrativo está en 0. Verificar que existe el artículo 'CAMBIO DE CARTA DE PORTE'")
                btnGenerarFacturas.Enabled = True 'para volver a habilitarlo despues de que se lo deshabilité por javascript para evitar mas de un click
                Return False

            End If
            ArticuloManager.Save(HFSC.Value, oArt)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)

        End Try


        Return True

    End Function





    Protected Sub btnGenerarFacturas_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerarFacturas.Click



        'Log Entry : 
        '07/07/2014 15:38:56
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:Empiezo a facturar en serio.07/07/2014 03:38:56 p.m.
        '__________________________

        'Log Entry : 
        '07/07/2014 15:38:57
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:La factura para 2341 tiene 16 renglones y el máximo es 15
        '__________________________

        'Log Entry : 
        '07/07/2014 15:38:57
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:No se pudo crear la factura para <a href="Cliente.aspx?Id=2341" target="_blank">HANAN PACHA ACOPIO SRL</a>;  Excede el máximo de renglones <br/>No se pudo crear la factura para <a href="Cliente.aspx?Id=2341" target="_blank">HANAN PACHA ACOPIO SRL</a>;  verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no  se haya disparado el error 'listacdp vacia' o no haya otro cliente con el mismo nombre <br/>

        '__________________________

        'Log Entry : 
        '07/07/2014 15:39:02
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.OutOfMemoryException
        'Exception of type 'System.OutOfMemoryException' was thrown.
        '   at System.Web.UI.WebControls.GridView.InitializeRow(GridViewRow row, DataControlField[] fields)
        '   at System.Web.UI.WebControls.GridView.CreateRow(Int32 rowIndex, Int32 dataSourceIndex, DataControlRowType rowType, DataControlRowState rowState, Boolean dataBind, Object dataItem, DataControlField[] fields, TableRowCollection rows, PagedDataSource pagedDataSource)
        '   at System.Web.UI.WebControls.GridView.CreateChildControls(IEnumerable dataSource, Boolean dataBinding)
        '   at System.Web.UI.WebControls.CompositeDataBoundControl.PerformDataBinding(IEnumerable data)
        '   at System.Web.UI.WebControls.GridView.PerformDataBinding(IEnumerable data)
        '   at System.Web.UI.WebControls.DataBoundControl.OnDataSourceViewSelectCallback(IEnumerable data)
        '   at System.Web.UI.DataSourceView.Select(DataSourceSelectArguments arguments, DataSourceViewSelectCallback callback)
        '   at System.Web.UI.WebControls.DataBoundControl.PerformSelect()
        '   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
        '   at System.Web.UI.WebControls.GridView.DataBind()
        '   at LogicaFacturacion.GenerarLoteFacturas_NUEVO(DataTable& grilla, String SC, StateBag& ViewState, Int64 optFacturarA, GridView& gvFacturasGeneradas, String txtFacturarATerceros, Boolean SeEstaSeparandoPorCorredor, HttpSessionState& Session, Int32 PuntoVenta, DataTable dtViewstateRenglonesManuales, String agruparArticulosPor, String txtBuscar, String txtTarifaGastoAdministrativo, String& errLog, String txtCorredor, Boolean chkPagaCorredor)
        '   at CDPFacturacion.btnGenerarFacturas_Click(Object sender, EventArgs e)
        'System.Web
        '__________________________

        'Log Entry : 
        '07/07/2014 15:39:02
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:generarLoteFacturas(). 7segs System.OutOfMemoryException: Exception of type 'System.OutOfMemoryException' was thrown.
        '   at System.Web.UI.WebControls.GridView.InitializeRow(GridViewRow row, DataControlField[] fields)
        '   at System.Web.UI.WebControls.GridView.CreateRow(Int32 rowIndex, Int32 dataSourceIndex, DataControlRowType rowType, DataControlRowState rowState, Boolean dataBind, Object dataItem, DataControlField[] fields, TableRowCollection rows, PagedDataSource pagedDataSource)
        '   at System.Web.UI.WebControls.GridView.CreateChildControls(IEnumerable dataSource, Boolean dataBinding)
        '   at System.Web.UI.WebControls.CompositeDataBoundControl.PerformDataBinding(IEnumerable data)
        '   at System.Web.UI.WebControls.GridView.PerformDataBinding(IEnumerable data)
        '   at System.Web.UI.WebControls.DataBoundControl.OnDataSourceViewSelectCallback(IEnumerable data)
        '   at System.Web.UI.DataSourceView.Select(DataSourceSelectArguments arguments, DataSourceViewSelectCallback callback)
        '   at System.Web.UI.WebControls.DataBoundControl.PerformSelect()
        '   at System.Web.UI.WebControls.BaseDataBoundControl.DataBind()
        '   at System.Web.UI.WebControls.GridView.DataBind()
        '   at LogicaFacturacion.GenerarLoteFacturas_NUEVO(DataTable& grilla, String SC, StateBag& ViewState, Int64 optFacturarA, GridView& gvFacturasGeneradas, String txtFacturarATerceros, Boolean SeEstaSeparandoPorCorredor, HttpSessionState& Session, Int32 PuntoVenta, DataTable dtViewstateRenglonesManuales, String agruparArticulosPor, String txtBuscar, String txtTarifaGastoAdministrativo, String& errLog, String txtCorredor, Boolean chkPagaCorredor)
        '   at CDPFacturacion.btnGenerarFacturas_Click(Object sender, EventArgs e)
        '__________________________

        'Log Entry : 
        '07/07/2014 15:39:03
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.OutOfMemoryException
        'Exception of type 'System.OutOfMemoryException' was thrown.
        '   at System.Collections.Specialized.HybridDictionary.GetEnumerator()
        '   at System.Web.UI.StateBag.SaveViewState()
        '   at System.Web.UI.Control.SaveViewState()
        '   at System.Web.UI.WebControls.WebControl.SaveViewState()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Control.SaveViewStateRecursive()
        '   at System.Web.UI.Page.SaveAllState()
        '   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
        'System



        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                'MsgBoxAlert("Elija un cliente como tercero a facturarle")
                MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
                Return
            End If
        End If

        Dim sErr As String

        Dim tablaEditadaDeFacturasParaGenerar As DataTable = dtDatasourcePaso2()

        If True Then 'optFacturarA.SelectedValue = 5 Then

            'TODO: truco para que traiga TODAS las filas, sin paginar
            ViewState("pagina") = 1
            tablaEditadaDeFacturasParaGenerar = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState("pagina"), ViewState("sesionId"), 999999, cmbPuntoVenta.Text, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), sErr, cmbAgruparArticulosPor.SelectedItem.Text, ViewState("filas"), ViewState("slinks"), Session.SessionID)
        End If




        Try
            KeepSelection(GridView2) 'pinta que se trula cuando le paso un null en el ID en el caso de los renglones manuales
            'una vez que queda chueco, explota despues el Validar2doPaso
        Catch ex As Exception
            ErrHandler2.WriteError("El keepselection del btnGenerarFacturas")
            ErrHandler2.WriteError(ex)
        End Try



        Dim v As Boolean
        Try
            v = Validar2doPaso(tablaEditadaDeFacturasParaGenerar)
        Catch ex As Exception
            ErrHandler2.WriteError("Explota la validacion")
            ErrHandler2.WriteError(ex)


            'capturar(datos)            captura(imagen)   hacer dump


            Throw


            '            __________________________()

            '            Log(Entry)
            '01/06/2014 15:58:00
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.ArgumentOutOfRangeException
            'Index was out of range. Must be non-negative and less than the size of the collection.
            '            Parameter(name) : index()
            '   at System.Collections.ArrayList.get_Item(Int32 index)
            '   at System.Web.UI.WebControls.GridViewRowCollection.get_Item(Int32 index)
            '   at CDPFacturacion.gridview2_RowEditing(Object sender, GridViewEditEventArgs e)
            '            mscorlib()
            '            __________________________()

            '            Log(Entry)
            '01/06/2014 15:58:33
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:El keepselection del btnGenerarFacturas
            '            __________________________()

            '            Log(Entry)
            '01/06/2014 15:58:33
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.NullReferenceException
            'Object reference not set to an instance of an object.
            '   at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.<KeepSelection>b__5(<>f__AnonymousType0`2 <>h__TransparentIdentifier2) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 97
            '   at System.Linq.Enumerable.WhereSelectEnumerableIterator`2.MoveNext()
            '   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
            '   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
            '   at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.KeepSelection(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 104
            '   at CDPFacturacion.btnGenerarFacturas_Click(Object sender, EventArgs e)

        End Try



        If v Then

            'CartaDePorteManager.ReasignoTarifaSubcontratistasDeTodasLasCDPsDescargadasSinFacturarYLasGrabo(HFSC.Value)
            Dim tTemp = Now
            TabContainer2.ActiveTabIndex = 2
            Try

                Dim errLog As String = ""
                Server.ScriptTimeout = TIMEOUT_SCRIPT
                'acá se ve que le estoy pasando un millon de parametros....
                LogicaFacturacion.GenerarLoteFacturas_NUEVO(tablaEditadaDeFacturasParaGenerar, HFSC.Value, optFacturarA.SelectedValue,
                                        gvFacturasGeneradas, SeEstaSeparandoPorCorredor,
                                          Session, cmbPuntoVenta.Text,
                                        dtViewstateRenglonesManuales, cmbAgruparArticulosPor.SelectedItem.Text,
                                        txtBuscar.Text, txtTarifaGastoAdministrativo.Text, errLog, txtCorredor.Text,
                                          chkPagaCorredor.Checked, txtOrdenCompra.Text,
                                          ViewState("PrimeraIdFacturaGenerada"), ViewState("UltimaIdFacturaGenerada"), 0)





                lblMensaje.Text = errLog



                Dim surl = "Facturas.aspx?ImprimirDesde=" & ViewState("PrimeraIdFacturaGenerada") & "&ImprimirHasta=" & ViewState("UltimaIdFacturaGenerada") & "&Modo=TXT"
                lnkImprimir.PostBackUrl = surl
                hlImprimir.NavigateUrl = surl

                Dim surllaser = "Facturas.aspx?ImprimirDesde=" & ViewState("PrimeraIdFacturaGenerada") & "&ImprimirHasta=" & ViewState("UltimaIdFacturaGenerada") & "&Modo=DOCX"
                lnkImprimirLaser.PostBackUrl = surllaser
                hlImprimirLaser.NavigateUrl = surllaser


                Dim listfac As New List(Of Integer)
                For idf = ViewState("PrimeraIdFacturaGenerada") To ViewState("UltimaIdFacturaGenerada")
                    listfac.Add(idf)
                Next



            Catch ex As Exception

                ErrHandler2.WriteError(ex)
                ErrHandler2.WriteError("generarLoteFacturas(). " & DateDiff(DateInterval.Second, tTemp, Now) & "segs " & ex.ToString)
                TabContainer2.ActiveTabIndex = 1
                UpdatePanel2.Update()
                MsgBoxAjax(Me, ex.ToString.Replace("\", "\\"))
                Return
            End Try


            Try
                GenerarExcelDeFacturacionVistaDetallada(tablaEditadaDeFacturasParaGenerar)
                'genero el excel antes de perder el datatable. -pero esto puede ser bastante grueso!!!!!!!
                generarResumido()
            Catch ex As Exception
                ErrHandler2.WriteError("GenerarExcelDeFacturacion(). " & ex.ToString)
            End Try


            UpdatePanel2.Update()

        End If


    End Sub





    Function filtrarDeLatablaLasAgregadasManualmenteQueSonDeEsteCliente(ByVal dt As DataTable, ByVal id As Long) As DataTable
        Return ProntoFuncionesGenerales.DataTableWHERE(dt, "NumeroCartaDePorte is null AND FacturarselaA=" & _c(ClienteManager.GetItem(HFSC.Value, id).RazonSocial))
    End Function



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    'generar vista detallada y resumida
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Sub GenerarExcelDeFacturacionVistaDetallada(ByRef tablaEditadaDeFacturasParaGenerar As DataTable)


        Dim dt As DataTable

        Try

            dt = DataTableUNION(tablaEditadaDeFacturasParaGenerar, dtViewstateRenglonesManuales)  'esta es la grilla, incluye las manuales

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        If False Then
            dtDatasourcePaso2EnPaso3 = dt 'se lo guardo al paso 3
        End If



        Dim vista As Data.DataView = dt.DefaultView
        Try
            'dt = vista.ToTable(False, "NumeroCartaDePorte", "FechaArribo", "FechaDescarga", "FacturarselaA", "Producto", "KgNetos", "Titular", "Intermediario", "R. Comercial", "Corredor ", "Destinatario", "DestinoDesc", "Procedcia.", "TarifaFacturada", "ClienteSeparado")

            dt = vista.ToTable(False, "NumeroCartaDePorte", "FechaArribo", "FechaDescarga", "FacturarselaA", "Producto", "KgNetos", "Titular", "Intermediario", "RComercial", "Corredor", "Destinatario", "DestinoDesc", "Procedcia", "TarifaFacturada", "ClienteSeparado")

        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & " Si no hay cartas (solo buques), puede no encontrar la columna RComercial")
        End Try


        'TODO: En los archivos de Vista Resumida y Vista Detallada, poner las columnas Tarifa,	KgDescargados y Total en formato número


        Try

            dt.Columns.Add("Total")
            For Each row In dt.Rows
                row("Total") = row("KgNetos") * row("TarifaFacturada") / 1000D
            Next



            If Not EsteUsuarioPuedeVerTarifa() Then
                dt.Columns.Remove("TarifaFacturada")
                dt.Columns.Remove("Total")
            End If


            ViewState("ExcelDeLaGrillaDelPaso2") = DataTableToExcel(dt)

            'acá puede saltar un outofmemory y no te queda registro de nada  https://mail.google.com/mail/u/0/#inbox/13e807f99e1ac233


        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & " GenerarExcelDeFacturacion()")
        End Try


        '        MO, since you can't predict what you can/can't do after an OOM (so you can't reliably process the error), or what else did/didn't happen when unrolling the stack to where you are (so the BCL hasn't reliably processed the error), your app must now be assumed to be in a corrupt state. If you "fix" your code by handling this exception you are burying your head in the sand.

        'I could be wrong here, but to me this message says BIG TROUBLE. The correct fix is to figure out why you have chomped though memory, and address that (for example, have you got a leak? could you switch to a streaming API?). Even switching to x64 isn't a magic bullet here; arrays (and hence lists) are still size limited; and the increased reference size means you can fix numerically fewer references in the 2GB object cap.

        'If you need to chance processing some data, and are happy for it to fail: launch a second process (an AppDomain isn't good enough). If it blows up, tear down the process. Problem solved, and your original process/AppDomain is safe.



    End Sub


    Function generarResumido() As String
        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                'MsgBoxAlert("Elija un cliente como tercero a facturarle")
                MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
                Return ""
            End If
        End If



        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////

        Dim sErr

        Dim output As String

        Dim tablaEditadaDeFacturasParaGenerar As DataTable

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)

        If True Then 'optFacturarA.SelectedValue = 5 Then
            'TODO: truco para que traiga TODAS las filas, sin paginar
            ViewState("pagina") = 1
            tablaEditadaDeFacturasParaGenerar = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState("pagina"), ViewState("sesionId"), 999999, cmbPuntoVenta.Text, fechadesde, fechahasta, sErr, cmbAgruparArticulosPor.SelectedItem.Text, ViewState("filas"), ViewState("slinks"), Session.SessionID)
        Else
            tablaEditadaDeFacturasParaGenerar = DataTableUNION(dtDatasourcePaso2, dtViewstateRenglonesManuales)  'esta es la grilla, incluye las manuales
        End If



        LogicaFacturacion.ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, HFSC.Value, ViewState("sesionId"))
        Dim dt = GenerarDatatableDelPreviewDeFacturacion(tablaEditadaDeFacturasParaGenerar, HFSC.Value)



        'saco estas columnas que molestan en la presentacion
        dt.Columns.Remove("Factura")
        dt.Columns.Remove("IdClienteSeparado")

        If Not EsteUsuarioPuedeVerTarifa() Then
            dt.Columns.Remove("Tarifa")
            dt.Columns.Remove("Total")
        End If


        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////

        'En los archivos de Vista Resumida y Vista Detallada, poner las columnas Tarifa,	KgDescargados y Total en formato número


        output = DataTableToExcel(dt)
        ViewState("ExcelDeLaGrillaDelPaso2Resumido") = output
        Return output
    End Function


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Sub PreviewDetalladoDeLaGeneracionEnPaso2()



        'ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Empiezo")


        'If optFacturarA.SelectedValue = 4 Then
        '    Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

        '    If IdFacturarselaA = -1 Then
        '        ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
        '        'MsgBoxAlert("Elija un cliente como tercero a facturarle")
        '        MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
        '        Return
        '    End If
        'End If



        ''////////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////////

        ''Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = ViewState("ListaIDsLongs")
        ''Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
        ''        Dim q = (From r In db.CartasDePortes _
        ''               Where tildadosEnPrimerPasoLongs.Contains(r.IdCartaDePorte) _
        ''               Select r.IdCartaDePorte, r.AgregaItemDeGastosAdministrativos).ToList

        'Dim oo As DataTable

        'Try
        '    Dim l = fListaIDs()
        '    oo = ExecDinamico(HFSC.Value, "select IdCartaDePorte,AgregaItemDeGastosAdministrativos  " & _
        '                      " from CartasDePorte where AgregaItemDeGastosAdministrativos ='SI' AND  idCartaDePorte IN (-10," & IIf(l = "", "-10", l) & ")") ' , timeoutSegundos:=100)

        'Catch ex As Exception
        '    'http://stackoverflow.com/questions/3641931/optimize-oracle-sql-with-large-in-clause
        '    'Create an index that covers 'field' and 'value'.
        '    'Place those IN values in a temp table and join on it.

        '    ErrHandler2WriteErrorLogPronto("Al llamar a esta a veces da timeout", HFSC.Value, "")
        '    ErrHandler2.WriteAndRaiseError(ex)
        'End Try




        'Dim q = (From r In oo _
        '          Select IdCartaDePorte = CInt(iisNull(r("IdCartaDePorte"), -1)), AgregaItemDeGastosAdministrativos = CStr(iisNull(r("AgregaItemDeGastosAdministrativos"), ""))).ToList



        'Dim output As String

        'Dim sErr As String

        'Dim tablaEditadaDeFacturasParaGenerar As DataTable

        'Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        'Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)


        'ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2()  Levanto las cartas de la tanda")

        'If False Then
        '    TraerTodasQueryable(HFSC.Value, Session.SessionID)
        'ElseIf True Then

        '    'optFacturarA.SelectedValue = 5 Then
        '    'TODO: truco para que traiga TODAS las filas, sin paginar
        '    ViewState("pagina") = 1
        '    tablaEditadaDeFacturasParaGenerar = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState("pagina"), ViewState("sesionId"), 999999, cmbPuntoVenta.Text, fechadesde, fechahasta, sErr, cmbAgruparArticulosPor.SelectedItem.Text, ViewState("filas"), ViewState("slinks"), Session.SessionID)


        'Else
        '    tablaEditadaDeFacturasParaGenerar = DataTableUNION(dtDatasourcePaso2, dtViewstateRenglonesManuales)  'esta es la grilla, incluye las manuales
        'End If




        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''creo que es esto lo que tarda banda

        'ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Llamo a ActualizarCampoClienteSeparador")

        'If True Then
        '    ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, HFSC.Value, ViewState("sesionId"))
        'End If





        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////

        'Dim dt = tablaEditadaDeFacturasParaGenerar



        'ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Actualizo la tarifa")



        'dt.Columns.Add("Total", Type.GetType("System.Decimal"))
        'For Each row In dt.Rows
        '    row("Total") = row("KgNetos") * iisNull(row("TarifaFacturada"), 0) / 1000D

        '    Dim id As Integer = iisNull(row("IdCartaDePorte"), -1)
        '    Dim f = q.Find(Function(o) o.IdCartaDePorte = id)
        '    If Not IsNothing(f) Then
        '        If iisNull(f.AgregaItemDeGastosAdministrativos) = "SI" Then
        '            row("FacturarselaA") = " <<CON COSTO ADMIN>> " & row("FacturarselaA")
        '        End If
        '    End If
        'Next



        ''saco estas columnas que molestan en la presentacion
        ''dt.Columns.Remove("Factura")
        ''dt.Columns.Remove("idcorredorseparado")
        'dt.Columns.Remove("ColumnaTilde")
        'dt.Columns.Remove("IdCartaDePorte")
        'dt.Columns.Remove("IdArticulo")
        'dt.Columns.Remove("IdFacturarselaA")
        'dt.Columns.Remove("IdDestino")
        'dt.Columns.Remove("Confirmado")
        'dt.Columns.Remove("IdCodigoIVA")
        'dt.Columns.Remove("ClienteSeparado")

        'If Not EsteUsuarioPuedeVerTarifa() Then
        '    dt.Columns.Remove("TarifaFacturada")
        '    dt.Columns.Remove("Total")
        'End If




        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////
        ''////////////////////////////////////////////////////////////////////////////



        ''/////////////////////////////////////
        ''/////////////////////////////////////
        ''/////////////////////////////////////
        ''Por ultimo, dejo que baje el excel completo sin filtrar
        ''/////////////////////////////////////
        'ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Convierto a Excel")
        'output = DataTableToExcel(dt)
        'ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Se descarga")




        Dim output = LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(optFacturarA.SelectedValue, txtFacturarATerceros.Text, HFSC.Value,
                                                   EsteUsuarioPuedeVerTarifa, ViewState, txtFechaDesde.Text, txtFechaHasta.Text,
                                                   fListaIDs, Session.SessionID, cmbPuntoVenta.SelectedValue, cmbAgruparArticulosPor.SelectedItem.Text,
                                                   SeEstaSeparandoPorCorredor)







        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Fin")
    End Sub

    Sub PreviewDetalladoDeLaGeneracionEnPaso2_Version2()
        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Empiezo")


        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                'MsgBoxAlert("Elija un cliente como tercero a facturarle")
                MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
                Return
            End If
        End If



        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////

        'Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = ViewState("ListaIDsLongs")
        'Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
        '        Dim q = (From r In db.CartasDePortes _
        '               Where tildadosEnPrimerPasoLongs.Contains(r.IdCartaDePorte) _
        '               Select r.IdCartaDePorte, r.AgregaItemDeGastosAdministrativos).ToList

        Dim oo As DataTable

        Try
            Dim l = fListaIDs()
            oo = ExecDinamico(HFSC.Value, "select IdCartaDePorte,AgregaItemDeGastosAdministrativos  " & _
                              " from CartasDePorte where AgregaItemDeGastosAdministrativos ='SI' AND  idCartaDePorte IN (-10," & IIf(l = "", "-10", l) & ")") ' , timeoutSegundos:=100)

        Catch ex As Exception
            'http://stackoverflow.com/questions/3641931/optimize-oracle-sql-with-large-in-clause
            'Create an index that covers 'field' and 'value'.
            'Place those IN values in a temp table and join on it.

            ErrHandler2WriteErrorLogPronto("Al llamar a esta a veces da timeout", HFSC.Value, "")
            ErrHandler2.WriteAndRaiseError(ex)
        End Try




        Dim q = (From r In oo _
                  Select IdCartaDePorte = CInt(iisNull(r("IdCartaDePorte"), -1)), AgregaItemDeGastosAdministrativos = CStr(iisNull(r("AgregaItemDeGastosAdministrativos"), ""))).ToList



        Dim output As String

        Dim sErr As String

        Dim tablaEditadaDeFacturasParaGenerar As DataTable

        Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
        Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)


        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2()  Levanto las cartas de la tanda")




        Dim qq = TraerTodasQueryable(HFSC.Value, Session.SessionID)



        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        'creo que es esto lo que tarda banda

        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Llamo a ActualizarCampoClienteSeparador")


        ' Dim qq3 = ActualizarCampoClienteSeparador(qq, SeEstaSeparandoPorCorredor, HFSC.Value, ViewState("sesionId"))






        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////

        Dim dt = tablaEditadaDeFacturasParaGenerar



        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Actualizo la tarifa")



        dt.Columns.Add("Total")
        For Each row In dt.Rows
            row("Total") = row("KgNetos") * iisNull(row("TarifaFacturada"), 0) / 1000D

            Dim id As Integer = iisNull(row("IdCartaDePorte"), -1)
            Dim f = q.Find(Function(o) o.IdCartaDePorte = id)
            If Not IsNothing(f) Then
                If iisNull(f.AgregaItemDeGastosAdministrativos) = "SI" Then
                    row("FacturarselaA") = " <<CON COSTO ADMIN>> " & row("FacturarselaA")
                End If
            End If
        Next



        'saco estas columnas que molestan en la presentacion
        'dt.Columns.Remove("Factura")
        'dt.Columns.Remove("idcorredorseparado")
        dt.Columns.Remove("ColumnaTilde")
        dt.Columns.Remove("IdCartaDePorte")
        dt.Columns.Remove("IdArticulo")
        dt.Columns.Remove("IdFacturarselaA")
        dt.Columns.Remove("IdDestino")
        dt.Columns.Remove("Confirmado")
        dt.Columns.Remove("IdCodigoIVA")
        dt.Columns.Remove("ClienteSeparado")





        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////



        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        'Por ultimo, dejo que baje el excel completo sin filtrar
        '/////////////////////////////////////
        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Convierto a Excel")
        output = DataTableToExcel(dt)
        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Se descarga")

        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

        ErrHandler2.WriteError(" PreviewDetalladoDeLaGeneracionEnPaso2() Fin")
    End Sub


    Function TraerTodasQueryable(SC As String, ids As String) As IQueryable(Of wTempCartasPorteFacturacionAutomatica)
        Dim db As New LinqCartasPorteDataContext(Encriptar(SC))
        Dim o = (From i In db.wTempCartasPorteFacturacionAutomaticas _
                    Where i.IdSesion = ids _
                    Order By CStr(IIf(i.TarifaFacturada = 0, " ", "")) & CStr(i.FacturarselaA) & CStr(i.NumeroCartaDePorte.ToString) Ascending _
                    Select i.ColumnaTilde, i.IdCartaDePorte, i.IdArticulo, i.NumeroCartaDePorte, i.SubNumeroVagon, i.SubnumeroDeFacturacion, _
                            i.FechaArribo, i.FechaDescarga, i.FacturarselaA, i.IdFacturarselaA, i.Confirmado, i.IdCodigoIVA, _
                            i.CUIT, i.ClienteSeparado, i.TarifaFacturada, i.Producto, i.KgNetos, i.IdCorredor, i.IdTitular, _
                            i.IdIntermediario, i.IdRComercial, _
                            idDestinatario = 0, i.Titular, Intermediario = "", i.RComercial, i.Corredor, i.Destinatario, _
                            i.DestinoDesc, i.Procedcia, i.IdDestino, i.IdTempCartasPorteFacturacionAutomatica, i.AgregaItemDeGastosAdministrativos _
                )
        Return o
    End Function


    Sub PreviewResumidoDeLaGeneracionEnPaso2()

        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                'MsgBoxAlert("Elija un cliente como tercero a facturarle")
                MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
                Return
            End If
        End If

        Dim output = generarResumido()

        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try


    End Sub

    Sub PreviewResumidoDeLaGeneracionEnPaso3()


        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////



        Dim output As String



        If False Then
            Dim tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2EnPaso3


            'ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar)
            Dim dt = GenerarDatatableDelPreviewDeFacturacion(tablaEditadaDeFacturasParaGenerar, HFSC.Value)

            'saco estas columnas que molestan en la presentacion
            dt.Columns.Remove("Factura")
            dt.Columns.Remove("IdClienteSeparado")

            output = DataTableToExcel(dt)
        Else
            output = ViewState("ExcelDeLaGrillaDelPaso2Resumido")

        End If

        '/////////////////////////////////////
        '/////////////////////////////////////


        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try


    End Sub

    Sub PreviewDetalladoDeLaGeneracionEnPaso3()

        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////


        'ya generé antes el archivo. el nombre lo dejé en el viewstate
        Dim output As String = ViewState("ExcelDeLaGrillaDelPaso2")


        'Dim tablaEditadaDeFacturasParaGenerar = DataTableUNION(ViewstateToDatatable, dtViewstateRenglonesManuales)  'esta es la grilla, incluye las manuales
        'output = DataTableToExcel(tablaEditadaDeFacturasParaGenerar)


        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'ErrHandler2.WriteAndRaiseError(ex.ToString)
            ErrHandler2.WriteError(ex.ToString)
            'MsgBoxAjax(Me, ex.ToString)
            Return
        End Try

    End Sub


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    Protected Sub btnTarifaCero_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTarifaCero.Click
        CambiarLasTarifasQueEstenEnCero(Val(txtNuevaTarifa.Text))
        gv2ReBind()
    End Sub

    Sub CambiarLasTarifasQueEstenEnCero(Optional ByVal tarifaNueva As Double = 1.0)


        Dim tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2()


        Dim gastos = DatasourceGastosAdministrativos()
        For Each g In gastos.Rows
            If g("TarifaFacturada") = 0 Then
                Dim idClienteAfacturarle As Long = iisNull(BuscaIdClientePreciso(g("FacturarselaA"), HFSC.Value), -1)
                Dim idArticuloCambioCarta As Long = GetIdArticuloParaCambioDeCartaPorte(HFSC.Value)

                ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, idArticuloCambioCarta, 1)
            End If
        Next


        If True Then 'optFacturarA.SelectedValue = 5 Then

            Dim ids As Integer = ViewState("sesionId")
            Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))

            Dim o = From i In db.wTempCartasPorteFacturacionAutomaticas _
                        Where i.IdSesion = ids And i.TarifaFacturada = 0

            For Each i In o
                i.TarifaFacturada = 1.0
            Next
            db.SubmitChanges()



            Dim l = (From i In o Select i.IdFacturarselaA, i.IdArticulo, i.IdDestino).Distinct.ToList
            For Each i In l
                ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, i.IdFacturarselaA, i.IdDestino, 1)
            Next
        End If






        'If optFacturarA.SelectedValue >= 4 Then
        '    RefrescaTarifaTablaTemporal(tablaEditadaDeFacturasParaGenerar, HFSC.Value, optFacturarA.SelectedValue, txtFacturarATerceros.Text)
        'End If


        'For i As Integer = 0 To tablaEditadaDeFacturasParaGenerar.Rows.Count - 1
        '    If iisNull(tablaEditadaDeFacturasParaGenerar.Rows(i).Item("TarifaFacturada"), 0) = 0 Then
        '        If GridView2.PageIndex <> i / GridView2.PageSize Then
        '            GridView2.PageIndex = Int(i / GridView2.PageSize)
        '            gv2ReBind()
        '        End If

        '        MsgBoxAjax(Me, "Hay tarifas en 0. Se mostrará la primera aparición ")
        '        btnGenerarFacturas.Enabled = True 'para volver a habilitarlo despues de que se lo deshabilité por javascript para evitar mas de un click
        '        Exit Sub
        '    End If
        'Next



        For Each r In tablaEditadaDeFacturasParaGenerar.Rows
            If r.Item("TarifaFacturada") = 0 Then
                Try
                    Dim idClienteAfacturarle As Long = iisNull(BuscaIdClientePreciso(iisNull(r.Item("FacturarselaA"), ""), HFSC.Value), -1)
                    Dim ocdp As Pronto.ERP.BO.CartaDePorte = CartaDePorteManager.GetItem(HFSC.Value, r.Item("idCartaDePorte"))
                    'ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, ocdp.IdArticulo, ocdp.Destino, tarifaNueva)
                    ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, ocdp.IdArticulo, tarifaNueva)

                    'RECLAMO 8094: Al editar tarifas en el paso 2, no agregar una con destino y una sin destino. Hace confuso el listado de precios, si ellos tienen que agregar una excepción lo harán a mano.	
                    'ListaPreciosManager.SavePrecioPorCliente(HFSC.Value, idClienteAfacturarle, ocdp.IdArticulo, tarifaNueva)

                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            End If
        Next


        '-cuando es a terceros, parece que no anda muy bien la edicion de la tarifa. No sospecho tanto de
        'esta funcion q modifia el precio, sino de quien lo trae, que creo es RefrescaTarifa


    End Sub






    'Sub QuitarLasNoTildadasDelPaso2(ByRef dt As DataTable)

    '    Return 'la funcion no se usa más desde que no están visibles las tildes del 2do paso



    '    GuardaChecksGrilla2()

    '    Dim chb As CheckBox
    '    Dim s As String = "0"

    '    Dim l As Generic.List(Of Long)

    '    With GridView2

    '        For p = 0 To .PageCount - 1
    '            Dim values() As Boolean = Session("gv2page" & p)
    '            If Not IsNothing(values) Then
    '                For i = 0 To .PageSize - 1  'si en el paso 2 reseteo el datasource de la grilla del paso 1, no sé más qué buscar...
    '                    'chb = .Rows(i).FindControl("CheckBox1")
    '                    'chb.Checked = values(i)
    '                    Dim indice = i + p * GridView2.PageSize
    '                    If indice < dt.Rows.Count Then

    '                        Try
    '                            If Not values(i) Then
    '                                If False Then

    '                                    Dim id = dt.Rows(indice).Item("IdCartaDePorte")
    '                                    s = s & "," & id

    '                                    'Dim dr = DataTableWHERE(dt, "IdCartaDePorte=" & id).Rows(0)  'dt.Rows.Find(id)
    '                                    Dim dr() As DataRow = dt.Select("IdCartaDePorte =" & id)
    '                                    dt.Rows.Remove(dr(0))

    '                                Else
    '                                    'metodo 2
    '                                    'l.Add(indice)
    '                                    dt.Rows(indice).Item("IdCartaDePorte") = -1
    '                                    'dt.Rows.RemoveAt(indice)

    '                                    'al hacer el remove, rompo los indices
    '                                End If


    '                                Debug.Print(iisNull(dt.Rows(indice).Item(2)))
    '                            End If
    '                        Catch ex As Exception
    '                            ErrHandler2.WriteError(ex)
    '                        End Try
    '                    End If
    '                Next
    '            End If
    '        Next

    '        dt = DataTableWHERE(dt, "IdCartaDePorte<>-1")

    '    End With

    'End Sub





    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    'Mover estas cosas a ListasPreciosManager


    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////



    Function SeEstaSeparandoPorCorredor() As Boolean
        If optFacturarA.SelectedValue <> 3 Or _
                   (optFacturarA.SelectedValue = 4 And BuscaIdVendedorPreciso(txtFacturarATerceros.Text, HFSC.Value) = -1) Then
            'no se le factura a corredor ni a un tercero corredor, por lo tanto, agrupo por corredor

            '                    consulta(8078)
            '                    Mariano Scalella dice
            'y en el caso de q el "a terceros" sea un corredor, ahi tambien se separaría por titular, no?
            '                    Andrés(dice)
            '                    exacto()


            SeEstaSeparandoPorCorredor = True
        Else
            'no agrupo por corredor, sino por titular, puesto que estoy facturando a corredores.
            SeEstaSeparandoPorCorredor = False
        End If
    End Function













    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    'fin de GENERACION
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////
    '////////////////////////////////////////////////////////////////////////////////////////////













    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////////////////////////////////








    Function CDPsSinMarcar_GrillaEnPaso1de3(ByRef ms As String) As DataTable
        'Dim dt = EntidadManager.ExecDinamico(HFSC.Value, "Select * from CartasDePorte CDP where Entregador=" & IdEntregador)



        Dim dt As DataTable




        dt = EntidadManager.ExecDinamico(HFSC.Value, SQL_ListaDeCDPsFiltradas2("", optFacturarA.SelectedValue, txtFacturarATerceros.Text, _
                                                                               HFSC.Value, txtTitular.Text, txtCorredor.Text, _
                                                                               txtDestinatario.Text, txtIntermediario.Text, _
                                                                               txtRcomercial.Text, txt_AC_Articulo.Text, _
                                                                               txtProcedencia.Text, txtDestino.Text, txtBuscar.Text, _
                                                                               cmbCriterioWHERE.SelectedValue, cmbModo.Text, _
                                                                               optDivisionSyngenta.SelectedValue, _
                                                                               txtFechaDesde.Text, txtFechaHasta.Text, _
                                                                               cmbPuntoVenta.Text, , txtPopClienteAuxiliar.Text, _
                                                                               txtFacturarA.Text, txtCorredorObs.Text))



        '        dt = DataTableWHERE(dt, "SubNumeroDeFacturacion IS NULL OR SubNumeroDeFacturacion<1")

        'http://bdlconsultores.dyndns.org/Consultas/Admin/verConsultas1.php?recordid=9281
        'si saco esto, produzco mucho estrago???? en todo caso, q haga un distinct
        'dt = DataTableWHERE(dt, "SubNumeroDeFacturacion<=0 OR SubNumeroDeFacturacion IS NULL")
        'dt.Columns.Remove("SubNumeroDeFacturacion")


        'dt = dt.AsEnumerable.Distinct(  
        'dt = DataTableDISTINCT(dt, "NumeroCartaDePorte")
        'Dim q = From i In dt.AsEnumerable

        'hhhh() si voy al segundo paso marcando la copia, me muestra 4 en total. si solo marco la primera, anda 
        'bien (muestra 2). si solo marco la copia, trae 3!

        'Dim q As wTempCartasPorteFacturacionAutomatica


        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        'filtradores
        SoloMostrarElOriginalDeLosDuplicados(dt, ms)
        FiltrarCartasConCopiaPendiente(dt, ms)
        FiltrarLasQueNoSonEntregadorWilliamsYavisarEnMensaje(dt, ms)

        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////
        '///////////////////////////////////////////////////////////////////////////////////////////////



        Return dt

    End Function


    Protected Sub txtProcedencia_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtProcedencia.TextChanged
        'gv1ReBind()
    End Sub

    Protected Sub txt_AC_Articulo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txt_AC_Articulo.TextChanged
        'gv1ReBind()
    End Sub

    Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
        'gv1ReBind()
    End Sub

    Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
        'gv1ReBind()
    End Sub

    Protected Sub cmbPuntoVenta_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPuntoVenta.SelectedIndexChanged
        gv1ReBind()
        Try
            Dim numpv = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(cmbPuntoVenta.Text, HFSC.Value)

            If Not FacturaManager.ValidarCAI_FacturaA(HFSC.Value, numpv) Then
                MsgBoxAjax(Me, "Se venció la fecha de CAI para el punto de venta elegido")
            End If

            RevisarDefaultDelClienteElegido(txtBuscar.Text)


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, ex.ToString)
        End Try
    End Sub





    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        RevisarDefaultDelClienteElegido(txtBuscar.Text)
        txtFacturarATerceros.Text = txtBuscar.Text
        'TO DO: arreglar el filtro de clientes
        'http://bdlconsultores.dyndns.org/Consultas/Admin/VerConsultas1.php?recordid=11598
    End Sub


    Protected Sub txtTitular_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtTitular.TextChanged
        'gv1ReBind()
        '        RevisarDefaultDelClienteElegido(txtTitular.Text)
    End Sub

    Protected Sub txtIntermediario_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtIntermediario.TextChanged
        'gv1ReBind()
        '       RevisarDefaultDelClienteElegido(txtIntermediario.Text)
    End Sub

    Protected Sub txtDestinatario_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtDestinatario.TextChanged
        'gv1ReBind()
        '      RevisarDefaultDelClienteElegido(txtDestinatario.Text)
    End Sub


    Protected Sub txtCorredor_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCorredor.TextChanged
        'gv1ReBind()
        '     RevisarDefaultDelClienteElegido(txtCorredor.Text)
    End Sub


    Protected Sub txtRcomercial_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtRcomercial.TextChanged
        '    RevisarDefaultDelClienteElegido(txtRcomercial.Text)
    End Sub


    Sub RevisarDefaultDelClienteElegido(ByVal buscarEsto As String)


        Dim CantTextBoxConAlgo As Integer = 0
        If txtBuscar.Text <> "" Then CantTextBoxConAlgo += 1
        'If txtTitular.Text <> "" Then CantTextBoxConAlgo += 1
        'If txtIntermediario.Text <> "" Then CantTextBoxConAlgo += 1
        'If txtRcomercial.Text <> "" Then CantTextBoxConAlgo += 1
        'If txtCorredor.Text <> "" Then CantTextBoxConAlgo += 1
        'If txtDestinatario.Text <> "" Then CantTextBoxConAlgo += 1

        If CantTextBoxConAlgo = 1 Then

            Dim idClienteParaBuscar = BuscaIdClientePreciso(buscarEsto, HFSC.Value)
            If idClienteParaBuscar = -1 Then Exit Sub

            Dim cliente = ClienteManager.GetItem(HFSC.Value, idClienteParaBuscar)



            optDivisionSyngenta.DataTextField = "desc"
            optDivisionSyngenta.DataValueField = "desc"
            'optDivisionSyngenta.DataValueField = "idacopio"
            optDivisionSyngenta.DataSource = CartaDePorteManager.excepcionesAcopios(HFSC.Value, idClienteParaBuscar).Select(Function(z) New With {z.desc})
            optDivisionSyngenta.DataBind()


            'If cliente.SeLeFacturaCartaPorteComoTitular <> "SI" And _
            '    cliente.SeLeFacturaCartaPorteComoIntermediario <> "SI" And _
            '    cliente.SeLeFacturaCartaPorteComoRemcomercial <> "SI" And _
            '    cliente.SeLeFacturaCartaPorteComoCorredor <> "SI" And _
            '    cliente.SeLeFacturaCartaPorteComoDestinatario <> "SI" Then Exit Sub 'si el cliente no tiene marcado nada, huir

            Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
            Dim oCliente = (From i In db.CartasDePorteReglasDeFacturacions Where i.IdCliente = idClienteParaBuscar And i.PuntoVenta = Val(cmbPuntoVenta.Text)).SingleOrDefault
            If oCliente IsNot Nothing Then
                With oCliente

                End With

                txtTitular.Text = IIf(oCliente.SeLeFacturaCartaPorteComoTitular = "SI", cliente.RazonSocial, "")
                txtIntermediario.Text = IIf(oCliente.SeLeFacturaCartaPorteComoIntermediario = "SI", cliente.RazonSocial, "")
                txtRcomercial.Text = IIf(oCliente.SeLeFacturaCartaPorteComoRemcomercial = "SI", cliente.RazonSocial, "")
                txtCorredor.Text = IIf(oCliente.SeLeFacturaCartaPorteComoCorredor = "SI", cliente.RazonSocial, "")
                txtDestinatario.Text = IIf(oCliente.SeLeFacturaCartaPorteComoDestinatario = "SI", cliente.RazonSocial, "")
                txtPopClienteAuxiliar.Text = IIf(oCliente.SeLeFacturaCartaPorteComoClienteAuxiliar = "SI", cliente.RazonSocial, "")
            Else
                txtTitular.Text = IIf(cliente.SeLeFacturaCartaPorteComoTitular = "SI", cliente.RazonSocial, "")
                txtIntermediario.Text = IIf(cliente.SeLeFacturaCartaPorteComoIntermediario = "SI", cliente.RazonSocial, "")
                txtRcomercial.Text = IIf(cliente.SeLeFacturaCartaPorteComoRemcomercial = "SI", cliente.RazonSocial, "")
                txtCorredor.Text = IIf(cliente.SeLeFacturaCartaPorteComoCorredor = "SI", cliente.RazonSocial, "")
                txtDestinatario.Text = IIf(cliente.SeLeFacturaCartaPorteComoDestinatarioLocal = "SI", cliente.RazonSocial, "")
                txtPopClienteAuxiliar.Text = IIf(cliente.SeLeFacturaCartaPorteComoClienteAuxiliar = "SI", cliente.RazonSocial, "")

            End If


            txtFacturarA.Text = cliente.RazonSocial

            'TO DO: esto deberia cambiar tambien segun el punto de venta





            cmbCriterioWHERE.SelectedValue = "alguno"
        End If

    End Sub


    Function fListaIDs() As String

        'Join(TraerLista(GridView1).Select(Function(itemID) itemID.ToString).ToArray, ",")

        Return TraerListaSQL(GridView1, HFSC.Value, Session.SessionID)
    End Function


    Sub gv1Vaciar()
        GridView1.DataSource = Nothing
        GridView1.DataBind()

    End Sub


    Protected Sub btnIrAlPaso2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnIrAlPaso2.Click

        'en donde explota? no encuentra un cliente tercero, entonces explota

        If Not FacturaManager.ValidarCAI_FacturaA(HFSC.Value, PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(cmbPuntoVenta.Text, HFSC.Value)) Then
            MsgBoxAjax(Me, "Se venció la fecha de CAI para el punto de venta elegido")
            Return
        End If



        'si buscó explicitamente, el default es "a terceros" con ese cliente.  Si no, el default es facturar automatico.
        If txtBuscar.Text = "" Then optFacturarA.SelectedValue = 5




        'Voy al tab del paso 2

        'GuardaChecksGrilla1()


        KeepSelection(GridView1)
        'TraerLista(GridView1)



        'KeepSelection(GridView1, TablaGrillaChecks)


        'fListaIDs = Join(TraerLista(GridView1).Select(Function(itemID) itemID.ToString).ToArray, ",")
        'ViewState("ListaIDsLongs") = 'ListaDeCDPTildadosEnEl1erPaso()


        'aca se le podría hacer el favor al storeproc de grabar todas las tildes, así solo
        'trabaja haciendo un join con el wGrillaPersistencia
        'aca se le podría hacer el favor al storeproc de grabar todas las tildes, así solo
        'trabaja haciendo un join con el wGrillaPersistencia



        LogicaFacturacion.GridCheckboxPersistenciaBulk(HFSC.Value, Session.SessionID, TraerLista(GridView1))




        Try

            gv2ReBind()
            'ResetChecksGrilla2()
            'MarcarTodosLosChecks2(True)
            MarcarTodas(GridView2)

            Dim tildadosEnPrimerPaso As String() = Split(fListaIDs, ",")
            Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList ' ViewState("ListaIDsLongs")

            MarcarLista(GridView2, tildadosEnPrimerPasoLongs)
            RestoreSelection(GridView2)



            'If =5
            'Else
            If GridView2.DataSource.GetType.Name = "DataView" Then
                dtViewstateRenglonesManuales = GridView2.DataSource.totable.Clone
            Else
                dtViewstateRenglonesManuales = GridView2.DataSource.Clone
            End If

        Catch ex As Exception
            'If GridView2 Is Nothing Then
            ErrHandler2.WriteError("en donde explota? no encuentra un cliente tercero, entonces explota")
            ErrHandler2.WriteError(ex)
            'en donde explota? no encuentra un cliente tercero, entonces explota
        End Try


        gv1Vaciar()

        'averiguo el id del talonario 
        Dim IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(HFSC.Value, PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(cmbPuntoVenta.Text, HFSC.Value), "A")
        lblProximoNumeroTalonario.Text = FacturaManager.ProximoNumeroFactura(HFSC.Value, IdPuntoVenta)



        'articulo gasto admin
        Dim IdArticuloGastoAdministrativo = BuscaIdArticuloPreciso("CAMBIO DE CARTA DE PORTE", HFSC.Value)
        Dim gastoamdmin As Pronto.ERP.BO.Articulo = ArticuloManager.GetItem(HFSC.Value, IdArticuloGastoAdministrativo)
        txtTarifaGastoAdministrativo.Text = gastoamdmin.CostoReposicion



        If txtCorredor.Text <> "" Then PanelAdvertenciaPagaCorredor.Visible = True


        TabContainer2.ActiveTabIndex = 1


    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        gv1ReBind(False)
        TabContainer2.ActiveTabIndex = 0

    End Sub


    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    'IMPRESION
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button6.Click



        Dim ultimoidpresente As Long = FacturaManager.UltimoId(HFSC.Value)
        Dim primero = ViewState("PrimeraIdFacturaGenerada")
        Dim surl = "Facturas.aspx?ImprimirDesde=" & primero & "&ImprimirHasta=" & ultimoidpresente


        MandaEmailSimple(UsuarioSesion.Mail(HFSC.Value, Session) + ",mscalella911@gmail.com", _
                    "Impresión facturas", _
                  "Podes volver a imprimir el lote yendo a " & surl, _
               "buenosaires@williamsentregas.com.ar", _
                ConfigurationManager.AppSettings("SmtpServer"), _
                ConfigurationManager.AppSettings("SmtpUser"), _
                ConfigurationManager.AppSettings("SmtpPass"), _
                "", _
                ConfigurationManager.AppSettings("SmtpPort"), _
                , _
                , )



        'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
        Dim str = "window.open('" & surl & "');"
        AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)


        'TransfiereMerge("A")

    End Sub
    Protected Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button7.Click
        'TransfiereMerge("B")
    End Sub

    Sub TransfiereMerge(ByVal letra As String)
        'Genera las facturas y luego las une

        'EmitirFacturas(1)
        'MergeWorkbooks()


        'MergeWordDocs()

        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1

        Dim output As String
        'output = ImprimirWordDOT("Presupuesto_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdPresupuesto)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa


        Try
            Kill(System.IO.Path.GetTempPath & "*.txt")
            Kill(System.IO.Path.GetTempPath & "*.doc")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        'For Each s In System.IO.Directory.GetFiles("C:\WINDOWS\TEMP")
        '    System.IO.File.Delete(s)
        'Next s
        'File.Delete(System.IO.Path.GetTempPath & "*.doc")

        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Genera las plantillas 
        Dim p = DirApp() & "\Documentos\" & "Factura_Williams.dot"
        Try

            Dim ultimoidpresente As Long = FacturaManager.UltimoId(HFSC.Value)
            For i = ViewState("PrimeraIdFacturaGenerada") To ultimoidpresente
                If ClaseMigrar.GetItemComProntoFactura(HFSC.Value, i, False).TipoFactura = letra Then
                    output = ImprimirWordDOTyGenerarTambienTXT(p, Me, HFSC.Value, Session, Response, i, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Fact_" & i & ".doc")

                    'Dim outputtxt = output & ".txt"

                    Debug.Print(i)
                End If
            Next

            If IsNothing(output) Then
                MsgBoxAjax(Me, "No se generaron facturas " & letra)
                Exit Sub
            End If


        Catch ex As System.Runtime.InteropServices.COMException
            'If ex.ToString = "No se puede abrir el almacenamiento de macros." Then
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala (NO DESDE SU EQUIPO, sino en el servidor o por terminal), pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala, pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        End Try


        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Hace el rejunte

        output = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir.doc"
        Dim outputtxt = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir " & Now.ToString("ddMMMyyyy_HHmmss") & ".doc.prontotxt"

        If False Then
            MergeWordDocsVersion2(System.IO.Path.GetTempPath, output)
        End If



        Dim incluirtarifa = IIf(ClienteManager.GetItem(HFSC.Value, ClaseMigrar.GetItemComProntoFactura(HFSC.Value, ViewState("PrimeraIdFacturaGenerada"), False).IdCliente).IncluyeTarifaEnFactura = "SI", True, False)

        ImpresoraMatrizDePuntosEPSONTexto.WilliamsFacturaWordToTxtMasMergeOpcional(System.IO.Path.GetTempPath, outputtxt, , HFSC.Value, ViewState("PrimeraIdFacturaGenerada")) '0 incluirtarifa

        output = outputtxt

        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        '///////////////////////////////////////////////
        'Transmite el archivo


        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(Button6)
                Response.TransmitFile(output) 'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx

                Response.End()
            Else
                MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            MsgBoxAjax(Me, ex.ToString)
            Return
        End Try
    End Sub

    Private Function MergeWordDocsVersion2(Optional ByVal fileDirectory As String = "C:\documents\", Optional ByVal output As String = "Merged Document.doc", Optional ByVal plantillaDOT As Object = "")
        Dim wdPageBreak = 7
        Dim wdStory = 6
        Dim oMissing = System.Reflection.Missing.Value
        Dim oFalse = False
        Dim oTrue = True

        If plantillaDOT = "" Then plantillaDOT = System.Reflection.Missing.Value
        Dim WordApp As Microsoft.Office.Interop.Word.Application = New Microsoft.Office.Interop.Word.Application()
        Dim wDoc As Microsoft.Office.Interop.Word.Document




        Try



            Dim wordFiles As String() = Directory.GetFiles(fileDirectory, "Fact*.doc")

            wDoc = WordApp.Documents.Open(wordFiles(0))
            wDoc.Application.Selection.EndKey(wdStory, oMissing)

            wDoc.Application.Selection.Sections(wDoc.Application.Selection.Sections.Count).Footers(Microsoft.Office.Interop.Word.WdHeaderFooterIndex.wdHeaderFooterPrimary).LinkToPrevious() = False
            'wDoc.Application.Selection.Range.InsertBreak(wdPageBreak)
            'wDoc.Application.Selection.EndKey(wdStory, oMissing)

            'wDoc = WordApp.Documents.Add(plantillaDOT, oMissing, oMissing, oMissing)

            For i = 0 To wordFiles.Length - 1
                Dim file As String = wordFiles(i)

                With wDoc.Application.Selection.Range










                    '/////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////
                    'Cómo hacer para que no se repita el pie de pagina? (link to previous)
                    'http://www.vbaexpress.com/forum/showthread.php?t=3332
                    'http://thedailyreviewer.com/windowsapps/view/insert-multiple-documents-into-document-retaining-headers-and-foot-10666302


                    .Collapse(Microsoft.Office.Interop.Word.WdCollapseDirection.wdCollapseEnd)
                    'metodo 1
                    CleanHF(wDoc)

                    'metodo 2
                    .Sections(.Sections.Count).Headers(Microsoft.Office.Interop.Word.WdHeaderFooterIndex.wdHeaderFooterPrimary).LinkToPrevious() = False
                    .Sections(.Sections.Count).Footers(Microsoft.Office.Interop.Word.WdHeaderFooterIndex.wdHeaderFooterPrimary).LinkToPrevious() = False


                    .InsertBreak(Microsoft.Office.Interop.Word.WdBreakType.wdSectionBreakContinuous)
                    .Collapse(Microsoft.Office.Interop.Word.WdCollapseDirection.wdCollapseEnd)

                    '.LinkToPrevious = False
                    '/////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////
                    '/////////////////////////////////////////////////////////



                    .InsertFile(file, oMissing, oMissing, oFalse, oFalse)
                    .InsertBreak(wdPageBreak)

                End With
                wDoc.Application.Selection.EndKey(wdStory, oMissing)
            Next

            Dim combineDocName As String = Path.Combine(fileDirectory, output)
            If (File.Exists(combineDocName)) Then File.Delete(combineDocName)
            Dim combineDocNameObj = combineDocName
            wDoc.SaveAs(combineDocNameObj, 0, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing, oMissing)


        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & " Error al hacer el merge de docs")
            Throw
            'MsgBoxAjax(Me, ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.    Emision """ & DebugCadenaImprimible(Encriptar(HFSC.Value)) & "," & ID)
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
            If Not wDoc Is Nothing Then wDoc.Close(False)
            NAR(wDoc)
            'quit and dispose app
            WordApp.Quit()
            NAR(WordApp)
            'VERY IMPORTANT
            GC.Collect()
        End Try

    End Function



    Sub CleanHF(ByRef wDoc As Microsoft.Office.Interop.Word.Document)
        Dim mySection As Microsoft.Office.Interop.Word.Section, myHF As Microsoft.Office.Interop.Word.HeaderFooter

        For Each mySection In wDoc.Sections()
            For Each myHF In mySection.Headers
                With myHF
                    .LinkToPrevious = False
                    With .Range
                        '.Delete()
                        '                .Style = conPageHeader 'Test youreself
                    End With
                End With
            Next
            For Each myHF In mySection.Footers
                With myHF
                    .LinkToPrevious = False
                    With .Range
                        '.Delete()
                        '                .Style = conPageFooter 'Test youreself
                    End With
                End With
            Next
        Next
    End Sub





    Protected Sub btnPaginaAvanza_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaAvanza.Click
        Try
            GridView1.PageIndex += 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        gv1ReBind(False)
    End Sub

    Protected Sub btnPaginaRetrocede_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaRetrocede.Click
        Try
            If GridView1.PageIndex < 1 Then Return
            GridView1.PageIndex -= 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        gv1ReBind(False)
    End Sub


    Protected Sub btnPaginaAvanza2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaAvanza2.Click
        KeepSelection(GridView2)

        Try
            GridView2.PageIndex += 1
            ViewState("pagina") += 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        gv2ReBind(False)


        'todo: 'If ViewState("filas") + dtViewstateRenglonesManuales Then


        If GridView2.Rows.Count = 0 Then
            Try
                GridView2.PageIndex -= 1
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try
            ViewState("pagina") -= 1
            gv2ReBind(False)
        End If

        'If optFacturarA.SelectedValue <> 5 Then ViewState("pagina") = GridView2.PageIndex

        RestoreSelection(GridView2)
    End Sub

    Protected Sub btnPaginaRetrocede2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPaginaRetrocede2.Click
        Try

            KeepSelection(GridView2)
        Catch ex As Exception
            'no sé qué pasa:

            '        Log(Entry)
            '01/02/2014 15:12:38
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.NullReferenceException
            'Object reference not set to an instance of an object.
            '   at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.<KeepSelection>b__5(<>f__AnonymousType0`2 <>h__TransparentIdentifier2) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 97
            '   at System.Linq.Enumerable.WhereSelectEnumerableIterator`2.MoveNext()
            '   at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
            '   at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
            '   at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.KeepSelection(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 104
            '   at CDPFacturacion.btnPaginaRetrocede2_Click(Object sender, EventArgs e)

            ErrHandler2.WriteError(ex)

        End Try


        Try
            If ViewState("pagina") > 1 Then
                ViewState("pagina") -= 1

                If GridView2.PageIndex > 1 Then GridView2.PageIndex -= 1

                gv2ReBind(False)
                RestoreSelection(GridView2)
                Return
            End If


            If GridView2.PageIndex < 1 Then Return
            GridView2.PageIndex -= 1
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

        gv2ReBind(False)
        RestoreSelection(GridView2)

    End Sub



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    Sub gv2ReBind(Optional ByVal bRefrescarTarifa As Boolean = True)

        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        ErrHandler2.WriteError("entro en  gv2ReBind ")



        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                MsgBoxAlert("Elija un cliente como tercero a facturarle")
                Return
            End If
        End If



        Dim sErr As String
        Dim dt = getGrillaPaso2(bRefrescarTarifa, sErr, ViewState("pagina") * GridView2.PageSize, GridView2.PageSize)



        If bRefrescarTarifa Then lblErrores.Text = ""




        ErrHandler2.WriteError("salgo de  getGrillaPaso2 .")



        If optFacturarA.SelectedValue <> 5 Then ViewState("sLinks") = ""
        If ViewState("sLinks") <> "" Then lblErrores.Text = "Cartas con conflicto en el automático: " & ViewState("sLinks")


        If dtViewstateRenglonesManuales IsNot Nothing Then
            'dt = DataTableUNION(dt, dtViewstateRenglonesManuales)
        Else
            'Try
            '    gvGastosAdmin.DataSource = RecalcGastosAdminDeCambioDeCarta(dt, dtViewstateRenglonesManuales, HFSC.Value)
            '    gvGastosAdmin.DataBind()
            'Catch ex As Exception
            '    ErrHandler2.WriteError(ex)
            'End Try


        End If




        If True Then
            lblErrores.Text &= sErr
        Else

            If bRefrescarTarifa And optFacturarA.SelectedValue <> 5 Then
                Try
                    lblErrores.Text &= sErr ' VerificarClientesFacturables(dt, optFacturarA.SelectedValue, HFSC.Value, fListaIDs, txtFacturarATerceros.Text).Replace(vbCrLf, "<br>")
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try
            End If
        End If






        ' * Poner las que tienen tarifa en 0 al principio
        '* Ordenar alfabeticamente por la columna "Facturarle a"

        'Dim dtv = DataTableORDER(dt, "TarifaFacturada ASC, FacturarselaA ASC") '        ordenar por numero de carta porte
        'If tarifafacturada = 0 Then TagParaOrdenar = "*" & TagParaOrdenar
        If optFacturarA.SelectedValue <> 5 Then
            'Dim dtv = DataTableORDER(dt, "TarifaFacturada ASC, FacturarselaA ASC")
            'todo: tarifa en 0, ordenar 
            GridView2.DataSource = dt
        Else
            GridView2.DataSource = dt
        End If

        ErrHandler2.WriteError("punto 2 en gv2ReBind.")


        GridView2.DataBind()


        Try
            RestoreSelection(GridView2)

            If True Then 'optFacturarA.SelectedValue = 5 Then
                lblGrilla2Info.Text = (ViewState("pagina") - 1) * GridView2.PageSize + 1 & "-" & (ViewState("pagina") - 1) * GridView2.PageSize + GridView2.Rows.Count & " de " & ViewState("filas") '& " " & dt.Rows.Count & " fila(s)"
            Else
                lblGrilla2Info.Text = GridView2.PageIndex * GridView2.PageSize + 1 & "-" & GridView2.PageIndex * GridView2.PageSize + GridView2.Rows.Count & " de " & dt.Rows.Count & ""
            End If
        Catch ex As Exception
            ErrHandler2.WriteError(ex)


        End Try

        ErrHandler2.WriteError("salgo de  gv2ReBind .")


    End Sub





    Function getGrillaPaso2(ByVal bRefrescarTarifa As Boolean, Optional ByRef sErr As String = "", Optional ByVal startRowIndex As Long = 0, Optional ByVal maximumRows As Long = 100000) As DataTable


        If optFacturarA.SelectedValue = 4 Then
            Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)

            If IdFacturarselaA = -1 Then
                ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                MsgBoxAlert("Elija un cliente como tercero a facturarle")
                Return Nothing
            End If
        End If

        Dim dt = dtDatasourcePaso2(sErr, startRowIndex, maximumRows)

        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
        'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2




        If dt Is Nothing Then Return Nothing
        'TODO: funcion ineficiente

        'If optFacturarA.SelectedValue >= 4 And bRefrescarTarifa Then
        '    Try
        '        RefrescaTarifaTablaTemporal(dt, HFSC.Value, optFacturarA.SelectedValue, txtFacturarATerceros.Text) 'llamada 1
        '    Catch ex As Exception
        '        ErrHandler2.WriteError(ex)
        '    End Try
        'End If

        ErrHandler2.WriteError("punto 2 en getgrillapaso2.")

        If dtViewstateRenglonesManuales IsNot Nothing Then
            If dt.Rows.Count = GridView2.PageSize Then Return dt 'TODO: parche feo para evitar que los renglonesmanuales rompan la paginacion
            dt = DataTableUNION(dt, dtViewstateRenglonesManuales)
        End If

        ErrHandler2.WriteError("punto 3 en getgrillapaso2.")

        Return dt
    End Function


    Function dtDatasourcePaso2(Optional ByRef sErr As String = "", Optional ByVal startRowIndex As Long = 0, Optional ByVal maximumRows As Long = 100000) As DataTable
        Try


            'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
            'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2
            'arreglar relacion entre gv2rebind, getGrillaPaso2 y dtDatasourcePaso2

            Dim dt As DataTable


            If True Then 'optFacturarA.SelectedValue = 5 Then
                'modo automatico: los datos salen de una tabla temporal que se pagina
                'modo automatico: los datos salen de una tabla temporal que se pagina
                'modo automatico: los datos salen de una tabla temporal que se pagina
                'modo automatico: los datos salen de una tabla temporal que se pagina
                ErrHandler2.WriteError("punto 1 en dtDatasourcePaso2.")

                '  Dim ids As Integer = Val()

                Dim o = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState("pagina"), ViewState("sesionId"), GridView2.PageSize, cmbPuntoVenta.Text, iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#), iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#), _
                                                     fListaIDs, "", optFacturarA.SelectedValue, _
                                                    txtFacturarATerceros.Text, HFSC.Value, txtTitular.Text, txtCorredor.Text, _
                                                    txtDestinatario.Text, txtIntermediario.Text, txtRcomercial.Text, txt_AC_Articulo.Text, _
                                                    txtProcedencia.Text, txtDestino.Text, txtBuscar.Text, cmbCriterioWHERE.SelectedValue, _
                                                    cmbModo.Text, optDivisionSyngenta.SelectedValue, _
                                                     startRowIndex, maximumRows, txtPopClienteAuxiliar.Text, sErr, txtFacturarA.Text, cmbAgruparArticulosPor.SelectedItem.Text, ViewState("filas"), ViewState("slinks"), Session.SessionID)


                ErrHandler2.WriteError("punto 2 en dtDatasourcePaso2.")

                If ViewState("sesionId") <= 0 And optFacturarA.SelectedValue = 5 Then sErr += MostrarConflictos()



                ErrHandler2.WriteError("punto 2b en dtDatasourcePaso2.")

                Try
                    gvGastosAdmin.DataSource = RecalcGastosAdminDeCambioDeCartaUsandoTablaTemporal(ViewState("sesionId"), o, dtViewstateRenglonesManuales, HFSC.Value)
                    gvGastosAdmin.DataBind()
                Catch ex As Exception
                    ErrHandler2.WriteError("nm,.nm,.,m,")
                    ErrHandler2.WriteError(ex)
                End Try

                Return o


            Else
                ''modo manual, con filtros, pero sin paginar.
                ''modo manual, con filtros, pero sin paginar.
                ''modo manual, con filtros, pero sin paginar.


                ''http://support.microsoft.com/kb/288095
                ''Se produce un desbordamiento de pila cuando ejecuta una consulta que contenga un gran número de argumentos dentro de un IN o una cláusula NOT IN en SQL Server

                ''dt = EntidadManager.ExecDinamico(HFSC.Value, SQL_ListaDeCDPsFiltradas(" AND IdCartaDePorte IN (" & iisNull(fListaIDs, "-99") & ") ", optFacturarA.SelectedValue, txtFacturarATerceros.Text, HFSC.Value, txtTitular.Text, txtCorredor.Text, txtDestinatario.Text, txtIntermediario.Text, txtRcomercial.Text, txt_AC_Articulo.Text, txtProcedencia.Text, txtDestino.Text, txtBuscar.Text, cmbCriterioWHERE.SelectedValue, cmbModo.Text, optDivisionSyngenta.SelectedValue, txtFechaDesde.Text, txtFechaHasta.Text, cmbPuntoVenta.Text))
                'dt = ListadoManualConTablaTemporal(HFSC.Value, fListaIDs, "", optFacturarA.SelectedValue, _
                '                                    txtFacturarATerceros.Text, HFSC.Value, txtTitular.Text, txtCorredor.Text, _
                '                                    txtDestinatario.Text, txtIntermediario.Text, txtRcomercial.Text, txt_AC_Articulo.Text, _
                '                                    txtProcedencia.Text, txtDestino.Text, txtBuscar.Text, cmbCriterioWHERE.SelectedValue, _
                '                                    cmbModo.Text, optDivisionSyngenta.SelectedValue, txtFechaDesde.Text, txtFechaHasta.Text, _
                '                                    cmbPuntoVenta.Text, Session.SessionID, startRowIndex, maximumRows, txtPopClienteAuxiliar.Text)






                ''Return DataTableWHERE(dt, "Confirmado='SI' AND IdCodigoIVA>0 ") 'el "idcartadeporte is null" es por los renglones manuales -no, eso no funcionó

                'sErr = "<br/>" & VerificarClientesFacturables(dt, HFSC.Value, fListaIDs, txtFacturarATerceros.Text, optFacturarA.SelectedValue)

                'If optFacturarA.SelectedValue = 4 Then

                '    'RefrescaTarifaTablaTemporal(dt, HFSC.Value, optFacturarA.SelectedValue, txtFacturarATerceros.Text)




                '    Dim IdFacturarselaA = BuscaIdClientePreciso(txtFacturarATerceros.Text, HFSC.Value)
                '    Dim facturarselaA = "'" & txtFacturarATerceros.Text & "'"

                '    Dim drCliente As DataRow
                '    Try
                '        drCliente = EntidadManager.ExecDinamico(HFSC.Value, _
                '                            "SELECT IdCodigoIVA,CUIT," & facturarselaA & " as FacturarselaA " & _
                '                            "FROM CLIENTES where IdCliente=" & IdFacturarselaA).Rows(0)

                '    Catch ex As Exception
                '        ErrHandler2.WriteError("Elija un cliente como tercero a facturarle")
                '        MsgBoxAlert("Elija un cliente como tercero a facturarle")
                '        'MsgBoxAjax(Me, "Elija un cliente como tercero a facturarle")
                '        Return Nothing
                '    End Try


                '    Try

                '        For Each row In dt.Rows
                '            row("IdCodigoIVA") = drCliente("IdCodigoIVA")
                '            row("CUIT") = drCliente("CUIT")
                '            row("FacturarselaA") = drCliente("FacturarselaA")
                '        Next

                '    Catch ex As Exception
                '        ErrHandler2.WriteError("Quizas no encontró cliente")
                '        ErrHandler2.WriteError(ex)
                '    End Try


                '    Try
                '        gvGastosAdmin.DataSource = RecalcGastosAdminDeCambioDeCarta(dt, dtViewstateRenglonesManuales, HFSC.Value)
                '        gvGastosAdmin.DataBind()
                '    Catch ex As Exception
                '        ErrHandler2.WriteError("ascascascccc")
                '        ErrHandler2.WriteError(ex)
                '    End Try


                '    Return DataTableWHERE_ClientesHabilitados(dt)


                'Else

                '    Try
                '        gvGastosAdmin.DataSource = RecalcGastosAdminDeCambioDeCarta(dt, dtViewstateRenglonesManuales, HFSC.Value)
                '        gvGastosAdmin.DataBind()
                '    Catch ex As Exception
                '        ErrHandler2.WriteError("dfghdfghdfgh")

                '        ErrHandler2.WriteError(ex)
                '    End Try

                '    Return DataTableWHERE_ClientesHabilitados(dt) 'el "idcartadeporte is null" es por los renglones manuales -no, eso no funcionó
                'End If
            End If

        Catch ex As Exception
            ErrHandler2.WriteError("no pudo devolver el datasource del paso 2 opcion " & optFacturarA.SelectedValue)

            Throw



        End Try
        ErrHandler2.WriteError("punto 3 en dtDatasourcePaso2.")
    End Function





    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




    Sub ResaltarDuplicadosVer_Como_Dar_a_Elegir(ByRef dt As DataTable)

        'todo: hacer esto

        'TraerSubconjuntoDeRepetidosAutomaticosYtambienDuplicadosExplicitos(dt)

        Dim q = From i In dt.AsEnumerable() _
                            Group By Numero = CLng(i("NumeroCartaDePorte")), _
                                     IdFacturarselaAExplicito = CLng(iisNull(i("IdFacturarselaA"), -1)) Into Group _
                            Where IdFacturarselaAExplicito <= 0 _
                                     And Group.Count() > 1 _
                            Select Numero


        For i = 0 To dt.Rows.Count - 1
            If q.Contains(CLng(iisNull(dt(i)("NumeroCartaDePorte"), 0))) Then
                dt(i)("FacturarselaA") = "<span class=highlight>" + dt(i)("FacturarselaA").ToString + "</span>"
            End If
        Next

    End Sub



    Protected Sub lnkBuscarEnGrilla2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBuscarEnGrilla2.Click
        BuscarGrilla2()
    End Sub

    Protected Sub txtBuscarEnGrilla2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscarEnGrilla2.TextChanged
        BuscarGrilla2()
    End Sub


    Sub BuscarGrilla2()
        Dim sErrores As String

        Dim dt As DataTable

        If True Then 'optFacturarA.SelectedValue = 5 Then
            Dim temppagi = ViewState("pagina")
            ViewState("pagina") = 1
            dt = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState("pagina"), ViewState("sesionId"), 999999, cmbPuntoVenta.Text, iisValidSqlDate(txtFechaDesde.Text, "1/1/1980"), iisValidSqlDate(txtFechaHasta.Text, "1/1/2100"), sErrores, cmbAgruparArticulosPor.SelectedItem.Text, ViewState("filas"), ViewState("slinks"), Session.SessionID)
            ViewState("pagina") = temppagi
        Else
            dt = getGrillaPaso2(False)
        End If

        lblErrores.Text &= sErrores


        Dim index As Long

        q = txtBuscarEnGrilla2.Text.ToUpper

        'http://forums.asp.net/p/1255509/2332893.aspx
        'Vince, after you insert a new record you populate the grid again, right?  
        'When you call _manager.GetById(MyId) you will return a collection of objects. The grid will display 
        'this collection in the order it is returned by your method. The code I gave you basically find's out which is the position of the inserted record in your collection then it will calculate in which page the record is located to then select it.

        'le doy una primary key para poder usar el find
        'Dim keys(1) As DataColumn
        'keys(0) = dt.Columns(0)
        'dt.PrimaryKey = keys
        'Dim drc As DataRowCollection = dt.Rows
        'Dim dr As DataRow = drc.Find(ID)

        Dim ultimabusqueda As Long = ViewState("UltimaBusqueda")
        Dim n As Long

        For n = ultimabusqueda + 1 To dt.Rows.Count - 1 'no se podría usar el metodo Find del dataset?

            If InStr(dt(n)("NumeroCartaDePorte"), q) > 0 Or _
                InStr(dt(n)("FacturarselaA"), q) > 0 Then
                index = n  'dt.Rows.IndexOf(r)
                Exit For
            End If

        Next

        If n = dt.Rows.Count Then
            MsgBoxAjax(Me, "Se llegó al final")
            ViewState("UltimaBusqueda") = 0
            Exit Sub
        End If

        Dim Page As Integer = Int(index / GridView2.PageSize)
        If GridView2.PageIndex <> Page Then GridView2.PageIndex = Page

        If True Then 'optFacturarA.SelectedValue = 5 Then
            ViewState("pagina") = Page + 1
        End If


        'aparentemente, a diferencia del pageIndex, este lo tengo que asignar
        'despues que hago el bind
        'tempSelectedIndex = index - (Page * GridView2.PageSize)

        gv2ReBind()
        'gvMaestro.SelectedIndex = tempSelectedIndex



        ViewState("UltimaBusqueda") = index

    End Sub


    Function HighlightText(ByVal InputTxt As String) As String
        ' This function is called whenever text is displayed in the FirstName and LastName 
        ' fields from our database. If we're not searching then just return the original 
        ' input, this speeds things up a bit

        If q = "" Then
            Return InputTxt
        Else
            ' Otherwise create a new regular expression and evaluate the FirstName and 
            ' LastName fields against our search string.
            Dim ResultStr As Regex
            ResultStr = New Regex(q.Replace(" ", "|"), RegexOptions.IgnoreCase)
            Return ResultStr.Replace(InputTxt, New MatchEvaluator(AddressOf ReplaceWords))
        End If
    End Function

    Public Function ReplaceWords(ByVal m As Match) As String
        ' This match evaluator returns the found string and adds it a CSS class I defined 
        ' as 'highlight'
        Return "<span class=highlight>" + m.ToString + "</span>"
    End Function


    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////






    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////


    Protected Sub optFacturarA_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles optFacturarA.SelectedIndexChanged
        'MostrarFacturasAGenerar_GrillaEnPaso2de3() 'si cambias la asignacion, perdés los items agregados o editados!!!
        If optFacturarA.SelectedValue = 4 And txtFacturarATerceros.Text = "" Then

            'MsgBoxAjax(Me, "Elija un tercero") 'no hace falta avisarle la primera vez
            Return 'que elija un tercero
        End If

        If optFacturarA.SelectedValue = 5 Then MarcarSoloUnaTildeDelClienteAutomaticoDefault(Nothing)

        ViewState("sesionId") = ""

        lblErrores.Text = ""
        gv2ReBind(True)
        Try
            RestoreSelection(GridView2)
        Catch ex As Exception
            ErrHandler2.WriteError("optFacturarA_SelectedIndexChanged")
            ErrHandler2.WriteError(ex)
        End Try

    End Sub



    Function MarcarSoloUnaTildeDelClienteAutomaticoDefault(ByRef dt As DataTable) As String

        '        Dim dt = dtDatasourcePaso2

        If True Then
            'no usar mas esta funcion, mostrar links abajo con los conflictivos
            'ademas, CualEsElIdClienteAutomaticoDefaultDeEstaCarta es ineficiente, por llamar a ClienteManager

            Return "" 'linksCartasConflictivas(dt)
        End If




        Dim chb As CheckBox
        Dim s As String = "0"

        With GridView2
            For p = 0 To .PageCount - 1
                Dim values() As Boolean = Session("page" & p)
                If Not IsNothing(values) Then
                    For i = 0 To .PageSize - 1  'si en el paso 2 reseteo el datasource de la grilla del paso 1, no sé más qué buscar...

                        'chb = .Rows(i).FindControl("CheckBoxGv2")
                        'chb.Checked = values(i)

                        Dim indice = i + p * .PageSize
                        If indice < dt.Rows.Count Then

                            Try

                                Dim r = dt.Rows(indice)
                                If CualEsElIdClienteAutomaticoDefaultDeEstaCarta(r) = r("IdFacturarselaA") Then
                                    r("ColumnaTilde") = True
                                    values(i) = True
                                    'chb.Checked = True
                                Else
                                    r("ColumnaTilde") = False
                                    values(i) = False
                                    'chb.Checked = False
                                End If


                            Catch ex As Exception
                                ErrHandler2.WriteError(ex)
                            End Try
                        End If


                    Next
                End If

                Session("gv2page" & p) = values
            Next
        End With

    End Function

    Function CualEsElIdClienteAutomaticoDefaultDeEstaCarta(ByVal r As DataRow) As Long
        If ClienteManager.GetItem(HFSC.Value, r("IdTitular")).SeLeFacturaCartaPorteComoTitular = "SI" Then
            Return r("IdTitular")
        ElseIf ClienteManager.GetItem(HFSC.Value, r("IdIntermediario")).SeLeFacturaCartaPorteComoIntermediario = "SI" Then
            Return r("IdIntermediario")
        ElseIf ClienteManager.GetItem(HFSC.Value, r("IdRComercial")).SeLeFacturaCartaPorteComoRemcomercial = "SI" Then
            Return r("IdRComercial")
        ElseIf ClienteManager.GetItem(HFSC.Value, r("IdDestinatario")).SeLeFacturaCartaPorteComoDestinatarioLocal = "SI" And r("Exporta") <> "SI" Then
            Return r("IdDestinatario")
        ElseIf ClienteManager.GetItem(HFSC.Value, r("IdDestinatario")).SeLeFacturaCartaPorteComoDestinatarioExportador = "SI" And r("Exporta") = "SI" Then
            Return r("IdDestinatario")
        ElseIf ClienteManager.GetItem(HFSC.Value, r("IdCorredor")).SeLeFacturaCartaPorteComoCorredor = "SI" Then
            Return r("IdCorredor")
        Else
            Return r("IdTitular")
        End If
    End Function



    Protected Sub txtFacturarATerceros_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFacturarATerceros.TextChanged
        'MostrarFacturasAGenerar_GrillaEnPaso2de3() 'si cambias la asignacion, perdés los items agregados o editados!!!
        ViewState("sesionId") = 0     '!!!!
        gv2ReBind()
    End Sub



    Protected Sub btnRefrescar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefrescar.Click
        CartaPorteManagerAux.RefrescarAnulacionesyConsistenciaDeImputacionesEntreCDPyFacturasOnotasDeCredito(HFSC.Value, Session(SESSIONPRONTO_Busqueda))

        'If InStr(txtTitular.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngenta.SelectedValue
        'If InStr(txtIntermediario.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaIntermediario.SelectedValue
        'If InStr(txtRcomercial.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaRemitente.SelectedValue
        'If InStr(txtCorredor.Text, "SYNGENTA") Then .EnumSyngentaDivision = optDivisionSyngentaCorredor.SelectedValue
        'If InStr(txtDestinatario.Text, "SYNGENTA") Then


        MarcarTodas(GridView1)
        gv1ReBind()
        'ResetChecks()
        'MarcarTodosLosChecks(True)

        Dim tildadosEnPrimerPaso As String() = Split(fListaIDs, ",")

        Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList ' ViewState("ListaIDsLongs")
        MarcarLista(GridView2, tildadosEnPrimerPasoLongs)

        ' por qué marca en la grilla 2???


        Try
            RestoreSelection(GridView2)
        Catch ex As Exception
            ErrHandler2.WriteError("CDPFActuracion.btnRefrescar.Restoreselection  " & ex.ToString)
            MandarMailDeError(ex.ToString)

            '            ssss()
            '            /ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados
            'User:       factbb()
            '            Exception(Type) : System.NullReferenceException()
            'Message:	Object reference not set to an instance of an object.
            'Stack Trace:	 at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.b__2e(GridViewRow x) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 244
            'at System.Collections.Generic.List`1.ForEach(Action`1 action)
            'at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.RestoreSelection(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 244
        End Try

    End Sub








    '//////////////////////////////////////////////////////////////////////////////////
    'excels de vistas previas resumido y detallado (en paso 2 y paso 3 del asistente de facturacion)
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////


    'PASO 2 resumido
    Protected Sub lnkVistaPrevia_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkVistaPrevia.Click
        PreviewResumidoDeLaGeneracionEnPaso2()
    End Sub

    'PASO 2 detallado
    Protected Sub lnkVistaDetallada_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkVistaDetallada.Click
        PreviewDetalladoDeLaGeneracionEnPaso2()
    End Sub

    'PASO 3 resumido
    Protected Sub lnkExcelDelPaso2Resumido_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkExcelDelPaso2Resumido.Click
        PreviewResumidoDeLaGeneracionEnPaso3()
    End Sub

    'PASO 3  detallado
    Protected Sub lnkExcelDelPaso2Detallada_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkExcelDelPaso2Detallada.Click
        PreviewDetalladoDeLaGeneracionEnPaso3()
    End Sub




    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////
    '//////////////////////////////////////////////////////////////////////////////////


    Protected Sub LinkButton5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton5.Click
        EnviarCorreoEnPaso3()
    End Sub

    Protected Sub lnkEnviarCorreo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEnviarCorreo.Click
        EnviarCorreo()
    End Sub


    Protected Sub cmbPeriodo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodo.SelectedIndexChanged
        refrescaPeriodo()
        'no hace falta q haga rebind, porque este es un caso loco... no se aplica a la grilla, sino a lo que generan los filtros
        'ReBind()

        MarcarTodas(GridView1)
        gv1ReBind()
        'ResetChecks()
        'MarcarTodosLosChecks(True)
    End Sub



    Protected Sub cmbModo_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles cmbModo.SelectedIndexChanged
        MarcarTodas(GridView1)
        gv1ReBind()
    End Sub

    Protected Sub optDivisionSyngenta_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles optDivisionSyngenta.SelectedIndexChanged
        MarcarTodas(GridView1)
        gv1ReBind()
    End Sub

    Sub refrescaPeriodo()

        txtFechaDesde.Visible = False
        txtFechaHasta.Visible = False


        Select Case cmbPeriodo.Text

            Case "Cualquier fecha"
                txtFechaDesde.Text = ""
                txtFechaHasta.Text = ""

            Case "Hoy"
                txtFechaDesde.Text = Today
                txtFechaHasta.Text = ""

            Case "Ayer"
                txtFechaDesde.Text = DateAdd(DateInterval.Day, -1, Today)
                txtFechaHasta.Text = DateAdd(DateInterval.Day, -1, Today)

            Case "Este mes"
                txtFechaDesde.Text = GetFirstDayInMonth(Today)
                txtFechaHasta.Text = GetLastDayInMonth(Today)
            Case "Mes anterior"
                txtFechaDesde.Text = GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
                txtFechaHasta.Text = GetLastDayInMonth(DateAdd(DateInterval.Month, -1, Today))
            Case "Personalizar"
                txtFechaDesde.Visible = True
                txtFechaHasta.Visible = True
        End Select



    End Sub



    Protected Sub btnQuitarFiltros_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnQuitarFiltros.Click
        txtTitular.Text = ""
        txtIntermediario.Text = ""
        txtRcomercial.Text = ""
        txtCorredor.Text = ""
        txtDestinatario.Text = ""
        txt_AC_Articulo.Text = ""
        txtProcedencia.Text = ""
        txtDestino.Text = ""
        txtPopClienteAuxiliar.Text = ""
    End Sub


    Protected Sub lnkReintentarPaso2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkReintentarPaso2.Click

        Try
            If Not (IsNothing(ViewState("PrimeraIdFacturaGenerada")) Or IsNothing(ViewState("UltimaIdFacturaGenerada"))) Then
                If ViewState("UltimaIdFacturaGenerada") - ViewState("PrimeraIdFacturaGenerada") > 50 Then
                    If Not Debugger.IsAttached Then
                        MsgBoxAjax(Me, "Más de 50 facturas no se anulan automaticamente.")
                        Return
                    End If
                End If
                For IdFact = ViewState("PrimeraIdFacturaGenerada") To ViewState("UltimaIdFacturaGenerada")
                    FacturaManager.AnularFactura(HFSC.Value, FacturaManager.GetItem(HFSC.Value, IdFact), Session(SESSIONPRONTO_glbIdUsuario))
                Next
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "No se pudo anular la tanda de facturas. " & ex.ToString)
            Return

        End Try


        CartaPorteManagerAux.RefrescarAnulacionesyConsistenciaDeImputacionesEntreCDPyFacturasOnotasDeCredito(HFSC.Value, Session(SESSIONPRONTO_Busqueda))
        'Voy al tab del paso 2

        'GuardaChecks()
        'fListaIDs = ListaDeCDPTildados()
        'MostrarFacturasAGenerar_GrillaEnPaso2de3()
        ViewState("sesionId") = 0
        gv2ReBind()
        dtViewstateRenglonesManuales = GridView2.DataSource.Clone

        gv1Vaciar()

        'averiguo el id del talonario 
        Dim IdPuntoVenta = IdPuntoVentaComprobanteFacturaSegunSubnumeroYLetra(HFSC.Value, cmbPuntoVenta.Text, "A")
        lblProximoNumeroTalonario.Text = FacturaManager.ProximoNumeroFactura(HFSC.Value, IdPuntoVenta)


        TabContainer2.ActiveTabIndex = 1
    End Sub

    Protected Sub GridView2_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView2.RowDeleting

    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        btnIrAlPaso2_Click(sender, e)
    End Sub

    Protected Sub btnRefrescarPaso2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefrescarPaso2.Click
        ViewState("sesionId") = Nothing


        'gvGastosAdmin.DataSource = RecalcGastosAdminDeCambioDeCarta(GridView2.DataSource, dtViewstateRenglonesManuales, HFSC.Value)
        'gvGastosAdmin.DataBind()


        gv2ReBind(True)
    End Sub




    Sub EnviarCorreo()

        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////




        Dim output As String
        Dim tablaEditadaDeFacturasParaGenerar = DataTableUNION(dtDatasourcePaso2, dtViewstateRenglonesManuales)  'esta es la grilla, incluye las manuales
        ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, HFSC.Value)
        Dim dt = tablaEditadaDeFacturasParaGenerar

        'saco estas columnas que molestan en la presentacion
        'dt.Columns.Remove("Factura")
        'dt.Columns.Remove("idcorredorseparado")
        dt.Columns.Remove("ColumnaTilde")
        dt.Columns.Remove("IdCartaDePorte")
        dt.Columns.Remove("IdArticulo")
        dt.Columns.Remove("IdFacturarselaA")
        dt.Columns.Remove("IdDestino")
        dt.Columns.Remove("Confirmado")
        dt.Columns.Remove("IdCodigoIVA")
        dt.Columns.Remove("ClienteSeparado")


        dt.Columns.Add("Total")
        For Each row In dt.Rows
            row("Total") = row("KgNetos") * row("TarifaFacturada")
        Next



        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        'Hago mails del detalle filtrando por cliente
        '//////////////////////////
        Dim dtClientes = DataTableDISTINCT(dt, "FacturarselaA")
        For Each Cliente In dtClientes.Rows
            Dim dtFiltrado = DataTableWHERE(dt, "FacturarselaA=" & _c(Cliente.item("FacturarselaA")))


            '            Log(Entry)
            '01/02/2014 14:05:21
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.Runtime.InteropServices.COMException
            'No se puede obtener acceso a "Notas de Entrega 02ene2014_140521.xls".
            '   at Microsoft.Office.Interop.Excel.WorkbookClass.SaveAs(Object Filename, Object FileFormat, Object Password, Object WriteResPassword, Object ReadOnlyRecommended, Object CreateBackup, XlSaveAsAccessMode AccessMode, Object ConflictResolution, Object AddToMru, Object TextCodepage, Object TextVisualLayout, Object Local)
            '   at ProntoFuncionesUIWeb.TextToExcel(String pFileName, String titulo, String sSufijoNombreArchivo)
            '   at ProntoFuncionesUIWeb.DataTableToExcel(DataTable pDataTable, String titulo, String sSufijoNombreArchivo)
            '            at(CDPFacturacion.EnviarCorreo())

            output = DataTableToExcel(dtFiltrado)


            Dim idcliente = BuscaIdClientePreciso(Cliente.item("FacturarselaA"), HFSC.Value)
            Dim emailCliente = ClienteManager.GetItem(HFSC.Value, idcliente).Email
            emailCliente = iisNull(emailCliente, iisNull(UsuarioSesion.Mail(HFSC.Value, Session)))

            If emailCliente = "" Then
                MsgBoxAjax(Me, "Defina un mail por defecto")
                Exit Sub
            End If

            MandaEmail(emailCliente, Cliente.item("FacturarselaA") & " - Vista previa de facturación", "", _
                                   ConfigurationManager.AppSettings("SmtpUser"), _
                                    ConfigurationManager.AppSettings("SmtpServer"), _
                                    ConfigurationManager.AppSettings("SmtpUser"), _
                                    ConfigurationManager.AppSettings("SmtpPass"), _
                                    output, _
                                    ConfigurationManager.AppSettings("SmtpPort"), _
                                    , _
                                     iisNull(UsuarioSesion.Mail(HFSC.Value, Session)), _
                                     "Williams Entregas" _
                                   )

            'MandarMailsDelPaso2(dtFiltrado)
        Next

    End Sub

    Sub EnviarCorreoEnPaso3()

        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////////////////////////////




        Dim output As String
        Dim tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2EnPaso3  'esta es la grilla, incluye las manuales
        LogicaFacturacion.ActualizarCampoClienteSeparador(tablaEditadaDeFacturasParaGenerar, SeEstaSeparandoPorCorredor, HFSC.Value)
        Dim dt = tablaEditadaDeFacturasParaGenerar

        'saco estas columnas que molestan en la presentacion
        'dt.Columns.Remove("Factura")
        'dt.Columns.Remove("idcorredorseparado")
        dt.Columns.Remove("ColumnaTilde")
        dt.Columns.Remove("IdCartaDePorte")
        dt.Columns.Remove("IdArticulo")
        dt.Columns.Remove("IdFacturarselaA")
        dt.Columns.Remove("IdDestino")
        dt.Columns.Remove("Confirmado")
        dt.Columns.Remove("IdCodigoIVA")
        dt.Columns.Remove("ClienteSeparado")


        dt.Columns.Add("Total")
        For Each row In dt.Rows
            row("Total") = row("KgNetos") * row("TarifaFacturada")
        Next



        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        '/////////////////////////////////////
        'Hago mails del detalle filtrando por cliente
        '//////////////////////////
        Dim dtClientes = DataTableDISTINCT(dt, "FacturarselaA")
        For Each Cliente In dtClientes.Rows
            Dim dtFiltrado = DataTableWHERE(dt, "FacturarselaA=" & _c(Cliente.item("FacturarselaA")))

            output = DataTableToExcel(dtFiltrado)

            '            Log(Entry)
            '01/02/2014 14:05:21
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.Runtime.InteropServices.COMException
            'No se puede obtener acceso a "Notas de Entrega 02ene2014_140521.xls".
            '   at Microsoft.Office.Interop.Excel.WorkbookClass.SaveAs(Object Filename, Object FileFormat, Object Password, Object WriteResPassword, Object ReadOnlyRecommended, Object CreateBackup, XlSaveAsAccessMode AccessMode, Object ConflictResolution, Object AddToMru, Object TextCodepage, Object TextVisualLayout, Object Local)
            '   at ProntoFuncionesUIWeb.TextToExcel(String pFileName, String titulo, String sSufijoNombreArchivo)
            '   at ProntoFuncionesUIWeb.DataTableToExcel(DataTable pDataTable, String titulo, String sSufijoNombreArchivo)
            '            at(CDPFacturacion.EnviarCorreo())



            Dim idcliente = BuscaIdClientePreciso(Cliente.item("FacturarselaA"), HFSC.Value)
            Dim emailCliente = ClienteManager.GetItem(HFSC.Value, idcliente).Email
            emailCliente = iisNull(emailCliente, iisNull(UsuarioSesion.Mail(HFSC.Value, Session)))

            If emailCliente = "" Then
                MsgBoxAjax(Me, "Defina un mail por defecto")
                Exit Sub
            End If

            MandaEmail(emailCliente, Cliente.item("FacturarselaA") & " - Vista previa de facturación", "", _
                                   ConfigurationManager.AppSettings("SmtpUser"), _
                                    ConfigurationManager.AppSettings("SmtpServer"), _
                                    ConfigurationManager.AppSettings("SmtpUser"), _
                                    ConfigurationManager.AppSettings("SmtpPass"), _
                                    output, _
                                    ConfigurationManager.AppSettings("SmtpPort"), _
                                    , _
                                     iisNull(UsuarioSesion.Mail(HFSC.Value, Session)) _
                                   )

            'MandarMailsDelPaso2(dtFiltrado)
        Next

    End Sub






    Sub ValidarTildadosEnEl2Paso(ByRef tablaEditadaDeFacturasParaGenerar As DataTable)

        Try

            Dim keys(2) As DataColumn
            keys(0) = tablaEditadaDeFacturasParaGenerar.Columns("IdCartaDePorte")
            keys(1) = tablaEditadaDeFacturasParaGenerar.Columns("IdFacturarselaA")
            tablaEditadaDeFacturasParaGenerar.PrimaryKey = keys
            Dim dtv = tablaEditadaDeFacturasParaGenerar.AsDataView
            dtv.Sort = "IdCartaDePorte ASC,IdFacturarselaA ASC"


            'debe tardar banda........

            Dim marcados = TraerLista(GridView2)



            For i As Integer = 0 To tablaEditadaDeFacturasParaGenerar.Rows.Count - 1

                'resaltarAutomaticosRepetidos()

                'Dim num = iisNull(tablaEditadaDeFacturasParaGenerar.Rows(i).Item("NumeroCartaDePorte"), 0)
                'Dim id = iisNull(tablaEditadaDeFacturasParaGenerar.Rows(i).Item("IdCartaDePorte"), 0)
                'Dim idcli = iisNull(tablaEditadaDeFacturasParaGenerar.Rows(i).Item("IdFacturarselaA"), 0)


                'If ListaDeCartasTildadasEnLaGrillaDel2doPaso(dtv, id, idcli) Then 'el check de esta iteracion está tildado.....
                '    '... entonces, verifico q los de su grupo esten destildados

                '    Dim a = From o In tablaEditadaDeFacturasParaGenerar.AsEnumerable() _
                '            Where CLng(o("NumeroCartaDePorte")) = num _
                '                And CLng(o("IdFacturarselaA")) <> idcli _
                '                And CLng(iisNull(o("SubNumeroDeFacturacion"), -1)) <= 0 _
                '                And ListaDeCartasTildadasEnLaGrillaDel2doPaso(dtv, CLng(o("IdCartaDePorte")), CLng(iisNull(o("IdFacturarselaA"), -1))) _
                '            Select CLng(o("IdCartaDePorte"))


                '    If a.Count > 0 Then

                '        'RESALTAR
                '        If GridView2.PageIndex <> i / GridView2.PageSize Then
                '            GridView2.PageIndex = Int(i / GridView2.PageSize)
                '            gv2ReBind()
                '        End If

                '        MsgBoxAjax(Me, "Hay por lo menos una carta que está facturandose a más de un cliente sin duplicado. Se mostrará la primera aparición ")
                '        btnGenerarFacturas.Enabled = True 'para volver a habilitarlo despues de que se lo deshabilité por javascript para evitar mas de un click
                '        Exit Sub
                '    End If
                'End If


            Next

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


    End Sub


    Protected Sub lnkErrores_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkErrores.Click
        MostrarConflictos()
    End Sub


    Function MostrarConflictos() As String
        Dim ids As String = Session.SessionID ' ViewState("sesionId")

        Dim db As New LinqCartasPorteDataContext(Encriptar(HFSC.Value))
        ' Dim o = From i In db.wTempCartasPorteFacturacionAutomaticas _
        'Where(i.IdSesion = ids)

        ErrHandler2.WriteError("punto 1 en MostrarConflictos .")

        'aista = GetDatatableAsignacionAutomatica(HFSC.Value, ViewState, 999999, cmbPuntoVenta.Text, txtFechaDesde.Text, txtFechaHasta.Text))

        ' Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = ViewState("ListaIDsLongs")       'ListaDeCDPTildadosEnEl1erPaso()
        Dim tildadosEnPrimerPaso As String() = Split(fListaIDs, ",")
        Dim tildadosEnPrimerPasoLongs As Generic.List(Of Integer) = tildadosEnPrimerPaso.Select(Function(itemID) CInt(IIf(IsNumeric(itemID), itemID, -1))).ToList

        Dim lista = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia(CInt(cmbPuntoVenta.SelectedValue), ids.ToString()) _
                                Where tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaDePorte, -1)) _
                                        Or (cdp.SubnumeroDeFacturacion > 0 And tildadosEnPrimerPasoLongs.Contains(If(cdp.IdCartaOriginal, -1))) _
                                ).ToList


        ErrHandler2.WriteError("punto 2 en MostrarConflictos ." & lista.Count & " " & tildadosEnPrimerPasoLongs.Count & " " & tildadosEnPrimerPaso.Count)

        Dim listaSinFiltrar = (From cdp In db.wCartasDePorte_TX_FacturacionAutomatica_con_wGrillaPersistencia( _
                                                            CInt(cmbPuntoVenta.SelectedValue), ids.ToString() _
                                                        )).ToList



        'cierto!, el conteo de  listaSinFiltrar o lista debería ser mayor que tildadosEnPrimerPasoLongs, 
        ' porque el automatico asigna todo lo posible, aún repitiendose
        '-y por qué hay entonces cartas que el automatico no asignó a nadie??? no había un default para esos casos en una funcion que se ejecutaba despues?
        '-en su momento me acuerdo que se la facturabamos al titular por default si no encontraba nada... pero eso cambió?
        '-listar esos casos
        '-y por qué no anduvo el SQLSTRING_FacturacionCartas_por_Titular?????
        'porque en lugar de pasarle el Id de la Session, le pasaste tu numero de tanda, que tambien se llama IdSesion!!!!!!!!!!!

        Dim lll = listaSinFiltrar.Select(Function(x) x.IdCartaDePorte)
        Dim q = From i In tildadosEnPrimerPasoLongs Where Not lll.Contains(i) Select i



        'khhjjkljklhjl()
        'facturarselas al titular






        '        Log Entry
        '02/05/2015 14:54:22
        'Error in: http://190.2.243.16/ProntoTesting/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:punto 2 en MostrarConflictos .68 223 223
        '        __________________________()

        '        Log Entry
        '02/05/2015 14:54:24
        'Error in: http://190.2.243.16/ProntoTesting/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:punto 3 en MostrarConflictos .68





        'Dim errlinks As String
        Dim s As String '= "aaa" '
        'lblErrores.Text = MostrarConflictivasEnPaginaAparte(o, s, HFSC.Value)
        'Response.Write(s)
        'ProntoFuncionesUIWeb.
        'Dim str As String
        'str = "window.open('" & sUrl & "');"
        'str = "<script language=javascript> {window.open('ProntoWeb/ListasPrecios.aspx?Id=" & idLista & "');} </script>"
        'AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)
        'AbrirEnNuevaVentana(Me, "CartasConflictivas.aspx?Id=" & ViewState("sesionId"))
        'Response.Write(s)
        'lblErrores.Text = MostrarConflictivasEnPaginaAparte(o, s, HFSC.Value)
        ErrHandler2.WriteError("punto 3 en MostrarConflictos ." & listaSinFiltrar.Count)

        Try
            s = MostrarConflictivasEnPaginaAparte(lista, HFSC.Value)
        Catch ex As Exception
            MandarMailDeError(ex)
        End Try

        If s = "TOTAL 0" Then s = "SIN CONFLICTOS"
        lblErrores.Text = s

        ErrHandler2.WriteError("punto 4+ en MostrarConflictos .")


        Return s
    End Function

    Protected Sub GridView2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles GridView2.SelectedIndexChanged

    End Sub
End Class








Public Class ArreglarEsto


    Public Function DataTableToExcel(ByVal pDataTable As DataTable, Optional ByVal titulo As String = "") As String

        Dim vFileName As String = Path.GetTempFileName()
        'Dim vFileName As String = "c:\archivo.txt"
        FileOpen(1, vFileName, OpenMode.Output)
        Dim sb As String = ""
        Dim dc As DataColumn
        For Each dc In pDataTable.Columns
            sb &= dc.Caption & Microsoft.VisualBasic.ControlChars.Tab
        Next
        PrintLine(1, sb)
        Dim i As Integer = 0
        Dim dr As DataRow
        For Each dr In pDataTable.Rows
            i = 0 : sb = ""
            For Each dc In pDataTable.Columns
                If Not IsDBNull(dr(i)) Then
                    Try
                        If IsNumeric(dr(i)) Then
                            sb &= DecimalToString(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        Else
                            sb &= CStr(dr(i)) & Microsoft.VisualBasic.ControlChars.Tab
                        End If
                    Catch x As Exception
                        sb &= "" & Microsoft.VisualBasic.ControlChars.Tab
                    End Try
                Else
                    sb &= Microsoft.VisualBasic.ControlChars.Tab
                End If
                i += 1
            Next
            PrintLine(1, sb)
        Next


        FileClose(1)



        Return TextToExcel(vFileName, titulo)
    End Function

    Public Function TextToExcel(ByVal pFileName As String, Optional ByVal titulo As String = "") As String
        'Apartar estas funciones que usen Interop..... usar Open XML SDK
        'http://stackoverflow.com/questions/1405201/so-net-doesnt-have-built-in-office-functionality
        'http://stackoverflow.com/questions/1405201/so-net-doesnt-have-built-in-office-functionality
        'http://stackoverflow.com/questions/1405201/so-net-doesnt-have-built-in-office-functionality


        'EEPLUS
        'EEPLUS
        'http://epplus.codeplex.com/releases/view/67324
        'I'd view EPPlus as a ticking time bomb in your code if you're reading user-supplied files.....
        '-y si grabo como xlsx?
        'EEPLUS
        'EEPLUS



        Dim vFormato As ExcelOffice.XlRangeAutoFormat
        Dim Exc As ExcelOffice.Application = CreateObject("Excel.Application")
        Exc.Visible = False
        Exc.DisplayAlerts = False

        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        'importa el archivo de texto
        'Guarda con la configuracion regional. Si en el servidor está usando la coma (despues
        'de todo, no se usa el pronto en el servidor), lo importa mal
        'http://answers.yahoo.com/question/index?qid=20080917051138AAxit8S
        'http://msdn.microsoft.com/en-us/library/aa195814(office.11).aspx
        'http://www.newsgrupos.com/microsoft-public-es-excel/304517-problemas-con-comas-y-puntos-al-guardar-de-excel-un-archivo-txtmediante-vb.html

        Exc.Workbooks.OpenText(pFileName, , , , ExcelOffice.XlTextQualifier.xlTextQualifierNone, , True, , , , , , , , ".", ",")

        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////
        '/////////////////////////////////////////////////////////////////////



        Dim Wb As ExcelOffice.Workbook = Exc.ActiveWorkbook
        Dim Ws As ExcelOffice.Worksheet = CType(Wb.ActiveSheet, ExcelOffice.Worksheet)


        'Se le indica el formato al que queremos exportarlo
        Dim valor As Integer = 10

        If valor > -1 Then
            Select Case (valor)
                Case 10 : vFormato = ExcelOffice.XlRangeAutoFormat.xlRangeAutoFormatClassic1
            End Select
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(Ws.UsedRange.Rows.Count, Ws.UsedRange.Columns.Count)).AutoFormat(vFormato) 'le hace autoformato

            'insertar totales
            Dim filas = Ws.UsedRange.Rows.Count
            Ws.Cells(filas + 1, "F") = "TOTAL:"
            Ws.Cells(filas + 1, "G") = Exc.WorksheetFunction.Sum(Ws.Range("G2:G" & filas))
            Ws.Cells(filas + 1, "H") = Exc.WorksheetFunction.Sum(Ws.Range("H2:H" & filas))


            '/////////////////////////////////
            'muevo la planilla formateada para tener un espacio arriba
            Ws.Range(Ws.Cells(1, 1), Ws.Cells(filas + 2, Ws.UsedRange.Columns.Count)).Cut(Ws.Cells(10, 1))

            '/////////////////////////////////
            'poner tambien el filtro que se usó para hacer el informe
            Ws.Cells(7, 1) = titulo

            '/////////////////////////////////
            'insertar la imagen 
            'System.Web.VirtualPathUtility.ToAbsolute("~/Imagenes/Williams.bmp")  
            'Ws.Pictures.Insert("~/Imagenes/Williams.bmp")

            'todo: reparar esto
            'Dim imag = Ws.Pictures.Insert(Server.MapPath("~/Imagenes/Williams.bmp"))
            'imag.Left = 1
            'imag.top = 1


            '/////////////////////////////////
            'insertar link
            Dim rg As ExcelOffice.Range = Ws.Cells(3, 8)
            'rg.hip()
            'rg.Hyperlinks(1).Address = "www.williamsentregas.com.ar"
            'rg.Hyperlinks(1).TextToDisplay=
            Ws.Hyperlinks.Add(rg, "http:\\www.williamsentregas.com.ar", , , "Visite: www.williamsentregas.com.ar y vea toda su información en linea!")
            'Ws.Cells(3, "K") = "=HYPERLINK(" & Chr(34) & "www.williamsentregas.com.ar " & Chr(34) & ", ""Visite: www.williamsentregas.com.ar y vea toda su información en linea!"" )"








            '/////////////////////////////////
            '/////////////////////////////////

            'Usando un GUID
            'pFileName = System.IO.Path.GetTempPath() + Guid.NewGuid().ToString() + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            'Usando la hora
            pFileName = System.IO.Path.GetTempPath() + "WilliamsEntregas " + Now.ToString("ddMMMyyyy_HHmmss") + ".xls" 'http://stackoverflow.com/questions/581570/how-can-i-create-a-temp-file-with-a-specific-extension-with-net

            '/////////////////////////////////

            'pFileName = Path.GetTempFileName  'tambien puede ser .GetRandomFileName
            'pFileName = Path.GetTempFileName.Replace("tmp", "xls")
            'problemas con el acceso del proceso al archivo? http://www.eggheadcafe.com/software/aspnet/34067727/file-cannot-be-accessed-b.aspx
            'pFileName = "C:\Archivo.xls"
            'File.Delete(pFileName) 'si no borro, va a aparecer el cartelote de sobreescribir. entonces necesito el .DisplayAlerts = False

            Exc.ActiveWorkbook.SaveAs(pFileName, ExcelOffice.XlTextQualifier.xlTextQualifierNone - 1, )
        End If


        'Exc.Quit()
        'Wb = Nothing
        'Exc = Nothing

        If Not Wb Is Nothing Then Wb.Close(False)
        NAR(Wb)
        'Wbs.Close()
        'NAR(Wbs)
        'quit and dispose app
        Exc.Quit()
        NAR(Exc)

        Ws = Nothing


        GC.Collect()
        'If valor > -1 Then
        '    Dim p As System.Diagnostics.Process = New System.Diagnostics.Process
        '    p.EnableRaisingEvents = False
        '    'System.Diagnostics.Process.Start(pFileName) 'para qué hace esto?
        'End If
        Return pFileName
    End Function





End Class







