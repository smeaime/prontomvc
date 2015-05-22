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
                    //throw;
                }
                catch (Exception ex)
                {

                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    // FUNDAMENTAL!!!!!!!!!
                    // El informe tiene que tener el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
                    //
                    // Usá para las credenciales "Seguridad Integrada".
                    // Y en los Query Type de los Datasets usá "Store Procedure"
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    info.Text = " " + ex.ToString();
                    Elmah.ErrorSignal.FromCurrentContext().Raise(ex);
                    //throw;
                }


            }
        }

        protected void Informe()
        {


            string sss;

            try
            {
                sss = this.Session["BasePronto"].ToString();
            }
            catch (Exception)
            {
                var c = new ProntoMVC.Controllers.AccountController();
                sss = c.BuscarUltimaBaseAccedida();
            }

            if (sss == "")
            {
                throw new Exception("No se encontró base para conectar");
            }


            int idproveedor;
            int idcliente;


            var sc = Generales.sCadenaConex(sss);
            var scsql = Generales.sCadenaConexSQL(sss);
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

                if (this.Session["BasePronto"].ToString() == "")
                {
                    // this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey); // NO! esto ya tiene que venir marcado! no puedo usar la default si el tipo eligió otra!
                }

                c.db = new ProntoMVC.Data.Models.DemoProntoEntities(sc);

                string cuit = c.DatosExtendidosDelUsuario_GrupoUsuarios(oGuid);

                
                
                //si es deudor,  no puede ser <=0 esto

                idproveedor = c.buscaridproveedorporcuit(cuit);
                
                
                idcliente = c.buscaridclienteporcuit(cuit);

                //this.Session["NombreProveedor"];



                //el tema es esto!!! ReportViewerRemoto.ShowParameterPrompts = false; // lo oculto en el setparameter

                // ReportViewerRemoto.ShowPromptAreaButton = false;


            }
            else
            {



                idproveedor = -1;
                idcliente = -1;

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
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //  IMPORTANTISIMO  VITAL
            //  IMPORTANTISIMO  VITAL
            //  IMPORTANTISIMO  VITAL
            //  IMPORTANTISIMO  VITAL
            //   Si ves que el informe sigue apuntando siempre a la misma base, y no se refrescan los filtros, esta es la cuestion:
            //
            // En el visor web de informe, tiene que tener 
            //        el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
            //        para que en la pestaña "Origenes de datos" quede "Cadena de conexión:	<Basada en expresión>"
            // No sé si esto lo puedo configurar desde el BIDS al hacer el deploy. 
            // La cuestion es que en el informe instalado quedó un DEFAULT en la cadena de conexion, y usaba siempre esa al conectarse.
            //  O sea, por web aparece una opcion que no está en el bids: el DEFAULT del datasource (ademas del DEFAULT del parametro, que sí está en el BIDS) 
            //
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
            //  IMPORTANTISIMO  VITAL
            //  IMPORTANTISIMO  VITAL
            //  IMPORTANTISIMO  VITAL
            //  IMPORTANTISIMO  VITAL




            // Usá para las credenciales "Seguridad Integrada".
            // Y en los Query Type de los Datasets usá "Store Procedure"
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////

            ////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////

            // http://stackoverflow.com/questions/1439245/ssrs-report-viewer-asp-net-credentials-401-exception

            string reportName;

            reportName = this.Request.QueryString["ReportName"].NullSafeToString();
            if (reportName == "") reportName = "Resumen Cuenta Corriente Acreedores";

            ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/" + reportName;

            lblTitulo.Text = reportName;

            if (this.Request.QueryString["ReportName"] == null || this.Request.QueryString["ReportName"] == "Resumen Cuenta Corriente Acreedores")
            {
                //reportName = "Resumen Cuenta Corriente Acreedores";

                //ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/" + reportName;

                // acá pinta que me bocha...
                if (idproveedor > 0 || true)
                {
                    // http://stackoverflow.com/questions/1078863/passing-parameter-via-url-to-sql-server-reporting-service
                    //
                    // http://localhost:40053/Pronto2/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=1
                    // ?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=221&Todo=1


                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // VERIFICAR QUE EL RRSS SE ESTÁ CONECTANDO A LA MISMA BASE QUE EL ENTITYFRAMEWORK, SINO NO VA
                    // A ENCONTRAR EL IDPROVEEDOR Y NO MOSTRARÁ NADA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side
                    // http://stackoverflow.com/questions/2360992/binding-a-datasource-to-a-rdl-in-report-server-programmatically-ssrs?rq=1


                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side?rq=1
                    //You can use an Expression Based Connection String to select the correct database. 
                    //    You can base this on a parameter your application passes in, or the UserId global variable. 
                    //        I do believe you need to configure the unattended execution account for this to work.

                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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






                    // es fundamental que los parametros esten bien pasados y con el tipo correspondiente, porque creo que si
                    // no, explota y no te dice bien por qué


                    /////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////
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
                    /////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////

                    try
                    {
                        if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("(Ojo no usar parametros en modo INTERNAL ) Distintos parámetros");
                    }
                    catch (Exception ex)
                    {

                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        // El informe tiene que tener el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
                        // Usá para las credenciales "Seguridad Integrada".
                        // Y en los Query Type de los Datasets usá "Store Procedure"
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////

                        ProntoFuncionesGenerales.MandaEmailSimple("mscalella911@gmail.com",
                                            "getparam",
                                       scsql + " " + ex.ToString(),
                                        ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpServer"],
                                        ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpPass"],
                                          "",
                                       Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                    }

                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL
                    // leer arriba
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL
                    //  IMPORTANTISIMO  VITAL

                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////
                    //////////////////////////////////////////////////////////////////////////////////////////////////////


                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);



                }

            }
            else if (this.Request.QueryString["ReportName"] == "Resumen Cuenta Corriente Deudores")
            {
                //reportName = "Resumen Cuenta Corriente Deudores";

                //ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/" + reportName;





                // acá pinta que me bocha...
                if (idcliente > 0 || true)
                {
                    // http://stackoverflow.com/questions/1078863/passing-parameter-via-url-to-sql-server-reporting-service
                    //
                    // http://localhost:40053/Pronto2/Reporte.aspx?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=1
                    // ?ReportName=Resumen%20Cuenta%20Corriente%20Acreedores&IdProveedor=221&Todo=1


                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // VERIFICAR QUE EL RRSS SE ESTÁ CONECTANDO A LA MISMA BASE QUE EL ENTITYFRAMEWORK, SINO NO VA
                    // A ENCONTRAR EL IDPROVEEDOR Y NO MOSTRARÁ NADA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side
                    // http://stackoverflow.com/questions/2360992/binding-a-datasource-to-a-rdl-in-report-server-programmatically-ssrs?rq=1


                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://msdn.microsoft.com/en-us/library/ms156450.aspx#Expressions
                    // http://stackoverflow.com/questions/14546125/change-ssrs-data-source-of-report-programmatically-in-server-side?rq=1
                    //You can use an Expression Based Connection String to select the correct database. 
                    //    You can base this on a parameter your application passes in, or the UserId global variable. 
                    //        I do believe you need to configure the unattended execution account for this to work.

                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                    ReportParameter[] yourParams = new ReportParameter[8];
                    yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  // false);
                    if (idcliente <= 0)
                    {
                        yourParams[1] = new ReportParameter("IdCliente", "-1", true); //, false);//Adjust value 
                    }
                    else
                    {
                        yourParams[1] = new ReportParameter("IdCliente", idcliente.ToString(), bMostrar); //, false);//Adjust value
                    }
                    yourParams[2] = new ReportParameter("Todo", "-1");
                    yourParams[3] = new ReportParameter("FechaLimite", DateTime.Today.ToShortDateString()); //temita con formato en ingles o castellano:  DateTime.Today.ToShortDateString());
                    yourParams[4] = new ReportParameter("FechaDesde", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                    yourParams[5] = new ReportParameter("Consolidar", "-1");
                    yourParams[6] = new ReportParameter("Pendiente", "N", true); // S/N
                    yourParams[7] = new ReportParameter("UrlDominio", ConfigurationManager.AppSettings["UrlDominio"], false); // S/N



                    // es fundamental que los parametros esten bien pasados y con el tipo correspondiente, porque creo que si
                    // no, explota y no te dice bien por qué


                    /////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////
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
                    /////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////////////////////////

                    try
                    {
                        if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                    }
                    catch (Exception ex)
                    {

                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        // El informe tiene que tener el parametro @CadenaConexion "SIN predeterminado" ("NO default") y "Preguntar al Usuario"
                        // Usá para las credenciales "Seguridad Integrada".
                        // Y en los Query Type de los Datasets usá "Store Procedure"
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////
                        //////////////////////////////////////////////////////////////////////////////////////////////////////

                        ProntoFuncionesGenerales.MandaEmailSimple("mscalella911@gmail.com",
                                            "getparam",
                                       scsql + " " + ex.ToString(),
                                        ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpServer"],
                                        ConfigurationManager.AppSettings["SmtpUser"],
                                        ConfigurationManager.AppSettings["SmtpPass"],
                                          "",
                                       Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
                    }



                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);



                }

            }

            else if (this.Request.QueryString["ReportName"] == "Subdiario")
            {
                idproveedor = 7; // 7 compras, 1 ventas, 4 caja y bancos
                ReportParameter[] yourParams = new ReportParameter[]
                {
                    new ReportParameter("CadenaConexion", scsql, false),  // false);
                    new ReportParameter("Mes", DateTime.Today.Month.ToString()), //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                    new ReportParameter("Anio", DateTime.Today.Year.ToString()), //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                    
                    new ReportParameter("IdCuentaSubdiario", idproveedor.ToString()) //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                };

                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);

            }

            else if (this.Request.QueryString["ReportName"] == "Balance2")
            {

                ReportParameter[] yourParams = new ReportParameter[3];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  // false);
                yourParams[1] = new ReportParameter("FechaDesde", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                yourParams[2] = new ReportParameter("FechaHasta", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);

                lblTitulo.Text = "Balance";

            }
            else if (this.Request.QueryString["ReportName"] == "Mayor")
            {

                ReportParameter[] yourParams = new ReportParameter[4];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  // false);
                yourParams[1] = new ReportParameter("FechaDesde", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                yourParams[2] = new ReportParameter("FechaHasta", "1/1/1980"); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                yourParams[3] = new ReportParameter("IdCuenta", "-1", true); //, false);//Adjust value 
                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);

            }
            else if (this.Request.QueryString["ReportName"].IndexOf("Certificado") >= 0)
            {
                var keys = this.Request.QueryString.AllKeys;

                //cómo controlar que no tome lo de otro proveedor?

                var db = new ProntoMVC.Data.Models.DemoProntoEntities(sc);

                var op = db.OrdenesPago.Find(Generales.Val(this.Request.QueryString["Id"].NullSafeToString()));
                if (op.IdProveedor != idproveedor && idproveedor!=-1)
                {
                    throw new Exception("No tiene permisos");
                }




                ReportParameter[] yourParams = new ReportParameter[4];
                yourParams[0] = new ReportParameter("CadenaConexion", scsql, false);  // false);
                yourParams[1] = new ReportParameter("Id", this.Request.QueryString["Id"]); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                yourParams[2] = new ReportParameter("IdProveedor", op.IdProveedor.ToString()); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                string s = ConfigurationManager.AppSettings["UrlDominio"] + "Content/Images/Empresas/" + (((Session["BasePronto"].NullSafeToString() ?? "") == "") ? "DemoPronto" : Session["BasePronto"].NullSafeToString()) + ".png";
                yourParams[3] = new ReportParameter("ImagenPath", s); //temita con formato en ingles o castellano:  DateTime.MinValue.ToShortDateString());
                if (ReportViewerRemoto.ServerReport.GetParameters().Count != yourParams.Count()) throw new Exception("Distintos parámetros");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);

            }

            else
            {


                var keys = this.Request.QueryString.AllKeys;


                ReportParameter[] yourParams = new ReportParameter[1]; // keys.Count];
                yourParams[0] = new ReportParameter("CadenaConexion", sc, false); // S/N
                foreach (string i in keys)
                {
                    //yourParams[0] = new ReportParameter(i.na, sc, false);
                }

                if (true)
                {
                    ReportViewerRemoto.ServerReport.SetParameters(yourParams);
                }

            }


            // ReportViewerRemoto.ServerReport.ReportPath = "/Orden Pago"; // "/informes/" + reportName;
            // "/informes/" + reportName;


            //lblTitulo.Text = reportName;


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




/*


 Begin VB.Menu MnuSub 
         Caption         =   "Clientes"
         Index           =   3
         Begin VB.Menu MnuSubCli 
            Caption         =   "Retenciones y Percepciones"
            Index           =   0
            Begin VB.Menu MnuSubCliRet 
               Caption         =   "SICORE"
               Index           =   0
               Begin VB.Menu MnuSubCliRetSIC 
                  Caption         =   "Generacion SICORE"
                  Index           =   0
               End
               Begin VB.Menu MnuSubCliRetSIC 
                  Caption         =   "Retenciones de IVA"
                  Index           =   1
               End
               Begin VB.Menu MnuSubCliRetSIC 
                  Caption         =   "Percepciones de IVA"
                  Index           =   2
               End
            End
            Begin VB.Menu MnuSubCliRet 
               Caption         =   "Retenciones SUSS"
               Index           =   1
            End
            Begin VB.Menu MnuSubCliRet 
               Caption         =   "Percepciones IIBB"
               Index           =   2
            End
            Begin VB.Menu MnuSubCliRet 
               Caption         =   "Retenciones IIBB (Cobranzas) - SIFERE"
               Index           =   3
            End
            Begin VB.Menu MnuSubCliRet 
               Caption         =   "CITI"
               Index           =   4
            End
         End
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		          Begin VB.Menu MnuSubCo 
            Caption         =   "IVA Ventas"
            Index           =   5
         End

      Case 16
         Me.Caption = "Subdiario de IVA Ventas"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With

    Case 16
               mCampo = BuscarClaveINI("Modelo para libro de iva ventas")
               If Len(Trim(mCampo)) = 0 Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_IVAVentas", Array(DTFields(0).Value, DTFields(1).Value))
               Else
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_IVAVentas" & mCampo, Array(DTFields(0).Value, DTFields(1).Value))
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
               mCampo = BuscarClaveINI("IVAVENTAS_FilasPorHoja")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = CStr(mvarLineasIvaCompras)
               mvarParametrosExcel = "SaltoDePaginaCada:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnaConTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "5"
               mvarParametrosExcel = mvarParametrosExcel & "|ColumnaTransporte:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnasSumaParaTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "8,9,11,12,13"
               mVectorAux = VBA.Split(mCampo, ",")
               For i = 0 To UBound(mVectorAux)
                  mvarParametrosExcel = mvarParametrosExcel & "|SumadorPorHoja" & i + 1 & ":" & mVectorAux(i)
               Next
               mvarParametrosExcel = mvarParametrosExcel & "|Enc:SinFecha"
            
			
			

		 
		 
		 
		 
		 
Private Sub MnuSubCli_Click(Index As Integer)

   EditarConsulta "Cli", Index, MnuSubCli(Index).Caption

End Sub

Private Sub MnuSubCliRet_Click(Index As Integer)

   EditarConsulta "CliRet", Index, MnuSubCliRet(Index).Caption

End Sub
   Case "CliRet"
         Select Case Item
            Case 1
               Set oF = New frmConsulta2
               With oF
                  .Id = 45
                  .Show vbModal, Me
               End With
            Case 2
               Set oF = New frmConsulta2
               With oF
                  .Id = 47
                  .Show vbModal, Me
               End With
            Case 3
               Set oF = New frmConsulta2
               With oF
                  .Id = 50
                  .Show vbModal, Me
               End With
            Case 4
               Set oF = New frmConsulta3
               With oF
                  .Id = 120
                  .Show vbModal, Me
               End With
         End Select

		 
		 
		          Case 45
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesSUSS", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
			   
		            Case 47
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_PercepcionesIIBB", Array(DTFields(0).Value, DTFields(1).Value, mvarIdAux1))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
               cmd(3).Enabled = True
 
		         Case 50
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesIIBB_Cobranzas", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
Private Sub MnuSubCliRetSIC_Click(Index As Integer)

   EditarConsulta "CliRetSIC", Index, MnuSubCliRetSIC(Index).Caption

End Sub

    Case "CliRetSIC"
         Select Case Item
            Case 0
               Set oF = New frmConsulta2
               With oF
                  .Id = 37
                  .Show vbModal, Me
               End With
            Case 1
               Set oF = New frmConsulta2
               With oF
                  .Id = 39
                  .Show vbModal, Me
               End With
            Case 2
               Set oF = New frmConsulta2
               With oF
                  .Id = 88
                  .Show vbModal, Me
               End With
         End Select
		 

		 
		       Case 37
         Me.Caption = "Clientes - Retenciones de impuesto a las ganancias"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar"
            .Enabled = False
         End With
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
         With Check1
            .Left = cmd(2).Left + cmd(2).Width + 70
            .Top = cmd(2).Top
            .Width = cmd(2).Width * 2
            .Caption = "Generar para personas juridicas"
            .Visible = True
         End With
         With Frame1
            .Left = Check1.Left + Check1.Width + 100
            .Top = cmd(0).Top - 50
            .Caption = "Ordenamiento :"
            .Visible = True
         End With
         With Option1
            .Caption = "x Cliente"
            .Value = True
         End With
         Option2.Caption = "x Fecha"
      
 
      
      Case 39
         Me.Caption = "Clientes - Retenciones de IVA"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar"
            .Enabled = False
         End With
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
		 

            Case 37
               mOrden = "C"
               If Option2.Value Then mOrden = "F"
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesGanancias", Array(DTFields(0).Value, DTFields(1).Value, mOrden))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True


     
            Case 39
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_RetencionesIVA", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True



			   
			   
			   
			   
			   
			   
			   Case 88
         Me.Caption = "Clientes - Percepcion de IVA"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar"
            .Enabled = False
         End With
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      


         Case 88
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_PercepcionesIVA", Array(DTFields(0).Value, DTFields(1).Value))
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               cmd(1).Enabled = True
         





		 
		 
		       Case 120
         Me.Caption = "CITI Ventas"
         cmd(0).Caption = "Procesar"
         With cmd(1)
            .Caption = "Generar"
            .Enabled = False
         End With
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
		 
		           Case 120
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
               Set oTab = Aplicacion.Clientes.TraerFiltrado("_CITI", Array(DTFields(0).Value, DTFields(1).Value))
         
               cmd(1).Enabled = True
         
		 
		 
		 








            Case 5
               Set oF = New frmConsulta2
               With oF
                  .Id = 16
                  .Show vbModal, Me
               End With
			   
			   
			   
			   
			   
			      Case 16
         Me.Caption = "Subdiario de IVA Ventas"
         cmd(0).Caption = "Procesar"
         cmd(1).Visible = False
         cmd(2).Left = cmd(1).Left
         lblLabels(0).Visible = True
         lblLabels(1).Visible = True
         With DTFields(0)
            .Visible = True
            .Value = mvarFechaDesde
         End With
         With DTFields(1)
            .Visible = True
            .Value = mvarFechaHasta
         End With
      
	  
	                    
            Case 16
               mCampo = BuscarClaveINI("Modelo para libro de iva ventas")
               If Len(Trim(mCampo)) = 0 Then
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_IVAVentas", Array(DTFields(0).Value, DTFields(1).Value))
               Else
                  Set oTab = Aplicacion.TablasGenerales.TraerFiltrado("InformesContables", "_IVAVentas" & mCampo, Array(DTFields(0).Value, DTFields(1).Value))
               End If
               mvarSubTituloExcel = "|Desde el " & DTFields(0).Value & " al " & DTFields(1).Value
            
               mCampo = BuscarClaveINI("IVAVENTAS_FilasPorHoja")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = CStr(mvarLineasIvaCompras)
               mvarParametrosExcel = "SaltoDePaginaCada:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnaConTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "5"
               mvarParametrosExcel = mvarParametrosExcel & "|ColumnaTransporte:" & mCampo
               mCampo = BuscarClaveINI("IVAVENTAS_ColumnasSumaParaTransporte")
               If Len(mCampo) = 0 Or Not IsNumeric(mCampo) Then mCampo = "8,9,11,12,13"
               mVectorAux = VBA.Split(mCampo, ",")
               For i = 0 To UBound(mVectorAux)
                  mvarParametrosExcel = mvarParametrosExcel & "|SumadorPorHoja" & i + 1 & ":" & mVectorAux(i)
               Next
               mvarParametrosExcel = mvarParametrosExcel & "|Enc:SinFecha"








*/