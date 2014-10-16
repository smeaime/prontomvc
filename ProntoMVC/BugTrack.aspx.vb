Imports Pronto.ERP.Bll
Imports Pronto.ERP.Bll.EntidadManager
Imports System.Diagnostics
Imports System.IO
Imports System.Data



Namespace ProntoMVC.Reportes


    Partial Class BugTrack
        Inherits System.Web.UI.Page

        'Const sConexionConsultasTrackPronto = "Data Source=MARIANO-PC\SQLEXPRESS2;Initial Catalog=AdministradorProyecto;Uid=sa; PWD=ok; "
        Dim sConexionConsultasTrackPronto

        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
            'Session.Add("SC", ConfigurationManager.ConnectionStrings("Pronto").ConnectionString)
            HFSC.Value = GetConnectionString()

            If System.Diagnostics.Debugger.IsAttached() Then
                sConexionConsultasTrackPronto = "Data Source=Mariano-PC\MSSQLSERVER2;Initial Catalog=AdministradorProyecto;Uid=sa; PWD=ok; "
            Else
                sConexionConsultasTrackPronto = "Data Source=192.168.66.1;Initial Catalog=AdministradorProyecto;Uid=sa; PWD=3D1consultore5; "
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
                Else
                    HFTipoFiltro.Value = ""
                End If
                Rebind()
                'ObjectDataSource1.FilterExpression = GenerarWHERE() 'metodo nuevo: acá usa el filtro del ODS 
            End If

            'Permisos()



        End Sub

        Sub Imprimir(ByVal IdCDPStockMovimiento)
            Dim output As String
            'output = ImprimirWordDOT("CDPStockMovimiento_" & session(SESSIONPRONTO_NombreEmpresa) & ".dot", Me, SC, Session, Response, IdCDPStockMovimiento)
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
            'Dim p = "CDPStockMovimiento_A_FontanaNicastro.dot" '"CDPStockMovimiento.dot"   "CDPStockMovimiento_PRONTO.dot"
            
        End Sub





        Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
            Select Case e.CommandName.ToLower
                Case "ver"
                    Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                    Dim IdCDPStockMovimiento As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)

                    Dim sUrl As String = String.Format("http://bdlconsultores2.dynalias.com/Consultas/Admin/verConsultas1.php?recordid={0}", IdCDPStockMovimiento.ToString)
                    'Response.Redirect(sUrl)

                    Dim str As String
                    str = "window.open('" & sUrl & "', 'List', 'scrollbars=no,resizable=no,width=1200,height=800,left=0,top=0,toolbar=No,status=No,fullscreen=No');"
                    AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", str, True)

                Case "subeprioridad"
                    Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
                    Dim IdCDPStockMovimiento As Integer = Convert.ToInt32(GridView1.DataKeys(rowIndex).Value)
                    SubePrioridad(IdCDPStockMovimiento)

            End Select
        End Sub

        Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
            If e.Row.RowType = DataControlRowType.DataRow Then
                'Dim gp As GridView = e.Row.Cells(getGridIDcolbyHeader("Detalle", GridView1)).Controls(1) 'el indice de cell hay que cambiarlo si se agregan o quitan columnas...
                'gp.DataSource = Pronto.ERP.Bll.EntidadManager.GetStoreProcedure(HFSC.Value, "DetCDPStockMovimientos_TXFac", DataBinder.Eval(e.Row.DataItem, "Id"))
                'gp.DataBind()

                'http://stackoverflow.com/questions/331231/c-gridview-row-click
                'e.Row.Attributes("onClick") = "location.href='http://bdlconsultores2.dynalias.com/Consultas/Admin/verConsultas1.php?recordid=" + DataBinder.Eval(e.Row.DataItem, "IdReclamo").ToString + "'"
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



        Function GetConnectionString() As String

            Dim s As String = "Data Source=192.168.66.1;Initial Catalog=AdministradorProyecto;Uid=sa; PWD=3D1consultore5;Connect Timeout=8;"

            Return s
        End Function

        Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
            'HOW TO: Using sorting / paging on GridView w/o a DataSourceControl DataSource
            'http://forums.asp.net/p/956540/1177923.aspx
            'ObjectDataSource1.FilterExpression = GenerarWHERE()
            'ObjectDataSource1.Select()
            GridView1.PageIndex = e.NewPageIndex
            Rebind()
        End Sub










        Sub SubePrioridad(ByVal IdReclamo As Long)

            Dim sQuery = "UPDATE Reclamos" & _
                            " SET   IdPrioridad= 10+((IdPrioridad-2) % 3)  " & _
                            " WHERE idReclamo=" & IdReclamo

            ExecDinamico(Encriptar(sConexionConsultasTrackPronto), _
                                sQuery)
            Rebind()

        End Sub



        Sub Rebind()




            'todo: la grilla no está trayendo los nombres de los clientes, el puerto, el articulo....

            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////
            '/////////////////////////////////////////////////////////////////////////////////////////////////////////

            Dim dt As DataTable

            'http://bdlconsultores2.dynalias.com/Consultas/Admin/VerConsultasPorSector.php?CSector=13

            Dim CSector = 13
            Dim sQuery = "Select R.IdReclamo, " & _
        "			R.TituloReclamo, " & _
        "               R.Descripcion, " & _
      "					Clientes.NombreCliente as Empresa, " & _
      "					CONVERT(varchar, day(R.FechaAlta)) + '/' + CONVERT(varchar, MONTH(R.FechaAlta)) + '/' + CONVERT(varchar, YEAR(R.FechaAlta)) AS 'FechaAlta', " & _
      "					CONVERT(varchar, day(R.FechaNecesidad)) + '/' + CONVERT(varchar, MONTH(R.FechaNecesidad)) + '/' + CONVERT(varchar, YEAR(R.FechaNecesidad)) AS 'FechaNecesidad', " & _
      "					Prioridades.IdPrioridad as IdPrioridad, " & _
      "					Prioridades.Descripcion as Prioridad, " & _
      "					Estado.Descripcion as Estado, " & _
      "					Productos.Nombre as Producto, " & _
      "					Sectores.Descripcion as SectorAsignado, " & _
      "					UsuariosEmpresa.Nombre as Responsable, " & _
      "					DATEDIFF (Day , R.FechaNecesidad ,getdate()) as Diferencia " & _
       "		from Reclamos R, Prioridades, Estado, Productos, Clientes, Sectores, UsuariosEmpresa " & _
            "    where(R.IdPrioridad = Prioridades.IdPrioridad) " & _
      "		And R.IdEstado = Estado.IdEstado " & _
      "		And R.IdProducto = Productos.IdProducto " & _
      "		And R.IdEmpresa = Clientes.IdCliente " & _
      "		and R.IdResponsable = UsuariosEmpresa.IdUsuario " & _
      "		And R.Anulado = 'NO' " & _
      "		and R.Cumplido != 'SI' " & _
      "		And Sectores.IdSector = R.IdSectorAsignado " & _
      "		and R.IdSectorAsignado in (" & CSector & ") " & _
      "		order by R.IdReclamo"


            dt = ExecDinamico(Encriptar(sConexionConsultasTrackPronto), _
                                sQuery)











            'Dim txtFechaDesde As TextBox = CType(Master.FindControl("txtFechaDesde"), TextBox)
            'Dim txtFechahasta As TextBox = CType(Master.FindControl("txtFechahasta"), TextBox)

            'Dim ds = CDPStockMovimientoManager.GetList(HFSC.Value)
            'dt = ds.VistaCartasPorteMovimientos

            'dt = GetStoreProcedure(HFSC.Value, enumSPs.wCartasDePorteMovimientos_TT)



            'Dim cmbMesFiltro As DropDownList = CType(Master.FindControl("cmbMesFiltro"), DropDownList)

            'If cmbMesFiltro.Text = "Todas" Then
            'If False Then
            '    txtFechaDesde.Text = #1/1/1900#
            '    txtFechahasta.Text = #1/1/2100#
            'Else
            '    txtFechaDesde.Text = GetFirstDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
            '    txtFechahasta.Text = GetLastDayInMonth(Convert.ToDateTime(cmbMesFiltro.Text))
            'End If


            Dim pageIndex = GridView1.PageIndex




            '///////////////////////////////////////////////////
            '///////////////////////////////////////////////////
            'filtro
            'dt = DataTableWHERE(dt, GenerarWHERE)


            '///////////////////////////////////////////////////
            '///////////////////////////////////////////////////
            'ordeno
            Dim b As Data.DataView = DataTableORDER(dt, "IdPrioridad ASC")
            ViewState("Sort") = b.Sort


            '///////////////////////////////////////////////////
            '///////////////////////////////////////////////////
            '///////////////////////////////////////////////////
            GridView1.DataSourceID = ""
            GridView1.DataSource = b
            GridView1.DataBind()
            GridView1.PageIndex = pageIndex


        End Sub


    End Class

End Namespace