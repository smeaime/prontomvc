using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

using System.Net;
using System.Configuration;
using System.Web.Security;

namespace ProntoMVC.Reportes
{
    public partial class Reporte : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    Informe();
                }

                catch (System.Net.WebException ex2)
                {
                    //The request failed with HTTP status 503: Service Unavailable.
                    //Activar reporting services
                    info.Text = "Verificar que Reporting Services esté en marcha. Si es Unauthorized, no se puede usar el alias bdlconsultores.sytes.net \n\n" + ex2.ToString();
                    Elmah.ErrorSignal.FromCurrentContext().Raise(ex2);
                    throw;
                }
                catch (Exception ex)
                {
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    // FUNDAMENTAL!!!!!!!!!
                    // El informe tiene que tener el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
                    // Usá para las credenciales "Seguridad Integrada".
                    // Y en los Query Type de los Datasets usá "Store Procedure"
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    info.Text = " " + ex.ToString();
                    Elmah.ErrorSignal.FromCurrentContext().Raise(ex);
                }
            }
        }

        protected void Informe()
        {
            string nombreBase;


            var memb = new Generales.StaticMembershipService();

            try
            {
                nombreBase = this.Session["BasePronto"].ToString();
            }
            catch (Exception)
            {
                var c = new ProntoMVC.Controllers.AccountController();
                nombreBase = c.BuscarUltimaBaseAccedida(memb);
            }

            if (nombreBase == "")
            {
                throw new Exception("No se encontró base para conectar");
            }

            int idproveedor;
            int idcliente;
            int idauxiliar;

            var scEF = Generales.sCadenaConex(nombreBase, memb);
            var scsql = Generales.sCadenaConexSQL(nombreBase, memb);
            var scsql_Cubos = "Data Source=serversql3\\testing;Initial Catalog=DemoProntoWeb";
            
            // ReportViewerRemoto.Reset

            bool bMostrar = false;

            string usuario = Membership.GetUser().UserName;

            bool esExterno = Roles.IsUserInRole(usuario, "AdminExterno") ||
                        Roles.IsUserInRole(usuario, "Externo") ||
                        Roles.IsUserInRole(usuario, "ExternoPresupuestos") ||
                        Roles.IsUserInRole(usuario, "ExternoCuentaCorrienteProveedor") ||
                        Roles.IsUserInRole(usuario, "ExternoCuentaCorrienteCliente") ||
                        Roles.IsUserInRole(usuario, "ExternoOrdenesPagoListas");  

            if (esExterno)
            {
                Guid oGuid = (Guid)Membership.GetUser().ProviderUserKey;

                ProntoMVC.Controllers.CuentaController c = new ProntoMVC.Controllers.CuentaController();

                if (nombreBase == "")
                {
                    // this.Session["BasePronto"] = Generales.BaseDefault((Guid)oStaticMembershipService.GetUser().ProviderUserKey); // NO! esto ya tiene que venir marcado! no puedo usar la default si el tipo eligió otra!
                    throw new Exception("No está elegida la base");
                }

                c.db = new ProntoMVC.Data.Models.DemoProntoEntities(scEF);

                string cuit = c.DatosExtendidosDelUsuario_GrupoUsuarios(oGuid);
                
                //si es deudor,  no puede ser <=0 esto
                idproveedor = c.buscaridproveedorporcuit(cuit);
                idcliente = c.buscaridclienteporcuit(cuit);
                idauxiliar = -1;
                //this.Session["NombreProveedor"];
                //el tema es esto!!! ReportViewerRemoto.ShowParameterPrompts = false; // lo oculto en el setparameter
                // ReportViewerRemoto.ShowPromptAreaButton = false;
            }
            else
            {
                idproveedor = -1;
                idcliente = -1;
                idauxiliar = -1;

                ReportViewerRemoto.ShowParameterPrompts = true;
            }

            if (this.Request.QueryString["idProveedor"] != null)
            {
                idproveedor = Generales.Val(this.Request.QueryString["idProveedor"]);
                ReportViewerRemoto.ShowParameterPrompts = true;
                bMostrar = true;
            }

            if (this.Request.QueryString["idCliente"] != null)
            {
                idcliente = Generales.Val(this.Request.QueryString["idCliente"]);
                ReportViewerRemoto.ShowParameterPrompts = true;
                bMostrar = true;
            }

            if (this.Request.QueryString["id"] != null)
            {
                idauxiliar = Generales.Val(this.Request.QueryString["id"]);
            }

            this.Session["idproveedor"] = idproveedor;
            txtDebug.Text = idproveedor.ToString() + '\n' + new Uri(ConfigurationManager.AppSettings["ReportServer"]); ;
            txtDebug.Visible = false;

            if (false)
            {
                //var actParams = ReportViewerRemoto.ServerReport.GetParameters();
                //ReportParameter[] yourParams = new ReportParameter[6];
                //yourParams[0] = new ReportParameter("IdProveedor", "11", false);//Adjust value
                //yourParams[1] = new ReportParameter("Todo", "-1");
                //yourParams[2] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString());
                //yourParams[3] = new ReportParameter("FechaDesde", DateTime.MinValue.ToShortDateString());
                //yourParams[4] = new ReportParameter("Consolidar", "-1");
                //yourParams[5] = new ReportParameter("Pendiente", "N");

                //if (ReportViewerRemoto.ServerReport.GetParameters().Count != 6) throw new Exception("Distintos parámetros");

                //ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            // ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://serversql1:82/ReportServer");
            //ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServer"]);

            ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote;
            // IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
            IReportServerCredentials irsc = new CustomReportCredentials(ConfigurationManager.AppSettings["ReportUser"], ConfigurationManager.AppSettings["ReportPass"], ConfigurationManager.AppSettings["ReportDomain"]);
            ReportViewerRemoto.ServerReport.ReportServerCredentials = irsc;
            ReportViewerRemoto.ShowCredentialPrompts = false;

            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //  IMPORTANTISIMO  VITAL
            //   Si ves que el informe sigue apuntando siempre a la misma base, y no se refrescan los filtros, esta es la cuestion:
            //
            // En el visor web de informe, tiene que tener 
            //        el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
            //        para que en la pestaña "Origenes de datos" quede "Cadena de conexión:	<Basada en expresión>"
            // No sé si esto lo puedo configurar desde el BIDS al hacer el deploy. 
            // La cuestion es que en el informe instalado quedó un DEFAULT en la cadena de conexion, y usaba siempre esa al conectarse.
            //  O sea, por web aparece una opcion que no está en el bids: el DEFAULT del datasource (ademas del DEFAULT del parametro, que sí está en el BIDS) 
            //  y verificar que el proyecto de informes tenga el OverwriteDatasources en TRUE
            // http://stackoverflow.com/questions/18742788/dataset-doesnt-refresh-data-in-ssrs
            // http://stackoverflow.com/questions/14701233/changes-to-parameter-not-showing-on-report-server-after-deployment/
            // y a veces no se refrescan despues del deploy!!!!!!!!!!!!!!! terrrrribleeeeee:
            //Delete the report completely from Report Manager and re-deploy it, or go into report manager and update 
            //    the parameters from there. Parameters have been an issue when deploying reports since the 
            //dawn of time and I believe it's on purpose actually.
            //            This is "by design":
            //When you first deploy reports, parameters are uploaded with all their settings.
            //Administrators of those reports are then allowed to tweak the way report parameters function in the report web manager: change whether they accept null values, defaults, etc.
            //If you redeploy reports later, nothing is changed to existing parameters (the system doesn't want to "overwerite" changes made by report admins).
            //Solutions:
            //Delete the report, then redeploy it.
            //Change the parameter settings directly in the deployed report.
            //  IMPORTANTISIMO  VITAL
            // Usá para las credenciales "Seguridad Integrada".
            // Y en los Query Type de los Datasets usá "Store Procedure"
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            // http://stackoverflow.com/questions/1439245/ssrs-report-viewer-asp-net-credentials-401-exception

            string reportName;

            reportName = this.Request.QueryString["ReportName"].NullSafeToString();

            ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/" + reportName;

            //lblTitulo.Text = reportName;

            //if (this.Request.QueryString["ReportName"] == null || this.Request.QueryString["ReportName"] == "Resumen Cuenta Corriente Acreedores")
            if (reportName == "Resumen Cuenta Corriente Acreedores")
            {
                if (idproveedor > 0 || true)
                {
                    // http://stackoverflow.com/questions/1078863/passing-parameter-via-url-to-sql-server-reporting-service
                    // http://localhost:40053/Pronto2/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=1
                    // ?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=221&Todo=1
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // VERIFICAR QUE EL RRSS SE ESTÁ CONECTANDO A LA MISMA BASE QUE EL ENTITYFRAMEWORK, SINO NO VA
                    // A ENCONTRAR EL IDPROVEEDOR Y NO MOSTRARÁ NADA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side
                    // http://stackoverflow.com/questions/2360992/binding-a-datasource-to-a-rdl-in-report-server-programmatically-ssrs?rq=1
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side?rq=1
                    //You can use an Expression Based Connection String to select the correct database. 
                    //    You can base this on a parameter your application passes in, or the UserId global variable. 
                    //        I do believe you need to configure the unattended execution account for this to work.
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                    ReportParameter[] yourParams = new ReportParameter[10];
                    yourParams[0] = new ReportParameter("CadenaConexion", scsql, false); // false); // S/N
                    if (idproveedor <= 0)
                    {
                        yourParams[1] = new ReportParameter("IdProveedor", "-1", true); //, false);//Adjust value 
                    }
                    else
                    {
                        yourParams[1] = new ReportParameter("IdProveedor", idproveedor.ToString(), bMostrar); //, false);//Adjust value
                    }
                    yourParams[2] = new ReportParameter("Todo", "-1");
                    yourParams[3] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString()); //temita con formato en ingles o castellano:  DateTime.Today.ToShortDateString());
                    yourParams[4] = new ReportParameter("FechaDesde", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                    yourParams[5] = new ReportParameter("Consolidar", "-1");
                    yourParams[6] = new ReportParameter("Pendiente", "N", true); // S/N
                    yourParams[7] = new ReportParameter("IdMoneda", "1"); // S/N

                    string s = ConfigurationManager.AppSettings["UrlDominio"] + "Content/Images/Empresas/" + (((Session["BasePronto"].NullSafeToString() ?? "") == "") ? "DemoPronto" : Session["BasePronto"].NullSafeToString()) + ".png";
                    yourParams[8] = new ReportParameter("ImagenPath", s); // S/N
                    yourParams[9] = new ReportParameter("UrlDominio", ConfigurationManager.AppSettings["UrlDominio"].ToString()); // S/N

                    // es fundamental que los parametros esten bien pasados y con el tipo correspondiente, porque creo que sino, explota y no te dice bien por qué

                    /////////////////////////////////////////////////////////////////////////////////
                    // para ahorrarse problemas con lo de la cadena de conexion dinamica, hay que repetir, como usuario SQL,
                    // la cuenta Windows (kerberos) con la que pasamos credenciales (variables ReportUser y ReportPass)

                    //First, you could create a ‘shadow account’ on the reporting server by duplicating the user’s domain login and password on 
                    //the report server. Creating a shadow account can be hard to maintain, particularly if a password change policy is in effect 
                    //for the domain, because the passwords must remain synchronized.
                    //If the web application is on the same server as the Reporting Services web service, the call will authenticate 
                    //using DefaultCredentials, but you are probably seeing the “permissions are insufficient” exception. One solution to this 
                    //problem is adding the ASPNET or NETWORK SERVICE account into a role in Reporting Services, but take care before 
                    //making this decision. If you were to place the ASPNET account into the System Administrators role, for example, anyone 
                    //    with access to your web application is now a Reporting Services administrator.
                    // http://odetocode.com/articles/216.aspx
                    /////////////////////////////////////////////////////////////////////////////////

                    try
                    {
                        if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("(Ojo no usar parametros en modo INTERNAL ) Distintos parámetros");
                    }
                    catch (Exception ex)
                    {
                        ProntoFuncionesGenerales.MandaEmailSimple("mscalella911@gmail.com", "getparam", scsql + " " + ex.ToString(),
                                        ConfigurationManager.AppSettings["SmtpUser"], ConfigurationManager.AppSettings["SmtpServer"], ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpPass"], "", Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                    }

                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                }
            }

            else if (reportName == "Resumen Cuenta Corriente Acreedores Por Mayor")
            {
                if (idproveedor > 0 || true)
                {
                    ReportParameter[] yourParams = new ReportParameter[10];
                    yourParams[0] = new ReportParameter("CadenaConexion", scsql, false); // false); // S/N
                    if (idproveedor <= 0)
                    {
                        yourParams[1] = new ReportParameter("IdProveedor", "-1", true); //, false);//Adjust value 
                    }
                    else
                    {
                        yourParams[1] = new ReportParameter("IdProveedor", idproveedor.ToString(),  bMostrar); //, false);//Adjust value
                    }
                    yourParams[2] = new ReportParameter("Todo", "-1");
                    yourParams[3] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString()); //temita con formato en ingles o castellano:  DateTime.Today.ToShortDateString());
                    yourParams[4] = new ReportParameter("FechaDesde", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                    yourParams[5] = new ReportParameter("Consolidar", "-1");
                    yourParams[6] = new ReportParameter("Pendiente", "N", true); // S/N
                    yourParams[7] = new ReportParameter("IdMoneda", "1"); // S/N

                    string s = ConfigurationManager.AppSettings["UrlDominio"] + "Content/Images/Empresas/" + (((Session["BasePronto"].NullSafeToString() ?? "") == "") ? "DemoPronto" : Session["BasePronto"].NullSafeToString()) + ".png";
                    yourParams[8] = new ReportParameter("ImagenPath", s); // S/N
                    yourParams[9] = new ReportParameter("UrlDominio", ConfigurationManager.AppSettings["UrlDominio"].ToString()); // S/N

                    try
                    {
                        if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                    }
                    catch (Exception ex)
                    {
                        ProntoFuncionesGenerales.MandaEmailSimple("mscalella911@gmail.com", "getparam", scsql + " " + ex.ToString(),
                                        ConfigurationManager.AppSettings["SmtpUser"], ConfigurationManager.AppSettings["SmtpServer"], ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpPass"], "", Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                    }

                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                }
            }

            else if (reportName == "Resumen Cuenta Corriente Deudores")
            {
                if (idcliente > 0 || true)
                {
                    ReportParameter[] yourParams = new ReportParameter[8];
                    yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                    if (idcliente <= 0)
                    {
                        yourParams[1] = new ReportParameter("IdCliente", "-1", true);
                    }
                    else
                    {
                        yourParams[1] = new ReportParameter("IdCliente", idcliente.ToString(), bMostrar);
                    }
                    yourParams[2] = new ReportParameter("Todo", "-1");
                    yourParams[3] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString());
                    yourParams[4] = new ReportParameter("FechaDesde", "1/1/1980");
                    yourParams[5] = new ReportParameter("Consolidar", "-1");
                    yourParams[6] = new ReportParameter("Pendiente", "N", true);
                    yourParams[7] = new ReportParameter("UrlDominio", ConfigurationManager.AppSettings["UrlDominio"], false);

                    try
                    {
                        if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                    }
                    catch (Exception ex)
                    {
                        ProntoFuncionesGenerales.MandaEmailSimple("mscalella911@gmail.com", "getparam", scsql + " " + ex.ToString(),
                                        ConfigurationManager.AppSettings["SmtpUser"], ConfigurationManager.AppSettings["SmtpServer"], ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpPass"], "", Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                    }

                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                }
            }

            else if (reportName == "IVA Ventas")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                //yourParams[1] = new ReportParameter("Desde", DateTime.Today.ToShortDateString()); //System.Data.SqlTypes.SqlDateTime.MinValue.Value.ToShortDateString());
                //yourParams[2] = new ReportParameter("Hasta", ""); // DateTime.Today.ToShortDateString()); 
                //if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                //lblTitulo.Text = "Libro de IVA Ventas";
            }

            else if (reportName == "Subdiario")
            {
                idproveedor = 7; // 7 compras, 1 ventas, 4 caja y bancos
                ReportParameter[] yourParams = new ReportParameter[]
                {
                    new ReportParameter("CadenaConexion", scsql, false),  
                    new ReportParameter("Mes", DateTime.Today.Month.ToString()), 
                    new ReportParameter("Anio", DateTime.Today.Year.ToString()), 
                    new ReportParameter("IdCuentaSubdiario", idproveedor.ToString()) 
                };

                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Balance2")
            {
                ReportParameter[] yourParams = new ReportParameter[3];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false); 
                yourParams[1] = new ReportParameter("FechaDesde", "1/1/1980"); 
                yourParams[2] = new ReportParameter("FechaHasta", "1/1/1980"); 

                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                //lblTitulo.Text = "Balance";
            }

            else if (reportName == "Mayor")
            {
                ReportParameter[] yourParams = new ReportParameter[4];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  
                yourParams[1] = new ReportParameter("FechaDesde", "1/1/1980"); 
                yourParams[2] = new ReportParameter("FechaHasta", "1/1/1980"); 
                yourParams[3] = new ReportParameter("IdCuenta", "-1", true); 

                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName.IndexOf("Certificado") >= 0)
            {
                var keys = this.Request.QueryString.AllKeys;
                var db = new ProntoMVC.Data.Models.DemoProntoEntities(scEF);
                var op = db.OrdenesPago.Find(Generales.Val(this.Request.QueryString["Id"].NullSafeToString()));
                if (op.IdProveedor != idproveedor && idproveedor != -1)
                {
                    throw new Exception("No tiene permisos");
                }

                ReportParameter[] yourParams = new ReportParameter[4];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  
                yourParams[1] = new ReportParameter("Id", this.Request.QueryString["Id"]); 
                yourParams[2] = new ReportParameter("IdProveedor", op.IdProveedor.ToString()); 
                string s = ConfigurationManager.AppSettings["UrlDominio"] + "Content/Images/Empresas/" + (((Session["BasePronto"].NullSafeToString() ?? "") == "") ? "DemoPronto" : Session["BasePronto"].NullSafeToString()) + ".png";
                yourParams[3] = new ReportParameter("ImagenPath", s); 
                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Desarrollo y seguimiento por item de ordenes de compra")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  
                //yourParams[1] = new ReportParameter("FechaDesde", "1/1/1980"); 
                //yourParams[2] = new ReportParameter("FechaHasta", "1/1/1980"); 
                //yourParams[3] = new ReportParameter("IdCliente", "-1", true); 
                //if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Requerimientos pendientes de asignacion")
            {
                ReportParameter[] yourParams = new ReportParameter[2];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                yourParams[1] = new ReportParameter("Depositos", "-1", false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Pedidos pendientes de recibir")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Vales emitidos no retirados")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Cardex")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Transporte de mercaderia")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Requerimientos pendientes sin pedido")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Salidas de materiales")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Movimientos por partida")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }
            else if (reportName == "Estadistica de ventas por rubro - articulo")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }
            else if (reportName == "Cubo Stock 2" || reportName == "Cubo Gastos Detallados 2" || reportName == "Cubo Egresos Proyectados 2" || reportName == "Cubo Ingresos Egresos Por Obra 3" || reportName == "Cubo Presupuesto Financiero" || reportName == "Cubo Posicion Financiera" || reportName == "Cubo Balance")
            {
                ReportParameter[] yourParams = new ReportParameter[1];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql_Cubos, false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }

            else if (reportName == "Factura Venta" || reportName == "Recibo" || reportName == "Nota Debito" || reportName == "Nota Credito" || reportName == "Orden Pago" || reportName == "Orden Pago2" || reportName == "Gasto Bancario" || reportName == "Plazo Fijo" || reportName == "Salida Materiales" || reportName == "Recepcion" || reportName == "Deposito" || reportName == "Comprobante Proveedores")
            {
                ReportParameter[] yourParams = new ReportParameter[2];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                yourParams[1] = new ReportParameter("Id", idauxiliar.ToString(), false);
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }


            else
            {
                var keys = this.Request.QueryString.AllKeys;

                ReportParameter[] yourParams = new ReportParameter[1]; // keys.Count];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);
                foreach (string i in keys)
                {
                    //yourParams[0] = new ReportParameter(i.na, sc, false);
                }

                if (true)
                {
                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                }

            }

            ReportViewerRemoto.ServerReport.Refresh();

            // ReportViewerRemoto.DataBind();
            //ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote;
            //ReportViewerRemoto.ShowCredentialPrompts = true;
            //ReportViewerRemoto.ShowExportControls = true;
            //ReportViewerRemoto.ServerReport.ReportServerCredentials = new CustomReportCredentials(" adasd", "dfasd", "afaf");
            //ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
            //ReportViewerRemoto.ServerReport.ReportPath = "/informes/sss";
            //ReportViewerRemoto.ServerReport.Refresh();
            //ReportViewerRemoto.ServerReport.Timeout = 1000 * 60 * 3; //'3minutos
        }
        
        protected void RefrescaInforme(object sender, EventArgs e)
        {
            if (false)
            {
                //var actParams = ReportViewerRemoto.ServerReport.GetParameters();
                //ReportParameter[] yourParams = new ReportParameter[6];
                //yourParams[0] = new ReportParameter("IdProveedor", "11", false);//Adjust value
                //yourParams[1] = new ReportParameter("Todo", "-1");
                //yourParams[2] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString());
                //yourParams[3] = new ReportParameter("FechaDesde", DateTime.MinValue.ToShortDateString());
                //yourParams[4] = new ReportParameter("Consolidar", "-1");
                //yourParams[5] = new ReportParameter("Pendiente", "N");

                //if (ReportViewerRemoto.ServerReport.GetParameters().Count != 6) throw new Exception("Distintos parámetros");
                //ReportViewerRemoto.ServerReport.SetParameters(yourParams);
            }
        }
    }

    public class CustomReportCredentials : IReportServerCredentials
    {
        private string _UserName;
        private string _PassWord;
        private string _DomainName;

        public CustomReportCredentials(string UserName, string PassWord, string DomainName)
        {
            _UserName = UserName;
            _PassWord = PassWord;
            _DomainName = DomainName;
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get { return null; }
        }

        public ICredentials NetworkCredentials
        {
            get { return new NetworkCredential(_UserName, _PassWord, _DomainName); }
        }

        public bool GetFormsCredentials(out Cookie authCookie, out string user,
         out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;
        }
    }
}
