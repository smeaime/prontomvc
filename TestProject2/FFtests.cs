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

using ProntoMVC.ViewModels;

using System.Transactions;


//test de java lopez
// https://github.com/ajlopez/TddAppAspNetMvc/blob/master/Src/MyLibrary.Web.Tests/Controllers/HomeControllerTests.cs

namespace ProntoMVC.Tests
{
    using System.Web.Mvc;
    using Microsoft.VisualStudio.TestTools.UnitTesting;





    [TestClass]
    public class FondoFijoControllerTest
    {

        const string scbdlmaster =
                  @"metadata=res://*/Models.bdlmaster.csdl|res://*/Models.bdlmaster.ssdl|res://*/Models.bdlmaster.msl;provider=System.Data.SqlClient;provider connection string=""data source=SERVERSQL3\TESTING;initial catalog=BDLMaster;user id=sa;password=.SistemaPronto.;multipleactiveresultsets=True;connect timeout=8;application name=EntityFramework""";

        const string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=SERVERSQL3\\TESTING;initial catalog=DemoProntoWeb;User ID=sa;Password=.SistemaPronto.;multipleactiveresultsets=True;App=EntityFramework'";
        //string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=MARIANO-PC\\SQLEXPRESS;initial catalog=Autotrol;integrated security=True;multipleactiveresultsets=True;App=EntityFramework'";
        //            "metadata=res://*/Entity.csdl|res://*/Entity.ssdl|res://*/Entity.msl;provider=System.Data.SqlClient;provider connection string=&quot;Data Source=SOMESERVER;Initial Catalog=SOMECATALOG;Persist Security Info=True;User ID=Entity;Password=Entity;MultipleActiveResultSets=True&quot;" providerName="System.Data.EntityClient" 



        /// ////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////
        /// ////////////////////////////////////////////////////////////////////////////////////////////////////


        [TestMethod()]
        public void El_Superadmin_Desactiva_RMs_y_PEDs()
        {
            //   using (TransactionScope _scope = new TransactionScope())
            //   {

            // ir a  buscar el APP compartido





            //            System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString = @"Data Source=SERVERSQL3\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";


            BDLMasterEntities dbmaster = new BDLMasterEntities(scbdlmaster);
            DemoProntoEntities db = new DemoProntoEntities(sc);
            // Generales.sCadenaConexSQL("Autotrol", new Guid("5211110C-AF10-4D39-80CC-2542F69D3179"))
            string glbEmpresaSegunString = "DemoProntoWeb";// "Vialagro";
            string usuario = "Mariano";
            int IdUsuario = db.Empleados.Where(x => x.Nombre == usuario).First().IdEmpleado;


            Guid userGuid = dbmaster.aspnet_Users.Where(x => x.UserName == usuario).First().UserId; // me tira la bronca  por el transactionscope? "The partner transaction manager has disabled its support for remote/network transactions. 

            var c = new AccesoController();
            var Arbol = c.LeerArchivoAPP(IdUsuario, glbEmpresaSegunString, usuario, db, userGuid);



            foreach (string s in Arbol)
            {
                bool Esta = false;


                //mVectorAccesos.Find(x=>x.Nodo)

                // For j = 0 To UBound(mVectorAccesos)
                //   If mVectorAccesos(j) = oArbol.Nodes(i).Key Then
                //      Esta = True
                //      Exit For
                //   End If
                //Next



                //With oRsAcc
                //   .AddNew
                //   .Fields("IdEmpleado").Value = 0
                //   .Fields("Nodo").Value = oArbol.Nodes(i).Key
                //   .Fields("Nivel").Value = 1
                //   If Esta Then
                //      Arbol.Nodes(i).Image = "Abierto_1"
                //      .Fields("Acceso").Value = 1
                //   Else
                //      Arbol.Nodes(i).Image = "Cerrado"
                //      .Fields("Acceso").Value = 0
                //   End If
                //   .Update
                //End With
            }

            //For i = 1 To ArbolMenu.Nodes.Count
            //   Esta = False
            //   For j = 0 To UBound(mVectorAccesos)
            //      If mVectorAccesos(j) = ArbolMenu.Nodes(i).Key Then
            //         Esta = True
            //         Exit For
            //      End If
            //   Next
            //   With oRsAcc
            //      .AddNew
            //      .Fields("IdEmpleado").Value = 0
            //      .Fields("Nodo").Value = ArbolMenu.Nodes(i).Key
            //      .Fields("Nivel").Value = 1
            //      If Esta Then
            //         ArbolMenu.Nodes(i).Image = "Abierto_1"
            //         .Fields("Acceso").Value = 1
            //      Else
            //         ArbolMenu.Nodes(i).Image = "Cerrado"
            //         .Fields("Acceso").Value = 0
            //      End If
            //      .Update
            //   End With
            //Next




            Empleado o = new Empleado();

            c.UpdateColecciones(ref o, db);

            //ComprobanteProveedor d = fondoFijoService.ObtenerPorId(10);

            //Assert.AreNotEqual(numerooriginal, d.NumeroComprobante2);



            // _scope.Complete();
            //}

        }





