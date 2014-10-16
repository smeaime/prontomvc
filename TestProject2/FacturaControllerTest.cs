using ProntoMVC.Controllers;
using ProntoMVC.Models;

using ProntoMVC.Data.Models;

using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Microsoft.VisualStudio.TestTools.UnitTesting.Web;

using System.Web.Mvc;
using System.Web;
using System.Web.SessionState;
using System.Reflection;
using System.Data.Entity;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;

namespace TestProject2
{


    /// <summary>
    ///This is a test class for FacturaControllerTest and is intended
    ///to contain all FacturaControllerTest Unit Tests
    ///</summary>
    [TestClass()]
    public class FacturaControllerTest
    {


        private TestContext testContextInstance;

        /// <summary>
        ///Gets or sets the test context which provides
        ///information about and functionality for the current test run.
        ///</summary>
        public TestContext TestContext
        {
            get
            {
                return testContextInstance;
            }
            set
            {
                testContextInstance = value;
            }
        }

        #region Additional test attributes
        // 
        //You can use the following additional attributes as you write your tests:
        //
        //Use ClassInitialize to run code before running the first test in the class
        //[ClassInitialize()]
        //public static void MyClassInitialize(TestContext testContext)
        //{
        //}
        //
        //Use ClassCleanup to run code after all tests in a class have run
        //[ClassCleanup()]
        //public static void MyClassCleanup()
        //{
        //}
        //
        //Use TestInitialize to run code before running each test
        //[TestInitialize()]
        //public void MyTestInitialize()
        //{
        //}
        //
        //Use TestCleanup to run code after each test has run
        //[TestCleanup()]
        //public void MyTestCleanup()
        //{
        //}
        //
        #endregion



        string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=MARIANO-PC\\SQLEXPRESS;initial catalog=Autotrol;integrated security=True;multipleactiveresultsets=True;App=EntityFramework'";


        /// <summary>
        ///A test for BatchUpdate
        ///</summary>
        // TODO: Ensure that the UrlToTest attribute specifies a URL to an ASP.NET page (for example,
        // http://.../Default.aspx). This is necessary for the unit test to be executed on the web server,
        // whether you are testing a page, web service, or a WCF service.
        //[HostType("ASP.NET")]
        //[AspNetDevelopmentServerHost("E:\\Backup\\BDL\\ProntoWeb\\ProntoMVC\\ProntoMVC", "/Pronto2")]
        //[UrlToTest("http://localhost:40053/Pronto2/")]
        [TestMethod()]
        public void BatchUpdateTest()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

            FacturaController target = new FacturaController(); // TODO: Initialize to an appropriate value
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            DemoProntoEntities db = new DemoProntoEntities(sc);
            // Generales.sCadenaConexSQL("Autotrol", new Guid("5211110C-AF10-4D39-80CC-2542F69D3179"))

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            

            Factura Factura = db.Facturas.Where(p => p.IdFactura == 7627).Include(p => p.DetalleFacturas).SingleOrDefault();

            Factura.IdCliente = db.Clientes.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdCliente).First();
            Factura.PuntoVenta = 1;
            Factura.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            Factura.IdMoneda = 1;
            Factura.CotizacionMoneda = 1;

            Factura.FechaFactura = DateTime.Now;
            Factura.FechaIngreso = DateTime.Now;


            Factura.ImporteTotal = 222;


            //Factura. = "Esta solicitud fue creada para Demo de Web";

            Factura.Observaciones = "Solicitud para Demo de Web";
            Factura.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            var myDetF = new DetalleFactura();
            myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            myDetF.Cantidad = 30;
            myDetF.PrecioUnitario = (decimal)1.41;
            myDetF.Bonificacion = 0;
            // myDetF. = 21;

            Factura.DetalleFacturas.Add(myDetF);


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            JsonResult expected = null;            // TODO: Initialize to an appropriate value
            expected = new JsonResult();
            FacturaController.JsonResponse res = new FacturaController.JsonResponse();
            // res.Status = Status.Error;
            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
            //res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
            //expected = Controller.Json(res);
            JsonResult actual;
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
            target.db = db;
            actual = target.BatchUpdate(Factura);



            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Console.Write(actual.Data);


