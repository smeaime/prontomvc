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
    public partial class Reporteaaa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                int idproveedor;





                if (!Roles.IsUserInRole(Membership.GetUser().UserName, "SuperAdmin") &&
                        !Roles.IsUserInRole(Membership.GetUser().UserName, "Administrador"))
                {

                    Guid oGuid = (Guid)Membership.GetUser().ProviderUserKey;

                    ProntoMVC.Controllers.CuentaController c = new ProntoMVC.Controllers.CuentaController();


                    this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
                    string sss = this.Session["BasePronto"].ToString();
                    var sc = Generales.sCadenaConex(sss);
                    c.db = new ProntoMVC.Models.DemoProntoEntities(sc);

                    string cuit = c.DatosExtendidosDelUsuario_GrupoUsuarios(oGuid);

                    idproveedor = c.buscaridproveedorporcuit(cuit);

                    //this.Session["NombreProveedor"];

                    ReportViewerRemoto.ShowParameterPrompts = false;
                }
                else
                {

                    idproveedor = -1;

                    ReportViewerRemoto.ShowParameterPrompts = true;
                }










                ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote;
                IReportServerCredentials irsc = new CustomReportCredentials("administrador", ".xza2190lkm.", "");
                ReportViewerRemoto.ServerReport.ReportServerCredentials = irsc;
                string reportName = "sss"; // this.Request.QueryString["ReportName"];
                // ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://serversql1:82/ReportServer");
                //ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri(ConfigurationManager.AppSettings["ReportServer"]);





                // ReportViewerRemoto.ServerReport.ReportPath = "/Orden Pago"; // "/informes/" + reportName;
                ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/Resumen Cuenta Corriente Acreedores"; // "/informes/" + reportName;

                // http://stackoverflow.com/questions/1078863/passing-parameter-via-url-to-sql-server-reporting-service
                ReportParameter[] yourParams = new ReportParameter[2];
                yourParams[0] = new ReportParameter("IdProveedor", idproveedor.ToString());//Adjust value
                yourParams[1] = new ReportParameter("Todo", "-1");
                ReportViewerRemoto.ServerReport.SetParameters(yourParams);

                ReportViewerRemoto.ShowCredentialPrompts = false;


                ReportViewerRemoto.ServerReport.Refresh();





                //ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote;
                //ReportViewerRemoto.ShowCredentialPrompts = true;
                //ReportViewerRemoto.ShowExportControls = true;
                //ReportViewerRemoto.ServerReport.ReportServerCredentials = new CustomReportCredentials(" adasd", "dfasd", "afaf");

                //ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                //ReportViewerRemoto.ServerReport.ReportPath = "/informes/sss";

                //ReportViewerRemoto.ServerReport.Refresh();
                //ReportViewerRemoto.ServerReport.Timeout = 1000 * 60 * 3; //'3minutos

            }
        }
    }

    
}