        [TestMethod()]
        public void Un_Admin_Comun_intenta_cambiar_su_nivel_de_RMs_pero_no_tiene_acceso_al_modulo()
        {
            using (TransactionScope _scope = new TransactionScope())
            {

                // _scope.Complete();
            }

        }




        [TestMethod()]
        public void BatchUpdateFFTest()
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
            actual = target.BatchUpdate(o);


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


        /*

        [TestMethod()]
        public void ProbarGrabacionDelServicioDeFondoFijo()
        {

            // NO mockear el repo/uow cuando probas el servicio,  por lo menos por ahora. directamente probalo con la base
            // SÍ mockear el controller

            // http://stackoverflow.com/questions/795204/discrepancies-between-mock-database-and-real-database-behaviours/804536#804536
            // IMO, it is a common mistake that one tries to simulate in tests. A mock is not a simulator. It should 
            //not implement a logic that is similar to the original, it should just return hard coded results.
            //If the mock behaviour is complex, you end up in testing your mock instead of your business code.


            Repo.UnitOfWork unitOfWork = new Repo.UnitOfWork(sc);
            Servicio.FondoFijoService fondoFijoService = new Servicio.FondoFijoService(unitOfWork);
            ComprobanteProveedor o = new ComprobanteProveedor();
            int? numerooriginal;

            o = PreparoObjeto();
            //o = fondoFijoService.ObtenerPorId(10);
            numerooriginal = o.NumeroComprobante2;
            o.NumeroComprobante2 += 14; // para que de distinto
            o.IdComprobanteProveedor = 0;

            fondoFijoService.Guardar(o);
            unitOfWork.Save();

            ComprobanteProveedor d = fondoFijoService.ObtenerPorId(10);

            Assert.AreNotEqual(numerooriginal, d.NumeroComprobante2);
            //Assert.AreEqual(o, d);
        }

    */
    /*
        [TestMethod()]
        public void TestGrabarUsandoMockDelRepositorio()
        {

            //Servicio.FondoFijoService fondoFijoService;
            //Repository<ComprobanteProveedor> comprobantesproveedorRepositorio;

            var entity = PreparoObjeto();
            var entities = new List<ComprobanteProveedor> { entity };

            var mockRepository = new Mock<Repository<ComprobanteProveedor>>();  // no estamos usando una interfaz en el repo
            //  mockRepository.Setup(r => r.ObtenerPorId(2)).Returns(entities);


            //var service = new FondoFijoService(mockRepository.Object());

            ////Act
            //var objects = service.ObtenerPorId(2);

            //Assert
            //Assert.AreEqual(name, objects.Single().Name);
        }

    */

        //[TestMethod]
        //public void EditAllowsUsersToEditDinnersTheyOwn()
        //{
        //    // Arrange
        //    ComprobanteProveedorController controller = new ComprobanteProveedorController();

        //    // Act
        //    IPrincipal FakeUser = new GenericPrincipal(new GenericIdentity("Scott", "Forms"), null);
        //    ViewResult result = controller.Edit(4, FakeUser) as ViewResult;

        //    // Yada yada yada assert etc etc etc
        //    Assert.IsTrue(result.ViewName != "InvalidOwner");
        //}








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