            // Assert.AreEqual(expected, actual);
            // Assert.Inconclusive("Verify the correctness of this test method.");
        }


        [TestMethod()]
        public void ElectronicaTest_WSFE1_LetraE()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

            FacturaController target = new FacturaController(); // TODO: Initialize to an appropriate value
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            DemoProntoEntities db = new DemoProntoEntities(sc);
            // Generales.sCadenaConexSQL("Autotrol", new Guid("5211110C-AF10-4D39-80CC-2542F69D3179"))

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            Factura Factura;
            if (false)
            {
                Factura = db.Facturas.Where(p => p.IdFactura == 7627).Include(p => p.DetalleFacturas).SingleOrDefault();
            }

            else
            {
                Factura = new Factura();
            }

            Factura.IdCliente = db.Clientes.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdCliente).First();
            Factura.PuntoVenta = 6;

           // Factura.NumeroFactura = (int)Pronto.ERP.Bll.FacturaManager.ProximoNumeroFacturaPorIdCodigoIvaYNumeroDePuntoVenta(sc, 1, Factura.PuntoVenta ?? 0);
            
            Factura.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            Factura.IdMoneda = 1;
            Factura.CotizacionMoneda = 1;

            Factura.FechaFactura = DateTime.Now;
            Factura.FechaIngreso = DateTime.Now;


            Factura.ImporteTotal = 222;


            //Factura. = "Esta solicitud fue creada para Demo de Web";

            Factura.Observaciones = "Solicitud para Demo de Web";
            Factura.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            var myDetF = new DetalleFactura();
            //myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
            ////myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            myDetF.Cantidad = 30;
            myDetF.PrecioUnitario = (decimal)1.41;
            myDetF.Bonificacion = 0;
            // myDetF. = 21;

            Factura.DetalleFacturas.Add(myDetF);


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            JsonResult expected = null;            // TODO: Initialize to an appropriate value
            expected = new JsonResult();
            FacturaController.JsonResponse res = new FacturaController.JsonResponse();
            // res.Status = Status.Error;
            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
            //res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
            //expected = Controller.Json(res);
            JsonResult actual;
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
            target.db = db;
            actual = target.BatchUpdate(Factura);



            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            Console.Write(actual.Data);


            // Assert.AreEqual(expected, actual);
            // Assert.Inconclusive("Verify the correctness of this test method.");
        }


        //[TestMethod()]
        public void AltaFactura()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx

            FacturaController target = new FacturaController(); // TODO: Initialize to an appropriate value

            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
            var contexto = new DemoProntoEntities(sc);
            target.db = contexto;


            // Factura Factura = contexto.Facturas.Find(7627);

            HttpContext.Current = FakeHttpContext();
            // System.Web.HttpContext httpContext = System.Web.HttpContext.Current;
            HttpContext.Current.Session["BasePronto"] = "Autotrol";
            ViewResult aaa = target.Edit(-1);
            Factura Factura = aaa.ViewData.Model as Factura;

            JsonResult expected = null;            // TODO: Initialize to an appropriate value
            expected = new JsonResult();
            FacturaController.JsonResponse res = new FacturaController.JsonResponse();
            // res.Status = Status.Error;
            // res.Errors = GetModelStateErrorsAsString(this.ModelState);
            //res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
            //expected = Controller.Json(res);

            JsonResult actual;

            actual = target.BatchUpdate(Factura);

            Console.Write(actual.Data);


            // Assert.AreEqual(expected, actual);
            //Assert.Inconclusive(actual.Data);
        }




        public static HttpContext FakeHttpContext()
        {
            var httpRequest = new HttpRequest("", "http://kindermusik/", "");
            var stringWriter = new System.IO.StringWriter();
            var httpResponce = new HttpResponse(stringWriter);
            var httpContext = new HttpContext(httpRequest, httpResponce);

            var sessionContainer = new HttpSessionStateContainer("id", new SessionStateItemCollection(),
                                                    new HttpStaticObjectsCollection(), 10, true,
                                                    HttpCookieMode.AutoDetect,
                                                    SessionStateMode.InProc, false);

            httpContext.Items["AspSession"] = typeof(HttpSessionState).GetConstructor(
                                        BindingFlags.NonPublic | BindingFlags.Instance,
                                        null, CallingConventions.Standard,
                                        new[] { typeof(HttpSessionStateContainer) },
                                        null)
                                .Invoke(new object[] { sessionContainer });

            return httpContext;
        }
    }
}
