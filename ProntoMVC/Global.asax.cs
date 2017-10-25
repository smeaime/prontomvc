using System;
using System.Collections.Generic;

using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Globalization;
using System.Web.Security;

using System.Configuration;

using StackExchange.Profiling;
using StackExchange.Profiling.EntityFramework6;


using System.Web.Http;

namespace ProntoMVC
{
    // Nota: para obtener instrucciones sobre cómo habilitar el modo clásico de IIS6 o IIS7, 
    // visite http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {


            filters.Add(new HandleErrorAttribute());


            // http://stackoverflow.com/questions/6507568/using-mvc-miniprofiler-for-every-action-call/24197984#24197984
            filters.Add(new ProfileActionsAttribute());
        }




        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{exclude}/{extnet}/ext.axd");
            routes.IgnoreRoute("PaginaWebForm/{resource}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{myWebForms}.aspx/{*pathInfo}");
            routes.IgnoreRoute("{myWebServices}.asmx/{*pathInfo}");
            routes.IgnoreRoute("myCustomHttpHandler.foo/{*pathInfo}");
            routes.IgnoreRoute("Contents/{*pathInfo}");

            routes.IgnoreRoute("WebformsViejo/{*pathInfo}");
            routes.IgnoreRoute("ProntoWeb/{*pathInfo}");


            routes.MapRoute(
                "Default", // Nombre de ruta
                "{controller}/{action}/{id}", // URL con parámetros
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Valores predeterminados de parámetro
            );
            routes.MapRoute(
                "EditGrid",                                              // Route name
                "Requerimiento/EditGridData/{id}",                           // URL with parameters
                new { controller = "Home", action = "EditGridData", id = UrlParameter.Optional, NumeroItem = UrlParameter.Optional, Cantidad = UrlParameter.Optional }  // Parameter defaults
            );
        }


        protected void Application_BeginRequest()
        {
            //if (Request.IsLocal && )
            if (ConfigurationManager.AppSettings["Debug"].ToString() == "SI")
            {
                MiniProfiler.Start();
            }
        }

        protected void Application_EndRequest()
        {
            MiniProfiler.Stop();
        }


        protected void Application_Start()
        {


            MiniProfilerEF6.Initialize();
            GlobalFilters.Filters.Add(new StackExchange.Profiling.Mvc.ProfilingActionFilter());



            ViewEngines.Engines.Add(new RazorViewEngine());

            AreaRegistration.RegisterAllAreas();


            // https://stackoverflow.com/questions/26067296/how-to-add-web-api-to-an-existing-asp-net-mvc-5-web-application-project
            System.Web.Http.GlobalConfiguration.Configure(WebApplication1.WebApiConfig.Register);


            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);


            //http://stackoverflow.com/questions/14400643/accept-comma-and-dot-as-decimal-separator
            ModelBinders.Binders.Add(typeof(decimal), new DecimalModelBinder());
            ModelBinders.Binders.Add(typeof(decimal?), new DecimalModelBinder());


            //if (true)
            //{
            //   // this.Session["BasePronto"] = "Autotrol";
            //    if (Membership.ValidateUser("Mariano", "pirulo!"))
            //    {
            //        FormsAuthentication.SetAuthCookie("Mariano", true);
            //    }
            //}



        }





        protected void Application_Error()
        {


            // http://stackoverflow.com/questions/557730/i-am-getting-a-blank-page-while-deploying-mvc-application-on-iis
            // deshabilitar el control de errores para ver bugs serios de instalacion (falta de assemblies)
            if (false)
            {
                Exception exception = Server.GetLastError();
                RouteData routeData = new RouteData();
                routeData.Values.Add("controller", "ErrorController");
                routeData.Values.Add("action", "HandleTheError");
                routeData.Values.Add("error", exception);

                Response.Clear();
                Server.ClearError();

                IController errorController = new Controllers.ErrorController();
                errorController.Execute(new RequestContext(
                    new HttpContextWrapper(Context), routeData));
            }
            else
            {


                // si salta el error : Could not load file or assembly 
                // 'CodeEngine.Framework.QueryBuilder' or one of its dependencies. El parámetro no es correcto. (Exception from HRESULT: 0x80070057 (E_INVALIDARG))
                // limpiar los directorios temporales de asp.net
                // http://stackoverflow.com/questions/3831287/could-not-load-file-or-assembly-app-licenses


                //http://stackoverflow.com/questions/1171035/asp-net-mvc-custom-error-handling-application-error-global-asax



                Exception lastErrorWrapper = Server.GetLastError();


                if (lastErrorWrapper == null)
                {
                    // http://stackoverflow.com/questions/343014/asp-net-custom-error-page-server-getlasterror-is-null

                    // Try using something like Server.Transfer("~/ErrorPage.aspx"); from within the Application_Error() method of global.asax.cs
                    Server.Transfer("~/Shared/SinConexion.cshtml");
                }


                Exception lastError = lastErrorWrapper;
                if (lastErrorWrapper.InnerException != null) lastError = lastErrorWrapper.InnerException;


                string lastErrorTypeName = lastError.GetType().ToString();
                string lastErrorMessage = lastError.Message;
                string lastErrorStackTrace = lastError.StackTrace;

                if (lastErrorStackTrace == null) lastErrorStackTrace = "";

                try
                {
                    ErrHandler.WriteError(lastErrorMessage);

                }
                catch (Exception)
                {

                    //throw;
                }



                //  Attach the Yellow Screen of Death for this error   
                string YSODmarkup = "";
                HttpException lastErrorWrapperHttp = null;
                try
                {

                    lastErrorWrapperHttp = (System.Web.HttpException)lastErrorWrapper;

                    YSODmarkup = lastErrorWrapperHttp.GetHtmlErrorMessage();
                    if (!String.IsNullOrEmpty(YSODmarkup))
                    {
                        var YSOD = System.Net.Mail.Attachment.CreateAttachmentFromString(YSODmarkup, "YSOD.htm");
                    }


                    if (lastErrorWrapperHttp.Message == "The controller for path '/Pronto2/Content/jquery-ui-layout/jquery.ui.base.css' was not found or does not implement IController.")
                    //.ErrorCode == -2147467259)
                    {
                        // es el error del jquery.layout que le falta el theme
                        ErrHandler.WriteError(lastErrorWrapperHttp.Message);
                        return;
                    }


                }
                catch (Exception ex) { };


                string Body = "";
                //            if (lastErrorWrapperHttp != null)
                try
                {
                    Body = String.Format(
                        "<html><body> <h1>Hubo un error!</h1>_  <table cellpadding=\"5\" cellspacing=\"0\" border=\"1\">  <tr>  <td style=\"text-align: right;font-weight: bold\">URL:</td>  <td>{0}</td>  </tr>  <tr>  <td style=\"text-align: right;font-weight: bold\">User:</td>  <td>{1}</td>  </tr>  <tr>  <td style=\"text-align: right;font-weight: bold\">Exception Type:</td>  <td>{2}</td>  </tr>  <tr>  <td style=\"text-align: right;font-weight: bold\">Message:</td>  <td>{3}</td>  </tr>  <tr>  <td style=\"text-align: right;font-weight: bold\">Stack Trace:</td>  <td>{4}</td>  </tr>   </table></body></html>",
                            (lastErrorWrapperHttp == null ? "NO EXISTE REQUEST" : Request.RawUrl),
                                (lastErrorWrapperHttp == null ? "NO EXISTE USUARIO" : User.Identity.Name),
                        lastErrorTypeName,
                        lastErrorMessage,
                        lastErrorStackTrace.Replace(Environment.NewLine, "<br />"));

                }
                catch (Exception)
                {

                }

                Body += (YSODmarkup ?? "");


                // var direccion = "mscalella911@gmail.com";
                string direccion;
                try
                {
                    direccion = ConfigurationManager.AppSettings["ErrorMail"];
                }
                catch (Exception)
                {

                    direccion = "mscalella911@gmail.com";
                }






                /////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////

                //                1- en el caso de error en el Loggin (por un error de compilacion o algo por el estilo) si nos podes enviar en el mail las bases de datos de la BDLMaesteer (Solo las bases no los string de conexiones)

                //2-En el caso de otro tipo de error en que base de datos fue y si es posible el usuario (similar a los errores de Williams)

                //es es mas que nada para poder saber cuando nos llegan los mails saber en donde estan pasando
                string nombrebase = "";
                try
                {
                    if (System.Web.HttpContext.Current.Session != null) nombrebase = System.Web.HttpContext.Current.Session["BasePronto"].ToString();
                    //nombrebase = this.HttpContext.Session["BasePronto"].ToString();
                }
                catch (Exception)
                {

                    //throw;
                }

                /////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////
                //aca podria enviarme el ultimo log 
                // -Cómo se cual es el ultimo Log?
                const string DirectorioErrores = "~/Error/";

                string nombre = DirectorioErrores + DateTime.Today.ToString("dd-MM-yy") + ".txt";
                string nombreLargo = "";

                try
                {
                    if (System.Web.HttpContext.Current == null)
                    {
                        nombreLargo = AppDomain.CurrentDomain.BaseDirectory + @"Error\" + DateTime.Today.ToString("dd-MM-yy") + ".txt";
                    }
                    else
                    {
                        nombreLargo = System.Web.HttpContext.Current.Server.MapPath(nombre);
                    }


                }
                catch (Exception)
                {
                    nombreLargo = AppDomain.CurrentDomain.BaseDirectory + @"Error\" + DateTime.Today.ToString("dd-MM-yy") + ".txt";
                }

                string log = "";
                try
                {
                    log = System.IO.File.ReadAllText(nombreLargo);

                }
                catch (Exception)
                {

                    //throw;
                }


                /////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////


                ErrHandler.WriteError("Mando mail");


                try
                {



                    // 'apgurisatti@bdlconsultores.com.ar", _
                    //ProntoFuncionesGenerales.MandaEmailSimple(direccion,
                    //           (lastErrorWrapperHttp == null ? "" : User.Identity.Name + " en ") + nombrebase + " " + ConfigurationManager.AppSettings["ConfiguracionEmpresa"] + " (ProntoMVC)" + ": " + lastErrorMessage,
                    //               Body,
                    //                ConfigurationManager.AppSettings["SmtpUser"],
                    //                ConfigurationManager.AppSettings["SmtpServer"],
                    //                ConfigurationManager.AppSettings["SmtpUser"],
                    //                ConfigurationManager.AppSettings["SmtpPass"],
                    //                   (YSODmarkup + log) ?? "",
                    //               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));


                    Pronto.ERP.Bll.EntidadManager.MandaEmail_Nuevo(direccion,
                                    (lastErrorWrapperHttp == null ? "" : User.Identity.Name + " en ") + nombrebase + " " + ConfigurationManager.AppSettings["ConfiguracionEmpresa"] + " (ProntoMVC)" + ": " + lastErrorMessage,
                                   Body,
                                    ConfigurationManager.AppSettings["SmtpUser"],
                                    ConfigurationManager.AppSettings["SmtpServer"],
                                    ConfigurationManager.AppSettings["SmtpUser"],
                                    ConfigurationManager.AppSettings["SmtpPass"],
                                      null, //(YSODmarkup + log) ?? "",
                                   Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));






                }
                catch (Exception ex)
                {
                    try
                    {
                        ErrHandler.WriteError(ex);
                    }
                    catch (Exception)
                    {

                        //throw;
                    }



                };


                ErrHandler.WriteError("Mandado");


                // http://stackoverflow.com/questions/5226791/custom-error-pages-on-asp-net-mvc3
                var exception = Server.GetLastError();
                var httpException = exception as HttpException;
                Response.Clear();
                Server.ClearError();
                var routeData = new RouteData();
                routeData.Values["controller"] = "Errors";
                routeData.Values["action"] = "Index"; // "General";
                routeData.Values["exception"] = exception;
                Response.StatusCode = 500;
                Response.TrySkipIisCustomErrors = true;
                Response.ContentType = "text/html";
                if (httpException != null)
                {
                    Response.StatusCode = httpException.GetHttpCode();
                    switch (Response.StatusCode)
                    {
                        //case 403:
                        //    routeData.Values["action"] = "Http403";
                        //    break;
                        case 404:
                            routeData.Values["action"] = "PageNotFound";
                            break;
                        default:
                            routeData.Values["action"] = "Index";
                            break;
                    }
                }

                IController errorsController = new Controllers.ErrorController();
                var rc = new RequestContext(new HttpContextWrapper(Context), routeData);
                try
                {
                    errorsController.Execute(rc);
                }
                catch (System.Data.SqlClient.SqlException x)
                {
                    // por qué la llamada al ErrorController necesita del Membership (y por lo tanto, de la conexion SQL)?
                    //http://stackoverflow.com/questions/1171035/asp-net-mvc-custom-error-handling-application-error-global-asax
                    //ssss

                    // http://stackoverflow.com/questions/15894254/how-to-solve-redirect-loop

                    routeData.Values["action"] = "SinConexion";
                    IController errorsController2 = new Controllers.ErrorController();
                    var rc2 = new RequestContext(new HttpContextWrapper(Context), routeData);
                    errorsController2.Execute(rc);
                    // Response.Redirect("~/Views/Shared/SinConexion.cshtml");
                    //throw;
                }
                catch (Exception)
                {
                    throw;
                }


                /*
                        Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
                        ' Code that runs when an unhandled error occurs
        
                        ' http://www.asp.net/hosting/tutorials/processing-unhandled-exceptions-cs

        
                        'Get the error details

        
                        'Dim lastErrorWrapper As HttpException = Server.GetLastError()
                        Dim lastErrorWrapper As Exception = Server.GetLastError()
        
        
                        Dim lastError As Exception = lastErrorWrapper
                        If lastErrorWrapper.InnerException IsNot Nothing Then
                            lastError = lastErrorWrapper.InnerException
                        End If
        
                        Dim lastErrorTypeName As String = lastError.GetType().ToString()
                        Dim lastErrorMessage As String = lastError.Message
                        Dim lastErrorStackTrace As String = lastError.StackTrace
        
                        If lastErrorStackTrace Is Nothing Then lastErrorStackTrace = ""
        
                        ErrHandler.WriteError(lastError)
    
        
                        ' Attach the Yellow Screen of Death for this error   
                        Dim YSODmarkup As String
                        Dim lastErrorWrapperHttp As HttpException
                        Try
                            lastErrorWrapperHttp = lastErrorWrapper
        
                            YSODmarkup = lastErrorWrapperHttp.GetHtmlErrorMessage()
                            If (Not String.IsNullOrEmpty(YSODmarkup)) Then
            
                                Dim YSOD = Net.Mail.Attachment.CreateAttachmentFromString(YSODmarkup, "YSOD.htm")
                                'mm.Attachments.Add(YSOD)
            
                            End If
                        Catch ex As Exception
            
                        End Try
    
                        Dim Body As String = ""
                        If Not IsNothing(lastErrorWrapperHttp) Then
                            Body = String.Format( _
                                "<html><body> <h1>Hubo un error!</h1>_  <table cellpadding=""5"" cellspacing=""0"" border=""1"">  <tr>  <td style=""text-align: right;font-weight: bold"">URL:</td>  <td>{0}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">User:</td>  <td>{1}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">Exception Type:</td>  <td>{2}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">Message:</td>  <td>{3}</td>  </tr>  <tr>  <td style=""text-align: right;font-weight: bold"">Stack Trace:</td>  <td>{4}</td>  </tr>   </table></body></html>", _
                                If(lastErrorWrapperHttp Is Nothing, "NO EXISTE REQUEST", Request.RawUrl), _
                                 If(lastErrorWrapperHttp Is Nothing, "NO EXISTE USUARIO", User.Identity.Name), _
                                lastErrorTypeName, _
                                lastErrorMessage, _
                                lastErrorStackTrace.Replace(Environment.NewLine, "<br />"))
                        End If
            
                        Body &= iisNull(YSODmarkup, "")
        
                        Dim direccion As String
                        Try
                            direccion = ConfigurationManager.AppSettings("ErrorMail")
                        Catch ex As Exception
                            direccion = ""
                            'Dim direccion = "mscalella911@gmail.com"
                        End Try
                        If iisNull(direccion, "") = "" Then direccion = "mscalella911@gmail.com,apgurisatti@bdlconsultores.com.ar"
        
        
                        'me fijo si estoy depurando en el IDE. No lo hago antes para probar el pedazo de codigo de arriba. Es el mail
                        'lo que traba todo
                        If System.Diagnostics.Debugger.IsAttached() Then Return
    
        
                        Try
                            'apgurisatti@bdlconsultores.com.ar", _
                            MandaEmailSimple(direccion, _
                                            ConfigurationManager.AppSettings("ConfiguracionEmpresa") & " ProntoWeb" & ": " & lastErrorMessage, _
                                           Body, _
                                            ConfigurationManager.AppSettings("SmtpUser"), _
                                            ConfigurationManager.AppSettings("SmtpServer"), _
                                            ConfigurationManager.AppSettings("SmtpUser"), _
                                            ConfigurationManager.AppSettings("SmtpPass"), _
                                            iisNull(YSODmarkup, ""), _
                                            ConfigurationManager.AppSettings("SmtpPort"), , , )
            
                        Catch ex As Exception
                            ErrHandler.WriteError(ex)
                        End Try
        
        
        
        
                        '/////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////
                        'http://stackoverflow.com/questions/178600/microsoft-reportviewer-session-expired-errors
                        Dim exc As Exception = Server.GetLastError().GetBaseException()
                        If TypeOf exc Is Microsoft.Reporting.WebForms.AspNetSessionExpiredException Then
                            Server.ClearError()
                            Response.Redirect(FormsAuthentication.LoginUrl + "?ReturnUrl=" + HttpUtility.UrlEncode(Request.Url.PathAndQuery), True)
                        End If
                        '/////////////////////////////////////////////////////////////////////////////
                        '/////////////////////////////////////////////////////////////////////////////
                                   
                    End Sub
                  */
            }


            /*
            public async Task SendEmail(string toEmailAddress, string emailSubject, string emailMessage)
            {

                // necesito .NET 4.5 para esto
                var message = new MailMessage();
                message.To.Add(toEmailAddress);

                message.Subject = emailSubject;
                message.Body = emailMessage;

                using (var smtpClient = new SmtpClient())
                {
                    await smtpClient.SendMailAsync(message);
                }
            } 
            */

        }


    }


    public class DecimalModelBinder : IModelBinder
    {
        public object BindModel(ControllerContext controllerContext,
            ModelBindingContext bindingContext)
        {

            MiniProfiler profiler = MiniProfiler.Current;

            using (profiler.Step("En el DecimalModelBinder.BindModel"))
            {

                ValueProviderResult valueResult = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);
                ModelState modelState = new ModelState { Value = valueResult };
                object actualValue = null;

                if (valueResult == null) actualValue = null;
                else
                {
                    try
                    {

                        if (valueResult.AttemptedValue.Equals("N.aN") ||
                            valueResult.AttemptedValue.Equals("NaN") ||
                            valueResult.AttemptedValue.Equals("Infini.ty") ||
                            valueResult.AttemptedValue.Equals("Infinity") ||
                            string.IsNullOrEmpty(valueResult.AttemptedValue))
                        { actualValue = 0m; }
                        else
                        {
                            // actualValue = Convert.ToDecimal(valueResult.AttemptedValue,                        CultureInfo.CurrentCulture);
                            string tempResult = valueResult.AttemptedValue.Replace(",", ".");
                            double n;
                            bool isNumeric = double.TryParse(tempResult, out n);

                            if (isNumeric)
                            {
                                actualValue = Convert.ToDecimal(tempResult, CultureInfo.InvariantCulture);
                            }
                            else
                            {
                                actualValue = null;
                            }
                        }


                    }
                    catch (FormatException e)
                    {
                        ErrHandler.WriteError("propiedad:" + bindingContext.ModelName + "   valor:" + valueResult.AttemptedValue);

                        modelState.Errors.Add(e);
                    }
                    catch (Exception e)
                    {
                        ErrHandler.WriteError("propiedad:" + bindingContext.ModelName + "   valor:" + valueResult.AttemptedValue);

                        ErrHandler.WriteError(e);
                    }
                }

                bindingContext.ModelState.Add(bindingContext.ModelName, modelState);
                return actualValue;
            }
        }
    }

    public class DateTimeModelBinder : DefaultModelBinder
    {
        //    public override object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
        //  {
        // ???
        //    }
    }



    ////http://stackoverflow.com/questions/14400643/accept-comma-and-dot-as-decimal-separator
    //public class DecimalModelBinder : DefaultModelBinder
    //{
    //    #region Implementation of IModelBinder

    //    public override object BindModel(ControllerContext controllerContext, ModelBindingContext bindingContext)
    //    {
    //        var valueProviderResult = bindingContext.ValueProvider.GetValue(bindingContext.ModelName);

    //        if (valueProviderResult.AttemptedValue.Equals("N.aN") ||
    //            valueProviderResult.AttemptedValue.Equals("NaN") ||
    //            valueProviderResult.AttemptedValue.Equals("Infini.ty") ||
    //            valueProviderResult.AttemptedValue.Equals("Infinity") ||
    //            string.IsNullOrEmpty(valueProviderResult.AttemptedValue))
    //            return 0m;

    //        return valueProviderResult == null ? base.BindModel(controllerContext, bindingContext) : Convert.ToDecimal(valueProviderResult.AttemptedValue);
    //    }

    //    #endregion
    //}






}

/*


// http://www.packtpub.com/article/mixing-aspnet-webforms-and-aspnet-mvc mas que nada para lo de Reporting Services
namespace MixingBothWorldsExample
{
    public class Global : System.Web.HttpApplication
    {

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            routes.IgnoreRoute("{resource}.aspx/{*pathInfo}");
            routes.MapRoute(
            "Default",
                // Route name
            "{controller}/{action}/{id}",
                // URL with parameters
            new { controller = "Home", action = "Index", id = "" }
                // Parameter defaults
            );
        } 
        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
        }
    }
}
 */


public class ProfileActionsAttribute : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext filterContext)
    {
        var profiler = MiniProfiler.Current;
        var step = profiler.Step("Action: " + filterContext.ActionDescriptor.ActionName);
        filterContext.HttpContext.Items["step"] = step;
    }

    public override void OnActionExecuted(ActionExecutedContext filterContext)
    {
        var step = filterContext.HttpContext.Items["step"] as IDisposable;
        if (step != null)
        {
            step.Dispose();
        }
    }
}