        //[TestMethod]
        public void GetIndex()
        {
            // falta el prontobasecontroller
            // falta la conexion (y como está en la sesion, tenes que mockearla)
            // falta el membershipuser

            //HomeController controller = new HomeController();

            //ActionResult result = controller.Index();

            //Assert.IsNotNull(result);
            //Assert.IsInstanceOfType(result, typeof(ViewResult));

            //ViewResult viewResult = (ViewResult)result;
            //Assert.IsNull(viewResult.Model);
        }


        [TestMethod]
        public void IndexMoq()
        {

            var homeController = GetMockedComprobanteProveedorController();  //  new ComprobanteProveedorController();



            // explota al buscar el MembershipUser
            var result = homeController.IndexFF();
            // userMock.Verify(p => p.IsInRole("Administrador"));
            //Assert.AreEqual(((ViewResult)result).ViewName, "IndexFF");




            //// arrange
            //var httpContextMock = new Mock<HttpContextBase>();
            //var serverMock = new Mock<HttpServerUtilityBase>();
            //httpContextMock.Setup(x => x.Server).Returns(serverMock.Object);
            //var sut = new ComprobanteProveedorController();
            //sut.ControllerContext = new ControllerContext(httpContextMock.Object, new System.Web.Routing.RouteData(), sut);


            //   var actual = sut.IndexFF();


            // Assert.AreEqual(controller.Get(), identity.Name);

            //var identity = new GenericIdentity("Mariano");
            //var controller = new SutController();

            //var controllerContext = new Mock<ControllerContext>();
            //var principal = new Mock<IPrincipal>();
            //principal.Setup(p => p.IsInRole("Administrador")).Returns(true);
            //principal.SetupGet(x => x.Identity.Name).Returns("Mariano");
            //controllerContext.SetupGet(x => x.HttpContext.User).Returns(principal.Object);
            //controller.ControllerContext = controllerContext.Object;



            //Assert.AreEqual(controller.Get(), identity.Name);
        }

        [TestMethod]
        public void EditMoq()
        {

            var homeController = GetMockedComprobanteProveedorController();  //  new ComprobanteProveedorController();



            // explota al buscar el MembershipUser
            var result = homeController.EditFF(500);
            // userMock.Verify(p => p.IsInRole("Administrador"));
            //Assert.AreEqual(((ViewResult)result).ViewName, "IndexFF");




            //// arrange
            //var httpContextMock = new Mock<HttpContextBase>();
            //var serverMock = new Mock<HttpServerUtilityBase>();
            //httpContextMock.Setup(x => x.Server).Returns(serverMock.Object);
            //var sut = new ComprobanteProveedorController();
            //sut.ControllerContext = new ControllerContext(httpContextMock.Object, new System.Web.Routing.RouteData(), sut);


            //   var actual = sut.IndexFF();


            // Assert.AreEqual(controller.Get(), identity.Name);

            //var identity = new GenericIdentity("Mariano");
            //var controller = new SutController();

            //var controllerContext = new Mock<ControllerContext>();
            //var principal = new Mock<IPrincipal>();
            //principal.Setup(p => p.IsInRole("Administrador")).Returns(true);
            //principal.SetupGet(x => x.Identity.Name).Returns("Mariano");
            //controllerContext.SetupGet(x => x.HttpContext.User).Returns(principal.Object);
            //controller.ControllerContext = controllerContext.Object;



            //Assert.AreEqual(controller.Get(), identity.Name);
        }



        //System Under Test - i.e to test User
        public class SutController : Controller
        {
            public string Get()
            {
                return User.Identity.Name;
            }
        }

        public class TestableControllerContext : ControllerContext
        {
            public TestableHttpContext TestableHttpContext { get; set; }
        }

        public class TestableHttpContext : HttpContextBase
        {
            public override IPrincipal User { get; set; }
        }















