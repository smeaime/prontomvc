using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting.Web;
using System.Linq;
//using System.Linq.Dynamic;
using ProntoMVC.Models;
using ProntoMVC.Controllers;
using System.Web;
using Repo;
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

using System.Transactions;


//test de java lopez
// https://github.com/ajlopez/TddAppAspNetMvc/blob/master/Src/MyLibrary.Web.Tests/Controllers/HomeControllerTests.cs

namespace ProntoMVC.Tests
{
    using System.Web.Mvc;
    using Microsoft.VisualStudio.TestTools.UnitTesting;




    [TestClass]
    public class ComprobanteProveedorControllerTest
    {

        const string scbdlmaster =
                         @"metadata=res://*/Models.bdlmaster.csdl|res://*/Models.bdlmaster.ssdl|res://*/Models.bdlmaster.msl;provider=System.Data.SqlClient;provider connection string=""data source=SERVERSQL3\TESTING;initial catalog=BDLMaster;user id=sa;password=.SistemaPronto.;multipleactiveresultsets=True;connect timeout=8;application name=EntityFramework""";

        const string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=SERVERSQL3\\TESTING;initial catalog=DemoProntoWeb;User ID=sa;Password=.SistemaPronto.;multipleactiveresultsets=True;App=EntityFramework'";
        //string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=MARIANO-PC\\SQLEXPRESS;initial catalog=Autotrol;integrated security=True;multipleactiveresultsets=True;App=EntityFramework'";
        //            "metadata=res://*/Entity.csdl|res://*/Entity.ssdl|res://*/Entity.msl;provider=System.Data.SqlClient;provider connection string=&quot;Data Source=SOMESERVER;Initial Catalog=SOMECATALOG;Persist Security Info=True;User ID=Entity;Password=Entity;MultipleActiveResultSets=True&quot;" providerName="System.Data.EntityClient" 





        [TestMethod()]
        public void UsandoItemdeprespuestodeObra()
        {
            // hacer
        }

        [TestMethod()]
        public void Un_Admin_Comun_intenta_cambiar_su_nivel_de_RMs_pero_no_tiene_acceso_al_modulo()
        {
            // hacer
        }

        /*

        [TestMethod()]
        public void ProbarGrabacionDelServicioDeComprobanteProveedor()
        {

            // NO mockear el repo/uow cuando probas el servicio,  por lo menos por ahora. directamente probalo con la base
            // SÍ mockear el controller

            // http://stackoverflow.com/questions/795204/discrepancies-between-mock-database-and-real-database-behaviours/804536#804536
            // IMO, it is a common mistake that one tries to simulate in tests. A mock is not a simulator. It should 
            //not implement a logic that is similar to the original, it should just return hard coded results.
            //If the mock behaviour is complex, you end up in testing your mock instead of your business code.



            using (TransactionScope _scope = new TransactionScope())
            {



                Repo.UnitOfWork unitOfWork = new Repo.UnitOfWork(sc);
                Servicio.ComprobanteProveedorService comprobanteproveedorService = new Servicio.ComprobanteProveedorService(unitOfWork);
                ComprobanteProveedor o = new ComprobanteProveedor();
                int? numerooriginal;

                o = PreparoObjeto();
                //o = fondoFijoService.ObtenerPorId(10);
                numerooriginal = o.NumeroComprobante2;
                o.NumeroComprobante2 += 14; // para que de distinto
                o.IdComprobanteProveedor = 0;

                comprobanteproveedorService.Guardar(o);
                unitOfWork.Save();

                ComprobanteProveedor d = comprobanteproveedorService.ObtenerPorId(10);

                Assert.AreNotEqual(numerooriginal, d.NumeroComprobante2);
                //Assert.AreEqual(o, d);


                // _scope.Complete();
            }
        }

        */


