Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Diagnostics
Imports System.IO
Imports System.Data
Imports FuncionesUIWebCSharp
Imports System.Linq

Imports ProntoCSharp.FuncionesUIWebCSharpEnDllAparte



Imports CartaDePorteManager


Partial Class Facturas
    Inherits System.Web.UI.Page



    Const MAX_ADJUNTOS = 40

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
        HFSC.Value = GetConnectionString()



        If Membership.GetUser().UserName = "Mariano" Then
            lala.Visible = True
            paneldebug.Visible = True
        Else
            lala.Visible = False
            paneldebug.Visible = False
        End If


        If Not IsPostBack Then 'es decir, si es la primera vez que se carga
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'PRIMERA CARGA
            'inicializacion de varibles y preparar pantalla
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'si estás buscando el filtro, andá a PresupuestoManager.GetList
            If Not (Request.QueryString.Get("tipo") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                HFTipoFiltro.Value = Request.QueryString.Get("tipo") 'este filtro se le pasa a PresupuestoManager.GetList
            ElseIf Not (Request.QueryString.Get("Imprimir") Is Nothing) Then 'guardo el nodo del treeview en un hidden



                Imprimir(Request.QueryString.Get("Imprimir")) 'este filtro se le pasa a PresupuestoManager.GetList
            ElseIf Not (Request.QueryString.Get("ImprimirDesde") Is Nothing) Then 'guardo el nodo del treeview en un hidden
                If iisNull(Request.QueryString.Get("Modo"), "") = "DOCX" Then

                    Dim listaf = New Generic.List(Of Integer)
                    For idfac = CInt(Request.QueryString.Get("ImprimirDesde")) To CInt(Request.QueryString.Get("ImprimirHasta"))
                        listaf.Add(idfac)
                    Next

                    LoteFacturasNET(listaf, "A")
                ElseIf iisNull(Request.QueryString.Get("Modo"), "") = "FacturaElectronica" Then

                    'pedir confirmacion

                    barras.EnviarFacturaElectronicaEMail( _
                                CInt(Request.QueryString.Get("ImprimirDesde")), _
                                CInt(Request.QueryString.Get("ImprimirHasta")), _
                                HFSC.Value, False, UsuarioSesion.Mail(HFSC.Value, Session) _
                    )

                Else

                    TransfiereMerge(CInt(Request.QueryString.Get("ImprimirDesde")), CInt(Request.QueryString.Get("ImprimirHasta")))
                End If

            Else
                HFTipoFiltro.Value = ""
            End If



            txtFechaDesde.Text = GetFirstDayInMonth(Today) 'GetFirstDayInMonth(DateAdd(DateInterval.Month, -1, Today))
            txtFechaHasta.Text = GetLastDayInMonth(Today) ' Today ' GetLastDayInMonth(DateAdd(DateInterval.Month, 0, Today))

            Rebind()
            'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
        End If


        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimirLoteFacturas)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimirLoteFacturasNET)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimirLoteFacturasNETzip)

        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimirLoteFacturasAdjuntoWilliams)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnImprimirLoteFacturasAdjuntoWilliamsA4)
        AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnFacturasNoEnviadas)

        Permisos()
    End Sub









    Sub Imprimir(ByVal IdFactura)
        Dim output As String
        'output = ImprimirWordDOT("Factura_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdFactura)
        Dim mvaragrupar = 0 '1 agrupa, <>1 no agrupa





        Dim mvarClausula = False
        Dim mPrinter = ""
        Dim mCopias = 1


        'Acá es el cuelgue clásico: no solamente basta con ver que esten bien las referencias! A veces,
        'aunque figuren bien, el Inter25 explota. Así que no tenés otra manera de probarlo que ejecutando la
        'llamada a Emision desde el Excel del servidor y ver donde explota.
        '-No está encontrando los controles del UserControl o el UserForm (que tiene el codigo de barras)
        '-Claro! Porque, en cuanto ve que no esta el Inter25.OCX, desaparece la instancia del control!!!!
        '-Por ahora usá la de FontanaNicastro, que no tiene controlcito para codigo de barras
        'Dim p = "Factura_A_FontanaNicastro.dot" '"Factura.dot"   "Factura_PRONTO.dot"
        Dim p = DirApp() & "\Documentos\" & "Factura_Williams.dot"


        Try
            output = ImprimirWordDOT(p, Me, HFSC.Value, Session, Response, IdFactura, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Factura.doc")
        Catch ex As System.Runtime.InteropServices.COMException
            'If ex.ToString = "No se puede abrir el almacenamiento de macros." Then
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala (NO DESDE SU EQUIPO, sino en el servidor o por terminal), pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        Catch ex As Exception
            ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala, pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            Exit Sub
        End Try







        Try
            Dim MyFile1 = New FileInfo(output) 'quizás si me fijo de nuevo, ahora verifica que el archivo existe...
            If MyFile1.Exists Then
                Response.ContentType = "application/octet-stream"
                Response.AddHeader("Content-Disposition", "attachment; filename=" & MyFile1.Name)
                'problema: UpdatePanel and Response.Write / Response.TransmitFile http://forums.asp.net/t/1090634.aspx
                'TENES QUE AGREGAR EN EL Page_Load (AUN CUADO ES POSTBACK)!!!!!
                'AjaxControlToolkit.ToolkitScriptManager.GetCurrent(Me.Page).RegisterPostBackControl(btnAceptaDevolucion)
                Response.TransmitFile(output)
                Response.End()
            Else
                'MsgBoxAjax(Me, "No se pudo generar el informe. Consulte al administrador")
            End If
        Catch ex As Exception
            'No se puede abrir el almacenamiento de macros
            ErrHandler2.WriteError(ex.ToString)
            Throw
            'Return
        End Try

    End Sub

    Sub Permisos()
        Dim p = BDLmasterPermisosManager.Fetch(ConexBDLmaster, Session(SESSIONPRONTO_UserId), BDLmasterPermisosManager.EntidadesPermisos.Facturas)

        If Not p("PuedeLeer") Then
            'esto tiene que anular el sitemapnode
            GridView1.Visible = False
            lnkNuevo.Visible = False
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

        s += " AND ( " & _
                                   "Convert(" & cmbBuscarEsteCampo.SelectedValue & ", 'System.String') LIKE '*" & txtBuscar.Text & "*' )" '_

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

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Select Case e.CommandName.ToLower
            Case "ver"
                Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                Dim IdFactura As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)

                Dim sUrl As String = String.Format("Factura.aspx?Id={0}", IdFactura.ToString)
                'Response.Redirect(sUrl)

                Dim str As String
                str = "window.open('" & sUrl & "', 'List', 'scrollbars=no,resizable=no,width=1200,height=800,left=0,top=0,toolbar=No,status=No,fullscreen=No');"
                AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)



        End Select
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...
            gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, "DetFacturas_TXFac", DataBinder.Eval(e.Row.DataItem, "Id"))
            gp.DataBind()


            If iisNull(e.Row.DataItem("FueEnviadoCorreoConFacturaElectronica")) = "SI" Then
                e.Row.BackColor = Drawing.Color.LightGreen
            End If

            If iisNull(e.Row.DataItem("TieneNotaDeCredito")) > 0 Then
                e.Row.BackColor = Drawing.Color.Yellow
            End If

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

    Protected Sub lnkNuevo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkNuevo.Click
        Response.Redirect(String.Format("Factura.aspx?Id=-1"))
    End Sub


    Function GetConnectionString() As String
        Dim stringConn As String = String.Empty
        If Not (Session(SESSIONPRONTO_USUARIO) Is Nothing) Then
            stringConn = DirectCast(Session(SESSIONPRONTO_USUARIO), Usuario).StringConnection
        Else
            Server.Transfer("~/Login.aspx")
        End If
        Return stringConn
    End Function







    Protected Sub cmbBuscarEsteCampo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbBuscarEsteCampo.SelectedIndexChanged
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()

        Rebind()
        GridView1.PageIndex = 0
    End Sub

    Protected Sub txtBuscar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtBuscar.TextChanged
        'http://forums.asp.net/t/1284166.aspx
        'esto solo se puede usar si el ODS usa un dataset
        'ObjectDataSource1.filterparameters.clear()
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        Rebind()
        GridView1.PageIndex = 0
        'GridView1.databind()

        'http://forums.asp.net/p/1379591/2914907.aspx#2914907
    End Sub

    'Protected Sub txtFechaDesde_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaDesde.TextChanged
    '    'Rebind()
    'End Sub
    'Protected Sub txtFechaHasta_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtFechaHasta.TextChanged
    '    'Rebind()
    'End Sub



    Sub Rebind()


        Dim pageIndex = GridView1.PageIndex

        Dim dt As DataTable = dtdatasource(pageIndex)

        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'ordeno
        Dim b As Data.DataView = DataTableORDER(dt, "Id DESC")
        ViewState("Sort") = b.Sort


        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        GridView1.DataSourceID = ""
        GridView1.DataSource = b
        GridView1.DataBind()
        GridView1.PageIndex = pageIndex


    End Sub

    Function dtdatasource(ByVal pageIndex As Integer) As DataTable

        Dim dt As DataTable

        'Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
        'Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)

        Dim desde As Date
        If txtFechaDesde.Text = "" Then
            desde = #1/1/1900#
        Else
            desde = TextoAFecha(txtFechaDesde.Text)
        End If

        Dim hasta As Date '= IIf(txtFechahasta.Text = "", Today, TextoAFecha(txtFechahasta.Text))
        If txtFechaHasta.Text = "" Then
            hasta = Today
        Else
            hasta = TextoAFecha(txtFechaHasta.Text)
        End If

        'Dim cmbMesFiltro As DropDownList = CType(Master.FindControl("cmbMesFiltro"), DropDownList)

        'If cmbMesFiltro.Text = "Todas" Then
        'If False Then
        '    txtFechaDesde.Text = #1/1/1900#
        '    txtFechahasta.Text = #1/1/2100#
        'Else
        '    txtFechaDesde.Text = GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
        '    txtFechahasta.Text = GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
        'End If




        ''chupo
        'If HFTipoFiltro.Value = "Aconfirmar" Then
        '    dt = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_AConfirmar, -1)
        '    With dt
        '        .Columns("IdRequerimiento").ColumnName = "Id"
        '        .Columns("Nro_ Req_ a Conf_").ColumnName = "Numero"

        '        .Columns.Add("Recibido")
        '        .Columns.Add("Entregado")
        '        .Columns.Add("Presupuestos")
        '        .Columns.Add("Comparativas")
        '        .Columns.Add("Pedidos")
        '        .Columns.Add("Recepciones")
        '        .Columns.Add("Salidas")


        '        '.Columns.Add("Obra")
        '        '.Columns.Add("Sector")
        '        '.Columns.Add("Origen")
        '        .Columns.Add("Equipo destino")
        '        .Columns.Add("Anulo")
        '        .Columns.Add("Fecha anulacion")
        '        .Columns.Add("Motivo anulacion")

        '        .Columns.Add("Tipo compra")
        '        .Columns.Add("2da_Firma")
        '        .Columns.Add("Fecha 2da_Firma")
        '        .Columns.Add("Comprador")
        '        .Columns.Add("Importada por")
        '        .Columns.Add("Fec_llego SAT")
        '        .Columns.Add("Fechas de liberacion para compras por item")
        '        .Columns.Add("Detalle imputacion")
        '        .Columns.Add("Observaciones")
        '        .Columns.Add("Elim_Firmas")


        '        'GridView1.AutoGenerateColumns = True
        '    End With

        'ElseIf HFTipoFiltro.Value = "Aliberar" Then
        '    dt = EntidadManager.GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TX_ALiberar, -1)
        '    With dt
        '        .Columns("IdRequerimiento").ColumnName = "Id"
        '        .Columns("Nro_ Req_ a Conf_").ColumnName = "Numero"

        '        .Columns.Add("Recibido")
        '        .Columns.Add("Entregado")
        '        .Columns.Add("Presupuestos")
        '        .Columns.Add("Comparativas")
        '        .Columns.Add("Pedidos")
        '        .Columns.Add("Recepciones")
        '        .Columns.Add("Salidas")


        '        '.Columns.Add("Obra")
        '        '.Columns.Add("Sector")
        '        '.Columns.Add("Origen")
        '        .Columns.Add("Equipo destino")
        '        .Columns.Add("Anulo")
        '        .Columns.Add("Fecha anulacion")
        '        .Columns.Add("Motivo anulacion")

        '        .Columns.Add("Tipo compra")
        '        .Columns.Add("2da_Firma")
        '        .Columns.Add("Fecha 2da_Firma")
        '        .Columns.Add("Comprador")
        '        .Columns.Add("Importada por")
        '        .Columns.Add("Fec_llego SAT")
        '        .Columns.Add("Fechas de liberacion para compras por item")
        '        .Columns.Add("Detalle imputacion")
        '        .Columns.Add("Observaciones")
        '        .Columns.Add("Elim_Firmas")


        '        'GridView1.AutoGenerateColumns = True
        '    End With
        'Else


        If True Then
            'filtrar por fecha
            'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, DateAdd(DateInterval.Month, -100, Now), Now, -1)
            'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, #7/1/2009#, #7/31/2009#, -1)
            Try
                dt = GetStoreProcedure(HFSC.Value, enumSPs.wFacturas_TXFecha, desde, hasta, -1)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                ErrHandler2.WriteError(desde & " " & hasta)


                'temas de timeout? verificar índices

                'CREATE NONCLUSTERED INDEX [facturas_fecha]
                '       ON [dbo].[Facturas] ([FechaFactura])
                '                INCLUDE([IdFactura], [NumeroFactura], [TipoABC], [PuntoVenta], [IdCliente], [IdVendedor], [Anulada],
                '                [ImporteTotal], [ImporteIva1], [ImporteIva2], [ImporteBonificacion], [RetencionIBrutos1], [RetencionIBrutos2],
                '                [RetencionIBrutos3], [FechaVencimiento], [IVANoDiscriminado], [IdMoneda], [IdProvinciaDestino], [IdUsuarioIngreso],
                '                [FechaIngreso], [IdObra], [IdCodigoIva], [PercepcionIVA], [ActivarRecuperoGastos], [ContabilizarAFechaVencimiento],
                '                [FacturaContado], [CAE], [RechazoCAE], [FechaVencimientoORechazoCAE], [AjusteIva], [FueEnviadoCorreoConFacturaElectronica])


                'CREATE NONCLUSTERED INDEX [facturas_fecha2]
                '       ON [dbo].[Facturas] ([FechaFactura])
                '                INCLUDE([IdFactura], [NumeroFactura], [TipoABC], [PuntoVenta], [IdCliente], [IdVendedor],
                '                [Anulada], [ImporteTotal], [ImporteIva1], [ImporteIva2], [ImporteBonificacion], [RetencionIBrutos1],
                '                [RetencionIBrutos2], [RetencionIBrutos3], [FechaVencimiento], [IVANoDiscriminado], [IdMoneda],
                '                [IdProvinciaDestino], [IdUsuarioIngreso], [FechaIngreso], [IdObra], [IdCodigoIva], [PercepcionIVA],
                '                [ActivarRecuperoGastos], [ContabilizarAFechaVencimiento], [FacturaContado], [CAE], [RechazoCAE],
                '                [FechaVencimientoORechazoCAE], [AjusteIva], [FueEnviadoCorreoConFacturaElectronica])
                '                GO()


                'CREATE NONCLUSTERED INDEX [CuentasCorrientesDeudores_tipocomp]
                '           ON [dbo].[CuentasCorrientesDeudores] ([IdTipoComp])
                '                INCLUDE([IdCtaCte], [IdComprobante])
                '                GO()

            End Try



            'filtrar por punto de venta
            If If(EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)), New Pronto.ERP.BO.Empleado()).PuntoVentaAsociado > 0 Then
                Dim pventa = EmpleadoManager.GetItem(HFSC.Value, Session(SESSIONPRONTO_glbIdUsuario)).PuntoVentaAsociado 'sector del confeccionó
                If iisNull(pventa, 0) <> 0 Then
                    'NumeroPuntoVentaSegunSucursalWilliams                  () 
                    dt = DataTableWHERE(dt, "[Pto_Vta_] = " & pventa & " OR [Pto_Vta_] = " & pventa * 10)
                End If
            End If




            'dt = GetStoreProcedure(HFSC.Value, enumSPs.Requerimientos_TXFecha, #7/1/2009#, #7/31/2009#, -1)
            'dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TXFecha, TextoAFecha(txtFechaDesde.Text), TextoAFecha(txtFechahasta.Text), -1)
            With dt
                .Columns("IdFactura").ColumnName = "Id"
                .Columns("Factura").ColumnName = "Numero"
            End With

        Else
            'filtrar por pagina
            Dim lTopRow = pageIndex * GridView1.PageSize + 1
            dt = GetStoreProcedure(HFSC.Value, enumSPs.wRequerimientos_TTpaginado, lTopRow, GridView1.PageSize)
            With dt
                .Columns("IdRequerimiento").ColumnName = "Id"
                .Columns("Numero Req_").ColumnName = "Numero"
            End With
        End If



        '///////////////////////////////////////////////////
        '///////////////////////////////////////////////////
        'filtro
        dt = DataTableWHERE(dt, GenerarWHERE)

        Return dt
    End Function

    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////



    Sub LoteFacturasNET(ByVal Facturas As Generic.IList(Of Integer), Optional ByVal letra As String = "A", Optional bZíp As Boolean = False)

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


        Dim CANTIDAD_COPIAS As Integer = ConfigurationManager.AppSettings("Debug_CantidadCopiasCartaPorte")  'BuscarClaveINI("CantidadCopiasCartaPorte", sc, )

        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Genera las plantillas 
        Dim p = DirApp() & "\Documentos\" & "FacturaNET_Williams.docx"



        Dim prefijo As String = Int(Rnd() * 10000)



        Try
            Kill(System.IO.Path.GetTempPath & prefijo & "FacturaNET_Numero*.docx")
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



        Try

            For Each i In Facturas 'GetListaDeFacturasTildadas()
                ' Dim ofac = ClaseMigrar.GetItemComProntoFactura(HFSC.Value, i, False)
                Dim ofac = FacturaManager.GetItem(HFSC.Value, i, True)


                output = System.IO.Path.GetTempPath() & "\" & prefijo & "FacturaNET_Numero" & ofac.Numero & ".docx"
                'tengo que copiar la plantilla en el destino, porque openxml usa el archivo que le vaya a pasar
                Dim MyFile2 = New FileInfo(output) 'busca si ya existe el archivo a generar y en ese caso lo borra
                If MyFile2.Exists Then
                    MyFile2.Delete()
                End If

                Try
                    System.IO.File.Copy(p, output) 'http://stackoverflow.com/questions/1233228/saving-an-openxml-document-word-generated-from-a-template 

                Catch ex As Exception
                    MsgBoxAlert("Problema de acceso en el directorio de plantillas. Verificar permisos" & ex.ToString)
                    Exit Sub
                End Try


                If ofac.TipoFactura = letra Or True Then
                    'output = CartaDePorteManager.FacturaXML_DOCX_Williams(p,  Me, HFSC.Value, Session, Response, i, mvarClausula, mPrinter, mCopias, System.IO.Path.GetTempPath & "Fact_" & i & ".doc")

                    Try

                        CartaDePorteManager.FacturaXML_DOCX_Williams(output, ofac, HFSC.Value)
                    Catch ex As Exception
                        ErrHandler2.WriteAndRaiseError("Factura id=" & ofac.Id.ToString & " . " & ex.ToString)
                    End Try




                    For n = 2 To CANTIDAD_COPIAS
                        System.IO.File.Copy(output, System.IO.Path.GetTempPath() & "\" & prefijo & "FacturaNET_Numero" & ofac.Numero & "_" & n & ".docx")
                    Next




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
            'ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            'MsgBoxAjax(Me, "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala (NO DESDE SU EQUIPO, sino en el servidor o por terminal), pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")
            ErrHandler2.WriteError(ex)
            MsgBoxAjax(Me, "No se generaron facturas " & ex.ToString)
            Exit Sub
        Catch ex As Exception
            'ErrHandler2.WriteError(ex.ToString & ". Verificar que la DLL ComPronto esté bien referenciada en la plantilla, o que la macro no está explotando por las suyas (dentro de la ejecucion normal, algun campo sin llenar), o esté bien puesta la ruta a la plantilla, o habilitadas las macros. Ejecutar la misma linea con que se llamó en Word, y ver si no está explotando dentro de la ejecucion normal de la macro.   ")
            'MsgBoxAjax(Me, ex.ToString & "Verificar que DLL ComPronto esté bien referenciada en la plantilla " & p & "  Abrala, pulse alt-f11, Menu Herramientas->Referencias, y verifique la referencia a ComPronto")

            ErrHandler2.WriteError(ex)
            MsgBoxAlert("No se generaron facturas " & ex.ToString)
            Exit Sub
        End Try


        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        '////////////////////////////////////////////////////////
        'Hace el rejunte

        'output = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir.doc"
        'Dim outputtxt = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir " & Now.ToString("ddMMMyyyy_HHmmss") & ".doc.prontotxt"

        'output = outputtxt

        'ProntoFuncionesUIWebc()



        Dim wordFiles As String() = Directory.GetFiles(System.IO.Path.GetTempPath(), prefijo & "FacturaNET_Numero*.docx")

        'stringMerge = RESETEAR & CANCELCONDENSED

        Dim ssss As New Generic.List(Of Byte())


        If False Then
            ' formato html
            Dim wordDoc = DocumentFormat.OpenXml.Packaging.WordprocessingDocument.Open(wordFiles(0), True)
            Dim html = OpenXmlPowerTools.HtmlConverter.ConvertToHtml(wordDoc, New OpenXmlPowerTools.HtmlConverterSettings())
            wordDoc.Dispose()
            output += ".html"
            File.WriteAllText(output, html.ToString())

        ElseIf False Then

            'For i = 0 To wordFiles.Length - 1
            '    ssss.Add(File.ReadAllBytes(wordFiles(i)))
            'Next

            ''no está solucionado el tema del salto de pagina.  y el uso de AppendPageBreak???
            ''http://stackoverflow.com/questions/1278024/mixing-c-sharp-vb-in-the-same-project
            ''http://stackoverflow.com/questions/2339776/mixing-vb-net-and-c-sharp-code-in-an-asp-net-web-site-project
            'Dim a As New OfficeMergeControl.CombineDocs()

            'If True Then
            '    Dim archivofinal = a.OpenAndCombine(ssss)
            '    File.WriteAllBytes(output, archivofinal)
            'Else
            '    Dim archivofinal = a.CreateDocument(ssss) ' no anda bien. los ensarta por el medio
            '    File.WriteAllBytes(output, archivofinal)
            'End If

        ElseIf Not bZíp Then
            output += ".temppronto.docx"
            'If MyFile2.Exists Then
            '    MyFile2.Delete()
            'End If
            'KeithRull.Utilities.OfficeInterop.MsWord.Merge(wordFiles, output, True, "") 'p) '"") 'wordFiles(0))

            Try
                KeithRull.Utilities.OfficeInterop.MsWord.Merge_abriendoEnModoNoTemplateYanexando(wordFiles, output, True, "") 'p) '"") 'wordFiles(0))
                'http://stackoverflow.com/questions/1278024/mixing-c-sharp-vb-in-the-same-project
                'http://stackoverflow.com/questions/2339776/mixing-vb-net-and-c-sharp-code-in-an-asp-net-web-site-project


            Catch ex As Exception
                ErrHandler2.WriteError("Lote muy grande? Verificar que se mató al proceso WINWORD.EXE")
                ErrHandler2.WriteAndRaiseError(ex)


                '                Log(Entry)
                '05/06/2014 12:22:18
                'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Facturas.aspx?ImprimirDesde=58902&ImprimirHasta=59129&Modo=DOCX. Error Message:System.Runtime.InteropServices.InvalidComObjectException: COM object that has been separated from its underlying RCW cannot be used.
                '   at Microsoft.Office.Interop.Word.ApplicationClass.Quit(Object& SaveChanges, Object& OriginalFormat, Object& RouteDocument)
                '   at KeithRull.Utilities.OfficeInterop.MsWord.Merge_abriendoEnModoNoTemplateYanexando(String[] filesToMerge, String outputFilename, Boolean insertPageBreaks, String documentTemplate)
                '   at Facturas.LoteFacturasNET(IList`1 Facturas, String letra, Boolean bZíp)


                '                URL:	/ProntoWeb/Facturas.aspx?ImprimirDesde=58902&ImprimirHasta=59129&Modo=DOCX
                'User:           factsl()
                '                Exception(Type) : System.ApplicationException()
                'Message:	WriteAndRaiseError: System.Runtime.InteropServices.InvalidComObjectException: COM object that has been separated from its underlying RCW cannot be used. at Microsoft.Office.Interop.Word.ApplicationClass.Quit(Object& SaveChanges, Object& OriginalFormat, Object& RouteDocument) at KeithRull.Utilities.OfficeInterop.MsWord.Merge_abriendoEnModoNoTemplateYanexando(String[] filesToMerge, String outputFilename, Boolean insertPageBreaks, String documentTemplate) at Facturas.LoteFacturasNET(IList`1 Facturas, String letra, Boolean bZíp)
                'Stack Trace:	 at ErrHandler2.WriteAndRaiseError(Exception e) in C:\Backup\BDL\BussinessObject\ErrHandler2.vb:line 150
                'at Facturas.LoteFacturasNET(IList`1 Facturas, String letra, Boolean bZíp)
                'at Facturas.Page_Load(Object sender, EventArgs e)
                'at System.Web.UI.Control.OnLoad(EventArgs e)
                '                at(System.Web.UI.Control.LoadRecursive())
                'at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)



            End Try

            'output = wordFiles(0)
            System.IO.File.Copy(output, output + ".temppronto2.docx")
            output += ".temppronto2.docx"
        Else
            'usar novacode.docx

            output = output & ".zip"
            Dim MyFile1 = New FileInfo(output)
            If MyFile1.Exists Then
                MyFile1.Delete()
            End If
            Dim zip As Ionic.Zip.ZipFile = New Ionic.Zip.ZipFile(output) 'usando la .NET Zip Library
            For Each s In wordFiles
                zip.AddFile(s, "")
            Next

            zip.Save()



        End If







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
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////
    '///////////////////////////////////////////////////


    Sub TransfiereMerge(ByVal Facturas As Generic.IList(Of Integer), Optional ByVal letra As String = "A")
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

            'Dim ultimoidpresente As Long = EntidadManager.ExecDinamico(HFSC.Value, "SELECT TOP 1 idFactura from Facturas order by idFactura desc").Rows(0).Item("IdFactura")
            For Each i In Facturas 'GetListaDeFacturasTildadas()
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


        'Dim incluirtarifa As Boolean = False
        'Try
        '    incluirtarifa = IIf(ClienteManager.GetItem(HFSC.Value, ClaseMigrar.GetItemComProntoFactura(HFSC.Value, Facturas(0), False).IdCliente).IncluyeTarifaEnFactura = "SI", True, False)
        'Catch ex As Exception
        '    ErrHandler2.WriteError(ex)
        'End Try




        WilliamsFacturaWordToTxtMasMergeOpcional(System.IO.Path.GetTempPath, outputtxt, , HFSC.Value, Facturas(0)) '  incluirtarifa

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




    Sub TransfiereMerge(ByVal DesdeIdFactura As Integer, ByVal HastaIdFactura As Integer, Optional ByVal letra As String = "A")
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

            'Dim ultimoidpresente As Long = EntidadManager.ExecDinamico(HFSC.Value, "SELECT TOP 1 idFactura from Facturas order by idFactura desc").Rows(0).Item("IdFactura")
            For i = DesdeIdFactura To HastaIdFactura
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
        Dim outputtxt = System.IO.Path.GetTempPath & "Lote Facturas para Imprimir.doc.prontotxt"

        If False Then
            MergeWordDocsVersion2(System.IO.Path.GetTempPath, output)
        End If


        'Dim incluirtarifa As Boolean = False
        'Try
        '    pero y si es una tanda de clientes distintos???????
        '    incluirtarifa = IIf(ClienteManager.GetItem(HFSC.Value, ClaseMigrar.GetItemComProntoFactura(HFSC.Value, DesdeIdFactura, False).IdCliente).IncluyeTarifaEnFactura = "SI", True, False)
        'Catch ex As Exception
        '    ErrHandler2.WriteError(ex)
        'End Try




        WilliamsFacturaWordToTxtMasMergeOpcional(System.IO.Path.GetTempPath, outputtxt, , HFSC.Value, DesdeIdFactura) '  incluirtarifa)

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

    Function GetListaDeFacturasTildadas() As Generic.List(Of Integer)
        'todo
        Try

            KeepSelection(GridView1)
            GetListaDeFacturasTildadas = TraerLista(GridView1)
            'ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.
            HttpContext.Current.Session("ProdSelection" + GridView1.ID) = Nothing
            RestoreSelection(GridView1)
            Rebind()
            'borrarlista()
        Catch ex As Exception
            ErrHandler2.WriteError(ex)

            Rebind()
            'MsgBoxAjax(Me, "No hay facturas seleccionadas")
            'Return
            Throw
        End Try

    End Function

    Protected Sub btnImprimirLoteFacturas_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImprimirLoteFacturas.Click

        'se estan limpiando los txtfacturadesde y hasta

        Try
            Dim desde = txtFacturaDesde.Text.Replace("_", " ")
            Dim hasta = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(desde, 1), Val(Mid(desde, 3, 4)), Val(Right(desde, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(hasta, 1), Val(Mid(hasta, 3, 4)), Val(Right(hasta, 8)))

            Dim lista As Generic.List(Of Integer)

            If IsNothing(f) Then
                Try

                    lista = GetListaDeFacturasTildadas()
                Catch ex As Exception
                    MsgBoxAjax(Me, "No hay facturas seleccionadas")
                    Return
                End Try
                If lista.Count = 0 Then
                    MsgBoxAjax(Me, "No hay facturas seleccionadas")
                    Return
                End If
                TransfiereMerge(lista, "A")

            ElseIf IsNothing(f2) Then
                'hay q hacer un transfiereMerge q acepte una lista de Id
                TransfiereMerge(f.Id, FacturaManager.UltimoId(HFSC.Value)) ' f2.Id)
            Else
                TransfiereMerge(f.Id, f2.Id) ' f2.Id)
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub







    Protected Sub btnImprimirLoteFacturasNET_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImprimirLoteFacturasNET.Click
        Try
            Dim desde = txtFacturaDesde.Text.Replace("_", " ")
            Dim hasta = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(desde, 1), Val(Mid(desde, 3, 4)), Val(Right(desde, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(hasta, 1), Val(Mid(hasta, 3, 4)), Val(Right(hasta, 8)))

            Dim lista As New Generic.List(Of Integer)

            If IsNothing(f) Then
                lista = GetListaDeFacturasTildadas()
                If lista.Count = 0 Then
                    MsgBoxAjax(Me, "No hay facturas seleccionadas")
                    Return
                End If
                LoteFacturasNET(lista, "A")
            ElseIf IsNothing(f2) Then
                For i = f.Id To FacturaManager.UltimoId(HFSC.Value)
                    lista.Add(i)
                Next
                LoteFacturasNET(lista, "A")
                'hay q hacer un transfiereMerge q acepte una lista de Id
                ' LoteFacturasNET(f.Id, FacturaManager.UltimoId(HFSC.Value)) ' f2.Id)
            Else
                For i = f.Id To f2.Id
                    lista.Add(i)
                Next
                LoteFacturasNET(lista, "A")  ' f2.Id)
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub

    Protected Sub btnImprimirLoteFacturasNETzip_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImprimirLoteFacturasNETzip.Click
        Try
            Dim desde = txtFacturaDesde.Text.Replace("_", " ")
            Dim hasta = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(desde, 1), Val(Mid(desde, 3, 4)), Val(Right(desde, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(hasta, 1), Val(Mid(hasta, 3, 4)), Val(Right(hasta, 8)))

            Dim lista As New Generic.List(Of Integer)

            If IsNothing(f) Then
                lista = GetListaDeFacturasTildadas()
                If lista.Count = 0 Then
                    MsgBoxAjax(Me, "No hay facturas seleccionadas")
                    Return
                End If
                LoteFacturasNET(lista, "A")
            ElseIf IsNothing(f2) Then
                For i = f.Id To FacturaManager.UltimoId(HFSC.Value)
                    lista.Add(i)
                Next
                LoteFacturasNET(lista, "A", True)
                'hay q hacer un transfiereMerge q acepte una lista de Id
                ' LoteFacturasNET(f.Id, FacturaManager.UltimoId(HFSC.Value)) ' f2.Id)
            Else
                For i = f.Id To f2.Id
                    lista.Add(i)
                Next
                LoteFacturasNET(lista, "A")  ' f2.Id)
            End If

        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub


    Protected Sub EnviarMailAdjunto(ByVal SC As String, ByVal IdFactura As Long)

        'Cómo se mandan por correo?
        Dim output = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel(SC, IdFactura, "", ReporteLocal)

        '        __________________________()
        '        algunos explotan acá y no se mandan
        '        Log(Entry)
        '09/10/2014 11:49:00
        'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Facturas.aspx?tipo=Confirmados. Error Message:System.IO.IOException
        'The process cannot access the file 'C:\Windows\TEMP\AdjuntoDeFactura 10Sep2014_114859.xls' because it is being used by another process.
        '   at System.IO.__Error.WinIOError(Int32 errorCode, String maybeFullPath)
        '   at System.IO.FileStream.Init(String path, FileMode mode, FileAccess access, Int32 rights, Boolean useRights, FileShare share, Int32 bufferSize, FileOptions options, SECURITY_ATTRIBUTES secAttrs, String msgPath, Boolean bFromProxy)
        '   at System.IO.FileStream..ctor(String path, FileMode mode, FileAccess access, FileShare share, Int32 bufferSize, FileOptions options, String msgPath, Boolean bFromProxy)
        '   at System.IO.FileStream..ctor(String path, FileMode mode)
        '   at CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel(String SC, Int32 IdFactura, String& ArchivoExcelDestino, ReportViewer& ReportViewer2)
        '   at Facturas.EnviarMailAdjunto(String SC, Int64 IdFactura)
        '   at Facturas.ImprimirLoteAdjuntosPorListaMail(List`1 lista)
        '        mscorlib()
        '        __________________________()



        Try
            Dim destinatario As String
            Dim cuerpo As String

            Dim myFactura = FacturaManager.GetItem(SC, IdFactura, True) 'va a editar ese ID

            destinatario = ClienteManager.GetItem(SC, myFactura.IdCliente).Email ' MailDestino ' txtDireccionMailAdjuntoWilliams.Text


            '#8637	     Correos de adjuntos, enviar con copia al usuario


            CartaDePorteManager.EnviarEmailDeAdjuntosDeWilliams(HFSC.Value, IdFactura, output, destinatario, _
                                                                iisNull(UsuarioSesion.Mail(HFSC.Value, Session)))


            'EnviarEmail(destinatario, "Adjunto de facturación", "", _
            '        ConfigurationManager.AppSettings("SmtpUser"), _
            '        ConfigurationManager.AppSettings("SmtpServer"), _
            '        ConfigurationManager.AppSettings("SmtpUser"), _
            '        ConfigurationManager.AppSettings("SmtpPass"), _
            '         output, _
            '        ConfigurationManager.AppSettings("SmtpPort"), , iisNull(UsuarioSesion.Mail(HFSC.Value, Session)), , "Williams Entregas")


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


    End Sub


    Protected Sub btnMandarAdjuntosMails_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMandarAdjuntosMails.Click

        Try
            txtFacturaDesde.Text = txtFacturaDesde.Text.Replace("_", " ")
            txtFacturaHasta.Text = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaDesde.Text, 1), Val(Mid(txtFacturaDesde.Text, 3, 4)), Val(Right(txtFacturaDesde.Text, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaHasta.Text, 1), Val(Mid(txtFacturaHasta.Text, 3, 4)), Val(Right(txtFacturaHasta.Text, 8)))

            Dim DesdeIdFactura, HastaIdFactura As Long



            Try
                Kill(System.IO.Path.GetTempPath & "*.txt")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                Kill(System.IO.Path.GetTempPath & "*.doc")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try





            If IsNothing(f) Then
                Dim lista = GetListaDeFacturasTildadas()
                ImprimirLoteAdjuntosPorListaMail(lista)
                Return
            ElseIf IsNothing(f2) Then
                DesdeIdFactura = f.Id
                HastaIdFactura = FacturaManager.UltimoId(HFSC.Value)
            Else
                DesdeIdFactura = f.Id
                HastaIdFactura = f2.Id
            End If




            Dim sw As StreamWriter
            Dim sr As System.IO.StreamReader
            Dim output = DirApp() & "\Documentos\" & "Adjuntos_Williams_ " & Now.ToString("ddMMMyyyy_HHmmss") & "  .prontotxt"



            sw = IO.File.CreateText(output)



            If HastaIdFactura - DesdeIdFactura > MAX_ADJUNTOS Then
                MsgBoxAjax(Me, "No se pueden elegir mas de " & MAX_ADJUNTOS & " items")
                Exit Sub
            End If

            Dim er As Integer = 0
            Dim ok As Integer = 0

            For i = DesdeIdFactura To HastaIdFactura



                Try
                    'Dim o As String
                    'o = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON(HFSC.Value, i)

                    EnviarMailAdjunto(HFSC.Value, i)
                    'sr = System.IO.File.OpenText(o)
                    'Dim MyContents As String = sr.ReadToEnd


                    'sw.Write(MyContents)
                    ok += 1
                Catch ex As Exception
                    er += 1
                    ErrHandler2.WriteError(ex)
                End Try


            Next




            sw.Flush()
            sw.Close()


            MsgBoxAjax(Me, "Enviados " & ok & ". Errores" & er)


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub


    Sub ImprimirLoteAdjuntosPorLista(ByVal lista As Generic.List(Of Integer))
        Try
            txtFacturaDesde.Text = txtFacturaDesde.Text.Replace("_", " ")
            txtFacturaHasta.Text = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaDesde.Text, 1), Val(Mid(txtFacturaDesde.Text, 3, 4)), Val(Right(txtFacturaDesde.Text, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaHasta.Text, 1), Val(Mid(txtFacturaHasta.Text, 3, 4)), Val(Right(txtFacturaHasta.Text, 8)))

            Dim DesdeIdFactura, HastaIdFactura As Long

            'If IsNothing(f) Then
            '    Dim lista = GetListaDeFacturasTildadas()
            '    'TransfiereMerge(lista, "a")
            'ElseIf IsNothing(f2) Then
            '    HastaIdFactura = FacturaManager.UltimoId(HFSC.Value)
            'Else
            '    HastaIdFactura = f2.Id
            'End If




            Try
                Kill(System.IO.Path.GetTempPath & "*.txt")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                Kill(System.IO.Path.GetTempPath & "*.doc")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            Dim sw As StreamWriter
            Dim sr As System.IO.StreamReader
            Dim output = DirApp() & "\Documentos\" & "Adjuntos_Williams_ " & Now.ToString("ddMMMyyyy_HHmmss") & "  .prontotxt"
            sw = IO.File.CreateText(output)

            If lista.Count > MAX_ADJUNTOS Then
                MsgBoxAjax(Me, "No se pueden elegir mas de " & MAX_ADJUNTOS & " items")
                Exit Sub
            End If

            'lista.Sort()

            'ErrHandler2WriteErrorLogPronto(lista.ToString,HFSC.Value,
            Dim st As String = Join(lista.ConvertAll(Function(i) i.ToString).ToArray)
            ErrHandler2.WriteError(st)


            For Each i In lista

                Try
                    Dim o As String
                    o = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON(HFSC.Value, i, "", ReporteLocal)

                    sr = System.IO.File.OpenText(o)
                    Dim MyContents As String = sr.ReadToEnd


                    sw.Write(MyContents)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


            Next



            sw.Flush()
            sw.Close()


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


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub



    Sub ImprimirLoteAdjuntosPorListaMail(ByVal lista As Generic.List(Of Integer))
        Try
            txtFacturaDesde.Text = txtFacturaDesde.Text.Replace("_", " ")
            txtFacturaHasta.Text = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaDesde.Text, 1), Val(Mid(txtFacturaDesde.Text, 3, 4)), Val(Right(txtFacturaDesde.Text, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaHasta.Text, 1), Val(Mid(txtFacturaHasta.Text, 3, 4)), Val(Right(txtFacturaHasta.Text, 8)))

            Dim DesdeIdFactura, HastaIdFactura As Long

            'If IsNothing(f) Then
            '    Dim lista = GetListaDeFacturasTildadas()
            '    'TransfiereMerge(lista, "a")
            'ElseIf IsNothing(f2) Then
            '    HastaIdFactura = FacturaManager.UltimoId(HFSC.Value)
            'Else
            '    HastaIdFactura = f2.Id
            'End If


            Try
                Kill(System.IO.Path.GetTempPath & "*.txt")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                Kill(System.IO.Path.GetTempPath & "*.doc")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try


            If lista.Count > MAX_ADJUNTOS Then
                MsgBoxAjax(Me, "No se pueden elegir mas de " & MAX_ADJUNTOS & " items")
                Exit Sub
            End If










            Dim er As Integer = 0
            Dim ok As Integer = 0
            Dim flag As Boolean

            For Each i In lista
                flag = False
                For n = 1 To 10

                    Try
                        EnviarMailAdjunto(HFSC.Value, i)
                        ok += 1
                        flag = True
                        Exit For
                    Catch ex As Exception
                        ErrHandler2.WriteError(ex)
                    End Try

                Next

                If Not flag Then er += 1

            Next




            MsgBoxAjax(Me, "Enviados " & ok & ".  Errores " & er)






        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try



    End Sub


    Protected Sub btnImprimirLoteFacturasAdjuntoWilliams_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImprimirLoteFacturasAdjuntoWilliams.Click


        Try
            txtFacturaDesde.Text = txtFacturaDesde.Text.Replace("_", " ")
            txtFacturaHasta.Text = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaDesde.Text, 1), Val(Mid(txtFacturaDesde.Text, 3, 4)), Val(Right(txtFacturaDesde.Text, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaHasta.Text, 1), Val(Mid(txtFacturaHasta.Text, 3, 4)), Val(Right(txtFacturaHasta.Text, 8)))

            Dim DesdeIdFactura, HastaIdFactura As Long



            Try
                Kill(System.IO.Path.GetTempPath & "*.txt")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                Kill(System.IO.Path.GetTempPath & "*.doc")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try





            If IsNothing(f) Then
                Dim lista = GetListaDeFacturasTildadas()
                ImprimirLoteAdjuntosPorLista(lista)
                Return
            ElseIf IsNothing(f2) Then
                DesdeIdFactura = f.Id
                HastaIdFactura = FacturaManager.UltimoId(HFSC.Value)
            Else
                DesdeIdFactura = f.Id
                HastaIdFactura = f2.Id
            End If




            Dim sw As StreamWriter
            Dim sr As System.IO.StreamReader
            Dim output = DirApp() & "\Documentos\" & "Adjuntos_Williams_ " & Now.ToString("ddMMMyyyy_HHmmss") & "  .prontotxt"



            sw = IO.File.CreateText(output)



            If HastaIdFactura - DesdeIdFactura > MAX_ADJUNTOS Then
                MsgBoxAjax(Me, "No se pueden elegir mas de " & MAX_ADJUNTOS & " items")
                Exit Sub
            End If


            For i = DesdeIdFactura To HastaIdFactura

                Try
                    Dim o As String
                    o = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON(HFSC.Value, i, "", ReporteLocal)

                    sr = System.IO.File.OpenText(o)
                    Dim MyContents As String = sr.ReadToEnd


                    sw.Write(MyContents)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


            Next

            sw.Flush()
            sw.Close()


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


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub



    Protected Sub btnImprimirLoteFacturasAdjuntoWilliamsA4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnImprimirLoteFacturasAdjuntoWilliamsA4.Click


        Try
            txtFacturaDesde.Text = txtFacturaDesde.Text.Replace("_", " ")
            txtFacturaHasta.Text = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaDesde.Text, 1), Val(Mid(txtFacturaDesde.Text, 3, 4)), Val(Right(txtFacturaDesde.Text, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(txtFacturaHasta.Text, 1), Val(Mid(txtFacturaHasta.Text, 3, 4)), Val(Right(txtFacturaHasta.Text, 8)))

            Dim DesdeIdFactura, HastaIdFactura As Long



            Try
                Kill(System.IO.Path.GetTempPath & "*.txt")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try

            Try
                Kill(System.IO.Path.GetTempPath & "*.doc")
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
            End Try





            If IsNothing(f) Then
                Dim lista = GetListaDeFacturasTildadas()
                ImprimirLoteAdjuntosPorLista(lista)
                Return
            ElseIf IsNothing(f2) Then
                DesdeIdFactura = f.Id
                HastaIdFactura = FacturaManager.UltimoId(HFSC.Value)
            Else
                DesdeIdFactura = f.Id
                HastaIdFactura = f2.Id
            End If




            Dim sw As StreamWriter
            Dim sr As System.IO.StreamReader
            Dim output = DirApp() & "\Documentos\" & "Adjuntos_Williams_ " & Now.ToString("ddMMMyyyy_HHmmss") & "  .prontotxt"



            sw = IO.File.CreateText(output)



            If HastaIdFactura - DesdeIdFactura > MAX_ADJUNTOS Then
                MsgBoxAjax(Me, "No se pueden elegir mas de " & MAX_ADJUNTOS & " items")
                Exit Sub
            End If


            For i = DesdeIdFactura To HastaIdFactura

                Try
                    Dim o As String
                    o = CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsEPSON_A4(HFSC.Value, i, "", ReporteLocal)

                    sr = System.IO.File.OpenText(o)
                    Dim MyContents As String = sr.ReadToEnd


                    sw.Write(MyContents)
                Catch ex As Exception
                    ErrHandler2.WriteError(ex)
                End Try


            Next

            sw.Flush()
            sw.Close()


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


        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try

    End Sub


    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
        'http://forums.asp.net/p/956540/1177923.aspx
        'ObjectDataSource1.FilterExpression = GenerarWHERE()
        'ObjectDataSource1.Select()
        Try
            KeepSelection(sender)
        Catch ex As Exception
            ErrHandler2.WriteError(ex)
        End Try


        GridView1.PageIndex = e.NewPageIndex
        Rebind()
    End Sub



    Protected Sub GridView1_PageIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PageIndexChanged
        RestoreSelection(sender)



    End Sub



    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Protected Sub HeaderCheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) 'this is for header checkbox changed event


        'For p = 0 To GridView1.PageCount - 1

        '    'reviso cada pagina de checks
        '    Dim values() As Boolean = Session("page" & p)

        '    For Each row As GridViewRow In GridView1.Rows
        '        For i = 0 To row.Cells.Count - 1
        '            Dim cell As TableCell = row.Cells(i)
        '            Dim c As CheckBox = row.Cells(0).Controls(1)
        '            c.Checked = sender.Checked
        '        Next
        '    Next
        'Next

        For Each row As GridViewRow In GridView1.Rows
            For j = 0 To row.Cells.Count - 1
                Dim cell As TableCell = row.Cells(j)
                Dim c As CheckBox = row.Cells(0).Controls(1)
                c.Checked = sender.Checked
            Next
        Next



        MarcarTodosLosChecks(sender.Checked)

        If sender.Checked Then
            Dim dt = dtdatasource(GridView1.PageIndex)
            Dim i = (From r In dt Select CInt(r("Id"))).ToList


            MarcarLista(GridView1, i)
        Else
            MarcarLista(GridView1, New Generic.List(Of Integer))
        End If


        'GuardaChecks() 'acá tendría que grabar tambien el estado 
    End Sub


    Sub ResetChecks()
        Dim lista As New Generic.List(Of String)
        For Each Item In Session.Contents
            If Left(Item, 4) = "page" Then lista.Add(Item)
        Next
        For Each i In lista
            Session.Remove(i)
        Next
    End Sub

    Sub GuardaChecks()
        'persistencia de los checks http://forums.asp.net/t/1147075.aspx
        'Response.Write(GridView1.PageIndex.ToString()) 'esto para qué es? si lo descomento, no cambia la pagina
        Dim d = GridView1.PageCount
        Dim values(GridView1.PageSize) As Boolean
        Dim chb As CheckBox
        Dim count = 0
        For i = 0 To GridView1.Rows.Count - 1
            chb = GridView1.Rows(i).FindControl("CheckBox1")
            If Not IsNothing(chb) Then values(i) = chb.Checked
        Next
        Session("page" & GridView1.PageIndex) = values

    End Sub

    Sub MarcarTodosLosChecks(ByVal check As Boolean)
        Dim d = GridView1.PageCount
        Dim values(GridView1.PageSize) As Boolean
        'Dim values(GridView1.Rows.Count) As Boolean
        Dim ids(GridView1.Rows.Count) As Long


        For p = 0 To GridView1.PageCount
            For i = 0 To GridView1.PageSize
                values(i) = check
            Next
            Session("page" & p) = values
        Next
    End Sub


    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click

        imprimir_bool(False)


    End Sub

    Protected Sub Button2_Click(sender As Object, e As System.EventArgs) Handles Button2.Click
        imprimir_bool(True)
    End Sub

    Sub imprimir_bool(bVistaPrevia As Boolean)
        Dim sErr As String
        Dim lista As New Generic.List(Of Integer)
        Try
            Dim desde = txtFacturaDesde.Text.Replace("_", " ")
            Dim hasta = txtFacturaHasta.Text.Replace("_", " ")

            Dim f As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(desde, 1), Val(Mid(desde, 3, 4)), Val(Right(desde, 8)))
            Dim f2 As Pronto.ERP.BO.Factura = FacturaManager.GetItemPorNumero(HFSC.Value, Left(hasta, 1), Val(Mid(hasta, 3, 4)), Val(Right(hasta, 8)))


            If IsNothing(f) Then
                lista = GetListaDeFacturasTildadas()
                If lista.Count = 0 Then
                    MsgBoxAjax(Me, "No hay facturas seleccionadas")
                    Return
                End If

                'pedir confirmacion

                sErr = barras.EnviarFacturaElectronicaEMail( _
                          lista, _
                           HFSC.Value, bVistaPrevia, UsuarioSesion.Mail(HFSC.Value, Session) _
               )
            ElseIf IsNothing(f2) Then
                For i = f.Id To FacturaManager.UltimoId(HFSC.Value)
                    lista.Add(i)
                Next

                'pedir confirmacion


                sErr = barras.EnviarFacturaElectronicaEMail( _
                           lista, _
                            HFSC.Value, bVistaPrevia, UsuarioSesion.Mail(HFSC.Value, Session) _
                )
            Else
                For i = f.Id To f2.Id
                    lista.Add(i)
                Next

                'pedir confirmacion


                sErr = barras.EnviarFacturaElectronicaEMail( _
                           lista, _
                            HFSC.Value, bVistaPrevia, UsuarioSesion.Mail(HFSC.Value, Session) _
                )
            End If

        Catch ex As Exception

            '            Log Entry
            '07/08/2015 16:07:01
            'Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/Facturas.aspx. Error Message:System.NullReferenceException
            'Object reference not set to an instance of an object.
            '   at barras.EnviarFacturaElectronicaEMail(IList`1 Facturas, String cliente, String SC, Boolean bVistaPrevia, String sEmail)
            '   at Facturas.Imprimir(Boolean bVistaPrevia)

            'es probable que haya errores con la seleccion de las tildes en la grilla


            ErrHandler2.WriteError(ex)
            ErrHandler2.WriteError("Lista ")
            ErrHandler2.WriteError(lista.Count)
            ErrHandler2.WriteError("Lista " & Join(lista.Select(Function(X) X.ToString).ToArray))
            MsgBoxAjax(Me, ex.ToString)  'sssss
        End Try

        If sErr <> "" Then MsgBoxAjax(Me, sErr)
        'If sErr <> "" Then MsgBoxAlert(sErr) 'por el tema de los saltos de linea uso MsgBoxAlert
    End Sub

    Private Sub ssssss()
        Throw New NotImplementedException
    End Sub

    Private Sub WilliamsFacturaWordToTxtMasMergeOpcional(p1 As String, outputtxt As String, Optional p3 As Object = Nothing, Optional p4 As String = Nothing, Optional DesdeIdFactura As Integer = Nothing)
        Throw New NotImplementedException
    End Sub

    Protected Sub btnImprimir_Click(sender As Object, e As EventArgs) Handles btnImprimir.Click

        Dim pageIndex = GridView1.PageIndex

        Dim dt As DataTable = dtdatasource(pageIndex)

        ProntoFuncionesUIWeb.RebindReportViewer(ReportViewer2, _
            "ProntoWeb\Informes\Listado de Facturas.rdl", _
                    dt, Nothing, , , "")


    End Sub

    Protected Sub btnFacturasNoEnviadas_Click(sender As Object, e As EventArgs) Handles btnFacturasNoEnviadas.Click


        '        at Facturas._Lambda$__4(Factura x)
        'at System.Linq.Enumerable.WhereSelectListIterator`2.MoveNext()
        'at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
        'at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)


        Dim db = New ProntoMVC.Data.Models.DemoProntoEntities(ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(Encriptar(HFSC.Value)))


        Dim q2 = _
                (From x In db.Facturas.Include("Cliente")
                 From cli In db.Clientes.Where(Function(i) i.IdCliente = x.IdCliente).DefaultIfEmpty _
                Where If(x.FueEnviadoCorreoConFacturaElectronica, "NO") = "NO" And x.FechaFactura > #1/1/2015# Select x, cli).ToList


        If q2 Is Nothing Then MsgBoxAjax(Me, "No hay facturas pendientes de enviar")

        ErrHandler2.WriteError("noenviadas " & q2.Count)

        '.Cliente = IIf(x.Cliente IsNot Nothing, x.Cliente.RazonSocial, "").ToString,

        Dim q = (From x In q2
                Select New With {
                    .Numero = x.x.NumeroFactura,
                    .Anulada = x.x.Anulada,
                    .Fecha = IIf(x.x.FechaFactura IsNot Nothing, x.x.FechaFactura.Value.ToShortDateString, "").ToString,
                    .FueEnviadoCorreoConFacturaElectronica = x.x.FueEnviadoCorreoConFacturaElectronica,
                    .Cuit = IIf(x.cli IsNot Nothing, x.cli.Cuit, "").ToString,
                    .Cliente = IIf(x.cli IsNot Nothing, x.cli.RazonSocial, "").ToString,
                    .CAE = x.x.CAE
                }).ToList


        Dim output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
              "ProntoWeb\Informes\Facturas no enviadas.rdl", _
                    q, "")


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

    Protected Sub btnRefrescar_Click(sender As Object, e As EventArgs) Handles btnRefrescar.Click
        Rebind()
        GridView1.PageIndex = 0

    End Sub
End Class