        // [TestMethod()]
        public void ImportarFondosFijos()
        {
            // http://stackoverflow.com/questions/8308899/unit-test-a-file-upload-how

            // arrange
            var httpContextMock = new Mock<HttpContextBase>();
            var serverMock = new Mock<HttpServerUtilityBase>();
            serverMock.Setup(x => x.MapPath("~/App_Data")).Returns(@"C:\Backup\BDL\ProntoMVC\ProntoMVC\App_Data");  // es case sensitive!!!!  no pongas "app_data"    // (@"C:\Users\Mariano\Desktop");
            httpContextMock.Setup(x => x.Server).Returns(serverMock.Object);
            var sut = new ComprobanteProveedorController();
            sut.ControllerContext = new ControllerContext(httpContextMock.Object, new System.Web.Routing.RouteData(), sut);

            var file1Mock = new Mock<HttpPostedFileBase>();
            file1Mock.Setup(x => x.FileName).Returns("F.F.- Omar Breton.xls");

            // act
            var actual = sut.Importar(file1Mock.Object);

            // assert
            file1Mock.Verify(x => x.SaveAs(@"c:\work\app_data\file1.pdf"));
            //file2Mock.Verify(x => x.SaveAs(@"c:\work\app_data\file2.doc"));

            //ComprobanteProveedorController target = new ComprobanteProveedorController(); // TODO: Initialize to an appropriate value
            //target.Importar();

        }

