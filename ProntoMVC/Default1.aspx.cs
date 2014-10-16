using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web;
using System.Web.Mvc;
using Microsoft.Reporting.WebForms;
using System.Net;





namespace MixingBothWorldsExample
{
    public partial class Default1 : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {


            if (!Page.IsPostBack)
            {

                

                //ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote;
                //ReportViewerRemoto.ShowCredentialPrompts = true;
                //ReportViewerRemoto.ShowExportControls = true;
                //ReportViewerRemoto.ServerReport.ReportServerCredentials = new CustomReportCredentials(" adasd", "dfasd", "afaf");

                //ReportViewerRemoto.ServerReport.ReportServerUrl = new Uri("http://localhost/ReportServer");
                //ReportViewerRemoto.ServerReport.ReportPath = "/informes/sss";

                //ReportViewerRemoto.ServerReport.Refresh();
                //ReportViewerRemoto.ServerReport.Timeout = 1000 * 60 * 3; //'3minutos



                /*

                //Specify the report server
                ReportViewer1.
                  ServerReport.
                  ReportServerUrl =
                  new Uri(WebConfigurationManager.
                  AppSettings["ReportServerURL"]);

                //Specify the report name
                ReportViewer1.
                  ServerReport.
                  ReportPath = Session["reportPath"].ToString();

                //Specify the server credentials
                ReportViewer1.
                  ServerReport.
                  ReportServerCredentials =
                  new CustomReportCredentials
                   (
                     WebConfigurationManager.
                      AppSettings["ReportServerUser"],
                     WebConfigurationManager.
                      AppSettings["ReportServerPassword"],
                     WebConfigurationManager.
                      AppSettings["ReportServerDomain"]
                   );
                
                //  With the report specified, hydrate the report
                //  parameters based on the values in the
                //  reportParameters hash.
                 
                var reportParameters = (Dictionary<string,
                  string>)Session["reportParameters"];

                foreach (var item in reportParameters)
                {
                    ReportViewer1.
                      ServerReport.
                      SetParameters(
                        new List<ReportParameter>() 
              { 
                new ReportParameter
                  (item.Key, item.Value) 
              });
                }
            
            
            
            */

            }



        }




    }
}

/* 

    Sub InitServerReport()

        'https://www.google.com.ar/search?sourceid=chrome&ie=UTF-8&q=rsInvalidItemPath



        ReportViewerRemoto.ProcessingMode = ProcessingMode.Remote
        ReportViewerRemoto.ShowCredentialPrompts = True
        ReportViewerRemoto.ShowExportControls = True
        ReportViewerRemoto.ServerReport.ReportServerCredentials = New ReportsServerCredentials.ReportServerCredentials
        ReportViewerRemoto.ServerReport.ReportServerUrl = New Uri("http://bdlconsultores.dyndns.org:81/ReportServer")
        'ReportViewerRemoto.ServerReport.ReportPath = "Pronto informes/Balance"
        'ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/Balance"
        ReportViewerRemoto.ServerReport.ReportPath = "/Pronto informes/Pedido"

        ReportViewerRemoto.ServerReport.Refresh()
        ReportViewerRemoto.ServerReport.Timeout = 1000 * 60 * 3 '3minutos

        'ReportServer/Pages/ReportViewer.aspx?%2fPronto+informes%2fPedido&rs:Command=Render
    End Sub


*/



public class CustomReportCredentials : Microsoft.Reporting.WebForms.IReportServerCredentials
{  

    // local variable for network credential.
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
        get
        {  
            return null;  // not use ImpersonationUser
        }
    }
    public ICredentials NetworkCredentials
    {
        get
        { 

           // use NetworkCredentials
            return new NetworkCredential(_UserName,_PassWord,_DomainName);
        }
    }
    public bool GetFormsCredentials(out Cookie authCookie, out string user, out string password, out string authority)
    { 

       // not use FormsCredentials unless you have implements a custom autentication.
        authCookie = null;
        user = password = authority = null;
        return false;
    }

}