        ComprobanteProveedor PreparoObjeto()
        {


            DemoProntoEntities db = new DemoProntoEntities(sc);
            // Generales.sCadenaConexSQL("Autotrol", new Guid("5211110C-AF10-4D39-80CC-2542F69D3179"))

            ComprobanteProveedor o = new ComprobanteProveedor();

            //o = db.ComprobantesProveedor.Where(p => p.IdComprobanteProveedor == 30065)
            //                                 .Include(p => p.DetalleComprobantesProveedores).SingleOrDefault();

            //Factura.IdCliente = db.Clientes.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdCliente).First();
            //Factura.PuntoVenta = 1;
            //Factura.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta

            o.IdComprobanteProveedor = 0;


            //    [0]: "<br/>Falta el tipo de comprobante<br/>FechaComprobante<br/>FechaVencimiento<br/>
            //TotalBrutoSystem.NullReferenceException: Object reference not set to an instance of an object.\r<br/> 
            //at ProntoMVC.Controllers.ComprobanteProveedorController.crearProveedor(ComprobanteProveedor ComprobanteProveedor) 
            //in C:\\Backup\\BDL\\ProntoMVC\\ProntoMVC\\Controllers\\ComprobanteProveedorController.cs:line 843\r<br/>  
            //at ProntoMVC.Controllers.ComprobanteProveedorController.Validar(ComprobanteProveedor o, String& sErrorMsg, String& sWarningMsg) 
            //in C:\\Backup\\BDL\\ProntoMVC\\ProntoMVC\\Controllers\\ComprobanteProveedorController.cs:line 4133
            //    <br/>Falta la Letra<br/>Falta el número de punto de venta<br/>Falta el número de comprobante<br/
            //>Falta la fecha de recepción<br/>Falta la obra<br/>Falta la cotización<br/>El comprobante no tiene items<br/> 
            //Hay problemas en el recálculo del total. renglon con importe pero sin cuenta de gasto elegida? Por favor, [pagina de error, metodos de error] 0 "

            o.IdTipoComprobante = 10;
            o.FechaComprobante = DateTime.Now;
            o.FechaVencimiento = DateTime.Now;
            o.TotalBruto = 234;
            o.CotizacionDolar = 8;
            o.FechaRecepcion = DateTime.Now;
            o.Letra = "A";
            o.NumeroComprobante1 = 222;
            o.NumeroComprobante2 = 9797955;
            o.IdObra = 12;




            o.IdProveedorEventual = 226;
            o.IdProveedor = null;
            o.IdCuenta = 5868;

            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;

            //  Factura.FechaFactura = DateTime.Now;
            o.FechaIngreso = DateTime.Now;


            //  Factura.ImporteTotal = 222;
            o.IdUsuarioModifico = 715;

            //Factura. = "Esta solicitud fue creada para Demo de Web";

            o.Observaciones = "Solicitud para Demo de Web";
            //     Factura.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()



            o.NumeroRendicionFF = 333;
            o.FechaVencimientoCAI = DateTime.Now;


            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            var myDetF = new DetalleComprobantesProveedore();
            //myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
            ////myDetF.= DateAdd(DateInterval.Weekday, 3, Now);
            myDetF.IdCuenta = 5868;
            myDetF.IdCuentaGasto = 8;
            myDetF.Cantidad = 30;
            myDetF.Importe = (decimal)1.41;
            myDetF.CodigoCuenta = "dsafsdf";
            myDetF.AplicarIVA1 = "SI";
            //myDetF.Bonificacion = 0;
            // myDetF. = 21;

            o.DetalleComprobantesProveedores.Add(myDetF);

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////

            o.TotalComprobante = (decimal)1.41;

            return o;
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        }










        [TestMethod()]
        public void BatchUpdateComprobanteProvTest()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx




            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            ComprobanteProveedor c = PreparoObjeto();

            ViewModels.ViewModelComprobanteProveedor o = new ViewModels.ViewModelComprobanteProveedor();
            AutoMapper.Mapper.CreateMap<ComprobanteProveedor, ViewModels.ViewModelComprobanteProveedor>();
            AutoMapper.Mapper.Map(c, o);






            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            JsonResult expected = null;            // TODO: Initialize to an appropriate value
            expected = new JsonResult();