        public virtual JsonResult FondoFijo()
        {
            //http://msdn.microsoft.com/en-us/library/gg416511(v=vs.98).aspx









            //// Arrange
            //var contact = new Contact();
            //_service.Expect(s => s.CreateContact(contact)).Returns(false);
            //var controller = new ContactController(_service.Object);

            //// Act
            //var result = (ViewResult)controller.Create(contact);

            //// Assert
            //Assert.AreEqual("Create", result.ViewName);

            ComprobanteProveedorController target = GetMockedComprobanteProveedorController(); // TODO: Initialize to an appropriate value


            //string sc;
            //this.Session["BasePronto"] = Generales.BaseDefault((Guid)Membership.GetUser().ProviderUserKey);
            //string sss = this.Session["BasePronto"].ToString();
            //sc = Generales.sCadenaConex(sss);





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

            //// usando el pdf de documentacion: Circuito de comprobantes de fondo fijo

            //Empleado.idfondofijo=sarasa

            ////o tambien el numero de rendicion
            //        FondoFijo.CerrarRendicion

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //  creas los comprobantes  de prov con numero de rendicion


            //  // haces la orden de pago   // se puede usar el fondo fijo antes de asignarle la OP????
            //  OrdenPago.numerorendicion
            //      ordenpago.ConfirmarAcreditacionFF() // esto seria un metodo que acredita a FF la OP



            //InformesWeb.VerListadoDeFondoFijoPorRendicion  //Se procesa el listado de FF, marcando el Número de Rendición y la cuenta que se quiere consultar.


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //              a. OP Inicial:
            //Para comenzar con el circuito se deberá crear una Orden de Pago inicial con el
            //monto inicial del fondo fijo, eligiendo en principio el tipo de comprobante
            //A fondo fijo y luego colocándole el tilde en Inic? y la Cuenta :

            //ordenpago.tipo=ff
            //    ordenpago.inic=SI

            //        valores.add=




            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //            b. Ingreso de Comprobantes con un número de rendición (Se generan X
            //comprobantes para esa rendición).
            //Los comprobantes de gastos del Fondo Fijo se ingresan como se explico
            //anteriormente en Configuraciones Previas, con el formulario Nuevo o con las
            //utilidades de carga rápida.




            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //  c  Para cerrar la mención, se genera la OP sobre el Numero de rendición
            //respectivo.
            //Se da alta una nueva OP, eligiendo el tipo de comprobante A fondo fijo y
            //colocando en Nro de Rend FF a rendir.
            //El sistema traerá en Detalle de gastos todos los comprobantes ingresados,
            //pudiéndose marcar con una tilde el que se quiera incorporar a la Orden de Pago:





            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //d. Se pasa a cerrar la rendición:
            //Una vez que se piensa cerrar la rendición, sobre las OPs relacionadas a la
            //misma, se procesa el cierre de rendición. Este proceso se explica en la
            //configuración Inicial.
            //Cuando se cierra, aparece en la columna FFacreditado el valor SI., indicando el
            //cierre.
            //Observando el Resumen de FF, se ve el monto que antes aparecia en pendientes
            //de reintegrar, en la linea de Rendiciones Reintegradas. De aca se repone el
            //monto total de la OP.



            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //e. Se pasa al proximo Numero de rendicion para el FF respectivo:
            //En Compras - Fondo Fijos - Boton derecho del mouse a la cuenta de FF
            //adecuada, acceso con permiso, se otorga el proximo numero de rendicon.
            //Proceso explicado al comienzo del script.





            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            ComprobanteProveedor o = new ComprobanteProveedor();
            // ComprobanteProveedor o =db.ComprobantesProveedor.Where(p => p.IdPresupuesto == 7627).Include(p => p.DetallePresupuestos).SingleOrDefault();


            //o.IdProveedorEventual = db.Proveedores.Where(c => c.RazonSocial == "LYDIA E. FERRANDE Y ALCIRA E PEREZ S.H.").Select(c => c.IdProveedor).First();
            //o.IdProveedor = db.Proveedores.Where(c => c.RazonSocial == "LYDIA E. FERRANDE Y ALCIRA E PEREZ S.H.").Select(c => c.IdProveedor).First();
            //o.IdCuenta = db.Cuentas.Where(c => c.Descripcion == "FONDO FIJO COMPRAS MENORES TERMINIELLO").Select(c => c.IdCuenta).First();





            o.NumeroRendicionFF = 12;

            o.FechaRecepcion = DateTime.Today;


            o.NumeroComprobante1 = 1;
            o.NumeroComprobante2 = 2351;
            o.Letra = "A"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            o.IdMoneda = 1;
            o.CotizacionMoneda = 1;
            o.CotizacionDolar = 7;
            o.NumeroCAI = "6464646";
            //o.IdTipoComprobante = db.TiposComprobantes.Where(c => c.Descripcion == "Factura compra").Select(c => c.IdTipoComprobante).First();
            //o.IdCondicionCompra = db.Condiciones_Compras.Where(c => c.Descripcion == "30 Dias Fecha Factura").Select(c => c.IdCondicionCompra).First();
            ////   Presupuesto.FechaPresupuesto = DateTime.Now;
            //          Presupuesto.FechaIngreso = DateTime.Now;


            //        Presupuesto.ImporteTotal = 222;


            //Presupuesto. = "Esta solicitud fue creada para Demo de Web";

            o.Observaciones = "Solicitud para Demo de Web";
            //            Presupuesto.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            var myDetF = new DetalleComprobantesProveedore();
            //myDetF.IdCuenta = db.Cuentas.Where(c => c.Descripcion == "ACCIONES EN CIRCULACION").Select(c => c.IdCuenta).First();
            //myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            myDetF.Importe = 30.45M;
            //myDetF.PrecioUnitario = (decimal)1.41;
            //myDetF.Bonificacion = 0;
            // myDetF. = 21;

            o.DetalleComprobantesProveedores.Add(myDetF);


            //target.db = db;
            JsonResult actual2 = null; //= target.BatchUpdate(o);

            //fondoFijoService.Guardar(ComprobanteProveedor);
            //unitOfWork.Save();

            actual2.JsonRequestBehavior = JsonRequestBehavior.AllowGet; //  = Status.Error;
            //JsonRequestBehavior.AllowGet
            //actual2.JsonRequestBehavior
            //string s= actual2.Data.Errors[0];

            //actual2.JsonRequestBehavior=
            //return Json(Autorizaciones, JsonRequestBehavior.AllowGet);

            return actual2;

            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            JsonResult expected = null;            // TODO: Initialize to an appropriate value
            expected = new JsonResult();
            PresupuestoController.JsonResponse res = new PresupuestoController.JsonResponse();
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

            //si llamás prepo a BatchPresupuesto, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
            //target.db = db;
            // actual = target.BatchUpdate(Presupuesto);



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            // Firma


            Presupuesto Presupuesto2 = db.Presupuestos.Where(p => p.IdPresupuesto == 7627).Include(p => p.DetallePresupuestos).SingleOrDefault();

            //Presupuesto.IdProveedor = db.Proveedores.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdProveedor).First();
            //Presupuesto.PuntoVenta = 1;


            //JsonResult expected = null;            // TODO: Initialize to an appropriate value
            //expected = new JsonResult();
            //PresupuestoController.JsonResponse res = new PresupuestoController.JsonResponse();
            //JsonResult actual;



            // Assert
            // AssertActionResult.IsContentResult(result, "Hello World!");   
            // Assert.NotNull(result);
            // Assert.AreEqual( "Hello World!.", result.Content);

            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            Pedido Pedido = db.Pedidos.Where(p => p.IdPedido == 7627).Include(p => p.DetallePedidos).SingleOrDefault();

            Pedido.IdProveedor = db.Proveedores.Where(c => c.RazonSocial == "TRANSCONTROL S.R.L.").Select(c => c.IdProveedor).First();
            Pedido.PuntoVenta = 1;
            //      Pedido.TipoABC = "E"; // TipoABC debería ser readonly... ademas, la factelect no depende ni del cliente, sino del punto de venta
            Pedido.IdMoneda = 1;
            Pedido.CotizacionMoneda = 1;

            Pedido.FechaPedido = DateTime.Now;
            //          Pedido.FechaIngreso = DateTime.Now;


            //        Pedido.ImporteTotal = 222;


            //Pedido. = "Esta solicitud fue creada para Demo de Web";

            Pedido.Observaciones = "Solicitud para Demo de Web";
            //            Pedido.IdVendedor = 3; ///'IdUsuarioEnProntoVB6()




            //var myDetF = new DetallePedido();
            //myDetF.IdArticulo = db.Articulos.Where(c => c.Descripcion == "LING.ALUMINIO  SILUMIN Kgrs").Select(c => c.IdArticulo).First();
            ////myDetF.= DateAdd(DateInterval.Weekday, 3, Now);

            //myDetF.Cantidad = 30;
            ////myDetF.PrecioUnitario = (decimal)1.41;
            ////myDetF.Bonificacion = 0;
            //// myDetF. = 21;

            //Pedido.DetallePedidos.Add(myDetF);


            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //JsonResult expected = null;            // TODO: Initialize to an appropriate value
            //expected = new JsonResult();
            //PedidoController.JsonResponse res = new PedidoController.JsonResponse();
            //// res.Status = Status.Error;
            //// res.Errors = GetModelStateErrorsAsString(this.ModelState);
            ////res.Message = "Error al obtener CAE : El nÃºmero o fecha del comprobante no se corresponde con el prÃ³ximo a autorizar. Consultar metodo FECompUltimoAutorizado. - Ultimo numero 974";
            ////expected = Controller.Json(res);
            //JsonResult actual;
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

            //si llamás prepo a BatchPedido, el initialize no se corrió, el controlador no tiene el contexto inicializado (db es null)
            // http://stackoverflow.com/questions/5507505/why-does-my-asp-net-mvc-controller-not-call-its-base-class-initialize-method-d
            //target.db = db;
            // actual = target.BatchUpdate(Pedido);



            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////






            Console.Write(actual.Data);


            // Assert.AreEqual(expected, actual);
            // Assert.Inconclusive("Verify the correctness of this test method.");
        }


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


