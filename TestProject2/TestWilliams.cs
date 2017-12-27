﻿#region MyRegion

using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting.Web;
using System.Linq;
//using System.Linq.Dynamic;
using ProntoMVC.Models;
using ProntoMVC.Controllers;
using System.Web;
//using Repo;
//using Servicio;
using ProntoMVC.Data.Models;
using System.Web.Mvc;
using System.Web.Security;
using Moq;
using System.Data.Entity;
using System.Data.Entity.SqlServer;
//using System.Data.Objects;
using System.Security.Principal;
using System.Collections;
using System.Collections.Generic;

using ProntoMVC.Data;

using ProntoMVC.ViewModels;

using FCEngine;

using ProntoFlexicapture;

using System.Transactions;

using System.IO;

using Pronto.ERP.Bll;

using System.Data;

using System.Diagnostics;

using Microsoft.Reporting.WebForms;

using System.Configuration;

using BitMiracle.LibTiff.Classic;
using System.Drawing;
using System.Drawing.Imaging;

using System.Text;
using System.Reflection;


using OpenQA.Selenium.Firefox;
using OpenQA.Selenium;
using OpenQA.Selenium.Support.UI;


using System.Net;
using System.Xml.Linq;


using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;






using Tellurium.MvcPages;
using Tellurium.MvcPages.Configuration;
using Tellurium.MvcPages.SeleniumUtils;




//test de java lopez
// https://github.com/ajlopez/TddAppAspNetMvc/blob/master/Src/MyLibrary.Web.Tests/Controllers/HomeControllerTests.cs

namespace ProntoMVC.Tests
{




    [TestClass]
    public class TestsWilliams
    {


        #region blabla





        //const string scbdlmaster =
        //          @"metadata=res://*/Models.bdlmaster.csdl|res://*/Models.bdlmaster.ssdl|res://*/Models.bdlmaster.msl;provider=System.Data.SqlClient;provider connection string=""data source=SERVERSQL3\TESTING;initial catalog=BDLMaster;user id=sa;password=.SistemaPronto.;multipleactiveresultsets=True;connect timeout=8;application name=EntityFramework""";

        //const string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=SERVERSQL3\\TESTING;initial catalog=DemoProntoWeb;User ID=sa;Password=.SistemaPronto.;multipleactiveresultsets=True;App=EntityFramework'";


        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        const string nombreempresa = "Williams";
        //const string nombreempresa = "DemoProntoWeb";
        const string usuario = "Mariano";
        //string bdlmasterappconfig = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        string scbdlmasterappconfig; //  = "Data Source=SERVERSQL3\\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";

        string DirApp;
        string SC;
        string TempFolder;
        string plantilla;

        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 



        //http://stackoverflow.com/questions/334515/do-you-use-testinitialize-or-the-test-class-constructor-to-prepare-each-test-an
        [TestInitialize]
        public void Initialize()
        {
            //    string bdlmastersql = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            //    bdlmasterappconfig = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(bldmastersql);
            //    sc = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(Generales.conexPorEmpresa(nombreempresa, bldmasterappconfig, usuario, true));
            //

            DirApp = ConfigurationManager.AppSettings["AplicacionConImagenes"];

            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.AppSettings["SC"]);

            plantilla = ConfigurationManager.AppSettings["PlantillaFlexicapture"];

            //probar conexion con timeout cortopp
            if (false)
            {
                // no logro que el timeout sea corto
                var x = EntidadManager.ExecDinamico(SC, "SELECT TOP 1 * from provincias", 8);
            }


            scbdlmasterappconfig = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString);

            /*

            DirApp = @"C:\Users\Administrador\Documents\bdl\prontoweb";
            // string SamplesFolder = @"C:\Users\Administrador\Desktop\tiff multipagina";

            SC = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(
                   @"Data Source=SERVERSQL3;Initial catalog=Williams;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8");

            // plantilla = @"C:\Users\Administrador\Documents\bdl\pronto\InterfazFlexicapture\cartaporte.afl";
            plantilla = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\cartaporte.afl";
            */

            TempFolder = DirApp + @"\Temp";

        }





        static public void GetMockedControllerGenerico(ProntoBaseController c)
        {

            // http://stackoverflow.com/questions/1981426/how-do-i-mock-fake-the-session-object-in-asp-net-web-forms
            // http://stackoverflow.com/questions/1981426/how-do-i-mock-fake-the-session-object-in-asp-net-web-forms
            // http://stackoverflow.com/questions/1981426/how-do-i-mock-fake-the-session-object-in-asp-net-web-forms
            // http://stackoverflow.com/questions/1981426/how-do-i-mock-fake-the-session-object-in-asp-net-web-forms


            /*
            var controllerContext = new Mock<ControllerContext>();



            // cómo hacer con la cadena de conexion en ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            // http://stackoverflow.com/questions/9486087/how-to-mock-configurationmanager-appsettings-with-moq
            // agregarlas en el app config de este proyecto!!!
            // agregarlas en el app config de este proyecto!!!
            // agregarlas en el app config de este proyecto!!!
            // http://stackoverflow.com/questions/17580485/cannot-use-configurationmanager-inside-unit-test-project



            //controllerContext.SetupGet(p => p.HttpContext.Session["BasePronto"]).Returns(Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey));
            controllerContext.SetupGet(p => p.HttpContext.Session["BasePronto"]).Returns(nombreempresa);
            controllerContext.SetupGet(p => p.HttpContext.Session["Usuario"]).Returns(usuario);
            //  controllerContext.SetupGet(p => p.HttpContext.User.Identity.Name).Returns(_testEmail);
            controllerContext.SetupGet(p => p.HttpContext.Request.IsAuthenticated).Returns(true);
            controllerContext.SetupGet(p => p.HttpContext.Response.Cookies).Returns(new HttpCookieCollection());

            controllerContext.Setup(p => p.HttpContext.Request.Form.Get("ReturnUrl")).Returns("sample-return-url");
            controllerContext.Setup(p => p.HttpContext.Request.Params.Get("q")).Returns("sample-search-term");






            // si queres que te funcionen las llamadas a Url.Action(...), tenes que mandar una url mockeada
        http://stackoverflow.com/questions/15258669/mocking-controller-url-actionstring-string-object-string-in-asp-net-mvc

            var routes = new System.Web.Routing.RouteCollection();
            MvcApplication.RegisterRoutes(routes);

            var request = new Mock<HttpRequestBase>(); //MockBehavior.Strict);
            request.SetupGet(x => x.ApplicationPath).Returns("/");
            request.SetupGet(x => x.Url).Returns(new Uri("http://localhost/a", UriKind.Absolute));
            request.SetupGet(x => x.ServerVariables).Returns(new System.Collections.Specialized.NameValueCollection());

            var response = new Mock<HttpResponseBase>(); //MockBehavior.Strict);
            response.Setup(x => x.ApplyAppPathModifier("/post1")).Returns("http://localhost/post1");

            var context = new Mock<HttpContextBase>(); // (MockBehavior.Strict);
            context.SetupGet(x => x.Request).Returns(request.Object);
            context.SetupGet(x => x.Response).Returns(response.Object);

            //controllerContext.SetupGet(x => x.Request).Returns(request.Object);
            //controllerContext.SetupGet(x => x.Response).Returns(response.Object);





            c.ControllerContext = controllerContext.Object;


            //var controller = new LinkbackController(dbF.Object);
            //controller.ControllerContext = new ControllerContext(context.Object, new RouteData(), controller);
            c.Url = new UrlHelper(new System.Web.Routing.RequestContext(context.Object, new System.Web.Routing.RouteData()), routes);






            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////


            // http://stackoverflow.com/questions/4257793/mocking-a-membershipuser

            var m = new Mock<Generales.IStaticMembershipService>();
            var us = new Mock<MembershipUser>();
            // administrador    1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9
            // supervisor       1804B573-0439-4EA0-B631-712684B54473
            //us.Setup(u => u.ProviderUserKey).Returns(new Guid("1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9"));
            us.Setup(u => u.ProviderUserKey).Returns(new Guid("1804B573-0439-4EA0-B631-712684B54473"));
            us.Setup(u => u.UserName).Returns("administrador");
            m.Setup(s => s.GetUser()).Returns(us.Object);
            m.Setup(s => s.EsSuperAdmin()).Returns(true);
            m.Setup(s => s.UsuarioTieneElRol(It.IsAny<string>(), It.IsAny<string>())).Returns(true);
            c.oStaticMembershipService = m.Object;




            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            // necesito llamar a mano al Initialize  http://stackoverflow.com/questions/1452665/how-to-trigger-initialize-method-while-trying-to-unit-test
            //  http://stackoverflow.com/questions/1452418/how-do-i-mock-the-httpcontext-in-asp-net-mvc-using-moq


            //var requestContext = new System.Web.Routing.RequestContext(controllerContext.Object, new System.Web.Routing.RouteData());
            //var requestContext = new System.Web.Routing.RequestContext(contextMock.Object, new System.Web.Routing.RouteData());
            //IController controller = c;
            //controller.Execute(requestContext);


            c.FakeInitialize(nombreempresa);

            // este tipo sugiere directamente sacar del Initialize el codigo y meterlo en un metodo para llamarlo aparte
            // http://stackoverflow.com/questions/5769163/asp-net-mvc-unit-testing-override-initialize-method
            // I suggest you to factor out your custom Initialize() logic out into different method. Then create fake (stub) subclass with 
            // public method that calls this factored out protected Initialzie. Are you with me?

            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////


            */

        }




        public static TimeSpan Time(Action action)
        {
            Stopwatch stopwatch = Stopwatch.StartNew();
            action();
            stopwatch.Stop();
            return stopwatch.Elapsed;
        }



        /// <summary>
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// </summary>





        [TestMethod]
        public void Carta_GetItemPorNumero()
        {
            //  2.1s  original


            const int CUANTAS = 10;

            // http://stackoverflow.com/questions/969290/exact-time-measurement-for-performance-testing/16157458#16157458
            TimeSpan time = Time(() =>
            {
                // Do some work

                for (int n = 0; n < CUANTAS; n++)
                {
                    string ms = "", warn = "";

                    var carta = CartaDePorteManager.GetItemPorNumero(SC, 20488343, 0, 0);

                    Console.Write(ms);

                }
            });

            Console.WriteLine("Por carta={0} s", time.TotalSeconds / CUANTAS);

            Assert.IsTrue((time.TotalSeconds / CUANTAS) < 3.3);


        }


        [TestMethod]
        public void Carta_GetItem()
        {
            //  1.8s  original


            const int CUANTAS = 10;

            // http://stackoverflow.com/questions/969290/exact-time-measurement-for-performance-testing/16157458#16157458
            TimeSpan time = Time(() =>
            {
                // Do some work

                for (int n = 0; n < CUANTAS; n++)
                {
                    string ms = "", warn = "";

                    var carta = CartaDePorteManager.GetItem(SC, 4444);

                    Console.Write(ms);

                }
            });

            Console.WriteLine("Por carta={0} s", time.TotalSeconds / CUANTAS);

            Assert.IsTrue((time.TotalSeconds / CUANTAS) < 3.3);


        }



        [TestMethod]
        public void Cliente_GetItem()
        {
            // 0.78s    original
            //     s    saltando la lectura de DetalleClientes
            //     s    saltando tambien linqtosql
            //     s    cambiando linqtosql por EF -no puedo porque la base oficial no tiene la tabla Clientes con esos campos nuevos!!!


            const int CUANTAS = 10;
            //var carta = CartaDePorteManager.GetItem(SC, 4444);

            // http://stackoverflow.com/questions/969290/exact-time-measurement-for-performance-testing/16157458#16157458
            TimeSpan time = Time(() =>
            {
                // Do some work

                for (int n = 0; n < CUANTAS; n++)
                {
                    string ms = "", warn = "";


                    ClienteManager.GetItem(SC, 8187); //carta.Titular);


                    Console.Write(ms);

                }
            });

            Console.WriteLine("Cada uno={0} s", time.TotalSeconds / CUANTAS);

            Assert.IsTrue((time.TotalSeconds / CUANTAS) < 3.3);


        }



        [TestMethod]
        public void Carta_IsValid()
        {
            // 12.34 s    original
            //       s    saltando  UsaClientesQueEstanBloqueadosPorCobranzas
            //  4.9  s    saltando  UsaClientesQueEstanBloqueadosPorCobranzas + UsaClientesQueExigenDatosDeDescargaCompletos
            //  2.6       saltando  UsaClientesQueEstanBloqueadosPorCobranzas + UsaClientesQueExigenDatosDeDescargaCompletos + EsUnoDeLosClientesExportador
            //  3.5  s    corregidas! UsaClientesQueEstanBloqueadosPorCobranzas + UsaClientesQueExigenDatosDeDescargaCompletos + EsUnoDeLosClientesExportador


            const int CUANTAS = 5;
            var carta = CartaDePorteManager.GetItem(SC, 4444);

            // http://stackoverflow.com/questions/969290/exact-time-measurement-for-performance-testing/16157458#16157458
            TimeSpan time = Time(() =>
            {
                // Do some work

                for (int n = 0; n < CUANTAS; n++)
                {
                    string ms = "", warn = "";

                    CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);

                    Console.Write(ms);

                }
            });

            //Console.WriteLine("Elapsed={0}ms", time.TotalMilliseconds);
            Console.WriteLine("Por carta={0} s", time.TotalSeconds / CUANTAS);

            Assert.IsTrue((time.TotalSeconds / CUANTAS) < 3.3);


        }




        [TestMethod]
        public void Carta_Save()
        {
            // 16.4s por carta (12s son del IsValid dentro del Save)
            //  5.4  despues de optimizar IsValid !!

            const int CUANTAS = 5;
            var carta = CartaDePorteManager.GetItem(SC, 4444);

            // http://stackoverflow.com/questions/969290/exact-time-measurement-for-performance-testing/16157458#16157458
            TimeSpan time = Time(() =>
                    {
                        // Do some work

                        for (int n = 0; n < CUANTAS; n++)
                        {
                            string ms = "", warn = "";

                            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

                            Console.Write(ms);

                        }
                    });

            Console.WriteLine("Por carta={0} s", time.TotalSeconds / CUANTAS);

            Assert.IsTrue((time.TotalSeconds / CUANTAS) < 3.3);


        }





        [TestMethod]
        public void CartaPorteFuncionalidadBasica()
        {

            //tarda 5 min

            string ms = "", warn = "";
            var carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC);
            carta.NobleGrado = 2;
            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            Assert.AreEqual(1, carta.NobleGrado);

            carta = null;
            carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            carta.NobleGrado = 3;
            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            Assert.AreEqual(2, carta.NobleGrado);

        }




        [TestMethod]
        public void probar_todos_los_sincros()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;


            string[] sincros = { "BTG PACTUAL[BIT]", "Beraza", "Granar" };
            //            string[] sincros = { "Beraza", "Zeni" };


            for (int n = 0; n < sincros.Count(); n++)
            {
                var output2 = SincronismosWilliamsManager.GenerarSincro(sincros[n], ref sErrores, SC, "dominio", ref sTitulo,
                                     CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                                     "", -1, -1, -1, -1,
                                     -1, -1, -1, -1,
                                     CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                                     new DateTime(2014, 1, 20), new DateTime(2014, 1, 28),
                                     -1, "Ambas", false, "", "", -1, ref registrosf, 40);




                //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
                System.Diagnostics.Process.Start(output2);
            }


        }




        [TestMethod]
        public void mail_de_error()
        {

            Pronto.ERP.Bll.EntidadManager.MandaEmail_Nuevo(ConfigurationManager.AppSettings["ErrorMail"],
                               "asuntoasuntoasunto 2",
                            "cuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpo cuerpocuerpocuerpocuerpo",
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpServer"],
                            ConfigurationManager.AppSettings["SmtpUser"],
                            ConfigurationManager.AppSettings["SmtpPass"],
                              "",
                           Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));
        }



        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////////////



        #endregion


        #endregion







        [TestMethod]
        public void OCR_validacion_de_A_C_A_47215()
        {

            /*
                                             * en los casos de a.c.a me tira:
            Error in: . Error Message:Falta elegir a qué acopio corresponde el remitente comercial
                habría q eludir esa validacion

            */
        }







        [TestMethod]
        public void SincroDiazRiganti_47179()
        {

            string sErrores = "", sTitulo = "";
            // LinqCartasPorteDataContext db = null;




            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                    "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 2), new DateTime(2014, 1, 2),
                0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void ServicioWebServiceDescargas_BLD_47213()
        {

            //¿habrá alguna diferencia entre el ListadoSegunCliente y el listado normal? andy sospecha del robot

            //La carta Id = 3222062 no aparece, al usar obtenerDescargas_v3 con estos paramtros:
            //Andres
            //Andre5!
            //1
            //2017 / 12 / 23
            //2017 / 12 / 23
            //
            // -creo que es porque el netofinal está en 0 (aún cuando está cargado el netosinmerma y la fecha de descarga)
            // -pero entonces debería aparecer como de posicion, no?
            // http://iismvc/Williams/ProntoWeb/wsCartaPorteExterno.asmx/obtenerPosiciones_v3?usuario=Andres&password=Andre5!&cuit=1&fechadesde=2017-12-23T00:00:00&fechahasta=2017-12-23T00:00:00
            // al regrabarla, le calcula bien el netofinal
            // -y entonces cómo solucionarlo? agregando una validacion que si la fechaDescarga está puesta, tambien el NetoFinal? Y por qué solo usa la fecha
            // para mostrar la pestaña de descarga, cuando la funcion sql usa el peso en lugar de la fecha?
            // Al margen de esto... cómo es que se dieron cuenta, si despues de todo, el informe muestra lo mismo que el servicio? -deben haber usado de referencia el sincronismo, no?








            //var s = new ServicioCartaPorte.servi();
            //string dir = DirApp + @"\Temp\Pegatinas"; // es fundamental para el selenium que no tenga la ultima barrita? SII!!!!!
            //string dirMiRepo = @"C:\Users\Mariano\Documents\";
            //s.CerealnetSelenium_ConChromeHeadless(dir, dirMiRepo + @"pronto\InterfazFlexicapture\bin\Debug\", true);

            //le tendria que pasar el directorio del chrome viejo
            //ProntoWindowsService.Service1.Initialize();
            //ProntoWindowsService.Service1.DoWorkSoloPegatinas();




            string usuario = "Andres"; //"fyo";
            string clave = "Andre5!"; // "76075";
            string cuit = "1";

            // var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            var respEntrega = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL_v3(usuario, clave, cuit,
                                            new DateTime(2017, 12, 23),
                                            new DateTime(2017, 12, 23), CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                                            SC, DirApp, scbdlmasterappconfig);


            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (CerealNet.WSCartasDePorte.analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            //Console.ReadKey();
        }





        [TestMethod]
        public void MandarmeLosSincrosAutomaticos_tema_de_la_firma_47212()
        {

            var s = CDPMailFiltrosManager2.AgregarFirmaHtml(1);

            string sErr = "";
            SincronismosWilliamsManager.EnviarSincro("TOMASHNOS", "nano@gggg", ref sErr, true);


        }







        #region reclamos43063_CHAT



        [TestMethod]
        public void conversacion_43063()
        {


            var s = new ServicioCartaPorte.servi();






            // Mariano elige una carta
            int idcarta = 2633335;

            //Mariano saluda a Rogrigo
            //s.GrabarComentario_DLL(idcarta, "Hola Rodrigo como estás", "Mariano", SC, "RODRIGORIOS");


            ////Rodrigo contesta, no tiene necesidad de indicar a quien, puesto que es un usuario externo
            //s.GrabarComentario_DLL(idcarta, "este es mi comentario", "RODRIGORIOS", SC, "");


            //var sss = Membership.GetAllUsers();
            //Dictionary<string, string> membershipCasillas = new Dictionary<string, string>() {
            //                                  { "Mariano", "mscalella911@gmail.com"},
            //                                  { "RODRIGORIOS", "gmalggievato@gmail.com"}
            //};

            //deberia enviar el mail y la notificacion esa funcion
            s.GrabarComentarioYNotificar(idcarta, "Mariano", "Hola Rodrigo como estás", SC, scbdlmasterappconfig, "RODRIGORIOS", false,
                                                                ConfigurationManager.AppSettings["UrlDominio"], ConfigurationManager.AppSettings["SmtpUser"], ConfigurationManager.AppSettings["SmtpServer"], ConfigurationManager.AppSettings["SmtpPass"], Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));


            s.GrabarComentarioYNotificar(idcarta, "RODRIGORIOS", "Mariano cuando va a estar listo este tema???", SC, scbdlmasterappconfig, "", true,
                                                    ConfigurationManager.AppSettings["UrlDominio"], ConfigurationManager.AppSettings["SmtpUser"], ConfigurationManager.AppSettings["SmtpServer"], ConfigurationManager.AppSettings["SmtpPass"], Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

        }








        [TestMethod]
        public void enviosPush__()
        {
            // https://firebase.google.com/docs/cloud-messaging/js/device-group?hl=es-419
            //Administra grupos de dispositivos
            //Antes de enviar mensajes a un grupo de dispositivos, debes:
            //Obtener los tokens de registro de cada dispositivo que desees agregar al grupo.
            //Crear la notification_key, que identifica el grupo de dispositivos mediante la asignación de un grupo específico(por lo general, un usuario) a 
            //todos los tokens de registro relacionados del grupo.Puedes crear claves de notificación en el servidor de apps o en las apps cliente de Android.






            string[] deviceId = { "fLTPu6cSIkk:APA91bFzQUwGEhSMKm7k_xwJO7CmviSxH9BxPoFle59XmvNz4w2rkqOlGE9HuDm-EFI3zPvhjJf7jKQa9V-EkNSGvDNsjCpNlM0BtlT-i9N6P-pQZ90Y_2vUPjo8fWiPD-O2WfLqHieE" 
                                  //"eq8033Zs2MQ:APA91bEw8zTPtAR1b_vj_z1qWE7Rrrbm95OgnMtYueab-W3q-z6cVokHmCXOG1fBLl9hKBasrssrNyKtiKw3ENdprmnIwYfVdLPEyLeDmgOq412Ddk8_bwQS6IyTSLqFQfVcf4jwfkAs"
            };


            var c = new Sch_WCFApplication.PushNotification(deviceId, "holaaaaaa nanooo", "Williams", "", "");
            // var d = new Sch_WCFApplication.PushNotification(deviceId[0], "holaaaaaa", "titulo");

            // cómo mandar al servidor un mensaje para que el servidor asocie mi ticket de subscripcion con mi nombre de usuario?
            // -lo tenés que hacer vos a mano en el sendTokenToServer del codigo de ejemplo


        }





        [TestMethod]
        public void _AsociarUsuarioConTokenFirebase()
        {
            //            var subs = BuscoLasSubscripcionesDelUsuario(usuario);
            //            MandoMensajeAListadoDeSubscripciones(subs);
            var s = new ServicioCartaPorte.servi();
            s.AsociarUsuarioConTokenFirebase("fLTPu6cSIkk:APA91bFzQUwGEhSMKm7k_xwJO7CmviSxH9BxPoFle59XmvNz4w2rkqOlGE9HuDm-EFI3zPvhjJf7jKQa9V-EkNSGvDNsjCpNlM0BtlT-i9N6P-pQZ90Y_2vUPjo8fWiPD-O2WfLqHieE"
                                        , "Mariano", SC);



            var lista = s.TraerTokensDelUsuario(usuario, SC);
            s.EnviarNotificacionALosDispositivosDelUsuario(usuario, "asdfaaf", "tit", SC, "", "");
        }










        [TestMethod]
        public void TienePermisosParaEstaCarta_43063()
        {

            CartaDePorteManager.TienePermisosParaEstaCarta("Mariano", 6546464, SC, scbdlmasterappconfig);

            //If Not(Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsComercial") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsAdmin") Or Roles.IsUserInRole(Membership.GetUser().UserName, "WilliamsFacturacion")) Then
            //    btnsituacion.Visible = False



        }


        [TestMethod]
        public void TienePermisosParaEsteArchivo_43063()
        {

            // http://localhost:50769/ProntoWeb/CartaPorteDescargarArchivo.aspx?Id=lala.pdf  
            CartaDePorteManager.TienePermisosParaEsteArchivo("Mariano", "lala.pdf", SC, scbdlmasterappconfig);
            //Busco en q comentario esta el archivo
            //    busco el reclamo del comentario, y la carta del comentario
            //    veo si tiene permiso para esa carta

        }





        [TestMethod]
        public void bajarArchivo_43063()
        {

            int idcarta = 2633399;

            //http://localhost:50769/ProntoWeb/CartaPorteDescargarArchivo.aspx?Id=lala.pdf  

            //var s = new ServicioCartaPorte.servi();
            //s.BajarArchivo_DLL( "asarararasa.pdf" , usuario, SC);
            //GrabarComentarioArchivo_DLL
        }




        [TestMethod]
        public void EnviarMailALosQueParticipanEnElReclamo_43063()
        {

            // podria pasarle a la funcion el listado de usuarios+mails....
            // o tambien, pasarle la conexion a la bdlmaster y hacer a mano la busqueda...

            //sfasdf
            //asdasdfasdfasdf

            //            Pronto.ERP.Bll.EntidadManager.MandaEmail_Nuevo(ConfigurationManager.AppSettings["ErrorMail"],
            //                   "asuntoasuntoasunto 2",
            //                "cuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpocuerpo cuerpocuerpocuerpocuerpo",
            //                ConfigurationManager.AppSettings["SmtpUser"],
            //                ConfigurationManager.AppSettings["SmtpServer"],
            //                ConfigurationManager.AppSettings["SmtpUser"],
            //                ConfigurationManager.AppSettings["SmtpPass"],
            //                  "",
            //               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]));

        }




        [TestMethod]
        public void ListadoDeUltimosReclamosDeEsteUsuario_43063()
        {


            /*
                        verMisChats

                    AgregarChat(idusuario, idreclamo, comentario)

                    quienes escuchan el chat? quiero decir, a quien les llega el mail / notificacion

                    SubirArchivo

                    ColaDeMails o SignalR
                    */




            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
                                //string output = @"C:\Users\Mariano\Downloads\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();


            var s = new ServicioCartaPorte.servi();
            string ret = s.ReclamosMaestro_DynamicGridData("IdReclamo", "desc", 1, 999999, true, filtro, "", "", 0, 0, SC, "", "");
            System.Web.Script.Serialization.JavaScriptSerializer jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            jqGridJson listado = jsonSerializer.Deserialize<jqGridJson>(ret);
            //Debugger.
            Assert.IsTrue(listado.records > 0);

        }




        [TestMethod]
        public void ListadoDeComentariosPorCartaYUsuario_43063()
        {

            /*
                        verMisChats

                    AgregarChat(idusuario, idreclamo, comentario)

                    quienes escuchan el chat? quiero decir, a quien les llega el mail / notificacion

                    SubirArchivo

                    ColaDeMails o SignalR
                    */




            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
                                //string output = @"C:\Users\Mariano\Downloads\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();



            int idcarta = 2633399;


            var rec = new Reclamo();
            rec.Estado = 22;
            rec.Descripcion = "asdfasdf";
            db.Reclamos.Add(rec);
            db.SaveChanges();

            var comentario = new ReclamoComentario(); // db.ReclamoComentarios.FirstOrDefault().IdReclamo;
            comentario.IdReclamo = rec.IdReclamo;
            comentario.IdEmpleado = 1;
            comentario.Comentario = "hola hola";
            db.ReclamoComentarios.Add(comentario);

            var comentario2 = new ReclamoComentario(); // db.ReclamoComentarios.FirstOrDefault().IdReclamo;
            comentario2.IdReclamo = rec.IdReclamo;
            comentario2.IdEmpleado = 10;
            comentario2.Comentario = "q haces";
            db.ReclamoComentarios.Add(comentario2);


            db.CartasDePortes.Find(idcarta).IdReclamo = rec.IdReclamo;

            db.SaveChanges();


            //haria falta aclarar el usuario tambien

            var s = new ServicioCartaPorte.servi();
            string ret = s.ReclamosComentarios_DynamicGridData("Fecha", "asc", 1, 999999, true, filtro, "", "", 0, idcarta, SC, "", "", "");
            System.Web.Script.Serialization.JavaScriptSerializer jsonSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            jqGridJson listado = jsonSerializer.Deserialize<jqGridJson>(ret);
            Assert.IsTrue(listado.records > 0);

        }



        [TestMethod]
        public void IdReclamoSegunCartaYUsuario_43063()
        {

            int idcarta = 2633333;


            var s = new ServicioCartaPorte.servi();


            s.IdReclamoSegunCartaYUsuario(idcarta, "", SC);

        }






        [TestMethod]
        public void ListarUsuariosDeEstaCartaConLosQueSePuedaChatear_43063()
        {
            int idcarta = 2633333;


            var s = new ServicioCartaPorte.servi();

            //Tendría que poder usarse la segunda bdlmaster(la de externos). Cómo hacemos entonces????

            s.GrabarComentario_DLL(idcarta, "este es mi comentario", usuario, SC, "carlitos"); //cómo abro un chat con usuarios especificos?


            var usuarios = s.UsuariosExternosQuePuedenChatearEnEstaCarta(idcarta, SC, scbdlmasterappconfig);

            // crear un chat con el primero de la lista
            // listar despues los comentarios de esa carta 
            // y despues listar los comentarios del usuario

            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
                                //string output = @"C:\Users\Mariano\Downloads\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            string ret = s.ReclamosComentarios_DynamicGridData("Fecha", "asc", 1, 999999, true, filtro, "", "", 0, idcarta, SC, "", "", "");



            string ret2 = s.ReclamosMaestro_DynamicGridData("IdReclamo", "asc", 1, 999999, true, filtro, "", "", 0, idcarta, SC, "", "");


        }








        [TestMethod]
        public void cerrar_consulta_43063()
        {

            //            -En Reclamos no funciona "Ver Carta"(es porque lo desactivamos ?)
            //- "Cerrar" no hace nada
            //- "Abrir" tiene que ser para el chat con cada usuario


            int idcarta = 2633333;
            string usuariodestino = "RODRIGORIOS";

            var s = new ServicioCartaPorte.servi();
            s.AbrirReclamo_DLL(idcarta, usuario, SC, usuariodestino);
            s.CerrarReclamo_DLL(idcarta, usuario, SC, usuariodestino);
            var bEstado = s.EstadoReclamo_DLL(idcarta, usuario, SC, usuariodestino);


        }



        [TestMethod]
        public void agregar_comentario_43063()
        {

            // http://localhost:50769/ProntoWeb/ReclamosPorUsuarioMovil.aspx?Id=2633399
            // http://localhost:50769/ProntoWeb/CartaDePorte.aspx?Id=2633399


            int idcarta = 2633399;


            var s = new ServicioCartaPorte.servi();
            s.GrabarComentario_DLL(idcarta, "este es mi comentario", usuario, SC, "carlitos"); //cómo abro un chat con usuarios especificos?
                                                                                               //s.UploadComentario_DLL();            // y si directamente comparto una url?... -pero cómo darle acceso a esa url al usuario externo?????



        }



        #endregion










        [TestMethod]
        public void liquidacionsubcon_46735_2()
        {

            /*

            Te tenemos que pedir que cuando se carguen camiones de SYNGENTA y se coloque en la solapa de entregador a otro, para lo que es la liquidacion del subcomisionista tome esa cp como elevacion.

            Solo tiene que afectar a eso. No tiene que afectar al envio de descarga al cliente y vista de la cp en nuetro sistema.

            En titular / intermediario / remitnte / cliente observ.

            */

            var cliente = SQLdinamico.BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC);
            cliente = -1;


            if (false)
            {

                var s = new ServicioCartaPorte.servi();
                var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
                DemoProntoEntities db = new DemoProntoEntities(scEF);


                var q1 = db.WilliamsDestinos.Where(x => x.Subcontratista1 == 10947 || x.Subcontratista2 == 10947).FirstOrDefault(); // ramirez jose luis
                q1.Subcontratista1 = 10947;
                q1.Subcontratista2 = 10947;

                var q2 = db.ListasPreciosDetalles.Where(x => x.ListasPrecio.Descripcion == "RAMIREZ JOSE LUIS - Precios").ToList(); // ramirez jose luis
                foreach (Data.Models.ListasPreciosDetalle ps in q2)
                {
                    ps.PrecioComboCaladaMasBalanza = 55;
                }

                db.SaveChanges();

            }







            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 5000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2016, 1, 1),
                        new DateTime(2017, 7, 31),
                        0, cliente, ref sTitulo);



            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Mariano\Documents\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }








        [TestMethod]
        public void loginEnUrenport3_42773_5()
        {
            var s = new ServicioCartaPorte.servi();
            string dir = DirApp + @"\Temp\Pegatinas"; // es fundamental para el selenium que no tenga la ultima barrita? SII!!!!!
            string dirMiRepo = @"C:\Users\Mariano\Documents\";

            s.UrenportSelenium_ConChromeHeadless(dir, dirMiRepo + @"pronto\InterfazFlexicapture\bin\Debug\", true, @"C:\Users\Mariano\Documents\chrome64_49.0.2623.75\chrome.exe");

            //s.CerealnetSeleniumConPhantomJS(DirApp);
        }



        [TestMethod]
        public void loginEnUrenport3_42773_6()
        {


            //            Comment 94 by ankitkoo...@gmail.com, Dec 5
            //For people who are searching for a Solution for C#. A very elegant solution has been provided by Cezary Piątek in his Tellurium framework. 
            //GitHub link to framework : https://github.com/cezarypiatek/Tellurium

            //Please refer to the class : Tellurium.MvcPages.SeleniumUtils.ChromeRemoteInterface.ChromeRemoteInterface

            //https://github.com/cezarypiatek/Tellurium/blob/master/Src/MvcPages/SeleniumUtils/ChromeRemoteInterface/ChromeRemoteInterface.cs

            //This class has the required implementation.

            //con la nueva version del chromedriver, en modo headless no me baja el archivo. https://bugs.chromium.org/p/chromium/issues/detail?id=696481


            var s = new ServicioCartaPorte.servi();
            string dir = DirApp + @"\Temp\Pegatinas"; // es fundamental para el selenium que no tenga la ultima barrita? SII!!!!!
            string dirMiRepo = @"C:\Users\Mariano\Documents\";

            s.CerealnetSelenium_ConChromeHeadless(dir, dirMiRepo + @"pronto\InterfazFlexicapture\bin\Debug\", true);

            //s.CerealnetSeleniumConPhantomJS(DirApp);
        }







        [TestMethod]
        public void Tellerium_should_be_able_to_run_test_with_configuration_from_file()
        {

            string dir = DirApp + @"\Temp\Pegatinas"; // es fundamental para el selenium que no tenga la ultima barrita? SII!!!!!
            string dirMiRepo = @"C:\Users\Mariano\Documents\";
            string testExecutionPath = @"C:\Users\Mariano\Documents\pronto\TestProject2";


            //var testExecutionPath = TestContext.CurrentContext.TestDirectory;
            var browserAdapterConfig = BrowserAdapterConfig.FromAppConfig(testExecutionPath);
            using (var browser = BrowserAdapter.Create(browserAdapterConfig))
            {
                //Perform test
            }
        }












        [TestMethod]
        public void problemasPorElCambioDeNRecibo_46500()
        {

            //varios dejaron de andar porque no actualicé los modelos de LinqToSql y el del TypedDatatables

            LogicaFacturacion.LeyendaSyngenta(2343, SC);



            //        CartaDePorteManager.ListaDeLinks(lista, oCP.SubnumeroDeFacturacion)
            //MostrarLinksAFamiliaDeDuplicados




            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;
            var output2 = SincronismosWilliamsManager.GenerarSincro("BTG PACTUAL [BIT]", ref sErrores, SC, "dominio", ref sTitulo,
                                     CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                                     "", -1, -1, -1, -1,
                                     -1, -1, -1, -1,
                                     CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                                     new DateTime(2014, 1, 20), new DateTime(2014, 1, 28),
                                     -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //wCartasDePorte_TX_InformesCorregidoTableAdapter

        }
































        [TestMethod]
        public void SincroChiambretto_46876()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarVendedorPorCUIT("30-71544287-2", SC, "");
            idcli = -1;

            var output = SincronismosWilliamsManager.GenerarSincro("Chiambretto", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, idcli,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2016, 1, 13), new DateTime(2016, 1, 16),
                -1, "Ambas", false, "", "", -1, ref registrosf, 100);




            System.Diagnostics.Process.Start(output);
        }







        [TestMethod]
        public void SincroMBC_47026()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarVendedorPorCUIT("30-71544287-2", SC, "");


            var output = SincronismosWilliamsManager.GenerarSincro("MBC", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, idcli,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2017, 1, 13), new DateTime(2017, 1, 16),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);




            System.Diagnostics.Process.Start(output);
        }







        [TestMethod]
        public void numerador_recibo_a_string_46500()
        {

            var cp = CartaDePorteManager.GetItem(SC, 46464);
            cp.NRecibo = "0068989864";
            string ms = "";
            CartaDePorteManager.Save(SC, cp, 1, "", true, ref ms);

            var cp2 = CartaDePorteManager.GetItem(SC, 46464);

            Assert.IsTrue(cp2.NRecibo == "0068989864");
        }




        [TestMethod]
        public void FACTURACION_FUTUROS_Y_OPCIONES_maximo_de_renglones_28265()
        {




            /*

            Andrès, estoy facturando el corredor Futuros y Opciones, como tiene muchas descargas, deberia generar automàticamente 2 facturas, solamente genera una y sale esta leyenda:
            No se pudo crear la factura para FUTUROS Y OPCIONES .COM; Excede el máximo de renglones
            No se pudo crear la factura para FUTUROS Y OPCIONES.COM; verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no se haya disparado el error **listacdp vacia** o no haya otro cliente con el mismo nombre


    Facturas generadas  Cliente Total   IVA IBrutos1    IBrutos2 IBrutos3    Certif IIBB
    A - 0020 - 00009403 FUTUROS Y OPCIONES.COM 41003.50    7116.31 0.00    0.00    0.00

    Es con el unico corredor que todos los meses pasa lo mismo.





            Log Entry : 
    06/05/2017 11:24:15
    Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:Cartas sin automatico encontrado (pero este es el modo no automatico!!!)15
    __________________________

            __________________________

    Log Entry : 
    06/05/2017 11:24:15
    Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:entro en PostProcesos 378
    __________________________

    Log Entry : 
    06/05/2017 11:24:15
    Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:despues de EmparcharClienteSeparadoParaCasosQueSuperenUnMontoDeterminado 378
    __________________________

    Log Entry : 
    06/05/2017 11:24:15
    Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:despues de EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones 378

                __________________________

    Log Entry:
            06 / 05 / 2017 11:24:33
    Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:La factura para 13648 tiene 63 renglones y el 
            máximo es 20
            __________________________

            Log Entry:
            06 / 05 / 2017 11:24:33
    Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:No se pudo crear la 
            factura para <a href="Cliente.aspx?Id=13648" target="_blank">FUTUROS Y OPCIONES .COM</a>;  Excede el máximo 
            de renglones <br/>No se pudo crear la factura para <a href="Cliente.aspx?Id=13648" target="_blank">FUTUROS Y OPCIONES .COM</a>;  verificar IVA y CUIT, o que la carta no estuviese imputada anteriormente; Verificar que no  se haya disparado el error 'listacdp vacia' o no haya otro cliente con el mismo nombre <br/>


            */





            int idClienteAfacturarle = 13648; // futuros y opciones
            const int idcorredorFYO = 107;
            int optFacturarA = 4; //para fyo, stella usa "por corredor" (o sea, opcion 3.   1. titular/ 2 destinatario /   3.corredor  / 4 a tercero / 5 automatico)   
            bool SeEstaSeparandoPorCorredor = false;
            string agruparArticulosPor = "Destino+RComercial/Interm+Destinat(CANJE)"; // usar un agrupamiento complejo, así salen más renglones en la factura


            string txtCorredor = "";
            int idClienteObservaciones = -1;
            int PuntoVenta = 1;




            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 




            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            List<int> lista_int = new List<int>();


            // estás agregando cartas q no son facturables (por ejemplo, incompletas) que desde el frontend no se pueden agregar
            // estás agregando cartas q no son facturables (por ejemplo, incompletas) que desde el frontend no se pueden agregar
            for (int n = 2000000; n < 2000500; n++) // estás agregando cartas q no son facturables (por ejemplo, incompletas) que desde el frontend no se pueden agregar
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.Vendedor = idClienteAfacturarle;
                cp.Corredor = idcorredorFYO;
                cp.IdFacturaImputada = 0;
            }
            db.SaveChanges();

            for (int n = 2000000; n < 2000500; n++) // estás agregando cartas q no son facturables (por ejemplo, incompletas) que desde el frontend no se pueden agregar
            {
                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
                lista_int.Add(n);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;




            //var f = db.Facturas.Find(idFactura);

            //Assert.AreEqual(true, f.ImporteTotal<100);
            //Assert.AreEqual(0, f.RetencionIBrutos1);

            object primerId = 0, ultimoId = 0;

            // uso dos tickets: uno el de la grilla. el otro, de qué?
            object sesionId = 0;
            string sesionIdposta = (new Random()).Next().ToString();


            var gv = new System.Web.UI.WebControls.GridView();

            string errLog = "";
            object filas = "", slinks = "";



            //no importa las fechas, lo importante son las tildes de la grilla
            var desde = new DateTime(1900, 1, 31);
            var hasta = new DateTime(2100, 1, 31);


            System.Web.SessionState.HttpSessionState Session = null; // new System.Web.SessionState.HttpSessionState();
                                                                     //Session[SESSIONPRONTO_glbIdUsuario] = 1;





            //marcar las cartas en wGrillaPersistencia
            //lote.Select(x => x.IdCartaDePorte)
            LogicaFacturacion.GridCheckboxPersistenciaBulk(SC, sesionIdposta, lista_int);



            //DataTable tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2() // es casi un wrapper. esto lo puedo reemplazar con la llamada mas directa a GetDatatableAsignacionAutomatica


            string sLista = string.Join(",", lista_int);


            object pag = 1;
            int cuantosrenglones = 9999999;


            string txtFacturarATerceros = EntidadManager.NombreCliente(SC, idClienteAfacturarle);


            DataTable tablaEditadaDeFacturasParaGenerar = LogicaFacturacion.GetDatatableAsignacionAutomatica(
                                                     SC, ref pag, ref sesionId,
                                                   cuantosrenglones, PuntoVenta,
                                                    desde,
                                                    hasta,
                                                     sLista, "", optFacturarA, optFacturarA == 4 ? txtFacturarATerceros : ""
                                                     , SC, "", "",
                                                    "", "", "", "",
                                                    "", "", txtBuscar, "",
                                                     "", "",
                                                     0, 0, "", ref errLog,
                                                     "", agruparArticulosPor,
                                                     ref filas, ref slinks, sesionIdposta);


            // codigo de CambiarLasTarifasQueEstenEnCero()

            foreach (DataRow r in tablaEditadaDeFacturasParaGenerar.Rows)
            {
                if ((decimal)(r["TarifaFacturada"]) == 0)
                {
                    try
                    {
                        long Cli = SQLdinamico.BuscaIdClientePreciso(r["FacturarselaA"].NullSafeToString(), SC);

                        Pronto.ERP.BO.CartaDePorte ocdp = CartaDePorteManager.GetItem(SC, (int)r["idCartaDePorte"]);

                        ListaPreciosManager.SavePrecioPorCliente(SC, Cli, ocdp.IdArticulo, 1.55);
                    }
                    catch (Exception ex)
                    {
                        ErrHandler2.WriteError(ex);

                    }
                }
            }





            DataTable dtViewstateRenglonesManuales = null;



            //hay q vigilar la funcion EmparcharClienteSeparadoParaFacturasQueSuperanCantidadDeRenglones -evidentemente esa funcion solo está haciendo 2 facturas si se queda corto, pero no más.

            LogicaFacturacion.GenerarLoteFacturas_NUEVO(
                            ref tablaEditadaDeFacturasParaGenerar, SC,
                            optFacturarA, ref gv,
                            SeEstaSeparandoPorCorredor, ref Session, PuntoVenta,
                            dtViewstateRenglonesManuales, agruparArticulosPor,
                            txtBuscar, txtTarifaGastoAdministrativo, ref errLog, txtCorredor,
                            chkPagaCorredor, "", ref primerId, ref ultimoId, 0);



            //int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
            //                            dtRenglonesAgregados, SC, null, optFacturarA,
            //                         agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
            //                           txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);




        }








        [TestMethod]
        public void plantillas_por_punto_de_venta_47029()
        {

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var f = db.Facturas.Find(80500);
            f.CAE = "654646";
            db.SaveChanges();

            var f2 = db.Facturas.Find(87700);
            f2.CAE = "654646";
            db.SaveChanges();


            var output2 = CartaDePorteManager.ImprimirFacturaElectronica(80500, false, SC, DirApp);


            System.Diagnostics.Process.Start(output2);


            var output3 = CartaDePorteManager.ImprimirFacturaElectronica(87700, false, SC, DirApp);


            System.Diagnostics.Process.Start(output3);

        }









        [TestMethod]
        public void SincroAMAGGI_47023()
        {




            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-71161551-9", SC, "");


            var output2 = SincronismosWilliamsManager.GenerarSincro("AMAGGI (DESCARGAS)", ref sErrores, SC, "dominio", ref sTitulo
                          , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                       "", -1, -1,
                  idcli, -1,
                    -1, -1, -1, -1,
                   CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                  new DateTime(2017, 1, 10), new DateTime(2017, 1, 11),
                  -1, "Ambas", false, "", "", -1, ref registrosf, 4000);




            System.Diagnostics.Process.Start(output2);
        }








        [TestMethod]
        public void SincroTomasHnos_46995()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;


            //Seri posible que en la posición 45 de dicho archivo siempre venga el valor cero(0)? La idea es que los usuarios no tengan que modificar cada archivo que les llega para que no les de error al procesarlo.


            var output = SincronismosWilliamsManager.GenerarSincro("TOMAS HNOS", ref sErrores, SC, "dominio", ref sTitulo
                                 , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                      "", -1, -1,
                 -1, -1,
                 -1, -1, -1, -1,
                  CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                 new DateTime(2017, 9, 13), new DateTime(2017, 9, 13),
                 -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }











        [TestMethod]
        public void porcentajeiva_en_el_detalle_46968()
        {

            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 


            int optFacturarA = 4;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            long idClienteAfacturarle = 30446; // la celestina s.a.
            int idClienteObservaciones = -1;
            bool SeEstaSeparandoPorCorredor = true;
            int PuntoVenta = 1;

            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);




            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            // empresa (para que sea agente de percepcion)
            db.Parametros.First().PercepcionIIBB = "SI";

            // punto de venta para que perciba ingresos brutos
            //Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            //Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
            //                                "PuntosVenta", _
            //                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
            //                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            //Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            var pv = db.PuntosVentas.Where(x => x.PuntoVenta == 10).FirstOrDefault();
            pv.AgentePercepcionIIBB = "SI";


            // cliente
            var cliente = db.Clientes.Find(idClienteAfacturarle);
            // no poner. la tabla IBCondiciones ya esta relacionada a un IdProvincia. //  cliente.IdProvincia = 3; //capital
            cliente.IBCondicion = 5; //Edu, a parte de Convenio Multilateral, Jurisdiccion Local y No Alcanzado, hay que agregar No Inscripto.    usar 2 o 3    "Exento"  "Inscripto Convenio Multilateral "    "Inscripto Jurisdicción Local "  "No Alcanzado"
            cliente.IdIBCondicionPorDefecto = 10;  //en williams,  6 es  "Santa Fe Convenio Multilateral 0.7%" <-- las condiciones estan relacionadas a una provincia


            //ibcondicion
            //en la tabla IBCondiciones, q diferencia hay entre Alicuota, AlicuotaPercepcion y AlicuotaPercepcionConvenio?
            // -la primera es de retencion.
            var ibcondicion = db.IBCondiciones.Find(5);
            ibcondicion.AlicuotaPercepcion = 7;
            ibcondicion.AlicuotaPercepcionConvenio = 8;
            ibcondicion.ImporteTopeMinimoPercepcion = 10;


            db.SaveChanges();
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////





            for (int n = 1372900; n < 1372910; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;


            int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
                                                 dtRenglonesAgregados, SC, null, optFacturarA,
                                              agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                                txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);

            var f = db.Facturas.Find(idFactura);

            //Assert.AreEqual(true, f.ImporteTotal<100);
            Assert.AreEqual(0, f.RetencionIBrutos1);


            // parece que en el codigo de edu, solo se revisa el ImporteTopeMinimo cuando no es codigoprovincia 901 o 902 (capital o buenos aires)

        }






        [TestMethod]
        public void informe_resumen_de_facturacion_46943()
        {

            // En el periodo anterior sigue habiendo bnastante diferencia
            // Si filtra por "entrega", aparecen cartas en "exportacion" porque de esas familias hay "Originales" en ese modo


            ReportParameter p2 = null;

            int idcliente = 2871; //los grobo
            var desde = new DateTime(2016, 11, 1);
            var hasta = new DateTime(2017, 5, 31);
            var desdeAnt = new DateTime(2015, 11, 1); //nov
            var hastaAnt = new DateTime(2016, 5, 31); //mayo
            var pv = -1;
            var ModoExportacion = "Entregas";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas; //CartaDePorteManager.enumCDPestado.Todas;

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();





            string output2 = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams2 = new ReportParameter[20];
            yourParams2[0] = new ReportParameter("FechaDesde", desde.ToString());
            yourParams2[1] = new ReportParameter("FechaHasta", hasta.ToString());
            yourParams2[2] = new ReportParameter("FechaDesdeAnterior", desdeAnt.ToString());
            yourParams2[3] = new ReportParameter("FechaHastaAnterior", hastaAnt.ToString());
            yourParams2[4] = new ReportParameter("bMostrar1", "true");
            yourParams2[5] = new ReportParameter("bMostrar2", "true");
            yourParams2[6] = new ReportParameter("bMostrar3", "true");
            yourParams2[7] = new ReportParameter("bMostrar4", "true");
            yourParams2[8] = new ReportParameter("bMostrar5", "true");
            yourParams2[9] = new ReportParameter("idVendedor", idcliente.ToString());
            yourParams2[10] = new ReportParameter("idCorredor", "-1");
            yourParams2[11] = new ReportParameter("idDestinatario", " -1");
            yourParams2[12] = new ReportParameter("idIntermediario", idcliente.ToString());
            yourParams2[13] = new ReportParameter("idRemComercial", idcliente.ToString());
            yourParams2[14] = new ReportParameter("idArticulo", " -1");
            yourParams2[15] = new ReportParameter("idProcedencia", " -1");
            yourParams2[16] = new ReportParameter("idDestino", " -1");
            yourParams2[17] = new ReportParameter("AplicarANDuORalFiltro", CartaDePorteManager.FiltroANDOR.FiltroOR.ToString());
            yourParams2[18] = new ReportParameter("ModoExportacion", "true");
            yourParams2[19] = new ReportParameter("puntoventa", "-1");


            var s = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                      "Williams - Resumen de Totales Generales (Facturacion).rdl", yourParams2, ref output2, false);






            System.Diagnostics.Process.Start(output2);

        }











        [TestMethod]
        public void GrabarVariasSituacionesCalidad_42871()
        {


            /*

            __________________________

            Log Entry:
            11 / 15 / 2017 17:35:53
    Error in: http://iismvc/Williams/ProntoWeb/WebServiceCartas.asmx/GrabarSituaciones. Error Message:Falta elegir a qué acopio corresponde el remitente comercial


            __________________________

            Log Entry:
            11 / 15 / 2017 17:35:54
    Error in: http://iismvc/Williams/ProntoWeb/WebServiceCartas.asmx/GrabarSituaciones. Error Message:Se necesita la fecha de la descarga (porque se ingresó el peso final de la descarga)


            __________________________

            Log Entry:
            11 / 15 / 2017 17:35:56
    Error in: http://iismvc/Williams/ProntoWeb/WebServiceCartas.asmx/GrabarSituaciones. Error Message:La patente del acoplado es inválida 


            __________________________

            Log Entry:
            11 / 15 / 2017 17:35:56
    Error in: http://iismvc/Williams/ProntoWeb/WebServiceCartas.asmx/GrabarSituaciones. Error Message:La patente del acoplado es inválida 

            */



            // url: "WebServiceCartas.asmx/CartaPorteBatchUpdate",

            //string ms = CartaDePorteManager.GrabarSituacion_DLL(2638292, 2, "RECHAZADO EN PLAYA EXTERNA", SC);
            List<long> ids = new List<long>();
            for (int n = 2633332; n < 2633400; n++) ids.Add(n);
            string ms = CartaDePorteManager.GrabarSituaciones_DLL(ids.ToArray(), 2, "RECHAZADO EN PLAYA EXTERNA", SC);



            // string ms = CartaDePorteManager.GrabarSituaciones_DLL(new long[] { 2633332, 2325493, 2636664 }, 2, "RECHAZADO EN PLAYA EXTERNA", SC);

        }







        //[TestMethod]
        public void _LENTO_envioNotificacionesconMail_42871_2()
        {
            ProntoWindowsService.Service1.Initialize();
            ProntoWindowsService.Service1.DoWorkCartasPorteNuevasParaElCliente();

        }




        [TestMethod]
        public void envioNotificacionesconMail_42871_3()
        {


            ProntoWindowsService.Service1.TandaNotificacionesCamiones(SC, scbdlmasterappconfig, "1");

        }




        [TestMethod]
        public void envioNotificacionesconMail_42871()
        {

            // el envio de mails (+ push de chrome)

            // EncolarNotificaciones(ClientesQueParticipanEnCartas(ListadoDeCartasModificadas(UltimaFechaDeEnvioNotificaciones)))


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            BDLMasterEntities dbmaster = new BDLMasterEntities(Auxiliares.FormatearConexParaEntityFrameworkBDLMASTER_2(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(scbdlmasterappconfig)));
            DemoProntoEntities db = new DemoProntoEntities(scEF);


            DateTime FechaNot;
            try
            {
                FechaNot = DateTime.Parse(ParametroManager.TraerValorParametro2(SC, "UltimaFechaNotificacion").NullSafeToString());
            }
            catch (Exception)
            {
                FechaNot = DateTime.MinValue;
            }


            int dummy;

            // solo estos clientes me interesan...  -cuantos usuarios externos hay en la bdlmaster? creo q mas de mil. ademas, recordá que los usuarios especiales tipo BLD los tendrías que filtrar de otro modo...
            var q = (from p in dbmaster.UserDatosExtendidos
                     join u in dbmaster.aspnet_Users on p.UserId equals u.UserId
                     join m in dbmaster.aspnet_Membership on p.UserId equals m.UserId
                     select new { FechaNotificacion = new DateTime(), p.RazonSocial, m.Email, ListadoCuits = p.TextoAuxiliar, u.LastActivityDate }).ToList();

            var usuariosclientes = from x in q
                                   select new { IdCliente = Int32.TryParse(x.RazonSocial, out dummy) ? Int32.Parse(x.RazonSocial) : 0, x.FechaNotificacion, x.RazonSocial, x.Email, x.ListadoCuits, x.LastActivityDate };


            List<int> usus = usuariosclientes.Select(x => x.IdCliente).Where(x => x > 0).ToList();

            List<int> ususCorredores = new List<int>(); //usus.Select(x => equivalen x.IdCliente).ToList();



            DateTime FechaMinima = usuariosclientes.Select(x => x.FechaNotificacion).Max();

            // una vez que tengo la lista de clientes, como vincularla con 





            //DateTime UltimaFechaDeEnvioNotificaciones = new DateTime(2016, 8, 31);

            List<int> clientesParaNotificar = (
                    from x in db.CartasDePortes
                        //from c1 in db.Clientes.Where(c => c.IdCliente == x.Vendedor)
                        //from c2 in db.Clientes.Where(c => c.IdCliente == x.Entregador)
                    where ((x.FechaModificacion ?? x.FechaArribo) > FechaNot
                    && (usus.Contains(x.Vendedor ?? -1)
                            || usus.Contains(x.Entregador ?? -1)
                            || usus.Contains(x.CuentaOrden1 ?? -1)
                            || usus.Contains(x.CuentaOrden2 ?? -1)
                            || ususCorredores.Contains(x.Corredor ?? -1)
                        ) // pero y si el cliente ya las vio?   UltimaFechaDeLoginDelCliente
                   )
                    select new int[] { x.Vendedor ?? -1, x.Entregador ?? -1, x.CuentaOrden1 ?? -1, x.CuentaOrden2 ?? -1, x.Corredor ?? -1 }
                    )
                    .SelectMany(x => x)
                    .Distinct()
                    .Where(x => usus.Contains(x))  // porque me estoy trayendo todos los clientes de una carta que solo tiene un cliente importante, tengo que volver a filtrarlo, y es mas practico hacerlo aca
                    .ToList();





            //como hacer para incluir los de bld? como en DataTablePorCliente
            // FiltrarQueryableSegunCliente






            var listado = from k in clientesParaNotificar
                          join x in usuariosclientes on k equals x.IdCliente
                          //where  clientesParaNotificar.Contains(x.IdCliente)  fechanot
                          select x.Email;




            //string rejunte2 = string.Join(";", qq.Take(100).ToArray());
            //var listado = db.Clientes.Select(x => x.CorreosElectronicos_1).Take(100);


            string rejunte = string.Join(",", listado.ToArray());

            ErrHandler2.WriteError("Notificaciones a " + rejunte);



            if (true)
            {
                Pronto.ERP.Bll.EntidadManager.MandaEmail_Nuevo(ConfigurationManager.AppSettings["ErrorMail"],
                               "Notificación Williams",
                               "Tenés actuatalizaciones de camiones informados en http://prontoclientes.williamsentregas.com.ar",
                               ConfigurationManager.AppSettings["SmtpUser"],
                               ConfigurationManager.AppSettings["SmtpServer"],
                               ConfigurationManager.AppSettings["SmtpUser"],
                               ConfigurationManager.AppSettings["SmtpPass"],
                                "",
                               Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]), 1
                               , rejunte

                               );
            }


            // actualizar fecha de ultima notificacion de cada cliente? -Una es la fecha desde la que tengo que buscar tandas de cartas, y otra es la fecha individual de los clientes


            ParametroManager.GuardarValorParametro2(SC, "UltimaFechaNotificacion", DateTime.Now.ToString());




        }






        [TestMethod]
        public void TraerListadoSegunUsuario_42871_2()
        {
            //Creo que tarda mucho por el parameter sniffing

            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"Trigo Pan\"},{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"MAIZ\"}]}";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.CartasPorte_DynamicGridData("IdCartaDePorte", "desc", 1, 999999, true, filtro,
                                                 "01/12/2016",
                                                 "30/01/2017",
                                                 0, -1, SC, "Mariano", scbdlmasterappconfig, 11);

            // q diferencia hay con listadoclientes?
            // si el usuario tiene una razon social asignada, hay que filtrar. -Pero hay que filtrar antes! como en ListadoSegunCliente()
            // -tambien tenes el tema de los clientes con filtros configurables.... en DataTablePorClienteSQL()

        }







        [TestMethod]
        public void ServicioWebServiceDescargas_FYO_y_BLD_46746()
        {

            ////Trust all certificates
            //System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            //var cerealnet = new WS_CartasDePorteClient();

            string usuario = "Mariano"; //"fyo";
            string clave = "pirulo!"; // "76075";
            string cuit = "30703605105";

            // var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            var respEntrega = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL_v3(usuario, clave, cuit,
                                            new DateTime(2016, 1, 1),
                                            new DateTime(2017, 1, 1), CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha,
                                            SC, DirApp, scbdlmasterappconfig);


            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (CerealNet.WSCartasDePorte.analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            //Console.ReadKey();
        }






        [TestMethod]
        public void no_facturar_las_q_tienen_clientes_bloqueados_por_cobranzas_43121()
        {



            //'verificar que no haya bloqueados por cobranzas
            //'If True Then
            //'    'http://bdlconsultores.ddns.net/Consultas/Admin/VerConsultas1.php?recordid=14168
            //'    'Precisan agregar una marca en el formulario de clientes para poder bloquear la carga de estos
            //'    'en las cartas de porte debido a un conflicto de cobranzas.
            //'    'Este tilde deberán verlo solo algunos usuarios(activaremos a los de cobranzas).
            //'    'Luego, cuando quieran usarlo en una carta de porte el sistema tiene que dar un mensaje de advertencia diciendo
            //'    'que el usuario no se puede utilizar y que tiene que ponerse en contacto con el sector de cobranzas.
            //'    'La carta de porte no se puede grabar si tiene un cliente en esta condición.


            //'    Dim sClientesCobranzas As String
            //'    If UsaClientesQueEstanBloqueadosPorCobranzas(SC, myCartaDePorte, sClientesCobranzas) Then
            //'        MS &= "Cliente bloqueado. Ponerse en contacto con el sector de cobranzas (" & sClientesCobranzas & ") "
            //'        MS &= vbCrLf   'return false
            //'    End If
            //'End If


            // edu solo tuvo q modificar el form de cliente, y con eso a andy le bastó para que la factura hecha por Pronto hiciese la percepcion, pero
            // por web no le percibe.







            long idClienteAfacturarle = 13648; // futuros y opciones
            int optFacturarA = 4; //para fyo, stella usa "por corredor" (o sea, opcion 3.   1. titular/ 2 destinatario /   3.corredor  / 4 a tercero / 5 automatico)   
            bool SeEstaSeparandoPorCorredor = false;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            int idClienteObservaciones = -1;
            int PuntoVenta = 1;




            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 





            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);






            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            // empresa (para que sea agente de percepcion)
            db.Parametros.First().PercepcionIIBB = "SI";

            // punto de venta para que perciba ingresos brutos
            //Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            //Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
            //                                "PuntosVenta", _
            //                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
            //                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            //Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            var pv = db.PuntosVentas.Where(x => x.PuntoVenta == 10).FirstOrDefault();
            pv.AgentePercepcionIIBB = "SI";


            // cliente
            var cliente = db.Clientes.Find(idClienteAfacturarle);
            // no poner. la tabla IBCondiciones ya esta relacionada a un IdProvincia. //  cliente.IdProvincia = 3; //capital
            cliente.IBCondicion = 5; //Edu, a parte de Convenio Multilateral, Jurisdiccion Local y No Alcanzado, hay que agregar No Inscripto.    usar 2 o 3    "Exento"  "Inscripto Convenio Multilateral "    "Inscripto Jurisdicción Local "  "No Alcanzado"
            cliente.IdIBCondicionPorDefecto = 10;  //en williams,  6 es  "Santa Fe Convenio Multilateral 0.7%" <-- las condiciones estan relacionadas a una provincia


            //ibcondicion
            //en la tabla IBCondiciones, q diferencia hay entre Alicuota, AlicuotaPercepcion y AlicuotaPercepcionConvenio?
            // -la primera es de retencion.
            var ibcondicion = db.IBCondiciones.Find(5);
            ibcondicion.AlicuotaPercepcion = 7;
            ibcondicion.AlicuotaPercepcionConvenio = 8;
            ibcondicion.ImporteTopeMinimoPercepcion = 10;


            db.SaveChanges();
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////






            List<int> lista_int = new List<int>();



            for (int n = 1372900; n < 1372905; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                //CartaDePorteManager.Save(SC, c, 2, "", false, ref ms); // ahora la grabo a traves del EF

                lote.Add(c);
                lista_int.Add(n);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;




            //var f = db.Facturas.Find(idFactura);

            //Assert.AreEqual(true, f.ImporteTotal<100);
            //Assert.AreEqual(0, f.RetencionIBrutos1);

            object primerId = 0, ultimoId = 0;

            // uso dos tickets: uno el de la grilla. el otro, de qué?
            object sesionId = 0;
            string sesionIdposta = (new Random()).Next().ToString();


            var gv = new System.Web.UI.WebControls.GridView();

            string errLog = "";
            object filas = "", slinks = "";



            //no importa las fechas, lo importante son las tildes de la grilla
            var desde = new DateTime(1900, 1, 31);
            var hasta = new DateTime(2100, 1, 31);


            System.Web.SessionState.HttpSessionState Session = null; // new System.Web.SessionState.HttpSessionState();




            //marcar las cartas en wGrillaPersistencia
            //lote.Select(x => x.IdCartaDePorte)
            LogicaFacturacion.GridCheckboxPersistenciaBulk(SC, sesionIdposta, lista_int);



            //DataTable tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2() // es casi un wrapper. esto lo puedo reemplazar con la llamada mas directa a GetDatatableAsignacionAutomatica


            string sLista = string.Join(",", lista_int);


            object pag = 1;
            int cuantosrenglones = 9999999;



            string txtFacturarATerceros = EntidadManager.NombreCliente(SC, idClienteAfacturarle);


            DataTable tablaEditadaDeFacturasParaGenerar = LogicaFacturacion.GetDatatableAsignacionAutomatica(
                                                     SC, ref pag, ref sesionId,
                                                   cuantosrenglones, PuntoVenta,
                                                    desde,
                                                    hasta,
                                                     sLista, "", optFacturarA, txtFacturarATerceros
                                                     , SC, "", "",
                                                    "", "", "", "",
                                                    "", "", txtBuscar, "",
                                                     "", "",
                                                     0, 0, "", ref errLog,
                                                     "", agruparArticulosPor,
                                                     ref filas, ref slinks, sesionIdposta);



            // codigo de CambiarLasTarifasQueEstenEnCero()

            foreach (DataRow r in tablaEditadaDeFacturasParaGenerar.Rows)
            {
                if ((decimal)(r["TarifaFacturada"]) == 0)
                {
                    try
                    {
                        long Cli = SQLdinamico.BuscaIdClientePreciso(r["FacturarselaA"].NullSafeToString(), SC);

                        Pronto.ERP.BO.CartaDePorte ocdp = CartaDePorteManager.GetItem(SC, (int)r["idCartaDePorte"]);

                        ListaPreciosManager.SavePrecioPorCliente(SC, Cli, ocdp.IdArticulo, 1.55);
                    }
                    catch (Exception ex)
                    {
                        ErrHandler2.WriteError(ex);

                    }
                }
            }





            string sError = "";
            LogicaFacturacion.ValidaCobranzas(ref tablaEditadaDeFacturasParaGenerar, ref sError);

        }









        [TestMethod]
        public void SincroTerraVerde_46499()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarVendedorPorCUIT("30 -71544287-2", SC, "");


            var output = SincronismosWilliamsManager.GenerarSincro("Terra Verde", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, idcli,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2017, 1, 13), new DateTime(2017, 1, 16),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);





            //            Estamos desarrollando el sincro de Terra Verde con la gente de BIT.
            //Te paso errores que nos pidieron modificar, el sincro que le pasamos como ejemplo fue el de BTG(Engelhart).

            //Te lo reenvie por correo tambien:



            //Hola Tomas, necesito que hagamos la siguiente corrección en la generación del archivo TXT, dado a que no nos están ingresando correctamente los movimientos.
            //El problema se nos da en los siguientes puntos:

            //            CAMPO CALIDAD: Posición en el txt 940 - 943
            //o Si es de Camara = CC
            //o Si es condición calidad grado = G1 – G2 o G3
            //o Si es Fuera de Standart = FE


            //CAMPO VENDEDOR: Posición en el txt 263 - 276
            //El CUIT del vendedor, depende de la posición en la cual este el CUIT de TERRA VERDE.
            //SI TERRA VERDE esta en remitente Comercial:
            //§ Debe enviar el Titular, si hay intermediario, debe enviar el intermediario.
            //SI TERRA VERDE esta como Intermediario:
            //§ Se debe enviar como vendedor el titular.
            //CAMPO COMPRADOR: Posición en el txt 131 - 144
            //o SI TERRA VERDE esta en remitente Comercial:
            //§ Se debe enviar como comprador el destinatario.
            //o SI TERRA VERDE Intermediario:
            //§ Se debe enviar como comprador el Remitente Comercial.

            //O sea que para el siguiente caso:
            //            Vendedor = “CUIT DE ELLIFF”
            //Comprador = “CUIT CARGILL”








            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }









        [TestMethod]
        public void percepcion_en_clientes_46551_2_directamente_llamando_a_creafacturacompronto()
        {

            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 


            int optFacturarA = 4;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            long idClienteAfacturarle = 30446; // la celestina s.a.
            int idClienteObservaciones = -1;
            bool SeEstaSeparandoPorCorredor = true;
            int PuntoVenta = 1;

            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);




            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            // empresa (para que sea agente de percepcion)
            db.Parametros.First().PercepcionIIBB = "SI";

            // punto de venta para que perciba ingresos brutos
            //Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            //Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
            //                                "PuntosVenta", _
            //                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
            //                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            //Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            var pv = db.PuntosVentas.Where(x => x.PuntoVenta == 10).FirstOrDefault();
            pv.AgentePercepcionIIBB = "SI";


            // cliente
            var cliente = db.Clientes.Find(idClienteAfacturarle);
            // no poner. la tabla IBCondiciones ya esta relacionada a un IdProvincia. //  cliente.IdProvincia = 3; //capital
            cliente.IBCondicion = 5; //Edu, a parte de Convenio Multilateral, Jurisdiccion Local y No Alcanzado, hay que agregar No Inscripto.    usar 2 o 3    "Exento"  "Inscripto Convenio Multilateral "    "Inscripto Jurisdicción Local "  "No Alcanzado"
            cliente.IdIBCondicionPorDefecto = 10;  //en williams,  6 es  "Santa Fe Convenio Multilateral 0.7%" <-- las condiciones estan relacionadas a una provincia


            //ibcondicion
            //en la tabla IBCondiciones, q diferencia hay entre Alicuota, AlicuotaPercepcion y AlicuotaPercepcionConvenio?
            // -la primera es de retencion.
            var ibcondicion = db.IBCondiciones.Find(5);
            ibcondicion.AlicuotaPercepcion = 7;
            ibcondicion.AlicuotaPercepcionConvenio = 8;
            ibcondicion.ImporteTopeMinimoPercepcion = 10;


            db.SaveChanges();
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////





            for (int n = 1372900; n < 1372910; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;


            int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
                                                 dtRenglonesAgregados, SC, null, optFacturarA,
                                              agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                                txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);

            var f = db.Facturas.Find(idFactura);

            //Assert.AreEqual(true, f.ImporteTotal<100);
            Assert.AreEqual(0, f.RetencionIBrutos1);


            // parece que en el codigo de edu, solo se revisa el ImporteTopeMinimo cuando no es codigoprovincia 901 o 902 (capital o buenos aires)

        }







        [TestMethod]
        public void percepcion_en_clientes_con_46551()
        {
            // edu solo tuvo q modificar el form de cliente, y con eso a andy le bastó para que la factura hecha por Pronto hiciese la percepcion, pero
            // por web no le percibe.







            long idClienteAfacturarle = 13648; // futuros y opciones
            int optFacturarA = 4; //para fyo, stella usa "por corredor" (o sea, opcion 3.   1. titular/ 2 destinatario /   3.corredor  / 4 a tercero / 5 automatico)   
            bool SeEstaSeparandoPorCorredor = false;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            int idClienteObservaciones = -1;
            int PuntoVenta = 1;




            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 





            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);






            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            // empresa (para que sea agente de percepcion)
            db.Parametros.First().PercepcionIIBB = "SI";

            // punto de venta para que perciba ingresos brutos
            //Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            //Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
            //                                "PuntosVenta", _
            //                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
            //                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            //Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            var pv = db.PuntosVentas.Where(x => x.PuntoVenta == 10).FirstOrDefault();
            pv.AgentePercepcionIIBB = "SI";


            // cliente
            var cliente = db.Clientes.Find(idClienteAfacturarle);
            // no poner. la tabla IBCondiciones ya esta relacionada a un IdProvincia. //  cliente.IdProvincia = 3; //capital
            cliente.IBCondicion = 5; //Edu, a parte de Convenio Multilateral, Jurisdiccion Local y No Alcanzado, hay que agregar No Inscripto.    usar 2 o 3    "Exento"  "Inscripto Convenio Multilateral "    "Inscripto Jurisdicción Local "  "No Alcanzado"
            cliente.IdIBCondicionPorDefecto = 10;  //en williams,  6 es  "Santa Fe Convenio Multilateral 0.7%" <-- las condiciones estan relacionadas a una provincia


            //ibcondicion
            //en la tabla IBCondiciones, q diferencia hay entre Alicuota, AlicuotaPercepcion y AlicuotaPercepcionConvenio?
            // -la primera es de retencion.
            var ibcondicion = db.IBCondiciones.Find(5);
            ibcondicion.AlicuotaPercepcion = 7;
            ibcondicion.AlicuotaPercepcionConvenio = 8;
            ibcondicion.ImporteTopeMinimoPercepcion = 10;


            db.SaveChanges();
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////






            List<int> lista_int = new List<int>();



            for (int n = 1372900; n < 1372905; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                //CartaDePorteManager.Save(SC, c, 2, "", false, ref ms); // ahora la grabo a traves del EF

                lote.Add(c);
                lista_int.Add(n);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;




            //var f = db.Facturas.Find(idFactura);

            //Assert.AreEqual(true, f.ImporteTotal<100);
            //Assert.AreEqual(0, f.RetencionIBrutos1);

            object primerId = 0, ultimoId = 0;

            // uso dos tickets: uno el de la grilla. el otro, de qué?
            object sesionId = 0;
            string sesionIdposta = (new Random()).Next().ToString();


            var gv = new System.Web.UI.WebControls.GridView();

            string errLog = "";
            object filas = "", slinks = "";



            //no importa las fechas, lo importante son las tildes de la grilla
            var desde = new DateTime(1900, 1, 31);
            var hasta = new DateTime(2100, 1, 31);


            System.Web.SessionState.HttpSessionState Session = null; // new System.Web.SessionState.HttpSessionState();




            //marcar las cartas en wGrillaPersistencia
            //lote.Select(x => x.IdCartaDePorte)
            LogicaFacturacion.GridCheckboxPersistenciaBulk(SC, sesionIdposta, lista_int);



            //DataTable tablaEditadaDeFacturasParaGenerar = dtDatasourcePaso2() // es casi un wrapper. esto lo puedo reemplazar con la llamada mas directa a GetDatatableAsignacionAutomatica


            string sLista = string.Join(",", lista_int);


            object pag = 1;
            int cuantosrenglones = 9999999;



            string txtFacturarATerceros = EntidadManager.NombreCliente(SC, idClienteAfacturarle);


            DataTable tablaEditadaDeFacturasParaGenerar = LogicaFacturacion.GetDatatableAsignacionAutomatica(
                                                     SC, ref pag, ref sesionId,
                                                   cuantosrenglones, PuntoVenta,
                                                    desde,
                                                    hasta,
                                                     sLista, "", optFacturarA, txtFacturarATerceros
                                                     , SC, "", "",
                                                    "", "", "", "",
                                                    "", "", txtBuscar, "",
                                                     "", "",
                                                     0, 0, "", ref errLog,
                                                     "", agruparArticulosPor,
                                                     ref filas, ref slinks, sesionIdposta);



            // codigo de CambiarLasTarifasQueEstenEnCero()

            foreach (DataRow r in tablaEditadaDeFacturasParaGenerar.Rows)
            {
                if ((decimal)(r["TarifaFacturada"]) == 0)
                {
                    try
                    {
                        long Cli = SQLdinamico.BuscaIdClientePreciso(r["FacturarselaA"].NullSafeToString(), SC);

                        Pronto.ERP.BO.CartaDePorte ocdp = CartaDePorteManager.GetItem(SC, (int)r["idCartaDePorte"]);

                        ListaPreciosManager.SavePrecioPorCliente(SC, Cli, ocdp.IdArticulo, 1.55);
                    }
                    catch (Exception ex)
                    {
                        ErrHandler2.WriteError(ex);

                    }
                }
            }





            DataTable dtViewstateRenglonesManuales = null;



            LogicaFacturacion.GenerarLoteFacturas_NUEVO(
                            ref tablaEditadaDeFacturasParaGenerar, SC,
                            optFacturarA, ref gv,
                            SeEstaSeparandoPorCorredor, ref Session, PuntoVenta,
                            dtViewstateRenglonesManuales, agruparArticulosPor,
                            txtBuscar, txtTarifaGastoAdministrativo, ref errLog, txtCorredor,
                            chkPagaCorredor, "", ref primerId, ref ultimoId, 0);



            //int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
            //                            dtRenglonesAgregados, SC, null, optFacturarA,
            //                         agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
            //                           txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);




        }















        [TestMethod]
        public void liquidacionsubcon_46735_13216()
        {

            /*

            Te tenemos que pedir que cuando se carguen camiones de SYNGENTA y se coloque en la solapa de entregador a otro, para lo que es la liquidacion del subcomisionista tome esa cp como elevacion.

            Solo tiene que afectar a eso. No tiene que afectar al envio de descarga al cliente y vista de la cp en nuetro sistema.

            En titular / intermediario / remitnte / cliente observ.

            */

            var cliente = SQLdinamico.BuscaIdClientePreciso("SYNGENTA AGRO S.A.", SC);



            if (false)
            {

                var s = new ServicioCartaPorte.servi();
                var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
                DemoProntoEntities db = new DemoProntoEntities(scEF);


                var q1 = db.WilliamsDestinos.Where(x => x.Subcontratista1 == 10947 || x.Subcontratista2 == 10947).FirstOrDefault(); // ramirez jose luis
                q1.Subcontratista1 = 10947;
                q1.Subcontratista2 = 10947;

                var q2 = db.ListasPreciosDetalles.Where(x => x.ListasPrecio.Descripcion == "RAMIREZ JOSE LUIS - Precios").ToList(); // ramirez jose luis
                foreach (Data.Models.ListasPreciosDetalle ps in q2)
                {
                    ps.PrecioComboCaladaMasBalanza = 55;
                }

                db.SaveChanges();

            }







            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2017, 6, 1),
                        new DateTime(2017, 7, 31),
                        0, cliente, ref sTitulo);



            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }














        [TestMethod]
        public void InformeControlDiario_42972_AKA_estadisticas_de_descargas_GrillaExportacion()
        {

            //            Filtros:

            //* Fecha Buque
            //* Cliente Facturado
            //* Producto
            //* Punto de Venta

            //Columnas:
            //Las mismas que tiene el listado actual y agregar:


            //* Factura
            //* Fecha Factura


            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
            string output = @"C:\Users\Mariano\Downloads\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();


            var m = db.CartasPorteMovimientos.First().IdCDPMovimiento;



            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.ControlesDiarios_DynamicGridData_ExcelExportacion_UsandoInternalQuery(SC, "Fecha", "desc", 1, 999999, true, filtro, "", "", 0, 0, "");

            // la internalQuery no me está trayendo la descripcion del destino (para la exportacion de movimientos estabas usando una view...)

            CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal, "Carta Porte - ControlesDiarios.rdl", sqlquery4, SC, false, ref output);


            System.Diagnostics.Process.Start(output);
        }





        [TestMethod]
        public void InformeControlDiario_42972_AKA_estadisticas_de_descargas()
        {


            //wCartasDePorteControlDescargas_TX_InformeControlDiario


            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";
            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter[] yourParams = new ReportParameter[6];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("sServidorWeb", ConfigurationManager.AppSettings["UrlDominio"]);
            yourParams[2] = new ReportParameter("FechaDesde", new DateTime(2016, 7, 1).ToString());
            yourParams[3] = new ReportParameter("FechaHasta", new DateTime(2016, 10, 30).ToString());
            yourParams[4] = new ReportParameter("IdDestino", "-1");
            yourParams[5] = new ReportParameter("IdPuntoVenta", "0");
            //yourParams[7] = new ReportParameter("Consulta", strSQL);


            var output2 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                "Williams - Controles Diarios.rdl", yourParams, ref ArchivoExcelDestino, false);

            System.Diagnostics.Process.Start(output2);
        }





        [TestMethod]
        public void listado_con_tipo_de_movimiento_42551_reportviewerylosupdatepanels()
        {

            //'acá (pagina CartaDePorteInformesConReportViewerSincronismos) la pagina tiene 3 updatepanels separados.
            //'en cambio, en la pagina de clientes (CartaDePorteInformesAccesoClientes), donde el informe servidor funciona, el updatepanel de filtros esta metido en otro que contiene al informe.
            //-por ahora no lo pude resolver porq no tengo tiempo


            string usuario = "DIAZDOW";
            var rs = ""; // se usa como "QueContenga"
            var desde = new DateTime(2017, 1, 1);
            var hasta = new DateTime(2017, 1, 31);
            var estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas;


            var idVendedor = -1;
            var idCorredor = SQLdinamico.BuscaIdVendedorPreciso(rs, SC);
            var idDestinatario = -1;
            var idIntermediario = -1;
            var idRComercial = -1;
            var idArticulo = -1;
            var idProcedencia = -1;
            var idDestino = -1;



            string sql = CartaDePorteManager.DataTablePorClienteSQL(SC, "", "", "", 0, 9999999,
                                estadofiltro, rs, idVendedor, idCorredor,
                               idDestinatario, idIntermediario,
                               idRComercial, idArticulo, idProcedencia, idDestino
                                , 0, "Ambas"
                                , desde, hasta,
                                0, "", usuario, scbdlmasterappconfig, true, true, true, false, false, false);




            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
            string output = @"C:\Users\Mariano\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams = new ReportParameter[10];
            yourParams[0] = new ReportParameter("webservice", "");
            yourParams[1] = new ReportParameter("sServidor", "");
            yourParams[2] = new ReportParameter("idArticulo", "-1");
            yourParams[3] = new ReportParameter("idDestino", "-1");
            yourParams[4] = new ReportParameter("desde", desde.ToString());
            yourParams[5] = new ReportParameter("hasta", hasta.ToString());
            yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
            yourParams[7] = new ReportParameter("Consulta", sql);
            yourParams[8] = new ReportParameter("sServidorSQL", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[9] = new ReportParameter("titulo", "ghkj");
            string sss = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                        @"Listado general de Cartas de Porte (simulando original) - Con tipo de movimiento.rdl", yourParams, ref output, false);



            System.Diagnostics.Process.Start(output);

        }
















        [TestMethod]
        public void envioNotificacionesconPush_42871()
        {
            // pasos 
            // 1- el usuario cliente se conecta al FCM, se suscribe y obtiene un registration_id 
            // 2- el usuario cliente se conecta al IIS y le manda el registration_id que obtuvo, para que el IIS los hermane



            /*
            https://developers.google.com/web/ilt/pwa/introduction-to-push-notifications
            We can test push messaging in our app using cURL. We can send an empty message, called a "tickle", 
                to the push service, then the push service sends a message to the browser.If the notification displays, then we 
                have done everything correctly and our app is ready to push messages from the server.

    The cURL command that sends a request to FCM to issue a push message looks like this:

    curl "ENDPOINT_URL" --request POST --header "TTL: 60" --header "Content-Length: 0" \
    --header "Authorization: key=SERVER_KEY"



                https://gauntface.github.io/simple-push-demo/
                constants.js y manifest.json
    */



            // https://stackoverflow.com/questions/39362446/how-to-implement-fcm-in-asp-net-c
            //https://stackoverflow.com/questions/38184432/fcm-firebase-cloud-messaging-push-notification-with-asp-net


        }





        [TestMethod]
        public void TraerListadoSegunUsuario_42871()
        {

            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"Trigo Pan\"},{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"MAIZ\"}]}";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.CartasPorte_DynamicGridData("IdCartaDePorte", "desc", 1, 999999, true, filtro,
                                                 "01/12/2016",
                                                 "30/01/2017",
                                                 0, -1, SC, "Mariano", scbdlmasterappconfig, 11);

            // q diferencia hay con listadoclientes?
            // si el usuario tiene una razon social asignada, hay que filtrar. -Pero hay que filtrar antes! como en ListadoSegunCliente()
            // -tambien tenes el tema de los clientes con filtros configurables.... en DataTablePorClienteSQL()

        }















        [TestMethod]
        public void SincroACA_45332()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarVendedorPorCUIT("30-50012088-2", SC, "");


            var output = SincronismosWilliamsManager.GenerarSincro("A.C.A.", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, idcli,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2017, 1, 13), new DateTime(2017, 1, 16),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);


            //            FB = FUERA DE BASE
            //FE = FUERA DE STANDAR

            //Buenas tares, nosotros necesitamos lo siguiente

            //Que el FB Y el FE venga informado como FE, sin discriminar grano




            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }








        [TestMethod]
        public void SincroTomasHnos_43179()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("TOMAS HNOS", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2017, 9, 13), new DateTime(2017, 9, 13),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }











        [TestMethod]
        public void SincroAMAGGI_45323()
        {




            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-71161551-9", SC, "");


            var output2 = SincronismosWilliamsManager.GenerarSincro("AMAGGI (DESCARGAS)", ref sErrores, SC, "dominio", ref sTitulo
                          , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                       "", -1, -1,
                  idcli, -1,
                    -1, -1, -1, -1,
                   CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                  new DateTime(2017, 1, 10), new DateTime(2017, 1, 15),
                  -1, "Ambas", false, "", "", -1, ref registrosf, 4000);




            System.Diagnostics.Process.Start(output2);
        }








        [TestMethod]
        public void FormatoNuevo_Grobo_Recibo_45281_2_cresud()
        {


            //-Les acabo de pasar correo con la solicitud del cliente nuevo SPEEDAGRO para que en el exel de descargas que pasa el sistema, salga el cuit a su lado titular, intermediario, rem comercial, corredor, transporte, chofer, etc, etc
            //    -Martín,Lo que deben hacer es cuando arman el mail de Speedagro, elegir el formato "Excel GroboCuits" que es el formato que se está usando con Grobocopatel.
            //    -Andres, ahi me hace la devolucion SpeedAgro, y estarian faltando los cuit del destinatario y corredor. Resto estaria ok.Podes avanzar con esto ? Abrazo Martin

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2017, 9, 11);
            var fechahasta = new DateTime(2017, 9, 13);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();



            //falta migrar a servidor:
            //grobo y recibo        GrbRec
            //grobo                 Grobo
            //cresud                Cresud
            //multigrain            Grain
            //recibo                ExcRec
            //corredores            Corred


            dr["ModoImpresion"] = "Cresud";
            //dr["ModoImpresion"] = "Grobo";
            //dr["ModoImpresion"] = "Grobo";
            //dr["ModoImpresion"] = "Excel";
            //dr["ModoImpresion"] = "HImag2";
            //dr["ModoImpresion"] = "ExcHtm";
            //dr["ModoImpresion"] = "Imagen";


            dr["Emails"] = "mscalella911@gmail.com";


            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.Todas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }





        [TestMethod]
        public void FormatoNuevo_Grobo_Recibo_45281()
        {


            //-Les acabo de pasar correo con la solicitud del cliente nuevo SPEEDAGRO para que en el exel de descargas que pasa el sistema, salga el cuit a su lado titular, intermediario, rem comercial, corredor, transporte, chofer, etc, etc
            //    -Martín,Lo que deben hacer es cuando arman el mail de Speedagro, elegir el formato "Excel GroboCuits" que es el formato que se está usando con Grobocopatel.
            //    -Andres, ahi me hace la devolucion SpeedAgro, y estarian faltando los cuit del destinatario y corredor. Resto estaria ok.Podes avanzar con esto ? Abrazo Martin

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2017, 9, 11);
            var fechahasta = new DateTime(2017, 9, 13);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();



            //falta migrar a servidor:
            //grobo y recibo        GrbRec
            //grobo                 Grobo
            //cresud                Cresud
            //multigrain            Grain
            //recibo                ExcRec
            //corredores            Corred


            dr["ModoImpresion"] = "GrbRec";
            //dr["ModoImpresion"] = "Grobo";
            //dr["ModoImpresion"] = "Grobo";
            //dr["ModoImpresion"] = "Excel";
            //dr["ModoImpresion"] = "HImag2";
            //dr["ModoImpresion"] = "ExcHtm";
            //dr["ModoImpresion"] = "Imagen";


            dr["Emails"] = "mscalella911@gmail.com";


            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.Todas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }




        [TestMethod]
        public void FormatoNuevo_42771_2_formatos_pendientessssssssssssssss()
        {


            //-Les acabo de pasar correo con la solicitud del cliente nuevo SPEEDAGRO para que en el exel de descargas que pasa el sistema, salga el cuit a su lado titular, intermediario, rem comercial, corredor, transporte, chofer, etc, etc
            //    -Martín,Lo que deben hacer es cuando arman el mail de Speedagro, elegir el formato "Excel GroboCuits" que es el formato que se está usando con Grobocopatel.
            //    -Andres, ahi me hace la devolucion SpeedAgro, y estarian faltando los cuit del destinatario y corredor. Resto estaria ok.Podes avanzar con esto ? Abrazo Martin

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();



            //falta migrar a servidor:
            //grobo
            //cresud
            //multigrain
            //recibo
            //corredores



            dr["ModoImpresion"] = "Grobo";
            //dr["ModoImpresion"] = "Excel";
            //dr["ModoImpresion"] = "HImag2";
            //dr["ModoImpresion"] = "ExcHtm";
            //dr["ModoImpresion"] = "Imagen";


            dr["Emails"] = "mscalella911@gmail.com";


            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }





        [TestMethod]
        public void FormatoNuevo_42771()
        {


            //-Les acabo de pasar correo con la solicitud del cliente nuevo SPEEDAGRO para que en el exel de descargas que pasa el sistema, salga el cuit a su lado titular, intermediario, rem comercial, corredor, transporte, chofer, etc, etc
            //    -Martín,Lo que deben hacer es cuando arman el mail de Speedagro, elegir el formato "Excel GroboCuits" que es el formato que se está usando con Grobocopatel.
            //    -Andres, ahi me hace la devolucion SpeedAgro, y estarian faltando los cuit del destinatario y corredor. Resto estaria ok.Podes avanzar con esto ? Abrazo Martin

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            dr["ModoImpresion"] = "Speed"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
                                           //dr["ModoImpresion"] = "ExcHc";
                                           //dr["ModoImpresion"] = "HtmlIm";

            dr["Emails"] = "mscalella911@gmail.com";


            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }










        [TestMethod]
        public void Se_pisan_las_observaciones_en_el_robot_43069()
        {
            string archivoExcel = @"C:\bdl\pronto\docstest\New folder\Posicion-170809-0850.xls";

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");



        }



        [TestMethod]
        public void ServicioWebDescargas_43031()
        {

            ////Trust all certificates
            //System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            //var cerealnet = new WS_CartasDePorteClient();

            string usuario = "Mariano"; //"fyo";
            string clave = "pirulo!"; // "76075";
            string cuit = "30703605105";

            // var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            var respEntrega = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL_v3(usuario, clave, cuit,
                                            new DateTime(2016, 1, 1),
                                            new DateTime(2017, 1, 1), CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha,
                                            SC, DirApp, scbdlmasterappconfig);


            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (CerealNet.WSCartasDePorte.analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            //Console.ReadKey();
        }




        [TestMethod]
        public void listado_especial_para_diaz_riganti_43183()
        {



            string usuario = "DIAZDOW";
            var rs = ""; // se usa como "QueContenga"
            var desde = new DateTime(2017, 1, 1);
            var hasta = new DateTime(2017, 1, 31);
            var estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas;


            var idVendedor = -1;
            var idCorredor = SQLdinamico.BuscaIdVendedorPreciso(rs, SC);
            var idDestinatario = -1;
            var idIntermediario = -1;
            var idRComercial = -1;
            var idArticulo = -1;
            var idProcedencia = -1;
            var idDestino = -1;





            string sql = CartaDePorteManager.DataTablePorClienteSQL(SC, "", "", "", 0, 9999999,
                                estadofiltro, rs, idVendedor, idCorredor,
                               idDestinatario, idIntermediario,
                               idRComercial, idArticulo, idProcedencia, idDestino
                                , 0, "Ambas"
                                , desde, hasta,
                                0, "", usuario, scbdlmasterappconfig, true, true, true, false, false, false);




            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
            string output = @"C:\Users\Mariano\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams = new ReportParameter[10];
            yourParams[0] = new ReportParameter("webservice", "");
            yourParams[1] = new ReportParameter("sServidor", "");
            yourParams[2] = new ReportParameter("idArticulo", "-1");
            yourParams[3] = new ReportParameter("idDestino", "-1");
            yourParams[4] = new ReportParameter("desde", desde.ToString());
            yourParams[5] = new ReportParameter("hasta", hasta.ToString());
            yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
            yourParams[7] = new ReportParameter("Consulta", sql);
            yourParams[8] = new ReportParameter("sServidorSQL", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[9] = new ReportParameter("titulo", "ghkj");
            string sss = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                        @"Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, ref output, false);



            System.Diagnostics.Process.Start(output);

        }








        [TestMethod]
        public void CampoEditableDeClientesRelacionadosAlUsuarioParaTirarInforme_28320_42549()
        {

            //probar fyo con mi usuario
            //o hago top, o un select mas angosto, o un filtro de fecha


            //probe con coma, pipe, punto y coma y nunca me funciona. ese usuario el 1/6 debería traer 
            //la cp 561439022 que es de JACIUK EUGENIO FELIPE 20-08494702-5 (titular)

            //Acá, mismo usuario, password y cuits, probando en Enero, debería traer la CP 558600767, donde 20 - 08494702 - 5(JACIUK EUGENIO FELIPE) es titular

            //string usuario = "RODRIGORIOS"; 
            string usuario = "Mariano";
            var rs = "FUTUROS Y OPCIONES .COM";
            var desde = new DateTime(2017, 1, 1);
            var hasta = new DateTime(2017, 1, 31);
            var estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas;


            var idVendedor = -1;
            var idCorredor = SQLdinamico.BuscaIdVendedorPreciso(rs, SC);
            var idDestinatario = -1;
            var idIntermediario = -1;
            var idRComercial = -1;
            var idArticulo = -1;
            var idProcedencia = -1;
            var idDestino = -1;






            string sql = CartaDePorteManager.DataTablePorClienteSQL(SC, "", "", "", 0, 9999999,
                                estadofiltro, rs, idVendedor, idCorredor,
                               idDestinatario, idIntermediario,
                               idRComercial, idArticulo, idProcedencia, idDestino
                                , 0, "Ambas"
                                , desde, hasta,
                                0, "", usuario, scbdlmasterappconfig, true, true, true, false, false, false);





            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
            string output = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams = new ReportParameter[10];
            yourParams[0] = new ReportParameter("webservice", "");
            yourParams[1] = new ReportParameter("sServidor", "");
            yourParams[2] = new ReportParameter("idArticulo", "-1");
            yourParams[3] = new ReportParameter("idDestino", "-1");
            yourParams[4] = new ReportParameter("desde", desde.ToString());
            yourParams[5] = new ReportParameter("hasta", hasta.ToString());
            yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
            yourParams[7] = new ReportParameter("Consulta", sql);
            yourParams[8] = new ReportParameter("sServidorSQL", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[9] = new ReportParameter("titulo", "ghkj");
            string sss = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                        @"Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, ref output, false);



            System.Diagnostics.Process.Start(output);



            if (false)
            {
                string sErrores = "", sTitulo = "";
                LinqCartasPorteDataContext db = null;
                DemoProntoEntities db2 = null;


                //UserDatosExtendidosManager.UpdateClientesRelacionadoslDelUsuario(usuario, scbdlmasterappconfig, "20-12345678-1|20-20100767-5");


                //cuando decide si usa CartaDePorteInformesAccesoClientes o CartaDePorteInformesAccesoClientesBLDcorredor? 
                //-con CartaDePorteManager.EsClienteBLDcorredor(HFSC.Value)
                //bueno, esto funciona. O sea que falla esa derivacion? -pero la pagina "..BLDCorredor" usa el filtro de corredor BLD  -y si se lo sacas?

                var b = CartaDePorteManager.usuariosBLD(SC).Contains(usuario);

                var clientes = CartaDePorteManager.TraerCUITClientesSegunUsuario(usuario, SC, scbdlmasterappconfig).Where(x => x != "").ToList();


                var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC,
                         "", "", "", 1, 99999,
                          CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                         -1, -1,
                         -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                          desde,
                          hasta,
                          -1, ref sTitulo, "Ambas", false, "", ref db2, "", -1, -1, 0, "", "Ambas");


                var q2 = q.Where(x => clientes.Contains(x.TitularCUIT) || clientes.Contains(x.IntermediarioCUIT) || clientes.Contains(x.RComercialCUIT))
                                        .ToList();

                var q3 = q2.Select(x => x.NumeroCartaDePorte).ToList();

                Assert.IsTrue(q3.Contains(558600767));







                System.Data.Entity.Core.Objects.ObjectQuery oq = (System.Data.Entity.Core.Objects.ObjectQuery)q;
                string sqlquery = (oq).ToTraceString();
                var strSQL = oq.ToTraceString();
                List<System.Data.Entity.Core.Objects.ObjectParameter> ps = oq.Parameters.ToList();
                for (int n = ps.Count() - 1; n >= 0; n--) //para que @QueContenga no reemplace a @QueContenga2
                {
                    System.Data.Entity.Core.Objects.ObjectParameter parameter = ps[n];
                    var name = "@" + parameter.Name;
                    string value;
                    if (parameter.Value == null)
                    {
                        value = " NULL ";

                    }
                    else if (!(parameter.Value.GetType() == typeof(DateTime)))
                    {

                        value = "'" + (parameter.Value ?? "").ToString() + "'";
                    }
                    else
                    {

                        value = "'" + (((DateTime)(parameter.Value)).ToString("s") ?? "").ToString() + "'";
                    }
                    strSQL = strSQL.Replace(name, value);
                }






                //string razonsocial = UserDatosExtendidosManager.TraerRazonSocialDelUsuario(usuario, scbdlmasterappconfig, SC);





                //var l = dt.AsEnumerable().Select(x => x["NumeroCartaDePorte"].NullSafeToString()).ToList();


                //Assert.IsTrue(dt.AsEnumerable().Select(x => x["NumeroCartaDePorte"]).Contains(558600767));


                //ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
                //string output = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
                //ReportParameter[] yourParams = new ReportParameter[10];
                //yourParams[0] = new ReportParameter("webservice", "");
                yourParams[1] = new ReportParameter("sServidor", "");
                yourParams[2] = new ReportParameter("idArticulo", "-1");
                yourParams[3] = new ReportParameter("idDestino", "-1");
                yourParams[4] = new ReportParameter("desde", desde.ToString());
                yourParams[5] = new ReportParameter("hasta", hasta.ToString());
                yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
                yourParams[7] = new ReportParameter("Consulta", strSQL);
                yourParams[8] = new ReportParameter("sServidorSQL", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
                yourParams[9] = new ReportParameter("titulo", "ghkj");
                var output2 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                            @"Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, ref output, false);

                //RebindReportViewer_ServidorExcel explota (al depurar, no al ejecutar) en el setparameters, se queja del xmlserializer. 
                //RebindReportViewerLINQ_Excel no explota

                System.Diagnostics.Process.Start(output2);

            }


        }




        [TestMethod]
        public void bldcorredor_29608()
        {



            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;
            DemoProntoEntities db2 = null;

            var clientes = CartaDePorteManager.TraerCUITClientesSegunUsuario("BLD25MAYO", SC, scbdlmasterappconfig).Where(x => x != "");
            String aaa = ParametroManager.TraerValorParametro2(SC, "ClienteBLDcorredorCUIT").NullSafeToString() ?? "";
            var sss = aaa.Split('|').ToList();


            // no usar mas esto, sino el DataTablePorCliente/DataTablePorClienteSQL

            var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC,
                     "", "", "", 1, 10,
                      CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                     -1, -1,
                     -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                      new DateTime(2013, 1, 1),
                      new DateTime(2014, 1, 1),
                      -1, ref sTitulo, "Ambas", false, "", ref db2, "", -1, -1, 0, "", "Ambas")

                        .Where(x => clientes.Contains(x.TitularCUIT) || clientes.Contains(x.IntermediarioCUIT) || clientes.Contains(x.RComercialCUIT))
                        .ToList();
        }









        [TestMethod]
        public void resumen_43047_43048()
        {

            // En el periodo anterior sigue habiendo bnastante diferencia
            // Si filtra por "entrega", aparecen cartas en "exportacion" porque de esas familias hay "Originales" en ese modo


            ReportParameter p2 = null;

            var desde = new DateTime(2016, 11, 1);
            var hasta = new DateTime(2017, 5, 31);
            var desdeAnt = new DateTime(2015, 11, 1); //nov
            var hastaAnt = new DateTime(2016, 5, 31); //mayo
                                                      //desde = desdeAnt;
                                                      //hasta = hastaAnt;

            var MinimoNeto = 0;
            var topclie = 99999;
            var pv = -1;
            var ModoExportacion = "Entregas";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas; //CartaDePorteManager.enumCDPestado.Todas;

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();





            string output2 = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams2 = new ReportParameter[9];
            yourParams2[0] = new ReportParameter("FechaDesde", desde.ToString());
            yourParams2[1] = new ReportParameter("FechaHasta", hasta.ToString());
            yourParams2[2] = new ReportParameter("FechaDesdeAnterior", desdeAnt.ToString());
            yourParams2[3] = new ReportParameter("FechaHastaAnterior", hastaAnt.ToString());
            yourParams2[4] = new ReportParameter("bMostrar1", "true");
            yourParams2[5] = new ReportParameter("bMostrar2", "true");
            yourParams2[6] = new ReportParameter("bMostrar3", "true");
            yourParams2[7] = new ReportParameter("bMostrar4", "true");
            yourParams2[8] = new ReportParameter("bMostrar5", "true");

            var s = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                      "Williams - Resumen de Totales Generales 2.rdl", yourParams2, ref output2, false);

            System.Diagnostics.Process.Start(output2);

        }









        [TestMethod]
        public void liquidacionsubcon_43045()
        {

            var cliente = SQLdinamico.BuscaIdClientePreciso("ALVAREZ, JORGE", SC);



            if (false)
            {

                var s = new ServicioCartaPorte.servi();
                var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
                DemoProntoEntities db = new DemoProntoEntities(scEF);


                var q1 = db.WilliamsDestinos.Where(x => x.Subcontratista1 == 10947 || x.Subcontratista2 == 10947).FirstOrDefault(); // ramirez jose luis
                q1.Subcontratista1 = 10947;
                q1.Subcontratista2 = 10947;

                var q2 = db.ListasPreciosDetalles.Where(x => x.ListasPrecio.Descripcion == "RAMIREZ JOSE LUIS - Precios").ToList(); // ramirez jose luis
                foreach (Data.Models.ListasPreciosDetalle ps in q2)
                {
                    ps.PrecioComboCaladaMasBalanza = 55;
                }

                db.SaveChanges();

            }







            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2017, 6, 1),
                        new DateTime(2017, 7, 31),
                        0, cliente, ref sTitulo);



            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }






        [TestMethod]
        public void SincroGrimaldi()
        {

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            //  int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-55549549-4", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("GRIMALDI GRASSI", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                 -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2017, 8, 1), new DateTime(2017, 8, 10),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void Urenport_5_37950_equivalencia_del_destino_42713()
        {

            // es precisamente así:
            /*
             * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
             * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
            it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                an "External table is not in the expected format" exception.
                    Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
            it's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
            all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
            */



            //insertarequivalencia("DESTINO|LDC ARGENTINA S A", "LDC ARG (PTA TIMBUES)");

            //string archivoExcel = @"C:\bdl\pronto\docstest\Posicion-170626-1330.xls";
            string archivoExcel = @"C:\bdl\pronto\docstest\New folder\Posicion-170809-0850.xls";
            //string archivoExcel = @"C:\bdl\pronto\docstest\New folder\urenport_09ago2017_085016.xls";

            //FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(archivoExcel);
            //FuncionesGenericasCSharp.GetExcel4_ExcelDataReader(archivoExcel);

            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            // verificar q Importa bien el destino especifico.

        }





        [TestMethod]
        public void facelec()
        {

            var output2 = CartaDePorteManager.ImprimirFacturaElectronica(87781, false, SC, DirApp);
        }




        [TestMethod]
        public void que_el_servicio_avise_si_esta_usando_un_directorio_inexistente()
        {
        }




        [TestMethod]
        public void BorrarPosiciones_42952()
        {



            var desde = new DateTime(2017, 1, 1);
            var hasta = new DateTime(2017, 1, 31);
            var puntoventa = 1;

            CartaDePorteManager.BorrarPosiciones(SC, desde, hasta, puntoventa);


        }



        [TestMethod]
        public void syngenta_webservice_ftp_42950_2()
        {

            var s = new ServicioCartaPorte.servi();


            var desde = new DateTime(2017, 6, 1);
            var hasta = new DateTime(2017, 8, 31);

            s.EnviarSyngenta(SC,
                            desde, hasta,
                            ConfigurationManager.AppSettings["SyngentaServiceEndpoint"],
                            ConfigurationManager.AppSettings["SyngentaServiceUser"],
                            ConfigurationManager.AppSettings["SyngentaServicePass"],
                            ConfigurationManager.AppSettings["SyngentaFTPdominio"],
                            ConfigurationManager.AppSettings["SyngentaFTPdir"],
                            ConfigurationManager.AppSettings["SyngentaFTPuser"],
                            ConfigurationManager.AppSettings["SyngentaFTPpass"],
                            DirApp);


        }



        [TestMethod]
        public void syngenta_webservice_ftp_42950()
        {


            string archivoExcel = @"C:\bdl\pronto\docstest\Syngenta_10feb2017_115941.xlsx";

            var s = new ServicioCartaPorte.servi();

            s.UploadFtpFile("goragora.com.ar", "/public_ftp/incoming", archivoExcel, "maruxs", "ns5aK!cvai0C");

            //s.UploadFtpFile("192.208.44.90", "/UAT/Ready", archivoExcel, "sappo_test", "4R04475j");
            s.UploadFtpFile(ConfigurationManager.AppSettings["SyngentaFTPdominio"],
                            ConfigurationManager.AppSettings["SyngentaFTPdir"],
                            archivoExcel,
                            ConfigurationManager.AppSettings["SyngentaFTPuser"],
                            ConfigurationManager.AppSettings["SyngentaFTPpass"]);





        }






        [TestMethod]
        public void _zxinf_referencias()
        {
            var dd = CartaDePorteManager.ReadBarcode1D_ZXing(@"C:\bdl\pronto\docstest\000555094127-cp.jpg", 0);
        }







        [TestMethod]
        public void problemasconNullstringyIField()
        {



            //class xxx : IField
            //{
            //    string asadasd;

            //    void ApplySuggest(string suggest) { return; }
            //    string Name { get; }
            //    string FullName { get; }
            //    FieldTypeEnum Type { get; }
            //    IFieldValue Value { get; }
            //    IFields Children { get; }
            //    IDocument Document { get; }
            //    IFieldInstances Instances { get; }
            //    IFieldDefinition FieldDefinition { get; }
            //    IBlocksCollection Blocks { get; }
            //    IStringsCollection Suggests { get; }

            //}


            //IField BarraCP = new IField(); // = Sample.AdvancedTechniques.findField(document, "BarraCP");
            string asdad = "·$fdsasfdadf";
            //string BarraCEE = asdad.NullStringSafe2();

        }





        [TestMethod]
        public void liquidacionsubcon_42676()
        {


            if (false)
            {

                var s = new ServicioCartaPorte.servi();
                var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
                DemoProntoEntities db = new DemoProntoEntities(scEF);


                var q1 = db.WilliamsDestinos.Where(x => x.Subcontratista1 == 10947 || x.Subcontratista2 == 10947).FirstOrDefault(); // ramirez jose luis
                q1.Subcontratista1 = 10947;
                q1.Subcontratista2 = 10947;

                var q2 = db.ListasPreciosDetalles.Where(x => x.ListasPrecio.Descripcion == "RAMIREZ JOSE LUIS - Precios").ToList(); // ramirez jose luis
                foreach (Data.Models.ListasPreciosDetalle ps in q2)
                {
                    ps.PrecioComboCaladaMasBalanza = 55;
                }

                db.SaveChanges();

            }





            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2017, 1, 16),
                        new DateTime(2017, 1, 16),
                        2, -1, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }







        [TestMethod]
        public void SincroDiazRiganti_42798()
        {

            string sErrores = "", sTitulo = "";
            // LinqCartasPorteDataContext db = null;




            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                    "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 2), new DateTime(2014, 1, 2),
                0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }





        [TestMethod]
        public void loginEnUrenport3_42773_4()
        {
            var s = new ServicioCartaPorte.servi();
            string dir = DirApp + @"\Temp\Pegatinas"; // es fundamental para el selenium que no tenga la ultima barrita? SII!!!!!
            string dirMiRepo = @"C:\Users\Mariano\Documents\";
            string dirbinary = @"C:\Users\Mariano\AppData\Local\Google\Chrome\Application\chrome.exe";

            s.UrenportSelenium_ConChromeHeadless(dir, dirMiRepo + @"pronto\InterfazFlexicapture\bin\Debug\", false, dirbinary);

            //s.CerealnetSeleniumConPhantomJS(DirApp);
        }



        [TestMethod]
        public void loginEnUrenport3_42773_3()
        {
            var s = new ServicioCartaPorte.servi();
            string dir = DirApp + @"\Temp\Pegatinas"; // es fundamental para el selenium que no tenga la ultima barrita? SII!!!!!
            string dirMiRepo = @"C:\Users\Mariano\Documents\";

            s.CerealnetSelenium_ConChromeHeadless(dir, dirMiRepo + @"pronto\InterfazFlexicapture\bin\Debug", true);

            //s.CerealnetSeleniumConPhantomJS(DirApp);
        }


        [TestMethod]
        public void loginEnUrenport3_42773_2()
        {
            ProntoWindowsService.Service1.Initialize();
            ProntoWindowsService.Service1.DoWorkSoloPegatinas();

        }



        [TestMethod]
        public void loginEnUrenport3_42773()
        {
            var s = new ServicioCartaPorte.servi();
            s.CerealnetSelenium(DirApp);
            //s.UrenportSelenium();

            return;


            IWebDriver browser = new FirefoxDriver();


            //////////////////////////////////////////////////////////////////////////////




            browser.Navigate().GoToUrl("http://extranet.urenport.com/login.aspx");

            new WebDriverWait(browser, TimeSpan.FromSeconds(10)).Until(ExpectedConditions.ElementExists((By.Id("Logins_UserName"))));


            var user_name2 = browser.FindElement(By.Name("Logins_UserName"));
            user_name2.SendKeys("williams");

            var password2 = browser.FindElement(By.Name("Logins_Password"));
            password2.SendKeys("santiago1177");


            var button2 = browser.FindElement(By.Name("Logins_LoginButton"));
            button2.Click();

            //if os.path.isfile(filename):            os.remove(filename)
            //WebDriverWait(browser, 20).until(            EC.presence_of_element_located((By.ID, "CPHPrincipal_btnExcel")))
            //new WebDriverWait(browser, TimeSpan.FromSeconds(10));
            var aaaad = new WebDriverWait(browser, TimeSpan.FromSeconds(20)).Until(ExpectedConditions.ElementExists((By.Id("ContentPlaceHolder1_GridView2"))));

            var button3 = browser.FindElement(By.Name("ContentPlaceHolder1_ASPxMenu2_DXI0_T"));
            button3.Click();





            //bashCommand = "ren Urenport.xls \"Urenport_%time:~0,2%%time:~3,2%-%DATE:/=%.xls\" "
            //os.system(bashCommand)

            //sleep(2)

            //bashCommand = "robocopy E:\SistemaPronto\Robot\  E:\Sites\ProntoTesting\Temp\Pegatinas *.xls /MOV /LOG+:LogRobot.txt "
            //os.system(bashCommand)



        }




        [TestMethod]
        public void loginEnCerealnet2_42773()
        {

            // el geckodriver tiene q estar en el path. actualizar version firefox (version 48)

            IWebDriver browser = new FirefoxDriver();
            /*
            //Notice navigation is slightly different than the Java version
            //This is because 'get' is a keyword in C#
            driver.Navigate().GoToUrl("http://www.google.com/");
            IWebElement query = driver.FindElement(By.Name("q"));
            query.SendKeys("Cheese");
            System.Console.WriteLine("Page title is: " + driver.Title);
            driver.Quit();

            */



            browser.Navigate().GoToUrl("http://entregadores.cerealnet.com/");

            // WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.ID, "txtUsuario")))
            new WebDriverWait(browser, TimeSpan.FromSeconds(10)).Until(ExpectedConditions.ElementExists((By.Id("txtUsuario"))));


            var user_name = browser.FindElement(By.Name("txtUsuario"));
            user_name.SendKeys("williams");

            var password = browser.FindElement(By.Name("txtPass"));
            password.SendKeys("santiago1177");


            var button = browser.FindElement(By.Name("btnInicio"));
            button.Click();

            //if os.path.isfile(filename):            os.remove(filename)
            //WebDriverWait(browser, 20).until(            EC.presence_of_element_located((By.ID, "CPHPrincipal_btnExcel")))
            //new WebDriverWait(browser, TimeSpan.FromSeconds(10));
            var aaaa = new WebDriverWait(browser, TimeSpan.FromSeconds(20)).Until(ExpectedConditions.ElementExists((By.Id("CPHPrincipal_btnExcel"))));

            aaaa.Click();

            //button = browser.FindElement(By.Name("CPHPrincipal_btnExcel"));
            //button.Click();









            /*

                        #!/usr/bin/python
            # -*- coding: utf-8 -*-
            import os
            from time import sleep
            from selenium import webdriver
            from pyvirtualdisplay import Display
            from selenium.webdriver.support.ui import WebDriverWait
            from selenium.webdriver.support import expected_conditions as EC
            from selenium.webdriver.common.by import By


            def download_excel(silent=True):
                if silent:
                    display = Display(visible=0, size=(1366, 768))
                    display.start()
                 #Instalar Firefox
                # instalar el ejecutable geckodriver de https://github.com/mozilla/geckodriver/releases
                binpath = 'E:/SistemaPronto/Robot' # Directorio donde está geckodriver
                os.environ["PATH"] += os.pathsep + binpath

                filename = 'Urenport.xls'

                profile = webdriver.FirefoxProfile()
                profile.set_preference('browser.download.folderList', 2)    # 2 = custom location
                profile.set_preference('browser.download.manager.showWhenStarting', False)
                profile.set_preference('browser.download.dir', os.getcwd())
                profile.set_preference('browser.helperApps.neverAsk.saveToDisk', "application/ms-excel;application/xls;text/csv;application/vnd.ms-excel")
                profile.set_preference('browser.helperApps.alwaysAsk.force', False)
                browser = webdriver.Firefox(firefox_profile=profile)
                try:
                    browser.get('http://entregadores.cerealnet.com/')

                    WebDriverWait(browser, 10).until(
                        EC.presence_of_element_located((By.ID, "txtUsuario")))

                    user_name = browser.find_element_by_id('txtUsuario')
                    user_name.send_keys('williams')

                    password = browser.find_element_by_id('txtPass')
                    password.send_keys('santiago1177')

                    button = browser.find_element_by_id('btnInicio')
                    button.click()

                    if os.path.isfile(filename):
                        os.remove(filename)

                    WebDriverWait(browser, 20).until(
                        EC.presence_of_element_located((By.ID, "CPHPrincipal_btnExcel")))


                    button = browser.find_element_by_id('CPHPrincipal_btnExcel')
                    button.click()


                    sleep(30)

                    browser.get('http://extranet.urenport.com/login.aspx')

                    WebDriverWait(browser, 10).until(
                        EC.presence_of_element_located((By.ID, "Logins_UserName")))

                    user_name = browser.find_element_by_id('Logins_UserName')
                    user_name.send_keys('williams')

                    password = browser.find_element_by_id('Logins_Password')
                    password.send_keys('santiago1177')

                    button = browser.find_element_by_id('Logins_LoginButton')
                    button.click()

                    WebDriverWait(browser, 20).until(
                        EC.presence_of_element_located((By.ID, "ContentPlaceHolder1_GridView2")))

                    button = browser.find_element_by_id('ContentPlaceHolder1_ASPxMenu2_DXI0_T')
                    button.click()

                    sleep(15)


                    bashCommand = "ren Urenport.xls \"Urenport_%time:~0,2%%time:~3,2%-%DATE:/=%.xls\" "
                    os.system(bashCommand)

                    sleep(2)

                    bashCommand = "robocopy E:\SistemaPronto\Robot\  E:\Sites\ProntoTesting\Temp\Pegatinas *.xls /MOV /LOG+:LogRobot.txt "
                    os.system(bashCommand)

                finally:
                    #browser.quit()
                    bashCommand = "Taskkill /IM Firefox.exe /F >nul 2>&1"
                    os.system(bashCommand)

                    bashCommand = "ren Urenport.xls \"Urenport_%time:~0,2%%time:~3,2%-%DATE:/=%.xls\" "
                    os.system(bashCommand)

                    sleep(2)

                    bashCommand = "robocopy E:\SistemaPronto\Robot\  E:\Sites\ProntoTesting\Temp\Pegatinas *.xls /MOV /LOG+:LogRobot.txt"
                    os.system(bashCommand)

            download_excel(silent=False)
                        */
        }

        [TestMethod]
        public void loginEnUrenport_42773()
        {

            // http://stackoverflow.com/questions/975426/how-to-programmatically-log-in-to-a-website-to-screenscape?noredirect=1&lq=1

            // url  = "http://extranet.urenport.com/Login.aspx?ReturnUrl=%2fextraform%2findex.aspx"
            //    string user="williams";
            //string pass = "santiago1177";


            //    HttpWebRequest http = WebRequest.Create(url) as HttpWebRequest;
            //    http.KeepAlive = true;
            //    http.Method = "POST";
            //    http.ContentType = "application/x-www-form-urlencoded";
            //    string postData = "FormNameForUserId=" + strUserId + "&FormNameForPassword=" + strPassword;
            //    byte[] dataBytes = UTF8Encoding.UTF8.GetBytes(postData);
            //    http.ContentLength = dataBytes.Length;
            //    using (Stream postStream = http.GetRequestStream())
            //    {
            //        postStream.Write(dataBytes, 0, dataBytes.Length);
            //    }
            //    HttpWebResponse httpResponse = http.GetResponse() as HttpWebResponse;
            //    // Probably want to inspect the http.Headers here first
            //    http = WebRequest.Create(url2) as HttpWebRequest;
            //    http.CookieContainer = new CookieContainer();
            //    http.CookieContainer.Add(httpResponse.Cookies);
            //    HttpWebResponse httpResponse2 = http.GetResponse() as HttpWebResponse;




        }








        [TestMethod]
        public void Buques_37816_GrillaExportacion()
        {

            //            Filtros:

            //* Fecha Buque
            //* Cliente Facturado
            //* Producto
            //* Punto de Venta

            //Columnas:
            //Las mismas que tiene el listado actual y agregar:


            //* Factura
            //* Fecha Factura


            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
            string output = @"C:\Users\Administrador\Downloads\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();


            var m = db.CartasPorteMovimientos.First().IdCDPMovimiento;



            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.CDPMovimientos_DynamicGridData_ExcelExportacion_UsandoInternalQuery(SC, "IdCDPMovimiento", "desc", 1, 999999, true, filtro);



            CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal, "Carta Porte - Buques.rdl", sqlquery4, SC, false, ref output);


            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void Buques_37816_GrillaAutocomplete()
        {
            //    falta el automcplete de rubros
            var s = new ServicioCartaPorte.servi();
            s.GetNormasCalidad(SC, "a");
        }


        [TestMethod]
        public void Buques_37816_GrillaPaginacion()
        {

            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"Trigo Pan\"},{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"MAIZ\"}]}";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var s = new ServicioCartaPorte.servi();





            var jsonData = s.CDPMovimientos_DynamicGridData(SC, "IdCDPMovimiento", "desc", 1, 100, true, filtro);


        }

        [TestMethod]
        public void Buques_37816_GrillaUpdate()
        {

            var o = new CartaPorteNormasCalidad();
            var s = new ServicioCartaPorte.servi();

            s.NormaCalidadBatchUpdate(SC, o);
        }











        [TestMethod]
        public void CampoEditableDeClientesRelacionadosAlUsuarioParaTirarInforme_42752()
        {

            //probar fyo con mi usuario
            //o hago top, o un select mas angosto, o un filtro de fecha


            //probe con coma, pipe, punto y coma y nunca me funciona. ese usuario el 1/6 debería traer 
            //la cp 561439022 que es de JACIUK EUGENIO FELIPE 20-08494702-5 (titular)

            //Acá, mismo usuario, password y cuits, probando en Enero, debería traer la CP 558600767, donde 20 - 08494702 - 5(JACIUK EUGENIO FELIPE) es titular

            //string usuario = "RODRIGORIOS"; 

            string QueContenga2 = "556224458"; //"558575010";

            string usuario = "Mariano";
            var rs = "FUTUROS Y OPCIONES .COM";
            var desde = new DateTime(2017, 1, 1);
            var hasta = new DateTime(2017, 1, 31);
            var estadofiltro = CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas;


            var idVendedor = -1;
            var idCorredor = SQLdinamico.BuscaIdVendedorPreciso(rs, SC);
            var idDestinatario = -1;
            var idIntermediario = -1;
            var idRComercial = -1;
            var idArticulo = -1;
            var idProcedencia = -1;
            var idDestino = -1;






            string sql = CartaDePorteManager.DataTablePorClienteSQL(SC, "", "", "", 0, 9999999,
                                estadofiltro, rs, idVendedor, idCorredor,
                               idDestinatario, idIntermediario,
                               idRComercial, idArticulo, idProcedencia, idDestino
                                , 0, "Ambas"
                                , desde, hasta,
                                0, QueContenga2, usuario, scbdlmasterappconfig, true, true, true, false, false, false);





            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
            string output = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams = new ReportParameter[10];
            yourParams[0] = new ReportParameter("webservice", "");
            yourParams[1] = new ReportParameter("sServidor", "");
            yourParams[2] = new ReportParameter("idArticulo", "-1");
            yourParams[3] = new ReportParameter("idDestino", "-1");
            yourParams[4] = new ReportParameter("desde", desde.ToString());
            yourParams[5] = new ReportParameter("hasta", hasta.ToString());
            yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
            yourParams[7] = new ReportParameter("Consulta", sql);
            yourParams[8] = new ReportParameter("sServidorSQL", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[9] = new ReportParameter("titulo", "ghkj");
            string sss = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                        @"Listado general de Cartas de Porte (simulando original) con foto 2", yourParams, ref output, false);



            System.Diagnostics.Process.Start(output);



        }






        [TestMethod]

        public void generar_mas_angosto()
        {

            // En el periodo anterior sigue habiendo bnastante diferencia
            // Si filtra por "entrega", aparecen cartas en "exportacion" porque de esas familias hay "Originales" en ese modo


            ReportParameter p2 = null;

            var desde = new DateTime(2017, 5, 10);
            var hasta = new DateTime(2017, 5, 12);
            var desdeAnt = new DateTime(2015, 11, 1); //nov
            var hastaAnt = new DateTime(2016, 5, 31); //mayo
                                                      //desde = desdeAnt;
                                                      //hasta = hastaAnt;

            var MinimoNeto = 0;
            var topclie = 99999;
            var pv = -1;
            var ModoExportacion = "Entregas";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas; //CartaDePorteManager.enumCDPestado.Todas;



            string output3 = "";
            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();
            dr["ModoImpresion"] = "Speed"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
            dr["Emails"] = "mscalella911@gmail.com";
            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = desde;
            dr["FechaHasta"] = hasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = ModoExportacion;
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;

            string titulo = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";
            long lineas = 0;
            int tiemposql = 0;
            int tiempoinf = 0;

            output3 = CartaDePorteManager.generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, desde, hasta, dr, estado, ref lineas, ref titulo, inlinePNG, pv, ref tiemposql, ref tiempoinf, false, null, 9999999);


            System.Diagnostics.Process.Start(output3);

        }





        [TestMethod]
        public void syngenta_webservice_42732()
        {
            // mandar una tanda

            int idcliente = 4333; //syngenta

            var dbcartas = CartaDePorteManager.ListadoSegunCliente(SC, idcliente, new DateTime(2016, 11, 1), new DateTime(2016, 11, 30), CartaDePorteManager.enumCDPestado.DescargasMasFacturadas);

            var s = new ServicioCartaPorte.servi();




            var endpointStr = ConfigurationManager.AppSettings["SyngentaServiceEndpoint"]; //  @"https://oasis-pi-nonprod.syngenta.com/uat/XISOAPAdapter/MessageServlet?senderParty=&senderService=Srv_BIT_BarterService&receiverParty=&receiverService=&interface=LoadDeclarationSoap_send_out_asy&interfaceNamespace=urn:broker:o2c:s:global:delivery:loaddeclaration:100";
            var UserName = ConfigurationManager.AppSettings["SyngentaServiceUser"];
            var Password = ConfigurationManager.AppSettings["SyngentaServicePass"];

            var x = s.WebServiceSyngenta(dbcartas, endpointStr, UserName, Password);

            // marcar fecha de cartas enviadas, loguar tanda de cartas enviadas para que 
            // sepan qué excel tienen que generar (el webservice solo manda un mail si hubo error, no tengo notificacion de otro tipo)

            // pagina de log o por lo menos de estado del envio de datos a syngenta.
            //                 noenviadas=Func();


            string DIRFTP = DirApp + @"\DataBackupear\";
            string nombre = DIRFTP + "Syngenta_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            s.GenerarExcelSyngentaWebService(x, nombre); // 3 horas 

            System.Diagnostics.Process.Start(nombre);

            return;


            s.CopyFileFTP(nombre, "username", "password#");   // 4 horas

            //return Log; // pagina de log o por lo menos de estado del envio de datos a syngenta. 3 horas 


            /*
            . El Web Service no devolverá ningún dato que haga referencia en cuanto a si se procesó bien o tuvo errores la interface.
    La interface será procesa por Syngenta y si la misma no puede ser procesada correctamente por contener errores en los datos 
    u otra validación; se enviara un mail con el detalle del procesamiento y error al mail indicado por el entregador para esta 
            interface como así también dicho mail será enviado de la misma forma al responsable de Canje por parte de Syngenta.
             * 
             * 
             * */


            // que pasa si alguien anula una carta de syngenta?
            //carta.anular();
            // -bueno, el que levanta la lista de cartas tiene que comparar la fecha de enviado con la de ultima modificacion



        }








        [TestMethod]
        public void problema_informe__42686()
        {
            //En el ranking de clientes, si se pide Modo: Entregas Fechas: 1/11/16 al 30/06/17, viene Amaggi en el lugar 9.
            // Amaggi no tiene facturadas cartas de porte de entrega
            // -esto pasa porque son duplicadas, y al pedir entrega, estas usando un TRUCHAMIENTO (en el fsql_) para hacer pasar el original por una de entrega (q es la de AMAGGI de exportacion)
            // -ok, una opcion es traer tambien los duplicados (porq el TRUCHAMIENTO lo haces solo al pedir originales)!!!


            ReportParameter p2 = null;

            var desde = new DateTime(2016, 11, 1);
            var hasta = new DateTime(2017, 6, 30);
            var desdeAnt = new DateTime(2015, 11, 1); //nov
            var hastaAnt = new DateTime(2016, 6, 30);
            var MinimoNeto = 0;
            var topclie = 99999;
            var pv = -1;
            var ModoExportacion = "Entregas";



            /*


                        declare	@startRowIndex int,@maximumRows int,@estado int,@QueContenga nvarchar(4000),@idVendedor int,@idCorredor int,@idDestinatario int,@idIntermediario int,@idRemComercial int,@idArticulo int,@idProcedencia int,@idDestino int,@AplicarANDuORalFiltro int,@ModoExportacion nvarchar(4000),@fechadesde datetime2(7),@fechahasta datetime2(7),@puntoventa int,@IdAcopio int,@bTraerDuplicados bit,@Contrato nvarchar(4000),@QueContenga2 nvarchar(4000),@idClienteAuxiliarint int,@AgrupadorDeTandaPeriodos int,@Vagon int,@Patente nvarchar(4000),@optCamionVagon nvarchar(4000),@p__linq__0 datetime2(7),@p__linq__1 datetime2(7),@p__linq__2 datetime2(7),@p__linq__3 datetime2(7),@p__linq__4 datetime2(7),@p__linq__5 datetime2(7),@p__linq__6 datetime2(7),@p__linq__7 datetime2(7),@p__linq__8 datetime2(7),@p__linq__9 datetime2(7)
            select @startRowIndex=NULL,@maximumRows=NULL,@estado=4,@QueContenga=NULL,@idVendedor=-1,@idCorredor=-1,@idDestinatario=-1,@idIntermediario=-1,@idRemComercial=-1,@idArticulo=-1,@idProcedencia=-1,@idDestino=-1,@AplicarANDuORalFiltro=0,@ModoExportacion=N'Entregas',@fechadesde='2015-11-01 00:00:00',@fechahasta='2017-06-30 00:00:00',@puntoventa=-1,@IdAcopio=NULL,@bTraerDuplicados=0,@Contrato=NULL,@QueContenga2=NULL,@idClienteAuxiliarint=NULL,@AgrupadorDeTandaPeriodos=NULL,@Vagon=NULL,@Patente=NULL,@optCamionVagon=NULL,@p__linq__0='2016-11-01 00:00:00',@p__linq__1='2016-11-01 00:00:00',@p__linq__2='2016-11-01 00:00:00',@p__linq__3='2017-06-30 00:00:00',@p__linq__4='2016-11-01 00:00:00',@p__linq__5='2015-11-01 00:00:00',@p__linq__6='2016-11-01 00:00:00',@p__linq__7='2016-06-30 00:00:00',@p__linq__8='2016-11-01 00:00:00',@p__linq__9='2016-06-30 00:00:00'


            select idcartadeporte, clientefacturado, exporta from 
            [fSQL_GetDataTableFiltradoYPaginado] (@startRowIndex, @maximumRows, @estado, @QueContenga, @idVendedor, @idCorredor, @idDestinatario, @idIntermediario, @idRemComercial, @idArticulo, @idProcedencia, @idDestino, @AplicarANDuORalFiltro, @ModoExportacion, @fechadesde, @fechahasta, @puntoventa, @IdAcopio, @bTraerDuplicados, @Contrato, @QueContenga2, @idClienteAuxiliarint, @AgrupadorDeTandaPeriodos, @Vagon, @Patente, @optCamionVagon) 
            where clientefacturado='AMAGGI ARGENTINA S.A.'

            */





            var q2 = ConsultasLinq.rankingclientes(SC, "",
                 "", "", 0, 10, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, ModoExportacion, desde, hasta,
               pv, desdeAnt, hastaAnt, MinimoNeto, topclie);




            ReportViewer ReporteLocal2 = new Microsoft.Reporting.WebForms.ReportViewer();
            string output2 = "";

            ReportParameter[] yourParams2 = new ReportParameter[2];
            yourParams2[0] = new ReportParameter("TopClientes", topclie.ToString());
            yourParams2[1] = new ReportParameter("MinimoNeto", MinimoNeto.ToString());

            CartaDePorteManager.RebindReportViewerLINQ_Excel(ref ReporteLocal2, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Ranking de Clientes.rdl", q2, ref output2, yourParams2);

            System.Diagnostics.Process.Start(output2);








        }






        [TestMethod]
        public void RangosResultadoCalidadesCalculoRebajaYMerma_37774__()
        {
            var s = new ServicioCartaPorte.servi();
            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);



            var ss6 = s.RebajaCalculo(SC, 5, 31, 5, -1); // quebrado partido, soja
            var ss5 = s.RebajaCalculo(SC, 1, 6.5M, -1, 1);
            var ss4 = s.RebajaCalculo(SC, 1, 20M, -1, 1);
            var ss1 = s.RebajaCalculo(SC, 1, 2.5M, -1, -1);
            var ss2 = s.RebajaCalculo(SC, 1, 2.5M, 01, -1);
            var ss3 = s.RebajaCalculo(SC, 1, 2.5M, -1, 1);

            /*
            En ningún caso pone bien la merma en KG
    Por ejemplo, estoy poniendo:

    * SOJA
    * 30000KG neto descarga
    * 1.5% cuerpos extraños/materias

    La rebaja la calcula bien: 0.5% pero me pone 1KG de merma.
    Deberían ser 150KG

    Cuando hay "tramos" de mermas no está calculando bien la rebaja.
    Ejemplo:

    * SOJA
    * 30000KG neto descarga
    * 6.5% cuerpos extraños/materias

    Debería ser 6.75% de rebaja y viene 7.25%

            */
        }





        [TestMethod]
        public void InformeControlDiario_41491_AKA_estadisticas_de_descargas()
        {


            //wCartasDePorteControlDescargas_TX_InformeControlDiario


            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";
            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter[] yourParams = new ReportParameter[6];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("sServidorWeb", ConfigurationManager.AppSettings["UrlDominio"]);
            yourParams[2] = new ReportParameter("FechaDesde", new DateTime(2016, 7, 1).ToString());
            yourParams[3] = new ReportParameter("FechaHasta", new DateTime(2016, 10, 30).ToString());
            yourParams[4] = new ReportParameter("IdDestino", "-1");
            yourParams[5] = new ReportParameter("IdPuntoVenta", "0");
            //yourParams[7] = new ReportParameter("Consulta", strSQL);


            var output2 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                "Williams - Controles Diarios.rdl", yourParams, ref ArchivoExcelDestino, false);

            System.Diagnostics.Process.Start(output2);
        }






        [TestMethod]
        public void SincroGualeguayCereales_42538()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcorr = CartaDePorteManager.BuscarVendedorPorCUIT("30-71077157-6", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("Gualeguay", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                 -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 3, 10), new DateTime(2016, 3, 15),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }










        [TestMethod]
        public void Urenport_5_37950_equivalencia_del_destino()
        {

            // es precisamente así:
            /*
             * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
             * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
            it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                an "External table is not in the expected format" exception.
                    Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
            it's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
            all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
            */



            //insertarequivalencia("DESTINO|LDC ARGENTINA S A", "LDC ARG (PTA TIMBUES)");

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-170626-1330.xls";

            //FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(archivoExcel);
            //FuncionesGenericasCSharp.GetExcel4_ExcelDataReader(archivoExcel);

            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            // verificar q Importa bien el destino especifico.

        }





        [TestMethod]
        public void ServicioWebDescargas_41486_bld()
        {

            ////Trust all certificates
            //System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            //var cerealnet = new WS_CartasDePorteClient();

            string usuario = "Mariano"; //"fyo";
            string clave = "pirulo!"; // "76075";
            string cuit = "30703605105";

            // var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            var respEntrega = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL_v3(usuario, clave, cuit,
                                            new DateTime(2016, 1, 1),
                                            new DateTime(2017, 1, 1), CartaDePorteManager.enumCDPestado.Posicion,
                                            SC, DirApp, scbdlmasterappconfig);


            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (CerealNet.WSCartasDePorte.analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            //Console.ReadKey();
        }







        [TestMethod]
        public void RangosResultadoCalidadesCalculoRebajaYMerma_37774_4()
        {


            //    falta el automcplete de rubros

            var s = new ServicioCartaPorte.servi();

            s.GetNormasCalidad(SC, "a");

        }





        [TestMethod]
        public void RangosResultadoCalidadesCalculoRebajaYMerma_37774_3()
        {

            string filtro = ""; // "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"Trigo Pan\"},{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"MAIZ\"}]}";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var s = new ServicioCartaPorte.servi();





            var sqlquery4 = s.NormasCalidad_DynamicGridData(SC, "IdCartaPorteNormaCalidad", "desc", 1, 999999, true, filtro);


        }




        [TestMethod]
        public void RangosResultadoCalidadesCalculoRebajaYMerma_37774_2()
        {

            var o = new CartaPorteNormasCalidad();
            var s = new ServicioCartaPorte.servi();

            s.NormaCalidadBatchUpdate(SC, o);
        }




        [TestMethod]
        public void RangosResultadoCalidadesCalculoRebajaYMerma_37774()
        {
            var s = new ServicioCartaPorte.servi();
            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);




            //db.CartaPorteRubrosCalidads.Add(new CartaPorteRubrosCalidad { Descripcion = "Materias Extrañas" });
            //db.CartaPorteRubrosCalidads.Add(new CartaPorteRubrosCalidad { Descripcion = "Tierra" });

            //db.SaveChanges();


            //            MATERIAS
            //EXTRAÑAS 1,0 3,0
            //Para valores
            //superiores al 1,0 %
            //y hasta el 3,0 % a
            //razón del 1,0 % por
            //cada por ciento o
            //fracción
            //proporcional.Para
            //valores superiores
            //al 3,0 % a razón
            // del 1,5 % por cada
            //  por ciento o
            //fracción
            //proporcional.
            //incluido


            db.CartaPorteNormasCalidads.Add(new CartaPorteNormasCalidad
            {
                IdCartaPorteRubroCalidad = 1,
                ResultadoDesde = 1,
                ResultadoHasta = 3,
                RebajaIncremento = 1
            });
            db.CartaPorteNormasCalidads.Add(new CartaPorteNormasCalidad
            {
                IdCartaPorteRubroCalidad = 1,
                ResultadoDesde = 3,
                ResultadoHasta = 999,
                RebajaIncremento = (decimal)1.5
            });

            db.CartaPorteNormasCalidads.Add(new CartaPorteNormasCalidad
            {
                IdCartaPorteRubroCalidad = 1,
                ResultadoDesde = 1,
                ResultadoHasta = 3,
                RebajaIncremento = 5,
                IdArticulo = 1
            });

            db.CartaPorteNormasCalidads.Add(new CartaPorteNormasCalidad
            {
                IdCartaPorteRubroCalidad = 1,
                ResultadoDesde = 1,
                ResultadoHasta = 3,
                RebajaIncremento = 6,
                IdArticulo = null,
                IdDestino = 1
            });




            var rubs = db.CartaPorteRubrosCalidads.Select(x => x.IdCartaPorteRubroCalidad).ToList();

            foreach (var r in rubs)
            {
                db.CartaPorteNormasCalidads.Add(new CartaPorteNormasCalidad
                {
                    IdCartaPorteRubroCalidad = r,
                    ResultadoDesde = 1,
                    ResultadoHasta = 3,
                    RebajaIncremento = 1
                });
            }

            //TIERRA 0,5 0,5
            //Para valores
            //superiores al 0,5 %
            //a razón del 1,5 %
            //por cada por ciento
            //o fracción
            //proporcional.
            db.CartaPorteNormasCalidads.Add(new CartaPorteNormasCalidad
            {
                IdCartaPorteRubroCalidad = 2,
                ResultadoDesde = 0.5M,
                ResultadoHasta = 999,
                RebajaIncremento = 1.5M
            });

            db.SaveChanges();




            var ss4 = s.RebajaCalculo(SC, 1, 20M, -1, 1);
            var ss1 = s.RebajaCalculo(SC, 1, 2.5M, -1, -1);
            var ss2 = s.RebajaCalculo(SC, 1, 2.5M, 01, -1);
            var ss3 = s.RebajaCalculo(SC, 1, 2.5M, -1, 1);


        }






        [TestMethod]
        public void mapa_con_googlemaps_40288_3()
        {

            var address = "BARRIO VILLA MAILIN, BUENOS AIRES, Argentina";
            var requestUri = string.Format("http://maps.googleapis.com/maps/api/geocode/xml?address={0}&sensor=false", Uri.EscapeDataString(address));

            var request = WebRequest.Create(requestUri);
            var response = request.GetResponse();
            var xdoc = System.Xml.Linq.XDocument.Load(response.GetResponseStream());

            var result = xdoc.Element("GeocodeResponse").Element("result");
            var locationElement = result.Element("geometry").Element("location");
            var lat = locationElement.Element("lat");
            var lng = locationElement.Element("lng");

        }



        //[TestMethod]
        public void _LENTO_mapa_con_googlemaps_40288()
        {
            //agregar en la grilla de localidades la edicion de lat y lng

            var s = new ServicioCartaPorte.servi();
            s.ReasignarGeocodeLocalidades(false, SC);
        }



        [TestMethod]
        public void mapa_con_googlemaps_40288_2()
        {

            string modoExportacion = "Ambos";
            DateTime fechadesde = new DateTime(2016, 11, 1);
            DateTime fechahasta = new DateTime(2017, 11, 1);
            int idprocedencia = -1;
            int idarticulo = -1;
            int idclientefacturado = -1;
            int tonsdesde = 1;
            int tonshasta = 999999;

            // llamar al mapa
            var s = new ServicioCartaPorte.servi();
            var q = s.MapaGeoJSON_DLL(SC, modoExportacion, fechadesde, fechahasta, idprocedencia, idarticulo, idclientefacturado, tonsdesde, tonshasta);

        }




        [TestMethod]
        public void movimientos_37806_5()
        {

            //no filtras por punto de venta
            int pv = -1;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("SOJA", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("ZARATE - TERMINAL LAS PALMAS", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("AMAGGI ARGENTINA S.A.", SC);
            DateTime desde = new DateTime(2017, 5, 9);

            var existencias1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario, pv);

            Debug.Assert(existencias1 != -74353677);

        }



        [TestMethod]
        public void movimientos_37806_4()
        {

            //no filtras por punto de venta



            int pv = -1;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("SOJA", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("ZARATE - TERMINAL LAS PALMAS", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("AMAGGI ARGENTINA S.A.", SC);
            DateTime desde = new DateTime(2017, 3, 23);
            DateTime desde2 = new DateTime(2017, 5, 9);
            DateTime hasta = new DateTime(2017, 5, 10);
            DateTime hasta2 = new DateTime(2017, 5, 11);


            var existencias1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario, pv);
            var existencias2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde2, idarticulo, destino, destinatario, pv);
            Debug.Print(existencias1.ToString());
            var existenciasTotales = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta, idarticulo, destino, destinatario, pv);

            var existencias3 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta2, idarticulo, destino, destinatario, pv);

            string sTitulo = "";






            // esto es cómo lo calcula GeneroDataTablesDeMovimientosDeStock





            var sql = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                    "", "", "", 1, 0,
                    CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
                    destinatario, -1,
                     -1, idarticulo, -1, destino,
                    CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
                     desde, hasta, pv, ref sTitulo);

            decimal MOVperiodo1 = 0;


            var dt = EntidadManager.ExecDinamico(SC, "select isnull(sum(netoproc),0) as total  from (" + sql + ") as C", 200);

            decimal CPperiodo1 = Convert.ToDecimal(dt.Rows[0][0]);
            decimal tot1 = Convert.ToDecimal(existencias1) + CPperiodo1 + MOVperiodo1;

            //Assert.AreEqual(tot1, existenciasTotales);






            decimal MOVperiodo2 = 0;

            var sql2 = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                    "", "", "", 1, 0,
                    CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
                    destinatario, -1,
                     -1, idarticulo, -1, destino,
                    CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
                     desde2, hasta, pv, ref sTitulo);

            var dt2 = EntidadManager.ExecDinamico(SC, "select isnull(sum(netoproc),0) as total  from (" + sql2 + ") as C", 200);

            decimal CPperiodo2 = Convert.ToDecimal(dt2.Rows[0][0]);
            decimal tot2 = Convert.ToDecimal(existencias2) + CPperiodo2 + MOVperiodo2;

            //Assert.AreEqual(tot2, existenciasTotales);









            DataTable dtCDPs = null;
            object dtMOVs = null, dt3 = null;


            //estoy usando dos GeneroDataTablesDeMovimientosDeStock!!! (uno en gerenciales y el otro en el nomrmal)

            LogicaInformesWilliams.GeneroDataTablesDeMovimientosDeStock(ref dtCDPs, ref dt3, ref dtMOVs, destinatario, destino, idarticulo, desde, hasta, SC, pv);

            // no puedo usar el RebindReportViewerLINQ_Excel porq este informe tiene su funcion especial para pasarle varios datasets
            //Movimientos_RebindReportViewer("ProntoWeb\Informes\Movimientos.rdl", dtCDPs, dt2, dtMOVs, fechadesde, fechahasta, idDestino, idArticulo, idDestinatario)



        }









        [TestMethod]
        public void diferencias_estadisticasdescargas_y_resumen_41321()
        {

            // En el periodo anterior sigue habiendo bnastante diferencia
            // Si filtra por "entrega", aparecen cartas en "exportacion" porque de esas familias hay "Originales" en ese modo


            ReportParameter p2 = null;

            var desde = new DateTime(2016, 11, 1);
            var hasta = new DateTime(2017, 5, 31);
            var desdeAnt = new DateTime(2015, 11, 1); //nov
            var hastaAnt = new DateTime(2016, 5, 31); //mayo
                                                      //desde = desdeAnt;
                                                      //hasta = hastaAnt;

            var MinimoNeto = 0;
            var topclie = 99999;
            var pv = -1;
            var ModoExportacion = "Entregas";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas; //CartaDePorteManager.enumCDPestado.Todas;








            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);
            var q4 = db.fSQL_GetDataTableFiltradoYPaginado(
                                0, 9999999, (int)estado, "", -1, -1,
                                -1, -1, -1, -1, -1,
                                -1, 0, ModoExportacion,
                                    desde, hasta, pv,
                                    null, false, "", "",
                                -1, null, 0, "", "Todos")
                          .Select(x => new { x.IdCartaDePorte, x.NetoFinal, x.Exporta, x.PuntoVenta }).ToList();

            var tot = q4.Sum(x => x.NetoFinal);
            var totelev = q4.Where(x => x.Exporta == "SI" && x.PuntoVenta == 1).Sum(x => x.NetoFinal);
            var totentreg = q4.Where(x => x.Exporta != "SI" && x.PuntoVenta == 1).Sum(x => x.NetoFinal);






            // por qué me muestra exportaciones si las estoy excluyendo? -porque pueden tener una 
            // copia de entregas. -Entonces por qué en produccion no se estan colando???
            // -creo q alla en produccion estaban desactualizados la funcsql y el store. Ahora sí se cuelan alla tambien... 

            var q = ConsultasLinq.EstadisticasDescargas(ref p2,
                                            desde.ToString(), hasta.ToString(),
                                            desdeAnt.ToString(), hastaAnt.ToString(),
                                            "Personalizar",
                                            pv, ModoExportacion, SC, -1, -1, -1, estado);


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
            string output = "";

            ReportParameter[] yourParams = new ReportParameter[2];
            yourParams[0] = new ReportParameter("Titulo", "jhjh");
            yourParams[1] = p2;

            CartaDePorteManager.RebindReportViewerLINQ_Excel(ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Estadísticas de Toneladas descargadas Sucursal-Modo.rdl", q, ref output, yourParams);

            System.Diagnostics.Process.Start(output);








            string output2 = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
            ReportParameter[] yourParams2 = new ReportParameter[9];
            yourParams2[0] = new ReportParameter("FechaDesde", desde.ToString());
            yourParams2[1] = new ReportParameter("FechaHasta", hasta.ToString());
            yourParams2[2] = new ReportParameter("FechaDesdeAnterior", desdeAnt.ToString());
            yourParams2[3] = new ReportParameter("FechaHastaAnterior", hastaAnt.ToString());
            yourParams2[4] = new ReportParameter("bMostrar1", "true");
            yourParams2[5] = new ReportParameter("bMostrar2", "true");
            yourParams2[6] = new ReportParameter("bMostrar3", "true");
            yourParams2[7] = new ReportParameter("bMostrar4", "true");
            yourParams2[8] = new ReportParameter("bMostrar5", "true");

            var s = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                      "Williams - Resumen de Totales Generales.rdl", yourParams2, ref output2, false);

            System.Diagnostics.Process.Start(output2);






            if (false)
            {

                string output4 = @"C:\Users\Administrador\Desktop\Informe" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xls";
                ReportParameter[] yourParams4 = new ReportParameter[9];
                yourParams4[0] = new ReportParameter("FechaDesde", desdeAnt.ToString());
                yourParams4[1] = new ReportParameter("FechaHasta", hastaAnt.ToString());
                yourParams4[2] = new ReportParameter("FechaDesdeAnterior", desdeAnt.ToString());
                yourParams4[3] = new ReportParameter("FechaHastaAnterior", hastaAnt.ToString());
                yourParams4[4] = new ReportParameter("bMostrar1", "true");
                yourParams4[5] = new ReportParameter("bMostrar2", "true");
                yourParams4[6] = new ReportParameter("bMostrar3", "true");
                yourParams4[7] = new ReportParameter("bMostrar4", "true");
                yourParams4[8] = new ReportParameter("bMostrar5", "true");

                var s4 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal,
                          "Williams - Resumen de Totales Generales.rdl", yourParams4, ref output4, false);

                System.Diagnostics.Process.Start(output4);

            }







            if (false)
            {
                // no tiene sentido, son una banda...  -Si, son una banda, pero es util igual!!!

                string output3 = "";
                var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();
                dr["ModoImpresion"] = "Speed"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
                dr["Emails"] = "mscalella911@gmail.com";
                dr["Vendedor"] = -1;
                dr["CuentaOrden1"] = -1;
                dr["CuentaOrden2"] = -1;
                dr["IdClienteAuxiliar"] = -1; ;
                dr["Corredor"] = -1;
                dr["Entregador"] = -1;
                dr["Destino"] = -1;
                dr["Procedencia"] = -1;
                dr["FechaDesde"] = desde;
                dr["FechaHasta"] = hasta;
                dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
                dr["Modo"] = ModoExportacion;
                dr["EnumSyngentaDivision"] = "";
                dr["EsPosicion"] = false;
                dr["IdArticulo"] = -1;

                string titulo = "";
                string sError = "", sError2 = "";
                string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
                string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";
                long lineas = 0;
                int tiemposql = 0;
                int tiempoinf = 0;

                output3 = CartaDePorteManager.generarNotasDeEntregaConReportViewer_ConServidorDeInformes(SC, desde, hasta, dr, estado, ref lineas, ref titulo, inlinePNG, pv, ref tiemposql, ref tiempoinf, false, null, 9999999);


                System.Diagnostics.Process.Start(output3);


            }
        }







        [TestMethod]
        public void syngenta_webservice_30920_2_ftp()
        {

            //            sFTP: 192.208.44.90
            //Carpeta: /UAT/Ready
            //Usuario: sappo_test
            //Password: 4R04475j


            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Syngenta_10feb2017_115941.xlsx";

            var s = new ServicioCartaPorte.servi();

            s.UploadFtpFile("goragora.com.ar", "/public_ftp/incoming", archivoExcel, "maruxs", "ns5aK!cvai0C");

            //s.CopyFileFTP("ftp://192.208.44.90/", "/UAT/Ready", archivoExcel, "sappo_test", "4R04475j");
            s.UploadFtpFile(ConfigurationManager.AppSettings["SyngentaFTPdominio"],
                            ConfigurationManager.AppSettings["SyngentaFTPdir"],
                            archivoExcel,
                            ConfigurationManager.AppSettings["SyngentaFTPuser"],
                            ConfigurationManager.AppSettings["SyngentaFTPpass"]);



        }



        [TestMethod]
        public void syngenta_webservice_30920()
        {
            // mandar una tanda

            int idcliente = 4333; //syngenta

            var dbcartas = CartaDePorteManager.ListadoSegunCliente(SC, idcliente, new DateTime(2016, 11, 1), new DateTime(2016, 11, 30), CartaDePorteManager.enumCDPestado.DescargasMasFacturadas);

            var s = new ServicioCartaPorte.servi();




            var endpointStr = ConfigurationManager.AppSettings["SyngentaServiceEndpoint"]; //  @"https://oasis-pi-nonprod.syngenta.com/uat/XISOAPAdapter/MessageServlet?senderParty=&senderService=Srv_BIT_BarterService&receiverParty=&receiverService=&interface=LoadDeclarationSoap_send_out_asy&interfaceNamespace=urn:broker:o2c:s:global:delivery:loaddeclaration:100";
            var UserName = ConfigurationManager.AppSettings["SyngentaServiceUser"];
            var Password = ConfigurationManager.AppSettings["SyngentaServicePass"];

            var x = s.WebServiceSyngenta(dbcartas, endpointStr, UserName, Password);

            // marcar fecha de cartas enviadas, loguar tanda de cartas enviadas para que 
            // sepan qué excel tienen que generar (el webservice solo manda un mail si hubo error, no tengo notificacion de otro tipo)

            // pagina de log o por lo menos de estado del envio de datos a syngenta.
            //                 noenviadas=Func();


            string DIRFTP = DirApp + @"\DataBackupear\";
            string nombre = DIRFTP + "Syngenta_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            s.GenerarExcelSyngentaWebService(x, nombre); // 3 horas 

            System.Diagnostics.Process.Start(nombre);

            return;


            s.CopyFileFTP(nombre, "username", "password#");   // 4 horas

            //return Log; // pagina de log o por lo menos de estado del envio de datos a syngenta. 3 horas 


            /*
            . El Web Service no devolverá ningún dato que haga referencia en cuanto a si se procesó bien o tuvo errores la interface.
    La interface será procesa por Syngenta y si la misma no puede ser procesada correctamente por contener errores en los datos 
    u otra validación; se enviara un mail con el detalle del procesamiento y error al mail indicado por el entregador para esta 
            interface como así también dicho mail será enviado de la misma forma al responsable de Canje por parte de Syngenta.
             * 
             * 
             * */


            // que pasa si alguien anula una carta de syngenta?
            //carta.anular();
            // -bueno, el que levanta la lista de cartas tiene que comparar la fecha de enviado con la de ultima modificacion



        }







        [TestMethod]
        public void nuevoTextoenFacturaElectronica_39138()
        {
            // https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=91981

            barras.EnviarFacturaElectronicaEMail(new List<int> { 89323, 89324 }, SC, false, "mscalella911@gmail.com");


        }


        [TestMethod]
        public void SessionDelLogin()
        {

            //explota BindTypeDropDown al buscar  Session(SESSIONPRONTO_glbIdUsuario) . No explota en el formulario de carta porque esta dentro de un try

        }




        [TestMethod]
        public void PegatinaRamalloBunge_23529_36711()
        {

            //explota

            string ms = "";

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\PORTE050041ramallo175.txt";  // tabs
                                                                                                                      // string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\Documentos\pegatinas\bungeramallo.txt";
                                                                                                                      //archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.d";   // punto y coma

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            //Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.BungeRamalloDescargaTexto, SC, 0,
                                    ref log, new DateTime(2016, 5, 1).ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);


        }





        [TestMethod]
        public void ListadoPrincipal()
        {

            CartaDePorteManager.ListaditoPrincipal(SC);


        }






        [TestMethod]
        public void SincroMonsanto_40195()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Monsanto", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", 3208, -1,
                -1, 3208,
                3208, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2017, 1, 1), new DateTime(2017, 1, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }





        [TestMethod]
        public void SincroLeiva_40189()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcorr = CartaDePorteManager.BuscarVendedorPorCUIT("30-71077157-6", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("LEIVA", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, idcorr,
                -1, -1,
                 -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 3, 1), new DateTime(2016, 3, 15),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }







        [TestMethod]
        public void SincroYPF_40143()
        {

            //        http://consultas.bdlconsultores.com.ar/AdminTest/template/desarrollo/Consulta.php?IdReclamo=40143&SinMenu=1
            //            "En el campo CUIT del proveedor debe ir el proveedor de YPF no el CUIT de YPF."

            //            Te adjunto ejemplo. El "cuit del proveedor" tira el de ypf y tiene que tirar:
            //* si solamente hay "titular de cp" el del titular.
            //*Si hay titular y remitente comercial.. el del "remitente comercial".
            //*Si hay titular, intermediario y remitente.. el del "remitente comercial".


            string sErrores = "", sTitulo = "";
            DemoProntoEntities db = null;



            var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC,
               "", "", "", 0, 1000, CartaDePorteManager.enumCDPestado.Facturadas
                  , "", 4333, -1,
               -1, 4333, 4333,
               -1, -1, -1,
               CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
               new DateTime(2016, 1, 1), new DateTime(2016, 1, 30),
                -1, ref sTitulo, "Ambas", false, "", ref db, "", -1, -1, 0, "", "Ambas").ToList();


            var output = SincronismosWilliamsManager.Sincronismo_YPF_ConLINQ(q, ref sErrores, "", SC);



            //registrosFiltrados = q.Count

            //If registrosFiltrados > 0 Then 'And sErrores = "" Then
            //    output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
            //                "ProntoWeb\Informes\Sincronismo YPF.rdl", _
            //                      q.ToDataTable, ArchivoExcelDestino) 'sTitulo)

            //    CambiarElNombreDeLaPrimeraHojaDeYPF(output)
            //End If

            //var sForzarNombreDescarga = "ENTREGADOR.CSV";
            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + sForzarNombreDescarga, true);


        }





        [TestMethod]
        public void problema_informe_38136()
        {
            ReportParameter p2 = null;

            var desde = new DateTime(2016, 11, 1);
            var hasta = new DateTime(2017, 5, 10);
            var desdeAnt = new DateTime(2015, 11, 1); //nov
            var hastaAnt = new DateTime(2016, 5, 10); //mayo
            var MinimoNeto = 0;
            var topclie = 99999;
            var pv = -1;
            var ModoExportacion = "Ambos";








            // [wCartasDePorte_TX_EstadisticasDeDescarga]
            var q = ConsultasLinq.EstadisticasDescargas(ref p2,
                                            desde.ToString(), hasta.ToString(),
                                            desdeAnt.ToString(), hastaAnt.ToString(),
                                            "Personalizar",
                                            pv, ModoExportacion, SC, -1, -1, -1, CartaDePorteManager.enumCDPestado.Todas);


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();
            string output = "";

            ReportParameter[] yourParams = new ReportParameter[2];
            yourParams[0] = new ReportParameter("Titulo", "jhjh");
            yourParams[1] = p2;

            CartaDePorteManager.RebindReportViewerLINQ_Excel(ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Estadísticas de Toneladas descargadas Sucursal-Modo.rdl", q, ref output, yourParams);

            System.Diagnostics.Process.Start(output);







            var q2 = ConsultasLinq.rankingclientes(SC, "",
                 "", "", 0, 10, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, ModoExportacion, desde, hasta,
               pv, desdeAnt, hastaAnt, MinimoNeto, topclie);




            ReportViewer ReporteLocal2 = new Microsoft.Reporting.WebForms.ReportViewer();
            string output2 = "";

            ReportParameter[] yourParams2 = new ReportParameter[2];
            yourParams2[0] = new ReportParameter("TopClientes", topclie.ToString());
            yourParams2[1] = new ReportParameter("MinimoNeto", MinimoNeto.ToString());

            CartaDePorteManager.RebindReportViewerLINQ_Excel(ref ReporteLocal2, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Ranking de Clientes.rdl", q2, ref output2, yourParams2);

            System.Diagnostics.Process.Start(output2);








        }









        [TestMethod]
        public void DESCARGA_IMAGENES_22373_2_38132()
        {


            string archivo = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\2501323ago2016_100401_555332208-CP.jpg";
            string output = archivo + ".salida.jpg";
            string output2 = archivo + ".salida.tif";

            if (true)
                CartaDePorteManager.ResizeImage_ToTIFF(archivo, 0, 0, output2, "", "");
            else
            {
                CartaDePorteManager.ResizeImage(archivo, 300, 450, output, "", "");

                CartaDePorteManager.ResizeImage_ToTIFF(output, 800, 1100, output2, "", "");
            }


            System.Diagnostics.Process.Start(output2);
        }






        [TestMethod]
        public void _38132()
        {


            // con        560133361 falla
            // -si hago un filtro más chico que la incluya, la baja bien. Pinta q lo q 
            // jode es la 000560133357 o la 000560133362, q pesan mas de un mega cada una.


            /*

        Log Entry : 
    05/11/2017 13:34:06
    Error in: http://prontoclientes.williamsentregas.com.ar/ProntoWeb/CartaDePorteInformesAccesoClientes.aspx. Error Message:System.OutOfMemoryException
    Out of memory.
    at System.Drawing.Image.FromFile(String filename, Boolean useEmbeddedColorManagement)
    at System.Drawing.Image.FromFile(String filename)
    at CartaDePorteManager.ResizeImage_ToTIFF(String image, Int32 width, Int32 height, String newimagename, String sDirVirtual, String DirApp) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:line 6555
    at CartaDePorteManager.DescargarImagenesAdjuntas_TIFF(DataTable dt, String SC, Boolean bJuntarCPconTK, String DirApp, Boolean reducir) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\ManagerDebug\CartaDePorteManager.vb:line 6058
    System.Drawing

            */



            if (false)
            {
                string[] sss = {@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
                                              @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg"};

                ClassFlexicapture.SaveAsMultiPageTiff(
                                                     @"C:\Users\Administrador\Documents\bdl\New folder\assadfasdf.tiff",
                                                     sss
                                                     );
            }


            string titulo = "";
            var dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, "",
                 "", "", 0, 10, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2016, 5, 29), new DateTime(2016, 5, 30),
                0, ref titulo, "Ambas", false);


            var output = CartaDePorteManager.DescargarImagenesAdjuntas_TIFF(dt, SC, false, DirApp, true);
            System.Diagnostics.Process.Start(output);

        }







        [TestMethod]
        public void OCR_Postprocesamiento_ManotearExcel()
        {
            var excel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\ExportToXLS.xls";

            ClassFlexicapture.ManotearExcel(excel, "asdfasdf", "232324423");

        }


        [TestMethod]
        public void OCR_Preprocesamiento_paginacion_2()
        {

            //  probar los picos de IIS en las subidas de imagenes (en los dos importadores) -apuesto a que es la paginacion



            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            //zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Lote 09nov190213 cgoycochea PV4\Xerox WorkCentre 3550_20161109190032.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Xerox WorkCentre 3550_20170511174612.tif";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //ClassFlexicapture.TiffSplit_dea2(zipFile);
            //ClassFlexicapture.TiffSplit(zipFile);


            VaciarDirectorioTemp();


            //var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, false, false, 1);
            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, true, false, false, 1);
            //PreprocesarImagenesTiff

            string sError = "";



            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            //ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");
        }


        [TestMethod]
        public void OCR_Preprocesamiento_paginacion()
        {

            //  probar los picos de IIS en las subidas de imagenes (en los dos importadores) -apuesto a que es la paginacion



            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            //zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Lote 09nov190213 cgoycochea PV4\Xerox WorkCentre 3550_20161109190032.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Xerox WorkCentre 3550_20170511174612.tif";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //ClassFlexicapture.TiffSplit_dea2(zipFile);
            //ClassFlexicapture.TiffSplit(zipFile);


            VaciarDirectorioTemp();


            //var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, false, false, 1);
            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, false, false, 1);
            //PreprocesarImagenesTiff

            string sError = "";



            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            //ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");
        }







        [TestMethod]
        public void btnGenerarFacturas_Click()
        {

            //son todos lios con el KeepSelection q bien pueden venir por problemas con la sesion

            //  at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.b__5(<>f__AnonymousType0`2 <>h__TransparentIdentifier2) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 97
            //at System.Linq.Enumerable.WhereSelectEnumerableIterator`2.MoveNext()
            //at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
            //at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
            //at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.KeepSelection(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 104
            //at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.TraerLista(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 58
            //at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.TraerListaEnStringConComas(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 70
            //at CDPFacturacion.Validar2doPaso(DataTable& tablaEditadaDeFacturasParaGenerar)
            //at CDPFacturacion.btnGenerarFacturas_Click(Object sender, EventArgs e)

        }



        [TestMethod]
        public void btnIrAlPaso2_Click()
        {
            // se estaria quejando porque en el IN (123123,4444,......) hay una banda de ids  -No. En este caso es por timeout (y no son tantos ids)
            //- Falta un indice en wGrillaPersistencia. Lo volaron en alguna actualizacion??

            /*  
              SELECT DISTINCT 0 as ColumnaTilde ,IdCartaDePorte, CDP.IdArticulo,               
              NumeroCartaDePorte, SubNumeroVagon,CDP.SubnumeroDeFacturacion, FechaArribo, FechaDescarga,  
              CLIVEN.razonsocial as FacturarselaA,  CLIVEN.idcliente as IdFacturarselaA              		  ,isnull(CLIVEN.Confirmado,'NO') as Confirmado,           
              CLIVEN.IdCodigoIVA  		  ,CLIVEN.CUIT,           '' as ClienteSeparado ,  		 dbo.wTarifaWilliams(CLIVEN.idcliente,CDP.IdArticulo,CDP.Destino, case when isnull(Exporta,'NO')='SI' then 1 else 0 end,0) as TarifaFacturada            ,
              Articulos.Descripcion as  Producto,         NetoFinal  as  KgNetos , Corredor as IdCorredor, Vendedor as IdTitular,   
             CDP.CuentaOrden1 as IdIntermediario, CDP.CuentaOrden2 as IdRComercial, CDP.Entregador as IdDestinatario,             		 
             CLIVEN.Razonsocial as   Titular  ,        CLICO1.Razonsocial as   Intermediario  ,     		 CLICO2.Razonsocial as   [R. Comercial]  ,        CLICOR.Nombre as    [Corredor ],      		 
             CLIENT.Razonsocial  as  [Destinatario],          LOCDES.Descripcion   as  DestinoDesc  		 ,         		 LOCORI.Nombre as    [Procedcia.] ,            CDP.Destino as IdDestino, CDP.AgregaItemDeGastosAdministrativos    from CartasDePorte CDP  inner join wGrillaPersistencia  on CDP.IdCartaDePorte=wGrillaPersistencia.idrenglon and wGrillaPersistencia.Sesion='0vrbvt41i4ikbcrkkfle5s5r'   LEFT OUTER JOIN Clientes CLIVEN ON CDP.Vendedor = CLIVEN.IdCliente     LEFT OUTER JOIN ListasPreciosDetalle LPD ON CLIVEN.idListaPrecios = LPD.idListaPrecios    LEFT OUTER JOIN Clientes CLICO1 ON CDP.CuentaOrden1 = CLICO1.IdCliente     LEFT OUTER JOIN Clientes CLICO2 ON CDP.CuentaOrden2 = CLICO2.IdCliente     LEFT OUTER JOIN Vendedores CLICOR ON CDP.Corredor = CLICOR.IdVendedor     LEFT OUTER JOIN Clientes CLICORCLI ON CLICORCLI.idcliente  = (select top 1 idcliente from clientes c1 where c1.RazonSocial = CLICOR.Nombre)     LEFT OUTER JOIN Clientes CLIENT ON CDP.Entregador = CLIENT.IdCliente     LEFT OUTER JOIN Articulos ON CDP.IdArticulo = Articulos.IdArticulo   
                  LEFT OUTER JOIN Transportistas TRANS ON CDP.IdTransportista = TRANS.IdTransportista    
                      LEFT OUTER JOIN Choferes CHOF ON CDP.IdChofer = CHOF.IdChofer   
                          LEFT OUTER JOIN Localidades LOCORI ON CDP.Procedencia = LOCORI.IdLocalidad     
             LEFT OUTER JOIN WilliamsDestinos LOCDES ON CDP.Destino = LOCDES.IdWilliamsDestino    
             where isnull(CDP.IdClienteAFacturarle,-1) <= 0  
              AND IdCartaDePorte IN (2864169,2861327,2861328,2838096,2869161,2836224,2836220,2836221,2834120,2838028,2838029,2834108,2878352,
              2881439,2864225,
              2856459,2858824,2853489,2853464,2856473,2851214,2851208,2858840,2861306,2861304,2863776,2884665,2884663,2881551,2881542,
              2855520,2855525,2839318,2829393,2829395,2829396,2829397,2829398,2829399,2829357,2829337,2829344,2829361,2830267,2829855,
              2830232,2830235,2830237,2883414,2883415,2881537,2883405,2883391,2863743,2863734,2865422,2865417,2867685,2867674,2866646,
              2863670,2866021,2865428,2865447,2883407,2839719,2844618,2837396,2841689,2872127,2872128,2872129,2866406,2866407,2867894
              ,2866172,2865262,2862972,2865257,2871188,2871189,2871209,2871211,2865284,2879207,2880075,2880076,2880100,2870756,2870757,
              2870758,2870759,2870760,2870761,2876849,2877457,2877118,2881951,2882819,2881201,2874745,2852148,2880079,2882843,2837472,
              2837474,2837475,2831137,2833519,2860281,2855434,2860284,2860298,2860277,2860295,2862975,2862980,2882816,2880087,2866183,2866191,
              2842239,2836339,2835962,2842502,2842503,2864192,2864209,2862513,2865317,2862129,2864195,2864189,2861665,2861666,2862125,2864218,
              2864219,2864601,2865409,2865391,2865393,
              2865395,2867897,2869257,2864495,2869164,2869165,2865320,2869995,2869253,2873795,2873780,2873776,2860472) 

             * 
             * 
             * 
             * 
             * 
             * __________________________

      Log Entry : 
      05/03/2017 14:08:06
      Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
      __________________________



                      Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.Data.SqlClient.SqlException
      Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.
         at Microsoft.VisualBasic.CompilerServices.Symbols.Container.InvokeMethod(Method TargetProcedure, Object[] Arguments, Boolean[] CopyBack, BindingFlags Flags)
         at Microsoft.VisualBasic.CompilerServices.NewLateBinding.CallMethod(Container BaseReference, String MethodName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, BindingFlags InvocationFlags, Boolean ReportErrors, ResolutionFailure& Failure)
         at Microsoft.VisualBasic.CompilerServices.NewLateBinding.ObjectLateCall(Object Instance, Type Type, String MemberName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, Boolean IgnoreReturn)
         at Microsoft.VisualBasic.CompilerServices.NewLateBinding.LateCall(Object Instance, Type Type, String MemberName, Object[] Arguments, String[] ArgumentNames, Type[] TypeArguments, Boolean[] CopyBack, Boolean IgnoreReturn)
         at Pronto.ERP.Dal.GeneralDB.ExecDinamico(String SC, String comandoSQLdinamico, Int32 timeoutSegundos)
         at Pronto.ERP.Bll.EntidadManager.ExecDinamico(String SC, String sComandoDinamico, Int32 timeoutSegundos) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\EntidadManager.vb:line 816
         at LogicaFacturacion.SQLSTRING_FacturacionCartas_por_Titular(String sWHEREadicional, String sc, String sesionid) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 7872
         at LogicaFacturacion.generarTabla(String SC, Object& pag, Object& sesionId, Int64 iPageSize, Int32 puntoVenta, DateTime desde, DateTime hasta, String sLista, Boolean bNoUsarLista, Int64 optFacturarA, String agruparArticulosPor, Object& filas, Object& slinks, String sesionIdposta) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 2159
         at LogicaFacturacion.GetDatatableAsignacionAutomatica(String SC, Object& pag, Object& sesionId, Int64 iPageSize, Int32 puntoVenta, DateTime desde, DateTime hasta, String sLista, String sWHEREadicional, Int64 optFacturarA, String txtFacturarATerceros, String HFSC, String txtTitular, String txtCorredor, String txtDestinatario, String txtIntermediario, String txtRcomercial, String txt_AC_Articulo, String txtProcedencia, String txtDestino, String txtBuscar, String cmbCriterioWHERE, String cmbmodo, String optDivisionSyngenta, Int64 startRowIndex, Int64 maximumRows, String txtPopClienteAuxiliar, String& sErrores, String txtFacturarA, String agruparArticulosPor, Object& filas, Object& slinks, String sesionIdposta) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 2277
         at CDPFacturacion.dtDatasourcePaso2(String& sErr, Int64 startRowIndex, Int64 maximumRows)
         at CDPFacturacion.getGrillaPaso2(Boolean bRefrescarTarifa, String& sErr, Int64 startRowIndex, Int64 maximumRows)
         at CDPFacturacion.gv2ReBind(Boolean bRefrescarTarifa)
         at CDPFacturacion.btnIrAlPaso2_Click(Object sender, EventArgs e)
             * 
             * */

            //SQLSTRING_FacturacionCartas_por_Titular

            //        GetDatatableAsignacionAutomatica


        }




        /*

        [TestMethod]
        public void btnPaginaAvanza2()
        {
            http://ltuttini.blogspot.com.ar/2012/02/

            ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.KeepSelection(GridView2);

    RestoreSelection(GridView2)
            //            System.NullReferenceException
            //Message:	Object reference not set to an instance of an object.

            //            Trace:	at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.b__5(<>f__AnonymousType0`2 <>h__TransparentIdentifier2) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 97
            //at System.Linq.Enumerable.WhereSelectEnumerableIterator`2.MoveNext()
            //at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection)
            //at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source)
            //at ProntoCSharp.FuncionesUIWebCSharpEnDllAparte.KeepSelection(GridView grid) in E:\Backup\BDL\ProntoWeb\Soluciones\ClassLibrary1\Class1.cs:line 104
            //at CDPFacturacion.btnPaginaAvanza2_Click(Object sender, EventArgs e)
        }



        public static void KeepProductInfo(GridView grid)
        {
            //
            // se obtienen la lista de producto con informacion proporcionada por el usuario
            //
            var listProd = from item in grid.Rows.Cast<GridViewRow>()
                           let amount = ((TextBox)item.FindControl("txtAmount")).Text
                           let shipper = ((DropDownList)item.FindControl("ddlShippers")).SelectedValue
                           where !(string.IsNullOrEmpty(amount) || shipper == "0")
                           select new ProductInfo()
                           {
                               Id = Convert.ToInt32(grid.DataKeys[item.RowIndex].Value),
                               Amount = Convert.ToInt32(amount),
                               Shipper = Convert.ToInt32(shipper)
                           };

            //
            // se recupera de session la lista de seleccionados previamente
            //
            List<ProductInfo> prodInfo = HttpContext.Current.Session["ProdInfo"] as List<ProductInfo>;

            if (prodInfo == null)
                prodInfo = new List<ProductInfo>();

            //
            // se cruzan todos los ingresados en la pagina actual, con los previamente conservados 
            // en Session, devolviendo solo aquellos donde no hay coincidencia
            //
            prodInfo = (from item in prodInfo
                        join item2 in listProd
                           on item.Id equals item2.Id into g
                        where !g.Any()
                        select item).ToList();

            //
            // se agregan la actualizacion realizada por el usuario
            //
            prodInfo.AddRange(listProd);

            HttpContext.Current.Session["ProdInfo"] = prodInfo;

        }




        public static void RestoreProductInfo(GridView grid)
        {

            List<ProductInfo> prodInfo = HttpContext.Current.Session["ProdInfo"] as List<ProductInfo>;

            if (prodInfo == null)
                return;

            //
            // se comparan los registros de la pagina del grid con los recuperados de la Session
            // los coincidentes se devuelven para ser seleccionados
            //
            var result = (from item in grid.Rows.Cast<GridViewRow>()
                          join item2 in prodInfo
                              on Convert.ToInt32(grid.DataKeys[item.RowIndex].Value) equals item2.Id into g
                          where g.Any()
                          select new
                          {
                              gridrow = item,
                              prodonfo = g.First()
                          }).ToList();

            //
            // se recorre cada item para asignar la informacion 
            //
            result.ForEach(x =>
            {
                ((TextBox)x.gridrow.FindControl("txtAmount")).Text = Convert.ToString(x.prodonfo.Amount);
                ((DropDownList)x.gridrow.FindControl("ddlShippers")).SelectedValue = Convert.ToString(x.prodonfo.Shipper);
            });

        }

        */

        [TestMethod]
        public void Urenport_4()
        {

            // es precisamente así:
            /*
             * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
             * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
            it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                an "External table is not in the expected format" exception.
                    Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
            it's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
            all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
            */


            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 951-28042017.xls";

            //FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(archivoExcel);
            //FuncionesGenericasCSharp.GetExcel4_ExcelDataReader(archivoExcel);

            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }







        [TestMethod]
        public void excelDetalladoPaso2AsistenteFactur_37875()
        {


            //            Log Entry : 
            //04/27/2017 15:10:49
            //Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message: PreviewDetalladoDeLaGeneracionEnPaso2() Convierto a Excel
            //__________________________

            //Log Entry : 
            //04/27/2017 15:10:49
            //Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/CDPFacturacion.aspx?tipo=Confirmados. Error Message:System.IO.IOException
            //El archivo ya está abierto.
            //   at Microsoft.VisualBasic.FileSystem.FileOpen(Int32 FileNumber, String FileName, OpenMode Mode, OpenAccess Access, OpenShare Share, Int32 RecordLength)
            //   at LogicaFacturacion.DataTableToExcel(DataTable pDataTable, String titulo) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 8587
            //   at LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(Int32 optFacturarA, String txtFacturarATerceros, String SC, Boolean EsteUsuarioPuedeVerTarifa, Object ViewState, String txtFechaDesde, String txtFechaHasta, String fListaIDs, String SessionID, Int32 cmbPuntoVenta, String cmbAgruparArticulosPor, Boolean SeEstaSeparandoPorCorredor) in C:\Users\Administrador\Documents\bdl\pronto\BussinessLogic\LogicaFacturacion.vb:line 8571
            //   at CDPFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2()
            //   at CDPFacturacion.lnkVistaDetallada_Click(Object sender, EventArgs e)
            //   at System.Web.UI.WebControls.LinkButton.OnClick(EventArgs e)
            //   at System.Web.UI.WebControls.LinkButton.RaisePostBackEvent(String eventArgument)
            //   at System.Web.UI.WebControls.LinkButton.System.Web.UI.IPostBackEventHandler.RaisePostBackEvent(String eventArgument)
            //   at System.Web.UI.Page.RaisePostBackEvent(IPostBackEventHandler sourceControl, String eventArgument)
            //   at System.Web.UI.Page.RaisePostBackEvent(NameValueCollection postData)
            //   at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)
            //Microsoft.VisualBasic
            //__________________________



            int optFacturarA = 3;
            string txtFacturarATerceros = "";
            bool EsteUsuarioPuedeVerTarifa = true;
            System.Web.UI.StateBag ViewState = new System.Web.UI.StateBag();
            string txtFechaDesde = "3/1/2012";
            string txtFechaHasta = "3/31/2012";
            string ListaCartasIDs = "99500,99501";
            string SessionID = "sfsfasfd12asdfsa3123";
            int cmbPuntoVenta = -1;
            string cmbAgruparArticulosPor = "";
            bool SeEstaSeparandoPorCorredor = false;

            ViewState["pagina"] = 1;
            ViewState["sesionId"] = SessionID;
            ViewState["filas"] = 10;



            string[] tokens = ListaCartasIDs.Split(',');
            var l = tokens.ToList();
            LogicaFacturacion.GridCheckboxPersistenciaBulk(SC, SessionID, l.Select(int.Parse).ToList());


            var output = LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(optFacturarA, txtFacturarATerceros, SC,
                                                   EsteUsuarioPuedeVerTarifa, ViewState, txtFechaDesde, txtFechaHasta,
                                                    ListaCartasIDs, SessionID, cmbPuntoVenta, cmbAgruparArticulosPor,
                                                   SeEstaSeparandoPorCorredor);

            System.Diagnostics.Process.Start(output);
        }







        [TestMethod]
        public void SincroGESAGRO_37858()
        {




            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-50930520-6", SC, "");


            var output2 = SincronismosWilliamsManager.GenerarSincro("AMAGGI (DESCARGAS)", ref sErrores, SC, "dominio", ref sTitulo
                          , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                       "", idcli, -1,
                  -1, idcli,
                   idcli, -1, -1, -1,
                   CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                  new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                  -1, "Ambas", false, "", "", -1, ref registrosf, 4000);


            var output = SincronismosWilliamsManager.GenerarSincro("Gesagro", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);








            System.Diagnostics.Process.Start(output);
            System.Diagnostics.Process.Start(output2);
        }






        [TestMethod]
        public void problema_informe_totalespormes_4()
        {
            ReportParameter p2 = null;
            string sTitulo = "";

            var q4 = ConsultasLinq.totpormes(SC,
             "", "", "", 1, 10,
              CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
             -1, -1,
             -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
              new DateTime(2014, 1, 1),
              new DateTime(2014, 2, 1),
              -1, ref sTitulo, "Ambas", false, "");
        }


        [TestMethod]
        public void problema_informe_totalespormes_totpormesmodo()
        {
            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.totpormesmodo(SC,
                       "", "", "", 1, 10,
                        CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                        new DateTime(2014, 1, 1),
                        new DateTime(2014, 1, 1),
                        -1, ref sTitulo, "Ambas", false, "");


        }


        [TestMethod]
        public void problema_informe_totalespormes_totpormessucursal()
        {
            ReportParameter p2 = null;
            string sTitulo = "";

            var q2 = ConsultasLinq.totpormessucursal(SC,
              "", "", "", 1, 10,
               CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
              -1, -1,
              -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
               new DateTime(2014, 1, 1),
               new DateTime(2014, 1, 1),
               -1, ref sTitulo, "Ambas", false, "");


        }


        [TestMethod]
        public void problema_informe_totalespormes_totpormesmodoysucursal()
        {
            ReportParameter p2 = null;
            string sTitulo = "";

            //An Error Has Occurred! System.NotSupportedException: This function can only be invoked from LINQ to Entities. at System.Data.Entity.SqlServer.SqlFunctions.StringConvert(Nullable`1 number) at Read_VB$AnonymousType_98`10(ObjectMaterializer`1 ) at System.Data.Linq.SqlClient.ObjectReaderCompiler.ObjectReader`2.MoveNext() at System.Collections.Generic.List`1..ctor(IEnumerable`1 collection) at System.Linq.Enumerable.ToList[TSource](IEnumerable`1 source) at ConsultasLinq.totpormessucursal(String SC, String ColumnaParaFiltrar, String TextoParaFiltrar, String sortExpression, Int64 startRowIndex, Int64 maximumRows, enumCDPestado estado, String QueContenga, Int32 idVendedor, Int32 idCorredor, Int32 idDestinatario, Int32 idIntermediario, Int32 idRemComercial, Int32 idArticulo, Int32 idProcedencia, Int32 idDestino, FiltroANDOR AplicarANDuORalFiltro, String ModoExportacion, DateTime fechadesde, DateTime fechahasta, Int32 puntoventa, String& sTituloFiltroUsado, String optDiv

            var q3 = ConsultasLinq.totpormesmodoysucursal(SC,
              "", "", "", 1, 10,
               CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
              -1, -1,
              -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
               new DateTime(2014, 1, 1),
               new DateTime(2014, 1, 1),
               -1, ref sTitulo, "Ambas", false, "");

        }






        [TestMethod]
        public void movimientos_37806_3()
        {

            //no filtras por punto de venta



            int pv = -1;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("SOJA", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("ZARATE - TERMINAL LAS PALMAS", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("AMAGGI ARGENTINA S.A.", SC);
            DateTime desde = new DateTime(2017, 4, 19);
            DateTime hasta = new DateTime(2017, 4, 20);


            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario, pv);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta, idarticulo, destino, destinatario, pv);

            string sTitulo = "";

            // esto es cómo lo calcula GeneroDataTablesDeMovimientosDeStock

            var sql = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                    "", "", "", 1, 0,
                    CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
                    destinatario, -1,
                     -1, idarticulo, -1, destino,
                    CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
                     desde, hasta, pv, ref sTitulo, "Ambas");

            var dt = EntidadManager.ExecDinamico(SC, "select isnull(sum(netoproc),0) as total  from (" + sql + ") as C", 200);

            decimal total = Convert.ToDecimal(dt.Rows[0][0]);



            DataTable dtCDPs = null;
            object dtMOVs = null, dt2 = null;

            LogicaInformesWilliams.GeneroDataTablesDeMovimientosDeStock(ref dtCDPs, ref dt2, ref dtMOVs, destinatario, destino, idarticulo, desde, hasta, SC, pv);
        }




        [TestMethod]
        public void Urenport_32235_excelqueesHtml_3()
        {

            // es precisamente así:
            /*
             * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
             * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
            it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                an "External table is not in the expected format" exception.
                    Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
            it's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
            all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
            */


            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\prueba.xls";

            //FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(archivoExcel);
            //FuncionesGenericasCSharp.GetExcel4_ExcelDataReader(archivoExcel);

            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }



        //        36711 - Ramallo – PRIORIDAD     ????

        //31206 - MAPA DE MERCADO ESTRATEGICO- PRIORIDAD



        [TestMethod]
        public void InfoAdicionalDelUsuario()
        {

            var a = CartaDePorteManager.TraerCUITClientesSegunUsuario("alalal", SC, scbdlmasterappconfig);
            var b = UserDatosExtendidosManager.TraerClientesRelacionadoslDelUsuario("alalal", scbdlmasterappconfig);
            var d = UserDatosExtendidosManager.UpdateClientesRelacionadoslDelUsuario("alalal", scbdlmasterappconfig, "asfsafas");
        }




        [TestMethod]
        public void SincroBTG_noFiltraElContrato()
        {
            //            Estoy necesitando que en la exportación de los TXT se agregue el campo de Calidad conforme.

            //51 – Calidad Conforme
            //Alfa
            //2
            //Acepta los valores Sí/No

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";

            string contrato = "9";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-50930520-6", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("BTG PACTUAL [BIT]", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                -1, "Ambas", false, contrato, "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void InformeMapaEstrategico_31206()
        {



            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";

            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();



            ReportParameter[] yourParams = new ReportParameter[9];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("Producto", "");
            yourParams[2] = new ReportParameter("Puerto", "");
            yourParams[3] = new ReportParameter("Cliente", "");
            yourParams[4] = new ReportParameter("TonsDesde", "0");
            yourParams[5] = new ReportParameter("TonsHasta", "9999");
            yourParams[6] = new ReportParameter("FechaDesde", (new DateTime(1000, 1, 1)).ToString());
            yourParams[7] = new ReportParameter("FechaHasta", (new DateTime(3000, 1, 1)).ToString());
            yourParams[8] = new ReportParameter("Modo", "entregas");


            // Armar un informe de tipo de tabla dinámica que se pueda filtrar por Producto, Puerto, Clientes, Toneladas (desde / hasta) y Modo.
            // El reporte será una tabla dinámica, el primer nivel la localidad de procedencia y el segundo el titular. El dato son las TN descargadas.



            var output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                  "MapaArgentinaProcedenciaCartasPorte.rdl", yourParams, ref ArchivoExcelDestino, false);



            System.Diagnostics.Process.Start(output);


        }






        [TestMethod]
        public void SincroLosGrobo_37815()
        {
            //            Estoy necesitando que en la exportación de los TXT se agregue el campo de Calidad conforme.

            //51 – Calidad Conforme
            //Alfa
            //2
            //Acepta los valores Sí/No

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-50930520-6", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("LOS GROBO", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void FormatoSpeedagro_37831()
        {


            //-Les acabo de pasar correo con la solicitud del cliente nuevo SPEEDAGRO para que en el exel de descargas que pasa el sistema, salga el cuit a su lado titular, intermediario, rem comercial, corredor, transporte, chofer, etc, etc
            //    -Martín,Lo que deben hacer es cuando arman el mail de Speedagro, elegir el formato "Excel GroboCuits" que es el formato que se está usando con Grobocopatel.
            //    -Andres, ahi me hace la devolucion SpeedAgro, y estarian faltando los cuit del destinatario y corredor. Resto estaria ok.Podes avanzar con esto ? Abrazo Martin

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            dr["ModoImpresion"] = "Speed"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
                                           //dr["ModoImpresion"] = "ExcHc";


            //ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcHtm" Then
            //    'este es de servidor, así que saco el path
            //    rdl = "Listado general de Cartas de Porte (simulando original) con foto 2"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "EHOlav" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) Olavarria"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "HImag2" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) para html con imagenes"





            //dr["ModoImpresion"] = "HtmlIm";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }









        [TestMethod]
        public void movimientos_37806_2()
        {




            int pv = 2;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("MAIZ", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("EL TRANSITO - ALFRED C TOEPFER", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("AMAGGI ARGENTINA S.A.", SC);
            DateTime desde = new DateTime(2012, 1, 1);
            DateTime hasta = new DateTime(2017, 3, 31);

            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario, pv);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta, idarticulo, destino, destinatario, pv);

            string sTitulo = "";

            // esto es cómo lo calcula GeneroDataTablesDeMovimientosDeStock

            var sql = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                    "", "", "", 1, 0,
                    CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
                    destinatario, -1,
                    -1, idarticulo, -1, destino,
                    CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
                     desde, hasta, -1, ref sTitulo, "Ambas");

            var dt = EntidadManager.ExecDinamico(SC, "select isnull(sum(netoproc),0) as total  from (" + sql + ") as C", 200);

            decimal total = Convert.ToDecimal(dt.Rows[0][0]);



            DataTable dtCDPs = null;
            object dtMOVs = null, dt2 = null;

            LogicaInformesWilliams.GeneroDataTablesDeMovimientosDeStock(ref dtCDPs, ref dt2, ref dtMOVs, destinatario, destino, idarticulo, desde, hasta, SC, pv);
        }








        [TestMethod]
        public void carta559344519_35603()
        {

            var ii = SQLdinamico.BuscaIdWilliamsDestinoPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, "TERMINAL 6"), SC);

        }



        [TestMethod]
        public void SincroLosGrobo_36699()
        {

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-50930520-6", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("LOS GROBO", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }









        [TestMethod]
        public void ServicioWebDescargas_36705_y_36749__incluir_posicion_para_bld_y_ctg_para_fyo()
        {

            ////Trust all certificates
            //System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            //var cerealnet = new WS_CartasDePorteClient();

            string usuario = "Mariano"; //"fyo";
            string clave = "pirulo!"; // "76075";
            string cuit = "30703605105";

            // var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            var respEntrega = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL_v2_00(usuario, clave, cuit,
                                            new DateTime(2016, 9, 1),
                                            new DateTime(2017, 1, 1), CartaDePorteManager.enumCDPestado.Posicion,
                                            SC, DirApp, scbdlmasterappconfig);


            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (CerealNet.WSCartasDePorte.analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            //Console.ReadKey();
        }







        [TestMethod]
        public void CampoEditableDeClientesRelacionadosAlUsuarioParaTirarInforme_28320()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;
            DemoProntoEntities db2 = null;


            string usuario = "Mariano"; //"BLD25MAYO"


            UserDatosExtendidosManager.UpdateClientesRelacionadoslDelUsuario(usuario, scbdlmasterappconfig, "20-12345678-1|20-20100767-5");




            var clientes = CartaDePorteManager.TraerCUITClientesSegunUsuario(usuario, SC, scbdlmasterappconfig).Where(x => x != "").ToList();

            //String aaa = ParametroManager.TraerValorParametro2(SC, "ClienteBLDcorredorCUIT").NullSafeToString() ?? "";
            //var sss = aaa.Split('|').ToList();


            var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC,
                     "", "", "", 1, 99999,
                      CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                     -1, -1,
                     -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                      new DateTime(2013, 1, 1),
                      new DateTime(2014, 1, 1),
                      -1, ref sTitulo, "Ambas", false, "", ref db2, "", -1, -1, 0, "", "Ambas");


            var q2 = q.Where(x => clientes.Contains(x.TitularCUIT) || clientes.Contains(x.IntermediarioCUIT) || clientes.Contains(x.RComercialCUIT))
                                    .ToList();


        }












        [TestMethod]
        public void movimientos_37806_1()
        {


            // originalmente era un movimiento simple, no un "asiento". lo que pasa
            // ahora es que toma los dos clientes como destinos o como origenes. es un embrollo


            int pv = 2;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("TRIGO PAN", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("ACA SAN LORENZO", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("AMAGGI ARGENTINA S.A.", SC);
            DateTime desde = new DateTime(2016, 1, 1);
            DateTime hasta = new DateTime(2015, 7, 27);

            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario, pv);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta, idarticulo, destino, destinatario, pv);

            string sTitulo = "";

            // esto es cómo lo calcula GeneroDataTablesDeMovimientosDeStock
            //var dtCDPs = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC,
            //        "", "", "", 1, 0,
            //        CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
            //        destinatario, -1,
            //        -1, idarticulo, -1, destino,
            //        CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
            //         desde, hasta, -1, ref sTitulo, "Ambas");

            var sql = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                    "", "", "", 1, 0,
                    CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
                    destinatario, -1,
                    -1, idarticulo, -1, destino,
                    CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
                     desde, hasta, -1, ref sTitulo, "Ambas");

            var dt = EntidadManager.ExecDinamico(SC, "select isnull(sum(netoproc),0) as total  from (" + sql + ") as C");

            decimal total = Convert.ToDecimal(dt.Rows[0][0]);



            DataTable dtCDPs = null;
            object dtMOVs = null, dt2 = null;

            LogicaInformesWilliams.GeneroDataTablesDeMovimientosDeStock(ref dtCDPs, ref dt2, ref dtMOVs, destinatario, destino, idarticulo, desde, hasta, SC, pv);
        }






        [TestMethod]
        public void SincroEstanar_36699()
        {

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-50930520-6", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("Estanar", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }







        [TestMethod]
        public void MailAmaggi_29728()
        {

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            dr["ModoImpresion"] = "Amaggi"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
                                            //dr["ModoImpresion"] = "ExcHc";


            //ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcHtm" Then
            //    'este es de servidor, así que saco el path
            //    rdl = "Listado general de Cartas de Porte (simulando original) con foto 2"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "EHOlav" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) Olavarria"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "HImag2" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) para html con imagenes"





            //dr["ModoImpresion"] = "HtmlIm";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }








        [TestMethod]
        public void SincroBragadense_36755()
        {

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-55549549-4", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("La Bragadense", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 14), new DateTime(2016, 1, 14),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void UrenportMasModificaciones_35603()
        {

            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"Trigo Pan\"},{\"field\":\"Producto\",\"op\":\"eq\",\"data\":\"MAIZ\"}]}";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.CartasPorte_DynamicGridData("IdCartaDePorte", "desc", 1, 999999, true, filtro,
                                                 "01/12/2016",
                                                 "30/01/2017",
                                                 0, -1, SC, "Mariano", "", 11);


        }





        [TestMethod]
        public void MostrarLogEnCartadeUrenport()
        {


            var dt = CartaDePorteManager.TraerLogDeCartaPorte(SC, 2737266, false);
            var s = CartaDePorteManager.TraerLogDeCartaPorteHtml(SC, 2737266, false);

        }





















        [TestMethod]
        public void OCR_alta_automatica_de_clientes_22172_36722()
        {


            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30710337892"));


            // FuncionesGenericasCSharp.CUITValido_DigitoVerificador
            // este son verdaderos. no les encontré cuit existente, pero tampoco a las otras 9 variantes de digito verificador
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30708142391"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30164632845")); // este pasa por verdadero. está bien? no le encontré cuit existente, pero tampoco a las otras 9 variantes de digito verificador
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30700809818")); // este pasa por verdadero. está bien? no le encontré cuit existente, pero tampoco a las otras 9 variantes de digito verificador
                                                                               // no hay algun servicio web de la afip para buscar cuits?




            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("13050795084"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("38763599059"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("38711815519"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("32769425127"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("33506737440"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("36700869918"));


            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido(""));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("asfasdfasdfasdf"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido(null));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("20"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30-53777127-4"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30-53772127-4"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30714018082"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30-71401308-2"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30-70359905-9"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30703539059"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30511355040"));




            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30-70914230-1"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30703142301"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30700142301"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30-70814230-1"));



            //            ACA:
            //10-50012088-2
            //30 50012088-2
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30-50012088-2"));
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("10-50012088-2"));


            //NIDERA:
            //33 50673744 9
            //31506732449

            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("31506732449"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("33 50673744 9"));
            //COMODITIES:
            //30 64087256 6

            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30 64087256 6"));

            //VICENTIN:
            //30600959629
            //30 50095962 9
            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30600959629"));
            Assert.IsTrue(FuncionesGenericasCSharp.CUITValido("30 50095962 9"));

            //OLEAGINOSA MORENO:
            //33502232223

            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("33502232223"));
            //BLD:
            //30703599053

            Assert.IsFalse(FuncionesGenericasCSharp.CUITValido("30703599053"));
            // TENEMOS UN GANADOR!!!!!!!


            // validar todos los cuits de la base
            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var cuits = db.Clientes.Where(x => x.Cuit != null && x.Cuit != "").Select(x => x.Cuit).Take(5000).ToList();
            foreach (string c in cuits)
            {
                if (FuncionesGenericasCSharp.CUITValido(c))
                {

                }
                else
                {
                }


            }




            /*



            Assert.IsFalse(CartaDePorteManager.VerificaCUIT("20"));
            Assert.IsFalse(CartaDePorteManager.VerificaCUIT("30-53777127-4"));
            Assert.IsTrue(CartaDePorteManager.VerificaCUIT("30-53772127-4"));

            Assert.IsTrue(CartaDePorteManager.VerificaCUIT("30714018082"));
            Assert.IsFalse(CartaDePorteManager.VerificaCUIT("30-71401308-2"));
            Assert.IsTrue(CartaDePorteManager.VerificaCUIT("30-70359905-9"));
            Assert.IsFalse(CartaDePorteManager.VerificaCUIT("30703539059"));
            Assert.IsTrue(CartaDePorteManager.VerificaCUIT("30511355040"));  // falla, me devuelve false. en el pronto anda. qué codigo usa el CUIT32.OCX????



            // buscavendedorporcuit y buscaclienteporcuit llaman a los dos validadores. por ahora estoy haciendo que verfcuit devuelva true



            // y por qué no explota en la validacion del form?


            //            MAROUN S.A	COLON 369 - Pº 6	30714018082	BAHIA BLANCA - BS AS	Delete
            //Editar	0	MAROUN SA.		30-71401308-2

            //    BLD S.A	MADRES DE PLAZA DE MAYO 3020 - OF. 14-03	30-70359905-9	ROSARIO (STA FE)	Delete
            //Editar	0	BLD S.A.		30703539059	

            Assert.IsFalse(FuncionesGenericasCSharp.mkf_validacuit("20"));
            Assert.IsFalse(FuncionesGenericasCSharp.mkf_validacuit("30-53777127-4"));
            Assert.IsTrue(FuncionesGenericasCSharp.mkf_validacuit("30-53772127-4"));

            Assert.IsTrue(FuncionesGenericasCSharp.mkf_validacuit("30714018082"));
            Assert.IsFalse(FuncionesGenericasCSharp.mkf_validacuit("30-71401308-2"));  // me devuelve true! si uso el form de corredor de pronto, este cuit es bochado. pedirle la funcion a edu


            Assert.IsTrue(FuncionesGenericasCSharp.mkf_validacuit("30-70359905-9"));
            Assert.IsFalse(FuncionesGenericasCSharp.mkf_validacuit("30703539059"));  // tambien me devuelve true!!! -tiene sentido, ya que en efecto el sistema (erroneamente) lo dio de alta 

            Assert.IsTrue(FuncionesGenericasCSharp.mkf_validacuit("30511355040"));







            Assert.IsFalse(CartaDePorteManager.VerfCuit("20"));
            Assert.IsFalse(CartaDePorteManager.VerfCuit("30-53777127-4"));
            Assert.IsTrue(CartaDePorteManager.VerfCuit("30-53772127-4"));

            var g = CartaDePorteManager.VerfCuit("30714018082");
            Assert.IsTrue(g);
            var h = CartaDePorteManager.VerfCuit("30-71401308-2"); //deberia haber dado false
            Assert.IsFalse(h);

            var i = CartaDePorteManager.VerfCuit("30-70359905-9");
            Assert.IsTrue(i);
            var j = CartaDePorteManager.VerfCuit("30703539059"); //deberia haber dado false -ok el cuit no existe, pero es invalido?
            Assert.IsFalse(j);

            Assert.IsTrue(CartaDePorteManager.VerfCuit("30511355040"));
            */
        }



        [TestMethod]
        public void Urenport_32235_excelqueesHtml_2()
        {

            // es precisamente así:
            /*
             * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
             * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
            it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                an "External table is not in the expected format" exception.
                    Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
            it's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
            all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
            */


            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 930-28032017.xls";

            //FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(archivoExcel);
            //FuncionesGenericasCSharp.GetExcel4_ExcelDataReader(archivoExcel);

            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }




        [TestMethod]
        public void Urenport_32235_excelqueesHtml()
        {

            // es precisamente así:
            /*
             * http://stackoverflow.com/questions/1139390/excel-external-table-is-not-in-the-expected-format
             * Just add my case. My xls file was created by a data export function from a website, the file extention is xls, 
            it can be normally opened by MS Excel 2003. But both Microsoft.Jet.OLEDB.4.0 and Microsoft.ACE.OLEDB.12.0 got 
                an "External table is not in the expected format" exception.
                    Finally, the problem is, just as the exception said, "it's not in the expected format". Though 
            it's extention name is xls, but when I open it with a text editor, it is actually a well-formed html file, 
            all data are in a <table>, each <tr> is a row and each <td> is a cell. Then I think I can parse it in a html way.
            */


            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_1130-21032017.xls";

            //FuncionesGenericasCSharp.GetExcel5_HTML_AgilityPack(archivoExcel);
            //FuncionesGenericasCSharp.GetExcel4_ExcelDataReader(archivoExcel);

            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }



        [TestMethod]
        public void Urenport_32235_conotroarchivo()
        {

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls";


            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }






        [TestMethod]
        public void ImportacionDeExcel()
        {
            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 953-29122016.xlsx";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls"


            var ds3 = ExcelImportadorManager.GetExcel2_ODBC(ArchivoExcelDestino);
            var ds4 = ExcelImportadorManager.GetExcel2_ODBC(@"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 953-29122016.xlsx");
            var ds5 = ExcelImportadorManager.GetExcel2_ODBC(@"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls");

            var dt1 = FuncionesGenericasCSharp.GetExcel3_XLSX_EEPLUS(ArchivoExcelDestino);

            var ds2 = ExcelImportadorManager.GetExcel(ArchivoExcelDestino);



        }







        [TestMethod]
        public void SincroPelayo_30816()
        {

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            int idcli = CartaDePorteManager.BuscarClientePorCUIT("30-70920121-9", SC, "");

            var output = SincronismosWilliamsManager.GenerarSincro("Pelayo", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", idcli, -1,
                -1, idcli,
                 idcli, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2016, 1, 1), new DateTime(2016, 3, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }














        [TestMethod]
        public void OCR_33371()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\bdl\pronto\docstest\1271214feb2017.tif";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();


            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, false, false, 1);


            string sError = "";


            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");
        }





        [TestMethod]
        public void Levenshtein2()
        {
            var a = SQLdinamico.BuscaIdLocalidadAproximado("CHIVILCOY", SC, 7);
            var a1 = EntidadManager.NombreLocalidad(SC, a);

            var b = SQLdinamico.BuscaIdClienteAproximado("CHIVILCOY", SC, 7);
            var b1 = EntidadManager.NombreCliente(SC, b);

        }




        [TestMethod]
        public void enviarFacturaElectronicaAlCorredor_32328()
        {
            // https://prontoweb.williamsentregas.com.ar/ProntoWeb/Factura.aspx?Id=91981

            barras.EnviarFacturaElectronicaEMail(new List<int> { 89323, 89324 }, SC, false, "mscalella911@gmail.com");


        }











        [TestMethod]
        public void excelDetalladoPaso2AsistenteFactur_32246()
        {
            int optFacturarA = 3;
            string txtFacturarATerceros = "";
            bool EsteUsuarioPuedeVerTarifa = true;
            System.Web.UI.StateBag ViewState = new System.Web.UI.StateBag();
            string txtFechaDesde = "12/1/2015";
            string txtFechaHasta = "12/31/2015";
            string fListaIDs = "99500,99501";
            string SessionID = "sfsfasfd12asdfsa3123";
            int cmbPuntoVenta = -1;
            string cmbAgruparArticulosPor = "";
            bool SeEstaSeparandoPorCorredor = false;

            ViewState["pagina"] = 1;
            ViewState["sesionId"] = SessionID;
            ViewState["filas"] = 10;

            string[] tokens = fListaIDs.Split(',');
            var l = tokens.ToList();


            LogicaFacturacion.GridCheckboxPersistenciaBulk(SC, SessionID, l.Select(int.Parse).ToList());


            var output = LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(optFacturarA, txtFacturarATerceros, SC,
                                                   EsteUsuarioPuedeVerTarifa, ViewState, txtFechaDesde, txtFechaHasta,
                                                   fListaIDs, SessionID, cmbPuntoVenta, cmbAgruparArticulosPor,
                                                   SeEstaSeparandoPorCorredor);

            System.Diagnostics.Process.Start(output);
        }







        [TestMethod]
        public void SincroAJNari_30816()
        {

            //string DIRFTP = DirApp + @"\DataBackupear\";
            //string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("AJNari", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", 3208, -1,
                -1, 3208,
                3208, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2017, 1, 1), new DateTime(2017, 1, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }





        [TestMethod]
        public void Urenport_32235_2()
        {


            var l1 = DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, "SUSANA");
            var l2 = SQLdinamico.BuscaIdLocalidadPreciso("SUSANA", SC);
            var l3 = SQLdinamico.BuscaIdLocalidadPreciso(DiccionarioEquivalenciasManager.BuscarEquivalencia(SC, "SUSANA"), SC);

        }










        [TestMethod]
        public void Urenport_32235()
        {

            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 953-29122016.xlsx";
            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_1450-23022017.xls";

            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls"


            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }












        [TestMethod]
        public void Urenport_29439_punto3()
        {

            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\171116\urenport.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\171116\Posicion-161117-1722.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 953-29122016.xlsx";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls"
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\New folder\Urenport_ 951-24012017.xls";
            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Ejemplo punto 3.xls";



            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;



            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

        }





        [TestMethod]
        public void Urenport_29439_punto5()
        {
            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
            string output = @"c:\asdad.xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, true, filtro,
                                                 "01/12/2016",
                                                 "30/01/2017",
                                                 0, -1, SC, "Mariano", 11);

            CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal, "Carta Porte - Buques.rdl", sqlquery4, SC, false, ref output);


            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void Urenport_29439_punto()
        {
            /*
            1    La imagen para ver la situación de los camiones tiene que ser mas grande, ordenado y dinamico. 
          Adjunto Excel de muestra. Esos son los campos que tienen que figurar y en el orden que tiene que figurar. 
          Se tiene que poder ver todos los campos sin tener que andar moviéndose en la pantalla para los costados.
             * Lo que quieren es que las columnas de la grilla del módulo sean las definidas en el excel (más la fecha y hora de la última modificación).

    Por otro lado, dicen que intentemos utilizar la mayor porción de pantalla posible. Con respecto a esto, por el ancho estamos usando toda la pantalla por lo cual si con las nuevas columnas quedan muchas columnas a la derecha, podríamos achicar la tipografía.
    Por el alto, se puede agrandar? En mi pantalla usa 380 pixeles cuando podría ser algo más grande.
             1h


            3 Que el robot filtre también la información de los otros entregadores y que figure 
             el entregador en nuestro sistema. ( ver ejemplo en el Excel que adjuntamos para el punto 1)
             * Sucede que en el excel que descarga el robot hay cartas de porte de multiples entregadores pero en la columna "CUIT_ENTREGADOR" siempre viene el CUIT de Williams.
    Se pueden identificar los entregadores por la razón social que aparece en la columna "ENTREGADOR".
    Adjunto un ejemplo que tiene cartas de porte de 8 entregadores que no son Williams pintados de amarillo.
            2h
             * 


             * 
            5  Al exportar a Excel tiene que tirar el mismo excel que te adjunto en el punto 1. Los otros datos en todo caso que estén
            3h
             * 

             * 
             */


        }






        [TestMethod]
        public void Mail()
        {
            //                Log Entry : 
            //01/24/2017 03:50:21
            //Error in: https://prontoweb.williamsentregas.com.ar/ProntoWeb/SincronismosAutomaticos.aspx. 
            //                Syntax error in parameters or arguments. The server response was: 5.1.3 Bad recipient address syntax
            //   at System.Net.Mail.RecipientCommand.CheckResponse(SmtpStatusCode statusCode, String response)
            //Error Message:
            string casilla = @"'jlouge@ledesma.com.ar', 'mruiz@ledesma.com.ar', 'lbonello@ledesma.com.ar', 'jturin@ledesma.com.ar',mfavot@williamsentregas.com.ar";

            EntidadManager.IsValidEmail(casilla);
        }





        [TestMethod]
        public void OCR_29442()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\Lote 20ene165904 nveron PV2\0.tif";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();


            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, false, false, 1);


            string sError = "";


            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");
        }




        [TestMethod]
        public void TambienParaFlexicaptureActivar_ImagenesTiffMultipaginaFormatoCPTK_CPTK_CPTK_20503()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\imagenes\3333.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\imagenes\CPTKCPTK.tif";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();


            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, true, false, false, 1);


            string sError = "";


            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");
        }









        [TestMethod]
        public void excelDetalladoPaso2AsistenteFactur_30934()
        {
            int optFacturarA = 3;
            string txtFacturarATerceros = "";
            bool EsteUsuarioPuedeVerTarifa = true;
            System.Web.UI.StateBag ViewState = new System.Web.UI.StateBag();
            string txtFechaDesde = "12/1/2015";
            string txtFechaHasta = "12/31/2015";
            string fListaIDs = "";
            string SessionID = "sfsfasfd12asdfsa3123";
            int cmbPuntoVenta = -1;
            string cmbAgruparArticulosPor = "";
            bool SeEstaSeparandoPorCorredor = false;

            ViewState["pagina"] = 1;
            ViewState["sesionId"] = SessionID;
            ViewState["filas"] = 10;

            //LogicaFacturacion.GridCheckboxPersistenciaBulk(GridView1, HFSC.Value, Session.SessionID, TraerLista(GridView1))


            var output = LogicaFacturacion.PreviewDetalladoDeLaGeneracionEnPaso2(optFacturarA, txtFacturarATerceros, SC,
                                                   EsteUsuarioPuedeVerTarifa, ViewState, txtFechaDesde, txtFechaHasta,
                                                   fListaIDs, SessionID, cmbPuntoVenta, cmbAgruparArticulosPor,
                                                   SeEstaSeparandoPorCorredor);

            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void liquidacionsubcon_29418_Caso_Munoz_ModoEntregas()
        {


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                        new DateTime(2016, 12, 1),
                        new DateTime(2016, 12, 31),
                        -1, 6319, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }



        [TestMethod]
        public void liquidacionsubcon_29418_Caso_Munoz_modoAmbos()
        {


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2016, 12, 1),
                        new DateTime(2016, 12, 31),
                        -1, 6319, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }


        [TestMethod]
        public void liquidacionsubcon_29418_Caso_EnPuertoServicios()
        {


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2016, 12, 1),
                        new DateTime(2016, 12, 31),
                        -1, 6324, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }



        [TestMethod]
        public void liquidacionsubcon_31006()
        {


            // En la liquidación de subcontratistas agregar el modo BUQUES
            //  * En las listas de precios, agregar las tarifas de CALADA y BALANZA para buques

            var c = CartaDePorteManager.GetItem(SC, 1372987);
            c.SubnumeroVagon = 222;
            string ms = "";
            CartaDePorteManager.Save(SC, c, 1, "", false, ref ms);

            ParametroManager.GuardarValorParametro2(SC, "DestinosDeCartaPorteApartadosEnLiquidacionSubcontr", "NOBLE ARG. - Lima|CHIVILCOY|CARGILL - San Justo|FABRICA VICENTIN|PUERTO VICENTIN");


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2016, 12, 1),
                        new DateTime(2016, 12, 31),
                        2, -1, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }



        [TestMethod]
        public void liquidacionsubcon_22294_23568_31006()
        {


            // En la liquidación de subcontratistas agregar el modo BUQUES
            //  * En las listas de precios, agregar las tarifas de CALADA y BALANZA para buques

            var c = CartaDePorteManager.GetItem(SC, 1372987);
            c.SubnumeroVagon = 222;
            string ms = "";
            CartaDePorteManager.Save(SC, c, 1, "", false, ref ms);

            ParametroManager.GuardarValorParametro2(SC, "DestinosDeCartaPorteApartadosEnLiquidacionSubcontr", "NOBLE ARG. - Lima|CHIVILCOY|CARGILL - San Justo|FABRICA VICENTIN|PUERTO VICENTIN");


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Buques",
                        new DateTime(2016, 9, 1),
                        new DateTime(2016, 9, 30),
                        -1, -1, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }







        [TestMethod]
        public void pegatinaUrenportRobot_29439()
        {

            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\171116\urenport.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\171116\Posicion-161117-1722.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 953-29122016.xlsx";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls"
            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\New folder\Urenport_ 951-24012017.xls";
            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            // Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);






            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            //foreach (System.Data.DataRow r in dt.Rows)
            //{
            //    var dr = r;
            //    var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
            //                                            null, null, null, null,
            //                                            null, null);
            //}




            ////verificar que sigue así
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            //Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);
        }


        [TestMethod]
        public void pegatinaUrenportRobot_29439_2()
        {

            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\171116\urenport.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\171116\Posicion-161117-1722.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Urenport_ 953-29122016.xlsx";
            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Posicion-161229-0945.xls";
            //string archivoExcel = @"C:\Users\Administrador\Documents\bdl\New folder\Urenport_ 951-24012017.xls";
            //explota

            string ms = "";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            // Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);






            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            //foreach (System.Data.DataRow r in dt.Rows)
            //{
            //    var dr = r;
            //    var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
            //                                            null, null, null, null,
            //                                            null, null);
            //}




            ////verificar que sigue así
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            //Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);
        }




        [TestMethod]
        public void GeneraYEnviaLosMailsTildadosDeLaGrilla_29401()
        {
            //ColaMails.EncolarFiltros(null, null, true, 1, 1, null, null, null, null, null);
            ColaMails.CancelarCola(SC);
        }








        [TestMethod]
        public void ImagenesPendientesIneficaz()
        {


            var lista = ClassFlexicapture.ExtraerListaDeImagenesQueNoHanSidoProcesadas(50, DirApp).ToList();


        }







        [TestMethod]
        public void ProcesarTandaDeExcelsDeUrenport_29439()
        {



            var lista = ClassFlexicapture.ExtraerListaDeExcelsQueNoHanSidoProcesados(5, DirApp);


            string log = "";
            //hay que pasar el formato como parametro 

            foreach (string f in lista)
            {
                int m_IdMaestro = 0;

                ClassFlexicapture.MarcarArchivoComoProcesandose(f);

                ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, f,
                                        LogicaImportador.FormatosDeExcel.Urenport, SC, 0, ref log, "", 0, "");

                //var dt = LogicaImportador.TraerExcelDeBase(SC, ref  m_IdMaestro);

            }

        }







        [TestMethod]
        public void ServicioWebDescargas_29771()
        {
            /*   
    1) Error bloqueante al proceso de importación
    • La hora (un String) tiene más de 10 caracteres, esto entra en conflicto con las definición del campo 
    en la base de datos para CerealNet (VARCHAR(10) ). Por lo que pude ver, Williams a veces 
    está informando una fecha en este campo, otras veces no informa nada. 
    CerealNet lo manda vacio a este campo y si bien en Williams rompe el proceso de importación 
    no usamos este campo para nada. En pocas palabras podríamos no darle importancia a este campo y seguir adelante.

    2) Una vez sorteado ese error me encontré con

    • KGDescarga (netodest) no se está informando.
    • En la mayoría de las veces no está informando el CUIT remitente y CUIT remitente comercial. Esto se usa para el mapeo de la empresa compradora.
    • Los CUITs los informa con guiones (20-12123123-2) cuando debería informarlo sin guiones (20121231232)
    • Los CodigoOnccaProducto (codmerca) no se está informando
    • La cosecha a veces no se informa y cuando se informa tiene el formato “20xx/yy” cuando debería ser “xxyy”. Ej.: Se informa 2015/16, debería informar 1516

    • No está informando el campo CodigoOnccaLocalidadProcedencia (codonccalocalproc)
    • CodigoOnccaPuerto (codonccapuerto), CodigoOnccaLocalidadPuerto (codonccalocalidadpuerto) y CodigoOnccaProvinciaPuerto (codonccaprovinciapuerto) no se está informando.
    • Cuando se informa el CuitPuerto (cuitpuerto) informa un número entero (parecería ser un código de 2 dígitos) en vez de un CUIT.
    • No está informando las mermas.
    • No se está informando fecha de descarga (fechadescarga) y fecha de posición (fechaposicion).

             * 
             * 
    • El campo calidad lo está informando mal. Debería ser:
    Valor informado	Valor esperado
    COND. CAMARA	CC
    GRADO 1	G1
    FUERA DE STANDARD	FE
    GRADO 2	G2
    CONFORME	??????
    CONDICIONAL X M.E	??????
    FUERA DE BASE	??????

    Vale destacar que sacando el error bloqueante no se pudo importar ninguna descarga correctamente al sistema.
    Todo esto sale de probar en todas las descargas (200) que se pudo importar con el rango de fecha 01/01/2010 al 01/01/2017
             * */


            ////Trust all certificates
            //System.Net.ServicePointManager.ServerCertificateValidationCallback = delegate(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors) { return true; };

            //var cerealnet = new WS_CartasDePorteClient();

            string usuario = "Mariano"; //"fyo";
            string clave = "pirulo!"; // "76075";
            string cuit = "30703605105";

            // var respEntrega = cerealnet.obtenerDescargas(usuario, clave, cuit, "2016-10-01", "2016-10-25");
            var respEntrega = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL(usuario, clave, cuit,
                                            new DateTime(2016, 9, 1),
                                            new DateTime(2017, 1, 1),
                                            SC, DirApp, scbdlmasterappconfig);


            foreach (var desc in respEntrega.descargas)
            {
                Console.WriteLine(string.Format("CP {0}", desc.cartaporte));

                if (desc.listaAnalisis != null && desc.listaAnalisis.Length > 0)
                {
                    foreach (CerealNet.WSCartasDePorte.analisis anal in desc.listaAnalisis)
                    {
                        Console.WriteLine(string.Format("\tRubro: {0} - %Analisis: {1} - %Merma: {2} - KgsMerma: {3}", anal.rubro.Trim(), anal.porcentajeAnalisis, anal.porcentajeMerma, anal.kilosMermas));
                    }
                }
            }
            //Console.ReadKey();
        }







        [TestMethod]
        public void webServiceParaDescargarPlanilla_22085_Estilo_CerealNet()
        {
            // http://stackoverflow.com/questions/371961/how-to-unit-test-c-sharp-web-service-with-visual-studio-2008


            // var sss = Membership.ValidateUser("Mariano", "pirulo!");

            //string archivodestino = "c:\\Source.jpg";
            string archivodestino = "c:\\Source.pdf";

            System.IO.FileStream fs1 = null;
            //WSRef.FileDownload ls1 = new WSRef.FileDownload();
            byte[] b1 = null;

            //b1 = CartaDePorteManager.BajarListadoDeCartaPorte_CerealNet_DLL("Mariano", "pirulo!", "30703605105", new DateTime(10, 10, 2015), new DateTime(10, 10, 2015), SC, DirApp, bdlmasterappconfig);
            ////{920688e1-7e8f-4da7-a793-9d0dac7968e6}

            //fs1 = new FileStream(archivodestino, FileMode.Create);
            //fs1.Write(b1, 0, b1.Length);
            //fs1.Close();
            //fs1 = null;

            //cómo sé en qué formato está?

            System.Diagnostics.Process.Start(archivodestino);
        }









        [TestMethod]
        public void InformeDeClientesIncompletos_16492()
        {

            // explota


            //               Mariano,
            //Con estas columnas estaría bien (si puede ser con un link al cliente):

            //Codigo
            //Razón Social
            //CUIT
            //Dirección
            //Localidad
            //Provincia

            //Solo un comentario, en la imagen incluyen el campo Autorizador Syngenta que no debe tenerse en cuenta porque casi ningun cliente lo tiene

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";

            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            //var output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
            //        "Williams - Listado de Clientes incompletos.rdl",
            //                 "", SC, false, ref ArchivoExcelDestino, sTitulo, false);




            ReportParameter[] yourParams = new ReportParameter[2];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("sServidorWeb", ConfigurationManager.AppSettings["UrlDominio"]);


            var output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                  "Williams - Listado de Clientes incompletos.rdl", yourParams, ref ArchivoExcelDestino, false);



            System.Diagnostics.Process.Start(output);




            //var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", txtMailDiazRiganti.Text, sErrores, bVistaPrevia);

            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
        }








        [TestMethod]
        public void exportacionUsandoInternalQuery_29439_4()
        {
            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
            string output = @"c:\asdad.xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            var s = new ServicioCartaPorte.servi();
            var sqlquery4 = s.CartasPorte_DynamicGridData_ExcelExportacion_UsandoInternalQuery("IdCartaDePorte", "desc", 1, 999999, true, filtro,
                                                 "11/01/2016",
                                                 "11/01/2016",
                                                 0, -1, SC, "Mariano", 11);

            CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal, "Sincronismo BLD.rdl", sqlquery4, SC, false, ref output);


            System.Diagnostics.Process.Start(output);
        }





        [TestMethod]
        public void exportacionPeroLlamandoAlRepServicesAlosupermachoconLINQ_29439_3()
        {
            string output = @"c:\asdad.xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            int totalrecords = 0;

            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";


            string sqlquery4 = Filtrador.Filters.FiltroGenerico_UsandoIQueryable_DevolverInternalQuery<ProntoMVC.Data.Models.fSQL_GetDataTableFiltradoYPaginado_Result3>
                                    (
                                                            "IdCartaDePorte", "desc", 1, 999999, true, filtro, db, ref totalrecords,
                                                            db.fSQL_GetDataTableFiltradoYPaginado(
                                                            0, 9999999, 0, "", -1, -1,
                                                            -1, -1, -1, -1, -1,
                                                          -1, 0, "Ambas"
                                                           , new DateTime(2016, 10, 1), new DateTime(2016, 11, 1),
                                                           0, null, false, "", "",
                                                           -1, null, 0, "", "Todos")
                                    );


            //var query = db.fSQL_GetDataTableFiltradoYPaginado(
            //                                               0, 9999999, 0, "", -1, -1,
            //                                               -1, -1, -1, -1, -1,
            //                                               -1, 0, "Ambas"
            //                                               , new DateTime(2016, 11, 1), new DateTime(2016, 11, 1),
            //                                               0, null, "", "",
            //                                               -1, null, 0, "", "Todos");

            // http://stackoverflow.com/questions/1412863/how-do-i-view-the-sql-generated-by-the-entity-framework?noredirect=1&lq=1.
            //https://www.stevefenton.co.uk/2015/07/getting-the-sql-query-from-an-entity-framework-iqueryable/


            //System.Data.Entity.Core.Objects.ObjectQuery oq = (System.Data.Entity.Core.Objects.ObjectQuery)query;
            //string sqlquery = (oq).ToTraceString();



            //var result = oq.ToTraceString();
            //var ps = oq.Parameters.ToList();
            //for (int n = ps.Count() - 1; n >= 0; n--) //para que @QueContenga no reemplace a @QueContenga2
            //{
            //    var parameter = ps[n];
            //    var name = "@" + parameter.Name;
            //    var value = "'" + parameter.Value.NullSafeToString() + "'";
            //    result = result.Replace(name, value);
            //}




            //var lp = new LinqProvider<fSQL_GetDataTableFiltradoYPaginado_Result3>(query);
            //string sqlquery3 = lp.InternalQueryContext.ToTraceString();


            //string sqlquery2 = Fenton.Example.IQueryableExtensions.ToTraceQuery_SinUsarExtension<fSQL_GetDataTableFiltradoYPaginado_Result3>(query);




            CartaDePorteManager.RebindReportViewer_ServidorExcel(ref ReporteLocal, "Sincronismo BLD.rdl", sqlquery4, SC, false, ref output);






            System.Diagnostics.Process.Start(output);


        }









        //[TestMethod]
        public void _LENTO_exportacionPeroLlamandoAlAction_29439_2()
        {
            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);


            var s = new ServicioCartaPorte.servi();
            var output3 = s.CartasPorte_DynamicGridData_ExcelExportacion("IdCartaDePorte", "desc", 1, 999999, true, filtro,
                                                 "11/01/2016",
                                                 "11/01/2016",
                                                 0, -1, SC, "Mariano", 11);

            System.Diagnostics.Process.Start(output3);
        }







        [TestMethod]
        public void exportacion_29439()
        {
            string output = "c:\asdad.xls";

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            List<ProntoMVC.Data.Models.fSQL_GetDataTableFiltradoYPaginado_Result3> q =
                                                 db.fSQL_GetDataTableFiltradoYPaginado(
                                                            0, 9999999, 0, "", -1, -1,
                                                            -1, -1, -1, -1, -1,
                                                            -1, 0, "Ambas"
                                                            , new DateTime(2016, 11, 1), new DateTime(2016, 11, 1),
                                                            0, null, false, "", "",
                                                            -1, null, 0, "", "Todos").ToList();

            FuncionesCSharpBLL.ExportToExcelEntityCollection<fSQL_GetDataTableFiltradoYPaginado_Result3>(q, output);
            System.Diagnostics.Process.Start(output);
        }













        [TestMethod]
        public void panelDeControl_generohtml_29439()
        {
            string output = "c:\asdad.xls";

            var s = new ServicioCartaPorte.servi();
            string html = s.InformeSituacion_html(-1, new DateTime(2016, 11, 10), new DateTime(2016, 11, 17), SC, 11);

            Console.Write(html);

            //usar icono truck 


            // FuncionesCSharpBLL.ExportToExcelEntityCollection<fSQL_GetDataTableFiltradoYPaginado_Result3>(q, output);
            //System.Diagnostics.Process.Start(output);
        }



        [TestMethod]
        public void panelDeControl_29439()
        {
            string output = "c:\asdad.xls";

            //SegunDestino
            var s = new ServicioCartaPorte.servi();
            var q = s.InformeSituacion_string(1, new DateTime(2016, 11, 1), new DateTime(2016, 11, 1), SC, 11);




            Console.WriteLine(q);


            // FuncionesCSharpBLL.ExportToExcelEntityCollection<fSQL_GetDataTableFiltradoYPaginado_Result3>(q, output);
            //System.Diagnostics.Process.Start(output);
        }









        [TestMethod]
        public void formato_mail_html_25065_estandar_2()
        {

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            //dr["ModoImpresion"] = "GrobHc"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
            dr["ModoImpresion"] = "ExcHc";


            //ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcHtm" Then
            //    'este es de servidor, así que saco el path
            //    rdl = "Listado general de Cartas de Porte (simulando original) con foto 2"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "EHOlav" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) Olavarria"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "HImag2" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) para html con imagenes"





            //dr["ModoImpresion"] = "HtmlIm";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }


        [TestMethod]
        public void _LENTO_formato_mail_html_grobo_25065()
        {

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            dr["ModoImpresion"] = "GrobHc"; // este es el excel angosto con adjunto html angosto ("Listado general de Cartas de Porte (simulando original) con foto 2 .rdl"). Lo que quieren es el excel ANCHO manteniendo el MISMO html. 
                                            //dr["ModoImpresion"] = "ExcHc";


            //ElseIf iisNull(.Item("ModoImpresion"), "") = "ExcHtm" Then
            //    'este es de servidor, así que saco el path
            //    rdl = "Listado general de Cartas de Porte (simulando original) con foto 2"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "EHOlav" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) Olavarria"

            //ElseIf iisNull(.Item("ModoImpresion"), "") = "HImag2" Then
            //    rdl = "Listado general de Cartas de Porte (simulando original) para html con imagenes"





            //dr["ModoImpresion"] = "HtmlIm";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }






        [TestMethod]
        public void OCR_29441()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\140029nov2016_095446_ExportToXLS_388413.tif.jpg";


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");



            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(@"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\Temp\" + excels[0] + @"\ExportToXLS.xls");



        }




        [TestMethod]
        public void GrabarFilaEnGrillaDeSituacionCalidad_29439()
        {
            // url: "WebServiceCartas.asmx/CartaPorteBatchUpdate",

            string ms = CartaDePorteManager.GrabarSituacion_DLL(2638292, 2, "RECHAZADO EN PLAYA EXTERNA", SC);

        }







        //CartasPorte_DynamicGridData

        [TestMethod]
        public void grillaParaModuloCalidadSituacion_29439()
        {

            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";
            //string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"NIDERA SA ( PGSM )\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";

            var s = new ServicioCartaPorte.servi();
            var output = s.CartasPorte_DynamicGridData("IdCartaDePorte", "desc", 1, 50, true, filtro,
                                                        "01/01/2016",
                                                        "01/01/2016",
                                                        0, -1, SC, "Mariano", "", 11);



            //            hacer test donde filtras por mas de un puerto
            //              Los filtros Producto, Puerto, Procedencia serán múltiples (se podrá elegir más de uno para filtrar el listado).
        }



        [TestMethod]
        public void grillaParaModuloCalidad_29439_2()
        {
            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";

            var s = new ServicioCartaPorte.servi();
            var output2 = s.CartasPorte_DynamicGridData("IdCartaDePorte", "desc", 1, 50, true, filtro,
                                                "01/01/2015",
                                                "01/01/2016",
                                                0, -1, SC, "Mariano", "", 11);


        }


        [TestMethod]
        public void grillaParaModuloCalidad_29439_3()
        {
            string filtro = "{\"groupOp\":\"OR\",\"rules\":[{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"MOL. CAÑUELAS - ZARATE\"},{\"field\":\"DestinoDesc\",\"op\":\"eq\",\"data\":\"TERMINAL 6\"}]}";


            var s = new ServicioCartaPorte.servi();
            var output3 = s.CartasPorte_DynamicGridData("IdCartaDePorte", "desc", 1, 50, true, filtro,
                                                 "01/01/2010",
                                                 "01/01/2016",
                                                 0, -1, SC, "Mariano", "", 11);
        }









        [TestMethod]
        public void OcrBarajaAsignacionDeImagenes_()
        {
        }







        [TestMethod]
        public void SincroMonsanto_29381()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Monsanto", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", 3208, -1,
                -1, 3208,
                3208, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Entregas",
                new DateTime(2017, 1, 1), new DateTime(2017, 1, 31),
                -1, "Ambas", false, "", "", -1, ref registrosf, 4000);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }





        [TestMethod]
        public void ElegirCombosSegunParametro_29385()
        {

            SincronismosWilliamsManager.ElegirCombosSegunParametro("BTG PACTUAL [BIT]", new System.Web.UI.WebControls.TextBox()
                , new System.Web.UI.WebControls.TextBox(),
                new System.Web.UI.WebControls.TextBox(),
                new System.Web.UI.WebControls.TextBox(), new System.Web.UI.WebControls.TextBox(),
                new System.Web.UI.WebControls.TextBox(),
                new System.Web.UI.WebControls.DropDownList(), new System.Web.UI.WebControls.DropDownList(),
                new System.Web.UI.WebControls.DropDownList(), SC);

        }







        [TestMethod]
        public void OCR_bug_alsubirdesdeReasignarListado_se_trula_separando_laspaginasdeltiff()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\Lote 09nov190213 cgoycochea PV4\Xerox WorkCentre 3550_20161109190032.tif";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);
        }



        [TestMethod]
        public void FormatoImpresionPlantillaFactura_iibb()
        {

            //explota

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var f = db.Facturas.Find(87781);
            f.CAE = "654646";
            db.SaveChanges();

            var f2 = db.Facturas.Find(87700);
            f2.CAE = "654646";
            db.SaveChanges();


            var output2 = CartaDePorteManager.ImprimirFacturaElectronica(87781, false, SC, DirApp);


            System.Diagnostics.Process.Start(output2);


            var output3 = CartaDePorteManager.ImprimirFacturaElectronica(87700, false, SC, DirApp);


            System.Diagnostics.Process.Start(output3);

        }





        [TestMethod]
        public void SincroMonsanto_17940()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Monsanto", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2016, 1, 1), new DateTime(2016, 1, 28),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        //[TestMethod]
        public void _LENTO_SincroTomasHnos_27154()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("TOMAS HNOS", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2016, 1, 1), new DateTime(2016, 1, 28),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }

















        [TestMethod]
        public void ingresosbrutos_facturacion_26131_3_topeminimo()
        {

            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 


            int optFacturarA = 4;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            long idClienteAfacturarle = 30446; // la celestina s.a.
            int idClienteObservaciones = -1;
            bool SeEstaSeparandoPorCorredor = true;
            int PuntoVenta = 1;

            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);




            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            // empresa (para que sea agente de percepcion)
            db.Parametros.First().PercepcionIIBB = "SI";

            // punto de venta para que perciba ingresos brutos
            //Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            //Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
            //                                "PuntosVenta", _
            //                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
            //                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            //Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            var pv = db.PuntosVentas.Where(x => x.PuntoVenta == 10).FirstOrDefault();
            pv.AgentePercepcionIIBB = "SI";


            // cliente
            var cliente = db.Clientes.Find(idClienteAfacturarle);
            // no poner. la tabla IBCondiciones ya esta relacionada a un IdProvincia. //  cliente.IdProvincia = 3; //capital
            cliente.IBCondicion = 2; //usar 2 o 3    "Exento"  "Inscripto Convenio Multilateral "    "Inscripto Jurisdicción Local "  "No Alcanzado"
            cliente.IdIBCondicionPorDefecto = 5;  //en williams,  6 es  "Santa Fe Convenio Multilateral 0.7%" <-- las condiciones estan relacionadas a una provincia


            //ibcondicion
            //en la tabla IBCondiciones, q diferencia hay entre Alicuota, AlicuotaPercepcion y AlicuotaPercepcionConvenio?
            // -la primera es de retencion.
            var ibcondicion = db.IBCondiciones.Find(5);
            ibcondicion.AlicuotaPercepcion = 7;
            ibcondicion.AlicuotaPercepcionConvenio = 8;
            ibcondicion.ImporteTopeMinimoPercepcion = 10;


            db.SaveChanges();
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////





            for (int n = 1372900; n < 1372901; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;


            int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
                                                 dtRenglonesAgregados, SC, null, optFacturarA,
                                              agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                                txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);

            var f = db.Facturas.Find(idFactura);

            //Assert.AreEqual(true, f.ImporteTotal<100);
            Assert.AreEqual(0, f.RetencionIBrutos1);


            // parece que en el codigo de edu, solo se revisa el ImporteTopeMinimo cuando no es codigoprovincia 901 o 902 (capital o buenos aires)

        }



        [TestMethod]
        public void ingresosbrutos_facturacion_26131_2_facturo_sin_cambiar_la_configuracion_del_cliente()
        {

            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 


            int optFacturarA = 4;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            long idClienteAfacturarle = 30446; // la celestina s.a.
            int idClienteObservaciones = -1;
            bool SeEstaSeparandoPorCorredor = true;
            int PuntoVenta = 1;

            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);



            //////////////////////////////////////
            //////////////////////////////////////





            for (int n = 1372900; n < 1372910; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;


            int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
                                                 dtRenglonesAgregados, SC, null, optFacturarA,
                                              agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                                txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);


        }




        [TestMethod]
        public void ingresosbrutos_facturacion_26131()
        {

            // tenes instalado el pronto? server2/publico/actualizacion

            //    tarifas en cero de buques
            //LogicaFacturacion.GenerarLoteFacturas_NUEVO(tablaEditadaDeFacturasParaGenerar, HFSC.Value, ViewState("pagina"), ViewState("sesionId"), optFacturarA.SelectedValue, gvFacturasGeneradas, _
            //                    txtFacturarATerceros.Text, SeEstaSeparandoPorCorredor, Session, cmbPuntoVenta.Text, _
            //                    dtViewstateRenglonesManuales, cmbAgruparArticulosPor.SelectedItem.Text, _
            //                    txtBuscar.Text, txtTarifaGastoAdministrativo.Text, errLog, txtCorredor.Text, chkPagaCorredor.Checked, txtOrdenCompra.Text, ViewState("PrimeraIdFacturaGenerada"), ViewState("UltimaIdFacturaGenerada"), 0)




            //              ByRef pag As Object, _
            //  ByRef sesionId As Object, _



            //ByRef gvFacturasGeneradas As GridView, ByVal txtFacturarATerceros As String, _


            //System.Web.SessionState.HttpSessionState Session;
            //Session[CartaDePorteManager.SESSIONPRONTO_glbIdUsuario] = 4;

            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 


            int optFacturarA = 4;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            long idClienteAfacturarle = 164;
            int idClienteObservaciones = -1;
            bool SeEstaSeparandoPorCorredor = true;
            int PuntoVenta = 1;

            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);



            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            // empresa (para que sea agente de percepcion)
            db.Parametros.First().PercepcionIIBB = "SI";

            // punto de venta para que perciba ingresos brutos
            //Dim numeropuntoVenta = PuntoVentaWilliams.NumeroPuntoVentaSegunSucursalWilliams(sucursalWilliams, SC)
            //Dim IdPuntoVenta As Integer = EntidadManager.TablaSelectId(SC, _
            //                                "PuntosVenta", _
            //                                "PuntoVenta=" & numeropuntoVenta & " AND Letra='" & _
            //                                mLetra & "' AND IdTipoComprobante=" & EntidadManager.IdTipoComprobante.Factura)
            //Dim IdObra As Integer = PuntoVentaWilliams.ObraSegunSucursalWilliams(sucursalWilliams, SC)
            var pv = db.PuntosVentas.Where(x => x.PuntoVenta == 10).FirstOrDefault();
            pv.AgentePercepcionIIBB = "SI";


            // cliente
            var cliente = db.Clientes.Find(idClienteAfacturarle);
            // no poner. la tabla IBCondiciones ya esta relacionada a un IdProvincia. //  cliente.IdProvincia = 3; //capital
            cliente.IBCondicion = 2; //usar 2 o 3    "Exento"  "Inscripto Convenio Multilateral "    "Inscripto Jurisdicción Local "  "No Alcanzado"
            cliente.IdIBCondicionPorDefecto = 5;  //en williams,  6 es  "Santa Fe Convenio Multilateral 0.7%" <-- las condiciones estan relacionadas a una provincia

            //ibcondicion
            //en la tabla IBCondiciones, q diferencia hay entre Alicuota, AlicuotaPercepcion y AlicuotaPercepcionConvenio?
            // -la primera es de retencion.
            var ibcondicion = db.IBCondiciones.Find(5);
            ibcondicion.AlicuotaPercepcion = 7;
            ibcondicion.AlicuotaPercepcionConvenio = 8;



            db.SaveChanges();
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////
            //////////////////////////////////////





            for (int n = 1372900; n < 1372910; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;


            int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
                                                 dtRenglonesAgregados, SC, null, optFacturarA,
                                              agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                                txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);


        }







        [TestMethod]
        public void webServiceParaDescargarPlanilla_22085()
        {
            // http://stackoverflow.com/questions/371961/how-to-unit-test-c-sharp-web-service-with-visual-studio-2008


            // var sss = Membership.ValidateUser("Mariano", "pirulo!");

            //string archivodestino = "c:\\Source.jpg";
            string archivodestino = "c:\\Source.pdf";

            System.IO.FileStream fs1 = null;
            //WSRef.FileDownload ls1 = new WSRef.FileDownload();
            byte[] b1 = null;

            b1 = CartaDePorteManager.BajarListadoDeCartaPorte_DLL("Mariano", "pirulo!", new DateTime(10, 10, 2015), new DateTime(10, 10, 2015), SC, DirApp, scbdlmasterappconfig);
            //{920688e1-7e8f-4da7-a793-9d0dac7968e6}

            fs1 = new FileStream(archivodestino, FileMode.Create);
            fs1.Write(b1, 0, b1.Length);
            fs1.Close();
            fs1 = null;

            //cómo sé en qué formato está?

            System.Diagnostics.Process.Start(archivodestino);
        }





        [TestMethod]
        public void formato_mail_html_24908_3()
        {

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            //dr["ModoImpresion"] = "ExcHtm";
            dr["ModoImpresion"] = "HtmlIm";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }




        [TestMethod]
        public void formato_mail_html_24908_2()
        {

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            //dr["ModoImpresion"] = "ExcHtm";
            dr["ModoImpresion"] = "HImag2";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }




        [TestMethod]
        public void formato_mail_html_24908()
        {

            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 12);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            dr["ModoImpresion"] = "Excel";
            //dr["ModoImpresion"] = "ExcHtm";
            //dr["ModoImpresion"] = "EHOlav";
            //dr["ModoImpresion"] = "HImag2";

            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;

            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;
            //CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasDeHoyMasTodasLasPosicionesEnRangoFecha;
            //CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.Posicion;

            string output = "";
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";





            try
            {

                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


            }
            catch (Exception)
            {

                //throw;
            }



            System.Web.UI.WebControls.GridView grid = new System.Web.UI.WebControls.GridView();
            string html = CartaDePorteManager.ExcelToHtml(output, grid);


            System.Diagnostics.Process.Start(output);

        }





        [TestMethod]
        public void InformeSincroLaBiznaga_25066()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("La Biznaga", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2016, 1, 1), new DateTime(2016, 1, 30),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);


            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void OCR_Tickets()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\tickets y cartas.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\141016\TIFFF.zip";


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");



            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(@"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\Temp\" + excels[0] + @"\ExportToXLS.xls");



        }










        [TestMethod]
        public void Pegatina_toepfer_23761()
        {

            //explota

            string ms = "";

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\230916\descar19.txt";
            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            // Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.CerealnetToepfer, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);
        }











        [TestMethod]
        public void InformeControlDiario_24958()
        {

            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";
            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter[] yourParams = new ReportParameter[6];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("sServidorWeb", ConfigurationManager.AppSettings["UrlDominio"]);
            yourParams[2] = new ReportParameter("FechaDesde", new DateTime(2016, 7, 1).ToString());
            yourParams[3] = new ReportParameter("FechaHasta", new DateTime(2016, 10, 30).ToString());
            yourParams[4] = new ReportParameter("IdDestino", "-1");
            yourParams[5] = new ReportParameter("IdPuntoVenta", "0");
            //yourParams[7] = new ReportParameter("Consulta", strSQL);


            var output2 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                "Williams - Controles Diarios.rdl", yourParams, ref ArchivoExcelDestino, false);

            System.Diagnostics.Process.Start(output2);
        }


















        [TestMethod]
        public void ClientesEspecificosDelUsuarioBLD_23822()
        {
            var q = CartaDePorteManager.TraerCUITClientesSegunUsuario("Mariano", SC, scbdlmasterappconfig);
        }




        [TestMethod]
        public void InformeControlDeKilos_23685()
        {


            string DIRFTP = DirApp + @"\DataBackupear\";
            string ArchivoExcelDestino = DIRFTP + "ControlKilos_" + DateTime.Now.ToString("ddMMMyyyy_HHmmss") + ".xlsx";


            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter[] yourParams = new ReportParameter[6];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("sServidorWeb", ConfigurationManager.AppSettings["UrlDominio"]);
            yourParams[2] = new ReportParameter("FechaDesde", new DateTime(2015, 11, 1).ToString());
            yourParams[3] = new ReportParameter("FechaHasta", new DateTime(2016, 11, 1).ToString());
            yourParams[4] = new ReportParameter("IdDestino", "-1");
            yourParams[5] = new ReportParameter("IdPuntoVenta", "0");
            //yourParams[7] = new ReportParameter("Consulta", strSQL);


            var output2 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                "Williams - Controles De Kilos Clientes.rdl", yourParams, ref ArchivoExcelDestino, false);

            System.Diagnostics.Process.Start(output2);
        }





        [TestMethod]
        public void liquidacionsubcon_22294()
        {


            // Sería agregar dos tarifas más que servirían para la liquidación de subcontratistas, especialmente para Vagones, separado por  Calada y Descarga


            var c = CartaDePorteManager.GetItem(SC, 1372987);
            c.SubnumeroVagon = 222;
            string ms = "";
            CartaDePorteManager.Save(SC, c, 1, "", false, ref ms);

            ParametroManager.GuardarValorParametro2(SC, "DestinosDeCartaPorteApartadosEnLiquidacionSubcontr", "NOBLE ARG. - Lima|CHIVILCOY|CARGILL - San Justo|FABRICA VICENTIN|PUERTO VICENTIN");


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2014, 1, 1),
                        new DateTime(2014, 1, 10),
                        -1, 29146, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }














        [TestMethod]
        public void Pegatina_23519_reyser_analisis_23519()
        {

            //explota

            string ms = "";

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\150916\Anali19.txt";


            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 556275834, 0, 0);
            carta.NumeroCartaDePorte = 556275834;
            carta.FechaArribo = new DateTime(2016, 1, 1);
            carta.FechaDescarga = new DateTime(2016, 1, 1);
            carta.PuntoVenta = 1;
            carta.Cosecha = "2016/17";
            carta.IdArticulo = 5;
            carta.NetoFinalIncluyendoMermas = 30160;
            carta.Merma = 0;
            carta.Humedad = 0;
            carta.HumedadDesnormalizada = 0;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.ReyserAnalisis, SC, Convert.ToInt32(carta.PuntoVenta), ref log,
                                    carta.FechaArribo.ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 556275834, 0, 0);

            Assert.AreEqual(528, carta.HumedadDesnormalizada);
            Assert.AreEqual(0, carta.Merma);
        }




        [TestMethod]
        public void Pegatina_23519_reyser_analisis_23761()
        {

            //explota

            string ms = "";

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\080916\Anali19.txt";

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 556447516, 0, 0);
            carta.NumeroCartaDePorte = 556447516;
            carta.FechaArribo = new DateTime(2016, 1, 1);
            carta.FechaDescarga = new DateTime(2016, 1, 1);
            carta.PuntoVenta = 1;
            carta.Cosecha = "2016/17";
            carta.IdArticulo = 4;
            carta.NetoFinalSinMermas = 30160;
            carta.Merma = 0;
            carta.Humedad = 0;
            carta.HumedadDesnormalizada = 0;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.ReyserAnalisis, SC, 0, ref log, DateTime.Today.ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 556447516, 0, 0);

            Assert.AreEqual(528, carta.HumedadDesnormalizada);
            Assert.AreEqual(0, carta.Merma);
        }










        [TestMethod]
        public void PegatinaRamalloBunge_22408()
        {

            //explota

            string ms = "";

            //string archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.txt";  // tabs
            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\Documentos\pegatinas\bungeramallo.txt";
            //archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.d";   // punto y coma

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            //Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.BungeRamalloDescargaTexto, SC, 0,
                                    ref log, new DateTime(2016, 5, 1).ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);


        }





        [TestMethod]
        public void acopio_23480_22255()
        {

            //caso 1: si es LDC y elevacion (o sea exportacion), NO mostrar "ACOPIO OTROS" (pero sí los demás)
            var s1 = LogicaFacturacion.LeyendaAcopio(85759, SC);

            // caso 2: había acopios de distintos clientes (ACA PEHUAJO en factura de LDC). Usar solamente los del cliente facturado
            var s2 = LogicaFacturacion.LeyendaAcopio(85760, SC);



            var s3 = LogicaFacturacion.LeyendaAcopio(86082, SC);
            //Assert.AreEqual(s3, "");


        }







        [TestMethod]
        public void InformeControlDiario_22052_2()
        {


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);


            List<CartasDePorteControlDescarga> control = (from a in db.CartasDePorteControlDescargas select a).ToList();
            //            FuncionesCSharpBLL.ExportToExcelEntityCollection<CartasDePorteControlDescarga>(control, output);


            int iddest = db.WilliamsDestinos.Where(x => x.Descripcion == "Villa Constitucion - Servicios Portuarios")
                            .Select(x => x.IdWilliamsDestino).FirstOrDefault();

            db.CartasDePorteControlDescargas.Add(new CartasDePorteControlDescarga { Fecha = new DateTime(2016, 1, 22), IdPuntoVenta = 1, TotalDescargaDia = 400, IdDestino = iddest });
            db.SaveChanges();



            db.Database.CommandTimeout = 180;


            List<ProntoFlexicapture.FuncionesCSharpBLL.ret> xxx = ProntoFlexicapture.FuncionesCSharpBLL.InformeControlDiario(scEF);



            string output = "c:\\adasdasd.xls";

            //exportar excel al estilo Pronto, como tenemos hacer en las grillas de mvc

            //CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel_ParaBLD(SC, IdFactura, ref output, ref ReporteLocal);

            FuncionesCSharpBLL.ExportToExcelEntityCollection<CartasDePorteControlDescarga>(control, output);
            //FuncionesCSharpBLL.ExportToExcelEntityCollection<ProntoFlexicapture.FuncionesCSharpBLL.ret>(xxx, output);





            //var copia = @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output);
            //File.Copy(output,copia, true);
            System.Diagnostics.Process.Start(output);

        }




        [TestMethod]
        public void InformeControlDiario_22052()
        {


            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";
            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter[] yourParams = new ReportParameter[6];
            yourParams[0] = new ReportParameter("CadenaConexion", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            yourParams[1] = new ReportParameter("sServidorWeb", ConfigurationManager.AppSettings["UrlDominio"]);
            yourParams[2] = new ReportParameter("FechaDesde", new DateTime(2015, 11, 1).ToString());
            yourParams[3] = new ReportParameter("FechaHasta", new DateTime(2016, 11, 1).ToString());
            yourParams[4] = new ReportParameter("IdDestino", "-1");
            yourParams[5] = new ReportParameter("IdPuntoVenta", "0");
            //yourParams[7] = new ReportParameter("Consulta", strSQL);


            var output2 = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                                "Williams - Controles Diarios.rdl", yourParams, ref ArchivoExcelDestino, false);

            System.Diagnostics.Process.Start(output2);
        }




        [TestMethod]
        public void OCR_bug_23629()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\pronto\docstest\TIFFFF1.zip";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
            ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");



            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(excels[0]);



        }



        [TestMethod]
        public void DESCARGA_IMAGENES_22373_3()
        {
            using (Bitmap bmp = new Bitmap(@"C:\Users\Administrador\Documents\bdl\pronto\docstest\2501323ago2016_100401_555332208-CP.jpg"))
            {
                using (Tiff tif = Tiff.Open(@"C:\Users\Administrador\Documents\bdl\pronto\docstest\BitmapTo24BitColorTiff.tif", "w"))
                {
                    byte[] raster = getImageRasterBytes(bmp, System.Drawing.Imaging.PixelFormat.Format24bppRgb);
                    tif.SetField(TiffTag.IMAGEWIDTH, bmp.Width);
                    tif.SetField(TiffTag.IMAGELENGTH, bmp.Height);
                    tif.SetField(TiffTag.COMPRESSION, Compression.NONE);
                    tif.SetField(TiffTag.PHOTOMETRIC, Photometric.MINISWHITE);

                    tif.SetField(TiffTag.ROWSPERSTRIP, bmp.Height);

                    tif.SetField(TiffTag.XRESOLUTION, bmp.HorizontalResolution);
                    tif.SetField(TiffTag.YRESOLUTION, bmp.VerticalResolution);

                    tif.SetField(TiffTag.BITSPERSAMPLE, 8);
                    tif.SetField(TiffTag.SAMPLESPERPIXEL, 3);

                    tif.SetField(TiffTag.PLANARCONFIG, PlanarConfig.CONTIG);

                    int stride = raster.Length / bmp.Height;
                    convertSamples(raster, bmp.Width, bmp.Height);

                    for (int i = 0, offset = 0; i < bmp.Height; i++)
                    {
                        tif.WriteScanline(raster, offset, i, 0);
                        offset += stride;
                    }
                }

                System.Diagnostics.Process.Start(@"C:\Users\Administrador\Documents\bdl\pronto\docstest\BitmapTo24BitColorTiff.tif");
            }
        }




        private static byte[] getImageRasterBytes(Bitmap bmp, PixelFormat format)
        {
            Rectangle rect = new Rectangle(0, 0, bmp.Width, bmp.Height);
            byte[] bits = null;

            try
            {
                // Lock the managed memory
                BitmapData bmpdata = bmp.LockBits(rect, ImageLockMode.ReadWrite, format);

                // Declare an array to hold the bytes of the bitmap.
                bits = new byte[bmpdata.Stride * bmpdata.Height];

                // Copy the values into the array.
                System.Runtime.InteropServices.Marshal.Copy(bmpdata.Scan0, bits, 0, bits.Length);

                // Release managed memory
                bmp.UnlockBits(bmpdata);
            }
            catch
            {
                return null;
            }

            return bits;
        }

        /// <summary> 
        /// Converts BGR samples into RGB samples 
        /// </summary> 
        private static void convertSamples(byte[] data, int width, int height)
        {
            int stride = data.Length / height;
            const int samplesPerPixel = 3;

            for (int y = 0; y < height; y++)
            {
                int offset = stride * y;
                int strideEnd = offset + width * samplesPerPixel;

                for (int i = offset; i < strideEnd; i += samplesPerPixel)
                {
                    byte temp = data[i + 2];
                    data[i + 2] = data[i];
                    data[i] = temp;
                }
            }
        }







        [TestMethod]
        public void DESCARGA_IMAGENES_22373()
        {

            //CartaDePorteManager.JuntarImagenesYhacerTiff(@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
            //                                  @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg",
            //                                  @"C:\Users\Administrador\Documents\bdl\New folder\assadfasdf.tiff"
            //                                  );


            if (false)
            {
                string[] sss = {@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
                                              @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg"};

                ClassFlexicapture.SaveAsMultiPageTiff(
                                                     @"C:\Users\Administrador\Documents\bdl\New folder\assadfasdf.tiff",
                                                     sss
                                                     );
            }


            string titulo = "";
            var dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, "",
                 "", "", 0, 10, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2016, 5, 29), new DateTime(2016, 5, 30),
                0, ref titulo, "Ambas", false);


            var output = CartaDePorteManager.DescargarImagenesAdjuntas_TIFF(dt, SC, false, DirApp, true);
            System.Diagnostics.Process.Start(output);

        }






        [TestMethod]
        public void Pegatina_20886_unidad6_analisis()
        {

            //explota

            string ms = "";

            //string archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.txt";  // tabs
            string archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.d";   // punto y coma

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            //Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Unidad6Analisis, SC, 0, ref log, DateTime.Today.ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);
        }







        [TestMethod]
        public void asdasd_23498()
        {

            //tarda 5 min

            string ms = "", warn = "";
            var carta = CartaDePorteManager.GetItem(SC, 114444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC);
            carta.NobleGrado = 2;
            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            Assert.AreEqual(1, carta.NobleGrado);

            carta = null;
            carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            carta.NobleGrado = 3;
            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            Assert.AreEqual(2, carta.NobleGrado);

        }






        [TestMethod]
        public void liquidacionsubcon_22294_2()
        {

            CartaDePorteManager.ReasignoTarifaSubcontratistasDeTodasLasCDPsDescargadasSinFacturarYLasGrabo(SC, 1, "nano", 2066);

        }








        [TestMethod]
        public void OCR_y_Tickets()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\imagenescp\tickets.zip";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            if (true)
            {

                // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
                ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");

                // ProntoWindowsService.Service1.Initialize();
            }
            else
            {
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref processor,
                                        plantilla, 30,
                                         SC, DirApp, true, ref sError);
                var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
            }


            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(excels[0]);


            // mostrar info del lote1
            //VerInfoDelLote(ticket);



            string archivoExcel = excels[0];


            int m_IdMaestro = 0;

            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Autodetectar, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }


        }







        [TestMethod]
        public void Exportacion_a_Excel_de_Entities()
        {

            // la idea seria llamar a la funcion filtrador pero sin paginar, o diciendolo de otro modo, pasandole como maxrows un numero grandisimo
            // http://stackoverflow.com/questions/8227898/export-jqgrid-filtered-data-as-excel-or-csv
            // I would recommend you to implement export of data on the server and just post the current searching filter to the back-end. Full information about the searching parameter defines postData parameter of jqGrid. Another boolean parameter of jqGrid search define whether the searching filter should be applied of not. You should better ignore _search property of postData parameter and use search parameter of jqGrid.


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);


            List<CartasDePorteControlDescarga> control = (from a in db.CartasDePorteControlDescargas select a).ToList();


            int iddest = db.WilliamsDestinos.Where(x => x.Descripcion == "Villa Constitucion - Servicios Portuarios")
                            .Select(x => x.IdWilliamsDestino).FirstOrDefault();

            db.CartasDePorteControlDescargas.Add(new CartasDePorteControlDescarga { Fecha = new DateTime(2016, 1, 22), IdPuntoVenta = 1, TotalDescargaDia = 400, IdDestino = iddest });
            db.SaveChanges();



            db.Database.CommandTimeout = 180;



            string output = "c:\\adasdasd.xls";

            //exportar excel al estilo Pronto, como tenemos hacer en las grillas de mvc

            //CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel_ParaBLD(SC, IdFactura, ref output, ref ReporteLocal);

            FuncionesCSharpBLL.ExportToExcelEntityCollection<CartasDePorteControlDescarga>(control, output);
            //FuncionesCSharpBLL.ExportToExcelEntityCollection<ProntoFlexicapture.FuncionesCSharpBLL.ret>(xxx, output);





            //var copia = @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output);
            //File.Copy(output,copia, true);
            System.Diagnostics.Process.Start(output);

        }








        [TestMethod]
        public void Pegatina_22167()
        {

            //explota

            string ms = "";

            string archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.txt";  // tabs
                                                                                  //archivoExcel = @"C:\Users\Administrador\Desktop\Anali19.d";   // punto y coma

            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            //carta = null;
            //carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            //carta.NobleGrado = 2;
            //CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            //Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.ReyserAnalisis, SC, 0,
                                    ref log, new DateTime(2016, 5, 1).ToShortDateString(), 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);
        }
















        [TestMethod]
        public void primer_test_para_temas_de_facturacion_22221()
        {

            // tenes instalado el pronto? server2/publico/actualizacion

            //    tarifas en cero de buques
            //LogicaFacturacion.GenerarLoteFacturas_NUEVO(tablaEditadaDeFacturasParaGenerar, HFSC.Value, ViewState("pagina"), ViewState("sesionId"), optFacturarA.SelectedValue, gvFacturasGeneradas, _
            //                    txtFacturarATerceros.Text, SeEstaSeparandoPorCorredor, Session, cmbPuntoVenta.Text, _
            //                    dtViewstateRenglonesManuales, cmbAgruparArticulosPor.SelectedItem.Text, _
            //                    txtBuscar.Text, txtTarifaGastoAdministrativo.Text, errLog, txtCorredor.Text, chkPagaCorredor.Checked, txtOrdenCompra.Text, ViewState("PrimeraIdFacturaGenerada"), ViewState("UltimaIdFacturaGenerada"), 0)




            //              ByRef pag As Object, _
            //  ByRef sesionId As Object, _



            //ByRef gvFacturasGeneradas As GridView, ByVal txtFacturarATerceros As String, _


            //System.Web.SessionState.HttpSessionState Session;
            //Session[CartaDePorteManager.SESSIONPRONTO_glbIdUsuario] = 4;

            string txtBuscar = "";
            string txtTarifaGastoAdministrativo = "";

            bool chkPagaCorredor = false;
            //   numeroOrdenCompra As String, ByRef PrimeraIdFacturaGenerada As Object, 


            int optFacturarA = 4;
            string agruparArticulosPor = "Destino";


            string txtCorredor = "";
            long idClienteAfacturarle = 164;
            int idClienteObservaciones = -1;
            bool SeEstaSeparandoPorCorredor = true;
            int PuntoVenta = 2;

            DataTable dtRenglonesAgregados = new DataTable();
            //dtRenglonesAgregados.Rows.Add(dtRenglonesAgregados.NewRow());

            var listEmbarques = new System.Collections.Generic.List<System.Data.DataRow>();
            //listEmbarques.Add(dtRenglonesAgregados.NewRow());



            var lote = new System.Collections.Generic.List<Pronto.ERP.BO.CartaDePorte>();
            string ms = "";



            var scEF = Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);



            for (int n = 1372900; n < 1372910; n++)
            {
                var cp = (from i in db.CartasDePortes where i.IdCartaDePorte == n select i).Single();
                cp.TarifaFacturada = Convert.ToDecimal(2.77);
                cp.IdFacturaImputada = 0;
                db.SaveChanges();

                var c = CartaDePorteManager.GetItem(SC, n);
                // CartaDePorteManager.Save(SC, c, 2, "", false, ref ms);

                lote.Add(c);
            }


            IEnumerable<LogicaFacturacion.grup> imputaciones = null;


            int idFactura = LogicaFacturacion.CreaFacturaCOMpronto(lote, idClienteAfacturarle, PuntoVenta,
                                                 dtRenglonesAgregados, SC, null, optFacturarA,
                                              agruparArticulosPor, txtBuscar, txtTarifaGastoAdministrativo, SeEstaSeparandoPorCorredor,
                                                txtCorredor, chkPagaCorredor, listEmbarques, ref imputaciones, idClienteObservaciones);


        }








        [TestMethod]
        public void problema_informe_liquidacionsubcon()
        {


            var c = CartaDePorteManager.GetItem(SC, 1372987);
            c.SubnumeroVagon = 222;
            string ms = "";
            CartaDePorteManager.Save(SC, c, 1, "", false, ref ms);

            ParametroManager.GuardarValorParametro2(SC, "DestinosDeCartaPorteApartadosEnLiquidacionSubcontr", "NOBLE ARG. - Lima|CHIVILCOY|CARGILL - San Justo|FABRICA VICENTIN|PUERTO VICENTIN");


            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            ReportParameter p2 = null;
            string sTitulo = "";

            var q = ConsultasLinq.LiquidacionSubcontratistas(SC,
                       "", "", "", 1, 2000,
                        CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                        new DateTime(2014, 1, 1),
                        new DateTime(2014, 1, 10),
                        -1, -1, ref sTitulo);



            string titulo = EntidadManager.NombreCliente(SC, 105);


            ReportParameter[] p = new ReportParameter[5];
            p[0] = new ReportParameter("Concepto1", "");
            p[1] = new ReportParameter("titulo", "");
            p[2] = new ReportParameter("Concepto2", "");
            p[3] = new ReportParameter("Concepto1Importe", "-1");
            p[4] = new ReportParameter("Concepto2Importe", "-1");


            string output = "";

            CartaDePorteManager.RebindReportViewerLINQ_Excel
                                (ref ReporteLocal, @"C:\Users\Administrador\Documents\bdl\pronto\prontoweb\ProntoWeb\Informes\Liquidación de SubContratistas 2.rdl", q, ref output, p);

            System.Diagnostics.Process.Start(output);

        }









        [TestMethod]
        public void SincroZeni_17945_22197()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Zeni", ref sErrores, SC, "dominio", ref sTitulo,
                        CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                        "", -1, -1, -1, -1,
                        -1, -1, -1, -1,
                        CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                        new DateTime(2014, 1, 20), new DateTime(2014, 1, 28),
                        -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        [TestMethod]
        public void probar_informe_estandar_con_el_EnviarMailFiltroPorId_DLL_2()
        {

            //  https://prontoweb.williamsentregas.com.ar/ProntoWeb/Reporte.aspx?ReportName=Listado%20DOW

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 6, 30);
            int pventa = 0;
            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, 7574).NewRow();
            dr["Emails"] = "mscalella911@gmail.com";

            //dr["Vendedor"] = 1618; // DOW
            //dr["CuentaOrden1"] = 1618;
            //dr["CuentaOrden2"] = 1618;
            //dr["IdClienteAuxiliar"] = -1; ;
            //dr["Corredor"] = -1;
            //dr["Entregador"] = -1;
            //dr["Destino"] = -1;
            //dr["Procedencia"] = -1;
            //dr["FechaDesde"] = fechadesde;
            //dr["FechaHasta"] = fechahasta;
            //dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            //dr["Modo"] = "Ambos";
            ////dr["Orden"] = "";
            ////dr["Contrato"] = "";
            //dr["EnumSyngentaDivision"] = "";
            //dr["EsPosicion"] = false;
            //dr["IdArticulo"] = -1;

            //dr["ModoImpresion"] = "Excel";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;



            string output;
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";




            output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                   pventa, "", estado,
                                                ref dr, ref sError, false,
                                               ConfigurationManager.AppSettings["SmtpServer"],
                                                 ConfigurationManager.AppSettings["SmtpUser"],
                                                 ConfigurationManager.AppSettings["SmtpPass"],
                                                 Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                   "", ref sError2, inlinePNG, inlinePNG2);



            System.Diagnostics.Process.Start(output);

        }





        [TestMethod]
        public void probar_informe_estandar_con_el_EnviarMailFiltroPorId_DLL()
        {

            //  https://prontoweb.williamsentregas.com.ar/ProntoWeb/Reporte.aspx?ReportName=Listado%20DOW

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 6, 30);
            int pventa = 0;
            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();
            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = 1618; // DOW
            dr["CuentaOrden1"] = 1618;
            dr["CuentaOrden2"] = 1618;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;

            dr["ModoImpresion"] = "Excel";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;



            string output;
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";




            output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                   pventa, "", estado,
                                                ref dr, ref sError, false,
                                               ConfigurationManager.AppSettings["SmtpServer"],
                                                 ConfigurationManager.AppSettings["SmtpUser"],
                                                 ConfigurationManager.AppSettings["SmtpPass"],
                                                 Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                   "", ref sError2, inlinePNG, inlinePNG2);



            System.Diagnostics.Process.Start(output);

        }




        [TestMethod]
        public void webServiceParaBLDconDescargaDeImagenes_18181_20864()
        {
            // http://stackoverflow.com/questions/371961/how-to-unit-test-c-sharp-web-service-with-visual-studio-2008


            // var sss = Membership.ValidateUser("Mariano", "pirulo!");

            //string archivodestino = "c:\\Source.jpg";
            string archivodestino = "c:\\Source.pdf";

            System.IO.FileStream fs1 = null;
            //WSRef.FileDownload ls1 = new WSRef.FileDownload();
            byte[] b1 = null;

            b1 = CartaDePorteManager.BajarImagenDeCartaPorte_DLL("Mariano", "pirulo!", 20488343, SC, DirApp, scbdlmasterappconfig);
            //{920688e1-7e8f-4da7-a793-9d0dac7968e6}

            fs1 = new FileStream(archivodestino, FileMode.Create);
            fs1.Write(b1, 0, b1.Length);
            fs1.Close();
            fs1 = null;

            //cómo sé en qué formato está?

            System.Diagnostics.Process.Start(archivodestino);
        }





        [TestMethod]
        public void SincroDiazForti_17962_20845()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Diaz Forti", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2014, 1, 20), new DateTime(2014, 1, 28),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void problema_informe_22009()
        {
            ReportParameter p2 = null;

            var q = ConsultasLinq.EstadisticasDescargas(ref p2, "1/11/2015", "31/5/2016", "1/11/2015", "31/5/2016",
                                            "Personalizar",
                                            1, "Todos", SC, -1, -1, -1, CartaDePorteManager.enumCDPestado.Todas);

        }










        [TestMethod]
        public void DESCARGA_IMAGENES_17890()
        {

            //CartaDePorteManager.JuntarImagenesYhacerTiff(@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
            //                                  @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg",
            //                                  @"C:\Users\Administrador\Documents\bdl\New folder\assadfasdf.tiff"
            //                                  );


            if (false)
            {
                string[] sss = {@"C:\Users\Administrador\Documents\bdl\New folder\550466649-cp.jpg",
                                              @"C:\Users\Administrador\Documents\bdl\New folder\550558123-cp.jpg"};

                ClassFlexicapture.SaveAsMultiPageTiff(
                                                     @"C:\Users\Administrador\Documents\bdl\New folder\assadfasdf.tiff",
                                                     sss
                                                     );
            }


            string titulo = "";
            var dt = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, "",
                 "", "", 0, 10, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2016, 5, 29), new DateTime(2016, 5, 30),
                0, ref titulo, "Ambas", false);


            var output = CartaDePorteManager.DescargarImagenesAdjuntas_TIFF(dt, SC, false, DirApp, false);
            System.Diagnostics.Process.Start(output);

        }




        [TestMethod]
        public void FormatoImpresionPlantillaFactura_Leyenda_ELEVACION_20516()
        {


            //explota

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC (id2775) y de ACA (id10)
            int IdFactura = (from c in db.CartasDePortes
                             from f in db.Facturas.Where(x => c.IdFacturaImputada == x.IdFactura).DefaultIfEmpty()
                             where c.Exporta == "SI" && f.IdCliente == 2775
                             orderby f.IdFactura descending
                             select f.IdFactura).FirstOrDefault();



            //var IdFactura = db.Facturas.OrderByDescending(x=>x.IdFactura)
            //                .Where(x=>x)
            //                .Where(x=>x.IdCliente==2775).FirstOrDefault().IdFactura;

            // buscar una de exportacion de LDC


            var output = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura, false, SC, DirApp);


            //LogicaFacturacion.EsDeExportacion(oFac.Id, SC)



            //var copia = @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output);
            //File.Copy(output,copia, true);
            System.Diagnostics.Process.Start(output);


            int IdFactura2 = (from c in db.CartasDePortes
                              from f in db.Facturas.Where(x => c.IdFacturaImputada == x.IdFactura).DefaultIfEmpty()
                              where c.Exporta == "SI" && f.IdCliente != 2775 && f.IdCliente != 10
                              orderby f.IdFactura descending
                              select f.IdFactura).FirstOrDefault();


            var output2 = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura2, false, SC, DirApp);


            System.Diagnostics.Process.Start(output2);

        }



        [TestMethod]
        public void InformeFacturacionBLD_17587()
        {
            ReportViewer ReporteLocal = new Microsoft.Reporting.WebForms.ReportViewer();

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC (id2775) y de ACA (id10)
            int IdFactura = (from c in db.CartasDePortes
                             from f in db.Facturas.Where(x => c.IdFacturaImputada == x.IdFactura).DefaultIfEmpty()
                             where c.Exporta == "SI" && f.IdCliente == 2775
                             orderby f.IdFactura descending
                             select f.IdFactura).FirstOrDefault();

            string output = "";
            CartaDePorteManager.InformeAdjuntoDeFacturacionWilliamsExcel_ParaBLD(SC, IdFactura, ref output, ref ReporteLocal);



            //var copia = @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output);
            //File.Copy(output,copia, true);
            System.Diagnostics.Process.Start(output);

        }






        [TestMethod]
        public void NoPonerAutomaticamenteAquienSeFacturaAlaOriginalEnLasDuplicacionesConExportador_20539_extensionde18059()
        {

            // q lo haga solo en los casos especiales
            //                La cosa quedaría así:

            //Si se duplica una carta de porte y en una copia está el tilde y en otra no:

            //* En la que tiene el tilde -> FacturarAExplicito = Destinatario
            //* En la que no tiene el tilde -> FacturarAExplicito = Cliente a determinar según los tildes. Si no se puede determinar porque mas de uno cumple con la regla, quedará vacío y a cargar por el cliente


            //Casos en los que no llenar el FacturarAExplicito:
            //* Si está triplicada
            //* Si está duplicada y ninguna tiene tilde


            string ms = "", warn = "";

            // doy un alta
            Pronto.ERP.BO.CartaDePorte carta = new Pronto.ERP.BO.CartaDePorte();

            carta.NumeroCartaDePorte = 600000000 + (new Random()).Next(800000);
            //carta.Titular = CartaDePorteManager.BuscarClientePorCUIT("30-51651431-7", SC, ""); //PUNTE
            carta.Titular = CartaDePorteManager.BuscarClientePorCUIT("30-55549549-4", SC, ""); //BRAGADENSE
                                                                                               //carta.CuentaOrden2 = CartaDePorteManager.BuscarClientePorCUIT("30-53772127-4", SC, ""); //TOMAS HNOS
            carta.Corredor = 121; // CartaDePorteManager.BuscarVendedorPorCUIT()
            carta.Entregador = CartaDePorteManager.BuscarClientePorCUIT("30-71161551-9", SC, ""); // amaggi // usar un cliente que sea exportador;
            carta.IdArticulo = 22;
            carta.Destino = 222;
            carta.Procedencia = 211;
            carta.Cosecha = "2016/17";
            carta.FechaArribo = DateTime.Today;
            carta.PuntoVenta = 1;

            carta.Exporta = false;

            carta.FacturarAManual = true;

            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);



            // duplico la carta
            Pronto.ERP.BO.CartaDePorte carta2 = CartaDePorteManager.GetItem(SC, carta.Id, true);
            carta2.Id = -1;
            carta2.SubnumeroDeFacturacion = CartaDePorteManager.ProximoSubNumeroParaNumeroCartaPorte(SC, carta2);
            carta2.IdClienteAFacturarle = -1;
            carta2.Exporta = true;

            CartaDePorteManager.IsValid(SC, ref carta2, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta2, 1, "lalala", true, ref ms);


            ////////////////////////////////

            carta = CartaDePorteManager.GetItem(SC, carta.Id, true);
            carta2 = CartaDePorteManager.GetItem(SC, carta2.Id, true);


            ////////////////////////////////

            Assert.AreNotEqual(-1, carta.IdClienteAFacturarle);
            Assert.AreNotEqual(-1, carta2.IdClienteAFacturarle);



            // verificar que le creó un duplicado


            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            //Assert.AreEqual(1, carta.NobleGrado);

            //carta = null;
            //carta = CartaDePorteManager.GetItem(SC, 4444);

            //carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            //carta.NobleGrado = 3;
            //CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            //CartaDePorteManager.Save(SC, carta, 1, "lalala");

            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            //Assert.AreEqual(2, carta.NobleGrado);



        }






        [TestMethod]
        public void PonerAutomaticamenteAquienSeFacturaAlaOriginalEnLasDuplicacionesConExportador_20463()
        {

            // q lo haga solo en los casos especiales
            //                La cosa quedaría así:

            //Si se duplica una carta de porte y en una copia está el tilde y en otra no:

            //* En la que tiene el tilde -> FacturarAExplicito = Destinatario
            //* En la que no tiene el tilde -> FacturarAExplicito = Cliente a determinar según los tildes. Si no se puede determinar porque mas de uno cumple con la regla, quedará vacío y a cargar por el cliente


            //Casos en los que no llenar el FacturarAExplicito:
            //* Si está triplicada
            //* Si está duplicada y ninguna tiene tilde


            string ms = "", warn = "";

            // doy un alta
            Pronto.ERP.BO.CartaDePorte carta = new Pronto.ERP.BO.CartaDePorte();

            carta.NumeroCartaDePorte = 600000000 + (new Random()).Next(800000);
            //carta.Titular = CartaDePorteManager.BuscarClientePorCUIT("30-51651431-7", SC, ""); //PUNTE
            carta.Titular = CartaDePorteManager.BuscarClientePorCUIT("30-55549549-4", SC, ""); //BRAGADENSE
                                                                                               //carta.CuentaOrden2 = CartaDePorteManager.BuscarClientePorCUIT("30-53772127-4", SC, ""); //TOMAS HNOS
            carta.Corredor = 121; // CartaDePorteManager.BuscarVendedorPorCUIT()
            carta.Entregador = CartaDePorteManager.BuscarClientePorCUIT("30-71161551-9", SC, ""); // amaggi // usar un cliente que sea exportador;
            carta.IdArticulo = 22;
            carta.Destino = 222;
            carta.Procedencia = 211;
            carta.Cosecha = "2016/17";
            carta.FechaArribo = DateTime.Today;
            carta.PuntoVenta = 1;

            carta.Exporta = false;

            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);



            // duplico la carta
            Pronto.ERP.BO.CartaDePorte carta2 = CartaDePorteManager.GetItem(SC, carta.Id, true);
            carta2.Id = -1;
            carta2.SubnumeroDeFacturacion = CartaDePorteManager.ProximoSubNumeroParaNumeroCartaPorte(SC, carta2);
            carta2.IdClienteAFacturarle = -1;
            carta2.Exporta = true;

            CartaDePorteManager.IsValid(SC, ref carta2, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta2, 1, "lalala", true, ref ms);


            ////////////////////////////////

            carta = CartaDePorteManager.GetItem(SC, carta.Id, true);
            carta2 = CartaDePorteManager.GetItem(SC, carta2.Id, true);


            ////////////////////////////////

            Assert.AreNotEqual(-1, carta.IdClienteAFacturarle);
            Assert.AreNotEqual(-1, carta2.IdClienteAFacturarle);



            // verificar que le creó un duplicado


            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            //Assert.AreEqual(1, carta.NobleGrado);

            //carta = null;
            //carta = CartaDePorteManager.GetItem(SC, 4444);

            //carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            //carta.NobleGrado = 3;
            //CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            //CartaDePorteManager.Save(SC, carta, 1, "lalala");

            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            //Assert.AreEqual(2, carta.NobleGrado);



        }





        [TestMethod]
        public void cadenaenProcesaCarta()
        {
            string archivoOriginal;
            archivoOriginal = @"\Temp\Lote 14abr073732 EGUIDI PV1\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 14abr073732 EGUIDI PV1\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 14abr114641 fvelazquez PV4\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 14abr113424 fvelazquez PV4\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 12abr170609 cgoycochea PV4\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 13abr160652 jheredia PV1\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 13abr083243 EGUIDI PV1\ExportToXLS.xls";
            archivoOriginal = @"\Temp\Lote 09abr080248 jheredia PV1\ExportToXLS.xls";

            string nombreusuario = archivoOriginal.Substring(archivoOriginal.IndexOf("Lote") + 16, 20);
            nombreusuario = nombreusuario.Substring(0, nombreusuario.IndexOf(" PV") + 4);

        }



        [TestMethod]
        public void InformeSincroDeNidera_20523_2()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Nidera", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2016, 1, 1), new DateTime(2016, 1, 5),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);


            System.Diagnostics.Process.Start(output);
        }


        [TestMethod]
        public void InformeSincroDeNidera_20523()
        {





            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;
            DemoProntoEntities db2 = null;

            if (false)
            {

                // probar el webservice tambien
                var q2 = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC,
                       "", "", "", 1, 10,
                        CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                        new DateTime(2013, 1, 1),
                        new DateTime(2014, 1, 1),
                        -1, ref sTitulo, "Ambas", false, "", ref db2, "", -1, -1, 0, "", "Ambas").ToList();



                var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada(SC,
                       "", "", "", 1, 10,
                        CartaDePorteManager.enumCDPestado.Todas, "", -1, -1,
                       -1, -1,
                       -1, -1, -1, -1, CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                        new DateTime(2013, 1, 1),
                        new DateTime(2014, 1, 1),
                        -1, ref sTitulo, "Ambas", false, "", ref db, "", -1, -1, 0, "", "Ambas").ToList();
            }



            string output;
            string ArchivoExcelDestino = @"C:\Users\Administrador\Desktop\lala.xls";
            Microsoft.Reporting.WebForms.ReportViewer rep = new Microsoft.Reporting.WebForms.ReportViewer();


            if (false)
            {
                ReportParameter[] yourParams = new ReportParameter[8];
                yourParams[0] = new ReportParameter("webservice", "http://190.12.108.166/ProntoTesting/ProntoWeb/WebServiceCartas.asmx");
                yourParams[1] = new ReportParameter("sServidor", "");
                yourParams[2] = new ReportParameter("idArticulo", "-1");
                yourParams[3] = new ReportParameter("idDestino", "-1");
                yourParams[4] = new ReportParameter("desde", new DateTime(2012, 11, 1).ToString());
                yourParams[5] = new ReportParameter("hasta", new DateTime(2012, 11, 1).ToString());
                yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
                yourParams[7] = new ReportParameter("Consulta", "");


                //var output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                //        "Williams - Nidera con Webservice.rdl", yourParams, ref ArchivoExcelDestino, false);

                output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                            "Williams - Nidera con Webservice sin parametros.rdl", yourParams, ref ArchivoExcelDestino, false);
            }

            else
            {


                string strSQL = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                               "", "", "", 1, 20, CartaDePorteManager.enumCDPestado.Todas,
                               "", -1, -1,
                               -1, -1,
                               -1, -1, -1, -1,
                               CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                        new DateTime(2013, 1, 1),
                        new DateTime(2014, 1, 1),
                        -1, ref sTitulo, "Ambas");


                ReportParameter[] yourParams = new ReportParameter[9];
                yourParams[0] = new ReportParameter("webservice", "http://190.12.108.166/ProntoTesting/ProntoWeb/WebServiceCartas.asmx");
                yourParams[1] = new ReportParameter("sServidor", ConfigurationManager.AppSettings["UrlDominio"]);
                yourParams[2] = new ReportParameter("idArticulo", "-1");
                yourParams[3] = new ReportParameter("idDestino", "-1");
                yourParams[4] = new ReportParameter("desde", new DateTime(2012, 11, 1).ToString());
                yourParams[5] = new ReportParameter("hasta", new DateTime(2012, 11, 1).ToString());
                yourParams[6] = new ReportParameter("quecontenga", "ghkgk");
                yourParams[7] = new ReportParameter("Consulta", strSQL);
                yourParams[8] = new ReportParameter("sServidorSQL", ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));


                output = CartaDePorteManager.RebindReportViewer_ServidorExcel(ref rep,
                            "Williams - Nidera con SQL.rdl", yourParams, ref ArchivoExcelDestino, false);


            }

            try
            {
                //rep.Dispose();
            }
            catch (Exception)
            {

                //throw;
            }


            System.Diagnostics.Process.Start(output);


            //var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", txtMailDiazRiganti.Text, sErrores, bVistaPrevia);

            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
        }




        [TestMethod]
        public void SincroCGG_20470()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("CGG", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2016, 1, 1), new DateTime(2016, 1, 28),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }


        [TestMethod]
        public void bldClienteUsuarioExterno_20348()
        {
            //escribir 
            //Dim aaa As String = iisNull(ParametroManager.TraerValorParametro2(SC, "EsClienteBLDcorredor2"), "")

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC (id2775) y de ACA (id10)
            ProntoMVC.Data.Models.Parametros2 param = (from c in db.Parametros2 where c.Campo == "EsClienteBLDcorredor2" select c).FirstOrDefault();
            if (param == null)
            {
                param = new ProntoMVC.Data.Models.Parametros2();
                param.Campo = "EsClienteBLDcorredor2";
                param.Valor = "BLDPIRULO";
                db.Parametros2.Add(param);
            }
            else
            {
                param.Valor = "BLDPIRULO";
            }
            db.SaveChanges();

            var q = CartaDePorteManager.TraerCUITClientesSegunUsuario("BLDPIRULO", SC, scbdlmasterappconfig);
            var q2 = CartaDePorteManager.TraerCUITClientesSegunUsuario("BLD_ALABERN", SC, scbdlmasterappconfig);
            Assert.AreNotEqual(q.Count, q2.Count);
        }






        [TestMethod]
        public void ModicarCartaConIdApartirDelExcelDelFlexicapture_18266()
        {

            // string archivoExcel = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\pegatinas\Copia de PRUEBA SISTEMA2.xls";
            //string archivoExcel = @"C:\Users\Administrador\Downloads\prueba3.xls";
            string archivoExcel = @"C:\Users\Administrador\Downloads\ExportToXLS (97).xls";

            int m_IdMaestro = 0;

            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Autodetectar, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            string sb = "";
            foreach (System.Data.DataRow r in dt.Rows)
            {
                try
                {


                    var dr = r;
                    string c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                            null, null, null, null,
                                                            null, null);

                    sb += c + "\n";
                }
                catch (Exception x)
                {
                    sb += x.ToString() + "\n";

                }

            }

        }


        [TestMethod]
        public void Log()
        {
            ClassFlexicapture.Log("safasdfsf");
        }



        [TestMethod]
        public void EquivalenciasOCR_18223()
        {
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\Lote 21mar101631 prueba1 PV1\prueba sistema.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\prueba.zip";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            if (true)
            {

                // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
                ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");

                // ProntoWindowsService.Service1.Initialize();
            }
            else
            {
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref processor,
                                        plantilla, 30,
                                         SC, DirApp, true, ref sError);
                var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
            }


            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(excels[0]);


            // mostrar info del lote1
            //VerInfoDelLote(ticket);



            string archivoExcel = excels[0];


            int m_IdMaestro = 0;

            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.Autodetectar, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }


        }





        [TestMethod]
        public void PonerAutomaticamenteAquienSeFacturaAlaOriginalEnLasDuplicacionesConExportador_18059()
        {

            // q lo haga solo en los casos especiales
            //                La cosa quedaría así:

            //Si se duplica una carta de porte y en una copia está el tilde y en otra no:

            //* En la que tiene el tilde -> FacturarAExplicito = Destinatario
            //* En la que no tiene el tilde -> FacturarAExplicito = Cliente a determinar según los tildes. Si no se puede determinar porque mas de uno cumple con la regla, quedará vacío y a cargar por el cliente


            //Casos en los que no llenar el FacturarAExplicito:
            //* Si está triplicada
            //* Si está duplicada y ninguna tiene tilde


            string ms = "", warn = "";

            // doy un alta
            Pronto.ERP.BO.CartaDePorte carta = new Pronto.ERP.BO.CartaDePorte();

            carta.NumeroCartaDePorte = 600000000 + (new Random()).Next(800000);
            //carta.Titular = CartaDePorteManager.BuscarClientePorCUIT("30-51651431-7", SC, ""); //PUNTE
            carta.Titular = CartaDePorteManager.BuscarClientePorCUIT("30-55549549-4", SC, ""); //BRAGADENSE
                                                                                               //carta.CuentaOrden2 = CartaDePorteManager.BuscarClientePorCUIT("30-53772127-4", SC, ""); //TOMAS HNOS
            carta.Corredor = 121; // CartaDePorteManager.BuscarVendedorPorCUIT()
            carta.Entregador = CartaDePorteManager.BuscarClientePorCUIT("30-71161551-9", SC, ""); // amaggi // usar un cliente que sea exportador;
            carta.IdArticulo = 22;
            carta.Destino = 222;
            carta.Procedencia = 211;
            carta.Cosecha = "2016/17";
            carta.FechaArribo = DateTime.Today;
            carta.PuntoVenta = 1;

            carta.Exporta = false;

            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);



            // duplico la carta
            Pronto.ERP.BO.CartaDePorte carta2 = CartaDePorteManager.GetItem(SC, carta.Id, true);
            carta2.Id = -1;
            carta2.SubnumeroDeFacturacion = CartaDePorteManager.ProximoSubNumeroParaNumeroCartaPorte(SC, carta2);
            carta2.IdClienteAFacturarle = -1;
            carta2.Exporta = true;

            CartaDePorteManager.IsValid(SC, ref carta2, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta2, 1, "lalala", true, ref ms);


            ////////////////////////////////

            carta = CartaDePorteManager.GetItem(SC, carta.Id, true);
            carta2 = CartaDePorteManager.GetItem(SC, carta2.Id, true);


            ////////////////////////////////

            Assert.AreNotEqual(-1, carta.IdClienteAFacturarle);
            Assert.AreNotEqual(-1, carta2.IdClienteAFacturarle);



            // verificar que le creó un duplicado


            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            //Assert.AreEqual(1, carta.NobleGrado);

            //carta = null;
            //carta = CartaDePorteManager.GetItem(SC, 4444);

            //carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            //carta.NobleGrado = 3;
            //CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            //CartaDePorteManager.Save(SC, carta, 1, "lalala");

            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            //Assert.AreEqual(2, carta.NobleGrado);



        }







        [TestMethod]
        public void MailDeInformeDow_18085()
        {

            //  https://prontoweb.williamsentregas.com.ar/ProntoWeb/Reporte.aspx?ReportName=Listado%20DOW

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 6, 30);
            int pventa = 0;
            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();
            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = 1618; // DOW
            dr["CuentaOrden1"] = 1618;
            dr["CuentaOrden2"] = 1618;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            dr["ModoImpresion"] = "ExcHtm";
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;



            string output;
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";




            output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                   pventa, "", estado,
                                                ref dr, ref sError, false,
                                               ConfigurationManager.AppSettings["SmtpServer"],
                                                 ConfigurationManager.AppSettings["SmtpUser"],
                                                 ConfigurationManager.AppSettings["SmtpPass"],
                                                 Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                   "", ref sError2, inlinePNG, inlinePNG2);



            System.Diagnostics.Process.Start(output);

        }






        [TestMethod]
        public void LogDeEnvioDeFactura_18012()
        {
            barras.MarcarEnviada(SC, 17000);
        }








        [TestMethod]
        public void SincroYPF()
        {

            string sErrores = "", sTitulo = "";
            DemoProntoEntities db = null;



            var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada3(SC,
               "", "", "", 0, 1000, CartaDePorteManager.enumCDPestado.Facturadas
                  , "", 4333, -1,
               -1, 4333, 4333,
               -1, -1, -1,
               CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
               new DateTime(2016, 1, 1), new DateTime(2016, 1, 30),
                -1, ref sTitulo, "Ambas", false, "", ref db, "", -1, -1, 0, "", "Ambas").ToList();


            var output = SincronismosWilliamsManager.Sincronismo_YPF_ConLINQ(q, ref sErrores, "", SC);



            //registrosFiltrados = q.Count

            //If registrosFiltrados > 0 Then 'And sErrores = "" Then
            //    output = ProntoFuncionesUIWeb.RebindReportViewerExcel(HFSC.Value, _
            //                "ProntoWeb\Informes\Sincronismo YPF.rdl", _
            //                      q.ToDataTable, ArchivoExcelDestino) 'sTitulo)

            //    CambiarElNombreDeLaPrimeraHojaDeYPF(output)
            //End If

            //var sForzarNombreDescarga = "ENTREGADOR.CSV";
            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + sForzarNombreDescarga, true);


        }


        [TestMethod]
        public void SincroRivara()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;



            var output = SincronismosWilliamsManager.GenerarSincro("Rivara", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambas",
                new DateTime(2014, 1, 20), new DateTime(2014, 1, 28),
                -1, "Ambas", false, "", "", -1, ref registrosf, 40);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\"   Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }











        [TestMethod]
        public void ImagenesTiffMultipaginaFormatoCPTK_CPTK_CPTK_17748()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile;
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\CPTKCPTK.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\3333.tif";

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, true, false, false, 1);


            string sError = "";

            CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, l, -1, ref sError, DirApp);


        }


        //[TestMethod]
        public void _LENTO_LocalidadAprox()
        {
            SQLdinamico.BuscaIdLocalidadAproximado("IRENEO PORTELA - BS. AS.", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("RENEO PORTELA - BS. AS.", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("Chi’J'ilcoy", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("fi7/in-r.HAnARi ino", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("J.J. ALMEYRA", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("pUGGAN", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("zarate", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("RINCON DEL GATO", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("6740-CHACABUCO", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("Sote", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("SAN ANDRES DE GILES", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("25 de Mayo", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("SAN ANDRES DE GILES", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("Gral Viamonte", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("ÜAN AINUKhb Ut UILbb", SC, 7);
            SQLdinamico.BuscaIdLocalidadAproximado("ARROYO DULCE", SC, 7);
        }


        [TestMethod]
        public void PruebaFlexicaptureConZip()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile = @"C:\Users\Administrador\Desktop\tiff multipagina.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\Lote.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\LoteDe10.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\Nueva carpeta.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\doc02102016173229.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\tandabuena.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\doc02152016123436.zip";
            zipFile = @"C:\Users\Administrador\Desktop\bien giradas\bien giradas.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\patasarriba.zip";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\doc02172016135519.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\doc02172016094547.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\doc02182016085814.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\Lote 23feb094434 prueba1\doc02232016091830.tif";
            zipFile = @"C:\Users\Administrador\Documents\bdl\New folder\pv4 buenas\pv4 buenas.zip";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            if (true)
            {

                // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
                ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");

                // ProntoWindowsService.Service1.Initialize();
            }
            else
            {
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref processor,
                                        plantilla, 30,
                                         SC, DirApp, true, ref sError);
                var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
            }


            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(excels[0]);


            // mostrar info del lote1
            //VerInfoDelLote(ticket);


        }





        void VaciarDirectorioTemp()
        {

            System.IO.DirectoryInfo di = new DirectoryInfo(@"C:\bdl\pronto\prontoweb\Temp");

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }
            foreach (DirectoryInfo dir in di.GetDirectories())
            {
                dir.Delete(true);
            }
        }




        [TestMethod]
        public void NuevoLote()
        {
            string SamplesFolder;
            SamplesFolder = @"C:\Users\Administrador\Desktop\codigo barras\17-3-2015\entrega\14Williams\loteindividual";
            SamplesFolder = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\buenlote";
            SamplesFolder = @"C:\Users\Administrador\Documents\bdl\New folder\repetido";

            string sError = "";

            List<string> lista = new List<string>();

            DirectoryInfo d = new DirectoryInfo(TempFolder);//Assuming Test is your Folder

            Copy(SamplesFolder, TempFolder);

            FileInfo[] Files = d.GetFiles("*.*");
            foreach (FileInfo file in Files)
            {
                lista.Add(file.FullName);
                //lista.Add(file.Name);
            }

            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, lista, ref sError, DirApp, "SI");



            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var cdp = CartaDePorteManager.GetItemPorNumero(SC, 550867628, 0, 0);
            Assert.AreNotEqual(cdp.PathImagen ?? "", "");
            Assert.AreNotEqual(cdp.PathImagen2 ?? "", "");



        }




        [TestMethod]
        public void ProcesarSuperTiff_17748()
        {

            string sError = "";

            List<string> lista = new List<string>();

            Copy(@"C:\Users\Administrador\Desktop\tiff multipagina", TempFolder);

            DirectoryInfo d = new DirectoryInfo(TempFolder);//Assuming Test is your Folder
            FileInfo[] Files = d.GetFiles("*.*");
            foreach (FileInfo file in Files)
            {
                //lista.Add(file.FullName);
                lista.Add(file.Name);
            }



            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, lista, ref sError, DirApp, "SI");
        }




        [TestMethod]
        public void AlertaMailFertilizante()
        {

            // Alerta por mail al Despachante. 2h
            // -El mail se dispararía solo cuando se hace el alta de un cupo? O tambien cuando se modifica?
            // -Esto serían mails para todos los despachantes de ese PUNTO de despacho
            //   El mail de alerta a los operadores de despacho, se dispara unicamente en el alta. Tiene que salir un mail para cada operador de despacho de ese punto de despacho




            // ponerme como despachante
            // var cupo = FertilizanteManager.GetItem(SC, 412424);



            //   grabar el cupo



            //       verificar el envio

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            //db.us



            //AsociarUsuarioConPuntoDespacho()
            //AsociarUsuarioConTipoDespacho()


        }




        [TestMethod]
        public void TraerPanelDeFertilizantes()
        {

            //         Agregar panel informativo al despachante. -En donde? en el listado de cupos?
        }


        [TestMethod]
        public void MaestroDeFertilzantes()
        {
            // Tendrá que filtrar según los TIPOS/PUNTOS de despacho. 
            // filtrar el listado por sus TIPOS de despacho

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            var result = ProntoMVC.Data.FuncionesGenericasCSharp.Fertilizantes_DynamicGridData(db, "NumeroPedido", "desc", 0, 50, false, "");

        }








        [TestMethod]
        public void Pegatina_17734()
        {

            //explota

            string ms = "";

            string archivoExcel = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\pegatinas\30488_Posi19.txt";
            int m_IdMaestro = 0;
            Pronto.ERP.BO.CartaDePorte carta;


            // escribir descarga de una carta
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);




            string log = "";
            //hay que pasar el formato como parametro 
            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                    LogicaImportador.FormatosDeExcel.ReyserCargillPosicion, SC, 0, ref log, "", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }




            //verificar que sigue así
            carta = null;
            carta = CartaDePorteManager.GetItemPorNumero(SC, 549768066, 0, 0);
            carta.NobleGrado = 2;
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreEqual(30000, carta.NetoFinalIncluyendoMermas);
        }








        [TestMethod]
        public void movimientos_22213()
        {

            //Cuando pone del 27/06 al 27/06 le tira tantos kg netos . Y cuando tira del 01/01 al 27/06 le tira otros kg netos. Los kg netos tendrian que ser los mismos, ya que la fecha final es la misma ( 27/06).

            int pv = 2;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("TRIGO PAN", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("ACA SAN LORENZO", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("AMAGGI ARGENTINA S.A.", SC);
            DateTime desde = new DateTime(2016, 1, 1);
            DateTime hasta = new DateTime(2015, 7, 27);

            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, desde, idarticulo, destino, destinatario, pv);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, hasta, idarticulo, destino, destinatario, pv);

            string sTitulo = "";

            // esto es cómo lo calcula GeneroDataTablesDeMovimientosDeStock
            //var dtCDPs = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC,
            //        "", "", "", 1, 0,
            //        CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
            //        destinatario, -1,
            //        -1, idarticulo, -1, destino,
            //        CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
            //         desde, hasta, -1, ref sTitulo, "Ambas");

            var sql = CartaDePorteManager.GetDataTableFiltradoYPaginado_CadenaSQL(SC,
                    "", "", "", 1, 0,
                    CartaDePorteManager.enumCDPestado.TodasMenosLasRechazadas, "", -1, -1,
                    destinatario, -1,
                    -1, idarticulo, -1, destino,
                    CartaDePorteManager.FiltroANDOR.FiltroAND, "Export",
                     desde, hasta, -1, ref sTitulo, "Ambas");

            var dt = EntidadManager.ExecDinamico(SC, "select isnull(sum(netoproc),0) as total  from (" + sql + ") as C");

            decimal total = Convert.ToDecimal(dt.Rows[0][0]);

        }




        [TestMethod]
        public void movimientos_17679()
        {
            /*
            Mariano, yo me estoy tirando los reportes y me salen igual que a ellos.

    Lo que dicen es que cuando sacan los reportes, salen así:

    Fecha: del 27/7 al 31/10
    Saldo Inicial: 19.999.120 kg
    Movimientos: hay cinco en el período que suman 147.940 kg entre el 27/7 y el 1/9
    Saldo Final: 20.147.060 kg

    Fecha: del 31/10 al 31/10
    Saldo Inicial: 19.999.120 kg
    Movimientos: no hay movimientos ese día
    Saldo Final: 19.999.120 kg

    Entiendo que está mal el saldo inicial en el segundo caso.
            */

            int pv = 2;
            int idarticulo = SQLdinamico.BuscaIdArticuloPreciso("TRIGO PAN", SC);
            int destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("SASETRU - Sarandi ", SC);
            int destinatario = SQLdinamico.BuscaIdClientePreciso("BTG PACTUAL COMMODITIES S.A.", SC);

            var ex1 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 7, 26), idarticulo, destino, destinatario, pv);
            Debug.Print(ex1.ToString());
            var ex2 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 7, 27), idarticulo, destino, destinatario, pv);
            var ex3 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 10, 30), idarticulo, destino, destinatario, pv);
            var ex4 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 10, 31), idarticulo, destino, destinatario, pv);
            var ex5 = LogicaInformesWilliams.ExistenciasAlDiaPorPuerto(SC, new DateTime(2015, 11, 1), idarticulo, destino, destinatario, pv);


        }








        [TestMethod]
        public void RecibidorOficial_15188()
        {
            /*
                - Se agregan 4 campos:
    Recibidor Oficial (Tilde)
    Estado: Combo con las opciones "Recibo" (por defecto) y "Rechazo"
    Motivo Rechazo: VACIO / REGRESA ORIGEN / ACONDICIONA / CAMBIA CP 
    Nombre de acondicionador: listado de clientes de Williams

    - Los campos tienen que quedar habilitados si el camion está rechazado

    - Si se rechaza el camion debe exigir una opción en Motivo Rechazo (distinta de vacio)

    - Armar un informe igual al de Listado General, agregando al final estos 4 datos

    - A parte de sobre el reporte, el completar alguno de estos datos no tiene que influir en el resto 
             * del sistema (inclusive los pueden cargar antes de rechazarlo)
            */


            string ms = "", warn = "";
            Pronto.ERP.BO.CartaDePorte carta = new Pronto.ERP.BO.CartaDePorte();
            // var carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.Id = -1;
            carta.SubnumeroDeFacturacion = -1;

            carta.NumeroCartaDePorte = new Random().Next(51234567);
            carta.FechaArribo = DateTime.Now;
            carta.PuntoVenta = 1;
            carta.IdArticulo = SQLdinamico.BuscaIdArticuloPreciso("TRIGO PAN", SC);
            carta.Titular = SQLdinamico.BuscaIdClientePreciso("BTG PACTUAL COMMODITIES S.A.", SC);
            carta.Corredor = SQLdinamico.BuscaIdVendedorPreciso("BLD S.A", SC);
            carta.Entregador = SQLdinamico.BuscaIdClientePreciso("BTG PACTUAL COMMODITIES S.A.", SC);
            carta.Procedencia = SQLdinamico.BuscaIdLocalidadPreciso("GONZALEZ CATAN", SC);
            carta.Destino = SQLdinamico.BuscaIdWilliamsDestinoPreciso("SASETRU - Sarandi ", SC);




            carta.TieneRecibidorOficial = true;
            carta.EstadoRecibidor = Pronto.ERP.BO.enumEstadosDeRecibidor.Recibo;
            carta.MotivoRechazo = Pronto.ERP.BO.enumRechazosDeRecibidor.VACIO;
            carta.ClienteAcondicionador = SQLdinamico.BuscaIdClientePreciso("BTG PACTUAL COMMODITIES S.A.", SC);

            //carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            //carta.NobleGrado = 3;


            //Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);

            // la validacion me lo tiene que bochar 



            bool esvalido = CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            Assert.AreEqual(true, esvalido);
            int id = CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);
            Assert.AreNotEqual(-1, id);


            // Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            // Assert.AreEqual(2, carta.NobleGrado);


            var carta2 = CartaDePorteManager.GetItem(SC, 4444);



        }




        [TestMethod]
        public void InformeConAcopios_16451()
        {
            string sErrores = "", sTitulo = "";

            var sql = CartaDePorteManager.GetDataTableFiltradoYPaginado(SC, "",
    "", "", 0, 0, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 2),
                0, ref sTitulo, "Ambas", false);



            //      var yourParams = new ReportParameter(3);


            //                    yourParams(0) = New ReportParameter("CadenaConexionSQL", Encriptar(SC))
            //                    yourParams(1) = New ReportParameter("ServidorWebRoot", sUrlDominio)
            //                    yourParams(2) = New ReportParameter("SentenciaSQL", sql)

            //var rep = new ReportViewer()

            //var output = CartaDePorteManager.RebindReportViewer_ServidorExcel( ref rep, 
            //        "Williams - Listado de Clientes incompletos.rdl", 
            //                "", SC, false, ref ArchivoExcelDestino,sTitulo,false) ;

            //rep.Dispose();





        }



        [TestMethod]
        public void InformeMultigrain_14861()
        {

            // tarda 7 min

            /*
            * Ahi veo tu mail. El tema es que el dato que envía el sistema es el que está en la pestaña de Calidad (no en 
             la pestaña de Descarga).
             Esto es porque el que está en la pestaña Calidad es el número (1, 2, 3; que es lo que piden ellos) y lo 
             que está en en la pestaña de descarga es un texto (que puede ser "GRADO 1" o "FUERA DE BASE" o "COND. CAMARA" por ejemplo).
                Por eso es el dato del Grado de la pestaña Calidad el que se envía.

             * 
             * Piden que cuando cargan "GRADO 1", el sistema ponga 1 en grado en la pestaña de calidad
             * 
            solo desde el formulario? o tambien en las pegatinas? todavia sirve para algo ese campo?

                El campo lo siguen usando porque tienen otras opciones de calidad que no se reflejan en ningun otro lado de la CP.

    Hagamoslo tambien con la pegatina, asi hay un mismo criterio y despues no nos vienen casos 
              de que está en un lugar y no en otro y tenemos que rastrear por que.
            */

            string ms = "", warn = "";
            var carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC);
            carta.NobleGrado = 2;
            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 1", SC), carta.CalidadDe);
            Assert.AreEqual(1, carta.NobleGrado);

            carta = null;
            carta = CartaDePorteManager.GetItem(SC, 4444);

            carta.CalidadDe = SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC);
            carta.NobleGrado = 3;
            CartaDePorteManager.IsValid(SC, ref carta, ref ms, ref warn);
            CartaDePorteManager.Save(SC, carta, 1, "lalala", true, ref ms);

            Assert.AreEqual(SQLdinamico.BuscaIdCalidadPreciso("GRADO 2", SC), carta.CalidadDe);
            Assert.AreEqual(2, carta.NobleGrado);


        }

        [TestMethod]
        public void RemoveSpecialCharacterstest()
        {
            string original = "ássss/46";
            var s = ProntoMVC.Data.FuncionesGenericasCSharp.RemoveSpecialCharacters(original); ;

            Assert.AreEqual(s, original);

        }

        [TestMethod]
        public void MailDeInformeConHtmlyConExcelAdjunto_16455_2()
        {

            //MailLoopWork // no puedo llamar a esta funcion, porque usa la dll del appcode

        }



        [TestMethod]
        public void OCR_equivalencia_de_Destino_18085_2()
        {
            var id = CartaDePorteManager.BuscarDestinoPorCUIT("30506792165", SC, "CARGILL SAC.I.(E)", "VILLA GOBERNADOR GAL");
            var id2 = CartaDePorteManager.BuscarDestinoPorCUIT("30506792165", SC, "CARGILL SAC.I.(E)", ".PilaR-");

        }


        [TestMethod]
        public void OCR_equivalencia_de_Destino_18085()
        {

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            string zipFile = @"C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\destino rebuscado.zip";
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            VaciarDirectorioTemp();

            var l = ClassFlexicapture.PreprocesarArchivoSubido(zipFile, "Mariano", DirApp, false, true, true, 3);

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            // 2 caminos
            // ProcesoLasProximas10ImagenesDelFTPqueNoHayanSidoProcesadasAun_yDevuelvoListaDeIDsYdeErrores
            //o  ProcesoLaListaQueYoLePaso_yDevuelvoListaDeIDsYdeErrores

            IEngine engine = null;
            IEngineLoader engineLoader = null;
            IFlexiCaptureProcessor processor = null;


            ClassFlexicapture.IniciaMotor(ref engine, ref engineLoader, ref processor, plantilla);

            var ver = engine.Version;


            string sError = "";


            if (true)
            {

                // cuanto va a estar andando esto? -le estás pasando la lista explícita "l"
                ClassFlexicapture.ActivarMotor(SC, l, ref sError, DirApp, "SI");

                // ProntoWindowsService.Service1.Initialize();
            }
            else
            {
                var resultado = ClassFlexicapture.ProcesarCartasBatchConFlexicapture_SacandoImagenesDelDirectorio(ref engine, ref processor,
                                        plantilla, 30,
                                         SC, DirApp, true, ref sError);
                var html = ClassFlexicapture.GenerarHtmlConResultado(resultado, sError);
            }


            var excels = ClassFlexicapture.BuscarExcelsGenerados(DirApp);

            System.Diagnostics.Process.Start(excels[0]);


            // mostrar info del lote1
            //VerInfoDelLote(ticket);


        }





        [TestMethod]
        public void MailDeInformeConHtmlyConExcelAdjunto_16455()
        {
            //aaaaaa
            //Agregar el campos de AMBAS ( Excel + HTML ), asi no hay que agregar repetidamente
            //otro grupo de mail para elegir el otro forma, y que en el mismo correo llegue de las dos manera, pegado en el cuerpo del mail + archivo Excel. - PENDIENTE

            var fechadesde = new DateTime(2014, 1, 1);
            var fechahasta = new DateTime(2014, 1, 2);
            int pventa = 0;


            var dr = CDPMailFiltrosManager2.TraerMetadata(SC, -1).NewRow();

            dr["ModoImpresion"] = "ExcHtm";
            dr["Emails"] = "mscalella911@gmail.com";

            dr["Vendedor"] = -1;
            dr["CuentaOrden1"] = -1;
            dr["CuentaOrden2"] = -1;
            dr["IdClienteAuxiliar"] = -1; ;
            dr["Corredor"] = -1;
            dr["Entregador"] = -1;
            dr["Destino"] = -1;
            dr["Procedencia"] = -1;
            dr["FechaDesde"] = fechadesde;
            dr["FechaHasta"] = fechahasta;
            dr["AplicarANDuORalFiltro"] = 0; // CartaDePorteManager.FiltroANDOR.FiltroOR;
            dr["Modo"] = "Ambos";
            //dr["Orden"] = "";
            //dr["Contrato"] = "";
            dr["EnumSyngentaDivision"] = "";
            dr["EsPosicion"] = false;
            dr["IdArticulo"] = -1;
            CartaDePorteManager.enumCDPestado estado = CartaDePorteManager.enumCDPestado.DescargasMasFacturadas;


            string output;
            string sError = "", sError2 = "";
            string inlinePNG = DirApp + @"\imagenes\Unnamed.png";
            string inlinePNG2 = DirApp + @"\imagenes\twitterwilliams.jpg";




            dr["ModoImpresion"] = "ExcHtm";
            output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                   pventa, "", estado,
                                                ref dr, ref sError, false,
                                               ConfigurationManager.AppSettings["SmtpServer"],
                                                 ConfigurationManager.AppSettings["SmtpUser"],
                                                 ConfigurationManager.AppSettings["SmtpPass"],
                                                 Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                   "", ref sError2, inlinePNG, inlinePNG2);


            if (false)
            {
                // no anda todavía con los informes locales...

                dr["ModoImpresion"] = "Excel";
                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);


                dr["ModoImpresion"] = "Html";
                output = CDPMailFiltrosManager2.EnviarMailFiltroPorRegistro_DLL(SC, fechadesde, fechahasta,
                                                       pventa, "", estado,
                                                    ref dr, ref sError, false,
                                                   ConfigurationManager.AppSettings["SmtpServer"],
                                                     ConfigurationManager.AppSettings["SmtpUser"],
                                                     ConfigurationManager.AppSettings["SmtpPass"],
                                                     Convert.ToInt16(ConfigurationManager.AppSettings["SmtpPort"]),
                                                       "", ref sError2, inlinePNG, inlinePNG2);

            }



            //System.Diagnostics.Process.Start(output);

        }









        [TestMethod]
        public void PDFdeCartaPorte()
        {


            // explota


            var idorig = 2165737;
            var sDirFTP = DirApp + @"\DataBackupear\";
            string output = DirApp + @"\DataBackupear\lala.pdf";

            var myCartaDePorte = CartaDePorteManager.GetItem(SC, idorig);

            CartaDePorteManager.PDFcon_iTextSharp(output,
                        (myCartaDePorte.PathImagen != "") ? sDirFTP + myCartaDePorte.PathImagen : "",
                        (myCartaDePorte.PathImagen2 != "") ? sDirFTP + myCartaDePorte.PathImagen2 : ""
                );

            System.Diagnostics.Process.Start(output);

        }


        [TestMethod]
        public void SincroBunge()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("Bunge", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                 CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 2),
                0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void SincroDow()
        {

            // tarda 2 min


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("DOW", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 2),
                0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }

        [TestMethod]
        public void SincroRoagro()
        {

            // tarda 2 min


            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("Roagro", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 2),
                0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }

        [TestMethod]
        public void SincroBLD()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("BLD", ref sErrores, SC, "dominio",
            ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 2),
                 0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }


        [TestMethod]
        public void SincroPetroAgro_16516()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;

            // el _CONST_MAXROWS sale del app.config

            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("PetroAgro", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 1), new DateTime(2014, 1, 2),
                  0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void SincroDiazRiganti_15362()
        {

            string sErrores = "", sTitulo = "";
            // LinqCartasPorteDataContext db = null;




            int registrosf = 0;

            var output = SincronismosWilliamsManager.GenerarSincro("Diaz Riganti", ref sErrores, SC, "dominio", ref sTitulo
                                , CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                    "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2014, 1, 2), new DateTime(2014, 1, 2),
                0, "Ambas", false, "", "", -1, ref registrosf);



            //File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
            System.Diagnostics.Process.Start(output);
        }






        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////





        /// </summary>
        [TestMethod]
        public void ImagenesPendientesListados()
        {

            var irrec = ClassFlexicapture.ExtraerListaDeImagenesIrreconocibles(DirApp, SC).ToList();

            var lista = ClassFlexicapture.ExtraerListaDeImagenesQueNoHanSidoProcesadas(50, DirApp).ToList();
            var encola = (from i in lista select new { nombre = i }).ToList();

            var termin = ClassFlexicapture.ExtraerListaDeImagenesProcesadas(DirApp, SC).ToList();

        }





        int SuboElZip(string archivo)
        {
            // "C:\Users\Administrador\Documents\bdl\prontoweb\Documentos\imagenes\buenlote"
            //List<String> archivos = CartaDePorteManager.Extraer(destzip, DIRTEMP, out ticket);

            //return ticket;
            return 0;
        }


        string VerInfoDelLote(int ticket)
        {

            // buscar la informacion en el log?

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);



            // buscar factura de LDC (id2775) y de ACA (id10)
            //int IdFactura = from l in db.log

            //sssss

            return "";

        }












        [TestMethod]
        public void ProcesarTiffMultipagina_Reclamo14967()
        {

            // explota

            string sError = "";

            List<string> lista = new List<string>();

            Copy(@"C:\Users\Administrador\Desktop\tiff multipagina", TempFolder);

            DirectoryInfo d = new DirectoryInfo(TempFolder);//Assuming Test is your Folder
            FileInfo[] Files = d.GetFiles("*.*");
            foreach (FileInfo file in Files)
            {
                //lista.Add(file.FullName);
                lista.Add(file.Name);
            }

            //CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);
            ClassFlexicapture.ActivarMotor(SC, lista, ref sError, DirApp, "SI");
        }






        [TestMethod]
        public void FormatoImpresionPlantillaFactura_14851()
        {


            //explota

            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC (id2775) y de ACA (id10)
            int IdFactura = (from c in db.CartasDePortes
                             from f in db.Facturas.Where(x => c.IdFacturaImputada == x.IdFactura).DefaultIfEmpty()
                             where c.Exporta == "SI" && f.IdCliente == 2775
                             orderby f.IdFactura descending
                             select f.IdFactura).FirstOrDefault();



            //var IdFactura = db.Facturas.OrderByDescending(x=>x.IdFactura)
            //                .Where(x=>x)
            //                .Where(x=>x.IdCliente==2775).FirstOrDefault().IdFactura;

            // buscar una de exportacion de LDC


            var output = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura, false, SC, DirApp);




            //var copia = @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output);
            //File.Copy(output,copia, true);
            System.Diagnostics.Process.Start(output);


            int IdFactura2 = (from c in db.CartasDePortes
                              from f in db.Facturas.Where(x => c.IdFacturaImputada == x.IdFactura).DefaultIfEmpty()
                              where c.Exporta == "SI" && f.IdCliente != 2775 && f.IdCliente != 10
                              orderby f.IdFactura descending
                              select f.IdFactura).FirstOrDefault();


            var output2 = CartaDePorteManager.ImprimirFacturaElectronica(IdFactura2, false, SC, DirApp);


            System.Diagnostics.Process.Start(output2);

        }




        [TestMethod]
        public void FormatoImpresionPlantillaRemitoLDC()
        {


            //explota


            string plantilla = DirApp + @"\Documentos\" + "RemitoLDC.docx";
            string output = DirApp + @"\Documentos\" + "remito_.docx";

            var MyFile1 = new System.IO.FileInfo(output);
            if (MyFile1.Exists) MyFile1.Delete();

            File.Copy(plantilla, output);

            // var o = FertilizanteManager.GetItem(SC, IdCartaDePorte, True);


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC y de ACA
            FertilizantesCupos cupofert = (from c in db.FertilizantesCupos
                                           orderby c.FechaModificacion descending
                                           select c).FirstOrDefault();

            OpenXML_Pronto.RemitoParaLDC_XML_DOCX_Williams(output, cupofert, SC);

            System.Diagnostics.Process.Start(output);
        }


        [TestMethod]
        public void FormatoImpresionPlantillaOrdenDeCarga()
        {

            string plantilla = DirApp + @"\Documentos\" + "OrdenDeCarga.docx";
            string output = DirApp + @"\Documentos\" + "orden_.docx";

            var MyFile1 = new System.IO.FileInfo(output);
            if (MyFile1.Exists) MyFile1.Delete();

            File.Copy(plantilla, output);

            // var o = FertilizanteManager.GetItem(SC, IdCartaDePorte, True);


            var scEF = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(ProntoFuncionesGeneralesCOMPRONTO.Encriptar(SC));
            DemoProntoEntities db = new DemoProntoEntities(scEF);

            // buscar factura de LDC y de ACA
            FertilizantesCupos cupofert = (from c in db.FertilizantesCupos
                                           orderby c.FechaModificacion descending
                                           select c).FirstOrDefault();

            OpenXML_Pronto.OrdenCarga_XML_DOCX_Williams(output, cupofert, SC);

            System.Diagnostics.Process.Start(output);
        }




        [TestMethod]
        public void CrearDirectoriosParaLasImagenesAutomaticamente_15153()
        {
            //explota

            string sError = "";

            List<string> lista = new List<string>();

            Copy(@"C:\Users\Administrador\Desktop\tiff multipagina", TempFolder);

            DirectoryInfo d = new DirectoryInfo(TempFolder);//Assuming Test is your Folder
            FileInfo[] Files = d.GetFiles("*.*");
            foreach (FileInfo file in Files)
            {
                //lista.Add(file.FullName);
                lista.Add(file.Name);
            }

            CartaDePorteManager.ProcesarImagenesConCodigosDeBarraYAdjuntar(SC, lista, -1, ref sError, DirApp);

            //probar subida individual -qué diferencia hay entre AdjuntarImagen y GrabarImagen (esta ultima es la llamada por ProcesarIm...)
            //CartaDePorteManager.AdjuntarImagen
            //CartaDePorteManager.AdjuntarImagen2
        }



        [TestMethod]
        public void Pegatina_14744()
        {

            //explota

            string archivoExcel = @"C:\Users\Administrador\Downloads\Lima Noble (1).xls";
            int m_IdMaestro = 0;
            string logerror = "";

            //hay que pasar el formato como parametro 

            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel,
                                            LogicaImportador.FormatosDeExcel.Autodetectar, SC, 0, ref logerror, "1/1/2014", 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = LogicaImportador.GrabaRenglonEnTablaCDP(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }

        }




        [TestMethod]
        public void PegatinaDeFertilizantes()
        {
            string archivoExcel = @"C:\Users\Administrador\Downloads\Lima Noble (1).xls";
            int m_IdMaestro = 0;

            //hay que pasar el formato como parametro

            ExcelImportadorManager.FormatearExcelImportadoEnDLL(ref m_IdMaestro, archivoExcel, null, SC, null, null, null, 0, "");

            var dt = LogicaImportador.TraerExcelDeBase(SC, ref m_IdMaestro);

            foreach (System.Data.DataRow r in dt.Rows)
            {
                var dr = r;
                var c = FertilizanteManager.GrabaRenglonEnTablaFertilizantes(ref dr, SC, null, null, null,
                                                        null, null, null, null,
                                                        null, null);
            }

        }


        [TestMethod]
        public void Lartirigoyen_13789()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;


            var s = "(ISNULL(FechaDescarga, '1/1/1753') BETWEEN '" + ProntoFuncionesGenerales.FechaANSI(new DateTime(2014, 1, 1)) +
                                 "'     AND   '" + ProntoFuncionesGenerales.FechaANSI(new DateTime(2014, 1, 1)) + "' )";
            var dt = EntidadManager.ExecDinamico(SC, CartaDePorteManager.strSQLsincronismo() + " WHERE " + s);


            var output = SincronismosWilliamsManager.Sincronismo_Lartirigoyen(dt, ref sErrores, sTitulo);

            File.Copy(output, @"C:\Users\Administrador\Desktop\" + Path.GetFileName(output), true);
        }


        [TestMethod]
        public void SincroFacturacionSyngenta_Reclamo15104()
        {

            string sErrores = "", sTitulo = "";
            LinqCartasPorteDataContext db = null;



            var q = CartaDePorteManager.CartasLINQlocalSimplificadoTipadoConCalada2(SC,
               "", "", "", 0, 1000, CartaDePorteManager.enumCDPestado.Facturadas
                  , "", 4333, -1,
               -1, 4333, 4333,
               -1, -1, -1,
               CartaDePorteManager.FiltroANDOR.FiltroOR, CartaDePorteManager.enumCDPexportacion.Ambas,
               new DateTime(2016, 1, 1), new DateTime(2016, 1, 30),
                -1, ref sTitulo, "Ambas", false, "", ref db, "", -1, -1, 0, "", "Ambas").ToList();


            var output = SincronismosWilliamsManager.Sincronismo_SyngentaFacturacion_ConLINQ(q, ref sErrores, "", SC);

            var sForzarNombreDescarga = "ENTREGADOR.CSV";
            File.Copy(output, @"C:\Users\Administrador\Desktop\" + sForzarNombreDescarga, true);


        }




















        static void Copy(string sourceDir, string targetDir)
        {

            try
            {

                Directory.CreateDirectory(targetDir);

                foreach (var file in Directory.GetFiles(sourceDir))
                    File.Copy(file, Path.Combine(targetDir, Path.GetFileName(file)), true);

                foreach (var directory in Directory.GetDirectories(sourceDir))
                    Copy(directory, Path.Combine(targetDir, Path.GetFileName(directory)));

            }
            catch (Exception)
            {

                //throw;
            }

        }
    }





    //Function test1_ReclamoN9066(ByVal sc As String) As String

    //    Dim ds As New WillyInformesDataSet
    //    Dim adapter As New WillyInformesDataSetTableAdapters.wCartasDePorte_TX_InformesCorregidoTableAdapter

    //    '// Customize the connection string.
    //    Dim builder = New SqlClient.SqlConnectionStringBuilder(Encriptar(sc)) ' Properties.Settings.Default.DistXsltDbConnectionString)
    //    'builder.DataSource = builder.DataSource.Replace(".", Environment.MachineName)
    //    Dim desiredConnectionString = builder.ConnectionString

    //    '// Set it directly on the adapter.
    //    adapter.Connection.ConnectionString = desiredConnectionString 'tenes que cambiar el ConnectionModifier=Public http://weblogs.asp.net/rajbk/archive/2007/05/26/changing-the-connectionstring-of-a-wizard-generated-tableadapter-at-runtime-from-an-objectdatasource.aspx
    //    adapter.Fill(ds.wCartasDePorte_TX_InformesCorregido, -1, #4/1/2012#, #4/4/2012#)

    //    Dim sWHERE = ""
    //    ' Dim output As String = Sincronismo_Argencer(ds.wCartasDePorte_TX_InformesCorregido, , sWHERE)

    //    'Return output
    //End Function



    [TestClass]
    public class TestsWilliamsLentos
    {




        [TestMethod]
        public void ZipdePDFsReducidos()
        {
            //tarda 12 min

            string titulo = "";
            var dt = CartaDePorteManager.GetDataTableFiltradoYPaginado("poner SC", "",
                 "", "", 0, 100, CartaDePorteManager.enumCDPestado.DescargasMasFacturadas,
                     "", -1, -1,
                -1, -1,
                -1, -1, -1, -1,
                CartaDePorteManager.FiltroANDOR.FiltroOR, "Ambos",
                new DateTime(2015, 12, 30), new DateTime(2015, 12, 30),
                0, ref titulo, "Ambas", false);


            // var output = CartaDePorteManager.DescargarImagenesAdjuntas_PDF(dt, "poner SC", false, DirApp);
            // System.Diagnostics.Process.Start(output);

        }


    }

}





