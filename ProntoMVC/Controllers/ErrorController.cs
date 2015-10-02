using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using ProntoMVC.Data.Models;
using ProntoMVC.Models;
using jqGrid.Models;
using Lib.Web.Mvc.JQuery.JqGrid;
using System.Text;
using System.Data.Entity.SqlServer;
using System.Data.Entity.Core.Objects;
using System.Reflection;
using System.Configuration;



namespace ProntoMVC.Controllers
{
    public partial class ErrorController : Controller
    {

        //como no heredo ProntoBaseController, sería bueno no mostrar el layout




        public virtual ViewResult Index(Exception exception)
        {


            // Response.StatusCode = statusCode;
            //var model = new ErrorModel() {Exception = exception, HttpStatusCode = statusCode};
            //return View(model);

            var m = new HandleErrorInfo(exception, "Error", "Index");
            

            return View("PageNotFound", m);
        }

        //public virtual ViewResult Index()
        //{

        //    //string s =Model.c  .ControllerName;
        //    //    <
        //    ///p>
        //    //        <p>
        //    //            Action = @Model.ActionName</p>
        //    //        <p>
        //    //            Message = @Model.Exception.Message</p>
        //    //        <p>
        //    //            StackTrace :</p>
        //    //        <pre>@Model.Exception.StackTrace</pre>
        //    //    ";



        //    return View("PageNotFound");
        //}


        public virtual ViewResult PageNotFound()
        {

            //Response.StatusCode = 404;  //you may want to set this to 200
            return View("PageNotFound");
            //return View("../ErrorPages/PageNotFound");
            //return View("~/Views/ErrorPages/PageNotFound");
            //return View("../ErrorPages/PageNotFound"); // http://stackoverflow.com/questions/879852/display-a-view-from-another-controller-in-asp-net-mvc
            //hace falta que el directorio de views de errores sea ErrorPages? -Le podés cambiar el nombre de ErrorPages a "Error"...
        }




        ////////////////////////////////////////////////////////////////////////////////////////////
        // http://kitsula.com/Article/MVC-Handling-and-logging-JavaScript-errors
        /// ErrorController.cs
        //        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);

