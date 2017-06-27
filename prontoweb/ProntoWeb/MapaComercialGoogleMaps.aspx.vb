Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Microsoft.Reporting.WebForms
Imports System.Net
Imports System.Configuration
Imports System.Web.Security
Imports Pronto.ERP.Bll

Imports CartaDePorteManager



Namespace ProntoMVC.Reportes


    Partial Public Class MapaComercialGoogleMaps
        Inherits System.Web.UI.Page


        Protected Frame_A_Url As String


        Protected Sub Page_Load(sender As Object, e As EventArgs)
            HFSC.Value = GetConnectionString(Server, Session)
            HFIdObra.Value = IIf(IsDBNull(Session(SESSIONPRONTO_glbIdObraAsignadaUsuario)), -1, Session(SESSIONPRONTO_glbIdObraAsignadaUsuario))


            If Not IsPostBack Then


                cmbPeriodo.SelectedIndex = 5
                txtFechaDesde.Text = DateAdd(DateInterval.Day, -60, Today)
                txtFechaHasta.Text = Today


                refrescaPeriodo()
                BloqueosDeEdicion()

                Try

                    'Informe()

                Catch ex2 As System.Net.WebException
                    'The request failed with HTTP status 503: Service Unavailable.

                    'Activar reporting services

                    ' info.Text = "Verificar que Reporting Services esté en marcha. Si es Unauthorized, no se puede usar el alias bdlconsultores.sytes.net " & vbLf & vbLf & ex2.ToString()
                    'throw;
                    Elmah.ErrorSignal.FromCurrentContext().Raise(ex2)
                Catch ex As Exception

                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    ' FUNDAMENTAL!!!!!!!!!
                    ' El informe tiene que tener el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
                    '
                    ' Usá para las credenciales "Seguridad Integrada".
                    ' Y en los Query Type de los Datasets usá "Store Procedure"
                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    '''///////////////////////////////////////////////////////////////////////////////////////////////////
                    ' info.Text = " " & ex.ToString()

                    'throw;
                    Elmah.ErrorSignal.FromCurrentContext().Raise(ex)


                End Try
            End If



            AutoCompleteExtender2.ContextKey = HFSC.Value
            AutoCompleteExtender21.ContextKey = HFSC.Value
            AutoCompleteExtender27.ContextKey = HFSC.Value


        End Sub


        Sub BloqueosDeEdicion()
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'Bloqueos de edicion
            '////////////////////////////////////////////
            '////////////////////////////////////////////
            'If ProntoFuncionesUIWeb.EstaEsteRol("Cliente") Or


            Dim admins = New String() {"mariano", "andres", "hwilliams", "twilliams2"}


            If Not admins.Contains(Session(SESSIONPRONTO_UserName).ToString().ToLower()) Then
                MsgBoxAjaxAndRedirect(Me, "No tenés acceso a esta página", String.Format("Principal.aspx"))
                Exit Sub
            End If


        End Sub


        Protected Sub cmbPeriodo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmbPeriodo.SelectedIndexChanged
            refrescaPeriodo()

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


            Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)



        End Sub

        Protected Sub Informe()


            'Dim sss As String

            'Try
            '    sss = Me.Session("BasePronto").ToString()
            'Catch generatedExceptionName As Exception
            '    Dim c = New ProntoMVC.Controllers.AccountController()
            '    sss = c.BuscarUltimaBaseAccedida()
            'End Try

            'If sss = "" Then
            '    Throw New Exception("No se encontró base para conectar")
            'End If

            Dim sTitulo As String = ""
            Dim idVendedor = BuscaIdClientePreciso(txtTitular.Text, HFSC.Value)
            Dim idArticulo = BuscaIdArticuloPreciso(txt_AC_Articulo.Text, HFSC.Value)
            Dim idProcedencia = BuscaIdLocalidadPreciso(txtProcedencia.Text, HFSC.Value)


            Dim fechadesde As Date = iisValidSqlDate(txtFechaDesde.Text, #1/1/1753#)
            Dim fechahasta As Date = iisValidSqlDate(txtFechaHasta.Text, #1/1/2100#)




            Dim idproveedor As Integer
            Dim idcliente As Integer


            Dim SC As String = HFSC.Value 'Generales.sCadenaConex(sss)
            Dim scsql As String = HFSC.Value 'Generales.sCadenaConexSQL(sss)
            ' ReportViewerRemoto.Reset

            Dim bMostrar As Boolean = False

            If Not Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") AndAlso Not Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador") AndAlso Not Roles.IsUserInRole(Membership.GetUser().UserName, "Compras") AndAlso Not Roles.IsUserInRole(Membership.GetUser().UserName, "Comercial") Then

                Dim oGuid As Guid = CType(Membership.GetUser().ProviderUserKey, Guid)

                '  Dim c As New ProntoMVC.Controllers.CuentaController()

                ' this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey); // NO! esto ya tiene que venir marcado! no puedo usar la default si el tipo eligió otra!
                'If Me.Session("BasePronto").ToString() = "" Then
                'End If

                '   c.db = New ProntoMVC.Data.Models.DemoProntoEntities(sc)

                ' Dim cuit As String = c.DatosExtendidosDelUsuario_GrupoUsuarios(oGuid)

                ' idproveedor = c.buscaridproveedorporcuit(cuit)

                'this.Session["NombreProveedor"];



                'el tema es esto!!! ReportViewerRemoto.ShowParameterPrompts = false; // lo oculto en el setparameter

                ' ReportViewerRemoto.ShowPromptAreaButton = false;


                'idcliente = c.buscaridclienteporcuit(cuit)
            Else



                idproveedor = -1
                idcliente = -1

                ReportViewerRemoto.ShowParameterPrompts = True
            End If





            If Me.Request.QueryString("idProveedor") IsNot Nothing Then
                ' idproveedor = Generales.Val(Me.Request.QueryString("idProveedor"))
                ReportViewerRemoto.ShowParameterPrompts = True
                bMostrar = True
            End If


            If Me.Request.QueryString("idCliente") IsNot Nothing Then
                'idcliente = Generales.Val(Me.Request.QueryString("idCliente"))
                ReportViewerRemoto.ShowParameterPrompts = True
                bMostrar = True
            End If




            Me.Session("idproveedor") = idproveedor
            txtDebug.Text = idproveedor.ToString() & ControlChars.Lf & Convert.ToString(New Uri(ConfigurationManager.AppSettings("ReportServer")))


            txtDebug.Visible = False








            'var actParams = ReportViewerRemoto.ServerReport.GetParameters();
            'ReportParameter[] yourParams = new ReportParameter[6];
            'yourParams[0] = new ReportParameter("IdProveedor", "11", false);//Adjust value
            'yourParams[1] = new ReportParameter("Todo", "-1");
            'yourParams[2] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString());
            'yourParams[3] = new ReportParameter("FechaDesde", DateTime.MinValue.ToShortDateString());
            'yourParams[4] = new ReportParameter("Consolidar", "-1");
            'yourParams[5] = new ReportParameter("Pendiente", "N");

            'if (ReportViewerRemoto.ServerReport.GetParameters().Count != 6) throw new Exception("Distintos parámetros");

            'ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            If False Then
            End If





            ' ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://serversql1:82/ReportServer");
            'ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            ReportViewerRemoto.ServerReport.ReportServerUrl = New Uri(ConfigurationManager.AppSettings("ReportServer"))






            ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote
            ' IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            Dim irsc As IReportServerCredentials = New CustomReportCredentials(ConfigurationManager.AppSettings("ReportUser"), ConfigurationManager.AppSettings("ReportPass"), ConfigurationManager.AppSettings("ReportDomain"))
            ReportViewerRemoto.ServerReport.ReportServerCredentials = irsc
            ReportViewerRemoto.ShowCredentialPrompts = False



            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '   Si ves que el informe sigue apuntando siempre a la misma base, y no se refrescan los filtros, esta es la cuestion:
            '
            ' En el visor web de informe, tiene que tener 
            '        el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
            '        para que en la pestaña "Origenes de datos" quede "Cadena de conexión:	<Basada en expresión>"
            ' No sé si esto lo puedo configurar desde el BIDS al hacer el deploy. 
            ' La cuestion es que en el informe instalado quedó un DEFAULT en la cadena de conexion, y usaba siempre esa al conectarse.
            '  O sea, por web aparece una opcion que no está en el bids: el DEFAULT del datasource (ademas del DEFAULT del parametro, que sí está en el BIDS) 
            '
            '  y verificar que el proyecto de informes tenga el OverwriteDatasources en TRUE

            ' http://stackoverflow.com/questions/18742788/dataset-doesnt-refresh-data-in-ssrs
            ' http://stackoverflow.com/questions/14701233/changes-to-parameter-not-showing-on-report-server-after-deployment/
            ' y a veces no se refrescan despues del deploy!!!!!!!!!!!!!!! terrrrribleeeeee:
            'Delete the report completely from Report Manager and re-deploy it, or go into report manager and update 
            '    the parameters from there. Parameters have been an issue when deploying reports since the 
            'dawn of time and I believe it's on purpose actually.

            '            This is "by design":

            'When you first deploy reports, parameters are uploaded with all their settings.

            'Administrators of those reports are then allowed to tweak the way report parameters function in the report web manager: change whether they accept null values, defaults, etc.

            'If you redeploy reports later, nothing is changed to existing parameters (the system doesn't want to "overwerite" changes made by report admins).

            'Solutions:

            'Delete the report, then redeploy it.
            'Change the parameter settings directly in the deployed report.

            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL




            ' Usá para las credenciales "Seguridad Integrada".
            ' Y en los Query Type de los Datasets usá "Store Procedure"
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////

            '''/////////////////////////////////////////////////////////////////////////////////
            '''/////////////////////////////////////////////////////////////////////////////////
            '''/////////////////////////////////////////////////////////////////////////////////
            '''/////////////////////////////////////////////////////////////////////////////////
            '''/////////////////////////////////////////////////////////////////////////////////

            ' http://stackoverflow.com/questions/1439245/ssrs-report-viewer-asp-net-credentials-401-exception

            Dim reportName As String

            ' reportName = Me.Request.QueryString("ReportName").NullSafeToString()

            reportName = "MapaArgentinaProcedenciaCartasPorte"


            ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/" & reportName

            'reportName = "Resumen Cuenta Corriente Acreedores";

            'ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/" + reportName;

            ' acá pinta que me bocha...


            ' http://stackoverflow.com/questions/1078863/passing-parameter-via-url-to-sql-server-reporting-service
            '
            ' http://localhost:40053/Pronto2/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=1
            ' ?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=221&Todo=1


            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' VERIFICAR QUE EL RRSS SE ESTÁ CONECTANDO A LA MISMA BASE QUE EL ENTITYFRAMEWORK, SINO NO VA
            ' A ENCONTRAR EL IDPROVEEDOR Y NO MOSTRARÁ NADA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side
            ' http://stackoverflow.com/questions/2360992/binding-a-datasource-to-a-rdl-in-report-server-programmatically-ssrs?rq=1


            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
            ' http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side?rq=1
            'You can use an Expression Based Connection String to select the correct database. 
            '    You can base this on a parameter your application passes in, or the UserId global variable. 
            '        I do believe you need to configure the unattended execution account for this to work.

            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            ' !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

            Dim yourParams As ReportParameter() = New ReportParameter(7) {}





            yourParams(0) = New ReportParameter("Modo", DropDownList2.SelectedItem.Text) ' )
            yourParams(1) = New ReportParameter("Producto", txt_AC_Articulo.Text)
            yourParams(2) = New ReportParameter("Puerto", txtProcedencia.Text) ' )
            yourParams(3) = New ReportParameter("Cliente", BuscaIdClientePreciso(txtTitular.Text, SC)) ' )
            yourParams(4) = New ReportParameter("TonsDesde", txtTonsDesde.Text) ', txtFechaHasta.Text)
            yourParams(5) = New ReportParameter("TonsHasta", txtTonsHasta.Text) ', txtFechaHasta.Text)
            yourParams(6) = New ReportParameter("FechaDesde", txtFechaDesde.Text) ' )
            yourParams(7) = New ReportParameter("FechaHasta", txtFechaHasta.Text) ', txtFechaHasta.Text)






            If Diagnostics.Debugger.IsAttached Then
                'Stop
                'SC = Encriptar("Data Source=serversql3\TESTING;Initial catalog=Pronto;User ID=sa; Password=.SistemaPronto.;Connect Timeout=500")
                'estoy teniendo problemas al usar el reporteador desde un servidor distinto del que tiene la base
            End If



            ReportViewerRemoto.ShowParameterPrompts = False
            ReportViewerRemoto.PromptAreaCollapsed = True
            ReportViewerRemoto.ShowPromptAreaButton = False

            ' es fundamental que los parametros esten bien pasados y con el tipo correspondiente, porque creo que si
            ' no, explota y no te dice bien por qué


            '''//////////////////////////////////////////////////////////////////////////////
            '''//////////////////////////////////////////////////////////////////////////////
            '''//////////////////////////////////////////////////////////////////////////////
            ' para ahorrarse problemas con lo de la cadena de conexion dinamica, hay que repetir, como usuario SQL,
            ' la cuenta Windows (kerberos) con la que pasamos credenciales (variables ReportUser y ReportPass)

            'First, you could create a ‘shadow account’ on the reporting server by duplicating the user’s domain login and password on 
            'the report server. Creating a shadow account can be hard to maintain, particularly if a password change policy is in effect 
            'for the domain, because the passwords must remain synchronized.
            'If the web application is on the same server as the Reporting Services web service, the call will authenticate 
            'using DefaultCredentials, but you are probably seeing the “permissions are insufficient” exception. One solution to this 
            'problem is adding the ASPNET or NETWORK SERVICE account into a role in Reporting Services, but take care before 
            'making this decision. If you were to place the ASPNET account into the System Administrators role, for example, anyone 
            '    with access to your web application is now a Reporting Services administrator.
            ' http://odetocode.com/articles/216.aspx
            '''//////////////////////////////////////////////////////////////////////////////
            '''//////////////////////////////////////////////////////////////////////////////
            '''//////////////////////////////////////////////////////////////////////////////
            '''//////////////////////////////////////////////////////////////////////////////

            Try
                If ReportViewerRemoto.ServerReport.GetParameters().Count <> yourParams.Count() Then
                    Throw New Exception("(Ojo no usar parametros en modo INTERNAL ) Distintos parámetros")
                End If
            Catch ex As Exception

                '''///////////////////////////////////////////////////////////////////////////////////////////////////
                '''///////////////////////////////////////////////////////////////////////////////////////////////////
                '''///////////////////////////////////////////////////////////////////////////////////////////////////
                ' El informe tiene que tener el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
                ' Usá para las credenciales "Seguridad Integrada".
                ' Y en los Query Type de los Datasets usá "Store Procedure"
                '''///////////////////////////////////////////////////////////////////////////////////////////////////
                '''///////////////////////////////////////////////////////////////////////////////////////////////////
                '''///////////////////////////////////////////////////////////////////////////////////////////////////
                '''///////////////////////////////////////////////////////////////////////////////////////////////////

                ProntoFuncionesGenerales.MandaEmailSimple("mscalella911@gmail.com", "getparam",
                "Ojo que este es el primer acceso al servidor de informes.  Fijate si estan en distintos servidores el reporteador y la base. Fijate si la consulta puede ejecutarse en la base que elegiste. " &
                Convert.ToString(scsql) & " " & ex.ToString(), ConfigurationManager.AppSettings("SmtpUser"), ConfigurationManager.AppSettings("SmtpServer"), ConfigurationManager.AppSettings("SmtpUser"),
                    ConfigurationManager.AppSettings("SmtpPass"), "", Convert.ToInt16(ConfigurationManager.AppSettings("SmtpPort")))
            End Try

            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            ' leer arriba
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL
            '  IMPORTANTISIMO  VITAL

            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////
            '''///////////////////////////////////////////////////////////////////////////////////////////////////


            ErrHandler2.WriteError("Vamos bien?")

            ErrHandler2.WriteError(ConfigurationManager.AppSettings("ReportServer") & " - " & ConfigurationManager.AppSettings("ReportUser") & " - " & ConfigurationManager.AppSettings("ReportPass") & " - " & ConfigurationManager.AppSettings("ReportDomain"))

            Try
                ReportViewerRemoto.ServerReport.SetParameters(yourParams)
            Catch ex As Exception
                ErrHandler2.WriteError(ex)
                Throw
            End Try

            ErrHandler2.WriteError("parece")






            ' ReportViewerRemoto.ServerReport.ReportPath = "/Orden Pago"; // "/informes/" + reportName;
            ' "/informes/" + reportName;


            '   lblTitulo.Text = reportName


            ReportViewerRemoto.ServerReport.Refresh()

            ErrHandler2.WriteError("Cli 3")


            yourParams(0) = New ReportParameter("Modo", DropDownList2.SelectedItem.Text) ' )
            yourParams(1) = New ReportParameter("Producto", BuscaIdArticuloPreciso(txt_AC_Articulo.Text, SC))
            yourParams(2) = New ReportParameter("Puerto", BuscaIdLocalidadPreciso(txtProcedencia.Text, SC)) ' )
            yourParams(3) = New ReportParameter("Cliente", BuscaIdClientePreciso(txtTitular.Text, SC)) ' )
            yourParams(4) = New ReportParameter("TonsDesde", txtTonsDesde.Text) ', txtFechaHasta.Text)
            yourParams(5) = New ReportParameter("TonsHasta", txtTonsHasta.Text) ', txtFechaHasta.Text)
            yourParams(6) = New ReportParameter("FechaDesde", txtFechaDesde.Text) ' )
            yourParams(7) = New ReportParameter("FechaHasta", txtFechaHasta.Text) ', txtFechaHasta.Text)



            Dim link As String = "GoogleMapsHtml.html?modoExportacion=" & DropDownList2.SelectedItem.Text &
                                                "&idprocedencia=" & BuscaIdLocalidadPreciso(txtProcedencia.Text, SC).ToString &
                                                "&fechadesde=" & Convert.ToDateTime(txtFechaDesde.Text).ToString("yyyy/MM/dd") &
                                                "&fechahasta=" & Convert.ToDateTime(txtFechaHasta.Text).ToString("yyyy/MM/dd") &
                                                "&idarticulo=" & BuscaIdArticuloPreciso(txt_AC_Articulo.Text, SC).ToString &
                                                "&idclientefacturado=" + BuscaIdClientePreciso(txtTitular.Text, SC).ToString &
                                                "&tonsdesde=" & txtTonsDesde.Text &
                                                "&tonshasta=" & txtTonsHasta.Text

            'Frame_A_Url = link


            AjaxControlToolkit.ToolkitScriptManager.RegisterStartupScript(Me.Page, Me.GetType, "alrt", "window.open('" & link & "','_blank');", True)


            'Response.Write("<script>window.open('" & link & "','_blank');</script>")
            '             <a href = "GoogleMapsHtml.html?modoExportacion=Ambas&idprocedencia=-1&fechadesde=2017/1/1&fechahasta=2017/3/1&idarticulo=-1&idclientefacturado=-1&tonsdesde=0&tonshasta=999999" target="_blank">ver mapa  </a>



        End Sub








        Protected Sub RefrescaInforme(sender As Object, e As EventArgs)

            'var actParams = ReportViewerRemoto.ServerReport.GetParameters();
            'ReportParameter[] yourParams = new ReportParameter[6];
            'yourParams[0] = new ReportParameter("IdProveedor", "11", false);//Adjust value
            'yourParams[1] = new ReportParameter("Todo", "-1");
            'yourParams[2] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString());
            'yourParams[3] = new ReportParameter("FechaDesde", DateTime.MinValue.ToShortDateString());
            'yourParams[4] = new ReportParameter("Consolidar", "-1");
            'yourParams[5] = new ReportParameter("Pendiente", "N");

            'if (ReportViewerRemoto.ServerReport.GetParameters().Count != 6) throw new Exception("Distintos parámetros");

            'ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            If False Then
            End If
        End Sub





        Protected Sub btnRefrescar_Click(sender As Object, e As EventArgs) Handles btnRefrescar.Click
            Informe()
        End Sub





        Private Sub btngeocode_Click(sender As Object, e As EventArgs) Handles btngeocode.Click

            Dim s = New ServicioCartaPorte.servi()
            Dim err = s.ReasignarGeocodeLocalidades(False, HFSC.Value)
            MsgBoxAlert(err)
            'Response.Write(err)

        End Sub

    End Class





    Public NotInheritable Class CustomReportCredentials
        Implements IReportServerCredentials
        Private _UserName As String
        Private _PassWord As String
        Private _DomainName As String

        Public Sub New(UserName As String, PassWord As String, DomainName As String)
            _UserName = UserName
            _PassWord = PassWord
            _DomainName = DomainName
        End Sub

        Public ReadOnly Property ImpersonationUser() As System.Security.Principal.WindowsIdentity Implements IReportServerCredentials.ImpersonationUser
            Get
                Return Nothing
            End Get
        End Property

        Public ReadOnly Property NetworkCredentials() As ICredentials Implements IReportServerCredentials.NetworkCredentials
            Get
                Return New NetworkCredential(_UserName, _PassWord, _DomainName)
            End Get
        End Property

        Public Function GetFormsCredentials(ByRef authCookie As Cookie, ByRef user As String, ByRef password As String, ByRef authority As String) As Boolean Implements IReportServerCredentials.GetFormsCredentials
            authCookie = Nothing
            user = InlineAssignHelper(password, InlineAssignHelper(authority, Nothing))
            Return False
        End Function
        Private Shared Function InlineAssignHelper(Of T)(ByRef target As T, value As T) As T
            target = value
            Return value
        End Function
    End Class
End Namespace