            //FacturaController.JsonResponse res = new FacturaController.JsonResponse();

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


            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            // -no entiendo: cómo es que MOCKEAS el controller, si el controller es el SUT! ( es decir, estás fingiendo lo mismo 
            // que estas probando!!) 
            // -Es que no mockeas el controller: mockeas su ControllerContext +  HttpContextBase + IPrincipal
            // ComprobanteProveedorController target = new ComprobanteProveedorController(); // TODO: Initialize to an appropriate value
            ComprobanteProveedorController target = GetMockedComprobanteProveedorController();
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////



            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////



            //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
            //target.db = db;


            using (TransactionScope _scope = new TransactionScope())
            {


                actual = target.BatchUpdate(o);
                
                
                _scope.Complete();  
                // funciona barbaro, pero te bloquea hasta la lectura de la tabla
                // http://stackoverflow.com/questions/3886319/transactionscope-causing-blocking
                //If you are using a Database then you are not doing Unit testing, and the problems you are experiencing are one of the reason why true Unit testing uses Mocks and Stubs.
            }


            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            //  http://www.seankenny.me/blog/2013/05/02/unit-testing-asp-dot-net-mvc-jsonresults/
            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var obj = serializer.Serialize(actual.Data) as dynamic;
            var customer = serializer.Deserialize<dynamic>(obj);

            //Assert.AreEqual(1, customer["Id"]);
            //Assert.AreEqual("John", customer["Name"]);

            Console.Write(customer["Errors"]);
            //Assert.Inconclusive(customer["Errors"].ToString());
            //Console.Write(customer["Warnings"]);
            //Assert.AreEqual("John", customer["Success"].ToString());
            //Assert.AreEqual("John", customer["Errors"].ToString());
            //Assert.AreEqual(4544, customer["IdComprobanteProveedor"].ToString());


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////




            // Assert.AreEqual(expected, actual);
            // Assert.Inconclusive("Verify the correctness of this test method.");
        }





        /// <summary>
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////
 
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////


        static private ComprobanteProveedorController GetMockedComprobanteProveedorController()
        {

            // -no entiendo: cómo es que MOCKEAS el controller, si el controller es el SUT! ( es decir, estás fingiendo lo mismo 
            // que estas probando!!) 
            // -Es que no mockeas el controller: mockeas su ControllerContext +  HttpContextBase + IPrincipal


            var c = new ComprobanteProveedorController();


            //var httpContextMock = new Mock<HttpContextBase>();
            //var serverMock = new Mock<HttpServerUtilityBase>();
            //serverMock.Setup(x => x.MapPath("~/App_Data")).Returns(@"C:\Backup\BDL\ProntoMVC\ProntoMVC\App_Data");  // es case sensitive!!!!  no pongas "app_data"    // (@"C:\Users\Mariano\Desktop");
            //httpContextMock.Setup(x => x.Server).Returns(serverMock.Object);
            //var sut = new ComprobanteProveedorController();
            //sut.ControllerContext = new ControllerContext(httpContextMock.Object, new System.Web.Routing.RouteData(), sut);


            // http://stackoverflow.com/questions/1389744/testing-controller-action-that-uses-user-identity-name
            // por qué necesito usar un mock para hacer que uso un usuario específico? No puedo usar el controller derecho viejo sin mockear?
            // -sea lo que fuere, vos necesitás inyectar 

            var identity = new GenericIdentity("superadmin");
            var userMock = new Mock<IPrincipal>();
            userMock.Setup(p => p.IsInRole("Administrador")).Returns(true);
            userMock.SetupGet(x => x.Identity.Name).Returns("superadmin");


            // mockeas ControllerContext +  HttpContextBase + IPrincipal

            var contextMock = new Mock<HttpContextBase>();
            contextMock.SetupGet(ctx => ctx.User)
                       .Returns(userMock.Object);


            var controllerContext = new Mock<ControllerContext>();

            controllerContext.SetupGet(con => con.HttpContext)
                                 .Returns(contextMock.Object);






            //controllerContext.SetupGet(p => p.HttpContext.Session["BasePronto"]).Returns(Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey));
            controllerContext.SetupGet(p => p.HttpContext.Session["BasePronto"]).Returns("DemoProntoWeb");
            //  controllerContext.SetupGet(p => p.HttpContext.User.Identity.Name).Returns(_testEmail);
            controllerContext.SetupGet(p => p.HttpContext.Request.IsAuthenticated).Returns(true);
            controllerContext.SetupGet(p => p.HttpContext.Response.Cookies).Returns(new HttpCookieCollection());

            controllerContext.Setup(p => p.HttpContext.Request.Form.Get("ReturnUrl")).Returns("sample-return-url");
            controllerContext.Setup(p => p.HttpContext.Request.Params.Get("q")).Returns("sample-search-term");

            c.ControllerContext = controllerContext.Object;








            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////
            // necesito llamar a mano al Initialize  http://stackoverflow.com/questions/1452665/how-to-trigger-initialize-method-while-trying-to-unit-test
            //  http://stackoverflow.com/questions/1452418/how-do-i-mock-the-httpcontext-in-asp-net-mvc-using-moq


            //var requestContext = new System.Web.Routing.RequestContext(controllerContext.Object, new System.Web.Routing.RouteData());
            //var requestContext = new System.Web.Routing.RequestContext(contextMock.Object, new System.Web.Routing.RouteData());
            //IController controller = c;
            //controller.Execute(requestContext);


            c.FakeInitialize("DemoProntoWeb");

            // este tipo sugiere directamente sacar del Initialize el codigo y meterlo en un metodo para llamarlo aparte
            // http://stackoverflow.com/questions/5769163/asp-net-mvc-unit-testing-override-initialize-method
            // I suggest you to factor out your custom Initialize() logic out into different method. Then create fake (stub) subclass with 
            // public method that calls this factored out protected Initialzie. Are you with me?

            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////




            return c;
        }