        [HttpPost]
        [ValidateInput(false)] // temas por "potentially dangerous" http://stackoverflow.com/questions/17254354/asp-net-mvc-a-potentially-dangerous-request-form-value-was-detected-from-the-cli
        public virtual EmptyResult JSErrorHandler(string msg, string url, string line)
        {
            // Init Log4Net library
            //log4net.Config.XmlConfigurator.Configure();

            //if (!string.IsNullOrEmpty(Request["msg"]) && !string.IsNullOrEmpty(Request["url"]) && !string.IsNullOrEmpty(Request["line"]))
            //{
            //    try
            //    {
            //        System.Text.StringBuilder bodystr = new System.Text.StringBuilder();
            //        bodystr.Append("<html><head>");

            //        bodystr.Append("<style>");
            //        bodystr.Append(" body {font-family:\"Verdana\";font-weight:normal;font-size: .7em;color:black;} ");
            //        bodystr.Append(" p {font-family:\"Verdana\";font-weight:normal;color:black;margin-top: -5px}");
            //        bodystr.Append(" b {font-family:\"Verdana\";font-weight:bold;color:black;margin-top: -5px}");
            //        bodystr.Append(" H1 { font-family:\"Verdana\";font-weight:normal;font-size:16pt;color:red }");
            //        bodystr.Append(" H2 { font-family:\"Verdana\";font-weight:normal;font-size:14pt;color:maroon }");
            //        bodystr.Append(" H4 { font-family:\"Verdana\";font-weight:bold;font-size:11pt;}");
            //        bodystr.Append(" pre {font-family:\"Lucida Console\";font-size: .9em}");
            //        bodystr.Append(" .marker {font-weight: bold; color: black;text-decoration: none;}");
            //        bodystr.Append(" .version {color: gray;}");
            //        bodystr.Append(" .error {margin-bottom: 10px;}");
            //        bodystr.Append(" .expandable { text-decoration:underline; font-weight:bold; color:navy; cursor:hand; }");
            //        bodystr.Append("</style>");
            //        bodystr.Append("</head><body bgcolor=\"white\">");

            //        bodystr.Append(String.Format("<b>Date:</b> {0}<br>", DateTime.Now));
            //        bodystr.Append(String.Format("<b>Page:</b> <a href=\"{0}\">{0}</a><br>", Request.ServerVariables["HTTP_REFERER"].ToString()));
            //        bodystr.Append(String.Format("<b>JS File: </b><a href=\"{0}\">{0}</a><br>", HttpUtility.HtmlEncode(Request["url"])));
            //        bodystr.Append(String.Format("<b>Error Message: </b>{0}<br>", HttpUtility.HtmlEncode(Request["msg"])));
            //        bodystr.Append(String.Format("<b>Line:</b>{0}<br><br>", HttpUtility.HtmlEncode(Request["line"])));

            //        int i = 0;
            //        bodystr.Append("<h4>Server Variables:</h4>");
            //        for (i = 0; i <= Request.ServerVariables.Count - 1; i++)
            //        {
            //            bodystr.Append(String.Format("<b>{0}:</b> {1}<br>", Request.ServerVariables.Keys[i], Request.ServerVariables[i]));
            //        }

            //        // Add Session Values in email
            //        bodystr.Append("<h4>Session Variables:</h4>");

            //        if ((Session != null))
            //        {
            //            if (Session.Count > 0)
            //            {
            //                foreach (string item in Session.Keys)
            //                {
            //                    bodystr.Append(String.Format("<b>{0}:</b> {1}<br>", item, (Session[item] == null ? "" : Session[item].ToString())));
            //                }
            //            }
            //            else
            //            {
            //                bodystr.Append("<b>No Session values: 0</b> <br>");
            //            }
            //        }
            //        else
            //        {
            //            bodystr.Append("<b> No Session values: nothing</b> <br>");
            //        }
            //        bodystr.Append("</body></html>");

            //        AlternateView bodyHtmlView = AlternateView.CreateAlternateViewFromString(bodystr.ToString(), new System.Net.Mime.ContentType("text/html"));

            //        MailMessage message = new MailMessage { From = new MailAddress("support@kitsula.com") };
            //        message.To.Add(new MailAddress("support@kitsula.com"));
            //        message.Bcc.Add(new MailAddress("IgorKitsula@gmail.com"));
            //        message.Subject = String.Format("JS Error on the site - {0}", Request["msg"]);
            //        message.AlternateViews.Add(bodyHtmlView);
            //        using (SmtpClient client = new SmtpClient())
            //        {
            //            client.Send(message);
            //        }
            //        // Save error to database using Log4Net
            //        log.Error(bodystr.ToString());
            //    }
            //    catch (Exception ex)
            //    {
            //        // If sending email failed - save error to DB using Log4Net
            //        log.Fatal("Error", ex);
            //    }
            //}


            try
            {

                string urldominio = ConfigurationManager.AppSettings["UrlDominio"]; // +"Account/Verificar";


                string body = msg + " " + url + " " + line;
                //    body += " " + Request["msg"] + " " + Request["url"] ?? "" + Request["line"] ?? ""; // la tuve que sacar por 
                //                                                                                      el "potentially dangerous". pierdo algo?
                body = body.Replace("\n", "<br />");


               string nombrebase="";
                try 
	{
        nombrebase = this.HttpContext.Session["BasePronto"].ToString();
	}
	catch (Exception)
	{
		
		//throw;
	}
                

                ProntoFuncionesGenerales.MandaEmailSimple( ConfigurationManager.AppSettings["ErrorMail"],
                                   nombrebase + ": JScript Linea " + line + "  " + body,
                                body,
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpServer"],
                                ConfigurationManager.AppSettings["SmtpUser"],
                                ConfigurationManager.AppSettings["SmtpPass"],
                                  "",
                               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

            }

            catch (Exception e)
            {
                try
                {
                    ErrHandler.WriteError(e);

                }
                catch (Exception)
                {


                }
                //throw;
            }



            return null;
        }


    }
}
