using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Microsoft.VisualStudio.TestTools.UnitTesting.Web;
using System.Linq;
//using System.Linq.Dynamic;
using ProntoMVC.Models;
using ProntoMVC.Controllers;
using System.Web;
using Repo;
using Servicio;
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
    public class TestsBasicos
    {

        //const string scbdlmaster =
        //          @"metadata=res://*/Models.bdlmaster.csdl|res://*/Models.bdlmaster.ssdl|res://*/Models.bdlmaster.msl;provider=System.Data.SqlClient;provider connection string=""data source=SERVERSQL3\TESTING;initial catalog=BDLMaster;user id=sa;password=.SistemaPronto.;multipleactiveresultsets=True;connect timeout=8;application name=EntityFramework""";

        //const string sc = "metadata=res://*/Models.Pronto.csdl|res://*/Models.Pronto.ssdl|res://*/Models.Pronto.msl;provider=System.Data.SqlClient;provider connection string='data source=SERVERSQL3\\TESTING;initial catalog=DemoProntoWeb;User ID=sa;Password=.SistemaPronto.;multipleactiveresultsets=True;App=EntityFramework'";


        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        const string nombreempresa = "Pronto"; // "DemoProntoWeb";
        const string usuario = "supervisor";
        //string bldmasterappconfig = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        string bldmasterappconfig; //  = "Data Source=SERVERSQL3\\TESTING;Initial catalog=BDLMaster;User ID=sa; Password=.SistemaPronto.;Connect Timeout=8";
        string sc;
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 
        // la cadena de conexion a la bdlmaster se saca del App.config (no web.config) de este proyecto 



        //http://stackoverflow.com/questions/334515/do-you-use-testinitialize-or-the-test-class-constructor-to-prepare-each-test-an
        [TestInitialize]
        public void Initialize()
        {
            string bldmastersql =  System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
            bldmasterappconfig = ProntoFuncionesGeneralesCOMPRONTO.Encriptar(bldmastersql);
            sc = ProntoMVC.Data.Models.Auxiliares.FormatearConexParaEntityFramework(Generales.conexPorEmpresa(nombreempresa, bldmasterappconfig, usuario, true));
        }



        /// </summary>

        [TestMethod]
        public void EditPedidoMoq()
        {

            var c = new PedidoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Edit(-1);

        }



        [TestMethod]
        public void GrabaPedidoMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(sc);

            Pedido Pedido = db.Pedidos.First();

            var c = new PedidoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(Pedido);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaRequerimientoMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(sc);

            Requerimiento o = db.Requerimientos.First();

            var c = new RequerimientoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaPresupuestoMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(sc);

            Presupuesto o = db.Presupuestos.First();

            var c = new PresupuestoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaComparativaMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(sc);

            Comparativa o = db.Comparativas.First();

            var c = new ComparativaController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }

        [TestMethod]
        public void GrabaComprobanteProveedorMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(sc);

            ComprobanteProveedor o = db.ComprobantesProveedor.First();



            var c = new ComprobanteProveedorController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            ViewModelComprobanteProveedor vm = new ViewModelComprobanteProveedor();
            AutoMapper.Mapper.CreateMap<Data.Models.ComprobanteProveedor, ViewModelComprobanteProveedor>();
            AutoMapper.Mapper.Map(o, vm);

            var result = c.BatchUpdate(vm);

            // Assert.AreEqual(expected, actual);

        }


        [TestMethod]
        public void GrabaOrdenPagoMoq()
        {
            DemoProntoEntities db = new DemoProntoEntities(sc);

            OrdenPago o = db.OrdenesPago.First();


            var c = new OrdenPagoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.BatchUpdate(o);

            // Assert.AreEqual(expected, actual);

        }



        [TestMethod]
        public void MaestroPedidoMoq()
        {

            var c = new PedidoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Pedidos_DynamicGridData("NumeroPedido", "desc", 0, 50, false, "");

        }


        [TestMethod]
        public void MaestroRequerimientosMoq()
        {

            var c = new RequerimientoController();

            GetMockedControllerGenerico(c);  //  new ComprobanteProveedorController();

            var result = c.Requerimientos_DynamicGridData("NumeroRequerimiento", "desc", 0, 50, false, "", "", "", "");

        }














        static private void GetMockedControllerGenerico(ProntoBaseController c)
        {

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
            us.Setup(u => u.ProviderUserKey).Returns(new Guid("1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9"));
            m.Setup(s => s.GetUser()).Returns(us.Object);
            m.Setup(s => s.EsSuperAdmin()).Returns(true);
            m.Setup(s => s.UsuarioTieneElRol(It.IsAny<string>(), It.IsAny<string>())).Returns(true);
            c.oStaticMembershipService = m.Object;
            // administrador    1BC7CE95-2FC3-4A27-89A0-5C31D59E14E9
            // supervisor       1804B573-0439-4EA0-B631-712684B54473



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




        }



    }




}