        [TestMethod()]
        public void BatchUpdatePedidoTest()
        {
            /*
                //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx




                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                ComprobanteProveedor c = PreparoObjeto();

                ViewModels.ViewModelComprobanteProveedor o = new ViewModels.ViewModelComprobanteProveedor();
                AutoMapper.Mapper.CreateMap<ComprobanteProveedor, ViewModels.ViewModelComprobanteProveedor>();
                AutoMapper.Mapper.Map(c, o);






                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                JsonResult expected = null;            // TODO: Initialize to an appropriate value
                expected = new JsonResult();

                //FacturaController.JsonResponse res = new FacturaController.JsonResponse();

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


                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                // -no entiendo: cómo es que MOCKEAS el controller, si el controller es el SUT! ( es decir, estás fingiendo lo mismo 
                // que estas probando!!) 
                // -Es que no mockeas el controller: mockeas su ControllerContext +  HttpContextBase + IPrincipal
                // ComprobanteProveedorController target = new ComprobanteProveedorController(); // TODO: Initialize to an appropriate value
                PedidoController target = GetMockedComprobanteProveedorController();
                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////



                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////



                //si llamás prepo a BatchFactura, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
                // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
                //target.db = db;


                using (TransactionScope _scope = new TransactionScope())
                {


                    actual = target.BatchUpdate(o);


                    _scope.Complete();
                    // funciona barbaro, pero te bloquea hasta la lectura de la tabla
                    // http://stackoverflow.com/questions/3886319/transactionscope-causing-blocking
                    //If you are using a Database then you are not doing Unit testing, and the problems you are experiencing are one of the reason why true Unit testing uses Mocks and Stubs.
                }


                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                /////////////////////////////////////////////////////
                //  http://www.seankenny.me/blog/2013/05/02/unit-testing-asp-dot-net-mvc-jsonresults/
                var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var obj = serializer.Serialize(actual.Data) as dynamic;
                var customer = serializer.Deserialize<dynamic>(obj);

                //Assert.AreEqual(1, customer["Id"]);
                //Assert.AreEqual("John", customer["Name"]);

                Console.Write(customer["Errors"]);
                //Assert.Inconclusive(customer["Errors"].ToString());
                //Console.Write(customer["Warnings"]);
                //Assert.AreEqual("John", customer["Success"].ToString());
                //Assert.AreEqual("John", customer["Errors"].ToString());
                //Assert.AreEqual(4544, customer["IdComprobanteProveedor"].ToString());


                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////




                // Assert.AreEqual(expected, actual);
                // Assert.Inconclusive("Verify the correctness of this test method.");
               */

        }
          
          
        
    }
}