            // http://stackoverflow.com/questions/4257793/mocking-a-membershipuser


            var membershipMock = new Mock<Generales.IStaticMembershipService>();
            var userMock2 = new Mock<MembershipUser>();
            userMock2.Setup(u => u.ProviderUserKey).Returns(new Guid());
            membershipMock.Setup(s => s.GetUser()).Returns(userMock2.Object);






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
            //c.FakeInitialize(sc);

            // este tipo sugiere directamente sacar del Initialize el codigo y meterlo en un metodo para llamarlo aparte
            // http://stackoverflow.com/questions/5769163/asp-net-mvc-unit-testing-override-initialize-method
            // I suggest you to factor out your custom Initialize() logic out into different method. Then create fake (stub) subclass with 
            // public method that calls this factored out protected Initialzie. Are you with me?

            /////////////////////////////////////////////////////
            /////////////////////////////////////////////////////




            return c;
        }


    }


    //public interface IStaticMembershipService
    //{
    //    MembershipUser GetUser();

    //    void UpdateUser(MembershipUser user);
    //}

    //public class StaticMembershipService : IStaticMembershipService
    //{

    //    // https://github.com/r0k3t/TaskBoardAuth/blob/master/TaskBoardAuth.Tests/Controllers/AccountControllerTests.cs
    //    // https://github.com/r0k3t/TaskBoardAuth/blob/master/TaskBoardAuth/Controllers/AccountController.cs


    //    public System.Web.Security.MembershipUser GetUser()
    //    {
    //        return Membership.GetUser();
    //    }

    //    public void UpdateUser(MembershipUser user)
    //    {
    //        Membership.UpdateUser(user);
    //    }
    //}
}